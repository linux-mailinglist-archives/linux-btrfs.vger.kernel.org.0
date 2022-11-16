Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A251562B1CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 04:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiKPDVZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 22:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKPDVY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 22:21:24 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7D4C11
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 19:21:22 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhD6g-1pQbvR0TwI-00eJC9; Wed, 16
 Nov 2022 04:21:19 +0100
Message-ID: <33e40e7c-5b9a-62e7-457c-24f85808d189@gmx.com>
Date:   Wed, 16 Nov 2022 11:21:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/5] btrfs: raid56: destructive RMW fix for RAID5 data
 profiles
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1668384746.git.wqu@suse.com>
 <20221115132452.GH5824@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221115132452.GH5824@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eZcFpk5D2yc33DPstyZ7hSAt6gXFyONbPKjR5mZwKXyFDaQsU3Q
 7woSv3LqiNesdjZ4pBcvQXSDhzxZ1hFe4KGOxie3fkjOcJaQWz5d3SfVlU3xwZNsXUNKuY7
 p+TAIXApEIeyGDmhQL2OxXKkp0kLDAlNPPWMO2XohplvdWnSMxH1FGjbWiUMVxlqG7SiyeH
 H3xEZtS8phuVwnT0kINfA==
UI-OutboundReport: notjunk:1;M01:P0:5xJlNvpHjhA=;auzlS8xq+Tr+rewDbyqF7kCOa7S
 NMl92QyTgvrrSNlAlqfv71tNrc89fyJB23ZfB5cjC9+Ri6O6ic4BYBCS7JERc7fGzh0aobjgD
 zA1Cra8CW2NKQaCy8YpmNw7neUXipB+kUrQytzBQLmtGogn6b2PrdgnAnTgbVF2sxrCr6fPzu
 hB8nupsXbU/HQti1oHZ02W93DmNpNmjCFFqFoQtd86ZD4+ml72MSuEINsVn/RaF610ydfMegs
 bnXNJ5sCpxznuZCEXTQqsAfVNkExTIa46sOMqMpYn+lmMGXHS8NFWMXx5dd0+za5aae9LoMOB
 +eC9ul/0YqqxfOU9hDARAbDsLqaOlcMSoj6tzNyjEYbJzJZSegq3uG/TXt0po/o8Ju6Dn+ptP
 mpvqHZVb9y+Bf7+h1TaLAwfAOh9r2qxLsyCfLtLVq7dUPQlXfsiqwg/Gibia2RKPY5pc/vkPk
 cWLOOLWJL3D3K+tYqqtRkHqX8o9cNcBWy8DZbk1jEqx3zu0Hgj6lKk2533mVNYkxyyPely8Uo
 8M39IKosjiWEpq/FRj/mhpUmkvtQU8WCoEqX+i6sMQUuPk4W3UFzDQlrYH+g5Mimc4zemBllw
 6qscCCw90si41ywA/5rBt7aeb1+PcMnd8rdotzan7m7gEQTnBcqlPvRBW0Pk46/Z+XtOcHl2i
 rMJmguvj+wUvyElQqpZnhUyPquUzd1N5q5GBws4t0nnDC8myJXyWC1zg9c4pMLQLZAsflby6D
 2QZOIDwAHE4Fl14WbvNycjzcJr6WH/c/RTeCxnH/pWOBdMfdYTKQXx6AEBTciD+XSdAXyqEny
 D+G5BM/cRGlC16zb+gQMSWeNYLSdX57JN3UnxgroO6nyY0GyMPSYL8obtus9E0hq9fMN3x1Kd
 ATcM7vHkMegVGYu/2pss5UrOJr5FgV3ADx+Q6nl5gHQxbhJIkCMlDZeZNxZf3J5HDHLCmq9Ii
 ScmT8w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/15 21:24, David Sterba wrote:
> On Mon, Nov 14, 2022 at 08:26:29AM +0800, Qu Wenruo wrote:
>> [DESTRUCTIVE RMW]
>> Btrfs (and generic) RAID56 is always vulnerable against destructive RMW.
>>
>> Such destructive RMW can happen when one of the data stripe is
>> corrupted, then a sub-stripe write into other data stripes happens, like
>> the following:
>>
>>
>>    Disk 1: data 1 |0x000000000000| <- Corrupted
>>    Disk 2: data 2 |0x000000000000|
>>    Disk 2: parity |0xffffffffffff|
>>
>> In above case, if we write data into disk 2, we will got something like
>> this:
>>
>>    Disk 1: data 1 |0x000000000000| <- Corrupted
>>    Disk 2: data 2 |0x000000000000| <- New '0x00' writes
>>    Disk 2: parity |0x000000000000| <- New Parity.
>>
>> Since the new parity is calculated using the new writes and the
>> corrupted data, we lost the chance to recovery data stripe 1, and that
>> corruption will forever be there.
> ...
>> [TODO]
>> - Iterate all RAID6 combinations
>>    Currently we don't try all combinations of RAID6 during the repair.
>>    Thus for RAID6 we treat it just like RAID5 in RMW.
>>
>>    Currently the RAID6 recovery combination is only exhausted during
>>    recovery path, relying on the caller the increase the mirror number.
>>
>>    Can be implemented later for RMW path.
>>
>> - Write back the repaired sectors
>>    Currently we don't write back the repaired sectors, thus if we read
>>    the corrupted sectors, we rely on the recover path, and since the new
>>    parity is calculated using the recovered sectors, we can get the
>>    correct data without any problem.
>>
>>    But if we write back the repaired sectors during RMW, we can save the
>>    reader some time without going into recovery path at all.
>>
>>    This is just a performance optimization, thus I believe it can be
>>    implemented later.
> 
> Even with the todo and potential performance drop due to mandatory
> stripe caching I think this is worth merging at this point, so patches
> are in misc-next now.
> 
> Regarding the perf drop, I'll try to get some results besides functional
> testing but if anybody with a decent setup for raid5 can do some
> destructive tests it would be most welcome.
> 
> Fallback plan is to revert the last patch if it turns out to be too
> problematic.

If you're concerned about the fallback plan, I'd say we need to at least 
drop the last two patches.

Sure, dropping the last one will remove the verification and the extra 
reads, but unfortunately we will still fetch the csum for RMW cycles.
Although the csum fetch would at most cost 2 leaves, the cost is still 
there.

Thus if needed, I can do more refactoring of the series, to separate the 
final patch.
Although I hope we don't need to go that path.

Thanks,
Qu
