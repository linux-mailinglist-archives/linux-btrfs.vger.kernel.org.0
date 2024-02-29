Return-Path: <linux-btrfs+bounces-2890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE9C86BE80
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2CE2856CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DE03613E;
	Thu, 29 Feb 2024 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YGhGmd3C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HJufbwfE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F652E84B;
	Thu, 29 Feb 2024 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171446; cv=fail; b=sT0dbTnMjJhrlXPFL8b6S7Gj1ANoQgM5ZKEtp3/UMsCKYgrXilmBwBrxnoRoonybSqYW4mTlUDc5K8QN0PiubfOSdVtQFg+F7/rPtw80S0PnOf8C5CdRfTmi9AX/mOBGFbJmnD+2kr53riRC416eHp6LW1/vOfoOXZmxmnlEAw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171446; c=relaxed/simple;
	bh=8iZ6C1Q1kvBanXq+t4ly1UUCidTL95tTgAp90O1/ZWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LFtElKaUqg4zbl1BjmMufoMrQquCZ+Z3sqfgvpU0cTBeOTUPeLG3gJ+e4Ave7Afdpe/xaqLuQ6NxXQOzEHlWayhpncDR5YPnFpSQkGK5s5eHdzOsWNxWoPvhyBXNvcfwY7YZVTM7kyTVi1vJroMgCjCGoQuIz0um1zV7crQUzIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YGhGmd3C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HJufbwfE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SK9Am6013086;
	Thu, 29 Feb 2024 01:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=wbl8l4Z0MXKae8+t1qkGI6PiKlGmmDTsF8XdL6w6O8E=;
 b=YGhGmd3CTnWQsIurLIpX327WYIiccHTwOj5JC5go65vUbruLlGcTEaAj9+6uQUEB02Vg
 BDyOvRzn95TBFA1YNliz4B0F2tqkzvSdo51ASormYLvpsM+YfdD8JX80NDWtvUHGCY/P
 yCGQSHF4O9RDaemRM1yjUa8qVW9RGLwVKhCqIRfx2BhtiUJKgsUsPYdCDBdBLctfW+wT
 NwjrIeD21xwoS7fD9YMGJu37KCJzfrm7kba3OJeToSmOgC90Ter3/iiQNEP7P5W93s4v
 QvQBdYDWBW3+s02oz13IuPLxtSP8FTpS1dfrgFist+twSa4v7QdFcBxtWBqgJuRKKIeE 2A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90vbx54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T0GfUT001691;
	Thu, 29 Feb 2024 01:50:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9tbh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvEcod3L63Qm5xoYtxHGdZ+ZwNekh3u6UDBJpSZWN9jr0c1bcDHbUkaooIAboWuhOPrFS5+ppvvtjDt+5yTDx9fF3nwpsZnb6G7hLFnPTtO8XWSxVbpkgM9W88/eoUDP3eDgouL5S5YiEF0HgBihNSFeEvScYtR2BOXIoxI2CBM6AcrjiKgZaegsw9xrDaSTIXXieMMG15zW+1N0g+D64TnuPM4SouYDuX1NfYFRSN2S7kEqy3iNd5cRFLcG/tOFrQLDlPla1yYKX6fIZM7Nzwihw9I9fOz0yB+Axt2F9i6fyQlOgekFkWygDj+1TSS8uM8sbBaqS0D64xbgoPlhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbl8l4Z0MXKae8+t1qkGI6PiKlGmmDTsF8XdL6w6O8E=;
 b=jrit81EBF1Cd3RPEIqXz0LZeLQdc0G0DzEzO3lGC7ppu8dwsi67YLa35qaQlMCFrDceSZKOOMAYmCf5uQR6D69a4GRnb4vjoLElh5nuz1VRW7tm9sOtTObDyMIeYeea0KFcnC/6T9J/4r2A9HgymFNpVMM43vY1VZIogEiBHk4Hp9lVQeQdTauNPMIQiEo8yrITpW/mT6GfzHT9Ak1Mhe5nIB4zZKfjVBoyayfMnb6ncmrsh+cnrQmHXu0qI/s5aWAQ5Oa5EHLPS/MBM94OlO0ivBUlqv7u0+jquY5WA1kc/lj24wqdMuciFPe9/eliLW1LLbvXKJvknnHM31FGZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbl8l4Z0MXKae8+t1qkGI6PiKlGmmDTsF8XdL6w6O8E=;
 b=HJufbwfEZZ25CCMhU7a+fYP7Srm1cZO8/73WuZqHEk541dIIhPexw+s9vF2d6kKTGfrduGCueWEWUqHR4g84l2+EtalE1LQcB9Yubjzv5GV/QRXeIXOij3L2wQcGlTs6bstVlnDJcEx2azag7FKLjezr4JnJvDN2vG1dcBTd8/U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 01:50:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:50:39 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v4 04/10] btrfs: verify that subvolume mounts are unaffected by tempfsid
