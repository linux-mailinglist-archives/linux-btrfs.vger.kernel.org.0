Return-Path: <linux-btrfs+bounces-1157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C09E81FF63
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7633283BD5
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897F611C95;
	Fri, 29 Dec 2023 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kXrQaNaS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rAAZqZ+e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC211C80;
	Fri, 29 Dec 2023 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8OJCD011757;
	Fri, 29 Dec 2023 12:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=YDQqw5EPL65V+zNf06K5m8JXQWlDxOzeEKkb2ClMt7c=;
 b=kXrQaNaSCSg5iOFpW4u9gLACoGxOvHh/mF9UljVBdWE12Ocyl0tZp4BKyV/vkAxQrhmZ
 PbuxWN3SW/+mEB/cb/3mU9ypiK7VKlLIiQmDALvhA0XWCAT466OIVNGHUix/gqgJGEMt
 vnw6aLE+8XOYo3ObiB0krrOCn9uwiIeUk8SkPADc/c+6nQ1nukf1n9s3FdLll4RkhVBx
 VZZbOqJbL9kDP2iy3wYI2aAdcC9X72auW1v3FYY7fi3KL8d5K8WFtlOoOGRTDa1WFlyV
 Ay+2DjQSwDqF3k12VwehqOZT7ztIMvvOqjNRaEVIMBirZQ1iBx/HakMMF1XWwziNC3eo 3w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5p52fkmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTC5XY7003235;
	Fri, 29 Dec 2023 12:23:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p0kf2a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud/UqEukQLJN1KzDE7sTfDTVJlunO1JVDzqFa2m35YUN9F+PoIg9B4cf6N/PXhICSqz41ztxUkDT+r/5w9OtsziutJqxpaWfwDqidZspSubROYckld2X8giYqNPLh7QnVW3iLYyxYEfGAyBLutwL999X+mzoGYs5Uhb7hUN4aESPr+MDZSfu6beewRDb3vqfc1gPvnbYGTHdUiOz6hiXbM8CVdsGFAP5MSyyqTmmdGDLHTEsq6RkdnzEh31gBiGrvYAYFkiSHsu2lB1CiErDCRfyOmhj/jCPYACp2uYbKsfTGn44DPlUK2ppccDeT6mQXSgk5S1ntRQrF+8pAWpjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDQqw5EPL65V+zNf06K5m8JXQWlDxOzeEKkb2ClMt7c=;
 b=H5wmKTeaAyYQCogYh4O0/1DrXXrFhu/sfuwpzQw6dVgisexQpfGPGLYVzU5/lM+NjIcHvwWsxHhUvwwdITwUNmyxNcqerOT0MsBG39Rk5YVp87q1M+C0bRTrcTJo0mdqXZkk3UO+wEDPqnHh9r4Y6Ee94gB6pE1KPMCeEdYe4f5Vxqj6nOwJINAXK7gN/fA1O7zOP2qVkb/oGgy0MUJ5psyegMGij/pilg1PuxTGHhABtzTG5PF7r/I/SXsQaTVuB6SIGQYtmaiw4PT8zRQy5pnr+HHeaGFbdGBVC624pgEIYBAvdYcgJNrBXnsiTe12BiFBxJr+fhmBFPW7g7oO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDQqw5EPL65V+zNf06K5m8JXQWlDxOzeEKkb2ClMt7c=;
 b=rAAZqZ+eYnONxkVT6N1kFmZo7F6wI95HOdczl+6iSgC6AJLwwnLsqNuAJaC31r8GnrZATYUtXzLMpv+C4wdNkpNHR+04juN4A7V+FeSrfsTU7u0vVh3Xtz8uKE4xRueCjok3hVIKhXoeBd6WwL5eT+kcCOptPxmaKkvNtj20I3o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 12:23:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:23:22 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: [PATCH v7 05/10] common: add _filter_trailing_whitespace
