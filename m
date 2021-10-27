Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8789943C38C
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 09:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbhJ0HLj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 03:11:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51453 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240330AbhJ0HLh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 03:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635318553; x=1666854553;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nzFDlCKg/T08k7IaT4UQaRpK9QbbqNMEGKnUECUrzzA=;
  b=JQAjC1R4H6pSdzNW4rgN8Tyt9ahG70JhiJjskW1XhVJ6QH0BdUBvUQVW
   4V847Fp8ckWrmi8gAdXe5aAkF8cJ+av9+JQIpbMvDsA01xi6IA4dTqMD/
   ckv+JL5aV5WcAqzCiqHV5LcYmXKMclKlY56OcxW5TSZBGv3NYC5DONE3+
   0w5Na8t6Jp3LsTYxfEcpHHfsFi+32o5CXGY78iiwW1dQWUvMQ8/jWJJxN
   FvTUA2Tm+I+iXHB+zexYZFUx0hgfn2MZXzok1h8V9guORKXhHa9lTPGpo
   lvZ8qWx91Fyg3/+iC5/zuH5bt0hmiL4miYpn9pfBCyX5moE4p5mOVnC8g
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,186,1631548800"; 
   d="scan'208";a="295687627"
Received: from mail-mw2nam08lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2021 15:09:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo+AWuEYk9Xrvtz8UO72dXRGVqjzOI5JQrppLZvjjER5+Gg8Fyc4ygC3XA3IAZKwj1OX4f2RDYMFqDjinROK6RiqF7Y4SG2MoChfoHZh/9BFtmLUoYru020EdvLrDeNy2Tw+su3pPtR5VM3pT0XuEk+fomUj2Cn/+ER04u7zclPHdum0/ksQ189c1bcY9hTsMIybtgTuOogY17AvOYswg0/Jx/7omOBHHsxA8dHOpZjfWd96Gkl5qOxP4wF4oEt249qNRSAkYZH0K7McXD46D8Deaq6srBo9cU7vnCP3UZCs0bGlfY6RJc6D14aYiiRwQOyBxouhBg2B2c0SBgZCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJzqWpD+rVsWXdUvc7DLpmmKdi1BxR0CvQjO1qGv8qo=;
 b=B/DflDZCCKelJN4p2ZSPScGChYS/UKH4EV2nFh345S9kX2zaIBVnWyGWiJPZ9+6xGJaU1Z6Bv0Jh/MKbA+lIauloHo+WwfE3NxmCdKtm/DpILApiHqVi0rc3+Nlxm6YeBHayBQv8v6+MUf7336Zu9xOIR+CV1Z63t6qVjAJeoPZn86/vHM653+z6Ye75X4U8OVPkmyrvtqsqNXC7Ba+q1OuyogRKxSLOU5EWPtoyG0JlJxDPW5OILOadQEdQlvvUbOWl2zkmkYU141ojUC4P3tkWueIMsVr5NiStQmvAYVD0o8sHv1Z919OJNm0p1IGfWHJUI2jguSm/a0cVdXFCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJzqWpD+rVsWXdUvc7DLpmmKdi1BxR0CvQjO1qGv8qo=;
 b=qP8o9icpmMy1x5siR33jbveXtPNC+uWtTLxJ7PxCIel283sycQgueER76cb69nMHH1tabUr60zaxcsj3HkgzkBhyXDaguMwl9paqaqBNHmoLxpSg6PZp914tU0FKRsDXrO6WV3Ic1pqRFrpbGbIU1oeG5l4n8P9hcVMGcemhXdI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7221.namprd04.prod.outlook.com (2603:10b6:510:17::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 07:09:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 07:09:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Stefan Roesch <shr@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: sysfs: set / query btrfs stripe size
Thread-Topic: [PATCH] btrfs: sysfs: set / query btrfs stripe size
Thread-Index: AQHXyordsU5W6HCCtE+CLExpPEpQgg==
Date:   Wed, 27 Oct 2021 07:09:11 +0000
Message-ID: <PH0PR04MB74165DE04219D13232F3D9CE9B859@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211026165915.553834-1-shr@fb.com>
 <PH0PR04MB74165B2A0D395AD9A45310C79B859@PH0PR04MB7416.namprd04.prod.outlook.com>
 <9a0a442c-8409-3401-da85-9032259a7bc5@opensource.wdc.com>
 <285f0f7f-a2df-7f23-2ba3-8ad3c12293ad@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82d73532-4101-47e6-5436-08d99918ad4b
x-ms-traffictypediagnostic: PH0PR04MB7221:
x-microsoft-antispam-prvs: <PH0PR04MB72210D611510363F09BEEDA39B859@PH0PR04MB7221.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 82pTgor5wEXyIZbUW1FlJWBGnwJNq0iLOwuSCI3hf8Z4WCM4DmV4dq7WwPev0945UL9r1UU4QJ1Cwx0IHYwAYH8V/VVUXbAK8D92nlhltvUlnbdtkE7iAJiUdTRqw0Nc8Qmm9y1myw0GkHTjtiPy8GgAjXsQH+LoYkPJBhggaGdojyaYOlA5iYEfiCd5BO6YThjvb8VxrRUjIUqpaMDnfp+FQ+a7L4IG4r93taqZUzpicWYnLb4/7318IP+aGTdVu5tV6oSxy0wsoUMAV8kj4nUKww/qBlZXgouhZjUbscKA63BBDilwzJvZ0JbL45COpnI5lNu0mxw0jKEEZgPqWRmFKxFAh8ZCvadtHbG9naewTVbjUqfqJjKvxFB1iYEko+E4UIraxHWtfB4dwcdfML2UCt5O1m0ubXDnOS71hz0CSbw48pw7e6GrqIsaq21g+uwL2S3TMV90gACRoIjcJUAhIl6c2ANthSU3kLjmNKR6/PCboZlQ2RQrQS0aXjPW+Q3wLm7KFPRAttCd7RzH2YCd87mSAsHfVvsrGRNY2xK2kbYgb7AKeyoKkF+WeiytNQ3lG7GF4V8P248niaoIFH46fn7Vt0Ys+GYncCc7Kv9JQOaNs46JgqJhhiMfzq0V6EfKBe7/3HrrvcOu0RRXRfJqD51EtgrtjQCMYYq1Rx2xkTWKEsmO50HghbSzlVm98streAxpp8RxXu595Sal3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(110136005)(508600001)(53546011)(66446008)(38070700005)(6506007)(8936002)(86362001)(7696005)(316002)(9686003)(5660300002)(82960400001)(4326008)(2906002)(52536014)(26005)(91956017)(33656002)(71200400001)(55016002)(8676002)(76116006)(122000001)(66946007)(66556008)(38100700002)(66476007)(64756008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tc1WeyjbYGHenYifw90Ktzafci3UXKvygW448PYEWulsxqPQW9VMp3vM5DR9?=
 =?us-ascii?Q?Lov5Fih1xXgfV5Ta4phiZFD1ptJI52jUWnJFSC2kGp1SHIDp4v2r3D9UvYA0?=
 =?us-ascii?Q?dmYX6R9+PVRCBOLEPLoxG3Dxj8IamlGmazL4HdtCC7LB9IFaGiUYMuy9OXtG?=
 =?us-ascii?Q?grhNYZ37glzxmUw6rrwhpITYj9PM2faZvsjboAAUdr9pdMXBqlPN+KWtKyUw?=
 =?us-ascii?Q?nhfkzKonhlvGxXjSqz75zpJ0pEbzckV3sD/sN+E+CgeP4v8cqYn/ZHaHoT/H?=
 =?us-ascii?Q?YO9yqQm0qdQzxMi5BseLFoLOiNp/IP2BavQcEml9IVOtgae37AROGIV2wo/R?=
 =?us-ascii?Q?/6BR7DPd9ajBLi1ZpMdBC61pYvzf6LSE493AdRdAx3HOKV0iHQPgQUqLd5uk?=
 =?us-ascii?Q?v1GFe1Bnqd1nPyR54/rvKFAFPpLoC1bV+e2m2RWLevkig79som8xHuPAq7v2?=
 =?us-ascii?Q?YQLo2+Upo8vBay4Ymq7zNmtcuE88CfL8j3rLOqr1Kq5gLFthX6wQyskrWLsN?=
 =?us-ascii?Q?hXZa1heBh3NWH9LKiggEgaw9vtYcvH7QT79ilFO2iH5WQMN5gEfvM0R/W0yJ?=
 =?us-ascii?Q?apVCm6cfHucpNQjll5CE0YMLQ4GhWt3QqnJu3r7LZEfluFwiOXIR+Xknb33k?=
 =?us-ascii?Q?KpSEgnzjKsCX0QyHJJKGkgygQHhyVNTujQl9igQN8qxUTh4Y+ulshw6n9HRq?=
 =?us-ascii?Q?7tNq0qbpEIh6dhVBLi0Ld/+5xU7fMx/MukL/XTjSLmnVixJifIy6kkVjf2lt?=
 =?us-ascii?Q?sSM1CjibvvnGxlTFhsYqrtzz+1szzuGW0qTaFMBYGfrFNINT0wj4fJEe2CwP?=
 =?us-ascii?Q?IWiVFkSQ6KZxAD+47AW/SYXhge/7rIyT1bCZ/TmE9MkhNKjGIgix+BJXJ2Cj?=
 =?us-ascii?Q?d15GThdKF9WYjeieo+vM+lczNnVw60nVoHzWTx0tKUCxOT8tVJ4NYfqOHu7s?=
 =?us-ascii?Q?yPvWnKdbexn9bATr85JY945tOirZK7IPCxH/bV5tRKNvAhFQrZeZgy3q4v/C?=
 =?us-ascii?Q?a+5sizusPyqgKdRpRSk/rxGXzjM7BhPZRIqE79cGjJkL2OBrzDBwi0DUeFzc?=
 =?us-ascii?Q?UmgmfWty+L08EmnNQeMBezdJtS37TvAbNlX6CXoS/14sIL0T0CFzPIjebCMk?=
 =?us-ascii?Q?Q69Vg2YQVu8jrJiyby4kbq0KjeOq4pwd2lznHX043zY5urTBqJ5xLD1uRyj4?=
 =?us-ascii?Q?3YcB9wJXZfr5vn9Eg16Z4lXgwB0e3aKzrXl5o53mD2i17iAIAphCZ9QAc1RQ?=
 =?us-ascii?Q?0vEr9LYdap1I36puDTWX4iygzMtcmH0tG01imQ2Pe8qyAeiYUT/4wd8l8moz?=
 =?us-ascii?Q?wLXDhRcmMHzaEfy3b8HF/DZ03/duvjc0eleBkR4oHIz2+QIJesxhF0wCLgKj?=
 =?us-ascii?Q?gLh1+ilv5VPm+/ZaCzrS0km1lZ14DTTkGrvqHG8ZL1KFdZndJfFzDY9eR2Tu?=
 =?us-ascii?Q?C8hawz0Xq70L0YLCvI17s83A/keY6Bsv51Mf71cPBznypLqiViJ3v0Gyhi56?=
 =?us-ascii?Q?mZK1cH6ZL5yOyh0LDpH4SlMXKDNMH3A3QwtwX2Wu9L/QjNTETL/Z7WfrumYJ?=
 =?us-ascii?Q?6O7oea7BoTirn4fgdWA8WVaXqkSt0CdA6BsCYRRrBf02rM4JkKOyFPaC27rh?=
 =?us-ascii?Q?8257/S3VMdqz8GDRjUg77or5ARUp2o1ChzZ8ez41ouUzBYWO6s/3ofw++yxb?=
 =?us-ascii?Q?MXAsEXMvWRzoHgXFe0TMBcjZJTE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d73532-4101-47e6-5436-08d99918ad4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 07:09:11.3832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WoVBY6QULvE5QC1cwJdvQCgWmD3sp2AbZpzLf8f2crwuiFi80rHSEfiIcM/bnirqJ8DnzGS6sgXewuAM2uYRaU/BcnU/MksbkAaoDAAVj/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7221
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/10/2021 08:59, Stefan Roesch wrote:=0A=
[...]=0A=
>>> static ssize_t btrfs_stripe_size_show(struct kobject *kobj,=0A=
>>> 				struct kobj_attribute *a, char *buf)=0A=
>>>=0A=
>>> {=0A=
>>> 	struct btrfs_space_info *sinfo =3D to_space_info(kobj);=0A=
>>> 	struct btrfs_fs_info *fs_info =3D to_fs_info(get_btrfs_kobj(kobj));=0A=
>>> 	u64 max_stripe_size;=0A=
>>>=0A=
>>> 	spin_lock(&sinfo->lock);=0A=
>>> 	if (btrfs_is_zoned(fs_info))=0A=
>>> 		max_stripe_size =3D fs_info->zone_size;=0A=
>>> 	else=0A=
>>> 		max_stripe_size =3D sinfo->max_stripe_size;=0A=
>>> 	spin_unlock(&sinfo->lock);=0A=
>>=0A=
>> This will not work once we have stripped zoned volume though, won't it ?=
=0A=
>> Why is not max_stripe_size set to zone size for a simple zoned btrfs vol=
ume ?=0A=
>>=0A=
> =0A=
> My intention was to not support zoned volumes with this patch. However I =
missed =0A=
> the correct check in the function btrfs_stripe_size_show. The intent was =
to return=0A=
> -EINVAL for zoned volumes. =0A=
> =0A=
> Any thoughts?=0A=
=0A=
Hi Stefan,=0A=
=0A=
struct btrfs_fs_info *fs_info =3D to_fs_info(get_btrfs_kobj(kobj));=0A=
=0A=
if (btrfs_is_zoned(fs_info))=0A=
	return -EINVAL;=0A=
=0A=
But why not just set the correct values for a zoned dev and show them?=0A=
You can still not allow setting new values.=0A=
