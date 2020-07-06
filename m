Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE467215379
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgGFHsR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 03:48:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:37801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgGFHsR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 03:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594021692;
        bh=WaCUuji80dIKDjG2whbUYG92C7J7yLgCRj7Bb+Idzes=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=ccqYcgtj6Iu3LflsoDFpkQkfjU+NPgwL7uvIEfUFpoZ8bZr2ELIsJwUr2zHXAOezl
         0GxGIRMUZPsJycAfWr93TQbGxod1x2y4npagxzWXo9uncQPnqCpPGTlH5tUkSAaEJK
         pxh1e16k7n4NTGkqb1MbnWkIkmCpRVI9FWzXNY3c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJqN-1keLmK2O9r-00nOnl; Mon, 06
 Jul 2020 09:48:12 +0200
Subject: Re: Balance + Ctrl-C = forced readonly
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Hans van Kranenburg <hans@knorrie.org>, linux-btrfs@vger.kernel.org
References: <42c9515d-7913-e768-84b1-d5222a0ca17d@knorrie.org>
 <131421c2-1c2a-4b1b-8885-a8700992a77d@gmx.com>
 <93419615-8f34-efc4-f50e-eac1151f0f37@knorrie.org>
 <fc428d50-2853-1be7-4764-e643f59faca5@gmx.com>
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
Message-ID: <bc64c59d-2bec-e2b0-4d65-b12d848afc08@gmx.com>
Date:   Mon, 6 Jul 2020 15:48:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fc428d50-2853-1be7-4764-e643f59faca5@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WikCaq4F9l30PdtzRlXvFmZQ0wqd1kWbN"
X-Provags-ID: V03:K1:ut0biZ5/UM8k8wd758hSACRsFiVjy6KsX8pbeMdxPkM+OiCCJrz
 1ty6qZcUm3fAhb0YWs/WU3VBrj8pILVvIPDpJu1wZt2PU9NEjCL/mFBL8Vb8OYkwuYqN3Tu
 iVV8evwUOGxxzGV1+K1REVBASkck/CjOF85XJZVmOD9F4XmqOBem7v2mh1eK9CP7gYCQnm0
 IoSGD5sz46h3kljbhCbPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fuuCjkWgeeA=:CHYhI5tPIWIO5viqsRra8F
 DKz9vthPIK/Tdyi2nNakZGIa7/xvjqlZR8LjOLpBiUDhRK3oWrv+mdF2O4y/K2i7Nk9xRd47W
 d9vWB8HlJK1zGt39hHSdZt5pxlAv+f573w12Ivsa4mDp3Pt9Ys3MyjKKlko76l8CKH6nMYfNA
 xFx7dr7G3pO7ru07dmvH6ssw3+reNy/OfY9oivBl7dsNk7CHLHavIg/3JS2HT1QQ4zDNdRoJq
 tBscQN3UY/eJeGVqkupD720vslJqOJlJxLhlhtu1X22ghtDmUfvWxGPAtf8UH0L4V0uRGNPNK
 iZbPlhyvXRjZiQNCdALj8qB3kN/S2s0k5F/S/+WJcclqx5c8Sx9bulAERdY/W878J9sQ5WwNx
 J7H0m+P4eX8smzzSfhOpaZegp4oDGmhYWw5mY+x2fZKm6K3aJlB1GxEYxck0AUtb0js8quG8t
 ntOpYc/hFO/NApmIJvNR03bN96Ted9/ByLYVPah9is/AhPVURXXAHFY9dIRvttQGsyGpBU0Ot
 tnAiez0ksSB2CoQfFlqAe7NVFwI1YhgR4+2d1lg55yb30CzJYmKkjYmbnvgO8oQY4oQdFThbU
 KnZ6A9nlqV7kuJp5EF0G65c4roO8TX/UKkR90r1p16ZdOxHCns7gswVli/iqxPTr29Tkbv0X0
 +m6liLqQyvagDwpWemFLeOiXMMoG8o10UdISlDhwsexPVTsxiyxlvedvr/s1ni75U4ddyMJk6
 xOpDapygjN0yP+6nLmcWToBHiaXloTeOhcY3XBYfXPBr7lybTmZVtwgbI/jKLLyeTCmlGqMTL
 C09llnHWp+OLm8Enb15FPThb8pRHVwqt6HaIM7H5Mz/JolpELjEGMLjfUiTEBXwSLir6EZ8we
 qJ4tTHw5zfrB1K9fYSTGw6lThZ4pC69BmBKwWweQYT1XCX2QRmlXhTMIjF/Bwf811c3QApFp8
 ptjz1hkgSbVLrgzIAHFTlk0ObgCUtsaqN8Mw4UzJi7M6l5N1rpIfH8huaK6dcZeph4JcOSawY
 nCoLFJFenu71KjFDAaxSR6zuxgP2KWzhW4jmdd7Ktr8JvZQ7H/uOcdODFnXIdEClX0RNBMP06
 lytTtYYXNFk6qpu8AqKElzCnAbDVj6l4vaSnwlOLp7lqSQwq6FdvvoAo28x5nuiRbZwOtu8vJ
 vegLwQSgGxZlVr6O4bOinCuOlN5dBm5NIrbUuJkUYl2Qbmq/ogZoaIs6/wXwVaI7/zyIRApaF
 +A5tngy3V9UAU/q4oL/qIESBE/9eOiaZs7e3TCA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WikCaq4F9l30PdtzRlXvFmZQ0wqd1kWbN
