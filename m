Return-Path: <linux-btrfs+bounces-10902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D8AA096E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 17:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF23E3A2127
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 16:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22863212D81;
	Fri, 10 Jan 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fG78sU0v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FeAnA8sp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF67212B35
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525580; cv=fail; b=jBD0gwdPSZMMpBzeTYApGofF7MuzAVzu+ZLoSMavh0VcJlCD9C1LRnnmxYWmagiV4HdA4GsIw7MJNy+KZ2x5qbs4aWFoubcRcvEkB0Ls40LJ4pdlL1nUD09G5wI1bbZUgw0q2yvSQYTXt3S3GegRC1n1DlcWFmHvJ1D4W0AA0po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525580; c=relaxed/simple;
	bh=CUENB8c0rZGynU9XU0Bekfo/FUNK8ix6AHZ/6Km+kXA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m26PYmIdunlcitC/6boJfFZoazgf4YAVojAzXoC7fwdpANkC7y8eUp2pfUr4TPWMwRE/48ZMBbMkOiD7Y8HFkjnXPs+Yzb+84tQBsvo1HPBnF2fDxcuPlSAxOKqaG3Ak2z9cGnsYM13WCZ3g8vSChTdjOFgM6KDd/0qZKmIr+OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fG78sU0v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FeAnA8sp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AENUin011156;
	Fri, 10 Jan 2025 16:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=PiItBs80oztjQ51L
	DHB9N0lxGl/oGr/yCBUk5yNwVso=; b=fG78sU0vPCHVWsnMgYD481xQ59Zj5GPN
	82FUz7uspaZm7sy756vUKs6kOi4OqDV8S8n/pKXe42vrkkuintRn2yBPsLNdTjOI
	1+4LqLhve2z22auGuzNdYgpbpZchqz/2hCfrvk7cnOfUnkxL+Imym3sxT4XCU4We
	RTt5eFeHRO3PCURb5Nn1PVpuP7n54p+vKILaQ1O4WznvEiY37LAX+DRQ5rvKbAap
	mFElQmpghia/tgk49EvxqUztwFbziwsRUefLBI4H/7FA6Qf0nyMNr9o2efvCaBMM
	uRzEBxTniHtwtM9s1uYFeT2XphSi0KDD0TsVLvW5/bZLYXJL5lmN6A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 442gy5t72h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 16:12:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50AFTLc1023426;
	Fri, 10 Jan 2025 16:12:55 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xueckhte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 16:12:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2EqqN4W0kPrxIyAT3B6XgHkQr76hTFqnCLjEGoR7ES0gJR7qjnB8GlzuCJMUQwW09tQndggUMNk64SIFN354vr/aPlL+UPMREubj8izeYHhO0Bx217qxaaY0W/AZRD0ja+CqLDF2X9THHf/JwJIanpuqRQQl+aHS3rMuXaAQetCO7fIZ8IwP37F/GH4xeuETdXtN3anak53U5x1t/V+FdbCMcOdG/dqJ0B+PrYkfer6aHxmIexJN+hfl882fCVUv1nSlKOt633Agw5DjqWbz+uNgxGv1VYl3xkMx9MU/mxDs31/mgMmxL/+dj34ml82XY3Vk6Vr9pl414XtCnIUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiItBs80oztjQ51LDHB9N0lxGl/oGr/yCBUk5yNwVso=;
 b=s3QWkqiKFGGGcJDegGLDSKoFmvGw8dP4VkQnlUmnCqlZo8MWXvltffk7IKOj9cK9OvbZf1y2MbZ4QzsqFIjRKKTX79MyEMtVqkndJQYKTjfklagLWzYwjgM7pj0/eaHFnvKpaKRaI9vnvJmUo1as+YZGHZv9a63TS5UC+gq56ql7cPhbXlhIfwb87iqKSksFwu70WTyi0AKh2ycFojXn+aDMzzBwetxYm1EVHk48l5eOArqRucDn1X0M6IMNxDVQtdQoKmWQM00NnVhm22Eoqkz0QVP+oNeBoWzz6fAjIy+GzIwHG6dMhxqmM3w0avwSQJfaoi3zHKrnxTnN6k+NnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiItBs80oztjQ51LDHB9N0lxGl/oGr/yCBUk5yNwVso=;
 b=FeAnA8spuHQs+GD48aaKRhc6OY920y5yFCI3XHTTrgjxB91CDcriISY5dXdrAuywfmieN6N6m+OnH63dhEXHhOO04PIK6tSjeGB/zNv0Xdc3dNl2wNLgSlt35fv4G6hK8daH+flQNSoG1hQiGJl7WwyKNGQxKo5V78NcOFRxzcY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6760.namprd10.prod.outlook.com (2603:10b6:208:42c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 16:12:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 16:12:52 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH] btrfs-progs: resize: remove the misleading warning for the 'max' option
