Return-Path: <linux-btrfs+bounces-3435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF688803F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1CF285862
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3DE2CCB4;
	Tue, 19 Mar 2024 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wIJKiqWZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FAD2C84C
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870811; cv=none; b=NoRbFE/Neq8VJNFmixHpObtFmxpLKQzgpv17adPQqBT1rL5wlFPaR/FjgccaOXeaV3ENA0dJBtnF97IODrxx9Yf6b2bKnxGpoOCeSV1Cs6bEwb/A6VyrH/JuSgxw1ctiiApO9AOzT/mCKr7OElCI2vB3anHFkPC12ZFuRWyPPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870811; c=relaxed/simple;
	bh=ifnuAoPqbt00EnIs/YnFdaHuK0DmA4Uqc34Do9y2wR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImV7bADFEVegOqd5Qsv9fjzKL+gQNMQrjXulMmBe52z2VUmrj0XTlTbdd2dHQQZKi4Xa34SNw0nr8aqIDoSPkQ4WbFkzlOav2boWEo8Z3FgHpsoha2MV9qPBpC1tGv5bnVt6o9bDMWthdV/VVzf545P8MeE5bQsUBFwoT6CiihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wIJKiqWZ; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d42d18bd63so1815422e0c.2
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710870809; x=1711475609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TwUFl7F3pKIzfMXRT96c83edoWqdKbPZXSriTg/4xM0=;
        b=wIJKiqWZpwxDVwVwzUQqxcH0J4w5lHlsnYAIAp2Eo5/MirjSYxHGevcHVc5rpCwslP
         7n63vQbAnXruVYLk8wWpBNMKTnG2423ze6vi6Jhffu85egyxm/h/jLsAzhkDzNxLIB30
         ogE8bydUKAEQmYrAhZR9yAhlJT8L3o15OJxqO4jtFsDpSsOb1sY6oXST/IUkrFz+JhoR
         CPlb/u/o7EzTJK9bDn2SueBEQruf0MVbrGvqfWvs9kYZUJP8FmZsnVF1m9x7DL+skgPb
         tWdAL9/hiLAGTzLQJuP1xVPZhHbMfJYZndQN4ZIxSl3SFjgWn3htkQN3/2431nx6EtcC
         VxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870809; x=1711475609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwUFl7F3pKIzfMXRT96c83edoWqdKbPZXSriTg/4xM0=;
        b=aAZ0KTUx/QMeCUNfZYdAPte2/rmEWEoHUYhSiZn2I3Z1yOvhjFga0wOhmhz1u7KKBv
         L2JS8GDVqtL6xrZ4cvgODxwN9lWcPeh0BnwqBWhRDe4jfmqt24LN5ZjXtC73O94LfRYy
         TVgS9ZohQfiNijTBa0xnUcgRqaeiyZUOurpKvahb8WM1AFqx85CNmsHHtpFAWZ3j/YjP
         cHPkjgJ2QylK4LJISdgwuNe0VViZF2f9CHL7rgWbfDw/NoL1WOHlIipNLdpL/rVmP0WR
         bg9QqgjV9ZQiWW7ZkFAKGHV3qOjEFA8nLLeXnSG+ax5dK5hYKnr4gmwT73X0TMF/z6Jw
         Oi5w==
X-Gm-Message-State: AOJu0YyPF6gRDr6eQX1KyhvhPpGmorT/KfxYePD4/Vz3JPLv3j2Ixqzt
	67thWgIZgkJqTVeoGa/1O+Q+xMxy9/qPfWdl/vo8TIdEoVeCphPo/hrNtOv8D2k=
X-Google-Smtp-Source: AGHT+IHE7Xf5gM52XveJ/64j7rHwZyZZ7mcjnFPs/KwpQDaAoBwHucEY8lr+YqKh3hn0uSjT/Otqcg==
X-Received: by 2002:a1f:f28b:0:b0:4d4:3e64:8e6c with SMTP id q133-20020a1ff28b000000b004d43e648e6cmr2351615vkh.13.1710870808896;
        Tue, 19 Mar 2024 10:53:28 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z10-20020a056214040a00b00690d951b7d9sm6692154qvx.6.2024.03.19.10.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:53:28 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:53:27 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 12/29] btrfs: btrfs_write_marked_extents rename werr to
 ret err to ret2
Message-ID: <20240319175327.GC2982591@perftesting>
References: <cover.1710857863.git.anand.jain@oracle.com>
 <14bd267ea479d4c4d104966d4dae2d88ff403a99.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14bd267ea479d4c4d104966d4dae2d88ff403a99.1710857863.git.anand.jain@oracle.com>

On Tue, Mar 19, 2024 at 08:25:20PM +0530, Anand Jain wrote:
> Rename the function's local variable werr to ret and err to ret2, then
> move ret2 to the local variable of the while loop. Drop the initialization
> there since it's immediately assigned below.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/transaction.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index feffff91c6fe..167893457b58 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1119,8 +1119,7 @@ int btrfs_end_transaction_throttle(struct btrfs_trans_handle *trans)
>  int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
>  			       struct extent_io_tree *dirty_pages, int mark)
>  {
> -	int err = 0;
> -	int werr = 0;
> +	int ret = 0;
>  	struct address_space *mapping = fs_info->btree_inode->i_mapping;
>  	struct extent_state *cached_state = NULL;
>  	u64 start = 0;
> @@ -1128,9 +1127,10 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
>  
>  	while (find_first_extent_bit(dirty_pages, start, &start, &end,
>  				     mark, &cached_state)) {
> +		int ret2;
>  		bool wait_writeback = false;
>  
> -		err = convert_extent_bit(dirty_pages, start, end,
> +		ret2 = convert_extent_bit(dirty_pages, start, end,
>  					 EXTENT_NEED_WAIT,
>  					 mark, &cached_state);
>  		/*
> @@ -1146,22 +1146,22 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
>  		 * We cleanup any entries left in the io tree when committing
>  		 * the transaction (through extent_io_tree_release()).
>  		 */
> -		if (err == -ENOMEM) {
> -			err = 0;
> +		if (ret2 == -ENOMEM) {
> +			ret2 = 0;
>  			wait_writeback = true;
>  		}
> -		if (!err)
> -			err = filemap_fdatawrite_range(mapping, start, end);
> -		if (err)
> -			werr = err;
> +		if (!ret2)
> +			ret2 = filemap_fdatawrite_range(mapping, start, end);
> +		if (ret2)
> +			ret = ret2;
>  		else if (wait_writeback)
> -			werr = filemap_fdatawait_range(mapping, start, end);
> +			ret = filemap_fdatawait_range(mapping, start, end);

Ok so this is a correct conversion, but we'll lose "ret" here.  Can you follow
up with a different series to fix this?  I think we just say

free_extent_state(cached_state);
if (ret)
	break;

otherwise this patch looks fine, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

