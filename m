Return-Path: <linux-btrfs+bounces-7121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3421394EC1E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 13:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561361C21636
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 11:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FBE17836D;
	Mon, 12 Aug 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCz1JIeR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C79170A1D
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463489; cv=none; b=EpuDpAPBovAOK92lER1mBQ8hw1qA0owL2c2hbJbe4nb2yEplGl9KL1JI+yl8WqhccxodpxOaqMqEkgZMc9QiXfvvillcDqjf3SpTN8KdupeCwVnLlqjoxx2rEDBTQX/U5AtxSuCPlKRfZFiVzzqG/6kdsDnTw5SN9hV8g05LgPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463489; c=relaxed/simple;
	bh=fnNfnJLhvhvDdaj1LcNMDKJueFf8FD6zpw2NrVJuqsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4zvyoV+bVFZBaPBTSgloNd5ZNBlFkI4apD+9BlczVSmPY0cdHINdHn2aQCWx28GnzGc7Q02VnUtWMM6GhXWITglltKDYc4pEtiKjC+IwIPAbp9R/Q+1ujuC2jKoztQjtRXh8fTiHNtDxe1ewhe6cat5gjpuOSjNomlBnUwAYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCz1JIeR; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db12a2f530so3138338b6e.1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 04:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723463486; x=1724068286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+acfznexGVt8MTrQReOWXN3FuhRcpwgSyorPEoPfE8=;
        b=kCz1JIeRUohbS+7W3gVCkMdrytr1Qfx6+vRHfR2CydDa/2CpzXxt0gbm0Byjb1UXer
         cE7YEn8+mokAvTzj/AR+EHjJfhfWXtM2peQpbtHsgGfW/CHBHkBfGQ3IPadg01FjpoTu
         xe0tKquxqXgBPiGXbVTdZYZ0CACsBgb93LNMzDOVyat9b4NfUM5gHJg2/Qh5b1+UiyU/
         Kdf36zgt66kwdtzNcBP4mnUAp5t1gwM+DrksbamINCMoH1ZA9iMO93it9i88XZ6x/1yC
         UXN416LQVH4oxVh6PA3yVLxFGSUef1EztoCZU4Nr5wGyEfEfq1sPurAcOEXJsdGVPCPp
         EAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723463486; x=1724068286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+acfznexGVt8MTrQReOWXN3FuhRcpwgSyorPEoPfE8=;
        b=j3j5XT1xJF4lInh+2TBG/loBKo6K3d4LzDgHpC7Jn70HpPcaMrCXd6UBu0q9WI3yE2
         PMdmRRwfCzwEAGjc92PwAE2b8t7hLz2Yvy54PdDO17Z6Riaeg9XR7AgKxacxNf+pdIR/
         WABPu7Wh5L8m+QjkxmN5w5dpgYALwrbyjMnWTBDYKi8gltzaecj7Y9YRPBWXMtk5e68X
         QjAYUgbt2PzWabkLa109GgrhNPKAZ5lFw5qtJaUS8IOwa+qHj9XAFT2N3Wh+Un/ttlFR
         QorlqSoGv9YN8n2jjKakDp5hNXqrXBnChY8TtMK2cGVk1mOkLJwYJ9WMjxNOzPXF4j1t
         RdsA==
X-Forwarded-Encrypted: i=1; AJvYcCVgNyiF1ZbZEA/xDBGKYExrsbwi8RqSHGM0/PANiP4bCtSJWzKnIbHhmdHS9k1jPgb8ZkAMPJeK7xKEdG8tmr2vfab4cNO4yuaW+K8=
X-Gm-Message-State: AOJu0YylOOn7cZcmh8mx6keG8ZmoZDU71OOcI688MiIdG5J+wAvaeOMw
	r15RsDrLAqT6g4v480z7W8P3yb8c9fWoZbc7d2vVuPakjL/j0Uy8Nj30BPcO+6dgscUOM8AGE9S
	Sb7ivgg0j+iB1R8At7kRMtG717Ko=
X-Google-Smtp-Source: AGHT+IHtnkms9YDMMsQvF7QeFhKOjF5ysyE4YXy7vjWxMH8v7W8TzhG25UMY6vfYOtQHYseJxQSAHap7Jn8J+AiEI5o=
X-Received: by 2002:a05:6808:14c4:b0:3d2:1b8a:be32 with SMTP id
 5614622812f47-3dc417102c4mr11621566b6e.42.1723463486370; Mon, 12 Aug 2024
 04:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+W5K0rSO3koYTo=nzxxTm1-Pdu1HYgVxEpgJ=aGc7d=E8mGEg@mail.gmail.com>
 <ac2ff9ae-b2fa-49df-9ce3-fc32ddd3c222@gmx.com> <CA+W5K0qUAXYSZFxJv+vVM+knFkXm+VK61zOb2qF6TXmW156LOA@mail.gmail.com>
 <7bc8aa3b-f5c1-4db5-b588-4332af4bdda6@suse.com>
