Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73B91905FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 08:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgCXHDn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 03:03:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:47009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgCXHDn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 03:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585033414;
        bh=jWGV+ZfiryDNMnxcUWltCaKKruavwjud1wXCuKHPTWQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KWyrhpZCQ/4elRgiPZbzaa4BsjQ/tAWyepPpEpiKPuf241M6yZqAlb+AP1x8YxMrV
         hZuvxzya5GoBEKGU9w9XbM8xFQ/0vgdS067jUgeAlupnbA34btigeQ4hsGojTWnp99
         I0gRRQLrn+w51Tm3mU0duLwadEyOevXtElGLWDU0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIx3C-1ixT5T2xII-00KQ3V; Tue, 24
 Mar 2020 08:03:34 +0100
Subject: Re: [PATCH] Btrfs: fix removal of raid[56|1c34} incompat flags after
 removing block group
To:     dsterba@suse.cz, fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200320184348.845248-1-fdmanana@kernel.org>
 <8107ef53-5317-327c-674e-d5bd1b9d1e4d@gmx.com>
 <20200321174553.GK12659@twin.jikos.cz>
 <9eac14a3-b6fc-87e5-097e-b8aca1043398@gmx.com>
 <20200323192841.GM12659@twin.jikos.cz>
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
Message-ID: <74562983-4312-c08d-e0ed-73cbea194f20@gmx.com>
Date:   Tue, 24 Mar 2020 15:03:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323192841.GM12659@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f0dkLCsk3B5jryrcv2d83YW7H73liNynV"
X-Provags-ID: V03:K1:LkVGS2J41LuOSIJ0h2b+EtOFBBRzyQi2e+4naWo8rRbVONJIUn/
 tMNwEnthrhhk5Lf1rRODJEWyRPR80Ol8WVq+yKKIBrPaIPyT5LAF7yIt7e/JmnYPODRA8NT
 6gPgS/Me6GHSsnOL3PLyOBTLPDZFVUMqzsCG+FK04fD6shua9P+Yu+Ma1Cl8OIt9arJgqDh
 91fYG9mYCsMdbTwlwYJvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ALfONMEsN7Y=:UuNA23vM/+elRbz5Sd93v+
 XZOFwg+T3KyOGOTACBD3sa9dinXBRRgY4paM6UvAWrcCdI35cTQnLCGb01ah+KzYs7L+WRz8k
 rHS1AnRnZSmJ2/Frwk2BAThFbPokBN/zdKQKP8cJearOrWXDUENxXbvrIzUgwYMc/3o3K/+Vw
 X5lODY4UvAqVOuQyjsc/qyviuZpT0jC7CWvcjg2eJg33kYQhWcw8JCIN3zThS8lTuFwadojaE
 bySAEKnIFBcf6YBKWwCBY49CEWieWyNwpFlTsTskWZb/oKXsS0Yz3n6o900jXDK6asiEPlEr9
 5xlO/XodfQeimviCyEZFUyZR8p0BowgxJgYLugUA0UjAMTfjPtTxf8LCo0l5+SBO+w+egfL38
 OcD6Q2J3HtROaZYr/8K+3Bd8hE4yDBoHLyFwc8Koa+3ymfpQou9kKcmgG+vRPUCNmIGCqnekz
 Uk3iDcqi9CPyfjk44fUyNCol/q3p82rFeVLH7tHYg0pF5EgZxgNQntaEGH91Id5Ldc54WW6yZ
 DcHM2s6hiW5a1sbSvuIVO0jCII1WBxI0GpfqTZp4N6iV1od5cSGDjqhiZK0M0gDBgto9pVV/W
 F+M72MBvwG1HE6/tQ5bHncNAP7VDCNeT1t01MiEVcC1bhYd/AL6AgoPvhpvUhG9hoTrG9iYmd
 y6634AXaYtFI2RCeQn3SAwzYfgJNtNw4AnYsVLq8nxnBz9Tlj6h9EjG7dJNSS0B8RQ9FJEzgQ
 NmX9urgY8zzuSxdd7eDf2t+3b9vUhQ6nZzxQMGxZbDdovUq7j0J0zZBTcHpwUKnQGBpsoMQpf
 2fy5zJx0lGYxdLfuv6rVDsLgy7841akV0Rb+CcdhhH1rSIM7/dqxhUPfAOTk28hY1hUDL+7dX
 eMPqURRW7uQnhkgtBt53aBHDjNQpp96m5HLkdH0EMmeMiNmVvlybZKZjE21WszydSwqfAYqYz
 8rjp+A/ahVD8pg/qcDX3clIDz/PH0oAOR/Zaz4F04Uk7Mmavk6P2k7s7zIQ2TPlhpqCN5t0ak
 L7lfYgUvJxVw70Ig+vEVqht8BBbZxpaBmY0DMxy23fwvm0JaTMYXWRVuibsgu6/RzAgVGUPRP
 7OJa+frcdu6vCLBzEpsRLRvsUrmbyC6Tab52JHe4joM7RPqiaL6uSG3uLsMASserCHavheYXI
 SPbwZ9pa3Lm+CvcO7dBliJyx8GUjtuKjv+3cx82ipqapjdN5oSpu+hWwNb12QOTFeOB7ugXlK
 Vm3wkZzxUooAZWx7+
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f0dkLCsk3B5jryrcv2d83YW7H73liNynV
Content-Type: multipart/mixed; boundary="NKOv6Z3mOpInY7blzbe1vc6fexpWJ08q8"

