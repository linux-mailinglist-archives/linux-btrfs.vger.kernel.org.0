Return-Path: <linux-btrfs+bounces-7920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E805B974A79
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 08:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46DB2884B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 06:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE11C7DA88;
	Wed, 11 Sep 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDJwUsvf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8844A2BAE3
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726036847; cv=none; b=Fa1bPyIUPmfVYcM5/lWmhoXexE+y6Ex9ztIZrhI/Nv/oi3EaC/19DvuL/yKV7mqOHl5NJW9WewnhJROpOxVsc+hRnL3hTHTaelAhcXRX3KyOT0xRu6SIPTqq73ZrsSyiPeuHwzvEHXu2zpBlYweBWQNxrIdp43+SeMuMT/9y1w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726036847; c=relaxed/simple;
	bh=LCF95sgRscJhuMTL4dg5NP9s6yywyw4rpB61JVLDIqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1Jk7MTTm5oaSbe0HdqEyWakFIt/glDDxtNOQj88fdeW1GloVUiPcaJXJLSj56Kg24gg1ZdgoTI/IAra0ZA9/97sNMmPWvLJ/rwupSZO/mDubzQiVWNUXgOFy81Z/3Bb76xxGogpWaw2FbSa3OiGUEsFQ35qFTaT9FmH9BfB3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDJwUsvf; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9a23fc16fso162504685a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 23:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726036844; x=1726641644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6M5TsgLQM7R6di1l21KUw5PDVp7qq8WzPqIK4QTnv70=;
        b=iDJwUsvfPOn5CnrC1Q+XaUnXShoi/dqQFQxf2YjLTe7lAf4Rmev35DFZNjW8rlUe+c
         nqdCQjZLinSltbofGsBMlh2aFc5sBL9SLrklkmh44zpqGfgo59BLoPWMYTPYCk91ru8+
         YQyMb5S1aSynx7Z4gb+Hfn5sktnaDxihQ3V8c2pYwL8uX7knUAJ4rtHgr5AYCbTCnw3t
         8iPKTQhb04Lb4bM4LMwVLjAmbu9saUnQkwQ7/Fy+pwBAtjUY+4AlNw0RoOryfpV4Z1eT
         sSsMFqJnRUMdhs0bnU2VcSXOAd1qGSmcrPC65bC4UbiM2hjxSRHCUO3yeEuLxyNBmp0R
         3siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726036844; x=1726641644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6M5TsgLQM7R6di1l21KUw5PDVp7qq8WzPqIK4QTnv70=;
        b=Z0KSYKpNvdZ6GYOqFcv0MLZoCB+xy00mhxti600wEs2xIQ9nzH7L37FgqzbYqhCxoe
         FuN8odPHqfGNQgUJ7jqHin3YjTPykicmFiBv1SA7For/eXiYKp0VrfdevUvzSJ9BuSWj
         i10+FHKZ8pyt+PHTHfXyhz6HTdGmQdHCu0EpZcreL+iUHFbdRv9XclCL3NRufUNU+e8u
         /bRZZFOfFcfl2QxjOw7mCSGy8rpmmojQ/+KGJSR0HZYr3KcpaJpINToSH/EbB6+MjVgU
         cy2rT2POcH6yOHzZYvitYOR7qiLVuOh8mpK+K67+hZRcCtAt+CMV+L5siVTXSplQsAYh
         s3ag==
X-Gm-Message-State: AOJu0YzZDuGYn3fYrIJLhE9SXGxTTtddiQu9xIpVc8jXWbupvBQNhNQo
	i7mhLzrICoUBlcIjP5T1XZbXCgSupkggvPNsrkp7jax4vsbYEIGVQnVXUhsN1aUFitlCgK6jGGR
	VSoppz6+xmKTJ/6SFt3g1XCpf5/0=
X-Google-Smtp-Source: AGHT+IEYnizhYCDQKRhvoL/DGxsXHIA+cfbWL9GcIYm+pDi7YwfpgjxfrENJgGO7yV0HtuV+mKDTjvIEozB9+Gmw2Rc=
X-Received: by 2002:a05:620a:2717:b0:7a9:b7c7:ad4c with SMTP id
 af79cd13be357-7a9d3d7ffebmr325282985a.58.1726036844320; Tue, 10 Sep 2024
 23:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
 <89131a4f-5362-4002-9a55-d1a24428ef05@gmx.com>
In-Reply-To: <89131a4f-5362-4002-9a55-d1a24428ef05@gmx.com>
From: Neil Parton <njparton@gmail.com>
Date: Wed, 11 Sep 2024 07:40:34 +0100
Message-ID: <CAAYHqBZ+-3GbDmQFGxMcYs3HpO-DUQA4pCG0xqWMZW+sbw-KJg@mail.gmail.com>
Subject: Re: Tree corruption
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

btrfs ins dump-tree -b 333413935558656 /dev/sda
btrfs-progs v6.10.1
checksum verify failed on 333413935558656 wanted 0x00000000 found 0xbd640a7=
9
checksum verify failed on 333413935558656 wanted 0x00000000 found 0xbd640a7=
9
ERROR: failed to read tree block 333413935558656

On Tue, 10 Sept 2024 at 22:30, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2024/9/11 02:38, Neil Parton =E5=86=99=E9=81=93:
> > Arch LTS system (kernel 6.6.50)
> >
> > Cannot mount a raid1 (data) raid1c3 (metadata) array made up of 4
> > drives as I'm getting corrupt leaf and read time tree block corruption
> > errors.
> >
> > mount -o recovery /dev/sda /mountpoint   didn't help
> >
> > If I blank the log on what seems to be the affected drive I can get it
> > to mount but it will give out the same errors after a few sec and turn
> > the file system read only.
> >
> > If I pull the affected drive and mount degraded I get the same errors
> > from another drive.
> >
> > Trying to work out if I'm shafted or if there are steps I can take to r=
epair.
> >
> > Critical data is backed up off site but I also have a tonne of
> > non-critical data that will take me weeks to re-establish so nuking
> > not my preferred option.
> >
> > I've managed to ssh in and here are some lines from dmesg:
> >
> > [   14.997524] BTRFS info (device sda): using free space tree
> > [   22.987814] BTRFS info (device sda): checking UUID tree
> > [  195.130484] BTRFS error (device sda): read time tree block
> > corruption detected on logical 333654787489792 mirror 2
> > [  195.149862] BTRFS error (device sda): read time tree block
> > corruption detected on logical 333654787489792 mirror 1
> > [  195.159188] BTRFS error (device sda): read time tree block
> > corruption detected on logical 333654787489792 mirror 3
> >
> > [  195.128789] BTRFS critical (device sda): corrupt leaf:
> > block=3D333654787489792 slot=3D110 extent bytenr=3D333413935558656 len=
=3D65536
> > invalid data ref objectid value 2543
> > [  195.148076] BTRFS critical (device sda): corrupt leaf:
> > block=3D333654787489792 slot=3D110 extent bytenr=3D333413935558656 len=
=3D65536
> > invalid data ref objectid value 2543
> > [  195.157375] BTRFS critical (device sda): corrupt leaf:
> > block=3D333654787489792 slot=3D110 extent bytenr=3D333413935558656 len=
=3D65536
> > invalid data ref objectid value 2543
>
> `btrfs ins dump-tree -b 333413935558656 /dev/sda` output please.
>
> Thanks,
> Qu
> >
> > advice needed please
> >

