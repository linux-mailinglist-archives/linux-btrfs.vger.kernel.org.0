Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD6CDFDB8
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 08:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfJVGam (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 02:30:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:36593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfJVGam (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 02:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571725834;
        bh=WN0yQkCGqnAxYqvrtstJ8ylHE2pDdtoDRxO/uK8sVB0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aw0fihPFLBtwJm2wr0ZvnWdcS+c95JQXLENF2P+yuSa7GbBY7OxD2aYaVRbRYP4dA
         Ue2Xi31V+rVHWx8EPiKSxFCh65BV+9uD8OaTYtOTXnrt5f4G34dn3YwwrXVGE0S3y/
         Ji9yJMNHcPMEmx3IFQHJ3RDf7pjWJGdT6GDLnMFk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvvJ-1hos7H3IQX-00hPKG; Tue, 22
 Oct 2019 08:30:34 +0200
Subject: Re: [PATCH v2 0/7] btrfs-progs: Support for BG_TREE feature
To:     dsterba@suse.cz, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191008044936.157873-1-wqu@suse.com>
 <20191014151723.GP2751@twin.jikos.cz>
 <1d23e48d-8908-5e1c-0c56-7b6ccaef5d27@gmx.com>
 <20191016111605.GB2751@twin.jikos.cz>
 <7c625485-1e2b-77f5-26ac-9386175e2621@suse.com>
 <20191018172745.GD3001@twin.jikos.cz>
 <03ba36bd-fa92-fdea-6069-da60fe4df159@gmx.com>
 <20191021154404.GP3001@twin.jikos.cz>
 <07b33628-2cec-7bd3-26a1-e3be2367774a@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7435bf0f-ffbc-6723-4383-d780522d5af8@gmx.com>
Date:   Tue, 22 Oct 2019 14:30:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <07b33628-2cec-7bd3-26a1-e3be2367774a@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WS9mHMbI0FpMapqDfgv4RIki022ccCWjT"
X-Provags-ID: V03:K1:BFICXhTXBZ2tSZnxFrK8Dj/jiwbsIN+zdqV6kuJflwMyEsJp2fv
 i/qVhsjPImCG6+01T9SbIbIIRNZ5v9qB2atBTCSeFcpiWt7APQbVN4R1EuowG7UDeWY+tvu
 4LFAv0OHFxRAtKFimvJTIcMvrbBqGy78CKYY7UT7EUQ7xlPVs3NZmHpt8aUw2oUh3OekrnG
 Gsh4us+yB9JpBWDQkC8ow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PG9gLpgIyts=:uMdXLODbxi6sWDypOvhusq
 pYwvr1RAbfdDC/6IUUig7qosJYlS2ljI0ZbAB0WNDuzyE2A6uuJxWYRmwjp5yMcDR3lUA3Ep+
 dWR09NrxFayyXT8QmsziYwzkzbL2zV75BQdFPFLR9HM0i6lgT1fGN7Hns0G2RSZGLVAC5aoec
 mAzGGgvWtFUkrgPRBNpRQZXQTEnK2GFxY3infoMeDEw2T6OXOojinZ1k3N/Y2efin5fyu0Tgj
 /9x7+m9FnHk2ooOo4nSDOVBEiLCJIAO8GHs81cuja5FpydNOIkuQA2H/XOrHLj33iijcYoO6l
 o5LKNrr4teSp0rPFddYMDCxrrguu/siNpXhDA6ZGin8l6soQ8njNlpu9nZol0EX1rdKjB/xxh
 v4sbQjYsp21jGTBDCNiGmQY097+X9MBsP39x1tVlsJvA0Ym+FMFoFiJQtF5rBR5jdyu7i04W1
 o0WgXTpCYDq97HdfHbT6JalQSoBQMryZtB19cy+LyVSHTx1Wcup/Y7Jhr/tQPxkxOF20rC11U
 XEbeEcXO5o/PN/elygvW1TjGqqXR1QWCo1HYWj6jUFyoPi9igqsULv3mo96HSZMaowUosQt5x
 jVdAzGxbi6iXpxdTdpZb59pPHWG6iKMPzZ6wEtQ4BCEZIL4z+rhaVXOfWIp80HdqU+lPx1+41
 sfG2nTGDqwC6Dv/wV+P1z/M3+Gacab5GUu3tKm0rV+FL7ZPbHiv7vUqJ0aToLDEOyQjf5DY2V
 k7/jb9YccQVG0uoAHdeECv9WE+Iug6THR7SAI6Q7C/MLK1RN/YSoYrSAfXZ7qIdN9DbxEy0iQ
 leiHhA0rFwDuwZm7QhrHMYsTzekQMeruH/9hDuP/HIbt9dC2zwlW6A/q2JFT3Ve1jHC3T9gkI
 m+ALaVZ2Jq5aRbuuFnpZ0R+ntpDy8PHiqTlpUQO5ilhFgY2VBLb0ycwG8q9dwjFjtBnwv2RAt
 F9ahdiLlkjLfzh1RpVL4KlFlQgtP1+qaETP1ChkDnj6rGFn5KNGii5Cir37rZUgeO8Q54fi52
 U36dz++S/jVWt+cGEg72lcExbWBk34164f8/cM4s5Gpe/uOB7sjXgNUsLmW6EMPnEVcvwpL/D
 z6r5gIsPEz9Dn8n1qZcHQQAqyi63EslpMSqdSmlIyUNnrwXrzCkNSO/+MCYYuhrM1T1uJlYth
 x6Tc4bi6YmMpb10vLDRT390W+MN/g/kDt7Mzyh44O1DTRZi6qvpc9COC8ruuEjjb4bxEje+1a
 7vz9nooLZZ13SnqaFtvYFpLYijwDpyy+xlISRO5XQhvCRJOmlrtBLP5u/tsg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WS9mHMbI0FpMapqDfgv4RIki022ccCWjT
Content-Type: multipart/mixed; boundary="T0ICh1p8Aeowm33kngfRhNz9PwBv5bJhh"

--T0ICh1p8Aeowm33kngfRhNz9PwBv5bJhh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

BTW, there is one important compatibility problem related to all the BGI
related features.

Although I'm putting the BG_TREE feature as incompatible feature, but in
theory, it should be RO compatible.

As except extent/bg tree, we *should* read the fs without any problem.

But the problem is, current btrfs mount (including btrfs-check) still
need to go through the block group item search, even for permanent RO mou=
nt.

This get my rescue mount option patchset to be involved.
If we have such skip_bg feature earlier, we can completely afford to
make all these potential features as RO compatible.


Now my question is,  should we put this feature still as incompatible
feature?

Thanks,
Qu


On 2019/10/22 =E4=B8=8A=E5=8D=888:49, Qu Wenruo wrote:
>=20
>=20
> On 2019/10/21 =E4=B8=8B=E5=8D=8811:44, David Sterba wrote:
>> On Sat, Oct 19, 2019 at 08:04:51AM +0800, Qu Wenruo wrote:
>>> That's wonderful.
>>> Although I guess my patchset should provide the hint of where to modi=
fy
>>> the code, since there are only a limited number of places we modify
>>> block group item.
>>
>> I indeed started at your patchset and grepped fro BG_TREE, adding
>> another branch.
>>
>>>> We agree on the point that the block group items must be packed. The=
 key
>>>> approach should move the new BGI to the beginning, ie. key type is
>>>> smaller than anything that appears in the extent tree. I chose 100 f=
or
>>>> the prototype, it could change.
>>>>
>>>> To keep changes to minimum, the new BGI uses the same block group it=
em,
>>>> so the only difference then becomes how we search for the items.
>>>
>>> If we're introducing new block group item, I hope to do a minor chang=
e.
>>>
>>> Remove the chunk_objectid member, or even flags. to make it more
>>> compact. So that you can make the BGI subtree even smaller.
>>
>> Yeah that can be done.
>>
>>> But I guess since you don't want to modify the BGI structure, and kee=
p
>>> the code modification minimal, it may not be a good idea right now.
>>
>> As long as the changes are bearable, eg. a minor refactoring of block
>> group access (the cache.key serving a as offset and length) is fine. A=
nd
>> if we can make the b-tree item more then let's do it.
>>
>>>> Packing of the items is done by swapping the key objectid and offset=
=2E
>>>>
>>>> Normal BGI has bg.start =3D=3D key.objectid and bg.length =3D=3D key=
=2Eoffset. As
>>>> the objectid is the thing that scatters the items all over the tree.=

>>>>
>>>> So the new BGI has bg.length =3D=3D key.objectid and bg.start =3D=3D=
 key.offset.
>>>> As most of block groups are of same size, or from a small set, they'=
re
>>>> packed.
>>>
>>> That doesn't look optimized enough.
>>>
>>> bg.length can be at 1G, that means if extents starts below 1G can sti=
ll
>>> be before BGIs.
>>
>> This shold not be a big problem, the items are still grouped togethers=
=2E
>> Mkfs does 8M, we can have 256M or 1G. On average there could be severa=
l
>> packed groups, which I think is fine and the estimated overhead would =
be
>> a few more seeks.
>>
>>> I believe we should have a fixed objectid for this new BGIs, so that
>>> they are ensured to be at the beginning of extent tree.
>>
>> That was my idea too, but that also requires to add one more member to=

>> the item to track the length. Currently the key is saves the bytes. Wi=
th
>> the proposed changes to drop chunk_objectid, the overall size of BGI
>> would not increase so this still sounds ok. And all the problems with
>> searching would go away.
>>
>>>> The nice thing is that a lot of code can be shared between BGI and n=
ew
>>>> BGI, just needs some care with searches, inserts and search key
>>>> advances.
>>>
>>> Exactly, but since we're introducing a new key type, I prefer to perf=
ect
>>> it. Not only change the key, but also the block group item structure =
to
>>> make it more compact.
>>>
>>> Although from the design aspect, it looks like BG tree along with new=

>>> BGI would be the best design.
>>>
>>> New BG key goes (bg start, NEW BGI TYPE, used) no data. It would prov=
ide
>>> the most compact on-disk format.
>>
>> That's very compact. Given the 'bg start' we can't use the same for th=
e
>> extent tree item.
>>
>>>> This would be easy with the bg_tree, because we'd know that all item=
s in
>>>> the tree are just the block group items. Some sort of enumeration co=
uld
>>>> work for bg_key too, but I don't have something solid.
>>>
>>> Why not fixed objectid for BGI and just ignore the bg.len part?
>>
>> I wanted to avoid storing a useless number, it costs 8 bytes per item,=

>> and the simple swap of objectid/offset was first idea how to avoid it.=

>>
>>> We have chunk<->BGI verification code, no bg.len is not a problem at
>>> all, we can still make sure chunk<->bg is 1:1 mapped and still verify=

>>> the bg.used.
>>
>> This is all great, sure, and makes the extensions easy. Let's try to
>> work out best for each approach we have so far. Having a separate tree=

>> for block groups may open some future options.
>=20
> Great, I'll explore the most compact key only method with BG_TREE.
>=20
> And maybe also try the fixed key objectid solution, just dropping the
> bg.length, while keep the current BGI structure.
>=20
> Thanks,
> Qu
>=20


--T0ICh1p8Aeowm33kngfRhNz9PwBv5bJhh--

--WS9mHMbI0FpMapqDfgv4RIki022ccCWjT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2uof4XHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qiDcwgAqATFIgjL1JKc1bhVCpRzmDvp
KObSrFAtUeQXh5ue02l+eEdi7atfe9iA24qsECoa9WAdjMmXhFmfXPWGj/v/V2t2
RB7S1JN6Pe1tfvLnUdG7OEGclNpWSp/zxi8u4RuUFAl94YKRzJVvuW+F1g28+fhN
bdCD6RyB3387LBTP5aDt4ErEq2aioWar/1+Pyw9sqnpRbQJNFcou3AY3MpWVLj9d
1kfjhvtHgLoAVrRLOJcWggNaZeX4/7Cw0KmJuVSdR93DtGNM6HsvaOz97sfBxIyL
2MXZAuXdfX+nTMSSdlhOBOdju7NNbjuXqoAmmUDyjJxIzoSZ1sXr0phtkjjkjg==
=ViKL
-----END PGP SIGNATURE-----

--WS9mHMbI0FpMapqDfgv4RIki022ccCWjT--
