Return-Path: <linux-btrfs+bounces-11146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DD0A22014
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 16:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E9A3A69D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B732B1DDC34;
	Wed, 29 Jan 2025 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fcsrddzo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F4vqnvAS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD715B102;
	Wed, 29 Jan 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164027; cv=fail; b=JvlaVnoXaJ34dA0Cp1EUTZA4c3nTTlmjN0ulKR/4GRwDgmRBjjUAOUJmvYwZ51j4MTSJsKwsdjKwRP1f7xSryuwyMqjKSOOZTr3WR2Pt5ePNg1rNfVwAUGCSTIS2YCqNEmOOhrWpqYiWAa+1l8p9pyVoFehaFI0IO3nEy4q/fGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164027; c=relaxed/simple;
	bh=sgJiu9ugshyaxE1tYy/oMpUqOdkIVhfWQ8Mxt2dWwYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FbNQue+elX8aFEE/cS3TyfaZHkqQ+P45CYOFDg6Zk9T5o2BSQbulwE3RK84tZeyzkD4VScf2+F0kRVt+dh9wQtsHKgT3mVPHXoYRLZ8WBK1xnkWiOavLY+LZMDWHqURETkqgbYRWqpHJF6wcVKB0oZfbkBgMsxksI/BbGuH4wh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fcsrddzo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F4vqnvAS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFHRnM000945;
	Wed, 29 Jan 2025 15:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=foZg87m0YStHqg0or9PvBHL8O8Bzf9n5ZOJOCwSX3vo=; b=
	Fcsrddzo1RAUjp6UEgmEYa0e8zcgP9PpKtuqQWWUF3s1SReqmB9X9TS/+I7oV/Dy
	Pmwl1bZE6FDyZgp5pshZHXEBfmlWvOAAgMXNBLo/SJkqhKqq+UBJJNq80P8QUIUc
	22+Rr3/1Eb1zYrmFHZ3yqbgUT35T/UwXnqhvOfxmbl0DhQRNFJhy/rIno6zzqDFN
	yedKG73DKDHjmcXBp4FrPBhyd+/KCwAWu0gLVPB/fkcDS6K6bBIF+Ux7q59pRMCt
	GZHUb/YxEpIpqhPugLkiYbefaCExaqV/vHuZMMSfmrGrKhb3UlhgPv/kyBg9GaFD
	qiL7BCb6K68F2fCzG8x2WA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fn2ug8qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:20:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TETeuU036366;
	Wed, 29 Jan 2025 15:20:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd9tpks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:20:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biRVnOOTa811d6jCpilBjffkNgmTMf0M+NQIYwdqTZEafeAI4RfO8KFz8jw9thXS5wuJZG3pcvfxRP1fk8qJYyuVDY9VeMt1puSJ2PIE8mUFJVOS7nEQshT9Tr6kGTawxveccHezYHTs0Ylgtbw/AyXB3CRMHb/91dGLXici2UE5oMlp44ZeFGqnpLOmRsoI8ZP+etRSm2q2vmiEmwUxQWEUF63/UnbZw+C3l0VwB0IB3jNlTTfgoD5KQjUdOhtUnzPZaD3I+XmHImzfDgj5y2PzVUc5yjmJjQnXT6kNQoJdkIqC1JKzlYD+14lcV0Z0zYGhSanhlTH+mE0zzhn+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foZg87m0YStHqg0or9PvBHL8O8Bzf9n5ZOJOCwSX3vo=;
 b=axlj8qiJcldzwUEIMNTfXhAPnJ+25WDx/5kvaaPzc7yvGBLI3ZdtwAmKVDQ1ZGNYOLbxJg203UlWeYwOnm6XkxVERxG2aXXZa7sj+x3Uabjb4V0/gJ8UfzZWh5k79djTjzKsCzuuI5DPXjytBWUDahohbcAFF0gr+y+nh8ZCN2Pq2rTAAAKI8AuJy9ZCt4EGKmWT0CV9y20o4alxSaGAuZz30aNr5gumYVpEdSFh4W+StUofkvQAKMgPIZy8uO91d1JNYd47EFPysipn1X1lYf4Sp5k3vPEcQEiJJZLVUmWDRa6aoVAm6Gy0itCY4sd8WyrDAJxifTetAKxqIh+FMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foZg87m0YStHqg0or9PvBHL8O8Bzf9n5ZOJOCwSX3vo=;
 b=F4vqnvAS0/fO+ocgj+Fj0KB9dbb7YhLylaktGLDLrqw7Yazl/Dwl9+u0HGLBIhyDiHTaBgffP3NWuAn+E9iDrSEug5r7E21DLFB3dY/xUKwOxgkLku3Oswwxci3sCXm3moGfLtAS852QAnxhJvUwxDKsvsgZXlT64em3toOoGyw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4959.namprd10.prod.outlook.com (2603:10b6:5:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Wed, 29 Jan
 2025 15:20:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 15:20:19 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
Date: Wed, 29 Jan 2025 23:19:52 +0800
Message-ID: <1eb59407c06a9c6a51a854bbce458208e3e53fea.1738161075.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1738161075.git.anand.jain@oracle.com>
References: <cover.1738161075.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f1a11b-fce6-4382-8316-08dd40787134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ewyhgidAf2DP7Z4lLvSXauKFqyw4xHfGLmdmWDzXawFzFFCJa4qyPPXMS7xN?=
 =?us-ascii?Q?S9vVcZ1OR36doKXBC9m14EPKb+h6/AHE4M2d7qAxCT694d/87liEkuay663a?=
 =?us-ascii?Q?JFmMQFYLyad5vFNv5g7rkeS/0NDCc4pm07yHX/qBDs11CsfLGu/S2BAo56el?=
 =?us-ascii?Q?0dkX3LsVLKsP6dBgSiyNcMf0oDpiNiRms66DULICxZVhbFRLS8UeX4rlUQ2W?=
 =?us-ascii?Q?sjkTDAHkFqQYnsoauGxVPHbGmbSL4X6D/61+YLIw6AKGGg3/WUb87yPzJrXK?=
 =?us-ascii?Q?xk47FxtOXDBOzUiiWyMYagrH8rEUdPkJ5Dkzvnc752VqiOEjhNTBsjdjpTS6?=
 =?us-ascii?Q?hZPip7OdBvehy34EkaEKo1LagAdr1F9R4huEUN+AVKOBAR+nKNE/lcEQygKM?=
 =?us-ascii?Q?PHw5estVhlnNeNHxy0AsalQ8WsJr3s1pg9FKFb8P1u471J14JbMw+bgDpAc0?=
 =?us-ascii?Q?M4TBzUvcWnEJ80XjXc4Ypy6r0M26eDJOd5pm5dzARnSiqO3eU6I69lW1tBQ5?=
 =?us-ascii?Q?vJSOEzoB5cUEcpnuA+OyEHL+6VbzNZowwFvRNZaVmUgVVZDLXuMPn1oCp+vc?=
 =?us-ascii?Q?502bfQm3ldm1xgT0kpJSN/u67vhiPbOgl2XkeuNnnO2TQI0MYB8YbmIuGRwm?=
 =?us-ascii?Q?BwVo7SLu/sVaC3dRbMD0ATrSk3LbyXRwhDB50LIg3VNlm2M7R3+ZLFWUIypT?=
 =?us-ascii?Q?UmEEZprUiLulxHWxadmEYzKRL382KLYcjrUpd18n/L7l0Myf6rMdCfA4Rglj?=
 =?us-ascii?Q?5IgHFjy3DH2J3FrJP0L5JYj87Qfq7RpOBiInADqBb/bAgH1BYBYLX6oRjnUl?=
 =?us-ascii?Q?cGrr7/l42tADd/aRBg5594DZR/Et/QAbsq6FEJVQNhQ/RUaL/cvOgzd0907w?=
 =?us-ascii?Q?9DtaCYiLt9Mwp/8LR2CJPYMmsCk3J6z+JbwywTodb1o7aE/8e8cXb3JM70X4?=
 =?us-ascii?Q?SwtbZZoUb3/6bkHqwnAuhF3DlI0FB5Q0eYtoZbQi1T9F1o5Jps1LzRTUN8u1?=
 =?us-ascii?Q?VNE1FJF9+Y0N8YLSOijrpQbtkRm7ojT+I/cVLi2dvrKJf2NaZ2QwnMzdRoKd?=
 =?us-ascii?Q?JnTtKkcbOWSWxpBh53Y6jrp+XughSyaTFn5Lgi2TVPtNsz3EeG430PVG9Z1z?=
 =?us-ascii?Q?P6dSo9UXZoWc81eTHTWTcaeYpCZfz+2GumxSzu2cXsWtngZLsvW18WFstjYQ?=
 =?us-ascii?Q?Nj8V9SJB67rmLQehXiUZcGU+HCjYOe3DCjZN+0cpoq/NW8rbc32AcuAtxG+/?=
 =?us-ascii?Q?GWkYIlYn1alhH97+HUfYBOxvvFmGMOfo6gH2FywulNqUMQ0gQUzon97mbmQg?=
 =?us-ascii?Q?AzQCyRmOrZ6+z7tNZKm5NO6XYR04zCnLwrbUaK2ypaXu+WHp4mKGCJ2mYh/U?=
 =?us-ascii?Q?/UTuDx8d1JEPGdST8bgTMRlGUsoe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sNUJ1v7MVwzbN/VBFsosnuAH7YaaVFgX8sW+TOpJ34QMHzaz6TeGR+Ck0jg5?=
 =?us-ascii?Q?2xkPqLujc4hTXEjsWCgkJcKcHGoqJKN4jy6Tyv05h/KTXDTF7tNmS/42bzlX?=
 =?us-ascii?Q?M3AC5Z+3VAxT+3ufpMWurbSfH5bwuMxxBiIvuvxr5y22OxhkeeYwlFXoHCXT?=
 =?us-ascii?Q?PoMvFDRsM0fRpt+sNk+NGrfs+QpZ0BLiBsamrkGLEw9AZ8CIHm/0lTVKc2xd?=
 =?us-ascii?Q?HbjeO78Geygj0a4jn9nRFsPAXHRl6yraYub/FzgE+ZxJ2T2e/tZ44CN/nb/v?=
 =?us-ascii?Q?ALXDa2BrOh8DoIq+kjmuZsDvJq6/g9zT5W0Bg0om3ZqKu0nV+glTlibK74vV?=
 =?us-ascii?Q?AQwrSgVvokZCQPDW9kpHqbmpLNMmS05GFIvj+yHlE/i71Vus6YQUfhvFjLSC?=
 =?us-ascii?Q?5luQ30v0y4JgDQ4jUv3M2XfyMIn3cSrV+f2i9mPeY4FVRjj9DqgTlN2CU4Ie?=
 =?us-ascii?Q?Ptx3yhxx9iwqUY9yL8aejiai9rrFPN1bUJc+db0e4cIR8/W9TzRXeJI94FD8?=
 =?us-ascii?Q?HHqGm5jzXWsjoSEZIV5l4g0yYp3XxaXSEgI7ihG4BFrM08FbG+45HzRZMIXK?=
 =?us-ascii?Q?ZBpQLCPt0pn5HehZYo77UhDhIMUM0sslK1P1GcbgrzQdgOQQKkOd6xejI766?=
 =?us-ascii?Q?HpQWKlrYX9lLIAdD7tMjXnxPayja58Nq2T/6ZhVYPfFVKfMensl6EqUux+Qz?=
 =?us-ascii?Q?mUTi0cqN/M6UyatDVz3PUdAtQs2KpS1/sv24D3NiI1qcsYMli51TDCNFOAr5?=
 =?us-ascii?Q?r2KYcLO9qH5SJOsWv2hSTDaNxcBsBwUpkI7efdTvlfpGCbnQ45wd3XooJEnk?=
 =?us-ascii?Q?3PasaactrXoLUyjK6uphp/wwmux/WmXsOR/5VeLQvEnZPBEBvu5+o2IfekB2?=
 =?us-ascii?Q?Q5Zu10z8NQ9xfPHTDx7rS1EnIwc8wqEy52yenYeqpw/KLPaaygdHtGhGhlnu?=
 =?us-ascii?Q?6wsOsmMjRp/O86LViDtdQ39Gb0cCm0uW9pOopa5a4ycVpN8Ur9sNVE5QhGOn?=
 =?us-ascii?Q?OtqGVc/OccwA2WMB0j2WaCNDmRi+frYWU+r2mLFGjDrJXzgF+BIOMxD3u58q?=
 =?us-ascii?Q?RTLN6PrkLR+FxIc7bz6kxrkXalF+WvdXcyv91LdR8Lign3GVzlS9TFNf+O4B?=
 =?us-ascii?Q?WsGHLeurLRgwPGiDZQ2YH85AXTXdmhPEjoVq+jXnHq8MOE50BdV+qI7X+FYo?=
 =?us-ascii?Q?F9lUpdIRnXX69Cqs37BwfzZL2g0pC/YZ03KlkD7gS8N6pHPjpCJyiuXP8hi4?=
 =?us-ascii?Q?oP/KkvoD8anhyYXO1RW2D8GVUpSJ1L/1JBig3Mh2KbDqb3jce11XqolypogI?=
 =?us-ascii?Q?gQ0030mIrCYKx075cL159v4sBsyuR+o9wUgz/cdqOZ+g3HAfsTjvj93r1qZD?=
 =?us-ascii?Q?QBH81FNiFETS5T2tQuOkQ6X+pl7hmB/sQoFh0vtKIOVLAWNOg4Gykjz+ezq5?=
 =?us-ascii?Q?vB+0tiCMUsEHEwcGViPWLmG0wWzgGLO/r2z+ZG+Ps6TgH72bogC2O4L7GQa6?=
 =?us-ascii?Q?e5tAtlY0QbJ30dk1DsJDSjwJCUmXC/oSk+6unYQNPI6fzdQzI7Lb0GrPNj4G?=
 =?us-ascii?Q?S7kGFfC2AmXhFFrVgSiJBi0lGiCVRaIwkAXR7pRn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FzB+yMcgfNuLL/7fc+bXpAnn9t31FZXGLdjZQI7MglGDvYBh31V8jvd4E3A6vYmEMFeoEGw3fUsR6O5u4aFcNQ1f+VBohnYbPIhrSKlC+NelrCPJQy071gpAcZc4ZxHsvDUT+mtS0CwtmbgKsmbAO3lJjR6jp474FKBRfimEbH8OpXJ7Jux+c2/fOdT00vqEQlAqKFLLZp/xdC7YlO839PUcG81E7o1J7I1y/we5za2DdC+rpe1FQfVv9PBBvwVfsCQ1nwPUcCINLh4AeslCfAgVTFBma+CxZkMX3odFdCpFsKy8uGSJqiz3CXxnL5MWLQ9K6cG6rPdzGJzqBkeeUrOvAHpXMb3ThPnVBZRNHEzj7rgN6MlEzgXJoXkW04zJDVReHuGNeNUoaZU1fZSUixibtFUTpvr2wR0R0UBCLXATHMICbGJOHIDc6gxpNa45qr63quR0pe3QocACC0yDUybdk4ZhbrAgfZfdy6W9V1oI+Dem1RatB3JGwKVDh7HIGY8EFU+Tc2pJSqfYSrFDwbVIw2m9xNe+R9NyHCAAMu1TwTFbKC7tUly5ARGg1434mUTBiSuV3P0VK4AKy2ru2jcEr7MEOm7RfJ/qHpKLIZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f1a11b-fce6-4382-8316-08dd40787134
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:20:19.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KX8LAHR6Ksl8vet+sb0j0PvNywnMhFw6OUmu7i/agvZ2CS4KVk1JTGzegItJEobus3xFIaeXgdo7IO/kLtIQKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290123
X-Proofpoint-ORIG-GUID: aJlmuW-vmQ6TbSjF152CkaC9U5f3U1Q-
X-Proofpoint-GUID: aJlmuW-vmQ6TbSjF152CkaC9U5f3U1Q-

Redirect sysfs write errors to stdout as a preparatory patch to enable
testing of expected sysfs write failures. Also, log the executed
sysfs write command and its failure if any to seqres.full for better
debugging and traceability.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index a3ee09d54cf0..2c4621bad5d0 100644
--- a/common/rc
+++ b/common/rc
@@ -5082,7 +5082,8 @@ _set_fs_sysfs_attr()
 
 	local dname=$(_fs_sysfs_dname $dev)
 
-	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
+	echo "echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full
+	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full
 }
 
 # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
-- 
2.47.0


