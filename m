Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828F01751AE
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 03:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgCBCAO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 21:00:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:55603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgCBCAO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Mar 2020 21:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583114403;
        bh=qWn6xSZdjP3Oazj9mdnSYxAqrOtJnF5SRH3+eO908AU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GeUbNHTuw6JV3mgd3bPOvlPjHLe1IXupjN6uFMdKFWtHJ2cllPjYPlHBG8fhkr+6R
         hNp9cGFbTWjvEYjWk96pJ/YffUrA7aZFMN0GwAnuwAn0wBbQcWXMN2dgwaLyovi//6
         mIP0M3NQNbf2VRF+p8Qh/UREr0qdXIBpYcax7HTA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MC34X-1jEK473CTF-00CTdh; Mon, 02
 Mar 2020 03:00:03 +0100
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     Etienne Champetier <champetier.etienne@gmail.com>
Cc:     Matt Corallo <kernel@bluematt.me>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <1746386.HyI1YD2b7T@merkaba>
 <BA3238FF-0884-40AA-9E32-89DA35D8CD0A@bluematt.me>
 <7ab6c91f-6185-06be-0091-f3540858de29@gmx.com>
 <CAOdf3gpeyRSNEp_efkxG9be1PaFx7xzF5GO9STXYRSm3DsH9Rw@mail.gmail.com>
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
Message-ID: <a439ec04-fc10-4eb1-d21e-125aa905258a@gmx.com>
Date:   Mon, 2 Mar 2020 09:59:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAOdf3gpeyRSNEp_efkxG9be1PaFx7xzF5GO9STXYRSm3DsH9Rw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Csq7ZtykzKuX3FcDnaXulumYstuzuxfAF"
X-Provags-ID: V03:K1:asV9ENm0Xh7pFgoj49+Sr0z6jC1CQRufWGsz8y5yn9TnfcqXwTH
 AO1AmPH/QL+/pGK58K8+14DPbOzjdsfvCAhUVdQoZ3PNanSfEH7Eu/O5wn0gmXBtyM7VTw7
 JFSex+9LSXBt15g6OoUIPJ8FpaGABl+tboL/EMi2Mw7OaXzm8guEmIuAfa+tn/YXrE1/gxZ
 QzBuRO75NU3c+WIrNnMYg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uFhPpouEGn0=:OORHymV0Qs2WjoGMvQ3nSw
 WB/g1M8JF9gG1zuSgKO59NJRgh4io87JGC0Hul2pRZTaTbGXbD7hXbJN14eb1lViCDkKFmaoH
 OrfyJe4vYlTETMn0VZ4r//qPpRozLM4CmZTuzDxxqi9Po/P3mdsXSejthf2azETLv+SbYNRLt
 DQFm8EyOsYBSWGQ+zI1CVG2ZHfO2Y2TLNeN9OtcQK1fRP5WItsOEA5YvUS5NnQgN1wfpacg1O
 ZSSeJhsxlqx+1SARjczRoVNu1LP5NMZNhJC3htMfFPxSOHdE6Uthz5eSUAoqKnqJzlk6tfPf+
 2ECWYuOiVAhex6NXYcBX9LTEsnmYXwbPWtCYvsN/ODjOyopJIIC27dDNrSKrYACclwYhGYeke
 wKvHbvAqcSsPmKbzfDolMmj68KUXM+9b3xoEhcj9Nyu/KykFmAuqyDddeLtV41iDJmuruakum
 aa4ZjOserOBP1MtD8tLxa7n/NbAW6h0pQVEK8owX1OhRLQEvb3Ec7rGOrxrsVgJmMT2X2ccZS
 cewpd+LGFTsBbh5tYb95rQ85xFH597I1bSmaNC57qyKJubgHnjHZMwVd6GePxzMmuoq1R7BtC
 H7h+Tjiyepbz/kRSrpUzXdO9kdjcctaUIa+wu/hkrNoUblLpnC/c+o8fbMEbZXyImZ+6tghBv
 BH4WmPLT7jSQuLNFo1UK5X/FHXSggejHF8v8Nm9iwzfH3a1bLTLLa1aOzNwRi3WHLcIua4V76
 I2GAKAeTFG2XOS+owzgVxo+SOtfgkBbjMdUacADEmnSOFOzYySmZtckjzhqCxrvMEVepvLflo
 EjdAZDGgEIznszOAxJWaChq/y65UZYGV53Y6VAl/5p3FHOooHdHvtdgQEEE8VB9DzOgXvWG7k
 zLvXYpLrpRG+giICT+T8P+VuCUxHe2GVRaxGiImuzVzDiNp0KI7iQdzIfalk5IhttDeHFfqvB
 kJgXTwshQ1QF7sSLsSajxFb0mRHtnsuj7PztwXCm1ooUfdKlbK/aal5FAC2wsE3iLB5MMxNwg
 hJWMJA4yhHiZ4lBCS5eWKbkdqCOyKjTtSKfJgR4aoQmgWIxhOtBidwCqWSPLe40ufsr/DuRX0
 ATY/dUgCRHULO8Jg/cHFljJd80/Adtj5/xFGFbHZuqQcytQFwjQfA3oergLfYytdO8T5ckRvF
 0QCHaNsGU0YammzHxjhvq/UuI2kUUrtp4tBX4gWpU8PKH0PXINIEOGMIgKRB1KKGJBGTmAhWx
 oERn9X+ESJ+l3wMqv
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Csq7ZtykzKuX3FcDnaXulumYstuzuxfAF
Content-Type: multipart/mixed; boundary="fc2cornymuzz6BjaeunmqThElbc7Qk0ok"

