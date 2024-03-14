Return-Path: <linux-btrfs+bounces-3296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8807A87C1E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 18:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E328283E74
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DFF745E0;
	Thu, 14 Mar 2024 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="I7517JuI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iCOXsH+i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA899745C5
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436271; cv=none; b=P8jzpKRV9GoebGbb1cNuej7zffh6ciAnjwz83IWnqM0wzlB+GeDaqUKPHdyw6s1RuDN5KMb7WnXnRHghleVeTWihgWmz2tuz/B4pGecdsFOjxVs6kc8dP7NbdEdqeti35ErFfscadY96PGTHRusXGar/KYMED10XkfH3VJ6PV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436271; c=relaxed/simple;
	bh=sHqrX7U02t+IOVDct12T+ZMYYcin5p7bYAjYjeUKIPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gy6ZTZ2BCBUL/dpMrVS+qRnhGNANz2WraShZT/ZOQ3KqDb1/XgXAPRBhaIQr0NtGe/IewQCHsazPXTF8zitOKJlvCYkE51hK3mbb4BZoo11kk1DBEbf5yZSF7/T/4at6joVAGC81HQACdlqq62EPD/SzZRT6ZZArCy6j0BEz8MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=I7517JuI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iCOXsH+i; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id EE0D05C008C;
	Thu, 14 Mar 2024 13:11:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 14 Mar 2024 13:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710436267; x=1710522667; bh=/3RFwaeDsI
	NhOA3XGRsSKvWRV3kQlTeC3qSAwwWnJI4=; b=I7517JuIo8gjy0ZI38V6bFxQFb
	riDekW/YStUJhzNwEM6DLrB86m0UWVSCsR4Yis914rlTv7RkY938tKA/jYQsILUa
	kVL5tjk6ztos/V6LYKQVqG32n3hr7farH2fwO5CRcUABvVGmWHObYcNWN/9UNC/G
	j9nMxcGBJhGruVNhh+JKIa2T7QHjDHKLzg2ZVKOvct+qsnoEu/T2zvpDpJRgBCw4
	dUlcfKmPAYzpijLPjvX+nt7YCE6GhueTn0wQZXdI0WS9OGr8204FTMbEDIp3Ejoy
	mTlwrfFydnaq7T1z6YxYOvEqGNtEMRJF9km6eIwwaeV+zZjmOQqaQNkX9Onw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710436267; x=1710522667; bh=/3RFwaeDsINhOA3XGRsSKvWRV3kQ
	lTeC3qSAwwWnJI4=; b=iCOXsH+iHRZb1jN5kL/wX67C4VOsL1oMEh44QYu2N3w8
	6kTXvK84d8hnzAFSAYCPSDy+DAJODJdntE7Le7WIrOPF4dYWlytiLzVrMIhBIkjB
	ROD/bAC6aLGtDxlfXfQGCiS5SWfhUmnMk/nVMYXxjQMZ6Kbhc7I0GEDYyaT1eiIv
	An3x08HDb7rBgAH0IJar1g/burBzcq2cuqzT9/S0rdf3jI7DkYzXif9bviY5LYO4
	GHeIBRLLENH/oUguXJzGnPOrJnw7fLg935sYA+UkwPWl430CwOorCX3iuKbvmLdo
	ym0kesokQqG8zgzHo+knYtUxKJ/njp49XFBBONCYww==
X-ME-Sender: <xms:qy_zZS8gxkIFiIOEn_EvBoS7aIKM1sc8R1fSFExlI3qx0jz35b3yBA>
    <xme:qy_zZSsKkCTGVpSuDA08n-vajxf0-9_hs_3aDmkPCDZz_g6yGNSnYaac6dnKaqg2O
    y02M5cYcbZkCgwmnAw>
X-ME-Received: <xmr:qy_zZYBOe5s8sprxWLJm8Y4_Y9TBMKjHnNHyU6WDQzQlL5AhH5rTN0lB8dLKJSnQ2UGr1f8KfYvunK-7jzOjtiOG2ys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeejgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:qy_zZafY6p7c3PAGVms-FNm9diMvqGG22K80vJBjwvL6armBLLNURA>
    <xmx:qy_zZXMN3HBTwqolf265squiy30tDZuFFPJwBaiszooXDHAsywcMQA>
    <xmx:qy_zZUmosWKLYtLVDohwvDq3xBEVENzJiBkFA9wxusRWWU2hRs3CVg>
    <xmx:qy_zZZvOv4YaHHMmiBOw-WwdReQDT_m_VtV0BFiS7mcXKbIACq6UPw>
    <xmx:qy_zZd2xT32IFcXrHcSKfC5rUvNr93LBHMXvBfP-sieF1GxCW3CKbA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 13:11:07 -0400 (EDT)
Date: Thu, 14 Mar 2024 10:11:58 -0700
From: Boris Burkov <boris@bur.io>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: validate device_list at scan for stray free
Message-ID: <20240314171158.GD3483638@zen.localdomain>
References: <cover.1709991203.git.anand.jain@oracle.com>
 <87d75575e16637a84b82326d5c53cb78cdf9a7e0.1709991203.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d75575e16637a84b82326d5c53cb78cdf9a7e0.1709991203.git.anand.jain@oracle.com>

On Sat, Mar 09, 2024 at 07:14:31PM +0530, Anand Jain wrote:
> Tempfsid assumes all registered single devices in the fs_devicies list are
> to be mounted; otherwise, they won't be in the btrfs_device list.
> 
> We recently fixed a related bug caused by leaving failed-open device in
> the list. This triggered tempfsid activation upon subsequent mounts of the
> same fsid wrongly.
> 
> To prevent this, scan the entire device list at mount for any stray
> device and free them in btrfs_scan_one_device().

Is this an additional precaution on top of maintaining an invariant on
every umount/failed mount that we have freed stale devices of single
device fs-es? Or is it fundamentally impossible for us to enforce that
invariant?

It feels like overkill to hack up free_stale_devices in this way,
compared to just ensuring that we manage cleaning up single devices
fs-es correctly when we are in a cleanup context. If this is practically
the best way to ensure we don't get caught with our pants down by a
random stale device, then I suppose it's fine.

A total aside I just thought of:
I think it might also make sense to consider adding logic to look for
single device fs-es with a device->bdev that is stale from the block
layer's perspective, and somehow marking those in a way that tempfsid
cares about. That would help with things that like that case where we
delete the block dev out from under a mounted fs and mount it a second
time with tempfsid after it's recreated. Not a huge deal, as we've
already discussed, though.

> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 60d848392cd0..bb0857cfbef2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1382,6 +1382,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>  
>  	lockdep_assert_held(&uuid_mutex);
>  
> +	btrfs_free_stale_devices(0, NULL, true);
> +
>  	/*
>  	 * we would like to check all the supers, but that would make
>  	 * a btrfs mount succeed after a mkfs from a different FS.
> -- 
> 2.38.1
> 

