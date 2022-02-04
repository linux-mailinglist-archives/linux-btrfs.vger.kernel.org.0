Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542784A97FF
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 11:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiBDKmy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 05:42:54 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:1250 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiBDKmx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 05:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643971372; x=1675507372;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0snNU0ZbfMWR8QTABmfSqNTYAdn3ZlG+/jye0M5cFdo=;
  b=SG7kNEyZwjfAleUFq2xiT/ay6n8N9g7ZBX9E4o5XmBwr9dkQnBzx0hjW
   XnF5yBky4y0RetEzfjSyqwk3dqFrY+NOG3KR9Bi4MmjuN5JpCborC309i
   5mPUWiqcYan3NFPDnzADda0DNKJcXDDb8kEiomkZvgdxUWN4AgWktaaCL
   PLUz+AlwvGcWlfx7RbbIifgadjGFnRDsQ9PaC4JFZhzZE45UR+x0NVfZ7
   IqNVgarVsJcSTJ43Y6LhEjADjsMUf32ziFgqomE3P3rsucQ4hrhJvcz99
   ZiY3ZV4yXXHzDWh+jHOlYQEnT+pxwjO8sGPDjenptQbbj+LNzQ352xpB+
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635177600"; 
   d="scan'208";a="192158197"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 18:42:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/TKLNZtQkezc0FCy/GdCPtb8ZMFS+XjmZbm9mNU8Mu2OzRfaUm1YQlSBCLhWyVJXYlCh5LgsYD0roiPUEwbhyac+SekyE8/Mo1uQyLX3DUNnnTzLCRgnUNSqiLZk3meL7uDRrPwHtOaueOSIb6EEB7Iz8LHyMkClJaDvYQTytQ1KoarS93mJ/TvpEGftAtzbTLlrq3cIqKaTDncFQYqidhcIDNriDWEfUcwtedOexvOx1H7QWqfkkoLjF7O/XCn96sCjNiyOsow6NguogwlF/EpXixMapGIFa5xKzMoGjuwLp/pNZIBUz/GxhAx/uy7qAsel85sBIG7L22WoA0BNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAnsqxeJ4EbarlW1Bykc/0w7HbB3MEGkwzoZR6Hidd4=;
 b=Wcv/wjRbxUxFHEMTg9YfXiuxd9hyA/wmTgozfrLknQ1mAH4RlUhlpV4EZjii2hSRbC9yidG90I01zPcnaaNLfcVkLCbvnz5/DW5yuG+hbuTlDtG4SYbg0BL/9baOp3kONgzqLYtNz5ZCd6ejCLQSGt6ND+5ZCDMDRH3VXnr8r9BhQ+EEVF4cKW4UebZ+IgUn4ihqsQj4fHqbcnDbqzLogAr+k57v6tfWPDB2PA/M0AcNwAEBQuC+IEerDX090DAQcpixpOGfaCaAlT3pLVOgMFcUqYRlTJ6T8TUKTXiSzy+ML/DsWvpsl2vsXaKZbIy9O18cswZHsQAFwL+ifzWAqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAnsqxeJ4EbarlW1Bykc/0w7HbB3MEGkwzoZR6Hidd4=;
 b=YyduUOHmVKvwNJAiJwNLjsM07OdjWU3ccP2wB/6uyhmxo7inTXP8HJt/2YsBtt0y3M1L7CQeM9YdwyFiLULU/KF2obPmNP6TrNlyHamiuh/jKoKMs03wPayja7MRAdbZuLAKIPEjlaYGe1aE5KIS6dnFdS0bg0/Esy7W4jAU7KA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB6183.namprd04.prod.outlook.com (2603:10b6:a03:ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 4 Feb
 2022 10:42:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%4]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 10:42:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     Pankaj Raghav <pankydev8@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>
Subject: Re: [PATCH] btrfs: zoned: Remove redundant assignment in
 btrfs_check_zoned_mode
Thread-Topic: [PATCH] btrfs: zoned: Remove redundant assignment in
 btrfs_check_zoned_mode
Thread-Index: AQHYGafSHMmi2StDQkOvadcgPo31Eg==
Date:   Fri, 4 Feb 2022 10:42:46 +0000
Message-ID: <PH0PR04MB7416DCAEB7C986441C1BCC1F9B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CGME20220204091546eucas1p178596598790b945cb5033dd3938ef505@eucas1p1.samsung.com>
 <20220204091542.78118-1-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e254c49e-7ce3-4eef-ab32-08d9e7cb14c1
