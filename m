Return-Path: <linux-btrfs+bounces-2535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A64485AC6A
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F781F24244
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254BA57871;
	Mon, 19 Feb 2024 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RUi4xTHk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xE7M9ZpK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9671B57324;
	Mon, 19 Feb 2024 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372165; cv=fail; b=fYWsYCU4Lk2IgmllzMxUMKH+fkbbORuF24DApWcWKSd+FxT1tZJ4OHSxSVByy9w5mtY1LO0syGjWN2RvmYzwbQfD6dbDO9RN6jUvdWWvxsSJB9QF8FPWde2ao+xBskq78xyzaUzP8Ebsa7JbN9Kr0d6pfr+hmYr+Jt0I7NeywWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372165; c=relaxed/simple;
	bh=TXsIHrn5iERTenciECpqiQAG6x28tMOoSrBDWv0Krek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XEo+cxsKu7n6+y4EWNAs307yhgjG2rjUl/JFkcNws6e3bxXENeNaT5TtBTKy1+eymv+JYo2LsYcPemUQ0kfPZX0fOK0hd5EMFRXuzSV2N/C6FMSNKOELW+fitMebdU69Qv62qOuzabZFwFMXQ4Ds0WUE2lWb8XFIorJ8kDdxYBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RUi4xTHk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xE7M9ZpK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIJ4td018019;
	Mon, 19 Feb 2024 19:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=CVWvXsz+AlGi1Sk8h82ITdkQqK/LRTe4opdTHGWn0+E=;
 b=RUi4xTHk1+V9zlNxnGp6ZdD9y0bBMst770egGtiMa89KbDxzPfwJ+Tl+gFlq0bMw+7dp
 qkIsmdD3fsr6ArdjIDR8Td1Qc+5JfNorQBM0N28c7an1pjyeqvnKdXIvGm27u5q3KInL
 cJA4Jkn00gC4MJKi3/Xo6Sc8SB7PiHPH+nZorhLuAE3bKCh5a4TpVxIJrAuyRfReL0A8
 FhulWDMEw7zAsgjJjkmXyDvIfdJmw2pzlKDAm5iZwv+A6Tt7XalP6Ww8+wjigG0Fy7p6
 j4VXBbahxwmxNnRnxIlL7K+GYvXkoiyy43/qozPgCITFhJXXz01YlAFN4aErsCJPOaAM OA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdtw04d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIU9ou012963;
	Mon, 19 Feb 2024 19:49:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak86aacg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9UAc4bExGyA/CGVj+dbB4lo82Ay+tsvlOYJ5EK28L6RPRereSTQtfNbGyyqBC+TuTUO74HjQCGXCGribEvCD46LsCvLVfdhgofsh/G4L9OmhCh25ALc/7AJ+xR8URdWjMFKcfPRhnKkSR5ztqCvzCxw9OiTUVqtafJ/Gx5xf3ZHEwpdPCfmzoELb2ZremJ1gyG4vXjkm1xUvbCNTBPuaGlrxLYS+xgnDjLJfwOkOsyuJ3yQdIj+CExN99fNU7FEj6yQ/nUVxht1WLkXzTsOwflloAilsM0ZaO39cLJc1OaUyMPyl2Wnl75USxEkbW0Bh2TBaaVTfHnaFszFFsX3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVWvXsz+AlGi1Sk8h82ITdkQqK/LRTe4opdTHGWn0+E=;
 b=cl7lRIVDJeRA2tc+RF8rvinZ9zET6oTFJzldI5psCx2vM8xVDZuhNxFkY0Bp79sQZFuuR9D1i9+tQPNYa0j2TCAAMGKohKAAWQavrJGnFG+w7vzqKhUhEy/16CWNtmT8lUZxi8/VSFUedeUJHM/U/inJiDUQhOiqljfchfYIJRFPCfU07TjrA80Mk+KOqIdJHJT3IZ6gzkcZggo9yENnTeo21rggKktGwgp5Gcs1ZvHjtUvjJkXpqVf3WWNQ//Vj+nqTtlxqp0Oz3AnJP8zhuBWgypEM0hruZqF7ixoTBZXkEYwbzl/8VlI5a2z6/W+YiHmd5JJYFG8zmRW4H0uG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVWvXsz+AlGi1Sk8h82ITdkQqK/LRTe4opdTHGWn0+E=;
 b=xE7M9ZpKp6rPjMlIVaJQ9z8LtLP8T70ORz7hXRuI8J09xZyOQBdMJxNzT/DqNiB4MtLF79zFprKvLcg6sy81ewy0t9S9FwKBvZoEVOxv+ABS1doYi/2sWpMoxuMZIsiG79a3D3lp0+Rpm5UWMUed3lqgIcYWhMmphts/SCwQEBU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5898.namprd10.prod.outlook.com (2603:10b6:208:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Mon, 19 Feb
 2024 19:49:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 19:49:15 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 02/10] btrfs: introduce tempfsid test group
