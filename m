Return-Path: <linux-btrfs+bounces-3282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C2687BB6F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 11:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DB81C20F60
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6B960ED0;
	Thu, 14 Mar 2024 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dc965EQv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IAq77f6J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76021A38FC;
	Thu, 14 Mar 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412705; cv=fail; b=eG6xfOWP4LPmoFkAzx6LW9o0F4cFQN2ct07P6CJ8OpkeFXqK5Kym3fwCfBPQXiiOEpAF6nTfS7RE3m3upjsQTL2g4YSuJyN29Ty5lD6qy/OIizMRByvizbN6ArPQCRK5EDtTm/1HB0IS2KGv/MB3W1ESBGuCN5sa6zzu/w7oBfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412705; c=relaxed/simple;
	bh=4vNhCfDFv+S67Zshu9WBQjRuGmQF7QLtr0CmFiuuqtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sBvrO54y9lP3bl6ccvn7USoCntaLfS1drvNC2XPL7jPZJzto1yD5VLy9HJVN5MsrHOb4YcAShSHaLZejpD4QKbfX/W19ISnVMIwYUpcr8jxZPt1292lfeRnefJZHpgyGeUFE+PMnD/UoXPBul2g4lN/i3byNDeecLRY8+R2DwkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dc965EQv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IAq77f6J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42E7nLa7014529;
	Thu, 14 Mar 2024 10:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=zkulvl4/QE6BVOyWlD31CD5mEzYDfMKs89ve0q8OW6o=;
 b=dc965EQvzTPKUUKsP4XqeCAF0kvk6HXMfDbm+y4rooIM8Dx7p8JZDwZ/JrH4++h7RL65
 LFZi9oNjVGu8Kmq7ip1WSod34/O+rlVZbzSPrO+lAxXEfydd36Tz2VD9TBsenAaQEdbA
 2ne5SldZvsSZvvlIvQufvFoN4rASug4RPcR86vZiGPXSZysOQhBPxRKL3iDHQZAsjV+z
 x/ScYr5mZyTXf9Ke33Ren2H/KfiVnZDumRIQSN3hCo0+SNq3XYcqDFYFjq4GfFrVQ5Wj
 os8JtLQ3+ZATpFSzGMhXD25b1hsOnzSqiupp9tCKp+6dTRSHPciTavi3mU7TP4uANUnb Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfnbtxg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 10:38:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42E9BvBM004760;
	Thu, 14 Mar 2024 10:38:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7aha0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 10:38:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSal2jKTPb1YquGozFw6jSQGnykn4c8WdeDhdjCfdAYdIY049avEE6T9Zzi+nXzMf5RS4g9ix+lrqUf7t4PSkiTs+Zdvgi7bsfHXMczZa4iJHPsQsKshZjitvQYpIK8SjeATeUuXFk7qz+872vjTkjFrJIIT1xyEfxaojcT+frKkQ1WK8hHUzNnddEUM5TUDmeAxYPkxkG3FdQLpVCa01pFa2+x0KUDs/3yHs6tj/cGEND1EXTS7DJDwISh+N/CHfOJPG19dB9SINgpdh1eOUL8kHnzlnBH0rhoq0YVabfqtzCa1H4Yz134sHmegMnLhP90zm+jwRyPZ/dK4EppDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkulvl4/QE6BVOyWlD31CD5mEzYDfMKs89ve0q8OW6o=;
 b=jgtQYsRanJDKcEmc7+p+mx40QLDx+vLdRLqBZzMVwHwzDeU8QYW03XE+XvB8u3aiDPMm1LhSX3K4lUNFMi17QJ4TjeN6DzDdQUmoVbC6Pf3yfgZHLlCinyZAQcoa01idZZG8Tq7HOwwuBfh9iajqYRxHFC0nlOyt2eeqS7Wkeh+FN58+BPsLKnb5L9J4ID1D1A0As+AXXgzSFa0unh1CzbN0mMN8VqfdBZKuHff2XpWnvdZOslWq0bCYYr6svMRu12XgeJdenTg2oTKLEXygrQNZjIXqjy1rnGHFN0LAZiv1d/WyYru5fsYY5SQpRL9FRyY7koOAHXtFDd00+goAqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkulvl4/QE6BVOyWlD31CD5mEzYDfMKs89ve0q8OW6o=;
 b=IAq77f6JcsmS8+htpJiFAafHm39mGbnz99jbuj2zz32gg39CSTWL3hRQN3OvGEq2Vlk6hs8EdUiOJSox32C+dN9iXVvOlLq08t+ZOvtp288ujlOahAUapiFZ92qjYhR24h/Gy33CmGJxzmEZHfu8nboEcs+d6bVuMZBY/IQ4wck=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6617.namprd10.prod.outlook.com (2603:10b6:806:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 10:38:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 10:38:18 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, boris@bur.io
Subject: [PATCH v2 2/4] btrfs/320: skip -O squota runs
Date: Thu, 14 Mar 2024 16:07:38 +0530
Message-ID: <9fac4d3f4fc7a2fc0ee31344440d3350a7d7ac12.1710411934.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710411934.git.anand.jain@oracle.com>
References: <cover.1710411934.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: dd80c1ed-6ca0-417b-08f8-08dc4412dcb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Dp/A3P5BF9d74NjQp5AyCCXlvr+/8kPEsPvD6oDE3kBm4vp1C9/U53sMiTxtBBTBUENeVzJQgIftNnU2bt5q5Na7ITs+FMEumSssjcL7KIxOXrxC31QSMTGLMbq2WekBAy2sePQgSARM4q97ENT1mqQGouR0RJ8s4JjVDhgCjQisRbv82I5H4SO0IKbcUTx0oABHPzO1Q7PJDxq1QiEzQt1raReepjXZWmDE+sn04cpA2fskwKPbiGVj74+HOf4Cf54oNE0F+T1IQj25SlST1Squ28AHYISvHumAkbn948SfmcuMTksuqHbMBrfMRvGbXwVf0DB9m00m1WNO7soY/rjupcIbVXgd32DzQAeJrwKDfMqTbH3xUnknWPvkfC3Yea6Bjqq3007Odn0BW3BuoQxPevuWU+XwD7UWZyyrRcrRGo9mGQ7BfpDnRAvZNxACXZ1X55FMggIOkoyCzZzAFJxzpQPsWW3O7wtDz956XrNYnO2OP4Z6vyGP2x2SALgdGa9CU4Ddvk8FJc5qju1Es5ZCmt8/YSD3N8Niok4l2VJDXcTNZe39nXuoWAPy5hGoOZQfLALC4fbV2yX4rF0CWMZDgM+GbyFChMMTP/MfpnRqbSq2e/Up/tC3ZBkiupoM6cJHPnrdAHAMIAuu5Xve5zGy/gcCmy7z6/3Wciez7qE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ClObD5q37Nviopa/iarggtf1yRpO62HMsX+daeQRzoaLm37SoCB1qR74O91W?=
 =?us-ascii?Q?0XPKOBtzZelnBpBJhaUfdo/wB/+bVIV7E6AXy0+5VrEGIkjvALle7ACn/aAk?=
 =?us-ascii?Q?04jNePJ6DTQDawlRC4mqZSuHxfJzqwa2r7TvI6/v/pq2ZrVZgvw+ySUAOv8N?=
 =?us-ascii?Q?6XBhaKD+qLs7fd+De/yJnwK7MwQs73++bfHnVWEqPVLuaUd18X7J9ILLGask?=
 =?us-ascii?Q?JKkMBxPe8UFcxhg2/PBHbcQQpxMae2bmEa4ji1ouh25Uq8/begwOgayT4KdK?=
 =?us-ascii?Q?TvrswdJxEqx1E7vQVLlQvKSlZUfeFiNigdtGPRVnvNZa6K6TOkmdKFG6rUC2?=
 =?us-ascii?Q?OJugT6HiR2jybtseO8NeCDKA6+OFQyky9sQWjN7Rjo2tDLcvt981dseCCJak?=
 =?us-ascii?Q?inQKma1spQZAwM5IiQbCxR0VxYzFw/D3owmRYGHRaVPipKF3HeiXv/+3ggPd?=
 =?us-ascii?Q?pBLHB5A+Rj+rl/sThEHw2VZGinUpbhyWhw22abOKBVQes1tHnkx0eHiBkkjK?=
 =?us-ascii?Q?Bs7H2SuseoV3B+UH3IlXsH+s6KcBg1KcrM3ezv39TVhtaYz43ivFS/C+shdY?=
 =?us-ascii?Q?gneDujMhYUhXDkXhAFt5iX1TIEayYZxtUP+/Pz4iXX8fp8Er+BkvwnYyIFwU?=
 =?us-ascii?Q?Yb/tLC93AWyOe3DkPlEXgAMzRvb/JF90TJytWMq42ca/bd9TjpktjeDTuHDd?=
 =?us-ascii?Q?joogO9cUSTNa7IMh3bRET/dqtHy8pEJyJb9aZMffNdn9HGqYf0U+rXUNI5Zq?=
 =?us-ascii?Q?aeGpnZdUxxFhppmsr/topLn9DZXkkUMU+I0SP/Gud4wHJh4Jxo32dLR9gyLn?=
 =?us-ascii?Q?dK7WO2bKYn0ofqWa/3jkCPQxYcWzCj8w37VQgI9yHzkogsb2GUq80YO6Pdjo?=
 =?us-ascii?Q?Ol0JjMv87lPJmmCHMwOZ0aOxwzgIzqKGEY7SrZVMJCrTfIXploRmQv/SLgXg?=
 =?us-ascii?Q?Df33skhfZtxoPyUNxKu6JfB42t5vLaDI1j+IVUrdW2Its1PqyS1s3+ghWGnl?=
 =?us-ascii?Q?hHSV9Ai3ZkkYg/FvD2f3CnI3jzMOcxnOVV1yI4VXuzmJ29G2tdjr0sR5flgl?=
 =?us-ascii?Q?fQQ6o3s4TApi9zPi+GPeJ0sNUKRiL27WCgW64iBYR85yJyEe2vTDAsUtMLgA?=
 =?us-ascii?Q?vpnWj8/8Fwm4+PiRHThNys9HR/kJNYui6E1GQ2UGvr5c/FoqetUQgduPgrDn?=
 =?us-ascii?Q?XNXBvlOZoxCWCKIBBV9OBFTzmgQhpxQ4gEPXKTn9dK84xXUIff1TMn+7Soia?=
 =?us-ascii?Q?zSBwmjlt4q9ILDArtHuP+bdmgKAr8jh0ghhPSQ1slXHn/mKBjiby0dNRXv4T?=
 =?us-ascii?Q?n1uwmuzjz5cUutOJUQj+WnMcyOtxbuwddbFSrwDBrPL3nciW+SSInHMJooql?=
 =?us-ascii?Q?jm83aI+K/8PMJkYgokzN5bR2yCDI4WJwoQftp6R8sFptCVAcP/r5G5TWPdak?=
 =?us-ascii?Q?IdZz7Se3RyTMJRImQXu9H/LBFWB6sjs0baB0ividhn4crvNtaVU3fKVfvryv?=
 =?us-ascii?Q?PUzVR5pBBLLvGJ2aQJIK7kOSHRy34occdbBiHtPgOGVJDI3ZSMVm7iBZeo/p?=
 =?us-ascii?Q?Oh8wNjgIpT/asJl2FOW04IhwrLsOolyod0W0Fu99?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GjTVS7jMRAi5z1ye6u0ntVU4DxJ8d5DWqTNx3km/gRhEPRfwxGikfmtUPbQ2j+3m63/JEzz6SBOuV2zur9JSPWlmahZxriFCitAXdyAUsC0eoo48XQ/5Lt7vXMtVNSE2zRSMA9vWo/J+3Ipk6psa7TdAKzRJKWbciXBj4fXHpOkS6SFfD8ixoo3ZwWehz9wGIm22zQST1y70fMlIfprwYrJR33PHgUKksgRaXbL3AV/3O2q8hlQ8TuoEpyGutBJoWQa5aszKaQo7Egzaofvd04f/WoNmDMukYlv//4bCwzqEhn+yorOIjyoMYfSeYFtmxxI9sTUtq+xfgkv+EPoarnk20Znh+dlNf2CFy438mRnHr/uzplEMjzDzlyDp8HBbX4cdeI/OtCHsIu5+Q2iKyvTSLYjVphAaER8cos9xSePKsZ30i0ZvaqkjoCfkGS0QiUTMBJNg2KwkiLmL2Gdq27elDbHQ3dG4nU+2kt3eHDUFYGWasPbBL44iw8ZMnZdjU23h9qBP/x+eMGX2Xf4ZnXlgAqduyt0tE2ehDh12mh+R0uQ8b9S0eKTGIng41t6tPaCYr0T6FNmT1Doq/E/7cNKZITxuFKMEb6AGFztIumE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd80c1ed-6ca0-417b-08f8-08dc4412dcb2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 10:38:18.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/SqBMW4ACpQ09j+yQZY0IOyeeDSmtkgHJSbbkYNhb0k654ZTtJ6x7QyaIm6elOLQ/a+JkobCj9jo4a/7RTC4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_08,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140075
X-Proofpoint-GUID: RL1cpxermSfkEW5dn4iFp7xUsI_HU-bW
X-Proofpoint-ORIG-GUID: RL1cpxermSfkEW5dn4iFp7xUsI_HU-bW

From: Boris Burkov <boris@bur.io>

This test makes assumptions about the shared usage under snapshots which
are not valid when using squotas. Skip squotas for this test.

Also, make it use the rescan wrapper, just for uniformity and since it
doesn't hurt.

Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
[ added _require_qgroup_rescan ]
---
 tests/btrfs/320 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/320 b/tests/btrfs/320
index 408053457aba..df7acdbb3deb 100755
--- a/tests/btrfs/320
+++ b/tests/btrfs/320
@@ -15,7 +15,9 @@ _begin_fstest auto qgroup limit
 
 _supported_fs btrfs
 _require_scratch
+_require_qgroup_rescan
 _require_btrfs_qgroup_report
+_require_scratch_qgroup
 
 # Test to make sure we can actually turn it on and it makes sense
 _basic_test()
@@ -23,7 +25,7 @@ _basic_test()
 	echo "=== basic test ===" >> $seqres.full
 	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
 	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
-	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+	_qgroup_rescan $SCRATCH_MNT
 	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
 	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid >> \
 		$seqres.full 2>&1
@@ -62,7 +64,7 @@ _rescan_test()
 	echo "qgroup values before rescan: $output" >> $seqres.full
 	refer=$(echo $output | $AWK_PROG '{ print $2 }')
 	excl=$(echo $output | $AWK_PROG '{ print $3 }')
-	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+	_qgroup_rescan $SCRATCH_MNT
 	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
 	echo "qgroup values after rescan: $output" >> $seqres.full
 	[ $refer -eq $(echo $output | $AWK_PROG '{ print $2 }') ] || \
-- 
2.39.3


