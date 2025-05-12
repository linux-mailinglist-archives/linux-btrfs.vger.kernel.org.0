Return-Path: <linux-btrfs+bounces-13933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A74AB4300
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0261B623BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ED829AAE3;
	Mon, 12 May 2025 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rvp1d1BC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TjCCpHt1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4281129A9F6
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073443; cv=fail; b=rHCHjvHcpg5U+yab1wb7NWCBLUKag2owSpmh4O//R/ynAqdqrJcSegfzo1yc62y42Yec429EQUZB8BfhJoLokKUn2T4c+3cqR7Ix6y5i6lz+uucG5opWZ6GKXzwH2W9J51Hzp0fGqEB3eSiqVmBG3EDl1dw5jMtNFMByZFH0Ekc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073443; c=relaxed/simple;
	bh=74UZGseIJIdfxAuyxnHhUkoHIynepLakWo7YutrRLpk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pfjtv/vyCwq1qfdSpf4W+eeeFGYXTXbxzR0yjqdfx1CzkgLmkn0ySHq1cRJ71M43N+OCUe1Sp7b3gsuQ8au8b+LC6ISk6vpW3DzBdIU/whzvSyvCgF+cg7W3XNcYlCLG3Kv8nTaameogFxm7XJcRonkoXKHsmndRtcxuE6lMoHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rvp1d1BC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TjCCpHt1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0rC9000511
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=whYsQFT6aOFzBixsUTI7nBIpltVKsw90RkNwex51hoA=; b=
	rvp1d1BC3IR5wXw79OYO3AbWbon8ou3wkUeAxtBsaCjmgi4hWe+dyIjGAqmDTKxE
	iE47dzpE+g2sBONSrC3lwZlWDggNAtbc5tt08lKrHjiZAEWzdEUwjdrSU9FZQWCu
	OnaGQ+LkJ8gD5ZvLztcJ0Qtz+hPhSHGLxrbRoghxEubaBPFppcBp7dNva962aKeR
	UkNnGjmF9zBu2Rh9N1SdSaXyVJ8fU+TESS5XjufqCrgbfNCzW97FslIxg1M0fshG
	7vsArA+0DhgcT7L3ytGlRPstfnzppC4LMxc+EeRFCAf83kInEvE9rQ65RG499O74
	VvWVO1AaWHVn+yyByyeovQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1jnk6ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHQaZU022509
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:38 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw88q9se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhayF/r9m1QUPyJ3OylHIWEydBb7qibilM7ml519YjjCGnMnIUyzlgAKk16UPfjxZctD9W+C0k/aN2jf92q+bKaa0H5OocJftZzREe7HPBCjvfBrpeicomYGRTn13gUu3USQP7b1plh5pxXzaJ4ovzpFhOisy93Oww50PezcGx2g1ybV44PjZNEK1cH3Ikfszbb3jLtyH0S5h05s7p4JMqbBn1UTBuHLi7XP61VWtvGzt0ChKVxFSH3ch9n7MAnG2Ny+Beo/HD4sIIH9KK0/+xIHouNl/FL5sRkigk/g0fCu+FEpRl/guAf2ruDbZuKMXIH9NNXy0JnRFDmZ6Vd2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whYsQFT6aOFzBixsUTI7nBIpltVKsw90RkNwex51hoA=;
 b=MDZYJXEvBVpKAg09472PZNl82vSG3n9xN1Zsz732f1c/fwzbE77pgbSVM8Q14LzRcuepypy88BYmDuHRmXzPFX+LeN5Y5sZ6QVAKGqOCLvinJfXsDOkwUa4gI4Z3/JDlbFlGAccRDdvSkWTQGaGWerOjPJSheP7vbHwJurI6I7v2oNA9T53qE9XGFQ95VVyYB1xqVwBNimKSvsBJKN5lD63nnAGkKmV4Yx7urZnKvRRqgQxLAS8FxZ73o7jA9JUMg7c+pnI9p9LLhRAcAh0xhqPpXwLLQ7XE0wmIAsjv3iy9TTYj63jeNJIWSQYxFsu/3CMftAEK38nRGWiel/2GvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whYsQFT6aOFzBixsUTI7nBIpltVKsw90RkNwex51hoA=;
 b=TjCCpHt1qhdDeNndRFN3U+54OIBdv0J3m7FP0IofOjBhdFAJKbjCcxLwC51e0Vg4qpHN431jRT4+wA/lWBaoFq4OCVwm6lxL8M8Ch5itf9Dupy+jMaQ/y3fHgWestDHCRVJ0AEg3lhRZwv3lpgxEzLI3fDAwVNUWVZiHFnkKDOg=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:10:36 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:10:36 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/14] btrfs-progs: mkfs: eliminate duplicate code in if-else
