Return-Path: <linux-btrfs+bounces-4405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E77E8A93C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2E1B21BF7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44EA53805;
	Thu, 18 Apr 2024 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R6i9WsCB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K6Ea0mXg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDD3B1AE
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424220; cv=fail; b=IX6lR0jVF7AuOTQUbv48XiD8rNA/on1OLXJ7MPkjT+I61LxoCk4sRxo0dfHcYgNOeqxIJD9TSIgY/dpnH5tJt08ZIhAXFfNiN3JYKRtWY2SL62XrNr78q90sEtLH9tw5+u4CNzv7PRwvGtKii72XM0zE1A5B+X16SyOXZzKms1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424220; c=relaxed/simple;
	bh=LFc/akKQ6UlugHVcLO+jLFXIUx+hhBfmy/Xjjuipvns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WuaejvhbDqEZ6Xkn6CZ3kluWRX9nH0WlcUUCT80LQdGPbkgFbIYXUcijjNCII2a/liV+KGMPu+lc2WiFCg13MxuWdJQP5N12XYfP/S79OFJFC5+1EG2BHZ8PphUt3GoguPIXRp95GrjtOyMjg2DPs2HTldH69kjZS6t8q1j+q2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R6i9WsCB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K6Ea0mXg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3wxcO031358
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Ji4ZqNP9fNZUCSexmnB/02fwtxMlkE67c0+hj3/BnnI=;
 b=R6i9WsCBojKTaKyjYiHoYE1A1334eBYFbgiEU/9FTChJZfMaWH4C2X5whivlafIR5bhG
 quSK8OT38Eo0H8nOVekYedBnFZrqtnc2r3rPvIo2PDzYvvAnLq+ant1rQ8L5PKm04F1N
 AQEN3zDbhmB6HQ6v4zQ1rRom7iGMAlmjhXylTmNIgBSxA949vPyvgaUVypH4uTVRF7z1
 xSAZIUFNP/lAPrcRdjk4nllQqwTL5QLbaapeKah4+VvSw8DnCEeYYOPdjiAqIEpQCugp
 vltsKKM/1T8EfXr1FjpxGOc5XJc3Ih7PWO9LZavjLTFteMzbwjTc6wxVw2DyTKVMJhXi 5A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhnuhr5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I7A8jP029247
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg9y9c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBwG1q1iZUk1OJTVYcFg7Jyv8obJz7I7hNB65W+rp4DAP88Zd/mTW3F5j2D76bkilGe3cV7TQATCx85iflt+OEYXSEq1HeIGjs5qfnvWDLFKXfgErktuDp0KUY32CkwBAW4SdZdO6i13El1lJzQ1ztfQybuAHToPAVE7hUYI2LL4svZbWQaqtBPo5wjseKtB5bqHpSTBDWaaP0BQaVlR4Iko9u2ocifZcgKctExTJnFMriYWOJ+BGZczT+IREArffSt7CQKZF2e2bQsGon0QQzM8GsS6OAzO4k0yGfdkVV/jhqT+OA86Lk3FCybCsTYhf2mvVb7FV22nhY8KGH6wdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ji4ZqNP9fNZUCSexmnB/02fwtxMlkE67c0+hj3/BnnI=;
 b=A7AchAcj0KXGuWmyqog52K8hBLUA52Pn1ao0KsUI+WK/rjW+uufPDWLxxwwUSS2TyKbgmEfs73bfeZ9Xl2pcMNBiAUsMOlxVytlYZFOzV5jp/yakfYVX3pHGLNqgBZYVpgLGEtZwMNU9fEQigvfmO6aO5pxBrK+ySsZnUun53fZ/p/f+R3D62vzrZ57NLyqnHYiN8Gmd+ABa3haQU9u78syY7F+vmKHJG1NcWyjRn5OZd8z14HuenbpNpKe08i/fiDxrSnZosP9lwWJ2XGnON33oWOz9xwHSWUSYE53SY8tuUCs1symzFho4ihs299Vwq+38UyPYDlkPBza5LEUX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji4ZqNP9fNZUCSexmnB/02fwtxMlkE67c0+hj3/BnnI=;
 b=K6Ea0mXg0hcVNvy/SVzVSd+QOIG0fXBZt1c/zULPtc/GkHj9oYlo6kHU1Rf/zYZhS4vQuWpjq4ePNFNfEyIVmVe/NeHo8Z7q4EosQ2JKz1qVRuSeuhq6w6RtdsIgJmQTQAmyXCHtc/KSiWtj1GkSjKj790Wg3HKtvEJajR5afIk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:10:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:10:15 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 09/11] btrfs: lookup_extent_data_ref code optimize return
