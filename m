Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5675AFF83
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 10:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiIGIqS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 04:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiIGIqO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 04:46:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638E774CF6
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662540366;
        bh=zXHVnKvaOLovZgrBn7yed027a8ttsT4Jl9duP+cwQ8Q=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=jkpWasJXuMHtXFyZLA4fXof8uBIh+CyBJRDnd71RciQVcicHgp4iX7PxQ2f6eWKEM
         +Gfch3XaLe7JTWe4nDb+fPgpQWoRAsuBv8KFIs1kRs00IyHji3t0JSlSLRuIrMXgZQ
         I2u36R86eKiy/JeslG4+1iH1L/MAI/f253HEA3Vo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY6Cb-1oqy3c1uZh-00YS93; Wed, 07
 Sep 2022 10:46:06 +0200
Message-ID: <70caa5b6-af86-2841-c602-602c0306fca2@gmx.com>
Date:   Wed, 7 Sep 2022 16:46:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: some help for improvement in btrfs
To:     hmsjwzb <hmsjwzb@zoho.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <fb056073-5bd6-6143-9699-4a5af1bd496d@zoho.com>
 <655f97cc-64e6-9f57-5394-58f9c3b83a6f@gmx.com>
 <40b209eb-9048-da0c-e776-5e143ab38571@zoho.com>
 <72a78cc0-4524-47e7-803c-7d094b8713ee@gmx.com>
 <00984321-3006-764d-c29e-1304f89652ae@zoho.com>
 <18300547-1811-e9da-252e-f9476dca078c@gmx.com>
 <4691b710-3d71-bd26-d00a-66cc398f57c5@zoho.com>
 <7553372e-1485-63ae-d3f1-e9e0a318b2f6@gmx.com>
 <9c295a8c-5167-116e-4fae-d548f1deb3b2@zoho.com>
 <1b00d889-bf4b-a092-38c0-fb6c6aa09fdf@gmx.com>
 <e2e84e6c-147a-b54b-1213-32a1b7c34660@zoho.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e2e84e6c-147a-b54b-1213-32a1b7c34660@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dWuaADhsDNjKrZUFPNn26rKqSJLRBegEuA3oLak56K/XtuC88ER
 bYDrHD9993APUiHL2k68EX8bwAf1L8lnWdjAPEhoVpyheFxt5b2HKInfVCL+aa46aSR3Clf
 0nMsrx8KB1DatGDw0LLdX+WZtLuZPFOVH/M1xRLd7iFk6aRUflzGqrv2Lm++ggybLUOlwOX
 9oXb9g7y5/+u6sgbngRLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dEkdEXpzGrM=:kGwAyg6di8tS6x3ed2VqZR
 j95RtkkTSoj8Hrxo9fOnPU6F3HsHQI5xMNvL2PYOdbJZglfVS7Z+KybjxAwg+9GlDX4Q6PD1S
 8nHk3JCrvwfN2egpIZmXA+AkD/kCS/xV6s4mjOBaQJQRjOFsNZhJY/s5NWdAciNHpLCypssXH
 0i6uQMzUxJkFQGNF6XRJ50atB9Abtgwi4NCCSGULWLODpdOYv4OlJPsCHn14MeQUapIJTeuSA
 EvDhFkAAtiGrqBXulmJSfYs29sDn9bMC+drZf5pf496iRN0b1QB+Xu87KSs/2kGvbSVzAJXo5
 8IquM9L88TxIf6hiuA/ZT3bVmuY2f+lzt4+lyp4KDrMwVsWR3lVj8lcxNZk8n7EyNE1bBqjfg
 cUJLzXX5ZzZLUKRXC05jPK8hPpEwe6mqwTXXXKaFY0mGiS0DLJrjV668eOvKQ4KFirD019tGs
 evNxt/Es8+g7TZ74Hb07C7e7RnzHe/nMLmLqykmLX/cilWVmwvGD3cW7QRXONl4vojOkpgucZ
 1WsIfMyhivozInEXSLxt8XoAOr0ud5p7+jKTrs74599FyA3IXXu0Z5Nnfs11LoaTTvd1LwwbM
 J8Eyn1BKZT1quT5XmGhueS6h0PLKBibBrTIFqpG8Fx487qlXnGm/6ZPPnwBFhvVaupu+GnIA2
 Kyz8SMnugXcgjmmTH6LPgAqgoH6ZMbmpnwnMGm+5HLqFzYmrXEhm0nUPN9T5cde8klZPySKww
 kL3QEVYCHc91IMcGX/SnZbfrHNQGb8tUZSxT23Y+3HnGT9GYEUyYElzmChBu9ze89DURdp45u
 WV+IbFVepGRzyvjUdOEduV+owPT0/l88sQdNM0fmP3RQeI9JOkIHjDWsQhT8IZ9KiBrHzOCUT
 W+GM7lTstSykVFYnM2S8BYl8UnBaD7KCNNfjOMA1FhxGwbQiTip69xcfTGdB30GKCBzmfuACp
 xQ6HtKu+BVrIW7MCrBjtl5NlWJY/DdVHRA0ys/MXAfUVQ/tf79tPgILVrZQ+r2kaE5eeum3mT
 LWhv+6NdPg6NrPz5o9Zo6aTRlokfWM2aOegxnm4AwtFd+S4ioOkUBR7tmd4ZuQjwwNlMBp6Zb
 b1BN8RWA3Ppc5xtcrw7rk9UICRBkGK87HfcNaY//qWh8KtU4/Y9XfYYp12HMXfUr43d0tAijI
 Igpia9hRg46M01fJHJBzkxPFZ7
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/7 16:24, hmsjwzb wrote:
>
[...]
>> That's the idea to fix the destructive RMW, aka when doing sub-stripe
>> write, we need to:
>>
>> 1. Collected needed data to do the recovery
>>  =C2=A0=C2=A0 For data, it should be all csum inside the full stripe.
>>  =C2=A0=C2=A0 For metadata, although the csum is inlined, we still need=
 to find out
