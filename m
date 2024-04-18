Return-Path: <linux-btrfs+bounces-4407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEC88A93C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499A3281EEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754323C489;
	Thu, 18 Apr 2024 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="avuO+nS6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qGVrBtL5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408D3C473
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424229; cv=fail; b=rZ9khD+2zobOcI/y1OQ7fw5sPA680WkskAPbPY+AUswAgY1oOP6x33IxA8xp1lgXY+c0ax5ngC2daQN7HTlpLl3rkIVDHhomh7N//6VtDcTOCJb9ob5rJpTT2PVFniWxk1iZ7TcdIM4gVU3U6L4CgILSTCXrpHAnnwPTDZfqGj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424229; c=relaxed/simple;
	bh=rqQDo8CRlf67UMmrNo3oylj7TkkrY3CcQVIfYKSLchg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SBW59N3j22INL+jHgCVbg/H8Ob2Yi2M9wI0/eyYo38QSFoDmswMLfXo6cUwplMARxrYGGYsl2wjFgs+1MQ9GlWdSyd6xgN03DTQagGguujNGUfbboQFj+vR2AXzXrNHBdhT11adzVJj44M6Lm2BXuC03ts2kogC7f9TwyVnuAVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=avuO+nS6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qGVrBtL5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3xdDM010638
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=4wH4edaMN3tHSvVmGeH17E0vUG+AuvCecVQi/2HAKwk=;
 b=avuO+nS6JKpMsueuUgzY8B4wcS4WGtVEYJLHAB1YQ8tU/RAb2/x7hHAcAwVmJ8fjT5RC
 SlP8FjsJxRPZkSMDyGCnXGocdsagWcZfCjd9SHyR+QzY46IodDruWeUCL/XJ8DlyQb9A
 S0TQqZ9brLc0UgBPCnbPBJoUCAucma84u7CpF0rDZKqlfbg0zo4E9eGzxZUdmbQ36o/z
 Ea0DN2wjhjYTM1TpWqbaWs/gK175R0Gzrc1gsNY+pphMLtXiLdNEyFH1VSLkI3LPoEEW
 rsVp7Ckd7iMHkoKImnE6faS96bHRsMnYzR2MtQTbJEJGHa6CeD15+/Cro+HmH0NW7k2C mQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv9k6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I6phsG028845
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg9y834-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSNsosUlQecdQ/d7UjB7fEe7y57L2gOZlOP7nwV8PbPzE1EQRMw8Z6+sZLqeDRHKOp33mW0hnZRWB2WMuuLpuWeghNM0TGC+tHA+7QW+pj5+zRkmZ16p3kLnXFj6DRUJFdpyY/yjkvYwCZ2A9kymftLS4/17/6mCChpHXhq3zzJf2o48FX3Mq0R+8BUJORl67fVGi67oMe9DNsN8oq3QFXIl/I1wkTlM7qarh1AWJExapG7BRssa2C3qwIROy15NtAHfyZPabRv/eYYEjc3LdRq2cO3IV/he5RAIbzTqyisGKH8uUSOP9kHe+QZZGcaZXDQqg9F7m3RiCOxbIA4xJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wH4edaMN3tHSvVmGeH17E0vUG+AuvCecVQi/2HAKwk=;
 b=W38qaxccR+3BdwKLR44M/XBILk9LzeK4wl0Ew5s6acIsI2Jn3ZvfK9jHl8ktDNxMyW64pVOBwW50XaRYnFGF2PS5RKMNHRwkYiM8dEzsr+ftWlny6xG1ZiAjFwJhM7V/60lOQrAhCJsru5YqpkhlTZlpmsz0QLzlaibT8L1K1ySEUY/XpBV9U5oLTgKJT4R0lnHo4+0dnCzBAFqD7tk35y2EbL/aLLaHosItPKopLmAtcWmW711+9CsBHgTnPqzVERTqBB26n6eWcmzjzHfD3Rr3RtrCJz9JkOoqjL6ilGdUHAdo59KIzNmbVPUEt3F5N3Rdq824csupKG7rsk+OIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wH4edaMN3tHSvVmGeH17E0vUG+AuvCecVQi/2HAKwk=;
 b=qGVrBtL5Ur474eCyK1NEhXmXjcdGptT+eD52at0uIT5IZs2O2hC97+uppx533BQrGix28qrBTFLRaxWJCCoS517Z/q/aPJxcBQE4qjaY+tuyzsYE35X9Q2PHa56S1F6ZjgBZuwFSduCHX9nMC9bp9RrbXZl/k0hFH4Dp7CzjwHI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:10:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:10:24 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 11/11] btrfs: btrfs_drop_subtree optimize return variable