Date: Tue, 13 May 2025 02:09:22 +0800
Message-ID: <3df90c1eefe8d0369dac0923fef1267287a3e205.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 168d01d4-6d29-4a0b-70c7-08dd91804b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HV0od4u5lHvtVILf/XRV0ziSRvK9Dqz/4M4CZd2nHxYD86CADvg3fzlCRmQR?=
 =?us-ascii?Q?Suf4FmL06btqGuQm7NajtxBz8RfBigD+J4iwG5F/kGUm2i4jv5HO7j97dnQw?=
 =?us-ascii?Q?3mEPykrJ7m2hTel4Fq2kKn7vIM3GTOwjV2gO7p2z1mez4fjng1pBBnaJCWIx?=
 =?us-ascii?Q?FZ+Mvofpv5eerdcV0HGT9VMFyWhdsuw8KimwaZ8Lr2vc7iPZKlUTaT1DXgH9?=
 =?us-ascii?Q?4cCoAaxy05laQk9Ka3uS0QlfaXE3ymfVYrAfHRbWU6mnRK2ESxkDZ3tT9WJT?=
 =?us-ascii?Q?bIRZgokk/oLhvotASvkJmNqB1R3Ckcj8CPHINPe3HVQOmBFPa3B7pDm4EGZX?=
 =?us-ascii?Q?nfOKDYGxH8K6H/eZs4pH0eUia2n784ORbwAM+Bn7l7OOQrUYfF3Ca1Txi16j?=
 =?us-ascii?Q?4Cy3a7267Fsq568MPQLGWsC/KA4IxV2gIi1EI6/tlgiQCDUQWCV9G4BkX7Xn?=
 =?us-ascii?Q?WNMNEwzfDt3w7uSbobwMVoVinVkey7AGk+iIJ8xq/tC6Rr8NNMdWSqASzSMe?=
 =?us-ascii?Q?QRB63ZtvRqAa+NbToMin8GTs3cmZ4EXodEkbgE3ri+4r9YZZVhpugcW54Dvm?=
 =?us-ascii?Q?v+ol9BJgntbcayM8LIE5mfpo1+hNAvUgKn8h8txm7V88WOsnytFYLIhrdZCo?=
 =?us-ascii?Q?oasef/ign/uQ64AC8cjj8ngEIKJHqzK3cmEbpr0kegg+OJFaFYQeCXIBPtJR?=
 =?us-ascii?Q?KL0e3z2FwSbgp2mCCm11g6IVNko4MvK2sVRiLHjF8YkaVamIJ94Bl6tEZD2l?=
 =?us-ascii?Q?MsG3emleOAAMA82uXCoMHD4dcQ4Scobg0azNoxn/WgiU0adSfscRQZPLG0Q7?=
 =?us-ascii?Q?tzSWf4a6bl2hEeny+tM0IbhjIeOkdYLEE3+WgVeXkcAA+MKfd/YpXWOtml9P?=
 =?us-ascii?Q?eqCQm8dgTeL/e58zKeL3w3w9itsG8x8qdV5gB65+3m7jK6rhykORXF2AJ5MC?=
 =?us-ascii?Q?TYMF82QbcVZmkpir+mHJeSr0bPsUoogZnzx4/DJ97a8XH/JP/UdUhzc8LjNR?=
 =?us-ascii?Q?+uCqQWzaPOAfGYtlMgwtmmFjXrgci4Ksk8bsI4RqdEr0gv/xQEOCp1rBIugw?=
 =?us-ascii?Q?1REUdq5MVeiDybZCqK+1iqNHZHqD/8qJKROsFynN8RJvmdlA/VI/n7L2Blyy?=
 =?us-ascii?Q?vNgdhHmonEkvjV09w7PQw1DvW2yVtHANu7tdfVMbX7MbicqRr5AG+KieWCeY?=
 =?us-ascii?Q?1cbXJrRN4Yyk92zUBEoawk3X1kMf30kItexSknUE1DvoSjvOHU8HWj/0UTcT?=
 =?us-ascii?Q?VQdrs3J15UHP85D/ZhaVNDKpWzWFUakfQ8uwqi1aNfqy3D424QOnpHWyt4PW?=
 =?us-ascii?Q?T3ASx/HS2EZROPm4uOEI7f6yElC1IqQye7tsekfbS7bPlEhxn+mDP+aggWpI?=
 =?us-ascii?Q?/Q2ly4yG7lfvqjRQv51RBS6I/ZaJCWCKiQWa/1gDeQdfDiCpzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/xjOXk2ibk3+wcz06qCRJkZB1lvVI+DqM86rqC1+TfFoP4X44FuVHufXP9I?=
 =?us-ascii?Q?Qmt7TNKmGyk5oSNWe7wpqshgotSK+DPZ4T4ZEDYEy3Omz2qRHmT/CcKkgdAE?=
 =?us-ascii?Q?2FT3qVc8m7l9udFqqNBqj0hIPEf7Z3zJoLXlFMJPgHxEhJip+++VH65vQ82h?=
 =?us-ascii?Q?Eeo3M0BevndLriPtiK6amROpYXq9Wz75S5ch+kLrU0IcO31uyAtyVD0EvmiA?=
 =?us-ascii?Q?25JszbzAkoA4KrclrhNBcYkIGa6knTSw2Glv9kJT5ma/WStNP7R/JLxm5ydc?=
 =?us-ascii?Q?5og4e5+liI/FNNJciL420zXp3pxLolH8QVgJZrW568MnSB4KMKbdhKCHFwEk?=
 =?us-ascii?Q?K/ktghm2+pJ2aiWHeUTTodfgiAhBYxg2xRhhKXlM3H8E2+kqGSDM9QH5ucSh?=
 =?us-ascii?Q?3l+3U+m8Niz2lA6vylXm01oiwt+/bzRFTMdxPfra6JqPc7Ak+qm62aac97q/?=
 =?us-ascii?Q?atmTM/5Z0xa+qgb/em13PMe40IzX5fprjan5puCJeG6ctAAD1+r/mwzPWfVc?=
 =?us-ascii?Q?SkTkdVyT92jPLlc1Y8GoHcq0r3efJXvd+9tQlNaOe9nxZzaNeT1RPKCHB0uO?=
 =?us-ascii?Q?YktHCn0Zz1x8hLniiUD+SnBrFMYWMHu4jhcBAkt45OIDriSLdvM6XFGnm2vE?=
 =?us-ascii?Q?ee9v2TnSocaGrHcbAidFnUiKsw2rEsZsvZ0oIPYaTjhW3xSEvUYWNW0xYeH9?=
 =?us-ascii?Q?VkJTV5vBZweXV1YppFZxc5kKl4ANkEzTVC2y3108NC+467rKQOP6CN5CLrOs?=
 =?us-ascii?Q?yEXINBw7o5fX8LgPvFpRHQt8ZqGc3nqEFXZDlsxGjrEmtpdl3eTjDLdDdFdl?=
 =?us-ascii?Q?tdDU5OnCIKzpyhgFT2FrRMf15jKdSfVDJ82dYhUajvX+eLB4MLKYttZ26yl+?=
 =?us-ascii?Q?ziO1jw9wruTwnb0IWJ8FM974t/ogM173InZ8lKGA+4tf2QpYqYaYfhm2B4kK?=
 =?us-ascii?Q?C64aRxaiGLmH9GmK+b3nG80OS4MMiOhNAy7qKqxxUD8zzCdlriVJPpfsAYrc?=
 =?us-ascii?Q?0VtUpqUCvi4r8gWqVA02kOFzy8RpnVHQxLpAvyxWfNHGVsg8VF6ByS3znfFJ?=
 =?us-ascii?Q?3zta7rOywiI1pKzznT9JD2RwfT9vo2FJRTd5vaDPaaOq53wyD2Uyo4xm9l48?=
 =?us-ascii?Q?LwzwXyv4HKpQgaQxiluqgDOKzQEM4+dkFJsEhb5YcKiYCT2dZ9mwSc8zNMc0?=
 =?us-ascii?Q?hf0shmyBFiNJWIjDzCYhZ131Ha8ULqu4HcVsqs4lc4K8wKOwaMnXkIYYVEXq?=
 =?us-ascii?Q?XwUfi8kKJo42sagOjywFZ8YYGKE4kvtTECGzUPvsZA4KkgrcnE9+Qahrln1L?=
 =?us-ascii?Q?6P5Jk9oK4RF2WmZUdpGX60uaU6SGE8tFqp7itRIHpkLGfHUj2BXSLPc7CO3m?=
 =?us-ascii?Q?IzKrphltJvRImAihbwbn5NJC4B/3OCkJvVNJoLPrMOy5thJo8Yg42uWvGTnG?=
 =?us-ascii?Q?/G4HffFfZosZQvY8i7/UbV56+7U+hG5THlPsRWLP8pbOLxByB8XjGChfX0B5?=
 =?us-ascii?Q?nzUd+4CK5gBRH1QK5lziD7NanbxjPRe274w0/0AEQXA/5BGYqoVzLB2ZaGF2?=
 =?us-ascii?Q?g1B7ytsOYFZlZM1R51ayOkjcCM1C4Q5uFYruzQHb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wQTXsD58+A2hMb9tOIKmEqi3MVX0tFqcw0nkgowO71eEjP+zqqVpYmSvppSW8ti3RJxE+D+6WTaDv4KimLVtenMDGDnunpjjA+cevtzUcPW0HG/8R93HT1fLYGX6eNpFg3/EUfwomUESe92RHQDR9X7NXtTAQmqbnnLivcy1E8oGMQY2d9Irz1QE3sL4XgHbjtdgn1OYtoNmYW1A4SBA6S/QFgmehCMXWPBJN9ipLVBCyOOYFomprQe1hMGCW2YfMBSty+JzmtWyBtjkzSeDFWU0jhb+j8OcgMafsVViQYxjWQHyWtGL3IXJsmtWT8pH1p+nT1ODpNrmVPJIVGMJDOsbUgUfetX2frc78zx23DpQQpecv5msPbJ6jftmTXSUPwn0McTHza05KWhZla8nncPJ2ryGd4CfemAQKxyArfNqGEB0RzCmw0fu0oh3+e67cAh98WkticYRmdSi3yWQm5csOKyuW7n8IzYwvIESQ6jDLg6fwRBOX6ozhHRABkFGzXbWHEFzvlorknuRILBiCUPpXvYUQQqqFQ3S2g1miJDTwVdphDLB6eACreKMFEujEHCtLqBHlwAcw6VohhQJT/dm8ndhrlDR/U5dqnKG0yo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168d01d4-6d29-4a0b-70c7-08dd91804b6b
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:10:36.4724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vef/zYlji4wWBAbMpncSUotpwtj8x4DeDYwMDSlQ9eLli7yI/Sg+hVpm1KxeHSRJWnU0zwpuXznNkbZt7uf75w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Proofpoint-GUID: XVoIygUQR5vebcfYYQAjTls4NF3g9_mo
X-Authority-Analysis: v=2.4 cv=PeH/hjhd c=1 sm=1 tr=0 ts=6822399f cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=JzWtAMvUshBmqpXODD8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfXyCPRmRRlhvat N/8G0elEr5UXvu1jdxHFUyrDZZbt2rPHrJWCprKNx/uKOzIjOHFZJzqPOflaqxe924MlyUVYMYh Xrtye4++fP7zbb9lg1/QYVsnmxJXEjm9sAiskVCDC9aVyTOiMxo0ADxqZRZSTFVDnkm+W6arTGJ
 QqPJgJB8spDkllH0QoXuLUbRwaZX/OU8Zf9LqJyV6GJc9Vn9mVI0Pa2MiDsZW811T1zyExXLUAP TLQFmXbrZl7GfG4aJaTeXCJhEz+n4IMODdM+x8ZYRUM1aGAa0+7yDN6aFr/xXHgEkkcRZ/Xt+63 vWlCP/DmnwkKLt0sXHR2zAnEdCuBGnTYZMbWjR02e7Q4HplJTcqZHd5NVBzf/uhMc7VpLj3A0WS
 xD1rY6Uxivndms2b3cUVu+JUMk8yVWeKfrw1kLmEK1QSY5FZs9tLGUOQV3kwdwRlby7qASHo
