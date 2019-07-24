Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C3E72E12
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 13:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfGXLsL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 07:48:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:48359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfGXLsK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 07:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563968863;
        bh=WcLHtPTnD1jjDzD++oBJaGRriBYO/gmNf9woe7Rjt8E=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=J4jpfhzH4ThYKbyd6nGiX9z4Dga2tLFDb9jb1DNh0t15AjH83YSoRbZOXJgRr1yTB
         M3zh6M1WIK+Aqs6/g6h+1Fx+Chc/5546wm9jWVlRupzaUj3EkGQmksTT4kJoZxAY0q
         Y46MjGvduLT3BfTcktexGq4DUMWQar+izk4fDFWA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5wPh-1hkVNN0Zy7-007X4n; Wed, 24
 Jul 2019 13:47:43 +0200
Subject: Re: [PATCH] btrfs-progs: misc-test/034: Avoid debug log populating
 stdout
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190724050705.29313-1-wqu@suse.com>
 <20190724105228.GH2868@twin.jikos.cz>
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
Message-ID: <5d20c4d5-17c0-a40c-f762-e8f35a3cf598@gmx.com>
Date:   Wed, 24 Jul 2019 19:47:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724105228.GH2868@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X295WmQ3C4TJLa4nRAxvOCTT3HH7qJpDy"
X-Provags-ID: V03:K1:PGo04aXSEv4cBsSsKs7INckiXZbzuyRJxXLd9pyI4J9O0JV9oCU
 eEkTnk9d9VizzBcA59bc2LJgkmwC4P927egQ14WHjWWw7qxPsEl/BYCykVPnxdX/3t5zN6P
 C43Kvg7FH8RYIMbIMN6gDybuCQIDCSpRIYWsH+0nUFtrmro9+gPqhf4cRMurZL+HNjYcP1W
 Q4uz3rS3T9UhqahYLKQJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jGrVTs5Fz9A=:FFMk+OgaIsNvPNz3Hx06t0
 HhoNXUm1hy+snURiCoJHwriofopkH4SlXS6o88nQUXUXsOZ+3ILSUPs4BZ3QtAioTNUPE3Hel
 AE4SpHcSVrP86K4JBzm+M8bOI3phOR+ne/EYEZ3EO1W0XjZGP8fQSmJoEUINpwdqCYlQV6aGK
 HZhPmvhXFx0ibKAFX/qu9nfv18IYL8m6o7DNRz+i6Z8vz4Cl1chPLWdSa2cF0DATWs4V13Zyl
 21EShEgUynXUIhErUBuTcRxZEPrbIxWAgomiVXA6yqNK1siL4FxW5lf0xxviwNULZuB8zpAQz
 A+mxCutEEgSaUsYsYx1ll0RNaOSmSQDd3L3aCfOH0R+v12aptbALPFNo1LY61UKJHCzWd2Vk7
 vbXxjsIOY9Omk4YOUlWJ4x+1T+ZI4kmVIg21p1kyNOMd1yZw7fwaJ1hBWWSoBTx0PSxVqzJx7
 znoYzWKizXnGrLoXDSCgSep6kULSy1HmuvS7wLVTPCnmADoxhG1R57GX1fb5s7fSQGDK23+Ke
 Yk86OKVTg0hnCU2NB+yJ5g2CzKIepVDnOWGfDkwH24ctsNpA/cEmKv3KkPkb3qUYu1ki7gt4C
 Gj48Zi2S3Os3B5BUEKfIq8AVzUnSAN8z2GlJbNSEmSKfOs2CMy8DgembIObsTv2/hUYIJ5O/0
 YgTqvHbFZHjIPwSltXecCKpu6F/m3D9V5LS38mz3nAuQxhD6SupGXkvNpy4H3MGwj2uQ30B3F
 PB/Ue7LFofAq4klCbZZcJadJX93UVBETnYntk46xyngItsEEe42VyHYpJrPD1dxyNmK09aIsV
 NRKDJAuIDvoJZiwd1eNtKQWXguQsvWQY371BmOPwgUUkk5GUO+ZiLb7e6FFDwqYLktF8k9n3k
 o0Pg15Q3SR+JMvkym4qmBgIzfriRJjRlV+fFUgTcxOiJeQtB7HzW9NE09LnR11ysjbvXBOh3o
 5Y/jLxQeah3cR6smhmbqp3rRZ3KJ+H3xxgfB1tIu6A5tqkUXwVDxNbpihTOHqkCtuYGPRjV8a
 ZkHXYLPCDXNfP9MkC0+3/RJa/vLKf4IEwBlzXh6hFtDsFLnb+UAw8h24Mk8p4zHsdiRduIaPa
 k1BQ/KyYUae+eE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X295WmQ3C4TJLa4nRAxvOCTT3HH7qJpDy
