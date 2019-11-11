Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D49F6C71
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 02:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfKKBq6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Nov 2019 20:46:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:49021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfKKBq6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Nov 2019 20:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573436815;
        bh=fhu9Q7200NHowBI3tddV43Vb9jh4ox7uEqxg09N0Hx8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kjK4WHLEWH9bvOIThKuTmjIBNYXn2ZU0s5fbrcc5ndNqPWmw6X6qEfU6k4Z3U0nwE
         jpSh/PBhRCpQC/AIeJFL9O4HIvNM4+T0wVL4Akh6cDDgYJFKVlvWG8hn5wQfXa9tln
         D/ypt98ifZG7qqUeVQgvZ5Tc+eG9Lxqt0gq1uNHE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxDou-1hfHuw3HNQ-00xZqI; Mon, 11
 Nov 2019 02:46:55 +0100
Subject: Re: fix for ERROR: cannot read chunk root
To:     Sergiu Cozma <lssjbrolli@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAJjG=74frVNMRaUabyBckJcJwHYk33EQnFRZRa+dE3g-Wqp5Bg@mail.gmail.com>
 <187ab271-f2be-9e96-e73a-0f6f3e97655a@gmx.com>
 <CAJjG=77Csw5P4q1sPeinoT=y=9Gy=FUr88NK2mJH72OBExnHgQ@mail.gmail.com>
 <1e600b1e-f61b-ab7a-85bc-8bd1710c2ea9@gmx.com>
 <CAJjG=74LUiRLbJiJ_BwgirqkA=i72t0GfJB0Masgkg0NHY0ozA@mail.gmail.com>
 <CAJjG=74O4oMPpDkj2Ue2b+scnb6AM8Bvh_e3ZGQr2_gTEVSUuQ@mail.gmail.com>
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
Message-ID: <4f82e6ea-2ebf-3103-90d4-00a17a1cf1c6@gmx.com>
Date:   Mon, 11 Nov 2019 09:46:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJjG=74O4oMPpDkj2Ue2b+scnb6AM8Bvh_e3ZGQr2_gTEVSUuQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kIDS9Ldqm0plrNv0AKuJamXRIMDetNFtB"
X-Provags-ID: V03:K1:Yu7qjtupyd8hRkUl9kScT62Y+1zEsqWTSxy7THubotVpoTJx8w2
 MM8hH5jx5sLOy1pIwvWvpB0YcHkCr+P1O6X2bQodhtGyl7UC+3DSScGH8oXWXJPb0KHFzOz
 FsgE3X4F2VMRIfjd0ODkj9lV++CLyd8v5PCuz1xdZ2JVA/zidaG258yL7iFn490tIp5aNJ1
 vsemypis9fk69XbxeO8IQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VOX0qH2NOiQ=:8r57P0nEwkzbDeJiV4ZPku
 x/mTDeTqprSbr8pqcNU4AHxn4a2v55e5kesKhon3JKgTrKRWH4b/mwKa5vj5RbqHIT+6RL2uR
 ecnA2UKyfeA+yKNK0omzxVHEUSKW1USfxiqPXKBnfKo3thAuZ+ttTnw75MFe7WUYdgSGnpP9V
 3c6aHd2S300vDvWxEHRaRCA36aCQjXfwEyVnyZu/dUXe+tgfJSCkpIfZRKMK1AIhNDzxCqbAl
 Nbs4jL9VQ+p9sNrIOW40fPg2z9szX+HqeYLJ4SuyGBk9JAjGUXDrV4vGvEJEYk6QJWWpDOs9E
 sp/cQQ9cOYY8COHV+hMXPvAhGif1X6dYvrETsH9vJB+ss8y8DzFtETNr/VW7+M1Be0u8n2++n
 9ABy9lE5GTnusSBwT/k5xrePGbNUK0GKXPbD0GNf+GUvs0m0SSR1+Gd6gNH3laOH7hIrkqXhE
 UT1gVrpHJWBGOR9Z8QqSVfnQ/CLhHBtXq/fz8pDdSOaCDJgeoxiP8yr+FNqoHMiyAQDbqkAUm
 DyqHGIt2oNjRGFyPKLIgnJxjggjyZNcIGf6MlP+xzXOhwW/lSi30WG0++9l7iSAQc+ECS68rt
 IE/eINp82A138MmhNH4qlu0ZbTzz7yX6D2ZqYbFz/XCD+QjffSK6IxCAmImTdtTABIPYRd7+H
 2T6FjcIDDaB4GQgOY5P6ls9W/cYH5/l1dIDdB2bWWcJ6Cx8ZmzsV14Gy/i+FIKqtzj1Gia4tW
 iDDmWcu7KwCI2lLrynEIhlBgoawiajvTnepIM4lZ6HnVZsXAI79wpRrCV8LFeiG31Oos5++Ga
 cMcICN+YFPKrSegNhrcuqIa2Yxbzcb4knDUq87dfKSLMLIuYnHxBUNfMRspYCMcor6a4WYPdW
 Z7BibgWSBjm5DU0gAZsywd6XYnDou7Te3IS/zq4BKbve2Yu9qC4acWFp4GVFzQ0lGEiRCyuJX
 vs/5rs5gSg0IXyjiWyQYH0rMcFipIPl77Uw4tQlxhW1rPkMmClhXOAnQx/6CJy6Mxck8Za3sX
 QZJwOmqv5w5FJ4hiLXMWX6aiFeS5euoeYXm1MP140jShTJDcBJ/smNNgsc/M3sA0DRb+UpjtG
 EHWppQHqCW/YzPhNX7n5/lYRyLpWN019mx8om+WnIka3nXHgyLaZTWO0y+Ye/BjV62TAMvjzc
 v/rzwR9qh0qDUTpZdrtfvnw+xG2RpWR9sWLnvmGCGnwhWkruSKwEpQNXvakcjqrh3bZbUorm3
 jVy+HCsG9t7hZC+KOrLyMhIyemzI3I7yAJw4Ik9Tinn+6NcUSAsXdHGFDSIc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kIDS9Ldqm0plrNv0AKuJamXRIMDetNFtB
