Return-Path: <linux-btrfs+bounces-3404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A888000A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887B91C2030B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97015651A1;
	Tue, 19 Mar 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jraEuBLr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JcHL8m8Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37426651B7
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860235; cv=fail; b=m0Pmvng4HOe3pcIZ9LjScgFhilx8b1toaOQgtEgof1GRF/E58iSDMoo7FCGIhUiTUIPYDW9uLiDKqIyCggqSR1kR4NC8MkU0XzxadaODBGeYOKCzVFhjKuk8C+78Xh5/L9FwdGrsDDQjhyNDoQI0RVOhtGlFjkdsXfiFQmHgIhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860235; c=relaxed/simple;
	bh=Fpn2aRoHw+2WMQDixALhzOnLz9WjYR9ZcKR9rbtONrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QAEEmcTO1D+TK9o5oxNlYdSNeye1bkQCPKNaSzs7XAVVS6QfSqUrIh03w1Gu8EYnGSsSC6SEa5bEHHtpNouvQ1AhnjqXsYgCB7wTDJxF/F92RjrJebDmcyNAwHmpx3SIQ4/Y+GRBSLBCGf3zJbIsGFVs2YfRIOG5D8RbHtfbgnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jraEuBLr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JcHL8m8Y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHZCr010741
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=yWOXTbQrx/cIWjUDojYyAFgn1JtuIvwdPyMPI4v6YbM=;
 b=jraEuBLrlWQWQcYWtxDrwo5bSEtEatrbCed3awz0o+YxwmqoQV1Hoy82S2Xx9r05EHmB
 TkUyErZY+PgYSCO9o5FCh6fBwIZReNPAMsZ2eMf7kqW3ZrIwFl6j0yh+Pupk6hXvPdIF
 7FeZzVWtVLOgpUJEo16t+G2OUnVt4jRORLYY4iMpVejDUi/lcR8njBF4iVh4PYTE+r/r
 eORXTpHS7Kyvi/adNuIhBmLUcMLClnA+JBiHXAaul95JQWigvf+J/fPGKYsFj9v3IVuN
 JoGduyccFxrHwQkk00skQf+6ZoUlmMVYq4WgLbXSNgu6ru1asjajcDYZquQKgYY+e0+1 RQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2115rbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JE2UnR007529
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6cn3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7VuRomVnzGKQ4K31iLAjdGTOxJvqzCbbPFYT4Vfmb6Hv9eu7I/RtCFuL8j2miZpgSNE9G6n9HA08j54pPGrUE9PLUCPXtxeQNvTL3NNSmAiGoZoV2VEAcHsZ4hFPrv0ogkqrQBtY62dMt6npoMZNHT96S81zuj5bWu/3quiEyHZf5Ye9Qx2YE+baZUwIkiqJE4bw6Pq1t9Z6vEicq/VG5coe2s2BDOrGQTYsFOXzJrAtjzg7jFKwkX2HfTrUgZxeyVjnZqW3kzaDu7dxUBkd9BgEDNcBypFtbk8b+WczAwoNIZgrGwuP1kSw94L+5AH3UUJGleZsnmqYwt1Tvly6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWOXTbQrx/cIWjUDojYyAFgn1JtuIvwdPyMPI4v6YbM=;
 b=a5sIv9OYzoukbVq4gTM8c9ZqaFvQSKpOOyW9lwlAqgTHhXIL3+ogmgFntdX6GxxnTY9GBjmtfj4jaXAIruccj+rq7impufzSzbnzKAzuF7scBbTQJTIWZ4AMnQefQPXM2enaKnls7Kf61OrhpTpelTP/KRi/T7OPo14ME0A6lYJT6W4SQXliqG0aPeRJfrWIiZNNZ5pUzgUOzgB3E9a9WuWE17nz+7/c4OmXpTTasmM02ZdxsbhxGmhpmB8TBUKVu8soZTj1XZTBGFC+a7AlsVePSYue5gDUTdo8Tvyh2yAEkV10U4RYSqtefvUAJtrHaKp9OCWPXnP9FYvp72i/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWOXTbQrx/cIWjUDojYyAFgn1JtuIvwdPyMPI4v6YbM=;
 b=JcHL8m8YnvFoAMJ+8TSxGKGdmXarDCs3hzbhpo1kFdMrcMdTvYBAtuZnzZU7As3rXaq/ptDyV9INJF606LqR+KC8BLIRPecS1qeoCqdeHCm1mYjMOyzReFyDSQSC6xnWvIcdm3rtgnY1Ljm7RcRMjp5rScJ+qq/+FVF78Ugedi0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7460.namprd10.prod.outlook.com (2603:10b6:610:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 14:57:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:57:10 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 09/29] btrfs: __set_extent_bit rename err to ret
