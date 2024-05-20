Return-Path: <linux-btrfs+bounces-5096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F99F8C97AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 03:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31292815B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 01:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E82E746E;
	Mon, 20 May 2024 01:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AxAgbBY2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wrqxXtlb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D21428E8
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716168923; cv=fail; b=YpEr3uyEfhn9ZkO1s2OS1XRqYuM9XMzPjWjKjKx7DCEbiru5mLe2E2fPgajdKExmLb/AjAg15Avc20g6796EOKd8RkuzY8MRbAqYbir+MeS9xyEYkpG0DBrPrHNorq7TxUB2/EGF8rR0uvPme3bXPW8DW3tGku+y1Rs5fsMUD6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716168923; c=relaxed/simple;
	bh=gQ6Fat/irjvw58+gNU8I2u/EQQsjEJqBp0OICq+6abk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bdZ+Nb5i3Qr8+T5TdiPjlQ+eoh6zEKyGNQkFp/UkNz1WVFnCU2dWl5Q007QBzRE8lTaf1m5bkREZ75Tt3S0r7iCQ0g3TDh4bnV9vr83VyLrYM93motemPxC2VbHmojnh4RW6//38flvO/HvOvRNh9dfuwNF7FrO+jI/s2jVppss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AxAgbBY2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wrqxXtlb; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716168921; x=1747704921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gQ6Fat/irjvw58+gNU8I2u/EQQsjEJqBp0OICq+6abk=;
  b=AxAgbBY2f+/4wIKXSXVYUEtbyNDArVc4bl+EqRINwaGpBOtv2Zj6Ueku
   zLhp1EfEUHdDoRYHv0em45qypPFCfIqlzq1Do+Ovw6GYDrFUrtvepz/lI
   0s1fQW69ypps1q1uOqmdZn/ZrdskNSmkcAPP51AsQSrUV/QhT5Zp/2VoN
   Z7dKq0lKutnewEss1YQcd4hX9TEKlQ3PLlXawYhxVKJ5ZBNfArgCjVDmB
   8Sp5Y15dRx8z/aOpdGyEEQXCTH/U6EMvicSGfw8rlx9E/IuE2xhWqDV5u
   Lt9An4XUDRncENoHeLHG9FeHZayYnJ58wdjrYqx5actFAWrJ0t2/RvP9o
   w==;
X-CSE-ConnectionGUID: UFCaIxa+S6axNGQZuRw7Ig==
X-CSE-MsgGUID: rAEwuQknQiiOwKdARVylkA==
X-IronPort-AV: E=Sophos;i="6.08,174,1712592000"; 
   d="scan'208";a="16946675"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2024 09:35:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctbmMB3Wcq2l7j5fzLAkQ2/6Wf8svmJS/OrydrhpGhQToZ2nzo51pGG+GIPyK9SbqRBWFtpBIGtCh+T/hrrjkNi+32+Jx3e30QT1/PevDDy8jLrnJweQcBPUegkIyvhicJPyOHbsHw4cl4VO4td3KIn0G6V4OjJ6y/ikiBazuHASD7R0FC8OhveH7ZbCQU+amJ5A6r/EmaN/Akw+dpYvWfOAasyb0CfDK7LjUZ2MkGgTGFpvAAWvTHYFOof/KfFX0O3rN1FpnZsYSkIHZQlqoMpU60ueT4bWM7IBo/Taz7vRDU5zBbBU6NqRZMGfwn0u0Gq8xItmpJGmujg9SzhEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ6Fat/irjvw58+gNU8I2u/EQQsjEJqBp0OICq+6abk=;
 b=nQ7DOZAmweUwoo10pWG6+TU5yULs9WhZvSFAPmEOJ03VKxLM9J4yzYPO5GBW2muO1HgvWeiCDDx/hTmcWMwmou1MehVgtBHaBmJ1JcezO06kQJ+4sZ4Ie6WkuwodLQd26ZZ9ERFnXwRb0pQ4b8f1mAHfh/mffhrpj4aUfFnuNPN26ZBu163FlgpxgBaaJ9NYl+QCoeumAL9zqtmwhcswqNv+IMufmgAR5YfxQNnOta+R5BXAcfpggchHsEeM14YBWU4d2a02iakZ6S+oq6cqw7BdQbkYFZEKDrjRi3JhiKNUPpEt11Pt2V49EpXdD8VeObKvGJ0gILsJIHUh53hwDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ6Fat/irjvw58+gNU8I2u/EQQsjEJqBp0OICq+6abk=;
 b=wrqxXtlbacNzYUld2REOteuDDmHboDfZSwuQtOKQTE5XTbzBm5AJaT6xg6bNjFm/uUd/Qk8gY6UkOhU5kcEkcx8aS/Li1s8hiypYbyyPZtFUMUYZ/mKpe43JvCQZorV+pu0qnoxI6iXjx2AgVe5VHJ6DyOAFFQCcCh/CQh6ICSA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7213.namprd04.prod.outlook.com (2603:10b6:a03:291::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Mon, 20 May
 2024 01:35:18 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57%3]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 01:35:18 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Anand Jain <anand.jain@oracle.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: move btrfs_block_group_root to block-group.c
