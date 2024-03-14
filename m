Return-Path: <linux-btrfs+bounces-3295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB3187C1C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 18:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B00A1F2214A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E497441E;
	Thu, 14 Mar 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="o0adAcgQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NcIONeim"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E818E20
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435869; cv=none; b=nTgyUX/byp01c7Ncp8othO4mrUOVolecXLmVGR3g3YnGztugnz7eai4J51AOrV32kN2L5AA6lZO+nAAqtnJXPSrhobuM+5rU8NsLJg+7j4ILILRQdXQmkaFKhDg5TfolZ79+lRIsEY7gqiEo6TDWlYeZahKeKDMCDl5oWYFJC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435869; c=relaxed/simple;
	bh=hACYea5m6gwzn1Zup85zBeVH2i18wXEyCOk6mcqegW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbYGqoL/DhlszDjr9MBLIv9vznSqb6FVPokmVkhURYqHOkpE0IEEWBMQNeQXO4dVTCUs4MX0sOHCwyNu+WQpymXdxQER5TLaHTb2B75drK+0fWXB3r1XURdy5ECjDphZrhqPvJytPkb0aLAbD0tFhrrUCKbY628Cn0DenzKVDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=o0adAcgQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NcIONeim; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 914555C007B;
	Thu, 14 Mar 2024 13:04:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 14 Mar 2024 13:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710435866; x=1710522266; bh=RaUkM6fAXo
	XZGZnoy/howh+UlkNDq2HGLSrtnP/WvC4=; b=o0adAcgQaRgF2lrc2nj/RaFFe4
	gN/1rjKlayi2G08mkPhvXg/NB4oW6FVYNH8a7Xteg+equo9s2g44k/0YMUyComQ3
	0XFT4ToOui6kNJciaDmTtHUeWjsqbhGWWnZlzd74diWARkZTXOQOPbtDPCp6u5up
	Mvrrh722mSeIhmB4iID7WrlWGFqbDSXIaxBhaCjiYF1m44uVFfGYjBzWkS07qJGG
	4YmKuLjvV7zmKNaQE5r6YS7iL0xmeNlUT5P6QZCtf+6e2lZ2PTd5/1Va5JmeJd5w
	njHduNSXwp6+TEkod1DGAKcvnSfevSejyamRLKzyGZ1VboRmVnwcZY+BBmXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710435866; x=1710522266; bh=RaUkM6fAXoXZGZnoy/howh+UlkND
	q2HGLSrtnP/WvC4=; b=NcIONeimDEj/yj33GQVGTGSg0IGowbGoIEW/3xZ/uP7g
	HATN9h0dsXPbJhtRgGSaVddlwGk37PyH2xjANWEPG6Iaz+X7z4HANRxUw6K55lOq
	gTRiK/HCu6MDq4jfvetBt0K04J5O3UFs+Sc7xB4ZemsRRGCbL0ORsYHz/US/U4ET
	MLjPmovt4gTiX+0xP+VAAQbipQOMss+gj8HOnsUJQbkte3Depuv8ODRq7KAbfgRq
	uGWX4xC/8HcktF0dVTKCSfhjJWwFm35GyNgErIQZIrYr4/Wo57ymRRbSh4pj5/uz
	2ii1ETLDzLKaWQkWrUU2/4UkbuRsKd3ZSzccj4hRJQ==
X-ME-Sender: <xms:Gi7zZWm63kwc_iXXHn3yb6Fr2neQ3Mhk909C1A9M3TzKEBIGF8jORg>
    <xme:Gi7zZd3QEQWs5N7fCU0L3Bc-vkQPNrz65qdxXBhFiVUq0LGc5zu-oJhMxA9fJvgkS
    RRVOcnlWt9SRsCROvc>
X-ME-Received: <xmr:Gi7zZUrUWFMbCHaqHCbtYXcz8E1cLZdusLowwRPuR4vnWpaK3ftfkkdTAM43pR5rl1nqVak4ih_WyjZI7HzIDrKHKpU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeejgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:Gi7zZalLqHDsgA_ax-8bZSo5FXNqL794_np-lYsfb4KK9yo51AUVRA>
    <xmx:Gi7zZU3RsbXQfR_zIkej4V2_Et0qqa-3iTANiqKwa66VmgzUmP35ZQ>
    <xmx:Gi7zZRvoo1gmY1YACWNZ1IfjSB3J91uw2atc1NClFCkrizUzam-Zvw>
    <xmx:Gi7zZQWn09X7qEaQ4tYbNinLjBOv3j4Ddpu2Tq18beB6_NOz-FgOQw>
    <xmx:Gi7zZR_Dcw6FaLEE0Yr4PsUEx1VuFpaw18b632DwSKJMTxWOgSXB6w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 13:04:26 -0400 (EDT)
Date: Thu, 14 Mar 2024 10:05:16 -0700
From: Boris Burkov <boris@bur.io>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: forget stray device on failed open
Message-ID: <20240314170516.GC3483638@zen.localdomain>
References: <cover.1709991203.git.anand.jain@oracle.com>
 <7abddd87a9b1be4b6da6173478f2ccbcd3117dba.1709991203.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7abddd87a9b1be4b6da6173478f2ccbcd3117dba.1709991203.git.anand.jain@oracle.com>

On Sat, Mar 09, 2024 at 07:14:29PM +0530, Anand Jain wrote:
> If the physical device of a flakey dm device is tried mounting it fails
> to open the device with handle, and leaves behind a stray single device
> in the device list.
> 
> Remove it if the open fails and if it is a single device. As we don't
> register a single device in the device list unless it is mounted.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/super.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 29fab56c8152..4b73c3a2d7ab 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1820,6 +1820,9 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>  	fs_info->fs_devices = fs_devices;
>  
>  	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
> +	if (ret && fs_devices->total_devices == 1)
> +		btrfs_free_stale_devices(device->devt, NULL);
> +

It feels like we need to do this free no matter what the mount error is
after this point, not just in this one place.

>  	mutex_unlock(&uuid_mutex);
>  	if (ret)
>  		return ret;
> -- 
> 2.38.1
> 

