Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489B01FA533
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 02:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgFPAiL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 20:38:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:46563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFPAiK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 20:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592267887;
        bh=7S/3IDwFhlVhye0z18uhhDIPetHG4pYHLwFNCUQ5Bzo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=U/tVKiSWTmFBxjQSC0QqvQ7VuwiAQJY5OXb8dp0xxYabISBWbJjATDKrLg7oySUAb
         Ff7I9afAzbviTLlPawplHoOrwd4UGPwM+tczQ4QvzbZ+DfWIYqfSqwlBMg+XlbLQzm
         WTSk4EsKJyNJmXlLTprD3isfuu1JPv/Ui/zfE9IM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMofW-1jUYeo2752-00IlfG; Tue, 16
 Jun 2020 02:38:07 +0200
Subject: Re: BTRFS: Transaction aborted (error -24)
To:     Greed Rong <greedrong@gmail.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com>
 <20200611112031.GM27795@twin.jikos.cz>
 <a7802701-5c8d-5937-1a80-2bcf62a94704@gmx.com>
 <20200611135244.GP27795@twin.jikos.cz>
 <CA+UqX+OcP_S6U37BHkGgzyDVNAud5vYOucL_WpNLhfU-T=+Vnw@mail.gmail.com>
 <20200612171315.GW27795@twin.jikos.cz>
 <CA+UqX+PxF=prEHeS_u_K2ncT1MGqdmFsQeVTkDYLS6PqhJ7ddQ@mail.gmail.com>
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
Message-ID: <46f57bfd-8957-6d7c-b8bf-66b5bc2cb3a5@gmx.com>
Date:   Tue, 16 Jun 2020 08:38:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CA+UqX+PxF=prEHeS_u_K2ncT1MGqdmFsQeVTkDYLS6PqhJ7ddQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lY8eGQOuHN40jdz8qlyKYTVyZSfi9pxgt"
X-Provags-ID: V03:K1:T+Jg/c7KbANR8bKU6KAMhWDivOeMNPkG6E2AhVdOZaHKDVq9TZe
 PRCgDMEIXUe4aNJCj9B7udfmgXHKUoDeNtQ/6qkts6405Mey1kyVJGLTm2V+WmUR6E+2WRv
 JAI1LlksmU5JjnXLXdt2nZAEQiZwW+GUPIKgYaGi9Nd7UREe7g6Y2bnX6d3GBZNg+28Ulvy
 ncRwmkz+z+JQWtlx7jIVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Budh0xPDFQ=:XgQ88oeq+ymGGjpPa+x8XV
 M0g8DZScVGMIiXqCrkAJK9eu7wE107tuBoUQgDbK/RAXjTMCe1RaQXoihXHpG5/h1CmmKdqzr
 U4s1S1EccKZm2raa3PB2vDoJSGel5eJPPhNI8JIDc5iADQ1KagHwiuQIrjxB0qSvMNRXXFfSK
 ztV5O9LLhEx8D4Ag5Ldkc56BaD8NotmOYrqOBbnZV1J35xMuGR0Vjh265D58xig9Vy/er9i+1
 gD14IfabFdaAj22VlyXpRdKPF7fKU3DPiwVsAsBQIIEpedVlMG8QliDtEw6hwoLYSERUcWcyf
 BP9YSSyK6O0F5g/SMtUTNG4aHGgpx1zXiGnqr4T2Opa/nd60egqBa+gSZQyG+hrNwGYpB/rFc
 OoKtj2riVGnQuEHBiw3zLuzflOrH9pVg7jPRjMMGg2UwWcRTi3xd3raEJAYumRoP8Y3iHNwzU
 zeo/CwgO1paTfrjrUdtXjxiMDYfoF6zjDH5JhUBZFGvN2IBys5OHskkCVRX7W8kNG4sLb8sVa
 RhI8tQqo8ZJfhbp1lqzhDhLI3Iuo53Qmz8CLNDT98WTsdUYwkyRqVUiDdy+B3SBNZ9TE8hYrQ
 Rlgn4KYVSpQ3zwTo5lEUDAZaeHJACLmsxQZxOXzYf3UIEOAaGdkF3+YfeLHJ9wwQM6ji+DqtB
 aD0p483dCOk5aiGYSuKNkU67u7OEE1AYDJoSxlou2iRpgiXau+Qw3JjcY1s4Ef9WousyjPsT1
 pfQl4ytieYnjwlcpI5EilHxWJI2w6xOKxhPG9zaTmlBvKwbPFdLZcp+5brykipjKdNbVpLPI3
 IVutqTpSxd6xWgQSgIagV8ZXR2bbhxu6mgP4wpb1sVy6X7fPjAuyC/VsNtSZuemy8LKlF8LcB
 1Y3pFbCTjOd50q8yxjOGQzXgJHOb1RrMgek1eIe2LKBJXJLOB6oOQYgbjLFqNaIKbcv3R+g8s
 F3vAsRsAzIWOqN2Aar1ngTmoFK08VcA6oSTij5i9lRDqEJ978jaCJzMxCQ2XWT9B9TDQGnu+3
 YtOZhpQynOyE2oTwRU40fBVGWHjs+mSHdVx2CLj48/X0+vimmu/eQDWHVcrVdTO3kN7O7E6kb
 WcwClNQyMZiandzy5Jz1fDQxcydNOx7jMjiIWWzwfR9zQ+3s5hND1m2gqdbd/LIfEOprmgYwJ
 VTDnQHg05IoPmF79YBqHmm9Z4IFMOZzvOxtaHvLRfuJEb6x0IUdEP2TspkcrW8QOyzohoUZfq
 c/UbRYewomBGFT4Rz
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lY8eGQOuHN40jdz8qlyKYTVyZSfi9pxgt
Content-Type: multipart/mixed; boundary="q7hCZEsmDeBBnHVulqw3EfRdgtAeMOZJQ"

