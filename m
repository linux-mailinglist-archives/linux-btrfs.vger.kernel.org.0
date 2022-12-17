Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FE464F606
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Dec 2022 01:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiLQAXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 19:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiLQAWr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 19:22:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B318D66C08
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 16:17:14 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoNC-1pAEug1wQA-00EwyQ; Sat, 17
 Dec 2022 01:17:09 +0100
Message-ID: <2fd05fcf-c65d-47d7-a2af-46caaa426436@gmx.com>
Date:   Sat, 17 Dec 2022 08:17:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 5/8] btrfs: fix uninit warning in __set_extent_bit and
 convert_extent_bit
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1671221596.git.josef@toxicpanda.com>
 <02a60dacc01beb1ab14845f2b579e4b6f56c6359.1671221596.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <02a60dacc01beb1ab14845f2b579e4b6f56c6359.1671221596.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6LHmQIgngG+G2nJQQ5QDoH5P5CGRu3JxwJSdsgf/K88wn3g43C6
 EcAhM6ybpSHNi/ez6iO8RegTQO9RNBqPvOodvVcpf9QpHoaQ7uohuJfBLUDvuhhISkxvnez
 Ttlse4O/sNJthdx4f1tgXdifmefFN7oL30kPIS2NClNkzDsUd6Q0DL1aXY9ZHuVDJ9CA+R3
 D7zGm27NCG/YiCVLmpi/A==
UI-OutboundReport: notjunk:1;M01:P0:jJQFHNCsyCY=;vi5CC9nxzQXXrKNGybDjk4aBtUd
 CspUPrS1nJ55xtTeo71u14PkKvPk89VQe7hnmbJ+D/I4dK1PSu/buMOTTIVDMbcrkcxN28gfn
 KEU362ongt4sgNsr0b9MAnZ3FRKX50eT/azqzCEHEe9NSjx1XLmBrnZDUG6O2vQN5fR7cT01C
 PfycEp//qp2H8nuXGxnMVYaEgG0jFLB385djtDD/lAdDfLUymkCOiZpWLuYpLq6Jyeboqt7Be
 sN9zrlBmWvW5MZe7JxaEhE7KYn+JbsMQmn8Rd866sUwYGZX9rrbPXBSWYMuEoDa3/p8IGD5rE
 5FUiF9LRGKeS2NpDQRHgqSYq24wm96t+ipwLGXTTlwrqNxIXl8o42lDPOBQr+gEwQLbEm0qow
 l44SAjflQQkMbzsgvjw4JMW+vG4FPmf1VmyBm+epXIyh+lDhfaAhWbe4WxieWfNeyN5gngILX
 vrdf9vXKIqpHIiMfjakeFJK1vAgxv3O8cMbH4vizIPRPuUgBR7ig8awe+y6QFs6GZEC3gNSzU
 W0nxGqvujfqn0XtSfcsUxyy8fL07t+yqSy82HygxY7Muprj5L68V6pwXGdAVngvV0T5Tyv0b0
 bUKe/M2moBwSd/MKoQmxS0lCPfvwDVm0Fi6E4Y5Q+0prt9QzA3yrdI5lwPWMFVIYRf2Iq/6Yz
 ViWCg+QRi48b4ayUozReiGkGyUmp5CwtZm9GI544vGEwQfBBSiy8aRsrmEaSFV7EEZKQuAq/J
 Fb2QNR/jsS+cQ6tN7r78RDKBO/wBuRTGUkzRm4AGQN+TRdbo+vGR7A4HjFnwE/dy+AVg+7Hmp
 JZF30PIi9KTHjiu07exsRsyxtCYfPrpz+7iEk/axZz/aLV99bE4SrWTTffG5Q6iqrqIuiNjm4
 pT9w52BF1I1CziusvxzWAchmApfAzQXJjTp2LrDlrwAK3yGX3G6HSWqqVQtOQTauezWDci98l
 qMpK/OuRVWceGcXgreDFwZbNucI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/17 04:15, Josef Bacik wrote:
> We will pass in the parent and p pointer into our tree_search function
> to avoid doing a second search when inserting a new extent state into
> the tree.  However because this is conditional upon passing in these
> pointers the compiler seems to think these values can be uninitialized
> if we're using -Wmaybe-uninitialized.  Fix this by initializing these
> values.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent-io-tree.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index 9ae9cd1e7035..9e1f18706a02 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -972,8 +972,8 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>   {
>   	struct extent_state *state;
>   	struct extent_state *prealloc = NULL;
> -	struct rb_node **p;
> -	struct rb_node *parent;
> +	struct rb_node **p = NULL;
> +	struct rb_node *parent = NULL;
>   	int err = 0;
>   	u64 last_start;
>   	u64 last_end;
> @@ -1218,8 +1218,8 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>   {
>   	struct extent_state *state;
>   	struct extent_state *prealloc = NULL;
> -	struct rb_node **p;
> -	struct rb_node *parent;
> +	struct rb_node **p = NULL;
> +	struct rb_node *parent = NULL;
>   	int err = 0;
>   	u64 last_start;
>   	u64 last_end;
