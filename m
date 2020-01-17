Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 451E3140C58
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgAQOW6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:22:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:58265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgAQOW6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579270973;
        bh=yq7Y5tuqScTVzeLOUPgocmk2nopl32ioG45PWlLbAbA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=GcCfUMYgCetVx/8WH3wxNrY4SLPfBnZpHIonN7vkaS6hHjP/i9rmCzmGcHVzOJqlH
         A+CjMFCgcGV6yfCjrrjmFn0MEpDV05ZaY826zk++Kxp7DZWUarNvaAmThQ9N6WPk9L
         NKYquuPIfmPFJopo9dsvE2XRgdjZBvgtoM7nflkk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N63Vi-1jguV107aa-016QxB; Fri, 17
 Jan 2020 15:22:53 +0100
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
 <20200116142928.GX3929@twin.jikos.cz>
 <40ff2d8d-eb3b-1c90-ea19-618e5c058bcc@gmx.com>
 <a8e81e58-8d9d-789c-de33-c213f6a894e6@gmx.com>
 <20200117141037.GG3929@twin.jikos.cz>
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
Message-ID: <85585720-77de-b999-8d17-a17e86e1c181@gmx.com>
Date:   Fri, 17 Jan 2020 22:22:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117141037.GG3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="poYttRGl01PBgXxV8VA1MCLtOg9tkLTb7"
X-Provags-ID: V03:K1:6orPc7a2JV9ktp//rfjp9qoScFenca0mdB6LVtZ7FTi/GgXtnHK
 9/tLXRUKAItVeHgtKTRtb7vL6BNryKUW+OOLqnOs3Btw+8SxwGAtrA44hkFZ3tw7ei9x0zk
 owuUWuL539dXs0rDtwrWIHFHRmkIHhkdSN4EeKlhIqhgqR2VDexgDXmYVBcT/9Wqp7ZWgHq
 Uqh4iHXHadIlcoJzRexEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rEC7UjPMleg=:dfzKDie+neMj1qDUMaqtOU
 9erVoa4c7hyvXzVk7Kro5PYWtwlVqpFOnxdpeEp9i997iU2riuyDDt9u9gGrDCAffulgpcZjN
 WkdT1QheW91wVDFQNNWpZ8M1tCJzdtrjnkcKKG4Dg0+Z6aGH2h4SDQG2zeHHNkE/Hkv69liYn
 d/PCk5KQ1pA4DKGNg/KbDk5pppxmhTC+T7Whx7GTBLSNN/NB4dvc8u8Xuh3x/35qmXICGhySH
 2UzJY2FjPup33cuSksNR8aIg1auCVt0CVFKiWmXo8h8cv9ANBm8PWpMhU4yDEJ/FFGshuxBXV
 TFdw1YVrTiYtAXE26vSPelC4+N1S5xc/Z6kAdV4coW3lgGXfiqglXh2i7UUnq6R+8IjDKMiXn
 /4SPddg2bUXq2ZbEBVSQTYvhBLjrjt6SRQrqYSAFtEsR1UlZVADqKcE5KxCqsH4Au/LTghcvl
 cH7Ef/H+KEejjrHsvrEnlcdu5pBHKaXKHy/0ykE/TFNP/q5usonoRFvCbuqBttNFSwYqElQaD
 twhfgy8AEmmWrOtmQP91hKum0SbSXLs6a9IFy0PTM3A8eZiL43wYqQ7nRjhXOMWZUKlwUBRAN
 6om9yA+8d3JwuWK5J6IVhjNSVM2/nRvRZEqM/vLm+UfDEM8VEYIlmS73W7H/YRK0Qut+mQbqS
 Lui2Q+b6+r6xlmM14yFS8wOaW4SXeh5SRacUgIFqeW57/uuwLWQjcyfhMCF70CYYAUix/CIqw
 FUfoEbV7zTfk++smrwWPKlCeSw//01mHxz0of65pAjpaouLgaavauBGJOUQ6KO9qPNF6oBdhu
 nF9+hErw3dJFAl44H+G5dZaOAxeHr3QwAYjJ51IwrlpGZIkW/p3wOgAb7oW4QfN154mpZiMuv
 i++yXTeTduH3QA+bF9V0buvDgmOAYZZTdWhR0d5vYHsWSkoc58IIdhdXH1Ww5qoB0eMrLCLEk
 Dee6wHjwJuwSsafToMU7gP6V+8dutUyT8khKSE08Pc5m0osy5KMzEvzIK4ud9yxmR2l+r/5T9
 V7KEbgVj12ynagfaj21H7bijfumWkJWHKoMu62e//blFm86qUFvvonN8r4akobpXhnZvsK6EC
 DJAxsTWzvWm+EgnsLJ0AnxveDwxvuGKPjx/OZzv/99CeiQ71uemPtYj5lE0y9Tp1ofsBSVYlj
 JyQcL9y7me8HBVJg8WY8RiHWospLH5GwXKq+QewKDooQ/DrOL7d5HBKS3A/+C/DtiIeOGB2TH
 ucTM+BWJrxbeCUejJ4fe4c0rps72G/Z4KmtSLSefQIqBgh/ZisBqLf2W4Z4o=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--poYttRGl01PBgXxV8VA1MCLtOg9tkLTb7
Content-Type: multipart/mixed; boundary="vEtdfjUpaxkNWgKM57cINAhOg24lB2PJO"