Content-Type: multipart/mixed; boundary="59ABZfm9sF9KNp1ZCmRICD5lh3LzYdypV";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <5d20c4d5-17c0-a40c-f762-e8f35a3cf598@gmx.com>
Subject: Re: [PATCH] btrfs-progs: misc-test/034: Avoid debug log populating
 stdout
References: <20190724050705.29313-1-wqu@suse.com>
 <20190724105228.GH2868@twin.jikos.cz>
In-Reply-To: <20190724105228.GH2868@twin.jikos.cz>

--59ABZfm9sF9KNp1ZCmRICD5lh3LzYdypV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/24 =E4=B8=8B=E5=8D=886:52, David Sterba wrote:
> On Wed, Jul 24, 2019 at 01:07:05PM +0800, Qu Wenruo wrote:
>> When running misc-test/034, we got unexpected log output:
>>       [TEST/misc]   033-filename-length-limit
>>       [TEST/misc]   034-metadata-uuid
>>   Checking btrfstune logic
>>   Checking dump-super output
>>   Checking output after fsid change
>>   Checking for incompat textual representation
>>   Checking setting fsid back to original
>>   Testing btrfs-image restore
>>
>> This is caused by commit 2570cff076b1 ("btrfs-progs: test: cleanup mis=
c-tests/034")
>> which uses _log facility which also populates stdout.
>>
>> Revert to echo "$*" >> "$RESULTS" to remove the noise.
>=20
> Yes to remove the noise but the idea was to avoid manual redirections t=
o
> $RESULTS, so we need a new helper or adjust _log.
>=20

OK, I'll change _log to avoid populating stdout.

BTW, the reason I didn't change _log is at commit e547fdb16667
("btrfs-progs: tests, add more common helpers") it's using _log in
_run_mayfail(), but now it's not.

So some commits are doing conflicting modification during that cleanup.

Thanks,
Qu


--59ABZfm9sF9KNp1ZCmRICD5lh3LzYdypV--

--X295WmQ3C4TJLa4nRAxvOCTT3HH7qJpDy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl04RVUACgkQwj2R86El
/qgD8AgAqhyvya+h99P3gSpmUog8J24GSZJsn3uFYoOjdMmAwMIKMIVdkWVkyQST
GuWO/oT8dCo6T45eoGj0Sez3Q6KmIEPAJ86fbb/v1Le7u4X1JcDggj60mIWpqZyd
/gaqgWkAMuQRmJE/ps3J6BHgylXh8//EB9FFA+N0ouZg7TPQvhKpcv2e929YBIg0
9tj8+lK1kQeeyNzdcCXIkeTtzCRsSpCMm0U5Ay0WaM56xqD51utM15fsisiPecJT
CM8v8vg7kv5fzsVTXXMtAVoun1iL1yHvjoXhfznedPY7AJ2JR3eJevzwckTqxbXw
xKnswH4Y4hjG9FZTqkVLQfq878/6nw==
=W4jf
-----END PGP SIGNATURE-----

--X295WmQ3C4TJLa4nRAxvOCTT3HH7qJpDy--