>>  =C2=A0=C2=A0 which range has metadata, and this can be a little tricky=
.
>
> Hi Qu,
>
>    As for fix solution, I think the following method don't need a on-dis=
k format.

I never mentioned we need a on-disk format change.

I just mentioned some pitfalls you need to look after.

>
>      For Data:
>        When we write to disk, we do checksum for the writing data.
>
>          dev1 |...|DDUUUUUUUUUU|...|
>          dev2 |...|UUUUUUUUUUUU|...|
>          dev3 |...|PPPPPPPPPPPP|...|
>
> 	D:data Space:unused P:parity  U:unused
>
>        The checksum block will look like the following.
>          dev1 |...|CC          |...|
>          dev2 |...|            |...|
>          dev3 |...|            |...|
>
>          C:Checksum
>
>        So if data is corrupted in the area we write, we can know it. But=
 when the corruption happened in
>        the unused block. We can do nothing about it.

We don't need to bother corruption happened in unused space at all.

We only need to ensure our data and parity is correct.

So if the data sectors are fine, although parity mismatches, it's not a
problem, we just do the regular RMW, and correct parity will be
re-calculated and write back to that disk.

>        The checksum of blocks marked with C will be calculated and inser=
ted into checksum tree.

Why insert? There is no insert needed at all.

And furthermore, data csum insert happens way later, RAID56 layer should
not bother to insert the csum.

If you're talking about writing the first two sectors, they should not
have csum at all, as data COW ensured we can only write data into unused
space.

Please make it clear what you're really wanting to do, using W for
blocks to write, U for unused, C for old data which has csum.

