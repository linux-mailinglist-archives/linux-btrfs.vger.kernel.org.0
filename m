Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692285806D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 23:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbiGYVdP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 17:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbiGYVdC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 17:33:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA916468
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 14:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658784590;
        bh=zKXK+q2mGjS71IvN5tp3mc/aY5zmqiH8yLzL2H7OKJU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SxXKPxk1j+UFhDsDUilnoYw5Z0yxgSLCF10KDVgXb6qisaq97PZ4VHFrKeAiQ+woq
         SbgMP9FKNvjY+SUcQ7CmnBD59Yx2LsN2WuX07yfsWZEky5ipuBF7K7G73H+xwZuFZD
         dBxFOoCL7ozU/w+/fubEkVCZ5ud11ppzBwl1lu8w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNJq-1o2SWV2jv0-00VPAa; Mon, 25
 Jul 2022 23:29:50 +0200
Message-ID: <5699b8ca-1309-372e-5952-63daf09d9177@gmx.com>
Date:   Tue, 26 Jul 2022 05:29:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Content-Language: en-US
To:     kreijack@inwind.it, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Forza <forza@tnonline.net>, Chris Murphy <lists@colorremedies.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
 <CAJCQCtTJ=gs7JT4Tdxt3cOVTjkDD1_rQRqv6rbfwohu-Escw6w@mail.gmail.com>
 <b62a80a.e3c8d435.182134a0f8d@tnonline.net>
 <829a9b85-db35-1527-bf3d-081c3f4211b2@gmx.com>
 <Yt3dLAZQk1QGhVo2@hungrycats.org>
 <a3d3d872-f0f8-7cd7-7abd-6f4e8f511b57@inwind.it>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a3d3d872-f0f8-7cd7-7abd-6f4e8f511b57@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hFoXGasbaleFCDEH1+joj+VOaAdImxoMsvrbmMYrdYDy12G8fq5
 A5lMe2x7PBBryLnacxzZqQkp3aPlF9Xw6t9DS6AqP5YA/fTzIcZuiXuETTlOTfjkAdk7+Da
 QfGfLSHjiSOoYlSWTvOoTtYzywnRj2zcTLIjc/oM6f7QieJP3Vb3sJXnQFfOcuAPKoagAXN
 gxgXzE9UUogaqtCdQ5RJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qWfq4Z0M/Nc=:qehP3ndy8HA51cuV1q3rBO
 F/9RW82UF+U64YHykMJVToTuIMKu1/4lnxzVYXWv+HqjsvI4yRhq+rJJdMDeiclpgKCExR8Kh
 jvdw10EyQVrnCwG+U8z4n//ivAEtp+vo3dmvQI8tLfKYL517UV+BJ2w037hHDxnk9xmvS01S8
 +uwDX0Zn0o88Dd9knTN14PNsD9jA9IgIVd+JH6jrMW6cH1bQWMFyjZOip5xzEOM/BMpX9mCyk
 A48NpLqJzbICUF/cFelbT75yH8LHdkOu8kHez2YnqiPPkAcwud2eG+bshpG4icEZrso0UEcEA
 3PMS8abPbTB2DXhrfezEcsZPrXi/Nl2rq3QJjQFQQxjUzzOfY5lacPqbEjgV5GbuDXKwzJ9Nr
 0ZhHTmKZb1yasG+LFBBVA5fqbiRw+Wu2Jw06ay+fH4WrmIEPPBUmpEd3tuWzpmpsOXcuNUpsg
 WTgNBW0IgM6TKGgbEoaSZJ5h42Grj9Od4FrTPTiveSk6fbnz36DNNZI5pIKeOnMDyfyXlMaCV
 SQf7qN/uTejTw1r+YSDkfdNwViruoA14n1ZhieTfWd5gLCLsnPrqoJr1xHnasyDJY8v1jVFj4
 1eVEi+o63+1mrnCocWjPPORwRkxyjdPVdBff7e39rB5FeGlKqiXiKzzE7Vv8rGo9UNs6KfCDR
 l69n4XCgpXRca5YM6f8VZrquroKg/R++T4HbwfO+/aZta9/kSbliwzVaYbXoVkh8G3n08fqb7
 qb8Igv1eIhUzx/b++PkewAUXlw0t9K7GBJ5ec5L7rGS23EYlMjHJOJpK80e7y/bVcQugyQjh6
 xx5ks53breJIjQsOUGVoIApBAhlMHhi7MvKRH5RYVqJ8WyYuwAl7fI8PF76/E1l9ySdVev7O8
 u/myoAFXRu98OCCDT6Jna+EXsaqqTWnVn5K8cbaTWhFYsnfHp+J+ODf49ce3Zx9IX6iNeXglw
 q3XF8ICUQEoizlBSUdswsVDprQFfom0L021lqPSZMPgj3VD3TUpOGVzz8ttP5ZsmDUIotpAku
 cmCl6MePvscPT+GY3A94EWgzhdzRTaz7xrSzxPmI8tebvyeuzELMoKmS9AhXE9qQKOGLi1IxG
 IMEBQDE+dOStc8bBs9rsAc8DARH9q3c9uEpa7d8Yzw4Bti8bSG8+nsbmw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/26 03:58, Goffredo Baroncelli wrote:
