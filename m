Return-Path: <linux-btrfs+bounces-3062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE0A874F6F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 13:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749831C21838
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBA685279;
	Thu,  7 Mar 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bKgQ25zT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tsjp+fj8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E992AD17;
	Thu,  7 Mar 2024 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815847; cv=fail; b=SvEmfwwD/EZgyILy51NWD260iBdftzPTQ6OrltqWG3nJuS+HEBpJLQs4jp7hf0EWssthrPMJbAoI4lf8CkqFF08lva52VdCuE72hzsFCNv9eK1/zGZda8piw64rLr6xHXl+iF+GUO/kSSdvBo7dalcqrC7+SU/jtNFV+jNIJFPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815847; c=relaxed/simple;
	bh=rxd7TxltLi2LBig8uKoLUHFGFOcyaYnKCxcuzl7SoiI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rczRMPj/BFlxPcS1fl8QMCaUSORj0qPrB2kPiPc9UrYpEDRDZ8/xCndzC/SRXWp7gkVAl+aOFiQWFrsSH29fcpZ5U2HkViYuP9nCxWqS06dnYwABXcd4KVvuq+P2Tipc4oXjCfFCfegi6EACoY3S0pxZJeHwzSz6K9MC/dzf9CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bKgQ25zT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tsjp+fj8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279n5gc019160;
	Thu, 7 Mar 2024 12:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=1IkL89LAaYF/V6RaBtMeS9o9S2rg0J+DHdi3Ng854+Q=;
 b=bKgQ25zT540X/3umJgLma77FdB1h0NSOipkAkEAlHL/EobrmyyoktBCxTvDopR66vH10
 Cl0T8SQORUmyFlgT5C94loVh+p8H9IZV+HKvCjxjyjnB59vetvsSuzVtWyFIsWXoGowI
 Xy1xqA3pRuUo6xL1GiofUt22UVrDkoefY4I0jEQHXnC8fPirAxQ+jrMNqTLItI8+Mml3
 CZZoCksBFMCrfkIgIF8ZIE9XZ03x8t1YOO0TMVWcNCftF2g9xlBuW129d3EuScPGNjoe
 KF9JEDGby2EUMy2sHmTIhrBLF/2/PPAtA+YmrewPtfMXcTFH+s3SXO5qSEHAjMpes0BV IA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dm1gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:50:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427CQmmX040804;
	Thu, 7 Mar 2024 12:50:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjgy3n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 12:50:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEJxU1tixY+Oz+zpSZLAsVN0CktaYcl0LUam6waxhqH8euprMSqnCgxjoRl/vcv4drBba09mQvm/Lvu3xwgowJuC4LbQrYaPGS16aQsUr9z+guBMpEVlhNRvRrltKhTjixoo/A3Hmo8pTExxM0lDYen5oEKGq4x7aWitKp6xgTeKHHMIKqkWViCTRj8ZDCnmZJjKYUmWnhPBcMRTCywCiQXR5C7YBXr5KHR0V8wSso7koGZvIOxXxg7MrZuy53RequmdK352DqeHrMaKOz7IB7KD70MFZCx1q/NpRzIlOzEmviF/O1+U37BWnGWyH10/zZCf/tdC+lE19hg+SH/dpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IkL89LAaYF/V6RaBtMeS9o9S2rg0J+DHdi3Ng854+Q=;
 b=PvNPa7DThwCbK/gfesIohe81K8aRo5Nu1dgFOWkniasZKADCAb+UIupPmvHqQViSLg0z5NaPwgFEZF3pZrRFK0Yz5v59Av+WEzak+k6nOrj45ZNLp8wV5Oyyl8Wpt35UNHAE2Bu1fSAz/yEVsakooMleRFF/46t2vnJTV1bkDokIJuP1IkfQsUcK5jbej2rWjPELS2YSxCtIK6sEqIEqAmDGCNskfxSpnbcpJkh6OwkmjqG+cEIuMOSnHHNCf4ZJ6obUhOkaQ6RpQtXyFBo82P1nuRNtzZwDmCa1zlb9+smsm8D/u5Mz/OgtMUF1AFRNbXpjod33JJHxBU/29t426Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IkL89LAaYF/V6RaBtMeS9o9S2rg0J+DHdi3Ng854+Q=;
 b=Tsjp+fj87L1ap9oxRCIrH//JBQCJokl0qWj9TJl/2sow87lSx1v6JxTPUyTB7l8BySMBYhRfD9Yy/Xr8JGcpMF7kFESFI9CDMC0ZvbtZM9q0jIxsYsrYUz2yZjSabGVv9LG9Hhb0bXmOYC+E74OS2nJZkL1FGk/y7AyndXXRIVc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7196.namprd10.prod.outlook.com (2603:10b6:930:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 12:50:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 12:50:42 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] fstests: test tempfsid with dm flakey device