Date: Tue, 20 Feb 2024 03:48:42 +0800
Message-Id: <a8974626f600e904372934cfd3387ac0f5dd3da5.1708362842.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1708362842.git.anand.jain@oracle.com>
References: <cover.1708362842.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b73370f-fa43-452d-4701-08dc3183daa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UrK6vBfvKEahhE/zKZyRXgxzIjsobkVNHJqm47KgkGYBegUulvhm1h6DpHZIkjqsYokeiIpFy+lYqcDCnW5x9Q+SnkRAsKchGqG1c2GzrZtDKpVgELAXTqnFkCcfKe5584Arz58WN8Dx8CoDkhsPsMJJsgWtvNmaATC/95En1GePQU9UmCC2rYdn4j1IDSBvbo5QBi2Ych4vOLS7ZDk7Di6Y4qSuWsDAHs/eBlZgo3N5tgFodPWarBCUAl/87gHlYCkdqSX7Rdc+aBoGvXdFVEnJRseVzDZD/QOCD9JljEJb9S6892SghfRxnH5SI+QTyjAynfKFN5JZfWdFuR5kCyRPXUFVKWNBmX4XEJ0gLGR+sS8fj+GLSryFr/FPBLDSh40uHGO2LjolO3ZMWZI7h0q3ER2rWtwZ4tmbU3V8pG1hwrBgh1+fdQAJN7/+5DBo1W/RNZQWKlOST1iHNuENCOPYRb68dLzudVqKetIaJUiRNXfu5+/tM/a8emjW4SbF59JXeZc52sjP+vNxlnx0tWtW35s4j467mzprFiD+FaY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?u+rUjlEf+XLShyUFrczxc/p0S1i4I+sKkPdzd/qMGXKFZKoB0p4OSmdPE/kt?=
 =?us-ascii?Q?r9c3V/SKGz4vEf7CNcuz6TF8QsNGXWWPS455RNCNQFZmd5fbsGZ1DrzVSlg9?=
 =?us-ascii?Q?5+AelhD6kTR3yPKHcBW9O+Vawb3QPvtANTd4DoHnr6ao5OsAikXUKUjaGbSE?=
 =?us-ascii?Q?Updgh9p1ByFlaWLOaQQjlOJrWcmGmwSA+ebglpIG6Q8UGFyXBu8tnf/OSuau?=
 =?us-ascii?Q?pTLZGR79JSWJ5DZVFJDf7d9o9UJ4sUW75tXtyaBTXrdIFXWXfruTlddy6I3h?=
 =?us-ascii?Q?b1EuI/VTkkCRfWsz9l+wrZWLv+7gvayht/KKJCpUNnYA34h6QtarwxqAjTFd?=
 =?us-ascii?Q?CUENQWEzM6jM7gEKmYBZcwlll2vLVqnL8GEOO8CjsgUZ4noOrrzYKK36Aeme?=
 =?us-ascii?Q?seulEvjAipMG2SHNkfrGaWPAgpGbMoiAJIGPWnB6xoRMBoswy61HyY3a+F1G?=
 =?us-ascii?Q?UY9u+nOh2wVM00Z1H8cIyGf6TbB8nY5sz73Vp7QgJIywKoGMM5RiTH4hWtmc?=
 =?us-ascii?Q?wE7NTsWDFZTYNrkKFwvrAMEJ1vkSoUpJPsXtdhW5SgeiYgSoFtRKM0QMUhZa?=
 =?us-ascii?Q?pztZgphg1qrhlodNEWlwIuwajRRjVci7343psWvQ8r3nE7AheXFvX48edUyB?=
 =?us-ascii?Q?oQpb8k9Z7/BpTEw5+tPU6Qgi/WDoX5vFG6X4T4Xr6UWV9Gj+9yVvs1Jjw/Sl?=
 =?us-ascii?Q?gIODFHOtu5LJzfPX3xFNOSMjHJYrtdK8jLtcM1Ti3sAvZIwr64AOG9YntHEl?=
 =?us-ascii?Q?67GG3zQqdIepLfR3EKXKFXJfWjJ/zF/J75iLSE8vFabznnfr8/CiqKu0Zkjd?=
 =?us-ascii?Q?kyoyLOMPL6c/aW0p9JzEIvSPtkHqhKUDHS4nG6I5XGLTv7scze5bly1noXgQ?=
 =?us-ascii?Q?wJE1T/8ANpxCiADDKkWXMDnKI0j4RkEy4qoPtUOqC+nvs03qyWZIhI5hzi5L?=
 =?us-ascii?Q?dGlgjOtvje3ujxXBAXAY1CXlm2lxCCgygmrcKfInj+/Hnu/jtKa7Llkb4Pm/?=
 =?us-ascii?Q?beuMqcQoM/2rQsIAd2ZvsK6o6PZTuA0Yt4u1CxtaQVrb0pq2CkaNoXKT8mWS?=
 =?us-ascii?Q?qusDPqeGGFP1menfNHdMQsD3eVNJsVZLguyJGHaiDDDxsn38jFkhvYLSWk4i?=
 =?us-ascii?Q?krYLlaQtlDI+/qSxDLFtIDciDFgL/g8RCKXnfevAr96FrT3iqNC3PZnVVPFm?=
 =?us-ascii?Q?2vivximCFuFLpaHRGLXrC8ZE1P14AT9VRyfYRl9csHTaxv5cUwF4YP4QwOMW?=
 =?us-ascii?Q?qvi0iYLz6z09v+VDqMu5gQSjaCu7ccC/1Wi7eIF1FsR9OiWjGfxRcaglndpb?=
 =?us-ascii?Q?x9VXBnYX7Q2s5Wo6Zm7wF9cHabgm5REqqXzFJ6+3EJjIsFtDSd0AqwLx2tux?=
 =?us-ascii?Q?yGblPVl+2EeMQW9sZwS4oH7MqC7wRqlXbVLDLmreTAkJBsNuhes2enDt1TsX?=
 =?us-ascii?Q?m4d8VrU6vS+x0ieO54ALUxZNeFHYlJKn/pZqQOCqX1ubI4JyOt7jw5q9P1N0?=
 =?us-ascii?Q?Kc69ZRL/ozEXyBmf5JC4TxHjwUjqrfLc0KnGmT9pq5ns0oVR2bMAAcarLlrO?=
 =?us-ascii?Q?W5qPRsru6gdGKx+7cty3Kqw/9umtTDoMi6KOBDIK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MWf7b7u3GHVZtHieB7oQ++DUIt8Pumw1DIKj0UPcU8KbL5a0ASlIRTEIj7VXvK+pG5ddO9y2J/RH6cN/DE+QqQwQBUIN772SizNMWRd6eqCXHxGh60oIoqguB5Gwc7SlFtUk3xd8SAWxx/3Xfp4qWjoz+iMhghqisRd2MXvewKjZJBu79eRmJh5KrBydBA9JiEOcwrEz5h5VqfuXp5MSm48i6t7eQ0FKRMNnlc+wxq5A0So5gEGf7Vqm+bvSbCxe2BT9bBDb0nbXftw1Jt9npnmubklxwl9s7zJrpGD6dCQTztX/ZgWyFj4N3kw5IaHSGn95TamudMgk9wyWBbfraSAtAn7ViTvNsDqlA11nfK/Uqkkbp+x9cJ4o/7Ph5KcvpkNGTqic9EmnfU/NcVOQpjgxQEdG1CDJK0AmJ9CKj25W8wZTkK8Zm7JNP7hhctOrzW3hF+GB6EotXcqW3C26omn6EsuAFs5jWzrCUc7E2UWhhdzb1IcaPqqM6Q3g4QOlMo3/yXDr/kOzK8+Ij7sO0Mxzk72oL5G6cAuyrVw9JNanOMElK26UEcmozMmAJTqZGNlgDL7yI+l8M9vcLZKwF0DwYeK4JSDYJvhAzTJyPs0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b73370f-fa43-452d-4701-08dc3183daa1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 19:49:15.9267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LJmP+2HjY/mO0yPMTv+I/vtLtZ6IF+Ze5eu3ufcVNo+Wo0Hvy8waYyg08mXYwa64DI+inakdAEp2VALda1qew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_18,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190150
X-Proofpoint-GUID: hgQhn0nBOFB8MuonV8TGJUgf8_IdUBh8
X-Proofpoint-ORIG-GUID: hgQhn0nBOFB8MuonV8TGJUgf8_IdUBh8

Introducing a new test group named tempfsid.

Tempfsid is a feature of the Btrfs filesystem. When encountering another
device with the same fsid as one already mounted, the system will mount
the new device with a temporary, randomly generated in-memory fsid.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Add rb.

 doc/group-names.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/group-names.txt b/doc/group-names.txt
index 2ac95ac83a79..50262e02f681 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -131,6 +131,7 @@ swap			swap files
 swapext			XFS_IOC_SWAPEXT ioctl
 symlink			symbolic links
 tape			dump and restore with a tape
+tempfsid		temporary fsid
 thin			thin provisioning
 trim			FITRIM ioctl
 udf			UDF functionality tests
-- 
2.39.3


