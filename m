Return-Path: <linux-btrfs+bounces-3339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC5C87DAF3
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 18:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D111F213C5
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1291BF20;
	Sat, 16 Mar 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M4OxOMhP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PKadBI4d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA601BDD5;
	Sat, 16 Mar 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710608608; cv=fail; b=NpjfEteAhp8Ln9tRMYgBLiiJaJn0oHl37bq6G1hO2fW74Iy8s91LOuSYD7niFE+0lviFJpZYX2L1TRXFMsoIyQ9UEeqyh4QpnSf4StXYqx4iqHSiMnEuDMS3GMIf3az4XtvXFfgLDe8l9grSWlaAtvOtUDfK1WsF9YBFGpwCK44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710608608; c=relaxed/simple;
	bh=EwQrDZDhv6apFgVFHYoJwHpgks+Co08gpxOFv7rARnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uVlzL5Qt0+QdiRVLOw+LLzSZz4SmctoBL+fTb+8XDrj57smUZcLSrtqHo1QceeP7nrvVXLAYIJNrzN2bw51rJgxNeiQwZvrT95eZVm7RlPtwxoIfUrWDcgWcw2iauuzLf6GORtijHPdaJuU8b4vh207BVmXdH5fdOEo/gLzs7gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M4OxOMhP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PKadBI4d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42GB0xm4024950;
	Sat, 16 Mar 2024 17:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=6MaFRQgeVcahxwJo9QLtVVBpzFKqnZQezZ70vdwG1Bw=;
 b=M4OxOMhP8X8KWXJSEi9Hvjl7j8A7vRNLkW5vbJLdguNpSVvRAuc+x4QEfMGjNPD9IoHs
 zoQcFMd2ikUdl6Ued3QPQlR5JLgkcRgpQTBWfLT/bK1RPw/5btMZcZXBc0fQnfppfoRr
 4is3DI5km5u6j2ghKU9iLHeXUvfarf4TfBZMehWIUYei60jhENNOOencPcpCQP6gQm5m
 MDhetgTAbrtf9O+j9qkbHBnHpvCmAoiqKXS/MtlEOB02sdn5KSlIVUi1+F4MdoKXubSi
 AvfKZednRwxnUrfTGuL1xMG/jaoIgNG5zar052w3E5s7XiC2DUwsoVwZgyRuPFIFARVC 3w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww272rnwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 17:03:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42GEv04x007572;
	Sat, 16 Mar 2024 17:03:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v394c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 17:03:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8WhIHBdd9lN/NhmP2GCHV7hWb6hvYUd7G7sNyJq6rBMw5+EllGPDiiTXbh5mCrrbbEbp2a76Sd9dblZTjPFaoyPh4fB7WpDVwVbqYaBts79UIJRoHVQdoD+pHAZwcOhho0ZjPlYaBrCjhr/WD4lR6AS/0VrovPMYa+P0UREdfazlFMj0VSuqMuqfxk5bOrnCmc21u0BQs5QgmgwGTvM6YZXkfBDgaFQdv12hz/tLlAxt33sq5NU/iJFIbHrDFLRGxQUBbeoDUno7/jVqax2MFOhC7pv2pHHv+M8032V6iaElZasHKtpwvPZ/2Nhl9W6+bgYF8bszdBzCwRMwvfrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MaFRQgeVcahxwJo9QLtVVBpzFKqnZQezZ70vdwG1Bw=;
 b=AoXwxIc72vw0Q6qYBKoYGhxkdsk1R23IcXq2Ef0EX/O5xnEG1k4IroaeDQUJn8pXCeIql9T7Hr2uz8ZGg5Y9Mh7zqn97dGyKELuDSyrbkZLVHGVw0xWjiTx0O+wekXSRon7hLlBojgOz7oWIUg2yjcktzvNR7EST+TaEyii6aDTa11kHZxUGoJ+EZVQ8/ihrVIy60TB+Yu59Mgoayyyk+60YaE6QO8Ba39M7b9egzFKHR9tHH5WCkkVxRVbH5I/sRXYb9VEPq5osNG0QSOaTNXetSKTTw7mRd9DJSDVEXm3N/i9HfwaYqiAGpbe1tx85VpgBhXm3Vdc8tCv/LsD/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MaFRQgeVcahxwJo9QLtVVBpzFKqnZQezZ70vdwG1Bw=;
 b=PKadBI4debe40B7RqLMq3bw9hKRHeDs1GVr0OHaAry03f96XEZkXiy4L/wV2K8NVNetPcpoOSAgZCItnZ14SIlZWWViOisOjA88IEmJvvXz60OnUPjaJtnHVV9C2hHCSH+ITWQBWuIVYg95YxWMPbsLjE08iPNEOaEvkCRzNkT0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4304.namprd10.prod.outlook.com (2603:10b6:208:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Sat, 16 Mar
 2024 17:03:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.022; Sat, 16 Mar 2024
 17:03:09 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 2/2] generic: test mount fails on physical device with configured dm volume
