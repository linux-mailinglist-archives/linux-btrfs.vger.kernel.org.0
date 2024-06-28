Return-Path: <linux-btrfs+bounces-6047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A34D891C704
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 22:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCEF1F221C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 20:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DDB76F1B;
	Fri, 28 Jun 2024 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GA4fEesG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pgWbhkeE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA4481B8;
	Fri, 28 Jun 2024 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605071; cv=none; b=C22vXhBPmVwWhsVAiVje14lsXOo8cyO2hWFCyfLESuV/1FexcslhnZXwkzjIaIdcQZJUZnDOLL0ptcO7bTILLJ+8fr9/LP8bzDq98nn2BXgO4h9R+gCded5yZgMuRw3g8tCQgANsZHwhYjpOyxsADIHJYne+FSHvqJIUcdRZLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605071; c=relaxed/simple;
	bh=CshgPMfLB35phJwPPQdnZDuqjiZMs5FbfMAbw3IBA3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4MtfD5k1VnY5dk0aAujZw0XyJzwiVlknWoUYMoUm8jGnGxvv1VAqaVyFXXopKr5xka7XMkWCwuGPhx0Km0Exyv0TMJeEez7jh/43r6zwGEQ5VgloGQwc6N4ANTmt/CAbCpugssgTR6onDy7mrP5VI4/KEMQrjaXbHV8BS6+Swg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GA4fEesG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pgWbhkeE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id BE088138037A;
	Fri, 28 Jun 2024 16:04:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 28 Jun 2024 16:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1719605068; x=1719691468; bh=5MwgQZ3S0l
	BnPLtQHFGuH0xjiFtoWFYAcoPhw4VggFs=; b=GA4fEesGgrE8SfmRd51EzM2zFK
	iaCTzVeDXyALK7d7DWbtnckRLbhABVLzyoPW79xKqHljBS7fWg+UnRECMmpGy1JY
	Hc2s69uqc7H8lHSfDx3bZnHEjqgZQS8qn1B0VcUrFgMdFkxJ8WD4Yh8QwgX4fLrR
	//P56Ibwxe8WxLQqbfQULpVUXqdR6X6U13fgM3LmkiYRM+62Yol43Y2tEnQ4Ssw1
	9KDcOywP9BWk49b3y6huSpspGswMiTaGN3zL0b3iDwAXvlhcWyhFm6xdXbRn4ffI
	ZJHS1dKK15cCnrV2MUT/a5iZi3+kAE5Va9UDOCAapqMZmi5ziik1okuFF5Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719605068; x=1719691468; bh=5MwgQZ3S0lBnPLtQHFGuH0xjiFto
	WFYAcoPhw4VggFs=; b=pgWbhkeE2cK6t7gNScWlpoHUtuDDvfoaKu87P27IGtcE
	NW4DecqYSns140Op1hEdCj5N4CXl42jFK54QAlUTtNt0kmpsv+0HMU4/dQXglFQr
	cin+QsncnqYgrXuahmMKURUOucmS2GtOgPUjRsZJvwGm7ee7GNTTE3GDN167nifC
	dktHppMMC8hkIOThPC6JsPBJ0ml8aeThwDQ5aIFXmzlQ21hjTfdl0rZAO6bSeMMl
	GJIp6Sv5thF/78rcSotrN03lHfZsQ4xVl3F4txW8AL8xrXd/V1hgX1K6PuVhdD2B
	VgKC5BR13shoBH3OjgCuDNTujDCfksUU+wyQ8rXcLw==
X-ME-Sender: <xms:TBd_Zpev1gFTpQIGqbv3K_QibToZukNt3nIhzwM98qI554d6XSWFgQ>
    <xme:TBd_ZnOJVMMqA2Z4E6KtC3dJ47eYZnNGrbaT14t-WoFvyMJDMh44JCmdfr228DgJj
    ud1t5V_zVv7iqFV1fA>
X-ME-Received: <xmr:TBd_Zigw4IX0sR-eGGTG8YeWpA66dUfP21w6uDpfzXSprER_HE218Ba7rPMMvfHsHNAzAGXqYDBg2_AXtnya01AvefY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdejgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:TBd_Zi_de8XAM-LEwXV_QJxGOVAXpTMB4FPuvYvpscBFwLjxjxSlwQ>
    <xmx:TBd_ZlsrDUSS2gRtVxQDu64Bff_Di0dC9me8tV4kST0_HZ-ghHmgAg>
    <xmx:TBd_ZhHUWTHF_QhJKFFm61Mlw9sfRvfRXLpDS8B_-9xzTu7wLwyhxg>
    <xmx:TBd_ZsMiEGh9bvLgJcqE6fe1ohHRqBJCvyjVSErOYkMfaMOlQhLW8w>
    <xmx:TBd_ZvImzOcQgATG-kYpQU11DUWPFlwUYn6NDWzDfabab_NYc8Z6QWQI>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jun 2024 16:04:27 -0400 (EDT)
Date: Fri, 28 Jun 2024 13:03:53 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/081: wait for reader process to exit before cycle
 mounting
Message-ID: <20240628200353.GA2141116@zen.localdomain>
References: <bdbff9712f32fe9458d9904f82bcc7cbf9892a4b.1719594258.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdbff9712f32fe9458d9904f82bcc7cbf9892a4b.1719594258.git.fdmanana@suse.com>

On Fri, Jun 28, 2024 at 06:04:49PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We send a kill signal to the reader process, check the md5sum of the
> files and then cycle mount the scratch device. Most of the time the
> reader process has already terminated before we attempt the cycle mount,
> but sometimes it may still be alive in which case the cat command
> executed by the reader process may fail because the scratch fs was
> unmounted and the target file doesn't exist. This makes the cat command
> print an error message and the test fail like this:
> 
>      Verifying file digests after cloning
>      14968c092c68e32fa35e776392d14523  SCRATCH_MNT/foo
>      14968c092c68e32fa35e776392d14523  SCRATCH_MNT/bar
>     +cat: /opt/scratch/bar: No such file or directory
>     +cat: /opt/scratch/bar: No such file or directory
>     +cat: /opt/scratch/bar: No such file or directory
>     +cat: /opt/scratch/bar: No such file or directory
>     ...
>     (Run diff -u /opt/xfstests/tests/btrfs/081.out
> 
> Fix this by making the test wait for the reader to terminate after
> sending it the kill signal.
> 
Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/081 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/btrfs/081 b/tests/btrfs/081
> index c3f84c77..64544da3 100755
> --- a/tests/btrfs/081
> +++ b/tests/btrfs/081
> @@ -82,6 +82,7 @@ $CLONER_PROG -s 0 -d 0 -l $(($num_extents * $extent_size)) \
>  	$SCRATCH_MNT/foo $SCRATCH_MNT/bar
>  
>  kill $reader_pid > /dev/null 2>&1
> +wait $reader_pid
>  
>  # Now both foo and bar should have exactly the same content.
>  # This didn't use to be the case before the btrfs kernel fix mentioned
> -- 
> 2.43.0
> 

