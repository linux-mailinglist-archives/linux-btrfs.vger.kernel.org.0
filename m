Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B3460D7E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 01:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiJYXaW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 19:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiJYXaR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 19:30:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D3C20F44
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 16:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666740609;
        bh=fifh+qMEwpd+y9efpuXTx3wUyTbkHfGQcly86coLWCs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=U7bnsDtLsjlyrqFQ5GwpJ3CINGXggLVLYTFqDfOnpEte/yRitAIXBUn7ekpDD2vXL
         iI7DBWtPyZGHzyFQiS/N3d2mwLYfuzFMS5u4MSLYoSVnPbT07uh84t4LN7sDj579RE
         Af0SI5ibfCRxUww82x9Sp+M5NbXzU4BzUpN40iKE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2V4J-1pDe0d0yb9-013vtE; Wed, 26
 Oct 2022 01:30:08 +0200
Message-ID: <a9310323-f19e-258a-5dac-88a40e50ce06@gmx.com>
Date:   Wed, 26 Oct 2022 07:30:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC 0/5] btrfs: raid56: do full stripe data checksum
 verification and recovery at RMW time
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1665730948.git.wqu@suse.com>
 <20221025134824.GK5824@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221025134824.GK5824@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wrlxG9oaV3q0ZMkv8IW7mIJCI8TkK+RYrsLXUSmlL9ZGcItCgsu
 w+Z6G3ahiw6ydgR4g/TAw8dlbyRpneqk6mq7hkX4B2repcDJGwjHVsRprnFtHn1Fa0j8P+l
 qh2b7PB+7TWWIswibZcfozsz/3WVAMDcFjjqK9axNona5woz9zlyJBAJAXDMNiqx2jwaLGE
 QExWFqUXlUsUYEedYrunA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SlGGi0P1VrA=:1EWfGxd4OryTcof7h8ru22
 cfcTg/XenEP5VwEHXZ+uiaZIjAHuWDUdsq1h4RtBaQ8A4jtydaXLT+6NDnDfZk3r/kNOUHtmS
 PcypiKkpyRCpE441f5nG5C2a2RMxb27y9hZiNeMIEp+35NZFxtIyrEXqT5VM0wftuQiPUBNRz
 PL2mqVpcz9HYWGBe0QyN7j8+pIYn0bOjv8FT3RFko7cYzwFIUJrWr3oKeAYtUPQnibw3MIezQ
 pYfAF0utxT7uG4yl2wiK2hzCH568io+YxNn6JNqe4O3KklxPGz5Ab7kzFuo1qMbgtXRx87zs1
 jHg+FWXkHGdfPbdT64G9f3ttu+oXBLs8tObrp6y3J3bzVK+YeDxS9pVU7Hn/RMFzkHm0AJcHt
 bnP3YbuvjFuHTDQjJSs1AGnXqTb0eqI7wHgkS5yTg8MnokeUNm66ZHYgelE+uLhIN10AgFZLt
 qnpgvjr2cFRaEsmnvmHVMb9GoQ9Z12LRB8Wdt0FkGVA00nDrXMeB0+EgFAc2lI7MJVQrgzMI9
 CglEpNZOEjMexKGYGJLQSxfh/Y3d0geidE0xgU1oZ4BK4z3SFJDWDonfeuRyZVNduRLiBpFwB
 gQL+VxJ6cCWkK1POEhhsjEkR77kD0ERM1IwUlbDi6NWuQ5rD/wlkVnG3Y1TBxCXFycybd9XIl
 FnXsLnFgb2aw6CVVeuvDoYrUx/iN+t9EwiK26dCrShs+FMkd2Fl9FlSsO8T4ZpRVta6g0Ftvv
 4UA+oOwJGkjLgkumLB+SeTsvE8B5+PjORUxa3LnSYBwlxCEEN0W6bq/79b6nHLZMZ1Om0fN58
 xVsBkOmHfB/DbKPbYwGFJNRNoblZuMQUVFYbAHrwsB9dFaDnX8Q57lZv3E+HXyCyCWU9gVvPb
 jleAnAx0AglHIXYXCsfGH2bPAgQoWb99t87+1eAyCcWbkpM+gd5qbWUDiXBRTB06H7HL96QjY
 B3NaQCKEm3/nzAXuyyztAYy0BbDIViqwtS0M5ab7UsH7MK4Hs3AWnMFFn6oOMydFdAZ5NfHLP
 lcHLKdqfYfx2YhYBsJjbUSzp161ulzT90SYVMs36G3UVchT3p/Uq8PB1yo+0JeL4yGxhVddss
 2s5DucQ0ffCKZZMRq82iQyv6/RvIgVurG9sedZCYpD05kCX8L1HveOO1YUX8snjZ5iRY2wn8y
 hfqmrpnL6iI9uqCJw0c7zlP3rExMAHFrXcDZtU95mL0bNNK1pMvskRizIa5lRJOd6O/RZF0oa
 OMplLf6wk1oZbDsoPXuQdjtYDvkR59TR5KFAahsKIDItMvAz7pTzxE8BIiIRZmAb0D8fPnpZt
 +DeiD5tffKZ6y6/tekvQf7UGXSJcxysEH1yS7TJqQEG1ejAmK6Ij326/03fwmx0n+nbx4j8Fa
 O41ttn8pA+canePDKemaadqAlBj6WJm0zxTsQd4LQN81rnlnDvHMInqOT+0hnCBxZRFyjAmxN
 0kBDtZoxJv67shjjNvGJvYVxb2ayLJ08wpohzBNzIXKTVQXp3a8nJK2t8j1QvlsT/x1v8oxen
 l9bpdqw8ShTth0fI7ugWgDieAQXLLOBQRspaOXFwm+ZgW
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/25 21:48, David Sterba wrote:
> On Fri, Oct 14, 2022 at 03:17:08PM +0800, Qu Wenruo wrote:
>> There is a long existing problem for all RAID56 (not only btrfs RAID56)=
,
>> that if we have corrupted data on-disk, and we do a RMW using that
>> corrupted data, we lose the chance of recovery.
>>
>> Since new parity is calculated using the corrupted sector, we will neve=
r
>> be able to recovery the old data.
>>
>> However btrfs has data checksum to save the day here, if we do a full
>> scrub level verification at RMW time, we can detect the corrupted data
>> before we do any write.
>>
>> Then do the proper recovery, data checksum recheck, and recovery the ol=
d
>> data and call it a day.
>>
>> This series is going to add such ability, currently there are the
>> following limitations:
>>
>> - Only works for full stripes without a missing device
>>    The code base is already here for a missing device + a corrupted
>>    sector case of RAID6.
>>
>>    But for now, I don't really want to test RAID6 yet.
>>
>> - We only handles data checksum verification
>>    Metadata verification will be much more complex, and in the long run
>>    we will only recommend metadata RAID1C3/C4 profiles to compensate
>>    RAID56 data profiles.
>>
>>    Thus we may never support metadata verification for RAID56.
>>
>> - If we found corrupted sectors which can not be repaired, we fail
>>    the whole bios for the full stripe
>>    This is to avoid further data corruption, but in the future we may
>>    just continue with corrupte data.
>>
>>    This will need extra work to rollback to the original corrupte data
>>    (as the recovery process will change the content).
>>
>> - Way more overhead for substripe write RMW cycle
>>    Now we need to:
>>
>>    * Fetch the datacsum for the full stripe
>>    * Verify the datacsum
>>    * Do RAID56 recovery (if needed)
>>    * Verify the recovered data (if needed)
>>
>>    Thankfully this only affects uncached sub-stripe writes.
>>    The successfully recovered data can be cached for later usage.
>>
>> - Will not writeback the recovered data during RMW
>>    Thus we still need to go back to recovery path to recovery.
>>
>>    This can be later enhanced to let RMW to write the full stripe if
>>    we did some recovery during RMW.
>>
>>
>> - May need further refactor to change how we handle RAID56 workflow
>>    Currently we use quite some workqueues to handle RAID56, and all
>>    work are delayed.
>>
>>    This doesn't look sane to me, especially hard to read (too many jump=
s
>>    just for a full RMW cycle).
>>
>>    May be a good idea to make it into a submit-and-wait workflow.
>>
>> [REASON for RFC]
>> Although the patchset does not only passed RAID56 test groups, but also
>> passed my local destructive RMW test cases, some of the above limitatio=
ns
>> need to be addressed.
>>
>> And whther the trade-off is worthy may still need to be discussed.
>
> So this improves reliability at the cost of a full RMW cycle, do you
> have any numbers to compare?

That's the problem, I don't have enough physical disks to do a real
world test.

But some basic analyze shows that, for a typical 5 disks RAID5, a full
stripe is 256K, if using the default CRC32 the csum would be at most 256
bytes.

Thus a csum search would at most read two leaves.

The cost should not be that huge AFAIK.

> The affected workload is a cold write in
> the middle of a stripe, following writes would likely hit the cached
> stripe. For linear writes the cost should be amortized, for random
> rewrites it's been always problematic regarding performance but I don't
> know if the raid5 (or any striped profile) performance was not better in
> some sense.

Just to mention another thing you may want to take into consideration,
I'm doing a refactor on the RAID56 write path, to make the whole
sub-stripe/full-stripe write path fit into a single function, and go
submit-and-wait path.

My current plan is to get the refactor merged (mostly done, doing the
tests now), then get the DRMW fix (would be much smaller and simpler to
merge after the refactor).

Thanks,
Qu
