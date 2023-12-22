Return-Path: <linux-btrfs+bounces-1123-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFEC81C4D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 07:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C26428424D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 06:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB95663C2;
	Fri, 22 Dec 2023 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NfgifEVh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L9VcuLWr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B86124;
	Fri, 22 Dec 2023 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1703224966; x=1734760966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KaqmF+dJiEbTXm8rDGee7E1riWNChoRcIuafl/rZSqY=;
  b=NfgifEVhCTJusPQnefCn/AIlH0lcfP+pfHo1bE0puDU4Yd4o7yqYDgfj
   0CUhCHfumkYdB6k5w27+cha//OQZSCwLJ3qzGWeTVLq5U2P7qOJg9Wrsp
   oFBC7R+SgY1CzbYEQwyToDoROWiCoO69sprX7gdDpdmYnAMGJDUysPFi8
   stuQMg0KGhogLB17ukEkFl7cMsLwpN7/Mvi8pr8Dclr7xD1pECYALgiLf
   BuzHcS9Ck1g+4DxmclDKf8K5SfSlAEEIno4pi0quvmEyMLZjqkZxKM1BB
   sAfnWnpXhRGryOWUMWi8Ba38vLSofK/e8fQBaHCvjXBlH89EASFAoB6h2
   Q==;
X-CSE-ConnectionGUID: 6yDnw4+kTh2W42aorvSb7g==
X-CSE-MsgGUID: Yt9zafs/Qui97oA8rfx0Jw==
X-IronPort-AV: E=Sophos;i="6.04,294,1695657600"; 
   d="scan'208";a="5652305"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2023 14:02:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCdM0bTh3ZaT77Dq4kLNmQ84D8apP8TXbA50oJTSTFeC3GyA7VwPzel7NCNaorEkoZEjYFxZSJ7nTc2ZwBBE9m4/YP1JeYc7wbEpsCvTwHMKrTedlmmOAIv/7tnkGAd1GnjDAXQ/Nl7ToWr4GE2omk4MNqddB/1SJJEvglQraN5bZeZzRsBbFL/ila0RYxEWeqQ7kWGi2JI9WL9qQp0xokaVDPes/tFhZ3NqvLMRlKpC0Uk95B80+JFCZHRF7aYosO4AQu+/H3eZCRq+o9hXm4SIMxYV360drU/te8Zq8rVPHeCFzMCw6+ucxtC+ZhRDwZsR8baHMawNDOuBF1qudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TuILdzaXj6D8zv3sKtILYnt5xH7oBnBTQx/Hiqq80Y=;
 b=ge3dEGqL+f72sRIe/M5krghWkw9PFjm7xRgrBgT4ChYlIsiQUKV2V6nKGebSDfGblyNnpYQOPkRG+HFHvQNMqGhTt/LT54DeMLxq2S4aUd7zfAaHfbPPS+uxFbLVh5bMQnyb+vnXsngIze3SpHLtm8mVTAwUOFoGI3l/2J9xdCccFM9ljU3F3ZrS7U+vR/AcVduW4BbjFXsfQ8AsVrPYapTVAVy848UMmXpbAqzJPvhN/DlDHm9TVgz5r6Ok4jFhSkIaAzsFCiFjeh04khHW99HYUMoiMRtBAbN+nTjdfZ/QUzg4T7wAF2wTmxzaLipy4hzpzn6JQJ2+foprKNZ/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TuILdzaXj6D8zv3sKtILYnt5xH7oBnBTQx/Hiqq80Y=;
 b=L9VcuLWrH7xPchAxrF9GUrku5Zw9V8RbKFWZrDX7MyB+H98a+kHRms0pi4t6V/d1DExEYyqh0XF0JqXTnCeIyq7tI6aySmUvMmp8gOY8M5YbRiOiBM3TjOZfdHhm/3DBW+pYwBpYLjAroOHKQfCDaTR+dFU1cCSPPl356aDwfbs=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7197.namprd04.prod.outlook.com (2603:10b6:a03:291::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 06:02:42 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9511:64b5:654e:7a8a]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9511:64b5:654e:7a8a%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 06:02:41 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Disseldorp <ddiss@suse.de>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] fstests: btrfs: use proper filter for subvolume deletion
Thread-Topic: [PATCH] fstests: btrfs: use proper filter for subvolume deletion
Thread-Index: AQHaNIJ8tkSkMhKhxEeyB3JNeHh04LC0wH0AgAAPbgA=
Date: Fri, 22 Dec 2023 06:02:41 +0000
Message-ID: <zc6nx5hyhpticuwhcjiahbp67sjteqqehfhnrpk4kwvhyrwmq4@lf6uhzx6nst3>
References:
 <727fc0e695846a43830bdfc2d6757d6edc2d6878.1703213691.git.naohiro.aota@wdc.com>
 <20231222160726.7206676f@echidna>
