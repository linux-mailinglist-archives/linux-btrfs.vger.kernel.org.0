Return-Path: <linux-btrfs+bounces-1214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D17823BE7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A128E283A36
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 05:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D419B1DDE7;
	Thu,  4 Jan 2024 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AN1Srwb3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zpp4p31X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742FD1D68E;
	Thu,  4 Jan 2024 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403MLXZd027250;
	Thu, 4 Jan 2024 05:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=EKulkkd2eaKLZGzfLYbI2aJ2OfDDP8kRCGMix1mEgpw=;
 b=AN1Srwb3SVgyWOYtDedEY4XyoK3AqNRnMNCD37FPWH1ffhxlHUuXPXYnddUHCZmppT2z
 j2H6OqSrBR/8RD75NftJ6f79fuoX4bf0jVpyOQsGDs5Tvkvl8w0BMHK+f10T3YsayALj
 zoFr5+K4tvikPXpQ8xOQm324uNVorkh6+FudtYYjmwwYe6oEG/MmvslYL8cHKVCnXlRI
 RuAkYz1m3DYILsTp0xrBJRE696eq/eFd3QpsvIKNjrpcD2J55Oud4epywZNtUnISij4j
 Jx1bc4xnLOXCRz965Vb4wxAl8+x/XGbZ6J0CbnZBGnz8gQQASedlp4E0YBBXMjBs2veP Zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3va9me6br0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4045lcoD015771;
	Thu, 4 Jan 2024 05:49:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdpudg1r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0Jl7pB7WzhRSYwr1NfugqkSkVniGJkSan5dV9uGk0ZUrDA6XtD8SALdtpyiYNv4l/Bkk7YqqsNBQAsIu4DpHUCmeGHydNpFnsAnDdEX4b7E/R88OXWg+BkbUSOCXBqpL7cmx1Yc49fuyDQMgj1ydnJ1CHLldKtJy/J0Hz6x6qt0RpuVWzVffbIRQardCMF3hNLM5YFV2pS3qv6D/jwXQy8g3+RyEco3/KYxEY3/igGLUxoITzxrBucLUDXmlSxTctdLLdAN0F98DSlVGUxJN59RnWtyXRE6kyH1rkwr1QzlsUqb7S7RB5PrjKpBqlc1a2rVpdEjaJwwcUt5fcEFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKulkkd2eaKLZGzfLYbI2aJ2OfDDP8kRCGMix1mEgpw=;
 b=A1M/TH2d2ncTdr0kLY+3LyNjRn5O6SF99aVcFJwn8rroJ0uZKIG0+C3J5Qy+wGguCh65E52JpGM/ViQoY6dANZPoJZLxhwdJpCwiY7C0Qh0Sve/l3LfUrmUHSr42FVmYQjnR55Xh0/C02qIZ0xpWvapJ4sqP5WxUyswJR0w1kCOlIm8JoO4bVXY7ZYV2tUcr1VgV9gH8zwdcuB92UKzxvLJnPZTaPD6y4mIrNHKSuv0ew+R7CZF25/+phsNO11/H7Qsk5MDvsAwhaYwlnjMIXaKhYdL5zbCYFLUO2AxhGL6y7Niuy8rI6UWPn1i1bgELhAD/WpyWiCAqc06adyF8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKulkkd2eaKLZGzfLYbI2aJ2OfDDP8kRCGMix1mEgpw=;
 b=Zpp4p31XTD7mrxt95vjq9VirI+33MQTpPX0wtU004QW7GV3N2DZGUpPDfv7i356wwhOtAUDt7g4+54JrcDwiNH/6+jUlystx3yo219mQK3tl0TA+ZPUnr6LdjU47KIEFmzZ4fnhUhM0hGMeJPtzonOCGhV09rE8WTR14Iy3klKs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 05:48:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 05:48:37 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        fdmanana@kernel.org
