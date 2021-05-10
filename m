Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A69377F7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 11:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhEJJjG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 05:39:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16434 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJJjF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 05:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620639479; x=1652175479;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cTL6UPDmuRGzkrR3saIotYZe+Zu+WCmqYcnqillezao=;
  b=Fekg4ML+XiL/U/BqUr32O1ECbMu43SZUtTX2/SeJHZlIiNZqCxoXIr7P
   JiqwdIJoU0qNxPK8Klwb8GmGbw6yCwf4QiIICOl7rwkvExTTbvPuTeX/N
   dmChXGE1PcJdXLXLqczXx8BW54oBvHKkKiYX9uB6IbZ47DrIr1bX7OpV/
   f/cagcRsBD4MXwSWgaGhAi+NOyynW7gv1EOie0INV3xe6WESqyDf6bPTd
   oRiYVfKMZWiHLGXiNB9nhiDENxmqfdq+mAOXB7YJemeoP84TET1+VIeth
   +2el23GnGX0VaAuVtexDJXiU1JqJsNXLX8oKFeQG4viGkCpNDfZEFUXvb
   A==;
IronPort-SDR: q2sC2mymTW5KRFMtbmwYS0BDSqGwxQEnAnja+iXUNXGSpb7lHXH1TCk293awHuLX6JzOcoT9qZ
 piM72N1oWJ5/BCOxoUTTqeHugqqXXl/wmap0O/bQqnHyZpi40FYJpUneVNQZ3KkuUtR/lAO6lu
 pIRWbL5I2BzkpwvfiCRj7zuDqlnvmW/LJQeNZx/kY2Xc+gr62pRQ8XKCRpRGhsLw5Dx2JqtSC8
 sj6RpMHRZeZr7NPcObzfkO1XDi9FHZp28oPnWHdhc2cI+xuIaKly8xO880oROKXvU/ZaCQxNti
 yUA=
