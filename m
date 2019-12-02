Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7720510E51F
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 05:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLBEos (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Dec 2019 23:44:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:51671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfLBEos (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Dec 2019 23:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575261719;
        bh=CHZQ7vqzlTPLjsjA0gjgb3u8uPhwtKoDK44ayqOw/fM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EdDD3gI/P72IBG3kXbmE791c+cK0Y5bAyg9/1SCMw0wAbckR+/s6TIue5boD9yqRv
         GYMQusnT8c9lvKB9rHJlqr1hO8RLWe8MyNI2EO2ztGVS9NyKJ1r4HdSOD64DZIQBHv
         lU1UkmdPuxLCXGkrLWU6FhfQY9WQzlQlGu53bNGQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9nxt-1ifBtj2flV-005rnX; Mon, 02
 Dec 2019 05:41:59 +0100
Subject: Re: [PATCH 0/3] btrfs: More intelligent degraded chunk allocator
To:     Zygo Blaxell <zblaxell@furryterror.org>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
 <20191118201834.GN3001@twin.jikos.cz>
 <f6dfede7-c65c-2321-ab8f-ba16a6a3c71f@gmx.com>
 <20191202032259.GN22121@hungrycats.org>
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
Message-ID: <78acb42f-071f-8d78-c335-71c2af5da841@gmx.com>
Date:   Mon, 2 Dec 2019 12:41:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202032259.GN22121@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KFQU0JV7cghg7OzjfcaayGGJ40yV4gHTS"
X-Provags-ID: V03:K1:/Ui+/Cw1JdHTD1ejXyH1wAf8FCUpbLaa1qM/SWcWDJHdNOsMr9e
 avD1Xl3OE7GCecZoZspDdYLp/w1mYgFGp0O6ojMV7g3JYlGrWAFiJqt1zcomLJVArBUTwLn
 J0pltfeX2jcPysrPV0EYSEd5XjoDXKEcVVhtlmZrL6eDyKOU0bqP8zZE/JSJTetxOOj/JCK
 ft/JXB/8BaUArGNFKp/qA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c3htcRt01Kk=:cldyOwN8H4oEZCqqwENYeT
 C+6vEHGalddqcofYonVkEwr1X44pcSo94mf+KtfKpBcnjyu2sk1XXRaoJ8psX8vCwAdUGkLo4
 8VuXOg7HkWgBruH3ZoUrhoa8xzWESG/9OVa3dfFrSV2XMHU7w58kfqXeyW3d/2/5j9YT6Mkhk
 7+lN6lMAuAIAjQrTsS/tTv4e6owhBPJoCgyYzJYUZjZdIkoFpVl759HRuRGA0z21RaqBvmjiK
 ZLfQI3lUaa4ToeKFrB/i1ou2Rno9opMPnBG+n+CHelL4uUpcIqyev3ZRch92hktPap8YU4M2q
 8L6nkTDcFQ9ai+NswBaV2Wah9vjL+P+K60OQP9uQd9feh+VgQeq+bPTHnZpITUysFA4TdS++z
 Gp8hX4jZuTbgoOGjKLLjmJNkHgWMWYowKvq4UKgUDL4Vk9f72p0uhIQa9LxIVnJughyonJF3j
 FuzD6IWsUtFv4mdcEqeYWb/ZtuJzhxy8rkn1iMpP2IocB0aD37KgEEsXspLMKOT7v7Tr9qNSr
 z498YlMX2lJWaLa7DL1MrhLgFvJ/2kHy5sp4CBtGEPV5kZqeQJytsNBQZr8aVuHDzJ2rTiPAG
 riLF+xQH8L6pkz75s7HP4z0fH7T0r43/U1/pPst5Tho2DU3M1B8iGHU/rp2eDr6uk7OhBJak7
 wxwfkmJu/g6ZWvtyz9O1YHvEoZ6mD9RfqCdHEE8sN7lRrnNzXPIwl25fpv5NAsaLfc1UwYgzh
 +kHe+wbmo9PMokccsXsmXIABauC+1FV4yXEt5YM7QFndeYk1YsKqVmvWJ8YoRHLwDRlfXL5mw
 xjuAQ2JYq3eI2nv7PF6PB69cg9JWYdOpYmxauww+BbW+WC5GD1JXo24ODT2t768zyncBjyc2J
 j8dluA561hjAp7EFg409g78mlVKrb0NvZXF+D5qim6mHiBR7uCUcJDrGlwSpw0ywIu9IVrIFK
 CVFkP7qME/ynti5yqJzbdWoItOWhUPGE0zMdipoIpxHdzmd/zaNfN3vHqZ96hdtWMz8XJA0BZ
 uqfJaHQB1xR8LrwSR6wCs65FVNrVzQ08w+M7UIX/BZlmwLEX4cpH2K7JQKXr5mMNT6ddiWwZ8
 LtDkFZi7Bouo+x27rGpKgcBjfuG67vGGXJZwULb69v9nZ80pomyEZxxULPXLTj8sUCJvEcuys
 SraZTUqX7yWbHfug2Bmc8VOXEeoGT21l98QFeYq8tlU0fRll3ZTP9D4T5dTkLHtdI8FLi6kB4
 aiCkG04IKCJi3nSrtrlrR7KGbp0v+4147WAfdUWKJxn3paXpNh5t+yY6NVvU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KFQU0JV7cghg7OzjfcaayGGJ40yV4gHTS
Content-Type: multipart/mixed; boundary="Dk92GGEfciifZSzxKWVJb2EnSymUxceGS"

--Dk92GGEfciifZSzxKWVJb2EnSymUxceGS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/2 =E4=B8=8A=E5=8D=8811:22, Zygo Blaxell wrote:
> On Tue, Nov 19, 2019 at 07:32:26AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/11/19 =E4=B8=8A=E5=8D=884:18, David Sterba wrote:
>>> On Thu, Nov 07, 2019 at 02:27:07PM +0800, Qu Wenruo wrote:
>>>> This patchset will make btrfs degraded mount more intelligent and
>>>> provide more consistent profile keeping function.
>>>>
>>>> One of the most problematic aspect of degraded mount is, btrfs may
>>>> create unwanted profiles.
>>>>
>>>>  # mkfs.btrfs -f /dev/test/scratch[12] -m raid1 -d raid1
>>>>  # wipefs -fa /dev/test/scratch2
>>>>  # mount -o degraded /dev/test/scratch1 /mnt/btrfs
>>>>  # fallocate -l 1G /mnt/btrfs/foobar
>>>>  # btrfs ins dump-tree -t chunk /dev/test/scratch1
>>>>         item 7 key (FIRST_CHUNK_TREE CHUNK_ITEM 1674575872) itemoff =
15511 itemsize 80
>>>>                 length 536870912 owner 2 stripe_len 65536 type DATA
>>>>  New data chunk will fallback to SINGLE or DUP.
>>>>
>>>>
>>>> The cause is pretty simple, when mounted degraded, missing devices c=
an't
>>>> be used for chunk allocation.
>>>> Thus btrfs has to fall back to SINGLE profile.
>>>>
>>>> This patchset will make btrfs to consider missing devices as last re=
sort if
>>>> current rw devices can't fulfil the profile request.
>>>>
>>>> This should provide a good balance between considering all missing
>>>> device as RW and completely ruling out missing devices (current main=
line
>>>> behavior).
>>>
>>> Thanks. This is going to change the behaviour with a missing device, =
so
>>> the question is if we should make this configurable first and then
>>> switch the default.
>>
>> Configurable then switch makes sense for most cases, but for this
>> degraded chunk case, IIRC the new behavior is superior in all cases.
>>
>> For 2 devices RAID1 with one missing device (the main concern), old
>> behavior will create SINGLE/DUP chunk, which has no tolerance for extr=
a
>> missing devices.
>>
>> The new behavior will create degraded RAID1, which still lacks toleran=
ce
>> for extra missing devices.
>>
>> The difference is, for degraded chunk, if we have the device back, and=

>> do proper scrub, then we're completely back to proper RAID1.
>> No need to do extra balance/convert, only scrub is needed.
>=20
> I think you meant to say "replace" instead of "scrub" above.

"scrub" for missing-then-back case.

As at the time of write, I didn't even take the replace case into
consideration...

>=20
>> So the new behavior is kinda of a super set of old behavior, using the=

>> new behavior by default should not cause extra concern.
>=20
> It sounds OK to me, provided that the missing device is going away
> permanently, and a new device replaces it.
>=20
> If the missing device comes back, we end up relying on scrub and 32-bit=

> CRCs to figure out which disk has correct data, and it will be wrong
> 1/2^32 of the time.  For nodatasum files there are no CRCs so the data
> will be wrong much more often.  This patch doesn't change that, but
> maybe another patch should.

Yep, the patchset won't change it.

But this also remind me, so far we are all talking about "degraded"
mount option.
Under most case, user is only using "degraded" when they completely
understands that device is missing, not using that option as a daily opti=
on.

So that shouldn't be a big problem so far.

Thanks,
Qu

>=20
>>> How does this work with scrub? Eg. if there are 2 devices in RAID1, o=
ne
>>> goes missing and then scrub is started. It makes no sense to try to
>>> repair the missing blocks, but given the logic in the patches all the=

>>> data will be rewritten, right?
>>
>> Scrub is unchanged at all.
>>
>> Missing device will not go through scrub at all, as scrub is per-devic=
e
>> based, missing device will be ruled out at very beginning of scrub.
>>
>> Thanks,
>> Qu
>>>
>>
>=20
>=20
>=20


--Dk92GGEfciifZSzxKWVJb2EnSymUxceGS--

--KFQU0JV7cghg7OzjfcaayGGJ40yV4gHTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3klhEACgkQwj2R86El
/qhDWQf/Q63Od/j31vXs9eLONQImeaydn5uqkblcmAnrYg4SF7pEQRuKOIq7ErtN
kY7wAfv9iOCtubvS4y4Wantaw+RvMYyvFtxvx0UvJmZvast2suZ2ejQWZjwhyMGu
2rjvDML+5B6MoGNJ8jD9ALU9EXQ3yLqgzuEs+ZFMvK5v2EbrpwBvx80dmVaMz4Aa
PrRDXShj0YqAnTWEW/LL5Y6sUAgRg884+llTd/GcNxk9/utoY1DEDzBtWZFqTCGp
dniyJsyKgxi5/AWzmGL9G2Ace0+gFeI1MR1ntD6fDOZrSc7gUqdUckWkCvKQ/fRR
RBemKrNV6cyAtkxMG0DNpqoyx5qr5w==
=OFn8
-----END PGP SIGNATURE-----

--KFQU0JV7cghg7OzjfcaayGGJ40yV4gHTS--