In-Reply-To: <7bc8aa3b-f5c1-4db5-b588-4332af4bdda6@suse.com>
From: Stefan N <stefannnau@gmail.com>
Date: Mon, 12 Aug 2024 21:21:15 +0930
Message-ID: <CA+W5K0qW5x-V2LR0FoJMueAeG9P-VNnKJ5C=ObCvEVVKwwXagA@mail.gmail.com>
Subject: Re: Help! Unmountable due to dev extent overlap
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Aug 2024 at 17:05, Qu Wenruo <wqu@suse.com> wrote:
>
> =E5=9C=A8 2024/8/12 16:30, Stefan N =E5=86=99=E9=81=93:
> [...]
> > dumptrees stdout is 50mb bzipped for all devices (no output to
> > stderr), so have uploaded to https://filebin.net/92cnqpr9xx9565oe
> >  From this output, sda (devid 4) and sdm (devid 13) are the two that
> > btrfs check is complaining about
>
> Oh, forgot to mention, dump-tree output is always per-fs, no need to do
> it for each device, as the result will be the same.
>
> [...]
> >
> > # btrfs check --mode lowmem /dev/sdb
> > [1/7] checking root items
> > [2/7] checking extents
> > ERROR: dev extent devid 4 offset 14263979671552 len 6488064 overlap
> > with previous dev extent end 14263980982272
> > ERROR: dev extent devid 13 offset 2257707008000 len 6488064 overlap
> > with previous dev extent end 2257707270144
> > ERROR: errors found in extent allocation tree or chunk allocation
>
> This matches the result from the tree dump.
>
> Only device extents are overlapping, but still matches the corresponding
> chunk items.
>
> For the devid 4's result, there is no direct bitflip indication.
>
> But for the devid 13's, it's a bitflip, and I guess the bitflip happens
> during the free extent lookup routine:
>
> hex(2257707270144) =3D 0x20da9d70000
> hex(2257707008000) =3D 0x20da9d30000
> diff               =3D 0x00000040000
>
> So my guess is, at least for dev 13, during a dev-extent lookup routine
> called for chunk creation, bitflip happened for the lookup of the last
> dev-extent's end (should be 0x20da9d70000, but one bit flipped from 1 to
> 0), causing btrfs to use the corrupted value for the new device extent.
>
> > [3/7] checking free space tree
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs done with fs roots in lowmem mode, skipping
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > Opening filesystem to check...
> > Checking filesystem on /dev/sdb
> > UUID: 3cde0d85-f53e-4db6-ac2c-a0e6528c5ced
> > found 104088092352512 bytes used, error(s) found
> > total csum bytes: 101533362472
> > total tree bytes: 117929181184
> > total fs tree bytes: 1742323712
> > total extent tree bytes: 1548320768
> > btree space waste bytes: 11865883351
> > file data blocks allocated: 139229426343936
> >   referenced 139218099167232
> >
> >>> # uname -a
> >>> Linux mynas.x.y.z 6.8.0-39-generic #39-Ubuntu SMP PREEMPT_DYNAMIC Fri
> >>> Jul  5 21:49:14 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
> >>
> >> I guess your NAS is running this newer kernel even before the first
> >> warning? Or is there any older kernel involved?
> >
> > last reports that this 6.8.0-39 kernel (Ubuntu noble) was active from
> > 30 Jul, I recall I did a release upgrade a few days after the replace,
> > so yes the errors all occurred while running this kernel. Prior to
> > this, it appears to have been running 6.5.0-44-generic and earlier 6.5
> > releases for 9 months (Ubuntu mantic).
>
> OK we can rule out older kernels.
>
> >
> >> A quick glance into the tree-checker shows that we do not have any
> >> checks on dev extent items.
> >> And I guess that's why we didn't detect the corruption in the first an=
d
> >> let the corruption sneak in and written the corrupted one onto disk.
> >>
> >> But my current guess is, it looks possible some kind of bitflip sneaks=
 in.
> >>
> >> Just to be sure, after taking the dumps, please run a memtest just in =
case.
> >
> > I've got memtest86+ running now to confirm, will confirm the output
> > next response
>
> Waiting for your result, and I bet it will find something.

3 passes on memtest and no errors!

This is an old filesystem though that has been going for several
years, is it possible this issue has been there for a while
undetected? It's been through several out of space data/metadata
consistency issues over the years and I had believed scrubbing had
resolved these, is it possible that these errors combined with the
scrub not verifying the metadata caused the issues today? Or given the
bit flip, do you still think it's more likely to be memory? There's
been no other symptoms but it is non-ECC..

> And I have already submitted a patch to detect the corruption and
> prevent it from corrupting the on-disk data in the future.
>
> Unfortunately I have no idea how to fix your fs at all...
>
> The overlapping can indeed lead to data corruption (since the
> overlapping dev-extents will be overwritten eventually from two
> different data chunks).
>
> And since their chunk items are completely valid, I can not simply craft
> a dirty fix to modify the value of that dev-extent, as that will cause
> problems for dev-extent verification against chunks.
>
> And if I need to modify the chunk items, it's going to cause a chain
> reaction to modify all the other dev-extents and dev items and superblock=
s.
>
> So I can only recommend to backing up your data (may hit EIO if unlucky
> enough), and rebuild the whole fs.

How can I best mount the filesystem to recover what data I can? So far
I haven't mounted it at all, the ro flag isn't sufficient to bypass
the error.

> At least your sacrifice will be remembered in the kernel git log forever.=
..
>
> Thanks,
> Qu
> >
> >> Thanks,
> >> Qu
> >

