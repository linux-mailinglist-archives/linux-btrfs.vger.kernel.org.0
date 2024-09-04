Return-Path: <linux-btrfs+bounces-7813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6241696C2FA
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 17:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184B51F23CCA
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFF41E1307;
	Wed,  4 Sep 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrS0Q9Hi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4D1E0B86;
	Wed,  4 Sep 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465041; cv=none; b=FQJffLGYW67V6fubjG99P+rDJ4VOYqPGxngKoPv3v2oIXUsTm3THS6GSqvvNYE9MPMhnwc36F6V2ipJle/Fd000EqUrDipnvm+7eNh981xBZQQwY5yWIs7ORNX/T3aCfolmQpS7ARiMaTJBMIwNj5RU5HBwDHAa7YbIBrYuGajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465041; c=relaxed/simple;
	bh=3h0jfTiAFR38+Kgi7UwXDmiCCO7ODKFwqWmvVPs+nc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k55RxBvzjg+aq3qdO+lFYZUrRASjD+yE/U29ZnEkMhffbmX4756eK+Yn5opcmbUYcsZEGfLyhprLJt34AFIE+aIzAyVvziMz4HCCd6fbxW26VxiitLcFFr4GVAsrzV5oZA95UViezbVSXUVRmiUrkbo/pkpoRwYnznSJMUAAb1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrS0Q9Hi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20570b42f24so35468975ad.1;
        Wed, 04 Sep 2024 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725465040; x=1726069840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2LdoEIUi1Dv5O9cEGpaSjS0YiChdqkoHDENpXGhcpg=;
        b=GrS0Q9HipQY0lswGYuYMVu8JhAParLzHEp9rrO+jSFJiRNgxKxJPQTWRFJSGbMG71x
         YbJq9GVe5zv5NiijuVN1IQ0q9DXCDFjDGztgcF3NF4IYpzAVvR2Sm1vRrvhNljfW1mqm
         2YtLcjSrRftdo/MhlCT9QCPSgBluIcr6YUYpn2zylMHsViLnsMg+sGkW4g7iPIcR0YeA
         pwCfuUZuo5a5REm8iNdqnSVL+HL00CwZUrJqDARGiN2C9DcTR5Xzx7Cgn8f06+2xzUWq
         8qiZZgvn/Q/Ho1uuPvgG3pKx3D5q47uqZivuCivTVv7ydg+dyQiyI0pWHLGg9mOMA4Au
         YClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465040; x=1726069840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2LdoEIUi1Dv5O9cEGpaSjS0YiChdqkoHDENpXGhcpg=;
        b=FvPk7WUb+J1qHLDjimR2AMz34H13Xeh6GnmIR+L1LAdgRJiGYOWqmxuGtRuq9QRYhF
         z+2DXpwJyucPdmZojwIjaeCAcGQyXxiGcq5Kx/eqfhTG/J1dbKQZYqvh2xDRLExZKOQT
         eeHyebpVadn5HiG9Z6slJHLzxgM2Po9ZCA94vVhQMZZNJ1PgCy2dWGQC2G6B9TASzXPF
         hjzAiJCqdwa/DZSfCCJK6o39IUmMMo9Y93jg93Fn+wL+S7CWTJor+9NP/hC0k+MvpQaO
         /48y6gO1n3VvmfGdgJXkYGIRMCMB1dUXJYpSciQ2xnOiJZd28kFyX+yHUN4G13nrPcdy
         cTGg==
X-Forwarded-Encrypted: i=1; AJvYcCVe3kFkHScuHvGQm3/Fdueh/8vSuTuu+lmU9nllsqxOkxa6/GyYlj8+ibSqPao/M/Xqk361vDydjpItSs3N@vger.kernel.org, AJvYcCWH6Yw0KLE2V4T43PXlvbzTNHTu/FsAFFlFY/W3uQgtHpsBYE4t0SkjYFWhey86xpkBM4MG0jlHq5R7Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXlKywyARWfIHwCzVobeXPk1V6qwpxT3YWUgwkaxNDbs6WxFn
	ivA5x94b/+ByZmh096Rl2q5AObSme7rYGc7HWBpxaFQBlibLBMmxxBrw0QmUFZ8eD2ZM2WL++w1
	/+BU42qzW8N9c3/cDWT+ZVtAE7s+iJZDL0b0=
X-Google-Smtp-Source: AGHT+IEpmm/4MJT/OGuv6caXpo6ITiWG0GqLT+7dMjxiS0777nX30sw948DcGEq7H6fjys3a1oAyV9NokIpBiphmJjY=
X-Received: by 2002:a17:902:e94d:b0:205:2d09:9a30 with SMTP id
 d9443c01a7336-20699acce23mr66632825ad.13.1725465039496; Wed, 04 Sep 2024
 08:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904023721.8534-1-ghanshyam1898@gmail.com> <9ee34826-259f-45a1-99d5-a21262489e49@gmx.com>
In-Reply-To: <9ee34826-259f-45a1-99d5-a21262489e49@gmx.com>
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date: Wed, 4 Sep 2024 21:20:02 +0530
Message-ID: <CAG-Bmoc9NVTZgOTGTsngKCw2mCankPvwz8ywExNzFiij+2sGQA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Added null check to extent_root variable
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 11:21=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/9/4 12:07, Ghanshyam Agrawal =E5=86=99=E9=81=93:
> > Reported-by: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
> > Closes:https://syzkaller.appspot.com/bug?extid=3D9c3e0cdfbfe351b0bc0e
> > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > ---
> >   fs/btrfs/ref-verify.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> > index 9522a8b79d22..4e98ddf5e8df 100644
> > --- a/fs/btrfs/ref-verify.c
> > +++ b/fs/btrfs/ref-verify.c
> > @@ -1002,6 +1002,9 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs=
_info)
> >               return -ENOMEM;
> >
> >       extent_root =3D btrfs_extent_root(fs_info, 0);
> > +     if (!extent_root)
> > +             return -EIO;
> > +
>
> Can you reproduce the original bug and are sure it's an NULL extent tree
> causing the problem?

The original bug can be reproduced using the c program provided by syzkalle=
r
https://syzkaller.appspot.com/bug?extid=3D9c3e0cdfbfe351b0bc0e

>
> At least a quick glance into the console output shows there is no
> special handling like rescue=3Dibadroots to ignore extent root, nor any
> obvious corruption in the extent tree.

I don't have a deep knowledge of filesystems and am unable to
understand this. If you believe I should try to understand this part
for working on this particular bug, please let me know. I will try to
understand this.
>
> If extent root is really empty, we should error out way earlier.

Upon studying the function call sequence, I found out that the
variable extent_root is read for the first time at btrfs_root_node
in fs/btrfs/ctree.c, "eb =3D rcu_dereference(root->node);" where "root"
is the extent_root. This is where we get a null pointer error.
>
> Mind to explain the crash with more details?
I have answered your questions individually. If any other details are
needed, please let me know.
>
> Thanks,
> Qu
>
> >       eb =3D btrfs_read_lock_root_node(extent_root);
> >       level =3D btrfs_header_level(eb);
> >       path->nodes[level] =3D eb;

Thank you very much for reviewing my patch. I look forward to hearing
back from you.

Thanks & Regards,
Ghanshyam Agrawal

