Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5A12316AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 02:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgG2APv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 20:15:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:55129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbgG2APu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 20:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595981748;
        bh=lb6I8rxMHu19yTAcdtJ8TeX3ZF/u7otu3ONzSMb68Is=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TEZlp8TIRppDwY+7xhhp4EEBThYCAPk6EBYCgQtOW3eAMBGmhSMoPOUYg7LgTjhj7
         m1vpOsJcDj4qXfJ3qqQ/wlmMNcbtLO6tlPCR+z5dDFkBpKhwLLeoWN8mprUPbwNXF7
         5aHa4PF5NIKwn67nj5FB8v3MzUH1VOkFkm/m6FrU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLiCu-1kIFAR1JSq-00Hct0; Wed, 29
 Jul 2020 02:15:47 +0200
Subject: Re: Debugging abysmal write performance with 100% cpu
 kworker/u16:X+flush-btrfs-2
To:     Hans van Kranenburg <hans@knorrie.org>, linux-btrfs@vger.kernel.org
References: <2523ce77-31a3-ecec-f36d-8d74132eae02@knorrie.org>
 <f3cba5f0-8cc4-a521-3bba-2c02ff6c93a2@gmx.com>
 <ae50b6a5-0f1e-282e-61d0-4ff37372a3ca@knorrie.org>
 <b4d0c916-71d5-753a-1c10-cd28f1c3ebec@gmx.com>
 <5155a008-d534-18d3-5416-1c879031b45d@gmx.com>
 <bfba7719-d976-d7e3-2956-f0f200de623f@knorrie.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <66efcce0-b06c-a6b7-e99f-60be81cb0bd1@gmx.com>
Date:   Wed, 29 Jul 2020 08:15:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bfba7719-d976-d7e3-2956-f0f200de623f@knorrie.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="T0exnJsN7en5Wc55Nda9xEHJGV6ba7EJN"
X-Provags-ID: V03:K1:JMmc56KtPLW623jFKBq7inNIJFuXm3PmWbN4NZGTaSBWEw/zSql
 osNDyGoAsuKa79qCBBIkKx20RPA9R6pRiD00o8rO5QOL+9bLEMvbhYHAS/Jv8GW/QctYZ84
 HcItxeySEo9HuLoSdWtLUKGOYr5scLHFwgTbXL+qeZSO4kFhCJJ4sYNz/6FKDh3R7i3+Jr2
 qVqinzVgSbHc3ZoPXMvFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ALiCZkXj5TI=:nEdfl2YYPKGkBR1M221/xO
 m+E9KUqM84jO9oKIWYKJZ+uL1+pd00GHptu7c8bsWg4jjNAEXgNP2zuTnjJCvftW4EXK9Is/W
 upvINL620xsXd0UeDP08dGit8mDFEyqFeI6pG7XpjMeqUD5B1y/ogv/R/x+x9kxTzQgeufE/m
 onHy/eaHvuA8Yx/qoo1IJRGHaD5yolmXkoway//dTnXZs6VH8I6v4/nqpJV+UgbXJiKKdP9pi
 bBWRXd84cGL+pGlNz1LGVyIINNydSBoX351sJE1M1WROfGDLLBhMW7jMbW/HriGIIxBeutAGK
 jSVdN9BlXEPw71S2w4o+u+ns7w+SrmkCOxi3Mh6H/Kt80wgXVumWxeffFB36cAToJCn5kxJ91
 dznkm4ToNrm/Mw/gErHNbHG9CLGeWnOszD4g3aWTLddwgDuPBpngwW7HWgivm9MiLNdFOzMEw
 L/e0tZWOqY8X0CtaN/6ydt6wiupu4epFvMIdPzobHIdKMK62oajFnNcCG73V16THCxqETLF7p
 +lBOcZRiL0JQIw+Xd9DcXnXBT6EvL5d6TqZGXjno81InGVvH1RYBIfAtTVELHILJEilB9Wfq2
 DIC4kKHhR9R0unfgEc71KKY5Fm4wxACoavOnH7V/+sGCftHcjqzMQ/SRxM79SNG3zmJ5S+/Bv
 FtVMLERRV65YkmYHrcAswnhKWB98HMoyUd7dmuOzQAbB2clprVZR7gUQ6h9D06aqSKoman9hL
 mbwAVzjZubxk8eZ3jin0xRH3mGdC23M4kJLjCqiSH9QC69e4NoWqXXgC179cDtsqb0slTDbw4
 Iuy4YQfkWRJDuIJpguJT4WKfKCgoUjTez+fOEuTDABOkHbPk6BMp4B/xRihLGaMjxrEoXkt+3
 0Ys0wHtGPiutddeMRhj9PcfoGc2b+TIZbgn/d12UMhE+r+EfHJxvPiwS4R4BxBchJMXl2Cuda
 oJ6xY4gv7YLHFhcpMa9Ka74qL+PTKILlbhtkHbgaIG87kyby8Jh4I46ni2I56YdrrSoM09+9U
 PJiYTUcHkWcj2md4B3OdylWEv0K+XGDmZpa77z4TBPcXLaN3sDMi++ZJ2yYSEbko/OctQFN0K
 7gXrxcQEMfemaHjhWDuuKSzIgzb/d5ZSgzFnTvZuiAf98rrg5suXoAJ6UlNWea4Eutot2zhjB
 rEDE4uaezWVKHAhQBDlDQH1tGfthp4/g6bMLDKVfKxSLRdUdLIaf+JeVPKXtgKqZkHx9jDvko
 RPJz3cXfBYXQDyaIh+dqZ1uKjHucetEcq3WZp7A==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T0exnJsN7en5Wc55Nda9xEHJGV6ba7EJN
