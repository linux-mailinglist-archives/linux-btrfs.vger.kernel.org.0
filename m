Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF5D7DE662
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Nov 2023 20:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjKAT3m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Nov 2023 15:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjKAT3l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Nov 2023 15:29:41 -0400
X-Greylist: delayed 515 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Nov 2023 12:29:38 PDT
Received: from mail.pmacedo.com (mail.pmacedo.com [IPv6:2a01:7e00::f03c:91ff:fedf:db2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3E27111
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 12:29:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.pmacedo.com (Postfix) with ESMTP id D9A2822607E;
        Wed,  1 Nov 2023 19:21:00 +0000 (UTC)
X-Virus-Scanned: Debian amavis at mail.pmacedo.com
Received: from mail.pmacedo.com ([127.0.0.1])
 by localhost (mail.pmacedo.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ShbWDU-3MnGp; Wed,  1 Nov 2023 19:21:00 +0000 (UTC)
Received: from [IPV6:2a00:79e0:60:200:8533:52aa:4312:f0b3] (unknown [IPv6:2a00:79e0:60:200:8533:52aa:4312:f0b3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.pmacedo.com (Postfix) with ESMTPSA id CA480225E4A;
        Wed,  1 Nov 2023 19:20:59 +0000 (UTC)
Message-ID: <21245ede-7ef3-40ad-828f-91f6845e9273@pmacedo.com>
Date:   Wed, 1 Nov 2023 20:20:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Balance on 5-disk RAID1 put all data on 2 disks, leaving the rest
 empty
Content-Language: en-GB
To:     Anand Jain <anand.jain@oracle.com>, Roman Mamedov <rm@romanrm.net>,
        Remi Gauvin <remi@georgianit.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <erRZVkhSqirieFSNm0d1BF5BemFMyUSCjGKT73prpKS7KDydKhqAvNqA7Eham7bQXmmh0CCx0rep6EAKKi_0itDlOf94KZ1zRRZfip_My4M=@protonmail.com>
 <16acffd1-9704-9681-c2d4-4f5b8280ade0@georgianit.com>
 <20231026021551.55802873@nvm>
 <de06dca2-9611-4fde-a884-0f4789f7b48c@oracle.com>
From:   Pedro Macedo <pmacedo@pmacedo.com>
In-Reply-To: <de06dca2-9611-4fde-a884-0f4789f7b48c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 27.10.23 06:21, Anand Jain wrote:
> On 10/26/23 05:15, Roman Mamedov wrote:
>> On Wed, 25 Oct 2023 17:08:08 -0400
>> Remi Gauvin <remi@georgianit.com> wrote:
>>
>>> On 2023-10-25 4:29 p.m., Peter Wedder wrote:
>>>> Hello,
>>>>
>>>> I had a RAID1 array on top of 4x4TB drives. Recently I removed one 
>>>> 4TB drive and added two 16TB drives to it. After running a full, 
>>>> unfiltered balance on the array, I am left in a situation where all 
>>>> the 4TB drives are completely empty, and all the data and metadata 
>>>> is on the 16TB drives. Is this normal? I was expecting to have at 
>>>> least some data on the smaller drives.
>>>>
>>>
>>> Yes, this is normal.  The BTRFS allocates space in drives with the the
>>> most available free space.  The idea is to balance the 'unallocated'
>>> space on each drive, so they can be filled evenly.  The 4TB drives will
>>> be used when the 16TB dives have less than 4TB unallocated.
>>
>
> Correct. That's the only allocation method we have at the moment. Do you
> have any feedback on whether there are any other allocation methods that
> make sense?


IMHO, based on the frequency of this question appearing here/on 
reddit/other sites, perhaps allocation by absolute space used?  It 
should fit the expectations of most folks that if you have free space on 
a disk it will be utilised, plus has potential performance implications 
by always using as many devices as possible to write to as long as they 
have any space left.

Regards,

Pedro


>
> Thanks, Anand
>
>> Interesting question and resolution. I'd be surprised by that as well.
>>
>> Now, a great chance to "btrfs dev delete" all three remaining 4TB 
>> drives and
>> unplug them for the time being, to save on noise, heat and power 
>> consumption!
>