Thread-Topic: [PATCH] btrfs: move btrfs_block_group_root to block-group.c
Thread-Index: AQHaqYKEaJrhzXNEqUGiwgnzotCuGbGfWOwA
Date: Mon, 20 May 2024 01:35:18 +0000
Message-ID: <vhojwao4b2ighjdothv56ggjohix6txju3ckgcm3o6kqqrh44d@5ajamrdqtfry>
References:
 <cab027dd541768375585dc32f14b160abba476c9.1716077975.git.anand.jain@oracle.com>
In-Reply-To:
 <cab027dd541768375585dc32f14b160abba476c9.1716077975.git.anand.jain@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB7213:EE_
x-ms-office365-filtering-correlation-id: eb8a6e14-8963-4c57-5c0d-08dc786d1b82
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?S6YBLW09jEEwD5yaw0WnHT0hAbJU5geUdh+rnyqDeXdS1o4oHw2nB5Pox+i6?=
 =?us-ascii?Q?UUzLtbfByoqoiDo8dtTzb45AHu76ahnWZu+CIlD7JYkDkVLdZVD+IVEXQb8+?=
 =?us-ascii?Q?CB77t/vuOWIOkdukf92PX27pCsmTkSmpNLF97asInrA7TMfoflVRMO/4dcC+?=
 =?us-ascii?Q?xiw9BCuYcP5PvrRJz5Klxio5kdyS7eHFbyOXWLz3oZRxcIbgrpAhVsLgw3w0?=
 =?us-ascii?Q?5d/yiqcHjRIcLYK/8Y15H1stjjxW3f6K/WXzadSkOoflBkwk4awum/wNGdXF?=
 =?us-ascii?Q?IaRjG/PCKSN296YrIj7igEtN9r4sgwcDvc8F1vKZ8bveW/REGR4hAg7xXPfN?=
 =?us-ascii?Q?5NJPh3A+hop7P56Png8baLl1zeZYi/t3C6htCmVzxblONXCdXdvN+nl+ilEb?=
 =?us-ascii?Q?UTemT3yGTak+lxOsPolp2mZU7I6uRYj6z6dDvVQBCwi6kl/cqFwO4FlHSH7E?=
 =?us-ascii?Q?yRmDA6EoPBUApAnHsOH/4cbh7JpJxkvbujH9UdZXvjq90MhVMiEvD2Dgf81n?=
 =?us-ascii?Q?BHHtV1jg3bxXm9zduCpefhMYl5v59M3rFwNy0kCdGKBEPVPxYkO/+w2gsMaO?=
 =?us-ascii?Q?hjgkGhWFh2THfk9wDYL8DKbdOT14RXV57uYnewH3ean+DJzG1MfVaLFaCVv8?=
 =?us-ascii?Q?V7h03m+PQmHhSsxh74wBrP4WSBvo75Aco5jXkgTUs9pT3khXDJ8AY7KGO+Ld?=
 =?us-ascii?Q?hXqvwP/bL2WC7XrWoYQx+H3O73UXAaW0l8CIbsJdFrl2Pw0RK0FSq1dMEJHa?=
 =?us-ascii?Q?QzUXn3kG22rUyMY0w7QCdVaXEmpUFZa6Fa/R7CxXkkizknu/RxnCHeu8xwTf?=
 =?us-ascii?Q?RG95rq+0WLVWKC8bCsQ3eTVUeUZnWjT5U2MuTPKYqcGUzeTIjnCY9ADAne3I?=
 =?us-ascii?Q?G3IzsLKORw91H0VX6UJ6bQ7dVOl5kxS+MFqWX2U1DrDBab0cseHXJecinGg2?=
 =?us-ascii?Q?cuPhGGk2qKcwUBUR9iY5Mro8py0nwFlQsPAdjSfm64YEy6Sj9pAxE5qzltzU?=
 =?us-ascii?Q?mmzUNlkGEhu11LJpxCtHoUvv/eJv28GMj0+sc7wcDLulJMuysFsbZRDIl1DZ?=
 =?us-ascii?Q?kwgkvpbnzAzw88H4c+um3XP9fGkl0ew52mwe3b9snUI9y5FYPWh9BCONW1mM?=
 =?us-ascii?Q?sWbz0xZP1ljosNfHjI7qnP2s5Ry20nQ6RTZCiYFvWQ0+jFWp/7/lXt8EWxTC?=
 =?us-ascii?Q?oF/BzP2T7jhZHiw5jMV2IpkRf9UyL+0RZO/HhRE/XXH5uRbsJRfTJmoV+dLU?=
 =?us-ascii?Q?bTP30WeYvzXfaO9yYSJZULMhU390xji+1IbeTf/8Cjvh8qHz4fpDBs3yFAfd?=
 =?us-ascii?Q?Ek2dP6Al+Mo2gOwUGUxL+kl2xkBDU2TyR+hrCNukSgF1Mw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NbSVdHO8/CydEy6IdZOH0CNZr1Jl3UPbVu4AgxCFKTmtQ8lgCq4esl50QOPl?=
 =?us-ascii?Q?zI8sDPm39jKxyX9sZQ/8R4n9TF+lGEYpu4iuJap8QNPMvkDXqpRQqjs9c2Dn?=
 =?us-ascii?Q?NDBk1V6LMdgpLjKl4jwuqZBX7a4CXMcEYljTmwItOfKStIGt4QmwC9TTycG4?=
 =?us-ascii?Q?bbOVcBH+0a9apL2nlvCUp1wHTPGI+M28b4mP8MfVbQ3sZMk8+AKN8ZkzlYnE?=
 =?us-ascii?Q?3CrkIYJEbBHB1MS6BExD+d5PmLpzdbMtdqxhfLvrhmlbzgqccfPONvEYjh6G?=
 =?us-ascii?Q?IJnm/IHdL1autCeO+OnKmMv2blE974zY9LZcnTE758k7iXHvE4LfEtTj2QOH?=
 =?us-ascii?Q?YLNnHK/9mQQ+WFl86NQwMjBTwEl+sClmsb/ao3C07Auk2hf1F5N+s92Rbv3N?=
 =?us-ascii?Q?LsaeEnilw0eDMVUpGEHHg1F2GHciCjugKSozRxJwZ7TJKxyeZ0P7gn1hA2Rp?=
 =?us-ascii?Q?mQQWfs+Qp0HpkhWgvP/sFDPKQc9fVl1g72I5R4yNewuDqsPkFCZSPhJg3wMM?=
 =?us-ascii?Q?NUAbAMKuzpkfYirCO6PWSIR/hgQDq7b2CekHBIu3w3xbnt/UXtdCnL6Cr506?=
 =?us-ascii?Q?gOwJtMoL7CYpNIeJxbLteLBA2g2ln02911C6tYcUqyWHs15s4tIyLJBsckip?=
 =?us-ascii?Q?tliE50cpnwt2lo6auvkQKaJPOlp904PufsaHrKrqmKg2J5ESLMRHezUTTKqI?=
 =?us-ascii?Q?NB807RFJXnz5rZMIin5xDqtd//iZZf3T0M9GNfeSN9CIY9qwXbO8BfYmiq+M?=
 =?us-ascii?Q?4h9sg9RufLyBBxzN5i1gajkF2YS6Z/t165xPbufoSm26oVzlK8RvaK+3ezHZ?=
 =?us-ascii?Q?VHqfPyniVYAw4h+eiJIjfhxOiJkn2BK1hOzPtnzB32FaDUHks3MFMWCJnB8T?=
 =?us-ascii?Q?WYDZo1Qri3nEj/0MhEtQ9xNNUnT7/3B7H8/MX0XrxcgABFwELb70qc34y6zg?=
 =?us-ascii?Q?kjgcsoM6UmsVfTVLKy/hZfnIh03gBMErcCn2b/vemwHyp6oz2mQs+TTaRErg?=
 =?us-ascii?Q?Y1ZuYvuYfJPTD0CGpw1QDSwa48I418ja3d6Lmx+JnjQRI0QlsVjWqtf6N+e7?=
 =?us-ascii?Q?ifbpVq3d9yW7v1IkAA2/J/6y51dzeXmf63HnRm4S28dX58PlIwGDqU1k0PnF?=
 =?us-ascii?Q?uK7BWHlTSiJcFjJuDRrgGEK4DZ5r37J8GRehD8kPTdU776PrRtUpOVL3IW9v?=
 =?us-ascii?Q?omgnb8fJHrItubKnWf/dCGvzh4BhllGH5zWNKQMXdNR/0umqMshipneAL2Nh?=
 =?us-ascii?Q?a5qFPSbUNSeEifLya5g1b1WixlKNKJ0jdOOiXf0BsH9aGhVcRvAEmfghY9Ye?=
 =?us-ascii?Q?RgVoseq2+5Rq+4Tl9iGquQNd5ecGYyqRrpdEBusOmU0+beqrhVuNdqWZxl/V?=
 =?us-ascii?Q?179XpUhGOz0nXsYU5h5N4ot3Hve8mW8HTaY1wuOoEpS8ojxp/eVmdQcU5IRP?=
 =?us-ascii?Q?5gzQaT3qOym99GCoVFhr/QSYRX1sX9pn0C4eIkVGbf2O6rQoQIpM7JYrqHBC?=
 =?us-ascii?Q?b0OdO9lLhB2aZRBjhg8BJJJS2h86OR1cqpinC0JLOU8rp6aCNggj3EneWOzW?=
 =?us-ascii?Q?6aGNxCLqkY4vDtWGo14R0mAoOUQOCMwvu7RE9aYj0tpNaAHfAu//d/ryr15r?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93BB104EB408CE448C94C53FA1F6E163@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oRfWZ2+XoEGg3+E4Xzxus8KZHUlFNvJGNqMmICpD+VH+kvnZJv2BTv54CtTWRUMNW+rVOKq/L0ZvgjRQrJpkL3bEGfC4oXAXganLru1t6YUw0AMEI53FvWseYLPPFwcalVoNpqsKgRXjTewEOhyZzoRHSCfXns4kwzmG9b8MX+ZpShMvQBFN4pEWNgcwUTGW9aMJVcE5679UAwl6Y0KuKCqIE5Vl9WZi/bkpAuFT4Vm6T/RmOZxMvEJpGexupNd1+/28SAV+odFpYdAyme2Kj1BY9IDnHsefbLs2EddBtHfJzob5z2y7x1WVzWOv8x6z5BolwBKo2/B0rifsA6yZzNK/F3SENv/tYdnBu6UMCJJiYwvWrgX+crJEXGYsiJR888X17yncR6u0mH4KrNN7T8ZGhVHGFONRdKBmuj0elUcBd8tR+fuEgE2zeeD7dI2aMkmDSZ21W/OWN6gMMF4Al6c/P6AhGt6vJMTuk2E9u5JBrP+bwiy3y9vrpw+uCp3bypSNkw2LQjW6C9eIAy+G68ctmO3LFbC5lX/UmJ+Ns3+3Edu5Q1BQTYbHOb/BZjn8nXujqVrud7u0BY0nfjsTp8nf3ulae5y8ZC1ppnSFbz66vaLyc7WsxAidXvXrOEBU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8a6e14-8963-4c57-5c0d-08dc786d1b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 01:35:18.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rEKdFgJrwEsYwdQPKFxrxwb9aRyWjkuLVUyrfa2Is3fTaOmG97kM4e+Zuchfr4LHRexPPTaGWZl2jjFaJq571w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7213

On Sun, May 19, 2024 at 08:20:41AM GMT, Anand Jain wrote:
> The function btrfs_block_group_root() is declared in disk-io.c; however,
> all its callers are in block-group.c. Move it to the latter file and
> declare it static.
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Looks reasonable.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

