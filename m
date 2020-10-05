Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896B028356B
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 14:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgJEMMc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 08:12:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:41891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgJEMMb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Oct 2020 08:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601899947;
        bh=L68g25G41E7r1APpeHIhvfHvLpTKJnh+c3ruiw3BNU4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AdgQRDM8kxXinKdkm3W4mKq/RijpLru9kKmwmpLsJGK8tushf7m/RasT5NUog0tbC
         wNqlzeeawRGgRRBS4bCAF9bQyx8V8dm3J5jlK0mmnxkjJDToy7iQ0KEo+SEsNCysid
         bHYIQw0Pmb4Q1FAlsbjcIswXo641vUlZHPK84/O8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MybKf-1kbRQd3pbp-00yzw7; Mon, 05
 Oct 2020 14:12:27 +0200
Subject: Re: ERROR... please contact btrfs developers
To:     Eric Levy <ericlevy@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CA++hEgx2x=HjjUR=o2=PFHdQSFSqquNffePTVUqMNs19sj_wcQ@mail.gmail.com>
 <c2d13609-564d-1e3b-482a-0af65532b42b@gmx.com>
 <CA++hEgwsLH=9-PCpkR4X2MEqSwwK6ZMhpb+YEB=ze-kOJ8cwaQ@mail.gmail.com>
 <CA++hEgzbFsf6LgPb+XJbf-kkEYEy0cYAbaF=+m3pbEdSd+f62g@mail.gmail.com>
 <c2c0f8e7-b3ff-9e88-9d98-3b903c241644@gmx.com>
 <CA++hEgwdYmfGFudNvkBR6zo3Ux01UFRwHN1WDd7csH5_jBZ0Rg@mail.gmail.com>
 <0b0cab47-1824-13ae-61c0-1c3c42c5fa10@gmx.com>
 <CA++hEgx4d_-Y4Be7_fpDLTbCnN2-2yAecbyjJWSJuU-qSFvVuw@mail.gmail.com>
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
Message-ID: <125dd8ae-a5d2-9694-af3f-504997e48338@gmx.com>
Date:   Mon, 5 Oct 2020 20:12:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA++hEgx4d_-Y4Be7_fpDLTbCnN2-2yAecbyjJWSJuU-qSFvVuw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jk4bnz49j3DkDxDAWbowqc6It1m4eghHu"
X-Provags-ID: V03:K1:mGHSKlU4nTge55QRxFBQjcJeIhHOeSbtHyTiHAgqnW6mFy8pWOu
 YAgI27ZCdefG951aXXtqlQXup9gkOLQ3BzDZXAlJupdoQ3ga1L56uothHfgef4z22KAVO22
 vUqQEnQ9WsFl2TfXTnSYBTKNk4IBYhhZFBRgJWA3Uxq2LxTdVnMfFFY+YMY2FHxvehBuBNr
 JUpf08eFOkGPdJhcrOX3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VbkikpY4uC0=:oMzGPBKbvdhOlr3g3kq4c7
 EmXfOtVF84a5PLhba2Vwskeo40rQDNbLiD6IO83+d5tpmf15ZWCwbnxmbHJDLpJ4gwekzyM+v
 4V1xaRtPZLb6amlH60IAzY7JkVx3dgwSQJbRwbOGPafeOmwB4VqbX0MKPX5WxxKo3pnSxjz2k
 FtaNNoUF2OjS1K5asA8Gyp9FdOc4d/SKcduLGvteIjlohf5yyvkIImHx17k+IpxezFU71/k4m
 DNZbeAdap4s9Y+uHXmfL7Df1cRZe6N5JNPU+le/wmkRw1/4SfnUZi7MA3dKollFQZZK3Ieujg
 cttBDGyZjlq/9tr2ZFqyq3pDpPRL6ZBvvycb29qh86Gb57mKAOY8AGPKkFd5mZQo24TzwDlMh
 t4acALRl8Aw5oog6/T6IMeifmqWm3c6Mfq8IX9AqwxiBy0ENZfguD3278X6CJQ7ilegwcJ2kN
 L6Rq/yjsuG/ZVzoBx9e4xI6xST3iknXOYuoZppNEnBO8h8p0pzzdUamRc06JeSjnOayrmZ0Ee
 NJuTmbqF8j9yeH5IEaYtPmrLPy2QWkLSJRiOjAgEa3xkwdOtvVXR6v3CPNBaCrvoE3zj/BjVo
 rqpsuL65fkmn3e7d1dqy/TvP6Fuzfgt2ro45tTGrgbZAlTN/97o9sDq9wrrxh2fq9Y7BkpTvK
 iL74JHz34DRvbB8+EP7ultTYj7YP0gOYrKavMLtUf8DmdWi0ECSBMpXDdDeX8BV29Ow4D3h2/
 w+e3XlkhJECXRusNEQNktQS5i8ZxZt9y5KyNiZWLpcCnV+Q3huseHd96eNimZo2s3F0UDqJ98
 OxZu5RBE9dx9BjKTjnkjYnSwEszRul4fuRsykrQyqAc6jivW5Bt3LOZUX7Ufoat+sAIG2/LDD
 EDyZ/XnWga+6d6AivOWcjmIOiacNpthkLiUqHrq8HFpjrQMioyhPaTKvrFoB2KIFDw1Ar4qPi
 iIXvd8SLf80z68utithuQcsfQDws7Il/JyR5/orX5pRHM3jKDZ56D4e5mkt2j5WgLr46QmtYD
 M2LF2uGvUslJh+L/YhjhJ1Odz1H7P8WZli3enIOzNBDVxg4WXt8gnJ8SFn44e5WLOUdNQKcki
 C6QffWGludekbLZrNiiZo4p+4890TKLG5JI2N+17UpMsC5a40jarsbwINEflC9Jm/wMBEjK70
 9Z+4Ei3yu4EHUZ0sjssZY4VNtafW+qK90E8bvS0vg3z1ppA7aDv0cjZqhDnUP/UrnxT74q2Dm
 bcZ/W0+zz5NJGgEfypF5zrbunHCOW5H1nxxts0w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jk4bnz49j3DkDxDAWbowqc6It1m4eghHu
