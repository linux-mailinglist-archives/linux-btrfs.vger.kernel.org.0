Return-Path: <linux-btrfs+bounces-10028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82BB9E1826
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 10:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE999166B5E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9568C1E0B86;
	Tue,  3 Dec 2024 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhWooIO0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2742D1E04A2
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219136; cv=none; b=oiqIE+AlZ7yA2LXR/iYgD81A0ER5wRzpZVIZgaC6NiJXUQDY0BUzGVjTK7SgXqlZ1lC2RZFox5gbhWhhsDUPiZy5kTZKrKbJYZz8cYr/FAuM9ZbfziPpFgUbG/RK2COfb6eVTWiVp/w6E0ETS0Vf/uYCw1cUoSBUdxnmNa1zrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219136; c=relaxed/simple;
	bh=x9DJnM2tYgskLo1DFuY+0cTi/eLjG8AN+u2jRf1BhIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=On5R1NxwQxNnOhci7nKDaH14yKyTeaXlOk0MaWiwBM/lKUlop2uGOjlBq+/fyif26r1pNekfh7RvUiEZ523MOFY2tU4bBZ9rSB5F2Vxz/+PfFXzK/ZlailhxsH8G4CA8ugNczhl08+krLvmo0gXbWQx9aIYt/+VlCr8F0Cj0Tik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhWooIO0; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f22ea6d72aso1539961eaf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Dec 2024 01:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733219133; x=1733823933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P1bUr4Q1/z8EnYF79RrTSBJO6kLl9ICcNhuQacDIi7c=;
        b=bhWooIO0uLjc2L7WdXQu8aQUppl3+HWEdNzvxihH6gsML+0CoiW8dSvxnje0sQO2bj
         ODv0nn947r2jgE68DmHGEA+Q+toZWGk7qmLrlqDTkdb7IYsT4GJ2tGY92Yh/lz+eLm28
         9600K59rYGA2ML+XdePcN/hWPv+ZBekhQeTfbfOECqWtdTJkfwYtxQVE4+SKpAUFcGgA
         HcvFEET9SjuYf7QoxjgONLYFBn7YxdLHe9kT7HgALlgDDzrkLYAdUZMDcSonap/e0zwZ
         E5g+Ucw9n+gHqw10OiVCeVtVgKSjVyaIDUS80g60DTBqD7WoL8fzxyhAvI0E4kZfxE6I
         xSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219133; x=1733823933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1bUr4Q1/z8EnYF79RrTSBJO6kLl9ICcNhuQacDIi7c=;
        b=BKnJ5gcBO8z1ZvmMdvAs7Xqbet5JoraifvzgMkoso/J0jhwdn7z7gdJd/ryJMRU5xc
         kwQj6j2W6sYuke77eOJTtwdyk7bzt9qgH09vyMyh5JVy3MtLjex32ijsmzaADrpHr48V
         e+5voJYI7gZpz71LEE1IppudqR/rjymZaAtjxFnr1zYbpYuhbfYiZGlCd/KVY02VOdJR
         Pg1CijrhLvv98JrulFiw9nyhoJp8Ud5ZBIruagekcVo9n3B7mJ08eFLeXntNoLAZCkon
         FFFffrnZRjVFOmix9FE+4Sd/K1VgqwFiQkwN+Tcq/oDOoqoJ4HpnquIP8w7wmf14pmsl
         KEKA==
X-Gm-Message-State: AOJu0YxH2NyZSbtUcn0wZBi9uSC3zW2mnIc8Ts5gulplQL7CFBm3irVB
	c6Jfpr64n6WoeCn3MbtzbkRFW+CsL5/qtqFbVaeIbphuLtHBfd6AQFA9dVzrsZOTs1v6dN2Kv6h
	Bm3PlKkbuhUqSpXj5SXX4kmf9DDzEvJLLkAA=
X-Gm-Gg: ASbGncs4/BBO8l4c2tgsF1u7WP8y9md7I13XTL2EN8a+WPO4UiJ5u58RTHJQCufoxkF
	ujw9ZebstETYqUMrWGg262unvANw8iUHjgONPpHYmqLNvAQjkJyT/2QJU0M4WEp4vKA==
