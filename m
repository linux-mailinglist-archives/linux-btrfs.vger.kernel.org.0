Return-Path: <linux-btrfs+bounces-10422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E6C9F38B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 19:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6DA1894622
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB83206F19;
	Mon, 16 Dec 2024 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oj0QeJo8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qg6ybGEb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0790177111
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372845; cv=fail; b=rgd8gXDFlqgH5YsNl6T4C+K7f9+RGsXpdMb7kQ5G+3nCJDRPNJ4xGIcarETwqNocYoCfQ7AkBcKz3/gfZ5SQmvHXRzv8X4C5ACloEjqAkiswQU/21HG/FY0tpwU3RTnfS20nnJFKOggg+HxL2e/MakKdrZPz4QR9ADsLdRgfk0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372845; c=relaxed/simple;
	bh=nug52iZejlVTxrxNUTEDJ6//hjr3c4p8r17wq6OI8FI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DOwbFmG7krRITzlTe7Be9W6TG1tyyVLOKUFE1uUHHLos7yKQy/EZWjrIyPR02Ps22xMrVWHPEHAorNZmlc5+yI1jwE+bRv8/FAgeOlPtiDdsygfuNgnh3VVkLGN/J5oA6ccjEz/WWl5K7rpM7eVJQvATaT3rTQ1zvj6FGNAkKsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Oj0QeJo8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qg6ybGEb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQhYJ017573;
	Mon, 16 Dec 2024 18:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=QOWB9w1NeUKAyaLL
	OBttgG3L++2IIaGQvCG2aphI/sE=; b=Oj0QeJo8VZ12OjQtELrBOZHrzzzW9zNh
	13pTgs4UZR2zmGrCDbNpPW0jaNS3718Pmbq4g+okbB6OrR9hmgqnTi0LpESSL9YS
	7arlPCK8zC8DO/KzMmD4dhHOmRH8odrD1Jqki7tNQ85gVBB1r6dMN+Ye2Z6yS5dB
	f66W2xnFZZvmyFpOGZFkqZKKHzejOYUeWGfCE7B8A4nlJknivrNyCYNg+PWOCix7
	X5PeTHgOMX5CgD8a4iU5vo7ta7VmJtLqGjKZDX0veCG04Cs5cNoiCNyrwJQoH0Bm
	jzaYwU3oM2H4Yfw1gC69mcp+dfOHUa1Vmhn9GAxtcnV5Ly1JGIcgzg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22ckxsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:13:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHrIWq006497;
	Mon, 16 Dec 2024 18:13:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f8bvrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TajkaoBD2Ft+/5hbxhtHKe1yeKxRsppomrBJwOr/VH1oHdL+eTPs0XTR+EABMiX30NZU/81lRWtaeW93dpcA7dipJHv7PoyuZVJFZOzw5Whb5kPuoIQhiI7cLIuLuHhNHLN0dTA/rH20RCkLws/uKpxUFtpW4mNWR/FpBVTH3gVvQWKMPhRZaYf2xVdHDJLwL/kyviYOYMh1dIsNc2vA2T+ChwF9Tp74SGHI2lws9Xj6J++nEHg98wVnh/mjCAtXLe71woQ1HQH+OjUEomQMYatECK/DrNPJ/e1deLDl81kLgT6z5QiUJyOpsnPgLXQa4v7ONHYfziFuZvpobOVMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOWB9w1NeUKAyaLLOBttgG3L++2IIaGQvCG2aphI/sE=;
 b=viVs1RrZaBGM7DqZ7sdAK7KgAmKGoBf2oVnXdrIbO7F/wXXFnRm0gHF3xepqmyUEHlXVrZGXy/yNIgRml00wyRnVfqY0VI0yQDdm/G0JCHElToCm1b1Lc7VhLLrZGrutBZx+rGF56T6xnfbVhz69KACJL/4nNDIYtfo+/9+LwJ876beofF9m0LqQs5Gfi04fF4ARoe3esGv7UbeNqZYeyDp3Nym9MsQy/o2C3asrikXfMBSy3y3vfd/oBYHClk13DcMUIX14ZDOWDTlNzx6iPeKJsdtumRIXp38HZWggqnsZSMWYQJmoVgS5HqmfFRyhNdx1fAhQvZE0wHsCwnmk4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOWB9w1NeUKAyaLLOBttgG3L++2IIaGQvCG2aphI/sE=;
 b=qg6ybGEbnZtqzQjxX7vwOWyhJ4wqaQzWKNagPmohyCXXLn7whtU+NpF9Nufl9Z/xEuYpZ+j3Ncv3MNXYlPqMglnFHyBH/FALnie3HorTlNQQ4FgHjWI1JLZg3XN4K26kXAak500A22ZIVt8jiBkprNEUaZxJLFgHmws9jomAIx0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6653.namprd10.prod.outlook.com (2603:10b6:303:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 16 Dec
 2024 18:13:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:13:48 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v4 00/10] raid1 balancing methods
