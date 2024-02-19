Return-Path: <linux-btrfs+bounces-2542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9CF85AC75
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B7A1C23042
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C6C5A0F7;
	Mon, 19 Feb 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="du7n2MuQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R0RSeb75"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457F59B7D;
	Mon, 19 Feb 2024 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372207; cv=fail; b=W9QIqhzY9YioCfSxdBM27cfo5bK+/A+rTbQ+glCOSGzg0BbveAXgMCdaFgJ4AmFzq4HPGRWCfkeDfFbV76hkkc/jow2lJDUt/v/AZVhr23qYT3kxE1AUc2gkHzHk/QFH3CsmMxoAxnWDXiYOiHK8G21Fl40zmiwx92E2MnzKhYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372207; c=relaxed/simple;
	bh=cwbMWBWHIHQl8mAueJljLlo9Oq95ZNCvp7n26Tj1gLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ry9KBBEiDOCq8pr4G6PktXcWI/mG6Uiq7d0vKDk7cFkLOc6Y11TrblPtVIinDA8IFeHYFoymZug7yDD8pOxF7QtCILNmKiV8UYT4CwJiKyudT+45z/BQJxyvCBO+7ihtEavxfygU7g8cp0JPSnlxaKRxkUw4Pbq3/djdZndOMso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=du7n2MuQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R0RSeb75; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIJ0is007922;
	Mon, 19 Feb 2024 19:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=JzTh6GNAQniFI69wmY9SY3ms0Wm7FXN5iyCFqLWPOmw=;
 b=du7n2MuQ2uo+m2oT3fLOeB+4tADCdSv/4f9izpRNdtWqvKltr4mOKYAQgGwZ2tW3XS6P
 Gp0FfmnzWCTAE4H04eqW1douC8EEiLKnYo+bmzVmZfmuFtcwngDNuPeA5e8g401zZpsU
 hhzYDP+R256Ubki+Kll83IxWah1Xo3LIeaox3uZe3fjCBz7yPkXXEtgQD2KN1mX/asQS
 PeTrYe8/BFDkPbseFqK0FeeJ6WG7gcaC9zwctEbx+YjjuENYeURorB1H83+KrX1bzzHs
 9HpVVM/wJBbEGsoC8HsC2JquTLL4+ZE6fjxAsoMjE2hnFgNJRYV21eZmArmV+lNMjF6K IA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamucw11m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:50:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIM4X6032517;
	Mon, 19 Feb 2024 19:50:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak86amsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:50:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcqoYMj8rZhVN45Pa12A7vEqK8afauTdA7ktKtuUVaDbauaGqDedF3JvQk8X9BnH7ALWlOjTyBRLwjrfha1xxFSWPBtVmOxf78GZY+8E32ZTumhVel6jq0vsGXUz+3z7SGlrDh7bG0Mk37iaAzZWtM1+QCjieFkYKCOp3g5TJdZy8edRpgPEAKXWMGAHDi1ew0o02atfMZRWNgLAF82SQq12WFi0KwFwNBmM6TDwIYsIJ10cbm9qXndiy21lHDmio61VKY33fOiDg5y+xTwIvGIt2ieoTskXF13VxcCKAH3/UcuOQuT3XuE7HbicB4sAcBVDtD+hhqpsxJmfNnGhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzTh6GNAQniFI69wmY9SY3ms0Wm7FXN5iyCFqLWPOmw=;
 b=CZ3pg9S0sXKhug+hDv/mV02u4kzatXv0Mzt4UcFNoB7hVRetLnjRl58rrgxGDdBvKZtH974mVJEvxJK71M1HkLUBjEfJBXRBaROpm8rK7LPNvOarWqaTvej+2bNz4peBbZE/KAylSzzPntnDAm8ILkBQ/COrmZ+d45KucmdD5SvHRq/StDbAPCObHjrHO2lEfQx0R+9X0sJemRLXvjFAeZz4ZzlfRYwGYihnJnZ4JPU3x44oifYaS7TI8GZgkvVE4W0tMepZlVWDlXYezy+QGfiigEIcSDoc3V7Q4/Pv+z5KvZeH2DcLEa9pEoFTEy3CnwnW9o+HaGombfTwfUCOgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzTh6GNAQniFI69wmY9SY3ms0Wm7FXN5iyCFqLWPOmw=;
 b=R0RSeb75iM+7dQF/pBZVYbeHQ4LGY/m2BOunhDJORxkJOOXzeJfq7NK+vDzWiOq5j2XS2cEj82ttXZBal7qIL/DJjOBp6DywokUVXW+Z43H9A2lOfQWi9nzwZoqlNB5U0QWo19F2AnbmCgo4jPoR6XWHvStEVa9GwmSrfRwBx1A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6852.namprd10.prod.outlook.com (2603:10b6:930:84::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 19:49:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 19:49:57 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 09/10] btrfs: validate send-receive operation with tempfsid.
