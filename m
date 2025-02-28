Return-Path: <linux-btrfs+bounces-11929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAABA49138
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 06:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2898818918B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 05:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C201C54B2;
	Fri, 28 Feb 2025 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ENxkbkUB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t46EOyxX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C410E5;
	Fri, 28 Feb 2025 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722164; cv=fail; b=HF5kYtteHiw7v6QwuLlyUYF5O23xAFetxgpJRVdhWsnRVrBhS98QDDhqK+Qc3EsaYFPmONMGcJ8sxf2c01VCRzYwz847PB5IqDjXe6VWu6SRbXb9U0dyR7/GMieZVeENpRcEDWtlw5/ySXskDG4WmCipANk3zjoxmUP/pKEBSnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722164; c=relaxed/simple;
	bh=zEVGOVDO12C4DbBQjQWUA2xu3FrsNWr52tz921WkCQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HiEQ/akly9NzN5WR1EWMuBA9ShGiP4sEDlyhZd48GFe2hdzy1JL+8Yc+w3GKKfIepHo8z0xpXkVI8Ldk30AL/zusisVRrIP/GVm2682b0c1ZG8psDf5vmKQdQ8XhF/Bl0H47is0cQ2tDap9zpw7XGWV5CiyqJZluHPBQzhYqTrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ENxkbkUB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t46EOyxX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1Blr1023930;
	Fri, 28 Feb 2025 05:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=iCXSOIu6qMdCGOyhvnaYUTjstvXQ+b5CKT9xYoJNMuk=; b=
	ENxkbkUB3bXQjlcGpm8XtCh6q7HxnoO8InrVNRx8P07KKswNUwjbKFfSlhspID53
	ATpK/8O+Jb6R9GQzkI4Ujz2xKOKOtwY3dwkL7fHNsdahdKNRkqSj1MTSCslmVzsP
	YzT8uptzF6C8Gmy2kLI2UxjtTqp2tJMn0zczWpgplJNCebt+a0DeVqhgzLEFkNzS
	iVzgRrrzwY3EEcJuhlDl7AC8zVOq0bJLPlr7TSv5iI/a+kZIkATu0sG9vsEn642f
	DACD4RIowapIl2jfo/H+o98Gi0oMNw11XDitLOiSJn6HXs6notkv96v3aJLtmPlY
	s75wUhoNuEc564oItMcyUg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf4ue2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 05:55:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S5p7Xp002719;
	Fri, 28 Feb 2025 05:55:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51ddt1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 05:55:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9UbyrLr+BpqhF0aiUaTF9D1dSAodhg5oMVt5u3jANZA5UXMcrMndx6kYXn+fMTsIMonTkDq5+QCZF0O8HvCBbbhcQlmtpJGq+7fU5K8gF/QbZemHMP5ryqZoIoJRDxC3ghexUhkVJRqEo4+5txXVgiLo5DghY99sAmROXWXWx5pgr1MNtZnM6auska8SVfDODWiWoIbbZ9wUAjEC4h77atR3cHKSoIVicf7mltDkLuzA6lHNb1/C7FOJmZ0OzgetswahA1sFfF4C127WXe/R2K9xbvDSqTi6jaekPUVPR/7ognK7N9QeB4vwp/xK8bXrNeo5+loW3n/2XI8D0oirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCXSOIu6qMdCGOyhvnaYUTjstvXQ+b5CKT9xYoJNMuk=;
 b=NgCTG0p9V8ASiwxBUb18q2LWq/chdE4Dh60r2h9APoFW7TC2InzduxT1MfGG3it1rLYNGsZB3VqQrgejRqWks/pd2N0dBZng91U/fzeJUmSWUvugcRuxEIiiNwya/b6lV8MTpYmuzckV0ch5T5sOupzZFWss2nwcv1In14/tulA+VDrtnSUDVsKMI+LfpUZfqbfLJwEaLiSedgfronmGy9VDQcwM3WQPTLC7tHr+TN0gxvczYs0CXxRdLJLCK5MpjwMqhhDbgoZMc+0lkfJnP2ihry2R8lJc2CYblCE/T2KqJH8IzPYiSHm7gS5od/oC4Bi/r5+21cezDJqJ0BHGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCXSOIu6qMdCGOyhvnaYUTjstvXQ+b5CKT9xYoJNMuk=;
 b=t46EOyxXSeXHueEWiehJZo17FQurBI9iET4KJjkVIDjwD28VZGL0FaLg+pzt8J+roMpsKAv5KjD2r47/Xe4tiDe+dXGawbFS98RF2T22PIoPyVhuoWirf1r8W2y9I6XQG9DJJY3BTB6nX1EzUdKxWuJ7CsMjImvbhR7Edincn8Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6618.namprd10.prod.outlook.com (2603:10b6:806:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 05:55:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 05:55:56 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org
Subject: [PATCH v4 5/5] fstests: btrfs: testcase for sysfs chunk_size attribute validation
Date: Fri, 28 Feb 2025 13:55:23 +0800
Message-ID: <8b6df6ccabf016310063e75117759c835931f70a.1740721626.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1740721626.git.anand.jain@oracle.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: b77620e5-0d99-4e17-f488-08dd57bc9188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TgbcV1ZUv/aNGLSwSTgBQ4FJTKhHNWikL8rChbCZDF0IzzbClVrpPBNziC05?=
 =?us-ascii?Q?YF6yREjLxywil6GAgiEhkZJdqg1RtzwLfYTdHFwA7RErhqIfD3b0xfSdh+WZ?=
 =?us-ascii?Q?YA+aeLeU3jSUF993EBiFjPZ6L1r525siiDPZzkm8fIvRLUSw0KIuhpoEFUHP?=
 =?us-ascii?Q?lNMveC8j51kTVNXjSF27kOuEnboTeDG1p9ztnVJ4hNIk6AARRFM8f/fq3Db7?=
 =?us-ascii?Q?y9Z0ABGcF1lBMwquMv9nkvFm+TYiZLNicRZwDNrRjHXncmnOLa9+zWGGhTse?=
 =?us-ascii?Q?M8N4Clxsow533mZkgQ7W1adPSuRhkIiJEQGtl4HG3JgxJxxeUnMBtFXVmqH8?=
 =?us-ascii?Q?79GTYo3nnXALcmGPNLb+BHS3BgXAQ67SjltC5Frcro4PGS0W2DLzf83Bds4a?=
 =?us-ascii?Q?Jt5cP2mkXApjmkmp1/Rl6g3WAX/dYm5Pe5HcE65dAF2wAsB1KtwEYyyG5dmZ?=
 =?us-ascii?Q?zAkpv+szUAx+kEKHPlGdS5lx8iqKNniLQDtFV1c+uC3cGrnXcJiaPx88zSjy?=
 =?us-ascii?Q?ouNghBN/2SeTDr1pfAh67D0HGntwvJhJxDMxw4Nw4zzKZmbaWirFQRZ2tvEh?=
 =?us-ascii?Q?85w1vw07pP/PunPCR2zwswJLcsvBI1ikjaPnuyDC/csCJGtrrI/sfrK9cxnh?=
 =?us-ascii?Q?bOq5cnS3tHblpr9J6T3AAET7nREvp/PIxfgRYJGglNPm5ySo1YR/OSRccM6H?=
 =?us-ascii?Q?SR5yX/R0VMfnd2UI0H7I8gU7NsMeCtuefDZxP9obp1XZswuhM5Id8h+3eT7t?=
 =?us-ascii?Q?7X6/CMHamK1jSwS9dKhVIsw6f0e2qc9m0RWSuZoupdhVRGJqQ8w8hOHRfR7d?=
 =?us-ascii?Q?tBwZUJHe3CaxyaLqASgBdNcGugwAYOWJ1g6eBD6oXV1Z0JLbJEA9a06I+gEj?=
 =?us-ascii?Q?6M7VsezBZzofa8NLEJuOvin6AJuf2DW281+A4Ak/xwcVK8pKYrWdWBAtGSpk?=
 =?us-ascii?Q?giBITCc0yk+cenRHGE/LO8jXf+wyht1eYgkUxap0kH4hye4EgTwaRxW9BASz?=
 =?us-ascii?Q?W16BetZ+mz3f2jZaHPGwfbQuKlR0w0OBOC0jh2LWcog7LGSHLjedmXemtdGB?=
 =?us-ascii?Q?iyy73uvtZn59k6/bgYj3R4r0UnpAnY9cGXkQBOrNexT7dv09mmsSnJL2ei1O?=
 =?us-ascii?Q?gLczX8ejFQaesBnq1fL3NhWEw2m9tk8VpfT29Ikp3ydOZELIBYmuosa1bCA6?=
 =?us-ascii?Q?d0IIkrshq5iZrZEfocyIFNLor/NZY+rFPqfo99aGvXlQw0UwX0FmHnZ3w9up?=
 =?us-ascii?Q?7f14BJ89Rytg4ECm6G4jt58BHnUoaXLh5XCmJrTu6FLgbm7JEcUo5tZ+hnJz?=
 =?us-ascii?Q?TVoei3hvzlo40o9MjfNDLeyaMNALLA1hcvDAyBbqYDReAh+CljHP5VY2UaeD?=
 =?us-ascii?Q?cTeEoiziJbWo9TfMjFpyOj4AcfjS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XhTl09QVgJTPVVjzLl0M6nzAwBFxLB/nMTjU0l5aW/PYDlFtToYXqbjQWxjV?=
 =?us-ascii?Q?7ls+OO9lHix/p3frio1h+AuwDn64cW+e2fBAJSHkkg/CFNANs/LRmI3211Ih?=
 =?us-ascii?Q?cHGp3XaXvli+sdG9JqwEDBqdLO3pyJAFeTwQzQHJeuqzQ6UiS/nrMycVWv9F?=
 =?us-ascii?Q?p5GXGLCzkfJ/rseUlSsVMqHTjQ9iUaKnS3kpwu6ShscSLCEu0r55GIQLFc7d?=
 =?us-ascii?Q?HwwbC0ay9R5vU7ql0TlOPSZ1t/QBjpHSOvi8vLZX6ddjcBVeAr+gmSvZ1dPy?=
 =?us-ascii?Q?K2/01u+/mZpIEsOKwuHv82m9YvdZ2xhUl85mYmkDh8bpCj/ldaVb2JK/7VSN?=
 =?us-ascii?Q?mFKRklT9gWzNJdRLGiJiijWWWXyCTzXaz4JZWKFfKE9jeemHDmvkiop987LV?=
 =?us-ascii?Q?yslleztJBDQzfbOrbSTt5VBQ/B+HG21s1EM8RbrlZtzKGJVYDCqZuHM5G1bU?=
 =?us-ascii?Q?uMNOcP/BrG5Iv1DR3B9cbZxLfJzZm1+U72F+OmBNQnMt8ke1+If+KRolmuJx?=
 =?us-ascii?Q?VPamT75A6irElUZxkxFMN87LLePtK01xGcdM5dmb0f22ah021fOHVLTiQA9I?=
 =?us-ascii?Q?LeNBlIoMvZycy9p54Y44Bq1FGyo5iHvZnNyt0vEYl9pzMD1m10zcRY7CsWzj?=
 =?us-ascii?Q?2SVFiwPR2rrROiQ/KC2lKvf4QsJH9UJeUnJ044sYuIzn2q1ty8XViIkXcx6V?=
 =?us-ascii?Q?RMinqjlUliJgwqlH3sVehTrHxSlNq8jz8U09aPQAUMr+MYaY/ijhz+l+dwQp?=
 =?us-ascii?Q?vRq+XI8crdLTitBWnIm8kuUuaYKsLqPSHrpfezKTBL1J2Yxp/x51hpi345o/?=
 =?us-ascii?Q?lf0JCJDf06Jg2bx+37YODyfds0t77ST5tY7uDUqYGklvtUDsJjMYnxcw9PBH?=
 =?us-ascii?Q?XmmrdSPIqE/lrQ6SGZKYOTo+Lw+IU6Yu0nxv/WDWFbV/RQCjUJi879Cdolwx?=
 =?us-ascii?Q?PIkNChrSS5c9+ool7YC6ygx8IJnBHtYAAOZ7p4wh/GVdvFlF88myvF/f4WEz?=
 =?us-ascii?Q?LfV+EWXyDxQbMgmrHGYhPdgCc7JGhs4dLdz2ZAkDQozV79Cb6bzR2M4XerKl?=
 =?us-ascii?Q?s/BoSGVqpC4eOByU2qcBGKYZZlUXpsiHoPPiYA6tgi44uuOMcvC7tinAPA5a?=
 =?us-ascii?Q?CaxVRAba1xrULeAL3o1gin+ZeAnIIQxxhLYE7KI4AQzHx+r5o++7Q64EM+aJ?=
 =?us-ascii?Q?2lnZlaJM2QvI3AZ7gntmjsAvvB0wCVxYclaJo9AAkpwimPkbVj3MuoGxvW81?=
 =?us-ascii?Q?ezgXSSwPsXXb9/l+8MmgzpdFHjoXClL1g0jbTA/MeTdRx9fjyBRJj5WpMXDz?=
 =?us-ascii?Q?sfOgnv/rCf4VBSPUj1gxmYCGJhmgZa2LlDpaoQgkYT+APC7zOSW1vt6KeAa/?=
 =?us-ascii?Q?log90JnhFx0APlJfHpE3xEhUIjoDc2o7pzn5N+M7npUqoecBHQTHWGLSZan8?=
 =?us-ascii?Q?9iIi374cXbb0Nn4m82TwdvxJKh2FxUcXCznFtU2IAabw8chn2lsLEDq0h+j4?=
 =?us-ascii?Q?wYdjZ9K2d8IQFN/omIJCqc/PTkoQHVEmSXLFP3ZSFQxV/4sos3F94LJ+NCsu?=
 =?us-ascii?Q?Cms3GNPgtp3U40p7/mAB7MfXtSaTaI+qXRNOmkDD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vIlMwLVJacs/nT7iicaY1un8MhVVg3Ks67jVqixFDD3ONgrg44tqz+nrBLxWTlyXEmM2pRRkCTUYurzulWM0MbBR/XuV4xYzdJouNmMf0e+kDSF8s7Ot3HyNskQueBW2C4wA8yho52n7kW2XI+kfXBIg9BAmvLUpeEfiWo9qIhPv9oOiwS6PB102okMVNrul1+FAQAUIbPhxNzoBx99mY1NToDQ4SF0Hxn2AxRDyi/W45YYLn0WazNpaaQAC0aLESysLeds+7tlJcgJmOJ+bEEJFw2aP7Hu0DloK9ejbrSFjN3lFbbom0mlY3WYwwdQLI4yL1+eThMjH77GJc4TyA9nXWNnzeCfSaoPLKrhE+JWoz9n6yLDvKneYgi0DO39i25XCtKHw3FYKAFosCodnEA9xlvXQWbs8v69ujA4DIW/QvXr12yOgo7vjxO22J1W7Vxy1tCZ8DV2Z4zq2y2vuza+qY7ljV36T2c7dIlP0NGGF/wn/UU1b2yzj2PmGLOcuXVOpbMuiUCN2uHiqEcY9FmwPC3+JQqxkfhlwGiom9tTvhl/9ZxdytWhosw1p5JRGwFx1tnsf+V8Yr7J2xceGZn7sFfAeH/YF4rwMbPBMGqQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77620e5-0d99-4e17-f488-08dd57bc9188
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:55:56.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aG6fiFsiQnB1keNgiRr8FD8IoXIoe6GJc96GPiPxqrZWUrxFHeYfEb7pwvnOhOVVuxPsm5I67mmIRQyTQlgXrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280040
X-Proofpoint-ORIG-GUID: 3qdl3ueae-z_ZOSuKfHdAbMapux9MmaR
X-Proofpoint-GUID: 3qdl3ueae-z_ZOSuKfHdAbMapux9MmaR

Checks if the sysfs attribute sanitizes arguments and verifies
input syntax allocation/data/chunk_size.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/334     | 19 +++++++++++++++++++
 tests/btrfs/334.out | 14 ++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100755 tests/btrfs/334
 create mode 100644 tests/btrfs/334.out

diff --git a/tests/btrfs/334 b/tests/btrfs/334
new file mode 100755
index 000000000000..532fe37a0489
--- /dev/null
+++ b/tests/btrfs/334
@@ -0,0 +1,19 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# FS QA Test 334
+#
+# Verify sysfs knob input syntax for allocation/data/chunk_size
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/sysfs
+. ./common/filter
+
+_require_fs_sysfs_attr $TEST_DEV allocation/data/chunk_size
+verify_sysfs_syntax $TEST_DEV allocation/data/chunk_size 256m
+
+status=0
+exit
diff --git a/tests/btrfs/334.out b/tests/btrfs/334.out
new file mode 100644
index 000000000000..f64f9ac09499
--- /dev/null
+++ b/tests/btrfs/334.out
@@ -0,0 +1,14 @@
+QA output created by 334
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


