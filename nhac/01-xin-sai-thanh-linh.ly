% Cài đặt chung
\version "2.20.0"
\include "english.ly"

\header {
  title = \markup { \fontsize #3 "Xin Sai Thánh Linh" }
  composer = "Hoàng Kim"
  arranger = " "
  tagline = ##f
}

% Nhạc điệp khúc
nhacDiepKhucSop = \relative c' {
  \partial 4 d8 _(e) |
  g4. e8 |
  e8. (d16 c8) e |
  d2 _~ |
  d8 g g a |
  d4. g,16 (a) |
  d8 (b16 a) g8 a |
  g2 ~ |
  g4 \bar "||"
}

nhacDiepKhucBass = \relative c'' {
  \override NoteHead.font-size = #-2
  \skip 4
  \skip 1.
  \skip 4. g8 |
  fs e d (c) |
  b e d c |
  b2 ~ |
  b4
}

% Nhạc phiên khúc
nhacPhienKhuc = \relative c'' {
  \set Score.timing = ##f
  \hide Stem
  %\override Score.NonMusicalPaperColumn.padding = #2.5
  g4 a \bar "|"
  b\breve a4 \bar "|"
  b\breve \bar "|"
  b\breve \bar "|"
  c\breve a4 a4 \bar "|"
  d\breve \bar "|"
  g,4 \bar "|"
  b\breve \bar "|"
  g\breve \bar "|"
  e\breve \bar "|"
  g\breve \bar "|"
  d\breve g4 \bar "|"
  a\breve \bar "||"
}

% Lời điệp khúc
loiDiepKhucSop = \lyricmode {
  Lạy Chúa xin "sai (i)" Thánh Linh
  Để Ngài đổi mới, đổi mới(i) mặt địa cầu.
}

loiDiepKhucBass = \lyricmode {
  Để Ngài đổi mới, đổi mới mặt địa cầu.
}

% Lời phiên khúc
loiPhienKhucMot = \lyricmode {
  \set stanza = #"1."
  \override LyricText.self-alignment-X = #LEFT
  Hồn tôi "ơi! Hãy chúc" tụng "Chúa,
  hỡi" "Chúa, Thiên Chúa của" con
  "Ngài thật" cao cả.
  "Ngài mặc" "áo oai" "phong lẫm" "liệt,
  và Ngài" "khoác long" bào ánh sáng.
}

loiPhienKhucHai = \lyricmode {
  \set stanza = #"2."
  \override LyricText.self-alignment-X = #LEFT
  "Ngài đặt" trái "đất trên" nền "vững,
  không" "khí chuyển" lay,
  "ngàn đời" ngàn kiếp.
  "Ngài dùng vực" "thẳm như áo" "che địa" "cầu,
  Và" "nước đã tụ" lại "trên đỉnh" núi.
}

loiPhienKhucBa = \lyricmode {
  \set stanza = #"3."
  \override LyricText.self-alignment-X = #LEFT
  "Ngài làm" vọt "lên những" dòng "suối,
  chúng róc" "rách tìm" lối "giữa những" khe núi,
  "gần dòng" "suối chim" "trời làm" "tổ.
  Núp dưới" "lá, chúng cất" giọng líu lo.
}

loiPhienKhucBon = \lyricmode {
  \set stanza = #"4."
  \override LyricText.self-alignment-X = #LEFT
  "Sự việc" cúa "Chúa, ôi" lạy "Chúa,
  thật là" "nhiều dường" "bao, 
  tất" "thảy Ngài làm" đều "khôn ngoan."
  "Địa cầu đầy" "dẫy sang" "giàu của" "Ngài.
  Này hồn" "tôi hãy chúc" tụng Đức Chúa.
}


% Dàn trang
\paper {
  #(set-paper-size "a4")
  top-margin = 20\mm
  bottom-margin = 20\mm
  left-margin = 20\mm
  right-margin = 20\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "DejaVu Serif Condensed"
	 		       "DejaVu Serif Condensed"
			       "DejaVu Serif Condensed"
			       (/ 20 20)))
  system-system-spacing = #'((basic-distance . 15)
                             (minimum-distance . 15)
                             (padding . 3))
  score-system-spacing = #'((basic-distance . 15)
                             (minimum-distance . 15)
                             (padding . 3))
}

TongNhip = { \key g \major \time 2/4 }

inNghieng = { \override LyricText.font-shape = #'italic }

\score {
  \new ChoirStaff <<
    \new Staff = chorus <<
      \new Voice = "sopranos" {
        \voiceOne \TongNhip \stemUp \nhacDiepKhucSop
      }
      \new Voice = "basses" {
        \voiceTwo \TongNhip \stemDown \nhacDiepKhucBass
      }
    >>
    \new Lyrics \lyricsto sopranos \loiDiepKhucSop
    \new Lyrics \with \inNghieng \lyricsto basses \loiDiepKhucBass
  >>
  \layout {
    \override Lyrics.LyricText.font-series = #'bold
    %\override Lyrics.LyricText.font-size = #+2
    \override Lyrics.LyricSpace.minimum-distance = #3.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  }
}

\markup { \vspace #0.5 }

\score {
  \new ChoirStaff <<
    \new Staff = verses <<
      \override Staff.TimeSignature.transparent = ##t
      \new Voice = "verse" {
        \TongNhip \stemNeutral \nhacPhienKhuc
      }
    >>
    \new Lyrics \with {
          \override VerticalAxisGroup.
            nonstaff-relatedstaff-spacing.padding = #1.5
          \override VerticalAxisGroup.
            nonstaff-unrelatedstaff-spacing.padding = #1.5
        }
        \lyricsto verse \loiPhienKhucMot
    \new Lyrics \with \inNghieng \lyricsto verse \loiPhienKhucHai
    \new Lyrics \lyricsto verse \loiPhienKhucBa
    \new Lyrics \with \inNghieng \lyricsto verse \loiPhienKhucBon
  >>
  \layout {
    %\override Lyrics.LyricText.font-size = #+2
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  }
}
