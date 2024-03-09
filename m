Return-Path: <linux-btrfs+bounces-3149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2837387717F
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 14:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19E8281C76
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 13:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F1140873;
	Sat,  9 Mar 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QOBRIPZQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qXtWy+MG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271BA36AF9
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Mar 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709991977; cv=fail; b=PhNIaEq8VKWwXNN3Gd+YBRfSQ61hb3gyTfBkBLjZ78p23/i/JxYvqMJfOTPK47+/gj60E3ctTcT/Fdcox7CR0adHQ6UpFEW3A454f9bpzyQVcxu484vuyWCsRmyzkLc17/dt/KfSk+++pXl6WxDtp2mGkenJ96RCgDRAYv1/yCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709991977; c=relaxed/simple;
	bh=g23mCWjwgHUm2cfg1X7GFAgXbfqkAe+vKHQkdZlslq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BHJwnwukT71l2c5myOGxLBBsrCnLrpcAsi27mvyJ5E5wGORaTc8+SPtFOn+R9SE1rTelV+CJr/z+Wd4ycf/uiyhxpzq/D11qABf3xRlD4CavsH2HolLGN1L3+fojmvsHrHvQCaWXSf+FFZriIsrBa+PspefRH7OLZhoaA/itVdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QOBRIPZQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qXtWy+MG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4299iIN2010471
	for <linux-btrfs@vger.kernel.org>; Sat, 9 Mar 2024 13:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=rO9U//7c1njA7jidYJYwXtmr9cuR4fSBYmprTgqW0PU=;
 b=QOBRIPZQG5D0FgysBhnJNniEgad9+6VHzD5S4NkGPuLrH5gKoMaw76My7E9xKTBSY3L/
 VzeLsLnHoHW4FbTTFw+n1drMbiv0fjl8/QGffqIYJXbZ5/gdIojyZpsbpY25fwk60ONM
 1CGZj+L4GarwOVaSYm93FjLM+ezjH5lncx9/FGIM8HdWJF2pF2g9BrASE9RutjYM7/vY
 m50XoU3iOWcLifQf/4p3Pn2lOjI3Q60ZSsy9upMCSQBcWZfsrNeTYQEUpbJY2GwSR4fZ
 iQzoQD5GJZOYfQEBMZse9Od0R+Qf8hGI4rUtTQ07yTGwqs7ASBjA747HfSLlwuOFZ2yo Qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrec28kfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Mar 2024 13:46:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 429ALhSP037380
	for <linux-btrfs@vger.kernel.org>; Sat, 9 Mar 2024 13:46:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7abfpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Mar 2024 13:46:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehERys43KN4/1JpwVLBoIQoIrraJgC9kMjic7GMyGXheJFbPoNEKBWTy7ZU9WGtHPMRciU1JWXeHOEaxVfLGbF4BCJthkG3QwHoeo5+KGv7lmPM+krzT0CRgEtQrtrf+A2YSjiYYF6jq4tcTMyxGB66RX2C/VTN/wqya6rX4hObbdbqW+iZDxbJdj6A1HB0gPmJOCo6eNtrKfdDdH357ddbvxTDe2+8rnDYG5Dsr/SNX/Bsz3VTKQ1TdsYl/GqIemaWc1+jA/VpqO7h2lqrj6g+Dfx21GMnQPv2sRZlhZC/Tx7Tk5aPvd4hTjykEXpMhJU/2O3aVNpEJR9THFlrGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rO9U//7c1njA7jidYJYwXtmr9cuR4fSBYmprTgqW0PU=;
 b=XQM3tW6a/EKRONhwiKhpBwxTYwGNn4ya04J96FAN3Sw5SThEa3iS53PS1HCRU96lnuvQ6kNJUoMxlnJULNDWGjonSPHDJfKZthz4yWMRxvPPo17U0mhM8qRUQtWSN/TLpSwHeHFkAh2mdUfMvdseX4dh3TstNzeORqT54uUd/O29qos43O1YwPNqTqlPx5RycE04dVBsESQl6EKiQ7MJufJbBRdK3ZqGYHfnAtJVjCYKQy3GLFamOAI3bUhoWbGq4XtO0abdW1D+sDFtaZXTtZga+GGeUbZXjT6x55lTOYcmOaIet58DeBqxTBN4ER77UHSdm9fj0vrc7L9rfRHvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO9U//7c1njA7jidYJYwXtmr9cuR4fSBYmprTgqW0PU=;
 b=qXtWy+MGWSZpShE9Iwf61QM027NdO67XnZ68utWlRJYLfAd3sYde7p9BGTTS45NEibeFABOpNegfxrHaJSoiKnNLh9nKFvmaMDYhSPvFRvKRmMNBQ1OsyGalSYNbTQDOGL+C2Skl8/3moEjHn4aqk475KvIWPxI/4kq01Da293o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7509.namprd10.prod.outlook.com (2603:10b6:8:162::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 13:46:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 13:46:12 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 4/4] btrfs: validate device_list at scan for stray free