--fc2cornymuzz6BjaeunmqThElbc7Qk0ok
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/2 =E4=B8=8A=E5=8D=889:57, Etienne Champetier wrote:
> Hello Qu,
>=20
> Le jeu. 30 janv. 2020 =C3=A0 20:57, Qu Wenruo <quwenruo.btrfs@gmx.com> =
a =C3=A9crit :
>>
>>
>>
>> On 2020/1/31 =E4=B8=8A=E5=8D=889:43, Matt Corallo wrote:
>>> This is a pretty critical regression for me. I have a few application=
s that regularly check space available and exit if they find low availabl=
e space, as well as a number of applications that, eg, rsync small files,=
 causing this bug to appear (even with many TB free). It looks like the s=
uggested patch isn=E2=80=99t moving towards stable, is there some other p=
atch we should be testing?
>>
>> That mentioned patch is no longer maintained, since it was original
>> planned for a quick fix for v5.5, but extra concern about whether we
>> should report 0 available space when metadata is exhausted is the
>> blockage for merge.
>>
>> The proper fix for next release can be found here:
>> https://github.com/adam900710/linux/tree/per_type_avail
>>
>> I hope this time, the patchset can be merged without extra blockage.
>=20
> I see that there is a v8 of this patchset but can't find it in 5.6, is
> it targetted at 5.7 now ?
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D245113

That's to be determined by David, I hope it could reach v5.7, but I
don't have the final say.

Thanks,
Qu

>=20
> Thanks
> Etienne
>=20
>> Thanks,
>> Qu
>>>
>>>> On Jan 30, 2020, at 18:12, Martin Steigerwald <martin@lichtvoll.de> =
wrote:
>>>>
>>>> =EF=BB=BFRemi Gauvin - 30.01.20, 22:20:47 CET:
>>>>>> On 2020-01-30 4:10 p.m., Martin Steigerwald wrote:
>>>>>> I am done with re-balancing experiments.
>>>>>
>>>>> It should be pretty easy to fix.. use the metadata_ratio=3D1 mount
>>>>> option, then write enough to force the allocation of more data
>>>>> space,,
>>>>>
>>>>> In your earlier attempt, you wrote 500MB, but from your btrfs
>>>>> filesystem usage, you had over 1GB of allocated but unused space.
>>>>>
>>>>> If you wrote and deleted, say, 20GB of zeroes, that should force th=
e
>>>>> allocation of metatada space to get you past the global reserve siz=
e
>>>>> that is causing this bug,, (Assuming this bug is even impacting you=
=2E
>>>>> I was unclear from your messages if you are seeing any ill effects
>>>>> besides the misreporting in df.)
>>>>
>>>> I thought more about writing a lot of little files as I expect that =
to
>>>> use more metadata, but=E2=80=A6 I can just work around it by using c=
ommand line
>>>> tools instead of Dolphin to move data around. This is mostly my musi=
c,
>>>> photos and so on filesystem, I do not change data on it very often, =
so
>>>> that will most likely work just fine for me until there is a proper =
fix.
>>>>
>>>> So do need to do any more things that could potentially age the
>>>> filesystem. :)
>>>>
>>>> --
>>>> Martin
>>>>
>>>>
>>>
>>


--fc2cornymuzz6BjaeunmqThElbc7Qk0ok--

--Csq7ZtykzKuX3FcDnaXulumYstuzuxfAF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5caJ4ACgkQwj2R86El
/qizxQf/V98oa/UNpa8EbFvrDFUOe36q1aLhHqkv4f8+lOVesSYvEWnvo3KyWI+5
DrX8t+jaBAv0WvgwhR1Z5H5f1rGkiVc9f4D/QdSycHzLLY4SFsUvOMV+cCpW6znS
DnUS53Zlx2EcS5HOWSNzDp7Pgh5CjCK035/gy6jC2Y3wUaNzwLVlJ+NRyLub5Vrk
Hh5/SwwfiZTBhB3n7FK2dxEpWdSR4jRd9pMmuVGL/JD0ye6hp6fpsXHZYKfgdRCf
cpUp0rhszA6RXKBwxMIlPvNtlV0isNsH45k8A4DdfU93T/3hKNs89LjQtkikiMZ6
OZYKRPLxdWeIFyIdJ+WX325pM0m+Qw==
=IcYc
-----END PGP SIGNATURE-----

--Csq7ZtykzKuX3FcDnaXulumYstuzuxfAF--