In-Reply-To: <20231222160726.7206676f@echidna>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB7197:EE_
x-ms-office365-filtering-correlation-id: b8f87dbb-1527-43b0-6602-08dc02b39bfd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 damVAmzJH0kOosrkAMzagZa/H8b/uiF53f2F8mqJQowXfW9cWlEdt3g1eBFfzduh3ic/jpuRRn2K9Cpu43GlqzBdylwcWikUjBPC2M6/8KCy0g1VV7JCtCybmfmi4MW7TDbU2AJ33qzBikO6FdnAhrYWdFL32XT7QSLhTyDzZrzsQrh7H6wF5wc+IWb3ZGRKNrrN1s3/OzpAaLTma81qErHgGN+105HvOKZRSB7pLUu1XqS/3atDkMBItN62Hnu5BWyxekLHrFf7GsvZkRhLK8Xyo2Q9J4snCJQQpOtFkvqditg30DgZF7FtbhUXo3sIJB9bnRHls/Q3F/UEV4gcGEoloHVvX3kuxJ9kictePHZbS0PHp6U/naEiJQFCpvSKzSOGkGY8QdEseoYcH1h/3zXkaXyTL7IxPfnTcGdZwRVuorsvurJXlRZhFsvx0L871yp3GE+kSIFqxJ+1Y7FoolCbPCedW92d6//5lCUkVVy4b+gKIF3HluZTMDEeTXi2HACposFTJ3sieE3Dk7LTBRux5sIMIjBKO+VT85q6mcXuWPm71tWN1AYTkouPjzunMOdvkl0sUdKE8v8xtsxUefSqBHfeiLFl+OEJkHZkvMjwsc2iJNBmTN3rtDYp5q5K
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(26005)(41300700001)(38100700002)(71200400001)(33716001)(122000001)(66476007)(66446008)(54906003)(64756008)(6916009)(316002)(4001150100001)(2906002)(5660300002)(8676002)(66556008)(8936002)(4326008)(9686003)(6506007)(6512007)(76116006)(91956017)(66946007)(478600001)(6486002)(82960400001)(86362001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?62Ib1ZZ7ermFXqxg3zptwimDU4bcLa9fnRrV1h++/LKP2vuRPX6LaK4xg7in?=
 =?us-ascii?Q?3jTtsci/BoTf38Aw8iMddz5IkidBkDvjkgq5DjiSNi9Q2wGGbd5lBREod0fi?=
 =?us-ascii?Q?EJr1aA7/WO6JW0xXhPJguis+p++sBsMqlHviDAN0YIUXjFmh0Y0sNet3ShM3?=
 =?us-ascii?Q?LJ2k22uZj44SzQ5fBzmGjg+hN3Oghreia5L4jD27BOwz/fJUQJYF08/WngnP?=
 =?us-ascii?Q?bAG9Gi+V2bVT14wwi4L2ANxtx+t2pwz/hXxjMEh3P+k9fg4eggqeOBT+wJ3w?=
 =?us-ascii?Q?LeyqAXWmgzENexOW8cxXtShpyG+m2cUjJ8FLZvMTeW40KgBEQJv/hHdeDu0O?=
 =?us-ascii?Q?S0E7tWtm4MpKDnPSht/HbKtlZuLQFyXraHXZG7g+1JUQq2kVkFDLTg8TVx5U?=
 =?us-ascii?Q?rWk5nuwZbWWrUMN2fKzl6ESUtt8PAONReCLqjAZB0UOA0qrzYMlXoreRhXsL?=
 =?us-ascii?Q?nlXIH1pVvRVyhUYrGgSM4ldmbw5xsCvChpmnyEFRpcccBQWdSJ6hWU6wBaIO?=
 =?us-ascii?Q?wSxhQE4Y7mhF2Ytx6DcxZlJH/lbDjg0c63VRmyErlHg6zgAAmWvB4Yz1IKuQ?=
 =?us-ascii?Q?imh8jltYjSd7/qck7rlsY8KkhlcGGYP7Lr1UIEHgoR36oV20G9RMCDyS7Bfa?=
 =?us-ascii?Q?9g3Jrls7XOANNjBg8KFemBqDJfyLLTkWPYswLh35DtzGAAlXL6BxGQwiXQc3?=
 =?us-ascii?Q?6wW7W42WCtWOYfcVFPpgmvvP9L7XbaHsrDG7tyqbe9uYtjEajCoO+S1mOgKp?=
 =?us-ascii?Q?U1g4ww+K9zIQvvZPul7SVTY5VK2UafMzsCCaQYFZeV953Lv0k451fw5MXtYW?=
 =?us-ascii?Q?ijHaMV71uvU/CZCVIPhCVNwBTAunN1VSQHrWCfubS+1FAmzT/TTEnK4eVGZL?=
 =?us-ascii?Q?xzeqPEPFmPkqYxY2rZdIdpKI+RhpMzQv5Dzym0vmowpx+R30Es6X/WykxFwe?=
 =?us-ascii?Q?JNY7GG4YZP1GTW69OKEe32UeBit+8vevb0gvJ1nEqcICSEWSGPx/SH77F56P?=
 =?us-ascii?Q?IwwU7XLtbPHtOuMleW40t4aeAK+5G6SjcAZZxVm6549W4L+JL7TxPcndQG6p?=
 =?us-ascii?Q?lOKByzyuT1xgkWAdfZernc8Q6TxsNhWmA8s1hGbokuu6QzmD/LnipMtx0Rg4?=
 =?us-ascii?Q?g9YN9LmKl7tjvVXRzF+e++i1ApS45o3wmL1vsWtVihNgLwjvivHPjGL0EB7I?=
 =?us-ascii?Q?LtBAzY3qImby5/63E5IJUiGREVrrPrDyKkeRXxFtg74UvaInaQ0bXvM1Uw7s?=
 =?us-ascii?Q?A/UAtFFJ17BqRyp1/aR+ytmVBoDfNZZkiZzXFBy51QO+mr+6TDoOn87fTaR8?=
 =?us-ascii?Q?fA5N+cOm4pZlpXrPNDfkmdKexZ3J2ECrvMVgqHgAOk1TqzlbyMfcq117XNp3?=
 =?us-ascii?Q?IJnQdKRPDQmNn+Mh/cGP+oqwOdIMH2rrEaJbKf25rcsL6WG4QMM/Lkc60gfN?=
 =?us-ascii?Q?K42ui2K/7eKvLRjrn8Cigk8ucEurF3YBcRGTkUe5IMFqcuIbTeIFcRe/I6pl?=
 =?us-ascii?Q?5QrVKKRjujfuMP892HAflHpKpDGC4T2O9ZOwO8N4FIfXNEtyVge37x82jtgF?=
 =?us-ascii?Q?Y831hCz1Bk13sjzRwREu4NIirzNS0svVs8d/EsmM92ZNDartkaCKw6AGDZBx?=
 =?us-ascii?Q?PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5B2DDE04BF526943B906E6741B68969A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EEL4EdwxIw31prSwnFbp4bnMqwQecH6daY/CxP6jl43y4LVHhzmo11n2Cm2x2U7XNlHvVf6IRAvWO+WsZNfNBtXQiUNXNAJf4Yjb9qcvpAdHJonVkJmTNOPNm/jyuzBvk+svOyVHPh1YR7ntoHGBAD3dZkJYPODeHp/4TcU78P0bRzDOBbREwYXLxLhx8RQ0N97siEoi0o867bAwgseJwYFOJlNdxhD/UahYXMRhhiBURapmojEcuki9W3seoGqAqM7GjsDTVpwQFhpTCjWSidFxUxbRWFcM3pAZ0aiHV0Gr2iGb0jwQN+kCXNOxKWECl/pBLvY/qCFUUoDVnCa2U+X/U5xvvqywDWJsym11d03JfZ/i4Z6l3n1R11tULjUVMwGNBKlTIlspZYJsPyLm9Rjh84RGYKl7Jp/JTXNb/iqkgazlOEZtoxOqtB9bO5jLOuHSjs8n0vev0rnXbA33bBQeG0B2pcPe6SHAefRmayIejDBD2YUiKZa8Hpyke6uEy1mCviSJiG1RIF5uhd8a1WIZcLoqkQgEoCnqTuc2chKLDixzsatCNIRuZRbEpcBgP4XJ5wNtQ2L2ovULjCaNC0owwsLvMMZW29Pl1wYw5SBe4WKGumxE/g9YlKMZO5by
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f87dbb-1527-43b0-6602-08dc02b39bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 06:02:41.8827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9o7PR43u6yvHoXOvAkJ1T09SCxDLMxXFQ8DK05vF/Yn7CJ5IGMYKVmrb6I8SZRB7CT0LhxsVf5quePOGEbNcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7197

On Fri, Dec 22, 2023 at 04:07:26PM +1100, David Disseldorp wrote:
> On Fri, 22 Dec 2023 11:56:22 +0900, Naohiro Aota wrote:
>=20
> > Test cases btrfs/208, 233, 276 does not use _filter_btrfs_subvol_delete=
()
> > to process "btrfs subvolume delete" command's output. So, the following
> > diff occurs even with a previous fix.
> >=20
> > btrfs/208       - output mismatch (see /host/btrfs/208.out.bad)
> >     --- tests/btrfs/208.out     2023-12-22 02:09:18.000000000 +0000
> >     +++ /host/btrfs/208.out.bad 2023-12-22 02:21:40.697036486 +0000
> >     @@ -6,12 +6,12 @@
> >      subvol1
> >      subvol2
> >      subvol3
> >     -Delete subvolume (no-commit): 'SCRATCH_MNT/subvol1'
> >     +Delete subvolume 256 (no-commit): 'SCRATCH_MNT/subvol1'
> >      After deleting one subvolume:
> >      subvol2
> >     ...
> >=20
> > Let them use the filter and fix the output accordingly.
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>=20
> Looks fine.
> Reviewed-by: David Disseldorp <ddiss@suse.de>
> One minor nit...
>=20
> > ---
> >  tests/btrfs/208     | 2 +-
> >  tests/btrfs/208.out | 6 +++---
> >  tests/btrfs/233     | 3 ++-
> >  tests/btrfs/233.out | 4 ++--
> >  tests/btrfs/276     | 3 ++-
> >  tests/btrfs/276.out | 2 +-
> >  6 files changed, 11 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/tests/btrfs/208 b/tests/btrfs/208
> > index 909f9fa40803..d58803e2f801 100755
> > --- a/tests/btrfs/208
> > +++ b/tests/btrfs/208
> > @@ -28,7 +28,7 @@ _delete_and_list()
> >  	local msg=3D"$2"
> > =20
> >  	SUBVOLID=3D$(_btrfs_get_subvolid $SCRATCH_MNT "$subvol_name")
> > -	$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT |=
 _filter_scratch
> > +	$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT |=
 _filter_btrfs_subvol_delete
> > =20
> >  	echo "$msg"
> >  	$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF=
 }'
