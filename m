Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B188B1164D3
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 02:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLIBpg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 20:45:36 -0500
Received: from mout.gmx.net ([212.227.17.21]:52919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfLIBpg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Dec 2019 20:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575855933;
        bh=CYjc9BZQrZL5qQ7yTU8Y7WoZ7ZZg+nUQrErl0uWP8r4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YyR/atJrwEKS2WqQuFiDRa3NKbJRhaGj2cG8d6RZY/eRfLZJAF+GQY6eoJvyA1f9g
         JuQTaDslCBksjH5fUpDxpcwy8pMqgrSYulUbmenh9BPar8xVwtlN2VUJKNkKJD4ic3
         n2UIFSyI7cVPt1rYlG73zVnovEP8RTMHZMCCTyz8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatVb-1i2sLv23Mx-00cQY6; Mon, 09
 Dec 2019 02:45:33 +0100
Subject: Re: Unable to remove directory entry
To:     Mike Gilbert <floppymaster@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
 <5eae7d6d-a462-53f4-df0c-3b273426e2b2@gmx.com>
 <CAJ0EP40Wj59=CevVnn1rjxoc4CtGqbRjKFBSbU8BsrSjRC48ng@mail.gmail.com>
 <6c3454b9-cc23-d22b-c3a7-59697add9b88@gmx.com>
 <CAJ0EP40a6DpTu1YmMtBezun58pfFXhWwYEXpnnGLkup0OvLQPw@mail.gmail.com>
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
Message-ID: <ae3289dd-c1f0-3aa8-dfbb-240ec4952b6e@gmx.com>
Date:   Mon, 9 Dec 2019 09:45:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJ0EP40a6DpTu1YmMtBezun58pfFXhWwYEXpnnGLkup0OvLQPw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V7vRQIoewaNK0mexBaZKSTqnDRkO42TP2"
X-Provags-ID: V03:K1:CDMGZMYT5DGcMBGCV04spl+3ZqLXBThEf0yg+G/k38vBHZoZMbD
 Ba8/9pJsp7GrjnyUcE8sIbM3TTi+Ev/0tPLX9QmgIz+BoJYQYIoBJjynwepfJzuuIyU2fBE
 XKLP5bTCPRXu14Mr5wcR2OnLfi1+iokLwxglRklbIo2r3NL/g3kLEdnc6NPdJeXKFC/Ovr6
 RCAqXMdtIrakYtZvlwRpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nt+FNMVeCxU=:sA0V9ItZL90es/wHhM2xQt
 75mNqlTZhTHYEel1sX+SY320zFDgRRYMCcLabIDNoWNXjrSMp6gf+KWKl2ReC19uzJSvz4jse
 shv/PmWMfI5ZxwruwsNjQ9/cvYaiI8qdrluSxZ6b98vr0kNK/U/y0x445XMqStp4RGkC8Su8l
 o+r1a4jME1S3TXiF48hjDqd0B8fMqHeQmGnL0RF5eMx0HrXToNxIgfQ5FdRE35ebC4tti7gUe
 z1/iD2POha9kP8ENol4Cx+AxTFH0pHukqsPMgj3PePXm02Z7gYL2HMWhnUYg03yzcOtDBHNjk
 6ONfTB7xEIzjmp1BdUmK7G3dUtH+3eu7JBHaDpaD8hcwaT8k2pUQXPaaroIc18/U8MYfvUOu9
 QR0g94UktDuVQ3kfGuhiQI118YJqU1iZcAYM0mdqQXKVVbU54w73U1veCl1Ls6wrb2BDfc9y2
 b9zs0+2WvrLB8I/2bWCN9Dt/g4JXBBlQsqXj1Zy4vDvq5Jgjz4F56zs6fdlTYFwx2chOccKq/
 C7RcDTzaYAApda5PrlSYXEWJVciPmOuRYlhIArG6gdjx/ZYpL/iyT97tgGvHcLSTDPjnrsu0h
 A9zZkvOHszV2VhCsx9/SFTXOrVFiqwFT6P5rbVm738yqQnIXBJLLkGgEXewSed2kEeOOeK8DQ
 +PqUwkxvKFqd55iXf+nWcdkhVHQjdye1n2jIxs2NUpboWOYhomdTjWgEjGukCS+7OpSwJYeWn
 2SIeCEEJLW1tXV2rhNoNVYfRzrXx4QZVFeFubxcph/a0g77416RV/TlxTuZ13naNjO7ELBTkp
 00wtpYmTvy9giPeClxT3dtLkWtyWJ4sRZ5BdMgFt23ybcPlHVjSKx2eE7At+Swkh1ArO9JT6V
 KXrJGe5o5gzDDTFGlcmoGe0XEyO73AhizQlweM0sMR8M8BrJfe+Mg273SbjnES2B/vhj3IATx
 h303SpFjtSf7G2zr7szq6OyA+iZiHOew/kDO1W4FhnMokO63Cuj0AQibH5QINA3Qa3yXNMRt2
 xzp+Kvr2mZl/+HTDjU3aJCB/jZrx6CvHy+I34kQxreWjpfLCXMr5OlXULVbP0qNZXq8jULcY+
 +vCOujSBDG14pY/pYI4lEnxOc96j14Gx+PDDpt+OkCJ21g5cA8w86qFpttS6NC55xMkSucUoQ
 RD9KOvjB/dRkP3yU1c4HlgUhRKoyz2yVS1nnselPbOML8ywaI34Q4UGl2oEzZClaOdqgrbnM3
 zWSyHoUMeQZC2jiPa4IhrcAFTY6p7JgQUsUYav4tpIbpJ3OwejHgXH26TVAA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V7vRQIoewaNK0mexBaZKSTqnDRkO42TP2
Content-Type: multipart/mixed; boundary="bNzlKz6Z2Tutt2MR7bwT9SoCpsaQwyE3D"

--bNzlKz6Z2Tutt2MR7bwT9SoCpsaQwyE3D
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/9 =E4=B8=8A=E5=8D=889:31, Mike Gilbert wrote:
> On Sun, Dec 8, 2019 at 7:41 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2019/12/9 =E4=B8=8A=E5=8D=888:30, Mike Gilbert wrote:
>>> On Sun, Dec 8, 2019 at 7:11 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>>
>>>>
>>>>
>>>> On 2019/12/9 =E4=B8=8A=E5=8D=883:19, Mike Gilbert wrote:
>>>>> Hello,
>>>>>
>>>>> I have a directory entry that cannot be stat-ed or unlinked. This
>>>>> issue persists across reboots, so it seems there is something wrong=
 on
>>>>> disk.
>>>>>
>>>>> % ls -l /var/cache/ccache.bad/2/c
>>>>> ls: cannot access
>>>>> '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.mani=
fest':
>>>>> No such
>>>>> file or directory
>>>>> total 0
>>>>> -????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351=
=2Emanifest
>>>>
>>>> Dmesg if any, please.
>>>
>>> There's nothing btrfs-related in the dmesg output.
>>>
>>>>>
>>>>> % uname -a
>>>>> Linux naomi 4.19.67 #4 SMP Sun Aug 18 14:35:39 EDT 2019 x86_64 AMD
>>>>> Phenom(tm) II X6 1055T Processor
>>>>> AuthenticAMD GNU/Linux
>>>>
>>>> The kernel is not new enough to btrfs' standard.
>>>>
>>>> For this possibility name hash mismatch bug, newer kernel will repor=
ted
>>>> detailed problems.
>>>
>>> Would 4.19.88 suffice, or do I need to switch to a newer release bran=
ch?
>>>
>> I'd recommend to go at least latest LTS (v5.3.x).
>>
>> .88 is just backports, nothing really different. And sometimes big fix=
es
>> won't get backported.
>=20
> I upgraded to linux-5.4.2, and attempted to remove the file, with the
> same results.
>=20
> ls: cannot access
> '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manifest=
':
> No such
> file or directory
> total 0
> -????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351.man=
ifest
>=20
> rm: cannot remove
> '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manifest=
':
> No such
> file or directory
>=20
> I don't see any output in dmesg. Is there some option I need to enable?=

>=20
Then it's not name hash mismatch, but just index mismatch.

In that case, kernel won't detect such problem by tree-checker. I'll
update tree-checker to handle the case.

I guess the only way to fix it is to rely on btrfs check --mode=3Dlowmem
--repair.
But before that, would you please provde the following dump? So that I
can be sure before crafting the enhanced tree-checker patch.

# btrfs ins dump-tree -t 5 /dev/sda3 | grep "(4065004 INO" -A7
# btrfs ins dump-tree -t 5 /dev/sda3 | grep "(486836.*13905)" -A7
# btrfs ins dump-tree -t 5 /dev/sda3 | grep "(486836.*2543451757)" -A7

Thanks,
Qu


--bNzlKz6Z2Tutt2MR7bwT9SoCpsaQwyE3D--

--V7vRQIoewaNK0mexBaZKSTqnDRkO42TP2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3tpzcACgkQwj2R86El
/qjNeQgAky94FRPOXDdHPN6c7mucCMqy+HO91+oqb9/z3Ke4WcQDegKi/AnD7PIv
HzXzxVfF93q02Fz01xtGtbejxwtp5kSnsCTPMUFVSYTZAYZ7xyJmhu3Poz/PRcBy
CWndPhqB7DErQBgxAOOKDxFEbwoF/oxdRtjrGaHqIHWZp/Sshy7SOB9JPK6UmOOS
UBemeK1wTH3S2AobeDuIlhQFPq2ArYdhs9WC01DDW/OjLeh89jogi21XmMW2YSxN
mTmGgGAZFoUY8wNjSqtwbKPb49WH2Ri6Eui4SlfDJdYBhdiLc17CYUVJaYR/qwgy
4d2K+duL9pe2FpbFI1B+4cZwFOxsUA==
=7ka4
-----END PGP SIGNATURE-----

--V7vRQIoewaNK0mexBaZKSTqnDRkO42TP2--
