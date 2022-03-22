Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC064E4778
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 21:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiCVU10 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 16:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiCVU1S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 16:27:18 -0400
Received: from libero.it (smtp-32.italiaonline.it [213.209.10.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37D66CB9
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 13:25:47 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.27.216])
        by smtp-32.iol.local with ESMTPA
        id Wl4bnrTePptnyWl4bng5nq; Tue, 22 Mar 2022 21:25:46 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1647980746; bh=3/H07Q8z2ZDiBt3Pws4PO91Mwwep+A97P70r8ut4ihc=;
        h=From;
        b=Rx2e0q+gz6AnVxUHPGpAikyAtRMKf/MD7ifArnIy4Eg3Yh3GGbfww0zDBzFUlxxcl
         KALVvUdhSoJvQ9D47JiVeo5TKoFfMGb6NpzEuaZzv/MFz32D4ksTnUSng6QMe1DRqg
         Ddcpuqr9i5pJbSHeX//YkYOKI3p4HU16HCYC4/rySobHsdVyALAJ7cZoZcFer8eAfV
         WD7R7K9OwhE8j9oj9sdrBObirNL8dlELO5ps8AJz9B3pcNBED4MCxUB0/TByfw8T0h
         RdgZoyBGQ97+X8A+wBz0oKvwkYzW0+Wppz6u3tif6qUpaoYgky9UNziDmVZ34zC8t4
         BSLy15RWdN88Q==
X-CNFS-Analysis: v=2.4 cv=fIX8YbWe c=1 sm=1 tr=0 ts=623a30ca cx=a_exe
 a=jMrWlYnwW16pavatx/Gsew==:117 a=jMrWlYnwW16pavatx/Gsew==:17
 a=IkcTkHD0fZMA:10 a=z6rT8oX5wO0W1B1P8ukA:9 a=QEXdDO2ut3YA:10
Message-ID: <42e2b1fd-809d-3370-e802-2a9b926d38c5@libero.it>
Date:   Tue, 22 Mar 2022 21:25:45 +0100
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
 <Yjoo5TOlfGXgAUyk@localhost.localdomain>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <Yjoo5TOlfGXgAUyk@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPXjov3HlgBic8OuRdLGsUHVgRbOD/4TG/i74VUBp+ZqhAwrQ5QkUuCimqKEyohB0FKlfNB9KWK6Kl+EdBxSS/kDmpGjpmkCuqTos/F6AngYy75ajrJ3
 gyCbj+nc6r6So3FhMQTNfP5/ldCBSIvi6Yq5MtRQOm30KOCP25c06CEEfmVezWB3QTMDtVdV1bC0LTzwROvGtAWdt17ZM4jMMjsydEIBM0E4ikdJ12ohe+0i
 yizYFGthzae7fxQ2Kqp/tNvtAmAqEDOjtD1Y/F2T2TvhQMsY0lCji0AazeFinskEqp8bEDT+7eZtpsV6RDYb3kGxoK+CT5FN/anW8+Y30uFFq8KT/QHssJlO
 IpdNBvdK6m5PqbQLO6ZBE+PLw4T3GtrroU02DqsxWGDqAmWYK7uBCNhSt84MK8n4+TDjtXnh
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

On 22/03/2022 20.52, Josef Bacik wrote:
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
>> +/* preferred metadata chunk, but data chunk allowed */
>> +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED	(1ULL)
>> +/* only metadata chunk are allowed */
>> +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY		(2ULL)
>> +/* only data chunk allowed */
>> +#define BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY		(3ULL)
>> +
> 
> I also just realized you're using these as flags, so they need to be
> 
> (1ULL << 0)
> (1ULL << 1)
> (1ULL << 2)
> (1ULL << 3)
> 

Could you elaborate a bit ? These are mutual exclusive values...

> Thanks,
> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
