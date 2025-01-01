Return-Path: <linux-btrfs+bounces-10662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3899FF4B3
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 19:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A8887A12F3
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 18:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079611E25EF;
	Wed,  1 Jan 2025 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lxG+igXP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GW+tH03D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6A33EC
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735754995; cv=fail; b=lJqIdzW4T7g/r48SR/JTimTlvrBSCW9g04ESrYVzRpCgGKzXlEfcnl3Z6TlXUC49kdaTuf4C65KGhK6UKsGFSXgtTJXv06bwikyFGbgLw/WrPayNFsbnLaIcqusm+97JnrFdLtJT4JADrW3UO2AJXBY+jfnimyMh+BQIhtCOH5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735754995; c=relaxed/simple;
	bh=gK5PfS41SlIi3q0cIYcfmzd/wFscMpz8fLi8fT815og=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b/r7MnY4fRjQo98KEjLQQwYVeYrRPF7kNiO+zulN8PES4/W8FGsayCTAad+8/uVAuVq9GkrViKAoSK8hW0LVctPY4xdVIQfEpu4egjiLg+BD1Qb/NtD/Dh8Zpc7l35MgxvAbC2eKusNQnWRBzuicu1idV+cavp7mxlgbZR9XNj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lxG+igXP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GW+tH03D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501HtpQg027468;
	Wed, 1 Jan 2025 18:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=sfCZIgTmxaAsPyzG
	qTgGeo4gHNyI8GCigub+YZINVjo=; b=lxG+igXPQ7QDNW0GICZ5seqVrwbZ9BjA
	E3s5cQylKN8GEgfaMLmmZtyySAEXsCuxMhrM9zRdhhu52dp38R7t3snCuBmOfRvu
	uZwWv/+ySAJZhRwESBT5YfUWeau2gHLWRzo7OGgfy+oHpeoge8amMJwf7Vjt7KRq
	CsMO+mF3PqbGNdJKCCTYtSky7nSC4l5H6pfx4UzjxOSrAWEma5S3R8+l2eTEoNs3
	Ol//gqFh+Z1lrmActGYx/ZKUO8L6uAtuCIQHFvgnDPg6XuMgpaFpEPAnudwfrrC9
	PaWX6Psj941zwjBcQUnIaFGbEC8856EtErfZAEyy2Tm+b9A2V9KjnQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t8xs4f03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:09:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501DBnwJ009521;
	Wed, 1 Jan 2025 18:09:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s7wv2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEMnDOb6FMY36XetZxuTAUVceWHgObKUE7N3PpzMQmiz+Kb5sFiFRPqFPdubuRD+Ff6cVbBj+uw0XKZHOjnsJhAzW/FYKlOY7BY1HWcWbqCdXmYlr9aFIfPF2nE/Kd1Ml8B45Fr8L7W/xIglQtnsNWNQOXZZ1fdVxmcw5kJfwzgSRHdo7Uzr0PXsdxZC1IOhhz7uuqmQ0mBz9th+OiNqmz1YdIyFz8oIeq9YtR0NDZt670rhsJ/+UKri0LhFsWtM1oiA6X/G+RRvkdMkWxW7rq77Q3NXHIXcajd1uAuuEYi9XXt3bjDlGWZ2J+sJYsW2uTAE+Q2aIs9rESM/Y6WIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfCZIgTmxaAsPyzGqTgGeo4gHNyI8GCigub+YZINVjo=;
 b=gcrqL4zpiYyYRGGyERh1bkBP9dBLYrvTZ0/Iqu1PjcYgjMpnq/LR8FlVkNfdssFecvcoZgQEPGNPEVm+URWc/Ob6wqjyXjDwoDr+Yyks7gKlzQk4iXMLBj5hNSot+nvXEuklid7x944EnuS21R8rTvH722bUZj9dxDtngPsdHWvNL1NjMugZO1wD45ICAHLo/spHyQNzCa0mBMFzr7pohrUTCmBOBPHYxnqJC4eOVmGgwSOTsyg2RsfDxAAiJD+pbf6DEYDmKZWlJdA3Ha0L7NLNmZ8IStWaCymPEtzPoDURrl8Dr/J1Oc+oAopCMxcBb3yOyJHi5SA0QcgMKDL3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfCZIgTmxaAsPyzGqTgGeo4gHNyI8GCigub+YZINVjo=;
 b=GW+tH03Dep1FGj87BjHmUlgI/RamCpMLWni+W+G0BYYCqe/+knfGn0MA1nLYOba/OuwQLgPCd9esDotxeBQAb5uQR9799IWuzLggU7y9Aw22Sc9eN2Zl2ktYqESInmhJBmcgObIpXwvP4w7iedfCrcpddjGtTIin92FP/3HOx80=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 18:09:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 18:09:28 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