x-ms-traffictypediagnostic: BYAPR04MB6183:EE_
x-microsoft-antispam-prvs: <BYAPR04MB61839DC2C51EF347114B89E99B299@BYAPR04MB6183.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9MIBzyR7PqdfZAQeYwAqB2yvZot+jQCdvtjbs5sr1Z0gWPIOntR2mXVtBzB6c4r+Wak81xDx4XcUabCVraJZ6k/1r5XwxS264J4EWSRj5HtaLH8TRhP9ydDQ++6d/z3yL1KHC9hFTkNsSWmAVs04oud0N11jnTuWatu83szQTiXsKiHM6nJyB+3GcwV8dl8lAL9g+9Pv8rnbVbU0sGk1TRWFHjk/QxFQERAmriLiKpKiqE5FMh//rcZ3zJOpfjVoLXZjKXdnUfAGHjDpv9v3c4KoTraPD3QUVJhh2kVjkTJRQuNoi3wO7hYx6j6OGRxrsX7/mX9iSvRiv+OEDCeoKD1pBIk+/u1Y/JbAbGLIYzzZH4eIVawCuE9ORXg3kMXlrLj8He37g3RGGNDyzuxm+BhFcspLGwkbQUmF9w0oTjEl2q6zthLLwUn9CPDYO6jrmjuQQ3LKzLrb6WBCWdpl6pCoyb/r93i3+48Qcm8lrNAid1CT6x77I14UZQgCKZu2x8S89esClvEDKPYWJSMqa95wLNZG7jUpdC26w1j5N0c5o4ZeDeIu/ZS/eT6sEHMo/Cv9fGrESEojWL6dtvh4bezPmYpklRSvF09Y9XvVTvLM4ZhDLi3zZ5NNr4wjseYxUy86YC5yRcV29FoxJz7qwq4aCrGgpUA6wQqVQeVLV7wx5FZiI0+puuUo+Mro8Y7VbW2CWGqjyjlL2Lgm+XQSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(66446008)(110136005)(8676002)(8936002)(54906003)(52536014)(64756008)(4326008)(66476007)(66556008)(66946007)(76116006)(91956017)(316002)(2906002)(508600001)(86362001)(9686003)(71200400001)(38070700005)(53546011)(7696005)(83380400001)(6506007)(5660300002)(122000001)(55016003)(186003)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yfw+Fzi4I2yq1uhF0RYdvc3Y6JNx5bOtkAj+sNUlN7X0MZBa4yZwfgZzcFGR?=
 =?us-ascii?Q?NDpA+Waz1YKiCM/OpNgjCwLmgpp7rm//PE/unrD49dXOvpceCXIOmWM88An0?=
 =?us-ascii?Q?T3HznRoGsrY92fQCq39TjQrHunBlyXH0VzIdKIn+BnT0tzE3cHHKm62hice+?=
 =?us-ascii?Q?6uXDQ7I4NRhO2+b8TQkFt1FoPeybJmqelck3TVyxlsKdpuJ8vAVPeFbaMw0p?=
 =?us-ascii?Q?uDcsw6vRiuDV7PFbABhhM5QkUoUrL2PV+hx7r0z0aBsaNAZhx60LY5qsurnM?=
 =?us-ascii?Q?xzl/U44E3ETR+ApC/+Tlb54H09bMX1DU8o58oq/4D5i25tkSPjrf6fBy/Ft0?=
 =?us-ascii?Q?AwChEucNvZCVrdnQjWL5k083sKJeSfq6jpSGh6E7ym0CVHLV0e96mQpAhwAE?=
 =?us-ascii?Q?Upk1+CmMwT2IdUVsrU198sjK8CM+QzfDHXgQrw45YESpI5UTR9Nd062kkoFM?=
 =?us-ascii?Q?qej9ZGsYEevSTaSckXgFKZuJiRTE0y3eyBjlDNWBB5SY4eMnWVf6bJH28rLQ?=
 =?us-ascii?Q?A5vewaispjdwapTFbSEymNb/3roSoQy6qHDjfg754mA/Q+Kw4b9eUu9bF3WJ?=
 =?us-ascii?Q?HfoKyipMXefLWYqJrm4sTGNIPpIoXgvsAvhifUwHwwIHCWvCz4vqay7g1aFx?=
 =?us-ascii?Q?Pll1V5SgK/2NUq988VFxEp0zPgRuhsF+ZM9h/J1u6qpV7wyhV6b28Zvv2sPA?=
 =?us-ascii?Q?nST9mbwJaxcIKZ5GcGJjQ4ljIsT2KOFLHgkRNnmYMo6YvdR2kNHgsTho5NDu?=
 =?us-ascii?Q?+iVLxhMANaqNs+k36IwyYkCz8XIJS3UnaztD/1RDLbZl82tu4wUm7+60+LA+?=
 =?us-ascii?Q?pWuC8+F+LOXsznXyYBYYxV2+S0X7jXHNoZO6p+tkujl47zPjHWoJc37VBqfy?=
 =?us-ascii?Q?Xbq+F2y5fyVhm021E7x33gauuEHUpL2FoFv7lBKY3rg/I7rjHsC4hsXHfatv?=
 =?us-ascii?Q?NUQTEq17bT065PNvBNfx+/rppMjhEn8wC+2i8IDmUoc5KmyRG++ml38PYjrg?=
 =?us-ascii?Q?HcEkphIikDm9LG78OKGXYNo1WAmug66KqUHHbW3+lgStH9gxrRhoX94MLdy4?=
 =?us-ascii?Q?/6mzzQwjgumnfbZvXUl5vZj5JP2BCSLzaZvYtYISlm8ExxVpR7KHrV0M5bjX?=
 =?us-ascii?Q?SlpBoAAHOFlGe5kRTrOAQD5XWfYw2JFGbv1g0D8AlPx8CAqkdCGVySlb6G7Z?=
 =?us-ascii?Q?5iyZEQfyvsVc/Fz2VBGNdJyZW6LLc1+Jxjemjz0PTijrvIveHBbIhJqKpY3g?=
 =?us-ascii?Q?OG4/jz7q9M4caEu98tpd9+If6kB07F0mJyXuQyw8B8cAehK7nReZB9NRhSkd?=
 =?us-ascii?Q?wWMKgozSbMcMIzxojXQPpFevFy3XcojnORwpOS2pho2QBCaL9E3qQcIKXbbJ?=
 =?us-ascii?Q?mOhG+uhx3PzEl3MBI5fZXW3/WhzB210Lr3eItN8CvPWzSnGA8+QUPWSlz/SU?=
 =?us-ascii?Q?6h1pV1RltU0vLSXZfKWzjwxkiYUcVtP+cmnoUomGAh2QqszOvvC0ZeCw4Hw0?=
 =?us-ascii?Q?omGZBwk1SxReEPVIDDrdywn0ul+exq3w9bLDkyj3HF2OJbZvJMhtq1ZJso3n?=
 =?us-ascii?Q?UUtrZ9q+eroWwvVbru5UAiZLfT5tOj07qKQSXKH+Bd0LdjwztFowR4SC6kQ2?=
 =?us-ascii?Q?B1gD0crk1ad9Q+B0MWxvjIbJ96R6SlXSWckIUctwkYEXtHmZp0tsjejilFjz?=
 =?us-ascii?Q?+yusFZUc+2QmxP/jQOcA+DQDFD4oWE3Mq5yQ81oKEN2c0Y+Y+NdXbOKWn6wj?=
 =?us-ascii?Q?tB30sbkVrOaUEQSrMy/UyCEwFPZatxc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e254c49e-7ce3-4eef-ab32-08d9e7cb14c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 10:42:46.0988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWjSyTlmHkMSSDd9e+og52rD0dAecMqN5KUHR87YBtx1A+giclA8p2omG4H7WNgqFP8rt7WfntKqOE5aUUa2GsWBW1MLRL1CeolL0uJ/Ejc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6183
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/02/2022 10:15, Pankaj Raghav wrote:=0A=
> Remove the redundant assignment to zone_info variable in=0A=
> btrfs_check_zoned_mode function.=0A=
> =0A=
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>=0A=
> ---=0A=
>  fs/btrfs/zoned.c | 1 -=0A=
>  1 file changed, 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
> index 3aad1970ee43..e3f6f24718d2 100644=0A=
> --- a/fs/btrfs/zoned.c=0A=
> +++ b/fs/btrfs/zoned.c=0A=
> @@ -655,7 +655,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_i=
nfo)=0A=
>  			struct btrfs_zoned_device_info *zone_info =3D=0A=
>  				device->zone_info;=0A=
>  =0A=
> -			zone_info =3D device->zone_info;=0A=
>  			zoned_devices++;=0A=
>  			if (!zone_size) {=0A=
>  				zone_size =3D zone_info->zone_size;=0A=
=0A=
Ack for the removal of the redundancy, but wouldn't this make to code look=
=0A=
nicer in the end:=0A=
=0A=
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
index 3aad1970ee43..b7b5fac1c779 100644=0A=
--- a/fs/btrfs/zoned.c=0A=
+++ b/fs/btrfs/zoned.c=0A=
@@ -652,8 +652,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_inf=
o)=0A=
                if (model =3D=3D BLK_ZONED_HM ||=0A=
                    (model =3D=3D BLK_ZONED_HA && incompat_zoned) ||=0A=
                    (model =3D=3D BLK_ZONED_NONE && incompat_zoned)) {=0A=
-                       struct btrfs_zoned_device_info *zone_info =3D=0A=
-                               device->zone_info;=0A=
+                       struct btrfs_zoned_device_info *zone_info;=0A=
 =0A=
                        zone_info =3D device->zone_info;=0A=
                        zoned_devices++;=0A=
