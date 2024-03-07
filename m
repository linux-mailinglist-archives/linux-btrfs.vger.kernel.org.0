Return-Path: <linux-btrfs+bounces-3050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FB987471C
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 05:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CDE1C21998
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 04:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5367E14F70;
	Thu,  7 Mar 2024 04:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dXzmWgBT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yRpxUvZK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663D117551
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709784869; cv=fail; b=eLnRF4rmrgB8dTiDuuXkKsEew1cgeodRp1B4aXcfesVf85SPEM4Baj4m6xjdtfHBeoWmgDHK8T9l/NeltcHt3bUiVa9Zo9LuIe7bCEbLb0nW2yixaJzVKcmrt0YK/pEPA1Ibk6DjR7PMBKKU+c2MG57aspkaW8rFDY27+0LLr+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709784869; c=relaxed/simple;
	bh=KaWN7+WfL8WXuH/m3QIyVRiFmwX9iUm6yvHalxdVyQo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hE0eaJEJn0J40NAwvmOWQn71YokRdZFf2UJmQlfbTqPk8od6Zhwd8ci8Sr8v6OF1CySBXw+b4UiHSySxQ0uCNkfVuQfJrOO+XZdLkMnZgT1TTLL2KgnnOPAIIe4OdMtDbtXxDABjAnfy08Saqq5DHtx3ggQ+zK29K4hq4sYp7X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dXzmWgBT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yRpxUvZK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4271TqfE005965;
	Thu, 7 Mar 2024 04:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=XJUMgYa9lb+iqeO+UHdrd89VWpipV2gGNpSp5/Ko/g4=;
 b=dXzmWgBTbGBOSdD09+qdcfJL7DQU7Y3D8jtD6s4axFLdVUq84gL+wvAtK8S290mYyT4h
 69DfQAqjW8gzdIH61xsRvZilAlnNf4XqBeUKG2FpHg4e4HkkraeTqyCu1PFJ76mDVMPh
 7QpN7YSYEOreLu//ri5+RfPZxUEpMrZb5GFUL+Qrms/jW7SJTDxxvtwH65Mdfz2lkcjS
 Fj0tJ0wP4P8zAfJOtfuurOv7TwfqYPVOKtJgDWBkWwHJUt0GPxSAWIUax91fuEiVrroT
 eXhULPxQizNqyir3hj3cV6Wu4NseokenUaqDXtBVPzt3SbFDDgQIp2HvtcCIw/ntnNKU Pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq2aqrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 04:14:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4273q63s031918;
	Thu, 7 Mar 2024 04:14:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjamnwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 04:14:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEVGvyVEjs3BG4h0TY9pHyLVTzYDlsGelKWZjjZe6R9MyZvcnwnjzKqJVA8BPw/f6NzsbradD/EWegq36CHvTOmj+SjcBj8kIIayvqwvVPnKKXhwJq3pVzTiWuMPKR8H1UbGpCnDLKt8XdNr0Et4kfztNzDpD4UTXkB8oKiBpswJ11yBn6jcWQF/sFPxWKAZI7azsY3uQNnjoA1VFXb9wQqi4f7/bh2Og2BB7gwqaW272UXafqNNiMENcyfFeHF8+TAwSiXcHZsniIsPgqPSCMFIKr9xlUZHyIgBIFfr9vKUwdosamOoahC10vkjaNEaT/QASYDBZA2mf7aNNPPigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJUMgYa9lb+iqeO+UHdrd89VWpipV2gGNpSp5/Ko/g4=;
 b=YL34nVvVoQAwk/JAHYGHEJ/ZKKzQGsdUoIgOQI0yzqjgv9R068yhtVZjCleiaNek2eOrK2KxN+wx7As1Oe/2oAV8wjGkhnS2u7q/yq1/1Px6rddCCffW9FKL/U5Y1DWF1LrtSp7XOOtYzUbdKkaWCSr+8gQIujxzpo2D7A4bk/cnW8VCY4NVEeG/KPZS/1/G0W889UFVi6vvH7tn6+EsTQbMZ35vxzHfnCk3P845qHLoA0ya+EOXOa6hR1gkK6oU7oRKCyq5tUVNQXpC0u2DhiY6AYFq75zmXtlu708K0Hy1D4BZ/30nzsxT1iTb5SiItcPlbE/T1owCLn/hksYiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJUMgYa9lb+iqeO+UHdrd89VWpipV2gGNpSp5/Ko/g4=;
 b=yRpxUvZK9Ta3mwPqDnFFFi5iF7hFrOd3qUHXMV5/0RviqfPT7s60DITum8G2TlJ6qZGPRi0esdjJcdR/CCA1/8Q0wdJdh6ZvyWJD97vu3rb55lvDgC+fqrfDvEgW1c5KLMFEi66a72yOH+vZzSFYX8QGhsF+TvCGIYg5TNmJHFE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB7074.namprd10.prod.outlook.com (2603:10b6:806:34c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 04:14:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 04:14:18 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>, Alex Romosan <aromosan@gmail.com>,
        CHECK_1234543212345@protonmail.com, David Sterba <dsterba@suse.com>
Subject: [PATCH v3 RFC] btrfs: do not skip re-registration for the mounted device
Date: Thu,  7 Mar 2024 09:43:46 +0530
Message-ID: <e2add8d54fbbd813305ba014c11d21d297ad87d0.1709782041.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e20f5e-5bd4-48f1-18b0-08dc3e5d0edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cI2s13xB62pJlffigLkEjqNfMKSn7pIr5FYdccXLGlB8a2URKqiHrR9bT7FtkEHGX7v9GYSM/yQZy9d65GGMReTHlJZz92fM210D5i9ceLfXifUVYL4IroWa1QzqIiPZLOrZTMaMLCZCcjtIa94Z1dqwniWH91LrcsKwmYMJ9gqsjgBWGkL4LKhLjP/kRh3WQ3mKJU11RZFmtc9PdfTQHQj1iAz5vIqXEsCn3TV87wZZnujBpCCrkSek14NKDyORpuhKjIBL75L94cLUHoaONVjbnx8ZOiy9l6zxy+mkaatt/A9AtkO+PBQJnLCqEPFyW2i/1g2aIcr+Sq6Kf8Ir9aLVsu3pjZHgCqk5AcUB6YIqOM/Hjfdbfl5qHRxRJmCrGIFpjkkON4Yz/8FkC+VVDFWUUmfMUwG+sbylAtJUf3kUOlAESxQMwcQKJN4tOQhwDHzIgSsZ0gDxzFpx0fZArexscK1nmKo+WGiVzksBp924iPnbDmX9Nf44kerJZcwGIfRPTjELr2w2B1yT8HZSgLwMS6LMN85r758AFiroeEHdmKTdjmszH6vTLW8CT4EMwsCB+otTAKEgwn146zYuU5VAaFo3otI1DiNMzLL3sgd5/vXqrO1HmEPoo991IKCf
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/5bbOo4a2mQjNY8Cneyy4VnQId1JX8/Iwn3wGTKiwKDWJnnXk9Q0Zef04MXc?=
 =?us-ascii?Q?on3Md7Ry322PFHsCaCzt6gVUJuSpDXKzdGZNZ3sXXsu3MM950xTMviDMef4x?=
 =?us-ascii?Q?b5bRJf47gn1V+rKbFCzD0v5BwTTriKM1/Nqo7kwXSf4uRDHcp/wdhoaiQZ9K?=
 =?us-ascii?Q?azDW6s0DDXgffSnQslpIbmEVICW25XuISWYm5n6FgAaoy4bn1aPxWaHhmvMh?=
 =?us-ascii?Q?qe95OPKj4bfJiwXwDNpSAyzf5vts9y/s9R6Q0F5g3p0ajPqoCSLhn8IzOD3c?=
 =?us-ascii?Q?bVph/b7ZR5l5Xs6Z3Ph1sWahbv12tfvcaP3wZdKRpSnLEX7Xpx7KaRsiHIDM?=
 =?us-ascii?Q?4dQLNStw90TLjeYluhQ5P3s3cSts2PbFVDBUsI7E0+Q92uu8pcB92KFVZ0yx?=
 =?us-ascii?Q?z/2loA1vOHVjabDo03LkFKzA1ruNZzmOrjcKBg2OSuXiTG2tPtQ25VGHwz1J?=
 =?us-ascii?Q?qm8Hu1WaYWtlMr0TN53dT758eaAbQpeakLa9PLm30LI1BOckuJQJHY1gxEVq?=
 =?us-ascii?Q?dqDPdXzqXoAE2XzKQ8dds2RcemujCxoSw0dVaqbN8ZMHYbfBnBeDD+28Sasg?=
 =?us-ascii?Q?Oxly9I3Ap4SOjAaIu0SMC1rd91dvCU/MB7f3+q/ym3QYC8WttXa41CbgriL5?=
 =?us-ascii?Q?We3MZEmDud9Ri1vi0Ra/p36swTQ7tw8GvgEDe4CrvvMy2CZg6mJfzJXM7f32?=
 =?us-ascii?Q?JpM7+hx6ll5ZnTM9WjyGQHNO2RtHSfIGpbo2oGU+7PMerQ4d5XS2o0pBax4L?=
 =?us-ascii?Q?LH4AnfFUKV1ZfQjaGYqorDU0RyX/EKyUzYEer3Ho91zWDOxf0jRzMABR6ghL?=
 =?us-ascii?Q?Gc+/m9+ZNX/p0MV0/lTBlNxvMoqS0uL9wc/yyqw+GeV4Q0P7Tc1kihM9PNtZ?=
 =?us-ascii?Q?2W0Vm/J+ZpS/IEz0pt2zLHyAjKJZ21HX62ZuubqlNZ6/+/ENnhfRgSNWsOFK?=
 =?us-ascii?Q?EUNLtvl2n1uxSObBb+7BetTxAFzAfizSob6/BUZ/OtOx7LACNgZM+MVESFJD?=
 =?us-ascii?Q?/J+mN2gb5vEgOwnkQ8jo8iFvIDM/JJGgTcTHdoVXl/WJIyIktAxjm/jE+tlE?=
 =?us-ascii?Q?qS3r6gtYfHKt/ogIQjAErEyOUBjBaE9fu2rihPVGfN8DeJLEzHjdHwMMEcpY?=
 =?us-ascii?Q?M9Ch02JMfSWFypza1yqfljCYXyBbmJeb5+qDbmnMR6R7qor21cliXEaAEmYq?=
 =?us-ascii?Q?o11H+CqmDvKYjqzN9pu3+11SboJZLO+2rWb5dOyxR2ehmX0EtLD4WErbNcsd?=
 =?us-ascii?Q?UZafyagvlHIwdzR6fqWzI7Bg7MFQcSO5SwNPM6baIu/zX8QbqwcSBXeRuxaZ?=
 =?us-ascii?Q?yX1/mgxfYhIf0MM3T/dSJYoZK9Yv+dy/1Y40dBbJsRQklxTwzkXOjVxSFiQr?=
 =?us-ascii?Q?u0gO9MQokSVYYbbxmfhj3KWziOCe479nQMw/Nkgb36MFh5JQXx9D0EYdjkgi?=
 =?us-ascii?Q?1Ccg0Ftgh9Fzd3lIlrz9vpgIMcz8Oaj6Ilc34+xYn+lDgTGph03HJ2asbuOZ?=
 =?us-ascii?Q?fGc5l1FdmaEJk9fM19SdRDKd1i/lgRL/PbRd7bXaEITbm71oGDQXQVaZWRJP?=
 =?us-ascii?Q?DIylCEvN7Oy2+Bwib8QAg+ZsRHIwiPCqXe48n12L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/aO+jdhBniIqPcEBabnb8f6Zgk4SoDsHOGtPrConjJCFxDA54hrwUUeSL4L6CNQF7dAcB92JjRwkac6EmdR0ecmIo0FTXobxL6lFrulr1icjdhmTJALRs9SXB5G25YeWMZLBby0swp9l5+pNgL0Mz+Nd+MmV6otaD2bDPo7jlNMMcFVJds7bYmJCwptl+S87013yYSkx0wIFuRJW+f6nE3Sx9bDiQos0G4h6C7923qCEkrvRcg4JTw7BzOcktlv6WIwYGHA5ibI0ugxe20aTx7z9BO/YpEWG4DMqrG2AUT4ooLPy9/J5oz4LxXNUzk/S1r/zYftiWgqzgwJD0ZIAhmI/2tSX8Ai7ROPDLtid6Kr7jICIoiBl+p0GAJcE39xfZwFMhjgNT0IraM8wlWxhvhuCFF+xi0J9CuYys9RFhruUpg6Gjb8uEIHzgXA0cLqmp0sOC4D3xXHLwr8e0uu4j9ctiqIgLJI2A2KvJWvK2i25UmkAeBsIVID3PVf1BaqKXAsJoDznSg9tuefhP8rAekubLDCB8aOKbJxqO+gat7/A+J0SOoO2Ci20EXk2zKkIclMNIL31CHraCzYNVms5qIbHfQQ7UmqBR1cWgVxjQLI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e20f5e-5bd4-48f1-18b0-08dc3e5d0edf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 04:14:18.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7Up+i1Wum1R/LJHWqWpXEv9NnfUn73lAIysf6WE1uS2emTh1nwao+k3gnssjK/vq4QFZ5yMhp5koLL92TutWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070027
X-Proofpoint-GUID: AXeLTLkiLmTjyojMQDPKuv7u8uR7_haT
X-Proofpoint-ORIG-GUID: AXeLTLkiLmTjyojMQDPKuv7u8uR7_haT

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

Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Tested-by: Alex Romosan <aromosan@gmail.com>
Tested-by: CHECK_1234543212345@protonmail.com
Reviewed-by: David Sterba <dsterba@suse.com>
---
v3:
I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the RFC stage.
I need this patch verified by the bug filer.

Changes in v3:
Verify if the device is opened/mounted to prevent skipping registration,
fixing the following fstests failures.
   ./check btrfs/14[6-9] btrfs/15[8-9]
Update comments.
Only reregister when devt matches but the path differs.

v2:
https://lore.kernel.org/linux-btrfs/88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com/

 fs/btrfs/volumes.c | 61 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e49935a54da0..ea71a2c14927 100644
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
 	struct bdev_handle *bdev_handle;
 	u64 bytenr, bytenr_orig;
+	dev_t devt = 0;
 	int ret;
 
 	lockdep_assert_held(&uuid_mutex);
@@ -1359,19 +1401,16 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto error_bdev_put;
 	}
 
-	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
-	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
-		dev_t devt;
+	ret = lookup_bdev(path, &devt);
+	if (ret)
+		btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
+			   path, ret);
 
-		ret = lookup_bdev(path, &devt);
-		if (ret)
-			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
-				   path, ret);
-		else
+	if (btrfs_skip_registration(disk_super, path, devt, mount_arg_dev)) {
+		pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
+			  path, MAJOR(devt), MINOR(devt));
+		if (devt)
 			btrfs_free_stale_devices(devt, NULL);
-
-	pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
-			path, MAJOR(devt), MINOR(devt));
 		device = NULL;
 		goto free_disk_super;
 	}
-- 
2.38.1


