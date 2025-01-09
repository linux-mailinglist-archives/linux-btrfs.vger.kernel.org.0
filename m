Return-Path: <linux-btrfs+bounces-10873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78929A07DA9
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 17:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07EC1881FC7
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA3F221DBB;
	Thu,  9 Jan 2025 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h/6x7Jw6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C2l6q7+V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B58218EA0
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440445; cv=fail; b=ASd8Fub1KUznDRvuDjlfhSlFHM+lmRMbujul7Gnf7dl6hcH1wCnGL+ge1pA4xH6jfC9gziIqTQfiUpCpkqavMubOm24J43Cenmv4Cmu6q1V9qeyU2CJGq/Xr6chJ+w4WrC07YA6EGk1wBVh1PPLLGfdBJnNp6BNVQ+C2qkXDl60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440445; c=relaxed/simple;
	bh=6JfpBKJtA1iRrHaTTTsfwMD0PQyDLj5DTZxxEgg16bk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e/YJpsOORE/RN63trH5GlfiPZUFf7EnECMvaGkrcAlO/PNXjEmQZByEuBx31DR3gn9Y8ChYXNPD/FKm2URctlIiAEAYkj8Hiq+TH886uJMDqEoJ/GJlFOJQehtYz7X32GVMwZ/X+IK6zHH7cVYQNUuXm2UUVPE4UpeIbGz42How=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h/6x7Jw6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C2l6q7+V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509GXmhK012772;
	Thu, 9 Jan 2025 16:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=RrccMrafO4bTGpFM
	IfXeN5gILyVVHLuCrVK/2Edb8Jw=; b=h/6x7Jw6WzWq62hThVUj6J0ZZZ7uUrSg
	IvTogqizz/ObkNhrbQqIWVTTtHQa956bZ4N/xpL11jBG/T9yTHVCiV4wsAySQLL3
	B+QWOEHtDGjm6LOLsWNeSM7AdMLDAAHbFoXH8y6rHTs9BU8aZh6x9fMxaQq+tQs1
	dmjhmJtZq1j7WQO2tjUurmW8wQcNR20pyvsMRMObqSimbHR/f7dAU43FGpeHDGLA
	U8H6l8emVhq4KADfikCbh6wJcLkH6MLmo6/4e+rNbupOGlbrW8tBK4cOs4rEE3LA
	HUeFE+FS6mMFs1CRwFljRcRk9t8S7QmA957CLv7eP3EsaC2r2Bh4FQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xvkt1215-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 16:34:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509FK9Qc004832;
	Thu, 9 Jan 2025 16:34:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xueba841-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 16:34:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9ew2mY3ZIh0GGQCHWLUK8lzSjEw6HTJdY99e+kqUZqwr/xtvP+A/dxFhoH9GLpARjxbkDLaQXQiDB85ANN3yAUDpElegl2HuJXScUEA+zcl0r2MKNOHkkeOwcYuIY3w2hB8WDKVd2seu8BeH5iu197jJSbzAB5yvRbicgoKVfYH1OUDltAUhI5UYDf6N0pqtZnYvZw09yfMJq0/X0+Ls2POTkA8eg7M+KJddCcfSLTaAUGat5rQSRt1442ayh2FeYQ4VvFsgs7G0BtfgEB3A1gNg7e4a4LQIYyoR90e1xHxOhmsvNipv0tgVFHLXCunOeopmHwGc1pBS/3kTZ5f6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrccMrafO4bTGpFMIfXeN5gILyVVHLuCrVK/2Edb8Jw=;
 b=dZiYcedLuH56Pq3UlEuLsXfjNhtNP4tLDs82VbnQ0ctGft5yMGol+xrGlOnaJERdoNsSWfWJHs7kqYqiOo7Sx9I4DkW0tPnkpGMZEzxsbAXCltZRwMiaRQ1K5oXprh8s+L2oosxBQoK9Ze3QHtRXa5cbab+5xKL/AzRpyOu0JJnxUEd/obIKu5pYMb+x949lC/iiwx1p13vblG4SEz+CxDHfWgJxUcqTR2LjQkh9rxWQquyGpR7XQFuLJs0yWwmYzKtLdLc49Udp43RixNG3hBUkWN/V1uWl/Azs7SXeY5qev79SaXAgb6TO5Ub0BVXTW/9xjMclBYjAQCz8jpczAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrccMrafO4bTGpFMIfXeN5gILyVVHLuCrVK/2Edb8Jw=;
 b=C2l6q7+VY4KAo050ypXECpi+ppNz+za5SNNOR2D0QQOVr/Jx3HZvxAw8VSNdqwth4vYtts+sR97NWRjMc+3Xi6cQ911RIhfGmFmidvXv6VascwMX58IY1haFByCqzU/rjmyODgNzAYyP+HRb3v8nzQqbWN9lgJgK6/QBtRX9u28=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB6960.namprd10.prod.outlook.com (2603:10b6:510:26e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Thu, 9 Jan
 2025 16:33:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 16:33:36 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH] btrfs: fix errors in source code
