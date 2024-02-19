Return-Path: <linux-btrfs+bounces-2540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C989985AC73
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA1F1F247FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7FD59B52;
	Mon, 19 Feb 2024 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GYc5VxpY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Twh+s8PB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317F58AA5;
	Mon, 19 Feb 2024 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372195; cv=fail; b=T0VFjfxKmx6VmlglSeRkQH4aN89phwrKPGgRuohOb1r6kSCPVeYedYgADRqIGuFKIlqHTNg5uTwj5qUTyahJwhTDCCCgr4dbehkOSRdbVotPC7HARRwVCLIA0QtvLZSV1WPjdSIicW2GRWsyUkcSO4kbAop/4gx/MSF3L0g3wqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372195; c=relaxed/simple;
	bh=bfWal707rllY98vKFCZhkX9Pp2zLJZjCfUALUUNbK2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LlxVkVRdBes7PKLMeGd8cNPlfydJ4m+d9bsGeQHF3I+0iRpY+V995l+q7Ea2gfO20Q2RbtlcBRU9Ert6sVw8bRkbjC+J1BUW0+To76ellHRR8RWubdlvVZhC7+H+4tsk278opveRoRhpP343ICs96gjTIw5RiEjSytREXaW3h9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GYc5VxpY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Twh+s8PB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIIxMS023188;
	Mon, 19 Feb 2024 19:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=cCAMEzYe5KsdEsqNQG9R91uuIgHHzf8pzma/J2qOnrI=;
 b=GYc5VxpY7/e8kcNSO0iL0JKzeXhfU2uE3mUE3zXrzvaEAjBdTmM3ZmHwzJI2/VxQPSAv
 Qfzu3G+5uFPEzFmPjDJR8dG/OE1uEfCIxcjbyTiW8/u4VTj6d6XXhSZk9D3mekfWU2pr
 rn8U8xSg+d5sab2iC9dBbqCae2IotaF2ZGR2Wbx/Z0KI+eB4iLhewmJelAKMusvnTXSG
 FKsNDcjMCwtomDxFrb0dwElmuczSFYqG+EP16p016IMNEVK/INwNU+9evA5I/Fy36YYG
 dYOcmz7svkgeayfVuFEbOqq4SRtqPR+hCLrt76+kf4ZKKTkC1DAkwyWDyetxVjf7OIZI BQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk3w372-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIIS1C012968;
	Mon, 19 Feb 2024 19:49:47 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak86aaru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdHRKK8HFxfvPzqBpRn1kKtlpxilp/mFWkwGSObCf5SV9uia+RLAeNqXiSJOykQuCwr54vtbJBOSJrjpUhBZpNAtc85JVPXhHnnSI9dS71tRkFHUbCQzlzlvt86et7zjxd1ePmyv04JyvLswJZT73/BnpeedamQXCFUCJTqCbCA5FKzJSf5R937pw7WmNyv0xS5bCmhOVpkEECQsIq4cq1etO6yx2xzBLe0KNAufs0gt4AJUW1VJQgsCLhfhIWneUb4yjLmfeTxhznliatbEr4Vsz8J+D1NxyVcDThuH4az0lQQKAVSGVgZHkPQpMI694zOv1nQTTRwHv9PEp/XL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCAMEzYe5KsdEsqNQG9R91uuIgHHzf8pzma/J2qOnrI=;
 b=mUT3sbblZOuxTY+nySmY0u3g/MaeN1KQB+5DWsTDbpxVSvcjCi7RTrIBaoCS9hXHUPB6H7+43IZqVnBCP3xVRflRDskn4rXRHw64uXghtt/9uMuH7Hx1bkG40oiOEFqLILGWl3XRYnkI7r4SKJoN6cuhZhIrQPjCB9/SyOVRVadY1vTpTIjjmvqj9EkgyzkiYnDaPd/qOB6rnrMY5UDG+sR9uu96dmLP9tMGbdP6qAWh1xRwpEjHDlYgWGzhevg4B/9CrTMW4lcZKqgkTe9zT7ieYugfKMejFUQcTZPsurSUo2/woKonhgokleGn6bRZlrSWJh3SsQMKNsVovFT6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCAMEzYe5KsdEsqNQG9R91uuIgHHzf8pzma/J2qOnrI=;
 b=Twh+s8PBBwwcLtf449/NYStmbWTiVHrt+v+42zwvjFL5/K8rrll/QXPUCktlHPQfOqPyjeAR80Vwq5bjaft0/RS6Yv7Nw4MpFdxHnmTC/bKge7At4N8siE6rnGkmDaKysdFirNZS/cAOU5/0KZOpK0nzZ3Z2+2lKh40KG/MaraI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6852.namprd10.prod.outlook.com (2603:10b6:930:84::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 19:49:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 19:49:45 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 07/10] btrfs: introduce helper for creating cloned devices with mkfs
