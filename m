Return-Path: <linux-btrfs+bounces-2538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1B385AC6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97704B2480E
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356DA5821C;
	Mon, 19 Feb 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UrLxy0Dd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qkZbcAfy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652358212;
	Mon, 19 Feb 2024 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372183; cv=fail; b=mqXKynTWsED0+km9bYpmkzbrjk0b9hJrs2K3zSm6nMtZEvshO4+M6uQpE8b9Ht5izj7y+SoN6+0dLTx9tDfCWrjC7iX7Hu/XhKDoUbHE1kQOG50jefzb6qQy1u4k/zoB/+oAmqRch2bXI0rx9eEDNIbb/8qsQcwNeO18DPjJIuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372183; c=relaxed/simple;
	bh=cwteLNONSzit2Nb4utLL7qUOrgHHQb3iP6SY9scHo6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=adJ77lUMC98aJoP2azhB5uLeM27KJTzwHTGhe3+HTv1ZFanZ9st0z5UBso4Chm0uSCuPknZB7uX8Y+Et6SkCC6uCAnzaUMNuJA25sJGRsyB0z+pw4CMD+SZ1aGsFt7XVe0MPO0Xfk1FWAIPV22g+SCYieopwYw0etLHCUaS2k5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UrLxy0Dd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qkZbcAfy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIKUTb007295;
	Mon, 19 Feb 2024 19:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=hQiIibmcBBgyFfzeHT2MQIhVAWktmMQQKaLRyp0GsDs=;
 b=UrLxy0DdF90dRjvfiVd+1Tdhf6G4a6drLnxrFIQJC1lYu5+KIz/J1m0ck3I/BdzCpLjD
 DlgpM6BkIwEQM9feIXOj94B8X9XiiFQNb79l77+um8MFaeUCav4YiQUNWq7hw/zm4VK+
 fKMDmyWTnaFdLqy0M1nMiDHwdy2NS2mG+dgipDe79HNJe29w/p4hFjSKHBWAhuYPG1xq
 EtadRuu+T4odz5DOGol0Uh/YdU7ZAktaJBMBku87Z+swY+Kb4Bjalg68Nrgbrxs/3HYx
 SgBXh1QNqn2N1EYwfhm7I19Iy9G58VW1DnwQgpSWKgqV5teY9A9LyJ32arZvkzfLeQzF Mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc522h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIKZTg037778;
	Mon, 19 Feb 2024 19:49:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak86a10m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUOn+vlHF7D1a+qCetP3n9kTJEDPT4gRJT4EwZeLkbZVKUmFbF7ryAahzK0kT48AqXcAFc6OJxId4loGBXxGt+PFS11BqbbcarDNitZYet3woaTOQY8S5B02elrc7oQ16SZGzDsR5uqF1u8M2sQ55vyObIx3YfoaKwjT5tbrddVrAIw828FQRYeJ8c9NKHH7y7RImcfvdmvNPwH6LNmdyQpreeAN8Nz3862KQDFd1fr7YoiBQiT4NUvKy51OBvK0MVPHUbkMBHDVaAqZpn4EvKmmRFU01ghMG7wDQwK5IIqFKPT0lNMjW/WviZ42+KIS81eKdPXZxojNANTKj95o2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQiIibmcBBgyFfzeHT2MQIhVAWktmMQQKaLRyp0GsDs=;
 b=h0tRmEjFw7iI3n4MKorp/OPxSzt6Epn7C1FO7duyAMpT5Dmk7u/0ULdnrtcDOLDPo+Q8pAgwO+k4v0ePe/XXibvU1PCjFQzh+Xz9OqkrAKq7K5cFUtysM4cghGFHQIVzUl4rYL5jQGzHh01YLTIFI2gOj0lurqtR376ad0yTBHLRVYj2v3A0qFrULoMCB6qEOEb7xdwii/MCprlQPZHxT6GHO4SSlxM0+G8lTrxL+4TQic3HWCp+i5VwQNJ4i+Zm10ErZ5r6sieN0Px6EvFW+M6TkrK2sw62/FGNdxk908Me7l/xJIvCj16J7PFFjE1VL9lpgp7YVxED3+V6eDo86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQiIibmcBBgyFfzeHT2MQIhVAWktmMQQKaLRyp0GsDs=;
 b=qkZbcAfyd2El30UoT/g+Nlr3gB9XoBmhQJ/OOzxm0L0B/WA5NJc02a07q7yrELr12tXxfWR1MuPSHdstXC+qDWUeOmDJMB21Hhl8hNrYKeu3Hag9CKlpGOzwmHt6xzdzjlXUB5Xr2ytDtY9y4lOSOcaqA5TXDLPeHFzpFg1XiEQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6852.namprd10.prod.outlook.com (2603:10b6:930:84::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 19:49:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 19:49:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 05/10] btrfs: check if cloned device mounts with tempfsid