Date: Sat, 16 Mar 2024 22:32:34 +0530
Message-ID: <1b07e16433faa5c149d2f6c0693fbcc656561aad.1710599671.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710599671.git.anand.jain@oracle.com>
References: <cover.1710599671.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 97baaa9c-1c61-49c4-5a1c-08dc45daf4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9Hq+6orreIxCD2s5kPfnsr/+7sOR3Bga29SUo6Ud+Mq62w+hiBiPEpCsecirYIsDAisE099hyvsqpY4BV9ILxoF3d1Vm6CmZxOWuMo77uenlRIZXmZi4weS3DXDXCEwPYawJeqk+SaN2VoTw1nqGFP4gMEjKFau65Z3TMaGgxusuekcHJxfA/fBPgwYk/ACu50wwDrlqbiSdP02nNvmy9jSgad5BP+fNIBSiVdGmfHO1JZxq0e02XX8HKlX1vJL4A357mpj3CpFGZ/EujG9qjYkYpjFG8lmvBbglT2Aeb+ZL4ve0oOWCl1LSDYEiABLNTLhM3ja8crE5OmZKZzpjsTnbbl9HSPWoGVBazdnJktWlF8Z/LQ1BSbNrOh+AlMN7pL9fV9PzagHhDwfDDmlX/IOU5ipSOnYIPa4isv8xZEitFfA1xO3ikzeVm1oJglTKi6Fm6RHVoOvmTf2P7MQYq2x7cGG0UBuB0B1mHEiIbaHdSBEcE6Zg+qamVUtjO8Jr6MN19jS3yDyo8q5CNbhVXZl1L3nfQ0KnO/aJ9JcaT4ah2FCmNaWKiEnynGONR/ltsolgO3muFO6GMdf1+NUPSV+chiOj4sWQ2l+o1raT0I7gOeaXUhQxh0t6pjVo0g+coFPO6oi71qBQFKUKe3MDaFfb9CcU3/lWtFnb8abX2R0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZDhJPtnndP1Hhxo/OpMSzZt98odWKakf0xkbrx9wBGU74eqPtxOGbZMyJy9U?=
 =?us-ascii?Q?3deLAwwgqTacaN3EHG0dxcmt6zLZ9nyNWzEgRwJCnkEj7dc9OazRYFFpnR5u?=
 =?us-ascii?Q?uJpLC/SqByUh1j0pL4tRTL/qcFbXYnVnR0XWHYw+ojuME2w9NsHNsdhRhQx1?=
 =?us-ascii?Q?TfTJMW7Z3KkBSMaSgpNUdpL5S8vqQPisb3itJWe7ZfnpG/cBtz/KubMojk7r?=
 =?us-ascii?Q?1VZL//cgiAVyyV0esCN4ovoMzm0U46XzNrC5RbYayRiLGPvBTOV5GynF+Y7D?=
 =?us-ascii?Q?9flGhXmZHxQfUy0yJSis87Y/uKx9AkEzQsZEuMW9VQ8L/bSQLBFIIZRsnk0M?=
 =?us-ascii?Q?0WCLtEhbSOGIeO4oEieRm2RZS5eoi2I/NF4BcAlSeoz1y4Ovo+mgulrnr0w3?=
 =?us-ascii?Q?vtWyBxGz4PYcyFMasU8MKxfCQLwnYDD5Q9mc/QxgaCafuj0ujDOJPsGfl8gW?=
 =?us-ascii?Q?WfKyhYDaP9vXPgLmWnrNvzVzWrrqgNEwyJKdMBHd00g/UZ6Jjl4D1X0M80kC?=
 =?us-ascii?Q?HgQY+5pkE9PoGSHTelPZ/ApnwD8oGovmjRSQ9d4zrjic0Sw9aVrsbXqS8FMZ?=
 =?us-ascii?Q?8HNf7Fr/8200TdAH9XDUjvOi/JzjSnIg3/8uIRQhyLdyA4r0+psSrXDr4mW7?=
 =?us-ascii?Q?9kW9lcxtJBkBw9Nk2b2eqRFUwWwo82coksVasZQG4NP6Q5Zv+D0VIGQZgrxg?=
 =?us-ascii?Q?pF8zeed81XC63Aqgpzo8hJgzaEtFcV5RVEKgub5z4+/6X9pCZ1J25ZrBWB8E?=
 =?us-ascii?Q?jTlvXK1D1SN435Niw9U/4tn4WaAD069reWpnk9VR9oo9HD2gg8tJPezzNJHn?=
 =?us-ascii?Q?enlDs2DX+WAco/hn00WryuNQEHAlMd1U4xFujLsYLpoffGR/M+9IFK6t82b+?=
 =?us-ascii?Q?n6N8GYkeqyl/Zcw4e28bJfzXmKu5PY6dGU2OEpnogAApvCwQHF0Ksf1mTCg9?=
 =?us-ascii?Q?VC+++Kruqn1YgqIJT0mwuPTap6NVqf1HAa4CtUMI5WOV6pF+3ulOKIPiU1jy?=
 =?us-ascii?Q?S0eGtxJQAqLwytb32GCEBT+yRwyeCFNfZD7av69ocpMV2ikg8pDTXZJn72pP?=
 =?us-ascii?Q?F2Z9pP1w855VbbRIP5H0m3xbL/BvykgixmpsekZz3SqebSn6e/1qmMSFqkiL?=
 =?us-ascii?Q?XL2H3nq93KlbYyRLKMPyU/sxHIsF7Jf/85FTIMh0lc2SGCqzs4jR2vqNG3Hh?=
 =?us-ascii?Q?sZrhkbZJ9oomUHJCOoJWyJ1opge2k5+3zRDaLze6zl+0/ZOerynRoIc3Aeyy?=
 =?us-ascii?Q?a+QbhrM5t30a/8DttBBPHDcGVM4AxN8OYz1xRLKrSbYBY6a2JW40hs3Wc9cM?=
 =?us-ascii?Q?eTJeS3zLIquLcDtVeOQjleilXukvjJN1JDCGeg9kzmCXYi0hho+xqIH7IEsb?=
 =?us-ascii?Q?pzq76GdHsoQQXjtNu4PyfD+OZZgWYNPAIhRjCxtFXcF8NrZwh3xU6aGIwU20?=
 =?us-ascii?Q?x5EVbfr3PriD63KX8t2rgee/saPs3yk/UIMmMTLDqA+hXYO2sEGD/I5Of1KG?=
 =?us-ascii?Q?FFsrSBiTlqNRYRR6Q5jU47bpvfi0S09Xvk1Z81e1iCK7gs+9KxOLRdI3ZEZM?=
 =?us-ascii?Q?ir/j5SIIYgwLbgkUOawpN7iQxjms6DnsOb68/oCO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yMTsbi7PmdOVhPzNyzGm7YnCMgWHgtmhDZfaIp5MDDT2O459LukADOnG93pD7MZc/odwxgyOSoHr1r64j72Dby8XpWwqclDMpwgp8KBLT+sdD3N8LjsRRT9ZLZO1xbDalnxyVYm5vPuIFPo6SA/SZWcdR6g2y25kkfqZJ1UZWDptUPJ5P8aBoSeRxtKbe2DFBCs9AiKK9FBPqJAK8HWZ/QqkwC9psoLG+vUPjUayoM0sKXIfIYwJ5qBhCJr3YnLJAcBJS0GdBCXSerVTyYYIL1TsPnpRwNPwpoK30CPOY7sn2xQmoCfOfxz3IKnAj8RmGc+SoD8T/a2Q4waZkIxtwW18HZa+51HLSZ2j4wDoRM9GHpd3q7EY8yGk8BPN9XLR2jIVLT4fYE3ZazFcZiel85cdPvvF2FJeDH4pdtXaoXIpigFOEr6IYsnFPKR1GghfoRHfEBV9l08U5+bFG+COjPvA4ZT4lOsxsJ5oeviSJs6Sxdc3CFmRhzpHs1yDaniayha3+Ke5T5k6tq13Yys7t6fR/EaVY/Cgo/OMjewZsmOo99HBd9hJ3BZrlzBiGpZ4LVYikNTQTDbMH7OpcvSZnPjbkM7vYT3e8ByLCro0OZ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97baaa9c-1c61-49c4-5a1c-08dc45daf4c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 17:03:09.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWxERl7G5EoREQ22ebUnNSLTYf1LICZmNW16jBqqYU4fOwhs5K35O9093efTPwb/6q7PhMPAOUsf1kSsYWTjhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-16_14,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403160134
X-Proofpoint-GUID: fd-woJhAaex9UIoLyH2YSueZK62mTHG9
X-Proofpoint-ORIG-GUID: fd-woJhAaex9UIoLyH2YSueZK62mTHG9

When a dm Flakey device is configured, (or similar dm where both physical
and dm devices are accessible) we have access to both the physical device
and the dm flakey device, ensure that the physical device mount fails.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Remove redirect for rm
Add _require_test
Add _filter_error_mount
Change log - make it more sound generic with a dm device
Add quick group

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


