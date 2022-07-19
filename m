Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F164578FC6
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 03:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiGSBTk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 21:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGSBTk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 21:19:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6569B63C1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 18:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658193568;
        bh=h41QOzYDPZINh/CYkTMF3CXxPmwZBgRSx9dlEpAnyu4=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=I5dpoLsuUPMpGGyZGyE9ymHdvnStKIwdXrvRft03U8I+K9AM2UsXlD/oXmvTS6VPe
         O/3kdArssnY5ZXj6EhWHFWYzequvsxWwwccjQFtuysaccyr2akN42jvvRljrYPEgAS
         8JZtWXJFyQrJfHORP7g7hMb0jTkNqeHDFdP54hAs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8hZJ-1o9VHy1xD7-004frU; Tue, 19
 Jul 2022 03:19:28 +0200
Message-ID: <829a9b85-db35-1527-bf3d-081c3f4211b2@gmx.com>
Date:   Tue, 19 Jul 2022 09:19:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Forza <forza@tnonline.net>, Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
 <CAJCQCtTJ=gs7JT4Tdxt3cOVTjkDD1_rQRqv6rbfwohu-Escw6w@mail.gmail.com>
 <b62a80a.e3c8d435.182134a0f8d@tnonline.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
In-Reply-To: <b62a80a.e3c8d435.182134a0f8d@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ETAdV/1+MoV7jKvYby3T82WuO0vJUV40FPgjjbljK5qOlRiP+1w
 Gr4g7fx2BCecosn/p4hCHtV0HHl1ZFoLIu81KwE0k2Y60+TYrIkFYawsqsSOU1G86h1Ya4X
 VuHaDXP63NRuRDGAF5Tk7H92OCQd9/n+aH2ln1k/ARFOw0GJ+gj4g8NX/PGNmy4MVeJwkYl
 M7FwCx2QzuMPQUc0vdoYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JEHZyUaosAw=:9w1m7J/rZUFhJN1dbMBTuE
 or4Cd3SgWWSBThu09eVUxb8+O0J41S0cWdKhkfnnWVk1JPHCJfeTRlX1WEpTuC84C0aTMUpRf
 dztILZ9LvU873flwEgQfiYhNIwOuK2sJcXXs8WwdokS8GRJF7/5Gfet4+LR3owc6ujVPn0x1R
 hd5LdFY01n7Y6Jr1XixnaR9nRmY/yQp9uL47BVGBnpsOKrsi554n9GfQsuVKMPga4K9Se81IS
 43sp619iVd5j2HUDMGOmmxNCMK7GNXmb/KmWHVc0lEATvOHzWjexhAIPYbJL6Uuuu0452b6l6
 hceJf8tl0alBeHb8PdCeJgv/y5mIgp89nBfF7V7fzDxSHf15t9LVKv+y7xFr1QD7MWBwizQCk
 p0JyGNiYNFVlwyeUqtRZX3K6cqurzR/46ZJm6ZElM91CZxU1nRV9A/TT3bn/VBP9b2t/T0UcO
 jOB0JqtnuB/pUHKc1W2BjkD4+2Ah5RCwlVt7txY+abH2fr95CKvltVE/Qjmqf119BDJ2VV81O
 4A3WoInChD+HRibOQkIunpKUZzBjGL+WgUW1eDsifGzxuiVczuJtEoMiJDVAICDqPBc/1oK3x
 p8oXu4qDpUw1WxDOud0DkVIrlUUliJTrki8IPPBBBlkePGge4mGOy8fb9DADpdL6Ac3OUzLtz
 RSAtBHiLCmLZYf63aLmonmkuRriCm/Wn6sSsLXN3vFqYC248XSgOporrHMFx7u4E0fU2U+fuc
 qyLAb/P9tuvdvfjlxCl7GicdTgGNBVtWs1M47s+OIJW2Nv7UbKZvKMeBnTJjIMnrcNZW1ReGB
 JJg0rt1rjh58oLaS3r5yzMrkhR9we+fO0F0j3BTXMjz2YTg8DRuZpbTNZffCU1dQCNIDPLv89
 08d0vPoTZPXo1NQEMaB1H2ys5DMQRZIfjYewKS8fqPLBGJqyDg5NII84UVvqONQMnXLsiK57h
 u/EsWuiMpLnGkw6jh1YVsDrrN2xmuSzmqG8IAnJL0gqx6I1/LCRT2MA8ZVR3B1tzr2gHCeD64
 AhckNh0JqjuvEDM6gFaSVfBEk3EmnzjM/rNgzKp0QiL87ZM213rAzTINJvQaIQpKdiJYZ2Grm
 j4Kv6KB3GRqBVlctXd+LC2Fb7jG6VRWUKKTU7Wf3TiIG0OnyHQ5R03fKA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/19 05:49, Forza wrote:
