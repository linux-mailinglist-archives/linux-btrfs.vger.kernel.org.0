Return-Path: <linux-btrfs+bounces-8836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F7C999AB5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 04:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96499B21676
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 02:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FFD1F4732;
	Fri, 11 Oct 2024 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MGAGzyaO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d18B6aiR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72181F4FB7
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614988; cv=fail; b=Wo6N1Qf83SO8aVP6MGvlomuKFy0MJaQUfX1R3wcEUb0Fa7RNZUSwFWK7IJLURWb2Rz+O70fn9l4DWMTJaOMo0ELrvSq9UVMQ5F91CYLa3V2dJBfHDBVEVz+Ppzs/CgpCgQQsn6Q0/f6M+GHLy5VwiFLtnHewItU3FKruVXKlsH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614988; c=relaxed/simple;
	bh=Sc6fqI4vgN0TbgBl5hEQIsjc47vfsG+EaaO2nHCnmso=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L1dWOr8DIdsxm6MNTFP1mcNqPliI+1mdpAV9ZwRHQdO6HRc/UoxAVIsADNBkj89s+CnGVigMcNuTFLCr/WMaJXPLLwVNPLWgTOZgEy8pUeLyTEyE1/msoCHKHkEB6MYySppzPB+e7w8JBtmtgA8dWIkrCUYd8ZwwlvEqjk6/zvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MGAGzyaO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d18B6aiR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJtdok009438;
	Fri, 11 Oct 2024 02:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=uKhGWhJpyCDkk03e
	QMjhkAe7N+L2D3CnW4ilQ2zE/uc=; b=MGAGzyaO2oWmwLxvUTuv58K039tVNBU1
	/lsBNA5ezxXfdZ6oV4FfylF7rogXR+AupE7K/sy3e/DoKRD1bw6nUr+n1/lhYBA2
	cC5lRxUY6nt7hOSuuqwBgrjCqVsx80hTH8NPqtnTvTotnsDg5vuowzWzWKib2Wnq
	plegtgKfN3QaoeWZEgcw6S/ZMX5pyGp73NhbVH7THMY3VRa6GSuzI79QCVhs8b5V
	lq1jMlL7eLZ6WyXVJFZ4ixlFu26y5pZCNv3OHC6JfM0SH/f9EVSQELZG1yGfp6wE
	N4RvFS8G9XX/PkcGEqHl6EDqyXppi71T+MolZ1jhoKramTyajVL9FA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306em31u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 02:49:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49ANUKlq005769;
	Fri, 11 Oct 2024 02:49:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwh56xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 02:49:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWI5nG5YUXCwITxoipIQ5VA7AVWBQ3bu5muWzu+ZHoZ/LDjEn6ehRFGD3PtMpdL/D3XqKQRUNscM6i+EYM6VXU+CLraR8HrhkD/ZhvX+Co5VnUKxEJ4cNKYLqJpJM14EWH08rhfFU2qHWJBtRxWOfP/wu52W/O1gUSqtOJXcXwilIEH4CmKUnnQsZHeK9e31HCl4O1Zrr4qAyj/qtDW/pWr0mwnlo+kI6v9QQDtfa10dh6RTTT5c6HrJHuk4HUv9UId96Z3zq77t1c+KmWSFKPlziTSVbdrlMPVyO9+qSM4l8IP4R33rCIWYlXJ53kaylTItKeWBgh/z/OvBxqWkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKhGWhJpyCDkk03eQMjhkAe7N+L2D3CnW4ilQ2zE/uc=;
 b=KGwMBEBB7HJ+JMNzH2tQRyVugdV5vOY4GCEIX0mtBB5xV/HxiDGVF2zixiKRjPZp7fU1pkKE0NahZ+9ufjLWn1psGwUMgPnPkM/eFzwUMn2F89AiRMIlHsOX5BEivyo6rwn+Di2GM/uA9Ya8nP76wDq3TWvEG6xbijQ8nQ1z+jLCPXiyt9wjZ75JDNv7Afn8FhNjaq6IL1/dQJd1KAIcVCjGAAtKUWn18+c7KfurWMRLivAtOXrmu6LlfKNmD/Y3jdcwEHCzI5QOwCJc2MibjsAAt7YgePVZBLRLtkRFedeewj4cUnKZsIJej1ADfcmmsDO2zlrLl4JldWNnj3gCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKhGWhJpyCDkk03eQMjhkAe7N+L2D3CnW4ilQ2zE/uc=;
 b=d18B6aiRdbIGRI6jBYA4D5X2SAqmdsXToQw9hfvLXzZvCSnHtlcRHiUPGVy1FBeqmhfBgXCLPS+hwGcOLIdcZl4cSmnGocNSXxQghc3xk+bxAnTy1w6D0/8AA8zhb+znKLKZYg3nRI1QGThIAI2321WAizrnRExCVGATzY6xYLE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7815.namprd10.prod.outlook.com (2603:10b6:806:3ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 02:49:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 02:49:32 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v2 0/3] raid1 balancing methods
