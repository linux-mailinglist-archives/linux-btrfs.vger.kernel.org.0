Return-Path: <linux-btrfs+bounces-7033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D54B94AFA4
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 20:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766601C21328
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D70E13E02E;
	Wed,  7 Aug 2024 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="M/vG2oBY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6lR1v7i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE71535D4
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2024 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055124; cv=none; b=JpgL0PEnZiG4JtUP31pMeNiPED6iIaeeXooWFbxAm7MALY7drwylfmXwYNC5HCGTQu1Sw1mgQGQ77NlP+D8c0FwaAsUq4TKLsRLhDK/P6GpMAzxT4KB8y4uk8MjOKARHagfPUhFeyWaZY2bIBTCkMgT/llMSO0RNze3xgA+ilwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055124; c=relaxed/simple;
	bh=weiggL5LTujzskY4bl6CX0muEUGZQHaOYMOrm4LWW/E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbYys16nuu2su9vobX0g0+ZnEOy1HnyZREvj38EOeYgQHMMPWnG9jo/NfqGuXmEKzdLEHvSn/prJ4EFqMExL0GimN8IEXqmjNsztEEbLTTIeOhz84P+jV56navJgWRmS+JNczFRCaPDbFy7fLsAH/lWkZ9auQX+buBtz8SyGnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=M/vG2oBY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6lR1v7i; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 69515114F5BE;
	Wed,  7 Aug 2024 14:25:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 07 Aug 2024 14:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1723055121; x=1723141521; bh=RWaEZMN3vR
	cPYsVH6pi20u0t1bPeRuKwqwWEQA+Qm4Q=; b=M/vG2oBYrr6PDfS/6geGagnJiN
	oo6YktThlyPt0zIw7RPn5MXim4nL4+AL76A3BjvTreeq5SLnZ148CgYNun12Jqmn
	Y4uWV3zya9PJBNC1g0RiBzoLzZAqih8eN2IAuCJpK+HJJDf4NHLmExi3wnQUz+B0
	jta6TTvnl1g/Q5jFFiktvU+FLaRWM/lClDNAMWMKjs1mUj7A/98Um6wnIUgvVdXJ
	yQN3iHsrBxUU7ea3VWkJYB44hWjnSh56g2E/31tVbr//PCjCl+6LpSp2qEbQFzq5
	M7b5yFPR1+D2wpnr4HaRgeCH4Si1q5PBcbThzlbQY21+3NZ6TKJyKTy1WcIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723055121; x=1723141521; bh=RWaEZMN3vRcPYsVH6pi20u0t1bPe
	RuKwqwWEQA+Qm4Q=; b=n6lR1v7iR1zl57Zqit6LCpu0r6jLf7Kz6lLDFXSzCnUx
	yhkJGKu3DIMs3GEsYndiI8E44TlHdsBgMh9SWUWQn7jTg+l2PoUt/QFYznWzJ/hH
	1ScCY/ijuggwCGBA4cjwYxCBE4Arw1D+mB/Z3V2/FotAFQ8aAIMqTLkIffige/kb
	JBzg6guomiy2yoqhCJvUGZXrL+jhZRGLnKWLbyOMqMdzbud39T9vngyW9TUdxnGa
	RXo7UK4/9osye5cpRRuYWX/brbI21vbHdNy+ti4NAvhLHCq0b20YtJiVAtLFOcTP
	88vK6bQNwhFV6KwcmYpSiDS66BMlS1d4LeJuvh2btg==
X-ME-Sender: <xms:EbyzZmqIvuhAK56IgTdVfSJFSeyNIXxw9Og0sPi2Uy_aHoHKS2b-Yw>
    <xme:EbyzZkptXT34HJ2tvOrQRZfMXBkuucy_3ihHDlzFgG1MkvMOLmCHFBRLKPG3YLo54
    7vCPJBq_7dxXWyF2dc>
X-ME-Received: <xmr:EbyzZrNckPQeeaeKXetqp7Pdq2LLvxo_sMBCjyrl5y1aJnjC0CRtwUOoVwWMug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    duveelkeeiteelveeiuefhudehtdeigfehkeeffeegledvueevgefgudeuveefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:EbyzZl62p8hxLoQaC_VI-U-JfKD_T13cSfOm_mHc2duAvMp9reNT5w>
    <xmx:EbyzZl7eLPw6Lat3IaS3UCptjPQ4bmV7apC2NrKGi3BsuDBrvt2y3w>
    <xmx:EbyzZli-cbJrvRFFRNbXYwieszo77sLbLmc07mMAxQOfWp-Q96CVsw>
    <xmx:EbyzZv6sLmfGlxs05TSlPYqoxTuxJJbPL_6WzU1w3rfZLniSsloRxw>
    <xmx:EbyzZlEZRqKPT8B2ORuXaTXL3d3QC1gPvcAmfA524XJ2R7dfDTay7RxP>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 14:25:20 -0400 (EDT)
Date: Wed, 7 Aug 2024 11:25:15 -0700
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: directly wake up cleaner kthread in the
 BTRFS_IOC_SYNC ioctl
Message-ID: <ZrO8C/hMDp52cYXs@devvm12410.ftw0.facebook.com>
References: <b4c0f0bc574a1b105a02132c2ebedb0e31f235eb.1723052137.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4c0f0bc574a1b105a02132c2ebedb0e31f235eb.1723052137.git.fdmanana@suse.com>

On Wed, Aug 07, 2024 at 06:47:50PM +0100, Filipe Manana wrote:
> The BTRFS_IOC_SYNC ioctl wants to wake up the cleaner kthread so that it
> does any pending work (subvolume deletion, delayed iputs, etc), however
> it is waking up the transaction kthread, which in turn wakes up the
> cleaner. Since we don't have any transaction to commit, as any ongoing
> transaction was already committed when it called btrfs_sync_fs() and
> the goal is just to wake up the cleaner thread, directly wake up the
> cleaner instead of the transaction kthread.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/ioctl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index e0a664b8a46a..ee01cc828883 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4765,11 +4765,10 @@ long btrfs_ioctl(struct file *file, unsigned int
>  			return ret;
>  		ret = btrfs_sync_fs(inode->i_sb, 1);
>  		/*
> -		 * The transaction thread may want to do more work,
> -		 * namely it pokes the cleaner kthread that will start
> -		 * processing uncleaned subvols.
> +		 * There may be work for the cleaner kthread to do (subvolume
> +		 * deletion, delayed iputs, defrag inodes, etc), so wake it up.
>  		 */
> -		wake_up_process(fs_info->transaction_kthread);
> +		wake_up_process(fs_info->cleaner_kthread);
>  		return ret;
>  	}
>  	case BTRFS_IOC_START_SYNC:
> -- 
> 2.43.0

