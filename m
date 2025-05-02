Return-Path: <linux-btrfs+bounces-13635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9245AA789B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 19:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27D21B6831D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 17:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AECA14EC60;
	Fri,  2 May 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="aPrDAEmB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BQzPFulT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C294A32
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746206557; cv=none; b=c/ZSr/IBGjUKV/QgM+PUW17fCRRwtvEfZ1AE347EQlW5xMpHzkpN48Noq0Z70HnD1DN+M+kSM5ML3cmY1SaOPG1V2Tz2fYI2I6SgDlloJfsRY9EI4RMNoxDPop3/8YZ/D/eU8s/FVz+JJ+b9DCvtIHgN4sOM7w6m6u+vKNZQEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746206557; c=relaxed/simple;
	bh=9ucMymtaHC7UkJ19Z0vrUp3UtDiNddPs/DGKOmnmMJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZYQrR5TNr+LFvj2OSURc5Tbvlaqalfk9MBqgGnxmwooW7afiU8Lzwj9tphR6OncDn+dFtf/UY26XxBr8vASD5HjD6w3aYyUUjYqUuVio1TxQwmevyKa+mENIr2EIBV+fHhC2h087Xwq5nieucTzhDI9mwXY+dv6pXxIDgRdavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=aPrDAEmB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BQzPFulT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E1D8625401BC;
	Fri,  2 May 2025 13:22:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 May 2025 13:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1746206552; x=1746292952; bh=d6YlwtK2hk
	qpKd+9LH5J7o2hjUMBhh3tIJcrISLzsL4=; b=aPrDAEmB8i3NLOuXSNmj9vEfQw
	IBXbPiBlnWhNz/2MdpYL/J3r4/hHAGvzq1f6MxYDPO9++lL98+1v20hIEVTcOyFR
	GwH4mSQgM6IlevExVLjbF4Tcwa69aR52LhUmQMtf0RYsMYoktqvcUm5no6KPUfWy
	gRFfT+snYLtL34eCKYAHxxHapYf87DK/YSPoSUZdQd+RZN7y9t1lVCLPtuGSm4cX
	8Tz56Fz2Z78bZ7X3koIJ1EUGQBrPHQyArZiD5a3zxlBQzYcyHvyFgM6/CfR7kkmK
	CurN8T9c0I2ymQEDcRsox6BgwV47a3PPLlbqTp05HWNDzHebf7tvl/lVoFGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746206552; x=1746292952; bh=d6YlwtK2hkqpKd+9LH5J7o2hjUMBhh3tIJc
	rISLzsL4=; b=BQzPFulTSyjZsogik+dr0sBcDL4nntfGKh5X0QDNhrSKd99KdMt
	el+9ErXp0FngCL+o+4IDglgANcTGHVReFY+2cYKKH5DI/rdjOmp06on4dGGK7T9a
	AdcB/w/lUXNm+XpGdELsk4JoIftiKs792+IoPcyBZJZeWLj3w9U9doBQHBgQzbvm
	l/5RXdoG4+clpgpZG/LoHhs8lpfQxcekEhG1GwX8VOrjCJsGUFc2l0I+/ukFVCMe
	UQ3Qmj1nIoiVwqHOgeCAKRr1b0ozXnE4wQk3Xv2e0UisF66okKGQiUoBc1RdoJfE
	uimC91oxPQL35IflyZMylPo1oa5YqTgeevg==
X-ME-Sender: <xms:WP8UaF4q5tGcrfcbP-phc76HFefCI9gBHsUr3w0uD1ZKHy_5ARm_YA>
    <xme:WP8UaC6argNGABTjLVx4WhLem8VkeKRnbKmtWFMquO2C4bOMJxVYA6ARqpgVdgN0r
    T-nBcW7HmoQ1DOg9mA>
X-ME-Received: <xmr:WP8UaMdRpW1YO0RPFwEr5M-qnfCQJXkXIT1dMXoQI4zqMRe0j5IQWphvzGZr4jCvVVcOggCf0ADYIMthW4OwByZ1GYU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeftdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeelle
    fhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughm
    rghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WP8UaOIHNHEsgXm-3Y4s-2rJr4pruKrd3BsabdSxFDwru4GzP3GAag>
    <xmx:WP8UaJIr2G69zoXfDQfXmKSUQ0gLg9r7J4MLvui4lH40EesNkh3ynQ>
    <xmx:WP8UaHxVrrCAhmaIY6BZcDtpWGW2upEy_1fLYUO6Ai9IvHZSiEzvsQ>
    <xmx:WP8UaFJf9aMw-qbgXbpj2_-WWBmPHXI42xI9lt8bKVwJc-nwqibdpw>
    <xmx:WP8UaH3ZDlregiyiQCPou-Gxagn0IzpNwu9kBpdStWa9ySZRehNcqjSn>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 13:22:32 -0400 (EDT)