(Don't bother NODATASUM case for now).

Thanks,
Qu

>
>        But what if we do the checksum of the full stripe.
>                   |<--stripe1->|
>          dev1 |...|CCCCCCCCCCCC|...|
>                   |<--stripe2->|
>          dev2 |...|CCCCCCCCCCCC|...|
>          dev3 |...|            |...|
>
>        So in the rmw process, we can do the following operation.
>          1.Calculate the checksum of blocks in stripe1 and compare them =
with the checksum in checksum tree.
>            If mismatch then stripe1 is corrupted, otherwise stripe1 is g=
ood.
>          2.We can do the same process for stripe2. So we can tell whethe=
r stripe2 is corrupted or good.
> 	3.In this condition, if parity check failed, we can know which stripe i=
s corrupted and use the good
>            data to recover the bad.
>
> Thanks,
> Flint
>
>> 2. Read out all data and stripe, including the range we're writing into
>>  =C2=A0=C2=A0 Currently we skip the range we're going to write, but sin=
ce we may
>>  =C2=A0=C2=A0 need to do a recovery, we need the full stripe anyway.
>>
>> 3. Do full stripe verification before doing RMW.
>>  =C2=A0=C2=A0 That's the core recovery, thankfully we should have very =
similiar
>>  =C2=A0=C2=A0 code existing already.
>>
>>>
>>> [question]
>>>  =C2=A0=C2=A0=C2=A0=C2=A0I have noticed this patch.
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [PATCH PoC 0/9] btrfs: scr=
ub: introduce a new family of ioctl, scrub_fs
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hi Qu,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Is=
 some part of this patch aim to solve this problem?
>>
>> Nope, that's just to improve scrub for RAID56, nothing related to this
>> destructive RMW thing at all.
>>
>> Thanks,
>> Qu
>>>
>>> Thanks,
>>> Flint
>>>
>>>
>>> On 8/16/22 01:38, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/8/16 10:47, hmsjwzb wrote:
>>>>> Hi Qu,
>>>>>
>>>>> Sorry for interrupt you so many times.
>>>>>
>>>>> As for
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scrub level checks at RAID56 substrip=
e write time.
>>>>>
>>>>> Is this feature available in latest linux-next branch?
>>>>
>>>> Nope, no one is working on that, thus no patches at all.
>>>>
>>>>> Or may I need to get patches from mail list.
>>>>> What is the core function of this feature ?
>>>>
>>>> The following small script would explain it pretty well:
>>>>
>>>>  =C2=A0=C2=A0 mkfs.btrfs -f -m raid5 -d raid5 -b 1G $dev1 $dev2 $dev3
>>>>  =C2=A0=C2=A0 mount $dev1 $mnt
>>>>
>>>>  =C2=A0=C2=A0 xfs_io -f -c "pwrite -S 0xee 0 64K" $mnt/file1
>>>>  =C2=A0=C2=A0 sync
>>>>  =C2=A0=C2=A0 umount $mnt
>>>>
>>>>  =C2=A0=C2=A0 # Currupt data stripe 1 of full stripe of above 64K wri=
te
>>>>  =C2=A0=C2=A0 xfs_io -f -c "pwrite -S 0xff 119865344 64K" $dev1
>>>>
>>>>  =C2=A0=C2=A0 mount $dev1 $mnt
>>>>
>>>>  =C2=A0=C2=A0 # Do a new write into data stripe 2,
>>>>  =C2=A0=C2=A0 # We will trigger a RMW, which will use on-disk (corrup=
ted) data to
>>>>  =C2=A0=C2=A0 # generate new P/Q.
>>>>  =C2=A0=C2=A0 xfs_io -f -c "pwrite -S 0xee 0 64K" -c sync $mnt/file2
>>>>
>>>>  =C2=A0=C2=A0 # Now we can no longer read file1, as its data is corru=
pted, and
>>>>  =C2=A0=C2=A0 # above write generated new P/Q using corrupted data st=
ripe 1,
>>>>  =C2=A0=C2=A0 # preventing us to recover the data stripe 1.
>>>>  =C2=A0=C2=A0 cat $mnt/file1 > /dev/null
>>>>  =C2=A0=C2=A0 umount $mnt
>>>>
>>>> Above script is the best way to demonstrate the "destructive RMW".
>>>> Although this is not btrfs specific (other RAID56 is also affected),
>>>> it's definitely a real problem.
>>>>
>>>> There are several different directions to solve it:
>>>>
>>>> - A way to add CSUM for P/Q stripes
>>>>  =C2=A0=C2=A0 In theory this should be the easiest way implementation=
 wise.
>>>>  =C2=A0=C2=A0 We can easily know if a P/Q stripe is correct, then bef=
ore doing
>>>>  =C2=A0=C2=A0 RMW, we verify the result of P/Q.
>>>>  =C2=A0=C2=A0 If the result doesn't match, we know some data stripe(s=
) are
>>>>  =C2=A0=C2=A0 corrupted, then rebuild the data first before write.
>>>>
>>>>  =C2=A0=C2=A0 Unfortunately, this needs a on-disk format.
>>>>
>>>> - Full stripe verification before writes
>>>>  =C2=A0=C2=A0 This means, before we submit sub-stripe writes, we use =
some scrub like
>>>>  =C2=A0=C2=A0 method to verify all data stripes first.
>>>>  =C2=A0=C2=A0 Then we can do recovery if needed, then do writes.
>>>>
>>>>  =C2=A0=C2=A0 Unfortunately, scrub-like checks has quite some limitat=
ions.
>>>>  =C2=A0=C2=A0 Regular scrub only works on RO block groups, thus exten=
t tree and csum
>>>>  =C2=A0=C2=A0 tree are consistent.
>>>>  =C2=A0=C2=A0 But for RAID56 writes, we have no such luxury, I'm not =
100% sure if
>>>>  =C2=A0=C2=A0 this can even pass stress tests.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> I think I may use qemu and gdb to get basic understanding about this=
 feature.
>>>>>
>>>>> Thanks,
>>>>> Flint
>>>>>
>>>>> On 8/15/22 04:54, Qu Wenruo wrote:
>>>>>> scrub level checks at RAID56 substripe write time.