Date: Fri, 29 Dec 2023 17:52:45 +0530
Message-Id: <cf58eed9c9b9134b94fb6872d37b75a0c0bbe914.1703838752.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1703838752.git.anand.jain@oracle.com>
References: <cover.1703838752.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: a031984d-6f1b-44c9-636c-08dc0868f2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ebk73caBxQM7rcbvW9B5/o76A7cEpMNfgoZid1GchD07DIG+kDHn1RGbye2uCIpyiD0IeZiD4+aqVPhsU+6H5t4Y1O23ViOHaLDjoOZxM64fOYH2kIZw2n5+nLcg2ST4b4mkG8+XekYACzHzKZmKfwGsBEzLPpwfGZOih4qmeyoZmAGxD5UGWBR/TUcnXx+xiSCqkj7RwJJbz3u8Q4XwBTGZsW1yG4jYnL6GzPdjEICQTAuUgS01Pr7q8XopIIKHgTuvS67f+t+PK9F21lWiE8ez2hsr0XXdbP7JWrM2Ekbw4vSwej4nBL6BDUJaRJNGKyhkj1FlJzBz01ebvmFyR21JeamTs5YPzATFnV58yGbXGD3t/xhijK7sbLxZET+OLLo81Q7Adl8l06MtK+CjggKRBtNlTszoQhC4uDHQjSG9dilROOqgAcW+eNyAoRHvH4307/TVKxFFmPdhVIRSCECRIXs8Cc4dcjlqa5Pc1aEEuoV4+hBBLkpSQq53TbufsrOhNy5JkEAcd4BXPDZ0rO2gP+DuyfO79cE/A6Fej7m8pdz+m1bXAiSxAmykO6+j
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(2616005)(26005)(44832011)(8676002)(8936002)(5660300002)(2906002)(4744005)(6486002)(6512007)(6506007)(6666004)(478600001)(66476007)(66556008)(66946007)(316002)(6916009)(41300700001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7PJrlliQa0orIBqYZG3Nt7k7qvZsju5Af4+CvypscT7roQjrxPnhhTPFpmPs?=
 =?us-ascii?Q?3FxxU/HmMlBOhqextDxLrzbsCDz1/epKc4wSzpONIoNgYX3XiGCRAE9j7I5c?=
 =?us-ascii?Q?7sju5Ib5KDYyN82ZCbveHUlLpRpC29sN5Y726/5JqfSAv/2C/2QmV40yrCyu?=
 =?us-ascii?Q?0iaBCIjqg19JbfKZObDCKIib4LGLWkvvaCgH3W/3qxPKuFfWxj1MiyBCad6Y?=
 =?us-ascii?Q?EtABd/tQrlmqqdA4pYPkowpRIkDwgqaxdb0rFfJ4sKMJbdWuD/Xo/B9Ap8Tu?=
 =?us-ascii?Q?0jfeYhcOFBZQreSk6ie+Sro4njQcz5sFQmSXazp87c/Zj9vqSz0z4Yj5nTP7?=
 =?us-ascii?Q?3tbM82BMSHeBN92WOqy9xO5Lxr8UyG+zIKFtf4NXzQvxEmZpwAI2s4bQYw2T?=
 =?us-ascii?Q?rkeUW6inwCkCDVl5xKtllHaT9szyh2x3ABmfKN1dWHXkqzm0BlxitNi5Bu3c?=
 =?us-ascii?Q?shQO4MRs1h5KOwRTNR8TtZ/tRAhcdBI2qnpMOeCB0CpLNn5AZKxLME6UyjmO?=
 =?us-ascii?Q?q2Mzh44/UIcP85eI+y/ueiWCXiT2Zg/QLhg4qADLipaFQq5EKUXaiBIH+jgL?=
 =?us-ascii?Q?n8N/+7XUVU4z4Gq4fl6kzLIva0fLcxC9nmnoNPWO6RQKg8PXRYLxkBs6Gzu3?=
 =?us-ascii?Q?EfV4DlG6pdLgCHClYRG+LRSOrufYh8zr/B0JY9MgD413Msjw899wzUCF7VLi?=
 =?us-ascii?Q?3/n3bmRFA8ujWvBCBV5LhK6V1AE47jt5BJcv0ZsaOK3apOAFv7zax+V8W/3u?=
 =?us-ascii?Q?6nTjEJtdQz9DTuYYu7js0cCvlMMZvxtBOoR9ANTmS/hevbxzPqrxfyOZO2S7?=
 =?us-ascii?Q?xUPMXkzBNwcwWFbMSZSRhvKrvEGD4O9RN5jS+VXM6sJF2tHMAwUI+y+X0kia?=
 =?us-ascii?Q?GEdI/Dsr/MHHcWqRLM4ZMoi6xGAmg2BfXGxg24MmBRILotVeQVQwkefYEpUi?=
 =?us-ascii?Q?5yKQyMoGSg/jcBCpbWfWnwuALnOoB1UfPPVrhxUYr6eDWUj++h40Lbct11CE?=
 =?us-ascii?Q?pcyNq98wuETASorRyHJJjgzjah2VxlR/A+FVrbufqMcE+GoyhzfQttYxeQmL?=
 =?us-ascii?Q?EkHYGg9UoCE/qGVr8pEB4jpjZSBDmaNaE1j+fwU8L2L016m0jtog7wHmyIVL?=
 =?us-ascii?Q?kZTLgrEJ9HmZL2qenU//PoNsUazT8UnvBN36MXJ7qOcIrrXVB7amk/Yr2f+r?=
 =?us-ascii?Q?WSzDa/7mBkHbkXrqBQAf5pEZTFFirpaaiFBUNiDB51Lf/kUKcdppA9XFrqA8?=
 =?us-ascii?Q?Htfg6t4wg0DiU2N+LWrn4VkzfGvQMiWiYAbnOU1M2sqgOJ5PKs2/VbffSEvq?=
 =?us-ascii?Q?dy0U1Ts3Szt3yNL23dHEFnpJMhOevz/TW7AFBT6cna9H9wqi0zULVvnkDb4B?=
 =?us-ascii?Q?gwCODLwMfsuDR40PDsdtUvIwd+mDbnWO8dvIGy6WDFlkMVnvSkSB26gutfPC?=
 =?us-ascii?Q?DmButtlryLLBwliaNXIMgz9Hiv/SOdiSOoicWH84ES5fQL3ZfJQQrEExzgmp?=
 =?us-ascii?Q?xTOTtrv85KnAqgfRSG0ymuAXHM/VvrT/9SXrRKfbzXEA+xzsIglHaV6yRL7H?=
 =?us-ascii?Q?esZLvLd3IlE5+P37LpV6upnC/biZCBX0jzVMLM/p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OlUgFPqPLKMZucnYH8K5lPYXono/MEZ90+qtv/YJaqEI8R4wQHHKlXqJ5+CkLgluWCO5gAXtT22PJdYbAwyHkVULNmQgVI2SHth5n64knytISU25clukZtnwo7rL51CqQ2HoeztoIa75aGmbTjCwPClGDsnjF8zPwiBSXOgZxVBwUBYZ5MOiFxyFWF9xtCThWs/BHhFR4aAhQDbHNeieAKfW1QKclDP586w1cu2ZtPL9HEszpcaE6WS4/yQBKhOHsTwCK0ZMa/tqwcfop7wB/ZJV6E9abLJ/qu8Jz+zz0HCbCAMX66PaJVSPl45ePUC3K5ysL7GryC3D0S+vLWtp4/3X2MlVXmQ8TTSo1TsAg2BlXqH1+8T1A0VbEuw67C+WVWWSDP/9imaDAFDkbI4EZVrSlgjA3SDhOnB4nPTveyRdU8Os06GuOY25Qp7WBkHXTQz9n+4PfD2KevJTFGOy7cZn/qmpWz+opE6Dy92nIBt9qEadyiiMN5dOoAraSSK3taJQe6/myl/kJ7lih8FVRMWAbpeDeM4N4lqz/7c8R0B2hY1NhkiY+foAW+Ix/40+wr/x/odRSuEaRY4IAuB8Gu7eGokOv4m4kZ3x5rr0FL0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a031984d-6f1b-44c9-636c-08dc0868f2d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:23:22.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiYppOuEn9SepAGVGk1vi6FgvUJkxxOasVF15mzfl4f5p2tBKpy9LXdq2QqWOzdj5QAB5hKM7lTkSyzaRVjtyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312290098
X-Proofpoint-GUID: O3YhDRJc5qaU-qma9Qx00ADr1_TaFNhk
X-Proofpoint-ORIG-GUID: O3YhDRJc5qaU-qma9Qx00ADr1_TaFNhk

The command 'btrfs inspect-internal dump-tree -t raid_stripe'
introduces trailing whitespace in its output.
Apply a filter to remove it. Used in btrfs/30[4-8][.out].

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/filter | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/filter b/common/filter
index 509ee95039ac..016d213b8bee 100644
--- a/common/filter
+++ b/common/filter
@@ -651,5 +651,10 @@ _filter_bash()
 	sed -e "s/^bash: line 1: /bash: /"
 }
 
+_filter_trailing_whitespace()
+{
+	sed -e "s/ $//"
+}
+
 # make sure this script returns success
 /bin/true
-- 
2.39.3


