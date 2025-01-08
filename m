Return-Path: <linux-btrfs+bounces-10798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75346A066C6
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 22:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87483A2380
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 21:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EA4202F96;
	Wed,  8 Jan 2025 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lJlGqN96";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cvj+HJMW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC8F1AA1EE
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2025 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370123; cv=fail; b=olnSWEmcWnzTWvjfRf0O4bFIRAlnqWsidtLzdli6Nw6rWnLsibxLJr6T4GwCKyFew9Gfo6aOt1XmLoPeuo7yO+5hN3bx6S6zIqoOQsSv8UDmpY4xid1Q2UDEXpms8RAaPzuYhkhTZBKR+Eyuk7IURt6qH2pbBQTRHcJwQ6m1SlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370123; c=relaxed/simple;
	bh=303U0VPHD0Bkj/RmpJllZ9QHLlR+W+1GAYXk76Y5Sgo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TldzRPCYqZ2jWkjAB9vWaCi6bPmhbt/i7S1dEYk6oWj25bNphxs2Dfthsz3DgnCekePFaNmuB/LaRcLtOmsYiFSoNUPbpaXC97775CYbjCpmMASjci7uY85x2KAx+MlIUjNF+gkPCHAsvjBXAadQMteoYwlb1UcxOWVYnVWlhns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lJlGqN96; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cvj+HJMW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508IMrhi005794;
	Wed, 8 Jan 2025 21:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=qcmFryUKZwwfvJ9m
	r4ir6CbiF9SkHmInNzx34yCWAqE=; b=lJlGqN96H5u4nK9z43aAwOwhvTl1T5+e
	i+EtuB3l74Y/v5r9LsL5lmzDCehWR1HPjy/K5z/Js2Do3SsEdn0OVDyEwly5XIAC
	VfI0BzwQRioCbTMznBjItgBCp4+MMFXroZVxOC/5yk0GsNzO1elLW+EKoBIGRs9A
	KSEi7xFtqfNj4QjWnwPA6XGsk8V5DP84n2X7cO2u9K/BXNUlGtxzPK8ofMDZR4yj
	Hee3JMhpcswt8nzk56TD5HPiQ/fjPA2NbtjiZe2posIGymLZT3NPgggI8qy//qJJ
	S4SwH6QTQrp9AhCnNGiIpQG4+lKBWqH/6TklsfPzsbgvpSF44s3WAg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudc7wvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 21:01:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508KunUl010865;
	Wed, 8 Jan 2025 21:01:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea3cx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 21:01:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHu10RbF2tUWIGORGg+pnljaN1+zyJQX0DFrb8+CmybDrRk4MXarcXrF1yPttgfO85+6uFESnKNVCm5bx7C0uYny7EKMs2zxkYmzSlyJpmHKuYvyCY8ZrEllfoVGHWoGyrpjRgk7qoezhll7xZQrlpEsEeLmOLl30r0hAJL1YqvVgRQhEHM2ioI66a7/yKB+CXpND3uxcW1T0nEmH5CLJs6+3H5VRnGYhHnAy+lS7C+biTBv+KYv4ocYrGIIfR4K0qe7BpkhJzhVECO+eWdGh0l8BYjLuMuJh1ePZCvNEN63cxoxpDVYtqmD1cub83awPM2OvFteys+tHCCAYoMzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcmFryUKZwwfvJ9mr4ir6CbiF9SkHmInNzx34yCWAqE=;
 b=CXwxdtwWF0ziZvjZd4IIE1NzY3rUzBXU2dLNfNxKXpTD98MlHd4WsWvKQJE5Jw+7yisQlqCrafZYg2ypbqFCFvBLXO3CuuEYHeMuGTshChxCZYZVwMrPno6TUuLNSxshbXZE0jy6T7S7rL8yfeNrmQR3i/ckQgWVLv1HgraFnM4c5LvXBlXUSQlsNLqM6fMcXQtZl50DoVhT3tpTK0FaozXmJvqcRRHPzA5kBQTQ/tdWPZOeqrFqratvxEXDUuXsxOHXYi5vebZCwYCTmdqXuvN7kVQCED3LFfvkwDp8m/K1BZIXqG+gTSYTbs4AbbvYyVZluthnmXT2zFIV1A0G8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcmFryUKZwwfvJ9mr4ir6CbiF9SkHmInNzx34yCWAqE=;
 b=cvj+HJMWfKmWYwgl+A4GHZkaLu1iHeXTpv8H9Cu6SC7Hd2yKP9R1YTQXcygFfYMo1LjvpI5WDgDkZmgGrPt5CYLLUVQYmUz7K4gwS4r3RmQ/YLxsnfk+ENQm/behKzqKK4ZuNoTmiv/XxCSivQpgqDsEgTzE/CTj+C+05Fp9tIk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4131.namprd10.prod.outlook.com (2603:10b6:a03:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 21:01:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 21:01:56 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH 0/2] btrfs: migrate tracking read blocks from fs_devices to
