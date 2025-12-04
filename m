Return-Path: <linux-btrfs+bounces-19509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB33CA2502
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 05:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24A53301832D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 04:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093B72DCF7B;
	Thu,  4 Dec 2025 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ENfPYXWH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sKkWd/PH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209923D7D8
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 04:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764822444; cv=none; b=kl9cDOO5lD8aD0ZN2uRhuusLhG2pcuH/QUOl7UR/ArPHqpq1Og2PkT0tSSKY/Ehoh+v0gs5XNgtAbvSepMOgDDcC7r05Aj9dDA20ZTVz+PLNOSRikR2w6T0APFJxpQICV/lxyjK0F/YtIO4sMK/dc3XSy1icIt2/WkTsrGbrHUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764822444; c=relaxed/simple;
	bh=btSLl71hz7Z+Q3VVM4u6R19fB3jwuq0M2QB3XCK3s4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBlESH0UbQKckTVMaf1F2mpA35PUJdya8EUYIxaQRtrB4o29dhiNG7q4EPA74/b53UxePEeeMU9LYO4yYSJt97rfRtQwEl5Eztxd8TzK6RQF9/medyFyB4Fthq1YBCDVxb5MXiexnjRZUeYKMFMUcMXP+RJdTxkOkNyAizSRK1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ENfPYXWH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sKkWd/PH; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A1DE1D000DD;
	Wed,  3 Dec 2025 23:27:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 03 Dec 2025 23:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764822440; x=1764908840; bh=3Jn9uBuAqE
	pAhNxpr530jZmE3T6bRBDhcXkVRKgngRE=; b=ENfPYXWH0uS9t8pN0ShkThRpss
	QGu/EFqZtP7jtkKnko3vC6D+omHa66jbgli2pkVbvHMCX9oU8VqPdCZE39Zyijpu
	k6UWX0/H8GFc8qllWlg3gre5vvX8+P70GwUZVUDyfj/qn7PEDMWUCzdb78TtVnJI
	uAM4O0g7p4VyWCmFRFQfMQj7VYQ3MjLsWV3KJ7Z3V3033cBM/7U3S2iggGAHFQFa
	nBGVyUHxKoHnzS6TBHj8cBp+SlCpbrb3n7kmXikTXAj2vc53zRekp2BzvWo/JPmX
	p0QrZJCqFAT2BxiJ06wti2pXMnzSlUnUdRDk9/+bi8C8LPRsHojJ0sLrg4NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764822440; x=1764908840; bh=3Jn9uBuAqEpAhNxpr530jZmE3T6bRBDhcXk
	VRKgngRE=; b=sKkWd/PHeD9xBk2Sj1uvpAojOHW+j3w+QIr3Wr4AJv0uYIr1qjQ
	6DJ3t30PDj0mZPrpT0vjuG/4R9JSOG5dTAO2+9o7sCg7w9SjT2BYdyY3w859HnJP
	JljHQA2sw6xM42bKEP6caKxUTisLqcSu/4up3zcqV6pQIRMAmaHgQcYnur7HZ2et
	EFGqzY9CPXc/0wZEJPIHSCkrznbkseyi6IYAmraqKXZrIMGlo+3CfxVGWnLjd3HM
	SD4O+QDUqGvuO7SePHc7hg8SuklsKCeP8srtdvstpx774c9w0jhAbYl1nBLzQhqv
	YIXUG808roDaNYW8C+PEhJLEkmJwQvPdDOg==
X-ME-Sender: <xms:qA0xacOM2p1fO3ciF4rSGMe7Mq3Zs0yQKQ2itEqn1TgdoBsAup6M_g>
    <xme:qA0xaY_A3EbIcr_1X6BM8G2EUB2dXl5Tk-Akd0DFGoNIMKpkca_FzQYDXBFLQjHHT
    ZkpvC0WaW59YWjPXcLpTiWjx6kRL5nyS-L00hAXYz9TCqX5bpRZcB7d>
X-ME-Received: <xmr:qA0xaQ5tGzuF-KzkaNDT6XIalQldtCPHZnlnfkQ3R_Q9bunGu7R-G7jszdVreIwAW_okuu9k09Fl8tiJDzad-Gw15Ns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcuuehu
    rhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekff
    ejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    fihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qA0xaf1LaqMH61KWg_ku88v7o8pRs45uw7PPTd2SaoRxm4I7C0rgOw>
    <xmx:qA0xaXAminGIS1ZpZyGAY_cwdPobaNozPTUA8vtPM4rysPDGVODoLA>
    <xmx:qA0xaR3pMqNSiLxIjv5RyXeTUJK_wn6dd-DIZfS-pFcBNBPPKzSuLQ>
    <xmx:qA0xaRsCbiIaLBcVgtIDke9A5sKT4wS4bE7EJc3P4jOPaQAQCXhHfw>
    <xmx:qA0xab66jon2BGjmhYwETjkzH9krqNnRh_U4jyKuQTNBpjhIoOt8IBeb>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 23:27:19 -0500 (EST)
