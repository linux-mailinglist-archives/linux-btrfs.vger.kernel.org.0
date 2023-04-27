Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8596F0F24
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 01:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbjD0Xi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 19:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344424AbjD0XiX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 19:38:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04A240F0;
        Thu, 27 Apr 2023 16:37:53 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9o21-1pxPqY3bq1-005nfg; Fri, 28
 Apr 2023 01:37:40 +0200
Message-ID: <de1a63db-2f30-5969-bc28-a53faaed1608@gmx.com>
Date:   Fri, 28 Apr 2023 07:37:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs: properly reject clear_cache and v1 cache for
 block-group-tree
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <832315ce8d970a393a2948e4cc21690a1d9e1cac.1682559926.git.wqu@suse.com>
 <20230427233229.GK19619@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230427233229.GK19619@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:20GDs0lxhsWa6UqEKiy8URUMT1YzNAsrZUiKiGhQMYeoF4QhKGU
 vLCmw+OdzOQNJ/Gc0Mi1+3cXA6Qf1Xq84ovK5Py5xyZTvxPSIgIhDnV4sKsKaCRyFNsTNE5
 s3JPRxOUGV8Y6mGKXl4ewxrrm2TeyN1Wm7j/UPqVV/P0Gc8GzkIvrZ/ab0XZvwfkLU67TL6
 BrpFK3LyYH69WWd1i2yQQ==
UI-OutboundReport: notjunk:1;M01:P0:fml2WwOj06Q=;06CvUOq0O9Us9gW/HGgJq5UQ9cq
 FfPMCDDU5q7kzUuKpgTuIexY0dumUAoZYR8iUyqQ/Yoq66etHuNiu99z2DINaVCLkba7PkWdR
 xS5IsNT7pihEnfWE0dHNDOKQproG1M2lKdqL4ut0/PT0+eq6qdd/pxDRIZ/aLISDdVdsOKDo0
 k0aB2SYzf7Q+VGhbG/Is8wT4QEJ5cleeYwShu7ucXh59/NWd75IJzPnHNAEfrZv0c9hQYzmH0
 KN19RdIGPNmVSbtjuKdoE9QWml23L28KT+7zC3dhLKBYYrMvH75OWO0KKb2QELBN9tDgKOffb
 LPUfhfWovie9jOOWLZAjDqE+ZJ/L62Fy9x3KcqaBlM41x9enhGlw04ST+aRSEDYLO7lWLXQJL
 o23sB7KsLDRM2WXcdlkar51uGZlnUqcU3EB+JHl87yra+qrRtgTIU+UG3NWJdeSIeQKKLdegs
 JcHtYqhDgx9iJO4GIzzvHHugJa+0uutxHeLs03yUk35bruL3IYc4QYuVnIkH0lKJ7HgPca5ri
 V0ElzRo53xVeuE7qEbaHKvobVdfISRstxCbpk3PJCH8n/3f+67PUAuSE604ZYE7UC5GqEZSI8
 wqalW0I4D6sTD5HXJs2pEIXwjcGONpXTkRvdYCpRNnSFQZrFmLh9aU1cLIDbrJj0CgjJ8Z4q6
 avtdIobo82arM5M7z/XT2ufxRpYNO9Z1H3WtwAephSbtPjVMm9+q3uAzVkStBVcpRBH8VuqQK
 GbtG5IbT6BVM36xcfrmgK/shx3j9Kdvf1kkMtTMjmSmUPa9DrHhfcjz6EP0xCeLvlYNe3fPZN
 gRgCuy7dApMpNGa4wGQ13baXut/aipONC0vV4fnfmohCwIUSq6+nL8Q1uqYKWehmh51YeQhHq
 w7WHv6SaUGr1a03Pr2frTJty7UmSJDIKBmnrJYbj1jl/nPGXxmhkqBe9jwPBe+8kmS7j6w3qN
 qc2w89bmqfZCxoLYSKx6gv3yqWY=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/28 07:32, David Sterba wrote:
> On Thu, Apr 27, 2023 at 09:45:32AM +0800, Qu Wenruo wrote:
>> [BUG]
>> With block-group-tree feature enabled, mounting it with clear_cache
>> would cause the following transaction abort at mount or remount:
>>
>>   BTRFS info (device dm-4): force clearing of disk cache
>>   BTRFS info (device dm-4): using free space tree
>>   BTRFS info (device dm-4): auto enabling async discard
>>   BTRFS info (device dm-4): clearing free space tree
>>   BTRFS info (device dm-4): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
>>   BTRFS info (device dm-4): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
>>   BTRFS error (device dm-4): block-group-tree feature requires fres-space-tree and no-holes
>>   BTRFS error (device dm-4): super block corruption detected before writing it to disk
>>   BTRFS: error (device dm-4) in write_all_supers:4288: errno=-117 Filesystem corrupted (unexpected superblock corruption detected)
>>   BTRFS warning (device dm-4: state E): Skipping commit of aborted transaction.
>>
>> [CAUSE]
>> For block-group-tree feature, we have an artificial dependency on
>> free-space-tree.
>>
>> This means if we detects block-group-tree without v2 cache, we consider
>> it a corruption and cause the problem.
>>
>> For clear_cache mount option, it would temporary disable v2 cache, then
>> re-enable it.
>>
>> But unfortunately for that temporary v2 cache disabled status, we refuse
>> to write a superblock with bg tree only flag, thus leads to the above
>> transaction abortion.
>>
>> [FIX]
>> For now, just reject clear_cache and v1 cache mount option for block
>> group tree.
>> So now we got a graceful rejection other than a transaction abort:
>>
>>   BTRFS info (device dm-4): force clearing of disk cache
>>   BTRFS error (device dm-4): cannot disable free space tree with block-group-tree feature
>>   BTRFS error (device dm-4): open_ctree failed
>>
>> Cc: stable@vger.kernel.org # 6.1+
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> For the proper fix, we need to change the behavior of clear_cache and v1
>> cache switch.
>>
>> For pure clear_cache without switch cache version, we should allow
>> rebuilding v2 cache without fully disable v2 cache.
> 
> There was an issue to clarify docs about the space caches and it's a
> mess, once we had v2 the number of states has increased and it's
> becoming user unfriendly. At least we have the block-group-tree and
> free-space-tree tied together and this should be the focus of the
> feature compatibility.
> 
> I think it should be acceptable to slightly change the behaviour for
> some obscure combination v1/v2/clear/bgt and either reject some of them
> or suggest more than one step how to do it. E.g. first fully convert
> from v1 to v2 and then to bgt, or allow v2/bgt/clear in one go.

On the clear cache behavior, I'm working on making it independent from 
the current cache version.
E.g. on v2 cache, clear_cache would just clear the cache, without 
(temporarily) falling back to v1.

This should slightly reduce the complexity for the free space cache matrix.

To me, the biggest inconsistency comes from the fact that free space 
cache version can be too easily modified just by a mount option.

While compat_ro flags normally should be enabled/disabled by btrfstune 
tools.

Thanks,
Qu

> 
> Added to misc-next, thanks.
