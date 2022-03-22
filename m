Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5E44E4644
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 19:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiCVSvD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 14:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiCVSvC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 14:51:02 -0400
Received: from libero.it (smtp-32.italiaonline.it [213.209.10.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5684685955
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 11:49:33 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.27.216])
        by smtp-32.iol.local with ESMTPA
        id WjZRnqWtrptnyWjZSnfgFg; Tue, 22 Mar 2022 19:49:32 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1647974972; bh=4iFZTny9Pnfw/3YqxVUKhG7pd1CPG/znC4o3OqiL2PY=;
        h=From;
        b=GOo51awN2gJZ/Fpe8uiiaoDNuH0Re5SD8okU9nXbDk2i/eMM55XgSkA30qUJ9DaKg
         kDRtSt7FD4Ld0N8Ko1j43Fh5Tsk82SKneuBghCSm3/tFCiUa3XjTVBEf/uJNP8h0VE
         eyPyTboyMyMQMmhrxswL6BSbPbGbKqaVOLrSgRT8PRKvvlPASVCh2My93/WSJzMrB8
         bcnwWhpYSA9ziHIna21GNgEO2Laca0+G/k1hlVxngHgy9lYzMgQqkE/6U5inYXuSzA
         b4fq2UJAQlpRDKwNjt6DECJoJElalj064TyuiSHm8MHoT/5qEStUfzinnat48El2qU
         caQMIzEFY3Qlg==
X-CNFS-Analysis: v=2.4 cv=fIX8YbWe c=1 sm=1 tr=0 ts=623a1a3c cx=a_exe
 a=jMrWlYnwW16pavatx/Gsew==:117 a=jMrWlYnwW16pavatx/Gsew==:17
 a=IkcTkHD0fZMA:10 a=z6rT8oX5wO0W1B1P8ukA:9 a=QEXdDO2ut3YA:10
Message-ID: <365418c8-3cf5-aa46-94ef-9ca63b0764ef@libero.it>
Date:   Tue, 22 Mar 2022 19:49:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/5] btrfs: add flags to give an hint to the chunk
 allocator
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <cover.1646589622.git.kreijack@inwind.it>
 <b15072e61eac46aa9f61317c59219713a01ff897.1646589622.git.kreijack@inwind.it>
 <YjoNvoIy/WmulvEc@localhost.localdomain>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <YjoNvoIy/WmulvEc@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEBpc1KulmuhcvPCjg00tRmyw5bdkj1IMJN0EHNWMn7PtrYt8zjLLTaqGhE6lrSogTKN1Rl48Ew9quzZiK6GjwMSYCTTfIMcgLC9G0n+TdWAvBTEIa7q
 HljEvEAcNkvBi7LAK4Htt1shRBk17Iefg8fFocRL+IBEbHrAs9uWMHC1amgsLUVIAzxaEroW3r9TvekXN57lpyIbL8mEXrd08frewNiO3AnpINYTAw1p5g40
 TaClZg0zeIYA6A09FMVI3ckqmKGY4sQnK9atLpDy1V4TN981wHtdJ+Z5x4Xs4d2DQVtUN18Nxf+zQZcIPqQ6KZ9CYlwBf7rqxk2rMCVI8pSqSqW8NLo/rs8n
 vqd5Vo+0kSrZnTsGPwzQFuVG/53b4f40Llm5B4KF2gtm5sWujG/GZ5pNonaPJ2ih3bxVO9ny
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/03/2022 18.56, Josef Bacik wrote:
> On Sun, Mar 06, 2022 at 07:14:39PM +0100, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> Add the following flags to give an hint about which chunk should be
>> allocated in which disk:
>>
>> - BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED
>>    preferred for data chunk, but metadata chunk allowed
>> - BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED
>>    preferred for metadata chunk, but data chunk allowed
>> - BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY
>>    only metadata chunk allowed
>> - BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY
>>    only data chunk allowed
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>> ---
>>   include/uapi/linux/btrfs_tree.h | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
>> index b069752a8ecf..e0d842c2e616 100644
>> --- a/include/uapi/linux/btrfs_tree.h
>> +++ b/include/uapi/linux/btrfs_tree.h
>> @@ -389,6 +389,22 @@ struct btrfs_key {
>>   	__u64 offset;
>>   } __attribute__ ((__packed__));
>>   
>> +/* dev_item.type */
>> +
>> +/* btrfs chunk allocation hint */
>> +#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT	2
>> +/* btrfs chunk allocation hint mask */
>> +#define BTRFS_DEV_ALLOCATION_HINT_MASK	\
>> +	((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)
>> +/* preferred data chunk, but metadata chunk allowed */
>> +#define BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED	(0ULL)
> 
> Actually don't we have 0 set on type already?  So this will make all existing
> file systems have DATA_PREFERRED, when in reality they may not want that
> behavior.  So should we start at 1?  Thanks,

Yes, the default is 0 (now DATA_PREFERRED).
If we have all the disks set to DATA_PREFERRED (or METADATA_PREFERRED), all the disks
have the same priority so the chunks allocator works as usual.

If we have DATA_PREFERRED=1, it is not clear to me which would be the expected behavior when the allocator has to choice one of the followings disks:
- TYPE=0
- DATA_PREFERRED
- DATA_ONLY

It should ignore TYPE=0 ? or it should block the 'allocation_hint' policy ? Or TYPE=0 should have the lowest (or highest) priority ?

DATA_PREFERRED to me seems a safe default, because at worst we have only missing performance penalty (i.e. it is a faster disk where we should put METADATA)

BR

> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
