Return-Path: <linux-btrfs+bounces-11740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C60A41EB2
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 13:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64D2188B0D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 12:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947C623BD02;
	Mon, 24 Feb 2025 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CHl6cBNw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fT8wHXHS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6C23373F;
	Mon, 24 Feb 2025 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399337; cv=fail; b=PQ/ukRaM/HCZCCfesS2K2rq1yeorgH5T1bdai2bXqYRIt7LbDziey70oJYFOoM0gvunHmnv7loeHjHYwKqsNzofMvP3tw6AoGBk2n+mnBokAiCPUk0BOUGiqpB0b0fc1TxFh2knINQSfdspcxxa2Yr2v1ehWt0bV7bwIRqCMFyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399337; c=relaxed/simple;
	bh=cUsEgtaqtGvq9h1WoSKzak8mxlqCDBmtPhYA0FQ80uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K5ykBRXrel430AWmjurOB67n8OY47/Xc/MxFlAYheVOUlW7byZhOPvXGg+l47+HYPQh+I1x2NC2G2M5cDEvxOjQ413foVAYNJedIA1dH+jc7YJE+eMsn4mtON3cnp50HgmsPsFPQOmgZuMVkvLb9UmvNf6ntmSPHGV3g8ujl168=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CHl6cBNw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fT8wHXHS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMbeJ015110;
	Mon, 24 Feb 2025 12:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bTD3mHK6uVdexc+dff7X5PV8ShfZXBU6sDP9XwCHjsc=; b=
	CHl6cBNw4iLs4fWFN2tR6lv41iXvSS2+TS4pTHNXNAUR/JHEmL/EU12tOvKGIHIU
	Mkjeo9J9V6jUqi3jRkr5K5QBj6gGbMOTh1bJAsIPg/3H1pOFJiuRbwd7hGvNpW/X
	fwLeI/XV45xckS/hW28RfSFPurrZCf1tDlNMeNlYjZFp1y6NuGdFbxBzKWLzSW14
	zmDHWEZWoMJ1pM1IXJT2Ev72n4gMcxzEjIsBwX8QKyZ7mOLdpdKK2uGz8Aw+N8ZI
	+nLAPBuMmVrxJvJhpp3abmSgBvnXEXrv6/tnk9gDQx280tItbhCrp/pxHkA9ReQd
	brMxa2xbjY2JUNZNzeYM5A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y66sadn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:15:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OAW0go024567;
	Mon, 24 Feb 2025 12:15:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y517je34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:15:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jrmo/s5tCZxAWUY8y4SWXDtLpM7809Iq0X4XzJikHzz3Cnf2BMrpgFVo9UHgNa+JGNqJu0HNLDNgynyJ82pRzlp7v7ijCH8q48oFq8CBpUGSBtyTCpRcHpx6qC8MGoM0hKoxGDjMDd+lGceDZcc0a4g+MiSo+uWARw02SkcfbOgHy4nKxlVI4pkCwdJrHHXu5w1unAJ28sdJYaJD8KYRzD6v2xU3vBDt8PsZyUVjyKsYkWFFYm7SBT0ifJ5ve0vufohu9JSJ8+f+ao31sAq11aNcBkYPPA8mNnRCG3Bm0dPSeVVFCMt1OshZDlmXkU66t8dT7QSK8K16gZ585Y8HYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTD3mHK6uVdexc+dff7X5PV8ShfZXBU6sDP9XwCHjsc=;
 b=XwDZcmVOy65nzXVPOypKBl7ABR7or2UBwrQnplt2CJk60evon9KtrqY34Sd4H2rpkEJvrELJST6b1ysljqo5lKqDvR/kccTaTwlf0YUpHPV8nDe06dYRnvCvFC31ruUmQO/NxqfxD9BJFQMkI0QurCqRKMNk+5KRSDzgoc/XzUq6TIPr8D+D7TY53CRGsspsg8o3VkY7HSbOVctpYvw+/QMM81Ay2e2mbpKqO4peq+GkzXA+HJQ/UOZ8nkKCIW+L326d53sb/qDE3mR50kL+O0ToZFBUXMmfoJelVMEdjtjcZg3Q4DUd2wSuDZaY7NX56S0wXyswbiEIG9wLsyY3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTD3mHK6uVdexc+dff7X5PV8ShfZXBU6sDP9XwCHjsc=;
 b=fT8wHXHSiA2+7aTsHPNU922lEhB00pGGnP/tWUTseHTyKKNeT0XLcHZoqi8ppYeOIOdpSR5YjuezqmB/0XvgV/JCAG7gBRLPRdS42TobJVANG+IHhp4ya1ji2gGinErXYyuICxax3/LjmTkkXueqNzEyCTLUrciw3WCnZWVWVLw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7202.namprd10.prod.outlook.com (2603:10b6:8:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 12:15:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:15:26 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH v3 2/5] fstests: filter: helper for sysfs error filtering
