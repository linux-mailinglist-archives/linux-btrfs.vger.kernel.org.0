Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1443630CCD
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Nov 2022 07:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiKSGxl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Nov 2022 01:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKSGxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Nov 2022 01:53:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E561A18B18;
        Fri, 18 Nov 2022 22:53:36 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryXN-1pJjuo0tFt-00nwHa; Sat, 19
 Nov 2022 07:53:16 +0100
Message-ID: <a076e281-022f-1f49-b70d-513272ca86cf@gmx.com>
Date:   Sat, 19 Nov 2022 14:53:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: fix a resource leak in btrfs_init_sysfs()
To:     Zhen Lei <thunder.leizhen@huawei.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221119064348.1743-1-thunder.leizhen@huawei.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221119064348.1743-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iEavSc+zX6PCY8pCzSIgmtnoS7afG0PA1HRj6P41eW+Skly5KKa
 RWPVwC/aoLQb1yNk8wUnqTO1BkTu6mwo/jTwQQR5OWUs7NVm4qirNWFuUTAqnIULJit8VbR
 1ElRYB5xBnuaHV5YRwZRtJm4YCmT75ymB/0WbsmTEqKwx2UcR9JgTC51nUSLtnH6xJU5GLH
 fH0hNPOkxbHn/1qrMdhHw==
UI-OutboundReport: notjunk:1;M01:P0:5LMp6awC1Ss=;unzldrecvpc2gbpzIhCz09FEo3/
 LvjPD8VKYSCpwzJMgZjgIGmcGcqYoGZmyVltRFE1oNHsbpRdEttYwrVmoCip1s+P+X0fawPDX
 F0ILzsjo+Q0PPdBSQrfpv1dIU2SWrx+twskztexdagirG7W+fdz7Jrie2laFr1ZRIyI6SGhPn
 qVtzuoz9KDqpWWkFDCCE9Uo5ThIunhWeh7or+Qah1eKy0gFfsweyQjg4xepNmhumqx2FlYhTv
 ao4ylg2tyX6eYA+w+P4742GGapMCWJftjS4vioBVxWKLNCByLyTf7VlZHo8hoO/OoOcXIWgR1
 r56t4Cowc9vNXZt1swNYWkCfuLk+iibXCdoGm+eHTVdPVJki8qoK1VKwtZtTthu1O2yazAzcV
 /GeNt7EG0S17veKpSbvgG9ejLwT7/gQuKwRrm0DeAcndya+w2CcXiw6jv1TCvj1uZ4euuwVXS
 vKy1zz5mrfKT8vSGWIm8v4F4fPNFcy/3GFCXeb0BGfQSp8bd4abx6SBG5kB+SRs5iZya92lmX
 Fj91STY1VLxTcjd67ASRRp2+zuyeu+3dqF91dDWufICMRu12max1tVJ3Gk2o2eLRrSXpm759K
 1s4vNizIscNaCJqaM6BNQ8/s+WyQgvv1B2kEhyswiTrDP55YqVLYBrfHKmjAv3Ah+hhZBNHak
 9B+xbjt/R1tFGsv0SF90JD1Zs7jLGjle28jBNtkyiuOAINXgIxnNRn8ekLI1fZDLTWuWY9oXE
 YKxUt70bdl/wg4duzcaQQG50abWCvKRC+Mh2reJhyht9uOzEizqCTwU+6fSXGwN63VM03m0DI
 B4FSkUKMI0israjtjX13lhcoz7QPhO8/pOsbJ3bxYDGv4a/2wXA6QdY7ir5n14feHpNFf+tyH
 XgJndBWZtWzlyyltcLV/ncITFoa+iUJ5I5JTE8CefM2iZlwD0RxkByRuJYIihFn0TNkQt2FJ8
 +Gdb0a/qak4XTTyzG//ltb9BiSk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/19 14:43, Zhen Lei wrote:
> When btrfs_debug_feature_attr_group fails to be created,
> btrfs_feature_attr_group is not removed.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/sysfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 699b54b3acaae0b..947125f2ceaaf96 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -2322,7 +2322,7 @@ int __init btrfs_init_sysfs(void)
>   #ifdef CONFIG_BTRFS_DEBUG
>   	ret = sysfs_create_group(&btrfs_kset->kobj, &btrfs_debug_feature_attr_group);
>   	if (ret)
> -		goto out2;
> +		goto out_remove_group;
>   #endif
>   
>   	return 0;
