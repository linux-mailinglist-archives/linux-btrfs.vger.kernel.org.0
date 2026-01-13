Return-Path: <linux-btrfs+bounces-20459-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC44D1AD75
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 19:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A5D3046F95
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 18:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F401234E74D;
	Tue, 13 Jan 2026 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DWN/IN9p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQM11Yol"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C2342CB1;
	Tue, 13 Jan 2026 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328942; cv=none; b=qpolhgUC4bpisZHP3dZei/yC1YHvYvCokWyOm93Rzxg/ROP2x1BAM8dF+GGJ0p+nFpGgAUjzP6L6FfnSKyrOal/mrAyfDIKH/NmsiIuOyg50utEte+12qL6k4kebeN3omg/cwec2sdscRfUrfGRhBAXOC1puBdLVlhzZnI5IdLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328942; c=relaxed/simple;
	bh=TPDVEWWSDkoAaIOR8tpv5u70u5M5N5P09k04y3ghV+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krIfe++X/0IwgUb7q36rwU7+0qwqjs0H0/hQUehDSUm+s/Ag4lJ7qvHqZPh8Y/dQxG1JcT+73Z/mymylgP2VYC3bnro2cMNemOd2rIS9G9koqf+vgRUNgMFPshE0b4WMYceZ+WJsPrgEopPw0MiCKbPnTgCDBdBRVuK878FkypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DWN/IN9p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQM11Yol; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CA03EC028D;
	Tue, 13 Jan 2026 13:29:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Jan 2026 13:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768328940; x=1768415340; bh=2cK+qiWRQH
	isne09QKuU20R8b7Ur7VFdwnivRPdcYuY=; b=DWN/IN9pBpMOSzP4J1LuNsAfsB
	rxrU5ELFPQJDri4c8nrpMejs5VqfKvKjifNNFcCqfYELmi8iYwQ7sglkf4tLaBiW
	BamhKs9klCFAxPZUdQyWX1L3yT75zjeo2e18c4mAAVqjBfrFghmHqpIqn/VG2EaH
	ptUeWA1AuVkf09dY93kJhJebyhXsBOKrbK5V9KspOjc6KOMFNXqyuz5m+evUMBiO
	XMVn0DjFWt5pecw9vX++Aol4r8QbUoyzieD/iYd+VYxzTcKeWzDntYXOGARcPxAP
	2XoCTSFdkuYPiyyIBwdiTKEpBX4HyhfI+k4qrD5YodJT3c0CiaugOOLAogYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768328940; x=1768415340; bh=2cK+qiWRQHisne09QKuU20R8b7Ur7VFdwni
	vRPdcYuY=; b=lQM11Yol2sGUXeL/s9JDyuyFtW832dfzOO5Pn51yXacV30ASyvG
	dcyq2xGO74+nymwDBXqjFs8Wp2RwwHIb1fwO0n8By3SN8L9laP2SR3GyQWp9fzpF
	MnnaHPlXyADBRA0q9Ao48aAmcuZWEKIS45jNnIJ/Ug1UNUog5ZIw9aid8RXl8Jzd
	ffJ++8DEZSkhw/FRCZ4ymbXSFMSCLszHDP9y05h69rhmQgE20vvBP/vxM1EC04bm
	euUYBxuJpM3qVvfN02tv5FDBnGxTh0Y4fgORcSLdMYwatqV59b3W0AGZGApSHtt2
	JUMFTnvQbv+k5CxmKsDH3HmUNKnNPaqhnpA==
X-ME-Sender: <xms:7I5maSWnodDlN73Ag-sS7pBzWnhcT5kP_jyjsq8Wb9Ko-9RAdYH2Lg>
    <xme:7I5maQGTvMIQss0X2tQSZtfdNoN_yTnWlrry6toEmuNmuCJf3YR-asz4U6mU8j5L6
    17e40KiMiVPhx4LLyNtvSyxcn0j2w8KAH81zj1PcD4cfbeiCNwCVw>
X-ME-Received: <xmr:7I5maWc6X-5KpxJe0KOLYypnVMITypoRTpR2vfCxXlpNct0TGyCWueOZsmpZ755EzJyUn2THFm66XuiW5TuInjGF4EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddutdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjihgrshhhvghnghhjihgrnhhgtghoohhl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghlmhesfhgsrdgtohhmpdhrtghpthhtoh
    epughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhf
    shesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7I5maZLB9DmZbdNuXwMfZ_2xD86OtsmYQXd24JpdZHV-3bskuqhwKQ>
    <xmx:7I5maTHf8Pf0hwX3HUgF4tVBWSXVfjK46XQEtUBaV84azJl07dQRRQ>
    <xmx:7I5maUBPsjBu-glINEZk3rYtPffid5mrlILnPHzjjMH0DBsfE5Z-FA>
    <xmx:7I5mae-Y4sZRiv2G2Fiw9N2oOWoroXAGAAF30D4Hzc5a1mjsB89oew>
    <xmx:7I5maWhWkdf5vWJ3RJmu4d43TOtLsP9tcQseqZ7M_Spx98MTGfGuQ1HQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 13:28:59 -0500 (EST)
Date: Tue, 13 Jan 2026 10:29:00 -0800
From: Boris Burkov <boris@bur.io>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: zoned: remove redundant space_info lock and
 variable in do_allocation_zoned
Message-ID: <20260113182900.GC972704@zen.localdomain>
References: <20260112185637.GB450687@zen.localdomain>
 <20260112202227.37626-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112202227.37626-1-jiashengjiangcool@gmail.com>

On Mon, Jan 12, 2026 at 08:22:27PM +0000, Jiasheng Jiang wrote:
> In do_allocation_zoned(), the code acquires space_info->lock before
> block_group->lock. However, the critical section does not access or
> modify any members of the space_info structure. Thus, the lock is
> redundant as it provides no necessary synchronization here.
> 
> This change simplifies the locking logic and aligns the function with
> other zoned paths, such as __btrfs_add_free_space_zoned(), which only
> rely on block_group->lock. Since the 'space_info' local variable is
> no longer used after removing the lock calls, it is also removed.
> 
> Removing this unnecessary lock reduces contention on the global
> space_info lock, improving concurrency in the zoned allocation path.
> 

It would probably be best if Johannes or Naohiro had a look at this,
just in case there is some space_info synchronization need I'm missing
(without accessing any fields like you pointed out) but I think it
looks correct.

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Removed the description about avoiding deadlocks.
> ---
>  fs/btrfs/extent-tree.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index e4cae34620d1..43d78056c274 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3839,7 +3839,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
>  			       struct btrfs_block_group **bg_ret)
>  {
>  	struct btrfs_fs_info *fs_info = block_group->fs_info;
> -	struct btrfs_space_info *space_info = block_group->space_info;
>  	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
>  	u64 start = block_group->start;
>  	u64 num_bytes = ffe_ctl->num_bytes;
> @@ -3900,7 +3899,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
>  		 */
>  	}
>  
> -	spin_lock(&space_info->lock);
>  	spin_lock(&block_group->lock);
>  	spin_lock(&fs_info->treelog_bg_lock);
>  	spin_lock(&fs_info->relocation_bg_lock);
> @@ -4002,7 +4000,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
>  	spin_unlock(&fs_info->relocation_bg_lock);
>  	spin_unlock(&fs_info->treelog_bg_lock);
>  	spin_unlock(&block_group->lock);
> -	spin_unlock(&space_info->lock);
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 