Subject: [PATCH v8 02/10] common: add _require_btrfs_no_nodatacow helper
Date: Thu,  4 Jan 2024 11:18:08 +0530
Message-Id: <1cea3aa45d90904999866da86565528e45532109.1704344811.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1704344811.git.anand.jain@oracle.com>
References: <cover.1704344811.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::34)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa419dc-1e46-4561-244b-08dc0ce8cbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4n/61WQYeJH6zhoHQ/vLIpykmtIDe6wIDEJ3wVP/HdDd47l940waAfpQPbREXsj2bjNA0dsWJrSljvakEn1+o0aU4OuCupptJGwsMluwSCT+RrKco73qkXY+gC5rQijgs3/ryEVR5r+zNnZVexhG9dtEQJlrs/U9hdfGJ3UegCEhSqynhUGiMiGD6bn3dE79gEc33xHtQg9MYIWE2Z/6M217URd+2rmVzzneylmbWLO9ZoJtXotGtIviA4yj+gU0Etd4HFcHrOS+/cqbEjogwLLephGYaC+CMNF2TQU2R+CwtzPf2CReUK14a+RjO5XRyB/0/iQUlAWgzsk7PNlJigVhp4q3eCAgIbPik7+BxjF9vjCPpREwtnbprCgAXu4xmyETGIi04Y0VG7aHx0Q7EVICaR1fEVtdv0PUNhCxkk2DGMn5zEFQs//11UJPxfp7YetVcPIJ7WKZ7gaEnccJhYQgeKq3ftVNowavwfuXFATcQKZdddrSWfjXM7VeGQxNzJylFk3+xTncyweRbHxeaHiDAiWXuOUjFtiygYtJDlWxtQPffLcUbO5fyIX0xfaV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(4744005)(2906002)(4326008)(316002)(8936002)(8676002)(66556008)(66476007)(6916009)(66946007)(44832011)(2616005)(26005)(6512007)(41300700001)(38100700002)(36756003)(86362001)(6506007)(6666004)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?y9T2xWCNxtY9I5wwwlQAiif8z0qPWl4LlHxUppN0UcaGfassJx2XzrR8FRNa?=
 =?us-ascii?Q?sl6VwDxiKHfX5hRGUwX0Ep8kC0mmcxiiQsoq0NjkUsebe95ZzvzBaJmK6wBe?=
 =?us-ascii?Q?2Lg1enZ+bbtIWRgpqToZWXo00CIYnwiD12wMOnaRADFLA5NIJgPdqvPjpQAb?=
 =?us-ascii?Q?mkIvka9l55CpGxj/dj30QSeAeg4h9wKpjtLYyDkC1AE1+PWcftP9RfAKMNKm?=
 =?us-ascii?Q?zVhTthxBQZM8U7LsMoTZXQhj179T6vM2PEup4vNzaZw1MUp0DKIhjxsSsQ7z?=
 =?us-ascii?Q?I92MR9fx/gB/NTZUVG7Y25Z0lgbEEJlDhu0/C7VjkDiIhWZqHddHnLNgJTcm?=
 =?us-ascii?Q?uD2R91RdvMipvbGXcipOCOn3Eqenje1OK8mre4oef3f6gJuUIUb+lcbaB/Pu?=
 =?us-ascii?Q?ZEhUJE66xtZDlBi/zj56AyqqOLe7sdJvykyLqfRrFHXD919noL6yVWm/zjMa?=
 =?us-ascii?Q?VQ0ocI5jmAzYojBN6uzo4uZR9aPKQLxKAmfUOBC+yVA7/2XYUa4Ct7T2J9Hi?=
 =?us-ascii?Q?PyoZPcZEa6g9msGefTcOjW9XJxdyKjces292lQADLmWLNWezp1S2FZt+PJNP?=
 =?us-ascii?Q?XV6miIcS9x8b2kdgO+0n64vNOYdjp1KZ15s7ohdTx9Y47lopSkrigrtJrG0N?=
 =?us-ascii?Q?fyy5pqPyV3IezSuJZ7v4x3dzLQz9dn2n47TNqNEqKgRQqCL/WqgT3xOgtWEd?=
 =?us-ascii?Q?kpgzkU5VHo8J8membf86p5oNebyK/8R2Bnx4f2C0ewwAtvdr1/OsJWJVpeTQ?=
 =?us-ascii?Q?TSAHlmxSvX+mACSkNsqRWpo8xdl+DNPNF9a9q+4PJmpJjsPVcfskAYz1SHWd?=
 =?us-ascii?Q?Y3htHx5Torl1hdUdYu+MhR81ZKkmaf90NH7ZoUqLeVF8La1nKmtqTHuLuEER?=
 =?us-ascii?Q?0BeZQ8sgl8zTqhMFmE+LMXCTsbG+yh93jBcN5xa93+7+EYCbK5jRv8IY27rL?=
 =?us-ascii?Q?uojxAa/VZjCIOwrQ2TQssKOO61oAVOYN/hePJnSQCPbx/KTc/HT0fZvjSRYx?=
 =?us-ascii?Q?4qAxpzihXGxaENiJwms/chHCg8g2NzfL5LMewtuTbB0+fNASAF1s6cvzHLK+?=
 =?us-ascii?Q?hCYQ4mH8nVhl9T4V69ySWEziaO+ECK5WMS0hEHnY6jPc8kbpOfauPRzkQsSq?=
 =?us-ascii?Q?R4tU8jKD8slsRQm0F0oDYY4acHpgGBwsIu/fcszu6TJAUtAsbwhVhX+yAymr?=
 =?us-ascii?Q?f2OnR5Cq5KpTkUNbJD+CMY0gIIiWnPcHwyRcmnq/7xjhPQIpAdbEYR8bwIcd?=
 =?us-ascii?Q?fpFUxJHy+XLMIjHKbMA65L9dBMDoBJPoAtZWyD2tspdfGUadhN9NrGK7GifM?=
 =?us-ascii?Q?0TdrHrkKMsqnBvwjBvYG0rrLRoMMAWDMW6kJ9U1nq2PNgo+xof9gjBm3nKFA?=
 =?us-ascii?Q?CFIcdrHMyoMoBq/pLJ4G6yZRtjs6F3J+mie5Nmfz1nz7NtZFkxiV7TW1Y7y4?=
 =?us-ascii?Q?OzSIr9IB+p+KJ32XCVJThMtmk6+8s3x3rgmfpB2UE+Gm0+Ge2QbRrcX1qCnH?=
 =?us-ascii?Q?XvSKJQA7goeHTdVuBZXgCWcqum7CWCFcSd6HgRFOWi0bWxD78T3UBAAUeyOp?=
 =?us-ascii?Q?Lx09XcHxYHKIsVkWlg/r9MIqcYMIN+OLt6t9Mg4M?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TK0LYQftqhoi/lTCqeVHnn/i5GtbmjKB2f3YdjMN8yf8XfSSElHU8p7LS3X8N2JbqAE8EwHZyo+cU7kVsEuYVum99LfFXV4nX24c/9hK33oxqcIZi2BEgIFdb8ogzLo0p5i+H4iSYZH7NbCHGiJfuLqOZBX9aFUX43BivxfZZmGGeGkKD1Vrfl6OZ1jAZjgXLmx6cxCk9oJV4F3wsaQuQGFkE59cTgc6S1Gu5MUdBmJRxixrx6Pqt7uRedklvkf09Wk50TqfFT4uqzwNHEQK6rzTPV5CUr/HfnCMOvl307wqq108LdZxWMJP7htNToeyb5lJAPbbGDPXVKsgZIzoQDtm6jGsgGqbBGBWxDNjeiSyxwNhtZ0Rlimq+7E7TWVAkz5/GPFv38ei3ArlO/ioBOjKWFr3IXfe5MxRv1Ak9OOZyxvUf7V7Vjf0o1RJrL1SraACuNo2zyUPcZSN9+6LlYaKOo+wAzCrWUhv3DYW5jHpsWNKsPNToOUYyBTCPzXuYeeARL3hyAQhksXVu5iOxrwTwaZqC53fMmyowk515AaccSy4Vx04fSM11DCPVrbDuYGOGkX8NtG/QpqaHChreGz4TG7Pn7Nh4ovTZ9dI434=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa419dc-1e46-4561-244b-08dc0ce8cbc3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:48:37.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oKWi1Bgnq5xHVmiXq+jSFbVWKPdYXDOslL5gsq0kLc6CyElX1kZBI1TfaYYpaQ6IGksuUSNdfwyj4iUC4FySw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040039
X-Proofpoint-ORIG-GUID: fMe-lCOy-P8ucs6UxawLkD4_KYcYZqiU
X-Proofpoint-GUID: fMe-lCOy-P8ucs6UxawLkD4_KYcYZqiU

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index f91f8dd869a1..9dd2a7f49e16 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -120,6 +120,13 @@ _require_btrfs_no_compress()
 	fi
 }
 
+_require_btrfs_no_nodatacow()
+{
+	if _normalize_mount_options "$MOUNT_OPTIONS" | grep -q "nodatacow"; then
+		_notrun "This test requires no nodatacow enabled"
+	fi
+}
+
 _check_btrfs_filesystem()
 {
 	device=$1
-- 
2.38.1


