Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA645D53F
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 08:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349264AbhKYHS1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 02:18:27 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:57173 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbhKYHQ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 02:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637824395; x=1669360395;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cjYKXF/WW9JIAqYlzJHhug9xQPCYBL2BLHM7383bJyU=;
  b=YHc83L6qiUCI8OesP9ca4gQA6BudzxHoZH8x4b5dW9oUE+5SaDT8eqmG
   3CQvwm3jDVdTjjZuP+UrFeGgTb3t/hFAzMGVy4bSTFaKzFK1GkJcSI8Qm
   n48ehhvaWVzBmo4l6O4zMkdnfEm4twTHU/RPmOVwTTgJ64JeAuelk5FAD
   LZxYJRRSkWaUxh8XjotVD9hu5BmYkZy+eGZ2A7Ok7Lv+P9ORWQ7UXvC1u
   MV86VdI1/UkaUOXvjY/faDqswi/TGbhEnVyDc2ALzOgmNQTi4SNvQWfkT
   FPnvuT+2IlVE/e8Tf+0v6i984IqDWMjCiBnF2ODikzHSiSIlS0yTIvt87
   w==;
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="186609183"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2021 15:13:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=au8b+MxKHZIVOGmCNd759YXHAzC0nSwFCm+s/Rcq64pwsu87XbzqUtdZFXgAw06V86ya7xR01a0w52VE5P/wg4LY1gHw/+m6E4TOMEeRyhDdsUU6NbmpcvjWiqYJ4/77vUph2PdCc11M3DsgKwTdxz12FOlPrYafHj1RIW/dofz6awIQZIwqssQ0PEy6G2k61HNwCFDgBuF9uBH5inj2Z9jZa6+n8wwT9Iwfbp5y51NkID9Xh6n1xE61DYHsyYAKKgt7LkkjmqwPmqwULcfIWHf4gXzRVEdeLsvj9SqnxNCDb20BTsyzgyTZCI5g6+RoiVa7tk+CxHVbhBFMcQd5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inWedEfaR5s0A3lORLmQpvQar/MJvEVFkOn/zYm7HRU=;
 b=OUVkAzqNEmtCuDBLgocFDYekb+mRBthzI47gNgCE5se1kPiseT+B9HKLOkyDlB4WmFARlArRh+8YI4MuSRE+3M7OOpXAemksx+OYda/5AgsZnQLJg0GsiN1C3uy7k0wHw5Aieob99bqomd/C1Ok2gmvM75959sd4Idf1XpcTaIYwFZkeISl2DcNtgtN8Ncwwepe6eA6Apfj9wfgs4APk7tP7xreSWK/cewL+2utnUpMqXlu0DE9ZJOwJiZXjgD8a8E7+uDrEt5DEmzn5wNYfmXwtAZYW4uEUc1X6xM+w9TVKab9V95kCK8tgs7rF91ouo2lTEF3APVDxYz+yFhL77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inWedEfaR5s0A3lORLmQpvQar/MJvEVFkOn/zYm7HRU=;
 b=Akv1VYLwmbxaTrqmN/MasM4Q7qYv57PkXk26f7EKz/jfLRKk2OGEmEMJGaB4sh9d2mFSdG0QwwgtimrDr0qoslgdkcSG+qx2CYSfPkaNfrE+wLtF5t4hZo/0FvGg0teqnEN74fUdMvLCd8Dh6+v5ufT4caBG106Q89P2hsz9Pn0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7608.namprd04.prod.outlook.com (2603:10b6:510:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 07:13:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4734.022; Thu, 25 Nov 2021
 07:13:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 03/21] btrfs: zoned: sink zone check into
 btrfs_repair_one_zone
Thread-Topic: [PATCH 03/21] btrfs: zoned: sink zone check into
 btrfs_repair_one_zone
Thread-Index: AQHX4RYA0/yKoIpUs0qneuZcIsLxew==
Date:   Thu, 25 Nov 2021 07:13:12 +0000
Message-ID: <PH0PR04MB74169447E16DA7FFD6D5A1D49B629@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
 <8c38c2f9d1bee46ded4ec491e16398f2f5764200.1637745470.git.johannes.thumshirn@wdc.com>
 <20211124172950.GU28560@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acadb895-3f67-4c3a-a483-08d9afe30af7