Content-Type: multipart/mixed; boundary="ylR6DKvRWEkHmDtU6gKXGh6gHrSjVJ4H0"

--ylR6DKvRWEkHmDtU6gKXGh6gHrSjVJ4H0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/6 =E4=B8=8B=E5=8D=882:15, Qu Wenruo wrote:
>=20
>=20
> On 2020/7/5 =E4=B8=8B=E5=8D=8810:53, Hans van Kranenburg wrote:
>> On 7/5/20 3:13 PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/7/5 =E4=B8=8B=E5=8D=888:49, Hans van Kranenburg wrote:
>>>> Hi,
>>>>
>>>> This is Linux kernel 5.7.6 (the Debian package, 5.7.6-1).
>>>>
>>>> So, I wanted to try out this new quicker balance interrupt thing, an=
d
>>>> the result was that I could crash the fs at my very first try using =
it,
>>>> which was simply doing balance, and then pressing Ctrl-C.
>>>>
>>>> Recipe to reproduce: Start balance, wait a few seconds, then press
>>>> Ctrl-C. For me here, ~ 5 out of 10 times, it ends up exploding:
>>>>
>>>> -# btrfs balance start --full /btrfs/
>>>> ^C
>>>>
>>>> [41190.572977] BTRFS info (device xvdb): balance: start -d -m -s
>>>> [41190.573035] BTRFS info (device xvdb): relocating block group
>>>> 73001861120 flags metadata
>>>> [41205.409600] BTRFS info (device xvdb): found 12236 extents, stage:=

>>>> move data extents
>>>> [41205.509316] BTRFS info (device xvdb): relocating block group
>>>> 71928119296 flags data
>>>> [41205.695319] BTRFS info (device xvdb): found 3 extents, stage: mov=
e
>>>> data extents
>>>> [41205.723009] BTRFS info (device xvdb): found 3 extents, stage: upd=
ate
>>>> data pointers
>>>> [41205.750590] BTRFS info (device xvdb): relocating block group
>>>> 60922265600 flags metadata
>>>> [41208.183424] BTRFS: error (device xvdb) in btrfs_drop_snapshot:550=
5:
>>>> errno=3D-4 unknown
>>>
>>> -4 means -EINTR.
>>
>> From extent-tree.c:
>>
>>   5495         /*
>>   5496          * So if we need to stop dropping the snapshot for
>> whatever reason we
>>   5497          * need to make sure to add it back to the dead root li=
st
>> so that we
>>   5498          * keep trying to do the work later.  This also cleans =
up
>> roots if we
>>   5499          * don't have it in the radix (like when we recover aft=
er
>> a power fail
>>   5500          * or unmount) so we don't leak memory.
>>   5501          */
>>   5502         if (!for_reloc && !root_dropped)
>>   5503                 btrfs_add_dead_root(root);
>>   5504         if (err && err !=3D -EAGAIN)
>>   5505                 btrfs_handle_fs_error(fs_info, err, NULL);
>>   5506         return err;
>>   5507 }
>>
>>> It means during btrfs balance, signal could interrupt code running in=

>>> kernel space??!!
>>
>> What a wonderful world.
>>
>> In the cases where the fs does not crash, it displays e.g.:
>>
>> [ 1749.607057] BTRFS info (device xvdb): balance: start -d -m -s
>> [ 1749.607154] BTRFS info (device xvdb): relocating block group
>> 69780635648 flags data
>> [ 1749.732598] BTRFS info (device xvdb): found 3 extents, stage: move
>> data extents
>> [ 1750.087368] BTRFS info (device xvdb): found 3 extents, stage: updat=
e
>> data pointers
>> [ 1750.109675] BTRFS info (device xvdb): relocating block group
>> 60922265600 flags metadata
>> [ 1758.021840] BTRFS info (device xvdb): balance: ended with status: -=
4
>>
>> ...and it fairly quickly after pressing Ctrl-C exits 130 because SIGIN=
T.
>> (128+2)
>=20
> I could get this reproduced now, with more filled fs.
>=20
> Although I haven't yet reproduced the abort transaction, it should
> already be a valid bug.
>=20
> As at this case, next balance run can cause a kernel warning due to the=

> reloc tree not yet cleaned up.
>=20
> This really exposed a new set of problems.
>=20
> Thanks for the report, now it's time to debug it.

Cause pinned down, the patchset has been sent to the ML.

Although my fix works here, it touches the core of ticketing system,
thus it's marked with RFC.