Content-Type: multipart/mixed; boundary="oYNUNf2cVOstA3wEYsNeQz42FiGHgdr2T"

--oYNUNf2cVOstA3wEYsNeQz42FiGHgdr2T
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/5 =E4=B8=8B=E5=8D=888:03, Eric Levy wrote:
> I have two pieces of good news.
>=20
> First, after the extents were repaired, a RO mount was sufficient to
> duplicate successfully the subvolumes on other media using the send
> and receive commands.
>=20
> Second, with respect to the further problem of the balance operation
> failing, I was able to synchronize the subvolumes by mounting with
> balancing disabled. The effect of this step was to gain 22GB of
> unallocated space. Balancing succeeded after I unmounted and then
> mounted normally.

Great!

>=20
> I then began a scrub operation, which completed successfully.

That ensures your data is all good.

Since your previous btrfs check ensures your metadata is also good, and
you freed enough unallocated space, your fs is officially very healthy no=
w.

Really all good news.

>=20
> I am hopeful that we may consider this file system healthy, with no
> loss of data due to file system problems. Currently, all the evidence
> suggests as such.
>=20
> Needless to say, it would be very valuable to pursue improvements that
> reduce the chances of similar problems for users in the future.

Although I really doubt about the ENOSPC behavior, it looks like
something wrong with the space reserve code, and should not happen for
single device case, at least for latest kernel.

But since now you have enough free space, I guess we can't find out the
result anymore.

Thanks,
Qu

>=20
>=20
> On Mon, Oct 5, 2020 at 5:17 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/10/5 =E4=B8=8B=E5=8D=885:05, Eric Levy wrote:
>>> The volume is not RAID, only a single NVMe card.
>>
>> Then this means, we may have a bigger problem.
>>
>> Normally btrfs space reservation keeps enough margin for critical
>> operations, thus it will return ENOSPC before we really go to do some
>> space consuming operations, thus no abort_transaction problem like you=
rs.
>>
>> If it's single device, and still hit the case we need more space than =
we
>> have, either the space reservation or the space consumer,
>> btrfs_drop_snapshot(), has something wrong.
>>>
>>> I deleted all the files and subvolumes except what I need to recover.=

>>
>> You may want to wait until btrfs really drops the subvolume/snapshot.
>>
>> The command is "btrfs subv sync <mount>". And then check if the usage =
drops.
>>


--oYNUNf2cVOstA3wEYsNeQz42FiGHgdr2T--

--jk4bnz49j3DkDxDAWbowqc6It1m4eghHu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl97DagACgkQwj2R86El
/qhSIggAqCunRUbO2EoT6SwwkO5Qy3k5ogaRlx4TchfV889GtcKCLwYfsFC4840n
GK/4cLBq8lnRe1yY4jm5zj0xLwIexBW4NgsWpePg6TeS6sSdjUL55/IxeLJzbxMG
ftXkO9+VcBZBF0ITAxaLpmbJCQHjfydgAQkl+BPQrcRk0fSgS5gdxmWz6MfhiBtr
VBdFAc8WzmCadDDYvDQQ6kihKJPUqxadcKM5uGHIgLleZRaw8Ap+72DtXSC+CnSn
WH+spKrxLCjJx3eYIkXICdQ49XSWqxWu4/bWk6AJwfSUNc1JPuJrnslyW8xdxP+H
ZiJ/7pnrtCaNRmHIIkxcdxu+mSvlyA==
=u5z5
-----END PGP SIGNATURE-----

--jk4bnz49j3DkDxDAWbowqc6It1m4eghHu--