> On 25/07/2022 02.00, Zygo Blaxell wrote:
>> On Tue, Jul 19, 2022 at 09:19:21AM +0800, Qu Wenruo wrote:
> [...]
>>
>> I'd agree with that.=C2=A0 e.g. some btrfs equivalent of ZFS raidZ (put=
 parity
>> blocks inline with extents during writes) is not much more complex to
>> implement on btrfs than compression; however, the btrfs kernel code
>> couldn't read compressed data correctly for 12 years out of its 14-year
>> history, and nobody wants to wait another decade or more for raid5
>> to work.
>>
>> It seems to me the biggest problem with write hole fixes is that all
>> the potential fixes have cost tradeoffs, and everybody wants to veto
>> the fix that has a cost they don't like.
>>
>> We could implement multiple fix approaches at the same time, as AFAIK
>> most of the proposed solutions are orthogonal to each other.=C2=A0 e.g.=
 a
>> write-ahead log can safely enable RMW at a higher IO cost, while the
>> allocator could place extents to avoid RMW and thereby avoid the loggin=
g
>> cost as much as possible (paid for by a deferred relocation/garbage
>> collection cost), and using both at the same time would combine both
>> benefits.=C2=A0 Both solutions can be used independently for filesystem=
s at
>> extreme ends of the performance/capacity spectrum (if the filesystem is
>> never more than 50% full, then logging is all cost with no gain compare=
d
>> to allocator avoidance of RMW, while a filesystem that is always near
>> full will have to journal writes and also throttle writes on the journa=
l.
>
> Kudos to Zygo; I have to say that I never encountered before a so clearl=
y
> explanation of the complexity around btrfs raid5/6 problems and the rela=
ted
> solutions.
>
>>
>>>> For example a non-striped redundant-n profile as well as a striped
>>>> redundant-n profile.
>>>
>>> Non-striped redundant-n profile is already so complex that I can't
>>> figure out a working idea right now.
>>>
>>> But if there is such way, I'm pretty happy to consider.
>>>
>>>>
>>>>>
>>>>> My 2 cents...
>>>>>
>>>>> Regarding the current raid56 support, in order of preference:
>>>>>
>>>>> a. Fix the current bugs, without changing format. Zygo has an
>>>>> extensive list.
>>>>
>>>> I agree that relatively simple fixes should be made. But it seems we
>>>> will need quite a large rewrite to solve all issues? Is there a
>>>> minium viable option here?
>>>
>>> Nope. Just see my write-intent code, already have prototype (just need=
s
>>> new scrub based recovery code at mount time) working.
>>>
>>> And based on my write-intent code, I don't think it's that hard to
>>> implement a full journal.
>>
>> FWIW I think we can get a very usable btrfs raid5 with a small format
>> change (add a journal for stripe RMW, though we might disagree about
>> details of how it should be structured and used)...
>
> Again, I have to agree with Zygo. Even tough I am fascinating by a solut=
ion
> like ZFS (parity block inside the extent), I think that a journal (and a
> write intent log) is a more pragmatic approach:
> - this kind of solution is below the btrfs bg; this would avoid to add
> further
>  =C2=A0 pressure on the metadata
> - being below to the other btrfs structure may be shaped more easily wit=
h
>  =C2=A0 less risk of incompatibility
>
> It is true that a ZFS solution may be more faster in some workload, but
> I think that these are very few:
>  =C2=A0 - for high throughput, you likely write the full stripe which do=
esn't
> need
>  =C2=A0=C2=A0=C2=A0 journal/ppl
>  =C2=A0 - for small block update, a journal is more efficient than rewri=
te the
>  =C2=A0=C2=A0=C2=A0 full stripe
>
>
> I hope that the end of Qu activities, will be a more robust raid5 btrfs
> implementation, which will in turn increase the number of user, and whic=
h
> in turn increase the pressure to improve this part of btrfs.
>
> My only suggestion is to evaluate if we need to develop a write intent l=
og
> and then a journal, instead of developing the journal alone. I think tha=
t
> two disk format changes are too much.

That won't be a problem.

For write-intent, we only need 4K, while during the development, I have
reserved 1MiB for write-intent and future journal.

Thus the format change will only be once.

Furthermore, that 1MiB can be tuned to be larger easily for journal.
And for existing RAID56 users, there will be a pretty quick way to
convert to the new write-intent/journal feature.

Thanks,
Qu

>
>
> BR
> G.Baroncelli
>> and fixes to the
>> read-repair and scrub problems.=C2=A0 The read-side problems in btrfs r=
aid5
>> were always much more severe than the write hole.=C2=A0 As soon as a di=
sk
>> goes offline, the read-repair code is unable to read all the surviving
>> data correctly, and the filesystem has to be kept inactive or data on
>> the disks will be gradually corrupted as bad parity gets mixed with dat=
a
>> and written back to the filesystem.
>>
>> A few of the problems will require a deeper redesign, but IMHO they're
>> not
>> important problems.=C2=A0 e.g. scrub can't identify which drive is corr=
upted
>> in all cases, because it has no csum on parity blocks.=C2=A0 The curren=
t
>> on-disk format needs every data block in the raid5 stripe to be occupie=
d
>> by a file with a csum so scrub can eliminate every other block as the
>> possible source of mismatched parity.=C2=A0 While this could be fixed b=
y
>> a future new raid5 profile (and/or csum tree) specifically designed
>> to avoid this, it's not something I'd insist on having before deploying
>> a fleet of btrfs raid5 boxes.=C2=A0 Silent corruption failures are so
>> rare on spinning disks that I'd use the feature maybe once a decade.
>> Silent corruption due to a failing or overheating HBA chip will most
>> likely affect multiple disks at once and trash the whole filesystem,
>> so individual drive-level corruption reporting isn't helpful.
>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>>> b. Mostly fix the write hole, also without changing the format, by
>>>>> only doing COW with full stripe writes. Yes you could somehow get
>>>>> corrupt parity still and not know it until degraded operation produc=
es
>>>>> a bad reconstruction of data - but checksum will still catch that.
>>>>> This kind of "unreplicated corruption" is not quite the same thing a=
s
>>>>> the write hole, because it isn't pernicious like the write hole.
>>>>
>>>> What is the difference to a)? Is write hole the worst issue? Judging
>>>> from the #brtfs channel discussions there seems to be other quite
>>>> severe issues, for example real data corruption risks in degraded mod=
e.
>>>>
>>>>> c. A new de-clustered parity raid56 implementation that is not
>>>>> backwards compatible.
>>>>
>>>> Yes. We have a good opportunity to work out something much better
>>>> than current implementations. We could have=C2=A0 redundant-n profile=
s
>>>> that also works with tired storage like ssd/nvme similar to the
>>>> metadata on ssd idea.
>>>>
>>>> Variable stripe width has been brought up before, but received cool
>>>> responses. Why is that? IMO it could improve random 4k ios by doing
>>>> equivalent to RAID1 instead of RMW, while also closing the write
>>>> hole. Perhaps there is a middle ground to be found?
>>>>
>>>>
>>>>>
>>>>> Ergo, I think it's best to not break the format twice. Even if a new
>>>>> raid implementation is years off.
>>>>
>>>> I very agree here. Btrfs already suffers in public opinion from the
>>>> lack of a stable and safe-for-data RAID56, and requiring several
>>>> non-compatible chances isn't going to help.
>>>>
>>>> I also think it's important that the 'temporary' changes actually
>>>> leads to a stable filesystem. Because what is the point otherwise?
>>>>
>>>> Thanks
>>>> Forza
>>>>
>>>>>
>>>>> Metadata centric workloads suck on parity raid anyway. If Btrfs alwa=
ys
>>>>> does full stripe COW won't matter even if the performance is worse
>>>>> because no one should use parity raid for this workload anyway.
>>>>>
>>>>>
>>>>> --
>>>>> Chris Murphy
>>>>
>>>>
>