Date: Fri, 11 Oct 2024 10:49:15 +0800
Message-ID: <cover.1728608421.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: e233709a-42f7-40a1-3319-08dce99f5523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w/z3BCwe8z1cSqgvWUqUjkIZCbqbIIhNYX6TNb6RTL7H66RnUZxDElY1gYZr?=
 =?us-ascii?Q?VfvVMeYXCZe3xVE5XsfojH/TFIGvYYyyMZT2l+1JrGfKYCDp3sGe8ZsNyMzz?=
 =?us-ascii?Q?U2qd9GBjzwf8woKxZaLMJd6JcxgZlaj0CBlri9cbDeRoOvlRUg2HaTzX/3N3?=
 =?us-ascii?Q?VN1egrjAQsKr3P53F3p4kMiQnOEcibZO6jMK+ZXN4t0ONi+6fiN9NgTmSsM1?=
 =?us-ascii?Q?SMCEsB5HslDG0FvUYL5gx4msGv+VwtsBNqo1fNNK95I9f0RGt0h2uVlC8nGQ?=
 =?us-ascii?Q?uluUgIT6PSGFpxj27K7ymS+wU9u9suyH0OLSyW7BIJblC7vaq/h+fV17bnlH?=
 =?us-ascii?Q?gEBZpb7LO7dMJvKVbPOJ5W0ijbyIKDqP0pJI+UNAbsqoJTxizE8EzzP/eg4Q?=
 =?us-ascii?Q?UmSlY1NMxpHhrh1F8lRm7OjJibleHepJ2lmDJUHt62RUoxEQzZId6rvUulmc?=
 =?us-ascii?Q?Yd/N2w4RgmsfDc6bgBUHVrijuFuc6Nz0vz9VnPo9QhbdWK+1kXZYCU947RUS?=
 =?us-ascii?Q?1f7Nk8wOESzfJxGE1A8y42yYfj901Df6PyuAl49dGcvJDcErkGpDinkK/edW?=
 =?us-ascii?Q?SSrIpEYgRFQOqpv/k7hT/8JBv+qs8FPU5zu4drtyonBzC8WOGD9I8TXftY0e?=
 =?us-ascii?Q?gxDCmcjo46yQtuJMgnneEIw/tUMsYuYZkebtALO2cKg9HCZTYyHfF/j8JzXN?=
 =?us-ascii?Q?E21UAxyXfa9fF2MgIteodpsyFlvLChlKl+NQ6zlBCwARApKmHVQxe1Dlagrg?=
 =?us-ascii?Q?OTjPxqF7pX9RUGtSJaNzIXCY5N1S1NCAmyapCQOgpu3pwDEicmx2ni/q0VMM?=
 =?us-ascii?Q?8KAHbmpONhjXiuMijB9aIk69rjrJALVJQfkRHIQC7Rjf5K0tqwIXnNnVn4EM?=
 =?us-ascii?Q?g+REdgVUUPQ1DvB4/DMznz4tqIX/ZY5yaVwS5055x0ADtUBUPxHPTQqAr8XC?=
 =?us-ascii?Q?bBcU4Pk+PZ0fmKSXXfk4aYygHI+5Gq2g7gHZjDdM+bqu1ArrEY1/wCIIh1e0?=
 =?us-ascii?Q?Kn75qFrCJcuQ2dsI4cI4MGZ/KGhTG+w9QMU7YyEsu7SyuoEN2m/BEh14fFo+?=
 =?us-ascii?Q?DyOIhmhzlzCvAYjAHyB+2C5SoO34OVzSGAJ6g+9U+ok017ng5pMV4uysPBtd?=
 =?us-ascii?Q?0oQ/oxTMUHr3dGz9nQvmJkZQDWKT8WbSiJRqBfkXDmSs+gMv78WOf4+Ql7L0?=
 =?us-ascii?Q?tGRpWWNB1DLJibLZIcwoedNrCT0qghcwKn5t1sVfT+1kCzQYRz05RU7Hafmx?=
 =?us-ascii?Q?zhEApjlKPM/LBSmxfdNoqA4adWFP8SOfaXuMSMeypA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OgyRdLP8KZzA1CMpVWYr64YtHE8PhwMqkbM5bbFH1+P8ok8K7Z5gdDu9ZVLb?=
 =?us-ascii?Q?QVPOkExpQlLbBV8dhFlYe9Q+i4kBNWFhI2y8lK9goMYzjlrFwkAN1s77lAIZ?=
 =?us-ascii?Q?xIskHMDoDg5qiGlJO73gPrRtJZ71C2PGKL8wVteKMEpCK5BsCzL31koHBjS3?=
 =?us-ascii?Q?fVMcr4Njb9rOhLuiN3IT3sX71VLUaR+9BZiQtJ4hUSFTMs1Tb+F/19aWOfoB?=
 =?us-ascii?Q?Ibm9BfmrV3Eh45uPeQ5kHFE4UuBXX7hNIxemUpWIn0Vf4fkoueFZ8toeL+7F?=
 =?us-ascii?Q?cMyquth5LIq+mV4U9VCXi8og8CDEQosZLWQw097mXu9baCtXwVSOY8NaYqfT?=
 =?us-ascii?Q?onotzA3V9Bra+vqrD84HbmpKqvaCtjQA21NoXOSJ8/XmZcw+GC282P1URPov?=
 =?us-ascii?Q?BHgRoFZbSrd2FwcqsxQjj8siJexyDVHw/djVlkMEqXekuOY+5QLzPtuFfGUK?=
 =?us-ascii?Q?Tye9suMrbJAOYMlcPXAkiFesSlgbpvop8Iapgomfgq591ZTn8CaNr1QLv/4B?=
 =?us-ascii?Q?bEmsMU2opdwY/QVLN65aoBY8Zs5JGXbcRfKoDofRa54jwg5oJE8KAwiyH4g2?=
 =?us-ascii?Q?FPiDoLCVMbYRMDB/+86PBWfA1FRS1L6hXHFV/BuR/Et7y0EN0scN6hNscSnw?=
 =?us-ascii?Q?sU1hrCV3/1OKluFfuNeh6H7h1G0Ea9jQc1haEpyp174NKJIoeGC0NHdwoLfM?=
 =?us-ascii?Q?4WfZOmulsDltDc2q6eZa4ogv6j93ZC16o26MJlIzfRTYgAzu8PWNZMhX+V4q?=
 =?us-ascii?Q?Ae0rlhH9Z6Loo9pmyu8yiueLALP+U8D0Pp6XnR5GTrp7dDJJLHNDY6NFg0nj?=
 =?us-ascii?Q?Up4cbt0ITbFFlMG0fT+CaRiZRUJ8zM0sU14ICD4ZI8sLBQGaBDeoo02baF5U?=
 =?us-ascii?Q?XTdHA9Dai1YsnkiysXhbOr8SgOU037wiZZ7PbGDVE2+hbLnsViDb53ZQIrLe?=
 =?us-ascii?Q?8w6Ui5RFtQgkuh+CYO+r/sBpRNUq4e6vaqGDu3UMCCFapyaRjBhu7FnemJea?=
 =?us-ascii?Q?EspIqFddXT/dr3xBP6/x4/aMsCOBXFV0MCod/zcbANeSFdOmywcoMP1mcrha?=
 =?us-ascii?Q?w5jtZ830OzPKO2zU3fvf6wCO4uIOx335OAkmsPSn6e5GQ//7095ONeBr5qTp?=
 =?us-ascii?Q?ZfdP8vESVFsPawl981YH8dFGJyULrJRe7dkiLlvT2mLMbNjpcFr5QE90zpm7?=
 =?us-ascii?Q?xwaS0JQyurRFEzqTVdsm+pw7OxoV40Z9jMcbkzSDtehGKHjEF5S52msFyiWa?=
 =?us-ascii?Q?JC6xUCurJp6XCY10aHVBE4JN+jzzW/C3xeur6sFOWYuqmpyziUpgPamVzMvI?=
 =?us-ascii?Q?83dniBuYpH1UVhP0ciDpBuBKjA2ciD+vbBGKOq7hWqtqhZ+ITBRE2yGzv9jd?=
 =?us-ascii?Q?etlMCHyw76o1OVE6NxNZbCICJw7FxooPhHYW6/JHUiR9JAylwR9u9cFbRcI0?=
 =?us-ascii?Q?0gWeun+BF68Az651gMnH61HvnsfO9b4hZmci9Hs38SaDMXh+CGC5+TTJXimI?=
 =?us-ascii?Q?cJqVoba4XiTfUdyjXotWR5MTAXylXYSflDpPNH5nsbwx4XnVLbVLRtB1oRNU?=
 =?us-ascii?Q?KQRcF+ZlEUWdjc9C8FY9pySXTOJcf5VQuCbq7ln1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3W80LNTevfAbA1scGxFxExF0N2NB11kqOyUt7dqq8u1XZobEXC0ohMThA688XNsK7u4Ek7WpU4j06TIxAAW4wXR70PCfWIaLoWj58ofKj59f2NTUxY0p1EuRYMaepYpj/YOOB5Z2uLaobryxNKhiKVaV4mwPzMwHFCAKcaH5fJXfpYUUA1zRUA6O6CYNDKihaDgZInVZgad/v65d5DUeHHjz70yrrMzuAYhctKhx8APgKoHmnzx6fMT3FIxnMoMA1N+Skpr5Glv+zfJbfxehDrR26uHdTmbSJvc2inEli997DNzrnuqcn7WHCRY1Yp0+jSkp4FdgKohpC3QUhZWm3/n8g8ZJ/5pQTV7VzOOXx2VJ5RikcmyFYGt8wTAv0aQIhjomMZffwzA0H8I++OzdUisfPKQeG3GbGckJSoUQycwyuoMnKBXlhOW3BshbvkaRBGVFePzKud9NSnhCWI4EGkb+L3UUEsZAdFCAoJbPby4XxirSxjZY+ke0nU9G6Bkhw8QiiX+w/cFGlb+eqwdA5MYkPLvNbSxhfgU2OtB05oA8h68ghRfNvaVmtrclqs5W8ZQldXvSLMHyats+k7ysN5unuwqIryo9dZqb7khzSvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e233709a-42f7-40a1-3319-08dce99f5523
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 02:49:32.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVYNZPpGRNV1eUZkgIz0MASb77FPvjkE5lnsA7FAwXC/nwoM4z4bBcpls39AW6kFYmCDEpTvaDXsI1RyQfn5vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_19,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410110015
X-Proofpoint-GUID: 2iIIPgGyXWmqwPGz36FqGSzAYiktzTM7
X-Proofpoint-ORIG-GUID: 2iIIPgGyXWmqwPGz36FqGSzAYiktzTM7

