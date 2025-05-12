Return-Path: <linux-btrfs+bounces-13943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB654AB431E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB226188A744
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7C529B20A;
	Mon, 12 May 2025 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CfUD+NHL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kFNf0RTN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1829B20C
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073543; cv=fail; b=GMx++XMflAto79dUzVGXEfDdlLAyHiGsaIJg/frX2bOfPuhgmXHpWyyOtBD0YrNqfs9hrlwuSy8fdFCzNA91RAuPiodpe4a+2AxngUCNik4/BVCBmH1hFN3rtNd+0n7U5PTK0omhQqn9+ZYoEqcTgzpp1WF202NzEJ5OzVNsHUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073543; c=relaxed/simple;
	bh=CNy03bj662FZj4ioaaNBQlxhI9MsAe0lPlEevjPYLQs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nBRpV8m4+Ap+ELM7BA0ecnnsl9XXlXlxWNB5uBB1IKKpDG0po6Tnx3wJrgCrEH2hcqD7m7QScCZPFTQ5BXKQkNj6vHP/dbY0R0fdTdUuA6dorZZbIdbbBnQbB28G2b8SZFylZe2vuZKeMGD559VdyJkIaJT/wZrU/fBxwM+wdRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CfUD+NHL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kFNf0RTN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0tcv007993
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NAJG5v6DQ3rAxtgDPaC8+1hVpPi7u3jRksn2iZffLZ0=; b=
	CfUD+NHL5SdQ4d+10voD2IXM2v8hQfpOzwZup3Po7ig+vyFTOaQGPAYPhjl9DlnA
	vnaeF8kf6NLsLndHe1W9jVrpbcYUYq62USFvGWjWOLAtsBrBrTi6gMm+CyazKyXr
	GNe+HQku7fE0m1+Bf/LWuw2MQTtTXnCwWOxodgMMVvT7ZfiemrZ4fJEEVveL6MTO
	MEUANjIc6RCBoOx3/6HDhbKFU3hm8ZRSkDkZbGNHK818Unvhi3SlDHS5qPNo7niX
	HagetZtW/gDhK41kb7ggJpEBRuL3xxWch6RLj/Xs2jUD2zD/5p7no/tYXsTcFW+v
	9IOzOpOidi3IoBTLgXXZvQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d2b3q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHiB8H002851
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:19 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010020.outbound.protection.outlook.com [40.93.12.20])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8e7b3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9biAe6VltZrN7yoGr+WlYFrhnaY/0AFdrEruF9wwytHcosJmaj+A4CcN+Lh7jwUvPzle1kTh+um6RTF3m+Rw0TYtldbUUE3g7JQuKHa0GxJdQF2SaHa+UbcHvYEGCbfs+ATK2EoD3OUT5dPw9HBgWJxveLMaM5NC5MzttVShTAu6HMZzDuKRVBG4D8K7IDBDb9jPtyfYxvIXhHKG6tLxJAPpN657lFOIrpOwH9DHThiHFPTNV7EFbvNVrlIf8WfzZW80TAsPH8DssElwVjEkHHIrQjq73N8N+L6wwZGz35kpZsu5BX8aTMSDYAsyQB1TjOPq/yC3CK2e1fZr26biQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAJG5v6DQ3rAxtgDPaC8+1hVpPi7u3jRksn2iZffLZ0=;
 b=ltAXO+XjoFcG60IoNuIvkfmH/8zd8Z0NPp05KuakfWCD9WhywgtRGnGOV1LqAtThpmaujcs8EBB/v0BHRvYHJif5wcyU/CtmgtIm81rkmg5iOhOjfTCJwjToDaqIdJJflISnYmWkJp/4QnoaadfPCeJMKA/f/IEHj1v3z3JSdp6tRjDMnz0ne+/Tbc6CIDzr1oXnaSGjIoIneBble4tlwjDGKJOEAMcYmiTkEKFmlC7FAXP3gh+uIZKqJuEnGUfUCcQi4c9bJbRzU2R0JacAlt996ybxyJum7cZnF3X95eQ+r9bgOF2kOYmJ6C61kiGll2TEpV2pZ+ZgrnfPeF4tVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAJG5v6DQ3rAxtgDPaC8+1hVpPi7u3jRksn2iZffLZ0=;
 b=kFNf0RTNxVakYQiFLBB2jEzYNzZZgD9fX0kyPJAnpng7pefTPqnpctsAoIkeYJer62nJ4kasNwMzT5d8f3JzMM5SGlI0Cns4A91/Rc0JJ4540lcXSf9r838oNLdn6VWM3sKR5kmBP8iD9uU5ElGssf2dNBUSFfQ1xmiA3evDgDg=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 18:12:17 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:12:17 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/2] fstests: btrfs: add functional verification for device roles