Date: Tue, 20 Feb 2024 03:48:45 +0800
Message-Id: <a59c46c581dd2219c1aad6d7d82e1527e8a4d35d.1708362842.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1708362842.git.anand.jain@oracle.com>
References: <cover.1708362842.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: de5764bb-7626-4490-061b-08dc3183e58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hi9cQXzjh6F2WDkZaLQyp2eMX9F+wH6yKEJ5/wtgPIzsVLMP/YizgL3PpZxDkRXtIRdrvNsPqpxGd/nnMH5Aqfxrfip5vNlnH+xVKByFZIzX7E+HIjytyRfblV5BhGmL5/WVu4Ymu5TtcTDI888KPcRnsro1Uh7/yZ/GKV9g8P2a0/xqe/aLSAZDcoMR5w3t5AlqYHo8tndQF6UlBWXwnjnR1zc12V4qnwcAXyQQQgMxpSDdF6fzJXGpSc1A5GTP3wEYwKkBeuee0mgTMellQa9gU2qkACDRUlTSXsFa4ml6PSjWWvMTgvThhqCOto6V+cQ536nN8VUfmxCtqdX0LIRrQCryMdjRfF/cOxC7ZnBBOcc886pJVN0TiBJunmeKnYKcPCxo2G6FzgWX/0/49t0K42/wNivaXzojFVSU/2Tk6MVTK7wJlwD08gZUrG01D478pEMtpfMYPNxzy4FaXFdRNgCJXOklv8SdfXyvTuNNOv+/7bfSsctWlfX8OGzxXQ7cyiAYJtg5FGvep3Rfr3eS1CopYACi3MCj2JlY8h8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?F3k9a7B2oA+6XLDbMcncRInRDKEGS/PcvziE5qc+27Vb3id5zJKZwJ1gofNz?=
 =?us-ascii?Q?M52gWeiB+7A/x8S5USKHVO+yIL8TXeDAQVP87RGIvkBG4X7Qf8uk0V+FJptG?=
 =?us-ascii?Q?4U/iVWeu5xrHrmItUvQrNWZTcQHATnjFAzbyV9RbSSRHHix20FNdFMDMeiTu?=
 =?us-ascii?Q?GsqNmKLeNUWXtDLmZdJ8P8MqKA/pr7jnwGQUCh7M9Sr62icunJ59idR1+RZV?=
 =?us-ascii?Q?zrziWCA6hKY9Ra7jzFS98V1fTxuz3qHVDIVkWm4y9IvSEwa/x7gJP8UZTSPR?=
 =?us-ascii?Q?AOP96xJnn5fVuAX7xCWQqcFMPJXt34GqoSgKI+04t6g+DEJ++3LkPLJKxh99?=
 =?us-ascii?Q?SwzqOMJws54sKM94AbR/0ymnRfyiLsYjmTqq157GzWmsjdkH7xc/UqXWlq+S?=
 =?us-ascii?Q?2ZA4rMCDvxGK4slclU46kdDEQZqekFmptnomchJlf3a6K2sSpGWrjLTHO/eB?=
 =?us-ascii?Q?w3Gt+kQ+mZIuXHtexsz557bKuAUQ743i0nHpKkRzPx8km91RSW8BXmCKS7qA?=
 =?us-ascii?Q?6MtCbGQZCOY5E48j86zE5n2/TJEiElJCWD76JlqyMdZ9d6gOwLoNK6gbmGvV?=
 =?us-ascii?Q?+3njwX3IpAaEpbutOEgGeMA+YGxv5KSDTDF/eFGPg2AKlRXjDwfhBTPvFBFl?=
 =?us-ascii?Q?MsQ0QAFEaR9zETIdDTaBWfhXCTQFtmyhOnn3DfVvr7Mn+PN686ObzxM2JZKo?=
 =?us-ascii?Q?zPivsj9jL5bZdKnoYi9YBw8jxFN3bd1rdUbe7RZv1fbnXAq/8jL+7YGIp5cF?=
 =?us-ascii?Q?HOaZJc0hAPmij21hUBST+NFvFi1RLieY29omgf2ubDq5NTmih2Y5x9KBTKA9?=
 =?us-ascii?Q?oGolDwb/lO9Er8TfR/FiHgYcm/Uj09Hg3wQ+OTLOAvqqcVB3btoKGzn5Bs+l?=
 =?us-ascii?Q?ykNx+qjEMg+YLsMU9nnPDQFPt/tFOR58snlsyfpJQt58dSCF8SV8x04jw+V1?=
 =?us-ascii?Q?ixztzRUjBhJTdghiQq27C/joIig2hIDUikk02Y5LkeIYfdN12Nw9H06rn3VW?=
 =?us-ascii?Q?BawEfEOjgfnyQ9x4vk0YnI1Xs9SBAYonUkNrrmJbNbQBnIvgh4zAbz0y7Mxg?=
 =?us-ascii?Q?+XFYbPWxeGCSo6P1ENDNZQzkYnELJObucq7NFfXWJXktWWcdM0dTilqmfi8I?=
 =?us-ascii?Q?K91jmJMkK7225fF9SvE6PtLZjMAh2X08QLOmVk8FB/gHZJwVnjCUgV2Fy80w?=
 =?us-ascii?Q?ZbWvZTLYylEQnQK3JSCNv0bYlHRXyv21JR7nGSGmJE5vei/bh07bABinsW2A?=
 =?us-ascii?Q?FBoh347nsm9E6gNNgTrpPTwl2NeFwhAlSO3yCkdFyOc6UEc9x5YtpElAhnKV?=
 =?us-ascii?Q?LWW0H/3qZZ8hXslvTfu6RFAdpUbMWIPZHYfyecqHQfRc+G+HJrbADaIcoFaq?=
 =?us-ascii?Q?KOYiytBkAEH8wiUxFJ7nxRSTQQHH6YmK2g3nELn5efdn/3PERCG/vFVS2P+u?=
 =?us-ascii?Q?4SDH8FXANpOJ19wadWxjjnstu8Pi89vxCwWYAJ/IZBAvJh5Cm01AecOovg3s?=
 =?us-ascii?Q?NFqAn8imChXzEGcX7rtpn6elk35DOkFvtGMNVktz1jV7D3iFtlyD26+ycYL9?=
 =?us-ascii?Q?8M12bZ2MqfBvRD3OLNnXhb/5kxic4qaoym4sy7Ar?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qF/SWF31VqNvKondNeNL+O6v9UFGx0HyOhphqgUi8RMDinwqEVSOccvy16bnXjgw4S1DQSRlWtOtUxYgf4+yFKRTWu1WJ281kh/VhNLDsVtwGFGktPKpThb9vabQbhG5ln8bZpPSQM2NxbGQLZoj8W/wV00EKjPFluTTwadXIN9/6EHr5k2Hmf6xalPKp3E6dc/dGzRM8h9ty3YTPRfdjmrsFIe3k4gRyb4WuiNq7WBEx+drttKC6dpv3KfBLUInRcpJcaYcCJX9SfrGJU3OiufWuAJY0wLq3xzlIvd2swcQilpxKr85OmDDvqq888DvbnEMuKakq4nGE8HppFK5C8zpuHbDmHaa0ehocTsgdujCHKQOdIkqSdPYSuiF/SzlA5Frq1BGRSjI25+KfTQDlNUD6XAUOJjssljtciW9N2q5e7bXRcJUCj73bX7MaJ7GHwmrMcz/GiH62/KmtXg+5z6SRpMncVwPu3XGuapEpYMtmHD4GOPE3mzWhkYY3/tb+YKcU0wme3B/fKNqZQpZ3B9VGAnN/eFYR4Bmwqs4Zq+WzcYaIBILa34qSg34wC034KXi1f1MEoX909f8naAJYR1xQISAcXKCkfYOo9pb8YE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5764bb-7626-4490-061b-08dc3183e58c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 19:49:34.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3UkrmWvsyvutsuUyQfmsnuUr6wQYnfBdgaIjsQJOGiOBb/7lkDo/bxvrwbJsbvkGRJWxOKMe7cGIObS7nE28Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_18,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190150
