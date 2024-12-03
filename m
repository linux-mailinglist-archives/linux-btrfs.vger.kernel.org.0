Return-Path: <linux-btrfs+bounces-10018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E8C9E13BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 08:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058FE164491
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 07:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E70189F56;
	Tue,  3 Dec 2024 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAI9YJr8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98142AA3;
	Tue,  3 Dec 2024 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733209744; cv=none; b=FVMKbZzUIF0wavv/l5CRdtgICS5ye6pNFu0B+HN1fHOj6DpEehM+b/6aI8uWI6ExRZU5o7vilnv7r8xouHzwTdtBMBtweOcmKRyb2KNaxshMDnYJTOKL1B3ZimmhPo/3iHEu/q+QUKEsNiY4VMTf4Eure80/92FywM31mNvdEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733209744; c=relaxed/simple;
	bh=LjSURVKP1ndSn064bpc11n7MVWZaepXqpN0kFdE6CEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0Bj29tzTqvNFPLOrs8CF7UqJIbyg8sCTzvmbehsWETfC7EjIph3o3VuUPLq6Fn2Hl36EM+ifYYr/cqupqQ5nb/D+NcLKcPPBGl8MwyBJHZUZ1XcdKNnGqxeYpQPvqQxsePMU9sHM05Ttsod8hT0woiAO9chZTKpVHCOuGdZnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAI9YJr8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso2036300a91.1;
        Mon, 02 Dec 2024 23:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733209742; x=1733814542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tN8RvTSNJ77BxP7aNU9oyJmnuomj8CAUum0N9RHjg6M=;
        b=AAI9YJr8oNCpAjV2rLZxMXMhuJEHec+RpgRBl2uVzbHwmPDd9zUt7B+qwtKJ7P+zOt
         S3msk1GGE+R5tkdfOJ/K9g5iae16ohJufITTp6koH+FS19S4gjm/oADiA+Gr3XLRjOKf
         db149kEgiafrNO2xoatYmAVFNWygb2SP8lhqjf9xpU1kcto2R3ZKJvRouJplW3WA5W+5
         pzEDwAtZygMf7AlmCy/yED3+w9aTF4QgZlLlU3wXoIiqxajf+PQ5bYoI+LAcTd3qJ96O
         aeLPMlvg/lgWactstuk8jGYH9rO+/ZFedUH6/aRVd4h1MTiGlVGRPbvWLOulP50q1Opq
         JkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733209742; x=1733814542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tN8RvTSNJ77BxP7aNU9oyJmnuomj8CAUum0N9RHjg6M=;
        b=nfnMvDUWIy9IyTuHf1wJSaqM33m8yPzSM+jwqnVoWxBUu2ttmwiCaYxVsqvb9yIAaz
         Rx2XIgNPB6f1cUIgMy/kivo/9IMmqf/hPHMB+xSLsbBzHQm1bcwCRanou/0RBStdu7+5
         i1bT5Yymm41hQGjXsKgFUNSrPPKPuxefX1Yh92Lo2dDCdC+r9KSZY2zTeAeUbrC8NLGj
         T66effaK2hI0fTamXGb/3RQ0E7Qc6gOlT8kcI015ZEA97dD8ghIvKEYHgMEQbvgaSPaU
         SodUTOeF6tNms7pOBpDn2aXo3295rEu+ZDVjIvjT/J/VKz04qsr+6RmWAeYbjBTvM0z0
         uATQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwudYCj4kwUSbRhWl7mHQXOt27w4ArrqSmk/88D+aN7Gxf047/QoyrxShP2Rph1GIm1xjdJfhHpP2e5w==@vger.kernel.org, AJvYcCVaOo9Un4NuEWICIiZPLAYRKVK/JbW6LMqGvwIiknrYXrO5uG+zwugg0Nn8fAy03PjyX8frLmVjiT547Owu@vger.kernel.org
X-Gm-Message-State: AOJu0YyxYUXedy+hgb6F7d+ZvLn0TQPiKSpwmcvx7wedF2bsDl66jLZb
	e4caTiy69vDHAE/QXmdS9E84DcE7r9abJ+d7KboFv0l9V3+pgc4ka4VbR624/Gya8lElVLAPlTR
	0fo4TM/tdCSrtRow5DG0upoG8GYA=
X-Gm-Gg: ASbGncuX0oa6VNt58j44MB5kLZh8fmQKGDtCOHZBOXsEJHQXtg0DS9wVKdmNUfglykN
	9eSX06jQSAAaHDoRdgtCj0Etblym00vwF
