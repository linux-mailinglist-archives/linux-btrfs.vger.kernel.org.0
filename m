Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB77C1E575
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 01:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfENXJV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 19:09:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:35583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfENXJV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 19:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557875326;
        bh=tWDovYHscaknt1AnqpWZ1Sh9qCNWrX5YbBkQt1xw6v8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BvTuqX6foZIjZnRpR5yLy6NI1abSZBtMVK8peu+TiqBJyUZ4MIiI/APBsuTwelVa/
         PWemeNwTGSIb2PJ3RY2dcWpJZPAHiPlxFCtUfnegKSGCKcCTjdvE0MQm7Zm0BFHbT+
         Cf76jJchjavwc8CgElv0XQFgfCAiwpZZUqiseZ8g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MTSKd-1hI8422WjH-00SQf4; Wed, 15
 May 2019 01:08:46 +0200
Subject: Re: [PATCH] btrfs: extent-tree: Fix a bug that btrfs is unable to add
 pinned bytes
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
References: <20190510044505.17422-1-wqu@suse.com>
 <20190514172959.GN3138@twin.jikos.cz>
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
Message-ID: <7b313d7f-c61c-f419-64d0-2b928bb7fbb5@gmx.com>
Date:   Wed, 15 May 2019 07:08:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514172959.GN3138@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UkPlrOHh3VCwJooF6naj56REPCQPdYTcO"
X-Provags-ID: V03:K1:MIxjyOq30RYTArkWLPn+OvL7XhYs51rakwckwWvD5278CCG6gA+
 RKBEhmTx68ecokd1ksoI3lfHEHVAwpCv78yz56+zYRL9RTQm/WZrWjBcozmGlQxFZDhcpVw
 lhxPeVq4VzWfd3K7MtdFjmu2YW/NBPb0lcrA+Y86vaxrTV1nGIktpZi+eayKjTl7zED0rz8
 GuyWOF1pwnit+ZMGhhgIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HZVP/lO9PK0=:cSJ+BpFah+On5xeL4ZArPi
 iw1Gghdw7JK5C5bMDJ32DFVcH3iEEOOXAVDNSgWKj3/Filz9oOhhLYk0uyX5aqulqEo8B9J6W
 956Unt0DPWdPdkGGKZXi4BRlD8dfM7FPgm7BSvsbTLzqEcxueU6TBGI34i1WV+PgjYMvMWXRJ
 KuHKXaGq2gHFsl1CanA2zycqUYibHr118W0FwtlOEVGjJLlVqpGvRKTipuO0A4WWI9EhI0gLU
 gRp3DnRPNwI8Oa90N1T6pQ2OVLP10r5R7WrAEyCO29Kgin2SB2TovUGVMr45C4ZIPw+ou62LH
 e0F8mzb8lZXZCAdK1ScmbSZq85dP+JOmMOB7AFt/PccbepJ4d3Jeuoixil3L9izM8kaobH41/
 oL9j5a+sFRmYzsJPb9p+IbL05JBrC0p38+srmG23ZOpGErVMgK0HR5I0kSbdFmkxg/40TkAsq
 E8BfmCG0iC5h3kuZe0kM2SgstzBh5DekrXJsam76kpXp4p0p9NreOdHs2Bm+MNeFJL4KCGLDH
 yrTeG2mGSL5bgkFOmP5458xotYn6qslBr4f5r7PpZ194JWtrmLSTFKr11k5rFHaSejy4fYztz
 M9szFs+q9wLbBDPPNoQCBdZ8UllStSamw2zo/hSO7JzpCiLxrCvylsPUx6BvdQ+IPR2fgg33U
 EJAsIeUTWp7jmSREqB+fsFLaziW+l4oMchGrH7cb1oRa19kF4hJttCQvU3Ei/nK1T7hQPMgmL
 4RcnEwAvISOnwgfS/4DEOP1wo593cBPffc8vBr0sF5Xs0o/7aH7Eq5VxTtkYqKg0vIrDasyYn
 0tYUKFQfUjFkJdHIVUcGDl4IxJiI7i+qjbDCTRYF5ODiTnGjp2DKdazZAPeeIGGG0D/T/R9YO
 qTfG1IUNH6a3NLTAru0eoDYr5HPgMXNnQOvKCoLe2RXyXB/+2/wNX0UD7siy5Z
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UkPlrOHh3VCwJooF6naj56REPCQPdYTcO
Content-Type: multipart/mixed; boundary="p6RaMgUQgNnRAKgLsYcpMXRzCHURx8Rp4";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 kernel test robot <rong.a.chen@intel.com>
Message-ID: <7b313d7f-c61c-f419-64d0-2b928bb7fbb5@gmx.com>
Subject: Re: [PATCH] btrfs: extent-tree: Fix a bug that btrfs is unable to add
 pinned bytes
References: <20190510044505.17422-1-wqu@suse.com>
 <20190514172959.GN3138@twin.jikos.cz>
In-Reply-To: <20190514172959.GN3138@twin.jikos.cz>

--p6RaMgUQgNnRAKgLsYcpMXRzCHURx8Rp4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/15 =E4=B8=8A=E5=8D=881:29, David Sterba wrote:
> On Fri, May 10, 2019 at 12:45:05PM +0800, Qu Wenruo wrote:
>> Commit ddf30cf03fb5 ("btrfs: extent-tree: Use btrfs_ref to refactor
>> add_pinned_bytes()") refactored add_pinned_bytes(), but during that
>> refactor, there are two callers which add the pinned bytes instead
>> of subtracting.
>>
>> That refactor misses those two caller, causing incorrect pinned bytes
>> calculation and resulting unexpected ENOSPC error.
>>
>> Fix it by adding a new parameter @sign to restore the original behavio=
r.
>>
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>> Fixes: ddf30cf03fb5 ("btrfs: extent-tree: Use btrfs_ref to refactor ad=
d_pinned_bytes()")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/extent-tree.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index f79e477a378e..8592d31e321c 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -757,12 +757,14 @@ static struct btrfs_space_info *__find_space_inf=
o(struct btrfs_fs_info *info,
>>  }
>> =20
>>  static void add_pinned_bytes(struct btrfs_fs_info *fs_info,
>> -			     struct btrfs_ref *ref)
>> +			     struct btrfs_ref *ref, int sign)
>=20
> This does not look like a good API, can it be done with a separate
> function like sub_pinned_bytes?
>=20

No problem, indeed sub_pinned_bytes looks much better.

Thanks,
Qu


--p6RaMgUQgNnRAKgLsYcpMXRzCHURx8Rp4--

--UkPlrOHh3VCwJooF6naj56REPCQPdYTcO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzbSncACgkQwj2R86El
/qiLeggAgxGEHN4irOMjB+eLgH/jjTkLYdPgRLPBv2huvLzfAJb47baTNqV7uaj1
yi5Drh7fcyqvVvv844xHd7GiDScPDdwfPLEAV2qM0PgD8Rfdfch1g4EE3wp1iR9j
m3imrfSoeCQ8VYUYcrZ7Tpd0C2M0/8evtMhcywDQd0XYHpuX5LDnIVn5Z3iJCJH+
AlvTUauFvRr8OaivLkLed7WyKGoTtW9COsaQ4Br9J2Odkt2e4icA8rDj0aOQtF6n
iMTFRvFC7+wkGtESeA1noyhp6cp+qINMTw++Oe276+GLLCm1uTPUToup0i2udLf+
u6nbv1DDd6FwgvqkV/hcI43957mZng==
=wsiJ
-----END PGP SIGNATURE-----

--UkPlrOHh3VCwJooF6naj56REPCQPdYTcO--
