Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283A44F6C0A
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 23:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiDFVEi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbiDFVCI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 17:02:08 -0400
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C526E027
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 12:32:12 -0700 (PDT)
Received: from [192.168.1.27] ([78.12.30.135])
        by smtp-16.iol.local with ESMTPA
        id cBNtngO3RxXfVcBNunyREM; Wed, 06 Apr 2022 21:32:09 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1649273529; bh=WRnbIRDdppeiPmUzWGfXgOkqi2eNV24bARN3E29338U=;
        h=From;
        b=IABm4Cz4zYBmcPkG4u2BPG1KG+2gU2BIFhKorhcjRYn7qv2OQvgB11eMVgXg5sSfu
         ErwQQAIudmFJpbs0aTQ3bCasBZiP9Q+ygby4p/aBF9XFWOilkPHrqZUOVirhyiZVzM
         mSZ9Cd8A+MlgqrYde0OQGwJ/AtuCNyVPj5pjZAwvanU+VWl/kajPDj7CsqSClXHLel
         Zh7m+PbngHirUPVESxKqM/+TFwcxC1ND0/wbiU0E7m+oL/JyvFaHj5xHsXhSBklVnZ
         AFEOt88DzsMVR4D+HefRLfoGD0s2otanTKCn/6dcFH4OWlnD0XqsBbMfoIkn+y3phy
         lybIxxqMH6Kkg==
X-CNFS-Analysis: v=2.4 cv=XoI/hXJ9 c=1 sm=1 tr=0 ts=624deab9 cx=a_exe
 a=4XrYznHYtoO9gW1wDwXiyQ==:117 a=4XrYznHYtoO9gW1wDwXiyQ==:17
 a=IkcTkHD0fZMA:10 a=fx8nN4BKGLmDRhAw9MwA:9 a=QEXdDO2ut3YA:10
Message-ID: <a6615921-8cc7-c0bd-f74f-9c64bcd3708a@inwind.it>
Date:   Wed, 6 Apr 2022 21:32:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/5] btrfs: add flags to give an hint to the chunk
 allocator
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
References: <cover.1646589622.git.kreijack@inwind.it>
 <b15072e61eac46aa9f61317c59219713a01ff897.1646589622.git.kreijack@inwind.it>
 <YjoNvoIy/WmulvEc@localhost.localdomain>
 <365418c8-3cf5-aa46-94ef-9ca63b0764ef@libero.it>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <365418c8-3cf5-aa46-94ef-9ca63b0764ef@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBumpTzgLty+6aKD+N9Bo0Ryw9Sk6NK29ixGW3I48zT/OSgiGLj8is1Cn9EQ0oHZRfP26UBYxVRSfACS54yLdnGnFHnintmqESz32y9HxI+UeeN0Vpy8
 YodoRu+mufYYv1gRbrt3pCZMv5ACkgNWew3jd0XIUBEBoc6sYC1vwQtfPddWMhQWSiEp3T7cn/KfHRV7iVAo09aKsi8ormiKitDN3DczuTtRLWVH1RQNbWqj
 7VWIswAf8K0E+d/D336WKo+NoAvfQI2Var6ESvYAnBXlc8OCvMfVpSLRCh393ROqZetoYeWZjlCAVJjMqmHeD5w71c53PRnXpx55BeAvZfe+61d7pstMJUBz
 zYXuVhLdOfGHUr+Z8LO/C0dJcpgUzg==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Gentle ping

On 22/03/2022 19.49, Goffredo Baroncelli wrote:
> On 22/03/2022 18.56, Josef Bacik wrote:
>> On Sun, Mar 06, 2022 at 07:14:39PM +0100, Goffredo Baroncelli wrote:
>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>
>>> Add the following flags to give an hint about which chunk should be
>>> allocated in which disk:
>>>
>>> - BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED
>>>    preferred for data chunk, but metadata chunk allowed
>>> - BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED
>>>    preferred for metadata chunk, but data chunk allowed
>>> - BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY
>>>    only metadata chunk allowed
>>> - BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY
>>>    only data chunk allowed
>>>
>>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>>> ---
>>>   include/uapi/linux/btrfs_tree.h | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
>>> index b069752a8ecf..e0d842c2e616 100644
>>> --- a/include/uapi/linux/btrfs_tree.h
>>> +++ b/include/uapi/linux/btrfs_tree.h
>>> @@ -389,6 +389,22 @@ struct btrfs_key {
>>>       __u64 offset;
>>>   } __attribute__ ((__packed__));
>>> +/* dev_item.type */
>>> +
>>> +/* btrfs chunk allocation hint */
>>> +#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT    2
>>> +/* btrfs chunk allocation hint mask */
>>> +#define BTRFS_DEV_ALLOCATION_HINT_MASK    \
>>> +    ((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)
>>> +/* preferred data chunk, but metadata chunk allowed */
>>> +#define BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED    (0ULL)
>>
>> Actually don't we have 0 set on type already?  So this will make all existing
>> file systems have DATA_PREFERRED, when in reality they may not want that
>> behavior.  So should we start at 1?  Thanks,
> 
> Yes, the default is 0 (now DATA_PREFERRED).
> If we have all the disks set to DATA_PREFERRED (or METADATA_PREFERRED), all the disks
> have the same priority so the chunks allocator works as usual.
> 
> If we have DATA_PREFERRED=1, it is not clear to me which would be the expected behavior when the allocator has to choice one of the followings disks:
> - TYPE=0
> - DATA_PREFERRED
> - DATA_ONLY
> 
> It should ignore TYPE=0 ? or it should block the 'allocation_hint' policy ? Or TYPE=0 should have the lowest (or highest) priority ?
> 
> DATA_PREFERRED to me seems a safe default, because at worst we have only missing performance penalty (i.e. it is a faster disk where we should put METADATA)
> 
> BR
> 
>>
>> Josef
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