X-IronPort-AV: E=Sophos;i="5.82,287,1613404800"; 
   d="scan'208";a="167620423"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2021 17:37:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3l2RtYJZTjZBEz0DTWC/MUNxuNZREtZ9P4ILnrhWQci+w+h24hsTF0JPqQQWMIPvEHXYcQ5cTwLtFKK6Jg8RRl81sO33AJmFAaR6+7wPQpOxuklRfmZAyJMd2hyz5Jy1CcgL1SdYvvbT6d8ziHedpWdOFWyjpAzzQlRAgutAXXcX0y0ZhyKpC5v5jVa3c3H8ZOhfjlW25aEMTzvK7WDCzCZ0d0zXX3p002O3wYtXgEKHMRD2AxBqSdYmgr1xAMDA9FiOTvs3Gg+NjUHP36GOBmWZCeyervTMZ3wF790M26+RzEpUjKoF8AvDKFHMGhfOutz3Gz8A+T83qVWDH2/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfJkUumHVkXNrtlYH6ONdXjw8/Yy8o+gXFdgjS/h5JI=;
 b=SyLv40mHijXyu1hq0jWRDRH46t8sBaIz8QncjBMheOQCrwGkXJu75ccwDhuDElYV5owKvrbC0FJFmS7qhHbTKjiClfaoMoHmtO/pPgqIF6zH4Q2V6WaB6yVNV88O/l8VPjE7NQi3K2qmTBBldpuVU3fECM9mU6VuFgB85DPQc/7EzCeKZ81bzpAU6YzYeG2NXS4XoqkhzGOxvAHErbo5HdViCsdUBC/zHBUCdfZb2oo0+c/K9r4zyX3E0WSv9G7lRcet4UippN4XESTkfvPo8G5JTOGHfteDBk/WFcdazO9AlyAYWU29u8JJSX1lHlbTNWsOvg0F1P11Yxp9AqFybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfJkUumHVkXNrtlYH6ONdXjw8/Yy8o+gXFdgjS/h5JI=;
 b=Eh7gAoYSIFNZwG2jbif6MW9T59QO7gdQzmAv9rIhpD52KXh5HbFuwX9/nJ3P6FqpOH3OIqm/nexaRCWIAS6bg7bDOECUytUeW4p+FFCDwleB3I4TWB+SjGiFMRV2ByWDgV6VaDDBUnPZrueVtLob8bbJFLTkrhOMn5N/koqUz0Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7287.namprd04.prod.outlook.com (2603:10b6:510:1c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Mon, 10 May
 2021 09:37:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 09:37:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "clm@fb.com" <clm@fb.com>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Assign boolean values to a bool variable
Thread-Topic: [PATCH] btrfs: Assign boolean values to a bool variable
Thread-Index: AQHXEJjoiqW64Rl9Sk63MCR7+NNgEw==
Date:   Mon, 10 May 2021 09:37:58 +0000
Message-ID: <PH0PR04MB7416EC8C9020EAE3E074E21E9B549@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <1614764728-14857-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:6045:d432:b6c2:34a5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f23fa72-7e7f-4633-306a-08d913974bbd
x-ms-traffictypediagnostic: PH0PR04MB7287:
x-microsoft-antispam-prvs: <PH0PR04MB7287BE9AC98301AB9ECEA37F9B549@PH0PR04MB7287.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qct5EveYch/qv7Ra4s6nl2KKNgZK5NmhOQsAGF8bwZvHX0KYz+rRhjRAAH4BF58cULeUw6ph2gE3kxcxQyQx4/Pq1+28hga5KoYU493A3ol7TxNKffgunjyr3J+VO8OCbDzseGcgm07Vlm9S6pl+lmOuQIkL61CWOa6yYWMghXcC8Vwcd+e63mVZEkJM4HFbTrcEH59SgJU6XJjXg9UcXRfCBKHg62FW6kKcQYHqkwhDkawE7K68yoo5onXE6G1kV8zHHZ/oxff4ORYxU09RHYW5JJ5GS0cG0Hvh52Sb2Lnf9Odu1icRAWyLbs6DPv0zJcxS3QTDCgghMTwwvNHs/7jY6C6xd77Ab5WbjrpNS8KnRviaslIa8TH3bjAi1pbVYQbd6EgAPSoM/FvKam2+5j91KsgCIn3YoNnHoeSxrQuflzscQnMifXe2U8ns4Y3rq8UohNOJutiCisr7GPoifoN0EcIy4EQ0oU/BhqEtSD8tU00NKdWD0wfMQXKOxf9BAscDHm8ru1r8YeKSrHLgzr3OL+1EmcDTIKv4+Mw7lxBv5wyKK15tWTO3KjhulMfrCUhYWQQ+W+5iiwyrTAT9li230VFCdwKy8sQfsBqi6Sg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(4326008)(122000001)(7696005)(55016002)(9686003)(86362001)(110136005)(54906003)(71200400001)(2906002)(316002)(478600001)(6506007)(5660300002)(83380400001)(8936002)(38100700002)(76116006)(66946007)(4744005)(91956017)(64756008)(66476007)(66556008)(53546011)(33656002)(186003)(52536014)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U21GPA42wyB9fN+EdxebNN5UkOrBgJn2ItgEuLodsM42r3pnPD2lR3JsiPgZ?=
 =?us-ascii?Q?Rlb0qlbUs8P7k3u+oIVdcPOw/Z93d/msSGhuELFOtOo9YADLAWQw6/vBiNh4?=
 =?us-ascii?Q?jXqN2BgwAZSfzxroBWhQyf2d/RYsYxBQgUmTgfr/oc9i0crDbA00TlXuIjDM?=
 =?us-ascii?Q?n+19P/dSzy4BiYeEOrmMfjXC4UpP+ESnXJizIvlKLcWegq+LS5ZrQwToMYt5?=
 =?us-ascii?Q?l5F/x9IyNsgytIrWKJ5J/rCTmQ63X3Y/7+dX4fyKkd3aGuYDBOkzOXg5VLLf?=
 =?us-ascii?Q?sT75MB5P+ZKNKKx7xz1KWil0b9UiTwSAOYDatqlsq/ynTXLkTLlwXVfvRCLd?=
 =?us-ascii?Q?Vv0n+xfwlZDUbWAWRDG13x5x+0sh6+7wk0ysXgLYSJIVC3MWe7GDMNsURrkl?=
 =?us-ascii?Q?EExVC8kYy24KtOQ/0s69H1USMl7++oRcPQPrTeH4sOXTOitQeFRCqyOyflmW?=
 =?us-ascii?Q?XLH/rveeRAhasBAXdignE/DfGNg9+r3D8+gDiW+Gopa1dq6W5OcnVZi+FoA4?=
 =?us-ascii?Q?iofGep9Q/V/Ff4JmAs9CfhU8g0YILK1EyDhYUT2k7Mkxjlbr/EupcqbkS6b6?=
 =?us-ascii?Q?vQuPBMmmJfSox3zetjWT1PKY+wHb9wbL7kj0elzNVzr2yFirqAs3vYEl6PC2?=
 =?us-ascii?Q?bpoC/kVIq02/+m0Kn+sopvs1XFrywJ5KPWIrUMQBuBKMWEIPcLt+5fm+xWia?=
 =?us-ascii?Q?8sHtP9OhgHp5RiPEVtt4wwSef9YaA8ncwOQBf4VTW7S1A9nbegodYbSM6qnZ?=
 =?us-ascii?Q?Yx6fG1i7uXijFhOHh1iACobnABAAB3L1sbYx0Lql9lUFQxQsFH2Pt9cwd4k1?=
 =?us-ascii?Q?8cYW4P6eU1FxIcz/1dtrBWhyLdDn6FddQ7V0kYTqLa3hUopZBENSCOuqT04z?=
 =?us-ascii?Q?p+h0bEp8VNwVron/I4wkzdMfrft1/AxcHDchlOTStIFqKWuQUyXJf2OU4u5h?=
 =?us-ascii?Q?959a5R6ovpd96HS2JLWo9k13V3pVbBwhDlXVQfqPgEpoPy4elGzSj+nCuXvb?=
 =?us-ascii?Q?d7TrkxkU8msA0KLTSWZlSukOOw8DCHx2AFLe5wqdbHQq9iwDO6xK356AC7Js?=
 =?us-ascii?Q?EH+C6zzpfM9JET6DU0SNR6fyhCxAVCn4Lx9CXvqn1NvqbztGhByiCAnj5w5f?=
 =?us-ascii?Q?BtlCdU3bmo0RtWJMt2j926tYHnJTZyDUXf2f2cOfiClp0M2E6B+OFzkleDYt?=
 =?us-ascii?Q?hJTNbqHuHjsr/t29XzGp2wclr+jRW5J+GgnnBSoEBWAOUBgK2wshVa5AheTm?=
 =?us-ascii?Q?vL111ZThxCOBIMmdmy7DxGTxwujsqJgtub/T7LslsQANvfv0/e+xQxKKFTFL?=
 =?us-ascii?Q?TrpCstNwoh0/ijghQ46Gcqks905W/TQZWSr476Hn0K+QZhkEo6w3ak/EBZK9?=
 =?us-ascii?Q?ropO2EgLiviy1fQNjHwGJE4ThFoHYlZZKaqy29AMj1y+CVVsrw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f23fa72-7e7f-4633-306a-08d913974bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 09:37:58.0130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXdHTCR/xPxekebmgHvK8rpROuZboNI1YTFNq6C1n6hirUBzqFX7LprU08RNNl33VtnlVzAZDGOgVK9dtesVTBHI++onlldl5f0HQTrBQJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7287
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/03/2021 02:51, Jiapeng Chong wrote:=0A=
> Fix the following coccicheck warnings:=0A=
> =0A=
> ./fs/btrfs/volumes.c:1462:10-11: WARNING: return of 0/1 in function=0A=
> 'dev_extent_hole_check_zoned' with return type bool.=0A=
> =0A=
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>=0A=
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>=0A=
> ---=0A=
>  fs/btrfs/volumes.c | 4 ++--=0A=
>  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c=0A=
> index bc3b33e..995920f 100644=0A=
> --- a/fs/btrfs/volumes.c=0A=
> +++ b/fs/btrfs/volumes.c=0A=
> @@ -1458,8 +1458,8 @@ static bool dev_extent_hole_check_zoned(struct btrf=
s_device *device,=0A=
>  		/* Given hole range was invalid (outside of device) */=0A=
>  		if (ret =3D=3D -ERANGE) {=0A=
>  			*hole_start +=3D *hole_size;=0A=
> -			*hole_size =3D 0;=0A=
> -			return 1;=0A=
> +			*hole_size =3D false;=0A=
=0A=
=0A=
Erm, hole_size is u64 and not bool=0A=