X-Google-Smtp-Source: AGHT+IEmhh2DKPLw1V35pHNIlK7f8j+jJ4dOICc2gPwqP2u2I2OZwfIn4sFUxTqK4Q8uI2IfcBC2RhWibd6MYMAefEM=
X-Received: by 2002:a05:6820:1c9e:b0:5e1:c19d:3f4e with SMTP id
 006d021491bc7-5f25aebd6a4mr1311690eaf.8.1733219133122; Tue, 03 Dec 2024
 01:45:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAYHqBbMeLYXdhNondp8JwQCsp-n1cCvnAubS3f2FxD6PBOEsQ@mail.gmail.com>
 <8276d833-d4f2-42dd-8190-c98265896ee3@gmx.com> <CAAYHqBZMBmD2yT2C95KrGXNqYjkecEO3jQQ74X5iT+MKxWhpMA@mail.gmail.com>
 <ba4f665d-f7fe-438f-a7ba-dc92d16b9f68@gmx.com>
In-Reply-To: <ba4f665d-f7fe-438f-a7ba-dc92d16b9f68@gmx.com>
From: Neil Parton <njparton@gmail.com>
Date: Tue, 3 Dec 2024 09:45:21 +0000
Message-ID: <CAAYHqBZmXtW_Z1KBNzOODNHgC=hMVXUrS3HGvKsBy3cd=jW-mQ@mail.gmail.com>
Subject: Re: Balance failed with tree block error
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000bf861806285a868f"

--000000000000bf861806285a868f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK I unmounted the filesystem and ran sudo btrfs check --readonly
/dev/sdd 1> stdout.txt 2> stderr.txt > check.txt (sdd appeared to be
the drive with issues from the dmesg logs).

stderr and check outputs attached, stdout was blank

Thanks

Neil

