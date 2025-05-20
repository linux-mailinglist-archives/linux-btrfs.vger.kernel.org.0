Return-Path: <linux-btrfs+bounces-14130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A24ABD1EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 10:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56437A278A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 08:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D30F264608;
	Tue, 20 May 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LW4ykGR6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wk6icOgl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26871BD01D;
	Tue, 20 May 2025 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729738; cv=fail; b=AipOH1RvtgvpvrbM4QDPiMsWj29dS/R1CvSZeBQdX7+9wbdZQ3kUl8gK6LM0lSiyMChAnpgjlLgx1f/iK7CNtzyZpwMhMbZEYbO5NWAIS/d+2UH0/LUlfeE7OCxxNddpmIyCTr1JwFzoUC7lvbh5uKdqFR5ipNTopfXB2vRIEGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729738; c=relaxed/simple;
	bh=/jxX95mjWcsGWlDYZWGIcZU3eT5+jHAFeCIdsYZhJnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oIYVtPswvXAm/P3rLsl2L9oYD6iTmyRsEU5b6qdSRfuO8LsT6eoN3EdvsSA8qdcuXF9/4VxaVyh5Tj+JtYBh8X24gvW22Ncfcl5pfuM8aHZjmS2iyb3YNXkILfX+V8QN1Z2f0KgB/J30+8tMahbxWBdsWZCDy5IymU8P9EEIlkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LW4ykGR6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wk6icOgl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7FjSV004343;
	Tue, 20 May 2025 08:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=B38sUEPKrxuutdHPEYqYiwNpS/gtzoTUy91hjY9Ymoo=; b=
	LW4ykGR6mhFO5Luvqb0oc67p+h49jnN0gbUW3zbF5OSJeNobosR+sbCcDtcm7rEh
	r83fKLXZYu9b1vmtv3iainPfRGjvKfKCyhY7knCOLlu9IOSIEhBy4SfSKoehykwl
	dz3wCYA5zu9srGjW0Ogm1GmWJE373k9kwd3L/2N22cEoVy0Qik0X5KVizhPy+bdX
	zsrvZSB0rFiXeA+inSfujdEGDFf0NL99geH3q5CfYK6H06XSfGSzZcbGxgfwP6DV
	Y6q1HyizWRF3gFfVglvyxJyjeglKeeGdolPak+V2wqRLNq86bS9xfZY70AN0laMU
	oZty/ns8ZAsV+ktPRHgyLA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pk0vvu1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 08:28:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7g34S037170;
	Tue, 20 May 2025 08:28:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw8f53k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 08:28:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHJ/TA8zBH/ET++uzJr544c+bXnnn8Sh8PMSWQ23Bq2zhIK+cKilE9zUkLjd9e3TeIFNVATuKIFchF6ujEfh6KSlL0YG9M3LOOMASEajB607zuOmG0TGFruYvTlXguCR0XvQkkppGRaUn61OxyfLrTKAnKb21m4olZewPAO/TNYqmuPQMEruI5iou07yMtFvXmhd8nbIo8UFlzLy3gPv4QeJZgyaakMLWUSuPVESpz0xpf8JKYNZ0KZR/OHHjkL9/hPeSpCtlLy5P6zo47I2nIyL+2Ke7IOe37MeT9kP8snyh3gr6okX+yke33ddyVVomZtOFxUTdeV9/D/n+1GUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B38sUEPKrxuutdHPEYqYiwNpS/gtzoTUy91hjY9Ymoo=;
 b=b6g5lFXb6203HOkBXlho4O7iQLb9WxbuOVAdg2NcOO8RavHLLLH9D27Dg/92tDpyyWwQzLI7hbitM7sOwViUdPnkUAoCQdd1UQ9FnZ7cz7tI4qde9wuSXLnqd2/nMLHDAWVXilVY85TwTzljVlY3OZu/uQd4/6iOIfrFiXl1zpFhSz2z5J4bEwMCm+5C2iS9ZrfF74ew5KVCmYc1tHJnKeqom14jqp6LPy2bb+dwFSn7n1Lc4HKBpb9/Ts8h9DXOiv/5rgNfdqWqlsuA2HucGXgKjN4TWq9HVOUQ5Seoa+B4F8e5ipZK70g+gCGK+JZqEZUdgF9uJrtffJvesgxM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B38sUEPKrxuutdHPEYqYiwNpS/gtzoTUy91hjY9Ymoo=;
 b=Wk6icOglYeKyKRIv0rGVpBEK3bKKODi6ORB8vEQjIJ6v8jK5OHeSUkOZxFjrNjKWRHU0EDsxUGalMsMHqDoA4jiAcmBRYlexm2MBoEyQ1MrfDfUlVi377rmZ/IvvNCe6EQv82xbEp7HhwEGvuv9nlLdsihcSBaEbJE1Ap34phwo=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by PH8PR10MB6600.namprd10.prod.outlook.com (2603:10b6:510:223::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 08:28:52 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 08:28:52 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] fstests: new test case to verify show_devname() device path