Date: Thu, 18 Apr 2024 15:08:41 +0800
Message-ID: <ca750920945dca118d562b974edaf8dac46fd7dd.1713370757.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1713370756.git.anand.jain@oracle.com>
References: <cover.1713370756.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f09039-640c-4d49-37f3-08dc5f769892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8k09qI/szSytCIFcXaXELFgt5aUkDOUup+k5hJ1JEl4gM3dPlsuVegR06+HoYx6OxO73dbKU1orpHMsmZQbJHhnk+FurQB78ZnXsoEKzc/RSq4zU/sZfg7VTk6/AWtSqa2qFlZxRd/hZlBUkcjjwy6RlRI4GgLSzqaB7slenmde6ERWQdjvRfiTaI291mhlI1NhqzszgedLHroRhy3SzuOsJznfQm15qZQE9czBHkqFDTNkcPPUxf5F8SnJPNCZ0JN39urgMfwB5Wo9UQV2eG94Hd0nql0eEZaTP1fOp8StbotZw1ruvD5j0cDxb0Yir9CJBVTP4H5h4cQQJQUnebPi/IpPOZbW7xrr2c15031kzgdfyeR3hpeM/ThBPIK5q21m1AsqkRRq8Cy2BuNb42vFKgIbHeZTV6AxNtc4PaGRAjmNpSvHqRZM8C3MZfhIWM424rFkU2V461UxeSMtWfvDwRsd96ZLMOKRPRuYTtOnT2fRm3ZP7IlDtJAVgYlPeigVZ747Edyynb7mqqnhN2BI5rF8lT3VyDJ91bFWGI4aQfuhgJfec+dhxPsbMLOyUDyKSKFdDqRRJkdC5BWGL+66dGqEWprXS3ldpLWSz6InPX/DuaucyWuTjqQT5yvnQ7y1bPbf8K8Nigz0hrx/7gCuAqsngLbwXaYD9QAU1Axo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9hZAXC+yfuxU6B0J+mq5uarT3gx3Tq5W/JcoDhH+yiPeNa2Tdn/tS7iEGYLX?=
 =?us-ascii?Q?CJy5AClXVLTHK/+JB/l/ObOFIhQ4rOkd33ugRRThWXbc15/HvrhBzBUcmR5z?=
 =?us-ascii?Q?n9TWkd8wo+9yauNcdc3gK/ZZNxmlZemFpDjs0P2wVKwKan2ZfiYILs873nwJ?=
 =?us-ascii?Q?UeZTBtY/T++4sB5fvdHJL0GU6y87ohNxW9rikdHECV4rC249J5KFdZXlrBoC?=
 =?us-ascii?Q?jbQPNPzapK9B3k1q1+wYb9RMGyTnVUCSdg+O61gYkJq4wwXkAS6ZNjLrbdCo?=
 =?us-ascii?Q?daRUzwtemTxF/3NN4XedFt1B2uM3JITaic6hqLxV9+VGtJteCkVy23BXLkof?=
 =?us-ascii?Q?OedTg0+pt1Yu8f2RgPgsf8LpAd6plSv1W93ipNOjFJUNFKtrVdMTo8oK/kNt?=
 =?us-ascii?Q?jGcRuV08UCl+7OA8NLgu2E/30f/he+mSkUxBP7d8tAFb7j+9rHY+ePcpvvMS?=
 =?us-ascii?Q?cpRlFMxcfekisHIVAYKoa01FA8dYwQe40n3BUfDzK51gbzAeUxUNCNEWKv08?=
 =?us-ascii?Q?br2LiNtMlxP1nMQtcqD8sl+3hio1PwoxDeQLVnUQaqsh+CHYLOprCI4cZ8Aq?=
 =?us-ascii?Q?PfgqeTXGXr7c6ZxBjdS5KuhQWYf3HdtRxEGgFok/6fgfh0+GPC9/yN7jlFXJ?=
 =?us-ascii?Q?MLkXDlf1+Ko8Y2xM1FTTiuWihVEbGQE5N7wo2f/di5wXPsX6nXx7vXkN/ssY?=
 =?us-ascii?Q?Cq2dF54DDJk3MWPa6N3Qi2iP/qy32XI/q5vLC6RzQIHfTTG47A7Xdm2la5Ro?=
 =?us-ascii?Q?DHSyL0jJYVwDMd1OObLIFdj1l7o+c+77IVe9Epfb3fA9PH4qIhlAH7l8mMlb?=
 =?us-ascii?Q?Yyv+3OE9dOMmla5+1zpVj7iQTXgkDjFAIH/v9pyTr+MUyDIy2HSi1kBHJlJQ?=
 =?us-ascii?Q?9E/M5ZxnbyP1foThlmJEbv4EayTbEzIzcBA3TS7NaUKdjULqogMrxyWt/IwH?=
 =?us-ascii?Q?l9+58HzUCaClSPeBZi1wqC847v5WOvlGnmJLRBoqIbKs3IEcdhoAvmTMWHIp?=
 =?us-ascii?Q?fGTq/Lml22GIJsOItfdzMLdVfYGuyOeVNSG35b98tQ2P+yB+5KnnnnUxCUZp?=
 =?us-ascii?Q?Vnb6OHunMFZ39g9pg5NMtnSTTwxeXANfv+ClfNgJQVWDj8Ks8+v39K0yed3h?=
 =?us-ascii?Q?mR/atFYDdUafmZ4CNNEBt5RBuB04QhvBEFjoIWcpfaeyWSzvG9mBX4Q5IK6f?=
 =?us-ascii?Q?iMto5pWQL2jYZj9kCAFjdsoK8Ll/F3LNrzUcyHdsQDZ67YKYcWr9V16hSpUJ?=
 =?us-ascii?Q?asQ/M0j78weJbmVEBbJ807Xx5rq7rbCEaCnhDRlJhcTJE3GWfLB2dCloT7CK?=
 =?us-ascii?Q?8flrqW4PNcxaF0RbPXZWdXiKTyNkrTL1SxTHA2hU4RGVzI37AwfjmAveF7AS?=
 =?us-ascii?Q?fkoD/djkbeJvBl7PS3kLu7e1ytuhQLZwMg5b/wnZx7ZXyQkC9pHsN7GqKTUb?=
 =?us-ascii?Q?C8RJ06FW3uTGgP67dBR/ZIp+m2y6dP95YhYonzKiKQTnfWMc4NmWhLOjPy3g?=
 =?us-ascii?Q?ngf6VBs/GbdMpI4iRBiXb1FzSZguf6SBmOGZFzmeYcbxqKiHWSZIADHMIe+w?=
 =?us-ascii?Q?iXYZtbZTDGYTMbsCah608ARDtzj2n49LfsSZMjt5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5YWXAZJeDxokNzPT7dLgWBjipvc8Dhfb4zH8PfZG0Kwf86J2LJEnKVAgn91Hvz76S0WOIFlgwMA2/fxISC8DCy8VP0GOKrOywsNlsG1HhkSsUQbvTS/6VRq6g6nxW3tk/72sOjSjl3acFbGLl4EYdFdLC+c9NTPmev5MIJktZ2q0Q1jqKbzznDpazjqBJ8mtAEkBrqSTg9JVA98HWN5Y8w0Mus46ep2QFMZX5n6PZMyvclZnxPYkgOkadmSXD8fXyF+z6LU63A1iX9VCHhhE0eKLOV/4BV+Wabo50YOkCvCM7igp3JhczNqflURusbqCl7VlsylqlostVWNhk2Op4vRhIr3LWZUplj5pe19CT5k+jbTlLARnNobCnKItBqLaSxd278+OIgeOTaHhWTAtilrVGSIEJW1GifOo6Q2HjzW3Lc7+d0fbEVb6UVFjb0n+jBUx0IGcjbCmkwU5aVyS9cwue8InuUATxslU7AkZUz7Y4GKH8HuBhUCCOK+nTabNcuGKEfK/Fdt7GdRbJxCiUjXXWb6Bxby/WMEmxn2IMOZ+ijQnyeRZ6XSvQNV+tsMSe5ju/4SDIvLpZqnMCyArgf9uH3CTycNEY3RvVlwokCI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f09039-640c-4d49-37f3-08dc5f769892
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:10:15.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFLOYvMC7wczYmmp5VxnRupvwVhqivhW3gH/ItLI6ArsbxQWNjtfP2+6Vvt34ZA9knrTQ/dB+k28zxzR8ZaXWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180049
X-Proofpoint-GUID: 41HI3dMuBsPUwQloIXtLhowpHgiwBmNj
X-Proofpoint-ORIG-GUID: 41HI3dMuBsPUwQloIXtLhowpHgiwBmNj