--vEtdfjUpaxkNWgKM57cINAhOg24lB2PJO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/17 =E4=B8=8B=E5=8D=8810:10, David Sterba wrote:
> On Fri, Jan 17, 2020 at 09:32:49AM +0800, Qu Wenruo wrote:
>> On 2020/1/17 =E4=B8=8A=E5=8D=888:54, Qu Wenruo wrote:
>>> On 2020/1/16 =E4=B8=8B=E5=8D=8810:29, David Sterba wrote:
>>>> On Wed, Jan 15, 2020 at 11:41:28AM +0800, Qu Wenruo wrote:
>>>>> [BUG]
>>>>> When there are a lot of metadata space reserved, e.g. after balanci=
ng a
>>>>> data block with many extents, vanilla df would report 0 available s=
pace.
>>>>>
>>>>> [CAUSE]
>>>>> btrfs_statfs() would report 0 available space if its metadata space=
 is
>>>>> exhausted.
>>>>> And the calculation is based on currently reserved space vs on-disk=

>>>>> available space, with a small headroom as buffer.
>>>>> When there is not enough headroom, btrfs_statfs() will report 0
>>>>> available space.
>>>>>
>>>>> The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
>>>>> reservations if we have pending tickets"), we allow btrfs to over c=
ommit
>>>>> metadata space, as long as we have enough space to allocate new met=
adata
>>>>> chunks.
>>>>>
>>>>> This makes old calculation unreliable and report false 0 available =
space.
>>>>>
>>>>> [FIX]
>>>>> Don't do such naive check anymore for btrfs_statfs().
>>>>> Also remove the comment about "0 available space when metadata is
>>>>> exhausted".
>>>>
>>>> This is intentional and was added to prevent a situation where 'df'
>>>> reports available space but exhausted metadata don't allow to create=
 new
>>>> inode.
>>>
>>> But this behavior itself is not accurate.
>>>
>>> We have global reservation, which is normally always larger than the
>>> immediate number 4M.
>>>
>>> So that check will never really be triggered.
>>>
>>> Thus invalidating most of your argument.
>>>>
>>>> If it gets removed you are trading one bug for another. With the cha=
nged
>>>> logic in the referenced commit, the metadata exhaustion is more like=
ly
>>>> but it's also temporary.
>>
>> Furthermore, the point of the patch is, current check doesn't play wel=
l
>> with metadata over-commit.
>=20
> The recent overcommit updates broke statfs in a new way and left us
> almost nothing to make it better.

It's not impossible to solve in fact.

Exporting can_overcommit() can do pretty well in this particular case.

>=20
>> If it's before v5.4, I won't touch the check considering it will never=

>> hit anyway.
>>
>> But now for v5.4, either:
>> - We over-commit metadata
>>   Meaning we have unallocated space, nothing to worry
>=20
> Can we estimate how much unallocated data are there? I don't know how,
> and "nothing to worry" always worries me.

Data never over-commit. We always ensure there are enough data chunk
allocated before we allocate data extents.

>=20
>> - No more space for over-commit
>>   But in that case, we still have global rsv to update essential trees=
=2E
>>   Please note that, btrfs should never fall into a status where no fil=
es
>>   can be deleted.
>=20
> Of course, the global reserve is there for last resort actions and will=

> be used for deletion and updating essential trees. What statfs says is
> how much data is there left for the user. New files, writing more data
> etc.
>=20
>> Consider all these, we're no longer able to really hit that case.
>>
>> So that's why I'm purposing deleting that. I see no reason why that
>> magic number 4M would still work nowadays.
>=20
> So, the corner case that resulted in the guesswork needs to be
> reevaluated then, the space reservations and related updates clearly
> affect that. That's out of 5.5-rc timeframe though.

Although we can still solve the problem only using facility in v5.5, I'm
still not happy enough with the idea of "one exhausted resource would
result a different resource exhausted"

I still believe in that we should report different things independently.
(Which obviously makes our lives easier in statfs case).

That's also why we require reporters to include 'btrfs fi df' result
other than vanilla 'df', because we have different internals.

Or, can we reuse the f_files/f_free facility to report metadata space,
and forgot all these mess?

Thanks,
Qu


--vEtdfjUpaxkNWgKM57cINAhOg24lB2PJO--

--poYttRGl01PBgXxV8VA1MCLtOg9tkLTb7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4hwzYACgkQwj2R86El
/qj5MAgAjZMkH5qsGWN5vM7ywNqPUmIx500W5XCcd2foEYgBUzomd6a9+3J6bCQa
BjW2nzUwTGY451bD01bMqt4MeETA+avrkaxohNnVBb4CWlysGwvzb/BS/rB6Aeto
doGXHE22AgBeTLUQzi6DVDEx8d7AZLvppFleUsxUhvZMcMyv32tlkz6MaFlKD4SA
J6bOQ4oPxtbAlALy/PJyFvhUYlJ+j1gnINhbi5mtrwT+z7mGqdqZ34yhZPNLxk7X
b2w0mXt+2X33ZyiVLCyItKtJ+M7HSDnwouR7MNh1ZLtt5I/yT7qQsV7cge3LJEu6
v1JNXdJYgtK7VLcCheKNlg0gbh3lbg==
=S245
-----END PGP SIGNATURE-----

--poYttRGl01PBgXxV8VA1MCLtOg9tkLTb7--
