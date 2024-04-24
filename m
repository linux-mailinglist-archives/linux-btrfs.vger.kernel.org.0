Return-Path: <linux-btrfs+bounces-4538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B98768B1398
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 21:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CC11F23C2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0691377A03;
	Wed, 24 Apr 2024 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="svbMjNj0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B41A757FD
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987206; cv=none; b=qNldGEXz80+8YZEvQJeXMql/71krxeYyAzvVV1zjydjlhfs9YRXNM0No49llyEORloKOZfg+nFxgKBgjDl5CylmMghUNoXxafLrJhmOJkt2LIZNSZHGGILqkCx/1Dj7XcmzjUhKt01dzd4q26klU6HPeVPmaOafMqLrDzqA2BJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987206; c=relaxed/simple;
	bh=wvzwlc+3tdfShUTTUlRqHFkn5OVY+1QsyLaoZryigjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjLu0CVPr1rX+RdhLMdbMb0tVbJUPFDgjjgAK3TOwiI/veB6+yXeuzHvAD39Fe8wzLn0UwOMbAGPGobdEjCavdnPamaf0iA/4f++Ghyn81nbB/q16u+bY8556y0ai3h+qvgeq0kd6h90DF5gRSvOGlmx8Kj3SoWXwPuhX05gg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=svbMjNj0; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id ziKKrgNOVzTQvziKKrmGOM; Wed, 24 Apr 2024 21:30:44 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1713987044; bh=mDRyBeJUjqJMgy0ftZT0k6TmSg7ye/mpFXoAnljSm50=;
	h=From;
	b=svbMjNj0DjdqBNnBAKkny1TYo4kIcQjOKSXfZUFT0HCUsO+sgvZm6GQV1nuDMI5H+
	 +v9/mY5TOOf6VZY1cLHqMaGQEiz9qAI9DesE45+zbz5RlYbcnlUj/cunldXHCjw2dM
	 9TJ8vdDb68xL2tnAK2VeheoJQKyY+kBjIGPHDIHVbgjj5x0LHlJgOVRMuh0eAh0eq/
	 aMGRy71zPD/tKSEQbSkU/NXxLiM5DC0k2Pemhs4ICE0x5Rn9kTu+5sCuA+hjO+oraS
	 zVSPdQJnBzTNZ4AoclKY38qd6WIBj91gCNwRDOl4KZE3FVKp2XXmW9W/JesLRpmnV5
	 uQY/HT21ZMlTA==
X-CNFS-Analysis: v=2.4 cv=PJXE+uqC c=1 sm=1 tr=0 ts=66295de4 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=iox4zFpeAAAA:8 a=MuBgrnSyndUM2l4dhDoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
Message-ID: <d0b14c11-c224-4fb4-b9d6-ad7bfa0ecbba@libero.it>
Date: Wed, 24 Apr 2024 21:30:43 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs-progs: fsfeatures: hide RST behind experimental
 builds
To: Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.cz>
Cc: HAN Yuwei <hrx@bupt.moe>, linux-btrfs@vger.kernel.org
References: <a45bd8eb8d16b648368b2e83f12a72ea44dab71c.1713937746.git.wqu@suse.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <a45bd8eb8d16b648368b2e83f12a72ea44dab71c.1713937746.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDcPs6nkLcmTxZuc+zFxyntO/4qaCHNmo7iVqwCzzYNoCPTEAOew3lK4DN9Dx56dQ7+mazUix/w3qdbCgBXW0sBMSLmPHtbJlYgEioz7zKk+I3wmquyT
 ZjKOnmRr2jV3rL7z0GBttdk5hUR5qDac/kNQwJr84lDrkmZlGoQcePrCOvxrcvpoebKNHYSVv7K4rrawMsUmea5yGFZEAB/ximeaHG7DfZeDWJCi2i+cpD7+
 6Nx9TEoEJDrYCLkPFN1TFSTIM0UsKglOYKBsIMrisfc=

On 24/04/2024 07.49, Qu Wenruo wrote:
> [BUG]
> There is a report that with v6.7.1 btrfs-progs, `mkfs.btrfs -O rst`, but
> kernel 6.7/6.8 are unable to mount it at all.
>
> [CAUSE]
> Although the feature string states the raid-stripe-tree feature is
> supported since v6.7 kernel, it's not correct.
> Only debug kernel with CONFIG_BTRFS_DEBUG would support the RST feature.
>
> Thus RST is still considered experimental.
>
> [FIX]
> Move the RST mkfs features back to experimental.
>
> This patch would only hide the RST features from 'mkfs -O' options, the
> existing supporting code for RST would still be there, thus
> non-experimental build of `btrfs check` can still verify a btrfs with
> RST.
>
> Reported-by: HAN Yuwei <hrx@bupt.moe>
> Fixes: b421fdff9574 ("btrfs-progs: move raid-stripe-tree and squota build out of experimental")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   common/fsfeatures.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index c5e81629ccea..7aaddab6a192 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -222,6 +222,7 @@ static const struct btrfs_feature mkfs_features[] = {
>   		VERSION_NULL(default),
>   		.desc		= "block group tree, more efficient block group tracking to reduce mount time"
>   	},
> +#if EXPERIMENTAL
>   	{
>   		.name		= "rst",
>   		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE,
> @@ -238,6 +239,7 @@ static const struct btrfs_feature mkfs_features[] = {
>   		VERSION_NULL(default),
>   		.desc		= "raid stripe tree, enhanced file extent tracking"
>   	},
> +#endif
>   	{
>   		.name		= "squota",
>   		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA,

I am bit confused.

The Han report say that the problem is due to the fact that the option is enabled by *default*.

So way we should remove (from the binary) this option at all ? Shouldn't be enough to remove it from the options enabled by default  ?

Something like:

-        VERSION_TO_STRING2(compat, 6,7),
-        VERSION_NULL(safe),

+       VERSION_NULL(compat),

+        VERSION_TO_STRING2(safe, 6,7),


-- 

gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