Date: Sat,  9 Mar 2024 19:14:31 +0530
Message-ID: <87d75575e16637a84b82326d5c53cb78cdf9a7e0.1709991203.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709991203.git.anand.jain@oracle.com>
References: <cover.1709991203.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c48661-dd3e-4206-c734-08dc403f4874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lDd/RxMyPu+564TvVyHZfERTBs0AlaDkMwlTYYeygexS0gOjm/UNaBBnrCZgZlPllXXe+FXiQHlZUhUwbHY0vKMzM061VKVmLUTAck3OiQ1zIE6aSDcVa4B/7AsQW5lRkCGu93Xsb3oQ0t66FGj/Vng15ktfY1THSI2NJYq0BszEMGKSjXBb9ItOIDJApaV7GKot4mmiehAReZtK4knI3p4G3ulrZLEpWHVavReJ3nYC4KEepVI0Z/tUQEp3fhiftaJnfVpW871TGeW5ujW9AinDrcK6kdCU2cO03fUFnZeYUsGNRXHaogbLB9eGg+dm3t50wriU9LESUxhh6xVx38b+XJmh84jjxYbhEJvP3ga4BuJq4tkVGAKvZukcgF3+cH+7VeyrVd7DzmfSesr+LKYbzTaABpmL96LTks+b1HZkeMYBhjhDQArXcHJz1qUAROYtNX1pCtnVpDV3CaYcJ0+xmU6C+CseDzwBcXg1WCk92+m+aiuRxMFbFU4oy0TyTkr85ScW7vGPT5zPEChKXJ1xJ+TFZB5q1vWIxynhAbKUoon9VXTOWkyx608Wvyk/7n+QecmqGjvmuRx9hBEQWBAoxXUfS1HveH5TYj5QRb2WbAQ8q6PSGpWHzfLb5BeBw16xaD8CIDwhsIrhUt9L4TV5P5RYyJ5y2Hv4SWrebWE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qE/mus1AZRYFM8f4yNe1kgnfFTHIdM2wpfU3pxtnHXXqf0AyZMqH66zLwrZF?=
 =?us-ascii?Q?M4UbkVuGKA7oppQam3SZVzfmTsOEA3dDdFMvvkOjSK+xv0hhDbp35Q9RFNlc?=
 =?us-ascii?Q?LwFWql1acN54oRHKK5M4RfYzs6rfPEGal51G1cVF9UIfQoZ+jrmJSVHN/qNT?=
 =?us-ascii?Q?Lf4uXU/o+MZpIK7VioulIqxE2w//kckkggbNYwiFRcrCp1CI9Xru0d5V70Nf?=
 =?us-ascii?Q?BnNR0dCfOgUIi/q1m7Z1ugX4LsI7S7gsWKVmw7BVqAy4g20hPbDOkUimSisP?=
 =?us-ascii?Q?59HcWshNoJvtWk89ZVzesy+Vdsri7gomeynyzOA173r44PMKvcpjO/nPTMX/?=
 =?us-ascii?Q?1DSJZfGkvo6CoIbV8mXfpAopsafc3j55oN2a89rVWEm/MqlH2kH2j9xEg217?=
 =?us-ascii?Q?jbgyEMQYCwhoF/n0MiIy4rSfXJqqQ9JdWxH0T7vf+Q8XnzAo0KznNSAzQvns?=
 =?us-ascii?Q?uq24J7I9ySBVqDGCNwq5yfmpa2SmcPkxVVNfJPNlbs2HYxLWz2cLTzwHswqc?=
 =?us-ascii?Q?feCmer3WKccD+F1nW4mJTYet4kipW5VnnWv7NTZ4owg2le88VyGxxIO79KNp?=
 =?us-ascii?Q?uDzC/R/e3wngWTZR40BRvWB/FOwUK/oqI8X5B3ONY5OPGDGWeMkrLUTOwkyO?=
 =?us-ascii?Q?lqD3/+LOGgdUS+KzO1DqPdujjrIGoLbn+lygD7gOZv0e9/Rokl5zyj0BudoX?=
 =?us-ascii?Q?nsJYjMhz7EbDiPo94RORdw/Mn8AOo0CY9KsWDXbosKurIs34lrfCrLv9PErc?=
 =?us-ascii?Q?XUoy5oc7bIsJy8H7PH2oj6peqNrD7Y9IGSXrLmbQ62QXxm4RHjHdHYNgryL6?=
 =?us-ascii?Q?SE2X3bGicfxaoTc8ma6lrhxoAjElULdR2C98Axl9kVMdc7XaNiv/nsgaSYVI?=
 =?us-ascii?Q?aXBNfOZrDhcCK0sKUUbCpl82uwBgV/8wO/B4zi0QZWKovM7YTeOnZtu2TSQK?=
 =?us-ascii?Q?n2dPx6H7kAs4KYtgcRAbNEJSLIL4n+GwtNk15aKrSl3bzBfpflXxpYyDEWMU?=
 =?us-ascii?Q?RoH/qXh5tK0UTrQg9td7/amsg6lDZTXFiJhTySKZ4UHONdt9t5Us0MRlHDKr?=
 =?us-ascii?Q?O4P1hsebgp3qgc7SV/aMlPZEy3HxiCqG157G4dqQxfhhklO2dyobHo7hipjN?=
 =?us-ascii?Q?S13RUgUGZZYsJFMZ+9yLn78A1BaUKV3CdhJwFi0GmmNJdbP9Cd2wK0AX5urX?=
 =?us-ascii?Q?h5fsSX5UT4bXz4Jq7Pia9QRyhb5M58jIYRfVsDbE9eTizhaA3GQb0PpcTkeN?=
 =?us-ascii?Q?ZnH79UX7kgDLSX9E/eB76IL/gJbMqjJahciNOz34yEzVxJzciKMCC7JTyFxr?=
 =?us-ascii?Q?J2Bkpt8bbyZx0WsPlKT4PoK9VEBoebOiPR3bCJBfSOYvFsbPgTNlhBODHgsX?=
 =?us-ascii?Q?OPupI3Kb/cPGzRGpxjpSBXZuTiCXn7/BbwYuLIZArY1k/Uq9p1P/lFWebycO?=
 =?us-ascii?Q?Qc1fWH0o/bSRTMF15UAbsjYcePwzVcvml9TLNn5tHKhi6kj/JI+Jowrz2IA0?=
 =?us-ascii?Q?wr66W1HU7WwpU4N+lX10dTGyunSZZOV1Eu72hmxg5WaUkpYnbuj7nqK7ReAP?=
 =?us-ascii?Q?/QfUH6b4xG0Rt4txqFopOwbiizy8ZvvO2WexgsSCm6Kac99T9bGYUOfZTDTI?=
 =?us-ascii?Q?NDkmY/lcRwt2cK1hJsqGFCXFhlLyK8l1HMTD6VOMZu2wfJ8LiVQqha2REJ+0?=
 =?us-ascii?Q?y5foWQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QkTOduuDJoqc1MTeMrbza0uHAdecBO9zBXS89x6PV9sJEBOLMf97Tg3gHq5GIFWbT+RE9zUBtoOv5ZKfFzwaqTUH4u1kgb8me/iZmtGHR0MHJEZ5l2z8HGPRcs89QZijTX892B0uUjKym7Ym46VKbghTBQBmEYu8Q6IuGS+MskUUQzEhZ+ZAQUeigQeM1MmBJUDkn4Oq+NCPp9FGdx3p5OkIkWk0nOyEYpYWrRUL5nn6ouU5m/UAZhFznY0Y4KEcDy/TRuWymJ2KMQWERW/nOQpbIQXikoD1bDRu2uvxWEO8QrIxTda4n43VQhihxzYiZtwxwROOI58POWIM22YOrC2soZ5JK8jAQNjZCKukCysYPZSlU3f5Xh6Sjkob3Bd8UdCHEWj+IxMRso8RDXOWAKskCp3u7VRzKgXonx6b2XyBvEopdI6MQvwbZFPXHPm0KycQHjHrjoM1OzOqAZh+4kqVXz/Wc/QF6YZjvYEL6RbXzPmGIJlHcUH0zneSdTNznbVny5sK+CThu3Am5BYqqiLeAbap2TJ/ZekPerTmgIuOjgIbMkL3bYH57Ctj+EGFhp2cLfO4xm8Qhp7t/nShECLbQvtC4XBhVSRw9Z6UGAI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c48661-dd3e-4206-c734-08dc403f4874
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 13:46:12.3306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBWgxjVgcSt8EFBJ2piDT1C7EWgAFNqyiqoZaPx5FBDy6XzHJ/56c3m56XsU6IFgsAhlXXMhjeX5tPdLyrkRbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403090112
X-Proofpoint-ORIG-GUID: unx2zO8OJ0Ck_FXeWt5REectN4ss4gqq
X-Proofpoint-GUID: unx2zO8OJ0Ck_FXeWt5REectN4ss4gqq

Tempfsid assumes all registered single devices in the fs_devicies list are
to be mounted; otherwise, they won't be in the btrfs_device list.

We recently fixed a related bug caused by leaving failed-open device in
the list. This triggered tempfsid activation upon subsequent mounts of the
same fsid wrongly.

To prevent this, scan the entire device list at mount for any stray
device and free them in btrfs_scan_one_device().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 60d848392cd0..bb0857cfbef2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1382,6 +1382,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 
 	lockdep_assert_held(&uuid_mutex);
 
+	btrfs_free_stale_devices(0, NULL, true);
+
 	/*
 	 * we would like to check all the supers, but that would make
 	 * a btrfs mount succeed after a mkfs from a different FS.
-- 
2.38.1


