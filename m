Return-Path: <linux-btrfs+bounces-15755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86775B1652A
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 19:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1281AA0A16
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 17:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632362DCF69;
	Wed, 30 Jul 2025 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="XnxFqaQO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZu8rsWM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA8B4409
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895293; cv=none; b=GSFa3KpHyTmi+nKmkSsv5Fw+CH6rfl3JvNcEDrdCtDS456kZ5OpDyO5ElKOkFVD9eQXXO7VIfKFv2ckn5JdI4ACd/eHD8cfHE340ZrsQED4qRib2wSlbYaZrqXytUbkw6tOPZ3gnzA/MSPuo543GfDK5lWGiAlpZ/QreRXr83zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895293; c=relaxed/simple;
	bh=SHKn5ovoJMudbH851wZ/H+ECihvMrHvgOr+QA/+jkBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNvMoBAk83FLnVRolP+bnRxH5D3135RHUUrQ2H7uS/2dQiecg4RirKyso6mG0dutoe8sLvIxWsIeOVjKbKJthVgabGv+5n6dF3FMfZo5kimOkoWW3H/Z0zyLtRP/P4Q157/8kf3kxo5We9f5sUYOh8qAAVksvnyu06wRtPvxdSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=XnxFqaQO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZu8rsWM; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A1A541D0072A;
	Wed, 30 Jul 2025 13:08:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 30 Jul 2025 13:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753895289; x=1753981689; bh=1an/4oWF7W
	eSgZnJSxCljf1P8K3TBKoeDRs8VAaFc8Q=; b=XnxFqaQOPUNpjVhLjKji+ZQEpu
	zX9E0CSm8ACH1GT9E0ipAxveTB596vdTBmS1nvtagMFhB4p0tcbOmWS1CJmISmBH
	iC4Ydhav3aV68Zci1Ttx+9Hq47OIwJpUCO8i9r5Qse8nLWZ+mnn4GMkcvjVj9kDD
	nj2+XlifIb3cQ6JH1bdySN8lPPMIcWWlzD7xVHOA06WoMYGUrw8U/K8Z3wTjvlPy
	pMiZpGB9PLsdLx1hBaHaVLcoOoH1OOlYnerZMhQitKR6jlaVwrVneTufLONW1l4Q
	anrIueqUXzPnvSqPiWyF4XXM6G5Rv99/cENkrZKr8qIiDSkHPqyoJc1ukwPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753895289; x=1753981689; bh=1an/4oWF7WeSgZnJSxCljf1P8K3TBKoeDRs
	8VAaFc8Q=; b=TZu8rsWMx2DtM2OscyV3xDuFArVjCk/+FFLKiVBfnakfEs1bN07
	lJdirduW88djZKLNe0nikt+pXSZ8irfdyGMxttF49UssPsUS11Eze12Wu2pSItdE
	wvzEKEkocKC5ayq/yJ9bkZPLcnqnFdG8l6gmG9h/wDapfZxVOdhv2M7qJ8QZ+xQj
	SfiZjjhQcwd8JUfsixoK8jUGlRy4iJkpoi/1ptdgjyK/M0Jgr0AWaLJiVk98VZA2
	wio4EWPvEkQdlgN+O/ESSBPpQ7ciThnkd241OZnfxiH34w8N6VbheFnUQLJcXXv8
	OWh64s1wu9WLgC5sg7M3z7J+6AfjIlzMZgw==
X-ME-Sender: <xms:eVGKaLa7OmaJBW-bOkcyiqz3k4n4ClUdgkKSdQu1s4VMyrQ5hKxknA>
    <xme:eVGKaKlmuF8F5Qz1c9uRbJdRzWWlO6m0Gijp7IbH-1-QIPNdshQ5NR_LwoqEI6nwi
    QIasBodnWn_n4e1elQ>
X-ME-Received: <xmr:eVGKaPzUZcd5u7_LyrgMTtEk_m0QNjCqZucVSMNE657G3N_zVm2gBFd4xmhibk38DQaBVS4LvPoZbNIRseZ_TpUH_9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepveeuke
    ejueejvefggffhtdefveegveefkeegveelteegkeegtdekueelffdvvdeknecuffhomhgr
    ihhnpehvrghluhgvrdgtrghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgrnhgurdhjrghinhesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:eVGKaAOVzC1gwSL4h7KcYO_QQfphivX8_7-gfrZoBgRFRI6jRxpVGg>
    <xmx:eVGKaLQPWOTUFXUiOt6MQbaOCgC_B7poPxbc8N7Q6iGwEtKQ6tSE_A>
    <xmx:eVGKaGYaH8Vhe_MDzwTedW_HygBJolCWW9l7PWGDiTbHLzwCsvpoYQ>
    <xmx:eVGKaA3Zz1sPuDL2d3P6H0spwBcU4j-J1Z_aamjAyMYSRt0LgkY0bQ>
    <xmx:eVGKaIOyJ9FcMUlgDgZ8SpcNSObQzkqdRdiflhQgeKO_4AJTDtZ9TBn_>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 13:08:08 -0400 (EDT)
