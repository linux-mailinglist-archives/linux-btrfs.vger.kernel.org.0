Return-Path: <linux-btrfs+bounces-3342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8063F87E2D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 05:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93F91F219AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 04:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8095F208BB;
	Mon, 18 Mar 2024 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DEOX6oMZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZF1pw2Hk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1218B224CC;
	Mon, 18 Mar 2024 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710737240; cv=fail; b=VvZbo/SyYCLzn+Gy67V9Qkr4pdpNVA1nfWRDNQHOdVkZ9X10hGlI6P4Iwu8K0V97jWEvC2Zp8VCPf7Ls7vLpKmgEygn4y/+lT+jdyg0tWNFNxYv9cZwBhFSwI3GzjZqFopNlwNvHpop+55y0SRO811J835wo0Ow+k2Kn1RwaTxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710737240; c=relaxed/simple;
	bh=r8hRQs/PpCVa+STOToYQC9NAv5e5YPN5wNDKvG02oqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=luyHvlzpNgKWQ58E89xVuGOBoO/YGdBpFap9eA4nPS0wcEkcsCA2Wiam0DVAAwPp3+QjLL6hpFiKwFPQ5JPzj+AHywg+QV5qQb5TbaI/xMGspEBWPAuV4B9arckpBzZK4LiYB/6CaTsjJ84kXdPF7/n4LMHhnemTUzHk+1KdjQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DEOX6oMZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZF1pw2Hk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I1iBZD021066;
	Mon, 18 Mar 2024 04:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=v+nnTX2B8EW7um9blLRTsiFZZmVZYu063FSPG7jkjOU=;
 b=DEOX6oMZ3r3LzoRGRBOXjrWDLvbSKrRGpiNp6anliAijX92ccYFsqLo/xFFb8qfNMI7B
 SlJ5Nd59xXX2rn1xbqA1kxGmLwOyAtsDC0Uq++lluoU9lvxhgyJoX4bh6tAY2CAfu1OK
 bzGJnYy2Ov/GIO5vmS+UT53Y6r+m6jrrNyItSd7oi590kOqQ/7cJoJn3I6ExvuG9oukC
 6mFEoOUais7V3T6VgA+ryV4/azFOmnuKBtZd71uVmp3jwRGZXIk4cWfw5X4+5DnHTDTp
 eFVbO3ZYPlg2yi152ObHLZIh7NLTLfabH77KZGYHjm7444Uk5k2L0Ur8joGI4GqDVvHq xA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww1uda64x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 04:47:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42I2WSI1028727;
	Mon, 18 Mar 2024 04:47:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v4bk06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 04:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kewY/rkI17XsTzyoOcjKwtIbfajyhO4wlUSi4YvCmRaYwef/XQh072uHCdt7T3EhO+R0BGivUei+GlBgHLwpn9N+Z2c395FIFgby++dNconQR4oBa1IHNgO+q8bQnoZGZKZy2GGgDc5X9eGVCdWWl+p22XcAVBmeDyMXkyaVLKphNwaxubkKd76sxpJhztD49apfJ5eu4J6JtGrV9klLpqoS1MEhxFGfVpUHpFcY0PUAvy3Rp8Fx/Z+yHw/XXp/Fxq+ursmzeqkVLjueQSOm8INVcTHRNoqQAzkhwDRi/Ca2vn2RNprH6RMAJv2RTt5q9B913up6rjh8PdJQxHMqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+nnTX2B8EW7um9blLRTsiFZZmVZYu063FSPG7jkjOU=;
 b=eidxokrcyH4o+4DDUiM1kNPF6r2KpxL/2kgKm2dqB8dh6+fE7ABzLmYEN3CVdavfPZ2KEL7zdTi4uVfpT01/zOqHwajhztbi9RcLQAZLJYicm7Lvi/46CHvSgNUrLnxZxhVh4FBgwltqSfG4gaNBkSzOrLHjZmQ2cGPzZFBcQIBEMjGuLH5lz4YeDH0MgMMpZ8UPdWbaOTbyglaHJhCOHFutn09ZJ7mM5NjUayEGp5q0eW6RwE1i9WZ3S5s4GgK72ZqiTJ5gvGOQsOJdxW/P0Lb8g0uH/mV8BaPl9yyxkU5DS/GGlAylvAPNI0KpJ4U+ecIl7h9RndiMJOT/IqyvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+nnTX2B8EW7um9blLRTsiFZZmVZYu063FSPG7jkjOU=;
 b=ZF1pw2HkPYPu5XhMTfDl7UOfOh7QQnmI6lR3cfSZ125/0RfGKMTLCKRpjgoKzYiP8980SO7dQAnzWMKO7CHUH63kYJpuTQMG86RybxdFXMoM1w0kdOfg4FdAFdX6P6rdB0vvs730svBycilfl8bc64XO4OnlehY/vP+kA/5jUdQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 04:47:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 04:47:09 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>, stable@vger.kernel.org,
        Alex Romosan <aromosan@gmail.com>, CHECK_1234543212345@protonmail.com,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v5] btrfs: do not skip re-registration for the mounted device