First, drop err instead reuse ret, choose to return the error instead of
goto fail and then return the same error. Do not initialize the ret
until where it has to be initialized. Slight logic change in handling
the btrfs_search_slot() and btrfs_next_leaf() return value.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: rework so that 'ret2' can be dropped  (Josef)

 fs/btrfs/extent-tree.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 023920d0d971..78dc94a97e35 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -446,9 +446,8 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_extent_data_ref *ref;
 	struct extent_buffer *leaf;
 	u32 nritems;
-	int ret;
 	int recow;
-	int err = -ENOENT;
+	int ret;
 
 	key.objectid = bytenr;
 	if (parent) {
@@ -462,26 +461,26 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
 again:
 	recow = 0;
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
-	if (ret < 0) {
-		err = ret;
-		goto fail;
-	}
+	if (ret < 0)
+		return ret;
 
 	if (parent) {
-		if (!ret)
-			return 0;
-		goto fail;
+		if (ret)
+			return -ENOENT;
+		return 0;
 	}
 
+	ret = -ENOENT;
 	leaf = path->nodes[0];
 	nritems = btrfs_header_nritems(leaf);
 	while (1) {
 		if (path->slots[0] >= nritems) {
 			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				err = ret;
-			if (ret)
-				goto fail;
+			if (ret) {
+				if (ret > 1)
+					return -ENOENT;
+				return ret;
+			}
 
 			leaf = path->nodes[0];
 			nritems = btrfs_header_nritems(leaf);
@@ -502,13 +501,13 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
 				btrfs_release_path(path);
 				goto again;
 			}
-			err = 0;
+			ret = 0;
 			break;
 		}
 		path->slots[0]++;
 	}
 fail:
-	return err;
+	return ret;
 }
 
 static noinline int insert_extent_data_ref(struct btrfs_trans_handle *trans,
-- 
2.41.0