Date: Thu, 18 Apr 2024 15:08:43 +0800
Message-ID: <b11a794f626dd7c995607559f1835ba9011e1f3e.1713370757.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1713370756.git.anand.jain@oracle.com>
References: <cover.1713370756.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4e3c87-ec45-406c-f30b-08dc5f769e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qClm8a6EghA4CKopRxT6wpVvI1RSiBi0bw9cWTWYIgqFPAEUf/t4DmGPXLZDnj3oUwWU5mpldpJ3565FfaWdxB8r5HrGd4nf+TZ4U8QxylDThdOKCIqHojoDES77Iv4UdMi9374PY2Z1kM/Cw1w4W8qWFTDdx0hyE8fCf6UGPYVuDtF9Qv1XzdqI8J4NRAvTnuIIOQRM95BUsuQ6+9nORZca1VLnZjS+i+TIZ3NFn7ugts4PZoEr5Xlp8Gx1kX8dr+drsIN0adroZOJTfMbNk03VuPd5GyZdBlqoN89sLU2AY+t8XiEyUZv3iscN/BWyKQMRxrdp5gzNIc5Nrg3LDNw99boKqrlHnGV0/I6f8qn136yi9AXBXUmJsWTYhVbs6QPG/deCwb9egV4jxjG07iWBjnT38hyQPltZR7vk+s55HYFnQ/kxzT5l3YFmFViS1CdaYGNN5cmC5O4K4Oi+sRNQwJKqXW400pNkLWCpX0OvoCiCp6DXjrVRv0CECw2sHg7jrD7QU9AYP5k0ivJVog3UcqVNECv4lK91tMzoCyW7NG8sPIop7F6N282smRQH81pLrB4CqmIIW3RGqe+4QFm30r+mxNzHuiHzVHn0aYMKOhjUdHh9YNInLkUFfxM982QoMO75fmWkjs6DxWU9BRZQweA+Le95O09fqk1hz2E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oVFsHrPHg/gQj4SWUjTwGUSdyXnIK/87tQc0ipR6LcRe7DETb94CRjYLoCH7?=
 =?us-ascii?Q?Nh0wXWhIeKsNtES3zl6lajT5SbCQ5t4Hy1bBT3urV3PXrLlQZY8/ctP6QfWs?=
 =?us-ascii?Q?XkKCp30df0QdGP9CuhgfAxt5EHXv7o0xodYj0tlm7jm8/JVn2iHwt65UHTXQ?=
 =?us-ascii?Q?ufIc4gd68ZE9Ghi51aDS9hj6GBvxi9bwlrcN+CyBH5DFyWnunjnxH/QLMDIM?=
 =?us-ascii?Q?zE2JSs6U19UnR8Qy2Vy/ST0fsHU+5M9A/KE2tcMYph8BldKdEqxDywS+EaBs?=
 =?us-ascii?Q?9cKOHuu+6tfdJBxed6kBoPDy2g3F83fOTPwW8DZy1ZS4Gvyiv/7nCDodPf79?=
 =?us-ascii?Q?LAs3chLr4bhkGjduiH93C9/9I21KP6RAyfoVhEHf1Qo4nLzVWGo9XEL9NJfH?=
 =?us-ascii?Q?hAByw/kcRGW43Y8FO1NmD0ViDaOCyovP22r3gL6gHq6asurba/13RqPCZvJL?=
 =?us-ascii?Q?bI54s2HjCBml4whDB++BgPRK6CCIVNdUqQ9VZTTH+QZyGFEYUWgB+776qZQF?=
 =?us-ascii?Q?EueaAqUTvCn3L2ZHRSbf30BtZrmT2IKQhJnTJvvzo9bvlPZ8JfphaNrawjHc?=
 =?us-ascii?Q?CICS7xLa7PtCq5MBD9WFSHQ5C8c7ikMQoTWzVlO77o0qOxWa73UbpCxV0ZBm?=
 =?us-ascii?Q?gS7w+r+IVXrBTLSyUyS4GCJe3NUCfbKln6jRyHTgLyHXcONZX/Xam/J07Q6/?=
 =?us-ascii?Q?eSpfQh0F5Dx1rDGvbm0iRt9qmEpGMvjAu/cGWeFIheur4AQOsNh6P2bAL+5P?=
 =?us-ascii?Q?cmMVvSyjvSAUIdgmlbsEP4harSQB+g0krS4l9VahY+/Gm29fFBj0D1Hgd5XZ?=
 =?us-ascii?Q?k93eSc+seGRIB3taffcAnD8CL8cEGn55kZt2E3mRJjU8qUjhByzNqxt7FTkA?=
 =?us-ascii?Q?5OIOjORKCNXPELnsmJG6qquAVv6zVRfcHvg+AzPwWkAYdA0nUEoq+gUfJB2u?=
 =?us-ascii?Q?PJuFpZCXyfE75pJN3QWVJgQk3LW1OJFeGzeR7tdVNdjSbSTd+tRZg1h/HJJ4?=
 =?us-ascii?Q?vUMbf1FlTjacM89abPaM0mkEA70JPvsFQriDKy9G9itPmP/NeayWU1mD0I47?=
 =?us-ascii?Q?fnDm7dWzMapqkMDqcfnhaKM1HXcikHgeUOsSMsMTFCZRlLtTnNXuH+3Yq5XU?=
 =?us-ascii?Q?WWlU7tduwjhVWmb4/ufA0ewsI5uiuYRk21l2z9VqHXyClSLkfkuNBZLanAw1?=
 =?us-ascii?Q?//gDtfNrZAHfNWlkjqRKltxgUXNCELhLOqsCFPpAuVereSOb4T5j38OKpRCx?=
 =?us-ascii?Q?vg8ATqIyYdOMtdVDZ2RH4njydEg5H/AzUguurWgUed89pqhLU695f5DToa+3?=
 =?us-ascii?Q?YXdyV+GCYGKJrdEGmpmbppyN9nuSSNiu005juabUtLmiVwxctD905x37g9l5?=
 =?us-ascii?Q?IRfHYzqh4jzajtwim7pf3NADtv5bQIXZkcWuCrj6SwKTVL7UKOSJXrUCfBVs?=
 =?us-ascii?Q?M5ymM3F0MlC8/x2R17Sb0SuxVqmECpL+7pJZjcVJY2xky9ewnY71k+KKxqD6?=
 =?us-ascii?Q?QUtR6RD6XTzdi04ZBDcktY/KVe/eqn3gUZbV8UeEMEj2iKUgLXBKbjO+1R+D?=
 =?us-ascii?Q?VZNKOpIMHNWr/xXE+Nr6igIjW/geFt87GbXyPq8E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YNgBmSERILNPc25/5MDlfUggg0loupfslFlNxXGP+Auy4lETzUbQNZjKV4jBFjSVUoFP92JAqCS2plr7nlwlLF4v7U/G+f/9HoPkviNzdMOIDEogXm2sCeErLLuVvdzkxcPqVUcR1KRyL3tGTm+fDI1JcSvYZVIKX1+JXNTtZBAZovtCXZ5pOfXqQTNZERr7AxCWfuCP2hpWmSmQV6vo/YC1ABO7oZNC+oL/efzwk+J1Ay4EMgh42GkrmhZdoEeguwio1qzXXgKVSDQIk1BWpgtFp1F7PfqNKPo0yUFQJrMEz0iG8Lt9kO0cYAYHYljndyNn7lpTgGL0JNXxzZ7qdOC+MjnOgf8Ev1PymVmm1V9IG4oLEWxw1LGR4BImfUpd2cDNcUa3isRd8rEXNqJrHlgMmz3HjHCvpOWfPDCI7U24cqXIkdsAP2F048PetMbn+Xqd+Dig4ocKxgu5Cn+1Uv663pBloExt5AOhfHW1XE2VjqxUXIs9ieFKVoABoNUpYMMddN0iDkG983uKGy+u2irreQfQvkBRj2RLSMVFtRc2hA3xsccWtC4CG02i83Xe/WN0HTWE9v8fLggCMT+ndkjO6HH/f9Zmy1XOun2a96E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4e3c87-ec45-406c-f30b-08dc5f769e48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:10:24.8690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9AouIPmWdtiL3WNF03CTZ0+OajhySGVENXV6aLeScvtnMHlHFS0+3hTFGAo2kuJrQTx0bttPBmP1jYfcQzamQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404180049
