Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85114389E1E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 08:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhETGrJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 02:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETGrJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 02:47:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B237C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 23:45:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m190so11166329pga.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 23:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TFNiGSCJpQ3reEu4PSEH3DGsyOdFUNN9yoP/miaPeZ0=;
        b=nb+iHV7fo7L1h4qBp/KoTHcnADG9UBU1yvmIDBZhzfnv9z8hMeoSR6BJlU3BmybJyP
         PnKQDyttRNiouddtB6jUO8F5xqMSUOglelWHaoAd8ePGCxop5sANp8uN0Os40zZMsXhN
         vvIQkehk1qWvL5XLZJgVnP/pNR7l8ZL07usZuVgZjv/94Rg8AmqpO4fl3U+wJGPHbNEa
         9A0IZjjT9wb2OS/fyw4pAjAA8GjQL7zruaP9Kk7TJsiYdcDR8tQHi3M6yE867XkrfyBj
         pdMmmxd6lsTq+iheX7DHBta2M+h6U5umMJk+0O6LRl8be+cRLEo+f4l9sM0U+VzU1VUd
         yxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TFNiGSCJpQ3reEu4PSEH3DGsyOdFUNN9yoP/miaPeZ0=;
        b=QYGxNpVhjoZXhhpUuW4CwnkaWU7JUAtA4tBiumJ/ulseBYRaqiIUQyyV5wsWQwet0i
         cTMC4XQsN7JHbPtYX7/f/Dg4vt93KUgTqlp/e33aGV3AwPEmmFqqyATqirLxYdG7H06w
         AGZng7UKkQm6/7pRZilfrKQxS8J/tixBs5C0Xpf37bIeJalYmTl6FrIGOfXhspY3WIRa
         0Zq1K7vSedVyF7GYuAQNoeooCdN88pFj31+foG7THh0n3He2CES3jYaeSETYhytYP7O2
         +v/MDCeB+5Nd5g8M8a9yNX5frHQVT5YJir/o9T9jjFnG/9Az7hkup5/IINua+nT8fzcg
         0nkg==
X-Gm-Message-State: AOAM533UkEIPEPFX8fwfdazNSXONK9bjJDEGe/jsm5AtAVwLmmQEvpmm
        X4yBO0gEjhnyVVNdpe+g6iAb1EZ61rct04Qm4hzTJYARsy0=
X-Google-Smtp-Source: ABdhPJxpCWblvAvSWSqpStt2gzEAMnTt0bOpTmgJpWFRnqrHwsbg8BpIqyMo6AI3tVGlUtwTKIZKLmff/qCEm3Fitcg=
X-Received: by 2002:aa7:8202:0:b029:2d8:c24d:841d with SMTP id
 k2-20020aa782020000b02902d8c24d841dmr3251867pfi.57.1621493147796; Wed, 19 May
 2021 23:45:47 -0700 (PDT)
MIME-Version: 1.0
From:   Octavia Togami <octavia.togami@gmail.com>
Date:   Wed, 19 May 2021 23:45:36 -0700
Message-ID: <CAHPNGSTFw1rPFpnWF9OHzqKnxUSijYYUYtsenhj5YuNaSTGBgA@mail.gmail.com>
Subject: btrfs check: free space cache has more free space than block group item
To:     linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000014aecb05c2bd4b91"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--00000000000014aecb05c2bd4b91
Content-Type: text/plain; charset="UTF-8"

Hi,

I recently was trying to expand my root drive while booted into it, so
I made a new partition and did `btrfs device add /dev/the-partition
/`, then `btrfs balance start -dconvert=raid0 -mconvert=raid1 /`. It
segfaulted, and I determined it would be easier for me to just boot
into a live CD and move/resize it there; but when gparted attempted to
do the operation it failed `btrfs check`. I updated all my packages,
and then re-ran `btrfs check` and the output is attached. Is there a
fix?

--00000000000014aecb05c2bd4b91
Content-Type: text/plain; charset="US-ASCII"; name="btrfscheck.txt"
Content-Disposition: attachment; filename="btrfscheck.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kowj518v0>
X-Attachment-Id: f_kowj518v0