On Tue, 3 Dec 2024 at 08:38, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2024/12/3 18:50, Neil Parton =E5=86=99=E9=81=93:
> > OK I've output dmesg to a text file attached, glad you remembered my
> > previous experience as I forgot to mention that!
>
> The tree block backref btrfs is searching for is 332886134538240.
>
> But there are only two tree block backref near that number:
>
> [16181.904739]  item 63 key (332886134521856 168 16384) itemoff 13019
> itemsize 51
> [16181.904740]          extent refs 1 gen 12802640 flags 2
> [16181.904741]          tree block key (18446744073709551606 128
> 334290896531456) level 0
> [16181.904741]          ref#0: tree block backref root 7
> [16181.904742]  item 64 key (332886134554624 168 16384) itemoff 12968
> itemsize 51
> [16181.904743]          extent refs 1 gen 12802640 flags 2
> [16181.904744]          tree block key (18446744073709551606 128
> 334290913148928) level 0
> [16181.904745]          ref#0: tree block backref root 7
>
> So far it's very hard to judge if it's a memory bitflip.
>
> The bytenr 332886134538240 is 0x0x12ec217cc8000, meanwhile the target is
> 0x12ec217ccc000.
>
> The diff is 0x4000, so it may be a bit flip.
>
> On the other hand, it may also be a case where it's really an extent
> tree corruption that cause some backref missing for that 0x12ec217ccc000
> bytenr.
>
> I do not have a good call just based on the dmesg.
>
> A full "btrfs check --readonly" output (including both stderr and
> stdout) could help a lot.
> And if your memtest exposed some error, then it's also very likely it's
> a bitflip at runtime, and since such bitflip brings no obvious
> corruption btrfs is unable to catch it and wrote it back to disk.
>
> Thanks,
> Qu
>
> >
> > Thanks
> >
> > Neil
> >
> > On Tue, 3 Dec 2024 at 08:16, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/12/3 18:41, Neil Parton =E5=86=99=E9=81=93:
> >>> Arch Linux kernel 6.6.63-1-lts, btrfs-progs 6.12-1
> >>>
> >>> Yesterday I added a 5th drive to an existing raid 1 array (raid1c3
> >>> metadata) and overnight it failed after a few percent complete.  btrf=
s
> >>> stats are all zero and there are no SMART errors on any of the 5
> >>> drives.
> >>>
> >>> dmesg shows the following:
> >>>
> >>> $ sudo dmesg | grep btrfs
> >>> [16181.905236] WARNING: CPU: 0 PID: 23336 at
> >>> fs/btrfs/relocation.c:3286 add_data_references+0x4f8/0x550 [btrfs]
> >>> [16181.905347]  spi_intel xhci_pci_renesas drm_display_helper video
> >>> cec wmi btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel
> >>> xor raid6_pq
> >>> [16181.905354] CPU: 0 PID: 23336 Comm: btrfs Tainted: G     U
> >>>      6.6.63-1-lts #1 1935f30fe99b63e43ea69e5a59d364f11de63a00
> >>> [16181.905358] RIP: 0010:add_data_references+0x4f8/0x550 [btrfs]
> >>> [16181.905431]  ? add_data_references+0x4f8/0x550 [btrfs
> >>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> >>> [16181.905488]  ? add_data_references+0x4f8/0x550 [btrfs
> >>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> >>> [16181.905551]  ? add_data_references+0x4f8/0x550 [btrfs
> >>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> >>> [16181.905601]  ? add_data_references+0x4f8/0x550 [btrfs
> >>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> >>> [16181.905654]  relocate_block_group+0x336/0x500 [btrfs
> >>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> >>> [16181.905705]  btrfs_relocate_block_group+0x27c/0x440 [btrfs
> >>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> >>> [16181.905755]  btrfs_relocate_chunk+0x3f/0x170 [btrfs
> >>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> >>> [16181.905811]  btrfs_balance+0x942/0x1340 [btrfs
> >>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> >>> [16181.905866]  btrfs_ioctl+0x2388/0x2640 [btrfs
> >>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
> >>>
> >>> and
> >>>
> >>> $ sudo dmesg | grep BTRFS
> >>> <deleted lots of repetitive lines for brevity>
> >>> [16162.080878] BTRFS info (device sdd): relocating block group
> >>> 338737521229824 flags data|raid1
> >>> [16175.051355] BTRFS info (device sdd): found 5 extents, stage: move
> >>> data extents
> >>> [16180.023748] BTRFS info (device sdd): found 5 extents, stage: updat=
e
> >>> data pointers
> >>> [16181.904523] BTRFS info (device sdd): leaf 328610877177856 gen
> >>> 12982316 total ptrs 206 free space 627 owner 2
> >>> [16181.905206] BTRFS error (device sdd): tree block extent item
> >>> (332886134538240) is not found in extent tree
> >>
> >> There is a leaf dump, please paste the full dmesg, or we can not be su=
re
> >> what the cause is.
> >>
> >> Although I guess it may be a memory bitflip, considering all the past
> >> experience.
> >>
> >> So after pasting the full dmesg, you may also want to do a full memtes=
t
> >> just in case.
> >>
> >> Thanks,
> >> Qu
> >>
> >>> [16183.091659] BTRFS info (device sdd): balance: ended with status: -=
22
> >>>
> >>> What course of action should I take so that the balance completes nex=
t time?
> >>>
> >>> Many thanks
> >>>
> >>> Neil
> >>>
> >>
>

--000000000000bf861806285a868f
Content-Type: text/plain; charset="US-ASCII"; name="check.txt"
Content-Disposition: attachment; filename="check.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m489vmjs0>
X-Attachment-Id: f_m489vmjs0

T3BlbmluZyBmaWxlc3lzdGVtIHRvIGNoZWNrLi4uCkNoZWNraW5nIGZpbGVzeXN0ZW0gb24gL2Rl
di9zZGQKVVVJRDogNzVjOWVmZWMtNjg2Ny00YzAyLWJlNWMtOGQxMDZiMzUyMjg2CmZvdW5kIDI0
NTU1NDk5OTc4NzUyIGJ5dGVzIHVzZWQsIGVycm9yKHMpIGZvdW5kCnRvdGFsIGNzdW0gYnl0ZXM6
IDIzOTI3OTQzMTkyCnRvdGFsIHRyZWUgYnl0ZXM6IDI1ODExNzMwNDMyCnRvdGFsIGZzIHRyZWUg
Ynl0ZXM6IDY3MjMxNzQ0MAp0b3RhbCBleHRlbnQgdHJlZSBieXRlczogNDQ3ODU2NjQwCmJ0cmVl
IHNwYWNlIHdhc3RlIGJ5dGVzOiA3OTI5MjMyMDAKZmlsZSBkYXRhIGJsb2NrcyBhbGxvY2F0ZWQ6
IDEyOTI2Mjk5OTI5ODA0OAogcmVmZXJlbmNlZCAyNDI2NDUzMzIxMzE4NA==
--000000000000bf861806285a868f
Content-Type: text/plain; charset="US-ASCII"; name="stderr.txt"
Content-Disposition: attachment; filename="stderr.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m489vmjx1>
X-Attachment-Id: f_m489vmjx1

WzEvOF0gY2hlY2tpbmcgbG9nIHNraXBwZWQgKG5vbmUgd3JpdHRlbikKWzIvOF0gY2hlY2tpbmcg
cm9vdCBpdGVtcwpbMy84XSBjaGVja2luZyBleHRlbnRzCnJlZiBtaXNtYXRjaCBvbiBbMzE1ODc0
MDM0NTgxNTA0IDgxNTgwMDMyXSBleHRlbnQgaXRlbSAxNTYsIGZvdW5kIDc4CmRhdGEgZXh0ZW50
WzMxNTg3NDAzNDU4MTUwNCwgODE1ODAwMzJdIGJ5dGVuciBtaW1zbWF0Y2gsIGV4dGVudCBpdGVt
IGJ5dGVuciAzMTU4NzQwMzQ1ODE1MDQgZmlsZSBpdGVtIGJ5dGVuciAwCmRhdGEgZXh0ZW50WzMx
NTg3NDAzNDU4MTUwNCwgODE1ODAwMzJdIHJlZmVyZW5jZXIgY291bnQgbWlzbWF0Y2ggKHBhcmVu
dCAzMzI4ODYxMzQ1MzgyNDApIHdhbnRlZCA3OCBoYXZlIDAKYmFja3BvaW50ZXIgbWlzbWF0Y2gg
b24gWzMxNTg3NDAzNDU4MTUwNCA4MTU4MDAzMl0KcmVmIG1pc21hdGNoIG9uIFszMzg3Mzc3ODk2
NjUyODAgMTM0MjE3NzI4XSBleHRlbnQgaXRlbSA5MSwgZm91bmQgMApkYXRhIGV4dGVudFszMzg3
Mzc3ODk2NjUyODAsIDEzNDIxNzcyOF0gYnl0ZW5yIG1pbXNtYXRjaCwgZXh0ZW50IGl0ZW0gYnl0
ZW5yIDMzODczNzc4OTY2NTI4MCBmaWxlIGl0ZW0gYnl0ZW5yIDAKZGF0YSBleHRlbnRbMzM4NzM3
Nzg5NjY1MjgwLCAxMzQyMTc3MjhdIHJlZmVyZW5jZXIgY291bnQgbWlzbWF0Y2ggKHBhcmVudCAz
MzI4ODYxMzQ1MzgyNDApIHdhbnRlZCA5MSBoYXZlIDAKYmFja3BvaW50ZXIgbWlzbWF0Y2ggb24g
WzMzODczNzc4OTY2NTI4MCAxMzQyMTc3MjhdCm93bmVyIHJlZiBjaGVjayBmYWlsZWQgWzMzODcz
Nzc4OTY2NTI4MCAxMzQyMTc3MjhdCkVSUk9SOiBlcnJvcnMgZm91bmQgaW4gZXh0ZW50IGFsbG9j
YXRpb24gdHJlZSBvciBjaHVuayBhbGxvY2F0aW9uCls0LzhdIGNoZWNraW5nIGZyZWUgc3BhY2Ug
dHJlZQpbNS84XSBjaGVja2luZyBmcyByb290cwpbNi84XSBjaGVja2luZyBvbmx5IGNzdW1zIGl0
ZW1zICh3aXRob3V0IHZlcmlmeWluZyBkYXRhKQpbNy84XSBjaGVja2luZyByb290IHJlZnMKWzgv
OF0gY2hlY2tpbmcgcXVvdGEgZ3JvdXBzIHNraXBwZWQgKG5vdCBlbmFibGVkIG9uIHRoaXMgRlMp
--000000000000bf861806285a868f--