Date: Tue, 20 Feb 2024 03:48:47 +0800
Message-Id: <3b00cd9a28c6728ca2bf9c216fe67bf9c01cfc83.1708362842.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1708362842.git.anand.jain@oracle.com>
References: <cover.1708362842.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd38421-c016-4357-275d-08dc3183ec30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4GFo7pkA9zdi3cPVaPiz6fJx+ZimNO5kxWQpH3j9EDs94b7Yq+dFCtksLOSL9Xo138nQp++uIwgfEgGfdl6zNTiRLPO3FBLD0pL1u9N/jMrFJZs/vQWaC0vhlAwvqY8OzD2pS0mGWpn212+4YpS4De0+skoJMuw66xhE1FO/7Rml1cNOM2UZEUbDfh3+7fptbtK8gq3BvgeRra9pmfQ12G1VidQ6J52ZVQP+3VsV7/aDx1PN1Ff11bGcpa1JgyfD5f/5nLQvw24iBxESgXknxoH25yYMdh3e8q0hTj3tRKjA9eQk0NZel8R17qA79UidN3OYmpopkmTF1j5s5v2Y9ka2AIv9ATo3E9glITuhL9rl6EpYJ3FbTfsKgA1hG60fdbGoB+Uxlk6RQ4OX6trSAoDj6NSqN0ovqhOE0nck6KAB0xK883wttvRqVSTDKN8Tobgkua9Bo5dXAxtQRLH8JNC6LFdxztIsBl2PNGpWq/rP3SEsvacghl5Xf12pbJQkLB2ofegdQtnHTZmcr5aorwQ1u9wfzzOZqpTzuWfGCFA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NCIdOeaEPNMSuCKrkzBQ3Gd2z9BZrw/fUiSFA4b4HLXji6AVSVa/w+V+QJRk?=
 =?us-ascii?Q?xe9irhCTUejAxAeHqz8fSQr+aRvgX8lns021ntl4YRkRpLUY2Q/RgIJACrct?=
 =?us-ascii?Q?hNlauhUe7HWubH5bU1yhsv1ItZmOmK1qF6U/KQcYJ7kd8ZMadyA7QoOofr2S?=
 =?us-ascii?Q?LTls35bWJI9daUyzIJjozX9Ejxd1KYeTmWtyjJQyJoIJYF81W18M7aWq1Hdf?=
 =?us-ascii?Q?K0App7HLju5G+A+Z0WMBwq97PvgO15kdTi7wKv7288K5Eg2tnSoWH/pBONhX?=
 =?us-ascii?Q?UN7F8w+7NEgtdQWhJ+hP9+MIgtlRDpmPCLCVvqkIbAul2/Fj5dxlwfKWB/Vt?=
 =?us-ascii?Q?+VLsI0a1hxz66prjLWuwa5YDju/kPSjwult9IuBJ55h5FjsBjrjNxlb2Jj1f?=
 =?us-ascii?Q?39GkkzHR7Dv6rX+7TVLJnoC1fLF4Q8SAo+cCWHoPuu0C+B1r0VLRPZkAB1ZU?=
 =?us-ascii?Q?zwCc8O96/X4vDABUrwU8xcC9aCnDx+2WOCcwMi8Yq/OZHWNuNBC+edGpRU2M?=
 =?us-ascii?Q?ayIRPNTCJQVsc8Rk7YfFFojh1qhwK6TjxpznMBMWYlnOZiBi1fLf3jG3TXFF?=
 =?us-ascii?Q?iiEYcMf36AeqYd2NuDRLbOBqH0hWCV5aovQuDQBf1VtM8u7g0mkAYG+yUvGX?=
 =?us-ascii?Q?J7Ra11P9NMXLK+JymCaVnujQgv7WJuPHX+fBTJWktC90vNQXzu2xCQP6vFN/?=
 =?us-ascii?Q?as16gAHpWxiZn83KhIEmlFASVNPa9fccUxpfuzLLmohIpjxiJjKXebpLlQ7g?=
 =?us-ascii?Q?YmzZjrfTW+LFIvfcWMfPjCehL+nFAE+lm8puTEkwpTaLizwJi+XrOY/rMp7p?=
 =?us-ascii?Q?zqGztzbbdNpLex+YoJoqkMD92tp8rlokGfAMU55D6TdyzzeuSq1kElvUJeZ7?=
 =?us-ascii?Q?Uzp2RAhTK53x4wwjtHDViZqWLoeR1+fSrh3HSHBJPXEIE6tcLZdSDs2/uTs8?=
 =?us-ascii?Q?KPr+ZVLGV80smfw0KcfNyQg7BUxCZdPcCjhGhhLr1ygfODNDB0g8cX0qINuK?=
 =?us-ascii?Q?yI2F1rpR0Im/+JufB3vC4ZhZbI7fpDQNFUNv3CvF5nDYxu/3jqyetGtP+VPY?=
 =?us-ascii?Q?syFjqZOVeiTc1qQFgPe+X8l28EjCkTnrD3R+AdTHpXbd2iXTQ2IdKMHVwpUr?=
 =?us-ascii?Q?bikVoSI38pJCCT2EI5ZQF5VLqJunajvlf/Pj8E69inc64jWxps4u1bAoUYM/?=
 =?us-ascii?Q?KtRO4TRfXmr1yBeoZgNDsMP5C/JcVPOw6r8ll1wi1k++BEX/cdl+Jm7q1S0t?=
 =?us-ascii?Q?JeUxk4F0aBkCJS5RRja97HfDliZhX3kSzrtrS6i1tl8inMiRR/yLS4X2Vboo?=
 =?us-ascii?Q?mgOto+AJyj5MhWZhtxIn5zVzIY87KCK4plSJy/sE/WkXA26xxQVXtZ2OL8Ws?=
 =?us-ascii?Q?3Vs2f5RoOgG/PihPh+tTpGWZUJkrvs7Cz9/J3LTYvSm1NO1WhL4mDD+3z8wL?=
 =?us-ascii?Q?CFXt2cdM7D1ajPlIU4XHHmXPE/oZpgF0YqIrC1TJqFjiFqj+8zwhtYL/6l8C?=
 =?us-ascii?Q?T2oR7J9t/rwV4W/Q4j6zoVMXMa9JUuZlbmLVQxaAeAtgPneB6AAMrXWMjx3K?=
 =?us-ascii?Q?nUBlkuvQ2wm3y/eRWVo6b+t1PTfcHWtw25Zl57jO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mmSLmX8Y8voQUzMNd7NCSj+xmdoQ67/PiNujBQ725mORIJq7Qpv87H9JufN6dm5banDKHMI/f1eXdfw95ki/r/13cC5GKgUYVTT3qkHhZNGKPZ5XKSyBh1KGRginBlvvoiluFS6JF27ydC0iB6d7Vsl2MDOioKXRpeq0CIbT7jXllqykFSOkYlzrKGCDRyxXGFKShNyxNMRMmNqL55RwyRpFca1UvqJgQWeDwvgWSMxorEZ4Qaf655GyMGvBxbPGBciccEfGoh+Q+MsGI71+jEQAsXCMRq33wweomnrXrRjQt2Hs1CNU6XGP5JqQuxpQuclpRy4d/IBd3RY7Q8f3ibjH9k3MFkNnr4xlDKJXj1FZ/zDy5bPV5ah8LMVcH/A1jJqv7yLGm3lpUbIh6yyOrh+N1lR9Rjsp7l8odyeyVPj6GZuqvfsk7BW/t+pLMbqz7DTHS9nDVOSJhrVPWnLtgQU+7ZVdT3K4mAIejXqVqifqZPAguMbEejcOoshfD/FhT3hRkuFzSMt1PWHE5lTjxD1/XD0ays9ovVU5Vg1i+1SCoflLifGagbVWj/yyqNInTGs1NMbU08tWw9dcO9TkKf9nZdZRMNUedxCXxFNZybo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd38421-c016-4357-275d-08dc3183ec30
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 19:49:45.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Su6+9J8fjNH+FgdASPJiPIIyHFUuuJ+B+8qQlFb7CIQUt/kUv5pUcKmR89z7uSPNgKo2MtMGUOIBm0jHyvN53w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_18,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190150
X-Proofpoint-ORIG-GUID: LSg1ohvFj1cF70aW5GLqsx8LYc14LBLY
X-Proofpoint-GUID: LSg1ohvFj1cF70aW5GLqsx8LYc14LBLY

Use newer mkfs.btrfs option to generate two cloned devices,
used in test cases.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
 Organize changes to its right patch.
 Fix _fail erorr message.
 Declare local variables for fsid and uuid.

 common/btrfs | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index f694afac3d13..c3e5827562d6 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -838,3 +838,24 @@ check_fsid()
 	echo -e -n "Tempfsid status:\t"
 	cat /sys/fs/btrfs/$tempfsid/temp_fsid
 }
+
+mkfs_clone()
+{
+	local fsid
+	local uuid
+	local dev1=$1
+	local dev2=$2
+
+	[[ -z $dev1 || -z $dev2 ]] && \
+		_fail "mkfs_clone requires two devices as arguments"
+
+	_mkfs_dev -fq $dev1
+
+	fsid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
+					grep -E ^fsid | $AWK_PROG '{print $2}')
+	uuid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
+				grep -E ^dev_item.uuid | $AWK_PROG '{print $2}')
+
+	_mkfs_dev -fq --uuid $fsid --device-uuid $uuid $dev2
+}
+>>>>>>> e22bb3c816c1 (btrfs: introduce helper for creating cloned devices with mkfs)
-- 
2.39.3