v2:
1. Move new features to CONFIG_BTRFS_EXPERIMENTAL instead of CONFIG_BTRFS_DEBUG.
2. Correct the typo from %est_wait to %best_wait.
3. Initialize %best_wait to U64_MAX and remove the check for 0.
4. Implement rotation with a minimum contiguous read threshold before
   switching to the next stripe. Configure this, using:

        echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy

   The default value is the sector size, and the min_contiguous_read
   value must be a multiple of the sector size.

5. Tested FIO random read/write and defrag compression workloads with
   min_contiguous_read set to sector size, 192k, and 256k.

   RAID1 balancing method rotation is better for multi-process workloads
   such as fio and also single-process workload such as defragmentation.

     $ fio --filename=/btrfs/foo --size=5Gi --direct=1 --rw=randrw --bs=4k \
        --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 \
        --time_based --group_reporting --name=iops-test-job --eta-newline=1


|         |            |            | Read I/O count  |
|         | Read       | Write      | devid1 | devid2 |
|---------|------------|------------|--------|--------|
| pid     | 20.3MiB/s  | 20.5MiB/s  | 313895 | 313895 |
| rotation|            |            |        |        |
|     4096| 20.4MiB/s  | 20.5MiB/s  | 313895 | 313895 |
|   196608| 20.2MiB/s  | 20.2MiB/s  | 310152 | 310175 |
|   262144| 20.3MiB/s  | 20.4MiB/s  | 312180 | 312191 |
|  latency| 18.4MiB/s  | 18.4MiB/s  | 272980 | 291683 |
| devid:1 | 14.8MiB/s  | 14.9MiB/s  | 456376 | 0      |

   rotation RAID1 balancing technique performs more than 2x better for
   single-process defrag.

      $ time -p btrfs filesystem defrag -r -f -c /btrfs


