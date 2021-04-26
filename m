Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB14136AECA
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 09:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhDZHrI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 03:47:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47954 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhDZHqG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 03:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619423124; x=1650959124;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1YaPVyibUcojz7ar5w9FPsAy4Ez/4OJ/jB4zTaBcXxw=;
  b=HaA9YrDd0VuqX3HU8UjznJBPCohcpY8kZBQLxLw4IOy4um8KdIIZfEJU
   jVBFcGUnY/ohRejo79UL29SZAkUVRpYDIx6WGrXFigR6gl93ytFFTNuKJ
   /vgEuk936vOlA2AtomEIV+TsUm7ac97cDxX7VujgGHjkiG+Kn/CumB6MX
   NO/sklvGHfeKO/dDhQJgKdO0H2DeEbmOe/BsZi/9RpeB6QZvatdWUrSqW
   CT1uOCHsSXwkvht58s3mCFIvQQ5py2tea3ZJeXQtWNthJ5d/sKBL5BYLE
   pIpVpuSB1F3oKqZUUV/O0Lz5o/jn3lKUdfpNMgZcvU018Wzqo0RDHQ6Wj
   Q==;
IronPort-SDR: dbaJf0I44ar3Y72iKtskEJWkCEp27kac9+MIBvw0rvaIpf+fB/d07SGRab0QKElgibbe8IfZXN
 ZrqUgP6Ft0EufSapWsHa+d+XCSutel5aIAxZHl2T2oPhX+rQT45gR7Oo53M4Wjp36+/jqNbYIz
 056B8VKKDf3cXEvt+gLEJ3e5mg45H5Pc71iiIRlir4Tfdf79WW38fvXhd6+DNI2gqYBI2VJFwB
 W3abEMSLkr8lxJfzu/pnZgIusIYXQxraPUbHxaSccEB9/8F4QFpn7J5dpPE/GTZ75xkYOc1eDe
 KCY=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170793362"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 15:45:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUSjOZS7AZXsHpP5IiNqR6uhyeYH+sp7j6BhCfimIRQH74SPBHPX+O81XleZ9RX2bj5ZTIVRX4Xfrh0D8gXnLZejZ6ZKrTXrbDzENyxqSfdI8j4mXbxFerTGiw2Rh7IrkQ0tuE0DbcRD2fJU71zN4gzjwAzgyo171rdV6qTsULtHS9FJLqEwAOILuaynLyeOCdSzJM//dYxFBNUIUcmzFb9+b6eEnVx4LBYCy5IXW82WHgy6+WtMv2gdtLw2n9nx+LQ4qTaXoa8ahFFWQNyWH5V2w5c7fFmBDqXtEGrLPWSgnOIEainTDQsWEKj2BXNxIdVfo2TNwlRLeFwv2T6LZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfLioNDp62UncM29SvrD/sUQE4zTT4MameRZ5gYjMf0=;
 b=kHLoXlvJsMgLmzTHMd2Y+iS8v9HSQQUPmL01M6E+yWEM9xFG28cLTLzvn3Jw6bkVVie34NDmS9GAsFUuboRM5rw2cvIo2ZQs4NwoNmVwdzyZyl7J4aZimJU3r+/qLTA2yGHpwYTAz40f+ZmGtM70O8WRFMOj4clHchpDSaD7JQSyBjawrXXoh78W5VVD5BxVyH6EDKRO07GkrYdPsPrb0juXvcjfTFUET6bv034Adh0IB5B0vlCfv6BoQuPJpM9w7Zf9Y/mcqXZNPEwdWymPefTmW62dVgYXukYI/U18A/mZev7QDKMrd3bpxYO7vRyMDMMkdX8K/I03xOOFLE1X9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfLioNDp62UncM29SvrD/sUQE4zTT4MameRZ5gYjMf0=;
 b=UL3MjSk6KcFV5C7PHL8CuF6unsXMWhE/W5rETSEQASZqO/INZvbdmyzknrJYgGE9EeW+5KIqTJ7ej5l9zFZQfymgPajmpRRqWuOBa0hmBjJHQJK1IorFdf9jAqCCFhk8ftGr+55jMB8DGqOEXn2+oqTEz3R64X2475PE2yZn7aQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7736.namprd04.prod.outlook.com (2603:10b6:510:53::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 07:45:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 07:45:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 04/26] btrfs-progs: zoned: add new ZONED feature flag
