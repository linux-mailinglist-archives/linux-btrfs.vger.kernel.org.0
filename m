Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC97F57A307
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiGSP3u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 11:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbiGSP3u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 11:29:50 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A3556BB2;
        Tue, 19 Jul 2022 08:29:49 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id BD84280415;
        Tue, 19 Jul 2022 11:29:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658244589; bh=SkhHi5o2JPJ5Bx7tZKwKNvLm39jvZhBn6FjUUZ35N98=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=PEJ4hZSJl05ApDCpI6nK9JXaYwI43Jaf2YV25Reip6u2hMjzIAmHTSBkbX73A2Ier
         8kZjkOxQ3d9wz3EbIoAsx45kJ1gvh8SrIy0OoAw7f6rtDmKB1f+9IfG5bcHPy/D2my
         ko6piI6vkqLm77NL0nqIWKG9orC3vC4xD9ag8TgxN5XtcC8lfyHoud9OOsYjWU1+QG
         5Ni4WIOfhgZHqZtdkhSi3j06R/ATFNqUs2R+eMctMjL0LqIs7akYwFmMGac4qP7Fa2
         Jeu8A+/GUmdswpp7FvSQbs/gOipswzK9vF8j299fKPn9aU50lshCRvJwTkXPV61Vj6
         7+Iv2+c9yxyyQ==
Message-ID: <cdff598f-d6f1-81cc-a741-8e66f0f9863e@dorminy.me>
Date:   Tue, 19 Jul 2022 11:29:47 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] fstests: don't run btrfs/257 if we have compression
 enabled
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <31a36368502eb7b1ee7bae36f000f4ee1eda3913.1658244445.git.josef@toxicpanda.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <31a36368502eb7b1ee7bae36f000f4ee1eda3913.1658244445.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/19/22 11:27, Josef Bacik wrote:
> This fails on all of our compression config variations because it
> depends on specific file extent layout.  Add _require_btrfs_no_compress
> so we don't complain about failures that don't apply.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>   tests/btrfs/257 | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/btrfs/257 b/tests/btrfs/257
> index 5c5cdcc3..3092495f 100755
> --- a/tests/btrfs/257
> +++ b/tests/btrfs/257
> @@ -27,6 +27,9 @@ _begin_fstest auto quick defrag prealloc
>   _supported_fs btrfs
>   _require_scratch
>   
> +# We rely on specific extent layout, don't run on compress
> +_require_btrfs_no_compress
> +
>   # Needs 4K sectorsize
>   _require_btrfs_support_sectorsize 4096
>   _require_xfs_io_command "falloc"