Date: Tue, 20 May 2025 16:28:34 +0800
Message-ID: <36bb865cebab9111b7a00e417d5c639131748fa7.1747729098.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747729098.git.anand.jain@oracle.com>
References: <cover.1747729098.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|PH8PR10MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: 585e21e6-bbe2-4b64-f5f1-08dd977859f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JtWazk+Ox6mpfOSShRwwIu6xWRGNKXCoUNOvjSFbyMLm49jkNO6xiXX6YFjQ?=
 =?us-ascii?Q?lcFHHQk+864VFjN6VcPQzpF/PSozzWIsJNfoHPRpwB/Dt9ztO6DrTvozz8xX?=
 =?us-ascii?Q?BUNBRJX3ZmvNotWv1O4toVHc6jsKVcmcqud+5o2s2SGLg7dA428G5AXE35Tu?=
 =?us-ascii?Q?PJdsOUsQkgx97T33+2aKk3KAaNlEuTYP1xD5DIAQcf5XjHEZt53fNEwst+Ki?=
 =?us-ascii?Q?Tmp3yktw14JT7UlMC+gOr5ehrzjAxDWZhiwzeWfS2oBCLRYaWlhQdGDHnPXB?=
 =?us-ascii?Q?1jD7PX/mCL2ibmq3Q6UGS3iJtTMJyBqkExvPdcmg71Id1DGbhgbwjn4ow36X?=
 =?us-ascii?Q?1dTnfa26RKPuZrstQgNhQ7yB9pEJM8WBoKtPHSr4GMxDle3ANB45a8jckQpy?=
 =?us-ascii?Q?rLLrBhESQazLkFY+hC5g/fz5+1xqBA5DKjKv1AvYs2joN5uBzvEQazqfyZ9R?=
 =?us-ascii?Q?/KQq/Ahu29PGUe2VeyNPH6bmuZRvmpGPWbR2YzX0LgvizsUzTuCE1DSSA1Db?=
 =?us-ascii?Q?20ZKvG+WVJ4d1XlIRPN7J8crSZacWMKamyYHJvzt8/2bBVwe+PX5797FlA6s?=
 =?us-ascii?Q?dVnBQOxZ6+sxUQ9OvvRTqQQPIhOKqBwZwlDDQCmUwcfmW811A3dn0l87ejGF?=
 =?us-ascii?Q?4oRQcKoMRDtN4n+m8G1aTz25nsR5kSFKwlMum/VK7HAymx+050Ya8gv6C0RK?=
 =?us-ascii?Q?/72YSJfhiqqYfaGdeFnf/OHeasXYdwr/ShlclhFFXnWlH/jVCfDOPW/RDbYe?=
 =?us-ascii?Q?kc4oXKIdhK7ykVFJSWvX0nQXPW/i31LwYpaBQFf8esu7peMEVq20XKFVVXhw?=
 =?us-ascii?Q?a1ra1RZDrQHGwEAuzpbSN3NS965Puhp4ZL/nZ8BaQu1fTU9bsy+6NheYTesF?=
 =?us-ascii?Q?Q3mVPrjolXKN5B5nyHDJdE6FTJAAl0K2wNRN56P4g3iGmCvoqHy0ga+dfAC2?=
 =?us-ascii?Q?HapfIZKkCoJU5oi3urAhRWGKcikH/z/GlULwFEa4Lk2K3MfOfLneq2TOuDua?=
 =?us-ascii?Q?9ukExRrv/44eJz6tlyjihVUdgfWLI576BUTq4K/hvT0bi7pOokU7tx+EJJBy?=
 =?us-ascii?Q?t3++7s5v9kMccKjKI9R39NgmXGp7FfPwsGbJ2Hf96WO9y5elYc5VgedtLCZn?=
 =?us-ascii?Q?6FBgq/0d4ODAAD98m0dzEx7tOyNt2tgHNm/GXH/7rrjut+cuXDxVwUazQv3R?=
 =?us-ascii?Q?XfZrTH9kqig3EqO6U3skVZt8wDePUQOWXrStdVLqowPquNC8+DSqSh4IqTs2?=
 =?us-ascii?Q?hxjqsVutdaC3AlpFEeGyp7wkNcok9J5HQQDrC4OeZrUmXvzDnLW7fRsUWnQz?=
 =?us-ascii?Q?knERqcQuBWwXf/Xmur1Chifyr3LkKoaejYkkRsKKKj4/3g3RWlDz1VjuXiim?=
 =?us-ascii?Q?8VgHQnz8U4ixpBHYNVmWoqarxhFmKJKVeuc2HFLnZc03o7vnz9blqAA7VOcR?=
 =?us-ascii?Q?haZrVw0avL8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LfnssUtqoisSB5Pcq9keT2TVuwlI9O093fxnFPIMMweS2PMW76WVMjXbEbKw?=
 =?us-ascii?Q?yJwikQLPiaveonJhFvoLj5KvUcaTwzQqEgq6m+UkYI617EX4CuGKUB0W2fWl?=
 =?us-ascii?Q?Qe9JoM4Cqs8H9uYLNwr5RMcUI2ajTuDcCFx9/agQJoEwVTf7PvtmL5AZiyzv?=
 =?us-ascii?Q?ZOpf8JUBc0LaaL2WQsx0hZGwxpmGXMC24cjAb40unWgQE/hsfSvjmSS8cURY?=
 =?us-ascii?Q?/B3J/p476iHQ/IkG5AGdDlc+6n7bbRPkJQhPt88R5OymL/XwRx/+VHSV58DY?=
 =?us-ascii?Q?Iswg2KQDVzRq7YS46w4jI2bNYuoBRN9S5NRoQx+8S3AlxGfKphW6//QmSRIY?=
 =?us-ascii?Q?SdANmApMJzszaIH1DIKZLWUO8AzMX9MMcj3Z0fyEYkdyU6f0X2W3zcVPmu8G?=
 =?us-ascii?Q?dFwBpJj1UFzdmGX/0dNMnanHD8e60j74UgTPYlBoA6U5Yv8cAN5veBW9Wtrq?=
 =?us-ascii?Q?y9GTHPMQrGFGTHHTT2PZJvDj7f3Cec+CbEPvWrfO27DPQPHd2LfhGtXztxhK?=
 =?us-ascii?Q?9+NOfLrgww6ymifSIy4hDYpBt5HfD+GKun662xViASWRgaiEfQWi4XUTrSGk?=
 =?us-ascii?Q?dLFr8jAufF4Hlce0pOdI9NIkBQfID0udzz/uj8f7LOe3EXWPNybn3i3ZwBYa?=
 =?us-ascii?Q?psR5LiHh8iqwDpt5OTt86gT8iY5DySkPzFgOzAwFUfzX6n+gRaJYYaRqG60x?=
 =?us-ascii?Q?iyzPydMuMsdYv5+o6won99F5KSsKTu87zTLjayZhqhquxuQ5bJo3V3MPPR/p?=
 =?us-ascii?Q?gjMX9O6mI1CZeVh/GJGZAlWHwzCuoLyb6uyaP4sfZ7uqpG4UW9bO6+0kDMNo?=
 =?us-ascii?Q?rcu5aHRxv+FDLN1Xnmz5uZgke8Epx64cNY3tMw8/3tndDSlHOGvBhiRMQOL1?=
 =?us-ascii?Q?UCeU4EBRPWvoeq3wIju1cPEBD4/RsrfaM0jjQYBUzCba9gHrEGc72svtMKXN?=
 =?us-ascii?Q?8TokECJQOebpBSWdpMKZ5JAXIzeNfUmbIKtOb+guT5vFD2vqWAy5Xni+c2Zh?=
 =?us-ascii?Q?FDRrBEnbvGWkzb01DINyRvmXgYXltnou7QiA63LyWdLv1CvfyIImf99DWCRh?=
 =?us-ascii?Q?j4bTMfyaCtkWN38dllvuTaUvQv4rKbJNd1tG6DL0syEqLf5566bK/5GVyybr?=
 =?us-ascii?Q?GqL+5P13qmIISjfzZSlsvFdqGgJywmj5eRxVYXOaNokO00VV9oLtjLVgwN6M?=
 =?us-ascii?Q?RE7DpvnCQqn6xNjRkY4acWe4CcpnE63I+8QN0VlF9tNu7v3IVe3cpGGRmEK/?=
 =?us-ascii?Q?6zKp/eoP2dh6ceBK5EdSSSkZ2XP7Gv87pA3VtA9iWK+k+yBAuKmJN5RyJ/0Y?=
 =?us-ascii?Q?+t6x46mSrqvZHGMPTprcVtkJ5ISvxgyirte2cBIQRYxksMtB6nN/ZZw3Md9r?=
 =?us-ascii?Q?l5mn6FPqXmIJML+726kGg+IRlGzb8K2caWrv3w9ntTNePO+tE8SUkhhgB8RU?=
 =?us-ascii?Q?bkRaw8kH9Ud3vWchSkfvDhsnhsScJlbKY2vo+JYmIuPEI9vU//EFl+Nmdxju?=
 =?us-ascii?Q?VJQLnsW7PFvxdX7dpdtw9l5CQB8pqg+j4XOUUB4FsEZ9aKThVWWDXILYHqg8?=
 =?us-ascii?Q?S7EVJdx94t/wlkgM+LNwau2p2h31riHJAUa0S+Yw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+hXpYsVnsqxLBVXNMRRDNhYuXxcI/wLTYpj9aj8f7Lr+6TBd2X8eMEgSadba5GpNk4hcqrNumFuTk4yVh2cq5aN3RjybypkgG+BSo5RkG2fIW9ANaWM6xJypmRGX7j3iYylR77qjPs3YOwgO96YsQ8AZsJgqlTaDUwujf3Cdv2SqNzi1UduwLcfN4i+LOL6T/e+j6uQUqZbXYePhXOs+t1i2kORiILjN7+7xDJC9PnXphFUVmTPbWEYWE139UKsLIhnTtgwkAOKxNoChu4fPw2N3EDePUlc3ii7O3QY0Z1ExyEtBxXLNXC21UiewUa8XWfnVhVbPUcX7fh7Hq5qGXgMTmCGSOixRLHd8ZcUPBg14sCiK4xCpzpw76zeOMv1SjvAvRbzXEuIfcwr/WYBDErVp7MLcG2UpzKdQlHslko5r7uHJ1S8hZ0t4jUeRu9cJiDWsftsK+ZzNiLz2NcXt1NQmzxPCyv8lFMGXQSMtLqFUS3jxIMzRrBE/3NhbY29CdTqCsVHKbAGJGwYo9eAAa7RLjGBQEHetRO8Q8GlZsaQvoX3pXNZccYfL/jQ5Pkn2/R3uvOfCx6e2ZYPjlgsiqSDf4nZQ++5naiiOSlKdr1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585e21e6-bbe2-4b64-f5f1-08dd977859f7
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 08:28:51.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEorknY0Ns4Nq7AsmoWQBgxwlIzzzQbwTZ5azi59zdrXMiE6HwS5HqIOyuJrZ0uZnGkxLYSVSPosg9ZcZKBaag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200069
X-Proofpoint-ORIG-GUID: WEbY-UN4WPWwfw0CcXxdBwyJxigaQW9z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA2OSBTYWx0ZWRfXyc1q0gVJtNPF jlunrKByjHuwSedaqXVqpxKQIryAT8fpgIDPyJqW+M0Pe4GkNNFY7XTtojB1Xk84bxjKRFU3brH tnxVpkdTh1bOq57pgR9jbqnP9ltAjSd70fb97eWtrrHxBqL667VhwVs56f7O8O4XglPfSy7bYEO
 ypXolHKUR42TH+gFCjIy98/jVVzgeSlPMScC9cddteHdFrI0z8dnPK119fwIoM5t1eWlfZ15KyW tlo+FMV3Ax0sm8eo6LQ9q/Tzb4ouB7OJvGU0ej0PYrba8yOKpMX5poGDBRqKzMutvJPjq2A4FNJ BnW6wDOZa+yKPkXko9Ki669Vf8ZYc9DlnBclYPNgFUeByTwvg29Yd9XUfkfZjg9UdrdmrzPffZh
 xiXeyUE43NCoaLhDahuXtOEGMExbVBa8HmLNjimy4Ek5j2GNLVFIit7sUIXUVPZ5FnWxMKrf