JCBzdWRvIGJ0cmZzIGNoZWNrIC9kZXYvbnZtZTBuMXA2Ck9wZW5pbmcgZmlsZXN5c3RlbSB0byBj
aGVjay4uLgpDaGVja2luZyBmaWxlc3lzdGVtIG9uIC9kZXYvbnZtZTBuMXA2ClVVSUQ6IDJkODBl
YWY3LTY1ODgtNDFiMy1hZGQzLTFkNGEzYTI5OTZlYgpbMS83XSBjaGVja2luZyByb290IGl0ZW1z
ClsyLzddIGNoZWNraW5nIGV4dGVudHMKWzMvN10gY2hlY2tpbmcgZnJlZSBzcGFjZSBjYWNoZQp0
aGVyZSBpcyBubyBmcmVlIHNwYWNlIGVudHJ5IGZvciAzNzkwNDc2MDgzMi0zNzkwNDc2OTAyNAp0
aGVyZSBpcyBubyBmcmVlIHNwYWNlIGVudHJ5IGZvciAzNzkwNDc2MDgzMi0zODY3NjcyNTc2MApj
YWNoZSBhcHBlYXJzIHZhbGlkIGJ1dCBpc24ndCAzNzYwMjk4MzkzNgp3YW50ZWQgYnl0ZXMgMzI3
NjgsIGZvdW5kIDgxOTIgZm9yIG9mZiA2NDc3ODEyMTIxNgp3YW50ZWQgYnl0ZXMgNzQyMTUwMTQ0
LCBmb3VuZCA4MTkyIGZvciBvZmYgNjQ3NzgxMjEyMTYKY2FjaGUgYXBwZWFycyB2YWxpZCBidXQg
aXNuJ3QgNjQ0NDY1Mjk1MzYKdGhlcmUgaXMgbm8gZnJlZSBzcGFjZSBlbnRyeSBmb3IgNjc3MDE0
MDM2NDgtNjc3MDE0MzIzMjAKdGhlcmUgaXMgbm8gZnJlZSBzcGFjZSBlbnRyeSBmb3IgNjc3MDE0
MDM2NDgtNjg3NDE0OTY4MzIKY2FjaGUgYXBwZWFycyB2YWxpZCBidXQgaXNuJ3QgNjc2Njc3NTUw
MDgKd2FudGVkIGJ5dGVzIDg2MDE2LCBmb3VuZCAzNjg2NCBmb3Igb2ZmIDY5MzQ1MDE3ODU2Cndh
bnRlZCBieXRlcyA0NzAyMjA4MDAsIGZvdW5kIDM2ODY0IGZvciBvZmYgNjkzNDUwMTc4NTYKY2Fj
aGUgYXBwZWFycyB2YWxpZCBidXQgaXNuJ3QgNjg3NDE0OTY4MzIKdGhlcmUgaXMgbm8gZnJlZSBz
cGFjZSBlbnRyeSBmb3IgMTQ4NzY2NjU0NDY0LTE0ODc2NjY2MjY1Ngp0aGVyZSBpcyBubyBmcmVl
IHNwYWNlIGVudHJ5IGZvciAxNDg3NjY2NTQ0NjQtMTQ5MjcyMTMzNjMyCmNhY2hlIGFwcGVhcnMg
dmFsaWQgYnV0IGlzbid0IDE0ODE5ODM5MTgwOAp3YW50ZWQgYnl0ZXMgNTczNDQsIGZvdW5kIDQw
OTYwIGZvciBvZmYgMTQ5Nzg4NzU4MDE2CndhbnRlZCBieXRlcyA1NTcxMTc0NDAsIGZvdW5kIDQw
OTYwIGZvciBvZmYgMTQ5Nzg4NzU4MDE2CmNhY2hlIGFwcGVhcnMgdmFsaWQgYnV0IGlzbid0IDE0
OTI3MjEzMzYzMgp0aGVyZSBpcyBubyBmcmVlIHNwYWNlIGVudHJ5IGZvciAxNTY4NDI0NzU1MjAt
MTU2ODQyNDk2MDAwCnRoZXJlIGlzIG5vIGZyZWUgc3BhY2UgZW50cnkgZm9yIDE1Njg0MjQ3NTUy
MC0xNTc4NjIwNjgyMjQKY2FjaGUgYXBwZWFycyB2YWxpZCBidXQgaXNuJ3QgMTU2Nzg4MzI2NDAw
CndhbnRlZCBieXRlcyA4MTkyMCwgZm91bmQgMTIyODggZm9yIG9mZiAxODQ2MjU2OTY3NjgKd2Fu
dGVkIGJ5dGVzIDc5OTE3MDU2LCBmb3VuZCAxMjI4OCBmb3Igb2ZmIDE4NDYyNTY5Njc2OApjYWNo
ZSBhcHBlYXJzIHZhbGlkIGJ1dCBpc24ndCAxODM2MzE4NzIwMDAKd2FudGVkIGJ5dGVzIDQ5MTUy
LCBmb3VuZCA0MDk2MCBmb3Igb2ZmIDE4NTc4MTQyNDEyOAp3YW50ZWQgYnl0ZXMgMTA3MTY3MzM0
NCwgZm91bmQgNDA5NjAgZm9yIG9mZiAxODU3ODE0MjQxMjgKY2FjaGUgYXBwZWFycyB2YWxpZCBi
dXQgaXNuJ3QgMTg1Nzc5MzU1NjQ4CndhbnRlZCBieXRlcyAyNDU3NiwgZm91bmQgMTYzODQgZm9y
IG9mZiAyMDk3NTQ0OTcwMjQKd2FudGVkIGJ5dGVzIDc1NDQ3NTAwOCwgZm91bmQgMTYzODQgZm9y
IG9mZiAyMDk3NTQ0OTcwMjQKY2FjaGUgYXBwZWFycyB2YWxpZCBidXQgaXNuJ3QgMjA5NDM1MjMw
MjA4CndhbnRlZCBieXRlcyA1MzI0OCwgZm91bmQgNDA5NjAgZm9yIG9mZiAyMTk4NDU1OTkyMzIK
d2FudGVkIGJ5dGVzIDMyNzA0OTIxNiwgZm91bmQgNDA5NjAgZm9yIG9mZiAyMTk4NDU1OTkyMzIK
Y2FjaGUgYXBwZWFycyB2YWxpZCBidXQgaXNuJ3QgMjE5MDk4OTA2NjI0CndhbnRlZCBieXRlcyA1
NzM0NCwgZm91bmQgNDUwNTYgZm9yIG9mZiAyMjgxODMyODE2NjQKd2FudGVkIGJ5dGVzIDU3OTMw
MTM3NiwgZm91bmQgNDUwNTYgZm9yIG9mZiAyMjgxODMyODE2NjQKY2FjaGUgYXBwZWFycyB2YWxp
ZCBidXQgaXNuJ3QgMjI3Njg4ODQxMjE2CmJsb2NrIGdyb3VwIDMwNzE0NTczNjE5MiBoYXMgd3Jv
bmcgYW1vdW50IG9mIGZyZWUgc3BhY2UsIGZyZWUgc3BhY2UgY2FjaGUgaGFzIDUzMTIxMDI0IGJs
b2NrIGdyb3VwIGhhcyA1MzE0NTYwMApmYWlsZWQgdG8gbG9hZCBmcmVlIHNwYWNlIGNhY2hlIGZv
ciBibG9jayBncm91cCAzMDcxNDU3MzYxOTIKd2FudGVkIGJ5dGVzIDYxNDQwLCBmb3VuZCA1MzI0
OCBmb3Igb2ZmIDMzNTAyNTA2NTk4NAp3YW50ZWQgYnl0ZXMgMzc5NTc2MzIsIGZvdW5kIDUzMjQ4
IGZvciBvZmYgMzM1MDI1MDY1OTg0CmNhY2hlIGFwcGVhcnMgdmFsaWQgYnV0IGlzbid0IDMzMzk4
OTI4MTc5MgpibG9jayBncm91cCA0NjUxMDIxNzYyNTYgaGFzIHdyb25nIGFtb3VudCBvZiBmcmVl
IHNwYWNlLCBmcmVlIHNwYWNlIGNhY2hlIGhhcyAyNTQ3MzAyNCBibG9jayBncm91cCBoYXMgMjU0
NjQ4MzIKRVJST1I6IGZyZWUgc3BhY2UgY2FjaGUgaGFzIG1vcmUgZnJlZSBzcGFjZSB0aGFuIGJs
b2NrIGdyb3VwIGl0ZW0sIHRoaXMgY291bGQgbGVhZHMgdG8gc2VyaW91cyBjb3JydXB0aW9uLCBw
bGVhc2UgY29udGFjdCBidHJmcyBkZXZlbG9wZXJzCmZhaWxlZCB0byBsb2FkIGZyZWUgc3BhY2Ug
Y2FjaGUgZm9yIGJsb2NrIGdyb3VwIDQ2NTEwMjE3NjI1Ngp3YW50ZWQgYnl0ZXMgMjA0ODAwLCBm
b3VuZCA1MzI0OCBmb3Igb2ZmIDY4NjExNjc5ODQ2NAp3YW50ZWQgYnl0ZXMgNDQ0NjI4OTkyLCBm
b3VuZCA1MzI0OCBmb3Igb2ZmIDY4NjExNjc5ODQ2NApjYWNoZSBhcHBlYXJzIHZhbGlkIGJ1dCBp
c24ndCA2ODU0ODc2ODU2MzIKWzQvN10gY2hlY2tpbmcgZnMgcm9vdHMKWzUvN10gY2hlY2tpbmcg
b25seSBjc3VtcyBpdGVtcyAod2l0aG91dCB2ZXJpZnlpbmcgZGF0YSkKWzYvN10gY2hlY2tpbmcg
cm9vdCByZWZzCls3LzddIGNoZWNraW5nIHF1b3RhIGdyb3VwcyBza2lwcGVkIChub3QgZW5hYmxl
ZCBvbiB0aGlzIEZTKQpmb3VuZCAzMDI1MDM1NTUwNzIgYnl0ZXMgdXNlZCwgZXJyb3IocykgZm91
bmQKdG90YWwgY3N1bSBieXRlczogMTg2MjUwNzYwCnRvdGFsIHRyZWUgYnl0ZXM6IDQzMTU1OTQ3
NTIKdG90YWwgZnMgdHJlZSBieXRlczogMzY4NjE4NzAwOAp0b3RhbCBleHRlbnQgdHJlZSBieXRl
czogMzM1NzczNjk2CmJ0cmVlIHNwYWNlIHdhc3RlIGJ5dGVzOiA5MDgzMDkwMTkKZmlsZSBkYXRh
IGJsb2NrcyBhbGxvY2F0ZWQ6IDU4OTI0MDQ3OTc0NAogcmVmZXJlbmNlZCA0MTY0OTAwMTY3NjgK
Cg==
--00000000000014aecb05c2bd4b91--
