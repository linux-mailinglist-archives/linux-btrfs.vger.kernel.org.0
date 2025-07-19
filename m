Return-Path: <linux-btrfs+bounces-15571-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80017B0B1C7
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 22:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941515609C7
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 20:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB66221550;
	Sat, 19 Jul 2025 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyadV70T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116BC21578D
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Jul 2025 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752957559; cv=none; b=LpkHE/sXh6E6icAAXFLarPp04B0uLSTkVxwFGBK+j8TyeW0vzCZ0X2svXlE5Ujrb5ZaD8mR2idHln3d+YPbj1v+uPSFyYNT8sZyYj5oZibxTuepMme02YYPGL3SYXzTteY31fnnpyYx72KqnZGPndB0tI6+EDNcjv3Ko/HB3T/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752957559; c=relaxed/simple;
	bh=O/FAAcdTPaJ0dwXNslUEFOYiEKVNopxqXFsGdn4F6eM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=odPe03JtM6rLN7do4NJHZAaPLAKtj7A8fEQAcpWdl7LmKZ8HhjKsRhwS640mBI1BbQSxSNpN+KQC3zHbm3NylFyi3VBfa27KmvnqZ18fFnkLngUbSfH7qpMyvMivGAlt14bnobiyMO28GHogyc5LZJmVx9+ozG8oiHTwnIfGPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyadV70T; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71967cd1072so6193207b3.3
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Jul 2025 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752957555; x=1753562355; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dcYLBpWfgUSiLoMoM87Vf18jZFIurKx62W0kc/LMRMo=;
        b=JyadV70Tj3P3cdylPsfXPVFjFGutv35tHNptkmUnuHd8jfio9wcgLtHNf22q3GjOmv
         yY9ak0Jze+xXrAXbhXcEVIjjeCDmIcgXg/YmGJYvmhqpFKJXvjbCQnNyBLf3OrWMCkzZ
         gAnIO/kjB/HQh69kOjFCYhE30Sg19jC+Q8sW+XV1142Bd8sbo+QMgMPakV4Ca/Ly0dDz
         x0sAjuzhoheq6B0qS51kKctVZmhb5c+OXUGTJpk8uIVX9NQhKXxck4zRq2GlzLRJtCCf
         zfCV8k4rad3sVK0eCLO0wyAfGgwz/7+lMMNYwxln+mub4fZMB9oQmMQVUbJ2LpYYlOoj
         cYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752957555; x=1753562355;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dcYLBpWfgUSiLoMoM87Vf18jZFIurKx62W0kc/LMRMo=;
        b=ZUM7YCVptLZvI0y7mRx4e4WchPaSUH0azcKY4DC4lCkb2RjN5PyH8OaOy+doSSQvrR
         C0/1ylJahT+W3x2AmWOWYyqGgG97jNXk/e/nosJzqJkfygp9fC4ss5MiTS5wNrMs8wlr
         UpRCVelUZ5kjkp1lN6mB/FpDwkcmi1BtMSZB2uhJaqyaVnC6WZw7Ow17HfWI/fzPlixj
         pVLsu5c7ZsvaI9Up2Yb65AxJBsvkyRrBJc257ScH301etFcCaCGrLCMBnIBizA3Tz+I+
         zd/BaaI6A7mt/FhtOr6DRbQWHYMtYGcS4ZMJrUcrAwJK18FNk36ZcKzEd2eGQNgwbTIL
         gU2g==
X-Gm-Message-State: AOJu0YzO5f6QIzbgrOJnyveyvYjLPLnxMeQ7Mv7z1Zv85cGxZ7/dLpA4
	Zcs2RJ1mzqCTiZRQYUgPUhNA0HRrn/wa4+2H6VWdy2WjrAVj4G+kaxgeFIYgqnbsMgF7luWtnKQ
	uIseuQUXja/3CjrKTCiFbueCj0XOO/fGUZija
X-Gm-Gg: ASbGncs7CBMzhfx0/eOVA6V2gNC39jZo8uBPmef+t6RvX6IYDFAA6A96EABc6x0J+NA
	ckpouSmk4dPJ/2yuRPYU5RxRkHQsmZsS3xynhgQEWSS+6rTbTUhaFM1OrC9TtkWIfJgyTzUEAWV
	hHptanjC8erBkiunZFKBIkFJqU6jlTeMDcX+0jbQNLxedkLZ4dx+za1FieDGz4THgU1zJaSMt9V
	xQMBHkE