|         | Time  | Read I/O Count  |
|         | Real  | devid1 | devid2 |
|---------|-------|--------|--------|
| pid     | 18.00s| 3800   | 0      |
| rotation|       |        |        |
|     4096|  8.95s| 1900   | 1901   |
|   196608|  8.50s| 1881   | 1919   |
|   262144|  8.80s| 1881   | 1919   |
| latency | 17.18s| 3800   | 0      |
| devid:2 | 17.48s| 0      | 3800   |

Rotation keeps all devices active, and for now, the Rotation RAID1
balancing method is preferable as default. More workload testing is
needed while the code is EXPERIMENTAL.
While Latency is better during the failing/unstable block layer transport.
As of now these two techniques, are needed to be further independently
tested with different worloads, and in the long term we should be merge
these technique to a unified heuristic.

Rotation keeps all devices active, and for now, the Rotation RAID1
balancing method should be the default. More workload testing is needed
while the code is EXPERIMENTAL.

Latency is smarter with unstable block layer transport.

Both techniques need independent testing across workloads, with the goal of
eventually merging them into a unified approach? for the long term.

Devid is a hands-on approach, provides manual or user-space script control.

These RAID1 balancing methods are tunable via the sysfs knob.
The mount -o option and btrfs properties are under consideration.

Thx.

