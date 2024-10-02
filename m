Return-Path: <linux-btrfs+bounces-8442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2828398E232
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 20:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF2A1F2499E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 18:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0DE2139A8;
	Wed,  2 Oct 2024 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="LACt4gpj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZawNzzKf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44526212F12
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893245; cv=none; b=H7Ywfst0ZXYtG1fE5KVEJYV+aXfn7vUvdOkoy8DUGFfhS3gnf/kOuRzpLBQAUfXLg+D0p2zWnqhoJrXLmv+e1jwbFL4aZWG/IA3S1tAOHAhSdRdgLfBb9gZZD2wm0mNu54ecJUkNXl+uYJmLxGg4nD3j8bT3sLVLAzZ7e1btmpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893245; c=relaxed/simple;
	bh=LUiEHGCCaXtqzn3Txd2HEMCZxlNgFCMTPOw+pn5pSlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOxeIPuTLscYTlzlNa/15qIr7HtZxr7NcC1yobits1agMaJ/iXZDuCN0o1hGOEWw/pEeLHNKpIDNoN936eD1rajPV4jgDnALoUUWafzRgLO04Xw5g7LVG0m8qS3UQuBPz3/3qDW0bS5lugjykVla7yoAb4Ce83NAU34xYtJvyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=LACt4gpj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZawNzzKf; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 217961140149;
	Wed,  2 Oct 2024 14:20:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 02 Oct 2024 14:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1727893242; x=1727979642; bh=twhWGTLi2q
	ejPJu2kz5392QXttpX3tfdcUaN3rQ8zcI=; b=LACt4gpjl6etgTjEa6u2bYqgz1
	bTBWjWTF4GNS9KWN5wf/vUtdYCXB8NKQUBStAMH41U+4/czBlqu8hbE/Cx00x1H3
	3dOrIfa4uRRRPiyklRsFsL2zBHqv/1B2jHvk+KFsgMMbvSl4waOoPN7PxwLwA0NM
	Fkzv+MqdwKzzuDISIRXwJ6/cmgHhwqkDpxCzNURPrDXtbNZZ7xXRoArQGsq9Hr2j
	7aLjg4LxMCGUdUygz+H3s7SRtsVzjkiFWhe+3GNWKCKkK9xWyO4xYQjtDyda8HMS
	5J0eG3Q1LMpuygGAXy2Uf9hyRpVSr1ipxcMxJlmDkMiWJcbnnR3RGxKuqcdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727893242; x=1727979642; bh=twhWGTLi2qejPJu2kz5392QXttpX
	3tfdcUaN3rQ8zcI=; b=ZawNzzKfuvYaIOgfzTO2bgfh/GET0KsnLRP1KHxxlFWQ
	616PtrZSpBP9GW2JnzSnHeJVWgPs53vYWAymFcbP6niOPcfv0hz2vVej0XLAbdvU
	Gum7ZBMgxvW9O+R/kStmL24GinQJbGFUUOF26+v54ycxUxp/7Dx4aCj7XCFg+Bbg
	oAHPkZ6aF79/5nKO8iUCt5BiP8bvrdL0j73jIDITYoXT+MaalWcSyyY6MvzDZ7HT
	KR/q7C+9iWUU3zsjq5pWpbtWNiVBl8p3Cbx2ZsNIqCy//GJGsYY0qPy6/mpwKRIT
	slOghuQ8bSbrXGZ5JxIzlEfl5ZITirlhu/3TYWybLw==
X-ME-Sender: <xms:-Y79ZivajD1fYmOcnRDB9_XI6HrSFb7HsKI-865oEI13UyZROEFPHw>
    <xme:-Y79ZneilXKSVYjN4-y2yo-Sdz1wiorbOW8KkkfrqWw5WzWexUHcJEtj1ideDtBu1
    1EYDMocXqH1GownHm8>
X-ME-Received: <xmr:-Y79ZtxuwShFmlHzFkM8hUTdxyh_IVgT0p6tz_rRntMCW1Stbr3_6qT4YpnLat5wLy6To7ygoiyFtLCuZrZOA7V4tH8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrghhrghrmhhsthhonhgvsehfsgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-Y79ZtNHqWP_CjYrbAJ5UgI4FM44ifh5ZfyaRR_5ucXcYCBP-Zk_Lw>
    <xmx:-Y79Zi_rYvJwLdc4tTOU8whOf69RCvVLJF4mG8tYN_44Wdcp_UuR_Q>
    <xmx:-Y79ZlX5pCXsOxWsi6TPxsCq2Yl6hgSPuC4ZS-QrzPUhvopqmwMAXA>
    <xmx:-Y79ZrcYOkI93nIhOcNBJzE965jqMikSMHcDHiE9tPRxH-xa8arHEA>
    <xmx:-o79ZkKPaJrPN8jNIxZlhWjNVf8Q_4gUJB94OCk9qByoa2Pf6BYJ6E8P>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 14:20:41 -0400 (EDT)
Date: Wed, 2 Oct 2024 11:20:40 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix comments in definition of struct
 btrfs_file_extent_item
Message-ID: <20241002182040.GA3917419@zen.localdomain>
References: <20241002164500.2775775-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002164500.2775775-1-maharmstone@fb.com>

On Wed, Oct 02, 2024 at 05:44:45PM +0100, Mark Harmstone wrote:
> The comments in the definition of struct btrfs_file_extent_item were
> written while the FS was still in flux, and are no longer accurate.
> 
> The range [disk_bytenr, disk_num_bytes) is the same as the extent in the
> extent tree. There's no difference here between csummed and non-csummed
> extents, as the comments were implying. And the fields offset and
> num_bytes are in bytes, not file blocks.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  include/uapi/linux/btrfs_tree.h | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index fc29d273845d..5df54a11c74c 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -1094,24 +1094,23 @@ struct btrfs_file_extent_item {
>  	__u8 type;
>  
>  	/*
> -	 * disk space consumed by the extent, checksum blocks are included
> -	 * in these numbers
> +	 * The address and size of the referenced extent.  These should exactly
> +	 * match an entry in the extent tree.
>  	 *
>  	 * At this offset in the structure, the inline extent data start.
>  	 */
>  	__le64 disk_bytenr;
>  	__le64 disk_num_bytes;
>  	/*
> -	 * the logical offset in file blocks (no csums)
> -	 * this extent record is for.  This allows a file extent to point
> -	 * into the middle of an existing extent on disk, sharing it
> -	 * between two snapshots (useful if some bytes in the middle of the
> -	 * extent have changed
> +	 * The logical offset in bytes this extent record is for.
> +	 * This allows a file extent to point into the middle of an existing
> +	 * extent on disk, sharing it between two snapshots (useful if some
> +	 * bytes in the middle of the extent have changed)
>  	 */
>  	__le64 offset;
>  	/*
> -	 * the logical number of file blocks (no csums included).  This
> -	 * always reflects the size uncompressed and without encoding.
> +	 * The logical number of bytes.  This always reflects the size
> +	 * uncompressed and without encoding.
>  	 */
>  	__le64 num_bytes;
>  
> -- 
> 2.44.2
> 