Date: Tue, 17 Dec 2024 02:13:08 +0800
Message-ID: <cover.1734370092.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 361615c2-b1e1-4776-f610-08dd1dfd62ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9fLMdRzMJjfXfro/IFw5D7mGcrDYw2+blQzJH5ERqiyFzZeHBz59FP5nNny4?=
 =?us-ascii?Q?IuWIs/8Ku627UH6VBT+4ABKArCs24sV7UKrGaQNYBifVpqtcscuFoN1dlwdt?=
 =?us-ascii?Q?IGdnLCvzhXaxGu58pId6f83uEyKfVBTR00GVZQTGe+ev5rGw2wBuDJ8aKZc7?=
 =?us-ascii?Q?9DN1cEH8ehLQfAan+vT4OzYOB6h6JlyMT3EsYSNhdkYESzHnc68jGUdd9kbm?=
 =?us-ascii?Q?hIErASG2LitJRcaZ1tYw+UFqU+T5BHvKNUb+/M3gnGa4HYOO5M/5nWxl0wij?=
 =?us-ascii?Q?XeHZXPnzYz2oJ6/Yx4WBinU2QuyZ3BMT22xKsAvAvfJ50vlCDgirmbjMkQOR?=
 =?us-ascii?Q?1DvKJWBskfmoSfrHHWLZg1SE0MYZ70Zdf8klUw3kBJmL1mCZNY2GAnOzoXmY?=
 =?us-ascii?Q?yFmNZzmUkvBySsSU9TtDl9O4a7r5tx9WePBrV0H4rotKKbbh3jPcUO8ozjha?=
 =?us-ascii?Q?UDtwItMhJ8toBX/jeksz+SXxHasObLulM0lJBEbx728dSSUoUb55ghOJDVVz?=
 =?us-ascii?Q?W6iXpAqzj2qzpNR9G+dlUKMvkxaJE63U1K9pr/STcW/n9Sdja2KAE0RhbiQ1?=
 =?us-ascii?Q?4ImaJI/BkHkqm2EMkXxqZ2xuAQYRk+q8UWXU3/pjM5dzMg+2+b1W1xZCYDRW?=
 =?us-ascii?Q?OV8ZTC8yhUhwVe6a/SLrWo8TwJoKIHG+CvpmK+mf/3dT7kMubu8SfRVRmoeR?=
 =?us-ascii?Q?AfvR0DrX18b7fEngV4UddeG5D40tM6eNNchvUocBI+gUyL/dAhW2qHerLJmk?=
 =?us-ascii?Q?aZQBLsJbghQOL3LdYHOzRH8YqKnGWx1tHG2hXMaUedIvFD1hPp5O2nZvOZV6?=
 =?us-ascii?Q?kmLQzpKFQeN6TKQrKijHmzljBTGl4uf0ZyVLvue5aJgyX06LHbgZHBVQOjKi?=
 =?us-ascii?Q?j+fwVm5ksklE3mkU4lyYptLCinwRknwnbHRwj7t98STIVE35GAhodc5zZiRA?=
 =?us-ascii?Q?1e4kbmaj66TwxL4dPpxMi1Yz3RxSlT8E/rSZ+r8zDjO6BdumK2wa0XsQzb3Q?=
 =?us-ascii?Q?JX2DAbD6tIClqn8AfFtQbgLZe3MdJf7Vp2dPEtPZ115HmUcr23JFScBmzf0n?=
 =?us-ascii?Q?mWFK7zmkRmJppPSp9EbCuAeo+FXI7M+X7r4FlgC2/2aiq6FAhT8Wfwchjg72?=
 =?us-ascii?Q?gC8x8ABL41TBD8iuGyqdZl3zTjaqqF3bff3C0SA3HkqAA6YDTjG2umzrkNZg?=
 =?us-ascii?Q?q+/d21GulfI0/P9qO4QJXv/STDLDhfo1IpMPVSZEIGjhapZp8gATKZ3IFiKW?=
 =?us-ascii?Q?vgPMfD39yMHbKcDGSl/DDwOePSABXMBsSRE6ZjRt0HRnWyBzEpz/wVza8ipH?=
 =?us-ascii?Q?2r+nE8eXRnRYySQcPCZqsdgPJ+sXfYBx5uBFoTIxAsjLvLBhGg+SKMPI1ZRA?=
 =?us-ascii?Q?7eLLLvuwsuKQnXCb7j5rUG3wW1pT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YKttboi/vlPhYHXLshDlUfMLz/aMSgMb8lu07m/pZxhLdUbtBsr5rOW7zUB2?=
 =?us-ascii?Q?OK8K16JMit+ykfH3GdDoMH/WxfKGuokj+jjK5BonbMQs95B5r6H7ylcBqMnY?=
 =?us-ascii?Q?wouh9ognYnEK8x3pQT3Cjzmg/mJWTk1LR8o+iVK7rKr9qoGeSd7276fpB6Md?=
 =?us-ascii?Q?JdpjFfDrpRfTPMNka8kHjPHow+zVXYUjwbrbLq7Lc/+Syah39ScWNNkE14ve?=
 =?us-ascii?Q?0Ib/9gXGeBvXfZHY00QNw7/4qRCTSqRF5/Jrly2bfxBDrIX7vvDUjjJKE2fA?=
 =?us-ascii?Q?XJr/LSu/DPtiKu2DoQe0eB/jEiZX0jhD/2gzWXqcP2XAFweTC9Dff4/yLcMJ?=
 =?us-ascii?Q?WJyEmE02T2u+PYM4129w0AhsjaQ9qPI53dhp3KbyAb89xD9FyiMoBSUHzo1b?=
 =?us-ascii?Q?1yrE8JUcAcdD5we48tJz64g/WjXhTBgswgkeZqwBlNXKIbcdfY2ExMcYEGHH?=
 =?us-ascii?Q?H1lO38glXexWwXbY1V3t8LPL+NfWJK2wOQETQxzVyvfr08coMqRGsm8eAeIC?=
 =?us-ascii?Q?yhxRU+JQ4060fnipUR6B9a5VnhdYZb3Skngp2lGzc5fGt/ZmDpr+m/VfKXgs?=
 =?us-ascii?Q?8cG1qnk+ys9bZhA1M20pVopdmllnozwjCGb48vcnY7JsGebp5mP1wFv7LkIL?=
 =?us-ascii?Q?MTR1S9QZ60rouWNj+WSEGNiQGyWC+/PfubU6rwAAfKk8vLWUEVK79PnBq3hB?=
 =?us-ascii?Q?saI1YDsV4lSkyDMbcbXUMtjLUVGKEymKPoPU1/1TUyGr/fH8jlB2Ws5aLCOj?=
 =?us-ascii?Q?yxjxaf2MFq8DO0VJE0md7JIPhRM2OjxJrsUgGyNvgHE8CHzaizxP4mcpki1u?=
 =?us-ascii?Q?0Wx4ek+NXP38vGomXQtFexn2WAZWUkCL7Eet18vH7AyOd9jdYcc3JYWZ9euH?=
 =?us-ascii?Q?gv7xhmEomf/MGv3rpDBNdvwzaC6aViCfSRwqOqs5h72wUSHacSDZmAywHuDD?=
 =?us-ascii?Q?nwFpeslkg9S1AA+1UlhzjCzTfcao/5lR8Vtrg3UhjB3a+OwL4JOh/gVJt6K/?=
 =?us-ascii?Q?hbKJPH8n3Ce/+6WDrunhPNmFzyNPQFTMp2lNL0LN2BMgSMGMfo+0lHvKkskD?=
 =?us-ascii?Q?/3cj4ZLr7GiQdIt9iPGw9gLNDAmxmL3gytOZC5Oqp++8fhrY/xY9mJTi7Zjz?=
 =?us-ascii?Q?I3SYajYbh4Rh1K6D+h2Hr2FotIcAlVKx0QGxJnS4z5ADxhtnEfRcViTDn8pF?=
 =?us-ascii?Q?qr3LhRmWuwmmLQCVqrxy77ct65QzdPGqmMoxICB8pGOPUuPHzFRhXBLXsmR2?=
 =?us-ascii?Q?GGWVmEUUTt88MsF51WPIqd6n2d8mqwW9tKzZWAtplvq77WJs6FCqVGEGWnFX?=
 =?us-ascii?Q?1s29qFgLxg+cyvT+YrmmBWqQRzSMvnSzqZ9f16V3zSqqrJHfNSRgHOkxZJHI?=
 =?us-ascii?Q?fL5WT2waeTFeHCGIm06elzHrJRIM8WGYl7GJxhgCC9TN7gt+ZFBLuGQgIA+3?=
 =?us-ascii?Q?yZqRbnmXlaKoxgI5PRoqytvMhqy3oZxx43sTaoT7L9wBrnkpgAOwTk9KMFm/?=
 =?us-ascii?Q?O1t/FeuMXbr0xoPMw0po5b+oXQWSldySvNsepUWetMKvL17XLHR2rnw8TdJ9?=
 =?us-ascii?Q?GRMjaiI3xp2xU3WWvt5WdmdGR3z/ADEPdALwppZT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jj5KUBoX6qmjmNUoeFO7l4mylzKNXXTk+MxcQumTSm2/x4gjXsJ28Nn60YimwYnRuvIySvAunYO7+ITJzI8+fNIwAPFnY2VPv2gWeT1axrSLI4s15Ig6KKV6ZfM28nwCkMJbMG1hszQoS991+43Ur2UTTmL1uB+IHnnYh3VeQqASYwtG0S7rU15CcmbVHBUie/SHGfllrhV9yFOh2grLRLFazL/JfUiT2dgq1W/puYZd2hVr4A0q2/vdF7z9QEAgj3Or2t+r5Ha+MsNeIzmE6/yLaikyJD6gAtAdknlqRC2tu0UCoZdPw3yAtLhOiyyUI2j8m6mIcMuSj7kpV34Z+mdKeI3Bgodo33Ik5v7Nx0s0UGOCOUg0jXN9SxSQmOTfB/ZacHXrPUCbjp2TAmTkgkAUNKGWw4mp1grPrqHHYPzlCCiU7Pn2F2VIno+uvAjocz857Fa6UreJkJJ/Ko6QkmWkCvO/d5lWOhvkmHgyvahDNgQ2mfcg4uLF13RJgnaSazWCrQ/t+dqFBGOvkIkoys4YK/W+d4r2eXiF38DBgyFCVFbvt4PN/ajvJlNF2D2cohEBggXcYbZy3jZTPxiXHJkpdTg2ZIsT31oY7mis7R4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361615c2-b1e1-4776-f610-08dd1dfd62ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 18:13:48.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5kNS1d9zZlok5Hm25ZCXMtQIW3BrtJ4XxzwX+lxWLKejvcTmmlXxdZAZdzHAzI1LOenxrWmab+1xpcVUDOTzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160152
