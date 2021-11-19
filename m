Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC601456DD5
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Nov 2021 11:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhKSKzn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Nov 2021 05:55:43 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:44075 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhKSKzm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Nov 2021 05:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637319160; x=1668855160;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ulv2HXU6WySmZqDdxqXP5Ex1aWp//myUFIuehZa+FZA=;
  b=joWn4sl44cO8WNrRSFxuJQStGVH7awweOfpnw+f6nYH9akpFoga/XZdv
   Rb6MxYj4w5NWU/d0GtqEDFzoikNxxSDMkQZFqo6NuNagcAwXl4KUPrbwL
   CY+f9fI0R/dxH92E5I92eoCnfQSjPxQzgt2Z+PGbJ7cmp776H9I8HdpWv
   F4jyuZgN8EKIos6H1nIaBiIDBfrRxZ26Bz3+yk9DMyZQtGyvOql42kWd3
   gZQIGzXz/akXbwXrKferpDQEpiWZcKpmk/JLNUhsjDOuYHPxOIEHkG2ie
   8OmR76l+iP3OC2mFuGGA2nSuo54CcpjSVLOd6yDSDnVPow7k3AIPhzNet
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,247,1631548800"; 
   d="scan'208";a="297913825"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2021 18:52:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBH9TRiL4s6rPpLco+xhVZnpiJ69WRYrYx22nGOZv05hwljjHMX/7KPSf4d3abVmgS8HwImkTrEmagYjOiPrWmizd0IVXDDoT7l7sYLK7D6xYPRdPr0BACXNfU/JU2W0oUKqLZmWMj7mhJ9eE+NW5C6i1Qhw6qpmO4m86zG+MSGyIUfCLuh66c5tUBwl2jwva4iSLN9EqD22t0ZImxg6MdtJ9i2mBmx+WE0JfBw8iu/HoyJkPh2/YOeT6Jqkx+I2ASx7sXehxWOZU1X7FWy/USgrvkXnRzMSkhxlYBxfy3nJBeysgC7k4NOtpnoiJxkFbypOwyH8sPtXMoVtJN4x7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEP9aLI6/GhYWCQzlJQSP/rjcyCCFukRO5hXsdDLR40=;
 b=bNolPBEfsRi1g+CSTz7p+6w+JpuUolqVg+rAzk5CvDMlSJU9HJJpCLcfZfd36AF5ZytjyCzLAgiNoIoMJ/a+8o8s7OQEOPaCH1Hw0WagAbmIv4O1nQw2QbfIV/FYSzdjQIdYj4hCVDigglORAClT69ienFBhNa+EvhefhIX68s2pL4k1qemz3nWbh9NJ0zH6d7AA3/H8yAqzSAHn/yWxz6jMU3rRaj3rlRFRGwIqAZwx4PiskZa8xHinlBheLbRlwraR7wEKQT6VJpAAAanHDj9T9sWLsrz8bCIgEYhHxpBAGTyd2C9CvJ5FzQewlg8e3da56UR85N03gpxhL7aVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEP9aLI6/GhYWCQzlJQSP/rjcyCCFukRO5hXsdDLR40=;
 b=tyjxokxj8jA5ohbCLPcm9WdBq1i49Ei5QTzOLtpzGKBzBF7P5U+R9H6dLUioxPx5f/zArvXOuJ9JhdOGj4YBM564d1gfHbCY5/WzkZ6e48NTkykmY7k4yjnNej1hHvQu+4KRWittjMejZOKFU60JgkL38g36dnzCaBA2iX6n0aY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7413.namprd04.prod.outlook.com (2603:10b6:510:13::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 10:52:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%4]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 10:52:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v5 2/3] btrfs: index free space entries on size
Thread-Topic: [PATCH v5 2/3] btrfs: index free space entries on size
Thread-Index: AQHX3MPwl0obl13NHU+KLpqmKw+bYQ==
Date:   Fri, 19 Nov 2021 10:52:38 +0000
Message-ID: <PH0PR04MB7416BDFF1C613094C64689639B9C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1637271014.git.josef@toxicpanda.com>
 <afe97640a3d170bea4be47e7ac1487bc81be3a89.1637271014.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7be48b3-10ef-4498-d6f6-08d9ab4ab417
