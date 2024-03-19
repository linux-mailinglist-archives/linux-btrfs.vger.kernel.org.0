Return-Path: <linux-btrfs+bounces-3394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBA587FF54
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2EA28480D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC7381748;
	Tue, 19 Mar 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AL9ivLmb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t6RI2XPt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4547D3EA
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857512; cv=fail; b=hJA/QVvybalZr/Hj5DnXiNznryTCtBlZaf8i2wlQQtzJa5l+dKwV79UJ4TmmQEddJgYW0dsJehX82lgmEppt2X3plYA8MbXQP5qjEPoFTUCGQtLq6g6jLefKyCZJ6P7v6a0iF2slA2f5N9eRipyePwYU/RQZyrlrwCNnL9R8IoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857512; c=relaxed/simple;
	bh=KdRdi7iIKkGsHnkpSGGnUZ/noTcZx381IYMaX7Oln5w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j7vKAEKFjSQ9njsEXn++HQSp5Qqg3ng2aIqQFV7RY88gY1ZVvLMR5GiZnqF/kcIov7qSZ3yD3MEIP9HQqXbjOQKIgOdC8K5JeDwY0dNvtIuD7WjgYlvMFI3ybjOP2dDiKrEPFKJRcOPaVBO4+1dt2QLm2afWVjSi1sa4qNQQPeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AL9ivLmb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t6RI2XPt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHa3d013369;
	Tue, 19 Mar 2024 14:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=dgcIIq7SktxkufAdoOxsWfVAojuDTrtQk5iowH5EZo4=;
 b=AL9ivLmbwEKegqfP5iB0Trlg9y5CCSPE5WWolb83P3XDejmlggqmuQngEkIFFArh96xn
 dXwCE84NhPaz7p7t1av309dBeb5hnid/d57i9IRifLr1Cgvyqqk0s6CFTJS/MSGGBhxh
 qiosksIUgyJQp+cZB1O4gjiw2v7xAf0OI9CPhMLhmy+SeCYbnxiD7nv5ZdVeCk0M5dX3
 CJPRXtbsH1EPHhQaCjOQ1yZhnfBl3n5LMWNDJEls8MJD+ubsTk8g5P7Bz59LtKpmV0lQ
 sRa9zcf/9m73cTCeZR6WAxeLBgM7zpffZcxI2+F+KU+eFIn6lBnsqma1Wlx/MlqeK2YF CA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww1uddmgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 14:11:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JDFKVv015775;
	Tue, 19 Mar 2024 14:11:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6st19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 14:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h77ykAwtJ4CJBn3IiYZGuMljcFoTrGQqCmUOrohh2px3qHS4ImgaefLbI4ISsBRYEKKrRLUU3hwVPf+VIEsoSMBtE8TeaK3jvjLubNKxOAAQRvkCsDTZ8P9qBs+QKvN1VGxhA4Gez0aUC63MO1ddlWkGOU/SRfJAk9ZruFdwKMVY4q/CIgrf8gSB45ADOwjg8HwSyLBm55JwPG999IB1bLyUIJTdj37GPZB+qq4ZMTV+SQ+t/aJYmPnrVR7t8fwDARiaX9nW0pd9KGhUglP8JtrzpW6TMofvrOnlV/BuRGStfWD3UJClm/KeSosCA5DSSBa2kXh62U2hh01+D/IQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgcIIq7SktxkufAdoOxsWfVAojuDTrtQk5iowH5EZo4=;
 b=KSX/548xdD/FEe587qvObWIW9NN7qfKVUQutx4tQoKuYqKGt929t64zYxVt2c95stkajNVsyYhGI+fDkNyiUBTuc3NMk1NhsGFHPugFUCVgYKsaJHqoq/poNr6vcoD7S0cYFtXPW/oR7NxdgV2gYmPe7Fq/gkHgoMntmS0gK4+cAiKlPtuEJDPT5ghFleflZ4X209tVDEsVVSFyOVdWez22N7QJXJ5Laa1d10gX8skCcKQxWl4HNAXMg3RZiHqB++lixon1lebqcCUHGhUvo2KmwWpfWTWO1sF+H7E2DLB5cDRWTroZSSsytJk+/YiIgsW3s5KhI/DVYe1D+QKw80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgcIIq7SktxkufAdoOxsWfVAojuDTrtQk5iowH5EZo4=;
 b=t6RI2XPtQbzaR/DgRehkij6jF5si5BExJZm1r+pycWNLOkt5VgIMptLLGObvtSBT8L+D0Pw6ry4+Q89RmN3h5ZKG8AB2BobbiWzqBSdBNiGoXaUQq859XPidqiaz279dGfmdt8x9O0teMlYLn1W5FlHpmJlu7Di1lAl5gKTBfhI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6521.namprd10.prod.outlook.com (2603:10b6:806:2a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 14:11:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:11:43 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com
Subject: [PATCH] btrfs-progs: snapshot fix user message
Date: Tue, 19 Mar 2024 19:41:29 +0530
Message-ID: <207156d802739bf6225591450dfc19b710be0350.1710857220.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:404:56::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6521:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PazcH/8ErR+V7fGFW5tYtjCiM44rhvImi/76ulwwkKMAWivM0nISLxapsA6egzUKTTjQI5SBYc9RK6Fb+RBsPfNDw1ombQ9kI8gaxQ5clJCRyGXhAwmug3g9sg0GVhjHgmZ3vrglYSiLdmnv+odwUSt6TdmdUHcRdDUlbeeLO77lK1xNss+sHdYMUPMP6KcCGr54hYD/srZuWyBPfgj8nn1fIGTrNVyyxdUtVFiNnBw+q3F6N0gysStKMMCkglmA2yvruVdMOPKAYd3njE4Y0QHvyM3QdlcAXsuUwjfRuZvmdI0zTPfXP/2W2YdQAKv8XEcSdpDx93TMZnT6z6597h9tCe+iXRYwuzigOnl7f9h5DzpAbIv8lj2n19OnL7Vm6zIvuZbfmQw5qelgVYb765f2Vq/yc6vTHWQfcBqYNXWcF7+QBXRqwjL15ZLmdsza/w0OywZqyf0Ek2sMCNbQZ8Z6kLTN91899YPvwz72D1BbQf5AdhFbDcO9xLKLPEAE13GPa5hKpZB54G8awjl/HesNv+Wlxlx/ggDHz9IdtUY7GZLgSrH7OoSQmrcwQ7R/mTlXMqGuqV1abrR/fKweIHHR0dbhUlC3Uv7e5zDMfwEHN6R9haYddz+gDsvjHZ1coogJkTfq0tlqPEzW4yVEs7hrxQX+gZ9tf23Zn+ydTQg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?51Hdxdbr9zwUL/CZRm6qy9aN6QCXBKg9DdpEGR/2yg1TM+ePRHjf+b36gu0c?=
 =?us-ascii?Q?I/bU8KtNz7n3jKSucwuSpfFEkHhOy0nte/BzIA+E5oYT8oz3bN8RcuGVAi2I?=
 =?us-ascii?Q?FtK2aoKrDF1jwYmSIlxSWZMhGXWCyWLJUL9JiRPJC0J36aqGf6wiZFYN6un+?=
 =?us-ascii?Q?55TtIpfUNPm1M7IXEwdKC/UuAWK9gqoDJDy0t9Wk904XFBqK5AkwZWt2ANJb?=
 =?us-ascii?Q?C71buTU9feeCAuevmhkEIeXVm7WnKPU31UXNv1Kt2GWiWrlm5pCy1S8XfliF?=
 =?us-ascii?Q?Zf7Bqn5mlP12xrO3aO2ZaMkELEyQVS9LoWXIGVzN1IT1AbQnkfwk/r/hyVjc?=
 =?us-ascii?Q?lJj//4HTBrNY3yad0aFsu6+Dabx7Z0eLsL8KNKXUTVJ5LLfrPE3dEM9JXZE5?=
 =?us-ascii?Q?nhVafiicrXcyAUOFj6hptXNwCNn7loQbdfHUAw8mIAoDgHPx+qtR3p8s6WZt?=
 =?us-ascii?Q?Wsq1C9zJlO437fE4ec+LhJPFMjqcbjZqFLomuvmjtr4sTray2EL/NkbpKHjC?=
 =?us-ascii?Q?j0+Rl3nsGGBc0M4fKT+eTrfFJwB7XZ5XOifT1sgmM6u+rO5Uo0MFBOYlgxXM?=
 =?us-ascii?Q?YCZlP6o87O/0W3+s7U7fF9SmW1h1+IWMySIJ8idI/fZ4qYxtC3fRuzyPfLg5?=
 =?us-ascii?Q?E7hxX64KKWFu4G2WIMDeEjvWsLrn7+h/pIOqGtjonW5sRfeSkM4ZdeW9kdRL?=
 =?us-ascii?Q?9SpyDuBRgvoNW311ipySL03pF3VhAWVZAAK7raf9wqYV/OkLHXgZnIwJfd4Q?=
 =?us-ascii?Q?hhj3hlVQ1xlJrNiDTR88GkgckQahcYMApVkEbiVJjAhOm72DdIuzRfAJMEz9?=
 =?us-ascii?Q?zLJ40DwAtsWOl3Zc+fN1Jni8fOmlsXTuedY25IexcNmFBPFYQ3Uz9HjxNTrS?=
 =?us-ascii?Q?vQA1ZDQPwiz18WqM8AjLi5JYwCSX8fdkNR/LY3vp4QCo5IlaPz5G6Bm0MJwI?=
 =?us-ascii?Q?2jsPbnDNYRI6roXlaXz1Z6JpK9D4AEgMAPlsH7Q0sN+B9NCYyMZ1p+bt8oP3?=
 =?us-ascii?Q?+tkGz8FbE3gRn/q4YJmCj3k2uiqAJo7Vpzr/o7f+iFCbgb4KQLrdv2Sc5LCs?=
 =?us-ascii?Q?X3u4+H8enSX61T0UE7d8V0vBO137xbMlnJ9pV/akRmYEWcp///wzfIDCsa1h?=
 =?us-ascii?Q?kct3HxRSpMWKcI+izKAGvX44CqyiUFUlep1Ka08WlTYotQt0fd82f9UqEQGC?=
 =?us-ascii?Q?kY0JiZRDLvYjS/y75NPX6lXCKaLyrqe6ZeUt4nDcPl2Ruz+7mEjaCepoJ+HU?=
 =?us-ascii?Q?9roeD8zIAgBtvWmf23JsF5WsNnMRFLvLdy/PiG5u9Uf0izsah+5BnaGMm7ZJ?=
 =?us-ascii?Q?aqf4l0ERzhCJX2G3ZQme0xNB40JOCmYGzzvsBX4WjSR+mcOLoCkHSUx3VjyG?=
 =?us-ascii?Q?YHmgOPyRb2b1bRgQsHCWPD1vsAJIMa6nBUIXBazKNIlyyxAvRhcgZ6e0p4SG?=
 =?us-ascii?Q?KRsC1inMVXvLosvzuCcIbVaaxT7mJFkA9p42zocCwBtQzS9IHmaDrqI+3Qhn?=
 =?us-ascii?Q?Uem4hHVGr2tfoXPRSn1i9z753MQyqU11szfNtre4VROFrGHSQZcpMYJ4LcOw?=
 =?us-ascii?Q?YzRakmRSyFrj1A564NQ1jW3Zck2cyTdNJJOyP+OL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BAeO+6EqHK6Alnln71VFuo1FdAEqeQyt+am3yMGewRAyx1PJZ/Db2X5dDI8SoMHGz6kquCWls/OyKuuzq29s/ILsF80TQwL9E6rRqkq6xj9VzQihSQW3nzWKD+pRYLIQ2ESoQA079E10diG5WTtOzjZ+6BxkglW1JFa6uz35pwIIQCg5BvZ7dXhEFLtV16tao7JEZpgQ1NtLkGZFYowrKmu0C6clUObrXvCTdVgValc/KJiLZLnPV9R8K37L1rJO0y5pRTlcQxMGT8m+erX6ai4HcCkSQO0nifnFI3aTwiuQAXi+v4KxM2X4Eu3Ehd723fFTawkHU14TwgkKgArFWkmzzndPYUw4q5h7yD5lKKEdFVKuxxyITTOyxg0vef03yJ62tdTq4PUSCB+9bWv3nqSzD5fDezZ8drnqxf7cs1UgnEVdMpl7nbh5Hu7uAlpWDIQugq0pugxyqsxm3H5bV8TxSl3tCKIB70cIbzLn5bGYChEJ8gUYqh0c2/YTuAWPgIfZEUdeHBgJq/olWlQERwaJkWmGI9U03reXCU/IBfuIrBlsXdpQOZTRcKPeALxD9kiT4Wxy+wLaKGNbgsE7RZeOOpvVqvb9ss5cm8+65DU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e5d288-d581-4011-597f-08dc481e80dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:11:43.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqZTbLvvajh5u3UbAp0m9DcF6HoKWqCV286TzjZhcGFBTMps/W7w+FIZiocz5+m/tSOkIWOawqFU64g+fmQ0wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6521
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_03,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190107
X-Proofpoint-GUID: nw2ksR3bSyTahXqD7OFzfljf5-ItCDaP
X-Proofpoint-ORIG-GUID: nw2ksR3bSyTahXqD7OFzfljf5-ItCDaP

The fstests depend on the output message of the create snapshot command,
and if it's changed, the tests fail. Bring back the original messages,
as they are also grammatically correct.

Fixes: 5f87b467a9e7 ("btrfs-progs: subvolume: output the prompt line only when the ioctl succeeded")
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/subvolume.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 11bb5f560ad5..6516ea981d4d 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -779,11 +779,11 @@ static int cmd_subvolume_snapshot(const struct cmd_struct *cmd, int argc, char *
 
 	if (readonly)
 		pr_verbose(LOG_DEFAULT,
-			   "Create readonly snapshot of '%s' in '%s/%s'\n",
+			   "Create a readonly snapshot of '%s' in '%s/%s'\n",
 			   subvol, dstdir, newname);
 	else
 		pr_verbose(LOG_DEFAULT,
-			   "Create snapshot of '%s' in '%s/%s'\n",
+			   "Create a snapshot of '%s' in '%s/%s'\n",
 			   subvol, dstdir, newname);
 
 out:
-- 
2.39.3


