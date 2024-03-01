Return-Path: <linux-btrfs+bounces-2971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2755086E461
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 16:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91FD6B23D6C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 15:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CC56EEF7;
	Fri,  1 Mar 2024 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="kGMMepor";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YAI4LduW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545111C33
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307215; cv=none; b=bL73ofPIp8TR6LzCI9wwgie1KHGfn5yde6fx38aKC0mD150WPiYf8ndVMcGE9iS9Lu1Plm17koaz0opr4TQ4jy79nYv5YMxl/QWZpD798/VD4AqdDhZPhKkVD2/vQEGxU2M5IXFpx8D6bsCKdoztzFU75suWiCO3N9dXg6Et4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307215; c=relaxed/simple;
	bh=fn70h0dhp6kMKmk2eD9f715hgyTyCsfrlbuVH2pc3C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgwAri5oi/Y+VJeg0f/Na3CYqwicOavb42wyE3nT6mDXLfS2SEDiyb8X3br8JcUIe650DlKCHnaoR3WxPyhFhoT7EQGPchRdKs4e60DF/+S9tGAvcomsWlTQy/VnSX60gXuF6/rNkup3P9P1/sVllTt4Z3Cc57Ximpjzp9RW70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=kGMMepor; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YAI4LduW; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 1D6C53200A4E;
	Fri,  1 Mar 2024 10:33:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 01 Mar 2024 10:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1709307210; x=1709393610; bh=UdUt1ZK2+R
	EbGo0acnlKTnUtujviq6Lb8LyThWytlvk=; b=kGMMepornUKz2iNrT2LevJtBBC
	I51bPbj9+zEviYfP591WoPsnNJEj02sjd0lu98vfa0WviBQxxTMDLBF22q/ECpIP
	QSuphP8nTzD3wvC8h9U5Rz22D2QCeS2yy9tejdAX0c1/XejyItYF8PXEj5n+Y5MT
	CJOa1ueYe3BcuXl2Mt8B61E9Gv7v2WCieTzeGZWEYwbAPUGT6ng0d5gIaAt2Ssmy
	ZT+Ul/YQnATOowxtgSLsl09wJJSW1QbhwdN6LzxFYg03+chXjev3a64E9F5F5ZRZ
	QcOV6zf2a3txMBRM5TOZ0jnK3D9tRF7lXwOLd1Z8t/wxymOWXFksgqVezYKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709307210; x=1709393610; bh=UdUt1ZK2+REbGo0acnlKTnUtujvi
	q6Lb8LyThWytlvk=; b=YAI4LduWySbq30CB2ENmeghMeool0ACq+yEv26/OIr6e
	86y2c61MGf0nZdLik6GLAM3bQG3g8W0pdIh56Q6BuE7Hg4zH/Wz6R949MVVuhdi1
	6UNrX4ajlTQanzHcPzTzQMK192PWUcDpV5zo5qvYbhXsU5fMN+uqcN/WMdG7bySo
	l867E+y1S06zkeAO4zMVoU4vYa4cEmy5e6/cOV19hwB2sACTOcRnUNPAuAk8RDHE
	IpJziq5Eco2odsen7BRWKaECcvYU0QzGEfjQw0BiGDlvjDnPHjT41+E+5vcNCKc1
	bOzywbBQ8Mmbmn8JolYewKArcvLGVXXi/xAf+362eA==
X-ME-Sender: <xms:SvXhZcZwSAxiStfKSeQmsxAfJUkrEQIApUefpfjn2PHttoFOZDB5lQ>
    <xme:SvXhZXYEqELLh5_MhDeaB1TK7x0DdxqoPn3Sx9VRPRVI0P6VV3lzD7s3ususjQAIX
    soRnJ8hOWyAiWHDAX8>
X-ME-Received: <xmr:SvXhZW9CtL2fMkK8zBun-70ywi20bsWiDecLjFoKNNmDQm6EffGDESGToezGGCfz2ERrzTkWDB-rx5QR_Rb7_8AVeXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrhedugdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:SvXhZWpvp346IgghlD5sJZf8ailB2am79veFZNrJ-dJJ57bOyudPGw>
    <xmx:SvXhZXpwXzlbJz1VlPm_oWOzNAwsJBfFxC3VJvaVjkEO6MOpaT8Nzw>
    <xmx:SvXhZUQcDyr0d3cxtpWZlEwWHC_bmGMnWXhofNPIAXE4NqrSaS3bEA>
    <xmx:SvXhZQA-cV1b9DBNGPtLvO-D2KLUcWixQmP2k806yukNlUIqDMMjUA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Mar 2024 10:33:29 -0500 (EST)
Date: Fri, 1 Mar 2024 07:34:40 -0800
From: Boris Burkov <boris@bur.io>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH] btrfs: validate device maj:min during open
Message-ID: <20240301153440.GA1832434@zen.localdomain>
References: <752b8526be21d984e0ee58c7f66d312664ff5ac5.1709256891.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <752b8526be21d984e0ee58c7f66d312664ff5ac5.1709256891.git.anand.jain@oracle.com>

On Fri, Mar 01, 2024 at 07:21:32AM +0530, Anand Jain wrote:
> Boris managed to create a device capable of changing its maj:min without
> altering its device path.
> 
> Only multi-devices can be scanned. A device that gets scanned and remains
> in the Btrfs kernel cache might end up with an incorrect maj:min.
> 
> Despite the tempfsid feature patch did not introduce this bug, it could
> lead to issues if the above multi-device is converted to a single device
> with a stale maj:min. Subsequently, attempting to mount the same device
> with the correct maj:min might mistake it for another device with the same
> fsid, potentially resulting in wrongly auto-enabling the tempfsid feature.
> 
> To address this, this patch validates the device's maj:min at the time of
> device open and updates it if it has changed since the last scan.

I do believe this patch is correct for fixing my test case, but I don't
believe that it is the proper fix for this issue. This is just plugging
one more hole in a leaky dam.

> 
> Fixes: a5b8a5f9f835 ("btrfs: support cloned-device mount capability")
> Reported-by: Boris Burkov <boris@bur.io>
> Co-developed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index deb4f191730d..4c498f088302 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -644,6 +644,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  	struct bdev_handle *bdev_handle;
>  	struct btrfs_super_block *disk_super;
>  	u64 devid;
> +	dev_t devt;
>  	int ret;
>  
>  	if (device->bdev)
> @@ -692,6 +693,24 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  	device->bdev = bdev_handle->bdev;
>  	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>  
> +	ret = lookup_bdev(device->name->str, &devt);

It should be fine to just use the dev_t in bdev_handle->bdev->bd_dev.

> +	if (ret) {
> +		btrfs_err(NULL,
> +	"failed to validate (%d:%d) maj:min for device %s %d resetting to 0",
> +			  MAJOR(device->devt), MINOR(device->devt),
> +			  device->name->str, ret);
> +		device->devt = 0;
> +	} else {
> +		if (device->devt != devt) {
> +			btrfs_warn(NULL,
> +				"device %s maj:min changed from %d:%d to %d:%d",
> +				   device->name->str, MAJOR(device->devt),
> +				   MINOR(device->devt), MAJOR(devt),
> +				   MINOR(devt));
> +			device->devt = devt;
> +		}
> +	}
> +
>  	fs_devices->open_devices++;
>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>  	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
> -- 
> 2.38.1
> 

