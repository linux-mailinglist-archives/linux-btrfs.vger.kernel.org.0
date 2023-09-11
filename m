Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82B079A410
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Sep 2023 09:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjIKHCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 03:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjIKHCr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 03:02:47 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9479C
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 00:02:41 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qfawP-0001t6-Qo; Mon, 11 Sep 2023 09:02:37 +0200
Message-ID: <706df63f-ec5b-457a-b0ab-2d18816e3911@leemhuis.info>
Date:   Mon, 11 Sep 2023 09:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Wang Yugui <wangyugui@e16-tech.com>, Chris Mason <clm@meta.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        Chris Mason <clm@fb.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <20230811222321.2AD2.409509F4@e16-tech.com>
 <20ab0be0-e7d0-632b-b94c-89d76911f1ed@meta.com>
 <20230813175032.AA17.409509F4@e16-tech.com>
 <4108c514-77ff-a247-d6e1-2c12a5dea295@leemhuis.info>
In-Reply-To: <4108c514-77ff-a247-d6e1-2c12a5dea295@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694415761;89756994;
X-HE-SMSGID: 1qfawP-0001t6-Qo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Hmmm, nothing happened wrt to this regression during the past two weeks
afaics. Wonder if it fell through the cracks due to the merge window or
if there is a good reason. Was there progress and I just missed it? To
rule out the latter:

Wang Yugui, does the problem still happen with 6.6-rc1?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 29.08.23 11:45, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 13.08.23 11:50, Wang Yugui wrote:
>>> On 8/11/23 10:23 AM, Wang Yugui wrote:
>>>>> On Wed, Aug 02, 2023 at 08:04:57AM +0800, Wang Yugui wrote:
>>>>>>> And with only a revert of
>>>>>>>
>>>>>>> "btrfs: submit IO synchronously for fast checksum implementations"?
>>>>>> GOOD performance when only (Revert "btrfs: submit IO synchronously for fast
>>>>>> checksum implementations") 
>>>>> Ok, so you have a case where the offload for the checksumming generation
>>>>> actually helps (by a lot).  Adding Chris to the Cc list as he was
>>>>> involved with this.
>>>>>
>>>>>>>> -       if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
>>>>>>>> +       if ((bbio->bio.bi_opf & REQ_META) && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
>>>>>>>>                 return false;
>>>>>>> This disables synchronous checksum calculation entirely for data I/O.
>>>>>> without this fix, data I/O checksum is always synchronous?
>>>>>> this is a feature change of "btrfs: submit IO synchronously for fast checksum implementations"?
>>>>> It is never with the above patch.
>>>>>
>>>>>>> Also I'm curious if you see any differents for a non-RAID0 (i.e.
>>>>>>> single profile) workload.
>>>>>> '-m single -d single' is about 10% slow that '-m raid1 -d raid0' in this test
>>>>>> case.
>>>>> How does it compare with and without the revert?  Can you add the numbers?
>>>
>>> Looking through the thread, you're comparing -m single -d single, but
>>> btrfs is still doing the raid.
>>>
>>> Sorry to keep asking for more runs, but these numbers are a surprise,
>>> and I probably won't have time today to reproduce before vacation next
>>> week (sadly, Christoph and I aren't going together).
> 
> Sadly I also did not run into either you or Christoph during my own
> vacation during the last two weeks. But I'm back from it how, which got
> me wondering:
> 
> What happened to this regression? Was any progress made to resolve this
> in one way or another?
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke
> 
>>> Can you please do a run where lvm or MD raid are providing the raid0?
>> no LVM/MD used here.
>>
>>> It doesn't look like you're using compression, but I wanted to double check.
>>
>> Yes. '-m xx -d yy' with other default mkfs.btrfs option, so no compression.
>>
>>> How much ram do you have?
>>
>> 192G ECC memory.
>>
>> two CPU numa nodes, but all PCIe3 NVMe SSD are connected to one NVMe HBA/
>> one numa node.
>>
>>> Your fio run has 4 jobs going, can I please see the full fio output for
>>> a fast run and a slow run?
>>
>> fio results are saved into attachment files (fast.text & slow.txt)
>>
>> Best Regards
>> Wang Yugui (wangyugui@e16-tech.com)
>> 2023/08/13
