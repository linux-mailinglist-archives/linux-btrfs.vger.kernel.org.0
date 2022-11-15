Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C0962AE99
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 23:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbiKOWtb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 17:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbiKOWtI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 17:49:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7837F1F9F2;
        Tue, 15 Nov 2022 14:49:07 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4zAy-1p30mH2D36-010wYU; Tue, 15
 Nov 2022 23:48:46 +0100
Message-ID: <9b47b291-b1a0-ac0c-2049-b7de6545c26b@gmx.com>
Date:   Wed, 16 Nov 2022 06:48:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/3] btrfs: add might_sleep() to some places in
 update_qgroup_limit_item()
Content-Language: en-US
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxiaoxu5@huawei.com, yanaijie@huawei.com, wqu@suse.com
References: <20221115171709.3774614-1-chenxiaosong2@huawei.com>
 <20221115171709.3774614-2-chenxiaosong2@huawei.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221115171709.3774614-2-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ACaDmu0vn8uPXBZXogjhrJnHyIbAyNkKlZdK3dPVoAEEd4pPSQo
 ZMXIvZCG3aXAiXg/yYCwA7k49uNAryMUT1uQ0yrjm4uLkIliYsWgNPi4eIeDQNwCjnBtx/2
 WVYgcEzazdlxNpChDDyJofPa18+Ci5acB9OXRb1okfwQpNyYWJPFBHAhZ/SuHPng2wrJEBC
 2lF9Wd7AhMkCMsEGMZZbQ==
UI-OutboundReport: notjunk:1;M01:P0:U/7XQwDZGt8=;isD6mglcWv6XaR1jiP10hMwnLu4
 fyupKrp+azllYTtY4PfwLnPy0VS+1Osywq6+HJMBS97nzktCZqiD2CrrKlO3nxX4mzq5vlDoO
 TQijsJ46XiyvdOODTnmfWqAjbaKJz8LM3+uNmjH7HaJJb5frD2zME2z3UWHY6xNHYZ+0ulklr
 ajRSFXeLC+ZbL9POTHsGJI4DNFqaGnv3uU+/jr3aiD/w5V9RYF/8s0+lwNWsNkMjyM+QA8fsy
 uZliXEP2F5XSo8RVNDg+Xa4yiIBnxNvNbf73jAuHpQlfwL2d0mSmNuxHGuZ2LiYSvss4wM7DV
 M9yLYdwBgeMaYV7rtny22y2K+mgp1cbU4Ks89q0gsL0SQD97WilDoxYyw575RkMWtryRzXAMI
 OB2BjkJKu3UwdkUJWzzAQCi8IwoCkNsT0RmqF9SNFhAdkfKKxliI/3zI5GPy+3Nj/758Hilwt
 fgZkzpnnhBXouM7RhKDHPJyCM5ya3aUOvfOp1WBU2iA3eFgS+NZz/g9G6jkz7WFWL7Ivztyhf
 ZGpSZR4qBS+62pHCLBX36Z8+Su8vXXDsxzr/IuH3JflLd8h6W5KNPXsjKDHH2qBJ/SdHxfDDp
 CIxgz3j4A7uY1fZGppU2TkCrd2TGV/6gMfh1F/FJuxuKWgTgoOYGa34DgMYpSOKVOVbUuX2wV
 SdbooxLDDnQ/B2wJthpSPonxWw02kwTIN3/cug8Elg6UromSGhAr5YXRQGANaVnGjIMy10vVv
 xkfqGZDnEvOFBaFWccOSL+tY0AmrFMpKvf7VaSnyli6vs7LcQMAUAIGfeU6a9aB9V+vlbNeeD
 kTI8eXInUzDgdER5eFdsc2ahnlhTVQw80BqNcGWuCh46/oNvoq10HV/jhT1powjduNe5Ri42n
 G5W+dXhyokjGFj5d68NMyb8psEdA2gRoDSzTs3sS+HIYCsZWr5158Ej7/3H2YdFLscwsi91jK
 4c3Jz7ZPpdwJC9BpvkXOVt3oOZ4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/16 01:17, ChenXiaoSong wrote:
> As the potential sleeping under spin lock is hard to spot, we should add
> might_sleep() to some places.
> 
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>

Looks good.

We may want to add more in other locations, but this is really a good start.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c  | 2 ++
>   fs/btrfs/qgroup.c | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a9543f01184c..809053e9cfde 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1934,6 +1934,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>   	int min_write_lock_level;
>   	int prev_cmp;
>   
> +	might_sleep();
> +
>   	lowest_level = p->lowest_level;
>   	WARN_ON(lowest_level && ins_len > 0);
>   	WARN_ON(p->nodes[0] != NULL);
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9334c3157c22..d0480b9c6c86 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -779,6 +779,8 @@ static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
>   	int ret;
>   	int slot;
>   
> +	might_sleep();
> +
>   	key.objectid = 0;
>   	key.type = BTRFS_QGROUP_LIMIT_KEY;
>   	key.offset = qgroup->qgroupid;