Date: Wed, 3 Dec 2025 20:27:38 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: update all parent qgroups when doing
 quick inherit
Message-ID: <20251204042738.GA3754302@zen.localdomain>
References: <44875ba8294669ec2125476a5c2f7256cb534de5.1764821238.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44875ba8294669ec2125476a5c2f7256cb534de5.1764821238.git.wqu@suse.com>

On Thu, Dec 04, 2025 at 02:38:23PM +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug that if a subvolume has multi-level parent qgroups, and
> is able to do a quick inherit, only the direct parent qgroup got
> updated:
> 
>  mkfs.btrfs  -f -O quota $dev
>  mount $dev $mnt
>  btrfs subv create $mnt/subv1
>  btrfs qgroup create 1/100 $mnt
>  btrfs qgroup create 2/100 $mnt
>  btrfs qgroup assign 1/100 2/100 $mnt
>  btrfs qgroup assign 0/256 1/100 $mnt
>  btrfs qgroup show -p --sync $mnt
> 
>  Qgroupid    Referenced    Exclusive Parent     Path
>  --------    ----------    --------- ------     ----
>  0/5           16.00KiB     16.00KiB -          <toplevel>
>  0/256         16.00KiB     16.00KiB 1/100      subv1
>  1/100         16.00KiB     16.00KiB 2/100      2/100<1 member qgroup>
>  2/100         16.00KiB     16.00KiB -          <0 member qgroups>
> 
>  btrfs subv snap -i 1/100 $mnt/subv1 $mnt/snap1
>  btrfs qgroup show -p --sync $mnt
> 
>  Qgroupid    Referenced    Exclusive Parent     Path
>  --------    ----------    --------- ------     ----
>  0/5           16.00KiB     16.00KiB -          <toplevel>
>  0/256         16.00KiB     16.00KiB 1/100      subv1
>  0/257         16.00KiB     16.00KiB 1/100      snap1
>  1/100         32.00KiB     32.00KiB 2/100      2/100<1 member qgroup>
>  2/100         16.00KiB     16.00KiB -          <0 member qgroups>
>  # Note that 2/100 is not updated, and qgroup numbers are inconsistent
> 
>  umount $mnt
> 
> [CAUSE]
> If the snapshot source subvolume belongs to a parent qgroup, and the new
> snapshot target is also added to the new same parent qgroup, we allow a
> quick update without marking qgroup inconsistent.
> 
> But that quick update only update the parent qgroup, without checking if
> there is any more parent qgroups.
> 
> [FIX]
> Iterate through all parent qgroups during the quick inherit.
> 
> Reported-by: Boris Burkov <boris@bur.io>
> Fixes: b20fe56cd285 ("btrfs: qgroup: allow quick inherit if snapshot is created and added to the same parent")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/qgroup.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 58fb55644be5..7c23fa1c252b 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3256,7 +3256,10 @@ static int qgroup_snapshot_quick_inherit(struct btrfs_fs_info *fs_info,
>  {
>  	struct btrfs_qgroup *src;
>  	struct btrfs_qgroup *parent;
> +	struct btrfs_qgroup *qgroup;
>  	struct btrfs_qgroup_list *list;
> +	LIST_HEAD(qgroup_list);
> +	const u32 nodesize = fs_info->nodesize;
>  	int nr_parents = 0;
>  
>  	src = find_qgroup_rb(fs_info, srcid);
> @@ -3293,8 +3296,19 @@ static int qgroup_snapshot_quick_inherit(struct btrfs_fs_info *fs_info,
>  	if (parent->excl != parent->rfer)
>  		return 1;
>  
> -	parent->excl += fs_info->nodesize;
> -	parent->rfer += fs_info->nodesize;
> +	qgroup_iterator_add(&qgroup_list, parent);
> +	list_for_each_entry(qgroup, &qgroup_list, iterator) {
> +		qgroup->rfer += nodesize;
> +		qgroup->rfer_cmpr += nodesize;
> +		qgroup->excl += nodesize;
> +		qgroup->excl_cmpr += nodesize;
> +		qgroup_dirty(fs_info, qgroup);
> +
> +		/* Append parent qgroups to @qgroup_list. */
> +		list_for_each_entry(list, &qgroup->groups, next_group)
> +			qgroup_iterator_add(&qgroup_list, list->group);
> +	}
> +	qgroup_iterator_clean(&qgroup_list);
>  	return 0;
>  }
>  
> -- 
> 2.52.0
> 