X-Google-Smtp-Source: AGHT+IHSVeTP9wfdfJ0UgIy4Oq1garjUVcE+sfPuec0Ds9+grqwkJoZ3pRUJ6cZewF4rrc7SzZzmQuNs9nH30CNw1J0=
X-Received: by 2002:a05:690c:6181:b0:718:38be:b3e4 with SMTP id
 00721157ae682-71838bebb4bmr198292397b3.40.1752957554768; Sat, 19 Jul 2025
 13:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JLQuNC60YLQvtGAINCS0LDRgdC40LvQtdCy?= <hen03hat@gmail.com>
Date: Sat, 19 Jul 2025 23:39:03 +0300
X-Gm-Features: Ac12FXxxRxhYlVYjY9lJuwIwumwBAftdYh6H245H99dZztMxld4DJR0bSsev9k0
Message-ID: <CA+jD2V1yt6k53PDUrnOq07yBDbpYBnHvvS_8Dpm223ob63-N-w@mail.gmail.com>
Subject: Unable to remove a dir - "Directory not empty"
To: linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005c1aef063a4e3c10"

--0000000000005c1aef063a4e3c10
Content-Type: multipart/alternative; boundary="0000000000005c1aed063a4e3c0e"

--0000000000005c1aed063a4e3c0e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I accidentally stumbled upon a folder which I cannot delete:

=E2=9D=AF ls -alh
ls: cannot access 'a00334d6-50aa-42c6-9e08-a3506b9e9a7e': No such file or
directory
total 0
drwx------ 1 <username> <username> 72 Jul 19 21:47 ./
drwx------ 1 <username> <username> 24 Jul 19 21:47 ../
d????????? ? ?    ?     ?            ? a00334d6-50aa-42c6-9e08-a3506b9e9a7e=
/

According to the wiki I might have an empty directory with a non-zero
i_size:

=E2=9D=AF sudo stat -c %s a00334d6-50aa-42c6-9e08-a3506b9e9a7e/ ..
stat: cannot statx 'a00334d6-50aa-42c6-9e08-a3506b9e9a7e/': No such file or
directory
24

btrfs check did find errors (attached), whereas btrfs scrub didn't.
AFAICT, other than this folder, there are no other issues.

I'm hesitant to run btrfs check --repair on my own. Is there a way to
figure out if it's safe?

System info:
=E2=9D=AF uname -a
Linux raven 6.12.35-1-lts #1 SMP PREEMPT_DYNAMIC Fri, 27 Jun 2025 10:50:50
+0000 x86_64 GNU/Linux

=E2=9D=AF btrfs --version
btrfs-progs v6.15
-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED
CRYPTO=3Dlibgcrypt

=E2=9D=AF sudo btrfs fi show /dev/nvme0n1p2

Label: 'system'  uuid: 2034cd9d-98e7-480f-b0b5-92b6864d315b
Total devices 1 FS bytes used 716.05GiB
devid    1 size 1.82TiB used 902.57GiB path /dev/nvme0n1p2

=E2=9D=AF btrfs fi df /
Data, single: total=3D862.49GiB, used=3D702.75GiB
System, DUP: total=3D40.00MiB, used=3D192.00KiB
Metadata, DUP: total=3D20.00GiB, used=3D13.30GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

Thank you for your time.

Regards,
Viktor

