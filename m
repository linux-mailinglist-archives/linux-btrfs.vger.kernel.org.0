Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D9B543D7F
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 22:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiFHUWj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 8 Jun 2022 16:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiFHUWh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 16:22:37 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A7B158758
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 13:22:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 95C703F78B;
        Wed,  8 Jun 2022 22:22:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.91
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IEEl-R9iJEEd; Wed,  8 Jun 2022 22:22:30 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 171B33F623;
        Wed,  8 Jun 2022 22:22:30 +0200 (CEST)
Received: from [192.168.0.113] (port=40330)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nz2CD-000EiW-Gf; Wed, 08 Jun 2022 22:22:29 +0200
Date:   Wed, 8 Jun 2022 22:22:33 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>,
        Nicholas D Steeves <nsteeves@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <5532eba.f5bd40a9.18144fbad50@tnonline.net>
In-Reply-To: <cf220242-25dd-9241-01d5-38555c262d9e@gmail.com>
References: <c31c664.705b352f.1810f98f3ee@tnonline.net> <20220608104421.3759.409509F4@e16-tech.com> <20220608181502.4AB1.409509F4@e16-tech.com> <a97ff3a3-7b14-e6a4-32e9-b9da8cec422e@gmx.com> <cf220242-25dd-9241-01d5-38555c262d9e@gmail.com>
Subject: Re: What mechanisms protect against split brain?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Andrei Borzenkov <arvidjaar@gmail.com> -- Sent: 2022-06-08 - 16:11 ----

> On 08.06.2022 13:32, Qu Wenruo wrote:
>> 
>> 
>> On 2022/6/8 18:15, Wang Yugui wrote:
>>> Hi, Forza, Qu Wenruo
>>>
>>> I write a script to test RAID1 split brain base on Qu's work of raid5(*1)
>>> *1: https://lore.kernel.org/linux-btrfs/53f7bace2ac75d88ace42dd811d48b7912647301.1654672140.git.wqu@suse.com/T/#u
>> 
>> No no no, that is not to address split brain, but mostly to drop cache
>> for recovery path to maximize the chance of recovery.
>> 
>> It's not designed to solve split brain problem at all, it's just one
>> case of such problem.
>> 
>> In fact, fully split brain (both have the same generation, but
>> experienced their own degraded mount) case can not be solved by btrfs
>> itself at all.
>> 
>> Btrfs can only solve partial split brain case (one device has higher
>> generation, thus btrfs can still determine which copy is the correct one).
>> 
> 
> Start with both devices having the same generation number N.
> 
> Mount device1 separately, do some writes, device has generation N+1.
> 
> Mount device2 separately, do some writes, device has generation N+2.
> 
> Applying changes between N+1 and N+2 to device1 is wrong because content
> of N+1 is different on both devices.
> 
> So there is absolutely no difference between "same generation" and
> "higher generation".
> 
> The only thing btrfs could do is to try to detect this and refuse to
> integrate another device. One suggested rather radical approach was to
> change UUID on degraded mount, but this is probably unfeasible in real life.
> 
> Removing missing device from device list in superblock (or at least
> marking it as permanently missing until replaced) is probably another
> option.
> 
> And write intent log as discussed further in this thread could be used
> as well - if btrfs detects write intent log on device it should refuse
> to add it to existing filesystem.


Thank you all for the feedback on this topic. 

My take away from this is that we need to;
* clearly document the Btrfs cannot handle full split brain 
* document best practices on how to recover from a temporary device loss 
* add features that help btrfs handle both types of split brain in a safe way. 

One such mechanism could be to write a simple hash on all existing devices during a degraded mount. If the old device is re-attached, the hash will mismatch and btrfs should reject this device.

Then a special 'btrfs device add --reattach' command could be developed that would do what Qu said, run a full scrub and correct any differences on the reattached device. This avoids writing all data again, which is faster and saves TBW.

Nicholas suggested a similar approach in another thread https://lore.kernel.org/linux-btrfs/87sfogkwbd.fsf@DigitalMercury.freeddns.org/T/#t

Thanks,
Forza

