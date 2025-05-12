Return-Path: <linux-btrfs+bounces-13931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E4BAB432F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BAE3B169B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1640B29A9E9;
	Mon, 12 May 2025 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p1QB4nY3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kRn62l8x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A315529711D
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073433; cv=fail; b=mRmB6Ms+IkxxwKcpdNsaoRJsgPDACHjS8aoUcZdTwm2YgMw7G9M1inGDXghRdCY3l3DwBQd+64Gap8AreeKgGmdwAuC8ZCFLPVCTh+Oxm1WCzvy4BF9ZeP6j1tiW1TqeOU78LBKxMzqGMQuCfNt9WNl5zMnRiRK0yd0Y5zJbcyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073433; c=relaxed/simple;
	bh=L8DrOkVIeTVHGVU8yy2jHe9CQfakLRf2fOyCw8BdaM0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=awH1HIf+SfST4naVKCz5w13zdCppb4auTxF23miOP8At3nC8HNCXytCk4RbeHwaNBEVz74CJF/NNvjjv+hLd+C5aQxDNLrnadLH1pXaBPvObdHis6H9uX7+ygWl7ktzEa+AFrvU5JSGKMRhZ0PzmmkluYdp6zUwVovMSxm8BI3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p1QB4nY3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kRn62l8x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0tYj007997
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JAXp02BT7CjA9rzBI6ftcirJ4Vr3dqZWtPGuospCnWA=; b=
	p1QB4nY3Z/PekaA2WbCWG2FWoZLZuUH2rMRftdI0mJkBPngZhmjbhV8y0XXolavn
	taVWceuHysVlW2DJ6mncst7rCh/fzw05Yb96w4Yao1Kyi9epiH5s1goeAfw1tvdp
	0hC0mbodfYorXPM/Dae0lBjmzW7KTtD2kt61pIMLvdidl8sJOajkFu9bJjgtNjO8
	aOvc5j2BAfM9CiziaqCNFARYfMUCSlRf+KXZyajGGuUKAin6KzRnLnxf/KJ0PVns
	g7gx69Ws3BTm5ZXL9OOXwBVXfc/DFMYAbehNSWzp0LQmFeOZkTPBw5yxcxmh6Nxa
	iOQRTzy1Ol+mUsJ+PA+tnw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1d2b3kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHcZU1035662
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:29 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012051.outbound.protection.outlook.com [40.93.20.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw87q61s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gc/uVDxAKNMctUHXMo4cDURfUd+SO/7G2ubl1HVGuemN1Nf0LG/2E7+d0pcDi6FIbDM0MppF35ycofLLfkclj/h2D06yc9bjQrTsZcS2SOCP+xV+K6O+O0OxnFy3LEoyhFZvv/PSmTGMZQj8xx+pEZoumt+kRnaMbM+QoIdeV4OkVGR+0SrwAahStm8yhAy3CdF8+Ed2qpxxctg/1vmuKwE6vRpOfwtmgooRxuqox92uLxaNYtqMtg2Yqt6Fjvhl04PZZtxACsbh5bttm6duIhjrekHoqs97DyiWTTfM9lhh9JdotCooPnzqrs1WdqBZURSq/YYRuN23M/wxLUQzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAXp02BT7CjA9rzBI6ftcirJ4Vr3dqZWtPGuospCnWA=;
 b=PJE8yCTjMA/GdvEJYaSutuVYjdLwPxQoLMRH51w5sJItfW48ErLquAQmx9GFbUUqqWyFmN6bMh3IA/v1Ppgxffu6UtOJruEFG8JmsErO65kdY7VXxLZhiBiy4Xw8QJjOgC6mvUGtZExg0/tNXJRcpteEt3xDteehNLXQHc3GLQnKIWVdDG6iLYJl9CyLMW5OHvD6Kv2LGeKF9fJIC2LiJY1CdAfm6S+F7vweeuajiAXqDyHF2M6IsnMCjfm6z5CAzvPXWjrqAno3oy61Qa7rUDgfi2v3g+HigpwZ5nWEHOfTtTzf4rs+vIPv63VqT24UCC8yt8RKVqUXisYQ3E34SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAXp02BT7CjA9rzBI6ftcirJ4Vr3dqZWtPGuospCnWA=;
 b=kRn62l8x12qwHWM3/PLacVGh5EYvgoAxTHmHA8eGO6oFTy0dJOB1ooHcLaXQy3x4wWd+AJe7LT1xN1mM9cDIh0qLlg2rgBHPs9rT0Ft5orgDEgCqk6jiNhcd+DB6gV9MJsA1jzZHFkuNGt/IL+KxDrGFYy5X1o+tZsU4IFrxNys=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:10:28 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:10:27 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/14] btrfs-progs: rename local dev_list to devices in btrfs_alloc_chunk
