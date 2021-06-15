Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D073A7E18
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jun 2021 14:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFOMWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 08:22:47 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47648 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhFOMWq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 08:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623759642; x=1655295642;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=nIXSRDi8P6VtxXfnTHOjCcaIQ9BHRLwvj6KXnY/hWF5O6AA3kAwxaHKd
   CU8IB/M3BgcnYNPOVao41/rUJWTMdYbmWYLBRLg4QpuGDeyjWu4vxYmFu
   o6gaSsiwZxa/xUBLi2TThtI3G5vyaEY8amuMdQpDega2qhDpIB+QESGct
   pq943y5CbXNJxJLjbs6fvdFuQ44YHURPQz5JBa1nbjs8jEjPB7XaAulu5
   1Z+A488OG9yqiJ6iN/lwOYlGet7GdPuy7Scc6euA3Lo7MMNJIi32B8a99
   xEA+qAC07pwpu/BmkCP7IqLUsc+tu+cPvGbmwDzMdImBtZz6h2/EWTM+u
   g==;
IronPort-SDR: 6bPY+a5JCnQZSZfLSwEABqRUjQldyZCyIrSMlwQ5yUNFoLgAm933H+GZ9VgndPWzBpdWtGMDC5
 1YPiFmZwSCTqmKdp//Wvqzf2iN3VTq022x4TzUJFz3v9Bva7pc/WbPZ0wjBlCu8wM0LK6zkAwR
 apb8YhY4votqGPlqnHkoyVr8c2PMxDBCi3EqUGOEdmNU2ClEAdrRT6cfpr8ixTjmvvs5FemUyU
 TJTVx8QarvvqR0PS3JSfVYZFDZcD8Wd6byb9amU8lEe40zawDUcOeocmB7W0plf7xaY8MSzUi8
 zhc=
X-IronPort-AV: E=Sophos;i="5.83,275,1616428800"; 
   d="scan'208";a="283419222"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 20:20:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV7iTxJzNGkAVeLzpoOEg532MLT6WLSxjeww0hl2H3LZYldcOYzGs0wGrrKKwZsqtXCVrcnCzoByBuYQ1wU7n/zNSQOAR5QjrpRNHVspRwvM3nnW9w3qUhF486cJ11o8OIoVr+LGz2K5fM19vQQ6yCSxfcxeNh6oKZH1Wd0bSXFxnxSn15JTMb3lrXJ+DpaVRc5/fQej8hDdlgjf3QUvopCBcWEcsU/wdykys2rYaQ4VBUm/I4CJ60l3rx7L83jy7QItWJOfzknDuXXA6XDCFRlKUNjlpPPSManQj32pFwmueidpsA2IU+tTGLP21EsSOilPjg8RM6V7tR8OPqlrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TjwBcU6sKQnjzRGkzpb143WZPXToAZhOAfSspQMd0c7GPcu2u4Y2xh/Qo/cbj00J5aHp2c3FYC1WUnnqv8q2nPdpQNLXukxRWxfbdgtdepw9pC+0SMZuZqnhcZrF0ZcgfZBW/yzne7QuxNl6Re3QP+Sn/W4JyH8RGEfBNGM2D4E6LmCCpmcIwO0SCg5Vxa2RC7igjoqzeUyZ7LsMR2BAfhWL4ur5rd1MmGjT9IdP2v9mItwo7TdZJM4pOILJLlamBGnrsKSsOk2LRlkGCQ2P4SZKwFGTVOO+opTPwWTmrrYA7xd2QdQnW870dTOITz4c+ljHx1N+SQ33V1pcRfWaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bsDvE4UPyJ6P7RDUpOo0lo2VG31PD6g6QaJAjKLSnYrsUL3Nc/tXtqsEwFz706VlyrXJrkCAlx50P7U23PYoP7K/dyzp7QEz4cvObnpfpy4hwo4kNqsieC5yfNIBm++v42AV9y5Mes5ZHFKUkd9JjRbWDepTujyHjbyeMagJnwM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7543.namprd04.prod.outlook.com (2603:10b6:510:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 12:20:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 12:20:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 1/9] btrfs: remove a dead comment for
 btrfs_decompress_bio()
Thread-Topic: [PATCH v3 1/9] btrfs: remove a dead comment for
 btrfs_decompress_bio()
Thread-Index: AQHXYeCYL0B+Kusyhk+mxyuk9+92ZQ==
Date:   Tue, 15 Jun 2021 12:20:39 +0000
Message-ID: <PH0PR04MB7416D90D27A2BA87D7450ECA9B309@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210615121836.365105-1-wqu@suse.com>
 <20210615121836.365105-2-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:b8f6:a609:8f3f:1503]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44a8885f-b967-4bea-b411-08d92ff7fd00