X-Google-Smtp-Source: AGHT+IG7iIrgIOozrTQ2WIDeOgwlgF3yEAmk34/z++g6ioXUsRSSTL7EwRCTPGMRwf2mBMybQZY0giWeqJEMfY9BjQU=
X-Received: by 2002:a17:90b:3949:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2ef011e6a98mr2046298a91.5.1733209741921; Mon, 02 Dec 2024
 23:09:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H5U_88NA2PmyMvtwv1aZ7k+V6v=eetp7Hs2HqDdfVjokw@mail.gmail.com>
 <20241202133515.92286-1-zhenghaoran154@gmail.com> <CAL3q7H7dxA+Y30XbB1nng1duaoT8c9Pf4ZG6+iwikTGvb4cAXA@mail.gmail.com>
In-Reply-To: <CAL3q7H7dxA+Y30XbB1nng1duaoT8c9Pf4ZG6+iwikTGvb4cAXA@mail.gmail.com>
From: haoran zheng <zhenghaoran154@gmail.com>
Date: Tue, 3 Dec 2024 15:08:51 +0800
Message-ID: <CAKa5YKhbfwWtyBDNyT-9Tudz17=PJawuqLjD10D5VaUdmdbiPw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix data race when accessing the inode's
 disk_i_size at btrfs_drop_extents()
To: Filipe Manana <fdmanana@kernel.org>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the advice, I will explain in detail why it's a harmless race.
And submit patch v3.

On Mon, Dec 2, 2024 at 10:40=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Mon, Dec 2, 2024 at 1:35=E2=80=AFPM Hao-ran Zheng <zhenghaoran154@gmai=
l.com> wrote:
> >
> > A data race occurs when the function `insert_ordered_extent_file_extent=
()`
> > and the function `btrfs_inode_safe_disk_i_size_write()` are executed
> > concurrently. The function `insert_ordered_extent_file_extent()` is not
> > locked when reading inode->disk_i_size, causing
> > `btrfs_inode_safe_disk_i_size_write()` to cause data competition when
> > writing inode->disk_i_size, thus affecting the value of `modify_tree`.
> >
> > Since the impact of data race is limited, it is recommended to use the
> > `data_race` mark judgment.
>
> This should explain why it's a harmless race.
> Also it's better to explicitly say harmless race rather than say it
> has limited impact, because the latter gives the idea of rare problems
> when we don't have any.
>
> >
> > The specific call stack that appears during testing is as follows:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DDATA_RACE=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >  btrfs_drop_extents+0x89a/0xa060 [btrfs]
> >  insert_reserved_file_extent+0xb54/0x2960 [btrfs]
> >  insert_ordered_extent_file_extent+0xff5/0x1760 [btrfs]
> >  btrfs_finish_one_ordered+0x1b85/0x36a0 [btrfs]
> >  btrfs_finish_ordered_io+0x37/0x60 [btrfs]
> >  finish_ordered_fn+0x3e/0x50 [btrfs]
> >  btrfs_work_helper+0x9c9/0x27a0 [btrfs]
> >  process_scheduled_works+0x716/0xf10
> >  worker_thread+0xb6a/0x1190
> >  kthread+0x292/0x330
> >  ret_from_fork+0x4d/0x80
> >  ret_from_fork_asm+0x1a/0x30
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >  btrfs_inode_safe_disk_i_size_write+0x4ec/0x600 [btrfs]
> >  btrfs_finish_one_ordered+0x24c7/0x36a0 [btrfs]
> >  btrfs_finish_ordered_io+0x37/0x60 [btrfs]
> >  finish_ordered_fn+0x3e/0x50 [btrfs]
> >  btrfs_work_helper+0x9c9/0x27a0 [btrfs]
> >  process_scheduled_works+0x716/0xf10
> >  worker_thread+0xb6a/0x1190
> >  kthread+0x292/0x330
> >  ret_from_fork+0x4d/0x80
> >  ret_from_fork_asm+0x1a/0x30
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
> > ---
> > V1->V2: Modify patch description and format
> > ---
> >  fs/btrfs/file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 4fb521d91b06..f9631713f67d 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -242,7 +242,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *t=
rans,
> >         if (args->drop_cache)
> >                 btrfs_drop_extent_map_range(inode, args->start, args->e=
nd - 1, false);
> >
> > -       if (args->start >=3D inode->disk_i_size && !args->replace_exten=
t)
> > +       if (data_race(args->start >=3D inode->disk_i_size && !args->rep=
lace_extent))
>
> Don't surround the whole condition with data_race().
> Just put it around the disk_i_size check:
>
> if (data_race(args->start >=3D inode->disk_i_size) && !args->replace_exte=
nt))
>
> This makes it more clear it's about disk_i_size and nothing else.
>
> Thanks.
>
> >                 modify_tree =3D 0;
> >
> >         update_refs =3D (btrfs_root_id(root) !=3D BTRFS_TREE_LOG_OBJECT=
ID);
> > --
> > 2.34.1
> >
> >

