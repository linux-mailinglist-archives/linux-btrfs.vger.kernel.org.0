Return-Path: <linux-btrfs+bounces-8932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF51199EA4F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 14:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848AE28A5AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD691C07F6;
	Tue, 15 Oct 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgTAYc0w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC061C07CD;
	Tue, 15 Oct 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996583; cv=none; b=b3ag/kb7p0+u20NBrOVZAa6hyZEg9+yleGcR8AUKzgVOcYUoNdHHAirjU8jKJSN6EFzh0eGfzllrDi5wkgHFd6Ua3KPeD9BZYGD/5Rt7DFUbXZRaugHN56UFTk9PiFmyz9hx6SCK1IO64Kc6+4AUNb7IJU5UlmItNxf/qhhmKxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996583; c=relaxed/simple;
	bh=RING0shKmNXKkzvb4Ew0sBlR3AQzehnBy8pWuEmI4JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLuxWGS7nu5fDAx9vgacGcX0PDYorwfbgQmo2PjoWbZdpTgX+FG4aUkWgmFENgnWs5SJPiwGZSgVJCxNcIaPmov6uout2JIAlYNkljyWKIy9WRx1wunjeR75xS9JK5UPUQ0Xhr4NYyPVVcScNHe+3SkJuyagzC7wEWDLmqCmNMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgTAYc0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F29C4AF0B;
	Tue, 15 Oct 2024 12:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728996582;
	bh=RING0shKmNXKkzvb4Ew0sBlR3AQzehnBy8pWuEmI4JA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mgTAYc0wwQcD9n8fOJp11xt5y1ZVTaz0unTxugbi2042txj5JShkC3mqmpZL0s7AL
	 HW7P65gvYiOyxalSquG+2RB854azg3WZfim+i1nTe9HmiWbC3lK03SbP7HnjxoBuMl
	 pqOsitg4ItJ6yPEllIVcZK0xrR5BKNhdf8OHdvgeDNcI3Px3JFgNvE9Vy0Zr7Jzbfj
	 TvLHVCXqRVvvQaA+YkMkmxTLZIiV2jdeM0MJdd6YJgGqvmtPzrgyUC673b8juBcUsl
	 QiyjizsORa4liCRl26iR4wkA48hTVprTHRYM0xxE6MDS3ZGQP+b7Q7HebRxaBvFyWq
	 xter0JgDz7q2Q==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso8074453a12.3;
        Tue, 15 Oct 2024 05:49:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWfhdM4gwvLzFpl8rYR/a1lH4FUTZN1viyFtZ3GnRU3Vt9ZKxY8mDAiEUQfsmpLlQf92Rv7Ptc5l0rPUdw@vger.kernel.org, AJvYcCV15zPXTGLLmnJLgM38Ck2Ek0P6Hf2LE3DOdhS9CxJ/WOVo5EO7h3cUvvEa6P0O+u2E6tbUJvmtqlDpaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt2xJIAKKlxMDzlGx7gB6kN1MLSNXPv1zb60VvQTjfl5I3sLlE
	PYcw1LMqewbODkUSboKqRu5jZ7Cry68RrpjQrSf0M03zb6P9FzJQvcBHWF3aExttKOlP5IdYM/D
	APQf3HnUoc6Ta6moCFq/fhOfoZ9c=
X-Google-Smtp-Source: AGHT+IFYTK9KJBiTtmhYi8Z+0Jde9FYu3ciLO0x0lR/f0ED7zdLYV/uMnKYyF6VbIqZXZoaAG/X8ZuRPdFg0Jn8AJ1g=
X-Received: by 2002:a17:907:360c:b0:a99:499f:4cb7 with SMTP id
 a640c23a62f3a-a99b940530bmr1394328966b.23.1728996581180; Tue, 15 Oct 2024
 05:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <670d3f2c.050a0220.3e960.0066.GAE@google.com> <tencent_0EBF9E731B704B091B022578BA9EBB8E3308@qq.com>
In-Reply-To: <tencent_0EBF9E731B704B091B022578BA9EBB8E3308@qq.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 15 Oct 2024 13:49:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7D=uNsvgKwBcK+jtNXayDYPLO=ZowWyjjaeYK27ZgirQ@mail.gmail.com>
Message-ID: <CAL3q7H7D=uNsvgKwBcK+jtNXayDYPLO=ZowWyjjaeYK27ZgirQ@mail.gmail.com>
Subject: Re: [PATCH next] btrfs: Accessing head_ref within delayed_refs lock
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com, clm@fb.com, 
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 1:40=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> =
wrote:
>
> This is because the thread routine btrfs_work_helper released head_def af=
ter
> exiting delayed_refs->lock in add_delayed_ref.

This should be explained a lot better. Starting the changelog with
"This is because..." is odd. It should explain why the head reference
was freed (because delayed references were run).

> Causing add_delayed_ref to encounter uaf when accessing head_def->bytenr
> outside the delayed_refs->lock.
>
> Move head_ref->bytenr into the protection range of delayed_refs->lock
> to avoid uaf in add_delayed_ref.


This was already fixed yesterday, in a simpler way and with an
explanation of what's going on to trigger the use-after-free:

https://lore.kernel.org/linux-btrfs/02fc507b62b19be2348fc08de8b13bd7af1a440=
e.1728922973.git.fdmanana@suse.com/

Thanks.


>
> Fixes: a3aad8f4f5d9 ("btrfs: qgroups: remove bytenr field from struct btr=
fs_qgroup_extent_record")
> Reported-and-tested-by: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc3a3a153f0190dca5be9
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/btrfs/delayed-ref.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 13c2e00d1270..f50fc05847a1 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1012,6 +1012,7 @@ static int add_delayed_ref(struct btrfs_trans_handl=
e *trans,
>         int action =3D generic_ref->action;
>         bool merged;
>         int ret;
> +       u64 bytenr;
>
>         node =3D kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS=
);
>         if (!node)
> @@ -1056,6 +1057,7 @@ static int add_delayed_ref(struct btrfs_trans_handl=
e *trans,
>                 goto free_record;
>         }
>         head_ref =3D new_head_ref;
> +       bytenr =3D head_ref->bytenr;
>
>         merged =3D insert_delayed_ref(trans, head_ref, node);
>         spin_unlock(&delayed_refs->lock);
> @@ -1074,7 +1076,7 @@ static int add_delayed_ref(struct btrfs_trans_handl=
e *trans,
>                 kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
>
>         if (qrecord_inserted)
> -               return btrfs_qgroup_trace_extent_post(trans, record, head=
_ref->bytenr);
> +               return btrfs_qgroup_trace_extent_post(trans, record, byte=
nr);
>         return 0;
>
>  free_record:
> --
> 2.43.0
>
>