Date: Sat, 11 Jan 2025 00:11:35 +0800
Message-ID: <5c9857b5fbc5b71984594f2f7e6f666cc435118a.1736525474.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a68df7-9f89-41db-699c-08dd3191a282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nP0OIrmfHOJexn8IamINrd5DHImzJmQsbNVRq3rIX2Qe7UEqfcauetTzjkz9?=
 =?us-ascii?Q?x/atIVNtUEq2cwpcq+45n4DyGBapPFURYwSNxdswTaKgYA6C3ljVgZWBavxO?=
 =?us-ascii?Q?HplSy3P8QT+Te3xo0vffGEHhZXlh+cJQsuYj0LIVxKpjNTn2IdCFO7L+6KCM?=
 =?us-ascii?Q?BH/DgaGafWQcquOAeHJILwe6Nge9DJ9fHWTbzeENf4WIM09sRuYNihwuIfRJ?=
 =?us-ascii?Q?bBimppVzlZGMlLUkGSbKj/86TnRh/wSG13YBrLjEuq1k9GMZW2aPehVcAJ5k?=
 =?us-ascii?Q?YNQQFV+A9XkfEnTzIxLRxQgKBRO2pyoWaTGnp8Tu1zEW39QX5/3HeDBmt1bD?=
 =?us-ascii?Q?57agUSQZ615Qbd6dj5jXNF0UeO8U5/g+dNio4F5Hb9W/hf+S/uBgxojCvY1E?=
 =?us-ascii?Q?MdDISurXrBzzHuhvK1J7uOjUkWetbHoyHYovu6vX86bCBw6/Xi/sTe4UUP37?=
 =?us-ascii?Q?IbN4ZC5L47ifBTxYpHs1ugOCroFQSgktGe+BG5FYOtoSpuwzHgs0d9lOzUiP?=
 =?us-ascii?Q?/8Z1UPbsadMIde34RhZvjMOqgue4nku3flict3g8V1M8x9AWDaQR/45g0GOr?=
 =?us-ascii?Q?gimKu7uL6vs7Tz84nU6km+dlFoBle0Hm0MTuTO72rewnmxQBMumve7q6mlaN?=
 =?us-ascii?Q?xaip2h81yv4+bJQFNm9aUDGvfTGJc0Z8ATItImZTEUzB5aO2L+mcMbgCtR/t?=
 =?us-ascii?Q?BXx86Rt9p8eUDGkYp5nElV0UB8E+a8wHc4lAo9IDv1fvAypzAZypyabhttsL?=
 =?us-ascii?Q?JgYYJrF8ql98j0X039/xeTB+w7AlUDss9U5u+j7ShYyhESV/Oub/5eJmP1i4?=
 =?us-ascii?Q?J+QXshG9YFvxaI95/SD7DTjFCmdGLPgR0kUlsq2N42aOlaHUbMEtc15HRiDm?=
 =?us-ascii?Q?F0rWzyDyl25RcwZk9dwpYwMoiHjXa4sx693O3lXj1C/FvnuDejkswP1fnPzK?=
 =?us-ascii?Q?smp1xRz+aDpHsRTyUIeusDHK3EO6Oy5s3EZ6LGEYaJNzuU3u3SBWW/OvRaVX?=
 =?us-ascii?Q?wkZ4sQ6eHS2/vrDBv0m2c2vgU8L1aCB9Ne3wKiAgHTJx3R9DCHPeRJoq8nEj?=
 =?us-ascii?Q?hhuu8IwZzNo1vO4QjcV7itBrasV+vFvZRZ62bDrM8OnSod7q1m7gGDD7/tsH?=
 =?us-ascii?Q?jKcVDP0sGOCWT/kWjcipjfaiPPeEGsUqmMkRJDd+jLXPXYYBf/4DNCtD/9Ds?=
 =?us-ascii?Q?gj/2nEpXFqh06fabc23uzVjxT9cmiK5I/W8JZif9DaZiCN7s7M4JmF0XvZuY?=
 =?us-ascii?Q?FF3Qbb8NQXil8faQBg1aqnyoIwUvZ/6FrfOIp30QAgAXlDuMGi4VMoJeOI6H?=
 =?us-ascii?Q?qbn1f4Ie+pgR+1Ob8LneDFoCsfSA9BtPHNufmJ8YSFqcPfXw9uXcKwWR1LhP?=
 =?us-ascii?Q?8X5swYTi9y2vsqAa493po52bTddV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yHlIJLrnmpsKyavLMzIoBvF/W/xIcT7gqUwy+K3JOQ9y5s18VVzVuSHMTkx0?=
 =?us-ascii?Q?87AYdqi+KQqearUYF1UxcY+tVCBrYNL4KdFS66qD0hrRVnP4zS1P8gvYvFff?=
 =?us-ascii?Q?XjDPr+HOQklLMvkbIli7+WWLz/+7EcHzT5N75HrGlIeu0eD+f/4q9m0xTsvW?=
 =?us-ascii?Q?CO1VtIwyxcSjK4z+//jkIuckDJQp7Pe6xxJCSYWTeXCj7az8RmfmAh4d0LAZ?=
 =?us-ascii?Q?UY6nq3deswPyHFP2FM4xPCcKuYY/CJGlnLwEhXqWAADDX816cJ/Nzi86aw/m?=
 =?us-ascii?Q?ee1jzBb0GOldsYlU9XxXwKn21AHrJkMRpvMgP08kUWiGEU2lhFruxsOqFS+0?=
 =?us-ascii?Q?TdPiC6iCyq1RHz+S1xQjiDpWvtmggoJ3cbhZuEGxT6XtaZzTc93jNrncBj9y?=
 =?us-ascii?Q?FXcBONIwU/3zjRGaNLUco4BqXCYxSTpbrABkrB2eb/T8EuJ2JmyBQ+tKhaR4?=
 =?us-ascii?Q?OGIU8ztIu0uLdcruhyfAeCncK5uQEgvi9LCpFGYp17i0QYh8RQiPZ3EIUxPC?=
 =?us-ascii?Q?sspbetufPsmEks367B9NlTtjutf5md2ZcJ/OrGEdTrAdlNfs484v06UcamJR?=
 =?us-ascii?Q?AfE9rYgj4SypTKJTaGg8XTo8tHj7oGfZLCb5Wwlh6NCwXzigMq4UD9jQzJsV?=
 =?us-ascii?Q?tTAkGyGUzk7NSQg6KGNqAOxA1aOEXXKGWL/mVifQJKu/6uBn18lzF+gSFevj?=
 =?us-ascii?Q?dRKoNOPZ9CU3UjOr0PwF+xNGMbr7wdUZ44IuzJy07O7MAReG2cd51W2vPjSz?=
 =?us-ascii?Q?bWuHE2oVIBf62OQvN9OscXLjX4AedYpVswA0DqbIZ5nqQTqXABX7aSx49z8Q?=
 =?us-ascii?Q?2zQcLxlJF2sIC9bWLWdwjyki//YyF0IiWo5eZIfjqnPR6mkEhT3PbYsK323j?=
 =?us-ascii?Q?N2SH6IcNQgoat0Rug+ODswoy8pkVFlsNWL7vS/caWWU3YD++jAIuOiunahV7?=
 =?us-ascii?Q?OhV5jof+B2Ojw69BLwO+F+Gt1CkRGGj7JbpT21nhHyAKih/1kDzL/M86JMBQ?=
 =?us-ascii?Q?SUzWI9FUnz7Os1FRGwz3f4XOSL0jBFchS6z4MM57XO6gZZspw9/dPw/voUrJ?=
 =?us-ascii?Q?SQEnIXk/jwiymTbVtGbzCfbymb74iSF6LyQuW8M0/CYeLWx0HcPqZjFNO9Kx?=
 =?us-ascii?Q?lFCAcJDhWSEzNFBPdq5mHjV0QaWv52uDN9725tqtBAA60nM1b0MSR7zPJTyb?=
 =?us-ascii?Q?y0GW5wy9sYw4csE3hQfRTTxbd1UFsH9Nts62AxxZDstQVfIzvBQ1UdqqztXS?=
 =?us-ascii?Q?AkwmplOWYlWhNk6YGFzESDI25KLioD78zY3sLWjgp6LT/HLTNYxLLwLx9Vqz?=
 =?us-ascii?Q?xTuTImEC4cP4c66AEQ49nM2knx0c+HK40iiG7hUu0ny866NFBdHtPW3E/TX6?=
 =?us-ascii?Q?kn/7ohL124sF2SG/8quq+MZpxejCC7CMABpyE28DEV0OiRgHrtrhuBbFJpZS?=
 =?us-ascii?Q?7rZ8zbsiF9CzdkdfFof1oBIE2UCU9E2g1mw31ti+fdawhmym4gs6Cu8IZBhb?=
 =?us-ascii?Q?qRkZswbL7wMBcsr6q8XioF5f4qts0Olfk8UN5Wuk5ZdpU7KncCpY4bEF9phl?=
 =?us-ascii?Q?lKm0KOZjWUPKqs9MoEVHl324YKZhoaQno7+S0Kdf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zr3wHjiWFUngfOMOElzZHQSgmsckYClDKa5daA9FBFkym89zuTws8awcLG09ijiKYqels+rduTq6ayeNZvWRLs8Yc+WSFg7vByouKIj7Iu5ixLPkpi7DllQOAYLNmXXg5kCGQN5mStfhMUOYO0Rj2tTOwYfaGsK32IwFkwkuZdataJVXsvm6RkpRLmg4Nl6r1LvnL/ruCGRKGZ7FJnS5IDLGvRrX5PpfGyuIcx6Ua2/Ow5r53M+LYgF32DRxZi9lxH6icqhuoAjHDphYKtLDw1Yr7Ftq4qL6tQFIPt2/ZFO+5vhQhXZ5tBZv05u+hJlashdWgk1SLRSVWgA1FTXGufNqxHdn01YivYHJ968JAjTpqTf5SgebKxP3pUsGr0tnt8F0wXmGD1ckhhIowGyW0Ph3U2GPuvUUJuZGvaSdF1j5nEl7NQz9eAdqB19/M2ypyVEvthTa4qH1tHpPk7L+CCecQN/AAKoIwCKudolEEa/zMZ5KbOgksxDIBZfg3EvyiXTA2Ajl8qzpAj0Ow3nwB/LGIw9m0tV07JYUIrIeZqeF6l30hInCqpB0lhMZUSvq+uYsdxauU4pTtaauaG5OWdhG8d1cklQPRd4tuqraDQI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a68df7-9f89-41db-699c-08dd3191a282
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:12:52.6435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PP3L+UmafI68Qk9yJPEsyk18LPFENBZ0TQVeDCP1b5lOOUJTw3aYO57hA3LyuMxiwq0EJDzZCHYnTB3hlG8R9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_07,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100127
X-Proofpoint-GUID: 4mwZOZJaTa-GulnRkIQyq7yks6pLjcup
X-Proofpoint-ORIG-GUID: 4mwZOZJaTa-GulnRkIQyq7yks6pLjcup

