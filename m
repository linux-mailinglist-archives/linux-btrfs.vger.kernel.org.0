Return-Path: <linux-btrfs+bounces-335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6C97F69B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 01:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C33B1F20EBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 00:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F48C39F;
	Fri, 24 Nov 2023 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLOKpBfx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157F17E;
	Fri, 24 Nov 2023 00:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9657AC433C7;
	Fri, 24 Nov 2023 00:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700785053;
	bh=+lidUqppJxg2JG9sU7HTiTcJePswNNaLiOHkaBxgCcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JLOKpBfxq++lt1+6jFL0ZZ0n6/J0b9mqKkmGZ1DiGpZ307jgiRLuxygK3wy11g80E
	 zrk8+t1tKJmIoTs0t5RLzZwduYN+ugXJ156a2chSnjVdAouYp28hB1QIURsizYLMmv
	 rO/QGMvd+ycQNodtDXklBcofc1WQao0C1sx7DmoCICLw9z478+70Bs4xTfkAlIZm1s
	 tZGkd+skNo4+Wzh3aI3ug9XRcqrEUwoVPlSkWTHTFk7dMlpa0S3xM4DCVWkNo2qnm2
	 0RFKDFerR685WegE8i9RFCrNxQDNO9pwJ981qaa+3jKcf/kY8j9yAkVka4L+ZH1nh1
	 dqt7fGGX97GRQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a04196fc957so194764966b.2;
        Thu, 23 Nov 2023 16:17:33 -0800 (PST)
X-Gm-Message-State: AOJu0Yw+i4Y2L3KQSv2Cfts7nYoA76/ibLnCP17q5mIf6gKw5ZWdcW9N
	ZDG5365+4Hyw4rBWwNVt4HSe4XGErH8/SyZ+Umc=
X-Google-Smtp-Source: AGHT+IEcaOtWkKQy89/8U8PWKAmo0MrYE3Xc1MvOgz1GYhZvH1iyQh5ugiTKTuiWkWSzXeXnTMhAQi5N0Wk14ZRaC8A=
X-Received: by 2002:a17:906:3915:b0:9ff:9db9:1da7 with SMTP id
 f21-20020a170906391500b009ff9db91da7mr664666eje.29.1700785051984; Thu, 23 Nov
 2023 16:17:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124000034.27522-1-dsterba@suse.com>
In-Reply-To: <20231124000034.27522-1-dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Nov 2023 00:16:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6C=FJL9cX2-uVo1AhnNAmMOGfFMkTEzHekL5OeW0OAXQ@mail.gmail.com>
Message-ID: <CAL3q7H6C=FJL9cX2-uVo1AhnNAmMOGfFMkTEzHekL5OeW0OAXQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix 64bit compat send ioctl arguments not
 initializing version member
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 12:08=E2=80=AFAM David Sterba <dsterba@suse.com> wr=
ote:
>
> When the send protocol versioning was added in 5.16 e77fbf990316
> ("btrfs: send: prepare for v2 protocol"), the 32/64bit compat code was
> not updated (added by 2351f431f727 ("btrfs: fix send ioctl on 32bit with
> 64bit kernel")), missing the version struct member. The compat code is
> probably rarely used, nobody reported any bugs.
>
> Found by tool https://github.com/jirislaby/clang-struct .
>
> Fixes: 2351f431f727 ("btrfs: fix send ioctl on 32bit with 64bit kernel")

So this is not the correct commit, you copy-pasted the wrong one from
the change log above, it should be:

e77fbf990316 ("btrfs: send: prepare for v2 protocol")

With that fixed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> CC: stable@vger.kernel.org # 6.1+
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ioctl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index dfe257e1845b..4e50b62db2a8 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4356,6 +4356,7 @@ static int _btrfs_ioctl_send(struct inode *inode, v=
oid __user *argp, bool compat
>                 arg->clone_sources =3D compat_ptr(args32.clone_sources);
>                 arg->parent_root =3D args32.parent_root;
>                 arg->flags =3D args32.flags;
> +               arg->version =3D args32.version;
>                 memcpy(arg->reserved, args32.reserved,
>                        sizeof(args32.reserved));
>  #else
> --
> 2.42.1
>
>