Date: Tue, 13 May 2025 02:11:39 +0800
Message-ID: <cover.1747070864.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
References: <cover.1747070147.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b43fc8c-4a05-4f6c-3dbd-08dd91808799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K452Det50LQxVPKPWHtL+Pr/pRyfq36tSsFiqBgqUlngsOEnEbN7wlJ/21NL?=
 =?us-ascii?Q?mEoL2MXMADtILEhdaNE4k0LrkBQCocwzk1onU5TpZh1IcQzQPp4R+nxhs3O7?=
 =?us-ascii?Q?os1O+c9plR2rhFLkDG9RztUsWlfl/lh1mKYXOl8ItfCAMV6tW8ya2k8kxE8b?=
 =?us-ascii?Q?is7xRF04OMVrnzH/BKO0TpocLsnk1RVPYdwe7m0zKH2bDlaD8VP0AGv4WUKG?=
 =?us-ascii?Q?bExh3iUf03AvZCv8aH+B7HHKc9TpTSMM217aeUKLMpr+9T8WMICCzGzTHWTR?=
 =?us-ascii?Q?aZMu3CyTMTTazPMR1GScJYrcvyWdmLAFTSEW/0cmdb+6PBJJlMpMavsHNjSo?=
 =?us-ascii?Q?wA/oUWkJOYNLJgF3QjSLoP5vJkxFLPIA6uKOl5drl/BIE08gFNIf9Eq4z3Mt?=
 =?us-ascii?Q?dU687ptLFM0czk/6GHSKkCJXmdsHBtX+hHwCEI94zN8CRIuG+uplQmVcfJ12?=
 =?us-ascii?Q?fCJo2CQGVp3dWTAp+btG59DyNDzonLElYB8jQtTBR8Eh3hlfyAvrAKTzJ6hG?=
 =?us-ascii?Q?qh7xPndCEbe/av3cGnqNOwVlgkhh6a5avHSybckf4PxQ/VYm2UR6goy8RY+c?=
 =?us-ascii?Q?oZXRXAcpvi/WrRbTZMXmOXCyD4h79mME/OEKk0wbonGFccYDBfKP+vvChvab?=
 =?us-ascii?Q?PfeS28whXdsq7UDuFq9MpY8AZchQZ3e3/FcRnaSqDRm2VLQxRgGUEfVKGWlH?=
 =?us-ascii?Q?+3MgZQCUHynYu2LXKAnm51zsIS1t7dW2gjQ0fLVFU3DSu4/K1ajvYUTPO1ao?=
 =?us-ascii?Q?OgbfTUYc+pTmXhLBvLdePaLy4up52tFNP3CQtknTdlPMPf8WnkdjC5kSEI7m?=
 =?us-ascii?Q?NLtro453f0wkBlrYlprAkOjxGR355kMzECexigWqroT4o+tp2Di0XEtDBWWY?=
 =?us-ascii?Q?r7sa+kVtYCkjO7itFBnXbQR/KzqQO2/T8Y03/T4tm5DyEFa1h8UO9pyPbvtv?=
 =?us-ascii?Q?ko7TAimQYzSxEFrYUVM45K39VeqzlHcrIw65/UNnRbnmF90vhBnj6k3o4pTz?=
 =?us-ascii?Q?zCaRRJUg7K9KWzT77SLc0vXfPMEFlTHARxCrIYr7Oyx0367ctPbnqCupPju6?=
 =?us-ascii?Q?q9lgjNKZWcmoLiIOeeL0eBiz5QdswCaO8qByUbMoD/pugP/81fSuktxdtzwN?=
 =?us-ascii?Q?/wrlHsY/T4HmVw4bKPxGjTFG7/i4HRaf2kPRAYsgfIxb0PfgyY6bkJMUNmT1?=
 =?us-ascii?Q?PR0qgXYdGa4CtJGa2rXxySs3woNQdVTQwkr6oBVZ68Ncinu43J8JKnufMzYX?=
 =?us-ascii?Q?8Votx8XG+OI2kM3hRle36hLBWzAlHHo1RgA+yXGl21BpnfFEDG55EQbn8zej?=
 =?us-ascii?Q?32l0kIrs70boU3gV6fy/AjqvyGi8CNLwVxR39OZd2rHPA26aH+UMZmNWlC46?=
 =?us-ascii?Q?leUBolso4z/CLeN6qJ2DvYmv+e3BVCuxruo3hP0wPQxSnf9Bew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iEL9d73xM/p0yFOyfO9iQ1NW/tUtTDfQGvZwFsCqJSIE965eDqVc73Chj3W4?=
 =?us-ascii?Q?+wyxrhJPlPlGNlv5LsMjMJZTnU4mn9y0xVkGFg9s4CtMvGMyqMWSdwyr96yN?=
 =?us-ascii?Q?jlnjIbQGqPw/MeQbB2qOTCWqE0Cq15bIc5+rWh/JzQROgbNnWVF1eGe/IsEh?=
 =?us-ascii?Q?sd68TZfWLn8awmjl8RHv3UD7viu5KhQEWfUy+n7uwRaSvD8/wmR4FdiAWm3R?=
 =?us-ascii?Q?IUH9y8Zqz5Qb5QS4IJbudd+F9YPnA65D3xhg2NWolJ2lBWB8nsVxiaoX8hE5?=
 =?us-ascii?Q?MynMUuHAIm5P7JQD+ZWYvc7EgQo1Ya4VKVpXzlfr22ukQyaM1N1CItvK2Ksn?=
 =?us-ascii?Q?aqipu14jJCGfFTqy++arPi9ZbUzPbBNrn8FtdMNUpOR69yx91zEM3RbrCpzu?=
 =?us-ascii?Q?vkLWUNplNy+C1URjrd5zgGRVxEZNB0MxTREPybVB3+Qrd5JCzlyK5zr1LjqF?=
 =?us-ascii?Q?jEA2OArwh7EJmBiIdb9f2dEYOTvHUGTpplmD2UAkc+VXdpdAa1hkMtxGDufw?=
 =?us-ascii?Q?o36a7RSXWEOyN66ZlEXVhqvPZRDR8f67v5e+zIGVQndYexecTmIaZpili7kF?=
 =?us-ascii?Q?1AQ3/Amhy6vQytVwuscU5sOZ/OuW51VbsDTK3fPin2DTSM/CsmMfTHhLrkFN?=
 =?us-ascii?Q?jrqInRlWYGqDunjhR8v8lWD+86DlfmZxGF4IgVSzYdBkxRZ5Wfa02ZZKjSPG?=
 =?us-ascii?Q?iGwOsBXeyReliQc+YuP3/JKUT8kkc5gM+fvgYsoH8Uwo9DCCuMSCpStKBxj7?=
 =?us-ascii?Q?qaXD1G73nxdPfQoSQSser5kXvVEXXe8NnOitz83oSoaaeuMUu3U3h57pp2Tw?=
 =?us-ascii?Q?XZQrpHXevXZvz1Sqs2fe+IY7GcLFohRsL/P16da5za/f+JdlyGfXs2qM6+Fi?=
 =?us-ascii?Q?T8OgGnXH60VmeM/NjawS2Zo8Qdl/qFpKbXtU8Hqo4zQv9Lf/eX6pHJFhU65X?=
 =?us-ascii?Q?AL7hsdRxWEEKPB3CZGvl9qmCMowFUNHHWdE8x4FFAUiskKis3HmlFEs6bL0A?=
 =?us-ascii?Q?/IMPGH4xwmcxuJIEMkn9WKSlE51wYZri6rhlI907j69HkPwspkBo5jcLoElL?=
 =?us-ascii?Q?gRJoe5C/bPe224f4mb0ZiwaSAnGWwR1wgLHV56C6jlf2LqCGHRxBcOS8nSEa?=
 =?us-ascii?Q?NiB4CtkaXroxMQTpb8VzKZI5VVR146dgILs/Di1JOvESMKacDKgbGg3z1d28?=
 =?us-ascii?Q?eSzldGCsUsRmZw178u3e0Ekv6Xel53uyn4oP6IxtRmD8LkYxXDdWnZQXekyV?=
 =?us-ascii?Q?5wJh0Apf89f5K/QQnTZuPhlfs/qwiay1y+B/pVaJNoZlDwTprxwn/W5RLGgT?=
 =?us-ascii?Q?VHCvPKOt3MzbRbMk8l+uEhOanONjMlPa3S/I82iv3jpZPA2Do7luxcxwpmN1?=
 =?us-ascii?Q?2+lrMiG2O6SpIq4yP6Dx+2EA5wB7idHi9oLI8udoUvirV5PktYGKpLtjdNgI?=
 =?us-ascii?Q?a86Hm8G6EGEkyqlQeUvKSGf++749pi5W+3FPgsaanaFSeTleWxvipKZHI42v?=
 =?us-ascii?Q?+2tFCB1WqX6cpJNsph7YwRpyLr2Q1fkxApeCwEFSzP9zaDlj44JFrgWKQ0Qk?=
 =?us-ascii?Q?9f7iwOpBd8kYVm34BazZ+D5jlLtD375mJkBLWjc0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q5tLLLK/CQrGgegMTqC62/CffwSmTA6Ldq69sWN+SlzxaSXGDbJjIYS7lq04BB+IXSZ3TxtS5NUjcpf7qaT+5LV5uyWChr2ZSom8eGPp2LU4WiqGXGYB+Tic7QAnWzYr211+3cZx6NkptfepnAjK8tJoD4ZbU3/ujA8pp+6bmtCYDrbuLW4hQ3QWFpUhSJ8/p2ALtF5VeG7qNdPW7jD2D+PSDy3kuJDefMDGeSxNkZ1VNGfHD3JPcAUduOkgQsm/DJDQH0PSx4LafZOyXzib1VAqDa1Gk6osGYMd8DZ5zI0UYxB5BWehRtEI/jp9LWaYs14OTtBzEQG47a6DQQMDdR78MZ00NKexaGpl6ufM2MnUCHkS1WQi41o+2Vg6G5P4dU/Gx3bArJM5BVDhe20vQRkcVHUwQKtVF0+YUIkNQC78oUcDvBigmPxXNu2xnWkBAyVn+DnBMFRSxzIVEWAVmCeh8ubWZ0i3guqx6ScYT5TWsFYNQMUSUZBynzz7m0daeWJJClbqlqKvoSMSwPYb9gBG1mB5ydFdyGtI2fnZj4ZWLDLB9Au1y254BDT7kRet9oSbwstIqAIkz1CJNnLAkcXHZ2SYbymZ04Ha3ozyfT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b43fc8c-4a05-4f6c-3dbd-08dd91808799
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:12:17.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5FCXwL+d60HZqjnu6v45UtZiXAyqPH2iayYBCazZ5WCwRuzdQ32P373yJt3Zlncwa7ujd9FnZmuHACwR2Gz2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=905 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120187
X-Proofpoint-ORIG-GUID: q4j3Wxl4iaF3wafMin7tCNHgnOaiyArE
X-Proofpoint-GUID: q4j3Wxl4iaF3wafMin7tCNHgnOaiyArE
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=68223a04 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=2SpYOEDPpR_jHbvva8kA:9 a=zZCYzV9kfG8A:10 cc=ntf awl=host:13185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NyBTYWx0ZWRfX95C+dV2oRUBf 7FeFIm2QNhS9/HqmaGaSYCcaFbLN4or7kOnsmdpVIcioyjyeZNffDM99xDCB7lwXXWuIvWY3WM1 XYh5izlhIePotJQrHzS1CaWsbXwbSrBO9woD/goCt0HFGrD8UWhbjAVGeZtSGLSp2QzQ7Pbjlzs
 UxZ0+fbZqermLT4PtKhe328Wn1ZsxVmyH5c3dg89Ndv9bofdCN+4BqrKnKRiCn13w1wQyokp3pX ubKlUNhtQVsGVJHW0rOSEHKfnt4sBQhb2qNQp4NT9mrS4F95/mip1CclRPLio7gIQXazTo9qXyR 6tLTVZoG+0aTDE4a4QVOU352fbh8GeexdzDx9YS+U+a8rPfKI63XzpQuKJ8OUqN6cpiRKq2JCSZ
 M3M5FKJ56AeleXmeT1SBx1UgzkqonWn1INh0vzaEiHDlRRfitT52ARwLdPEKzWa11Fm7/+o0

Add testcase to verify Btrfs device roles are assigned
and that chunk allocations match the specified roles.

Anand Jain (2):
  fstests: common/btrfs: add _require_btrfs_feature_device_roles
  fstests: btrfs/366: add test for device role-based chunk allocation

 common/btrfs        |  12 ++
 tests/btrfs/336     | 259 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/336.out | 153 ++++++++++++++++++++++++++
 3 files changed, 424 insertions(+)
 create mode 100755 tests/btrfs/336
 create mode 100644 tests/btrfs/336.out

-- 
2.49.0


