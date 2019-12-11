Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E7311A31A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 04:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLKDjD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 22:39:03 -0500
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:47429 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbfLKDjD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 22:39:03 -0500
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2019 22:39:02 EST
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.147) BY m4a0072g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Wed, 11 Dec 2019 03:38:03 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 11 Dec 2019 03:22:55 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.124.8.14) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 11 Dec 2019 03:22:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO6CTJ9z8EDu5n6iR64mQtG+Fo/lpMdtzMuP7Tp/2bjkFByHo81HcyFCWCia8Rqg4FgcKn61r2rfj5mc+MavPKc3MCGrZttdas0P38hrh2GhydPGvATvQIfoFzYEZbvffHNZWTS3ziQKQ4E2l294+fDYM0MBS3bgUd5hSM3AZdI06QbMK7f+WJD/nFuZos2XVqs5tmxJeU4S8pmsku8RDqBs27O2Ipw/3TI/DRPTRDVcVgYNRXyVvXsTurN3mZKp5JOSigNiGyf1bAB1nmZ7hi6kyZGFNb/RhRPlJB/obR6gN++QgynRuybk/NPboQrP8YvxBfmS6uFPWbwMSakDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z85AQiEK6DztLqUx6cumEBWdGCubhFYouf563ZMuidQ=;
 b=f0XF4qJT/6UykjwKjJ17u0gWUlIVkOqE9/8/AVyNMFZxsH/30iw8DSzov2IHtKCLExtMg4bKME695w1o5DtWdVm3QOKJjRnLxD3lyOgHxxpthZvr3pZ0fPx3PbAsNQkG9Gy9hjZKeYaFgcuKxLQb2/OkXQddBud2Wl59yFjyJMRNkYZfWyBQKkxUbSmaK+rVQcl+IdXEELImWV0AHCrs2oyDspbsmfNsidfES+OCi4wgNxxGo7tzs2Ab5s7HmSrnilyXtLweIugP0lrDMG0r7Q7g+7kiwUuTbBhPGJushB/HX0pOxwXiUV1ZRlzTMscYvbS3FAtV3fExWxyYgJqLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3314.namprd18.prod.outlook.com (10.255.138.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 03:22:53 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::c9ec:d898:8be0:9f69]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::c9ec:d898:8be0:9f69%5]) with mapi id 15.20.2538.012; Wed, 11 Dec 2019
 03:22:53 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Filipe Manana <FdManana@suse.com>
Subject: Re: [PATCH] fstests: btrfs/157 btrfs/158: Prevent stripe offset to
 pollute golden output
Thread-Topic: [PATCH] fstests: btrfs/157 btrfs/158: Prevent stripe offset to
 pollute golden output
Thread-Index: AQHVr9JFs+kRTmW5Uke3Uoy5MKKNDg==
Date:   Wed, 11 Dec 2019 03:22:52 +0000
Message-ID: <010f5b0e-939a-b2be-70a2-d8670d1696ab@suse.com>
References: <20191211022207.15359-1-wqu@suse.com>
In-Reply-To: <20191211022207.15359-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYCPR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:405:3::13) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d527d2c-8c6b-4da7-5385-08d77de96800
x-ms-traffictypediagnostic: BY5PR18MB3314:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB3314B5E21542B01B41CD31FCD65A0@BY5PR18MB3314.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(478600001)(86362001)(52116002)(316002)(6506007)(31696002)(71200400001)(2616005)(36756003)(4326008)(66446008)(8676002)(6512007)(6486002)(2906002)(81166006)(64756008)(107886003)(5660300002)(26005)(66946007)(186003)(66616009)(66556008)(66476007)(31686004)(81156014)(8936002)(6916009)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3314;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: afxwMvm0Bx8GTpPZW2jhW50BEL7N+ArPAlDJ5HqpZyA1J6ifgCZlULhqKRBXyljJilHzyGaN1+zy4kbnvGu/uGvScbnKiZWGfMe7kgLgdSDAxWqVJeYMGSEcUV2xQ/qBbMUz2HE0YjCXgjpAyZMfLwKtqIJ1CCsPPt84/yCGFBA9IjYPk3BZL7ZL6QOm3wtl2mHew1/rmURciEC7k4r7rflQzuJejjXQ07q2nXjkiWO42azCBEhv4pWDaEGtY06mCwqUpyDbduFm1HINtbHTcBuBJbMEnxk6ZBXfuON+25mPFNByaw0S9043t6eznuBG1ujybPwGQFv+44Zsv2s69XgpPsQI5uOsSxUPShtQ4XQs6Q5smocLdizxGJq4y7r8hQxhreruAIusBwuZaBgb165kcWYvbsTrICWBJuWrWKBtSBPI8Vxx3UwCJqsEUlbq2Gevizv4l3VubN48Zq4BpzwaOIsq9GQKCPtsBvD23Y3vHKxouEipThV3CWRW4rvc
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="Rm0uQlJm0l2XdG7XR4K02HOHenzJ4oEgC"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d527d2c-8c6b-4da7-5385-08d77de96800
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 03:22:52.9384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rIzQea6KpO90qWFnSSbqzrQOQAKTrTxOg/QTTpklY18falCk9EmdTn+6O2Eg8Im
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3314
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Rm0uQlJm0l2XdG7XR4K02HOHenzJ4oEgC
Content-Type: multipart/mixed; boundary="bYIvY05NDoTqfgDkVqK2vxlxUpCbCfd2E"

