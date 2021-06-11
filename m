Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268903A3D50
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 09:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhFKHif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 03:38:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22623 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhFKHie (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 03:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623396997; x=1654932997;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iJp+Cf8XGBgimDLGn//mBFczcK6qztZppB0I3KRCDTY=;
  b=cBIyUflyvT5HKIjp8fSjqOi4qou/7bRdsJYqaYQxRl2OZxdxD26TGB2e
   WAgyDzSdOMDPBlAcdL1jA5qVZx2MU6BTAxrlp7eQw6fT9xCr2UhSvEDVq
   tK6hpoQloO4IGDe7dvoeDzDhm9zYFGVcfqYV3UKycK8/7Ru/SEdL2Yc1N
   q1eS9jxEOasBC0r7wqqsdqxTCDy4d8dCKyor9uEnBt1cBhCFWxT7NH+KR
   cFmKa+VkMFUkj4+eGt0hPmK/vUwownruOax0ePLOeDI6ktxdvghm6Hobr
   U+iYIDaq5bA7L7xbzPaoBigHyJXDmlRmQFk/LH9XNa+4uwy6Kz9ThG50g
   w==;
IronPort-SDR: RMYyYKQ3psvMfRUV7ttOT4nIT8J1ycezbFQBL9Ymh0v95X9DVNxMWYA0GL5lDeGz+Jr7na6HvK
 Z1g7M0nFYoqZZHRSqRdaPwsF7BiI4QfFfqxDm7mtV/p48sjvH1tw+th8wlzOtbUJOv5O0b9Rk7
 F9U5HvF+0EUps+ZG7yU0JZMD9p4xAaU4cWSiLuCONisa5tSMX/0FhKUSfhqa0J4tZNtC8k3VNS
 9Cz6kzVtoBla/sdD1h0KIJXkOqrZEwEFybHO7HcRZSgAsUlVP3ldgj+i2I7KWd6cCjghOHt4xB
 XVw=
X-IronPort-AV: E=Sophos;i="5.83,265,1616428800"; 
   d="scan'208";a="170836816"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 15:36:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDqnPEIhiyXRltdauVxjMGtdUyKnoOZHmWSDg9xGDdA1upobtshXTZuxd4wov/uZgb+0fgb/4NrAtTKSe7wOKUvuYC+AnXth5OjyRLJgIEbRU09Mtckb7WqaQefq27nO4viBOG9wl8yOQrCAaldTXl/0PyDhTJXMI6dZwM+eNMb7EfUvWQ2YlFftAnzQW5BDUAIS76MSFGZOOjH0tG+pMOlNRwnBYr7HO8K6pzBRU5y7Q9KV9pPKc4nnuGtgR3ycvn/OHZZGsqELcd8r0/zMTjtt9mHWc26x+xYUTyaw6qlcQP90mNBqIunkBwjQRauZCm/nl/s/HlXz05UBAt9dBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqYvHnsWoOh0570Xwfk/y+vrEmhzggGwfC2eofQw3XM=;
 b=fdPHt6TB72jY/EghkzxiJ4JJQ447dudT1YqxdrZg1ZKRwIhGyDdncfT61abmzXFJAApbrgCTHvte8x/8BeSDnCLb664g6UHJBBcw3jILPDU6qLlhc2+hZCLE1oYpxp9xBJKvVoUk6PeDWkXdjf3c4VA5KPCzI3dJkb5/AZLMboQF674MZ/2SeN8A5yZQDrAqtg8s0OCoVmroRRch5xGKvstfqXauLGskNX1wrHA74N/sL9qKm+QRmRjF5tZT31IbAKGTljaTUigK0K/09Sp2+uzHdHv3BjD3gnPC0hPDprTnWsv7LaSGO02+W3Unxo86g1LS9H2pAYFuogxU2VvIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqYvHnsWoOh0570Xwfk/y+vrEmhzggGwfC2eofQw3XM=;
 b=wmNFI5kb8o9uVtruy9azDyL/8Rv33+Yu7HFeJN5Qxn7PLEYX8BmFFpDxlQ63/ibG3VbV/jkC3UgGfCGhBwhOcnGMEaxDVm5ewCLahTA6EkYSCKZB0O0Xqb3QltvIbD4X28rXV5BrJdY9VK3MuIHJW0y/a1bbcbT1U1XJy4KI1SA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7160.namprd04.prod.outlook.com (2603:10b6:510:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Fri, 11 Jun
 2021 07:36:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 07:36:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/9] btrfs: hunt down the BUG_ON()s inside
 btrfs_submit_compressed_write()
Thread-Topic: [PATCH 4/9] btrfs: hunt down the BUG_ON()s inside
 btrfs_submit_compressed_write()
Thread-Index: AQHXXmGitolU4geRPUOPOaUGasmdbA==
Date:   Fri, 11 Jun 2021 07:36:34 +0000
Message-ID: <PH0PR04MB74168CCA9DF58BAA47A965D49B349@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210611013114.57264-1-wqu@suse.com>
 <20210611013114.57264-5-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:e91f:9de6:cb32:f149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49a4f2ff-b271-4f31-1f4f-08d92caba3d3
x-ms-traffictypediagnostic: PH0PR04MB7160:
x-microsoft-antispam-prvs: <PH0PR04MB7160D904EDCA95A624B4CE819B349@PH0PR04MB7160.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fkkElpyYSpJLfBPbobixi6Nk17fRM1ngTcnlVjV333lUe/YH7XoD63V6HMdMCRNTH7cFGh3WMLB7XNNKeoYUGx3FaMi0oywfHlRcswWfRrrjuDLkzcUaAmniEP1dbCHk/+yxHsKsocS/XmyUrBw4XZ4hLdPthqVRqcLu2ecCPYX+gTdt4UGH4KtrVR6/6oGUCwE7fmLhgNTUEwxWVH/O2lTO+zB2HqEW4SbYzH9sWfoQoWUwN1eVJzLEs/254Fn7QVMZyGFYN/K71j6umgMXgx5yq9hNGcaQp2IydAFNFhT3oIv39HRkUvQeTPrk2RE58ZmJ0daLPdRudV64E6e9lfVMhVWJgrwb3xKC5WtguOciBcArPPn3QWkm8PAE9gm1l9fSJpGI4fUyWPvvAIaBHtkqI9xBhM1qlKTVlLm+aOSx8Z3Mqu76NeCzmZOMKI1FSgktMRtii1Axhex3BWRVyYWLJG32xIo/Iq5irN8JDPvch0R9R5qd9wLEjlcDgj52plUTRN2qytqAC1WUDu1cC73TCkCk/TQ/5u+GItFqN3rFDtsy52RAQU+cNxo1mIuAnDGsX4Xt1tpUskyvzUK9mCaDulDAGsNBoh/KEb0MvtI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(76116006)(4744005)(5660300002)(91956017)(66476007)(64756008)(66556008)(86362001)(7696005)(66946007)(2906002)(122000001)(33656002)(38100700002)(8936002)(66446008)(71200400001)(8676002)(110136005)(9686003)(55016002)(52536014)(186003)(316002)(53546011)(6506007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s7sW4tE6sX2GmxKIWMs9Gj3tw9sdRUTxta7eok+3nf+2FpCFI6TyXLKkI6Gz?=
 =?us-ascii?Q?aLO6HIZpLoINyxISWRzdDc5ioRTDLdkCcxfTE9iqp8MwB5k5GU4raOfzSfAo?=
 =?us-ascii?Q?h7iH7SkxS99oGN80hjfaXVObc/VGVh6OYrRamq7VGhdu06s/9WoollMU1jDQ?=
 =?us-ascii?Q?d4JWE3g7WlKdHNgfhRmboXuycWktNx0ssEzwfxFo6NTiRercPYZS4re79Kyc?=
 =?us-ascii?Q?0mjOr3jYqtkw3Z5Y7Ld+PVdl73oydP4fpdiqIsMiKTtsjZ3B16pk78+BdhHw?=
 =?us-ascii?Q?h41+CwJkpd90O0gTq+yYrsjD4/0f6vdeZ2Ic5MArpwlYxqP/rR0VcsJgmIoH?=
 =?us-ascii?Q?VNgmT1UVU3H31nkTvFE7ZK/sw3xBdOaJnJ5oHBpvbD9Kr10w7Y755Cjo9SeS?=
 =?us-ascii?Q?wBBD8c66Y3qtDUeK7AfLZDaBuYo0oeO9JWrDddjPzIs/BFyrRT/eHFLjqNaN?=
 =?us-ascii?Q?xPD8KFUJpDYbRE3tu6Te2i77Jy/EzFzEVXr3CIsqnsKmBHD2CP1qk3J3dtAz?=
 =?us-ascii?Q?IeQxGgln+8FraQ4J9afU+gICFSDSlCp+/JwAh4SnKnXx1bKgFnUubiYLAIQP?=
 =?us-ascii?Q?o58WSQi1vLRixidtIPa/OqR2DCzdMTfRl0DYYmIcGcGz3yfl7zuOXdzedJqu?=
 =?us-ascii?Q?ZPSYYDDf2kb9yqav08VcIqR0Z4Um0kK32FMEh3MMaEUGXk96Y8dU7VVKN5rS?=
 =?us-ascii?Q?nQ2QgZYfbBt/WNraKHwcXJAUcZseu4KWIFRE1vIZt4BIZmevF6dtk2TU+KC1?=
 =?us-ascii?Q?Zcxo8RcCLlNONZLxVl3utj/H4At660UpPQd2dRGyGFfB1pLvmUkuKBr9KMoh?=
 =?us-ascii?Q?2g+yv2hapon3SIFLgvl2/lM6Ji9e4yZHeZ40cErKFuVL0Mt5IF7jck4gsjeT?=
 =?us-ascii?Q?3gj7sf8EgV28pHc2wE9vTOIEH+Wdr69EbuR95e8VZsyWrTuVV52TmNTGTl8A?=
 =?us-ascii?Q?dNnUe6G93yqBfn9fZwWj16JfhsN/rDCEYN7lA7tbLKWUU3COBxEsMyo7oXNd?=
 =?us-ascii?Q?i478OBGb0LggXU3Dvnsi+3QYV0NAXLjJ7wRKs1zh7sDd42WQOJONl8p7VQ8O?=
 =?us-ascii?Q?qeo9NRvPyLIMdUTtelLGzKnW3qYKCRaKAR/fQ7SsUTW6gBk3l8rArvkhBPRf?=
 =?us-ascii?Q?nS1yG2W9OW/VWE4rIwLsDCTuyBmduaF3WmV6Mjs+J/EIYSAlaN7PoMoP34GD?=
 =?us-ascii?Q?BIOJWpF9oho7FIDBl1+t7uat5T2le5Tm4YdzcvyArBQkFsO5EVkUeC48dEIX?=
 =?us-ascii?Q?H1WC1ywThq4gr4S599fDsFAqpXwQGFfjvNZzCEzvgNikNpdHwLqvEMZ4uv2l?=
 =?us-ascii?Q?5r4rxDS50cTODynO2CQd8kmc7Tw1qFXHnBkZj3Ic91UU5ZTYaREwQbyxqzMG?=
 =?us-ascii?Q?HMIrjbPglzZ8bo469yDYA2xf4BOAArA70DNov7PStRLmU6XL5w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a4f2ff-b271-4f31-1f4f-08d92caba3d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 07:36:34.7993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6mYwJqkBwvLzDcmUqqQDvx0aTxJmrVfm8s26/93fYmoIv2mt6PLL7y+Ykcod+4U9PpBC7s1mlUiwEbrWld3UY+IOhCZHKeyo/cVfdv7C3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7160
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/06/2021 03:32, Qu Wenruo wrote:=0A=
> Just like btrfs_submit_compressed_read(), there are quite some BUG_ON()s=
=0A=
> inside btrfs_submit_compressed_write() for the bio submission path.=0A=
> =0A=
> Fix them using the same method:=0A=
> =0A=
> - For last bio, just endio the bio=0A=
>   As in that case, one of the endio function of all these submitted bio=
=0A=
>   will be able to free the comprssed_bio=0A=
> =0A=
> - For half-submitted bio, wait and finish the compressed_bio manually=0A=
>   In this case, as long as all other bio finishes, we're the only one=0A=
>   referring the compressed_bio, and can manually finish it.=0A=
> =0A=
> Signed-off-by: Qu Wenruo <wqu@suse.com>=0A=
> ---=0A=
And that one doesn't apply cleanly as well, which base did you work on?=0A=
