Return-Path: <linux-btrfs+bounces-2896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5076B86BE86
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43321F24A83
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB5D376E0;
	Thu, 29 Feb 2024 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GIdtsDMU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vu0Jlb0L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5A374D3;
	Thu, 29 Feb 2024 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171476; cv=fail; b=DVqEIj+PjrUqcuIj8b5rm+cNZm7HrgK/xBrVy156WS+3T24nAUjvD46yIJ3P5Xf+Mh/4oeon7+DPdd8k1XlHcBz5I3yNmKdHUeKxJUJgR7GP8mu/PZlJh41euftsL04YvAntja13hLPArriI7U7497urvw2BQAHzzEXW/skcOs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171476; c=relaxed/simple;
	bh=kxX2EdcycW/IxGQgHyGj4mVA0n28OHEZ+y/ZN5BfLz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OZBQTTQVNV7bBQVbckg0k9bxVW3A5S+waPIDO6oD0XJV51ctyqqQGdLziLyGV0dFWtnL4aW4mOQC+EtGNhDovkIUKfq41zRBU1JMmbr90lNS+UWIMO9ImDOGCTsr/536xZUzorwz9FE9AOW6gWXExTOkKVvOQeWfbROevmOYCpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GIdtsDMU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vu0Jlb0L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SLGSPp016470;
	Thu, 29 Feb 2024 01:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=oa4mhEhbesYuJEaYhpui/gMZPuGxJwkSWrvfwo7PT54=;
 b=GIdtsDMUqmAb/78OOscX1j+tSyvPJkxFFiMyY1XLoPiEj1BVF+ThxIXuHrnuaBdFcsJ1
 8KEF67OysxM912FgXiVpmSfLI2tEz6Pk0orCHv5O2JYB4iSr5VSvn5Dc+5Llxltxhap6
 s5JuPp2knYfQ26p7w2vR9kzGHJnd0TBF5wEwCedIy5Q3ZRQCfVrb/BhbX2LmP4noidTV
 pYHMhiZUlsUbsqSj3giY6xIb0b77YuDIt4oRqioU9UV2AfcCgbcRgVd9GwrQQvBtQURN
 kJ8ItsKpSvnvjS/vQLijoWiLUGcPiFpdnyeaX4vA97cwaXqq5F+6Dle7+7ZljJTP1EdB Yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82ubm86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:51:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T0UxPI015351;
	Thu, 29 Feb 2024 01:51:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9yybd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:51:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDWW+yGbMFFZH4wiJqyNZQUMpOgR79H9gjwY1pRqqvhQ8D8ptSrIhRyWjHi0fw/67IgEuBPSU3GW/BPN3GNUEqwd6En5k1ubG5o1LHfkhT4AxlyZ9pVVd1++mHq/A5gs9LWA3+mOHiG2CYflJn1/CjmMDnApovHoSLWkIvH70wIzonDheIypcuFpDmWyyBTyvpoN8JSawILlgr0k31ZosPP5Lwg8zOmOg8AdbtpsFDyRpcz6cvUhLOY5KZ+DX7534ctf1i48h5avoOz3Y3xX9jdIcCSHgikLKu5q1guU4tpyYe0Dk6bXN9fQwz98+uBh9OPTE+D4ZgjE6WD/i2WOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa4mhEhbesYuJEaYhpui/gMZPuGxJwkSWrvfwo7PT54=;
 b=ct0GkfkuRmn4GF4891Hwa3+Iulp4xz4rWEHZZLcoBXR6PVnWHXSVMdXsj2rouy8NjZ4iz1yVXoRcPthS7Wy2BotsTldyBKxKKT6XW5OdUlv5KQW2C4tJIem8t0Oc7reI+F+6a91W0CFVbxzExEVe4q+kHRxMlUnnF2efaeeDux/kXiJLz1v5rKQYRtAFE+JAqd+Av+BCrPeUrCx5GxgY/iS/j8kExcZPwYXbuhYcMw9PGWRvuWs3LhvQ9OufP92KKSdFr0XNxwHFOoqfWNJEymN4ddNKWbA47GqwRYVs0KfsRT4zKEbUK8PJK7CKiQf5uT2oZExdgIC0vYyttW74uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa4mhEhbesYuJEaYhpui/gMZPuGxJwkSWrvfwo7PT54=;
 b=Vu0Jlb0LCielwc3zra0RvMSlmCSbKlZuDRpbDy3lwq5OBlIWMK2qRuAcLTUBZgJJEEOLg481qa/X8fRzaAp1gxggqXrBy7u9gCMGE3Uuqm7KYOyTKxZB5NY8oXz6qo+F2wHyA3uQzP+GIlRsdZjhY/lSPD1ND8JT3XucAqmlCX8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6239.namprd10.prod.outlook.com (2603:10b6:930:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 01:51:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:51:08 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v4 09/10] btrfs: validate send-receive operation with tempfsid.
