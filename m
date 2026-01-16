Return-Path: <linux-btrfs+bounces-20642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE357D37A10
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 18:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DA99308C07A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2639134C826;
	Fri, 16 Jan 2026 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="sh6cIipe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v645uDb4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3390A1E0DE8;
	Fri, 16 Jan 2026 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583820; cv=none; b=aOjwCbpc3EjM/UiNa9sRvbYTGu56i42wtUaC7G/HG55pfTD9npc/sw0UPKhaDHguvrt+3y/lxMh/6x9gpuesIDPBeYIm7nF54eSC3G6Celvew6HWfjUlP1UiaEZE5+GmF6ZhM42fRGz6h+uY1vie1wfRf8kLSoEPUHDVfa+THxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583820; c=relaxed/simple;
	bh=0p6o6JNNIThcsrbL/QvOkZlsKs8U984zCWGSvFZuLco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwjCk6sgbiWHp3REkxFMb+cxu42CkvQnbXoi6z05RA/3+JyVzb+3uEt7Fuj4Td+YGJSGlLybEGldcyDRgEK/ILaR2TVQx4lzVM/6+ewbX2r6IyzuMCtoSGyI6mgMaSaHfvplb70xxLDL8JHv2GVb6IQRG9rOCIdNMszhvSSFVjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=sh6cIipe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v645uDb4; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C6911D0014B;
	Fri, 16 Jan 2026 12:16:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 16 Jan 2026 12:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768583818; x=1768670218; bh=C5PtU0RiyE
	j1tGC1qxqJ9t/LUVAKMdss4e9wGylANgo=; b=sh6cIipexzCVsuio01+88bR6Ii
	SyncyQNBFgmaXR+zYZvKKyaXrxhuboGVXzzwZkSDjkRhbkueJ9rtKiXMrso8vo6F
	k82LD/JrNnndgGH4/tnC+jMTkYzcEWt8Idnl10+MUeprjL40fQl7t9KJx4vHhN0T
	ji7N6c9c6eBZFqvBDhlv8UakDGHoYsIEtyKEbYWy/p5OF6ph5ZE3+B6hk3fSwA8y
	hHxE/zxkEdxVR8W7APEnDNABPo2Zr8xo5vxlVVQxbGFcjZ8/6KjdqVS+DUr8/NRu
	sQN5K0Zk9qWCGQl1yEQQCTWj0s3XfHwWIQPItPThECqe3yMIxLqKhjnHhIUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768583818; x=1768670218; bh=C5PtU0RiyEj1tGC1qxqJ9t/LUVAKMdss4e9
	wGylANgo=; b=v645uDb4OYzr+1dJzAmtTuScUbbt9rnzblxLe/CcSwrpsgZuEab
	sQVJAGU5wtS1HuLzrk4eyCzsFYImN5nFZ3UtoaAy1IiwC/whcYiZFLHQAtU2a5XW
	j2XGwhkcT4rlSrs5rEMd0sk6MOfcW9D6CwnRDw5Ljxg/3aTH2Fl2rS9C5kWfhFdp
	X5+c8sDjVdo87OoZAtTQRCEEkL86WYnMlASMAWX9dokuG5kd1BwWW2QE7KPQ/FjI
	rF2OwRYHo6C0ZYPZ/EN0gobCS9f/siOYkJgg51PPq+DbnY7Ll/ELK63a1JRmicNu
	HIoCfKnjOEYYn40sJCSbnBq8cMi6EfTIRBg==
X-ME-Sender: <xms:inJqac0dZ5ShB2YRoNd5ef8GutxaHultbYQEXqXE-sbENOrbAIJRSg>
    <xme:inJqaYkIS5kBmNqMSpOTE-puozBp2nZcuuXpkxym-AsGEWUWCEvTe2IXmwdgg8X5Z
    fjuUk4IhBfgfvk346AFWIuCWQcUN15dVejAtTTaJqicZz565hirupY>
X-ME-Received: <xmr:inJqaU91_4_cF4rSAs8ZVT39OW6_DBiEWZ4Fsi1WU1BvaCnab9wufOJEE9OR9ct1xhZEQ6XR15wgF0QkGactYobdV_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelhedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:inJqaVpG-n3bBtTjj-oWxDcqK0KkLXhpr4q3t-Q1sX8--45gVc9R_g>
    <xmx:inJqaVkY9rstnHCxncgRoHxtTbhyxU_MfMpKSlQf98LUaSivydZDlg>
    <xmx:inJqaUiVJbnrt79W-oduHBOWRhZmfLRsyPbJrtZ8YzBqV12oJPPmZw>
    <xmx:inJqaVeaQvCrXJQcKe6s1-c-Ckz-6Xd0SP3eSWV5R4WYePyiY0kQBA>
    <xmx:inJqaXBvHswSagLcMyPJAXnzoSJa-5d7veWmjWObyMYDMJb_wgHFBJDw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 12:16:57 -0500 (EST)
Date: Fri, 16 Jan 2026 09:16:53 -0800
From: Boris Burkov <boris@bur.io>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unnecessary RCU protection in
 clear_incompat_bg_bits
Message-ID: <20260116171653.GB2507766@zen.localdomain>
References: <20260115224724.GB2118372@zen.localdomain>
 <20260116160256.19783-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116160256.19783-1-jiashengjiangcool@gmail.com>

On Fri, Jan 16, 2026 at 04:02:56PM +0000, Jiasheng Jiang wrote:
> The function clear_incompat_bg_bits() currently uses
> list_for_each_entry_rcu() to iterate over the fs_info->space_info list
> without holding the RCU read lock.
> 
> When CONFIG_PROVE_RCU_LIST is enabled, this triggers a false positive
> lockdep warning because the internal check inside the RCU iterator fails:
> 
>   WARNING: suspicious RCU usage
>   -----------------------------
>   fs/btrfs/block-group.c:1014 suspicious rcu_dereference_check() usage!
> 
>   other info that might help us debug this:
> 
>   rcu_scheduler_active = 2, debug_locks = 1
>   1 lock held by ...:
>    #0: ... (sb_internal_sem){.+.+}-{0:0}, at: start_transaction+0x...
> 
> As established in commit 728049050012 ("btrfs: kill the RCU protection
> for fs_info->space_info"), the space_info list is stable (initialized
> upon mount and destroyed during unmount). RCU protection is unnecessary.
> 
> Fix this by switching to the standard list_for_each_entry() iterator,
> which silences the warning.
> 

This version looks good to me, thanks.
Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  fs/btrfs/block-group.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 08b14449fabe..d2cb26f130eb 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1011,7 +1011,7 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
>  		struct list_head *head = &fs_info->space_info;
>  		struct btrfs_space_info *sinfo;
>  
> -		list_for_each_entry_rcu(sinfo, head, list) {
> +		list_for_each_entry(sinfo, head, list) {
>  			down_read(&sinfo->groups_sem);
>  			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID5]))
>  				found_raid56 = true;
> -- 
> 2.25.1
> 

