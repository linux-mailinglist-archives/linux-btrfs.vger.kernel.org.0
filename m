Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8B1778954
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 10:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjHKI6g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 04:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjHKI6f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 04:58:35 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85B0E76
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 01:58:31 -0700 (PDT)
Received: from 46.183.103.8.relaix.net ([46.183.103.8] helo=[172.18.99.178]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qUNyX-0002YE-1r; Fri, 11 Aug 2023 10:58:29 +0200
Message-ID: <adfdb843-2220-5969-e647-d31ba8684d42@leemhuis.info>
Date:   Fri, 11 Aug 2023 10:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Content-Language: en-US, de-DE
To:     Christoph Hellwig <hch@lst.de>, Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230801235123.B665.409509F4@e16-tech.com>
 <20230801155649.GA13009@lst.de> <20230802080451.F0C2.409509F4@e16-tech.com>
 <20230802092631.GA27963@lst.de>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230802092631.GA27963@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691744311;e1da6cc4;
X-HE-SMSGID: 1qUNyX-0002YE-1r
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_PASS,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02.08.23 11:26, Christoph Hellwig wrote:
> On Wed, Aug 02, 2023 at 08:04:57AM +0800, Wang Yugui wrote:
>>> And with only a revert of
>>>
>>> "btrfs: submit IO synchronously for fast checksum implementations"?
>>
>> GOOD performance when only (Revert "btrfs: submit IO synchronously for fast
>> checksum implementations") 
> 
> Ok, so you have a case where the offload for the checksumming generation
> actually helps (by a lot).  Adding Chris to the Cc list as he was
> involved with this.

Radio silence from Chris here and on lore in general afaics. Also
nothing new in this thread for more than a week now.

CCing David and Josef, maybe they have an idea what's up here and if
Chris might be afk for longer -- and maybe this can still be fixed
before the 6.5 release.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>>>> -       if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
>>>> +       if ((bbio->bio.bi_opf & REQ_META) && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
>>>>                 return false;
>>>
>>> This disables synchronous checksum calculation entirely for data I/O.
>>
>> without this fix, data I/O checksum is always synchronous?
>> this is a feature change of "btrfs: submit IO synchronously for fast checksum implementations"?
> 
> It is never with the above patch.
> 
>>
>>> Also I'm curious if you see any differents for a non-RAID0 (i.e.
>>> single profile) workload.
>>
>> '-m single -d single' is about 10% slow that '-m raid1 -d raid0' in this test
>> case.
> 
> How does it compare with and without the revert?  Can you add the numbers?