X-Proofpoint-GUID: ZqkipskC5xu1RSD8jaWDlmyvAcq_U2OM
X-Proofpoint-ORIG-GUID: ZqkipskC5xu1RSD8jaWDlmyvAcq_U2OM

If another device with the same fsid and uuid would mount then verify if
it mounts with a temporary fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
Bring create_cloned_devices() into the testcase.
Just use _cp_reflink output to match with golden output.

 tests/btrfs/312     | 85 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out | 19 ++++++++++
 2 files changed, 104 insertions(+)
 create mode 100755 tests/btrfs/312
 create mode 100644 tests/btrfs/312.out

diff --git a/tests/btrfs/312 b/tests/btrfs/312
new file mode 100755
index 000000000000..6dd5811ddaa5
--- /dev/null
+++ b/tests/btrfs/312
@@ -0,0 +1,85 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 312
+#
+# On a clone a device check to see if tempfsid is activated.
+#
+. ./common/preamble
+_begin_fstest auto quick tempfsid
+
+_cleanup()
+{
+	cd /
+	umount $mnt1 > /dev/null 2>&1
+	rm -r -f $tmp.*
+	rm -r -f $mnt1
+}
+
+. ./common/filter.btrfs
+. ./common/reflink
+
+_supported_fs btrfs
+_require_btrfs_sysfs_fsid
+_require_btrfs_fs_feature temp_fsid
+_require_btrfs_command inspect-internal dump-super
+_require_scratch_dev_pool 2
+_scratch_dev_pool_get 2
+
+mnt1=$TEST_DIR/$seq/mnt1
+mkdir -p $mnt1
+
+create_cloned_devices()
+{
+	local dev1=$1
+	local dev2=$2
+
+	[[ -z $dev1 || -z $dev2 ]] && \
+		_fail "create_cloned_devices() requires two devices as arguments"
+
+	echo -n Creating cloned device...
+	_mkfs_dev -fq -b $((1024 * 1024 * 300)) $dev1
+
+	_mount $dev1 $SCRATCH_MNT
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+								_filter_xfs_io
+	$UMOUNT_PROG $SCRATCH_MNT
+	# device dump of $dev1 to $dev2
+	dd if=$dev1 of=$dev2 bs=300M count=1 conv=fsync status=none || \
+							_fail "dd failed: $?"
+	echo done
+}
+
+mount_cloned_device()
+{
+	local ret
+
+	echo ---- $FUNCNAME ----
+	create_cloned_devices ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
+
+	echo Mounting original device
+	_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+								_filter_xfs_io
+	check_fsid ${SCRATCH_DEV_NAME[0]}
+
+	echo Mounting cloned device
+	_mount ${SCRATCH_DEV_NAME[1]} $mnt1 || \
+				_fail "mount failed, tempfsid didn't work"
+
+	echo cp reflink must fail
+	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | \
+						_filter_testdir_and_scratch
+
+	check_fsid ${SCRATCH_DEV_NAME[1]}
+}
+
+mount_cloned_device
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
new file mode 100644
index 000000000000..b7de6ce3cc6e
--- /dev/null
+++ b/tests/btrfs/312.out
@@ -0,0 +1,19 @@
+QA output created by 312
+---- mount_cloned_device ----
+Creating cloned device...wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+done
+Mounting original device
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
+Mounting cloned device
+cp reflink must fail
+cp: failed to clone 'TEST_DIR/312/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		TEMPFSID
+Tempfsid status:	1
-- 
2.39.3


