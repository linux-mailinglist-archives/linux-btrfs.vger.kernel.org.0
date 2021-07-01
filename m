Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575F03B951C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 18:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhGARCV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 13:02:21 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51503 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhGARCV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 13:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625158790; x=1656694790;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hF5qijNJ6x7UgOdbdgdpLkSdudwm23D7Db74sGn5++Q=;
  b=n1OeuYf9yKjX1qpbhTfkBID4kzh+pySVI/A9VSS3vpWbPAsWklnYnKxt
   0495wFJjX4qJh0SYUjUtkxHuOgI1/uidlEGvWDvXtbKQWl3dNUEQQXecr
   GHlpS+p17L39Pd0L3VAv3Doe9vGMxoRP6Etnjk0HQjkQ0BKcCpJx1yBtL
   etV6x6JfkDjnMNv/mGJ6tft1AIUMv/P+5TFEgdEsZA4PwN8KncyOLgltr
   kEO7u+JT0ap4KKZ7Z0vGCtDKhd3miUWFQ5uGKcPpxu6jrUKIRYtQZ/Rtx
   MxxeZPt47Ol1CjKsvEEx9jLp0fc2uIRlIEZuPQuTs+yAd5ESfey/LSjwB
   g==;
IronPort-SDR: b7sWAXI16hpOswOIymltyWjp2aOlgEJ5ZnCPFkU2O8v+MjSFoysSjnCPbNjaPzsqpK0MMi3Ceg
 gtKvN911aoPEF0/Bq30Y+SueCcgJa8XgXoVGAws28LY2jAK6eOHj9qtghJRQJ79mAC3MUsIkK6
 XO4F+i08v85UrfADzOUXXCF+CMURg7m1KhClt1O39GQo0Akb1CZ/eI/Gpgg7Pd4CEN+DAb5k5t
 KDb54bOhhleAHBU++HLptgSs2gTRDa1lOUlUBAkwPVynlxrZX4+8lB5TpA18eriQrq56v+YFWh
 mgU=
