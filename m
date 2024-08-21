Return-Path: <linux-btrfs+bounces-7371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B47095A3D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 19:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC1D285457
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 17:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C62B1B253B;
	Wed, 21 Aug 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="d2IKVJB6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692F1B2516
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261228; cv=none; b=u90eyyRfop8WTRT4jYma0liZx6CSjGP/2ER+nBiA6TQQViFwCJRGaMsxpXV/SNPS2O88WJvYwRESwQ1KWQq8aHTDrpZfDdReGUZFl6T5ExOa1gJbMRRZhqS0ZpRyMpHjL0sxBHW9B+BT5fCj3Nq1h9ipiOVpS9xM9VneoTCllWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261228; c=relaxed/simple;
	bh=3RZuCYy+vVZRqCA6mWv+INCkfGZ95Fq7b0Usg2VqSA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB+nS72S4W1v8mkw8HPJRNJ3HWz1vBwWqwXdB9IV+8t8DHbDQnryAQjInrZ7j2eyiUOOCbT+COmNB6WjJKLlDBw/G/0FEI3PaI9r1+cKBYVooHnW8dzT6I7d16Nr8658unMUSn8HlbtxeJjDvRM2eMN2TQgAyAcg2tRJq3IrDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=d2IKVJB6; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e115eb44752so7438230276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724261226; x=1724866026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Te2fZ6c8Qh376+Is7GB9Y5bGPQ8EYETIXcjQMro4Lfg=;
        b=d2IKVJB6TctZOak/KcwLl6iZDga+rlkOPv2w7Qq3cKZBkjxtRWG8wuJLmZUqKshnwu
         L4t7o77eTB1ShYUfwgDdS/9u3W/PTGxrx4RBDCZL+x6A4kT9Qofs/DN89qdb+x2l1IPh
         MUOAgsM4U6AlG9Vv8RwgOaXRxRSPfYNe9XP2Iq4CTFlR7F1uknJynhcKxBp1U5nOVlcE
         YJUxxf6lVtpm7qceHtrodUyiZd56+ZRuK1XvzD3/3YmYDY6AIlmw1Z8NOUm+F6PpA5XR
         Z3bg9dO1thuhK4axDI2j//0qVKUWOCtulggX/AJbowKk/e56DQRFbUv70X4ZMq6YhFTw
         wmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724261226; x=1724866026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te2fZ6c8Qh376+Is7GB9Y5bGPQ8EYETIXcjQMro4Lfg=;
        b=M016Y9ca4n6SBj0Wx8CzlGXbceaSqXpFaBd5MPQRxwpr+ItZ6rKMaIlYQVtSpS+z4Q
         pdTZM16uVU3/rm9wuZcrR1g+iGwtySP1F5sXkSUaThwbkJAVcXA1hGEDghb4x4Qy0DvW
         SUT8H6xMkLCx6IhoeqntQ8TBXWojXIy5F2YuKKaMLBehecEMQUifvGpyTOjvOo2ryreO
         Nwaykw4ymlSynGujq7fExeCR8eQlj8UBa7KdK+5IEa6udOnpSSsIwtj3oud2V23BtBnV
         kAFg4FWRir1oXOdcqtfS1tKasSixyY8bjShvbC9aAArs4cFIHrfoSJMswQyMktG+CqVi
         LynQ==
X-Gm-Message-State: AOJu0YxuXrQUbFceneM7FBCE6fj9U1i6P+kPDZtBeLTj+t4i+MBQgVff
	LEGGF/tfd5DGsjzZoEy0ItJD0jlYukmW6hkD3/qGick6dJb5CtcJbUfdydT75aE=
X-Google-Smtp-Source: AGHT+IFtcS1xKQQmYbwGz86BU0Qa2+pxf4jblZgZHuMXxiF/UmLribkJcOl4RRGOWQeVsXyQd8YlUQ==
X-Received: by 2002:a05:6902:2702:b0:e13:df00:2830 with SMTP id 3f1490d57ef6-e166549c8f8mr3579094276.30.1724261225825;
        Wed, 21 Aug 2024 10:27:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e164ca55c91sm877448276.36.2024.08.21.10.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:27:05 -0700 (PDT)
Date: Wed, 21 Aug 2024 13:27:04 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] btrfs: remove conditional path allocation from
 read_locked_inode, add path allocation to iget
Message-ID: <20240821172704.GC1998418@perftesting>
References: <cover.1724184314.git.loemra.dev@gmail.com>
 <652ef8f5f0b46c2488a2f72bf34a83d9bc8357db.1724184314.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652ef8f5f0b46c2488a2f72bf34a83d9bc8357db.1724184314.git.loemra.dev@gmail.com>

On Tue, Aug 20, 2024 at 01:13:18PM -0700, Leo Martins wrote:
> Move the path allocation from inside btrfs_read_locked_inode
> to btrfs_iget. This makes the code easier to reason about as it is
> clear where the allocation occurs and who is in charge of freeing the
> path. I have investigated all of the callers of btrfs_iget_path to make
> sure that it is never called with a null path with the expectation
> of a path allocation. All of the null calls seem to come from btrfs_iget
> so it makes sense to do the allocation within btrfs_iget.
> 
> ---
>  fs/btrfs/inode.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a8ad540d6de2..f2959803f9d7 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3790,10 +3790,9 @@ static int btrfs_init_file_extent_tree(struct btrfs_inode *inode)
>   * read an inode from the btree into the in-memory inode
>   */
>  static int btrfs_read_locked_inode(struct inode *inode,
> -				   struct btrfs_path *in_path)
> +				   struct btrfs_path *path)
>  {
>  	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
> -	struct btrfs_path *path = in_path;
>  	struct extent_buffer *leaf;
>  	struct btrfs_inode_item *inode_item;
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
> @@ -3813,20 +3812,13 @@ static int btrfs_read_locked_inode(struct inode *inode,
>  	if (!ret)
>  		filled = true;
>  
> -	if (!path) {
> -		path = btrfs_alloc_path();
> -		if (!path)
> -			return -ENOMEM;
> -	}
> +	ASSERT(path);
>  
>  	btrfs_get_inode_key(BTRFS_I(inode), &location);
>  
>  	ret = btrfs_lookup_inode(NULL, root, path, &location, 0);
> -	if (ret) {
> -		if (path != in_path)
> -			btrfs_free_path(path);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	leaf = path->nodes[0];
>  
> @@ -3960,8 +3952,6 @@ static int btrfs_read_locked_inode(struct inode *inode,
>  				  btrfs_ino(BTRFS_I(inode)),
>  				  btrfs_root_id(root), ret);
>  	}
> -	if (path != in_path)
> -		btrfs_free_path(path);
>  
>  	if (!maybe_acls)
>  		cache_no_acl(inode);
> @@ -5632,7 +5622,17 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
>  
>  struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
>  {
> -	return btrfs_iget_path(ino, root, NULL);
> +	struct btrfs_path *path;
> +	struct inode *inode;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return ERR_PTR(-ENOMEM);
> +

Actually now that I look at it, I don't want to do it this way.  Sorry about
that because I'm the one who suggested cleaning this all up, and I missed an
important piece here.

With btrfs_iget_path() we're doing the btrfs_iget_locked() first, which will
find the inode in cache if it can, so the path allocation isn't necessary in
that case.  I missed this when I was looking at this, so I think it's better to
move the path allocation out of btrfs_read_locked_inode(), but push it into
btrfs_iget_path() instead.  So btrfs_iget_path() will handle path == NULL the
way that btrfs_read_locked_inode() currently does, allocating if it has to and
freeing if it's necessary.  The second patch is still good.  Thanks,

Josef

