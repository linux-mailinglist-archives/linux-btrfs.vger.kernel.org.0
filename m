Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9337D740B8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 10:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjF1Ic2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 04:32:28 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:37906 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjF1I3t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 04:29:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E000161314
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 06:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7387C433C8;
        Wed, 28 Jun 2023 06:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687932204;
        bh=lnvqXGzT2nTwK1jMxNamuzxXiolwH7ESU8C2/uhXFfo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=qu1xW/P7zak5utQj0qaEYN64yxt07RgdhGYyn4kKnqSt0bEuKvs+VdBb3+VmkigU0
         ki4AElY4Y+ZdEYgz49HgN0rsTSjdYnKZF1NZsiZKzQYKEZnpuN7ZwocPg6KvotaoI9
         DJAuuWj4H6JwmtAlY7kWklaGLaDeeXByYwNrVOghqMXIWb61NirZwd3Am82cCG3cGf
         8o90khTZ5enmHHxtb/CUBEbxRRhzsOHpQxKQefC9cTfN1z8P0u+Mcu/EWrqtzQknC+
         GwDlcgkSqya+gVk96CJzh/LKJV+NPBoxcyMWvj1mFQzyQpxSdLD9MovUtuAoKMAoQz
         LGV3G2YXKJPUQ==
Message-ID: <203c7896-0e57-ce3a-5ff0-2bc3a7ab7bb3@kernel.org>
Date:   Wed, 28 Jun 2023 15:03:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: zoned: do not enable async discard
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <87c887259bfb49878be9990f4dd559ee90d273ec.1687913519.git.naohiro.aota@wdc.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87c887259bfb49878be9990f4dd559ee90d273ec.1687913519.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/28/23 09:53, Naohiro Aota wrote:
> The zoned mode need to reset a zone before using it. We rely on btrfs's
> original discard functionality (discarding unused block group range) to do
> the resetting.
> 
> While the commit 63a7cb130718 ("btrfs: auto enable discard=async when
> possible") made the discard done in an async manner, a zoned reset do not
> need to be async, as it is fast enough.
> 
> Even worth, delaying zone rests prevents using those zones again. So, let's
> disable async discard on the zoned mode.
> 
> Fixes: 63a7cb130718 ("btrfs: auto enable discard=async when possible")
> CC: stable@vger.kernel.org # 6.3+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/disk-io.c | 7 ++++++-
>  fs/btrfs/zoned.c   | 5 +++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7513388b0567..9b9914e5f03d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3438,11 +3438,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	 * For devices supporting discard turn on discard=async automatically,
>  	 * unless it's already set or disabled. This could be turned off by
>  	 * nodiscard for the same mount.
> +	 *
> +	 * The zoned mode piggy backs on the discard functionality for
> +	 * resetting a zone. There is no reason to delay the zone reset as it is
> +	 * fast enough. So, do not enable async discard for zoned mode.
>  	 */
>  	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
>  	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
>  	      btrfs_test_opt(fs_info, NODISCARD)) &&
> -	    fs_info->fs_devices->discardable) {
> +	    fs_info->fs_devices->discardable &&
> +	    !btrfs_is_zoned(fs_info)) {
>  		btrfs_set_and_info(fs_info, DISCARD_ASYNC,
>  				   "auto enabling async discard");
>  	}
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 85b8b332add9..56baac950f11 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -805,6 +805,11 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
>  		return -EINVAL;
>  	}
>  
> +	if (btrfs_test_opt(info, DISCARD_ASYNC)) {
> +		btrfs_err(info, "zoned: async discard not supported");
> +		return -EINVAL;

This is an option, so instead of returning an error, why not clearing it with a
warning message only ?

> +	}
> +
>  	return 0;
>  }
>  

-- 
Damien Le Moal
Western Digital Research