> > diff --git a/tests/btrfs/208.out b/tests/btrfs/208.out
> > index 9b660699a4b2..dc5761ba1c87 100644
> > --- a/tests/btrfs/208.out
> > +++ b/tests/btrfs/208.out
> > @@ -6,12 +6,12 @@ Current subvolume ids:
> >  subvol1
> >  subvol2
> >  subvol3
> > -Delete subvolume (no-commit): 'SCRATCH_MNT/subvol1'
> > +Delete subvolume 'SCRATCH_MNT/subvol1'
> >  After deleting one subvolume:
> >  subvol2
> >  subvol3
> > -Delete subvolume (no-commit): 'SCRATCH_MNT/subvol3'
> > +Delete subvolume 'SCRATCH_MNT/subvol3'
> >  Last remaining subvolume:
> >  subvol2
> > -Delete subvolume (no-commit): 'SCRATCH_MNT/subvol2'
> > +Delete subvolume 'SCRATCH_MNT/subvol2'
> >  All subvolumes removed.
> > diff --git a/tests/btrfs/233 b/tests/btrfs/233
> > index 2b94a9c6befe..f2c1eba090be 100755
> > --- a/tests/btrfs/233
> > +++ b/tests/btrfs/233
> > @@ -21,6 +21,7 @@ _cleanup()
> > =20
> >  # Import common functions.
> >  . ./common/filter
> > +. ./common/filter.btrfs
>=20
> common/filter.btrfs sources common/filter, so you can replace these.

Oh, I didn't notice that. But, there are many test cases importing
both. Maybe, it's good to express direct dependency (e.g, for
_filter_scratch) explicitly? Or, they should be fixed as well?

$ grep -E 'filter$' $(grep -lr filter.btrfs tests|sort)     =20
tests/btrfs/001:. ./common/filter
tests/btrfs/035:. ./common/filter
tests/btrfs/048:. ./common/filter
tests/btrfs/059:. ./common/filter
tests/btrfs/089:. ./common/filter
tests/btrfs/096:. ./common/filter
tests/btrfs/100:. ./common/filter
tests/btrfs/101:. ./common/filter
tests/btrfs/112:. ./common/filter
tests/btrfs/113:. ./common/filter
tests/btrfs/162:. ./common/filter
tests/btrfs/163:. ./common/filter
tests/btrfs/171:. ./common/filter
tests/btrfs/197:. ./common/filter
tests/btrfs/198:. ./common/filter
tests/btrfs/208:. ./common/filter
tests/btrfs/218:. ./common/filter
tests/btrfs/233:. ./common/filter
tests/btrfs/254:. ./common/filter
tests/btrfs/276:. ./common/filter=

