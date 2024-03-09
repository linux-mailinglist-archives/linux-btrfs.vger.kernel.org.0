Return-Path: <linux-btrfs+bounces-3142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4B877039
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 11:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDA11F21385
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3108338391;
	Sat,  9 Mar 2024 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kV9dvq3v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FPNjt61i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB2423DB;
	Sat,  9 Mar 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709979102; cv=fail; b=dJ+Dzjfp6WcD+fS5+RKVmsXd9+I/22JH7hb2OG1IcXzENm9d9DUSAzUZD3S0PEXPjLPoKRvFNVRsQB2MJe4JzHvoDz349XzO6vw2KaV71c3Y6XLRPyhRTQujPYP77xkPfZm7MQ2gZZBMASZcy53NlOHaUxPxwPiO2PfVDQWGF5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709979102; c=relaxed/simple;
	bh=znaFIi9YtH1kOJ36Pb1/XoC23oDEadO1Y742hfXJGp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uWiyWYz/gXAGGcK5CV1Et15uk5edHo7yY6He7koL8SshPZxCPYDhM6lnHHIm9RKkRiKPlbM9T6HqhZo60JX1CEfH6yB8yRfFPuXUpZcf32Tum1zvbda5O+/Lzf+Mw12nisteSSGipD0lvmIp35tyMgcp+ml7GJm8C9wRlc+lH3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kV9dvq3v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FPNjt61i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4299hlln019752;
	Sat, 9 Mar 2024 10:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=IMMgDt09wh84d+pFkBxsH0C5IRlEOMS5ZDZ9lcfbLb4=;
 b=kV9dvq3v6ScxAic2zZPp1Htss/t31aXq78g2sm0oPVNBNINwiwYLR/It+aHyIJulqcoM
 0FkS+kUPAxQxqG329Vo+Yk3g/tl02spCvIhT+VX6Wskei6HMai+ipSdqi/gu2b96gLv+
 21jjnD8YNFTzge9RmMy1T73Hwu8YH+LKilWxLKaUPGmZd1pfyXM/zXIQEMFZ1E0px1B6
 8OTV4YNQwN66ah2GqA05LmQkh438Iszm3pcIT+oiYzeFUlaQA5VsPyUQ1wEnejdOZa0z
 svYJIlrd2K7wa4eBxsxnslrhjZ3swLuVbNaTh3HG9tft3xoQc1sbzbuk2XM80axv189h wQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6e8e9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Mar 2024 10:11:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4299td7x037842;
	Sat, 9 Mar 2024 10:11:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre73s65c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Mar 2024 10:11:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLBqC5tO+WngxCqcMjx1kKzQnpEUTWzJMlEvYKVhLeMBYWa8vl62/53EyipHfL+FzZaLRTVWoqx9i8hQbyZ5OP6ukZFUUcywNaMFGdhHSadML/msVaAfJs3k398VHtBL26fv8bhIkhfwgw5rA7HsEvwiyVqJ03fMcZBObn43MsVOJbPKWn1HmsTrzq9FlDHFmo7aV8Z92Xt1V4rTUGmlm3nzSSHTXCjj+mMq2++q7vRDLbHmRFs97o2/nsEmNlAkuIocHSdjZQsnws4pH78+VkRWKHY8z2p8CS+Kc+Z1MOcau9nHFNu/bZz8q+m0lhOdrXtDfrFmeXo8d0T814JFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMMgDt09wh84d+pFkBxsH0C5IRlEOMS5ZDZ9lcfbLb4=;
 b=LDerNpecee9fReahsMTBSfo6/lWkDflGo2CWlfcbh21NgOY019v5Hxkt1HNutNVxvFp4ogIG3fx5hPMfY3LN6+g4GUolu9P20T/P1rxo/j9ZNmYUCRcV8cjJmukS+fiDEAqF5e74Ab/sg78b1nL2habwrOt+3+4FNabF+bP4sFRfx/8hnx21WICs3eOPMWJbxtiWetmcskjDTG6Xj+Oxsse6s5Zzuqig1ESMAEmtpwWeW1TnPx2gv/dm4YSToJIzU1VQhh4zWHm3xmpfKIS3jAKugVWep3ZdFE89FiZ01WRrOkotseSViX0rnDZ9otsTCGVy44ClgNlAMejnk7HSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMMgDt09wh84d+pFkBxsH0C5IRlEOMS5ZDZ9lcfbLb4=;
 b=FPNjt61i5xv3FfcnBQIBB++X95Y1xGU0loe6Htlm16cISgimYi4qPtYKObbKc0y+9UbcqJ61aQhQgjSe7jineqQj5q/ZbSbbh1HTcwGqOMJ4JvkfHVDBwnhsvwvsmsQbFt0yYbZ9bNalwxjESE2h7LQQZGyVoAgBifq6OyTkbZI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5167.namprd10.prod.outlook.com (2603:10b6:5:38e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 10:11:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 10:11:36 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] generic: test mount fails on physical device with configured dm volume