Content-Type: multipart/mixed; boundary="UV9NZp1KbWXujjmW4TDXV9f6KRyKJ3L3n"

--UV9NZp1KbWXujjmW4TDXV9f6KRyKJ3L3n
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/10 =E4=B8=8B=E5=8D=8811:40, Sergiu Cozma wrote:
> root   856153161728
> chunk_root     856119312384
>=20
> Aren't those nr too high for a 416GB partition?

It's btrfs logical address, they can be any aligned numbers in the range
of (0, U64-1).

So no problem at all.

Just check this:
# mkfs.btrfs -f -b 1G $dev
# mount $dev $mnt
# for i in $(seq 5); do
    btrfs balance --full $mnt
$ btrfs ins dump-super /dev/nvme/btrfs | grep chunk_root
chunk_root_generation   132
chunk_root              2018525184  << Way beyond 1G.
chunk_root_level        0


According to "have 0" errors, they are wiped somehow, and it's not
caused by btrfs kernel module.

Thanks,
Qu

>=20
> On Thu, Nov 7, 2019 at 9:16 AM Sergiu Cozma <lssjbrolli@gmail.com> wrot=
e:
>>
>> Well nothing to lose now so if you come up with any exotic ideas you
>> wanna try please let me know, I will keep the partition for the next
>> couple of days.
>>
>> Thank you for your time.
>>
>> On Thu, Nov 7, 2019 at 2:44 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>>
>>>
>>>
>>> On 2019/11/6 =E4=B8=8B=E5=8D=8811:52, Sergiu Cozma wrote:
>>>> Hi, thanks for taking the time to help me out with this.
>>>>
>>>> The history is kinda bad, I tried to resize the partition but gparte=
d
>>>> failed saying that the the fs has errors and after throwing some
>>>> commands found on the internet at it now I'm here :(
>>>
>>> Not sure how gparted handle resize, but I guess it should use
>>> btrfs-progs to do the resize?
>>>
>>>>
>>>> Any chance to recover or rebuild the chunk tree?
>>>
>>> I don't think so. Since it's wiped, there is no guarantee that only
>>> chunk tree is wiped.
>>>
>>> THanks,
>>> Qu
>>>
>>>
>>>>
>>>>
>>>> On Wed, Nov 6, 2019, 13:34 Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:=

>>>>>
>>>>>
>>>>>
>>>>> On 2019/11/5 =E4=B8=8B=E5=8D=8811:04, Sergiu Cozma wrote:
>>>>>> hi, i need some help to recover a btrfs partition
>>>>>> i use btrfs-progs v5.3.1
>>>>>>
>>>>>> btrfs rescue super-recover https://pastebin.com/mGEp6vjV
>>>>>> btrfs inspect-internal dump-super -a https://pastebin.com/S4WrPQm1=

>>>>>> btrfs inspect-internal dump-tree https://pastebin.com/yX1zUDxa
>>>>>>
>>>>>> can't mount the partition with
>>>>>> BTRFS error (device sdb4): bad tree block start, want 856119312384=
 have 0
>>>>>
>>>>> Something wiped your fs on-disk data.
>>>>> And the wiped one belongs to one of the most essential tree, chunk =
tree.
>>>>>
>>>>> What's the history of the fs?
>>>>> It doesn't look like a bug in btrfs, but some external thing wiped =
it.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>> [ 2295.237145] BTRFS error (device sdb4): failed to read chunk roo=
t
>>>>>> [ 2295.301067] BTRFS error (device sdb4): open_ctree failed
>>>>>>
>>>>>
>>>


--UV9NZp1KbWXujjmW4TDXV9f6KRyKJ3L3n--

--kIDS9Ldqm0plrNv0AKuJamXRIMDetNFtB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3IvYoACgkQwj2R86El
/qjZZwf+LiNSlqEtyYqy8xMzF5S4hP9nb+tJoPU+eDpOpu7kQqlRIi2Na1jQ72Gh
cuWG6YuKvrtX9cMducn1AxKOIxSaiotKQaSfj2RcoVjXuS816hBA1/FPasuX+txk
ryixcbhE205aFex11PbZKSGX0NqV4q8KvSX2QEbT1wz2YpyjXnOZRLYl0ebBW6WL
Q3sZEvWDyHY4g66+MiOaB6cfwACZIuDdxRtRc7PdPaZPsOZSepIdwF45+gCstSsN
2QS1PQCGTdTbrDrLdX517oJXHmDwCBhiBVwkpMiR9MoBxZ2FU1Oaf9xtIw0BdMRm
G5+9hbYROkKDdM6CwrQMrGmfgYJPVA==
=iOGs
-----END PGP SIGNATURE-----

--kIDS9Ldqm0plrNv0AKuJamXRIMDetNFtB--
