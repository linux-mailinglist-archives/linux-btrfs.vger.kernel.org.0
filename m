Return-Path: <linux-btrfs+bounces-2407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C068855A7E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 07:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8136E1C21F99
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 06:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CD7C127;
	Thu, 15 Feb 2024 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N2bdVQVg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ivg531Eh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE117BE65;
	Thu, 15 Feb 2024 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978911; cv=fail; b=VRbZTGJ5wxym0C8Qt0JzsSQR8Qhqe25QYh9FzHPQ2MKCAn9LI6LCkL0eli2PYaGZMsK/J0F2yqbBC7oZL/MKAN+3ugbWSWGTJcOm2GtfB3XfXxcbbO0jHzkzooKY3AeNZ8EJ34fXe/sMQf36xjSEyM6IDEwp1h0CCD65MNZb6GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978911; c=relaxed/simple;
	bh=izmJIukyRbTHlRF/cDMBiWgjVrZe2hAPGsT+r7NIUR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a8t953bahKnrSZ5EJflgFFsBYRH/syoxUi12gyLgBK89tVrZSmVgDx2OCQnKux0Vh/FD7/Lm4wSbjDUJ1SJvv9rLBHnxoQa36HnZWnMuqIhp22xsx40HRYvuQHWOoHubwMjNuIldzraV9mJyU6SrTBHR3+PX0Uu8iKo3t9lfOho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N2bdVQVg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ivg531Eh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMiCXi014112;
	Thu, 15 Feb 2024 06:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=XR7tig1IJkJVzvKC4XTIsrcvZS9MuWCqErU4LvqibyE=;
 b=N2bdVQVgmqutVPMQPMlstShQ9xqlAkdRB98aoAN/GfjJTtjg66LlL89jHRc6Kyue2hVW
 F5SOzmqI7louUtkXLijeWpzrwDQyIUzOuxZvDvUEXlzo7c85qTJjGnax3EIZwBbJudux
 oWqfE2afCqxEZD2isWKB3B2cVxY7k7rPMeiJQGeMy9HdOi4XmrlccX1xTJjTjeiAVRL+
 7x+XhiOb6va2WlWN/oo1nCjFWEsLE/nUIcrRlq3EwMpSAc4JBbOwsKcE48hqlX2X1xaR
 biklyCvUAHf4iydjdg/MJoOLGgu+IMaWCDoeMO1DUW0peqEaP+nEWdqxhnczuqc1qCRu 4Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f01d8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F6TNT4000640;
	Thu, 15 Feb 2024 06:35:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yka2v5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iek2yPkBfvmNEqCfL7Rqg7DENOu7BPW1f1Nv1wvYZQCSK3GumvC8BXp6NR5ZN21Kipvdp7xyJnh7rqVpVrB/gSa/WEQNA5Wwr5ymNWDNsDi8g1qnyC7Kc5NNluF7LhyqxCGSiTkG3z4gchUmq6gy5gbHQ9i+T0UZUpWiD9jLLnoxb/wQqwUOATLna1hYg7sVidjTNi2UfpIZbV7CmeNZVCZFTuI5/ZY7UsDvqVKeC98ZWPo4cpwIoRBsrwlIu8E7P7b6PNGOZAIvkIAMhBZ6cba0GJPgjKvtoK432sAawYQ9bu3l9gNiVzm4Pd5NpO19Mv70GbCqzAqjTLpeoeFwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR7tig1IJkJVzvKC4XTIsrcvZS9MuWCqErU4LvqibyE=;
 b=ibpPdjxiNGM5ZSElrJ+KXjz5WcKiz2gucxwqH/WWfTzsM+OsD91tEup2iCGNhQMWGYwk7vgATgNBVgnu/KRQ7dinbv9ki1Dxy2NzUAqTm47qRTw3PyX4eVEqpIzciUNoV/ZnXTcfSE5nTpwTMLu1XNlyY0yqwy2Qpi6EZWCaXWXoHpf7HMJY7VoZ8exHrijR2ryqRxQkTqZ6ap2IWFG3SVlKPA3cr3Fzb5FRK0OKhioBbHbMQ2PcDDcx02gSmj7ZDtk2q/G3u+/g+5SG2NKZxRBSfsH2ZlFte2WDCzGd0bjI0CMeaH6eGDCSm4xeXB/MeQkDBdeAbEZ3So3AXtGSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR7tig1IJkJVzvKC4XTIsrcvZS9MuWCqErU4LvqibyE=;
 b=Ivg531Ehi+/WqPpxtx7UckHHji7WK7wPKtI8H6XdUiqySjxjutkEQ3GcLQH682vAlTVOxV2MbYnVogre342AlcZX/JOBnsSDWQkfUJg/9af3AhbYS6AdurUEhL+3smqCay4YHbF8qAJUS1V+GryUqEvKZPS6exQJeXxjg8aYgs8=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 06:35:05 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7249.047; Thu, 15 Feb 2024
 06:35:05 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/12] create a helper to clone devices
