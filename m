Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A38389E7F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 08:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhETG74 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 02:59:56 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15346 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhETG7x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 02:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621493928; x=1653029928;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=mVC2j+x6B67IdgYs+3ViUwdWrDq6a7ZtlxKBbiUqHKjCkNhtF19R7eVG
   l4QVAEx8IFf/SWs8Sdvk3wbLanEvNpJmyUDX+Jr0ZkJ+gkLeNS8vSb5uJ
   /gNDDSl1oS3iytgIj62FHBJbdLDaeJKIRry9Ti9Op4PdGvLCUhYXWOh+s
   P0dCEaFcYZgel3d0S1WFrJ6XUSoQdDRLkZzijDeo0v5eNXS8QqdlyP929
   MZDirFcWiU1nVSB9dim1/EcIl6haJcxneoqQ7UNNnhUzCLUTpr3G82iw1
   DQpDTeYBXAcYOGk7/pcPkDiJNZC2/07HP3kEzHT2HDWGKXyrR6I1RdT5d
   A==;
IronPort-SDR: zhuU/b6ihjYohP2IkrtGe3dWJZiCuKCa24kWEBggawU7mvKQarX0I9GOMu3i43c9ntnsckON95
 8zzLIGEcFeTxp0pqGau8iQflyS96wApa90LOJ0R4dTIeufgmIpiXAq2B+YUFFSB3SDlsVCbWcA
 4Knmgyv79d+uwEwnW9VPCAj2+Z2/IzXkXafwgj5FMw/oWC5ZKY7ErLHm2gtuBelO0QeeTPQFeh
 0ov2jGFlL45aAoq6ihEt3GSE+oq3gYndOp8RtgDXL27HtDUC5S0ehoUYMQmaXuDJtVQhwI9EMz
 CjA=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="169353870"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 14:58:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQwKMVqS/rL8B5r/cGccVxjtoPD/32hPTxXdH+zUretBB6li3B332AsP9jQ0xjznfzUkcS+VHT2igPH6Pp1cRl+pu4HY+CMgIZlw874LXaX9SfI0B2oPv61gcHC3Dyy04AoptpVU7H3eNSRoTlTv7of8427N83W/t0xNPF3R0xInGgWafNThLL5+nSY9xZAVLpigAZ2I+844bkeqve6U2TpER/4mT+NVZGacHfgIrm6lpuR5BUNv5OOYjuumXNjzIdKq3XVFtuG2Gp/33T1laI/WpzdYj5n5a5RHXbdpX6Dfdt2ffrT5lJxczL4VzXKnoAdpChguChLcjOEyGIyNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TXGCotoYNaV1sDEDO1iCpeq2Lu2QCOgMNxERqf3CTan4XGpzDOUTv3TxUMn8c/6jIS/1nW/7adg35W3n2492XkARmpXSuYb/t/5gIUIPMx4mQLfLoJ68GKNhpwjBeFmt/t6xFi1M83ZAFKyhvrmvmc3Tt1zvt/EdEkCA12ODMO6i22nZqokDYnw/TqSd4klBA0RkFTcsSkpMP0Q76eOR63aTOCNMlgVAmaNuWGwthemAVC0acSuDES/HqmP6cYPprsYNFDowFAxK9JqydSSVCoPrEiR3YpKSzihiwqRxqT5KDSa2kpLEfk5VWD0hsrfIeTS661zgHW7aU521BuQuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WpsXpKomsUvS3glVzGkGZPTu2lWHYw1HAEiDWIhl1DOZXCAdLf19K77HyyfdcYdCiV5mlRjItSm6HQIg7p/H5oLJ+k56UToc0L+fntU/Ik5q+mt81PmROJUsKt42h1+0vgDKm93s9HtgEl4UZ64nuM5ZeMFma7kQRMiWJWdosD4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7685.namprd04.prod.outlook.com (2603:10b6:510:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 06:58:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 06:58:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3] btrfs: do not infinite loop in data reclaim if we
 aborted
Thread-Topic: [PATCH v3] btrfs: do not infinite loop in data reclaim if we
 aborted
