Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64327633BF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Nov 2022 13:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiKVMAV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Nov 2022 07:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiKVMAT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Nov 2022 07:00:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3F218AE;
        Tue, 22 Nov 2022 04:00:15 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNt0C-1oZIJS1gBE-00OIfY; Tue, 22
 Nov 2022 12:59:59 +0100
Message-ID: <351a524a-3739-e9f3-3b20-0854e8b2a1af@gmx.com>
Date:   Tue, 22 Nov 2022 19:59:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] btrfs: normalize the error handling branch in
 btrfs_init_sysfs()
To:     Zhen Lei <thunder.leizhen@huawei.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221122115002.1831-1-thunder.leizhen@huawei.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221122115002.1831-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Rv7u5fK2t4aiAyK9OInAXgLL4BGT/xivFuzt5wm/jtBRjO5DY9L
 gTfu/p2CaJQdPn2b3M1zpuF143Zg+kMQ6AcaEWhput4avG8i65bKaESvE6dpkJzC0qKQSck
 f8xAV/HfY2iSMYM5rKV80OAe183CNaYY//UCeW6ofXIVSmOaY1ILsgffqLzlNu5LgivjL4C
 76f64K07CCgoxem3ZCUYg==
UI-OutboundReport: notjunk:1;M01:P0:tHUVKFLNqMQ=;Nq+/Vd6hju5hh2jLnYbYmllmq1q
 kpcN3X+FbzdBAH6UFMy4ZbDpvIHCCSf2eWUutVGi4o2j+Qq2cPQQG4PRQq/wHGu7/R7NPjubY
 MBcmRe1MLsEmWOcNCVCCXNq9+zfPk7UrGph1hNlYA27MMqhvBqlmgzeGCswuRPpii71WLDEtT
 hJz+eIlnP0pE68PJmsMKY4JjdSWkXFQBIbLutkhuqEbgG+J2zHfmCkuL8T9TgqTeioNDg4paa
 IFMC84ISTVSQOsma1Om8kwoXEhYAWq/ufivYSrBkjW6hyYpb9P/sryzVG0PCpmtCmQehHPWIW
 V9P00LCO+D4gpyadxyVlrmxBHJNM/dri9rvpX/vwPgysrrFkUScSfzXIqZeDBc/EvDB6PgdAH
 CjjfI1qzahMeblm/biQQ9GlGOT0D+I9K1uzYkfm7sLRAFdpnPTKrZ70AEgEbeaAimVXn06lVb
 x4umAzLipUc9yq199KvP3IWdtOJF/QI2fp8wna8wWobsXxXABRgnp1jaQR0IIMShGA+qc0MQi
 9VMKhTX/NRIFqkZ2fb89TjNbILdQ0BbcWbQwvauEv7bP0cWOjOuOKBfM5IzodrcBnASqulFVl
 OubbUSMY6G9ij8KM/fSK4EY6nLHFA2oWNAJK5OoxSNRo/nIMIEQUF8KLB7hta3HQyCvmrJ9MR
 WZFOs9IJjkNJOMXuuCFayDGmQOmSf9zT5ExkbRtlQliwI1VwxsS5b4IiyhxPhmO0JEQKWUwQe
 PYwMSLi4pl0k834yAYCGbZxLVgtO/eXe/IflzJQaAa4a16t4+sZOyPoBh3BgFuUU/legbq33b
 gGJJUInTOvzLtNcjrjMrpVFquQ+6+mjb3edETwTbZpolAAECwklI+BknsYxwEadJeAbrf+Y03
 Nj3EcnH/Uk8HsMtn9NBeVoBh2NBDI0Uo1j3TXxTAFrL9xYo70yJg9ZFf9IdwzQdchsLjLKwwg
 zUxj0JbWlev3A5pbP551hZcKrzU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/22 19:50, Zhen Lei wrote:
> Although kset_unregister() can eventually remove all attribute files,
> explicitly rolling back with the matching function makes the code logic
> look clearer.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/sysfs.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> v1 --> v2:
> 1. Add sysfs_unmerge_group() to unmerge group first.
> 2. Update subject and commit message, no resource leaks.
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 699b54b3acaae0b..74fef1f49c358cd 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -2321,8 +2321,11 @@ int __init btrfs_init_sysfs(void)
>   
>   #ifdef CONFIG_BTRFS_DEBUG
>   	ret = sysfs_create_group(&btrfs_kset->kobj, &btrfs_debug_feature_attr_group);
> -	if (ret)
> -		goto out2;
> +	if (ret) {
> +		sysfs_unmerge_group(&btrfs_kset->kobj,
> +				    &btrfs_static_feature_attr_group);
> +		goto out_remove_group;
> +	}
>   #endif
>   
>   	return 0;