X-Proofpoint-GUID: Sdw2KOJpPEqbSQoNtAwQXSa3Cd2PjSI0
X-Proofpoint-ORIG-GUID: Sdw2KOJpPEqbSQoNtAwQXSa3Cd2PjSI0

v4:
Fixes based on review comments:  
  3/10: Use == 0 to check strlen(str); drop dynamic alloc for %param.  
  4/10: Add __maybe_unused for %value_str in btrfs_read_policy_to_enum().
	Return int instead of enum btrfs_read_policy. 
  5/10: Fix change-log (: is part of optional [ ]).
	Wrap btrfs_read_policy_name[] with ifdef for new methods.
	Use IS_ALIGNED() for sector-size alignment check.
	Roundup misaligned %value.
	Use named constants: BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ, BTRFS_RAID1_MAX_MIRRORS.
	Mark %s1 and %s2 in btrfs_cmp_devid() as const.
	Add comments to btrfs_read_rr();
	Use loop-local %i. Add space around /.
	Use >> for sector-size division.
	Prefix %min_contiguous_read with rr.  
  7/10: Move experimental to the top of the feature list.
	Use experiment=on. Skip printing when off.  

v3:
1. Removed the latency-based RAID1 balancing patch. (Per David's review)
2. Renamed "rotation" to "round-robin" and set the per-set
   min_contiguous_read to 256k. (Per David's review)
3. Added raid1-balancing module configuration for fstests testing.
   raid1-balancing can now be configured through both module load
   parameters and sysfs.

The logic of individual methods remains unchanged, and performance metrics
are consistent with v2.

----- 
v2:
1. Move new features to CONFIG_BTRFS_EXPERIMENTAL instead of CONFIG_BTRFS_DEBUG.
2. Correct the typo from %est_wait to %best_wait.
3. Initialize %best_wait to U64_MAX and remove the check for 0.
4. Implement rotation with a minimum contiguous read threshold before
   switching to the next stripe. Configure this, using:

        echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy

   The default value is the sector size, and the min_contiguous_read
   value must be a multiple of the sector size.

5. Tested FIO random read/write and defrag compression workloads with
   min_contiguous_read set to sector size, 192k, and 256k.

   RAID1 balancing method rotation is better for multi-process workloads
   such as fio and also single-process workload such as defragmentation.

     $ fio --filename=/btrfs/foo --size=5Gi --direct=1 --rw=randrw --bs=4k \
        --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 \
        --time_based --group_reporting --name=iops-test-job --eta-newline=1


|         |            |            | Read I/O count  |
|         | Read       | Write      | devid1 | devid2 |
|---------|------------|------------|--------|--------|
| pid     | 20.3MiB/s  | 20.5MiB/s  | 313895 | 313895 |
| rotation|            |            |        |        |
|     4096| 20.4MiB/s  | 20.5MiB/s  | 313895 | 313895 |
|   196608| 20.2MiB/s  | 20.2MiB/s  | 310152 | 310175 |
|   262144| 20.3MiB/s  | 20.4MiB/s  | 312180 | 312191 |
|  latency| 18.4MiB/s  | 18.4MiB/s  | 272980 | 291683 |
| devid:1 | 14.8MiB/s  | 14.9MiB/s  | 456376 | 0      |

   rotation RAID1 balancing technique performs more than 2x better for
   single-process defrag.

      $ time -p btrfs filesystem defrag -r -f -c /btrfs


|         | Time  | Read I/O Count  |
|         | Real  | devid1 | devid2 |
|---------|-------|--------|--------|
| pid     | 18.00s| 3800   | 0      |
| rotation|       |        |        |
|     4096|  8.95s| 1900   | 1901   |
|   196608|  8.50s| 1881   | 1919   |
|   262144|  8.80s| 1881   | 1919   |
| latency | 17.18s| 3800   | 0      |
| devid:2 | 17.48s| 0      | 3800   |

Rotation keeps all devices active, and for now, the Rotation RAID1
balancing method is preferable as default. More workload testing is
needed while the code is EXPERIMENTAL.
While Latency is better during the failing/unstable block layer transport.
As of now these two techniques, are needed to be further independently
tested with different worloads, and in the long term we should be merge
these technique to a unified heuristic.

Rotation keeps all devices active, and for now, the Rotation RAID1
balancing method should be the default. More workload testing is needed
while the code is EXPERIMENTAL.

Latency is smarter with unstable block layer transport.

Both techniques need independent testing across workloads, with the goal of
eventually merging them into a unified approach? for the long term.

Devid is a hands-on approach, provides manual or user-space script control.

These RAID1 balancing methods are tunable via the sysfs knob.
The mount -o option and btrfs properties are under consideration.

Thx.

--------- original v1 ------------

The RAID1-balancing methods helps distribute read I/O across devices, and
this patch introduces three balancing methods: rotation, latency, and
devid. These methods are enabled under the `CONFIG_BTRFS_DEBUG` config
option and are on top of the previously added
`/sys/fs/btrfs/<UUID>/read_policy` interface to configure the desired
RAID1 read balancing method.

I've tested these patches using fio and filesystem defragmentation
workloads on a two-device RAID1 setup (with both data and metadata
mirrored across identical devices). I tracked device read counts by
extracting stats from `/sys/devices/<..>/stat` for each device. Below is
a summary of the results, with each result the average of three
iterations.

A typical generic random rw workload:

$ fio --filename=/btrfs/foo --size=10Gi --direct=1 --rw=randrw --bs=4k \
  --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based \
  --group_reporting --name=iops-test-job --eta-newline=1

|         |            |            | Read I/O count  |
|         | Read       | Write      | devid1 | devid2 |
|---------|------------|------------|--------|--------|
| pid     | 29.4MiB/s  | 29.5MiB/s  | 456548 | 447975 |
| rotation| 29.3MiB/s  | 29.3MiB/s  | 450105 | 450055 |
| latency | 21.9MiB/s  | 21.9MiB/s  | 672387 | 0      |
| devid:1 | 22.0MiB/s  | 22.0MiB/s  | 674788 | 0      |

Defragmentation with compression workload:

$ xfs_io -f -d -c 'pwrite -S 0xab 0 1G' /btrfs/foo
$ sync
$ echo 3 > /proc/sys/vm/drop_caches
$ btrfs filesystem defrag -f -c /btrfs/foo

|         | Time  | Read I/O Count  |
|         | Real  | devid1 | devid2 |
|---------|-------|--------|--------|
| pid     | 21.61s| 3810   | 0      |
| rotation| 11.55s| 1905   | 1905   |
| latency | 20.99s| 0      | 3810   |
| devid:2 | 21.41s| 0      | 3810   |

. The PID-based balancing method works well for the generic random rw fio
  workload.
. The rotation method is ideal when you want to keep both devices active,
  and it boosts performance in sequential defragmentation scenarios.
. The latency-based method work well when we have mixed device types or
  when one device experiences intermittent I/O failures the latency
  increases and it automatically picks the other device for further Read
  IOs.
. The devid method is a more hands-on approach, useful for diagnosing and
  testing RAID1 mirror synchronizations.

Subject: [PATCH v4 0/9] *** SUBJECT HERE ***

*** BLURB HERE ***

Anand Jain (9):
  btrfs: initialize fs_devices->fs_info earlier
  btrfs: simplify output formatting in btrfs_read_policy_show
  btrfs: add btrfs_read_policy_to_enum helper and refactor read policy
    store
  btrfs: handle value associated with raid1 balancing parameter
  btrfs: introduce RAID1 round-robin read balancing
  btrfs: add RAID1 preferred read device
  btrfs: expose experimental mode in module information
  btrfs: enable RAID1 balancing configuration via modprobe parameter
  btrfs: modload to print RAID1 balancing status

 fs/btrfs/disk-io.c |   1 +
 fs/btrfs/super.c   |  20 +++++-
 fs/btrfs/sysfs.c   | 173 ++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/sysfs.h   |   5 ++
 fs/btrfs/volumes.c |  99 +++++++++++++++++++++++++-
 fs/btrfs/volumes.h |  16 +++++
 6 files changed, 292 insertions(+), 22 deletions(-)

-- 
2.47.0


