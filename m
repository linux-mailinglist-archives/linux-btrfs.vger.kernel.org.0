Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9AA328DB
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 08:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfFCGxR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 02:53:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:59495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfFCGxR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 02:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559544787;
        bh=sdw1sLuzm/K/O2lyCPElh7zPXQSnKfVQtjW7A5Qew+Y=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EcWFNAHVyG2ViR5qAZ2916sPhK88cdWjvAjzXZc5CsI2bCzO6B5EmZlPgZeGz1g7/
         UPkKANc11gevoqAgPL+rDykq4VXhNxJprIkfUePs9fAt9LRPNZ4Lrsnm/RoxIPhGCP
         R0ynBVukgZTrg21FXiCFBr/4JAT21WPEnu3XsnLk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2Dx8-1gZa9P1R6M-013doj; Mon, 03
 Jun 2019 08:53:07 +0200
Subject: Re: [PATCH] btrfs: don't end the transaction for delayed refs in
 throttle
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190124143143.8838-1-josef@toxicpanda.com>
 <20190212160351.GD2900@twin.jikos.cz>
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
Message-ID: <d10925d5-e036-379b-f68f-bf0f8fa1a5b9@gmx.com>
Date:   Mon, 3 Jun 2019 14:53:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190212160351.GD2900@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AJI4D1j3bnbCKKygAvw1JjIu7FyYoD1GK"
X-Provags-ID: V03:K1:oFyamZe1kBTT0gdFDZ8o5tAHdqZcdv533ziREn99c0t5DprlMYz
 Bx+aXpF+e1nrF8lPbTYIRBG/pe99SjWgezlQob8rtG6zhfMM8k4caOq1keksXQv6hVbm/Bn
 N6R970txFjQtd+srIvE4jWz9LJmacnLWfgai40F/F37F0Fa9g+KCsJduWYE+CSoktKsR6A9
 40YRjFrXgJyMBTDkKot3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wTln/D/2efQ=:yW6dPeX9JKtBj60xFyeIM4
 CsE5cVBU/o2SrNs9pKq7CT7I9EsOv0ppLpXjABQ+g5fabFvs6DDqKQ2mKCVjWXLBnkSdgZ+nI
 /0a///Vf7WHQBHtPMrZpn/gwyEZR6SL8ViARHLNr5+fesR6ZcZeJkvuEV1alp2tvZTAKnrpIe
 3cjZufBfKRtIXCm0yv8DEMKVrXAJPIR0V29PKpTpoT80Mu0CqE470FNwibcCyhSy6HtQla+7y
 ruLtK9SgYLSU/WfhQhtxrY1nnRVCEBrbMwZPvbdVRqd6FhskRJTD7UKf5cRWcMUIRP5svCpzb
 9vaSaNYF45P5blcDLOxUuFgR9KETFPkTkz3J5ZCEwYnN4KXW/nGs6t0cI16Dq4qVsZ+08EweG
 4CiHO3QYUXcUTHW5qg1WIX7erS01v246MqkdWkHbfelWcrR3VreheJ4k7N0cGXpuBRUaopdzM
 KnS5xv06HMiR3H0Q/aPhJYs4Kahm07zK6LK1H+tePDCjOlOgZaz/un7Bg/rTeMnnkopTatVtZ
 SOzWgqyvb7tb6k9vaX2iHnzTihAoP3fdESUqAy76kMUH14ZjZmIW43JbXH7QisnX6zQS05Vux
 LAl0YUVztXA7R/AoJgdDuobhjK3lqzigbOcwBTq0e/0CriyG+na82cXLc925F66pE/M+uW+La
 KlhA1pZCGmtq30TDbNhs4yds93vtnTYBnV/KTP4Pk725pKw+rQuetQZA78oIvGa05bBr6f21x
 idsgLma6MrQtv2P3llIU+n62go68cOxJFgYbHL1o2YYdb+QrmU0IgvVahXgjATNtG4T9xtcMo
 OctGPX+yCqqV8sPtiC9Z4ap/oTKqGnJdH3UiFay3OJv70As4Rc4zL6t+LAspYdTha4FXibUIl
 ODCwmDyBzjBtlKQU7CboDyFQsIh1t4ht/sZf6YDkupih+23MQl998fXUkjtcIbjg9wXgQUI7t
 ZwlpbhJEawJdjDYoKs0tBo5227wvHI5c=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AJI4D1j3bnbCKKygAvw1JjIu7FyYoD1GK