Date: Thu, 29 Feb 2024 07:19:21 +0530
Message-ID: <9c7e30b26d07ef53849d780d4c5f3b8d0d88dae2.1709162170.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709162170.git.anand.jain@oracle.com>
References: <cover.1709162170.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b99ece9-3afe-434c-069d-08dc38c8d466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dVBCEA/LLVqVyQZfhpiOa0EfO+j8v9yE+l/f31Cv6XHPe5nXu5RGi7zi2RYQ6VZPmFqc21GJtlHFqZx8rvVqUus4jPlqP8mEaJghVz3niSxg+VvAW0vb2/Gx8ylAG0gltJqlhX9ar3mbs8qNTY/9fdsoJeqTtsTqkuqjqXpPtTI9gZB2ncJEtr0jThRhPfLJOwWtRhmmG8JCymRGDexUnL6ss745Xiw0fdPPyeQleQ5coUeeIbAcyXBMJm4Zc5YzXNeH/Nl1kehzU8B/aJ8w9onGDt6yV0TtzxzMsFmGDsE11GT9NZjTxCzxC5pTXbErDJV2Ig/tskOG0SWRND3I11MPlvOeDtJmbWSTQd8CFtUbnMolRTAd9EN6det+0r2L6/mrbEmdHdl2a9tvkY6xAiVsZe/WmzGaRQPe/b6zo1b/OrPPT0/gH58TwyOSLdabQi3vDbVJPbXKnHsEsF44ZnOxxGHfQFkQ5m3ay7hjG767+WoHHBP71juCxiECS72Rc8LOnfzBqr9rM549jtaxBMXgm4k2Cg9Js3OQqgrXlwKLar10W/rhVVQNlMzlfZ4Wrz+jLZZ3z6YZv1S9AQAOF4/6fvV5SYiJYiivY7N/wZAGNQypDExs7psNB8ydtMl+wZ8AZu56PQ85nfs6KIcD+g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TEXVpe0LrP6ztq5TKQEfM3yMcsmU1o0g6vEJlZNLz7iYeUPFRrYYKK8i68cI?=
 =?us-ascii?Q?1TbzhN1dGHTuY2LTuZiKqSmCq2l8FvW4/BLnjnGc6xW3A+YdV3s/WHOtckfi?=
 =?us-ascii?Q?V9fb7oB+PM22b25ejwz/EMyk3smsoPvjIrA1bJm4d+E9DOUjS9hkY+b4ft2v?=
 =?us-ascii?Q?IjOqAHsQMS7hXft8bgMACaAyBHwP3KSMc09LmF2G52n6ClIPl00iEVItwanM?=
 =?us-ascii?Q?lnFkiZc4hSavptvU7kmwxJZIh3guVHmxpm946PLgjU91CWjASGRVSptmzo4p?=
 =?us-ascii?Q?Tdc+Eu9WK37RWa1eIksJBkVVCY8qnzpaNFmSZzLO4l6Hiz3ICjmuBkhlitxI?=
 =?us-ascii?Q?2DPc/g4pXqEkwKAe5/3hDju701s/R95jIlp9fA5HtiGpXpqD1WHcnfgt3hf2?=
 =?us-ascii?Q?YvpmUxQUG7AOQd2rsn0mSG1rmkAevixqH7RoAiuTIz5YGKH8jB4hLi5ChLyp?=
 =?us-ascii?Q?4LmzVYjS4sV0e9RF7ZyzXA7q7eJ85e5crxHV4EAquUQPFzOsdcLIlPjHfSSQ?=
 =?us-ascii?Q?bctOWyXQBz5iGxrR9xY11sPerOR7VG8Lg0ccgY5f27EyVoRVb8QGgP/DxLum?=
 =?us-ascii?Q?euCFoQnjrQVJPpM880X6Zad+We+lI+ZDoyQsB9/I3T76PG8wbSoMs2Cre13I?=
 =?us-ascii?Q?yv1UWil0BHq6W1lzk19M6j1QoW6aAsN/K1Rth0I12XYEBxd5SdzI4oVHY76q?=
 =?us-ascii?Q?ApU2lcL6XQJKRutkDz8Jwlp/Fv9aAFOGFP1hvL43iHs3RWe6akolfQHOnC8k?=
 =?us-ascii?Q?oSpDbnEs+Jvtr4h+Uwh/l0MYLloALs0WFzbmCjyTMFRB+UN19ZdYzdMDft23?=
 =?us-ascii?Q?HjRTP+AyxNKQFZw59fNQdyS3VSx0m/RaCXGHvtso2TozlTOCsGnIX7l41P4r?=
 =?us-ascii?Q?SyqvYaa42GvzEz/rlNRPJRt6JDY4XDnrNs2SM4NbEMoTqujQwB/BE9A15rfB?=
 =?us-ascii?Q?vacVQ+t7cPcze5GXUxeYG5R/4TUPd6p1SaTBM8/UhZRcszmNIgUP5/8rRAms?=
 =?us-ascii?Q?8DXM8HmJSYXQyZdxnH0Nj1AgLroOrFLIb7rx/+XVDecpMwXOoW3t6s0NSCHi?=
 =?us-ascii?Q?62ZV3Sz54N2B47Cav3zsDjXcaMBP7EwkneHm6epFQ/fwH/t0L3bVwqrt4aC3?=
 =?us-ascii?Q?JjGlM/6sKkJYOFWLTybMvEIdS903Q89EpS8nb8pbV86WcpYc1dL6kGxuKa8r?=
 =?us-ascii?Q?LSzPUPksF3PWmBmxD+Ol+gycg5o+ejrFgcGXqzX89C1BqLovpxf1dhwYYmQq?=
 =?us-ascii?Q?69E8yzOlAsXvg0pV9Om1koT1TJBTv+y9yigxOaqWdgl2KRRn6XYjaaU73MIm?=
 =?us-ascii?Q?MNxrx8L1fDjJ9pXLnmVuaGGC8jKqb9P7E3UZU8LOxHy0wkKH+8beyL2HLWja?=
 =?us-ascii?Q?dK3f2t17QbPs6LLvsU8SRNNaJg7s3/96xLsnh8vr0khcJfn7c4hKmbaYRPLz?=
 =?us-ascii?Q?HMvgl8buQXpxzN3xVv8O3J53BoF9CEWr15tnWUZBZXaUFgkPy1olHqZnObFz?=
 =?us-ascii?Q?oIMNtnBCTE1l5dcxj0qnRqwo6U4OE7PAykmiV2ZucBkWdEc6GIT5RMhKdA0L?=
 =?us-ascii?Q?X/SpD/bhobo6/gdVfnDbV69diu7BRIQZzHo6em80?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0uIlHuCFEfxQ/FeI1xx/8cTGprkQacJSdn/tz/XGOvIw8Los61821vCqPI7+KHFKNvkDQqL7MOxncKd7aY2yaxtPu1dIiUjgZUDx/+4a4njxZFP1mggPJxvtI+8QnOxCRf3G/Vc4xvbblb7dgScNSuI9yWAlUOCsStNTZqFghK/0vL+SdwLEoZ1GsdOj//xXxMY6aEFdXurFiRO9ykcVut8DH1vr86Hvg3/jig1S1WvqZCSlQJFzWRi5oHnatWQ0AmpMI4+nvZ/eaWfISYqSZxao9s+eEjLJzZYHHa7TcIRhp/KUVsKa5D0Q3bq2GVf0Xb/Bh0K2zawEU7kF52lSrkJjE3N7NinB1o7pc5bQ+27zQVmffU0GFxYN2w+yseZIeSqljO83naRF82kOp3fagKhvposXZfn4pxV723DldW/Pn3XTNctBJ89XCU4yseDmirRCo0ZRwTzrj7yHhN45zeYglmQ5MMKagE4E8qCmUSHv8p1Le2BDe2nekcJq3ALyd/8op5qBB1hegTj4KbTpdzG8Pl9i/86lhCx1OrBDpud3dTlPcpdRh4MK4R7FcQAf7Q/nLmHXElPWYssFXVHx9DKvz0bHv+Kciv/ttq5pfh0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b99ece9-3afe-434c-069d-08dc38c8d466
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:50:39.0873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AT+rR8sOED/Az5rA6y7eHIPHsZKkFAFgKPnsXCjLRFfbqtu9KKjawpTuPk7Ey1L2800ujnAKY3ZfMQrHCfbxkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290013
X-Proofpoint-GUID: gvRNydBcxfhSymCPk1OopD_S8mosQLxn
X-Proofpoint-ORIG-GUID: gvRNydBcxfhSymCPk1OopD_S8mosQLxn

