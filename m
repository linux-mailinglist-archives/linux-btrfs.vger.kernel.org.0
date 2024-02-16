Return-Path: <linux-btrfs+bounces-2446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9E285726D
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 01:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7231AB21D59
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 00:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E039933EE;
	Fri, 16 Feb 2024 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwiRSB/E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EFF38F
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042912; cv=none; b=dBKGv/qAS5i8NtEHqjsJnpoRya9tBCGw+T7/UgF08wS7PbGwe0chGXupgfkSIWV/pItxsIWz0U/lDfJEuJ0fjmPHcLOe+Xbz/+tR6537FAotEdYosmVmOOk0xajNf5x0FY5w4PAe49CEviBe9JO7rd5K4OFGzNd6ncvylAuiyqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042912; c=relaxed/simple;
	bh=YbI4PIAtz4jvbt5uGu6qc6ht5V8a9BQ6AbhWL8tf6+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmlNNQfdqfabNnzRPoe9Y5HAIdwdk7ujy6gj8HC0l94rQPy7jIY7ivm4/prBAzi/zCLWAEdPwjHvOe7Y6IPdJ9wxc1VnYdyCaloeT+BUQUXFZfa8kmroFAR5dh7l+iTASAx+efGOUSVAkDQVTKJOg9TnXSM/4cVl5SOwBxvJo5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwiRSB/E; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7858a469aso13053345ad.2
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Feb 2024 16:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708042910; x=1708647710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idXyoR7ymQ5N4Hx5q/kb0YASa/LieROnmdW+IJsa4c8=;
        b=DwiRSB/EIBP5+zFKvlChxohmfJ98CSlUs7PTYlPqP3KSRd6AQEB/rOUygRBoOY8Vr3
         6ozXpEWrKi4z2xPWIA5ShwZv37nltKkai4LwfC2iWkYF5wg74zZz0nJuPB/Ygyv8iJdu
         DMzccdzPbuzF5Kpfq/nNrDrGf4zp77RgQAMgIlpcpp3v/3xyx+7B7yQOF/aQzfuRxGbC
         NYr0PRBkVP1iJD7+FrPKKJsREBTw7Hg94dLNsddoBNx99pTpusVr8csWR8Fyn2tmu9s7
         gv07KwjFH4LOp/xIhaNEfDTJL14BQB8QjI9x2mBUiyUgsXARNGyN73HL9gtPCr2W+SGx
         J61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708042910; x=1708647710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idXyoR7ymQ5N4Hx5q/kb0YASa/LieROnmdW+IJsa4c8=;
        b=u/BUlhHGtC6uEIkG3JMphtIITxSrreUVNA5WjJNzeWyP3GkfhfPj3Wm4bQWyHFLxFi
         k/w8sd0g4NO+jNbAydOguw/lMVHt8bALj4pd7QEPfIci6OM7XkltmTFp1kdpIYfy8PGv
         CrUCPr80bKr9vSuOpXsltNRURXxXfX6BP1g+vM9COqsSfDOlbZMDTOxg1MSwFW/3W+ap
         FCtpFRbpSpT/JjtV27Qf+uKyVzVKTolowYKcds73nyB4OR1DfOHVzef5KXdkyBRDJ8Lr
         cJUpxGHl6eyl51jQibjYSTfYG3MF/uR0I0Kmhz+6YA1ra+HAFtq9NQovOrO5nl0eapDv
         A+ZA==
X-Gm-Message-State: AOJu0YxxNdQfy+k/pI3UUzixsCsKAIuNVzjjctkynXhMCIZMiJK3iHsK
	ttJ7kQ65L/s1Oj8ZzkcR7J/6t23s7/muEfIWwVuB9noV08pKTCnBKVekTQRUJ1DZS2KIoxnofhX
	a4zxlPY9w1d5XYy8M9SpZavdX7Xu2ALJf2a0=
X-Google-Smtp-Source: AGHT+IGNTPY0S/9yHRPjJZl7KxNCN/lSFyM3dyV3CJD1nJcnyJW4ijX/2Om3nAaPOy9qdvxg3Z/M2Wl8WOv++/nJKpw=
X-Received: by 2002:a17:90b:1e47:b0:299:246a:869e with SMTP id
 pi7-20020a17090b1e4700b00299246a869emr2078161pjb.38.1708042909482; Thu, 15
 Feb 2024 16:21:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKb79g0cM38YmV7rqeoC1EpO9vU856Y8LH2Kh7zxT5frDFfZDA@mail.gmail.com>
 <d66eab3e-d6b7-466a-82e5-c153ed49ce9a@gmx.com>