--q7hCZEsmDeBBnHVulqw3EfRdgtAeMOZJQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/15 =E4=B8=8B=E5=8D=888:50, Greed Rong wrote:
> Does that mean about 2^20 subvolumes can be created in one root btrfs?

Unfortunately that 1<<20 limit is shared across a lot of filesystemts,
like overlayfs, ceph and btrfs.

Furthermore the pool is a global pool, which means it's shared by all
btrfs filesystems.

So in one btrfs, it's way smaller than 1<<20.

>=20
> The snapshot delete service was stopped a few weeks ago. I think this
> is the reason why the id pool is exhausted.
> I will try to run it again and see if it works.

At least we're working on workaround the limit, by:
- Reduce known unnecessary users of the pool
  Reloc tree/data reloc tree don't need to utilize the pool

- Prealloc the id to prevent transaction abort
  So the user would get error from ioctl, other than forcing the whole
  fs to be RO later.

Thanks,
Qu

>=20
> Thanks
>=20
> On Sat, Jun 13, 2020 at 1:13 AM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Fri, Jun 12, 2020 at 11:15:43AM +0800, Greed Rong wrote:
>>> This server is used for network storage. When a new client arrives, I=

>>> create a snapshot of the workspace subvolume for this client. And
>>> delete it when the client disconnects.
>>
>> NFS, cephfs and overlayfs use the same pool of ids, in combination wit=
h
>> btrfs snapshots the consumption might be higher than in other setups.
>>
>>> Most workspaces are PC game programs. It contains thousands of files
>>> and Its size ranges from 1GB to 20GB.
>>
>> We can rule out regular files, they don't affect that, and the numbers=

>> you posted are all normal.
>>
>>> About 200 windows clients access this server through samba. About 20
>>> snapshots create/delete in one minute.
>>
>> This is contributing to the overall consumption of the ids from the
>> pool, but now it's shared among the network filesystem and btrfs.
>>
>> Possible explanation would be leak of the ids, once this state is hit
>> it's permament so no new snapshots could be created or the network
>> clients will start getting some other error.
>>
>> If there's no leak, then all objects that have the id attached would
>> need to be active, ie. snapshot part of a path, network client
>> connected to it's path. This also means some sort of caching, so the i=
ds
>> are not returned back right away.
>>
>> For the subvolumes the ids get returned once the subvolume is deleted
>> and cleaned, which might take time and contribute to the pool
>> exhaustion. I need to do some tests to see if we could release the ids=

>> earlier.


--q7hCZEsmDeBBnHVulqw3EfRdgtAeMOZJQ--

--lY8eGQOuHN40jdz8qlyKYTVyZSfi9pxgt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7oFGsACgkQwj2R86El
/qivAggAgQJtEb5IK66OviZ+/jgk6YenXTqiYgeblPiNSAsXKwVEeFm97WS26mle
QjtzibdM4GFXKM+ikMjChM9X85kNAJ8kPPzFey3bwdMR2bnY+OwInZQgKryNxJOl
vDmMeWvaXy2nR/HdYn0KTOvYa220iNXk9UxLk8Z4tXgLKcujtX9L/PlxUw+XG5s+
gtU9pZnk0FdTrGl53JcetnHMItiiLkIoajHt9z19kC11lrwpzTX8C9IoS1M+KBEQ
YuTEmAwcvGKeLpIwe88P8tCDIkA91JIVjcpFkT+w0C2Rjptig9vmfox/WJxJrEip
Fxzp2SMvUzc1sX2qBtn+uwgT2RfH5Q==
=UBHb
-----END PGP SIGNATURE-----

--lY8eGQOuHN40jdz8qlyKYTVyZSfi9pxgt--