Subject: [PATCH v5 00/10] raid1 balancing methods
Date: Thu,  2 Jan 2025 02:06:29 +0800
Message-ID: <cover.1735748715.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: e57872c9-4aa4-4257-9e89-08dd2a8f6e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k2Ke7QjtfgXf4scKglI2tLcf2jvogTnlvid++0WSCW5SbFwDhea8/SbnlyUo?=
 =?us-ascii?Q?6vCyXNf60K3XrvTZ1RHn1kGn0AS+2qaXmqaZvBapw5B628FltNajJOV2d4Ze?=
 =?us-ascii?Q?rlka8wAc+9kZ3AMDbwXIAxecSiF7Pad4uPs3BwT4xyElGg/r5lvaZ6NJJ6Ln?=
 =?us-ascii?Q?5CUGTNUfwTi+zwisHn8D0LIgZczHm3qMLZwhKFyNWNsM8uYD5AgtItqI+6F1?=
 =?us-ascii?Q?yBbFtzXOQCJd1uADtZJyCp7+Th0wta9h5dtL/TPWjmpBoFyI+kWF4QvAJbz3?=
 =?us-ascii?Q?Gt0bUIqv5ztCN7VL9FjnkGMUYRXYDnW1sLf6pZlJ1dc/q49LipLu2rv9A6v9?=
 =?us-ascii?Q?rQHOcPn+UndKtVtRurtyomxc3jkcgaMg5kd4cbXsx2NXIPWAvdqsvprJBWQW?=
 =?us-ascii?Q?AeV7xUcPWy739D4+ocDZfm+Rm2IwiywwdXnvlJtWxTvARWmdsXHBhbIx5IAr?=
 =?us-ascii?Q?8l0mfEYzX16FiNkp9OOjjVt2iOjxpJEcN2VSS9RgE16Q6XMUdADz5wlDw6wz?=
 =?us-ascii?Q?uoVmio+RWHTHHVM7fWBMtyvb8VAD4VbQpCeBiupgrpxz5S7cn7sMz+8+yAQG?=
 =?us-ascii?Q?rvDTQrahhK9eS5N2VQXB0/QurNwyhPYHodCy+Qb+RDFDdfMxPw/CMlPmhA91?=
 =?us-ascii?Q?Ew10dMlQUZNBC+Kth0PwRuYegkLKv0CLBCarJ4V4mMcTbaiVvcqBQ7+wgLwa?=
 =?us-ascii?Q?OCB+bzpiuv/uqD0VMyTEmJgI9ay+gKZlbnjqUOSDalHzbo+CLvYC1Zjdv8pn?=
 =?us-ascii?Q?lUAjGLVFgFpeZSdozI8IeO7yAEmniOtwFBdJ0h1b7mFHec6ZgBbMyr18v5h4?=
 =?us-ascii?Q?avFyDKJejg6yuUAiqJ5AHNVmnJagbNg4H0rheLk6azW/ouTUWi92gdG2MnLg?=
 =?us-ascii?Q?cyq/Jjs2F4M/o6FobXjpabNg+a0VTPv1Fk7g5k14a7RHH39sxEYXr5zdO//V?=
 =?us-ascii?Q?+3My2HtJtMdd51gjCkmSDj1OuaPs8moFa/BOkVXkFiNc3LFhG68PoCzmwtR9?=
 =?us-ascii?Q?xZ4oFcjhZMselQTbyHcOn3lh10zxjeZUn+SBJ3M6Iud8mAHVmYpSNWVk1oFI?=
 =?us-ascii?Q?PafNoD42Nx0+8aUW03k+7tYgt+0nbj/HpRkZb6dRQSNwmEY0pngG52mwPSZr?=
 =?us-ascii?Q?kFrBkkFi/zDyqgwPj6Vszhl1c5erCPIxkMLHZEAyHjLDbD1BuIYBxpO6+G9j?=
 =?us-ascii?Q?M2rV3SAfDpXgNm97U9CdUL+PLzuMbCNDa6OkAi5rbpfL4Ri7Qtac3mxPIub9?=
 =?us-ascii?Q?CLnKdr17tfR/AgA9LLDdrIi6NN1PqVa5bz7R4TalOw7hib4kDPeaJfiSRFoC?=
 =?us-ascii?Q?rJXXJbfPUAuMGQG/Ncdwe/HdOn460iziN7YQwgqwPJPSfx9QEJD60wYJWwSy?=
 =?us-ascii?Q?Yz4k6GV21c4mGOQOnvgslGyKXmdk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f6aZ5gnjbI6lWsX8E507Ocrbx9BF1qRv5IcJgMFqlXUHszy5ZMEPFU8A/VtD?=
 =?us-ascii?Q?bypMXVmCbstYK/pqTtXxUog2W53zZ2YvDmK8WpNzvdv+fIHFdGZsTj8ld7+V?=
 =?us-ascii?Q?a6LGzpC4nsOFDhd3xhigI0jvn87hwuhHJXn9/wcpmzytmNV2CvFhS1VK2jSj?=
 =?us-ascii?Q?KyUUw3ltAxK51uYLOlKI/7nfSAIkMiX7MVvDC+6qQc1DmVZ02k/69PJjhpnE?=
 =?us-ascii?Q?M/57s4JgrTO2ScK210ST7HbCc4irqIjiblDDU41t5R47qM0wGCSCVMPUzWCz?=
 =?us-ascii?Q?3ywOi7y2hsAbrUTWghu2xLbE3czImivBlX++aOw25OG5PCvQwPVZDqSEN6j+?=
 =?us-ascii?Q?80Hb3kZ42AzBhZZiDhtIDeIa8q4jSHCIovgzohwS/+bUIKtc0OZf7rizmb3D?=
 =?us-ascii?Q?wRURKC2RfJKQQbarmBuVqTKngMFBFqkbFer2zlxLgY0j+gbFmtNj+BsK+Oep?=
 =?us-ascii?Q?OCbtdgyqNlX5kYhSV0sEdyjE38xn0KW1zsdy2xBXb1v57Hb+c0RFnu0nrvcp?=
 =?us-ascii?Q?sCo0jppmOxsFVV2jNhUP90QtOikDqb1Tm+Qvnk3Pl5lv+7R6bRrQ9A4vUevn?=
 =?us-ascii?Q?ADu2fA/2Xazi3KMSXEtI2WoIiVO1viTnNSONxoe2YALyvaSDgBuNbwcj4Ew2?=
 =?us-ascii?Q?wFQWajbQfV4eJFqMZ18dNZYpnjHOEkJPKL5O+wHoWlcqifVgoQ6lySQOi78G?=
 =?us-ascii?Q?e8i0D4A55k5hEkGpa1t7ovpMYPYBOr1Z5QFn0TlOtx2q78aEq2BhwzRlw/iS?=
 =?us-ascii?Q?QKGdTzdQVbyQrZZq1IXdUl/pnQznSET6cXsYlUxqdaACJQQKsY85cp7PduhE?=
 =?us-ascii?Q?dxwRShSo7qD6jmFt8ec5ChHQPyfjcwN+o20phUnYTmVEvpSNAWm8IOSDW6qq?=
 =?us-ascii?Q?ryRtis6ygQm+/Ik+FxjrVnOzVeUrbf8axRzY9L1kORonG3fJqmduzSudq+xY?=
 =?us-ascii?Q?DfO9DSvGIwKzw+cH62RLZQYUe/XBgwSNeMtQNwdchJmRgOUrD6t4RXjE1zMt?=
 =?us-ascii?Q?UK2er76L09Q4WdHLPzC+YZy0X4fxm9LMw9ptTk1Pz4eqPX2uK1rKiu0MvZf3?=
 =?us-ascii?Q?DU1fAHm0pc4wJuKOqU5YXXnwhLNBSx93j/vNTgY13FeHUH7CZB7A+8gASfke?=
 =?us-ascii?Q?HNRePVthLXRaBMrg5kkN9nKLxczdLcqewBka/1IC2oyxU2qKed8VrwWjMvtJ?=
 =?us-ascii?Q?fYebZnLD6ht7ElkHjTPlsEG9ZWUzbHRcGUC4fgW1WdjdcEhj585tRtAOvL1a?=
 =?us-ascii?Q?4dEcCGYpAoGbnRo0RGsjL6Ajg7NtOUp58nZcCrHndBOigRXovYKcwapXfqok?=
 =?us-ascii?Q?tIywOUMj3JTt+DiBF47biplnGBOBdLILgHj/YFQot4HdXH6JBzd2oooTbo4X?=
 =?us-ascii?Q?sdRefZ/fOvKHVM46BaTdLSpW6jvCRVSoBGwhFMs8QW+mZV5pxFE8BMujl/LP?=
 =?us-ascii?Q?hRk3ANHmNPocHFHQmFEad9KUtwVRS5Om33uxRh9CbU3NXmKhh82LPx7Bqiww?=
 =?us-ascii?Q?4jhUlSz+M0p+IQ0U98tqQb216WFszw5H1ges7WwC+yHERZjqMSgBX8ble1OS?=
 =?us-ascii?Q?Txt+jGwLFGDJNsznyq8RtYY6kD5j5g0s0cUx8QSA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/vdvOXGJ0gRKR8VWh5b2gQ65eyYXK3uVba8rKwKQ87ffFUKj2EOWAT5+yRcNqhy2ORXQlya2xTdIQaz3cWeADxc/bLK7PL1S2RO06mj3Jq4Jdmx3l89G3CIo7DMJ46wvCFy99EvljXCAccMfCOL81mCysrtUgD0wEpv+ni4Ie0lZN3FHWDV3I9iKZ0BcHcMTDGgB7RmapNYL7KpH4UwoVFCklmSYi7Dk578Io0rdu9MZ0qj+1s7d4/gvdVuUgAfsamNkV2NkHTFSMSMcFaSULKGjnEXKlQ3XcGuhvolH8XbPPCiRAvYqyr9Xpo57SJDXhr0AMkRKZsgX99dBUFcIpPX1pPvc75El+QpN4oE1ZkdATMXvCpHre+/2DQ3RVUO2VzrACxT4Gwayi0ghvxX31i2zuCNhgXPxOCnwQf8MQRSASOc1B0RhlVeKTL6EIqjvHhYL0wmynsAoyYyuJ6ghILQqf0Ra8zTZr1PbE9R8AmxeTNtlEmQM31TY45vasGC6Eq0m4LVZYXQqpDojJuMfhdVvBEA8zyCmn6yjT2H3lcdsrJLSO0FPVtpTgCUPoI1mzTIi8XxhqI2timT3ts7F43wYhR40577g+LP62lUlF5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57872c9-4aa4-4257-9e89-08dd2a8f6e94
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 18:09:28.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ELCzmc7sl5zkV48fDFDqWFswnMpLIa+GIuXz7HX03SUsOseIDOFC3E3O9SjlgUGXO/5o+ek8YL+ul54/ptvtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_08,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010159
X-Proofpoint-GUID: b3fIciFP7-BLQr9ebPs0m4Tqu13xr4BB
X-Proofpoint-ORIG-GUID: b3fIciFP7-BLQr9ebPs0m4Tqu13xr4BB