Date: Tue, 13 May 2025 02:09:20 +0800
Message-ID: <ee2934f8125425b7c3a81be16076e555e4e90ed8.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: afee5225-1c44-4844-f2e4-08dd91804648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t8aaWVH91WE0/imN22K67JFqaJDwXgwOeTVaf3W2+ybmIkPquBpBpL5GRwEt?=
 =?us-ascii?Q?BUxV5lKnfKmg7bUT3Ky/rHkW6n5OEQoU8qaBsmWH2xpnRgmdw1uRjU4In2em?=
 =?us-ascii?Q?3sm6R5EPPswhmKUnBKNbIeukLU4VaBHSHfaz5xLwa/Y/oH+PPJtPdhK+jkiU?=
 =?us-ascii?Q?eC7zgg+NI1WqMRj4/4ZIBStZDTHs7p1Pgd78NFDj/it2gnLJkj8N28zw35dq?=
 =?us-ascii?Q?w2IE+oJYNun9GRzJ6O/mEonzEEZ4P7vDS7nacD8+SLTQ3HlHguU3d1tBKuEX?=
 =?us-ascii?Q?Ve1W+33bZTH84Sqdu40gbJJeWT3GFy3SBaq18kImbYMg3ESK3m0q7H2WnmEz?=
 =?us-ascii?Q?pMUSZenCrgvOS9BGx4QGy1mvt/42Lcj10yu8VYIhT8MJgk7l7eiIPyOX86rI?=
 =?us-ascii?Q?UQzDnj9E/ks6rVG2yHCv213u2/eN793gYG0ExaXNGJedAGJy3D6xLpK4c/yW?=
 =?us-ascii?Q?wxbIrzaqBN+hElQ9xNNxhvcKIn02mLGPgWmMttbGDpQoEbGuduPacPBkhnRu?=
 =?us-ascii?Q?6qBJ8swnpT8xO+phCD176PsOtRQs4XumBGYl0tbf+y1/kOr558/g+2/tEgnP?=
 =?us-ascii?Q?qzle4KhdL/mGF/MU0Z5QjiZjXyUpyG64Z2ZYN4AN1ozXcEF6nXebnUQcG13e?=
 =?us-ascii?Q?q59w1uKLxnaNrbkS2X9+Hu5xp4oo75JG8v9b1Kznx/Px+90izoVYDTWNZ/Fy?=
 =?us-ascii?Q?AcOdXWeST2JIfy/eWbMS8cgCOWLcKsMGAntMQZCpS2Mr1fKbRXFIrfxqusC2?=
 =?us-ascii?Q?DuHbCuNJeNRGe7SzOoJrUx9a9LBAN5XUwUpkAWF60io4asKx6PdDt4Q3vv8Y?=
 =?us-ascii?Q?f6VYy2+QPHDr79+JUDJ93wFmSse2qmo+dqt7qLHchC8aBNnlJ+VTc745WuzC?=
 =?us-ascii?Q?u5ueLuNBMBoVjAv6R/z9Udnz0xaCm9ZCZ4t5HPYsLSf/wTRK9juUrOJ6sY5O?=
 =?us-ascii?Q?CbkKmSwbmcLl+ZPx+J5Gcgtv+w98iuon43aPUogbGtoG4MDGqkvPpN/k59LU?=
 =?us-ascii?Q?1vJ16fyph3LeEICyb0nB1JqJIl04XiJbXWbmUZtelSbBb+nSYp4SMqQHa0yP?=
 =?us-ascii?Q?q36brIP/6iIdWAWGRgiAfSet8bMlhPqY/gjoA9aeB3oWc6QnaSRLEvQqn6Kd?=
 =?us-ascii?Q?TRHT9hHzI8LjkuUMO5O03SkESWZYoqJo4i/7selVgXolNOLslaQTRjepVPvC?=
 =?us-ascii?Q?E5I5bNCEYgrFOKy5y2RwA6+hnSlHaQGynkRZOMJ4DG17onQVnruZd5QSm0+C?=
 =?us-ascii?Q?P/jYYhAoWRnoGqPUWQQM7wosQn6gHSoqjwiNE3NiLoTs7UJGMwFkQVSGBwwl?=
 =?us-ascii?Q?KdCnclaer3cBS6VbNrjNyHAZJamH/onTpTH3MD6GU0oQrJ437icTAtBHomaf?=
 =?us-ascii?Q?L1Kw1HrKF7Dqw/TDLePCs3wN4C+BB3NwtimmONTnddahQrVXYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yorchTKNjb0+PloGlaubHyd2ZvWCRr6ZQBAK4m3scUDZSGrCg6CsThnyQqlq?=
 =?us-ascii?Q?Sove2FZrZyB4yljy/EAplnFd+SurLD/5zhg8ZVqAkWY+B4pnIZVWFZ19vMEV?=
 =?us-ascii?Q?eWOvjPoOms3xPcHBvmBQCmzhrZrHa+8MOE8TISWZtqS7a2Q1PplBZlrnyPji?=
 =?us-ascii?Q?X+pG+uvxsjTmBoUtg2RVfJNpcMRz7Nvshjmqh0v2D1GbaF/bZVdHndRB+dP5?=
 =?us-ascii?Q?HUFZjnm/gtiEpZolMkXHwJ0evGggAUyzcPyd+wH3m70se5ajhoexcDIjkTci?=
 =?us-ascii?Q?eddmGYL89EV81gEKlW6wO3ZgCiLdCeong4SVfJuLqcnWnXi58YYGh+8LGnhZ?=
 =?us-ascii?Q?HUbvdGGq+4SOK43YYQ9Gi/8JVMNooPM9fM8W/vPNIN0BsoXxnYRieHrDoKLa?=
 =?us-ascii?Q?/sggnhDUHHwWzp/3bZx87P/rQYdxrXSYJ9RlOpwKQRLgzZWshOFmw5KQttmo?=
 =?us-ascii?Q?XeDnWAaLDqfYsbo9MZkuzT+uB5McD0i5JFClikEp9GkxkjDVjen92hnLqtG6?=
 =?us-ascii?Q?YoFbIzdsTWzro5EnfJ1j0thx0IXCkx6koB1kZyEv+By/xnO2iXOznTKzMWHS?=
 =?us-ascii?Q?XbPO6DU2j8cU3CYt4aAjnDKWQaYFpYKPUDCVBZADC8FpscXEXDBhF6JJ90Nr?=
 =?us-ascii?Q?CDfWbstiA2JCh5u4qZCvIT4hZTblniqHJiz38thLP1ypcOeF4Eeo4KtrgrTF?=
 =?us-ascii?Q?3Sp4zw7GBeWKPGHYftDd02EFVWlp1x9a9RSgjBZ8V2hDLiQ9LfN5ENKI+9Q/?=
 =?us-ascii?Q?W0lJJEjb7oPNucmevSSRBI+QIfKICqDxOHI/kck5TKlvSC5eoAEVLtNzba8z?=
 =?us-ascii?Q?QbT2KW9Yc4Q5O09Fn8XM9juvkcfORUFVs0+XmgqdSr0cjaQnZ91WHI/mqyvI?=
 =?us-ascii?Q?JKUJ6/N8Qlk+4dyCG7riTf+HrlG+3mz/RagLykL9EVU4nZ/MJbyZCGQo6Vo0?=
 =?us-ascii?Q?1TS8ZTpgBgu7AvQkjnZ6JeHfUH0OfeHXpZqNVJw3yeby4o+wVADpxMennB9O?=
 =?us-ascii?Q?jR5iS0Y8WutL4hJ0LDpEAFjGxvxTWXmYEOXQgtiWZfWwF62/LFqdPGMan06U?=
 =?us-ascii?Q?K/O1ESYvCDOxG/phrxPJ2vpetTmjJEuKlTabqmPGitMtG8X/tOH7DQBW0dWx?=
 =?us-ascii?Q?YKTxHcqhP24vtzOuHAlDZECFuUgNx41T3cdu2ckeZZbuMqW7R1EMsi/RcZdw?=
 =?us-ascii?Q?PCynkzGHqicDx2saK6bfCYBeCPc3ESWkYmOp9//582hs+fl9kwIBL65ymg5o?=
 =?us-ascii?Q?B7wVZIoQu04A0SM89W3JpiwyibwwBnCuDbnzvktDuX7+ynFaBhEOmwRzWGFP?=
 =?us-ascii?Q?T++cpauHPevqgameuEzs1OxE3O6Odwa1Z5Es/3nVRmJ2QVhA1jlC4/f6pT4M?=
 =?us-ascii?Q?M0ZcChrvH/7YBDH8QPytIXeJZd8aruEX2LKlMU8vDlrs4OwZfbIWkydiebZj?=
 =?us-ascii?Q?eZmQxtGGANo8ZWCa538hAi+oWAqwA3vRWX5wm6+kbO3ieh+/mczH0ab4zitk?=
 =?us-ascii?Q?xcyS3pi9AtT8Wjz/Ri/gIuOrMmL11BGYFq/zHnHDFRIlU0RBflymJMQsTzNw?=
 =?us-ascii?Q?VEn6G5JYy7Uj8wcPXgUWOrVzauB8wWp0MSQkFpUu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sT0GgHOIH7AKp+ffT+VfY/uvgYHzV6SwvKWS9vjvhljsgXt7bue0Uj3h9s/2/SNevcnWQ6sWoKX1CmHXqFnAf/JyZEdXG7BYe0lu+YLqjyLpLsycxQdNjq+RW7KfmI0LnRsSLVeR0R2Q9g0cJY5PnoYx63E35BR4oBstd+ti0533eKQ7nQe+qHR+gom/iw4dRG/8R7XT0p0nQ+VzoIfF0e4+AqDZd7dN62loHHzHE230nY7s7aUWXwi61/HzvrZ5u0//fTtmhaPu+BKtQXTNDSnXtkoQi+m99saIIY+MIrfZ5sHIuuDUk7eEQ4KeJxLkb2YBdgIDMbVw1AsqF5u0zTm8q73PUxca5hnZIXgVQNjYytgQFkN9owCOmeKqYWoQy0sX6wAjjsup3y/Hjc+buvoFUbBp0ydRow24jjpccoTOuPjhBGG0HS5QKFbiTDuqfh4H2Pg9hS+wFmG2Ttdk2/fVyYKElCCMm5Ouioy7sE52NfHo5uePKDOUI6lSvlnVnSDLcLCOYdbquOSh/2B8S/Sdd9pAbp9xzeNac3Cp0baVgdhDtfv9XJgfi2n3RBsFWWCKQR/cjELr7LPqkS6s4cJf5Fz0ReZXoj8u8N3oUOI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afee5225-1c44-4844-f2e4-08dd91804648
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:10:27.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwudI/AxIYS9hGct+kOull2chXrwtDLNZs1mnqOyU8+TZ7QwrbwkxthxSX6UbDKaonUAt8FBoI5yKLRsKsGejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Proofpoint-ORIG-GUID: z0NWALKD6SPijvr4hdF-CFdToVcAJssC
X-Proofpoint-GUID: z0NWALKD6SPijvr4hdF-CFdToVcAJssC
X-Authority-Analysis: v=2.4 cv=XNcwSRhE c=1 sm=1 tr=0 ts=68223996 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=rX6nhuME89Rf5D-O_MAA:9 cc=ntf awl=host:13186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX5kZlwX3D9BDJ vF4jib3v5lYcOQ7/HzFsi2QP/I0ts35PmuAKa9pcHuxtWHM9MowiIjSceJhxxPAskIobmx/Zv2o i5JlzD3gkBoOErKOVeIvyDs0VX2Cb6QLkG5otM08D8J5rLqPMZB2TeVSdEM4Np5oLHYwbEnsYKM
 mKCQrKEiNVjh6Qa6j1l5xe93KFF3EnHwcboS4LtBgESWbwF/LT1Jsj26m0jxXJogf0hL6R5by4Y TrS1JJk1WSBv1Qjj409O/y30ZkpUxl/8SQhhCdOxI4tV+2bwL/E898twSJVUJxZG60SdOfvhUQj yYBnEdAqDV1sdzEt9rSvhf1HGSvFsUp6tqLaxaR4gUHllZgfmQ132qC9YvpdQeczjnCklL97vui
 T6//m79BT/SYI+BJ5U4tmejQP27hZ6IZBoysXL/vSmz9Ujo1p189JXL6IX2f24ra6D6kfmE4

