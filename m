Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948D66EF349
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 13:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbjDZLVJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 07:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbjDZLVH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 07:21:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05074EC3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 04:21:06 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXyJ-1pmWYN0ELn-00Z2jx; Wed, 26
 Apr 2023 13:21:00 +0200
Message-ID: <84ed9592-ac1e-8344-c0f6-4e114b2835ec@gmx.com>
Date:   Wed, 26 Apr 2023 19:20:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] btrfs: print extent buffers when sibling keys check
 fails
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1682505780.git.fdmanana@suse.com>
 <14f4089a9d26606c7a15e398536ca75f9c484c9c.1682505780.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <14f4089a9d26606c7a15e398536ca75f9c484c9c.1682505780.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iczjnPBYGcyTB1LB8jVgjnltHu/tVmYJxsyqr5a+XWucsLNFSA3
 car+GFmCuh4qQh2LCE57XP3HrJqxuhj8DBoAgiG3TEImDj/cJiIHDx+YQakksrvQYENhcVw
 CZFch8T9vMLmx/FTEqKBIwUC3Kv8fqlASNkHmZzb1T30AW0NlWyuC/8eNIFqReEqh+ug3du
 nWVHYcDepb8hSnO7shKWg==
UI-OutboundReport: notjunk:1;M01:P0:Z9ZEXGdOv7g=;e5hK3Oq/sc1uEvokfEf63gxnVlS
 LuLhSmPVljQPdGbK37tXq4rDr19neoXbiwU20qrVpeRHUoyj40Xk956RkExg7XHYMgYc198Ti
 Ha7ltJMMzG/RVqle9WSoTWVCwBdjiy/wMdFkd6iMRHf8g0VGS5OFTCHN5q5Rp5Q4XS5Zl3bml
 SRdItfOzln1we7JjApi8C7GDh5YaxxcQXFSrwhEBa8ApGRRQe1mfnejMzQGfgaRJlvqRlXMAX
 iPh/UIMC6K7F2Oc2a0W4rWCmHX5doJwCBb8egXTjTgOqyCGFyzBR2TG4vLDshN1IbIs3I2H3D
 3+XIU8hI4TiP9Cqx/xYU+z5a7zIMbsnZ4CZRSdgDxq1evFfFxA4TieBJoXK1BznkM6QToU1qL
 wrB1UAQ/asOeuDGD6SnN9sFIsMrVqLjHpR81DKKsEKzUIugnTIy9QxjVgnNTvH/DSlD3Glvad
 RItCLk0/d429+Gb7S8P0Zh8uP5w+YYLfgkE3yNNib48gzWV+FrgqO7/XFlYSMHxm8w8XNYh+0
 0KFCa34iKRyGCEKkSPB1kQSFg8PM1rNhGsI89RBSeqNDwQBGYrb+SX27FJboxJqSTd/v2Dazx
 QRB+UxVeBCIr9N8gCvAof73G8G9leUYOhXqn0if+6D0ZbTlBTltxdkYt7nxCkhl1nUPvtEyDh
 mhAR0wi3rOv9Bhh5G2AJ5+1lU/9pkbAyjbc8glAaGyA6G/QjmlSm4YZH3J9GcVg1Uw344rKRo
 fXlE8BItyLyvOBpdKiJbC9cWYOpx9vA5xjX2APyT3h8QV6rKF9SFM1+is8giJuBoRtZIP9gse
 PITlta4OXYifX7PtaSJf80TtgUVnAr71ywoeZEOKjLAV/hRkES1IkR/hZ/44JGZgetCct0Fjx
 NJMs0LS2udCdo5frIer6qCmpVO7fCqO6IwvpZy3Gj4Y+Vnx2dryUeP6YDKCvibXLrVV+AhkdO
 Vjg3TCqHzCX436515fTzuCV0KRs=
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
> When trying to move keys from one node/leaf to another sibling node/leaf,
> if the sibling keys check fails we just print an error message with the
> last key of the left sibling and the first key of the right sibling.
> However it's also useful to print all the keys of each sibling, as it
> may provide some clues to what went wrong, which code path may be
> inserting keys in an incorrect order. So just do that, print the siblings
> with btrfs_print_tree(), as it works for both leaves and nodes.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

However my concern is, printing two tree blocks may be a little too large.
Definitely not something can be capture by one screen.

Although dumping single tree block is already too large for a single 
screen, I don't have any better way...

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a0b97a6d075a..a061d7092369 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2708,6 +2708,10 @@ static bool check_sibling_keys(struct extent_buffer *left,
>   	}
>   
>   	if (btrfs_comp_cpu_keys(&left_last, &right_first) >= 0) {
> +		btrfs_crit(left->fs_info, "left extent buffer:");
> +		btrfs_print_tree(left, false);
> +		btrfs_crit(left->fs_info, "right extent buffer:");
> +		btrfs_print_tree(right, false);
>   		btrfs_crit(left->fs_info,
>   "bad key order, sibling blocks, left last (%llu %u %llu) right first (%llu %u %llu)",
>   			   left_last.objectid, left_last.type,