Date: Mon, 18 Mar 2024 10:13:13 +0530
Message-ID: <57a63f9905549f22618a85991b775fba76104412.1710732026.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <171028225254.16151.9271790987036999384.pr-tracker-bot@kernel.org>
References: <171028225254.16151.9271790987036999384.pr-tracker-bot@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc61274-bd26-4b4c-0daa-08dc47067829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	50Klhp+WogypfhT5490IHPtPUbdPnwfJB0Hnx4Df7oJhxJr98jWXGJ5fIGnjsp8SSvrSerXm8Ea6wX7ZX8dnPdch/5S63w38P6XFUqn75UDtYNx3h1qxbNvtMUAO8T0L9g2Qe0PrRy6dTtTvwAhD5RHN/AcoEo1VsguRVF77HcvfrALvt+tN8H8VEJAE8wVk6tiy/77Qm1WIoH3o6ni80M+Du7zUcqF+d3RQeYLCCY9KnNRMGzBqQQnAeV30k1iSWrPv8BvtjsFzTin0Yenfd8pGChndf0jnzQGKpyK8+VS+btLXe/Toh4AiAAZt/I1nePJ95ECT+EiEV/BQb6yrqxtY2vQWccmCfhYtEtIJ00uSwcT2+KDhygNktPHdADZ/eYl2qP8R7hn2Jv49/TfFAhlsRJwHfWE2lXb+R1ZsvtsrZQrqoNAfCIwa2Hyq3ymLdqApUhxpX2KF8htg9Ymd8BPdwA5rlXX6cHTy1p8Pgl38WB+4eYFU+OadGckQ2E22uDY8TElLApCM9C1r2rega17kNtgGk7/hv56HQgtUBzuU3VQrGXmvWdhTcduJSV8igpIdGxGNC5U63K4tWIsdNqtw3dowEsKzQkSHQPrNR72lE200oQrJQ54kRfHQYAdq
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cI1SRdQYxC9VVjuFHLt3aC6yu/zWcAxErG8kmkdQjPCX5JLDa5N0GIIQ+WF2?=
 =?us-ascii?Q?E7aSJKrQ+gr03G3gYgjeopkrBKO3Qm1RfzMSevBFBxC01wu2PylmuYgNEKX7?=
 =?us-ascii?Q?PJ1Ra87GtpPN1TQhnxfXblojxjGFO5AvmOG/6ILk0/o0L0Ra9I6oJckZhs04?=
 =?us-ascii?Q?pR2PxLfLrH7o0+oZhff/arUyf6AUklwJaXcDbZZz1aycSZTuuPvs7/oApfD0?=
 =?us-ascii?Q?GBH9u+90XiAKcPTzv3lzM0GXc4k2F80LY0kprI6PU46wXGTN5RH1nvxqnpB1?=
 =?us-ascii?Q?FgAuqgXZa2D3ziumKUlumzaCstIZAX3LhJWGG3i60EuhnF7CiAKMMe+ByRVQ?=
 =?us-ascii?Q?Kk1xnCWrWFEPlCVMwSemYs5tf/djRmCJWbkgsVA6WKIvzlYV2nKivJbhB0hy?=
 =?us-ascii?Q?oOWJWGT76BNoG8JQdh5nkI3zWiMgnXbRKZll2ZSWWN78Q9YEmFtCkyCYstoR?=
 =?us-ascii?Q?w6k7yhEK6ZrKksX7TR8NjPQMaqNxLYjHb2UOej60OewFpk+ohqYAYp6slrxu?=
 =?us-ascii?Q?ApyCMSYAMcfDAozKTn0hlESR82P0/RRY80d4aCPZZr7SXLyuBmkdZLez+1rn?=
 =?us-ascii?Q?8atrkAFrtzOWL5vuhZooJGJLJPgUJroq+jGyaAZN2bg/FSjFcBz/YPcTDj0I?=
 =?us-ascii?Q?BC7Vmrrq+apm2cOp8XoL+KXdaxt2R01fq05l772J75D2XbxgKijJpFg7x0uS?=
 =?us-ascii?Q?zQipIWZ1zeDOPdwgCbbyVMUAc4W4PFkmupmvsvHRhBg+HRfB6iMtL4g5bqDy?=
 =?us-ascii?Q?0m4D9rmyoLsW+2cAe5f0d6ZXOP3MbcNfwU0Inq8udd7m2Fi6c6ajrPYM3xEl?=
 =?us-ascii?Q?Y1c0GJA/+aTx0HaPOK1JY/d5YDdtMhSJDDLNA4VTi8NBC+ScaFkyORa4abZN?=
 =?us-ascii?Q?0MQdn0b7UzlELxL6YKSDMvjl16hAkNVElmHKNuCbQDnuJHwm9KY8K/Spasxr?=
 =?us-ascii?Q?JL0RBBsM/QgsgeBuqnJmXCDUUxdtuK0b+orvMSJIX26v6ti+K9ukX5Ov08jF?=
 =?us-ascii?Q?bwP1ehLSMp6LZANi5cuJ8zDrHfNEwOj/ZjiOpVcatSXf3r/sLCILpR94nJUd?=
 =?us-ascii?Q?eINykZ0Gj3TuNesbIVWZNYM2pxNcqefUSWUiIXkrdoKmjsvxuVX2qEUAQyrY?=
 =?us-ascii?Q?OQADKmjR1RucxcfrK9RrGFjYjj8b8rLS9OEEySpriBWjcqxO8s0jOh7y2nv4?=
 =?us-ascii?Q?2bcHHw+tS0FDNZQHLt5VyUdyo0sWnzFWcsPf/VHMYH3HI/E2EXaknLBMZ2gD?=
 =?us-ascii?Q?MH0gA4s78mnXE79VX2O5jUmG2iC8QLv97l3DT+4+J1gExJBO2OqhV0SrZSfe?=
 =?us-ascii?Q?Gl3zpyXyp+Id61LyjyTpoKNu+t8n4D43mqJWPEqgxDW4S5POM3mxRYbIK6N3?=
 =?us-ascii?Q?n/GrjkSsk/T1OuhfH9GoKUvaNQ11IHjAbgliTUdOyDmz3F4ylsKBvhTpPNf3?=
 =?us-ascii?Q?ZwQIoUa20ZiA712vswmmBxCFhDD48PMvzLwbtDAFxMjLgcZNH83pToHoN8Kc?=
 =?us-ascii?Q?5+5DF9RL/zJIhLGH2aUlBTsvRT9D8ucslpHroPcpOJmvnCPqH0ofU9TTlEQY?=
 =?us-ascii?Q?jghIr2YdTsePhGTOCefKctekwKeBsikfxfvtznZy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	erjhfM0mqY0o0pJV9KoKqUZ0V3aYjdD598Ucr70VhmDUZyXViURlCNCdK5Xgba2ktNgceM4N5TO4F4kZpBqqoLI6tpocQkRa35QbNdZ2X2Vahm4vAD3UF3Y2qD9Fxvq9xYEZ/nM5H6o4bdRJKsN6FiYQ6KVqEoblL/oEHjD6cb5OUNaSYyTEvKct3btufrrwbN2EABBo1Xne5n1GmhF0sCNrR0QuOG+udaxKHzO/xB1wC0Z5z0fmev5naqXRFoFrnjEbsvohUMSlWqA74b22YtcFZVnuH1Gikl7Zq6mHSpLsv8hdDI+WqPjgQaK1TehbVso+sYGOV3j7bWScvdiIjOnA0vST9D89vUi1WnFxhuzqy+pjhTS3EFIl0OZ4vw1zbK1G2F/MIdU26GBzDNwHtvb5G9EomykuQcQo7c7IbS5OCgqMYa6+MRHn7VihofXWQF87sgYcTsmp/YUYPT7CnsNl0CY8Q+eA+UORvCGFrQ0iWNxBgVlWWa+i6iMX6CfQU+nbPxG5uY45KCBExMNoy2wQCEIMCV4/pPDxtQCVTHM3pomrxHYuajBWprs6dH2Yh3iswDhD92kwrnxSKNu27X1XaiJDx/yl8LwdOleFsSc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc61274-bd26-4b4c-0daa-08dc47067829
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 04:47:09.4678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4LAcnL52p6/Adn9W1s50w+Han8aXdY77OfcWTbxWdfXRo+oDHqUqGoYgBszc1x5puTXEt95HalZEKX9wt58pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180033
X-Proofpoint-GUID: LIQF4R6AAO9hXnSxBjSXMXZ88iuHxmle
X-Proofpoint-ORIG-GUID: LIQF4R6AAO9hXnSxBjSXMXZ88iuHxmle