In-Reply-To: <d66eab3e-d6b7-466a-82e5-c153ed49ce9a@gmx.com>
From: Kyle Smith <mr.kyle.smith@gmail.com>
Date: Thu, 15 Feb 2024 16:21:37 -0800
Message-ID: <CAKb79g1KrW2KVdZkThu6X26wMKTyErq-eT+r555H4kXCTGDa1w@mail.gmail.com>
Subject: Re: mounting causes errors after power loss
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 3:23=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/2/16 06:34, Kyle Smith =E5=86=99=E9=81=93:
> > Hello,
> >
> > I have noticed the occasional btrfs error after a hard power cycle and
> > wanted to get a better understanding of the issue. These errors only
> > happen after the btrfs partition is mounted, and running "btrfs check"
> > before mounting does not find any errors.
> >
> > I am using btrfs on Linux 5.10.176 on an encrypted LUKS2 partition on
> > an eMMC device. The LUKS2 partition is configured to allow-discards
> > and btrfs is mounted with  "-o acl,noatime,nodiratime,compress=3Dlzo".
> >
> > # uname -a
> > Linux (none) 5.10.176 #0 SMP PREEMPT Thu Apr 27 20:28:15 2023 aarch64 G=
NU/Linux
> >
> > # btrfs --version
> > btrfs-progs v6.0.1
> >
> > # btrfs fi show
> > Label: none  uuid: d90b7698-7ef5-4c1e-8365-b7631a6eafba
> >      Total devices 1 FS bytes used 92.16MiB
> >      devid    1 size 2.53GiB used 808.00MiB path /dev/mapper/luks-part
> >
> > # mount -t btrfs -o acl,noatime,nodiratime,compress=3Dlzo
> > /dev/mapper/luks-part /mnt/btrfs
> > [  185.443505] BTRFS: device fsid d90b7698-7ef5-4c1e-8365-b7631a6eafba
> > devid 1 transid 17201265 /dev/mapper/luks-part scanned by mount (2976)
> > [  185.455314] BTRFS info (device dm-0): flagging fs with big metadata =
feature
> > [  185.461689] BTRFS info (device dm-0): use lzo compression, level 0
> > [  185.467924] BTRFS info (device dm-0): using free space tree
> > [  185.473563] BTRFS info (device dm-0): has skinny extents
> > [  185.486490] BTRFS info (device dm-0): enabling ssd optimizations
> >
> > # btrfs fi df /mnt/btrfs
> > Data, single: total=3D280.00MiB, used=3D91.46MiB
> > System, DUP: total=3D8.00MiB, used=3D16.00KiB
> > Metadata, DUP: total=3D256.00MiB, used=3D704.00KiB
> > GlobalReserve, single: total=3D3.25MiB, used=3D0.00B
> >
> > Here is an example of the errors found by "btrfs check" after
> > mounting. These errors don't happen often but they are reproducible
> > and persistent.
> >
> > # btrfs check --mode=3Dlowmem --readonly -p /dev/mapper/luks-part
> > Opening filesystem to check...
> > Checking filesystem on /dev/mapper/luks-part
> > UUID: d90b7698-7ef5-4c1e-8365-b7631a6eafba
> > [1/7] checking root items                      (0:00:00 elapsed, 1456
> > items checked)
> > [2/7] checking extents                         (0:00:01 elapsed, 42
> > items checked)
> > [3/7] checking free space tree                 (0:00:00 elapsed, 5
> > items checked)
> > ERROR: root 5 INODE_ITEM[27535265] index 55000957 name .sharedContents
> > filetype 1 missing
> > ERROR: root 5 INODE_ITEM[27535266] index 55000959 name .sharedContents
> > filetype 1 missing
> > ERROR: root 5 DIR INODE [256] size 668 not equal to 698
>
> Those are all fixable by the latest btrfs-progs, so no big deal.
>
> Furthermore, this is not caused by some powerloss, but more like some
> older btrfs bugs.
> Or sometimes even memory bitflips (this need extra debugging to confirm).
>
> By all means, it's recommended to use kernel newer than v5.11 at least
> (thus recommended to go at least 5.15).

I'm currently using OpenWrt 22.03.5 which uses the 5.10 kernel, and I
am eventually going to move to OpenWrt 23.05 with the 5.15 kernel. In
the meantime, are there any btrfs patches that I should backport to
the 5.10 kernel? Is there any problem upgrading the kernel from 5.10
to 5.15 while btrfs has these errors? Would upgrading alone be enough
to fix these errors or is a "btrfs check --repair" required?

OpenWrt also provides btrfs-progs 6.0.1. Is this version new enough to
safely and reliably fix these errors? "btrfs check --repair" has been
successful everytime.

Please provide the debug steps to check for memory bitflips. The
system has been very stable so while I don't think this is a memory
issue it would be good to rule it out.

