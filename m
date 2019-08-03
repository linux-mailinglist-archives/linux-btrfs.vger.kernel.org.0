Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC1804CF
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2019 09:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfHCHD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Aug 2019 03:03:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:37783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbfHCHD3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 3 Aug 2019 03:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564815806;
        bh=AUq439U87FD6cve15pd+h0AbYkGNR403fi3IOBBaD0o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=i98liNosKWr9hLBmeQHP7jMTmzQkpI/PMzYo/OcdSKnX9Zbo5n+HrfZsO6sKf059G
         ID9C2XnzDjroM+g82c7ktwlAk3LZDb82Dso2Vql4KumCUh2bYToqsfgE+7nMQROkOe
         taFWW1rZ+IXTbRiYQOuf0HFowYaQ3L7O0UwgfR9A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQeU-1i21nf3RFm-00AT5L; Sat, 03
 Aug 2019 09:03:26 +0200
Subject: Re: Non-existent qgroup in parent-child relation prevents makes
 qgroup commands fail
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <665ad51a-def8-b60a-8ea2-b76e46f306d2@gmail.com>
 <5dcb6a1b-42db-cc84-a403-288b30c2842b@gmx.com>
 <96f2509f-fd4b-ed5c-7e48-730d3a9875f5@gmail.com>
 <677ae3d7-10d8-9073-e5d3-e38de65da9ee@gmx.com>
 <5af7cf6f-50dc-7984-e030-e329622d4cec@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <ce47beac-6470-a137-42c5-25ac4b104b97@gmx.com>
Date:   Sat, 3 Aug 2019 15:03:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5af7cf6f-50dc-7984-e030-e329622d4cec@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="blYaRQHRypWWrDl4V3KNrmaJod6v9e6JD"
X-Provags-ID: V03:K1:l1S70BX9j8qgnWfKMCrJ7StPnyoSH6Ntdj4dR4G7Y5lIa67B0/e
 LhOUq7xFlL5dCi/mg0X1CQoNDupCnoVSdBScf38hW+aq6GdQaUkapKz15ShTXF1nJLo3lnu
 kS4j0z2o0yDrZYbRZGdXyQv60dO6kUsKnaPFauYEsFcRK7Z6Cr6EIMCIlrDh00tu7n0kEMh
 5NGq6RJo4zszOB8jzKPfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8rMtOW36ih8=:iEqRPOlop7YZzQ9DDj6lyz
 eaDi37ThleqkgZkgHe6hxS9ibw4WsJ8U77YQXMNIRDvgBhsm8tIQ27N72YTSeNg4Zh1Ol9vQp
 YKKyO2wNuZ0G4K4DNfXTr+q1UvBHd6efz+l0oAmOQqD01eLICGW5exM6FlAjeCZdvqQaAXlVp
 ttKBy9fU5XH3U8NrIGJ+688gkhAhx9qOKHPzGgvjY6aIg6kXtVZF6RMIrmcp7JwGJObPNTPXC
 4y434fxaewcRJhoZa69thAddoMa2trtKiUHC0CFEdRRQn4q2cksr+Vbo4h0VB1k5ADoRYNmFD
 nU7X2XPlh+1wzKxQ6O1xM0tpkyqOJ4DwfE8LD2ZdLtW7IlzvX+29hytkYcc2wPNXf8LxTitlI
 3YnpbCEj34rT5CU4gckcH+5eCudkxJEbAA27wRAedoXwT8xCYSpDEqggVz6ReAqJDPfi9TwBU
 CnAqI5LFIj9x+C/VKiGY2MH52WZDhpeXOhgDN8dhug98/HQfaFmwDdz4JU4nVMBC9HOuvpoqD
 eeKpGIkW+E3A48b1EKD4keObl7hPKs4ztLpnWKE1nfPFW//vIVQteWJRoUtg9VoYXCekz5dMi
 Rneif1vt0hP36NGMUwdb8euUhY+16CjzmaYSLk483Pv8f+XzrgsalV9geiPH5O0R69UZncvqp
 bKIYcypZfvfNTmRkTPxVMIKfwr7LGZamJ3ERchbBkp0dgvPFszi4rrNCFrO1zV+ViUDXsEDGv
 XSVa5wCDIIXlgChCVQNSEiNU19yTyhu1UFby+VrusC9dW2RxTM6uxoM8lLxqutGppI8uTDBtG
 CTQF1oMmt0yCAaDKrV9kBNMAURxZAwwBJERpA5oE8IzaNKiELlMa8UVcFqZ5mxuiJm4gcIZi5
 4E5hOBtHjslVlGD3seOsJ8WuNgBs2fwhB1DCNhjnFLiBeH0nNXyqzsJQO0/nEnLigu+OqLDdp
 BB99sIdDooBg68Ri5BU8YVw4mqpjfr43NfVVWbTB6zWxzwwM9R8trUxqG/jDjkfQ3O+qbDdes
 +XbNpRdrpIZMq6rpZ6flscGT5F0PVtaNS+Kk1Dgf/FJdTUwXx7A0KPZK9TjQ1EQ+kcPIO9PFy
 BysCRVWf2EFiXXLrGzFJlu2ewpaDTpmSqlJIZWJoBOKUjyep+7P7+i0hQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--blYaRQHRypWWrDl4V3KNrmaJod6v9e6JD