x-ms-traffictypediagnostic: PH0PR04MB7413:
x-microsoft-antispam-prvs: <PH0PR04MB7413BFEAFF7C7D8F97EF3D369B9C9@PH0PR04MB7413.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9vsLMtAa9AovI+gQ9hzfAHkq5++aHlIBtSbSs738iiMzAMt10o9oLdlekM3MawKAYO4ryrK2eHMWMmaC5Zcd+R40MS6Q11K38o116YARL8mSh5rFxFdqwy6f++ZUce2EdptvUNhq4A4oMcZRrM4pMOp4LB66O5y7ofmPti+Q7+ukHbg64bJMU/3gr2SuYOkCeBzM3FNhAdP08VvSFCi0Ls5vNg8DOkN1cG6QI7qjYEoWX8Y5ve0u3o2b0uk3NW9NMYLiHHylk7c9r9PzTbS63oNR78FDixxKw/WYxCiq5ULZWBcd5gJFztNrUlRTS8YdfyWwCdBwUxJA68zZCihTRh2fi0Gk4MmErUMI04+JB1beN02b+MRcviS9oHCHJLE4THNrIFrkfZiL1XNaTfB0u7l5pM4R/Gsp5VUgR/nqSB3p8DmzHc9oJuTE2+ejEgdKF++uYtkOl5H6QcCvBn8G1LWpBnuv1fE3AuokAxH++eilpPkz5RJDYfoJQvUDquDSHBGoziVV/bvzZF8XnweDrIfjYlls9u/vbYiqlxjIr1xRr3xRwomjo39Bpts/hV5IaOBM1GpAhFEVaqZ4U8ojvz7CFH0KjxhbzXQ5mnbvjVSssUENh2ZPTdZOg1wRBtV+UaKpxnC+8GdTRI6fTRcLMhle2JYc535fOW4j69tomZWWVYIQwV7xjQeZtiFZ/LAobhQDxZvEvwwXgQ+R0KVlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(508600001)(76116006)(110136005)(6506007)(53546011)(122000001)(64756008)(38070700005)(316002)(86362001)(4326008)(82960400001)(5660300002)(38100700002)(2906002)(55016002)(33656002)(52536014)(8676002)(186003)(66946007)(66446008)(66476007)(9686003)(7696005)(66556008)(71200400001)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bnE/Hgr1oGkvctyUz6dK5we/PmWwzp5XkI000Q5lCU0JXlh8ubX9fA6G+nc+?=
 =?us-ascii?Q?jBvBpZXxSDN3gROmhWjjDOf+eWmDh3vOtiZI61wsflJk1SdOsthMqSOphYIH?=
 =?us-ascii?Q?oO2OkoxUesxaF03OzJGrLEzUNiBjrEfvNi8NZWPjem5QZHrfHTnSmkiggoFE?=
 =?us-ascii?Q?Mc6JeV58pp2eQ3EW/BcEzswxSndULqOUlXMiG9Uy2frHebxO0+EbMj/ETg2i?=
 =?us-ascii?Q?b1mem1W+WqSllkIRlwIiD5EsASU4/XtPojH0An+18Zz0oE2n/ipXkgvvhOaL?=
 =?us-ascii?Q?GKfXtU0+l+Xz7plcfjOhqURXWifJ7PfBP+Ama44lV11LQNtWgerOSmgx1nl0?=
 =?us-ascii?Q?6VEChrSOsuZ6ySEcYPCpNVufHEOPSxL34aE562gzhjLQT864mxOT0ceN1V5h?=
 =?us-ascii?Q?51TY97Ux1AQgK4tOkc/aDvoy+j9UgVxnMTX6ltE/b86+JDgWxPgM9tF/5nyq?=
 =?us-ascii?Q?US8ujAbCyVAxYieTmF9I+1Eu6UmUZfsTeD+2Dua+RrgGC2bW2dwiOrJZOC8F?=
 =?us-ascii?Q?C1eKiVqPZo8ipt3/L31fn+aHu7zGXTQWySdd0GQv0Jo0B4RJM6pqeDFKkax2?=
 =?us-ascii?Q?KGXbQv/BB4zvkP5RycEUJe0SmRvf6Bbv2VXeoy+UsUTmjAQGcSDBUFOqlleW?=
 =?us-ascii?Q?i5oZ1t0hQWdveGpP5puK9xAfLIwurvfqRjKm030wqFjcyiQLXLIw5nsTkWQG?=
 =?us-ascii?Q?H6WMztPuhi/lUz9e0mlgI+j8UtGwm8DqxpCG8SQqk/+5BM62OJDAgZ0Qzkw3?=
 =?us-ascii?Q?wLig4PkHnGi66ZyDi8gysHnugUjTsXlXDftEbzcKWLWU9mSRiB1KLFwmOYOC?=
 =?us-ascii?Q?b/iUZ21c3X/iNdjDxTATTM6QPrRUmEdS0MnhHnep+L6nCZd+gZk9PgniN9xz?=
 =?us-ascii?Q?Q5RxHq26EAxUDpju2rKL0U4gFLdyYxc0HTqz9VSwItx4B6Nkp4XocPIjrYd5?=
 =?us-ascii?Q?9e+NsAjBpqK+mYqURR6F8eJmG0OIbh8TPcv47+7Z8ZMHHCb91ls1V7a3n/WU?=
 =?us-ascii?Q?WnQAP2kwHtDFxGN+NlbqE+Iz2eqTXbC3Lg7J6tTwWjBj7OH7OUCVZEk+v3pd?=
 =?us-ascii?Q?k0SN/Cxd+B69oHnPsqlMVjouGlOYRyNY/RqoqbVwiS3bdafGeE7tt1gmmrrv?=
 =?us-ascii?Q?bFgRAdvXDxye6ez00CpX85nX0XUliQUzDkD+ocTgb//mWcFW4w1T/GR4Uuxn?=
 =?us-ascii?Q?L9oBHRYGxeuHcTWIgtIRhd0DB2T/ynq1Zylf/7w4ruUicUxMvW2/6QYvV2RB?=
 =?us-ascii?Q?dV8FZPZyKATKHVnK9DFZItEnsL+nHvI6kmooUwAYvVMN1Q7anhIUUbAXvZWK?=
 =?us-ascii?Q?8X7hDNncjxGWWahWCUz5e+XzoQMs3GnyYFcZh/lOaGghDQHKw2bMDBYZiOHO?=
 =?us-ascii?Q?pLIPFGfU2YKIK3IdfTXcbRsP3o7ibeISUnMn6z2aATTM34eiPaJeu9GQYjAC?=
 =?us-ascii?Q?ZskwOkZbeFIy+CHrHU0qQ4VDDMNCec4mJwBeTxZ/U59+amHArliL4Rtl7hQQ?=
 =?us-ascii?Q?GcMGfAS439SAkG+q+whXJzu/xUmxQ8oq/W1OYnYZitC4mOroPcr06KIyANQr?=
 =?us-ascii?Q?0aMRK9VtpjUIv5dq+3GG1wELkfp2UlpTyycSecIWRbblh0+619i8ks+pJ2sC?=
 =?us-ascii?Q?20yeaNYuIVJy1Qwzzdljh3MdPeSpieH4daGn2Pi7ZeyRpXEPDMvLpW34u/9v?=
 =?us-ascii?Q?6xLXEP2VbxokIfn9UiV26jpjmLWFYJh1MERKN5lFQXuIIobRd0sf505stQfG?=
 =?us-ascii?Q?Pmq3qNCquIcqJSQ2irDE9EPicxLxuQM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7be48b3-10ef-4498-d6f6-08d9ab4ab417
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 10:52:38.5234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufQbY0rpL0XkCd1Juzkb5JvMJ0UmTlRAd6CoAVqiIbjwKZtKM93X2HWQEPi8GcnnrzL3wq1k2r4iq2zBQRES3ihZXhjz62oHREwJYHI35o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7413
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/11/2021 22:33, Josef Bacik wrote:=0A=
> +/*=0A=
> + * This is a little subtle.  We *only* have ->max_extent_size set if we =
actually=0A=
> + * searched through the bitmap and figured out the largest ->max_extent_=
size,=0A=
> + * otherwise it's 0.  In the case that it's 0 we don't want to tell the=
=0A=
> + * allocator the wrong thing, we want to use the actual real max_extent_=
size=0A=
> + * we've found already if it's larger, or we want to use ->bytes.=0A=
> + *=0A=
> + * This matters because find_free_space() will skip entries who's ->byte=
s is=0A=
> + * less than the required bytes.  So if we didn't search down this bitma=
p, we=0A=
> + * may pick some previous entry that has a smaller ->max_extent_size tha=
n we=0A=
> + * have.  For example, assume we have two entries, one that has=0A=
> + * ->max_extent_size set to 4k and ->bytes set to 1M.  A second entry ha=
sn't set=0A=
> + * ->max_extent_size yet, has ->bytes set to 8k and it's contiguous.  We=
 will=0A=
> + *  call into find_free_space(), and return with max_extent_size =3D=3D =
4k, because=0A=
> + *  that first bitmap entry had ->max_extent_size set, but the second on=
e did=0A=
> + *  not.  If instead we returned 8k we'd come in searching for 8k, and f=
ind the=0A=
> + *  8k contiguous range.=0A=
> + *=0A=
> + *  Consider the other case, we have 2 8k chunks in that second entry an=
d still=0A=
> + *  don't have ->max_extent_size set.  We'll return 16k, and the next ti=
me the=0A=
> + *  allocator comes in it'll fully search our second bitmap, and this ti=
me it'll=0A=
> + *  get an uptodate value of 8k as the maximum chunk size.  Then we'll g=
et the=0A=
> + *  right allocation the next loop through.=0A=
> + */=0A=
> +static inline u64 get_max_extent_size(const struct btrfs_free_space *ent=
ry)=0A=
> +{=0A=
> +	if (entry->bitmap && entry->max_extent_size)=0A=
> +		return entry->max_extent_size;=0A=
> +	return entry->bytes;=0A=
> +}=0A=
=0A=
This part is also present in =0A=
[PATCH v5 1/3] btrfs: only use ->max_extent_size if it is set in the bitmap=
=0A=