There are reports that since version 6.7 update-grub fails to find the
device of the root on systems without initrd and on a single device.

This looks like the device name changed in the output of
/proc/self/mountinfo:

6.5-rc5 working

  18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...

6.7 not working:

  17 1 0:15 / / rw,noatime - btrfs /dev/root ...

and "update-grub" shows this error:

  /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)

This looks like it's related to the device name, but grub-probe
recognizes the "/dev/root" path and tries to find the underlying device.
However there's a special case for some filesystems, for btrfs in
particular.

The generic root device detection heuristic is not done and it all
relies on reading the device infos by a btrfs specific ioctl. This ioctl
returns the device name as it was saved at the time of device scan (in
this case it's /dev/root).

The change in 6.7 for temp_fsid to allow several single device
filesystem to exist with the same fsid (and transparently generate a new
UUID at mount time) was to skip caching/registering such devices.

This also skipped mounted device. One step of scanning is to check if
the device name hasn't changed, and if yes then update the cached value.

This broke the grub-probe as it always read the device /dev/root and
couldn't find it in the system. A temporary workaround is to create a
symlink but this does not survive reboot.

The right fix is to allow updating the device path of a mounted
filesystem even if this is a single device one.

In the fix, check if the device's major:minor number matches with the
cached device. If they do, then we can allow the scan to happen so that
device_list_add() can take care of updating the device path. The file
descriptor remains unchanged.

This does not affect the temp_fsid feature, the UUID of the mounted
filesystem remains the same and the matching is based on device major:minor
which is unique per mounted filesystem.

This covers the path when the device (that exists for all mounted
devices) name changes, updating /dev/root to /dev/sdx. Any other single
device with filesystem and is not mounted is still skipped.

Note that if a system is booted and initial mount is done on the
/dev/root device, this will be the cached name of the device. Only after
the command "btrfs device scan" it will change as it triggers the
rename.

The fix was verified by users whose systems were affected.

CC: stable@vger.kernel.org # 6.7+
Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
Tested-by: Alex Romosan <aromosan@gmail.com>
Tested-by: CHECK_1234543212345@protonmail.com
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v5:
Fix the linux-next build failure reported here:
  https://lore.kernel.org/all/20240318091755.1d0f696f@canb.auug.org.au/
As the Linux-next branch no longer has the this commit,
I've sent out the entire patch again.

v4: (based on mainline master)
I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the RFC stage.
I need this patch verified by the bug filer.
Use devt from bdev->bd_dev
Rebased on mainline kernel.org master branch

v3:
https://lore.kernel.org/linux-btrfs/e2add8d54fbbd813305ba014c11d21d297ad87d0.1709782041.git.anand.jain@oracle.com/T/#u

 fs/btrfs/volumes.c | 58 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a2d07fa3cfdf..813c1c66b2db 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1303,6 +1303,47 @@ int btrfs_forget_devices(dev_t devt)
 	return ret;
 }
 
