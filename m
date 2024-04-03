Return-Path: <linux-btrfs+bounces-3882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8A8975C3
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 18:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D85528BFED
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D1715219D;
	Wed,  3 Apr 2024 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OToMWjTY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B108152172
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163502; cv=none; b=ZFplQGEgW91tkUakiVVZslObgD0FbqWUV7g7Q+XyGe47NmN/KzDMzqHU+mD01yw40Te6BzRO1iIoHywg19a5zM27kihNTxBUuE161cgH3z2xCtOxIgzjkRcyE3MfbXmbBa0ZK5y7ynl2uEgtDJz4bTvjmSSwudodBflSgkGqHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163502; c=relaxed/simple;
	bh=AnaON3b/vCZPnX5n53LzayRcIw1CUYQ6URv93NPOgQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0ctt4hIrlDbzZviXbib/P6RxS/6kpPKb4jiJxVo92bB8Ql9fVrFzrlbuVJK6lsYZ6KTdP4o7c9IAFxJ/I+y/qCRG3u51BxFJaeQDOSybbGYS0pvXANrWhRXI7h582V1BIvf+xD3EwqnOj1jwxSqqKaK8/rPvTQY9AExFZM9Sxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OToMWjTY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712163500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0vlp5zqKNWczSf5uwQPJWCYRlyw0wuDQPwNGC+8xK8=;
	b=OToMWjTYF4dRNpCVjO7bhBUbKNTu9mTqer3lTbduZekG/EcU//zDutzUajDbJxWD3pwyji
	2GhbnvJxIQrGsHl7vo+ZK0KYgW2mDpTSEh8I3nEtG/qxC0DnXh2tSfBeVjoZDyqoBSLNNf
	zn7qVbrtZWbe+EtQq/kqRmMGFt4g6A8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-b9Sqe5VQNbSAgN0m4F60cA-1; Wed,
 03 Apr 2024 12:58:14 -0400
X-MC-Unique: b9Sqe5VQNbSAgN0m4F60cA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6496A383CD7A;
	Wed,  3 Apr 2024 16:58:13 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A6F3C40C6CB5;
	Wed,  3 Apr 2024 16:58:12 +0000 (UTC)
Date: Wed, 3 Apr 2024 13:00:11 -0400
From: Brian Foster <bfoster@redhat.com>
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 11/13] bcachefs: fiemap: return correct extent
 physical length
Message-ID: <Zg2LG1_2-ac1GlsG@bfoster>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <b9b795987a485afa0fdb8f0decc09405691d9320.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b795987a485afa0fdb8f0decc09405691d9320.1712126039.git.sweettea-kernel@dorminy.me>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Wed, Apr 03, 2024 at 03:22:52AM -0400, Sweet Tea Dorminy wrote:
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  fs/bcachefs/fs.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index f830578a9cd1..d2793bae842d 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -913,15 +913,17 @@ static int bch2_fill_extent(struct bch_fs *c,
>  			flags |= FIEMAP_EXTENT_SHARED;
>  
>  		bkey_for_each_ptr_decode(k.k, ptrs, p, entry) {
> -			int flags2 = 0;
> +			int flags2 = FIEMAP_EXTENT_HAS_PHYS_LEN;
> +			u64 phys_len = k.k->size << 9;
>  			u64 offset = p.ptr.offset;
>  
>  			if (p.ptr.unwritten)
>  				flags2 |= FIEMAP_EXTENT_UNWRITTEN;
>  
> -			if (p.crc.compression_type)
> +			if (p.crc.compression_type) {
>  				flags2 |= FIEMAP_EXTENT_ENCODED;
> -			else
> +				phys_len = p.crc.compressed_size << 9;
> +			} else
>  				offset += p.crc.offset;
>  
>  			if ((offset & (block_sectors(c) - 1)) ||
> @@ -931,7 +933,7 @@ static int bch2_fill_extent(struct bch_fs *c,
>  			ret = fiemap_fill_next_extent(info,
>  						bkey_start_offset(k.k) << 9,
>  						offset << 9,
> -						k.k->size << 9, 0,
> +						k.k->size << 9, phys_len,
>  						flags|flags2);
>  			if (ret)
>  				return ret;
> @@ -941,14 +943,18 @@ static int bch2_fill_extent(struct bch_fs *c,
>  	} else if (bkey_extent_is_inline_data(k.k)) {
>  		return fiemap_fill_next_extent(info,
>  					       bkey_start_offset(k.k) << 9,
> -					       0, k.k->size << 9, 0,
> +					       0, k.k->size << 9,
> +					       bkey_inline_data_bytes(k.k),

Question for Kent perhaps, but what's the functional difference between
bkey_inline_data_bytes() and k->size in this particular case?

FWIW that and the other couple nitty questions aside, this all LGTM.
Thanks.

Brian

>  					       flags|
> +					       FIEMAP_EXTENT_HAS_PHYS_LEN|
>  					       FIEMAP_EXTENT_DATA_INLINE);
>  	} else if (k.k->type == KEY_TYPE_reservation) {
>  		return fiemap_fill_next_extent(info,
>  					       bkey_start_offset(k.k) << 9,
> -					       0, k.k->size << 9, 0,
> +					       0, k.k->size << 9,
> +					       k.k->size << 9,
>  					       flags|
> +					       FIEMAP_EXTENT_HAS_PHYS_LEN|
>  					       FIEMAP_EXTENT_DELALLOC|
>  					       FIEMAP_EXTENT_UNWRITTEN);
>  	} else {
> -- 
> 2.43.0
> 
> 