Date: Tue, 19 Mar 2024 20:25:17 +0530
Message-ID: <169ecf60e4d061574ef0401e705feef54a370778.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7460:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ey1qG/Xa/g/l7v3NUfWv7hvDTA3Qa41+Ko/n9ejmEi2UExO91DB4GKOk7BWR1SjNL2yLIgwb+iDAdygSTcr6pbStLYHkUUYP1Mxb/BAONFGmU9X31qnAXIKPCO6WHl5JiNOK13t/VREWCAoLEDdc/GUAvMUOz2aVuZSIv2xUaW/roPKODLqiaWVnLQGRXBW2Vdr5XC/OoUQmWhF3ZqB7p1TF8bC5G/vhJ41DOmpTL8SNEb07vhiemjvS2ltTs1WDEivOcr3QQhaqAsCgz7R1wN73B/5dlmiHZ/Lw8XzOgeH8Dly05lwipcdhtpW06X+QpGB5JCKSdDzZeowERSyOsaxxHpezSLmRn9xZEevf0P2sYP3iVRXb6tgS1Ef+RaFWYV7BpyOgN1wVzI4oOhD72GDY81jZM5AwLSQVZQTFenGMZ+v/oxQgZwHAQpbs9nXDdArvhpG1iy6Dkzsboq4rzx8XTCBWD8bYnaPXFcBeMpgKQ3rr+UOFzXL4+J4fUpAF1smqlrBp4y9aBj4F7dW4FGQ33jOUKky0ZNjLb88j2J4Np0+qhix243JJ3BOiuzhYb45xZ0Uas5nJ/9Wz9izdJFNeRU+bjcPOBw9sopfoY7g2UAXZMnxe2R5EfAd+qilxFri2WgkHTwEAE9T0rbQFDDtqzKgI51DGPggOZCRqqjg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Df7TN6yO7czuRuK6XKvEd4NQ5wVb5HwaB3S+UIIUBImqr+BR/puZ2vySR+0m?=
 =?us-ascii?Q?/PxeNMsUcqLNP11Dwai21f2xcDp+2t1PVCJJLItnluZh5Je7u50A0ujuY0mV?=
 =?us-ascii?Q?ojtyxP7W+YRUDYIKOQ52qBJhhR/hgO60ouENXiOfYXPRGDj0hUzrKMbrUCPA?=
 =?us-ascii?Q?nXSfmNUzo2O1S5IbLYsCNb+kw1orNWiDEEEPYe2N+xMuielPE36tmGOjlvIS?=
 =?us-ascii?Q?sZlAkHsMKQ+YSEtiRcMK7CNjtabAtCQj4f/pZjKGeff6J1YIq0t9Xm7zivdS?=
 =?us-ascii?Q?6aLrP4qPCfnRyRVbIKGzHw8BOwwwbvmD+Itn2bOV3ppfBPEKxCh50r0YPBbE?=
 =?us-ascii?Q?jj7hleRIr+p8kKwKXTmue1ZeGyPGB8bv0VAowVwFJ1HiHTQmK5u+L0JwWBNX?=
 =?us-ascii?Q?9kDxviDd9PZD58daPliQX9jPWm+Um/mUPSR0enTyV3MRNAgHjuGrPdDc2nY9?=
 =?us-ascii?Q?x/sNI4KeqYVGWvo41LVNsPDSHPgR4CsBlSVdOC3GgCbUypKsP9sdg0a+zboO?=
 =?us-ascii?Q?6UCCU1YZRySAOjh9hDKLqidvCMo/uCn6Ta4Wa3h8fxOh00IfuA86dqBVz2a5?=
 =?us-ascii?Q?QA0ur+cglGajR/RYOlY+YFgJcAM0hnAD/j8uquMu5elWWzngeA1D8CquXfYx?=
 =?us-ascii?Q?iT8g6z4/avWnDkVJRDtPFn80krTnQkzSnBoAGfMkvTEgLh3yv6Cm3tF5b7K/?=
 =?us-ascii?Q?TSxhK5K05lp/LAjvils2/VO2udzRMZv6xVW+1BGXYBk+/cPvWFT/rbpq3gRx?=
 =?us-ascii?Q?cSBtpkAbwXPEeLm1GQ/3PE7ypqHnBT+5Dje+PYGtF3gPMSBDbw89R/nfpeqX?=
 =?us-ascii?Q?xQ95vTXzTZ5K4cJbUXK6q9iNIqPwGK+nOA4LtL87MIQZjVPPcZ2wSzSsl8uG?=
 =?us-ascii?Q?3qQOoSjYpsud2V4nyADQ/nd6RLLZJiJqbkpa+6UrqzEe7k51YT+4RpmI40Jg?=
 =?us-ascii?Q?oXFA3WmM4TOwhDE6mPFpOHfnluW3uPnZibt+Vdlphpn2byv+FDwuvwc8/n6m?=
 =?us-ascii?Q?bR6LqC5obEt0yPffd8JVHHKENZ31JodTypXtxuQpBu0/h9qIuD149xfymeGa?=
 =?us-ascii?Q?a749ilwyoC2N+BDk4iNn5ehvIcGR0iSdqos++6ht5xnIpndTo5PNMfZP2JLf?=
 =?us-ascii?Q?S6DKN5S60EybjFkc4E2CMo1MG8S9TmwCPSnaiWqvxKS7RDSxFAYUCv82Bh+o?=
 =?us-ascii?Q?/iavlCNKX3MeM5CYx7Dcns1Kq+hIdOifrD39seGt3SC9lc6fQCJUiUJU8DV+?=
 =?us-ascii?Q?LA7MFcaAZQj5Vmv5xzoYwX7yNNiaPl6OSjz2LbIa0l1ui3ypMjavqlO6fwjc?=
 =?us-ascii?Q?tCF49wCUl6Gw4j0GglLo0ptUh2bUD7EnyX4PiasNnjxOeaxkLjDvgYcT4+io?=
 =?us-ascii?Q?ehdLK9tvJ76MB9D3/B8aGqGYnT7uIsnKw197IkY0npuqrBNshfT83zPIigiH?=
 =?us-ascii?Q?kZX2i14BWDgW5rIhlmc0yJQoeMBr8yv/RA76qFImqbB+QlI9Tzx6v5zrTBWF?=
 =?us-ascii?Q?PyqE308VQtaowGk6bIMx41UKHoKiGMtd40/InlpRUQHPWtDuWQhOTJpPWCWF?=
 =?us-ascii?Q?eV4vx6NeUl2y4HroTH23xwh2wTzqptjQwPNaqNAAwGo39qWn9qdVs5WTfPwQ?=
 =?us-ascii?Q?SW+NDXemdWdtBJCcPqOC4B6MZOI3rrYNLd70FvdEJfI7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	f32+CQsmRr6Cd8HWikIJRpTjUvEqzDYEJZ79nrU40IQ7JV7efkPoRiO+/ek+t35V4+rs7/aKVZ4hAqa8bPKfOGGTN6kk120VoLHbLxmek2aQGOa26tQGp6vuYEX+nE8ZjL7TN4MZscfCVddYz8Dnb30nRFX98+2sYQq9FVG1SeNrvgADLXu4sXeTcEZYy6pBKME1JE6N/2zET48p+URL56bKfncA6AzUBP6HCAzi9sxMBl+jZKRZyHGcjzqKaU4S51cc2mgbBeG+IljwI4jSAg/lrMSlqDo0oqRL8hY/nBgyNo4yqwtHHV5UC5jDE6a2zAan7hCUoK5bTlm4COArT+cnMCBULpgqa/1SuJeziCKUTlGWhD8Wmi0mEkZVu6uIYqt4Tp7dTjPMz8BXB9YcCUybOJlhKHalDcBJW4D/vgu2E4tGe2gOii+blE6m7KhdtIJ/A78owMfuXsNyDbSajkcfpI5EVB2uN60AYjJ+8RMMkmSLGgwmv16xUlEHICJLtZyid8v1PKDSniuC44p60C74kLUaXcns2K4HWkItKgA7AHHcqdfc4rXyZttwRFVqqr85MSkIdnFFOdU6kukfw4OVlGmWJ5XHN2KsifcGlzs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2746a1b-6d2d-4b74-47a1-08dc4824da7a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:57:10.4480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJy+u4zgZBW25da9Zo2dnGYMESHI/ENksJnOASH8VWtnM5y0kKw5h8hDk8glqU9Np4oPFTHs8LUpxNpzHkB02w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190113