Content-Type: multipart/mixed; boundary="oMTVu5Eip6Ncb6a5LSloskPOQ3W4A7DmE";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
 linux-btrfs@vger.kernel.org, kernel-team@fb.com
Message-ID: <d10925d5-e036-379b-f68f-bf0f8fa1a5b9@gmx.com>
Subject: Re: [PATCH] btrfs: don't end the transaction for delayed refs in
 throttle
References: <20190124143143.8838-1-josef@toxicpanda.com>
 <20190212160351.GD2900@twin.jikos.cz>
In-Reply-To: <20190212160351.GD2900@twin.jikos.cz>

--oMTVu5Eip6Ncb6a5LSloskPOQ3W4A7DmE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/2/13 =E4=B8=8A=E5=8D=8812:03, David Sterba wrote:
> On Thu, Jan 24, 2019 at 09:31:43AM -0500, Josef Bacik wrote:
>> Previously callers to btrfs_end_transaction_throttle() would commit th=
e
>> transaction if there wasn't enough delayed refs space.  This happens i=
n
>> relocation, and if the fs is relatively empty we'll run out of delayed=

>> refs space basically immediately, so we'll just be stuck in this loop =
of
>> committing the transaction over and over again.
>>
>> This code existed because we didn't have a good feedback mechanism for=

>> running delayed refs, but with the delayed refs rsv we do now.  Delete=

>> this throttling code and let the btrfs_start_transaction() in relocati=
on
>> deal with putting pressure on the delayed refs infrastructure.  With
>> this patch we no longer take 5 minutes to balance a metadata only fs.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>=20
> For the record, this has been merged to 5.0-rc5
>=20

Bisecting leads me to this patch for strange balance ENOSPC.

Can be reproduced by btrfs/156, or the following small script:
------
#!/bin/bash
dev=3D"/dev/test/test"
mnt=3D"/mnt/btrfs"

_fail()
{
	echo "!!! FAILED: $@ !!!"
	exit 1
}

do_work()
{
	umount $dev &> /dev/null
	umount $mnt &> /dev/null

	mkfs.btrfs -b 1G -m single -d single $dev -f > /dev/null

	mount $dev $mnt

	for i in $(seq -w 0 511); do
	#	xfs_io -f -c "falloc 0 1m" $mnt/file_$i > /dev/null
		xfs_io -f -c "pwrite 0 1m" $mnt/inline_$i > /dev/null
	done
	sync

	btrfs balance start --full $mnt || return 1
	sync


	btrfs balance start --full $mnt || return 1
	umount $mnt
}

failed=3D0
for i in $(seq -w 0 24); do
	echo "=3D=3D=3D run $i =3D=3D=3D"
	do_work
	if [ $? -eq 1 ]; then
		failed=3D$(($failed + 1))
	fi
done
if [ $failed -ne 0 ]; then
	echo "!!! failed $failed/25 !!!"
else
	echo "=3D=3D=3D all passes =3D=3D=3D"
fi
------

For v4.20, it will fail at the rate around 0/25 ~ 2/25 (very rare).
But at that patch (upstream commit
302167c50b32e7fccc98994a91d40ddbbab04e52), the failure rate raise to 25/2=
5.

Any idea for that ENOSPC problem?
As it looks really wired for the 2nd full balance to fail even we have
enough unallocated space.

Thanks,
Qu


--oMTVu5Eip6Ncb6a5LSloskPOQ3W4A7DmE--

--AJI4D1j3bnbCKKygAvw1JjIu7FyYoD1GK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlz0w8wACgkQwj2R86El
/qhJDAgAh23SIN/EU2c/8g+MG4E1swKsi+WfB3xiR6XSPqXGV5JcTtVlCzLSg2wC
RaxhOD4lz0k3iUHPu6g1YTnOH6bM30WehXNjOkyATBo2vXFJc7A2/PGumxN4MU7m
m8n4LISXCC9A3I+j8dbV586vinP4Yhg0KYyk+6GrWDyVlueNICVyBsU597YjRttM
uAGJvTidbPtAJtIU4vi+Rq/jd5t4DgOUqvfOTAs5BeJIqGKzx6R6fZKD4rI1hroD
dXpy2c4yRkrh0qbdNJlvSzVEPaM0RGHyEpZRjTjYAK/x5bJR3lLmmZ+/mCXCNHHC
t+NsRzThtBZEmw0w9misa4pGO1vzPw==
=8tfx
-----END PGP SIGNATURE-----

--AJI4D1j3bnbCKKygAvw1JjIu7FyYoD1GK--