--------- original v1 ------------

The RAID1-balancing methods helps distribute read I/O across devices, and
this patch introduces three balancing methods: rotation, latency, and
devid. These methods are enabled under the `CONFIG_BTRFS_DEBUG` config
option and are on top of the previously added
`/sys/fs/btrfs/<UUID>/read_policy` interface to configure the desired
RAID1 read balancing method.

I've tested these patches using fio and filesystem defragmentation
workloads on a two-device RAID1 setup (with both data and metadata
mirrored across identical devices). I tracked device read counts by
extracting stats from `/sys/devices/<..>/stat` for each device. Below is
a summary of the results, with each result the average of three
iterations.

A typical generic random rw workload:

$ fio --filename=/btrfs/foo --size=10Gi --direct=1 --rw=randrw --bs=4k \
  --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based \
  --group_reporting --name=iops-test-job --eta-newline=1

|         |            |            | Read I/O count  |
|         | Read       | Write      | devid1 | devid2 |
|---------|------------|------------|--------|--------|
| pid     | 29.4MiB/s  | 29.5MiB/s  | 456548 | 447975 |
| rotation| 29.3MiB/s  | 29.3MiB/s  | 450105 | 450055 |
| latency | 21.9MiB/s  | 21.9MiB/s  | 672387 | 0      |
| devid:1 | 22.0MiB/s  | 22.0MiB/s  | 674788 | 0      |

Defragmentation with compression workload:

$ xfs_io -f -d -c 'pwrite -S 0xab 0 1G' /btrfs/foo
$ sync
$ echo 3 > /proc/sys/vm/drop_caches
$ btrfs filesystem defrag -f -c /btrfs/foo

|         | Time  | Read I/O Count  |
|         | Real  | devid1 | devid2 |
|---------|-------|--------|--------|
| pid     | 21.61s| 3810   | 0      |
| rotation| 11.55s| 1905   | 1905   |
| latency | 20.99s| 0      | 3810   |
| devid:2 | 21.41s| 0      | 3810   |

. The PID-based balancing method works well for the generic random rw fio
  workload.
. The rotation method is ideal when you want to keep both devices active,
  and it boosts performance in sequential defragmentation scenarios.
. The latency-based method work well when we have mixed device types or
  when one device experiences intermittent I/O failures the latency
  increases and it automatically picks the other device for further Read
  IOs.
. The devid method is a more hands-on approach, useful for diagnosing and
  testing RAID1 mirror synchronizations.

Anand Jain (3):
  btrfs: introduce RAID1 round-robin read balancing
  btrfs: use the path with the lowest latency for RAID1 reads
  btrfs: add RAID1 preferred read device

 fs/btrfs/disk-io.c |   4 ++
 fs/btrfs/sysfs.c   | 116 +++++++++++++++++++++++++++++++++++++++------
 fs/btrfs/volumes.c | 109 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  16 +++++++
 4 files changed, 230 insertions(+), 15 deletions(-)

-- 
2.46.1


