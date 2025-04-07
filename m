Return-Path: <linux-btrfs+bounces-12828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D692BA7D2AB
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 05:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D54B171B88
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 03:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A766221DA6;
	Mon,  7 Apr 2025 03:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G35aG/x8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NjYjYUfn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34914AA9;
	Mon,  7 Apr 2025 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743997795; cv=fail; b=qrUJgAhcBvdI28zH/6lUxrJMqkMq3Vzg71Gz+0KItyINYDujaszGRqgotSk8zf4HhvcZQFw15s3CR6lkLuZ36gMqnRAlP6y7ueWiqisd36OzmNwJge+UBd3wnUic4cjm7x+7XubgCzgxOaCpmaGncpDSqG5nPjrwC5uWh+8uric=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743997795; c=relaxed/simple;
	bh=PLgvjNWoG8jzYe/Tf8Kfq2nkH0+2IEZ1Sy5LONgtGLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fPCydEhV4oYKJa+HzZtb0ZvWAbcU9OORtRQbTRiGnVPQUA8nc+TbWhaRqI7tH97u5znNlMD4q/8PdJCzay+kXc4G/IaU/NSaDgQg0BVLFUOqVq9lWk6yB/5iwWobyJAF0dL8o3UH7ne4d0VdEftWXO/i6QdUhn0r7VzOkmPkwsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G35aG/x8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NjYjYUfn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5371C5hC009611;
	Mon, 7 Apr 2025 03:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=b/XVTyA42vKsrr+fJ993WDWSgBxlak83ENXyRJHrD5c=; b=
	G35aG/x8CnqkVvPXJWjHWyW/8BN1xE+H43o7LYYenc/7fwRdXt5UNW9GfMfKQ4iK
	Mprnd4p6FC2vFc7kv/nKZNRzLot5PBynwpnQ6vQlIO+OtSHoyb3xTWBtsi6mnJ7c
	RpJ8O5oPOLSAcW4ACRDuQAs0ZrZK8F8Y/1N2jM21mKpCDGKiLo2+LTMnDClJWh5F
	LoZl//5gg68iYEmnAL5NsYJm11IHfH7kYLgmJqqfMrJy5D2LRhy++ePYvH0nea9w
	zaotW+P+SkilJhblbo+ttHoVfr7AFoRBXn9dkcwBbnq7o6WBC+plCH66o0X9miFw
	5/gOfbWOc0/0lxWwCclCQA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45ttxcsq7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53721eAH023792;
	Mon, 7 Apr 2025 03:49:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydevs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSxtj3NjC4WLtpVXi326a0lFIPHuk1khT11WmjoIN/y2BTV3mAncU0OmSPou5j8pj/8+mG3+SidYodt21YXuY3ZMV9VQP3Pm0XMDnCivqVVRnofRCaFjpbEK9BVwj8nEDM7a7A3dvy9TSmVPqSqVJPBQplIMoHhOvW/btUMCE0+2H9vZ/bGGNC3PtcxQRooi2qSWI+xb0rzTr9qnQiBd0ZYvAw4/pg7kMcIPY9GTVTUAHmuag3BN4HW49vcxanNsUvcjU0YNf5OvOwfui9jUNz0XSOWg1NnGYaxEa2lt9LlMVRzJQie5wvdkeqTbHRCOa+Ljo/yvKBvFeNqETMsbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/XVTyA42vKsrr+fJ993WDWSgBxlak83ENXyRJHrD5c=;
 b=EdeaLGg/2YUvBPg8hg/Su79ZkEtyWER6C1ILNciyGKZ3cb5T5wPPL9rOF3VZu76vziVQYDlNzvRlubky/fNF30QP5W2w2TwooUEyHG+S6FvOCTK8B936jeGWrkbo5VKF3XqWj6NyBhpM9/wYMCjXhZaj7xgshm4Nn0dXkATR5p1Xob0sie/BGLSv7rIgla1Tva1DJz/hdDbD9Qy7Z/sauhtunOfLA2OQIIvhM8vO6U0J7pW9mN9DZCR/5vkqOKKq0LIRrzYFpw0Xtp9rsbUSscBtIlSuGQzJ9NgPFs6UTy7m4V2t/GkkFmqmuu/mZdnNcIjuy6MaVreEJkBjEqb7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/XVTyA42vKsrr+fJ993WDWSgBxlak83ENXyRJHrD5c=;
 b=NjYjYUfnstmwFS1QcHk9xvBZ03Byjjkg8GqUd2UMeg8COs4OURtcBbdMJlgtPvsVI6Lm/7mi62Lb2MAZqjn5bDdRhe2xmvly8AnchYb6KHI++dfbp4mrnwblQXaBthlieGTN/U6UzGcixddTvJ8eLw82aGHfQRJzH5tklrr+w/k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 03:49:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 03:49:47 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v5 5/6] fstests: btrfs: testcase for sysfs policy syntax verification