Date: Sat,  9 Mar 2024 15:40:35 +0530
Message-ID: <16996ed4a60e1bd4d3cb44d035bf9202e8ad9f80.1709970025.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709970025.git.anand.jain@oracle.com>
References: <cover.1709970025.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: a03442aa-cc4d-4962-6e8d-08dc40214d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nMMJ3Dfdhu+PEEp+FjuTJ+DYIwR7ibXrCRP1LtQrJz7FGjUQvHFuyjbJchbFrLcfZX8ErKrFGmxy3ktK5/iHg2f1FjFStMF8tfC7Z4ow/pbLRDc8ETi31f1jG9SVnUfNzci0E0ks0WsNoPkAFWXYXnAClEvaCL1te5G6r0aa22QTNqhqBY+OZku7ZKoti88IYhfZGB3CGjP0QPDCzMvIOSmuJ/NStMMn/22bO5DJ8dUADHteXBsAz9v+Gy2WSG7QtrCNB6Zv8lK805m0t+V4NqLndWXTpYeVFpZsTAnWXavUnWPIh3zB749DT32O6/UV7nI+zdn03+3ZIF4McdCoXKIfqG516Q5dIIyyAWYaLjid+Hcsv3/KXHNvVeRbjjyS7byD8OIn3HTo5exHolb5QRQJEVvkjthJBFITEzIBfmLV0SVU+ctA7PB2q35zBdtk5ipDNpD5rFytVXVjMXf27OCAVmqGv/We9OlFYEOXfsq2ew2m7GFGQY4kj22sXs/R4ZD/AI9SvjvxwxE2YY/iv/jlEoxx3tMelcwEPZQW4LzE36RpYMDbTgzW35b/uyFz+j1Efd0yzi30tZ4JOt0cwyrYUvEtFnMJu5hYzhdOxcYvSgk76s/PJT8xahrEBkPZuUwCP6tOZtuqzH1M3RasGkhZWH78uUEbLYJNWJD55IQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/+cyIF57IyJkHCAEj8EZp3WOYmiwMyY4M0IuXPH+vrQ5vUhowoNgTIgV1oIg?=
 =?us-ascii?Q?/69wMXBtMkQCm24m0zch2t1D3RbOxr5ZduaJ9mKlb+CNYREQAoMK9c6REBdh?=
 =?us-ascii?Q?nFsLUozVebFtr6ngJ/u4oGSkkjzANyecKGLvtFVDkAkLxocU0NXwkDE5TEyP?=
 =?us-ascii?Q?2De82JpuIMYLzTkX4Fn3oyO5DjnfXSqDtgQQjNdtXixPlnH2+hWq5Q7b5ti6?=
 =?us-ascii?Q?4EVBW142XkPDjbhFrDJDmhiaZ9RK0Da2/vCflDn41O9SpXt8QDggNvoi8mid?=
 =?us-ascii?Q?HzhX9OBjlsCQIJu2Dd+Uc3Mktke5zxMQFfYOXIY4EsYa5KuVJYQN4d7KAGwW?=
 =?us-ascii?Q?4PbSwv4dyRrJk6y4lAal0WZKF+HjpiMJ/dLIANv9RT6Cfhg0rPbhQSidz5Fd?=
 =?us-ascii?Q?1SjRBXYX/vwIPKsy+oUulgsUQr7TcPDl4ixP5HQrxrv/udN2RzRlro5MOyUS?=
 =?us-ascii?Q?qTXMP6WPla/ZMCiXOdosZW6+nbFsgZfsOTTPA2EY9fc/3tiDPWL7H2luOrbX?=
 =?us-ascii?Q?vm6z19mrZhCD+viUwGcy6AL7J3CRKBUAUDMZjU+28BOfZiOxyqTzHexsDe0y?=
 =?us-ascii?Q?tv+GF/zv8VLBgi/GJd6I8evw8fHY1pZKcEx8bVS8la/EUODOrzoF1AUFHEnL?=
 =?us-ascii?Q?3lm5pRyP1S8MQdlkPcdSixrx1tpdp7GLyWY59JoMyf2OM10NHKZva3m54l7s?=
 =?us-ascii?Q?/uG7ySx5PZiinqqz3jXpjLx4xQQbnOGbCxcDe5TyXHOgSWGWYpBXp0Wfmoed?=
 =?us-ascii?Q?kNNd3PE8Tf5sLLn5vGi4UtKc4hNif6LYclJTjwKgPLCHhHK5eswL4mr9ncen?=
 =?us-ascii?Q?TxOklV1FwVCW+93gbjjBc6JfK93Z/9HH6H1zjTEsa6Geg2hqKYXwENO2SS9x?=
 =?us-ascii?Q?vVHi4BXVjXPzqkIZ7YnHLiNSau2aeFXkbpuOr/Ogpp/3PZLR2mn3+f1m1fDf?=
 =?us-ascii?Q?cOnjHLFKlYeZnkNpWBhMqv6Ky57FiGkZjpMX+jZqUOSuA3AFT8SGp6AZ93pb?=
 =?us-ascii?Q?LQIRYncE6MGIBLOZw89nGi7JR7qBmDSZM2dZH4R02Xi3g2IMt2Qc/GEgEYjF?=
 =?us-ascii?Q?/5KWVmQB5cLCK2+exMmga+33DI3or9aAeH3PzdyKn1dhEL+6R2V8ksV/R0dS?=
 =?us-ascii?Q?sw8hqPaAJkLxxX5NRWHyjuXSA37YbVSAJZciJ6bXCVIk5xzFQxwkIBi0pbLs?=
 =?us-ascii?Q?p3tuzNvehGmZoE/gWbs/OlgkfSjjMDPQZieO35APRBndpNSYHE+gojcaK/A1?=
 =?us-ascii?Q?a9k93R1wfQHrD8pFJSBzqAIoQIewMoLP8J8xSsYNmQOlJ+KXf+sqmUa2/OEB?=
 =?us-ascii?Q?kCJbdCLTXM9TqEet1pfZouBjwmolse8MBRvoy/SomzT0zNMx4QqCNx6JwsEC?=
 =?us-ascii?Q?898IKyCVnvCJk7BVAk2zuYsZnXVQ63OtlRLophDsZqkOIwNEx/yIQPtARKv5?=
 =?us-ascii?Q?SfVoiQ4J10wuV+4hQDGsbRwZw9HfTaUvRp7zFK/yaraSuFAEeOEC0nHO9f2h?=
 =?us-ascii?Q?oR5MxMYFhTpqWhLduIV8lqZVurpdfnUsv+6hFaXmfP3OH14a6AZZCKmlIfs8?=
 =?us-ascii?Q?vQ3Or5i+cFQjU+PnNg7wlhWrf7yHGaa6gD0TsFeBx6BoEp6s9KWEGPwY/IPb?=
 =?us-ascii?Q?nqJF2SJ1VzzAJDXLdmHRsofcP+clc85mUYxv+hWH10zTpPd+pi7z6DRRwrnM?=
 =?us-ascii?Q?GYhPtw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ai8zIc7/lQVV+cItQ75rAL5LhmCETkrIn7rl9yg/w8cSjMUOoHPEtBmUyEexJ0xXmJo6HOmn7buJ0yjlBZjm9ILzLMqVy3rjvF9/lRG7CdWE0j2MNK2k9+0UEsyCvUFTlJzLvZcfdPVK5Z4YMTTqGlLBWZ+PD35hYxkTYxVIAtQqe4uobQzfvA0zhGmXA9AiA9cB43Q7w3OVBlE9BVZb2HhOMe1k9q2cPbWDpWcae9icRwGUsXu23oQ8LODetSekLreIJ2TaIbFHpaeVBSNHf8wP3sHbBkrigSglnz7WPQNPl7gJTzO1m7qzgP4XKqTzTDSk2Emw2dEAsd4a2vJ4v0+D6iJ1h13k+SEeIT8AymYi7SdHjXvlCJ7JJ1G9bDCRWK5zeN700EvT88r6Awijz+mUxnnYcJ+P7+FWamMUyepFyWYbYCmIyrIRZhTQm78TCmu59ObJmZyzf9ggTgIbgCFfEasDopXkevfDPhc42e9obAHA710zqL5gtRb7n7MSP6aikGHwUkLVM9vXYJPCCfJ4rpreHKRF92ZypxqVjom2uBQL32/P4aKN78yu+eVQSjZkZgePmKEO26b12WZkgxTsuQxDSURONljsQUJGDuA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03442aa-cc4d-4962-6e8d-08dc40214d70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 10:11:35.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsTRAS31WA+3GbYv4O3mFMcGb6u0VvCDlYIH9TXCuNCtycjW5BhYShu4p33u4DSFQWK0VWr81bo+L0QaWRo7LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403090081