X-Proofpoint-GUID: HQkHkkJcqnqiZlDEkgxhFmMPCU1s9VUr
X-Proofpoint-ORIG-GUID: HQkHkkJcqnqiZlDEkgxhFmMPCU1s9VUr

Simple renaming of the local variable err to ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/extent-io-tree.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index c09b428823d7..0d564860464d 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1059,7 +1059,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	struct extent_state *prealloc = NULL;
 	struct rb_node **p = NULL;
 	struct rb_node *parent = NULL;
-	int err = 0;
+	int ret = 0;
 	u64 last_start;
 	u64 last_end;
 	u32 exclusive_bits = (bits & EXTENT_LOCKED);
@@ -1122,7 +1122,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (state->state & exclusive_bits) {
 			*failed_start = state->start;
 			cache_state(state, failed_state);
-			err = -EEXIST;
+			ret = -EEXIST;
 			goto out;
 		}
 
@@ -1158,7 +1158,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (state->state & exclusive_bits) {
 			*failed_start = start;
 			cache_state(state, failed_state);
-			err = -EEXIST;
+			ret = -EEXIST;
 			goto out;
 		}
 
@@ -1175,12 +1175,12 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		prealloc = alloc_extent_state_atomic(prealloc);
 		if (!prealloc)
 			goto search_again;