The disk max size cannot be 256MiB because Btrfs does not allow creating
a filesystem on disks smaller than 256MiB.

Remove the incorrect warning for the 'max' option.`

$ btrfs fi resize max /btrfs
Resize device id 1 (/dev/sda) from 3.00GiB to max
WARNING: the new size 0 (0.00B) is < 256MiB, this may be rejected by kernel

Fixes: 158a25af0d61 ("btrfs-progs: fi resize: warn if new size is < 256M")
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/filesystem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index d2605bda3640..1771ea5b99db 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1269,7 +1269,8 @@ static const char * const cmd_filesystem_resize_usage[] = {
 	NULL
 };
 
-static int check_resize_args(const char *amount, const char *path, u64 *devid_ret) {
+static int check_resize_args(const char *amount, const char *path, u64 *devid_ret)
+{
 	struct btrfs_ioctl_fs_info_args fi_args;
 	struct btrfs_ioctl_dev_info_args *di_args = NULL;
 	int ret, i, dev_idx = -1;
@@ -1402,15 +1403,16 @@ static int check_resize_args(const char *amount, const char *path, u64 *devid_re
 		}
 		new_size = round_down(new_size, fi_args.sectorsize);
 		res_str = pretty_size_mode(new_size, UNITS_DEFAULT);
+
+		if (new_size < 256 * SZ_1M)
+   warning("the new size %lld (%s) is < 256MiB, this may be rejected by kernel",
+			new_size, pretty_size_mode(new_size, UNITS_DEFAULT));
 	}
 
 	pr_verbose(LOG_DEFAULT, "Resize device id %lld (%s) from %s to %s\n", devid,
 		di_args[dev_idx].path,
 		pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DEFAULT),
 		res_str);
-	if (new_size < 256 * SZ_1M)
-		warning("the new size %lld (%s) is < 256MiB, this may be rejected by kernel",
-			new_size, pretty_size_mode(new_size, UNITS_DEFAULT));
 
 out:
 	free(di_args);
-- 
2.47.0