Date: Thu, 29 Feb 2024 07:19:26 +0530
Message-ID: <3fbe8aba0a33574e4932dc2e1f3c8fc9f39be56c.1709162170.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709162170.git.anand.jain@oracle.com>
References: <cover.1709162170.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b5b5d7-2b01-43d1-f5cc-08dc38c8e621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QbogqrNTujIEPZh4eiRL8artkrSG3VlN71tqDGcSeTEHvlQPARjWSipgR3lm71RJr2Mnj2y1mpw4Z1NSpKYEwFI3H5D0flsfU5eVJCOw1bIgM0jH/Dy76wCA785+Ak9KnuOe4iT4kPUs0uSGxY+bAbgRtBo/ZMdbm7tgBQqAnZex4lQFVywRz7WglcAtTYkwUOLZQgZkujKWmzus8wlue2Y9LOvwYmejzQyDFS885OS0V8H8wPJxeazHRmQLNCEiPiTkZbp5g1YZiKpwEmU8FZ/VJ0BgPWr2rRq1kwHffyJm60AscZvxUV+G60O1RFPJ6FDAcYiOl0BW7RpRENKYbAe3MAbleAeU9TcLWDC+riPC0kM4kcMP92X65YR7rWH1AaIfQoBK/ei2UDcLSNGqulYfxUcHrddQjWOmzF6VD9QmbI6326OafDSi1arvoCyCeh+9Rw5a3PLaT9LUnUfFKnhGi5NTNJfSVHkWM6l+f9ln8AU4YMrnU4EnUz3QdIoKP6+ST/i+tCOYx6uBsLbaO6P76rtkz7JQwcl1WsbttsfAPDDjPK4yfZeXYyVSgPVPnHhQn085W0Xaa0Mc/CdDuFzDkXCs1cykWfieeZZu4/Z61gstgZtPODA0/GsyIi8CscjLle63MMWi7Q1eAoxSrQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?w6ch6jSb2tMaS0xMCVJ2M/cTysekHAGfYZrtzqrzObxZypIHG5nLJPon7/cn?=
 =?us-ascii?Q?81/1cSGTz0NxUkPk1BnJip6ZWmIS6shZv62eNpsD+hiz7iE7SDw1mPZQR6tp?=
 =?us-ascii?Q?v/k6HWJ1zM5aQ5CgVsREXV5pQxpKqT0FgUqGe7mfCQMGhkao5rlN/Uer2oiF?=
 =?us-ascii?Q?L5r0O2D3CWawZAotrW+4aF4Xgk+NkdxPcRoSljeO5HGjkA9InluNNUJXAJuh?=
 =?us-ascii?Q?RejTe7drlSsiMnKwRNxub0icV7kMrcumnSIoNL47FOAtgpBzEoGP0AH7BRN3?=
 =?us-ascii?Q?tpoDFa9nLBl0PgET5tBq4OLWirMKfRyw3uh+7PNcTtR2IXlGn+uqRQYiOdYS?=
 =?us-ascii?Q?fgRZK0sbDSGDYbyqgolZlU3KBFzcopYPwsOVZ3sVSt8MnWZ3Kqv1/ogoEQGd?=
 =?us-ascii?Q?UaAcQdp/1AB/rwsxo3H6EuMozPm17AzPEx+f5DqUYQUkK86JaWxYIxJFRsGS?=
 =?us-ascii?Q?OhaNjJ1ItZGOuk+t3gYb6ldhx0s3WWCPmhE8s+BDswiIBECZQdu33y9r56mo?=
 =?us-ascii?Q?nlJmcNU3UmEzPqxcGGu4T1Uajen3vIUpRzOBDBIAULv9TAvqLdDW6Z6Y65bh?=
 =?us-ascii?Q?1GhSLT40W3RRfeTZxHSqCD2t+y9PzXIYO4V9kR+DC9/94RRiqzwR9eupGesO?=
 =?us-ascii?Q?eEuV7xy/51BgG9Hs18u6B4GoqI2x4G+Wje9BWy01czamVbPByiTeS7ehREuQ?=
 =?us-ascii?Q?BpEvnxuFuChQyDpsX8qTzojDNPGY6VfJgfZNVy1RRicZsqjUY9A4tAgwlYqp?=
 =?us-ascii?Q?o71HSSpapI3T/teLUSk2j1i4gY4WmZowcYV76PkFsMnzrbUws5ExkzcqfpWW?=
 =?us-ascii?Q?iLas+aPp8p3p0y7dBJALfTc6zmVI8rUikSyk5KcJgH48sQzEi3kb+sbV7DqG?=
 =?us-ascii?Q?TovOMiU1tjYyBp9GXUyE3LiAaJhm8KeMuiBf++wJv9h5gvKvmQvIQ4ykWeHQ?=
 =?us-ascii?Q?j8Gg3KT354lWefKHFelC1yNfKv6Cc5yBcqnPxn0Tk/SFIbDIZ97kBiJ24hCj?=
 =?us-ascii?Q?sFSpQrg6V/3qZMKtVMD/payWM/fO+4vZ0xGmu++0vBBwXcf30AgM0pAwfoGw?=
 =?us-ascii?Q?V74OdCy0PvQPv1YsXLAg9vb7xXr7k7xfKAOcYDYIEz/S2FZsj5bIi0xT2dcU?=
 =?us-ascii?Q?/B0fNk/BWC3pReU3QIfZgA4JqWie4SG6ErJ0RmxkDDsOsuFUWaROnBJGLToh?=
 =?us-ascii?Q?XZyyh0zOgoNaxM8R1J0+Hmv6ydcAqBDmLAZ88dF1hDlrEsG3Fult/AVQttDF?=
 =?us-ascii?Q?JL1X+AFylyS5Bm3g8gshZgX1J1RvCugl9OAhrctTlMdQOMlVrkBQtHXqT8Ke?=
 =?us-ascii?Q?Kt4A8CJjU+yA1xsOYkGIDcDzsWEk4xHMb0LK7GTNi6UOePR8I6+2jgaBWSAH?=
 =?us-ascii?Q?TL9070TW4xli+qMm4lA4pJK0iVa7xfTdqY9pHGGPPK9+DgB5BgpFVrCUcWX1?=
 =?us-ascii?Q?+eEPEXRgCORyOOzGqvZCCaM8CaPoB02UXPb47dnB/ogurGY28iP3OE4S+o+k?=
 =?us-ascii?Q?CO5L9A9mmkGXHCnhM1A54j4SH3icFU7t6Xu12g4BMHhgEOgqm64FeLieohbu?=
 =?us-ascii?Q?WL6FN0sniLZdRwL+T1tdUW96hCV711k2+7w5pyV8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	I4DppVSxicSC5qQghvPfawyFcTn/7J652g4dCQUnkWHGdOsv6RDyW0G06HXK0iRvg65Rv4AMYlp6Zn1lbEsC/5VzgGPVJy2hb8roITChPfqrwfzZi0q+pkarzUE/MRjOLrLc7hbtg5h2mwEQTL5KeBLBguTZhy9YOW72Os4n2PfwTJcZtm7vPVDf8heKZU3fY2GbkWLJ6UiIbNQGR2B5fDABU+WK0JT/NgtOMglaURedDwTl5fgqXAFKCkqbgmHTjdonMJ+fEG+z8OVglJeWznQbJQjhnXx9v0SgtGFKLLkRy8P/Wv/hNkvXmOCB9AuJGryaD8X3Su5UNCd+ncDHpxXb73dNA94zq6B7Tl0FVaZFS/IVkvQs2ws3XiwcuyT6o6n0R97TvP8kGd6wpJf3+nn3NLFEbqhYUtbv++zFcDEP/HH3htQBUR/6n2GZ48spciD5EDiII4SomxXUXSaCjldadn+jDkf1fsg6BBKI9Ui34XTxSCJSn0fKaUd4LgdPw6lwZvXnG8Emk3N9BhbCBLvRV4tCuQPNy5uIuW2ILudpervW9uf5RNUPXhCeRDXD0hHUVnY+tAunGZxjbnAmGMC9tlCHxkvgg/qc5/nQcB8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b5b5d7-2b01-43d1-f5cc-08dc38c8e621
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:51:08.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaOGZack02i4iLU3EZdeu+ZS4e37x2eBd093OXTEva8/cgsD60on9I06+KhiOiKFlKgH8kKnGK+jCbb2P/1f0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290013
X-Proofpoint-GUID: YhacRWJXuw0N_5cQxdps6MDWhP80x89A
X-Proofpoint-ORIG-GUID: YhacRWJXuw0N_5cQxdps6MDWhP80x89A