Date: Fri, 2 May 2025 10:23:23 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check: fix false alert on missing csum for
 hole
Message-ID: <20250502172323.GA1179844@zen.localdomain>
References: <4dbd03928f8384d926aff5754199c5078fc915cb.1746194979.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dbd03928f8384d926aff5754199c5078fc915cb.1746194979.git.fdmanana@suse.com>

On Fri, May 02, 2025 at 03:32:52PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we log a hole, fsync a file, partially write to the front of the hole
> and then fsync again the file, we end up with a file extent item in the
> log tree that represents a hole and has a disk address of 0 and an offset
> that is greater than zero (since we trimmed the front part of the range to
> accomodate for a file extent item of the new write).

I ran into this last week and reached the same conclusion about the fix,
but wasn't sure I understood how the items were created so was still
debugging. Thanks for explaining it.

I did notice that we have a CONFIG_BTRFS_DEBUG gated check for non-zero
offsets in a hole in extent_map (in validate_extent_map()).

I wasn't able to hit that while reproducing this issue but was curious if
you think that check is valid?

Regardless of that bit, thanks for the fix. You can add:

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> When this happens 'btrfs check' incorrectly reports that a csum is missing
> like this:
> 
>   $ btrfs check /dev/sdc
>   Opening filesystem to check...
>   Checking filesystem on /dev/sdc
>   UUID: 46a85f62-4b6e-4aab-bfdc-f08d1bae9e08
>   [1/8] checking log
>   ERROR: csum missing in log (root 5 inode 262 offset 5959680 address 0x5a000 length 1347584)
>   ERROR: errors found in log
>   [2/8] checking root items
>   (...)
> 
> And in the log tree, the corresponding file extent item:
> 
>   $ btrfs inspect-internal dump-tree /dev/sdc
>   (...)
>         item 38 key (262 EXTENT_DATA 5959680) itemoff 1796 itemsize 53
>                 generation 11 type 1 (regular)
>                 extent data disk byte 0 nr 0
>                 extent data offset 368640 nr 1347584 ram 1716224
>                 extent compression 0 (none)
>   (...)
> 
> This false alert happens because we sum the file extent item's offset to
> its logical address before we attempt to skip holes at
> check_range_csummed(), so we end up passing a non-zero logical address to
> that function (0 + 368640), which will attempt to find a csum for that
> invalid address and fail.
> 
> This type of error can be sporadically triggered by several test cases
> from fstests such as btrfs/192 for example.
> 
> Fix this by skipping csum search if the file extent item's logical disk
> address is 0 before summing the offset.
> 
> Fixes: 88dc309aca10 ("btrfs-progs: check: explicit holes in log tree don't get csummed")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  check/main.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 6290c6d4..bf250c41 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9694,10 +9694,6 @@ static int check_range_csummed(struct btrfs_root *root, u64 addr, u64 length)
>  	u64 data_len;
>  	int ret;
>  
> -	/* Explicit holes don't get csummed */
> -	if (addr == 0)
> -		return 0;
> -
>  	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
>  	if (ret < 0)
>  		return ret;
> @@ -9807,12 +9803,15 @@ static int check_log_root(struct btrfs_root *root, struct cache_tree *root_cache
>  			if (btrfs_file_extent_type(leaf, fi) != BTRFS_FILE_EXTENT_REG)
>  				goto next;
>  
> +			addr = btrfs_file_extent_disk_bytenr(leaf, fi);
> +			/* An explicit hole, skip as holes don't have csums. */
> +			if (addr == 0)
> +				goto next;
> +
>  			if (btrfs_file_extent_compression(leaf, fi)) {
> -				addr = btrfs_file_extent_disk_bytenr(leaf, fi);
>  				length = btrfs_file_extent_disk_num_bytes(leaf, fi);
>  			} else {
> -				addr = btrfs_file_extent_disk_bytenr(leaf, fi) +
> -				       btrfs_file_extent_offset(leaf, fi);
> +				addr += btrfs_file_extent_offset(leaf, fi);
>  				length = btrfs_file_extent_num_bytes(leaf, fi);
>  			}
>  
> -- 
> 2.47.2
> 