--NKOv6Z3mOpInY7blzbe1vc6fexpWJ08q8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/24 =E4=B8=8A=E5=8D=883:28, David Sterba wrote:
> On Sun, Mar 22, 2020 at 08:42:20AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/3/22 =E4=B8=8A=E5=8D=881:45, David Sterba wrote:
>>> On Sat, Mar 21, 2020 at 09:43:21AM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2020/3/21 =E4=B8=8A=E5=8D=882:43, fdmanana@kernel.org wrote:
>>>>> From: Filipe Manana <fdmanana@suse.com>
>>>>>
>>>>> We are incorrectly dropping the raid56 and raid1c34 incompat flags =
when
>>>>> there are still raid56 and raid1c34 block groups, not when we do no=
t any
>>>>> of those anymore. The logic just got unintentionally broken after a=
dding
>>>>> the support for the raid1c34 modes.
>>>>>
>>>>> Fix this by clear the flags only if we do not have block groups wit=
h the
>>>>> respective profiles.
>>>>>
>>>>> Fixes: 9c907446dce3 ("btrfs: drop incompat bit for raid1c34 after l=
ast block group is gone")
>>>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>>>
>>>> The fix is OK.
>>>>
>>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>>>
>>>> Just interesting do we really need to remove such flags?
>>>> To me, keep the flag is completely sane.
>>>
>>> So you'd suggest to keep a flag for a feature that's not used on the
>>> filesystem so it's not possible to mount the filesystem on an older
>>> kernel?
>>>
>> If user is using this feature, they aren't expecting mounting it on
>> older kernel either.
>=20
> Before we go in a loop throwing single statements, let me take a broade=
r
> look.
>=20
> First thing, the removal of incompat bit was asked for by users, Hugo i=
s
> as reporter in the commit 6d58a55a894e863.
>=20
> https://lore.kernel.org/linux-btrfs/20190610144806.GB21016@carfax.org.u=
k/
>=20
>   "   We've had a couple of cases in the past where people have tried o=
ut
>   a new feature on a new kernel, then turned it off again and not been
>   able to go back to an earlier kernel. Particularly in this case, I ca=
n
>   see people being surprised at the trapdoor. "I don't have any RAID13C=

>   on this filesystem: why can't I go back to 5.2?"
>=20
> That itself is a strong sign to me that there's a need or usecase or a
> good idea. Though we have a lot of them, this one was simple to
> implement and made sense to me. For the raid56 it's a simple check,
> unlike for other features that would need to go through significant
> portion of metadata.
>=20
> Booting older kernel might sound like, why would anybody want to do
> that, but if the bit is there preventing boot/mount, then it's an
> unnecessary complication. In rescue environmnents it's gold.
>=20
> Usability improvements tend to be boring from code POV but it is
> something that users can observe and make use of.
>=20
Thanks for the full picture.

That makes sense.

Thanks,
Qu


--NKOv6Z3mOpInY7blzbe1vc6fexpWJ08q8--

--f0dkLCsk3B5jryrcv2d83YW7H73liNynV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl55sMEACgkQwj2R86El
/qjOxAf/X+R9cbmQpYI/sCoaMZ1mEE7SW6za0yRVFoKyCVrJL6dxSrTRniuiF6HE
aYWwb6kTMmfJNNQ1TU8xTTDbB+9E4vTh5iebCtzTELi+EY+RTfZ7MJERlrHs620G
0BSTwTML3qVFACqPOGnGOiDd7sUGIVsLiyB8iytKY3jd1rRpP+0lk3eqcd6BYuib
SNvL5MBWgxMV+irTbGPLs7oClaLWPCKe5ZMqwKtyskFoEITW2e8+X0fOlFmGfq/0
zg0EKblZRpOWhak/0jg8F5e8F7Ufi1kYDGXKxXIgrVQ7VQMiEngKUvBLJ+d3Pz1Q
W4mY4C7MGZN1SMWzo2TxEwOUk6uTSw==
=BM0i
-----END PGP SIGNATURE-----

--f0dkLCsk3B5jryrcv2d83YW7H73liNynV--
