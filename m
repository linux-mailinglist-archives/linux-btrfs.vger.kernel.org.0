Return-Path: <linux-btrfs+bounces-11744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A35A41EB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 13:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF0D67A39EE
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 12:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B4C24EF72;
	Mon, 24 Feb 2025 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mw835ivN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sLCXniwG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCA1248883;
	Mon, 24 Feb 2025 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399345; cv=fail; b=DYhvzDMJmXmEAOZ7oAgYlYb8lQtT4kXjyFH+R94XHUpVWyah9pLfmLXXzrcUUA9d7L0Rffa2xJv3Ygl6H5UKZJo2eujduLjfeLo+2fctr+xB2EZJTXPQ5SjdfymCOn2wIiaWho6LjklbqfXSkhBM+N1neC6h2tWGzGi6yE/WKTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399345; c=relaxed/simple;
	bh=/r1erW5M9DeTEr2Hw5IUjHm6vNEz953NjoxdUb4UqG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RZZywyrn5n7+/Cf/QrEISK/z7IwO6a1vYAEbogP0Snv1+bPUXd3ccPGbVMaa+kRjBvyW9VGuKotXgL0bN3u0xQaecGhDxDy5Y5YJrTmo9Ohui1UICw0SUozouI/yp9dV0BCm0nx5USRP4HkrE/6Es5JiqLfJjH7m9+F+8YQqGLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mw835ivN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sLCXniwG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMmtj007222;
	Mon, 24 Feb 2025 12:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5VYS6OjdHVQnQ1Z6z44VkahZC8p5/zlSSfyjJajYN9M=; b=
	Mw835ivNY50LU/0yXJokfPH0chQ7/dsS1Ba3T3ZVscxicE1gtQ2AZIf1xAwaSp80
	5S4/a6jhyEMkVsRcYX8bYRNeOkN94faoljuLs9A8D6Xoaw0bd8wEqukW+qkV5s2u
	as0hFLR33HScqRb2VvMFg/Ema9J0jdbBGxwi0InrKanwOicvGl3iSrR2l8lSsvqK
	zeOECFzed8R76o2w6NkiJ68HaSYfuTUZ3njwj3Y4+uBNRM2C/PEih22QMY+lUx65
	YmWBQ8ajCykfG0eYlXikt1WcIl9t1AkQY/CkRhk7uqZ5ENTqpesrtsiDa5z6Gst6
	c4DOXUjUcJnh46OxvX6G5A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5gajeg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:15:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OAVLvA010336;
	Mon, 24 Feb 2025 12:15:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y517aepm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:15:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZvuwRCkvhE00vHfggdIRl9BZx1b2YUkcJP5A/FpLqjck4m5cpOcO2PLfwovF2WF34SaVUFI/w/5aq7FZKnshJjPI3K7Pfv7yOMCYVYYwQlbSbgr5X5XH+WA8SPKIOrDex2OxC6d+Kuf3SOAn0Tb1/9BScY68lDwrc4mO/p1BrArI0DqvefIqI2stWrER+5VHQxhss4Gd8bSMgj6XfXYIX1n/X/tgQp2VLc4rEAKQNbqrAOdesS8+on544RghXV6xni6W26tdbR2y/GN/LE1UP25GJUSwAgTRUlJWogccWK7tn7Cjx5xaiFVvvUOr7nGaqXb0RuzUACVeq1zNp1PgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VYS6OjdHVQnQ1Z6z44VkahZC8p5/zlSSfyjJajYN9M=;
 b=lydQ3FcuUHARpew0dNEPixm+yHQkqqPCfb6m7CzutJLEpzzVJTLicAUOJlX1LCrpW8waKpkIHdMwbFC5LMIlWCaXKXlXP1FnBkEDbZZm230e49VGsWqaqTPTdiiy1y+Fcz8BaWFv0sNXuAtC2ProxUpIi4sBeCck0dtNNsvQg/BKyyYz0ynWxscgCGuRSzAReO2K7fub8Mrk7efESytABYDrByKYLYbcr4mkJGncu68Godnz3j4dP+m48+98Tdj1qsTCnX/KCEgsKCwDhLZxnuO5vSxKtTCv4LKt8kRvRrIJNAgPyvHaIplnP+722kk/lfJIgOFEmkxWJefZdQO+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VYS6OjdHVQnQ1Z6z44VkahZC8p5/zlSSfyjJajYN9M=;
 b=sLCXniwGpfI+VriNaXVxh/yn+rkhR8t0etAX5WFeUTwO+ncTIAhAXN8hiS0BFnVHveO0DDLld6/JHp+bYw72oLsoJX2JuC8VUWlBNh+JlcRmEyo3aqTHOfmDxTVu46CyYiBLXJA2zg3ktOv3EQy14B0ejPhmRjGVlmnBwDd37Uw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7202.namprd10.prod.outlook.com (2603:10b6:8:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 12:15:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:15:39 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH v3 5/5] fstests: btrfs: testcase for sysfs chunk_size attribute validation