Thread-Index: AQHXTNH8t9jghm0210eI7MJCxrj/rA==
Date:   Thu, 20 May 2021 06:58:31 +0000
Message-ID: <PH0PR04MB74164E286E769104804043429B2A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <dadfaef8dc4bd12e96759701d6da8bab1c3cb0a5.1621444159.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:f8bd:921e:9aa5:6d21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c200aea7-c880-4ca4-76ca-08d91b5cadce
x-ms-traffictypediagnostic: PH0PR04MB7685:
x-microsoft-antispam-prvs: <PH0PR04MB7685DF173CD3BF72583057D39B2A9@PH0PR04MB7685.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9IJYpPn+C9m0JZFiobcuc5nVSbH2XewuAlfTzwPrFV6ox6DdbaVRCdzobfKn0BC8fNUvfZjM5LGT7ASC0Iq0IENWnnRrn2h8roCnuYvY+sdoHnF06+/RqKfJattDeHvsD+3oKVX4kUK/xR+ZztWzdVLRe7Q2KXGkKTm38wfUi5s/+PkJ6C5aZOa5TVdft4Mnz8h1lvYm8JAVbgYOkszfBD9Knu+h3kzLetN34+aUZZcHNNp+Yt7qrYpzvtWEfqCtVtGbHFGXjFtO/Ui2qAywCtskvWBwCYkEqDyxa6XrqSHzQJdBhvkllHxjT9kjyfjm65HvKiN6nIhEz1hEWZl/bnJ3/sHDiZ+RuMH8kRqBA7OgEpUWS+hGWOys1W15nghDrrR7WwYNLCXHseO6RRkI5ejb1KAWRGSPTwqq/8XRNUott653Ba1JQ23fUY2FRIgjWi7Uk2WUxPnnaLYOltKj6yV/LgYupMeDrnzY0f9d8nkHxK9rKH8gwLDEML3AYiAWcd/NWNo3fi6+ezGFV8pgF+FRkgjc5O8F+xxljFKWBaJ0HlpukjtPShK8xsK875awidt+eMhQd+MPrb7UGh4FGzfmhcnzGlXNUGiMh3UCsNc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(66476007)(66946007)(91956017)(76116006)(66556008)(110136005)(2906002)(19618925003)(316002)(52536014)(6506007)(33656002)(186003)(8676002)(122000001)(86362001)(9686003)(55016002)(7696005)(66446008)(5660300002)(8936002)(478600001)(64756008)(71200400001)(4270600006)(38100700002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2LP71hkcnUi8ot3YhXKAfPvjBgSBbOblRNDPirkmb2mjIQISlMcT6um9LmVy?=
 =?us-ascii?Q?rBK2nXIGSns0ORp1AjthKfHObXiiOFX8A80yUPH4xfna9yRIHSO6ALLrmpw0?=
 =?us-ascii?Q?GYt5rxmHqNrSg5y0c6YrnwdF/z/bt/UvTFkKxc7qvKH8x+RUjdn2KAGDRQjL?=
 =?us-ascii?Q?99UX2lyX4gHJxil+c4FY51Vtl164W31Vpn5ouGfH3ilZyRn3XaT04UjhjI1W?=
 =?us-ascii?Q?yWXdJrYo/AqRQOpuVBOgJ+q12j6ooNyQbBMXzowPcJmKlaijO6xY6py0FiXR?=
 =?us-ascii?Q?NmcmPqv9vW7E8HGiPGgMwCCDjcXCUxjyOZqRlUIHHZIvZ4p0lVk0L1EAp9z0?=
 =?us-ascii?Q?StZfs8xit4fCEDl9IadmNFFm76RTIR5EKs9ZLpHSMub1vx7CvmGJHkVfnK7k?=
 =?us-ascii?Q?Kdt2tWrgRKClpQX+wK5upjMvFV+dSW13POBzCEtZWb2N+CRMdQ9dkJwLqAIs?=
 =?us-ascii?Q?N2BnBFn4YiZzKGbsozKcJSXw6njiwR7qcn0om9F97tcY8jMz+bvbVIrXXeCY?=
 =?us-ascii?Q?5BKrWS6+DnURLlHVekcTx/XnYJpP9+jq3qlk9OAxFLOlkX+N/9sv6HWKi70u?=
 =?us-ascii?Q?FlLkNgCxOv/dWycKrHEGKoT9jJkYKWa1HCpuCvNvMUboBZC9piAkZIIyg/3E?=
 =?us-ascii?Q?jUoxCu1frJoC1O6TM2gbG4h4h4R8CKLwIcFpofJjmJhWzWXBPFXlPOmLGO3j?=
 =?us-ascii?Q?azXdSfV2OiLjEl0XCNjQ12nqaTb5T59Csg15tIJhMyjN6BvorbJNWfUrmSqD?=
 =?us-ascii?Q?HP2HK/QFNcevdPV0g5iafb7uobxuQaRfj9i8SZyX0D5IgQG9yRaNWEkwdK3C?=
 =?us-ascii?Q?VGS15nTIb3nAl4rC5Vqt7fpfTAJvxc3fe496GbLDcPtJrdtMlrfwnBT7PJxy?=
 =?us-ascii?Q?nH1O7+p6EAtEc7G22izG1m+DwlsF55Dv2yDcm1AeTYboEiZfXCk50Zx9O/fp?=
 =?us-ascii?Q?xXOil74/VWuSPzYQ4nzRh+5vaZS2AJP9oGFfEsIr4bdsynxn4OFoOKe5Hzgk?=
 =?us-ascii?Q?HIzqmCvjH3otdyrTBZOksZMVUaTuBsVZfe5QBbUrcY0GuH+e9LThoZ1hWNKb?=
 =?us-ascii?Q?6IqupEH7ieRkwWxi2jBsVkQFadI09Gz6BCFwhG+uJh4khRX+KdVnuzYPkLts?=
 =?us-ascii?Q?ZCT48kD397gbSiSoJoUBXPZmUVbmhUiQJTeyGtNcB6PlY1N5IeOX1NpnRcgp?=
 =?us-ascii?Q?ATRmAdghlUUEvbkHSKPsq0RCJFdmrWujUe4fJZm+HEKZD/xQVnreV9QYk3E8?=
 =?us-ascii?Q?Si4xmokfzyFYrpvVAmYW7652eh2d9TU2MLz/lFUZ+n338CRw+4fSKMx7/HiV?=
 =?us-ascii?Q?VlQZiNr8YCzBCr/s68+h4ezyo+NUPXnylPfSw5WIM2jDyS36FoBesZKXwWf1?=
 =?us-ascii?Q?FYLIHGV+hrYqDpxF0Fa/wJ9PHNusrwvXx3EGUxxPrQpZ3C1SRQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c200aea7-c880-4ca4-76ca-08d91b5cadce
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 06:58:31.5042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1wKXNauWk85KmaJBr9sxPEW1Krm/sF7of6H1HZEXag2NFx0n/3Y6/Q1y1rohKQzwzF78U52SsOpDZml2OmPqigllRDR3GTUYQCah9gnHZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7685
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