X-Proofpoint-GUID: 2zCX7sXnQx_63XLgu1Xx2NrSvpnTn8_J
X-Proofpoint-ORIG-GUID: 2zCX7sXnQx_63XLgu1Xx2NrSvpnTn8_J

When a dm Flakey device is configured, we have access to both the physical
device and the dm flakey device, ensure that the physical device mount
fails.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/generic/741     | 60 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/741.out |  3 +++
 2 files changed, 63 insertions(+)
 create mode 100755 tests/generic/741
 create mode 100644 tests/generic/741.out

diff --git a/tests/generic/741 b/tests/generic/741
new file mode 100755
index 000000000000..f8f9a7be7619
--- /dev/null
+++ b/tests/generic/741
@@ -0,0 +1,60 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 741
+#
+# Attempt to mount both the DM physical device and the DM flakey device.
+# Verify the returned error message.
+#
+. ./common/preamble
+_begin_fstest auto quick volume tempfsid
+
+# Override the default cleanup function.
+_cleanup()
+{
+	umount $extra_mnt &> /dev/null
+	rm -rf $extra_mnt
+	_unmount_flakey
+	_cleanup_flakey
+	cd /
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/dmflakey
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_scratch
+_require_dm_target flakey
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit XXXXXXXXXXXX \
+			"btrfs: return accurate error code on open failure"
+
+_scratch_mkfs >> $seqres.full
+_init_flakey
+_mount_flakey
+
+extra_mnt=$TEST_DIR/extra_mnt
+rm -rf $extra_mnt
+mkdir -p $extra_mnt
+
+# Mount must fail because the physical device has a dm created on it.
+# Filters alter the return code of the mount.
+_mount $SCRATCH_DEV $extra_mnt 2>&1 | \
+			_filter_testdir_and_scratch | _filter_error_mount
+
+# Try again with flakey unmounted, must fail.
+_unmount_flakey
+_mount $SCRATCH_DEV $extra_mnt 2>&1 | \
+			_filter_testdir_and_scratch | _filter_error_mount
+
+# Removing dm should make mount successful.
+_cleanup_flakey
+_scratch_mount
+
+status=0
+exit
diff --git a/tests/generic/741.out b/tests/generic/741.out
new file mode 100644
index 000000000000..b694f5fad6b8
--- /dev/null
+++ b/tests/generic/741.out
@@ -0,0 +1,3 @@
+QA output created by 741
+mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
+mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
-- 
2.39.3