x-ms-traffictypediagnostic: PH0PR04MB7543:
x-microsoft-antispam-prvs: <PH0PR04MB75430F152807D12C55A467749B309@PH0PR04MB7543.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1mTkVcjeYlSkVHOJzZYr4VuoIXPBEJZ86ZqWf+m/TE22DYDU3dg3T088pJcMyaBWxMUyRarrrs6doAE0SqPLAATaP3nIqvemUzxefXpS7A0Yh+cxJeMrNsQvOTDs2as95t2MsDPFR4QJcU57lJWdjaq5CrwUN8xj214b0L6tvH98rLjnAVVEPcFpVEkkw9GqrT0st/ywT8GnXdRBG/lcx6SSWv8cXqcJTTDntZPkWCWWJyhORXz7BZnzHyVFm9o9KPT6/rEjn3ZDAhsXNlQi6FSZAjWsds7bE3SvDZVmhaDuNJOHEqBGG+HbLxXzJjI+rN1D2YZ+2jgtlC+9LWMm5orYwXxZs5UTNZVShdj8fvynY+vIMi1+ZS7GsXHByXJ0JAhMHTECVrjUM/+e0O1UlVP8zoMgKkkeMEvw/ZRi5XqqxgwHs7mHvOKsWvtc1QACBQCJzPOutjQFUKHhMKZHxZN6d0WW5Cyavju+Bq1FDvFuGcLMEoemiUG3mbzevh3RNZJFi6hW/Dmbca85d5PW5MNgc4Kyhz01aXuFrR+A2MmTBT2QChfNxLe2DvCqrXEz5WU6bsh9XRsGoe0De5tmXUjFm4zT71wtAlz7NWkjhHQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(558084003)(7696005)(86362001)(498600001)(186003)(5660300002)(66476007)(66556008)(66946007)(38100700002)(66446008)(9686003)(55016002)(64756008)(8936002)(71200400001)(52536014)(76116006)(6506007)(110136005)(33656002)(4326008)(8676002)(2906002)(4270600006)(122000001)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OzLyLMnJ0qns8TU8JkQqFvmZxWyDEVssAjO3N1yPsEfHE7p0O7gN0+m4nzha?=
 =?us-ascii?Q?B9zpP69lHXDhwi97iMm3QNagu+63lGZX2Q+dPHhqeuSAP/bse2jIiH97jurj?=
 =?us-ascii?Q?hsHIWSXkw7YMczVlp1Z2lVTleuneM/2LH3FeoLqSuFlY9rihM7C/FIBHadFV?=
 =?us-ascii?Q?/K0iVl/dm8Y6AKQACPNhsebuseeMILJfDJTadvOYa77KyQGg2g24JVT/fxGy?=
 =?us-ascii?Q?f3TUM3v2fFDRM51Tpx7YZQFVpaLB0ZcKwBbHVs8x5+FQF2hOH4TKUxhYTFlE?=
 =?us-ascii?Q?XigqIJzjPoqJSzIdLLiXwiIIHdBiT20igQ6KtflPb2lFyTjodJn2Y/fPqeWs?=
 =?us-ascii?Q?XlkuI2dwTVuHxKUcW1ayadkKvIRcOm3Q/x0jlI9PSs3RfIPV3wu9fRCTBfqh?=
 =?us-ascii?Q?55OtEoiR43SO0IfurJY6U1YP7jf+f8rjwjDHCsG8vMBsLcRB4PNUIdY55xKQ?=
 =?us-ascii?Q?Mz/Cuvl3rZ3V+iCaCmZrPyO5ko7N89clsSgNxdTFWB0miDCxdVacYAcmOwBh?=
 =?us-ascii?Q?08T8eXB7VfhoTdQvAvvhzi2bKmvfWSVQVXo/0AlAehxcQFbcnIAyUa9cJCe2?=
 =?us-ascii?Q?0+qp1GIYXLmBS3hGRHjnuNkhLZ/4A7coB8a8ItT7OeyXNF3+Xb7SV/HAc/xw?=
 =?us-ascii?Q?2yaZ65MFN5rr9bEnZc+MAQ0FjbuBIeOVFyzjfg5RV7ClsLUWIyOUGhTzaSPs?=
 =?us-ascii?Q?Us62d2Z82YNY2cquqIZ8Vl1SXTMxipOIeMsXLb9IaNPPo2QmSfVFug4CvT71?=
 =?us-ascii?Q?dVFh/NF3ScdJWXpISel/ETM/Z5uTo6j7lrepcQEUE1zYAzPJNzcIVjIuCJ0A?=
 =?us-ascii?Q?uyYLkReEkO3FxcCzEfcUhvlajDLbzdynUBKXwwvbnambhA+IeLl9bbWwnt0I?=
 =?us-ascii?Q?knDR3sTL5nPsYwvwz+6sdrmT13ecVrhV7B35S+gmBrUv0k9vYfIYanJKKAIj?=
 =?us-ascii?Q?CQPOJMPwcLXmFXLmm0EoH8JucqSb1VhHmqEzTJ2r4piSv7lc6WNbFNOEu5HU?=
 =?us-ascii?Q?mwVhHDbCehY5MUXujG4mVz+axZrRlwe4/1sty7cLE6P+yvG/EeUt4TeqjDCy?=
 =?us-ascii?Q?oW3sx5DQoiSQ9J5Cbp8sKd2T4588Sgv+NB/xore6UexpPG8gsEpCPEy+fWh0?=
 =?us-ascii?Q?n55u4ioyI9/VJzhr0DcoCibOIjl/7ASZYV2b2JiAv1JkES3r1ltOCob0A9j2?=
 =?us-ascii?Q?PXTcz2wDe5gZSJSe55UXTeUoCzl3U9tAqosXsHY0BsV+JGlaTyNtCJYYz+bN?=
 =?us-ascii?Q?/jFoZoYiqsMIQACBEB9WD3+BKZwt8sIRFm9GzI9toaG6/NGyY6OSTNL3ShP3?=
 =?us-ascii?Q?EHNfSi/vsQm6Qko4XFjwuilvDdPxdaYFy+D9KwPlGoLy6b5QxEQKj7fArll+?=
 =?us-ascii?Q?2dgTOOMjBO9JSVFPZko6yuDFoOZFl0wqGSfGRAUzWWk6J110UA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a8885f-b967-4bea-b411-08d92ff7fd00
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 12:20:39.6082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bnTZ6hV1MPD/AMB4o5dAXAPsszRevz4STdPG3hH79YnbP72e8lvZyOtUBo4YJohQodMVp6DmwubumsJyivhbks+ipaJE8nw6nxbDbY60LE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7543
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