x-ms-traffictypediagnostic: PH0PR04MB7608:
x-microsoft-antispam-prvs: <PH0PR04MB76080C57C968B0321483CCD19B629@PH0PR04MB7608.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DcGWXB3mAXc+/xnioMrPhXyS/wlypsJGv/jdY31No3jbwiE8aO7mEJ7E2zRBeSAme/NHA6B55J7QEgcYAQretTlfPpH6/T+NYhRVfUTgX8QNl3c6vF8UIBUcJYbA6Fyz5vO6bpgbehcRO8oVG9+T1ICoR4ARAbO759AA8NIZbOg5wmCs/Of2dRYrRJNThEPvntstjH/DxGnklp0DHQAjoXnyrYYp9SjoMdrizb5GXy3DkvMAfgxU6WEGfGolhFdq0WJ23lDtAORcmLuyhDfO4MowsJq8V6lA//qnnx9RUFgA/wSPy1SpVhl1z/8nIrpzYxhRbNVZdkd8/0ZBqnCl7qs+KVw7nn9BayY62mD1nKMoMp5qOA5QaLyQ1ukm50H84Ty4m33eyhQLghvHkf1NRpuKdZ44tvRzQiVtLbPI+nJthbJ1I6HSxlAPMd9JT5MaMUhfHamOth2Tgy+PL11H9Xp1qYMw7BjyGNM8U2xShypATqVUVy01tFGUgtAdhlKKWNftNTmyjcz2GmjW6Pn47uyLRPjE4LACe0v2wwPugRIojYq8LH5hn8xxCGOFqlHuJFy+Xr/z7lwAXPSLvYSxWo9nUKLosaqMTSKMhB2cIUnbTOTgemg1YQzAvjPfr3hj/1rEPVcTp+8ZKDfetWuGmUGBpV+BEFqIgN79z2GCuCAX+FNAw6UOSajVW2L34D5ZO1om1c26o5dEIZfj3NjDUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(5660300002)(52536014)(82960400001)(7696005)(8936002)(33656002)(6916009)(316002)(53546011)(76116006)(91956017)(9686003)(6506007)(66946007)(122000001)(186003)(55016003)(66446008)(64756008)(66556008)(66476007)(54906003)(71200400001)(2906002)(8676002)(4326008)(83380400001)(86362001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rm9eITvxMfts6u2X2GnFaPHgOSVjbhjlx8/PeB92kLeyC/oGpsZ0bKnevnCC?=
 =?us-ascii?Q?mPup3XtQVcjJDRZp6nVNOJIZTC6u63rZoeUnvESN9A+lS2oI/qolYC7neT+Y?=
 =?us-ascii?Q?Lo3EE+AhqV/MWjZfKXeLC/AZ0VImGUA+1TswEFHMTbJFnb2WQLXcSLRG2odH?=
 =?us-ascii?Q?YEkLU5inMOtYXvTLBdOIWEsSbVzTcFhnVcb8VDbK2kvrjD+MLsyXi5jGyy/B?=
 =?us-ascii?Q?cH2aeDgYbRdMKiXyolooDrhqXm+xqSYy/OZPRqz8BUh6clarb3rk7HU+s24L?=
 =?us-ascii?Q?gvQ5DcRyl8cU8HDKjlXwuNZnMh+JidAIZr0ux0j6Fn6xBlLUWyeM2ZYRuOVB?=
 =?us-ascii?Q?MtOUcGL7JN6/cSNIi8NtuE+jPj9qtl1kAHdtHIMneI2S26ZPL8YVpDQ/m8YP?=
 =?us-ascii?Q?hSmxWnytQ61ZZEt9QH8qdQlumEWNYGEllTOVdmj8pI5+dxTDbPTnLqNTY29Y?=
 =?us-ascii?Q?UxnT1M3Mfsql0yvQvHaep6YeBgYZKOxfDYdtJu2Oz8sKE/Y4M9vaUgIoRHJt?=
 =?us-ascii?Q?R2o7NB0miEEhf7rdg7F0c4HChg80/i+h1tA/Gy/RUdEbp1fpHxyoi8q7BtZL?=
 =?us-ascii?Q?JsmoZuFrT0qJR+0zf4LDHkxU7nAUJafuMmM3IlAZWHkOe563nRuIDNbCqNEl?=
 =?us-ascii?Q?ESj7Go/gVYg5DybTykuhgBrml8tyljZMn6gtuf2VUv3omSXEB8pNmxI7Uqqn?=
 =?us-ascii?Q?Fsy0pasHWpupeEM3uDQ+r8cmfe0d2e0HszX29k3to9wnFtElMM/AgwO2zw/m?=
 =?us-ascii?Q?FdmfKWPXmBFKsBSkJW8yCfOQWaGHRTlfzMmJp6vDTEfLJBidcRgKiVp0FIyX?=
 =?us-ascii?Q?7RZrJB+J7nkw4d3HUwERSWycRouZwd90F7EsUyfVMDRew5BjC/r6GBZhfeTd?=
 =?us-ascii?Q?xHKsUd7ZJBQ7pppHIEmYMOhtFo+CIZc4XR87ElyFJgX0GhfzLgDx+UeurPuA?=
 =?us-ascii?Q?G+Tuw6Gkg4CjprjVwnxP/AqTTcggtNiBfW56im7IIoL5Weg8M7slxEasYzre?=
 =?us-ascii?Q?gt1PL/mx/Sz8NOEMt+Td4Rb9rz27ahMsYbknDy8BXGoc87Skp24G/xFqqk0c?=
 =?us-ascii?Q?WUL3qBo03qwl7e1Hcrb68OKReTKd5IXjh2/Gruq7B+jmAqNMT8GI5SJZOYJ4?=
 =?us-ascii?Q?hhcf2YjaUcNMKc8pqjmj5mGmcLGzErkWPP41b/zTw7o0dyXZn5gOVzHD+fKy?=
 =?us-ascii?Q?MWon+GJpJ3wJZWfedwqOOQk3URiVHQH+nIQaZvvcS3ldqFBb8jPOmmAkIZg/?=
 =?us-ascii?Q?h99wmsI+sLSE9DMCklqoh17ngF61dLx1TjqpyVJQ3meVeIuGEPvVDRACOPmh?=
 =?us-ascii?Q?uo5/R6TkK2ZyLKjoBY5DHzFCfIsATD0PFzNBoBpRaajc1OS8lU2Vu7HfFAl7?=
 =?us-ascii?Q?HCdBQh4oUHH5CW54XAus7sERA7SKr5F4FmAiKkarCcReRwKvTXiD2v8yeGZB?=
 =?us-ascii?Q?anPT4F/PPRgPjMEEcBSa5DBzWqxLf4zrJlmXR2JO3HrucD1rsZ6X65g9737/?=
 =?us-ascii?Q?mmIP/3vZ/l+6t9CoHu+kONv3zyeqnCkWKk3hcpO55dAkXlRUTcD0YHX5MS21?=
 =?us-ascii?Q?GpWg7zyAnvRRvhY4Ur6ATmLGKr4f+nALxI90+HjGJ0ajpQXe1WreVrxr+uaL?=
 =?us-ascii?Q?N/sEDGH3HyFQRbxC0JTQzEuxVSmf4+1xoOx0EUdn0IY3S57I1y4DOjKF1UKE?=
 =?us-ascii?Q?tGXndYgS3Ax70WIv0MIvu5uWjRtN6tW6NZRds5CQTI9dk6ltrOrJngZ80vxF?=
 =?us-ascii?Q?PBEacmfDXuSbXeqk6uX4JaA/9zE9HeQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acadb895-3f67-4c3a-a483-08d9afe30af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 07:13:12.4192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8BD7Xe5rEbv2fPn+8Qp7no8wO3DxWctQ+FyqgEjTEZyyTySp/OhHOZY8BUIWwbRg6BtC44l3yupToaEHsmfsrqq1czyrpTAGI4KMnjz13o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7608
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/11/2021 18:30, David Sterba wrote:=0A=
> On Wed, Nov 24, 2021 at 01:30:29AM -0800, Johannes Thumshirn wrote:=0A=
>> Sink zone check into btrfs_repair_one_zone() so we don't need to do it i=
n=0A=
>> all callers.=0A=
>>=0A=
>> Also as btrfs_repair_one_zone() doesn't return a sensible error, just=0A=
>> make it a void function.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>  fs/btrfs/extent_io.c |  3 +--=0A=
>>  fs/btrfs/scrub.c     |  4 ++--=0A=
>>  fs/btrfs/volumes.c   | 13 ++++++++-----=0A=
>>  fs/btrfs/volumes.h   |  2 +-=0A=
>>  4 files changed, 12 insertions(+), 10 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c=0A=
>> index 1654c611d2002..96c2e40887772 100644=0A=
>> --- a/fs/btrfs/extent_io.c=0A=
>> +++ b/fs/btrfs/extent_io.c=0A=
>> @@ -2314,8 +2314,7 @@ static int repair_io_failure(struct btrfs_fs_info =
*fs_info, u64 ino, u64 start,=0A=
>>  	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));=0A=
>>  	BUG_ON(!mirror_num);=0A=
>>  =0A=
>> -	if (btrfs_is_zoned(fs_info))=0A=
>> -		return btrfs_repair_one_zone(fs_info, logical);=0A=
>> +	btrfs_repair_one_zone(fs_info, logical);=0A=
> =0A=
> This changes the flow, is that intended? Previously in zoned mode the=0A=
> function would end here and won't go down to allocate bio etc, now it=0A=
> would.=0A=
=0A=
Oops nope that's unintentional and a bug.=0A=
=0A=
Thanks for catching it.=0A=