X-Proofpoint-ORIG-GUID: XVoIygUQR5vebcfYYQAjTls4NF3g9_mo

The separate if and else blocks unnecessarily handled different block
group types for the mixed case. The local flag variable already accounts
for these distinctions. Merging these blocks and relying on the flag
simplifies the code.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 mkfs/main.c | 49 ++++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 48aa57f23d5f..f80b18c7ad23 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -126,41 +126,24 @@ static int create_metadata_block_groups(struct btrfs_root *root, bool mixed,
 	if (ret)
 		return ret;
 
-	if (mixed) {
-		ret = btrfs_alloc_chunk(trans, fs_info,
-					&chunk_start, &chunk_size,
-					BTRFS_BLOCK_GROUP_METADATA |
-					BTRFS_BLOCK_GROUP_DATA);
-		if (ret == -ENOSPC) {
-			error("no space to allocate data/metadata chunk");
-			goto err;
-		}
-		if (ret)
-			return ret;
-		ret = btrfs_make_block_group(trans, fs_info, 0,
-					     BTRFS_BLOCK_GROUP_METADATA |
-					     BTRFS_BLOCK_GROUP_DATA,
-					     chunk_start, chunk_size);
-		if (ret)
-			return ret;
+	ret = btrfs_alloc_chunk(trans, fs_info, &chunk_start, &chunk_size,
+				flags);
+	if (ret == -ENOSPC) {
+		error("no space to allocate data/metadata chunk");
+		goto err;
+	}
+	if (ret)
+		return ret;
+
+	ret = btrfs_make_block_group(trans, fs_info, 0, flags, chunk_start,
+				     chunk_size);
+	if (ret)
+		return ret;
+
+	if (mixed)
 		allocation->mixed += chunk_size;
-	} else {
-		ret = btrfs_alloc_chunk(trans, fs_info,
-					&chunk_start, &chunk_size,
-					BTRFS_BLOCK_GROUP_METADATA);
-		if (ret == -ENOSPC) {
-			error("no space to allocate metadata chunk");
-			goto err;
-		}
-		if (ret)
-			return ret;
-		ret = btrfs_make_block_group(trans, fs_info, 0,
-					     BTRFS_BLOCK_GROUP_METADATA,
-					     chunk_start, chunk_size);
-		if (ret)
-			return ret;
+	else
 		allocation->metadata += chunk_size;
-	}
 
 	root->fs_info->system_allocs = 0;
 	ret = btrfs_commit_transaction(trans, root);
-- 
2.49.0