-		err = split_state(tree, state, prealloc, start);
-		if (err)
-			extent_io_tree_panic(tree, state, "split", err);
+		ret = split_state(tree, state, prealloc, start);
+		if (ret)
+			extent_io_tree_panic(tree, state, "split", ret);
 
 		prealloc = NULL;
-		if (err)
+		if (ret)
 			goto out;
 		if (state->end <= end) {
 			set_state_bits(tree, state, bits, changeset);
@@ -1224,8 +1224,8 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		prealloc->end = this_end;
 		inserted_state = insert_state(tree, prealloc, bits, changeset);
 		if (IS_ERR(inserted_state)) {
-			err = PTR_ERR(inserted_state);
-			extent_io_tree_panic(tree, prealloc, "insert", err);
+			ret = PTR_ERR(inserted_state);
+			extent_io_tree_panic(tree, prealloc, "insert", ret);
 		}
 
 		cache_state(inserted_state, cached_state);
@@ -1244,16 +1244,16 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (state->state & exclusive_bits) {
 			*failed_start = start;
 			cache_state(state, failed_state);
-			err = -EEXIST;
+			ret = -EEXIST;
 			goto out;
 		}
 
 		prealloc = alloc_extent_state_atomic(prealloc);
 		if (!prealloc)
 			goto search_again;
-		err = split_state(tree, state, prealloc, end + 1);
-		if (err)
-			extent_io_tree_panic(tree, state, "split", err);
+		ret = split_state(tree, state, prealloc, end + 1);
+		if (ret)
+			extent_io_tree_panic(tree, state, "split", ret);
 
 		set_state_bits(tree, prealloc, bits, changeset);
 		cache_state(prealloc, cached_state);
@@ -1275,7 +1275,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (prealloc)
 		free_extent_state(prealloc);
 
-	return err;
+	return ret;
 
 }
 
-- 
2.38.1