Date: Mon,  7 Apr 2025 11:48:19 +0800
Message-ID: <4c4694bbb986b923b607e132f3c255617a8caf97.1743996408.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1743996408.git.anand.jain@oracle.com>
References: <cover.1743996408.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: f98d1058-e00e-49be-f4bd-08dd75873d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a+sKhiJgNz0QeFmjXn59l9H6eM+IRsUCnYoFM9IFNzfHt/FFqQoJ+kWuqzw2?=
 =?us-ascii?Q?J4uo3iEKP9bgP0kAL7jYqoM33s10TIEdJzwzFmjUWOZtqCpWc+oCzbiOai4J?=
 =?us-ascii?Q?7hAlTPO1mGOzYGzbviJq8JiWJf8X7E3Eh/smlfXs+OQAhrLbCWJxZBWLitwX?=
 =?us-ascii?Q?RO2/OYbacdq0Wo4dbvxT7MwrdL8qox3NCAc5F7PuW/G/4Pg0kULGwZUAwvOp?=
 =?us-ascii?Q?ArxSdpT0jBMkQBTn6R0M39qlRiO5X+5GvR7Y6tU6j5BDjXXHXJF1EFuFpNg2?=
 =?us-ascii?Q?YBOOImVitnrvgyTi2i6vKbZdP6C2sOUHEXpHrq+dlPSuI+NeFsJ39A+/nU94?=
 =?us-ascii?Q?93fRMHMX+66SlcInqzTdBxQ8a0A9aita2KmbHNb9/OFoFOlc6NIl2MkK2VMk?=
 =?us-ascii?Q?KAJ1yBykArAQhMzRs4z2Qk/hF9E/DA9AzD+YpOLbkPdsGjHHMtUTZx2gPENZ?=
 =?us-ascii?Q?sgGnK8rY1cYfGsgMlrCrfQrftbjhABiigp1IkeGT2AdnWAAKHOuRy+tflhoF?=
 =?us-ascii?Q?U71ekS/jNx4qCJtNWpKUhoH0eZrmHDPnCV8ig7vyUAa2xyDyjmLq2aBh0UZN?=
 =?us-ascii?Q?9ghOI/M0VU/lyHzB9gJXUtG8c5NCKM0ZYfEqiPIo7SWoeKuA6kWU3WGnvNpZ?=
 =?us-ascii?Q?ZBszLZY06d4iV3mgSxhWxs4hkoWdK++p2z5mlvZwYL313uKxcB/sDOvpIr6l?=
 =?us-ascii?Q?TMDmypTsXYQBKOViET5M0MKbXUPs8N6DPtcnjXiROv23div9btbaCC5EWGQ2?=
 =?us-ascii?Q?VdKI+g6d7AehbYT/NeucEAN8kuuXogdVxDL5suE41fxdHqH7AWTuBOEP13X4?=
 =?us-ascii?Q?ym/mjC6az+FemnXblTcMXRgXsECH33Rjp0yJNqtckWbUYAiKkgvlaIE0Ezgz?=
 =?us-ascii?Q?4SjHEM593hSWyLZHSo5Dy6l7y3qc/oylnZPiwSCrdA8n3sGIpzh4pJtp+TcK?=
 =?us-ascii?Q?jChY+DljKuWBWU7hNVxzQTMCRMMZd1BrErM/+z6kV5EqgGrPigxRzw1Q78Pe?=
 =?us-ascii?Q?6qLVK+c09h23fIAOoPOQh1yl5apLI1906JuiPZtUVDcveF+IbwZKgpBG09VY?=
 =?us-ascii?Q?oc2nOqlT9jh+11hnR2YrL36bqfc5wY5y2KlBtQf0UMIJg0sA34QULxfhwwwf?=
 =?us-ascii?Q?qVoR3Qot7ZaODax88sCzPFTmv+v1iRFymUblNzhIseawNuBZlsF4mdP8xV4N?=
 =?us-ascii?Q?8IzZyPs/lqWpiW/pmtLUWjQYi1A5MCEZrWwJycbgM0FD0xSZhYpS296Be6oz?=
 =?us-ascii?Q?7CsOtT7LgQ3BwmJ+CJcCgrGveX+TIR/0CxeiF8U/DvvMrvfJH309ZuYD+h+f?=
 =?us-ascii?Q?mGnZ83EXqpcpAV7BrTqVLLObB7VRcy35k3XL9MzSbgJ7hFlIyeKetJtl+XLU?=
 =?us-ascii?Q?QOI1t648rdeUJA4r8HtA6hG98xcD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6l0FDBC7c84BhXogKTnEWpB+VAjjquzXuvY1joFrPEWWAzh4YHxMEP/7//BC?=
 =?us-ascii?Q?hu5CYblvMgRMn7jLOjPFP9OkdSiENb9l6WCSUjVZ95zjL6aua63k68xxxDqC?=
 =?us-ascii?Q?JY85vLYgyJ/2FhhDeawkWU0yhujw0Y6+xMryThz6yjZNqPO/IL2DcPW+GaYh?=
 =?us-ascii?Q?TgebXsAoGaA7PxRiqtH8Wy9hNFQKmzCE/xHMP6chc3NOKYe09hUFkC4BXC6H?=
 =?us-ascii?Q?CJyXSN39NtPDoyx6aBbYxb4+xeXJMQZ7uWag5MfaaY5wOIcnyLELSEj7D6+z?=
 =?us-ascii?Q?goD5nxv4Q5+d+w1HuI4baM5KgY70fk2cmgzrmkMKk4Nz385FWChdPn6sDH8I?=
 =?us-ascii?Q?ky9ZW3hXp/4TXXVW2yKLqxlavWuGYio8bYlTmyfHk+Tpf/S3Zl45lQhkQrzx?=
 =?us-ascii?Q?XIPTmq0+kVcN2wxsLclPXNeY/5HvCJPSibrPL3HYXYKdMbPZff6cjjmuY+XE?=
 =?us-ascii?Q?qclwkfXFl+od0P2qHn/GihAldjo5RE59bTp5PD4SUmUj9W1LCkd2Tg0aaB7g?=
 =?us-ascii?Q?Xw1v/8Pvd/Q2kTURtXiMPXzX/F3oEqfNq91VSqIRIz2BuatSXzNJi/+twALZ?=
 =?us-ascii?Q?/v2BtTeKy4gj9iPrC0eCcJJX/8vTFlITIGYg3G0M7yQ8yYXuDZFMGBijRHTb?=
 =?us-ascii?Q?e0zsZnn+xWVxKxBazQbDAzydUVieQfQvTBFOviH7fOGCzm38B8uh62H8MqX9?=
 =?us-ascii?Q?xUER0DIeV5Jd5uGfbaViHjBWrOFlqqUKRePHdEC2F+EPV5o6i/Uq/Jeb2qyU?=
 =?us-ascii?Q?lNMBePT7SkjE7lbRIzxS+fTEN2YD+p7dFit7fcBYssPnWWl+sspLxX0QjT1R?=
 =?us-ascii?Q?E6itlA0+olqlEC/KQumeLm+atDNX0IlOMX9BGxKFk5eriKeAGvTr/0J9iX/n?=
 =?us-ascii?Q?F4rxX0/ZyFXRQaFlbXUEbbOZRKvJa4nO+DcSOROAyWZtE9jzdaxdhv3rMjc6?=
 =?us-ascii?Q?VuBu0cscbgERT0KOLHnfXjqppN4g3MoeUaqMrJc0ZqKkWugk9arNIzBtGhbW?=
 =?us-ascii?Q?KqnEI1aK2u86lMkQL0eQltRx6gKF69glGn33Fu5mYoOF3YyLd7aTieXXF8D9?=
 =?us-ascii?Q?5qAIseHrWTsuZigDHAibgOOeJXE7FHDdcMvFf4/3rdZf8bL6/BDSqKhhrAOj?=
 =?us-ascii?Q?SYV6eZbU/D4bXdVyzQ1LFgb4fD0Euw1R2EbitOpDd8xxgbzu0NBhrGk0kgIl?=
 =?us-ascii?Q?idar/gq77Mlwp+d/6s/tPHc0DtrlfRcvBI600GLkbSZJCrXT3Gi4e4spuLTu?=
 =?us-ascii?Q?jj1ganXTc1TDxk6ItMYxA/ODrj0+CGldUb53KbE5hE7GID7wBm8xVH4vLcDP?=
 =?us-ascii?Q?pNvQqde2jfFvgMMGRPDA2u6S2HnlMEyvED75pvgIixTrszQFzVAws/4XbEz/?=
 =?us-ascii?Q?iyRVZt5zSR+YTnsL8tJKnUI0Yw7gkgKI1qqBfA51Y655ZCUbSm/JnT+u429V?=
 =?us-ascii?Q?ItctBi8E5L8Khuuw024jBMiHP3ZR1AFawpMHfEJNYFUftR0Fj8xNbwGNufZQ?=
 =?us-ascii?Q?BYtqLSvIsw+eVZ/wL3pgkY2a0ZZ6jCLXEgpxm/PU2SuWBGDQOGke7OfUreA9?=
 =?us-ascii?Q?6CWHcRZTv1QEkih1ltTP56IdD51+3WEQFJ8PcA5E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2KqjRJIIkmv2omz+i7dInvD5FHvK2XBLIRTetJ+c8kWAjRBb3g0XDrCFdbQT+T+HrEq8l3kXj2JmcBrotkajMQgZHVbawH2ZAAMJgUiTYlB3Se8WmPIQKIk/WZfi/o7Pz+JQ3FAiR0veoQYMozUZ5A1rCdHqem8xzr65HKWkyZGOd3UI+1RQaZWw14++WKKN8hNyh9DZ6O4lEfUSiuM9LqU0z2/SloLFUvPFbL8QGkEcvMyCAU5hHSC/6YTbcfNgyioiEjg7pIe4n9PhqzfbeIrLaqaRigh/C8rsDOsIrHsBoBCesTwoWurf1ecJpWdE1Vt/3c6Q+2l9NkEohKTW3ptmb5tmZgJJH0PX2Uhv+HDCd1VVygTDKQANpL3htuWoBUeYIiaibyUTtHQk1cfUIsJtcCciqTO2yUYp4pdGMG5H8xKn025NWF+Jmx/pVvwTyn8KkSM9sTqW82HICvuY/362xhhTw2nBMkACha8gtUw7cJyVVXvpHSRuEH9vtP6KCqdZrUNSAQOcJfqPplRzPg2iyhtLub130oyMPJvCMMm7//atoRqQjtJ2Iv8aUQSCrj++3UQmd80df6Ntaurb1XpVcj6iR2U7oA52SOrS9eU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98d1058-e00e-49be-f4bd-08dd75873d92
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 03:49:47.4086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DD2zKb154iPtZE5F0FajcdwBVJCU/OUUJ41EdLKxPfWw72C4+Zcn5ffZF97o0Rc/sx7IUiKSZIXEsFByKnP3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504070025
X-Proofpoint-GUID: IhvXO3HzphYjAA1GhD5I2PILH4Y32Zpj
X-Proofpoint-ORIG-GUID: IhvXO3HzphYjAA1GhD5I2PILH4Y32Zpj

Checks if the sysfs attribute sanitizes arguments and verifies
input syntax.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/329     | 19 +++++++++++++++++++
 tests/btrfs/329.out | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out

diff --git a/tests/btrfs/329 b/tests/btrfs/329
new file mode 100755
index 000000000000..c87e96a4f38a
--- /dev/null
+++ b/tests/btrfs/329
@@ -0,0 +1,19 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# FS QA Test 329
+#
+# Verify sysfs knob input syntax for read_policy round-robin
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/sysfs
+. ./common/filter
+
+_require_fs_sysfs_attr_policy $TEST_DEV read_policy round-robin
+_verify_sysfs_syntax $TEST_DEV read_policy round-robin 4096
+
+status=0
+exit
diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
new file mode 100644
index 000000000000..eff7573adb6a
--- /dev/null
+++ b/tests/btrfs/329.out
@@ -0,0 +1,19 @@
+QA output created by 329
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
-- 
2.47.0