Date: Thu, 15 Feb 2024 14:34:09 +0800
Message-Id: <8a9a66bdd309ea6ea81c3586674922517c3460be.1707969354.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1707969354.git.anand.jain@oracle.com>
References: <cover.1707969354.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 2779faff-f5cd-4091-5bc6-08dc2df03ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ed1tg7uikCt+4GsPP15i27eLyILdQtQhMDraekZztjvxdxdOXi7ivshJyj5NJEVUrZEG/71u3+kv5rktPEjF6J4iItHiTFe45oYTlz/8G4GjVmh0pB80jTb+aM5iwkYyk/im9/geloBQ6PE4AMq+L4wO3pTB2UCdvJxnVB3ns6PSEw9KOIqRDD4GuYWLC/3v9qQ4tI3NNHvgpKSQPbtAzUwotfDJF0OCXOv/1pEm/fDlvX3P00UTfNgZD5tVgKutRpmsosi19dz69F11SH6tM9GSsdJI0kbbaFMvGd8W/BtQYD5OAwnTo8F3Cij1xKS8DEvGrx69SuxY1hd0DhJHNSKn0Ys/4b76enRFp/7b26W6Y1FG5dP2WnY3uLn28gOhLczADlYM4UKCQmCqrioApZ7weKFaCCbEn+kaONRZIQg/cLv8GkVGgNdipdP86Z743Rk144BlZ5mqTsQPaq8Vo2ZBeNrg9B2cdw8dRd0oaEVEygtHwrXqg4QgbeK8wjucEWUVNWU/YsTsOblkBXePoDb4R9sTdSpQsf1NTitqZF5bE5TtE26UrkZ3++rz8deE
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(5660300002)(41300700001)(2906002)(44832011)(86362001)(36756003)(26005)(2616005)(450100002)(478600001)(66476007)(66556008)(6486002)(66946007)(6916009)(8936002)(4326008)(6506007)(8676002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Jta3zftKSHvMYyeqxi+LqAo7jeoZB6TLecjk9YM4vY9URXZbaLH4J9o6NjhU?=
 =?us-ascii?Q?BHifTJzvhauTJsb2+8UfgzigCcBT1F+DD1ZEbDRoqM09nfFpSPiNFG0A7qcX?=
 =?us-ascii?Q?3S1LtbG8BuIONctT9+msalefd3QjTU5nfmtY9DgiImGPQaNuSRAQHnzOFRuA?=
 =?us-ascii?Q?waPsAYfzqmZ0qlvmTf/ydm8L/mGyGTQ70QH0MJ6iSCMMaNa1CCgoxvMdKqKk?=
 =?us-ascii?Q?tZjH7jJRuMfaj0PvHoKBhXpcq8aCxZiE6s8iCkk2m1G3e4nbh1D1zi3R40+R?=
 =?us-ascii?Q?fZRhxnJ6/mPj8u0PpQl6l5nE9dutEF80NHjddIFSMliiSsvcHXRqHeS3CuGH?=
 =?us-ascii?Q?p/zfMT1IIJlrIYVFHYzOE3wI8/24dKPKFtsNoU3w/+SfL03Z8l11hDjyJw2y?=
 =?us-ascii?Q?x+m5L2FGdLHa3XUa7yDVbDSjSy2Rl0YGS0O+KKtIZ0riQ8HR/5NIOeiLFesd?=
 =?us-ascii?Q?evAmF7R927N7cBgcqCFdVBG25OzXOAD8cB2k+j55nHPDdM1YjdkVCn3JaPkj?=
 =?us-ascii?Q?FPrWbE6Dp8D2dDXVDhZNWx0aGGbRSLF8QxYaaCoUNLX+NW7j4NYmp0foNrUG?=
 =?us-ascii?Q?O2FWNWyWqOGot5LfurylZTmQCteX4djJ6Yqwj9yMX8fBfjBMDwN4FSPD+h7T?=
 =?us-ascii?Q?+SYKzye6pLfIiXmmXJe8NEyiUF3/16E4PpNxG0KlrF4FvtEOmzRxZ47Hd1c3?=
 =?us-ascii?Q?iv8HP7NKDUJfU2xoTmfR2mzHamxZ+xvLNRsyRKwDIBLxDqAFYuGgexsVuwL6?=
 =?us-ascii?Q?Gzig3FDL1CsvedGvp/7jjhM/zHkpJCBlnlhlRMYVL9/Fk3H+WGjSZ0LNuPpF?=
 =?us-ascii?Q?D4itAI1ijSpK4I+6GII3IdexOiXrrxrmZrUFBSKvBeE47Wx/LhlQ2af4VlVp?=
 =?us-ascii?Q?sIin2hzIHNDOj5IkZS/0sCfPRBB3xvuSxf6MOfYSxbHxVB902T+wb/GeBLSU?=
 =?us-ascii?Q?54JkSpc1UI9CV0vWrf4MhWnQzCoL0u4rfsZDPUu9qD6iYYRtMJbfUX+vpGBT?=
 =?us-ascii?Q?p4eMrmNx5wNTTIfkHKu8nTb0327sxfGicMRSY+ojDW6Y/TpuVEw7ha7d773S?=
 =?us-ascii?Q?+SceKIkD+GhL6F7Nod1yMKIQfBl3+qOZ0ezE8w3NssHOmHNeT46qS95BowsL?=
 =?us-ascii?Q?/yjp3uLVgiRd1Il7qLYODhvpVc4kEOFVDX5YphzRfJX10jD1UWKM/nn4AP8r?=
 =?us-ascii?Q?mDG4UqdzbmW8XUYSf1tfjqC9Xx46wBDlTnN5VkoAg+q6+/tF841USrAYv+qk?=
 =?us-ascii?Q?TcuqtqaD1IWxipAXVZpFFEnBKVc5XhpFu5+xl0MWffGH7hXuh9bZnpbiqp6Q?=
 =?us-ascii?Q?gzAJ9l6iMoqtmP1nK2c+qRCy1cbA0SRf3KKHkQ4cmSM7lt8Fol34GQlk5g/4?=
 =?us-ascii?Q?zZbtFwLF8TAaZfdXWRDG92HJ2KfJ/GkKvCeNk8lMTcuxorn6M9ef1jkG8y/m?=
 =?us-ascii?Q?NmeVzEVW9LyyjbjrXXxBWZOvQDQM0kifKi/K8zDd4U7oAVPWGJTrpCYe95WG?=
 =?us-ascii?Q?HF2XwfHSTBVzLC/5kvzfiocq6XdrfyMc29bGuNLPyf3u/g2QD6jQN7+6E0Tp?=
 =?us-ascii?Q?5dRMTUC0sg4TLOOF+OeSY1/gF227neAmQvhhcvEz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2oqQYCqdDHZMHon1QOoSUuCiITd/vnkbOljjm8FNT5ugxzWxJG/6MMWu1ITokkgHa0PURi1mnEzu6TjZnOao+GN2nCMe+TwsgQJgQMR9SPzG8vFcWKpZ22yudbmw6eoMzxHnbuGn2AJoHir4LAeqeFfUwsBQ51J4WRZ+CQJUijCS1Z7cpreiKKbMeJl8KCB9iA7UJBRwB64siudBTN+WrDeyVh89V70kss4vTWF9oyeaSRsQajOYWAd063op5cKP8DukRF1B6TjCjMVVDiKi5GxE0jwyEoArPYlGxtxgi8bD4hQU0eV+13+MqAsf2z1+ksb9nKI6kFo3KwrFvkbrdu0bW4B1XvJfQv2T8UlEwZt4gHP8iTk+eXXO0JGEUlbI5tsI0mDdcIAeZOrejzk5ERQ7kIrbbUCsYv3KhWZyXI0ksrGTnx7ZKPBW5vsPgx1nJhikHb1aSzN6/fw7WwdljarVgCv7oOR/Ph3m4GhDI5xVcvMDWlm4WVExEigdWvGyLmN+cIIoppc/0Y8PaH+0eqHqpMxOQnQtk+YYn2cybw4mR/bRoD56skiHW/lhOXE++ifR0n6sOSkMWNICD7HpTh+nlkGFqAOg27nyEIlIZR8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2779faff-f5cd-4091-5bc6-08dc2df03ee2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:35:05.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaX5JGKvom0xfqhvfdVcJ4EwsT4w76vSodMH612fBGizItr4BBkoiwSwBWwLY4dT/jbeaveyt/1CrTSEenGkew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150049
X-Proofpoint-ORIG-GUID: RCQhWcb6d0Jc20B9cfjfhGTBiG8QP2xa
X-Proofpoint-GUID: RCQhWcb6d0Jc20B9cfjfhGTBiG8QP2xa

The function create_cloned_devices() takes two devices, creates
a filesystem using mkfs, and clones the content from one device
to another using device dump.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 5cba9b16b4de..61d5812d49d9 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -826,3 +826,25 @@ check_fsid()
 	echo -e -n "Tempfsid status:\t"
 	cat /sys/fs/btrfs/$tempfsid/temp_fsid
 }
+
+create_cloned_devices()
+{
+	local dev1=$1
+	local dev2=$2
+
+	[[ -z $dev1 || -z $dev2 ]] && \
+		_fail "BUGGY code, create_cloned_devices needs arg1 arg3"
+
+	echo -n Creating cloned device...
+	_mkfs_dev -fq -b $((1024 * 1024 * 300)) $dev1
+
+	_mount $dev1 $SCRATCH_MNT
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+								_filter_xfs_io
+	umount $SCRATCH_MNT
+	# device dump of $dev1 to $dev2
+	dd if=$dev1 of=$dev2 bs=300M count=1 conv=fsync status=none || \
+							_fail "dd failed: $?"
+	echo done
+}
-- 
2.39.3


