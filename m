Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF3B6EF34B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 13:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbjDZLVl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 07:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbjDZLVk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 07:21:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5054EC3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 04:21:39 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59GG-1psjft0ogG-001EZh; Wed, 26
 Apr 2023 13:21:33 +0200
Message-ID: <214ea94d-ccd8-29ea-7246-f25597426738@gmx.com>
Date:   Wed, 26 Apr 2023 19:21:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] btrfs: tag as unlikely the key comparison when
 checking sibling keys
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1682505780.git.fdmanana@suse.com>
 <8e323961434327423faeea50a3c6a09ff82a364b.1682505780.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8e323961434327423faeea50a3c6a09ff82a364b.1682505780.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0XaQYjYyIx8Y34K6dBYrv5jDYHZAeETTwFrHcgg9M6ZE09DrMBs
 h9ntcwuAnHbx5yKKflJScFc9Rp3d1g8lhtsYjHCqAe1xlWkOU8bknzuC/cBd/VhrBccB9Cc
 F3rbSpktjiNwiKI1klI4pX1K8vGR7rXKWtzmOn8Mk4RmwcrlSk7rUDRD07E+k1I0pGdsZpo
 uga99tv5rUUld/EdpWcZA==
UI-OutboundReport: notjunk:1;M01:P0:TUJnl9cyXs0=;yRuT+oDBbQsAyAh4CNS7QPP+SG9
 as//4bs7+GaJ8bhgTWvqiipoe+m7JePpD42LFp2K34mIM1cb3WSZwz3Dc5C/CcVU4obaBIqs5
 kmpvCBoM4Mel9Iq5uBrSe81eSEE0QxFtq/issbf1ReUlRDHCr1Gf3yx3uj3iP47bEBS2GrBoV
 78s96I+824mGtdzPgVI8jD8/wO54JPbltmG0o7MbI7Hrgt1erwxu4tWyFD43CDOnxcUcaa3SJ
 /shvGuyC/zF7jDglc7DO03eOShNTTYVY4DvIWuDR20BjBSmxFP2Q65AKQ9N13hRFyy57R9H7f
 5SUk60syePXJuWd509RfDJ9eqmRt0AqN02FdzhtlVsGBicKGDuKN7dwgMUvJ1EBrU2GwHmDSZ
 1rVbrZboj2B5x4F5HhyY0CI4p7JORE/kiovkBv6hVSJoUbgs8K79thhw78lRMh2CHPGhl8FmM
 Gtx9jKSQLnYf6icDal7Fx6J5BEEpOULRgMRS4e0f4/Cj4/zqT9RIjtiZjF3s+axknWFw/4MmK
 +fnEmd/YKUL1itFw25HuNzm3vx3XY/lPq3rmVnNbVLyqaJ/ZfGNyQwA+Qqh6+lqOuC1n4ogN2
 Hxqmxa2ucOh9Fnc6ZHO9BKW3sUa1F3Lt2+qoIqYngoQE0bjy8ax7m4hD9OAXDASElqho1fxjt
 7B1PYigEviCyRc/clssutkKSQANBHTC50xokUuX1/A/pPFvswWBK1fmYAaM+NOQ2NfVlEpLDK
 3TD5lL0yZHyHmITs2DZl1NkxzfXHVfd6IbVv2dvMJqZQZsmODToJSoQ1Goj+2WiG2Mr/rY7vM
 d7w7USMZW2PJPL92S4DGk42dPre6ankYZxw53Q/IhfJ8bFLUiK7F71nSIAO+ffm615F6O9Kfz
 1+Nt91+bcwFLmtIIxGPxedG4J+mdEq7GhY75C0Gx5SL3e6eCUaoH8eJQvHJtJ6WB5oSDzh+0A
 6mdrol8DkbaXd83VxkR42aGfH/E=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/26 18:51, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When checking siblings keys, before moving keys from one node/leaf to a
> sibling node/leaf, it's very unexpected to have the last key of the left
> sibling greater than or equals to the first key of the right sibling, as
> that means we have a (serious) corruption that breaks the key ordering
> properties of a b+tree. Since this is unexpected, surround the comparison
> with the unlikely macro, which helps the compiler generate better code
> for the most expected case (no existing b+tree corruption). This is also
> what we do for other unexpected cases of invalid key ordering (like at
> btrfs_set_item_key_safe()).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a061d7092369..c315fb793b30 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2707,7 +2707,7 @@ static bool check_sibling_keys(struct extent_buffer *left,
>   		btrfs_item_key_to_cpu(right, &right_first, 0);
>   	}
>   
> -	if (btrfs_comp_cpu_keys(&left_last, &right_first) >= 0) {
> +	if (unlikely(btrfs_comp_cpu_keys(&left_last, &right_first) >= 0)) {
>   		btrfs_crit(left->fs_info, "left extent buffer:");
>   		btrfs_print_tree(left, false);
>   		btrfs_crit(left->fs_info, "right extent buffer:");
