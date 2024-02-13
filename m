Return-Path: <linux-btrfs+bounces-2357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638148539E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 19:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C5FB28621
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4391C60B85;
	Tue, 13 Feb 2024 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="F5PmPeDg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C460B80
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848786; cv=none; b=JL6P29QeXwgpj9dYejYXGnFVlNZFK4m/bJr3ne9/b1Zz+Ld+l8SMu6DlOAxFJjbTmDG4wcwunIatxx7jgfl0iKH/XIXvT04/YEJBd62TDu8HbZQT/9Z/+sNULClkRuUPY0xkjXthyMCBud6rFOoewYoDNCzBeGECiaEzf2PtZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848786; c=relaxed/simple;
	bh=Y5s41XdRBkRn/kvX0K964rWSGwNgAlSd8s2xffmO4Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmX3BR+EZczD8di7L50p4SNRU/opUyXDbJqTSkCE3bimW9HbDFXt8ttz10Nx8KNaTWNJpOmJyMhNoIIt8DX8NltuO+zU+1G821tSYENQZfs6rd6H4Uw9H5f2lZ8bZzFelbyPUvr4j76lsYv2u7HkVRy1mWtMFvVZeSx1/nGUvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=F5PmPeDg; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-785d93d3f08so144604685a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 10:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1707848783; x=1708453583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObJc2CGlbwgCtv//bX1BN89zaOEhe15WRZob3EObMKM=;
        b=F5PmPeDgoneH5avZR7jSvvjAJUm4W8exZpT1I2GBchU7R3M1hvTvlWIf+w6U+lojr+
         WCw6TpA6MKXDWqkzycJWAc8oQ/Cs8N0HQElhAuhvgNS6PrD9y4S6eB/T/QWMuKCyo9gM
         Nt9DfYmKOIybg+YeFTdjuocoHMN+YVVvxXnZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848783; x=1708453583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObJc2CGlbwgCtv//bX1BN89zaOEhe15WRZob3EObMKM=;
        b=q69PWK7/M4PqH82Xo2C4ZYlGzjSGuVp5Ef/GAuie9seZR54zlyQbkPhbz78SAKPL1Y
         suRTgF6I87nTrvmIRjsT6UiaNHjYzaiCQNy3mTA0aLuP8p4nR8+zFqcO01G6SjctHPxh
         3CbblZde+zgeD0FuflX3jU5OpJMLCA0L5px8DTIP7P7KDc9qhgPB2yCjfojk67lqsP9U
         3NAUs75DO5F6NdV/1fUHOU+0RtV4khIExXYarho8dWUoKEvsdLaXubDvDS2Aj+YovezN
         DBvlmWT8LUlxr2lnobZSxtxX8Jqm0Q8M7KhNjGQ3fRzlt22/Gb6A4RO2WUVr4szKOat6
         B1Hw==
X-Gm-Message-State: AOJu0Ywb+yhioddp+1yh4ygQbLGBG6L06pWnMJ6bRBTPGIFujW/LBjyg
	t5/QpHU8s8bsNtPsF39GuDDb9jRnXKzzT7qGF71YUL4ERpmAXsZ+N8aO7FRtinBy//nRru4iDYK
	54GKWKLa4sWCntWfMbwu9bKHXzTqpo3gK8H4=
X-Google-Smtp-Source: AGHT+IHGPWdX5D74j2GtVCvHT2jR5uux7W46+Aa5Sr39kqRPBTJRQpb9WuLn17R99ABy4CknZ7zJTdaQC6Rva+gxg2c=
X-Received: by 2002:a0c:dc05:0:b0:68c:8a21:2de6 with SMTP id
 s5-20020a0cdc05000000b0068c8a212de6mr254659qvk.57.1707848783632; Tue, 13 Feb
 2024 10:26:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8932de78-729c-431a-b371-a858e986066d@gmx.com> <20240206201247.4120-1-tavianator@tavianator.com>
 <60724d87-293d-495f-92ed-80032dab5c47@gmx.com> <CABg4E-=A+Ga2RtTW4tdJUhTQSNtg3HAvSYmGQaoPKJ-qh-UVJA@mail.gmail.com>
 <2cddff2a-ac98-44b3-a689-3f640d0e4427@gmx.com> <CABg4E-kqfkX3nyVdcSsgucmcxdcJRMfH+ahVBR+bYXJyd0y53g@mail.gmail.com>
In-Reply-To: <CABg4E-kqfkX3nyVdcSsgucmcxdcJRMfH+ahVBR+bYXJyd0y53g@mail.gmail.com>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Tue, 13 Feb 2024 13:26:12 -0500
Message-ID: <CABg4E-=AP9UXSzGh7a6Jw8FtC6RW6mNSuvaGpcL576buaCetOg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit
 something wrong
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 1:07=E2=80=AFPM Tavian Barnes <tavianator@tavianato=
r.com> wrote:
> I tried to bisect but I don't know where to start from.  It still
> reproduces all the way back to v6.5, although with a different splat:

Oh I missed part of the splat:

      general protection fault, probably for non-canonical address
0x7f99872a6b80f0: 0000 [#1] PREEMPT SMP NOPTI
      BTRFS critical (device dm-3): corrupted node, root=3D518
block=3D16000637395156534217 owner mismatch, have 12049901028372027545
expect [256, 18446744073709551360]
      CPU: 47 PID: 3729 Comm: iou-wrk-3310 Not tainted 6.5.0-euclean
#10 4197dfd21e86f976fbd69cbd6a56016cf20d42e1
      Hardware name: Micro-Star International Co., Ltd. MS-7C60/TRX40
PRO WIFI (MS-7C60), BIOS 2.80 05/17/2022
>     RIP: 0010:btrfs_bin_search+0xd7/0x1d0 [btrfs]
>     ...

Normally I would suspect bad RAM for something like this, but I have
ECC memory and no reports of corrected errors.  0x7f99872a6b80f0
doesn't look like a single bit flip either.  I'm leaning towards it
being a race condition somewhere.

I'll run memtest anyway just to be sure.  I already ran btrfs check
with no errors.

--=20
Tavian Barnes