X-Proofpoint-ORIG-GUID: i_d2mUUKUO2Rrukrgwz_1LSeXceBGDJa
X-Proofpoint-GUID: i_d2mUUKUO2Rrukrgwz_1LSeXceBGDJa

retw is a helper return variable used to update the actual return value
ret. Instead, just use ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: rework walk_up_tree() returned error, leading unusing wret. (Josef).

 fs/btrfs/extent-tree.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 17aa45b906bb..2d0c03806d80 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6099,7 +6099,6 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	int level;
 	int parent_level;
 	int ret = 0;
-	int wret;
 
 	BUG_ON(btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID);
 
@@ -6135,17 +6134,16 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	wc->reada_count = BTRFS_NODEPTRS_PER_BLOCK(fs_info);
 
 	while (1) {
-		wret = walk_down_tree(trans, root, path, wc);
-		if (wret < 0) {
-			ret = wret;
+		ret = walk_down_tree(trans, root, path, wc);
+		if (ret < 0)
 			break;
-		}
 
-		wret = walk_up_tree(trans, root, path, wc, parent_level);
-		if (wret < 0)
-			ret = wret;
-		if (wret != 0)
+		ret = walk_up_tree(trans, root, path, wc, parent_level);
+		if (ret) {
+			if (ret > 0)
+				ret = 0;
 			break;
+		}
 	}
 
 	kfree(wc);
-- 
2.41.0