Thread-Topic: [PATCH 04/26] btrfs-progs: zoned: add new ZONED feature flag
Thread-Index: AQHXOmVnbIYwAycgeUWmji+I/fyp4g==
Date:   Mon, 26 Apr 2021 07:45:23 +0000
Message-ID: <PH0PR04MB74167CC07BDF6C03906AC6999B429@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <c222a684214512e36fc721ee23ded5145bf9d89c.1619416549.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3449b88a-1194-4d3d-e5d8-08d908873fde
x-ms-traffictypediagnostic: PH0PR04MB7736:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7736339809F7FE79929BC3F19B429@PH0PR04MB7736.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FuuT2xLBu0//8aPeKVvwzyDSVc6km44cn40vq9Kt4Gykhfx1CC/Z3mrHENSOd8oKzcityWODU2yyl+Ju72fmWyizx4opH5g1BIe3isCKEmAc2vS2ECHMHF8Q56tM9YWJk+XiIECjTpcMyg2O3M/yWZojNyoIYQVgOeAGRCLtt/KvUWoUVYTdjjtt6RCrkZ9sjxpF0OCpK9Lj1A3O/KJC8goluRBTIjnkLX0Lg4yvycEplLdo4fCmDyTGeoXRXhf6Qo5u6vQTwupBLdbsPz5T7F4Ihv3sTIZQPHagQQ4kWkMKCAekenp53CAMT/zwghWXtrQYnHaCLyQU/CV/b+1JUiVMx2mhSscatkWefzhT6l6vXIctcH0G7u35vchcOeTDjIh3pgfBp2Yc8ZxmMAeAFMPGcEOpHGPYBineNtZkKIyaoeOHVg5Z00L1cWaHf4xZM+0zYGY2DlL5b8sVouT2rkHkWJnLKbjWiRnoRRxmYIkVRVMz5ExRe2L/ROZKADANgiRtJqKAuRELLFF0WOADTavyX8/k9luGrfqNuQvDTNWKPF3Zc8q+J87TaZSqAwLo3O9hNyXpNeKTha9IUwvJCrAfCmwrxLR8J7sH54W1ac=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(8936002)(186003)(2906002)(55016002)(86362001)(316002)(76116006)(64756008)(66446008)(26005)(4326008)(66476007)(66946007)(33656002)(5660300002)(52536014)(66556008)(8676002)(122000001)(38100700002)(478600001)(6506007)(53546011)(9686003)(71200400001)(54906003)(4744005)(7696005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?w0l+SGldiQZS7zY3SxtqKWIS2JdglNVUkjtfRrAkmW+8ZSL116z7Y7wLDRWp?=
 =?us-ascii?Q?8rLAUNBP8TRTZZ1HGd19YNCqfLFXoyAmXr5jzmciN+D6qYgWv5jGPyzU4Q3y?=
 =?us-ascii?Q?JvKpbvi5KONSgE3XDs24LCB6Ng0txisjQ9x6YEZCmIMYbS9xgqc3xplV9Jf4?=
 =?us-ascii?Q?qZ8OTexnB60gMyIOSoAeBhMgvTe4VGKGeRePDYNQGqbyIqykSSbmr1oiTR2g?=
 =?us-ascii?Q?EQRiGzR6EK3E6jLmVaWpDcsv7RvhCpCKHfDskDob1v0EeFqn8DjwI0d+4rkD?=
 =?us-ascii?Q?jvBJyzF5Es94Aq2cxZjh6lvfTMRukmLQauACf7XCAINwA8jIIvSVVBaXwRMc?=
 =?us-ascii?Q?AUhy0hrNv6JaY/dTV7KKoH5XjoTFoY80ekypOjCawObk5oZ/Uc8xiM3djNdE?=
 =?us-ascii?Q?ztV4r92IMBZk4HU8oaChuVyQm3u4uQPz7b/qydjMQ+d2FLtL9tXjjwv+s3Om?=
 =?us-ascii?Q?Na0r2Q0EarX/aCJ1UK83s7BsVbWbJLQUJyogQwfWc+yZPm971Vt3WYAaCmYh?=
 =?us-ascii?Q?tusRPThUWVpXG8GDs9Im1ND7gcQPlgV8nH2IgPV9HORrkonLRVLgB9s3kwZT?=
 =?us-ascii?Q?BxjHVdv5UFeGr37QWGNYkKOUmMfcbt9AOJBnniHZZ6WYTIzhaRV9+AuUsmI/?=
 =?us-ascii?Q?VFOQdddycih7XpYGjo680sZ96zAfAb3KQUJdrKhOhtZCuhRWbr2C26W/fb7/?=
 =?us-ascii?Q?40wjKtZNJFupnFKEbe112jDpVSxL6G3UjOGrdPp9JK/8xu0w97civY5N/v70?=
 =?us-ascii?Q?kVsBgiLpijvc0S+/YW4gwTlgG9FBhAelBJ6wlxL+05a9jaEiNXEJrs8DTJJx?=
 =?us-ascii?Q?aWyNtXjDII7zIyvPGWRKNvRJnug7L9pZQWPeEzzlhTOMYPyMFAJr9NdXTgom?=
 =?us-ascii?Q?J953KopvvQXZFKOtZXP0CJkQsag3JV2OmiAof175Ku3czrL5flX/+dNr3ZT7?=
 =?us-ascii?Q?yfAjhXn6rdbSBKz788vrh3svogh8FrwHh27smTN0ZOktF6Vttfu9V7WkIZ4Z?=
 =?us-ascii?Q?DFsGWfsCa96MWycKpUrV2Ib+Cb7o9wA26t0lId3qdZ2b8dPIZDcS8uPKLmyz?=
 =?us-ascii?Q?cspPLBMD1g0lo07laCC16Tibm8QUezFiT3nwYCaob5Z2LTE3v3BiMJAAbX20?=
 =?us-ascii?Q?Jf8p4lalmbA7+FA7Z5vHnhVASgvRDUsQqOIQvZFlR/lK1007jrZsOEt9OLSX?=
 =?us-ascii?Q?QfILGzwzzt/CjUaLo+kk9LA8/W1lFiuonJmr+YAWvJ4Gd7Qdsm6E8QoSw822?=
 =?us-ascii?Q?pxQCGQ/8JiGCVI5YKkq2hvqGeH8OhU9low2xasoxjGAA0ubYebEap3To9TP5?=
 =?us-ascii?Q?YvX3/GU17yiYc9TzGxNrKpSaCJ/WHHts1T9hhRujs+3rZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3449b88a-1194-4d3d-e5d8-08d908873fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 07:45:23.3172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eidqN5cj82C5AIheCpdu85cDjrxvE+KJjdkMub2VdBagfnDSFc2Hvxv9SkDiCuMhlUaQHlUsS/rCNtT3UZXqAf65P8wfEPnYHxSQgG/omv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7736
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/04/2021 08:28, Naohiro Aota wrote:=0A=
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c=0A=
> index 569208a9e5b1..c0793339b531 100644=0A=
> --- a/common/fsfeatures.c=0A=
> +++ b/common/fsfeatures.c=0A=
> @@ -100,6 +100,14 @@ static const struct btrfs_feature mkfs_features[] =
=3D {=0A=
>  		NULL, 0,=0A=
>  		NULL, 0,=0A=
>  		"RAID1 with 3 or 4 copies" },=0A=
> +#ifdef BTRFS_ZONED=0A=
> +	{ "zoned", BTRFS_FEATURE_INCOMPAT_ZONED,=0A=
> +		"zoned",=0A=
> +		NULL, 0,=0A=
> +		NULL, 0,=0A=
> +		NULL, 0,=0A=
> +		"support Zoned devices" },=0A=
> +#endif=0A=
=0A=
Shouldn't we set the compat version to 5.12?=0A=
I.e.:=0A=
#ifdef BTRFS_ZONED=0A=
	{ "zoned", BTRFS_FEATURE_INCOMPAT_ZONED,=0A=
		"zoned",=0A=
		VERSION_TO_STRING2(5,12),=0A=
		NULL, 0,=0A=
		NULL, 0,=0A=
		"support Zoned devices" },=0A=
#endif=0A=
=0A=