Date: Mon, 24 Feb 2025 20:15:05 +0800
Message-ID: <7446e568cd73cab408a271864718df5f49a6435c.1740395948.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1740395948.git.anand.jain@oracle.com>
References: <cover.1740395948.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b78d795-a3b2-4808-61ea-08dd54ccec0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cgAcEzslTETb9Pe7Gp7wVXB8hyLI6l6u91/IgGdRFBKeL0HQlRUFPGN2tex4?=
 =?us-ascii?Q?AjgqkECqPmco664aTsXOmwr2z8zKF+9tqclSlJHRQy7ArWQPAUiBu/nQhSLH?=
 =?us-ascii?Q?cNznx1ONeQcn+utmx/EemSeLfoFL7WcYpiROFGaPEQKz2V9SoiSGyXrWnZ44?=
 =?us-ascii?Q?0rRUqa0QQSgrlIG2+yxmxyAAcGjNEUhnCs9zhHA3+o/fTBkhb8pcnnF+Kar5?=
 =?us-ascii?Q?/j2dQH1COg50EdoaDyP9aeyh4GmeHgzwgC3fjfmJwgsfvlMunKmnj0Sfj8fA?=
 =?us-ascii?Q?WC+kIq0UtERPr7q82yQI+Oj5qUAxKXwIJqz3U8aiN/nWv7fi2yyKNSWs9OYN?=
 =?us-ascii?Q?WJFf63Fn+ttqgujW1tzESh41RTN4N0cWNdhgYCyeyf/urjo3xAAQhrMrZBa4?=
 =?us-ascii?Q?Q3jOH93cISm66bXaQR/RL5EJ+UokK8sZTUfGqa2f/8rgI3Z2Csb4RWnoS/0f?=
 =?us-ascii?Q?/dW3OD8CecAuUfh/9MB4jcggJZCV7AKrX/i4w+1xu6vE7aTguD27Hu7poGIH?=
 =?us-ascii?Q?tknNWXQ3lw40z5gAdstP/5c7aqLOn6YFLVFf6d6jTKLs2+g5yaBtUvFPPu4X?=
 =?us-ascii?Q?cdExzIbCKboQGXf7QC4c1dc6HCEfhlIK3e5ghy1gENkhsLbewJrVv0kv+A1c?=
 =?us-ascii?Q?EFjohDizLtNxkaeUfZwnKPyR3ZrpY9O9VAp5dWrFyWFD1PWb/PNhgjfvMhMo?=
 =?us-ascii?Q?jTcyGz7pphXmf3xQr90iYHPQWkk5wJ3q+N/i5Utj/Iwlqi/Vcow9Gqmf8GR8?=
 =?us-ascii?Q?IqMEyd4pTYaT8C/lDqLPYYSs3ZLo6fHdDNbZE17ND19eDl4OE9P6CfGI0hxl?=
 =?us-ascii?Q?8Q9xNTPqeMXC6o8cFd026jz5hEHClUXRjng8nM/yPSdG0++owyswkQD0lqXZ?=
 =?us-ascii?Q?P0lrMLfMOB8zAPP8o8r/oBXxzEG33kWIMyKEri3Eu+VT2RZJ/eWG6j2dqNqH?=
 =?us-ascii?Q?XT68tHiXzcFa7cVDTr7vVa0IA6kjx9tlPF1QVCkkOSR1y3w258FZCfTCDG94?=
 =?us-ascii?Q?RHGn6XHOaS8CBi7rAfPArxLWSVRkugNlhIcC8dxseCXqewz1l0fHKRyKjD+t?=
 =?us-ascii?Q?mkuYhXgAWg+z8s2sHmY+FVoZ3FdzmGRsrqcwRpqmeBuT5AJWkDo0C89Kk1Yn?=
 =?us-ascii?Q?QJpQpQMUvRe6g4/g721LN6JqtgfIYMoJk2JfrBZcFynaiyMYuDjoKvFxj8q3?=
 =?us-ascii?Q?PijVgwX63JmG/fGfGbIOfu/I7vxOe8Ex92lns3uC3wF/fLQAcbVTLzYVXGqy?=
 =?us-ascii?Q?MjQC+w3vRcL9ZhDsgiD8OaPDF8paLmlUXOwca7Uon/wR6ll8xyNJgFYJnEAb?=
 =?us-ascii?Q?UXS0ZW6ZZBP2gI+Hr4vNTSJ4QhaRZf3cGaT3HWmXhoT1UnR/ktmYf26HflHR?=
 =?us-ascii?Q?gf4wBsuYYX5zJ1FZ+iB5vMIZqWoM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?drzwOwbwmzCo0MjPKKK1uDqyYFhnzPGoDfpRGRpFcgJS0zGAeGIQ8s+NUHRj?=
 =?us-ascii?Q?06Oi0QkpOKzTH1ks46UQ0K3JHPYjxGnoe5whTVkbGz2+1P/vRo0GWlTPOuum?=
 =?us-ascii?Q?YNz8pww7wukmkg2wT5B348aLbLYUOrgKWIYfodG3O6N3Y1KHr+ciU7+FwK/g?=
 =?us-ascii?Q?GB7u4PYz19euUvyof4/4zXL/rptCEq61nhmHMzeEGvdbvYDzQ7YPK59P+IrE?=
 =?us-ascii?Q?kONv+Ghve9aTIbZCLatV6EycCwwM8Y8+Who7lqlkzFbxjqWoK0Hd65kTRWBN?=
 =?us-ascii?Q?HMbYrxCfB2dPMz73bxHya4H3f8j6vzs7xOrbSgkfOFa35OMyF/Ul2DUlJCff?=
 =?us-ascii?Q?sS9OZGNq0n7K0XwZSQrRLFEYnkeRZ8xNLL4E4jqu2alOJMtERQk9tFCmxA0B?=
 =?us-ascii?Q?N6X4egP6q3GSNXWDNIYmLK22DuhFqMXefWAce6xtRXfB/B/AzDFtKfgSHBxj?=
 =?us-ascii?Q?eJYeyon9SV3OOTqSakrur4v+AjNrwB5j6Ri/139q5upSFQL/HH9FRq2vZ4UH?=
 =?us-ascii?Q?bSegikwB01mcsUcz3vcdDsis7y6da7frK8ylpSQoh2pQd1AGTPoDluKzv5qj?=
 =?us-ascii?Q?BAv7mLHt1MQl4do6JY+m+47/O1y5Jt1W+Y0uO2lRJ8awcxzASQsdK13dRHwg?=
 =?us-ascii?Q?IAzWSeExkK/3tx4wStfvyUkC5OzS233kzqtSk/Y8Bwysjg/MD+B/vyg2Pkgj?=
 =?us-ascii?Q?zH0tdRTbVqSMdW/nCxMIaqRwj7P6lBw5XCPnwBKtuk+LSLYQHRcPDYlb6HkF?=
 =?us-ascii?Q?RQsZRiLG71IbBjTkOhar00hW5C+aydDO2qNkW7m+AXnNCc5UR4kv2LKSs8Hm?=
 =?us-ascii?Q?bCn/WjWJaTFLw927KG/fSL58KWyl7NHHs41zyG4+8pikvrst68TffH6gs5oj?=
 =?us-ascii?Q?M72BFpnLvFpw9J7EKu+UX8Ahcw3tm1LSjJjft3pZRnmqTUt+hxN7RG/jgRLI?=
 =?us-ascii?Q?AWlW7vg9eBPXKhPMpHQti7EOYcSf+J9AGpaV1kwA0lqhq3UwdkWK57tiZP2G?=
 =?us-ascii?Q?0zL2NZbLrVwtAg/oMA5v1sn7U4O1jVOLa58iYqijOxYT5hOVRSSejYkwqW4g?=
 =?us-ascii?Q?i4Nsu9GKa9NkmtCvwsG74AefTD1koYyxci6n74a2F274cZtE1vi927U3z62f?=
 =?us-ascii?Q?n2+bvgU3srcp7KTIDaosiNQ03A6N5dHez/KnotbMUfLRySiYPQr1JzF5lK0F?=
 =?us-ascii?Q?A9sZEd41+mX+oz8U34eURjQtYVRwvKLrBLXWnnhVv4zrmYP81KjG+fbSquB3?=
 =?us-ascii?Q?bJLmYBQLch78hFPxr5VWZvSzGaWOjH3vuPNxTayQsS/P1Yfr4G8wgHzYPzE+?=
 =?us-ascii?Q?SOimGipbHZN95P716HVei+/ihH619i3LydZiiNNSWQAyD+d9WlBqIpB1zSQf?=
 =?us-ascii?Q?xWclvjiE1EL+4pNsPSbdXtVb0SAZ9a5D/0aTS4/uuFEd2EVUj9EbuMQVzhm0?=
 =?us-ascii?Q?tyg2o5bIMiNxqHSFEO9CfFnAEtFwWWwCS+3U7aLexnl01aP3HWcC/W+reUfL?=
 =?us-ascii?Q?vjYxz/lGCnGp5W4S9dRCX2GBC/WHcUKyuQ9FwvU5GPkhEnNQK07HP1+vVw2x?=
 =?us-ascii?Q?AlBUoLk03Y+rtPs20gFCHwts5niqtQoNFMAHGqNX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Njuw6RKA0XXg0oe9AHE/TYIPNDNea+Roknr83M3cbJ18NI7mMNkIyvuTKXOzMa45fqKNusVMCB/hfw515UK06/cnXg+n0iAbb5EGJcXOS+uuuAGHInQtKMNYNiXojrb4SRZoGoGtaYq24nUsz2p1yvgyLxx5puxPFN+5EJz5GJBJBdwztwifkuPcTlXtWkQZ83okdIre0iZJ+5iu3y+Gbmoa7fd15Mlaei6yZtjb6//+xjlg4o5z4LfW/tVVcjcd5BJZ4q9lVshIx9cjnKp6Av0iyv0icTRnk9bNdXcrkgTP+H0gFTGOf4J7SkwbIAQwYLGddGGFoGQwP3JQ/GBwvFAnQwOvxKh7wS57E1Av5yAne7vvoeGktFIOFaUteYQay2X3YwZrOkEbKAJ2M9xRAR1o99JQus3qDJJw4SCOzfU3UTjWDBeogr7CsJvSV38MnwWwwxYXS4rxjhmtoO/15jUQUcP9Xsx2KxtBsM4hFRzDdYpqMqwbgfU9PcQtgljCOqcvMkwO7o+rXRvsyRiqiPrlNe/Ulm5BF7krtMzuGrpH1Hx3AB7mzb23hW+Rk4h8uvW7vdEtUrbe+HYbNpYI6KNZ6ef7DUjzun9N6ue4zdA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b78d795-a3b2-4808-61ea-08dd54ccec0f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:15:26.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKxUISbHMX7K0SVZSEYugfjcZob5OfqDrpNekGi2sMrbWLlhvarqHXkTRM+ibnpjznK//hf43/buh7WekKV/Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240089
X-Proofpoint-GUID: ghLobH7YfA2LekUdbOjd7MK_l2-WUHqW
X-Proofpoint-ORIG-GUID: ghLobH7YfA2LekUdbOjd7MK_l2-WUHqW

Added filter helper to filter sysfs write errors, retain only the
error part.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/filter | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/filter b/common/filter
index 7e02ded377cc..44ba2b38c21d 100644
--- a/common/filter
+++ b/common/filter
@@ -671,5 +671,14 @@ _filter_flakey_EIO()
 	sed -e "s#.*: Input\/output error#$message#"
 }
 
+# Filters
+#      +./common/rc: line 5085: echo: write error: Invalid argument
+# to
+# 	Invalid argument
+_filter_sysfs_error()
+{
+	sed 's/.*: \(.*\)$/\1/'
+}
+
 # make sure this script returns success
 /bin/true
-- 
2.43.5