Date: Fri, 10 Jan 2025 00:33:24 +0800
Message-ID: <2758edc2e290bbbe4946c80c00889931477aac43.1736440357.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: c06ca423-5898-43cd-f329-08dd30cb5d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f1D/pBVkkLUqzJv/Uxy4D8djdTwvTxOhzrE8WxUbYnL9U7FzIKxsQs/sWvLY?=
 =?us-ascii?Q?mkgPk7COS2IKTcYkwZWQX9e/67u+ebJQaxXr/8r5cHArJyBrMi02FBivQ4Ad?=
 =?us-ascii?Q?3tpxYqW020LeBj0H1iYDA9AgvZ3jMsR0AxqD44Qs/2F9RzACijcdDgtoDvJT?=
 =?us-ascii?Q?TAqJBopIs3zlGJc9O1QHhNtyFYAelPk9NbCwe160mG35F3c/cvqkzKwNHqZM?=
 =?us-ascii?Q?ml2EmPlWfZMuCSWChk71idLPefuNCo7iTavM0walcc5+31o6Kxf6SMi52hfL?=
 =?us-ascii?Q?XpHcLZi+qsoYcUqStX+T6HD9Lq/6t6LATP5qkCXsdX2pnOa0zTsPoXX/w7Ex?=
 =?us-ascii?Q?Rqzbp+tmDi75k+2XVAa5PwORAyO96Pn/Vgma1+cHGhCbJPTD9A+VqLJABiO5?=
 =?us-ascii?Q?tb9cXA0NKJFQPXTcN7M9l3RXRL3kRHr0Uuuh6Wp83A0ewosM82oOHHRHLuz9?=
 =?us-ascii?Q?q7KYF49/naFwaJvUFxHyz63spBKguryHqWo4b8/eBVXObnhFoGuofZ5/oI0P?=
 =?us-ascii?Q?NX0xzTsVfCHEt+djNjvgmReoiBQuPKTpv4TNqV1eRolZo0pBqIbHFOoSQKmH?=
 =?us-ascii?Q?eep6Xw5/eOAWYYyq5bKSuLL2LO6Jukxx18ohdBw7oPV1I7fjRz3GW0U7pcLt?=
 =?us-ascii?Q?sw8ZeADboZ4Cg3RtcONMoECpsLYQV6CZq4d14Sv7Awx9KvmG2TAIvlSO07qk?=
 =?us-ascii?Q?jjFwkkxN/qRdk3vFsLKgNNw4Bmk0edupBne1/vVUQzJvdUq4dD55/yI4dBIJ?=
 =?us-ascii?Q?RC8BxbThE6D1B5rwJ4woNBG6QzWU5Mp1jwjiq6VO2DC5PjVli+0grirlZMqt?=
 =?us-ascii?Q?ZXwsNaroyCpbeCQECA/rgfFZRb105HwyYzmTsFCtWBCQwCWDBUQ0Zh/uU0gr?=
 =?us-ascii?Q?HeZ94gdQ+TyuiUuBDKSm5xKgMsgvqQKBUEiqvJfR7JzeIIJ+0FOzBoTCXltl?=
 =?us-ascii?Q?lYLdlB8tt2oJQsn4nBPx3lBJzMaGnwzkdV4gaO76zph6wfimUArxHkamvkyf?=
 =?us-ascii?Q?k4i1Ranh+ufKpD2cnsmdQtIOkUCG7EbbIvAUUEHpA6EzVu/OhhyKuqo8hyJr?=
 =?us-ascii?Q?3YQCnhVOHtQRfh3X2UgsSouCbEjq6cjllbj+mluyiF1ReS/B2CV8ex7B1yVp?=
 =?us-ascii?Q?k4xjv5dGp/UFpEnxr8izm7prmdy+ic3slNkyRWHf9F7n1JU59GgxSU/5luWW?=
 =?us-ascii?Q?zK5riSgJ3U8AdmBKqIORCY8RYZo89yt+/vSCOC/HuSVncHkp7QMIxRAPbDFF?=
 =?us-ascii?Q?w4DztPqH/0bX3oNdAF6qwtjGyjetenTqjz2v0hGgRCRaAoZc1ieWGdOi0y4l?=
 =?us-ascii?Q?Ep8u8vUG/3+TgIdp7QOg6TGelpvSHdtUpjLQFwynuoQTI/YSxo09BtVWBuoF?=
 =?us-ascii?Q?y0CkCmN9P6BaVIGEXmmn/M9nBxpj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m27ewvca0leU57VF7nqI5Zmhun/CtZ1vDRNzrIqM+wlgS1EyMSo9G3Xs7BzQ?=
 =?us-ascii?Q?YUlNVaha//U1FsEXWU+Uh46EqwJW6hJaKqpipXqSFcipNhHy909xb/fcFoPm?=
 =?us-ascii?Q?yl8NVv7XqmYXbB5n7z+jlIgyobvgHCCHJg5hY/gNO8ZiiLiGw9+AI+8/pLaZ?=
 =?us-ascii?Q?1BK63LnQjFoNFhc7331c6AKB8jOqeDr9p8NFA2GZ1bXiJ1rutjBN93g/3RGg?=
 =?us-ascii?Q?xCVXYNlwNoNQz9wQW4pGRqjl+XWcV4+fQA3VoYQ/VnnY8VF/oOhZ+QxdTMbS?=
 =?us-ascii?Q?dYSrm51pqf5kQz8FlxuWs+hPxyt8T6aNwSsOtbdJPdaquHYmt3bGk2EKzTEn?=
 =?us-ascii?Q?zH2NdYLp3Mw6hUWcCFNWOdemjID3v+xnqTRGALOfpw2yclYRjBDIIeLNHds/?=
 =?us-ascii?Q?ienVC/HMEcxfQ/kjE793phBIARa/TCHb/fWq/MNTTeSkWTrUt+VjVY6o38Ee?=
 =?us-ascii?Q?31cZDPfpVnz6r1Mx2sjI3S4oLQJcnmZe9atEruHxR+OWCYbfMV4gzoyccdFW?=
 =?us-ascii?Q?/u9+Qyt00AeIiqtVJoKGperJEr57AtpkVvMahr6wIp1t45QT1AW4vgHDTBam?=
 =?us-ascii?Q?XKnBBPqo5F5zGyvtSx+i34DGuu5AbdMwrvwCsPCH25Mtip9opo7g64C++Kct?=
 =?us-ascii?Q?MqGhi4CT4LfntiyL4DYONWElizd0SkE71D/YwK4pFeORlLMcKqB4fM2Pp9p8?=
 =?us-ascii?Q?nX39zmYcos0gKUrZXX2jPsA2/ALe26fbdwWXGH4D+MzophB2UiYla1VaEU9i?=
 =?us-ascii?Q?uNobgrL5nv/pC0F+996TPda4PgYC9V9oSImyq1DxstyvIS8InnQiIgX3YLzO?=
 =?us-ascii?Q?5ZE9sc6wQgRnisCKRXXVJH+Yt8ZIssGL+nUnnomlCTukqaJTrrTFwxYhZohs?=
 =?us-ascii?Q?sBIwsK3tl7q5ZxXsysriVzPqKyUFFZsqDheUqrXi0hjSJrloE8T1Y8EejOom?=
 =?us-ascii?Q?VdaJp+DEhtBCYqdvuEGeQg099NhuSio3NPrleuWrclH5ihZz/tNthvQo1Wyx?=
 =?us-ascii?Q?QqkmqjblQFaQgNwWvKDaTTEkHgnsmYei3M1dJxQ8MKj4ZlKv1iSUU7WZqKlS?=
 =?us-ascii?Q?lwFh832hChtgZ7Eb5YZ8T5uVq8M1wk8U9i/Q5r6kAn38gAB6qnNqAW7B5dF8?=
 =?us-ascii?Q?fq4+jTl8yhxGi/OyZ3EzqFybmGIypaA82+nB5esZ7N8MdNI9TLeunKJtWTkr?=
 =?us-ascii?Q?amrFrOFI0BjOzZYvshWlq/TiDhWrYUWedaAvLW5qxaDEdMQisR1GXj1WWplL?=
 =?us-ascii?Q?uaYdXfG/9S+PKGLdzFTJ+TVSWCmLs8zF8g6zXs0y8zAplE1C19hKSsE8s24+?=
 =?us-ascii?Q?vEqUxJaMUaIfII0dT7fu80K75sGy79f5czqGRilciEzjo35f/djHCs6QzN4T?=
 =?us-ascii?Q?B5WZQ/houhdt0a/rKMYfOrrf6WjNJDozmxWGOOTOBqR/rjmLEmkCw91ICwXo?=
 =?us-ascii?Q?H/uvf3ZzijuIBgcWT1ZWMVu2CYgPuVhlPgoDcvVRTnAqRVRi2kOszFsLGJ+X?=
 =?us-ascii?Q?LudCgf+qc/qPnR4Z1HRY14CuutEz7zq3FA229mOUGWo3QdsW/JKxakBWV3dW?=
 =?us-ascii?Q?aD/BZ0qN+HFnzEGWkjSI8cmzfYNTwWHRzOmfW7g/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DDIcj0Af8VRQcRdkpb4JR4H1xrivy2gCvvJC5LMxZQUsEvgtkTliSe4HvCmuF2fWNlI9P7Wi5oBb2pCLsvWGOiBuqddHw4x9+U8/6rdnh2OC/fnrRbGiZq4RB8f+UJJJNpbUcxzqcn1vJ/GCsViO+Q+0qE0d3q7AYtxZyL6c0nSTelXifT+58yJ8sGCGedWmomHObtZKgRdYxIUM8IMFtmXRHKLLek9xOaPEmzYjeCB7HMQtyLATgiJRrwPwF+Tio39cLg5dNBhreNCAQ2x/8YzuoZ6LxYQerf1KejKf2khEgrl1GB4ehhqA0RD7VyDhb6hwHRRd3MSgui8eK37Cwm54x9VEjzwBQeNw8WhgQ0Uk3HX6XKRV4/ISz+6EmfjdiFW6iAoOe9Vv8QjS/A5EmsLRJbY9SYAP3Horwupe7cVq4mNUx+o6T+6xioxGSVUKlpemfcZngl0AEDJYuFRnuUAOYQT7odTcA7oQRcL2ffxiYI/5XctGL83e9Wt3K6U5dPGZL9sM1en2TrLAvPx9B25eJDGhquGPSlHWrK3zZ3H1O3KEUAenGSsOf70pw8wgJQKIV9upHH85dW4jM3mXT1GVBnxZQNc92jlbO1jmUiA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06ca423-5898-43cd-f329-08dd30cb5d5e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:33:36.3140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQ6sfyiy3wPPt9OmEBvG6fLA2AlfdalAxqp9fBD9a7q7kgPxmZRHRXLommyvh13cN3cgie+KEKtHOT/bkKQfow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_08,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090132
