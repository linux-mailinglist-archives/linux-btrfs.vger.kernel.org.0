Return-Path: <linux-btrfs+bounces-3233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50724879C24
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 20:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48251F23AB9
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 19:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5F4142634;
	Tue, 12 Mar 2024 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="m2RDJtZ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNfKB0hG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB91142620
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710270844; cv=none; b=iKRItpQxMQyauth6iU1lM6PP7Kzn+I/BqC1LaFhfOXKI7UybUKbO5fZTc9NMNoFY3+Z/0+57GWxTP4BSMv6BwBhMesO4NPPga5hFx9L3buY/y3r4JD2GWpZDO10TQc6EFDgs3VJ9wjF0vZpJVk67gCOVqEYfGMW2HdT9KIFL9iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710270844; c=relaxed/simple;
	bh=/7QRYPzxqWo3sAuRURvsIN0ts8CsaavS5+tAVaGnisU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJPparhvbbRA8FcX42dgui5F29XkZaI+xrGbqaW0bFw35MV/VCeCk0Y+Ft59TXAzWJD8bmuTAVVeWm30x+Vceqngwf5ZVPh+8sXPuWIQLZ1qlL7Zt3pBFtB2CYtx0tdqhQ7Ym5FhFc6U8d485r/ltXrdiJsKtmE3v0EduSFdbaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=m2RDJtZ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNfKB0hG; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id AAB675C003F;
	Tue, 12 Mar 2024 15:14:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 12 Mar 2024 15:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710270840; x=1710357240; bh=LgDLJvmX+h
	QMF7gsHtrJ083mjl83djxJ2AYy3XAC34A=; b=m2RDJtZ/s3czPXVxce1+KFK3Q1
	iMWjdeJO9d3z4ST4tIdf+K+o0lmZcZj0ST54YZTLrSjbi3qHjOt8iPg3CieDSIB5
	e9e3hdwGH3ZnRG+cZN4Y16/rn0F03r6dXbTlUTgkH9f0Y2bKd8julX+oATY48FUy
	x+O/3+uWW7OJaEFmZz8eJBnxUIuXbCFSoet2Vn3gmeCtAVPWE2PZhT9EFPeN6xuR
	ZZjHsbGBTX7EEvFRGGT7cE42mu4xFyqXzZcswFHogSxCX0BRgM41aQRovA+85Ym9
	ErrVc2vZPX1XIdel2fLR02zfq6i/E/kn53vtE8TUR7fCPnEiZuDbsVqIHPZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710270840; x=1710357240; bh=LgDLJvmX+hQMF7gsHtrJ083mjl83
	djxJ2AYy3XAC34A=; b=jNfKB0hGs4264qbXITN68vmuz7fyTATSlHczvCE9XcuQ
	8wlAVwI0RMH5fc55DmmPzDGNv/DA0uHtOAI/9OpIx2CjqrfkJv0+xuH7f0Bzjmtz
	po19GrcD3gCYLQpWi33jwy3q+T0MpAfUgrEtMit7mkQZUwKqVQBo/Ey0oxHzQDX9
	QMEKmvrxnmPTvJFtYJIh42/LcnaKe1OGmASgmHFCXCIPATR6hJP3EhmUwQVT7D/+
	XcqXvz0aiRaz1W6jRTvw09shF6JZTA1l+J3YK+5TVskI9crZA8sZaZ7itMePTQhO
	GQiddo71h3DPC38UlM8HuiAD8DUkrRfdyEJu8Svbaw==
X-ME-Sender: <xms:eKnwZaDvIwsfPR5tDFfJliyOa6ZY6FzvD8Pm2Q2jqtzf4X29CUDp6Q>
    <xme:eKnwZUjjDPeg31YewGXas58ZPW7CcIjDt_yxfZC0zBhSOAb6TTExrOEY49yqhzkce
    mJvVxX55uFFc1nZb5Y>
X-ME-Received: <xmr:eKnwZdnNb7IDloPKwzl6_iKMUq7lsw44mAvdUwov6hFFMuz4SY-sz4wAhlR6GSPo_HePA7At2c-fEjoO7n_m-6KlFcI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:eKnwZYwHe6Mi8-SYK9MX44UHlNAp7nSnJQxOWYHx2T7tV0E3_sHESg>
    <xmx:eKnwZfTCfb2VlJ7sJ4767ay0NIf0q9pNL2vnke7mxS-49Dl7odlG3g>
    <xmx:eKnwZTbWiX0MeftKZEBHuZ590I23QfdpzMNRSCKqwe4lAq7_CB0yHg>
    <xmx:eKnwZYRKigosdi6hXd0fd0I7XW9h62MM3FgEoJZOBJ424lBaeaUBFA>
    <xmx:eKnwZWL4HqPXDxX8NGq-zIx3_Wa1BdFgAM3_USplROUjXPXUci7Zlw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 15:13:59 -0400 (EDT)
Date: Tue, 12 Mar 2024 12:14:53 -0700
From: Boris Burkov <boris@bur.io>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: validate device maj:min during scan
Message-ID: <20240312191453.GA2898816@zen.localdomain>
References: <ea6a2384807500090943f95c164e9f6b899efc58.1710246349.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea6a2384807500090943f95c164e9f6b899efc58.1710246349.git.anand.jain@oracle.com>

On Tue, Mar 12, 2024 at 06:32:41PM +0530, Anand Jain wrote:
> The maj:min of a device can change without altering the device path.
> When the device is re-scanned, only the device path change is fixed,
> if any, but the changed maj:min remains (bug). This patch fixes it by
> also checking for the changed maj:min.
> 
> However, please note that we still need to validate the maj:min during
> open as in the patch ("btrfs: validate device maj:min during open") because
> only the device specified in the mount command gets scanned during mount.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Is this a real problem you can reproduce? I'm pretty sure we can't hit
this code path with single dev fs due to the temp_fsid logic. But it
does seem plausible to hit it with a multi device fs.

If you can in fact reproduce it, please feel free to add:

Reviewed-by: Boris Burkov <boris@bur.io>

and please also send an fstests patch with the reproducer!

> ---
>  fs/btrfs/volumes.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8a35605822bf..473f03965f26 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -854,7 +854,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  				MAJOR(path_devt), MINOR(path_devt),
>  				current->comm, task_pid_nr(current));
>  
> -	} else if (!device->name || strcmp(device->name->str, path)) {
> +	} else if (!device->name || strcmp(device->name->str, path) ||
> +		   device->devt != path_devt) {
>  		/*
>  		 * When FS is already mounted.
>  		 * 1. If you are here and if the device->name is NULL that
> -- 
> 2.31.1
> 