+static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
+				    const char *path, dev_t devt,
+				    bool mount_arg_dev)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Do not skip device registration for mounted devices with matching
+	 * maj:min but different paths. Booting without initrd relies on
+	 * /dev/root initially, later replaced with the actual root device.
+	 * A successful scan ensures update-grub selects the correct device.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		struct btrfs_device *device;
+
+		mutex_lock(&fs_devices->device_list_mutex);
+
+		if (!fs_devices->opened) {
+			mutex_unlock(&fs_devices->device_list_mutex);
+			continue;
+		}
+
+		list_for_each_entry(device, &fs_devices->devices, dev_list) {
+			if ((device->devt == devt) &&
+			    strcmp(device->name->str, path)) {
+				mutex_unlock(&fs_devices->device_list_mutex);
+
+				/* Do not skip registration */
+				return false;
+			}
+		}
+		mutex_unlock(&fs_devices->device_list_mutex);
+	}
+
+	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
+	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
+		return true;
+
+	return false;
+}
+
 /*
  * Look for a btrfs signature on a device. This may be called out of the mount path
  * and we are not allowed to call set_blocksize during the scan. The superblock
@@ -1320,6 +1361,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	struct btrfs_device *device = NULL;
 	struct file *bdev_file;
 	u64 bytenr, bytenr_orig;
+	dev_t devt;
 	int ret;
 
 	lockdep_assert_held(&uuid_mutex);
@@ -1359,19 +1401,13 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto error_bdev_put;
 	}
 
-	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
-	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
-		dev_t devt;
+	devt = file_bdev(bdev_file)->bd_dev;
+	if (btrfs_skip_registration(disk_super, path, devt, mount_arg_dev)) {
+	pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
+			  path, MAJOR(devt), MINOR(devt));
 
-		ret = lookup_bdev(path, &devt);
-		if (ret)
-			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
-				   path, ret);
-		else
-			btrfs_free_stale_devices(devt, NULL);
+		btrfs_free_stale_devices(devt, NULL);
 
-	pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
-			path, MAJOR(devt), MINOR(devt));
 		device = NULL;
 		goto free_disk_super;
 	}
-- 
2.38.1