--bYIvY05NDoTqfgDkVqK2vxlxUpCbCfd2E
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/11 =E4=B8=8A=E5=8D=8810:22, Qu Wenruo wrote:
> Test btrfs/157 and btrfs/158 are verifying the repair functionality of
> supported RAID profile, thus it needs to corrupt the fs data manually u=
sing
> physical offset of data.
>=20
> However that physical offset of data is dependent on chunk layout, whic=
h
> is further dependent on mkfs, so such physical offset is never reliable=
=2E
>=20
> And btrfs-progs commit c501c9e3b816 ("btrfs-progs: mkfs: match devid
> order to the stripe index") changed the mkfs stripe layout, the golden
> output no longer matches the output.
>=20
> This patch will remove the physical offset from golden output,
> especially since we already have those offsets output in seqres.full.
>=20
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/157     | 5 +++--
>  tests/btrfs/157.out | 4 ----
>  tests/btrfs/158     | 4 ++--
>  tests/btrfs/158.out | 4 ----
>  4 files changed, 5 insertions(+), 12 deletions(-)
>=20
> diff --git a/tests/btrfs/157 b/tests/btrfs/157
> index 7f75c407..9895f1fd 100755
> --- a/tests/btrfs/157
> +++ b/tests/btrfs/157
> @@ -90,8 +90,9 @@ dev3=3D`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
>  # step 2: corrupt the 1st and 2nd stripe (stripe 0 and 1)
>  echo "step 2......simulate bitrot at offset $stripe_0 of device_4($dev=
4) and offset $stripe_1 of device_3($dev3)" >>$seqres.full
> =20
> -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 | _filter_x=
fs_io
> -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 | _filter_x=
fs_io
> +# These stripe offset is mkfs dependent, don't pollute golden output
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 > /dev/null=

> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 > /dev/null=


Please discard this version, it doesn't take devid into consideration.

We need a more flex way to not only get physical offset from a stripe,
but also its devid.

I'll update the patch to be more flex.

Thanks,
Qu

> =20
>  # step 3: read foobar to repair the bitrot
>  echo "step 3......repair the bitrot" >> $seqres.full
> diff --git a/tests/btrfs/157.out b/tests/btrfs/157.out
> index 08d592c4..d69c0f1d 100644
> --- a/tests/btrfs/157.out
> +++ b/tests/btrfs/157.out
> @@ -1,10 +1,6 @@
>  QA output created by 157
>  wrote 131072/131072 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 9437184
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 9437184
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  0200000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
>  *
>  0400000
> diff --git a/tests/btrfs/158 b/tests/btrfs/158
> index 603e8bea..99ee7fb7 100755
> --- a/tests/btrfs/158
> +++ b/tests/btrfs/158
> @@ -82,8 +82,8 @@ dev3=3D`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
>  # step 2: corrupt the 1st and 2nd stripe (stripe 0 and 1)
>  echo "step 2......simulate bitrot at offset $stripe_0 of device_4($dev=
4) and offset $stripe_1 of device_3($dev3)" >>$seqres.full
> =20
> -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 | _filter_x=
fs_io
> -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 | _filter_x=
fs_io
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 > /dev/null=

> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 > /dev/null=

> =20
>  # step 3: scrub filesystem to repair the bitrot
>  echo "step 3......repair the bitrot" >> $seqres.full
> diff --git a/tests/btrfs/158.out b/tests/btrfs/158.out
> index 1f5ad3f7..95562f49 100644
> --- a/tests/btrfs/158.out
> +++ b/tests/btrfs/158.out
> @@ -1,10 +1,6 @@
>  QA output created by 158
>  wrote 131072/131072 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 9437184
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 65536/65536 bytes at offset 9437184
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  0000000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
>  *
>  0400000
>=20


--bYIvY05NDoTqfgDkVqK2vxlxUpCbCfd2E--

--Rm0uQlJm0l2XdG7XR4K02HOHenzJ4oEgC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3wYP0ACgkQwj2R86El
/qjFLAgApD4QGAZp05mIgojFUHpVJ3G0JzGpjXMtwiA8AwH4rwWwXnG960iI79V0
UfZHAUDvmM8RUxt0x9mgUr6FIebrgjfWjDKYIZbJeOfimN9WqWEhiF4mFntwoCPF
XMH+dOcekB5dIRVGxBBsRUuwjv2mQfwOPrPErhhEU8AAKonan7c5wwtA16t8Xcau
8pZlOHlZko0J8Nz/NJyyrWw6tTLNjy2fipzZwmzWYmBvikX1cq3w1GneqA8xu7rw
dBuThVj2ndkP19l8vA/i1FLsjQqJ/XVtzU9SQ2q57Bk3UF4/BJJ6ATA8m+8hx+1C
6ClJEpUee/ZqgFuQnD0vPWIwdYcVIA==
=nxyv
-----END PGP SIGNATURE-----

--Rm0uQlJm0l2XdG7XR4K02HOHenzJ4oEgC--
