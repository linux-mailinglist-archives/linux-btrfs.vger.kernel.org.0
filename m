Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F305615FE93
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2020 14:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgBONB1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Feb 2020 08:01:27 -0500
Received: from mail-vs1-f45.google.com ([209.85.217.45]:36578 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgBONB1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Feb 2020 08:01:27 -0500
Received: by mail-vs1-f45.google.com with SMTP id a2so7970745vso.3
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2020 05:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kVIJ+4y0bDO8iuQRjqnYOgDIjAk1H+WS4KlWBoFI0+U=;
        b=jCyX/uluXcVz9aKlIbDetl+/F7HiuCzwfwt2z0j9FF6xY8jqN3s8sX6aH2Fk3vihXx
         7EN4XFI1mTsX8xUaJ2GIp9zyI7zzZYGab9Y6C+9XJ7X6Bw6wG80FduKC5RbIJl5CrFpd
         aElNCs5qDz+gyPUY6BvF9FoilV2emHCu9xFd3DyZg+F+DPV6QeftRBp1b0WhYGiPBsHN
         CvZmb+TUKtk6wWGxoCvs4WrJs0Q5ax3Hyw4mFGawjG25lMEh15fXARaaXi8P5c66/3Wo
         IQp5jyUWCaGPmnbSfbwg76aaathhYGQ1yF4aHmxEUhRXaelJwoqDZbktpWBfd5n7I7Ei
         1AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kVIJ+4y0bDO8iuQRjqnYOgDIjAk1H+WS4KlWBoFI0+U=;
        b=I3wkdVQl4KTawEUfLwtMHkhrEZTlx4MEISiD/g5DWmtfx+29LdjcNquVGxWMUqAL+6
         8fq2YrDtlajmL44xT8pM+ODrQxBRe+4KU/sewA8kjDy7oj6M84kfyhqVpO9CLBfmbisI
         Y9TkLZz3jpNzD4bH7S2peVW5ZVcfR16xlEPixFAATto9e8cHVkXEdLmuYIpJrfgZjdhp
         wWFic5T/OKObzO6vdr3bI94yZeJKJbVulm8uOXBwYDVxinrRe7IlDIhqIy9O85fuLaWM
         yu4qHL3es14PgfgkWpyGGGqYZ1ien04ddlyTGMo96/W26IyY4KcAMLnIo19+C/mqXHH5
         z/Xg==
X-Gm-Message-State: APjAAAWb8LSL7K6n1mjArwJoeQR2ims47QhOMkap+3wwVI12ANaSRhCT
        dfzcMHKt/DpMVPpGci0ylwg32bSbZ68Lyc0ZBJXZQOI7
X-Google-Smtp-Source: APXvYqzK4jqPs9xXcBqhgSAtCseFYoVbMG79PowPZ+RqWH/ofXlp7kZk/DQ3bJZO8hPz4Wz6rdLc4DA4ixNsGaPGkyk=
X-Received: by 2002:a67:ff14:: with SMTP id v20mr3896498vsp.114.1581771683595;
 Sat, 15 Feb 2020 05:01:23 -0800 (PST)
MIME-Version: 1.0
From:   Robert Klemme <shortcutter@googlemail.com>
Date:   Sat, 15 Feb 2020 14:00:46 +0100
Message-ID: <CAM9pMnOCYvw+NqXJVUCa-ohHpenbAcMztb6gASbojaJrWc3XZw@mail.gmail.com>
Subject: No scrub resume on reboot or missing summary?
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000051243b059e9cebd5"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--00000000000051243b059e9cebd5
Content-Type: text/plain; charset="UTF-8"

Hi,

I started a scrub and then did a reboot:

sudo btrfs scrub start / && sleep 1 && sudo btrfs scrub status / &&
sleep 1 && sudo shutdown -r now

Now, after the boot there are no scrub stats:

$ sudo btrfs scrub status /
scrub status for 190d4803-f404-458f-85a1-f6ebf42554d4
no stats available
total bytes scrubbed: 0.00B with 0 errors

I wonder: did the scrub finish before the shutdown or got the scrub
status lost somehow? I attached excerpts of the journal that seemed
relevant. According to them it does not look like the scrub finished
in time. The 90s wait period just look too regular. But maybe I am
wrong.

Oh wait, I just tried resume:

$ sudo btrfs scrub resume /
scrub resumed on /, fsid 190d4803-f404-458f-85a1-f6ebf42554d4 (pid=2457)
$ sudo btrfs scrub status /
scrub status for 190d4803-f404-458f-85a1-f6ebf42554d4
no stats available
total bytes scrubbed: 1.30GiB with 0 errors

wait a bit

$ sudo btrfs scrub status /
scrub status for 190d4803-f404-458f-85a1-f6ebf42554d4
no stats available
total bytes scrubbed: 10.04GiB with 0 errors

So somehow the interrupted scrub is recorded but there is no automatic
resume. I thought the kernel would do that automatically. Am I wrong?

Kind regards

robert

-- 
[guy, jim, charlie, sho].each {|him| remember.him do |as, often|
as.you_can - without end}
http://blog.rubybestpractices.com/

--00000000000051243b059e9cebd5
Content-Type: text/plain; charset="US-ASCII"; name="no-continued-scrub.txt"
Content-Disposition: attachment; filename="no-continued-scrub.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_k6nlvc1i0>
X-Attachment-Id: f_k6nlvc1i0

dXNlckBob3N0On4kIHsgam91cm5hbGN0bCAtYiAtMTsgam91cm5hbGN0bCAtYiAtMDsgfSB8IGVn
cmVwIC1pICdidHJmc3xzY3J1YicKRmViIDE1IDExOjMxOjQ5IGhvc3Qga2VybmVsOiBCdHJmcyBs
b2FkZWQsIGNyYzMyYz1jcmMzMmMtZ2VuZXJpYwpGZWIgMTUgMTE6MzE6NDkgaG9zdCBrZXJuZWw6
IEJUUkZTOiBkZXZpY2UgZnNpZCAxOTBkNDgwMy1mNDA0LTQ1OGYtODVhMS1mNmViZjQyNTU0ZDQg
ZGV2aWQgMSB0cmFuc2lkIDExNDg1NiAvZGV2L3NkYzMKRmViIDE1IDExOjMxOjQ5IGhvc3Qga2Vy
bmVsOiBCVFJGUyBpbmZvIChkZXZpY2Ugc2RjMyk6IGRpc2sgc3BhY2UgY2FjaGluZyBpcyBlbmFi
bGVkCkZlYiAxNSAxMTozMTo0OSBob3N0IGtlcm5lbDogQlRSRlMgaW5mbyAoZGV2aWNlIHNkYzMp
OiBoYXMgc2tpbm55IGV4dGVudHMKRmViIDE1IDExOjMxOjQ5IGhvc3Qga2VybmVsOiBCVFJGUyBp
bmZvIChkZXZpY2Ugc2RjMyk6IGVuYWJsaW5nIHNzZCBvcHRpbWl6YXRpb25zCkZlYiAxNSAxMToz
MTo0OSBob3N0IGtlcm5lbDogQlRSRlMgaW5mbyAoZGV2aWNlIHNkYzMpOiBkaXNrIHNwYWNlIGNh
Y2hpbmcgaXMgZW5hYmxlZApGZWIgMTUgMTE6MzE6NTEgaG9zdCBzeXN0ZW1kWzFdOiBTdGFydGVk
IFJ1biBidHJmcyBzY3J1YiBwZXJpb2RpY2FsbHkuCkZlYiAxNSAxMTozNToyNyBob3N0IHN1ZG9b
MjQ0MF06ICAgdXNlciA6IFRUWT1wdHMvMCA7IFBXRD0vaG9tZS91c2VyIDsgVVNFUj1yb290IDsg
Q09NTUFORD0vYmluL2J0cmZzIHNjcnViIHN0YXJ0IC8KRmViIDE1IDExOjM1OjI4IGhvc3Qgc3Vk
b1syNDQ2XTogICB1c2VyIDogVFRZPXB0cy8wIDsgUFdEPS9ob21lL3VzZXIgOyBVU0VSPXJvb3Qg
OyBDT01NQU5EPS9iaW4vYnRyZnMgc2NydWIgc3RhdHVzIC8KRmViIDE1IDExOjM1OjI5IGhvc3Qg
c3lzdGVtZFsxXTogU3RvcHBlZCBSdW4gYnRyZnMgc2NydWIgcGVyaW9kaWNhbGx5LgoKRmViIDE1
IDExOjM2OjU5IGhvc3Qgc3lzdGVtZFsxXTogc2Vzc2lvbi1jMi5zY29wZTogU3RvcHBpbmcgdGlt
ZWQgb3V0LiBLaWxsaW5nLgpGZWIgMTUgMTE6MzY6NTkgaG9zdCBzeXN0ZW1kWzFdOiBzZXNzaW9u
LWMyLnNjb3BlOiBLaWxsaW5nIHByb2Nlc3MgMjQ0MiAoYnRyZnMpIHdpdGggc2lnbmFsIFNJR0tJ
TEwuCgo5MHMgd2FpdAoKRmViIDE1IDExOjM4OjI5IGhvc3Qgc3lzdGVtZFsxXTogc2Vzc2lvbi1j
Mi5zY29wZTogU3RpbGwgYXJvdW5kIGFmdGVyIFNJR0tJTEwuIElnbm9yaW5nLgpGZWIgMTUgMTE6
Mzg6MjkgaG9zdCBzeXN0ZW1kWzFdOiBzZXNzaW9uLWMyLnNjb3BlOiBGYWlsZWQgd2l0aCByZXN1
bHQgJ3RpbWVvdXQnLgpGZWIgMTUgMTE6Mzg6MjkgaG9zdCBzeXN0ZW1kWzFdOiBTdG9wcGVkIFNl
c3Npb24gYzIgb2YgdXNlciB1c2VyLgpGZWIgMTUgMTE6Mzg6MjkgaG9zdCBzeXN0ZW1kWzFdOiBS
ZW1vdmVkIHNsaWNlIFVzZXIgU2xpY2Ugb2YgdXNlci4KCkZlYiAxNSAxMTozODozMCBob3N0IHN5
c3RlbWQtam91cm5hbGRbMjg5XTogSm91cm5hbCBzdG9wcGVkCgpyZWJvb3QKCkZlYiAxNSAxMToz
OToxNiBob3N0IGtlcm5lbDogbWljcm9jb2RlOiBtaWNyb2NvZGUgdXBkYXRlZCBlYXJseSB0byBy
ZXZpc2lvbiAweGEwYiwgZGF0ZSA9IDIwMTAtMDktMjgKCkZlYiAxNSAxMTozOToxNiBob3N0IGtl
cm5lbDogQnRyZnMgbG9hZGVkLCBjcmMzMmM9Y3JjMzJjLWdlbmVyaWMKRmViIDE1IDExOjM5OjE2
IGhvc3Qga2VybmVsOiBCVFJGUzogZGV2aWNlIGZzaWQgMTkwZDQ4MDMtZjQwNC00NThmLTg1YTEt
ZjZlYmY0MjU1NGQ0IGRldmlkIDEgdHJhbnNpZCAxMTQ4ODEgL2Rldi9zZGMzCkZlYiAxNSAxMToz
OToxNiBob3N0IGtlcm5lbDogQlRSRlMgaW5mbyAoZGV2aWNlIHNkYzMpOiBkaXNrIHNwYWNlIGNh
Y2hpbmcgaXMgZW5hYmxlZApGZWIgMTUgMTE6Mzk6MTYgaG9zdCBrZXJuZWw6IEJUUkZTIGluZm8g
KGRldmljZSBzZGMzKTogaGFzIHNraW5ueSBleHRlbnRzCkZlYiAxNSAxMTozOToxNiBob3N0IGtl
cm5lbDogQlRSRlMgaW5mbyAoZGV2aWNlIHNkYzMpOiBlbmFibGluZyBzc2Qgb3B0aW1pemF0aW9u
cwpGZWIgMTUgMTE6Mzk6MTYgaG9zdCBrZXJuZWw6IEJUUkZTIGluZm8gKGRldmljZSBzZGMzKTog
ZGlzayBzcGFjZSBjYWNoaW5nIGlzIGVuYWJsZWQKRmViIDE1IDExOjM5OjE4IGhvc3Qgc3lzdGVt
ZFsxXTogU3RhcnRlZCBSdW4gYnRyZnMgc2NydWIgcGVyaW9kaWNhbGx5LgpGZWIgMTUgMTI6NDU6
NTggaG9zdCBzdWRvWzE4MDVdOiAgIHVzZXIgOiBUVFk9cHRzLzAgOyBQV0Q9L2hvbWUvdXNlciA7
IFVTRVI9cm9vdCA7IENPTU1BTkQ9L2Jpbi9idHJmcyBzY3J1YiBzdGF0dXMgLwpGZWIgMTUgMTI6
NDY6MTAgaG9zdCBzdWRvWzE4MDddOiAgIHVzZXIgOiBUVFk9cHRzLzAgOyBQV0Q9L2hvbWUvdXNl
ciA7IFVTRVI9cm9vdCA7IENPTU1BTkQ9L2Jpbi9idHJmcyBzY3J1YiBzdGF0dXMgLwoKdXNlckBo
b3N0On4kIHN1ZG8gYnRyZnMgc2NydWIgc3RhdHVzIC8Kc2NydWIgc3RhdHVzIGZvciAxOTBkNDgw
My1mNDA0LTQ1OGYtODVhMS1mNmViZjQyNTU0ZDQKCW5vIHN0YXRzIGF2YWlsYWJsZQoJdG90YWwg
Ynl0ZXMgc2NydWJiZWQ6IDAuMDBCIHdpdGggMCBlcnJvcnMKdXNlckBob3N0On4kIHVuYW1lIC1h
OyBsc2JfcmVsZWFzZSAtYQpMaW51eCBob3N0IDQuMTUuMC03Ni1nZW5lcmljICM4Ni1VYnVudHUg
U01QIEZyaSBKYW4gMTcgMTc6MjQ6MjggVVRDIDIwMjAgeDg2XzY0IHg4Nl82NCB4ODZfNjQgR05V
L0xpbnV4Ck5vIExTQiBtb2R1bGVzIGFyZSBhdmFpbGFibGUuCkRpc3RyaWJ1dG9yIElEOglVYnVu
dHUKRGVzY3JpcHRpb246CVVidW50dSAxOC4wNC40IExUUwpSZWxlYXNlOgkxOC4wNApDb2RlbmFt
ZToJYmlvbmljCg==
--00000000000051243b059e9cebd5--
