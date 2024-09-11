Return-Path: <linux-btrfs+bounces-7944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C7697500E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 12:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE67C1F219DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423B2185B67;
	Wed, 11 Sep 2024 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5pq77aC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD5E183CCD
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051755; cv=none; b=LOvO5iVC7sRvvPZyrcHY5uHZjFtCZ5Y+aTPBe86VCBX0yXl629VtmLnMQ3MjkG4P+7TUeJbov1027WQmRIYYMC98vRnsqkLFW7oIARJoicYKu6y2tvawE7H5q77WjnVzm/MwDimJl6Dy2SqfelH8ow9Jc+TdA3dtIqvMsKXygr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051755; c=relaxed/simple;
	bh=NbsreZ4VraHYpjDzjWixn4iUjI9sGURGybgZDhKLXog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmUyy0zUlrQ/5oX1IHguajXPkZRF0y2XTCfuJRrZ+VFHtdvcJMkCYyg/eRQJF1rBz3Wnt54dRC8sAMJ3jBJTq19+UGMq7sFbycQvQr86aHz+SUfx10xwBPSnYjyRZYnp5UHfMCQL+fkq+KWRuyp911EJal9ztW7Fwu3ZBxInjlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5pq77aC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92BAC4CEC6
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 10:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726051754;
	bh=NbsreZ4VraHYpjDzjWixn4iUjI9sGURGybgZDhKLXog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r5pq77aCxejUhShUS2Dv/EJELV+TnAm+fU8cwaYwJ8v969/Qsq90WaqkENf58MApw
	 MGY/K45wGCSnQmzZLaTFHUvqUINxYiwdlkbPD32GM2cZuA83g/7/CYNCiZRAWXLHXI
	 +o32N0igh1tBKWDCo/RFZQYFGqGbveRB2AYk32OrG2astg/l0NaRqxXDz8mlLstwVB
	 O3d0Ez9FplRf3M+0iANpo7BSpsDeU+BmcsNVAq28H4lXELP1/yOMHqhkhYpxVilDEy
	 Pnyz7zi8d0A/6qOjVoF14gZiCS4ezHjZEMsJ+OdXmNEZQLUFu8Ma37M89tAYwvB5GY
	 0sfYQsRY0ljlg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d2daa2262so433982066b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 03:49:14 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywx94xLH/p0nWQWWad9RdyrBm/u3MTNCklzA1fZV+El1yw6dmdk
	VPB9OvuG5Zakl6baaVpEQZPoG84fWZclxSemdhaP2kF+ElCpdUtBxIRRiRwiQlQX+c+FrjySsTh
	cZ3ib13cuuLruKuLA0kpQaM+cA9k=
X-Google-Smtp-Source: AGHT+IERKbHijLQGPXBdDQ6pdrmiy1EQQ3Ae/bWQgR4T/0qmbR+BfS6kG79EZUFPFumMRlb1yCMw7uJ+HSIfyIG4saw=
X-Received: by 2002:a17:907:72d5:b0:a8d:7046:a1bd with SMTP id
 a640c23a62f3a-a8ffab88f39mr360076766b.28.1726051753417; Wed, 11 Sep 2024
 03:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3aea93fcf3d04b38c4ab1cd7de9948599733b202.1726004203.git.wqu@suse.com>
In-Reply-To: <3aea93fcf3d04b38c4ab1cd7de9948599733b202.1726004203.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 11 Sep 2024 11:48:36 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5M3YftmnXwmyiJU0cEvJRHtkfbYjB-d9R97dwjSBfzMw@mail.gmail.com>
Message-ID: <CAL3q7H5M3YftmnXwmyiJU0cEvJRHtkfbYjB-d9R97dwjSBfzMw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: fix the wrong output of data backref objectid
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Neil Parton <njparton@gmail.com>, 
	Archange <archange@archlinux.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 10:37=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is some reports about back data backref objectids, the report

is -> are
back -> bad or invalid

> looks like this:
>
> [  195.128789] BTRFS critical (device sda): corrupt leaf: block=3D3336547=
87489792 slot=3D110 extent bytenr=3D333413935558656 len=3D65536 invalid dat=
a ref objectid value 2543
>
> The data ref objectid is the inode number inside the subvolume.
>
> But in above case, the value is completely sane, not really showing the
> problem.
>
> [CAUSE]
> The output itself is using dref_root, which is the subvolume id of the
> backref.
>
> [FIX]
> Fix the output to use dref_objectid instead.
>
> The root cause of that invalid dref_objectid is still under
> investigation.
>
> Reported-by: Neil Parton <njparton@gmail.com>
> Reported-by: Archange <archange@archlinux.org>

Please include Link tags on lore (there's at least one I have noticed).

> Fixes: f333a3c7e832 ("btrfs: tree-checker: validate dref root and objecti=
d")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Otherwise, it looks fine:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/tree-checker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 634d69964fe4..7b50263723bc 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1517,7 +1517,7 @@ static int check_extent_item(struct extent_buffer *=
leaf,
>                                      dref_objectid > BTRFS_LAST_FREE_OBJE=
CTID)) {
>                                 extent_err(leaf, slot,
>                                            "invalid data ref objectid val=
ue %llu",
> -                                          dref_root);
> +                                          dref_objectid);
>                                 return -EUCLEAN;
>                         }
>                         if (unlikely(!IS_ALIGNED(dref_offset,
> --
> 2.46.0
>
>