Content-Type: multipart/mixed; boundary="k57FNYtfbxHDx5WqrS5HRjDo21PYeqF6m"

--k57FNYtfbxHDx5WqrS5HRjDo21PYeqF6m
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/28 =E4=B8=8B=E5=8D=8810:52, Hans van Kranenburg wrote:
> On 7/28/20 3:52 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/7/28 =E4=B8=8A=E5=8D=888:51, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/7/28 =E4=B8=8A=E5=8D=881:17, Hans van Kranenburg wrote:
>>>> Hi!
>>>>
>>>> [...]
>>>>>
>>>>> Since it's almost a dead CPU burner loop, regular sleep based locku=
p
>>>>> detector won't help much.
>>>>
>>>> Here's a flame graph of 180 seconds, taken from the kernel thread pi=
d:
>>>>
>>>> https://syrinx.knorrie.org/~knorrie/btrfs/keep/2020-07-27-perf-kwork=
er-flush-btrfs.svg
>>>
>>> That's really awesome!
>>>
>>>>
>>>>> You can try trace events first to see which trace event get execute=
d the
>>>>> most frequently, then try to add probe points to pin down the real =
cause.
>>>>
>>>> From the default collection, I already got the following, a few days=

>>>> ago, by enabling find_free_extent and btrfs_cow_block:
>>>>
>>>> https://syrinx.knorrie.org/~knorrie/btrfs/keep/2020-07-25-find_free_=
extent.txt
>>
>> This output is in fact pretty confusing, and maybe give you a false vi=
ew
>> on the callers of find_free_extent().
>>
>> It always shows "EXTENT_TREE" as the owner, but that's due to a bad
>> decision on the trace event.
>>
>> I have submitted a patch addressing it, and added you to the CC.
>=20
> Oh right, thanks, that actually makes a lot of sense, lol.
>=20
> I was misled because at first sight I was thinking, "yeah, obviously,
> where else than in the extent tree are you going to do administration
> about allocated blocks.", and didn't realize yet it did make no sense.
>=20
>> Would you mind to re-capture the events with that patch?
>> So that we could have a clearer idea on which tree is having the most
>> amount of concurrency?
>=20
> Yes. I will do that and try to reproduce the symptoms with as few
> actions in parallel as possible.
>=20
> I've been away most of the day today, I will see how far I get later,
> otherwise continue tomorrow.
>=20
> What you *can* see in the current output already, however, is that the
> kworker/u16:3-13887 thing is doing all DATA work, while many different
> processes (rsync, btrfs receive) all do the find_free_extent work for
> METADATA. That's already an interesting difference.

That's common, don't forget that btrfs is doing COW to modify its metadat=
a.
After a data write reaches disk, btrfs will then modify metadata to
reflect that write, which will cause a metadata reserve.

The good news is, btrfs is not always doing metadata COW, if the needed
tree blocks has already been CoWed and not yet written to disk.

So in theory, the data reserve should be more frequently than metadata.

>=20
> So, one direction to look into is who is all trying to grab that spin
> lock, since if it's per 'space' (which sounds logical, since the worker=
s
> will never clash because a whole block group belongs to only 1 'space')=
,
> then I don't see why kworker/u16:18-11336 would spend 1/3 of it's time
> in a busy locking situation waiting, while it's the only process workin=
g
> on METADATA.
>=20
> But, I'll gather some more logs and pictures.
>=20
> Do you know (some RTFM pointer?) about a way to debug who's locking on
> the same thing? I didn't research that yet.

I had a bcc based script to do that analyze, but that's mostly for tree
blocks.
https://github.com/adam900710/btrfs-profiler/blob/master/tree_lock_wait.p=
y

Feel free to use that as a base to develop your own tool.


BTW, this data allocation race reminds me that, Josef and Nikolay
discussed this possible problem before, but not yet have a solid
solution to it.

So I guess what we can do now is just to collect enough data to proof
it's already a big problem.

Thanks,
Qu
>=20
> Hans
>=20
>> [...]


--k57FNYtfbxHDx5WqrS5HRjDo21PYeqF6m--

--T0exnJsN7en5Wc55Nda9xEHJGV6ba7EJN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8gv7AACgkQwj2R86El
/qjp0Qf9F7EQLJH4lglSMROO2zzidOaCAByr5l+ckN3a4tZTNcICAtRD2BVP36fl
DxAHSGDQquwotFJC5hkr7LwOLBNQWYk+cL7Z7w9ZWXLQLoDp8ldz9b/2/gbyp4lN
Ue1naNcplF8WZ74TuBVdWC2viBK3xBG3YVQKG/Lqd/6aFmrh8V5o8CeZBZM+s5EZ
HDgcYZuoYzSlN0V34lC4zdM1JJ38naMl/+xaoeh6VvT3OX22UT/lPdXGsbXr3Q/3
yoRdj/lebyAmERYVeWNKTuLEiWw9lReJUzllR8j6S5UaUcI2/6gO6AkhRIpjszoG
XVfTfL5Oa8p3lt0afjbPih3+M+ms4g==
=ang5
-----END PGP SIGNATURE-----

--T0exnJsN7en5Wc55Nda9xEHJGV6ba7EJN--
