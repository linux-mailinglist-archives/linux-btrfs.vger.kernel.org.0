Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117B2578D15
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 23:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbiGRVuJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 18 Jul 2022 17:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiGRVuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 17:50:07 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720172D1ED
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 14:50:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id C6AD83F447;
        Mon, 18 Jul 2022 23:50:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aHmFBjfAZxpo; Mon, 18 Jul 2022 23:50:02 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 7C54D3F311;
        Mon, 18 Jul 2022 23:50:01 +0200 (CEST)
Received: from [192.168.0.119] (port=55342)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1oDYco-000FeX-VY; Mon, 18 Jul 2022 23:49:59 +0200
Date:   Mon, 18 Jul 2022 23:49:57 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <b62a80a.e3c8d435.182134a0f8d@tnonline.net>
In-Reply-To: <CAJCQCtTJ=gs7JT4Tdxt3cOVTjkDD1_rQRqv6rbfwohu-Escw6w@mail.gmail.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com> <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com> <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com> <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com> <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com> <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com> <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com> <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com> <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com> <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com> <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com> <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it> <CAJCQCtTJ=gs7JT4Tdxt3cOVTjkDD1_rQRqv6rbfwohu-Escw6w@mail.gmail.com>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8]
 btrfs: introduce raid-stripe-tree")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Chris Murphy <lists@colorremedies.com> -- Sent: 2022-07-15 - 22:14 ----

> On Fri, Jul 15, 2022 at 1:55 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>>
>> On 14/07/2022 09.46, Johannes Thumshirn wrote:
>> > On 14.07.22 09:32, Qu Wenruo wrote:
>> >>[...]
>> >
>> > Again if you're doing sub-stripe size writes, you're asking stupid things and
>> > then there's no reason to not give the user stupid answers.
>> >
>>
>> Qu is right, if we consider only full stripe write the "raid hole" problem
>> disappear, because if a "full stripe" is not fully written it is not
>> referenced either.
>>
>>
>> Personally I think that the ZFS variable stripe size, may be interesting
>> to evaluate. Moreover, because the BTRFS disk format is quite flexible,
>> we can store different BG with different number of disks. 

We can create new types of BGs too. For example parity BGs. 

>>Let me to make an
>> example: if we have 10 disks, we could allocate:
>> 1 BG RAID1
>> 1 BG RAID5, spread over 4 disks only
>> 1 BG RAID5, spread over 8 disks only
>> 1 BG RAID5, spread over 10 disks
>>
>> So if we have short writes, we could put the extents in the RAID1 BG; for longer
>> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by length
>> of the data.
>>
>> Yes this would require a sort of garbage collector to move the data to the biggest
>> raid5 BG, but this would avoid (or reduce) the fragmentation which affect the
>> variable stripe size.
>>
>> Doing so we don't need any disk format change and it would be backward compatible.

Do we need to implement RAID56 in the traditional sense? As the user/sysadmin I care about redundancy and performance and cost. The option to create redundancy for any 'n drives is appealing from a cost perspective, otherwise I'd use RAID1/10.

Since the current RAID56 mode have several important drawbacks - and that it's officially not recommended for production use - it is a good idea to reconstruct new btrfs 'redundant-n' profiles that doesn't have the inherent issues of traditional RAID. For example a non-striped redundant-n profile as well as a striped redundant-n profile. 

> 
> My 2 cents...
> 
> Regarding the current raid56 support, in order of preference:
> 
> a. Fix the current bugs, without changing format. Zygo has an extensive list.

I agree that relatively simple fixes should be made. But it seems we will need quite a large rewrite to solve all issues? Is there a minium viable option here? 

> b. Mostly fix the write hole, also without changing the format, by
> only doing COW with full stripe writes. Yes you could somehow get
> corrupt parity still and not know it until degraded operation produces
> a bad reconstruction of data - but checksum will still catch that.
> This kind of "unreplicated corruption" is not quite the same thing as
> the write hole, because it isn't pernicious like the write hole.

What is the difference to a)? Is write hole the worst issue? Judging from the #brtfs channel discussions there seems to be other quite severe issues, for example real data corruption risks in degraded mode. 

> c. A new de-clustered parity raid56 implementation that is not
> backwards compatible.

Yes. We have a good opportunity to work out something much better than current implementations. We could have  redundant-n profiles that also works with tired storage like ssd/nvme similar to the metadata on ssd idea. 

Variable stripe width has been brought up before, but received cool responses. Why is that? IMO it could improve random 4k ios by doing equivalent to RAID1 instead of RMW, while also closing the write hole. Perhaps there is a middle ground to be found? 


> 
> Ergo, I think it's best to not break the format twice. Even if a new
> raid implementation is years off.

I very agree here. Btrfs already suffers in public opinion from the lack of a stable and safe-for-data RAID56, and requiring several non-compatible chances isn't going to help. 

I also think it's important that the 'temporary' changes actually leads to a stable filesystem. Because what is the point otherwise? 

Thanks
Forza

> 
> Metadata centric workloads suck on parity raid anyway. If Btrfs always
> does full stripe COW won't matter even if the performance is worse
> because no one should use parity raid for this workload anyway.
> 
> 
> --
> Chris Murphy