Date: Thu,  9 Jan 2025 05:01:34 +0800
Message-ID: <cover.1736369474.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a59571-1bd5-457b-6f8b-08dd3027af88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l9TJGGJyTWAK/qQWoqyJq+ueVnKr+xIVLpQl6PpIiddBztNoRzVybNBYvNL+?=
 =?us-ascii?Q?Ivt6XT5eSo0QsdHy+WkJ0O6235eVjL9qWTBDWFNrGlMbvFmOxz1hcD201xjp?=
 =?us-ascii?Q?oUD24/s+/6LZMKLW2X7HbhN6FpsLAS3ozojnsESWuWEu0TDtAIG2rdz6obFd?=
 =?us-ascii?Q?1YaVzf0suLnWgkMf3Dp4FT1YRqRfuzKvNtdsPuFASOLPpDvSJIW/bofbYorT?=
 =?us-ascii?Q?arEmg3enAxVzSCWyJo6+//J40fkPYOVCshFqWQLkz7+cdJExyQNfvsH+P2n1?=
 =?us-ascii?Q?JC+I718PUmzXuYMM4SdeDqFPKkwiVJg+b+5myzeqPUybQwP+55hYH0A4DjHO?=
 =?us-ascii?Q?Zcp4GgaYGVMY2AQ8s2y9XOc/kWVzRDY+fISzFlFf+u0MBn+9QiXDzQVvwkHo?=
 =?us-ascii?Q?Ob2nC3V87Q8AosaXUBc4HT/PRTxAHWlTevqL+EgUY80/Uo0IDYTptz1WZRlt?=
 =?us-ascii?Q?rq/u7jkOSNYn1te6I2nQmNoh1hkPEn+3vp9RxuYth0NALGII0MJWM5++ScMQ?=
 =?us-ascii?Q?TlE4CeJ30L9bz5h0UiauIpnmlxgA9gnqXniPcD7qa5gLeaoyR+Zyy9ds0xjN?=
 =?us-ascii?Q?RkzpHGA9038fB7Nccs3nfLaxnMd550SIicQutaZR2arIj95OQw062IqzeH5c?=
 =?us-ascii?Q?HKQClqeHeKSHSaG3ERDgsd/dCK9BzgnU33QTINeSmY93nD5lcwu7dZyGhJEI?=
 =?us-ascii?Q?QYd3egzQi9V+q8hqXUq+eUmozmRC26Kb08hKx3QPktC1G+JcoIB1rojhTZVr?=
 =?us-ascii?Q?kZyFOH2zso05SPOSz1QeUgq6E1X7wTSBIhYY+z84E1znxARyCtAaeyzw6Pim?=
 =?us-ascii?Q?sgVYcpQtz2odNRG7LpnHMcBRzpl/l+HfFXrsf3eCt1KGGYXTCo3c93jGDun+?=
 =?us-ascii?Q?jXdh6LFuA0NH4zo/cy3C1jqaAvmv9e9uAuIauCyEAokB3Xec35bKma67sVRP?=
 =?us-ascii?Q?uSrTrimHTwvEn/xDe63PwP2U0i5X+EHCCUwD/VNzKivDc3nBwwsdXC8yoB1b?=
 =?us-ascii?Q?RZPP6+yYvmJC6/+eSVRZZ5bcemwnYjGgZtHe8CftHFyJUrEmX7NT28AXUtVU?=
 =?us-ascii?Q?UR1jJ19E8YLsHTjWOH03rqLSYgYXFLdwVefb90G4OroiP5oDkRtdQ0WWW5wN?=
 =?us-ascii?Q?wGcxtHp4DzD+H5pS7jRNY8Z7OU7Nc3KTjYT7nUEnBwUNEagxor88cGgUq5pe?=
 =?us-ascii?Q?cTZQ9ugrXiV1j7tAUYgIvIXlPl+7HaeQ299xfg74SLh/CtKOw9E9EVOUdUS+?=
 =?us-ascii?Q?FOYZBE8Wq+cd+jxknSRJF8/YqE1QaMDglvtgjlOOGe/1cjOmz/Ix+kCBA+dI?=
 =?us-ascii?Q?mdq3ZlmwNFT1ZcLpuvlMxZXJWIy0tkXel7Ea02TDkXb1l8ZSMWXR+SP557lr?=
 =?us-ascii?Q?tTv6jSztGi29BD7XvKkYpg22h6EK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lRz2amF6T46QnHMSLTkXffHVGmet9pzcLJY4Cb6fhODYyVyyDxnpFN81O4oa?=
 =?us-ascii?Q?ktPLItT7FQ+l/XRDtjoUsqkMlp99WFG3rkRmJErt4pwZqVjqtJPVvEkwHyYW?=
 =?us-ascii?Q?TVQCjM7NzCiYUhaoIdYi21a6s1bejBTE/2wdmOA7vMxJGjSUrdu9NPxHHpTu?=
 =?us-ascii?Q?NelxXY5NVW6XrNUJ2bbQTXN8av09O65Xv3d+ekYHENx/8CZu7oyo1CGTjxro?=
 =?us-ascii?Q?422LMnKPiwGxztp43GhKiJlMDSWLZ9smgqCcyBIpRjuOFJRzMxyqOQlSrkUM?=
 =?us-ascii?Q?pSsidUuiOyJkSOXCMy/fsRW253QdPxeKFYm+zqCUfXU4NUD/2XgPV2zc1/oV?=
 =?us-ascii?Q?/vf90qJMnH7HKsvAFtIEJpvh0BH8jWX75mvsbe+8ViJg7VNJdjgVtiWDKMoH?=
 =?us-ascii?Q?CS3UqYJwkxHLsDIeoW4wtplX40A+tgjYzvegx81qtdcOqLK4HB28WpETIjOS?=
 =?us-ascii?Q?yVWFPB8LPdB+gfkMqfyspSOZqKGmzM4o9rsbJxtkCBHIibr5eLRrXO3PYYk2?=
 =?us-ascii?Q?P5tCsnzFAW/ASQVgN8L2a6JcRXDHgrIdM7aLt55nSssDTK9joN2U5BON1d6I?=
 =?us-ascii?Q?kLqrMxx9Nvcu20Oc9JcSudePdJSI/7ipqFKFXbjbaSFSqTUHb+nI92m3ioC1?=
 =?us-ascii?Q?sv2KG3fWAc+abYp3ZOr72G96J1YKoP+Fi2jyOX0Me26FVqDZVQGL9nR0mp/W?=
 =?us-ascii?Q?hLgGdb9KLjZyLQiXnheRqTvJ/iRXLRCO2m9y9xhkkQgghLMTdzyA1F6nVlUZ?=
 =?us-ascii?Q?IpDhoUVRLVOe7SGKIq0XgEn6VXM/21wZSDDBdQGSI6nerNo4kntRp90W+iUE?=
 =?us-ascii?Q?OQJWkgCI7FXMSmQOBb/e/F17Vrc3yPcLqC4oq4e4Oaa2NtHuehQMjTNKcRiB?=
 =?us-ascii?Q?60NVo8bx1jqGXUk01bQLIXMiYJ3AGOya3be6f82tUtU4CRVF3BTaXbraEI50?=
 =?us-ascii?Q?xNSDv9WW5Sv5bIjav73FuOoDyK312Kbn69ic7Aimxw+TiG3KWW0FrYzVSwdQ?=
 =?us-ascii?Q?ZPHWV/kkhyr2yuybedAiidMSGi+O/hK9YrU1+zcjC7pZ1GRb0sGO8sn5XmoB?=
 =?us-ascii?Q?ZTuLKXiLHyzHYn4ppXCSMYsKnFReL3gxOYDjJsrY/LSebzQ0C0jbDZj6vQ19?=
 =?us-ascii?Q?KCEvbSt8RWMcq8AhF8j7GjxQN0e+LYtUgad+O1n52k5Cps/WgEBkI5ObeUpS?=
 =?us-ascii?Q?IgvX5wo89Kbyil1begG5ZLU8K1G+4U6YUY3uXlQUh1rwJOgQGIZRjmEi5Xet?=
 =?us-ascii?Q?EkeZEDAGq1IRNgmeUBuQvL1g8riAJ3IJqXr/V7Ods2g5zAKepAO4ReLbBmdJ?=
 =?us-ascii?Q?r1aufvlb0jtKlZUuzI5FlGeCNUTXRZI85sPq/k9gdZpUGAUIBI8vkwtsOX6C?=
 =?us-ascii?Q?+YL4vVClJyJf9Aqt6IWGZDmYJq2F7tzHzl1UgwKIYIaeX15T2r883Nyb9OgQ?=
 =?us-ascii?Q?vlDL6kEnv1+O6PjXA8pDVm3Mfha9sVcnQReTkkFIwheWIAlDBzusAzHAsbUV?=
 =?us-ascii?Q?65Nf9xqX5PANWgHka3v67GOpN1Pe/Ncv4pXYQi5FM7UrDOPFFFFb/tMZ2tGG?=
 =?us-ascii?Q?3Rne/pKYHc1urnyIRMp69Tu84KZ/inuZ59JN6Ueh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GkmiJahDdmCdCUtVWHHgpz2RRCQOGjMu0aa7DUcnd17V6c+obkqwNSZCnG4xpkGil8+uWk3oFjXluSlDMYmw9Ph5KC1envI2WY1ORdds7tHLE3cG6UdRxZAaluS6bWSSocaP5/+L/XH4CMIlgFhafBtzHuubNAKoYfv+zws/zT95OBTddIWCFDd++l9+tqTerhRTjutMh/c4orfx4szi/vJYxGNV8IVev1OTQBglWrAAmjnsUEJeiUCRFJTmZ4j/wpAhfGeyfqgEwHAqZ8LqgjNEHtzfkOzIzU8RPH3dmdJje7olQ5jfUA1tXXQcmKjgEyYODCx2KybG0ALdn3roA5jrVJJIrRBtT0vqdWsZoxOi4OP2JKRY9CGBU502NmyOBGgCM5GpYwJUJv70uvVBUTKWY/BalMaHU4XEjLXJCNyUzOeuFx7SFPs6AvoF6JNy0tXXQCO3nn63ND25oZCoHgH7S1ZTc/pZ16MmA+p98Tp7o0WuzyXM38Msyy3/9g4U8vW8MdZIpyXO5HTZAT1bjpyFr9YSaAUWc9EZBnzKqMO3WXSk6N1yTELbBytfrZpF7CE6UJxMKHp1mIF/PxTqXaZDUu7Ah9IodW0FCyY5Ptk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a59571-1bd5-457b-6f8b-08dd3027af88
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 21:01:56.4922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKcDbYH1al6fEP59VBsfGCFG4VtAZ/1j9y4dPH5J8t6KtOcdfgGaJUXEr6ojsc0OWnAgw5kNJEvKuCdOM4/96w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501080171
X-Proofpoint-ORIG-GUID: dF44hAkZ8ALEXd9X8m1Anuo6Z0BekwdB
X-Proofpoint-GUID: dF44hAkZ8ALEXd9X8m1Anuo6Z0BekwdB

David reported btrfs/161 failing during sprouted filesystem unmount.
Bisected to commit 49136a74162e ("btrfs: add tracking of read blocks
for read policy"). Now, tracking is moved from `fs_devices` to `fs_info`.

Tested to be working fine.

-----
FSTYP         -- btrfs
PLATFORM      -- Linux/aarch64 local 6.13.0-rc6+ #45 SMP PREEMPT_DYNAMIC Thu Jan  9 04:04:07 +08 2025
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch

btrfs/161 0s ...  0s
Ran: btrfs/161
Passed all 1 tests
------

Patches should be folded into their respective commits. Thx.

Anand Jain (2):
  fixup: btrfs: add tracking of read blocks for read policy
  fixup: btrfs: introduce RAID1 round-robin read balancing

 fs/btrfs/bio.c     |  2 +-
 fs/btrfs/disk-io.c |  5 +++++
 fs/btrfs/fs.h      |  3 +++
 fs/btrfs/volumes.c | 17 ++++++-----------
 fs/btrfs/volumes.h |  3 ---
 5 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.47.0