Given concurrent mounting of both the original and its clone device on
the same system, this test confirms the integrity of send and receive
operations in the presence of active tempfsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/314     | 78 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/314.out | 23 +++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100755 tests/btrfs/314
 create mode 100644 tests/btrfs/314.out

diff --git a/tests/btrfs/314 b/tests/btrfs/314
new file mode 100755
index 000000000000..887cb69eb79c
--- /dev/null
+++ b/tests/btrfs/314
@@ -0,0 +1,78 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 314
+#
+# Send and receive functionality test between a normal and
+# tempfsid filesystem.
+#
+. ./common/preamble
+_begin_fstest auto quick snapshot send tempfsid
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $tempfsid_mnt 2>/dev/null
+	rm -r -f $tmp.*
+	rm -r -f $sendfile
+	rm -r -f $tempfsid_mnt
+}
+
+. ./common/filter.btrfs
+
+_supported_fs btrfs
+_require_scratch_dev_pool 2
+_require_btrfs_fs_feature temp_fsid
+
+_scratch_dev_pool_get 2
+
+# mount point for the tempfsid device
+tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
+sendfile=$TEST_DIR/$seq/replicate.send
+
+send_receive_tempfsid()
+{
+	local src=$1
+	local dst=$2
+
+	# Use first 2 devices from the SCRATCH_DEV_POOL
+	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+	_scratch_mount
+	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
+	$BTRFS_UTIL_PROG subvolume snapshot -r ${src} ${src}/snap1 | \
+						_filter_testdir_and_scratch
+
+	echo Send ${src} | _filter_testdir_and_scratch
+	$BTRFS_UTIL_PROG send -f ${sendfile} ${src}/snap1 2>&1 | \
+						_filter_testdir_and_scratch
+	echo Receive ${dst} | _filter_testdir_and_scratch
+	$BTRFS_UTIL_PROG receive -f ${sendfile} ${dst} | \
+						_filter_testdir_and_scratch
+	echo -e -n "Send:\t"
+	md5sum  ${src}/foo | _filter_testdir_and_scratch
+	echo -e -n "Recv:\t"
+	md5sum ${dst}/snap1/foo | _filter_testdir_and_scratch
+}
+
+mkdir -p $tempfsid_mnt
+
+echo -e \\nFrom non-tempfsid ${SCRATCH_MNT} to tempfsid ${tempfsid_mnt} | \
+						_filter_testdir_and_scratch
+send_receive_tempfsid $SCRATCH_MNT $tempfsid_mnt
+
+_scratch_unmount
+_cleanup
+mkdir -p $tempfsid_mnt
+
+echo -e \\nFrom tempfsid ${tempfsid_mnt} to non-tempfsid ${SCRATCH_MNT} | \
+						_filter_testdir_and_scratch
+send_receive_tempfsid $tempfsid_mnt $SCRATCH_MNT
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/314.out b/tests/btrfs/314.out
new file mode 100644
index 000000000000..21963899c2b2
--- /dev/null
+++ b/tests/btrfs/314.out
@@ -0,0 +1,23 @@
+QA output created by 314
+
+From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid_mnt
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
+Send SCRATCH_MNT
+At subvol SCRATCH_MNT/snap1
+Receive TEST_DIR/314/tempfsid_mnt
+At subvol snap1
+Send:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/foo
+Recv:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/snap1/foo
+
+From tempfsid TEST_DIR/314/tempfsid_mnt to non-tempfsid SCRATCH_MNT
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 'TEST_DIR/314/tempfsid_mnt/snap1'
+Send TEST_DIR/314/tempfsid_mnt
+At subvol TEST_DIR/314/tempfsid_mnt/snap1
+Receive SCRATCH_MNT
+At subvol snap1
+Send:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
+Recv:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
-- 
2.39.3