--0000000000005c1aed063a4e3c0e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>I accidentally stumbl=
ed upon a folder which I cannot delete:</div><div><br></div><div>=E2=9D=AF =
ls -alh<br>ls: cannot access &#39;a00334d6-50aa-42c6-9e08-a3506b9e9a7e&#39;=
: No such file or directory<br>total 0<br>drwx------ 1 &lt;username&gt; &lt=
;username&gt; 72 Jul 19 21:47 ./<br>drwx------ 1 &lt;username&gt; &lt;usern=
ame&gt; 24 Jul 19 21:47 ../<br>d????????? ? ? =C2=A0 =C2=A0? =C2=A0 =C2=A0 =
? =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? a00334d6-50aa-42c6-9e08-a3506b=
9e9a7e/<br></div><div><br></div><div>According to the wiki I might have=C2=
=A0an empty directory with a non-zero i_size:</div><div><br></div><div>=E2=
=9D=AF sudo stat -c %s a00334d6-50aa-42c6-9e08-a3506b9e9a7e/ ..=C2=A0 =C2=
=A0<br>stat: cannot statx &#39;a00334d6-50aa-42c6-9e08-a3506b9e9a7e/&#39;: =
No such file or directory<br>24<br></div><div><br></div><div>btrfs check di=
d find errors=C2=A0(attached), whereas=C2=A0btrfs scrub didn&#39;t.</div><d=
iv>AFAICT, other than this folder, there are no other issues.</div><div><br=
></div><div>I&#39;m hesitant to run btrfs check --repair on my own. Is ther=
e a way to figure out if it&#39;s safe?</div><div></div><div></div><div><br=
></div><div>System info:</div><div>=E2=9D=AF uname -a<br>Linux raven 6.12.3=
5-1-lts #1 SMP PREEMPT_DYNAMIC Fri, 27 Jun 2025 10:50:50 +0000 x86_64 GNU/L=
inux</div><div><br></div><div>=E2=9D=AF btrfs --version<br>btrfs-progs v6.1=
5<br>-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPTO=
=3Dlibgcrypt</div><div><br></div><div>=E2=9D=AF sudo btrfs fi show /dev/nvm=
e0n1p2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br>Label: &#39;s=
ystem&#39; =C2=A0uuid: 2034cd9d-98e7-480f-b0b5-92b6864d315b<br>	Total devic=
es 1 FS bytes used 716.05GiB<br>	devid =C2=A0 =C2=A01 size 1.82TiB used 902=
.57GiB path /dev/nvme0n1p2</div><div><br></div><div>=E2=9D=AF btrfs fi df /=
<br>Data, single: total=3D862.49GiB, used=3D702.75GiB<br>System, DUP: total=
=3D40.00MiB, used=3D192.00KiB<br>Metadata, DUP: total=3D20.00GiB, used=3D13=
.30GiB<br>GlobalReserve, single: total=3D512.00MiB, used=3D0.00B</div><div>=
<br></div><div>Thank you for your time.</div><div><br></div><div>Regards,</=
div><div>Viktor</div></div>

--0000000000005c1aed063a4e3c0e--
--0000000000005c1aef063a4e3c10
Content-Type: text/plain; charset="US-ASCII"; name="check.txt"
Content-Disposition: attachment; filename="check.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mdapmf3m1>
X-Attachment-Id: f_mdapmf3m1