Date: Thu,  7 Mar 2024 18:20:21 +0530
Message-ID: <cover.1709806259.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 578346c5-d46e-41ba-5c2e-08dc3ea53284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CTGXHR4Ra0iSW2dmJQGIMKwViZyP2ErFx6VxAlgYmHZHmqVM9KGOr/o95KeEPH2ugTeq7A3P2KPcTYJKJQW/0dWYKbkYs1RlyqLNQvJQnMfvGrL8fCqZWc91p68d1S83pbh45NsN7xQpmRSTwkkn0ZGQ5IkdQG6T6avD/5C+9B9cnRj2ZGlIzH2vDvMWWChsDzU7bnOYMkkwSvVY6zCzhTK8mEOYh/xZ3/lni99c6Q31I2KPiknwWmNd/56KjMoiGOOAj39hnkjZ8Xvu5/d/MMdGhF+JS8vZDy3d9xlHKppr1cZGs4oQ6t5viWrbgjZXN9cegIrfFIOnNynBP2plfXktuez40Rch0nvUcapSizO2Xvdnrws7cuzqp8mKVKxjfX5aUTkUI15x/F0rpcdl7jqVm+oncVw00WKEH3p1BurImFjlfqAuaQwd+Q5zgWI/fxQRsKop2sTIuNGIMprT3DhSzd9gb1814QPSohzzQvPgdNoR1qtQo6cBAyla/JgAigwcbZJvvMh8godpvOJCJoS8iOj7ltKv6C/MtsDQgjSyLFvfP6HyOWl3UGS2P9I6RR8Bapw/58ZhRpTNM4sCuPTpqs6y5fmZit64sUNOkuaUuOzTPRofDFet9xRHWwqpe4wBp0MEYraLT4nQzGx1sDSDEfKihGAFpOGde1kD/Po=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vFGyvmMJ7+nsKhQhkOe/tosFEhzlS5OSbUu1GFhSHvBo8DYDZllBrbcl7Gom?=
 =?us-ascii?Q?O0N1BtxbfmjOQN/fIrHXuN91YOweZIrpUhT8FhFrzVaVEPwjKhR8X3NMI8Rn?=
 =?us-ascii?Q?GASNY633rOzpsDpcokR48M4hO6m7vMqMl+KoBQLoCcjhXCc8mqYOMLo5Qtu1?=
 =?us-ascii?Q?QAJ6r1oGtQgDOESgwoQO0JzAU5E3e8CrfVjTYfpJJ/x0g/RuHMZlNYLnfg2t?=
 =?us-ascii?Q?dbg2L9oqPGRNhsmK4+ZWwIGtB/uHvqOwlWtLqObmy0MImhWeV4GLKW3zcXei?=
 =?us-ascii?Q?6jU/BjcXAMG+koq8giZ+OdLvqjY9LezBb8WdH5Wr8xvAUUQDxoi/SYeapHuT?=
 =?us-ascii?Q?wLrPWOlaB3n/jR131PkWNtpV9ePuo6lxW+gkincrMnN+UrN6UdOg5HotjCfn?=
 =?us-ascii?Q?2ZJrGYh06uN408InHSwBvyYVumVegIQrtT+ummx3XuTwXh10PriS/Ni7/gFC?=
 =?us-ascii?Q?3U54KpH+e9KqUcnf5uLbMbyUqdRHoqfTDKjWkXn2NOvSYyMugESWNsiMBwIB?=
 =?us-ascii?Q?M9uX077JiFYtpSQtC8qCBcbLVJFytGy83sOCdglZCHONBhZwKEy6KeGlrvTj?=
 =?us-ascii?Q?X6sWvsrX/xjW2mnVr/Tw4J2FcDiuxzaCiDHbVPIYODFLzyf68hvyXSWx9Rn+?=
 =?us-ascii?Q?fFD6FL+pC9XmZR5Mnb9OTOznENOL7NWNHQvxVY6Zso1voS3rQCN3aliOtTis?=
 =?us-ascii?Q?bCu0yuCJvoqqzbpffSaF+yeL9x5GbrzWg7P5ZbW6Hk7xZHGcT+rt6MpT7JeC?=
 =?us-ascii?Q?hDWMYISWl4ykyvsgyiScmRrmg2oP/fzrDz69s+bmUpBZaR44vzxrVTVCw0oG?=
 =?us-ascii?Q?fEu32fq+R7hFEQ3FJsD1640mPOlICx6RpzBhybgB0zrL8i+CxBUkPJTqK+an?=
 =?us-ascii?Q?RmOwCPZ+9fYB4r3keiaNh21EqB5t3Zgt8SfrR57qkUewg1FF1yr96CzGV0Gz?=
 =?us-ascii?Q?6JpKiOw0UIDn4cPt/838qHVnA2US2buHB8xcTFylpzFLK91mzVa0hscj2WoV?=
 =?us-ascii?Q?qFQo+QKobzCayWm40G/ohP67wbQk8WX5FA6uLABio3ZO1LUXZFgkV8ZLa1zV?=
 =?us-ascii?Q?pCY+id3sH9/2YKTZHFGsGaF/rdxYKUyIUyEmygN1jV/tinNTuDent/khe2hR?=
 =?us-ascii?Q?1k3fWXSuv8E3b+zMaJKsbpncnjImXFSIVlCCoWOLBUV2CHBrE1IR4SGsw+H4?=
 =?us-ascii?Q?qLUGY3dDQiPpeCTvXKD7QvS85UJjJrt+ZFaU01KG3Up2q8mnKiu6WCzQ9rMe?=
 =?us-ascii?Q?2pSAhg8tIpVhryI0cP28AGIjraELsYD4uhVgSJQm3lyruxaUSCGh0HcFiL/e?=
 =?us-ascii?Q?fE64cr+bPLQ0ejLClPFUr6yvGr+kVBQXsxelgbOoWST+nLm02DLLp2BwouMk?=
 =?us-ascii?Q?n1FPBRMxZYnloum+ojGOQPFrUTGxdKkfcWuLZCxdtlzyGtV9aJ9OurkWH/3A?=
 =?us-ascii?Q?PdoI0WeJUpYAWbrNOQs5u+CcPStd2b/KVjGfLDemYJDntaZoxKsamC12OEjq?=
 =?us-ascii?Q?nLaK7TV9PawRGW0lD8W8eABZlANdOofiPbeokyPygol3jA4NQU09RRCPbQWU?=
 =?us-ascii?Q?9mFaJ+YNedw7Jqh0Y5a7mXRUoi6ZliGucVjT+//W?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2k/jWNrlcS6xGpdvs88LYY3YO/W5mh8nKYyHyh2C/Lo2xQkU4Qc0b72vN/K21ft4sRVeaAqI/GTfzGPYUXeSbTaxttPQALudh+CgK2ITQ+ycojCFPqzVpk5QJeK8mtGeh0OD2XJPuplGIwtc+HFdtN/va+TudN2dfZptzCguJKhpVg8oKUtLNL9SqLvoTG7/3hxTpXYD4rSOC4XcNiR598mTUco9TGqRPQJAN2V1mHT/uB8ILEz0XthmC6uGp7Yq47z2gQOBwzPb9eAmJzw432TvqDu207j/iVdPkdSbx9PCQkLRx8DsNNC7ucGo0gbcPFEZs1c1mJra1BVZ65A950ayrHhOzkKcStpBQXtLy7PXsxhe9S74lZirS9qrVpID5b09NmE12ktuAtaf+a/mnuCta443tNdd+GSSVBQV18rlGtuREnhADE1rVYN4j/mvbg2x95s+Tsi8zGmKy14gXhhiGAoFrxwCxou9zEcBOifxcYqHUeSYkSN5XXamLphSvIikikMWTO1w13MsdwfRERv/h9XUc1r9ILttzmlDuZRQhcN2WRtfEj5GDIZGB0QV0wTeP+WwCk24bFC01PyzFvi78If/grAcgXAmU7mAZzQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578346c5-d46e-41ba-5c2e-08dc3ea53284
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 12:50:41.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAwNpcMQga+D8XtZZZv/luzfcIo6E6ISIBnIV5opuSkGJWRmRaFrwG0WejEaFB0uSIPIuwirtYyuOnO06pU7zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070087
X-Proofpoint-GUID: iqkj25cNPFLNBhBybRPF246R97JaHxfC
X-Proofpoint-ORIG-GUID: iqkj25cNPFLNBhBybRPF246R97JaHxfC

Add a testcase to verify the tempfsid behavior with the dm flakey device.
The first two patches are miscellaneous fixes not related to the testcase.

Anand Jain (3):
  .gitignore: add src/fcntl_lock_corner_tests
  common/rc: specify required device size
  btrfs: test mount fails on physical device with configured dm volume

 .gitignore          |  1 +
 common/rc           |  6 ++++--
 tests/btrfs/318     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/318.out |  3 +++
 4 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100755 tests/btrfs/318
 create mode 100644 tests/btrfs/318.out

-- 
2.39.3