X-IronPort-AV: E=Sophos;i="5.83,315,1616428800"; 
   d="scan'208";a="173466694"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2021 00:59:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iexbx1cuQzt+UcGA2UzHM0xTHjHlNvax7z4WqAb2iyTGwqY3xG4a177x++nAI8E7DVoMn0HNjNMRZ1q8oLopt3scIFubAUo8g3+PO3Bzxp160/J0xlx1LWxN+IzVZAmhBN4z+yaURVzehiJHbGe9Jm0y2kscEyP2ArSgWZQuq4uFSYhYWeRcvA1cR0uzKceh8D50jqLlWoXOXYnSr2w2IBzJ4iaD+1m4FiAPLSgIViykqT4HkhVOmxUKUdAMXl6XrUyzbttGLMcXZErbfGZ92BfYc5hH/mRU2GK/Nwu2PtNBm7BCbm1X04z9yMjsmZzvbPfk7ABGkMN5RHduMRCP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF5qijNJ6x7UgOdbdgdpLkSdudwm23D7Db74sGn5++Q=;
 b=HqLWA4mNu6YLrvIlooGv3dX04ukXC1y/emO75RyX+dxBrlM5M0ErfcXNBcMlBCXaECkyTmu/mSXilLd3oK3AOk4NFoEoznPqosF9Tp2Dkbzydx6Cc+cfHxeI7g3/GTM0BWmeQIvJ46cFX+IlYCegSof05+GGPx1QsRYKHbniLPITLZOQAXlv08ZDmX5CMcpHI1gXbsnwqdnFl6qEswO8P18YPpO2sy+cuI+Hg7wWMOdkkB/7rwh5BVMVK/P2wosFvSceHmTZM4hBFYuQq+qf+laq1btmc3wPHb3SfE0kgxJLM0hVqbKwrHssSc8v8KLVdC/ybf01jWfKkjubbe9JaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF5qijNJ6x7UgOdbdgdpLkSdudwm23D7Db74sGn5++Q=;
 b=EYEy1iYPKkeGtW9QBMTy9Ae6S96sA+o1E9+Vjzfrj8xX0SumF3Jqqr7rabwmm7gztNGbYWiKNY5ioZwyw0RHma1Kkh3TYL93DHYtxAL0HAnVNlK+pjNELYuNROxwTwt7gpdjSMZOUrAK/T2y5R6imqhKX0w0oQBRYKFOmdigt4Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7384.namprd04.prod.outlook.com (2603:10b6:510:1f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 1 Jul
 2021 16:59:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.026; Thu, 1 Jul 2021
 16:59:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix types for u64 division in
 btrfs_reclaim_bgs_work
Thread-Topic: [PATCH] btrfs: zoned: fix types for u64 division in
 btrfs_reclaim_bgs_work
Thread-Index: AQHXbouWyQh/SzYOE0GJ2NRBX2J7bg==
Date:   Thu, 1 Jul 2021 16:59:47 +0000
Message-ID: <PH0PR04MB7416C3C3A71E9909C5B489DB9B009@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210701151020.31244-1-dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2.247.255.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67b9b2d2-cd26-4a8b-4d98-08d93cb1a257
x-ms-traffictypediagnostic: PH0PR04MB7384:
x-microsoft-antispam-prvs: <PH0PR04MB7384E1AC6BC1AE39E68DC6269B009@PH0PR04MB7384.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZSEyjVh/YsDnV83rlAKjgcnfX4v5moP3WAhTiYFDHtZDt1GeqH+PHx6VwSmI41YgKlAsrPdrsF4MAxt0BaRy9TUFmLa7fjD8jkMIksv1OeDkphBdk+F6+oJwQ9syvVoZoMxQAyH+CGRIJn4KmerbGASKg9Nt3r7nAgoNJ0XMICN0i4C5s9pUzdc0QDR1FF/j7Paz+2zSpnZd7d68KtcRqSgSurttGp2Ua3z7OrZnZr2Ub/njQSBPDZPkZsb1fgiOuPrJwkY43bfC3yzZt84Wu0z+J5tFXIeIy1Vg9OgcPfbDPk2DgU5eGoBCB4gLN4GCiJYnGvbvY5FKQVXUD627SqEB3OH8wp7bSgAR4oQOnLemETM3QZm3NCRKtbUQX7n3+Ph4dpfKMfGLIFrddPlU/SqYZ96jhMJmzFDT2Xwszjt5FBYf6fbU4o168ueBvGmVp6urcMnkWhS+L10/XGw3fbs+wgHXxFikQXYopTKXl/AMLw8qkD03P8l7n0l/RvdA3xTDVtfVoqm98xdnR2A2DilyAY9YqfTCqw16gUV96uKqkI1Fi04fzUz15YOTH0k5RmxgTHYFFewlncpNjTttGA8ZKGIAeeZVmlbku/GydKrhaI2XKvNHZ8ybIk15xtVQlz6c4ICsJYYD+wtO0MmXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(346002)(136003)(376002)(9686003)(33656002)(316002)(110136005)(38100700002)(4744005)(8676002)(86362001)(122000001)(55016002)(478600001)(5660300002)(66476007)(7696005)(2906002)(66946007)(186003)(6506007)(66446008)(66556008)(8936002)(71200400001)(52536014)(83380400001)(53546011)(91956017)(76116006)(64756008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?58A7sE2p4qA9madmm1SYst5D/MLgv86+FkOf8/mZ/Nuc5lCZXHMkfrfNLPc/?=
 =?us-ascii?Q?W0x9MgQtYrfoJiJDX25d/HMp2J8liV1s51ZFwjJude8e1G1VW6UkxVi7P8kQ?=
 =?us-ascii?Q?PCrNzv1Y31mC3uEdezbUC8nw9sgrHFZm5EXDiGmc1hJ/tQ8toCOa36v1kzis?=
 =?us-ascii?Q?gqLImrGaxPSGcoLAmM81VYf6LHOwl3mTNceDsi//g6/NHb7JOe/P22eoclf9?=
 =?us-ascii?Q?HWetHEZB1bnscWy5j9eUjKlrb+3WCebn7EpD2iugAnxa+2eLtxDNll57oGdM?=
 =?us-ascii?Q?LVzYXW5ZhBPdzBiMgbBRIZd/aaO7ziACe3qGJlznWHe9xua8tZWb7MtD5p3g?=
 =?us-ascii?Q?a9CLpUr7znTYBS3f9uHwSVfEAtJ9KyOaa2kN9D6n5wewfKq+JNASD59sUzs2?=
 =?us-ascii?Q?IOlOzxfPrv5DioTQIguI1bsIfjWPArRNpYVFmbqYBZsDZAxj/i/tsiOMv8IK?=
 =?us-ascii?Q?qDh+gpfRQUgD9UNnVGPT5rbdwi+G4DFsGrj2XsfXXjrcQQNgl0dub2q1mBEc?=
 =?us-ascii?Q?1MZLauBEDI/GIeDsnGEYCbE6i9af86NqUoxgrnkhOA3NgGER1DCtYOSDxezW?=
 =?us-ascii?Q?T1qBQDEybiQohuZ8awLFPk3su0qWyyjovSBV1IlIIVNHjPXv1F0xW3d6vxR5?=
 =?us-ascii?Q?Gdrw6RzDnddfAQJPPq9+bGUnhlWFs6rZLrRTrj9gyD9P3+A2YWaIwa4CwItR?=
 =?us-ascii?Q?FtBHpvJxPCXOlTcQ0YCvE2+457QWEbFh5M1l8jr7TndRsHJ9VQryjipAsU5v?=
 =?us-ascii?Q?yvIOj1lWypYOpshgQr35nnZtUKvAmNbq94M9y+8SiHRjgBlD0/dqIvJOUnKm?=
 =?us-ascii?Q?Fb2b/ihKknrFu80XEW0HqiyFwRJweCivsCsEiD1cXk8fwvBF7seUgIQt4tmo?=
 =?us-ascii?Q?oaxhF8Cg8iFvfU02RrRGE3Suef1uMgj4ZEVYoqncdN5U/Z1QabZm93AByPjQ?=
 =?us-ascii?Q?USsBFdbgt3TWcqzhc/srLpzEDygari8O43MmGaQI9ceSaWwHdPzhfABD9gXm?=
 =?us-ascii?Q?z39EIZoq6wuA40K94Xo30zEL7cfUKqW/OZzWQ9mEn2AHz8z63knmo+AlvkXo?=
 =?us-ascii?Q?XWViE/iWwPjzYXeds6lYqLJwFt566B47866CkKzo96tHtMdSfFoXNHlkNjin?=
 =?us-ascii?Q?G+fe9Fd0/OBW84Egzj1cUm2JbO25spxrVMZWdtf2kaLcPSQHyM9I17s1m67F?=
 =?us-ascii?Q?QR7t8A8/nrM4gokXq+Rl0FH7mAQ2hzqpaZGN/JBKXT+mtIbWDbUUC4Pd2E2X?=
 =?us-ascii?Q?xhW/Tsx4r19sFrSOGasPhHPCHOZhOb8jaB/gWahlckhBlCh1txBQs8MzZo2V?=
 =?us-ascii?Q?5/qRCB7QRpQllbxSHWfTk4CG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b9b2d2-cd26-4a8b-4d98-08d93cb1a257
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 16:59:47.8840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVwFXb3nZzxl3A3sUVB3wG5UUGZe6ZwACJUSTDQurCNAxyDDKZB7s2GIiELZZwCFJ33x+cuaermT+/1wXaoXDrc5kmOU7ipNEFV5v0Ej8oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7384
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/07/2021 17:13, David Sterba wrote:=0A=
> The types in calculation of the used percentage in the reclaiming=0A=
> messages are both u64, though bg->length is either 1GiB (non-zoned) or=0A=
> the zone size in the zoned mode. The upper limit on zone size is 8GiB so=
=0A=
> this could theoretically overflow in the future, right now the values=0A=
> fit.=0A=
> =0A=
> Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")=0A=
> Signed-off-by: David Sterba <dsterba@suse.com>=0A=
> ---=0A=
=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
