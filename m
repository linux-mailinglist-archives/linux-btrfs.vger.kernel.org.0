Return-Path: <linux-btrfs+bounces-1565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA3832402
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 05:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C48DB22788
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 04:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFF44A12;
	Fri, 19 Jan 2024 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhd9TjEo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314846AD
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jan 2024 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705637284; cv=none; b=u2CGdTzW9+8mwoFTqgmZnLdGI07v8Vf0dd3kLpuFBb23Diae1VdC+N9MG/KgWwFCGLG3UN2FKsq3rKBEojKRZrglsM+Q5PM2jwGrM/QMdG18BtSRGxranrtoTGCFBt5P6YuSGmqoGY4MAEFpTwxYFD733+FEzrFZQMF0Mu/S+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705637284; c=relaxed/simple;
	bh=Y6RAKsBFbtKyzrBbZ4EsCm/TQ42GbuSW3tSuDrTniss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ioBOQtjyXbgvJWZ7gYDw8ZVVVY0TZ+fn80BgW6dD+g83IW4ffPNxTDxEGavzb3WhkE+Csu9BsvsD+cOtgWakXV1eZGvHfxDYEzTmqJvoSVpGBI6/ZJoWP1ET96i2oErYBSF67iloMyUO7AwTnCICrJXLUt974OEAM8ONO/Uf8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhd9TjEo; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cf495b46caso220053a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 20:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705637282; x=1706242082; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6RAKsBFbtKyzrBbZ4EsCm/TQ42GbuSW3tSuDrTniss=;
        b=fhd9TjEoaO+6mEzBeUjj8yWICljKsTejUyfcGOEqe9GjzmU5qk8wtQWcf/A3GXELh2
         r9O4kaXaQKDBcleK7IMYyzLZ4ArwYsUJiiqxhZ4QPESNdHmIdoQ+oYs4p7MTAVEkWdhy
         GSKRgh3Q82Grr4JEsm/sEtKTq+kCEDvAsQQRmXWbpwLDZlIuojUgDrtGP+nr/aNGsm/i
         Zlv3U0/y67600dBucC9TxzaCqACagUJjP3X35y8ut2HgsHkPYvGD0hVBXbigCqpWm52o
         Uz7shuiSYAHM7CUcXLlvPbf4Lid4/4tsIleQa+s1Gwnqm7MeOF1vEC9ywKnYrlkdBg9z
         4dwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705637282; x=1706242082;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6RAKsBFbtKyzrBbZ4EsCm/TQ42GbuSW3tSuDrTniss=;
        b=nMpAjq1OvCYFzkwilSjszsQYAjrikJ30nnIhhMRqMFWhboH1MEWzN4L67tfrHkOBVR
         lOm5umiBvPtxk2moT3fM4UlwhBkfw49ynbagQ6iUZW9Fo8G1ruWTvWVzUcLKjelGC5zE
         BbY2pC1A6fjw75eDr0J7EhNgudtUFOrS5vjiMi6MTMoxG0W41Wl0vQwWTw6CPzl7Bsv9
         i2D81ZYEugomxpiwe2hc7OltmeZyBW5Yo5E7FLD76rYP3iLhEvI/FpmPl0eoebf5nZEL
         js0R9p3suuwt6Af6CMd8MXWVk30oE8NubtY55szgH/x3aEdikBhstWCVwXh/UvZPo9es
         25eg==
X-Gm-Message-State: AOJu0Yx3pfGaZ7G/R9ozgWUehRdLmaRelmBFLZEqmKC8C/N9XXB440m/
	x1c5jOU18MFyFIKW2t/tmQ+UVFO+CLBymJf43q78m+B8sd2SLvZfVnW5cXx/fPuFCulaefEKP7u
	VKjEyNNvEgOJYU4giFv6DXZDq6PqXyejT
X-Google-Smtp-Source: AGHT+IEU0/htQ/EM4ts5ij2UzTlfoBVo3MBCAxpJW3CHpYr/pjl9qOkCo8haoL2ejSTtvtzJ+KlWZofTTzGVoDBRSkA=
X-Received: by 2002:a17:90a:d301:b0:28f:423f:1d05 with SMTP id
 p1-20020a17090ad30100b0028f423f1d05mr1516925pju.22.1705637282277; Thu, 18 Jan
 2024 20:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+XNQ=j6re4bhRDUebzPLDvMtZecqtx+GRRPgpd9apss+vOaBg@mail.gmail.com>
In-Reply-To: <CA+XNQ=j6re4bhRDUebzPLDvMtZecqtx+GRRPgpd9apss+vOaBg@mail.gmail.com>
From: Gowtham <trgowtham123@gmail.com>
Date: Fri, 19 Jan 2024 09:37:50 +0530
Message-ID: <CA+XNQ=hGxYsMAo6Gc+Up5QctbWjkER17uK97YXWc9uyx_7+3uw@mail.gmail.com>
Subject: Re: Disk write deterioration in 5.x kernel
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Is there anything I can collect to debug what is the problem in the new ker=
nel?

Regards,
Gowtham

On Tue, Jan 16, 2024 at 11:21=E2=80=AFAM Gowtham <trgowtham123@gmail.com> w=
rote:
>
> Hi
>
> We use BTRFS as a root filesystem and have recently upgraded our
> servers from Ubuntu 16.04 to 20.04 (from 4.15.0-36 linux kernel to
> 5.4.0-137). Post that we see a deterioration in the disk write speeds
>
> # dd if=3D/dev/zero of=3D/var/nvOS/log/dd.img bs=3D1G count=3D2 oflag=3Dd=
sync;date
> 2+0 records in
> 2+0 records out
> 2147483648 bytes (2.1 GB, 2.0 GiB) copied, 2.72458 s, 788 MB/s
>
> vs
>
> # dd if=3D/dev/zero of=3D/var/nvOS/log/dd.img bs=3D1G count=3D2 oflag=3Dd=
sync;date
> 2+0 records in
> 2+0 records out
> 2147483648 bytes (2.1 GB, 2.0 GiB) copied, 3.11866 s, 689 MB/s
>
> # btrfs --version
> btrfs-progs v5.4.1
>
> BTRFS options
> rw,noatime,compress=3Dlzo,ssd,flushoncommit,space_cache,subvolid=3D269,su=
bvol=3D
>
> On average we see 10-15% slower speeds on 20.04 when compared with
> 16.04. And this data has been recorded from different systems and
> different types of SSD.
>
> Are there any known enhancements in BTRFS that can affect the write speed=
s?
>
> Regards,
> Gowtham