Date: Wed, 30 Jul 2025 10:09:18 -0700
From: Boris Burkov <boris@bur.io>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: use zero-range ioctl to verify discard
 support
Message-ID: <20250730170856.GA2742973@zen.localdomain>
References: <2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com>

On Mon, Jul 28, 2025 at 10:36:52PM +0800, Anand Jain wrote:
> The discard_supported() function currently checks
> /sys/block/sda/queue/discard_granularity to determine if discard
> is supported, assuming a non-zero value means support is available.
> 
> However, this isn't always reliable. For example, on a virtual device,
> discard_granularity may be non-zero (e.g., 512), but an actual
> ioctl(BLKDISCARD) call still fails with EOPNOTSUPP.
> 
> Example:
> 
> $ cat /sys/block/sda/queue/discard_granularity
> 512
> 
> $ ./mkfs.btrfs -vvv -f /dev/sda
> ...
> Performing full device TRIM /dev/sda (3.00GiB) ...
> discard_range ret -1 errno Operation not supported
> ...
> 
> One workaround is to also check discard_max_bytes for a non-zero value.
> 
> $ cat /sys/block/sda/queue/discard_max_bytes
> 0
> 
> But a better and more direct way is to test discard support by issuing
> a BLKDISCARD ioctl with a zero-length range. If this call fails with
> EOPNOTSUPP, discard isn't supported.

Looking at the kernel code for the discard ioctl, it's basically just
checking discard_max_bytes but in the kernel.

After it succeeds or fails there, it will always fail with EINVAL in
blk_validate_discard_range() so at least it should be safe to issue the
0 length discard (for now?)

To me, it makes more sense to just read the other file.

I like that your approach handles the kernel logic changing how it
decides EOPNOTSUPP. I don't like that your approach might result in
actually doing some unexpected zero length discard in the future if
that takes on a different semantic meaning.

I dunno, both seem unlikely, but it seems easiest to just read both
files.

Thanks,
Boris

> 
> This patch changes discard_supported() to use that method.
> 
> Signed-off-by: Anand Jain anand.jain@oracle.com
> ---
>  common/device-utils.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/common/device-utils.c b/common/device-utils.c
> index 783d79555446..d95d406d9676 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -53,30 +53,24 @@
>   */
>  static int discard_range(int fd, u64 start, u64 len)
>  {
> +	int ret;
>  	u64 range[2] = { start, len };
>  
> -	if (ioctl(fd, BLKDISCARD, &range) < 0)
> -		return errno;
> +	ret = ioctl(fd, BLKDISCARD, &range);
> +	if (ret < 0)
> +		return -errno;
>  	return 0;
>  }
>  
> -static int discard_supported(const char *device)
> +static bool discard_supported(int fd)
>  {
>  	int ret;
> -	char buf[128] = {};
>  
> -	ret = device_get_queue_param(device, "discard_granularity", buf, sizeof(buf));
> -	if (ret == 0) {
> -		pr_verbose(3, "cannot read discard_granularity for %s\n", device);
> -		return 0;
> -	} else {
> -		if (atoi(buf) == 0) {
> -			pr_verbose(3, "%s: discard_granularity %s", device, buf);
> -			return 0;
> -		}
> -	}
> +	ret = discard_range(fd, 0, 0);
> +	if (ret == -EOPNOTSUPP)
> +		return false;
>  
> -	return 1;
> +	return true;
>  }
>  
>  /*
> @@ -278,7 +272,7 @@ int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
>  		 * is not necessary for the mkfs functionality but just an
>  		 * optimization.
>  		 */
> -		if (discard_supported(file)) {
> +		if (discard_supported(fd)) {
>  			if (opflags & PREP_DEVICE_VERBOSE)
>  				printf("Performing full device TRIM %s (%s) ...\n",
>  				       file, pretty_size(byte_count));
> -- 
> 2.50.0
> 