X-Proofpoint-GUID: t1hksFysma-vGVC4rF44DpAPbaFhuV2u
X-Proofpoint-ORIG-GUID: t1hksFysma-vGVC4rF44DpAPbaFhuV2u

Rectified minor typos in comments and documentation within the Btrfs source code to improve clarity and maintain code quality.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/backref.h | 2 +-
 fs/btrfs/fs.h      | 2 +-
 fs/btrfs/volumes.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index e8c22cccb5c1..a6db30d67b57 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -190,7 +190,7 @@ struct btrfs_backref_share_check_ctx {
 	 * It's very common to have several file extent items that point to the
 	 * same extent (bytenr) but with different offsets and lengths. This
 	 * typically happens for COW writes, partial writes into prealloc
-	 * extents, NOCOW writes after snapshoting a root, hole punching or
+	 * extents, NOCOW writes after snapshotting a root, hole punching or
 	 * reflinking within the same file (less common perhaps).
 	 * So keep a small cache with the lookup results for the extent pointed
 	 * by the last few file extent items. This cache is checked, with a
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 79a1a3d6f04d..119867be04e9 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -265,7 +265,7 @@ enum {
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/*
-	 * Features under developmen like Extent tree v2 support is enabled
+	 * Features under development like Extent tree v2 support is enabled
 	 * only under CONFIG_BTRFS_EXPERIMENTAL
 	 */
 #define BTRFS_FEATURE_INCOMPAT_SUPP		\
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3a416b1bc24c..04208821faed 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -31,7 +31,7 @@ struct btrfs_zoned_device_info;
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
 
 /*
- * Arbitratry maximum size of one discard request to limit potentially long time
+ * Arbitrary maximum size of one discard request to limit potentially long time
  * spent in blkdev_issue_discard().
  */
 #define BTRFS_MAX_DISCARD_CHUNK_SIZE	(SZ_1G)
-- 
2.47.0