WzEvOF0gY2hlY2tpbmcgbG9nIHNraXBwZWQgKG5vbmUgd3JpdHRlbikKWzIvOF0gY2hlY2tpbmcg
cm9vdCBpdGVtcwpbMy84XSBjaGVja2luZyBleHRlbnRzCls0LzhdIGNoZWNraW5nIGZyZWUgc3Bh
Y2UgdHJlZQpbNS84XSBjaGVja2luZyBmcyByb290cwpyb290IDI1NyBpbm9kZSAzMzE1NTczNiBl
cnJvcnMgMSwgbm8gaW5vZGUgaXRlbQoJdW5yZXNvbHZlZCByZWYgZGlyIDU3MzMwMjAgaW5kZXgg
MjEgbmFtZWxlbiAzNiBuYW1lIGEwMDMzNGQ2LTUwYWEtNDJjNi05ZTA4LWEzNTA2YjllOWE3ZSBm
aWxldHlwZSAyIGVycm9ycyA1LCBubyBkaXIgaXRlbSwgbm8gaW5vZGUgcmVmCgl1bnJlc29sdmVk
IHJlZiBkaXIgNTczMzAyMCBpbmRleCAyMSBuYW1lbGVuIDM2IG5hbWUgNDE2ODFmZmUtN2ExZi00
Njk5LTk0NDAtMTJlZTE2YzVjMWM5IGZpbGV0eXBlIDIgZXJyb3JzIDIsIG5vIGRpciBpbmRleApy
b290IDM3MTA4IGlub2RlIDMzMTU1NzM2IGVycm9ycyAxLCBubyBpbm9kZSBpdGVtCgl1bnJlc29s
dmVkIHJlZiBkaXIgNTczMzAyMCBpbmRleCAyMSBuYW1lbGVuIDM2IG5hbWUgYTAwMzM0ZDYtNTBh
YS00MmM2LTllMDgtYTM1MDZiOWU5YTdlIGZpbGV0eXBlIDIgZXJyb3JzIDUsIG5vIGRpciBpdGVt
LCBubyBpbm9kZSByZWYKCXVucmVzb2x2ZWQgcmVmIGRpciA1NzMzMDIwIGluZGV4IDIxIG5hbWVs
ZW4gMzYgbmFtZSA0MTY4MWZmZS03YTFmLTQ2OTktOTQ0MC0xMmVlMTZjNWMxYzkgZmlsZXR5cGUg
MiBlcnJvcnMgMiwgbm8gZGlyIGluZGV4CnJvb3QgMzg2MDggaW5vZGUgMzMxNTU3MzYgZXJyb3Jz
IDEsIG5vIGlub2RlIGl0ZW0KCXVucmVzb2x2ZWQgcmVmIGRpciA1NzMzMDIwIGluZGV4IDIxIG5h
bWVsZW4gMzYgbmFtZSBhMDAzMzRkNi01MGFhLTQyYzYtOWUwOC1hMzUwNmI5ZTlhN2UgZmlsZXR5
cGUgMiBlcnJvcnMgNSwgbm8gZGlyIGl0ZW0sIG5vIGlub2RlIHJlZgoJdW5yZXNvbHZlZCByZWYg
ZGlyIDU3MzMwMjAgaW5kZXggMjEgbmFtZWxlbiAzNiBuYW1lIDQxNjgxZmZlLTdhMWYtNDY5OS05
NDQwLTEyZWUxNmM1YzFjOSBmaWxldHlwZSAyIGVycm9ycyAyLCBubyBkaXIgaW5kZXgKcm9vdCAz
OTY3MCBpbm9kZSAzMzE1NTczNiBlcnJvcnMgMSwgbm8gaW5vZGUgaXRlbQoJdW5yZXNvbHZlZCBy
ZWYgZGlyIDU3MzMwMjAgaW5kZXggMjEgbmFtZWxlbiAzNiBuYW1lIGEwMDMzNGQ2LTUwYWEtNDJj
Ni05ZTA4LWEzNTA2YjllOWE3ZSBmaWxldHlwZSAyIGVycm9ycyA1LCBubyBkaXIgaXRlbSwgbm8g
aW5vZGUgcmVmCgl1bnJlc29sdmVkIHJlZiBkaXIgNTczMzAyMCBpbmRleCAyMSBuYW1lbGVuIDM2
IG5hbWUgNDE2ODFmZmUtN2ExZi00Njk5LTk0NDAtMTJlZTE2YzVjMWM5IGZpbGV0eXBlIDIgZXJy
b3JzIDIsIG5vIGRpciBpbmRleApyb290IDM5OTk4IGlub2RlIDMzMTU1NzM2IGVycm9ycyAxLCBu
byBpbm9kZSBpdGVtCgl1bnJlc29sdmVkIHJlZiBkaXIgNTczMzAyMCBpbmRleCAyMSBuYW1lbGVu
IDM2IG5hbWUgYTAwMzM0ZDYtNTBhYS00MmM2LTllMDgtYTM1MDZiOWU5YTdlIGZpbGV0eXBlIDIg
ZXJyb3JzIDUsIG5vIGRpciBpdGVtLCBubyBpbm9kZSByZWYKCXVucmVzb2x2ZWQgcmVmIGRpciA1
NzMzMDIwIGluZGV4IDIxIG5hbWVsZW4gMzYgbmFtZSA0MTY4MWZmZS03YTFmLTQ2OTktOTQ0MC0x
MmVlMTZjNWMxYzkgZmlsZXR5cGUgMiBlcnJvcnMgMiwgbm8gZGlyIGluZGV4CnJvb3QgNDAwNDYg
aW5vZGUgMzMxNTU3MzYgZXJyb3JzIDEsIG5vIGlub2RlIGl0ZW0KCXVucmVzb2x2ZWQgcmVmIGRp
ciA1NzMzMDIwIGluZGV4IDIxIG5hbWVsZW4gMzYgbmFtZSBhMDAzMzRkNi01MGFhLTQyYzYtOWUw
OC1hMzUwNmI5ZTlhN2UgZmlsZXR5cGUgMiBlcnJvcnMgNSwgbm8gZGlyIGl0ZW0sIG5vIGlub2Rl
IHJlZgoJdW5yZXNvbHZlZCByZWYgZGlyIDU3MzMwMjAgaW5kZXggMjEgbmFtZWxlbiAzNiBuYW1l
IDQxNjgxZmZlLTdhMWYtNDY5OS05NDQwLTEyZWUxNmM1YzFjOSBmaWxldHlwZSAyIGVycm9ycyAy
LCBubyBkaXIgaW5kZXgKcm9vdCA0MDM1MiBpbm9kZSAzMzE1NTczNiBlcnJvcnMgMSwgbm8gaW5v
ZGUgaXRlbQoJdW5yZXNvbHZlZCByZWYgZGlyIDU3MzMwMjAgaW5kZXggMjEgbmFtZWxlbiAzNiBu
YW1lIGEwMDMzNGQ2LTUwYWEtNDJjNi05ZTA4LWEzNTA2YjllOWE3ZSBmaWxldHlwZSAyIGVycm9y
cyA1LCBubyBkaXIgaXRlbSwgbm8gaW5vZGUgcmVmCgl1bnJlc29sdmVkIHJlZiBkaXIgNTczMzAy
MCBpbmRleCAyMSBuYW1lbGVuIDM2IG5hbWUgNDE2ODFmZmUtN2ExZi00Njk5LTk0NDAtMTJlZTE2
YzVjMWM5IGZpbGV0eXBlIDIgZXJyb3JzIDIsIG5vIGRpciBpbmRleApyb290IDQwNTAyIGlub2Rl
IDMzMTU1NzM2IGVycm9ycyAxLCBubyBpbm9kZSBpdGVtCgl1bnJlc29sdmVkIHJlZiBkaXIgNTcz
MzAyMCBpbmRleCAyMSBuYW1lbGVuIDM2IG5hbWUgYTAwMzM0ZDYtNTBhYS00MmM2LTllMDgtYTM1
MDZiOWU5YTdlIGZpbGV0eXBlIDIgZXJyb3JzIDUsIG5vIGRpciBpdGVtLCBubyBpbm9kZSByZWYK
CXVucmVzb2x2ZWQgcmVmIGRpciA1NzMzMDIwIGluZGV4IDIxIG5hbWVsZW4gMzYgbmFtZSA0MTY4
MWZmZS03YTFmLTQ2OTktOTQ0MC0xMmVlMTZjNWMxYzkgZmlsZXR5cGUgMiBlcnJvcnMgMiwgbm8g
ZGlyIGluZGV4CnJvb3QgNDA1NTAgaW5vZGUgMzMxNTU3MzYgZXJyb3JzIDEsIG5vIGlub2RlIGl0
ZW0KCXVucmVzb2x2ZWQgcmVmIGRpciA1NzMzMDIwIGluZGV4IDIxIG5hbWVsZW4gMzYgbmFtZSBh
MDAzMzRkNi01MGFhLTQyYzYtOWUwOC1hMzUwNmI5ZTlhN2UgZmlsZXR5cGUgMiBlcnJvcnMgNSwg
bm8gZGlyIGl0ZW0sIG5vIGlub2RlIHJlZgoJdW5yZXNvbHZlZCByZWYgZGlyIDU3MzMwMjAgaW5k
ZXggMjEgbmFtZWxlbiAzNiBuYW1lIDQxNjgxZmZlLTdhMWYtNDY5OS05NDQwLTEyZWUxNmM1YzFj
OSBmaWxldHlwZSAyIGVycm9ycyAyLCBubyBkaXIgaW5kZXgKcm9vdCA0MDU5OCBpbm9kZSAzMzE1
NTczNiBlcnJvcnMgMSwgbm8gaW5vZGUgaXRlbQoJdW5yZXNvbHZlZCByZWYgZGlyIDU3MzMwMjAg
aW5kZXggMjEgbmFtZWxlbiAzNiBuYW1lIGEwMDMzNGQ2LTUwYWEtNDJjNi05ZTA4LWEzNTA2Yjll
OWE3ZSBmaWxldHlwZSAyIGVycm9ycyA1LCBubyBkaXIgaXRlbSwgbm8gaW5vZGUgcmVmCgl1bnJl
c29sdmVkIHJlZiBkaXIgNTczMzAyMCBpbmRleCAyMSBuYW1lbGVuIDM2IG5hbWUgNDE2ODFmZmUt
N2ExZi00Njk5LTk0NDAtMTJlZTE2YzVjMWM5IGZpbGV0eXBlIDIgZXJyb3JzIDIsIG5vIGRpciBp
bmRleApyb290IDQwNjQ2IGlub2RlIDMzMTU1NzM2IGVycm9ycyAxLCBubyBpbm9kZSBpdGVtCgl1
bnJlc29sdmVkIHJlZiBkaXIgNTczMzAyMCBpbmRleCAyMSBuYW1lbGVuIDM2IG5hbWUgYTAwMzM0
ZDYtNTBhYS00MmM2LTllMDgtYTM1MDZiOWU5YTdlIGZpbGV0eXBlIDIgZXJyb3JzIDUsIG5vIGRp
ciBpdGVtLCBubyBpbm9kZSByZWYKCXVucmVzb2x2ZWQgcmVmIGRpciA1NzMzMDIwIGluZGV4IDIx
IG5hbWVsZW4gMzYgbmFtZSA0MTY4MWZmZS03YTFmLTQ2OTktOTQ0MC0xMmVlMTZjNWMxYzkgZmls
ZXR5cGUgMiBlcnJvcnMgMiwgbm8gZGlyIGluZGV4CnJvb3QgNDA2OTQgaW5vZGUgMzMxNTU3MzYg
ZXJyb3JzIDEsIG5vIGlub2RlIGl0ZW0KCXVucmVzb2x2ZWQgcmVmIGRpciA1NzMzMDIwIGluZGV4
IDIxIG5hbWVsZW4gMzYgbmFtZSBhMDAzMzRkNi01MGFhLTQyYzYtOWUwOC1hMzUwNmI5ZTlhN2Ug
ZmlsZXR5cGUgMiBlcnJvcnMgNSwgbm8gZGlyIGl0ZW0sIG5vIGlub2RlIHJlZgoJdW5yZXNvbHZl
ZCByZWYgZGlyIDU3MzMwMjAgaW5kZXggMjEgbmFtZWxlbiAzNiBuYW1lIDQxNjgxZmZlLTdhMWYt
NDY5OS05NDQwLTEyZWUxNmM1YzFjOSBmaWxldHlwZSAyIGVycm9ycyAyLCBubyBkaXIgaW5kZXgK
cm9vdCA0MDc0NiBpbm9kZSAzMzE1NTczNiBlcnJvcnMgMSwgbm8gaW5vZGUgaXRlbQoJdW5yZXNv
bHZlZCByZWYgZGlyIDU3MzMwMjAgaW5kZXggMjEgbmFtZWxlbiAzNiBuYW1lIGEwMDMzNGQ2LTUw
YWEtNDJjNi05ZTA4LWEzNTA2YjllOWE3ZSBmaWxldHlwZSAyIGVycm9ycyA1LCBubyBkaXIgaXRl
bSwgbm8gaW5vZGUgcmVmCgl1bnJlc29sdmVkIHJlZiBkaXIgNTczMzAyMCBpbmRleCAyMSBuYW1l
bGVuIDM2IG5hbWUgNDE2ODFmZmUtN2ExZi00Njk5LTk0NDAtMTJlZTE2YzVjMWM5IGZpbGV0eXBl
IDIgZXJyb3JzIDIsIG5vIGRpciBpbmRleApyb290IDQwNzk0IGlub2RlIDMzMTU1NzM2IGVycm9y
cyAxLCBubyBpbm9kZSBpdGVtCgl1bnJlc29sdmVkIHJlZiBkaXIgNTczMzAyMCBpbmRleCAyMSBu
YW1lbGVuIDM2IG5hbWUgYTAwMzM0ZDYtNTBhYS00MmM2LTllMDgtYTM1MDZiOWU5YTdlIGZpbGV0
eXBlIDIgZXJyb3JzIDUsIG5vIGRpciBpdGVtLCBubyBpbm9kZSByZWYKCXVucmVzb2x2ZWQgcmVm
IGRpciA1NzMzMDIwIGluZGV4IDIxIG5hbWVsZW4gMzYgbmFtZSA0MTY4MWZmZS03YTFmLTQ2OTkt
OTQ0MC0xMmVlMTZjNWMxYzkgZmlsZXR5cGUgMiBlcnJvcnMgMiwgbm8gZGlyIGluZGV4CnJvb3Qg
NDA4NDIgaW5vZGUgMzMxNTU3MzYgZXJyb3JzIDEsIG5vIGlub2RlIGl0ZW0KCXVucmVzb2x2ZWQg
cmVmIGRpciA1NzMzMDIwIGluZGV4IDIxIG5hbWVsZW4gMzYgbmFtZSBhMDAzMzRkNi01MGFhLTQy
YzYtOWUwOC1hMzUwNmI5ZTlhN2UgZmlsZXR5cGUgMiBlcnJvcnMgNSwgbm8gZGlyIGl0ZW0sIG5v
IGlub2RlIHJlZgoJdW5yZXNvbHZlZCByZWYgZGlyIDU3MzMwMjAgaW5kZXggMjEgbmFtZWxlbiAz
NiBuYW1lIDQxNjgxZmZlLTdhMWYtNDY5OS05NDQwLTEyZWUxNmM1YzFjOSBmaWxldHlwZSAyIGVy
cm9ycyAyLCBubyBkaXIgaW5kZXgKcm9vdCA0MDg5MCBpbm9kZSAzMzE1NTczNiBlcnJvcnMgMSwg
bm8gaW5vZGUgaXRlbQoJdW5yZXNvbHZlZCByZWYgZGlyIDU3MzMwMjAgaW5kZXggMjEgbmFtZWxl
biAzNiBuYW1lIGEwMDMzNGQ2LTUwYWEtNDJjNi05ZTA4LWEzNTA2YjllOWE3ZSBmaWxldHlwZSAy
IGVycm9ycyA1LCBubyBkaXIgaXRlbSwgbm8gaW5vZGUgcmVmCgl1bnJlc29sdmVkIHJlZiBkaXIg
NTczMzAyMCBpbmRleCAyMSBuYW1lbGVuIDM2IG5hbWUgNDE2ODFmZmUtN2ExZi00Njk5LTk0NDAt
MTJlZTE2YzVjMWM5IGZpbGV0eXBlIDIgZXJyb3JzIDIsIG5vIGRpciBpbmRleApyb290IDQwOTM4
IGlub2RlIDMzMTU1NzM2IGVycm9ycyAxLCBubyBpbm9kZSBpdGVtCgl1bnJlc29sdmVkIHJlZiBk
aXIgNTczMzAyMCBpbmRleCAyMSBuYW1lbGVuIDM2IG5hbWUgYTAwMzM0ZDYtNTBhYS00MmM2LTll
MDgtYTM1MDZiOWU5YTdlIGZpbGV0eXBlIDIgZXJyb3JzIDUsIG5vIGRpciBpdGVtLCBubyBpbm9k
ZSByZWYKCXVucmVzb2x2ZWQgcmVmIGRpciA1NzMzMDIwIGluZGV4IDIxIG5hbWVsZW4gMzYgbmFt
ZSA0MTY4MWZmZS03YTFmLTQ2OTktOTQ0MC0xMmVlMTZjNWMxYzkgZmlsZXR5cGUgMiBlcnJvcnMg
Miwgbm8gZGlyIGluZGV4CnJvb3QgNDA5NzQgaW5vZGUgMzMxNTU3MzYgZXJyb3JzIDEsIG5vIGlu
b2RlIGl0ZW0KCXVucmVzb2x2ZWQgcmVmIGRpciA1NzMzMDIwIGluZGV4IDIxIG5hbWVsZW4gMzYg
bmFtZSBhMDAzMzRkNi01MGFhLTQyYzYtOWUwOC1hMzUwNmI5ZTlhN2UgZmlsZXR5cGUgMiBlcnJv
cnMgNSwgbm8gZGlyIGl0ZW0sIG5vIGlub2RlIHJlZgoJdW5yZXNvbHZlZCByZWYgZGlyIDU3MzMw
MjAgaW5kZXggMjEgbmFtZWxlbiAzNiBuYW1lIDQxNjgxZmZlLTdhMWYtNDY5OS05NDQwLTEyZWUx
NmM1YzFjOSBmaWxldHlwZSAyIGVycm9ycyAyLCBubyBkaXIgaW5kZXgKcm9vdCA0MDk3NiBpbm9k
ZSAzMzE1NTczNiBlcnJvcnMgMSwgbm8gaW5vZGUgaXRlbQoJdW5yZXNvbHZlZCByZWYgZGlyIDU3
MzMwMjAgaW5kZXggMjEgbmFtZWxlbiAzNiBuYW1lIGEwMDMzNGQ2LTUwYWEtNDJjNi05ZTA4LWEz
NTA2YjllOWE3ZSBmaWxldHlwZSAyIGVycm9ycyA1LCBubyBkaXIgaXRlbSwgbm8gaW5vZGUgcmVm
Cgl1bnJlc29sdmVkIHJlZiBkaXIgNTczMzAyMCBpbmRleCAyMSBuYW1lbGVuIDM2IG5hbWUgNDE2
ODFmZmUtN2ExZi00Njk5LTk0NDAtMTJlZTE2YzVjMWM5IGZpbGV0eXBlIDIgZXJyb3JzIDIsIG5v
IGRpciBpbmRleApyb290IDQwOTc4IGlub2RlIDMzMTU1NzM2IGVycm9ycyAxLCBubyBpbm9kZSBp
dGVtCgl1bnJlc29sdmVkIHJlZiBkaXIgNTczMzAyMCBpbmRleCAyMSBuYW1lbGVuIDM2IG5hbWUg
YTAwMzM0ZDYtNTBhYS00MmM2LTllMDgtYTM1MDZiOWU5YTdlIGZpbGV0eXBlIDIgZXJyb3JzIDUs
IG5vIGRpciBpdGVtLCBubyBpbm9kZSByZWYKCXVucmVzb2x2ZWQgcmVmIGRpciA1NzMzMDIwIGlu
ZGV4IDIxIG5hbWVsZW4gMzYgbmFtZSA0MTY4MWZmZS03YTFmLTQ2OTktOTQ0MC0xMmVlMTZjNWMx
YzkgZmlsZXR5cGUgMiBlcnJvcnMgMiwgbm8gZGlyIGluZGV4CnJvb3QgNDA5ODAgaW5vZGUgMzMx
NTU3MzYgZXJyb3JzIDEsIG5vIGlub2RlIGl0ZW0KCXVucmVzb2x2ZWQgcmVmIGRpciA1NzMzMDIw
IGluZGV4IDIxIG5hbWVsZW4gMzYgbmFtZSBhMDAzMzRkNi01MGFhLTQyYzYtOWUwOC1hMzUwNmI5
ZTlhN2UgZmlsZXR5cGUgMiBlcnJvcnMgNSwgbm8gZGlyIGl0ZW0sIG5vIGlub2RlIHJlZgoJdW5y
ZXNvbHZlZCByZWYgZGlyIDU3MzMwMjAgaW5kZXggMjEgbmFtZWxlbiAzNiBuYW1lIDQxNjgxZmZl
LTdhMWYtNDY5OS05NDQwLTEyZWUxNmM1YzFjOSBmaWxldHlwZSAyIGVycm9ycyAyLCBubyBkaXIg
aW5kZXgKcm9vdCA0MDk4MiBpbm9kZSAzMzE1NTczNiBlcnJvcnMgMSwgbm8gaW5vZGUgaXRlbQoJ
dW5yZXNvbHZlZCByZWYgZGlyIDU3MzMwMjAgaW5kZXggMjEgbmFtZWxlbiAzNiBuYW1lIGEwMDMz
NGQ2LTUwYWEtNDJjNi05ZTA4LWEzNTA2YjllOWE3ZSBmaWxldHlwZSAyIGVycm9ycyA1LCBubyBk
aXIgaXRlbSwgbm8gaW5vZGUgcmVmCgl1bnJlc29sdmVkIHJlZiBkaXIgNTczMzAyMCBpbmRleCAy
MSBuYW1lbGVuIDM2IG5hbWUgNDE2ODFmZmUtN2ExZi00Njk5LTk0NDAtMTJlZTE2YzVjMWM5IGZp
bGV0eXBlIDIgZXJyb3JzIDIsIG5vIGRpciBpbmRleApFUlJPUjogZXJyb3JzIGZvdW5kIGluIGZz
IHJvb3RzCg==
--0000000000005c1aef063a4e3c10
Content-Type: application/octet-stream; 
	name="scrub.status.2034cd9d-98e7-480f-b0b5-92b6864d315b"