Rename local dev_list to devices in btrfs_alloc_chunk, avoids confusion
with btrfs_device::dev_list. Local variable dev_list currently points to
btrfs_fs_devices::devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 783505480765..be01bdb4d3f6 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1688,7 +1688,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_device *device = NULL;
 	struct list_head private_devs;
-	struct list_head *dev_list = &info->fs_devices->devices;
+	struct list_head *devs = &info->fs_devices->devices;
 	struct list_head *cur;
 	u64 min_free;
 	u64 avail = 0;
@@ -1698,7 +1698,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int ret;
 	int index;
 
-	if (list_empty(dev_list))
+	if (list_empty(devs))
 		return -ENOSPC;
 
 	ctl.type = type;
@@ -1715,7 +1715,7 @@ again:
 		return ret;
 
 	INIT_LIST_HEAD(&private_devs);
-	cur = dev_list->next;
+	cur = devs->next;
 	index = 0;
 
 	if (type & BTRFS_BLOCK_GROUP_DUP)
@@ -1737,11 +1737,11 @@ again:
 				index++;
 		} else if (avail > max_avail)
 			max_avail = avail;
-		if (cur == dev_list)
+		if (cur == devs)
 			break;
 	}
 	if (index < ctl.num_stripes) {
-		list_splice(&private_devs, dev_list);
+		list_splice(&private_devs, devs);
 		if (index >= ctl.min_stripes) {
 			ctl.num_stripes = index;
 			if (type & (BTRFS_BLOCK_GROUP_RAID10)) {
@@ -1773,13 +1773,13 @@ again:
 	while (!list_empty(&private_devs)) {
 		device = list_entry(private_devs.next, struct btrfs_device,
 				    dev_list);
-		list_move(&device->dev_list, dev_list);
+		list_move(&device->dev_list, devs);
 	}
 	/*
 	 * All private devs moved back to @dev_list, now dev_list should not be
 	 * empty.
 	 */
-	ASSERT(!list_empty(dev_list));
+	ASSERT(!list_empty(devs));
 	*start = ctl.start;
 	*num_bytes = ctl.num_bytes;
 
-- 
2.49.0


