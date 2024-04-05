Return-Path: <linux-btrfs+bounces-3952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CCC899855
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 10:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740961F21EE9
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5415FA84;
	Fri,  5 Apr 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cWFUwHse";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JqnTZlaT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD415F3E8;
	Fri,  5 Apr 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306739; cv=fail; b=JJ+c3hEvlZnt9Wsdohnky2xasf+IimF6M3tNu3ovAIfYHh7tYpDM7z0eXu82uep28b/MBNUSlUcPk/1jTY/yTStjDmV9tLP1rWy+EGg+sb7yKkWz9a+MRJ7cs41m+FAUtO0YTxxrZeUWbwviLAG2qO/OfP4Exv6zFsRREIwUSJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306739; c=relaxed/simple;
	bh=uNdpPXnHGHpUfQdkBQ3hQrMSSI90+u8groGXEM2iF6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ePyyAYvTFWNlXGfHpW/XecR8ucF3Qz6zZxz53yALLo3VOzVNcBvJlo+AQaEOiHJAy4LEp7J29Eb0rOdnxc1b05qjoIsW3pkkVoy1SWwX7zjHE5OdT2Bb6DuhGN9j8ktV6IS9plN9bczJfkopqXud7emB3LovqB/5R5rRaD9//qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cWFUwHse; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JqnTZlaT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4358Y5TR004526;
	Fri, 5 Apr 2024 08:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=pKRwmYvaY7H+fOKNuNyHmuLdlZTOXjRdmB6YJ6G0mnU=;
 b=cWFUwHsejxbp/W+aX2ghjeVOt2SLNyZ+ZOARyQX+8bGHigZsv6XwZ2qldZKlqYTPry+J
 hmEO3pZN8qmHvQUDOPUQkQT2ZPJxt7w08G15iK1wi814D2gTmPbpT0CT6Wk93HroYzho
 gH+p5FvYbkd6vqYvPxmfxj9mwxca7J6kMXeLHFqqObbFq71geASgi99yJh/aWHVwAf2G
 FSTFWNwMJJIp4REqRFWBwcSejQ3k9B1YY50zScWEnNwuOSzQ0SnJEG6bGFZnkm0sLSHJ
 /jHbox8iay/aDo4AhhOHwra4t3IMeSMbQNrRDHSZJZtk6ABkIuJLJxyOV8sUk37jcns2 Cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9en0k0c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 08:45:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4358dWcZ009396;
	Fri, 5 Apr 2024 08:45:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emmu1bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 08:45:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4uaDTAIH4ZCf4z3B/vEtKcsc4V4pXj6vlS1f2MBidqMIV4ENofZmzc/0b4S82Xm/NimLMdA5Lnc1kcNzxa/GD3CUSi9CVQnWDRf2oOUk6XKOdECdySakx1s+yVk/lRopMtzjdah4w0Rh39yO4V8gR6hu1u/HUNgzbFFlZgtmJeu0Z/la/tYfJlv8jIHJIKaUiV297fNkRQ3crM8g5AfTOwxmjne2x5G8R63NcYLxUx+9Fe7nWYBaFeFn1VDnNDt9WSLoOduT2yRWf55PEHUV1b9jBkpyfDLKnMeeiyVbHjszMqC9FkXq+bApxuXiOIqYcZOGZJdeAW3CbdQv6rz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKRwmYvaY7H+fOKNuNyHmuLdlZTOXjRdmB6YJ6G0mnU=;
 b=dEnF2Co6VhTNSm6eJl0M2CvYl+oxWGXjzX7+cqFXoCYHT16RAkb9N7JNh2fWlwsYlgHEcjAKtc3aVCRRwKcc5BpP9jZzRAiVYQ36t/v3GYo6r2M63m7Lq6yVecUN3XaXFGrxZCy8iFYtouWJEuPaBH42pmmoZC6msPkopEqa+vuYW4mfTSlngN+trTYd9L3Wjez58AcrFSmzG2Ldj/RffyGv6hKxJaOBaPQQdCFiVb6NEkoD13JJLHKU6jMoXin01pwXv/KdCrzi0vupHlaYBEmv+qlNMjx4CoOKM252bJ8n6H92F8Aa1jNNErQ3gyGQhtcBkzpqneeetFdh4OuKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKRwmYvaY7H+fOKNuNyHmuLdlZTOXjRdmB6YJ6G0mnU=;
 b=JqnTZlaTbH9Zhox+dxRxkaS0mAbuzkjmFQeeWyA1OqDwFVmh4AmM4EXGOXkklbWPKklZKoOYqL3KFWsOqjk+dYr1PMncqXgS92zbLxt3MOO5bFrRLv0GYDCTFrWWrqOfSJwSXLX9SrkcH2gXfn+2GVfzM4NIo7Vor96176YR7a8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7323.namprd10.prod.outlook.com (2603:10b6:8:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 5 Apr 2024 08:45:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 08:45:28 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.cz
Subject: [PATCH 2/2] btrfs: create snapshot fix golden output
Date: Fri,  5 Apr 2024 16:45:03 +0800
Message-ID: <8da4d9c492f5086b7a481c215623d1ac487e0987.1712306454.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1712306454.git.anand.jain@oracle.com>
References: <cover.1712306454.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7323:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	P8Pvns0XTiB32f8/rxbv2kUd2KfIrRwaCsD5XtpVFQY87/LUE6tlTcH/Wo54B3oLoX36V3O8YjHDos+TOjDNYjLoVnGVea5zhXcQrplbFYkMvzomDvPMRrkeu0qW2dGJWO8Gu/ErTHvvHlK+2DC6uTkhSJtZTmOEYs37/u/vvkFmFHrTLmx6eL+/ElIVYMAewX9jM1dvJstY4guFP9d9GFQactP+7WsBFcN2EyCGtJhPduMAsrlihNugJ7SIy4qtXrAZeJUoQT6YuImPFR7MPgTueKDjeUYf/xBTQDyGZyp8rA+xziawMr8C+TK3tE5CDQxgTBxCqBkf1QsUkS7srSMhotdTq/oLXIXASIt4n/cdlyAg5Kmj/1FXyqaoK+6UdcXktbz16KCiLGdkDcHZC++hL6yTHCXL4JT6iOgP2bNq51+WLGufwvrbrKbcZZtXCPFplLY0pBXeNlA2gF51ejg7Rj1JDnnGgk5a1okQOcgg5OGhmjaVdupZiJeZEa66k6WPh/1SaVfYK10dl/fMLXsSo9SK2uXQGOIrElXPCDlASv2KKJ68mTn37tae+AJv57+PnPrABBHP+LwpKP28gohd2ORH3WTUL5LPu7kImOsegNwYjQ1qQudpTc1gbvWZqoWmRlo5JYHOkfWjmxSKTODtJV+DAQ3v4mMYgUWxvr0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZiZnoLytMl4/ljPdDeFDIr0feqUIaUaBKSphwX6rYXlRrvkyD1o8uktWHUJR?=
 =?us-ascii?Q?fN6CNZmo85iGvkBFfH7kiIKufxCbgO2KViAO81CQENoPO91BYo/LNXtFyk/h?=
 =?us-ascii?Q?I/P3S4lToqjr1CQpLsDKCHD3gi9s4/e15GBPW+LrwDuRzxk9Se5lOTFakrBV?=
 =?us-ascii?Q?xfEOD+F577BlLrr11vU/mQiPETy1amJI8VPMQ6La0XrixAbUcDuhkVfbK98m?=
 =?us-ascii?Q?V1B+vH7rcrN5l42ID9ES2+Z9VhqQF38RAjZ6opSiZ6xerQ36j542AXK3a1kl?=
 =?us-ascii?Q?2ttK+gP+Y0ptLxPkteHeNp9wI4lQtWpb7uQCjacojViPVGbghOYSGP8fa9wL?=
 =?us-ascii?Q?sww3vSahQW0tlMZNo+l2Oz9xVmJ4gVeHRH8LaFHNJIVGrbEvADPwfTFDx7Vp?=
 =?us-ascii?Q?G5pBRpKmZuVQVcq19m55B+rIehW1qy7sXVqxPn8JlWcu7oowOC4f6ho5nRlE?=
 =?us-ascii?Q?7CS/jWKAxjbwidKXLlrD9hON0xhqgNiz8/KehDOhEbCOL5ISgjfP5k8Ds0km?=
 =?us-ascii?Q?fax+GuqBq2h4dQsrxdQZzVVzxdSGwWGZqA4gIqMgJ3yNnY4uckL4qfUsWiaJ?=
 =?us-ascii?Q?gS64MEtKvnIXOOZ86RIMJt/ZaoXi5RbHK4TMF+xJB3vGP8cT4OAnnixjM8do?=
 =?us-ascii?Q?YYuybZdG1TfbEoiL4bR9k/3b5mL5e/mY9O1D4aqa4Ix1ZdZSmr+f0h6mU5dz?=
 =?us-ascii?Q?9S46zXoQI7ajhE5yhcXdzOM+1njSwp3p6GJOCMvN7fJB2Yugll31n4tbgGo9?=
 =?us-ascii?Q?3le65sahUt1TsVsWSTDpzOhLHOq7wtL9SSqEKUPIgoWXpXzkpoQEQjZaAQgf?=
 =?us-ascii?Q?GWT66WHULaiuKI0p+ALfoZxCz/50WMDQ6ed31nxng6cph+CMdMPby5AvbN/6?=
 =?us-ascii?Q?htppuRKLyiw2ZOnHc4sdFSFp1RSgwNyAK8R0mG1mnBM/3s75LUImLJMJSwKy?=
 =?us-ascii?Q?GP6bak/HnIqSVx0fYlbkWFi+ljozPWyd0ybc6Zmd+zmALp9G8A3wsMyC0Ire?=
 =?us-ascii?Q?xFwt8UQ/SKVGh++ztc796Pt46i3qJxzb4XzDdyi7gnl4elnLoP6LCHKKLQyT?=
 =?us-ascii?Q?rqi8ag+3WqgzBQ0yPq9IOKcXQMCFuIM7hybb/SSeMEuEeH4p1S7+kwth0LVt?=
 =?us-ascii?Q?X4O+Sg4lWGg+KpuMQMjJ37JILEez3DUiVdDHkyCtEnQ+ZsrmZxRsF9BIlxVH?=
 =?us-ascii?Q?paSmbfdMKUCsKc5oGAOICU98qzkQgOWSYUnkFUfBnXFwkrb/uML5BnShK1qd?=
 =?us-ascii?Q?QCMr+KoyGhq9UMe4/pgq8R1ZN/Y5BbV1tik1hOGhfc46TbJzYQbdfkSmxgui?=
 =?us-ascii?Q?pmTgBIDLk5TrSm2vCz5xG9ieVW1Lv9Y+6a0b6yxOe1bTvAMZTWNQjwAo86mV?=
 =?us-ascii?Q?IJr/Xd0J7KwdXPLwfuKpXhBmAUjqFZh6IB7E5pNKgQ8DlxjcTFumQ4ARa+FR?=
 =?us-ascii?Q?zmyxVWaA4VMogfSN8XhBQvwCq/a/5cVybrwSPpc9CZ4XQBZvdLs4z1lyDfP/?=
 =?us-ascii?Q?yWJFLaj3OT4778UnLWNWN+tv1YkeYH5I7MKZVHRPQXcN+Q35IeEOTu1uGHQ8?=
 =?us-ascii?Q?ycAgEJTYv0KJHkXyg1tAK+nbF2uBjU8x0ptcnI4ngavOMhWXHahUsAcCiwCi?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	S/VvclvMHJ6rPi8G35iUX1WgqAy4D798ApJQSnWXY9u0oODGTXWt/a0s85ZwvDkt/ZkXkE48tsSu1eT05w7vxBGk+I3uNuMiWcwcaWEYreIytr30GGcPTfCnLg68Sv/rW4V/xiCJY0OJNEOJeEf1roLikbSian1vEiCG6JFHGGJYmG1uH3rnI3MPAd5Nm834AMmwE1OBmMBzURabNQ/vSIiuw2DBztfgHlZTwbhQEXYvC9218crSj+CkQX4aD80Mh/yjC50IK6+dFNTbNAYIycRaUmzXvNBqNnLAT9NdupLqiir/h1/BRfvJ3GnfyooQMwRyT71md+tBd+P3GCs1JpIw7SwKwFUsuuPwQQmkX5mi6w8KPYy33lEifyJ2gdu47+u9dXhbmdYODmQ56nkLMpWTmNoLKSdQGgOTVyk9sr2tZ5WyHJQONtQKMdDSryxJ+o5yuQWfqAUbjAQqLZ/BIwDJB5RZ0RkwGXiWQlKXEmfFNltSV7W+Ws89zSVN++SFKWunt9PNj14HvW3M5pkBb3OI6CrbwjuofVq8w5l5TL5SmagJBjud0sYLCI7ORtc5CUoNKQGDT84M8E4FZPtAowa1rSd69fvEP1EZqp/HVOs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2960effb-8f3c-49e0-e539-08dc554cbe84
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 08:45:28.4994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VtFqvwfHvqEty0+larrpkdZRbKWRdgJOva2Y+Qw4D7uwhGnxar4+ajHI2ruA39fSTFFHOcTZpMHd4fT3VO0RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_08,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050063
X-Proofpoint-GUID: LqWijbBvVcaZnOyt7sRHIxF2FYCsWRnR
X-Proofpoint-ORIG-GUID: LqWijbBvVcaZnOyt7sRHIxF2FYCsWRnR

Btrfs-progs commit 5f87b467a9e7 ("subvolume: output the prompt line only
when the ioctl succeeded") changed the output for snapshot command,
updating the golden outputs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/001.out | 2 +-
 tests/btrfs/152.out | 4 ++--
 tests/btrfs/168.out | 4 ++--
 tests/btrfs/202.out | 2 +-
 tests/btrfs/300.out | 2 +-
 tests/btrfs/302.out | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/001.out b/tests/btrfs/001.out
index c782bde96091..c9e32265da6a 100644
--- a/tests/btrfs/001.out
+++ b/tests/btrfs/001.out
@@ -3,7 +3,7 @@ Creating file foo in root dir
 List root dir
 foo
 Creating snapshot of root dir
-Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 List root dir after snapshot
 foo
 snap
diff --git a/tests/btrfs/152.out b/tests/btrfs/152.out
index a95bb5797162..763d38cefe65 100644
--- a/tests/btrfs/152.out
+++ b/tests/btrfs/152.out
@@ -5,8 +5,8 @@ Create subvolume 'SCRATCH_MNT/recv1_1'
 Create subvolume 'SCRATCH_MNT/recv1_2'
 Create subvolume 'SCRATCH_MNT/recv2_1'
 Create subvolume 'SCRATCH_MNT/recv2_2'
-Create a readonly snapshot of 'SCRATCH_MNT/subvol1' in 'SCRATCH_MNT/subvol1/.snapshots/1'
-Create a readonly snapshot of 'SCRATCH_MNT/subvol2' in 'SCRATCH_MNT/subvol2/.snapshots/1'
+Create readonly snapshot of 'SCRATCH_MNT/subvol1' in 'SCRATCH_MNT/subvol1/.snapshots/1'
+Create readonly snapshot of 'SCRATCH_MNT/subvol2' in 'SCRATCH_MNT/subvol2/.snapshots/1'
 At subvol 1
 At subvol 1
 At subvol 1
diff --git a/tests/btrfs/168.out b/tests/btrfs/168.out
index 6cfce8cd666c..0eccbc3fc416 100644
--- a/tests/btrfs/168.out
+++ b/tests/btrfs/168.out
@@ -1,9 +1,9 @@
 QA output created by 168
 Create subvolume 'SCRATCH_MNT/sv1'
 At subvol SCRATCH_MNT/sv1
-Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1'
+Create readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1'
 At subvol SCRATCH_MNT/snap1
-Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2'
+Create readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2'
 At subvol SCRATCH_MNT/snap2
 At subvol sv1
 OK
diff --git a/tests/btrfs/202.out b/tests/btrfs/202.out
index 7f33d49f889c..6b80810e96ed 100644
--- a/tests/btrfs/202.out
+++ b/tests/btrfs/202.out
@@ -1,4 +1,4 @@
 QA output created by 202
 Create subvolume 'SCRATCH_MNT/a'
 Create subvolume 'SCRATCH_MNT/a/b'
-Create a snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
+Create snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
index 6e94447e87ac..06a75bff5ce1 100644
--- a/tests/btrfs/300.out
+++ b/tests/btrfs/300.out
@@ -1,7 +1,7 @@
 QA output created by 300
 Create subvolume './subvol'
 Create subvolume 'subvol/subsubvol'
-Create a snapshot of 'subvol' in './snapshot'
+Create snapshot of 'subvol' in './snapshot'
 drwxr-xr-x fsgqa fsgqa ./
 drwxr-xr-x fsgqa fsgqa ./subvol
 -rw-r--r-- fsgqa fsgqa ./subvol/1
diff --git a/tests/btrfs/302.out b/tests/btrfs/302.out
index 8770aefc99c8..c08f8c135538 100644
--- a/tests/btrfs/302.out
+++ b/tests/btrfs/302.out
@@ -1,4 +1,4 @@
 QA output created by 302
 Create subvolume 'SCRATCH_MNT/subvol'
-Create a readonly snapshot of 'SCRATCH_MNT/subvol' in 'SCRATCH_MNT/subvol/snap'
+Create readonly snapshot of 'SCRATCH_MNT/subvol' in 'SCRATCH_MNT/subvol/snap'
 OK
-- 
2.39.3


