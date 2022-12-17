Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F12264F604
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Dec 2022 01:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiLQAXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 19:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLQAWh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 19:22:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676757CFE1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 16:16:33 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mzhj9-1okHqU41vV-00vdVd; Sat, 17
 Dec 2022 01:16:28 +0100
Message-ID: <17cce257-19e0-c7c6-ee68-8a6ea1bd408c@gmx.com>
Date:   Sat, 17 Dec 2022 08:16:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/8] btrfs: fix uninit warning from get_inode_gen usage
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1671221596.git.josef@toxicpanda.com>
 <aa2e624f5626b37a267ea123baf7db2d76be41ee.1671221596.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <aa2e624f5626b37a267ea123baf7db2d76be41ee.1671221596.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Q3VGU763DWPHQUU7MLW+f2HI3krEVaq1GfX7nti5EW2dPrB/ask
 mzf59XWhpxjRiWzmcxDcnVmchb9EX97gowxzJ4eHJUZ8Wa/puRgMRFrZtv10YKdt687BRlz
 CHCBYBMY0X6QFKsy4j8Ue7+mWfXZ7p3o7dMEsvE4oyCJl7vcEqES7sde4KSacEdq9q/FmQJ
 GvFjyuNP+nv+5qSo5YILg==
UI-OutboundReport: notjunk:1;M01:P0:YM6iScz1wgQ=;GQQN58oV77FM5kPWKsQ+zeyrUyb
 +uezymaIBD1ObiNwwi7l16oJaxV2pL0XyBIEDPsHwTeO6j/Gxkh8JL2Bth2cayvedV3pjaeQj
 XI69+fEOCdU8ggsr0bcuhRkeAGP1eveTlzxc77tbQ4j3iAt+pmPXR29nskM8WlRctZoWuMhAI
 3hX/DDUfw/xM3TEHHoWZQZLTD7FRY6KYtSUUw4BcqEsREtlUf5Xdj0CoxO0g4imSqkMB89BPC
 ZUJlir6t/GznRsnaL9Z6wvk1IseG2q+ycoIAAMnVMQXUte+8Pm9DsJbPobA/eksbZwv8xECUO
 6UVrfgy+Kc1wS7ckuIj96tD5XbFvh1J6wv+8c5RT9JihPWccFHr/SX/yAsC4hDrPa/NGJcH2N
 LP9GofwVkwqebhHWg/Ig8I3zqLdjXE6SaOav1bfSNC6oqLp7ykU/WpTnUQtP4SbLdDGJnXYTw
 FTkVC/2D8QABteSWJ/i3jLOuNsg7nWnGiNEffAsnLUnSqF7juwzxzTI5XKivxo6nHdq7oUtYH
 0J11AzkNPBsuKwOJ5TrftT3Ek+bMpL7EKBxyFDp6nIF2pmZaRkRRWwouvgKODKoM3Hgs2zPnY
 fpfq8tDXOipD7nEqBrNtGXsVSUuwyNPCDJ5nGmLthEVzIFzrySPSY11LxdB57N20Br79+UtEg
 YIwxYFw/DjfVvWgG4LNo++K91dGxG780Oj6u9lzmwC16Pt5my80vkH0RYRPrfWjecwdcBVyMS
 hkdumJw3R5ydBDyvc6d8xEZgD4O/Gusanv6UY03atGi2yMwtycoQdCI9itOFF6Ysig26Kz+Fw
 RYDWBAjyhktk+OBkS04xNeahgeawlRm/InMfLv4AK+wUV1idEK/VIvG1LtWw9eL8R6LCYd3iq
 6vaG1K5w3Tg7G16GvCC1nWUF/y6PL/oLXxPMPJOND62M+t0XoCXzysW/BMd4c172n90gbsa8T
 P7pbZX2A8Rp3PZci0HQjNiAfBQg=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/17 04:15, Josef Bacik wrote:
> Anybody that calls get_inode_gen() can have an uninitialized gen if
> there's an error.  This isn't a big deal because all the users just exit
> if they get an error, however it makes -Wmaybe-uninitialized complain,
> so fix this up to always init the passed in gen, this quiets all of the
> uninitialized warnings in send.c.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/send.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 67f7c698ade3..25a235179edb 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -955,14 +955,12 @@ static int get_inode_info(struct btrfs_root *root, u64 ino,
>   static int get_inode_gen(struct btrfs_root *root, u64 ino, u64 *gen)
>   {
>   	int ret;
> -	struct btrfs_inode_info info;
> +	struct btrfs_inode_info info = {};
>   
> -	if (!gen)
> -		return -EPERM;
> +	ASSERT(gen);
>   
>   	ret = get_inode_info(root, ino, &info);
> -	if (!ret)
> -		*gen = info.gen;
> +	*gen = info.gen;
>   	return ret;
>   }
>   