Content-Disposition: attachment; 
	filename="scrub.status.2034cd9d-98e7-480f-b0b5-92b6864d315b"
Content-Transfer-Encoding: base64
Content-ID: <f_mdaplx2a0>
X-Attachment-Id: f_mdaplx2a0

c2NydWIgc3RhdHVzOjEKMjAzNGNkOWQtOThlNy00ODBmLWIwYjUtOTJiNjg2NGQzMTViOjF8ZGF0
YV9leHRlbnRzX3NjcnViYmVkOjE4MjAxMTE5fHRyZWVfZXh0ZW50c19zY3J1YmJlZDoxNzQxMzc0
fGRhdGFfYnl0ZXNfc2NydWJiZWQ6NzU0NDI4NDI4Mjg4fHRyZWVfYnl0ZXNfc2NydWJiZWQ6Mjg1
MzA2NzE2MTZ8cmVhZF9lcnJvcnM6MHxjc3VtX2Vycm9yczowfHZlcmlmeV9lcnJvcnM6MHxub19j
c3VtOjM1MjQ4MTkyfGNzdW1fZGlzY2FyZHM6MHxzdXBlcl9lcnJvcnM6MHxtYWxsb2NfZXJyb3Jz
OjB8dW5jb3JyZWN0YWJsZV9lcnJvcnM6MHxjb3JyZWN0ZWRfZXJyb3JzOjB8bGFzdF9waHlzaWNh
bDoxOTk5ODYwODU4ODgwfHRfc3RhcnQ6MTc1Mjk1NDQ1NXx0X3Jlc3VtZWQ6MHxkdXJhdGlvbjox
OTB8Y2FuY2VsZWQ6MHxmaW5pc2hlZDoxCg==
--0000000000005c1aef063a4e3c10--