> > [4/7] checking fs roots                        (0:00:00 elapsed, 15
> > items checked)
> > ERROR: errors found in fs roots
> > found 96636928 bytes used, error(s) found
> > total csum bytes: 93652
> > total tree bytes: 737280
> > total fs tree bytes: 376832
> > total extent tree bytes: 147456
> > btree space waste bytes: 231395
> > file data blocks allocated: 95899648
> >   referenced 92807168
> > Command exited with non-zero status 1
> >
> > # btrfs check --readonly -p /dev/mapper/luks-part
> > Opening filesystem to check...
> > Checking filesystem on /dev/mapper/luks-part
> > UUID: d90b7698-7ef5-4c1e-8365-b7631a6eafba
> > [1/7] checking root items                      (0:00:00 elapsed, 1456
> > items checked)
> > [2/7] checking extents                         (0:00:00 elapsed, 54
> > items checked)
> > [3/7] checking free space tree                 (0:00:00 elapsed, 5
> > items checked)
> > root 5 inode 256 errors 200, dir isize wrong   (0:00:00 elapsed, 1
> > items checked)
> > root 5 inode 27535265 errors 1, no inode item
> >      unresolved ref dir 256 index 55000957 namelen 15 name
> > .sharedContents filetype 1 errors 5, no dir item, no inode ref
> > root 5 inode 27535266 errors 1, no inode item
> >      unresolved ref dir 256 index 55000959 namelen 15 name
> > .sharedContents filetype 1 errors 5, no dir item, no inode ref
> > [4/7] checking fs roots                        (0:00:00 elapsed, 22
> > items checked)
> > ERROR: errors found in fs roots
> > found 96636928 bytes used, error(s) found
> > total csum bytes: 93652
> > total tree bytes: 737280
> > total fs tree bytes: 376832
> > total extent tree bytes: 147456
> > btree space waste bytes: 231395
> > file data blocks allocated: 95899648
> >   referenced 92807168
> > Command exited with non-zero status 1
> >
> > Here is the "btrfs ins dump-tree" output of the above inodes.
> >
> > # btrfs ins dump-tree -t 5 /dev/mapper/luks-part | grep -A5 "(27535265 =
"
> >          location key (27535265 INODE_ITEM 0) type FILE
> >          transid 17119099 data_len 0 name_len 15
> >          name: .sharedContents
> >      item 62 key (256 DIR_INDEX 55000959) itemoff 13593 itemsize 45
> >          location key (27535266 INODE_ITEM 0) type FILE
> >          transid 17119099 data_len 0 name_len 15
> > # btrfs ins dump-tree -t 5 /dev/mapper/luks-part | grep -A5 "(27535266 =
"
> >          location key (27535266 INODE_ITEM 0) type FILE
> >          transid 17119099 data_len 0 name_len 15
> >          name: .sharedContents
> >      item 63 key (256 DIR_INDEX 55415388) itemoff 13545 itemsize 48
> >          location key (27743503 INODE_ITEM 0) type FILE
> >          transid 17188721 data_len 0 name_len 18
>
> Unfortunately the dump is not enough to confirm anything.
>
> Please try the following ones:
>
> # btrfs ins dump-tree -t /dev/mapper/luks-part | grep -A5 "(27535265
> DIR_INDEX 55000957)"
>
> # btrfs ins dump-tree -t /dev/mapper/luks-part | grep -A5 "(27535266
> DIR_INDEX 55000959)"
>
> After the direct match, there would be a line like:
>
>         location key (XXXX INODE_ITEM 0) type XXX
>
> Use that key to do such search again.

I wasn't able to find the  "(27535265 DIR_INDEX 55000957)" or
"(27535266 DIR_INDEX 55000959)"  strings in the dump. Here are the
lines matching any of those values. I get the same output with "-t 5"
or just removing the option. "-t" alone was throwing an error.

# btrfs ins dump-tree /dev/mapper/luks-part | grep -A3 -E
"27535265|55000957|27535266|55000959"
    item 61 key (256 DIR_INDEX 55000957) itemoff 13638 itemsize 45
        location key (27535265 INODE_ITEM 0) type FILE
        transid 17119099 data_len 0 name_len 15
        name: .sharedContents
    item 62 key (256 DIR_INDEX 55000959) itemoff 13593 itemsize 45
        location key (27535266 INODE_ITEM 0) type FILE
        transid 17119099 data_len 0 name_len 15
        name: .sharedContents
    item 63 key (256 DIR_INDEX 55415388) itemoff 13545 itemsize 48

I see these two "location key" lines but no new key values to search
for. Should I be looking for something else?

        location key (27535265 INODE_ITEM 0) type FILE
        location key (27535266 INODE_ITEM 0) type FILE

> >
> > Is this a known issue with btrfs and power loss? Running "btrfs check
> > --repair" can fix this issue but I would like to prevent it in the
> > first place. This issue looks similar to the one in a previous message
> > on this list, "Filesystem inconsistency on power cycle" [0].
>
> The power loss is only going to cause problem if your disk are not
> properly handling flush (VBox and VMware seems to do that).
> And if your disks (from the lower LUKS layer, until the disk firmwares)
> are not doing flushing correctly, it's going to cause transid mismatch,
> not the same symptom.
>
> For your case, it's completely unrelated, but I'd like more dump to make
> sure it's not some weird memory bitflip.

This is good to know. Can I rule out the lower LUKS layer and the disk
firmware since I'm not seeing a transid mismatch? These btrfs errors
are the only problems I've had with LUKS2 on eMMC.

Please let me know about backporting any relevant btrfs patches or
debugging a possible memory bitflip.

Thank you for your quick help.


Kyle

> Thanks,
> Qu
>
> >
> >
> > Thank you,
> > Kyle
> >
> > [0]: https://lore.kernel.org/linux-btrfs/CA+XNQ=3DixcfB1_CXHf5azsB4gX87=
vvdmei+fxv5dj4K_4=3DH1=3Dag@mail.gmail.com/
> >