Date: Mon, 24 Feb 2025 20:15:08 +0800
Message-ID: <f4a40cc908ca3a5310c028878f65271ee7d665b3.1740395948.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1740395948.git.anand.jain@oracle.com>
References: <cover.1740395948.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:4:7c::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: d7414c1e-072e-4805-c6fa-08dd54ccf365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OksWLnRY9Ts1meBJhbZ+DfYVplvS1lvUiTXUUKvy/ZQjhy8rO0yZzpxSxQo6?=
 =?us-ascii?Q?oettOlpV9mP++bPmpwO6EvyD7ZbG9zbE0UoeZEVPEbgvAVaZl00FmgRYIn6n?=
 =?us-ascii?Q?JL8C1aXfcDRWJ33P0MvDaZLFWbQx/CrlD5dMb3GxWfQ3rPj8HT4LPp4+igRN?=
 =?us-ascii?Q?RLwCRjoYVFbc1OyYMvYFxyzmGQJLs81ncOTcg8cK9fbUupAZJgGMuEzTZ7cm?=
 =?us-ascii?Q?0V3I3jsujvFRJjRDmXzkUtNYtgcgcpqbpoH54XpCgh9dMRT3B4nUwl2iRsGd?=
 =?us-ascii?Q?g4fZaI1NvmZmDDOKarqknim5t1Wl/y1WIkLoGmAAKvFm5S77ezRHozkTbmMU?=
 =?us-ascii?Q?c2dBpzpIAqA4+ZKuFKIk7WtmT1gIMFIskMHeg4Ecg3/kufPfvGYeF2UWmTA2?=
 =?us-ascii?Q?YXhfoFgBjoDndtiXavSnZUAYtkod8ED3cuHGRyaOPZ6PbzKv+OS+DPsFbU0Q?=
 =?us-ascii?Q?bUdCWUd8XW1ZJ9r7KSjZKmiknaVDmLOVJN8t80Dil+l5CblJZtvcXmMLm6um?=
 =?us-ascii?Q?ZsYgGs4bJYwzB7bOwdqKHoRUvT9vmpoKBq5OL15f+BcCwbUSObKV+ijAb6ct?=
 =?us-ascii?Q?Dc3t7sqT1g5IwpHK6yqJblygK0ObTaczIT+OiaInrc+gW2KeGBtVC/idey74?=
 =?us-ascii?Q?YUrQyX2joq8BFLtYd6k78ggM8dJwhzU16sgJB0re0r7z4kG10G6qi/Y5+2V6?=
 =?us-ascii?Q?juYNPoVAI2mfAF/KO6dArjgkbx12wNe8x2mZf8E+HgDHHB5lxsDxmMBcxjhT?=
 =?us-ascii?Q?7yn7o2Ms7hCE2liSIDydm2gDJjaY9et1mX/ZwCurQYG26q8GSWO1MLOV2Awo?=
 =?us-ascii?Q?dtikU82/LpAGYoif4m3zrWhcyso9T8AEqM2WcuLRZXCZAygtKzsPY8Hq4byK?=
 =?us-ascii?Q?LW00oa4IvJOp2ZtzVHLEUfYyGVTeHvg1DEO5YL+uTWoNmqmhcLj7koa5j5K+?=
 =?us-ascii?Q?hpvp9BcNx4GbJsYAmSlFBrf86WeQALPbLI6KePVDT9+nI2DrC6+hHa1Nm+6M?=
 =?us-ascii?Q?CzxfjY3v11WpjB8lhfPOz+oZVpWEcILBCOP64r6++FHvjEvrmebqRqDnM1K+?=
 =?us-ascii?Q?InfuzSSGbnor6TCNhK+Y90PegvhWfoKiIVKlWQ00GYgx5+eYiQHVpzO/7Ym3?=
 =?us-ascii?Q?hfHp+wa+cDH82N1t9/Yf6n1ZjE0jaOIG2X5KF9WQKGuk1z1BoY5kyKzH5W8M?=
 =?us-ascii?Q?ZG6o6k0gzbGHw0lA8MsLPvsOtLSXyR+D3f9tjHXr8GeXY8keAIjqxrgNDCZ2?=
 =?us-ascii?Q?urT5JDXaUl3si96AsTbDu63RkHzelixhLyAaTfl4twV/k4m7cnjn2wcQ54To?=
 =?us-ascii?Q?opOsCOGDETgYiU1jZj4NOUqNJK+CLq2PmRJbcrN4ZT8nRC9hAq5dXj4DNoQk?=
 =?us-ascii?Q?JfOKqbVocEoVhhCvGt5KFFysVAzr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jBHRNNZhL38Krjku9A9rr4HWm6njR+9W1IH1Pkm24AmMrpX7CCzBus0CcKbl?=
 =?us-ascii?Q?Tzzgug0he1xCq6SqtA1vRmFMHWKvqGXrmM5F7nbdYQHN5UBNjk9I5NPGIf2N?=
 =?us-ascii?Q?1g3kK9ZaXwftFuw64PPTEpj2jcRb1dTKZgVWLOMyFSVuybOWyDsFdqCAvuxg?=
 =?us-ascii?Q?J4w4Rsku+zub/NPfKft2phqgMZII8S1BnYBEkhQBeBTGesYiUxwXB4Hp+lLo?=
 =?us-ascii?Q?qbBfPssllyu1kWWshKkeASVME2yBqbcX6/tUyJJh4cjZUQsK6p9FUNpHiJhJ?=
 =?us-ascii?Q?jOIZB1XpkCBjB+kmI1dZnZan67qmmr3xj7ahGrUhEzeeRZkDNkY7wJ1jjQHz?=
 =?us-ascii?Q?pOljtcsC0TCv05x/rrQ00dp7WY/9yYyZXCj9neVIYVEqTEPJwdX1K0ltLCwf?=
 =?us-ascii?Q?iBJxuYuXvK8j6cR5ztykY/YyUDpVla+XMXT/COQLJdYYYhiqMPNi3ovaQ315?=
 =?us-ascii?Q?pm7dx9XhyNLdY8nkxrOSdmKssY2aTXmBxpC6fy22F4vGK/3QFD5ZQj2uXjUV?=
 =?us-ascii?Q?5qxrE0higJ7rkpP84nkyxLAZrZ7OaWp7Cu6Plrx2fazf/O2Y4MUMogvlkVQe?=
 =?us-ascii?Q?SCPcOThMn1Pz5f3c3hGbXFYi70EqdMydpfs0UTfacZlBxF6kVdwB1aFah8GP?=
 =?us-ascii?Q?A0uQc2RxPOUR854+ue8TXMaXB+y70dQSAqxfvF+u0SKlCqnyPoubycmuA63J?=
 =?us-ascii?Q?jvTBsas4Ly0uupf3/BqWZVtpYDvW6wT/zGfJ0wPsCh3NSP/2uwj5uBY4Ci6P?=
 =?us-ascii?Q?CreTVMyujEvDCn7L54GuLB0ZdxZPlcHnvz3DRy3Z7DbTTbYVGc/1B2dFh8eK?=
 =?us-ascii?Q?4DBLV5MNMxLkcZ8IuBAex0z9kOFFci4brVCQCkEn0iPfkaZRWzMORZ323gJ2?=
 =?us-ascii?Q?ZEAF1iqsTvihelk8H8OuWywD4gd1v2d+5HgF+PRmStZWis1C1Rb3ApHVy2To?=
 =?us-ascii?Q?lpv/jerXfSGm6QoS6ij4DMzkGPJmhucNXfX0PNaePhAP0OMKhlBG6CutUiqR?=
 =?us-ascii?Q?omjs4JpquLukevY50yzdudIXQlVmlLn02sqTLsxpICJ1ZqMiU5WFlEFKS5Vv?=
 =?us-ascii?Q?qj3fFaeygEbFOoTYgGLc1v1J7m6rUp8SAKTRowOTTrYsemEJ5RY/HC9yiQRv?=
 =?us-ascii?Q?o4vxStsobchGJLezpQpvdNdh62r2vKxvdz9YAMrxOlAeK+iaXFFTSM8FeDce?=
 =?us-ascii?Q?gaR3gg4hMxyM5+jjgUdh/CMSsmuxcoPWWbkNlgcs3z2FjGV/xQdy5309e3kF?=
 =?us-ascii?Q?4ifD5lPt9bDLdPNV0jlFhyCr+qkKyPB6KbjeNXQQXap7hhSdt5ggYFxcr4YA?=
 =?us-ascii?Q?kzdKEZTBht4ah4rNq0S00y6XNewn2ny4wnmToL4gvIyVhkBgflVMIU7RdBCs?=
 =?us-ascii?Q?zSsBUTyBMtmlc13g1W7a55OWeivHuVxJVxMrnXNQVcwUmbaDY18dXf4N7Hj6?=
 =?us-ascii?Q?fCCn+i7p5lIA8vrculudHbxr+o8sc5X/RgPJRLc4axqJSRS+fGG5Q+7EkRsq?=
 =?us-ascii?Q?HMuCJVfNTmJF3xLg2R2igAg/eZjtjHlDZPBcZYK4QxIuQOaAnIHcjdPE1JBP?=
 =?us-ascii?Q?/wUsWkXh/lAt4PVrtf6eoO02zMYcKdonLNbShuQM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kMPG8jkD/GF1dacSDsKlcfVzASXD/xv11jB2Yt3Q+IYBVXW2UGaxxw1gpGCfcb4hXdPWwRbeovT046070kub5MFUFugspFtzrcSWskVTD0cjKck1aXyhRzfc2gPP7yGM6SUP6SEyU7u/owPy0FRuBe9UnlCh4Ol5cEFQuWJm9VtNP/5wzFvRgpVbEPP/xn8Ic4mgape/Rty8r9ozY1OJKDsL/MXGlmPyDzqLQ2Y9Z0Ip0IJxNjEJNkPKSTVQ2Ie3CsVWqIw1O1ci/A2SMst8rsJBpm5JVXyDiGiLPDBtF4Dn2l88EFojWgMaEvoTgJpHBjvJavQyTdkxqfYn2cE/NqxmZzXQAoFb4PL2h9MGS3ZwtpEc9FsMoLmmRH2QSWTt6LV53ohZ/iAK5AOFyeL4FOArkL5NWiaOQAkF2AyaHXI3LiZnbplhPW39oWFa88nmOtciMG+p7FLe3CBXAlWAEHhypCezlSE48mmHyFItMseNfzx3mMXcOeZug1tR5T+NdeNDeUkTHNshRkaneqNXpu9G3yjZ8idCk8nm27d0I2N0xh6HLFonatc9LlAqYM+2lxWRAIOw468yQKBeLFrE4SarBVAu7+REwL5sZ5oghoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7414c1e-072e-4805-c6fa-08dd54ccf365
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:15:39.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bPSLZgD9A7wsk4+dmE7uoVePkLnYfskIaoPhRUcGaRg7ajhXaSCByBVGFWGJSv2U2xOgU1sZQmtvmonpXVLgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240089
X-Proofpoint-ORIG-GUID: bxjmxFK3664OXVfhXkou54fQ_21xOEDN
X-Proofpoint-GUID: bxjmxFK3664OXVfhXkou54fQ_21xOEDN

Checks if the sysfs attribute sanitizes arguments and verifies
input syntax allocation/data/chunk_size.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/334     | 19 +++++++++++++++++++
 tests/btrfs/334.out | 14 ++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100755 tests/btrfs/334
 create mode 100644 tests/btrfs/334.out

diff --git a/tests/btrfs/334 b/tests/btrfs/334
new file mode 100755
index 000000000000..532fe37a0489
--- /dev/null
+++ b/tests/btrfs/334
@@ -0,0 +1,19 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# FS QA Test 334
+#
+# Verify sysfs knob input syntax for allocation/data/chunk_size
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/sysfs
+. ./common/filter
+
+_require_fs_sysfs_attr $TEST_DEV allocation/data/chunk_size
+verify_sysfs_syntax $TEST_DEV allocation/data/chunk_size 256m
+
+status=0
+exit
diff --git a/tests/btrfs/334.out b/tests/btrfs/334.out
new file mode 100644
index 000000000000..f64f9ac09499
--- /dev/null
+++ b/tests/btrfs/334.out
@@ -0,0 +1,14 @@
+QA output created by 334
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
-- 
2.43.5