X-Authority-Analysis: v=2.4 cv=CMIqXQrD c=1 sm=1 tr=0 ts=682c3d47 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GQ2IgG55v5Hnj68Nk1cA:9 a=ESlSQR0dfRFtFI7x:21 cc=ntf awl=host:13186
X-Proofpoint-GUID: WEbY-UN4WPWwfw0CcXxdBwyJxigaQW9z

If the device path under /proc/self/mounts does not match the path shown
by findmnt --uuid, commands like mount -a may fail to recognize that the
device is already mounted and attempt to mount it again. This test case
verifies that the two paths match.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/generic/765     | 74 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/765.out |  6 ++++
 2 files changed, 80 insertions(+)
 create mode 100755 tests/generic/765
 create mode 100644 tests/generic/765.out

diff --git a/tests/generic/765 b/tests/generic/765
new file mode 100755
index 000000000000..9d4b69344678
--- /dev/null
+++ b/tests/generic/765
@@ -0,0 +1,74 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# FS QA Test 765
+#
+# Test if the device paths are compatible with systemd udev tools like
+# mount -a and findmnt.
+# Provide the device dm path to the mount command and verify that it is
+# correctly resolved to the mapper path in the kernel.
+#
+. ./common/preamble
+_begin_fstest auto
+
+node="fstests_${seq}"
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+
+	sed -i "\|[[:space:]]$SCRATCH_MNT[[:space:]]|d" /etc/fstab
+	_systemd_installed && _systemd_reload
+
+	_unmount $SCRATCH_MNT > /dev/null 2>&1
+	udevadm control --start-exec-queue
+	_dmsetup_remove $node
+}
+
+. ./common/systemd
+. ./common/filter
+
+_require_scratch
+_require_block_device $SCRATCH_DEV
+_require_dm_target linear
+
+[ "$FSTYP" = btrfs ] && _fixed_by_kernel_commit XXXXXXXXXXXX \
+		"btrfs: pass device path update from mount thread"
+
+filter_mapper()
+{
+	sed -e "s,\B$scratch_mapper_dev,MAPPER_PATH,g" |\
+		sed -e "s,/dev/dm-[^ ]*,DM_PATH,g" |\
+		_filter_scratch
+}
+
+#size doesn't matter just create it to the device size
+sectors=$(blockdev --getsz $SCRATCH_DEV)
+table="0 $sectors linear  $SCRATCH_DEV 0"
+_dmsetup_create $node --table "$table" || _fail "setup dm device failed"
+
+scratch_mapper_dev=/dev/mapper/$node
+scratch_dm_dev=$(realpath ${scratch_mapper_dev})
+
+# Block external triggers that alter the device path inside the kernel,
+# they are unreliable.
+udevadm control --stop-exec-queue
+_mkfs_dev $scratch_dm_dev
+
+# mount resolves dm path to its mapper path
+_mount --verbose $scratch_dm_dev $SCRATCH_MNT | filter_mapper
+
+fsid=$(findmnt -n -o UUID ${scratch_dm_dev})
+blkid --uuid ${fsid} | filter_mapper
+findmnt --source UUID=${fsid} --noheadings --output SOURCE | filter_mapper
+cat /proc/self/mounts | grep ${SCRATCH_MNT} | \
+				$AWK_PROG '{print $1" "$2}' | filter_mapper
+
+echo "UUID=${fsid} ${SCRATCH_MNT} $FSTYP defaults 0 0" >> /etc/fstab
+_systemd_installed && _systemd_reload
+_mount --verbose -a | grep $SCRATCH_MNT | filter_mapper
+
+status=0
+exit
diff --git a/tests/generic/765.out b/tests/generic/765.out
new file mode 100644
index 000000000000..62abea736f4d
--- /dev/null
+++ b/tests/generic/765.out
@@ -0,0 +1,6 @@
+QA output created by 765
+mount: MAPPER_PATH mounted on SCRATCH_MNT.
+MAPPER_PATH
+MAPPER_PATH
+MAPPER_PATH SCRATCH_MNT
+SCRATCH_MNT             : already mounted
-- 
2.49.0


