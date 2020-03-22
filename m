Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBE418E5A0
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Mar 2020 01:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgCVAmi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Mar 2020 20:42:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:34687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbgCVAmi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Mar 2020 20:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584837744;
        bh=N7Vo4AOiueX8bQsCQfQASVwh5V9IKlbOGZB1HcllTDE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ja8IQVaXuiEcrDZuILofDQaogtDSrvKEVnXvkqDEjahRh03QG5v44I5wauHEtjrXv
         s2G1oPGe/B3McXEHi8zUDH+oXktmJ8Tp2pqg0zo7F4epwyc1sIVrvtYOjx0NKLbqGy
         R4s15utWvUiXRDcMobmC904j6aCeLEX50FQ/DTI0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M59C2-1jEiEN3A3w-001EGb; Sun, 22
 Mar 2020 01:42:24 +0100
Subject: Re: [PATCH] Btrfs: fix removal of raid[56|1c34} incompat flags after
 removing block group
To:     dsterba@suse.cz, fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200320184348.845248-1-fdmanana@kernel.org>
 <8107ef53-5317-327c-674e-d5bd1b9d1e4d@gmx.com>
 <20200321174553.GK12659@twin.jikos.cz>
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
Message-ID: <9eac14a3-b6fc-87e5-097e-b8aca1043398@gmx.com>
Date:   Sun, 22 Mar 2020 08:42:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200321174553.GK12659@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="s73w0lShCte032LFb6uj6ZzYNgFaAbf2o"
X-Provags-ID: V03:K1:5L4uNiDGuJRR0QKxOuuJPOspb+tsStyZYl3/ol8WarYkzjgBVDS
 KXGpaIMu7q9q3ZYC/2cRnugUOsGVQm29gqBMSaJ04AfZWgr1Z/p6eTpLvDmTMOBDyj1xt/W
 Wy1rPKWQoQjqEyAJCK+UPP1MG4LjyjNs0tAPlueTbaB7jQyD8g3KBkVVCqwzkAHO+Lne6QU
 /Wjis7nUvtFTWnFDc/ywA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DyUhbhK+e24=:KXu5se+mDQ0dnn7+n9gj9J
 w6us2zo18BrHhKQT6IHAPyDhIViPbsDm7pziurRL08lTHWpZtVjD28NwdONhMl/waFGn1RQc1
 FFUlM51sBwQnNErFJ3oCOAmKbPjqPXDpHWPvWV3NDlewz2XJkgmXt+VMyIGfacZamogULRFU6
 +lwJYqI7uJZ/qoR/+e/OfT2uXZ+mjjsjKnLP7dS88UJLh2QajiRbUAqZdVuj00rhd1qDtpfp9
 VO+T/udRJIBgAtjMHZkBBM9OzfNC8xrqE8FmRU3DfTNyvtUQYJXY7THzduiNXDrDT+DtalpZw
 qzcwiwlv/JVZYggj0mL877oWhUdv0U70MTi+M9K+ebOlqEday5gdhLrU3fbl996SxjvY3Va9T
 jIyUOj7zzoYXjzczQoDNnQw5DqiV686xOGGQZnX7qUvIB8PD2I6wfx8n6Q/Z+4fuyF0GF55Su
 3kSd/COU6CzcDJgKwgs6VgVBJs8UaligXdoI6lV44m2pQHQtnO4NJsISMNiL1qtScMBru9k2k
 NLNAqrwQ+EiX1FjNnJOjUQMmpznqYoU0HE2078Zj0RbgRlSjyBpOYprflg8RdjeshCmQQh5CL
 O4kjZviu+vRQ1BENrQKvYFi2K/r0WWtjVmMpQ6cW0jWTzfoeKBSiXnnGzI7PVTESuaSEwndQg
 5+ZfoPut/ODF2TzVvV6EeurK6iFTQcxeChboC15roClOwuSRfSawiR17z1qu2aSgRN7tH1nJn
 jnQ3ySNenSQfBAtTQwxiEHfG32cAnvKuDkp07m7ZUgzWvpumCHPZ5mE0L9PS6euKT0oyldLSk
 IwPWDhdXeuG5qBqvmrHTXdspU226Rt5c9LZJKgs+N0IjyizQUBQef/02jfbPZHbfanfC/wZUu
 tmEeTdpCFBPgTCcBHlFYz9v1AoIDnV6yWb07M3v4+b72K7gku5BG3uB7fUNcF7aLUZcBUvtM3
 sRW3S8HkchfLhm1/5S/G4QUsBMg8WqdgfxEtSS7SBdmCz8JgpGH4wWlsfOv5CMqsjKQb4C5Et
 Tmc+9QXAD6pyk0wJM1iaOxrSM7nbGt+dQRvBTuW/7IERRvnF9tEJ2GVzUZTuSV+Iu4fKJIAtC
 iCcIHwP40Pp5tnFmpNMVNQfTTOQoe274NlvB65cRkVAYzzzKO/WrzBm1BDZrGN/NNFm0E9ppE
 M/VZSpuKH32e6Wew6YSUdVrl07MZsGARk9CBqmWFFeme6kXlNG2RGIB7woiHuFeWGDjk1u2ne
 QeFvK/P0uhrJE3VxF
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s73w0lShCte032LFb6uj6ZzYNgFaAbf2o
Content-Type: multipart/mixed; boundary="7cFcHUEPYRvo4slcrkrLGFTwLNG5dikmY"