Content-Type: multipart/mixed; boundary="TN92KsBzAri9pWrNjZpIIHWlK7YFrtJdT";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Andrei Borzenkov <arvidjaar@gmail.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <ce47beac-6470-a137-42c5-25ac4b104b97@gmx.com>
Subject: Re: Non-existent qgroup in parent-child relation prevents makes
 qgroup commands fail
References: <665ad51a-def8-b60a-8ea2-b76e46f306d2@gmail.com>
 <5dcb6a1b-42db-cc84-a403-288b30c2842b@gmx.com>
 <96f2509f-fd4b-ed5c-7e48-730d3a9875f5@gmail.com>
 <677ae3d7-10d8-9073-e5d3-e38de65da9ee@gmx.com>
 <5af7cf6f-50dc-7984-e030-e329622d4cec@gmail.com>
In-Reply-To: <5af7cf6f-50dc-7984-e030-e329622d4cec@gmail.com>

--TN92KsBzAri9pWrNjZpIIHWlK7YFrtJdT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/3 =E4=B8=8B=E5=8D=882:49, Andrei Borzenkov wrote:
> 03.08.2019 9:17, Qu Wenruo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>>
>> On 2019/8/3 =E4=B8=8B=E5=8D=881:31, Andrei Borzenkov wrote:
>>> 03.08.2019 2:09, Qu Wenruo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>
>>>>
>>>> On 2019/8/3 =E4=B8=8A=E5=8D=882:08, Andrei Borzenkov wrote:
>>>>> bor@tw:~> sudo btrfs qgroup show .
>>>>> ERROR: cannot find the qgroup 0/789
>>>>> bor@tw:~>
>>>>>
>>>>> Fine. This openSUSE with snapper which creates and automatically
>>>>> destroys snapshots and apparently either kernel or snapper now also=

>>>>> remove corresponding qgroup. I played with snapshots and created se=
veral
>>>>> top level qgroups that included snapshot qgroups existing at this t=
ime.
>>>>> Now these snapshots are gone, their qgroups are gone ...
>>>>
>>>> Kernel version please.
>>>>
>>>> IIRC latest upstream kernel doesn't remove the level 0 qgroup.
>>>
>>> Yes?
>>>
>>>> It may be the userspace doing it improperly.
>>>>
>>>
>>> Not sure what "improperly" means here. snapper removes qgroup after
>>> deleting snapshot. What is "improper" here?
>>
>> Doing without using the qgroup ioctl, but some extra flag in snapshot
>> creation/deletion, which can also add relation at subv/snapshot creati=
on
>> time.
>>
>=20
> As far as I can tell, this is exactly what snapper does:
>=20
>             if (qgroup !=3D no_qgroup)
>             {
>                 size_t size =3D sizeof(btrfs_qgroup_inherit) +
> sizeof(((btrfs_qgroup_inherit*) 0)->qgroups[0]);
>                 vector<char> buffer(size, 0);
>                 struct btrfs_qgroup_inherit* inherit =3D
> (btrfs_qgroup_inherit*) &buffer[0];
>=20
>                 inherit->num_qgroups =3D 1;
>                 inherit->num_ref_copies =3D 0;
>                 inherit->num_excl_copies =3D 0;
>                 inherit->qgroups[0] =3D qgroup;
>=20
>                 args_v2.flags |=3D BTRFS_SUBVOL_QGROUP_INHERIT;
>                 args_v2.size =3D size;
>                 args_v2.qgroup_inherit =3D inherit;
>             }
>=20
> Do you say it should not be doing it?
>=20

For creation, that's OK, as long as it's not using the deprecated copy
version..

Thanks,
Qu


--TN92KsBzAri9pWrNjZpIIHWlK7YFrtJdT--

--blYaRQHRypWWrDl4V3KNrmaJod6v9e6JD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1FMboACgkQwj2R86El
/qhxQwgAlp4yjcw9dwnDhtfiDkB+jsHzvkTjTbs1W/H2/VvACr+CGn52htJwbFFT
vvFdTi00fYVfmq7q6JKy7YHP6t4k5ACrrAaGeEyS6zOjBVmixc4fByO51QSR4QRu
oJxMbOuhG9AySLZIdx2/eHu3S6P3AxmOQWbwafvMlbjlLwGlpHpR2jYd3F7UeiCs
g2Z1ltKnxBFGs+lhIrEIxKAnrCYTE1Ib1XP3Ld/KEQZCfJCrZlF01WeFWGXswkRt
PTPMe257Anyh2fQZyRrRJ+UQH6JT5U0j2VijO8HocUtznF5eMcGYWBJu56bAbK5O
IyKc0DEsCJk1Hjjfff6yy4aBQDh3JA==
=zyzf
-----END PGP SIGNATURE-----

--blYaRQHRypWWrDl4V3KNrmaJod6v9e6JD--