Feel free to try to apply those two patches and retry.

Thanks again for your reproducible report!
Qu

>=20
> Thanks,
> Qu
>=20
>>
>> But when it goes wrong, then in between pressing Ctrl-C and the forced=

>> readonly happening, the balance in kernel continues for some time (thi=
s
>> can be even multiple next block groups), until it hits the code path
>> seen above (in btrfs_drop_snapshot), and it's *always* at that line.
>>
>> So, it seems that depending on what part of the kernel code is running=

>> when the signal is sent, it's queued for being processed in that
>> (different) part of the running code?
>>
>>> I thought when we fall into the balance ioctl, we're unable to
>>> receive/handle signal, as we are in the kernel space, while signal
>>> handling are all handled in user space.
>>
>> System calls can be interrupted from user space, e.g. a large read tha=
t
>> goes to slow.
>>
>> Previously, ^C on the btrfs balance execution would exit when the
>> current block group in progress was ended. So, in that case the signal=

>> would also be picked up somewhere in the kernel.
>>
>>> Or is there some config or out-of-tree patches make it possible? Is t=
his
>>> specific to Debian kernels?
>>> At least I tried several times with upstream kernel, unable to reprod=
uce
>>> it yet (maybe my fs is too small?)
>>
>> So, it at least seems to depends on the moment when Ctrl-C is pressed.=

>>
>> This is a two-disk fs, where I reflinked a single file many tens of
>> thousands of time to generate quite some metadata. You might have to
>> need some more data or metadata to have enough change to hit Ctrl-C at=

>> the right time, but I can only make guesses about that now.
>>
>> -# btrfs fi show /btrfs/
>> Label: none  uuid: 4771ea11-6ec6-4c00-a5f5-58acb3233659
>> 	Total devices 2 FS bytes used 5.76GiB
>> 	devid    1 size 10.00GiB used 3.50GiB path /dev/xvdb
>> 	devid    2 size 10.00GiB used 3.53GiB path /dev/xvdc
>>
>> -# btrfs-search-metadata block_groups /btrfs
>> block group vaddr 78370570240 length 1073741824 flags DATA used
>> 1072177152 used_pct 100
>> block group vaddr 79444312064 length 268435456 flags METADATA used
>> 219824128 used_pct 82
>> block group vaddr 79712747520 length 33554432 flags SYSTEM used 16384
>> used_pct 0
>> block group vaddr 79746301952 length 1073741824 flags DATA used
>> 1071206400 used_pct 100
>> block group vaddr 80820043776 length 268435456 flags METADATA used
>> 214712320 used_pct 80
>> block group vaddr 81088479232 length 1073741824 flags DATA used
>> 1073045504 used_pct 100
>> block group vaddr 82162221056 length 268435456 flags METADATA used
>> 262979584 used_pct 98
>> block group vaddr 85920317440 length 1073741824 flags DATA used
>> 1069948928 used_pct 100
>> block group vaddr 86994059264 length 1073741824 flags DATA used 159784=
96
>> used_pct 1
>> block group vaddr 90349502464 length 1073741824 flags DATA used
>> 1073246208 used_pct 100
>> block group vaddr 91423244288 length 268435456 flags METADATA used
>> 109608960 used_pct 41
>>
>>> If it's config related, then we must re-consider a lot of error handl=
ing.
>>
>> I don't know, but I don't think so.
>>
>>>
>>> Thanks,
>>> Qu
>>>> [41208.183450] BTRFS info (device xvdb): forced readonly
>>>> [41208.183469] BTRFS info (device xvdb): balance: ended with status:=
 -4
>>>>
>>>> Boom, readonly FS.
>>>>
>>>> Hans
>>>>
>>>
>>
>> Hans
>>
>=20


--ylR6DKvRWEkHmDtU6gKXGh6gHrSjVJ4H0--

--WikCaq4F9l30PdtzRlXvFmZQ0wqd1kWbN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8C1zgACgkQwj2R86El
/qi7MAgAisahAuOtz5SXK18zt/p+SK7Jq7B5i6MQnpg6BMnEot6SDLTa1prcepwa
1ru13Fk4SxCkNqfziL0G9+nHeIgUj+yeDuUQO5CDkGGXP2lzeYcl+oE24gCsOz8q
itg5WE/kiYEYVSsRQ/oVLq4sVftRKDNajTJ0CvZlgfzUTBJVzCXXPO7Xj8HXX9MI
mejbRt9/GgHGoKjhrW8PR5YmvHYXjxHuZr5QYEswmJ0yotveY+LvTRTxJqSjrMzR
KLN8OotJmd5UHtu4nTr8CE1uOJ8gdglUmS0a8dOB0jgdoSW3lYP2eEkDS9WynTCf
h1HGwbJDDH+qEJKcPeif1niSOaSAEg==
=GmfK
-----END PGP SIGNATURE-----

--WikCaq4F9l30PdtzRlXvFmZQ0wqd1kWbN--