>
>
> ---- From: Chris Murphy <lists@colorremedies.com> -- Sent: 2022-07-15 - =
22:14 ----
>
>> On Fri, Jul 15, 2022 at 1:55 PM Goffredo Baroncelli <kreijack@libero.it=
> wrote:
>>>
>>> On 14/07/2022 09.46, Johannes Thumshirn wrote:
>>>> On 14.07.22 09:32, Qu Wenruo wrote:
>>>>> [...]
>>>>
>>>> Again if you're doing sub-stripe size writes, you're asking stupid th=
ings and
>>>> then there's no reason to not give the user stupid answers.
>>>>
>>>
>>> Qu is right, if we consider only full stripe write the "raid hole" pro=
blem
>>> disappear, because if a "full stripe" is not fully written it is not
>>> referenced either.
>>>
>>>
>>> Personally I think that the ZFS variable stripe size, may be interesti=
ng
>>> to evaluate. Moreover, because the BTRFS disk format is quite flexible=
,
>>> we can store different BG with different number of disks.
>
> We can create new types of BGs too. For example parity BGs.
>
>>> Let me to make an
>>> example: if we have 10 disks, we could allocate:
>>> 1 BG RAID1
>>> 1 BG RAID5, spread over 4 disks only
>>> 1 BG RAID5, spread over 8 disks only
>>> 1 BG RAID5, spread over 10 disks
>>>
>>> So if we have short writes, we could put the extents in the RAID1 BG; =
for longer
>>> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by le=
ngth
>>> of the data.
>>>
>>> Yes this would require a sort of garbage collector to move the data to=
 the biggest
>>> raid5 BG, but this would avoid (or reduce) the fragmentation which aff=
ect the
>>> variable stripe size.
>>>
>>> Doing so we don't need any disk format change and it would be backward=
 compatible.
>
> Do we need to implement RAID56 in the traditional sense? As the user/sys=
admin I care about redundancy and performance and cost. The option to crea=
te redundancy for any 'n drives is appealing from a cost perspective, othe=
rwise I'd use RAID1/10.

Have you heard any recent problems related to dm-raid56?

If your answer is no, then I guess we already have an  answer to your
question.

>
> Since the current RAID56 mode have several important drawbacks

Let me to be clear:

If you can ensure you didn't hit power loss, or after a power loss do a
scrub immediately before any new write, then current RAID56 is fine, at
least not obviously worse than dm-raid56.

(There are still common problems shared between both btrfs raid56 and
dm-raid56, like destructive-RMW)

> - and that it's officially not recommended for production use - it is a =
good idea to reconstruct new btrfs 'redundant-n' profiles that doesn't hav=
e the inherent issues of traditional RAID.

I'd say the complexity is hugely underestimated.

> For example a non-striped redundant-n profile as well as a striped redun=
dant-n profile.

Non-striped redundant-n profile is already so complex that I can't
figure out a working idea right now.

But if there is such way, I'm pretty happy to consider.

>
>>
>> My 2 cents...
>>
>> Regarding the current raid56 support, in order of preference:
>>
>> a. Fix the current bugs, without changing format. Zygo has an extensive=
 list.
>
> I agree that relatively simple fixes should be made. But it seems we wil=
l need quite a large rewrite to solve all issues? Is there a minium viable=
 option here?

Nope. Just see my write-intent code, already have prototype (just needs
new scrub based recovery code at mount time) working.

And based on my write-intent code, I don't think it's that hard to
implement a full journal.

Thanks,
Qu

>
>> b. Mostly fix the write hole, also without changing the format, by
>> only doing COW with full stripe writes. Yes you could somehow get
>> corrupt parity still and not know it until degraded operation produces
>> a bad reconstruction of data - but checksum will still catch that.
>> This kind of "unreplicated corruption" is not quite the same thing as
>> the write hole, because it isn't pernicious like the write hole.
>
> What is the difference to a)? Is write hole the worst issue? Judging fro=
m the #brtfs channel discussions there seems to be other quite severe issu=
es, for example real data corruption risks in degraded mode.
>
>> c. A new de-clustered parity raid56 implementation that is not
>> backwards compatible.
>
> Yes. We have a good opportunity to work out something much better than c=
urrent implementations. We could have  redundant-n profiles that also work=
s with tired storage like ssd/nvme similar to the metadata on ssd idea.
>
> Variable stripe width has been brought up before, but received cool resp=
onses. Why is that? IMO it could improve random 4k ios by doing equivalent=
 to RAID1 instead of RMW, while also closing the write hole. Perhaps there=
 is a middle ground to be found?
>
>
>>
>> Ergo, I think it's best to not break the format twice. Even if a new
>> raid implementation is years off.
>
> I very agree here. Btrfs already suffers in public opinion from the lack=
 of a stable and safe-for-data RAID56, and requiring several non-compatibl=
e chances isn't going to help.
>
> I also think it's important that the 'temporary' changes actually leads =
to a stable filesystem. Because what is the point otherwise?
>
> Thanks
> Forza
>
>>
>> Metadata centric workloads suck on parity raid anyway. If Btrfs always
>> does full stripe COW won't matter even if the performance is worse
>> because no one should use parity raid for this workload anyway.
>>
>>
>> --
>> Chris Murphy
>
>
