Return-Path: <linux-btrfs+bounces-10485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1229F4EBE
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 16:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C3D164818
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B601F63E1;
	Tue, 17 Dec 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvW4YfEb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAFF1D63D1
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447814; cv=none; b=cVTu8i4Rjl93tOFpIifzHSV+q9UxGvPJ1LEsOopHa0d0Oyxlul5VcFFtFrlW29VpIzmDfYf/yRr/vmZltGHM3O08IMD9eq0vP8Y3GeB0K2xVA8RwgMt1yvtDiJROUiFVe99XJ6vPoFB4K4tsBauqNF4sX4efcmlgqtTA9gwT0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447814; c=relaxed/simple;
	bh=Hk+GSHY5U7xOeMX+LugvAVPkvSyvVxjAJ2RMTBh+rjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPy47oZWcrsN1lx2nfzqxZTcFuHc2fE6VYsox7uTCASI0erl0vhw0c+cKtFhmXWys6UU7rPTeJ0012RyuARi5kgUKWD75DAmW8c3fUEx36k8bG64/w0jzOzfHACnz6jSRGlIcfCvlY+DKnzVRtpxHmarca9/Bae1Dh8tqN6FDwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvW4YfEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6BEC4CED3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447814;
	bh=Hk+GSHY5U7xOeMX+LugvAVPkvSyvVxjAJ2RMTBh+rjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nvW4YfEblWZ/mepVwmqRYIEvi0D3FdIEsxfA7osiKl03eAetxeE6r727cxy7H8nhn
	 H9zPETPga7RqZHsT5+rWFyQPQB0KVDHTNRPVCFHx/VEGbDHSA2POMV7cNRxNPOHC9L
	 fTgDg/0+caHTrnAFzZ35L/kdPcmG6RR+FyqNWv8sEtH+y50e2YybVYrNfrPoKn1LiK
	 S15CjTbcJUaUqc+jEvKi4JNf7+5h/D+h8CfHelKApWNLK891HZgcRCMOHiRnDbnnZl
	 ccxRXHL5Ng5arZciKMRWNbHJd2l/C+QGjbP9hQnGxiXdTE2ViMk2fnXMzwZRAgqWmj
	 vJhccI3d0rrTg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa6a92f863cso1087081066b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:03:33 -0800 (PST)
X-Gm-Message-State: AOJu0Yxj6gjzHLpJujPHHDb1iPNdm+4sjV1TDts4N5KNjRaPKovgqypY
	+1RxOM1+E9mENz3NirXHnyCqN4O1+bMdh7Zp2NMAvB19hdnum8xdZcTI4m1KztkwcTyEOtEXC+x
	m+fqGHIuuNkMEbYVCSbqEE8J7z5U=
X-Google-Smtp-Source: AGHT+IFl6D+QosYaDTIM5Ex1onRdpPJtby3wqXE71Ytch8rKytaJHtv46VDyTK725HdNtBizW1jE9swRmpZ4v9k+LJ8=
X-Received: by 2002:a17:907:7710:b0:aa6:9461:a186 with SMTP id
 a640c23a62f3a-aab77e7b483mr1445456266b.46.1734447812581; Tue, 17 Dec 2024
 07:03:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <e996ff4c30ef83f271f2495d700635287d5587d9.1733989299.git.jth@kernel.org>
In-Reply-To: <e996ff4c30ef83f271f2495d700635287d5587d9.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 15:02:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4L05uE1wVtrW21-bSJvtiQpwHk_aQ8OJy7JEa8zwVNmg@mail.gmail.com>
Message-ID: <CAL3q7H4L05uE1wVtrW21-bSJvtiQpwHk_aQ8OJy7JEa8zwVNmg@mail.gmail.com>
Subject: Re: [PATCH 04/14] btrfs: fix front delete range calculation for RAID
 stripe extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 8:06=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> When deleting the front of a RAID stripe-extent the delete code
> miscalculates the size on how much to pad the remaining extent part in th=
e
> front.
>
> Fix the calculation so we're always having the sizes we expect.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index d6f7d7d60e76..092e24e1de32 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -138,10 +138,13 @@ int btrfs_delete_raid_extent(struct btrfs_trans_han=
dle *trans, u64 start, u64 le
>                  * length to the new size and then re-insert the item.
>                  */
>                 if (found_end > end) {
> -                       u64 diff =3D found_end - end;
> +                       u64 diff_end =3D found_end - end;
>
>                         btrfs_partially_delete_raid_extent(trans, path, &=
key,
> -                                                          diff, diff);
> +                                                          key.offset - l=
ength,
> +                                                          length);
> +                       ASSERT(key.offset - diff_end =3D=3D length);
> +                       length =3D 0;
>                         break;

What's the length =3D 0 for? We break out of the loop right after the
assignment and don't use length anymore.

Otherwise it looks good:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>                 }
>
> --
> 2.43.0
>
>

