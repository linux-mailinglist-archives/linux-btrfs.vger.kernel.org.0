Return-Path: <linux-btrfs+bounces-16004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB178B218FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 01:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B371907E3E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 23:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D53223C509;
	Mon, 11 Aug 2025 23:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="iK/GwWxW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MF+PBbIh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77302581
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954018; cv=none; b=RhdWyetC6XMC3FCw3lGxjYLdjnMpZEcssGj9h+j4ATI7YglGZu/obOpKNTVhVCT7MwewyAXRkPRb59Ok2+MsIUeFvNPCscE/M42fSksGPAZkNCNsmwVGFnzRX4ZeQiPczsaF18iOV53PURKAJLsQJqPR7O61k+6//cHYyJcD+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954018; c=relaxed/simple;
	bh=rAd+UiTVq2P/XvsSV2UdDnkH0vNaofc2A9dzxTTNLwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgCFY256nIQqrvwm4DLQDnQGfSL7HvdWL0/Ohlev8rQin85wszSOLVLKaQxMfoe1FN9DBsa8kyS/qVHEWnKs1Sey6F2hwUmVyZM0TIdOWnKHzqj8eL2a2VwZVWqOy9EK2c/ctgiNCcgpAVzhpnIPPm1tGgVAuyeB4/uZoZ0438o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=iK/GwWxW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MF+PBbIh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CB538EC0221;
	Mon, 11 Aug 2025 19:13:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 11 Aug 2025 19:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1754954013; x=1755040413; bh=oJkdlOF9F5
	3iINdREgXNRdqvuDEyI9zFblbT8/dIVMY=; b=iK/GwWxWlN0oddW9ZXdlKkYBSH
	DizG/ZXKJwDm0w4MUU623aDB9U/cJeh0ooj4DXZb83FImYV7Cl2IEsgs0oko02Lc
	Pg+b1OrIQaKcMKHYLCQSVYbYfsrVy2v+X6dETBETkHTfgkuQ6Ui7xPJYQslLSWHe
	HVGjlboj6aUaf1hmGOULG2/xlOvSyHxqg1JPiETGWGzy14sj/9QHx6WjvFP6QKY+
	z2R6eCH191VLNcCMvhWwltS2OLuSvTMl7wneXu7U0f4wUaGxWwnPPLUMDME+W1pZ
	dtehBYMxqJlYouYgzCLO7/PvyEYygS2/Eaoai9QwqaiLTObvBM7Capy2pFBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754954013; x=1755040413; bh=oJkdlOF9F53iINdREgXNRdqvuDEyI9zFblb
	T8/dIVMY=; b=MF+PBbIh4inHyLdF2xKVxDjbnYS4CQaQmQinPBgyBdlVVk427IS
	ZO8rQhtNB6GY21eDxAE1OsoeiOfU/CjINfNACxz+/fCv4gB4/iN93srToMYHcb3V
	t1TW6wapMIEmDtVlen5EDC+Okq/Ir+FErYlnvVo4jAGx+AJf3lZmooJ6HH+PuLRJ
	VDNi4+7fx0a02LKvamt1oEJhnUlZ8ESlL5TubCip/cvpoAfeFL2aepnH49cwmVck
	IQZUNDmqwX7OaLzHMDGxyJcpA9h58Zumv4WLMObQVX1UO3iftq8wKMwDTazUUfeq
	bNBDrpB+VXR4J9rPeoxDPl/w64yN8PI7FjQ==
X-ME-Sender: <xms:HXmaaGcwXl9SR6c7S-Ppbi-qX98JJAvRofQ9WR75xG613z-lM8Mclg>
    <xme:HXmaaDcuCWAO6niIKEiEr9ZYlDvWF5rB-oJeXVXegMmptyLhKXirvHlzFHYG7-7H7
    PK5tsq8e5QmYVu8QbM>
X-ME-Received: <xmr:HXmaaA-b7FgyQQiTPNmTRu1eYhmltac99-iAZ6ln6FJr5X9um_iFysAHb-4ULuUNVu7WQh-EUhehg_xHnEr3hfL-z2tViH5EY8Kj8cbFu3sY5al3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgrohhhihhrohdrrghothgrseifuggtrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegulhgvmhho
    rghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HXmaaPn6Qs4CV69CKOG3ktm4B_s1gbR1jsMi-hWey-GzYaRrK1Vb8w>
    <xmx:HXmaaC8THlZ7ioxz3OsVdTJ5sZtRQdCavQBh3SLKLONePOuwdheM0w>
    <xmx:HXmaaNluMY_wpCuBXX5S5cJRecMBpX0cCHy-9QQlX6rGln_1MAfEZQ>
    <xmx:HXmaaP3o3SLpdke6KpVy7xnz7-VtjipmKdIlC9lbhRb2s8NtpT7Mug>
    <xmx:HXmaaOlOoEvGioztMuZijzhLvQoy0zO31syiGFyOydGNfM4Hv9JYZV6t>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 19:13:33 -0400 (EDT)
Date: Mon, 11 Aug 2025 16:13:30 -0700
From: Boris Burkov <boris@bur.io>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH] btrfs: fix buffer index in wait_eb_writebacks()
Message-ID: <aJp5DFDRpiX9yUWn@devvm12410.ftw0.facebook.com>
References: <20250811225840.501895-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811225840.501895-1-naohiro.aota@wdc.com>

On Tue, Aug 12, 2025 at 07:58:40AM +0900, Naohiro Aota wrote:
> The commit f2cb97ee964a ("btrfs: index buffer_tree using node size")
> changed the index of buffer_tree from "start >> sectorsize_bits" to "start
> >> nodesize_bits". However, the change is not applied for
> wait_eb_writebacks() and caused IO failures by writing in a full zone. Use
> the index properly.
> 
> Fixes: f2cb97ee964a ("btrfs: index buffer_tree using node size")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/zoned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index d9b26a48cb48..e264310b8d6b 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2260,7 +2260,7 @@ static void wait_eb_writebacks(struct btrfs_block_group *block_group)
>  	struct btrfs_fs_info *fs_info = block_group->fs_info;
>  	const u64 end = block_group->start + block_group->length;
>  	struct extent_buffer *eb;
> -	unsigned long index, start = (block_group->start >> fs_info->sectorsize_bits);
> +	unsigned long index, start = (block_group->start >> fs_info->nodesize_bits);
>  
>  	rcu_read_lock();
>  	xa_for_each_start(&fs_info->buffer_tree, index, eb, start) {
> -- 
> 2.50.1
> 