The tempfsid logic must determine whether the incoming mount request
is for a device already mounted or a new device mount. Verify that it
recognizes the device already mounted well by creating reflink across
the subvolume mount points.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/311     | 87 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/311.out | 24 +++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100755 tests/btrfs/311
 create mode 100644 tests/btrfs/311.out

diff --git a/tests/btrfs/311 b/tests/btrfs/311
new file mode 100755
index 000000000000..7de8f0512489
--- /dev/null
+++ b/tests/btrfs/311
@@ -0,0 +1,87 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle. All Rights Reserved.
+#
+# FS QA Test 311
+#
+# Mount the device twice check if the reflink works, this helps to
+# ensure device is mounted as the same device.
+#
+. ./common/preamble
+_begin_fstest auto quick subvol tempfsid
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $mnt1 > /dev/null 2>&1
+	rm -r -f $tmp.*
+	rm -r -f $mnt1
+}
+
+. ./common/filter.btrfs
+. ./common/reflink
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_cp_reflink
+_require_scratch
+_require_btrfs_fs_feature temp_fsid
+
+mnt1=$TEST_DIR/$seq/mnt1
+mkdir -p $mnt1
+
+same_dev_mount()
+{
+	echo ---- $FUNCNAME ----
+
+	_scratch_mkfs >> $seqres.full 2>&1
+
+	_scratch_mount
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+								_filter_xfs_io
+
+	echo Mount the device again to a different mount point
+	_mount $SCRATCH_DEV $mnt1
+
+	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar
+	echo Checksum of reflinked files
+	md5sum $SCRATCH_MNT/foo | _filter_scratch
+	md5sum $mnt1/bar | _filter_test_dir
+
+	check_fsid $SCRATCH_DEV
+}
+
+same_dev_subvol_mount()
+{
+	echo ---- $FUNCNAME ----
+	_scratch_mkfs >> $seqres.full 2>&1
+
+	_scratch_mount
+	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol | _filter_scratch
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/subvol/foo | \
+								_filter_xfs_io
+
+	echo Mounting a subvol
+	_mount -o subvol=subvol $SCRATCH_DEV $mnt1
+
+	_cp_reflink $SCRATCH_MNT/subvol/foo $mnt1/bar
+	echo Checksum of reflinked files
+	md5sum $SCRATCH_MNT/subvol/foo | _filter_scratch
+	md5sum $mnt1/bar | _filter_test_dir
+
+	check_fsid $SCRATCH_DEV
+}
+
+same_dev_mount
+
+_scratch_unmount
+_cleanup
+mkdir -p $mnt1
+
+same_dev_subvol_mount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
new file mode 100644
index 000000000000..4ea46eab3c72
--- /dev/null
+++ b/tests/btrfs/311.out
@@ -0,0 +1,24 @@
+QA output created by 311
+---- same_dev_mount ----
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Mount the device again to a different mount point
+Checksum of reflinked files
+42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/foo
+42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/311/mnt1/bar
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
+---- same_dev_subvol_mount ----
+Create subvolume 'SCRATCH_MNT/subvol'
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Mounting a subvol
+Checksum of reflinked files
+42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/subvol/foo
+42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/311/mnt1/bar
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
-- 
2.39.3