--7cFcHUEPYRvo4slcrkrLGFTwLNG5dikmY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/22 =E4=B8=8A=E5=8D=881:45, David Sterba wrote:
> On Sat, Mar 21, 2020 at 09:43:21AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/3/21 =E4=B8=8A=E5=8D=882:43, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> We are incorrectly dropping the raid56 and raid1c34 incompat flags wh=
en
>>> there are still raid56 and raid1c34 block groups, not when we do not =
any
>>> of those anymore. The logic just got unintentionally broken after add=
ing
>>> the support for the raid1c34 modes.
>>>
>>> Fix this by clear the flags only if we do not have block groups with =
the
>>> respective profiles.
>>>
>>> Fixes: 9c907446dce3 ("btrfs: drop incompat bit for raid1c34 after las=
t block group is gone")
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>> The fix is OK.
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Just interesting do we really need to remove such flags?
>> To me, keep the flag is completely sane.
>=20
> So you'd suggest to keep a flag for a feature that's not used on the
> filesystem so it's not possible to mount the filesystem on an older
> kernel?
>=20
If user is using this feature, they aren't expecting mounting it on
older kernel either.


--7cFcHUEPYRvo4slcrkrLGFTwLNG5dikmY--

--s73w0lShCte032LFb6uj6ZzYNgFaAbf2o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl52tGwACgkQwj2R86El
/qhJGAgAqsjYIBzl6a8M80XYA0rTJLt/hd2G5bR8QWi/2BrHIKhjltpGnysr+Iyu
mTYt/eGevMXDOOq5LQe4EI1Np7kzBUbF0OT59iamjt5AMp3CubKNFLVSJeGhaL0s
pH6r+SVJb7URrsmYcTVb65u1IywtnwpkpVm1xCEC850Uah8IXeVh/tm3iaqSD6OX
0G31u0ONVkhD35uCP0yv7vggFiIsNS26TFGrDVVMVsQCMakYFeK5OcBzXoOQDyyv
ul+wwXwLSx0z76ILKJyGQqGEfTapu020CvmJTPZZm3aDYlIJQ/7JVFhTpawHCT3h
DVWQCE04t0OgCac+ErQ/kN2k+XJmNA==
=B16z
-----END PGP SIGNATURE-----

--s73w0lShCte032LFb6uj6ZzYNgFaAbf2o--