Date: Tue, 20 Feb 2024 03:48:49 +0800
Message-Id: <7d0b939fdcb0052c184e18226fcbbc4454508243.1708362842.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1708362842.git.anand.jain@oracle.com>
References: <cover.1708362842.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: aaba7eb4-e145-4065-7c3b-08dc3183f351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Evq73fdQdvZHTq8dFvqOOGn36xoACL/oAoSUdZb3pCIwwg/WhF9S8Xd0mOHFl84at4l4RKcoBKrhbIYVwfncg63WPdvW6JfWR7HFvyzcylP1bXz4CTmPegYfOos1WMOTnxm4aCbgbDIHUS8/oylLBDaDFC26bX+Ovt0NOC96cFVKbfGIo084C5nd0Cau+/HuiJpm8gWzb8K83xwjMlFNfvjjuP7faHjJ0KP2jAB5m9tARs3D8HmaHMa2wltNZlAJvgzRKWK4esolCA4JFr3G7b0SMLrU6pbUDJG5aCwQlw1gBEEQBCQALMEAr7ZHX2LA6fCCdmKgcpCsE7xY+BT/Szx7rbV/5gXGNWb4DHN8StAabQTUqlCRkElSsW6Ut006enlgNo81MZI035ig8Uo4pYEvvzAlk1YR/xwxmSWWiolZvXDvmJewXQ8zTQZ/4SQhlBk863MSlmE4f/tn5jz7I8hwYOWHGQbrbjIGoQRJdLllWdn2AjfzzXSuFl43HRACOkTOxC7v0zSqw0LGYOK4jaGGEV5kmlIxfkDS80pd4Z0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bV0XqepPGo2+N2y+lxs7NMExGS1XZPxz4vy6yUciU2QJSJLlnAKh2eds0llc?=
 =?us-ascii?Q?q2fM2boLMjuLGOEIPP0SwUXS5blyT9jL1OfhkX/2jm6TcwlMarY3GrKKfflu?=
 =?us-ascii?Q?v019OzVi+Z1bDbcOQACa0eraHvTPQ2MQLJqEkxkdUZ4JUyBXtbqMF1aeZ9MZ?=
 =?us-ascii?Q?JTdOr3XQn5SVEYjOcK1AJpxie3YSe93WwsbbGZtyTtWvv5IugU4ar9WS5lAZ?=
 =?us-ascii?Q?ylBvpP0x14hrcrvxxdWLYowKdriPRXkvTvAa1yZylhfvq4tHNRirSn9Syd8s?=
 =?us-ascii?Q?1mGminy8TuNxtJtkLy7Qp5MAEr63igzwrHXvonTKZaAtCBTvD+3yOjVVble7?=
 =?us-ascii?Q?wKBLU5zITaD6sCyW8zgePDfHUXqtizjH/sgTdJlFh/UxFj/aiUUtj/V4M3Uy?=
 =?us-ascii?Q?Rc77nNazvCQfDg+lWLy0oM7XhZ9QmzqUpS0bDRo7TrDoO+c4J49psxssnoEF?=
 =?us-ascii?Q?Rl7f4beqMb6LS1QTaTNQnRbcNFsYnK+7THc7om6J4Cg0kcoccgds0wqTBH/6?=
 =?us-ascii?Q?8D7i/0We6z/6ZmSWmCYNGRQWK/WkjbAEa8OlKsPYk/1EY5NrTRbUcKbcT8PZ?=
 =?us-ascii?Q?Z5edjbkbw0t/dOaEW/afOLfp6GvIyArrug4X+hNdjJk9xS70J2uPpvM7LXYI?=
 =?us-ascii?Q?W9Z3rAfV6Y0w53GFXfiT7ot+QaghhAa/X9CIgpkSdlzxDjXeJjZmjrhVFcEN?=
 =?us-ascii?Q?WrrE0ETTPZchfHMU5BAYrorAQWHzECyhdhTApIXa+2L12YJDgiI1vaWCHruy?=
 =?us-ascii?Q?wFdYcor+jp2f7wz7NZgNncpEZkVJhEscqwX0ElOqn1gpWeZdvBCDZJmvQ0ck?=
 =?us-ascii?Q?NJ+vwLuHIiTLCQfI9HOy9Zd7u5HQlMsgPY34sjzXJsN0N2gmr9tn632e2SjJ?=
 =?us-ascii?Q?0QCP0WdCpJJf6Tj6S4c+165zAjmtns7GKxezln8AqFgEWI0h3k8vFfZVmIHF?=
 =?us-ascii?Q?9F2FY4SvM6l+rL2UAEoyorPXXGWiQz3VMq+3u4h7GtFCpQ4DiTf95NuTRgRT?=
 =?us-ascii?Q?8cONiUxymCxwFOBqKc2xSSnIzCXMw74GWZtyuWytbhgclFMhCTXHTOqVvzLp?=
 =?us-ascii?Q?Q/roI7/nHV0RN5Y2DU0NgEf7W6UznktEcvEVcZI8hGaxQzYfr9nxce9UKHDr?=
 =?us-ascii?Q?vQOjPffAzMRLztPdoBSaIW1LpGDTXBvGNRs7jA50j3pIVKtLeb87ROMizI2u?=
 =?us-ascii?Q?29jCjMHGZY6gx9f+dwosJJ/plFViVNpPn+1tnAZsizKF9c/ritwJlFBeBEQP?=
 =?us-ascii?Q?16i/Wx/b5X1ibDvgB2Xxjmq0CmFPz7Yx5KWQ1TtRmy7oFJksc1YPaUJV+RVb?=
 =?us-ascii?Q?50mhB1wgAC88y9KCgjMv+cDI70Oe5HO+GB08kRM4MQ9NZMxk6li7AOXjBohw?=
 =?us-ascii?Q?P3WHwphjTHhaVz86FqXOeHvugt5bmDXFPUPlHieG6URdfU2b19u8iLd1njrH?=
 =?us-ascii?Q?tOl4afdaGyXL695J4YLd6rZKi5drHm9VNTiN8LjS9eHHWx4ItpUutgCBxl/A?=
 =?us-ascii?Q?g+gxbHxdjpsjETrex8tXVPeNArkQ6OQ94CHvOh01Eqg6YMLnxt8pmYJlnzDg?=
 =?us-ascii?Q?i3NtFAi9/Hy8JEVFSzt+NNkvrLc/QfJg1DSqlEFq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MyXsLMoaLVVz5rCPAQkeOD9ZLyZuWmGIqV3JdiWqmVvTspmbvDMYWvxv+UsN59Cg57L+uaCmEt/ifFzd7TammkKeEz4n2DWZPQBR8iSbmOxKKpJcMpORF97/o9vN6EvgMHh7Rduo4JYBD8N1otnknmSe/AHyyN5rq7enkcPyYV3mRGFwFIXRTq6VXkbdwwdqY0dcxzLIfNiOthTcAryvRfzU9LOLx3jFBNI+ru+EZlHpaCBxEeS48lbcyr0Ev9VCpDITCuvkRdTAERQGWRcH8UPJQGmbGP4Gv07BZh/+1yhNAGQl68SSK5mOjWy0fGuSSN5o6C/p32VljPXlWEIoKy8TmcnSogwceeG+KAxEL4VNESXW2imDoQxlumptBrVuaMdKIUUIO32U0/nvKsQ+MUBm9p+LGWmk/Kp3qjDPVAUN+bF1R2RmfMsKXO8N7gES0Mi5JUAiLj9tJAZo6XLon0WdlbyvvMCzG+aVchh2bZgTcteII055xjE9l24yWLDsWKod5Iv9sTyzegW1xMDO8bTaHpztUK+npiWDc+7AY4DhdpC5PvuU3XLckniljCOEgF8Bbn0BKN3hAyfaFPCE72jyfikbRiaFuyY1GXTzvm4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaba7eb4-e145-4065-7c3b-08dc3183f351
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 19:49:57.3308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoKFuo5QsZh7DjLTd4CZWo11LZBn/LrlBiI1u1kOPnJaqAudaWOQfFZQrleZSUtq1jk6ZJmO3GFySTeUGxWWpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_18,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402190150
X-Proofpoint-GUID: 0h9CBdjCceCBjVXMGvilQrbGBnUdVFX4
X-Proofpoint-ORIG-GUID: 0h9CBdjCceCBjVXMGvilQrbGBnUdVFX4

Given concurrent mounting of both the original and its clone device on
the same system, this test confirms the integrity of send and receive
operations in the presence of active tempfsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
 Organize changes to its right patch.
 Fix _fail erorr message.
 Declare local variables for fsid and uuid.

 tests/btrfs/314     | 81 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/314.out | 23 +++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100755 tests/btrfs/314
 create mode 100644 tests/btrfs/314.out

diff --git a/tests/btrfs/314 b/tests/btrfs/314
new file mode 100755
index 000000000000..59c6359a2ad8
--- /dev/null
+++ b/tests/btrfs/314
@@ -0,0 +1,81 @@
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
+_require_btrfs_sysfs_fsid
+_require_scratch_dev_pool 2
+_require_btrfs_fs_feature temp_fsid
+_require_btrfs_command inspect-internal dump-super
+_require_btrfs_mkfs_uuid_option
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


