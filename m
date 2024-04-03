Return-Path: <linux-btrfs+bounces-3852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DF3896653
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 09:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F8E287E98
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 07:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016885B200;
	Wed,  3 Apr 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HUC6R3g7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mBI/nEnk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504254909;
	Wed,  3 Apr 2024 07:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129076; cv=fail; b=Cv/Cla8UsKgtl8xDFnsW4PGMwpKI3RO4IIPS68+z/d0t/J3AauSM4RIj71PVTgXyCIr3IP2JT+e8LJAUtLaEjyGTaF2opqJWOL3TgNRbGvdvHorH9uJeUMD7yQkYkrtgtCNRk7Ca7XfhFGzpJLCQyBvPIHmpu5YICFanOUJsz5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129076; c=relaxed/simple;
	bh=FJMlmydTkJP6g8HJl0xs/phZG7M2fYhdzpJDNW7ceHU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AnOF4yzfFi30GrLIRXmTC9xE2h7PuroaDeCaYC2zMhA6DEM3Fsao6CzZLCmbxE5KfJi5um28MygJZJOUpBTOIH8qPbYd+3EzQwDE1QbjI+0BsBZI142jGcFhqyiZkltlzZpQ3tbJ5v3WnM7NjuFWSMckWrG4Sv4TMA+ZAbyvnoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HUC6R3g7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mBI/nEnk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4334nliE027253;
	Wed, 3 Apr 2024 07:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=CI3hq3y8UxcXvwEXsIUYAmRqS8q4dhmNbkLxb68/42Y=;
 b=HUC6R3g7RozMTy+F0/U95cU4q1PCQZuuiGFHC/Ihv5apMJ7/PpmT1HXNj4ZpmnWY46O3
 bvqjuN7g4HVQ/aa6PoI8zFGW8I4kOGjrbkYecxZ2caAZmpL1T9CVUj42HvQZCMhBeqVB
 PpAp5pAR+y4Da1GM+s7XKUs32ul00F77UX2nPYsM0vZ5XwD8slvNWoRnJUZb/MwnWp8Y
 OjmJov+hy3TsqdlnyIAtROPJ/++p5Q0OrUxhPZ7FBgx6hVAmRpMIXi7TD9f7NnixuZIc
 dKMUBwJ8lOWOwMIQ9Hu62Q5DdSPAn4ktmSz0cPKuAoNF92MwgIGjv1+F/2QnWhbvILYv Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x7tb9vg27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 07:24:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43372ilR008334;
	Wed, 3 Apr 2024 07:24:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696eer4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 07:24:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHTE+HIQY5AOhwuFKf2TFk5jLk3HqRtdsDrWOLISihWRnZREVt9A+4vb8wt+0LUP1jYsvR9UAMD6ZyfBsjjbeeP7BYYM8QSAbLTdmJ9oztbIKb88qQu5QRejG5kylzhaoSYH/91BkExFpJZtfYtzaxPO1OF65UfUsIHCCSFO2DdZKtq9zQfJmxYccX4eCtgpsb/FQ6G3fpdz63fvaqHYAo4doGM2GYN9zrjV0D5DN+X5h4HVrTiyEAqkNRpm6fUCahSvPdDenBlxWzWSbgHAh8gqeUA9CnHVw1Nzsyrq9c9/HjQCfKQiXQvK3kT6VAy2zuro5XOuWavaKBu+tLVuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CI3hq3y8UxcXvwEXsIUYAmRqS8q4dhmNbkLxb68/42Y=;
 b=mlSfhkk/hv1Smd4uSBjNwoohX95m0NVHQZBdmFR1psZxUs45WlGY2d6cO8Qizm3cEeYjyKGFvyY1NtnL45cUWvJJoDgp01Bc5Yq85ZBATxL249trY22RJpNOm/CtCKYRUdv2GSp3sHc/nph4TJ3CUqBN8Q745ZpvoT/nKfKLBUUCqIaR2wRyFD8ZGJbC0sSPVicFT1nHoYw5sTPExnuA6Gq7S1taIrCpKnGUeaar/Q1Sy6OZMyeyFKuJ9fOxsJ7fy7aK8dprLIQJcFPLg6ord8SZRbOQD/0VLURmfZtDCFdbXlKp+uCYSCm+S8LCNt+bm4SniSJTQCKGq/koqtD3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI3hq3y8UxcXvwEXsIUYAmRqS8q4dhmNbkLxb68/42Y=;
 b=mBI/nEnkAXT6IDgNXygJIVTWVQK6RMEwPwnoC+g21d6rFhz75hBVeBhMpzH0BLvEn2sbyRB8TyD4XnPTyQFdgpO/lGcrdZKnue01I/2K1C8Rho4Jm7IFaOO4nnsvdAifI4f++OBBesNsd4CG6fqIb7IDaI2RChbMppIh2f3vs1c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7324.namprd10.prod.outlook.com (2603:10b6:8:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 07:24:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 07:24:30 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [GIT PULL] fstests: btrfs changes for for-next v2024.04.03
Date: Wed,  3 Apr 2024 15:24:14 +0800
Message-ID: <20240403072417.7034-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7324:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LOstHPXH93U+gN4wYKXB3kRPTJqT9TUNpS9HQ5AmP4bdwNkHc8GIvTC3JDTwFuq+Argctsag7y9vGcLM5zgKAxnP1+fc3XTrD7/zYGNaOdv8JNZh6rsCOLTmljteZJ2n9B+C0JYGy94HCeJxanF+6yTTcEUgA4zz5TDqOd9MZLsTBVuUR0GC+5lefwEhe/lqbKK8FhIPJgdaQyOse/th0WqTu2bB/5rbo7E3iuNpg1CrJiFR+UDHePol4ygA7jTSUDDaZ8LNm0cBJEdqbRZ1vD2umYOYIuihHQfSvL+bhYw7cXfeYfH3ay+CHtD3cUWgCxZIeaZy94b5SJCu/3wOpB4I0viENbV5sJedtjWmN2BfU1rQMlczmtmHbr5AlrkyEDChL3KAuTVlwswPaWMOplMKKaZljDsY0IPxV5hkGS4k/3aL99cpTh6GdlecO7DobjaadXnkTvWgXD2AyN4+RfmA0G6ScazjEt3jR3OsPD47glHn+LYFK8sVspLl5MSbiVl/Kjpjn/URWJVOn4gs0CplQB+R7d9uACCYIrnJtyd47LTbOVUijrZkxNgDEE3sW1J0Z5LTcTCPM2md3N5KXGt8lUAl92j6N3/xE73aiqw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gPER7a+hZot7a6OH0RL7f383bt4NosvBFeqsvxdZBV19y+HaKswqbPAHPbKo?=
 =?us-ascii?Q?tB0LRAsv0AwJL+5bOvhdB/YkY4IIMpkvnVrsc1Vzmh5yp/7ZdAnCIz13tzN4?=
 =?us-ascii?Q?s3CXCdtCeHCetsBKWcWtcJjSDYLRzEvsmjX3ruOJ4CzXi2C1jX2YoFrfzMiP?=
 =?us-ascii?Q?P0tWdLtqblHGl1x45Y4x5hdpqIq0SGSwOJcQSmQEbPn1UFrd2QGEUO+gSLKZ?=
 =?us-ascii?Q?2saQg2cBFS6hAYgJQ23FjYEMOZr7FvdxQ6JLFjMifZRfSLz0UakvJZLj+QfL?=
 =?us-ascii?Q?iDtLEHjONjrmZRd++e0n4OMT1Y4m8PxtJ/PTWmH5KRWb9gywlqI6kkbTKTat?=
 =?us-ascii?Q?tFoiQXtgdChz3TodDMgpwdRrhk+Cli3/JAI7RDeP2FBrALpQZBpXznFv2YoG?=
 =?us-ascii?Q?9PXlbyMBp7MLlRpho0uj/ZvWjbVeGY7rwuV11Uac2iOHIgXAMHvgNFqcg1Yx?=
 =?us-ascii?Q?7rrphzNNLTaE+yq5PCcyc4yTlvWS+FEaXUQNfLPpOHQtWIxf17TSDedaov9m?=
 =?us-ascii?Q?xet+gmTiCw82T10nuj/cZEqouBgGGPMtWL2QBgmePtHzl9CivlavuH7t70do?=
 =?us-ascii?Q?6kuWtLTkC0TC0wlJPFEUlA+D9E6nHbOqfSj3SFz9fBu8E3AQ8lqkCvu6mZzu?=
 =?us-ascii?Q?b0MmGCWwN55vjZaPLQgSc0yohTy0kaZhlbV4Zlyqqflhkcb8BBaxVaxiMbDD?=
 =?us-ascii?Q?isns+iDgwLakxEQ/Bb8jEbNiBaSqrR0luQgoFevSNAJHjGDlkrGcsUZFll4F?=
 =?us-ascii?Q?Jgw78Rf0j/MPfJSkk5lFWAiiepUkrIBnSNtZOtehO+JUWVKAHS86w4zMawue?=
 =?us-ascii?Q?9w0N1MWiKWXwHvz/5b2Hisr/bLlLAm4ZujLjtzrw8Mnmc95WcPNISv5JFUZE?=
 =?us-ascii?Q?Utly/hwnXGECRgB3PJSRd/VM1x+aUmqjjKuXMrEs2GtRIMEwVhpxhRx0lEKk?=
 =?us-ascii?Q?LXpl/htE1DriNOO9OmmGyI7g7N3CF9ZfheUbSdcSTSRQAkmRTDJNef3Y8aZa?=
 =?us-ascii?Q?o+Fm0td9/y2bapE6okUuYGmCFPGBx6hDWE+jNzsUs6E4DOkKXFylU1ZGxpJj?=
 =?us-ascii?Q?Hy2v4b3+vuxgNwy8deVNsn7C64ahPu/u4Ig7nPY5/MdyZo+h6uhLrMqhxaRt?=
 =?us-ascii?Q?lYk9OR/EWtsrzbV85YpUVAo9pop7fSaDxaP6WMGnQGaXciNgcwTeR6ujp4We?=
 =?us-ascii?Q?ZJpSI++br84yggmPb59itbxT1ybOQItCmdRYpKBNr7gAUVLHRXr1AeCSUzre?=
 =?us-ascii?Q?IXIyUri4g2iuSGWeak4UPp9ck2nUbtuJ+foGavrkl7dc0hhqg+/XMmFovcwD?=
 =?us-ascii?Q?mOZXLWjRMm8mwm8np8IAccCfeC9ch3F/F/AgBRD6brCvCYhH7v4l6hmFSTQA?=
 =?us-ascii?Q?/9x8kF1jVHDmTTtLUF8A4V5fzNmsJaDeRi9NeoKhuZgHrJ7DCCbX5QVokgx8?=
 =?us-ascii?Q?n4cGFermRdJCbaH5x0Ejaz7ytBrgcrjAXtww+5oxflBaF/fZluL5tgebRtKX?=
 =?us-ascii?Q?a7Tk+ZFwU3ddgul5/Io0mUWuHLRKOqO2xhe+IaSy+MdOWp/OjuTKdsLksM66?=
 =?us-ascii?Q?Thb3TJfLEqaVdOf56TBGIOC6uWVZzhyPhO0aHM52?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	C9MWsAgjGMcX3LfM8sk7DT2BNmAQH58hiVclz1lTZIFczd1HbAwufxAaRPoL7VRNgBdobfyhLOVaEIIkvB7sQctCwV5JMQCLhVn3MIomoyHWeViTbTEucaebJldRVXoYPuWyo+xS3WNpmaCC9Ocj4jIiPZKnoCDPSRdyKLex4yLEwO6iXvuL5qCRTPp7rw22AdPpz1wr0G1Nysj6vz4OrHRIwBG3D+pFUQQfrJnoZjVDy+Vx2T8rOrai5Gl6WyXaTAFmB6oO3q8WigHSK4dJygCxjd9VmpIul9Iu8vfxDF4tKB2QBYnq6U+ybQgyETewa5rW53l/Yx+1oPpRkETN6PrbvKPpa7uDFgUrAll1EogFJqDkBzFJKbW8zN5AOZxXY+4yOAmDZQ3QXm7NvfK5h6AIbs5RlZyGYQqJ764bCbn76DzsYmP2oQgzN6E6agcclXPcOXX8KOmidMEbl3EROiH6HCM+Rx2q3TJe65qItgQCuHpmXT35Vc06DTVfVe9Le2lpFt2hlSCjv9IJXgJjPQ4fSQ+PhCk9+mPbPusObnBqmaFJEDtLD0+r8b8lOj8N0qpLn3pL80x2EOkxw936E5gshWqaIajZymUVmVoRI+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684559d0-a790-4123-214b-08dc53af1a2e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 07:24:30.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcMuHkIfSCD0u5bT9K0Xa4SWTdqYrwEaF+ly4+8r5YdrNHX5X1usp2q0IlXVt20rNqloXdJ2aVLEg94cmXS4Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_06,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030049
X-Proofpoint-GUID: 0rqTkcUSJ15l930xiAHHNUzBfxSaKpxu
X-Proofpoint-ORIG-GUID: 0rqTkcUSJ15l930xiAHHNUzBfxSaKpxu

Zorro,

Please pull this branch, which includes cleanups for background processes
initiated by the testcase upon its exit.

Thank you.

The following changes since commit e72e052d56c3f05e533f4b67056f86931f688368:

  generic: test MADV_POPULATE_READ with IO errors (2024-03-30 15:48:12 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-20240403

for you to fetch changes up to 8aab1f1663031cccb326ffbcb087b81bfb629df8:

  common/btrfs: lookup running processes using pgrep (2024-04-03 15:09:01 +0800)

----------------------------------------------------------------
Anand Jain (1):
      common/btrfs: lookup running processes using pgrep

Filipe Manana (10):
      btrfs: add helper to kill background process running _btrfs_stress_balance
      btrfs/028: use the helper _btrfs_kill_stress_balance_pid
      btrfs/028: removed redundant sync and scratch filesystem unmount
      btrfs: add helper to kill background process running _btrfs_stress_scrub
      btrfs: add helper to kill background process running _btrfs_stress_defrag
      btrfs: add helper to kill background process running _btrfs_stress_remount_compress
      btrfs: add helper to kill background process running _btrfs_stress_replace
      btrfs: add helper to stop background process running _btrfs_stress_subvolume
      btrfs: remove stop file early at _btrfs_stress_subvolume
      btrfs/06[0-9]..07[0-4]: kill all background tasks when test is killed/interrupted

 common/btrfs    | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/028 | 16 ++++-------
 tests/btrfs/060 | 33 ++++++++++++++++-------
 tests/btrfs/061 | 30 ++++++++++++++-------
 tests/btrfs/062 | 30 ++++++++++++++-------
 tests/btrfs/063 | 30 ++++++++++++++-------
 tests/btrfs/064 | 30 ++++++++++++++-------
 tests/btrfs/065 | 33 ++++++++++++++++-------
 tests/btrfs/066 | 33 ++++++++++++++++-------
 tests/btrfs/067 | 33 ++++++++++++++++-------
 tests/btrfs/068 | 33 ++++++++++++++++-------
 tests/btrfs/069 | 31 ++++++++++++++-------
 tests/btrfs/070 | 31 ++++++++++++++-------
 tests/btrfs/071 | 31 ++++++++++++++-------
 tests/btrfs/072 | 31 ++++++++++++++-------
 tests/btrfs/073 | 30 ++++++++++++++-------
 tests/btrfs/074 | 30 ++++++++++++++-------
 tests/btrfs/132 |  2 +-
 tests/btrfs/255 |  8 ++----
 19 files changed, 418 insertions(+), 161 deletions(-)