v5:
Fixes based on review comments:  
  . Rewrite `btrfs_read_policy_to_enum()` using `sysfs_match_string()`
    and `strncpy()`.
  . Rewrite the round-robin method based on read counts.
  . Fix the smatch indentation warning.
 - Change the default minimum contiguous device read size for round-robin
   from 256K to 192K, as the latter performs slightly better.
 - Introduce a framework to track filesystem read counts. (New patch)
 - Reran defrag performance numbers
      $ xfs_io -f -d -c 'pwrite -S 0xab 0 1000000000' /btrfs/P6B
      $ time -p btrfs filesystem defrag -r -f -c /btrfs

|         | Time  | Read I/O Count  | gain  |
|         | Real  | devid1 | devid2 | w-PID |
|---------|-------|--------|--------|-------|
| pid     | 11.14s| 3808   | 0      |  -    |
| rotation|       |        |        |       |
|   196608|  6.54s| 2532   | 1276   | 41.29%|
|   262144|  8.42s| 1907   | 1901   | 24.41%|
| devid:1 | 10.95s| 3807   | 0      | 1.70% |

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

Anand Jain (10):
  btrfs: initialize fs_devices->fs_info earlier
  btrfs: simplify output formatting in btrfs_read_policy_show
  btrfs: add btrfs_read_policy_to_enum helper and refactor read policy
    store
  btrfs: handle value associated with raid1 balancing parameter
  btrfs: add read count tracking for filesystem stats
  btrfs: introduce RAID1 round-robin read balancing
  btrfs: add RAID1 preferred read device
  btrfs: expose experimental mode in module information
  btrfs: enable RAID1 balancing configuration via modprobe parameter
  btrfs: modload to print RAID1 balancing status

 fs/btrfs/bio.c     |   8 +++
 fs/btrfs/disk-io.c |   4 ++
 fs/btrfs/super.c   |  18 +++++
 fs/btrfs/sysfs.c   | 168 ++++++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/sysfs.h   |   5 ++
 fs/btrfs/volumes.c | 115 ++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h |  22 +++++-
 7 files changed, 317 insertions(+), 23 deletions(-)

-- 
2.47.0


