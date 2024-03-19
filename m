Return-Path: <linux-btrfs+bounces-3396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 457A3880000
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00E51F2321A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C75651AC;
	Tue, 19 Mar 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S6PnkHAZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mKbLF8zK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBCF6166B
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860187; cv=fail; b=eFlVI3swNmRFvVe1lLbQuWWL2PrtlQq0+UUgOtshWBx1LV6O6XCCpOhYt1gSQVFwFm1IwjH1CXSKoaVmlpDnTFYPM8SLXFpxxcBpQ+yXYxAkEpaKJU71u9mNmi/8Yd8CYx774EjDg8SoDXuCeXR9Slk11j3PmRST8jSybZ0uwJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860187; c=relaxed/simple;
	bh=04DxCu+hGrskb1YTJ+N+s42DZhbyncZKZW4xZ71oWG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hdBbZ9QG+5vdP0c7oMMriCua6mov0q/QFJpmwX3C9NwPgDB/GOnkykpMGxna3na3nOTV+38dtngrQ3G1xtpZQb0P5XrW0zksbvdgC/nWtfMKaK43wxiprBIjDO9fI9v8GekX1lEMisuoAZSl6VekyhnOEWzMXXWuAK5ZiGkcu0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S6PnkHAZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mKbLF8zK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHItg005078
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=qv9itqghkrQkJKvneUBcu4udZY7obA0VCMZv7sQYqUs=;
 b=S6PnkHAZZxNuk/OZoeOHzVv8ns4/L7RcZEVLnIDToyTqrmRyCv9zG/FPtM9gbUi66PgU
 jb8AGAKNuqR1rIJBNM73i5BSIZ1nQObcPXpeJdbEwSKaDie88+x8UaA0AKdjOetvWYzx
 QGORTfVsKLzyTiXe1nhFmrfDU1S9PfYXhGCcvQIa1iNM4iQ+m9w8dwdeZd7/NV67KROA
 OEyCwkTMobMEGQ3Lyl6IMBvl6DVogJthhHA23NSjT+BgEkWuCerTr6MdKxkVjBRwd1LJ
 Ly6GOyJVcxMncLB1qcNreooWUkqBY+7xEuqE3fVMaHPxKA1RzdmHiu9pkadG9FP8uoaC 7Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww31tnsek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JDfYhA007509
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6cm0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpUU64sEuEAX5ddBWLKba0uBThxKy5gnSEBtxYUbDZ8OwvBTSOgDS66+/rqHy5Sotwa3FUyr2T+BdtSsSsIfEHVUds74Uq/vh5h6+0nLuiN/0ujsHtUValffLP1fQagdNTVsGHrmngfcR9ZDo5tX61OmZAkZsVUUa69m4Kfujmc+mgltmpzDnd+AZKQigENq8NpsBDd9cIe1pbUUFSvIwRLfawJfXT7tSFkfceQ6q0hvqbUcPoO7xVKCva13SSjMvZ2qIXS6vnTDQ5CP/TERkJoS3A4K1aRHA03X9EHQ4stQhYjRamBeI8zgJB25GonVVPSeUExMglXeBXHQLSC/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qv9itqghkrQkJKvneUBcu4udZY7obA0VCMZv7sQYqUs=;
 b=avYtDBX13LcwjqyLOm6AXpZSD/WPts+nI861r6mZCHgahEg2km0zqZcBhdvhU96fhqqbsftJIsCkbYGg0b08LQ+2FPk1N5hUxDoEGLN8gcFw98hkwh4u47oiksfgdTfXi4lTSS2RhtMmeiRjte6QhX6slbn0iYUqSjOQvR5aE4DHKBuCw6h7pz3PcxTqNGjbMh29B9dc0Xv9Ye8QB7P9Nj4OBKR1rmsQvmkKK2U5PU6e8PGVnltrl8rJpwtubJt1x3cidcmVjFfHmyfL4GewcbqKeL8qwIh3i0YWuRDZcvleRmS4xmZSrMdtjJvmnQ2As+/9zlpTU8HLKiDdY0letg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qv9itqghkrQkJKvneUBcu4udZY7obA0VCMZv7sQYqUs=;
 b=mKbLF8zK8aTMhtGkVc8l2GA+TeFh3abTmPpBqhvv3MJz2p0F/89PZtgOAU/1tVqSEgXvUtrygQG32oNcyz33TQxLeUDujEksOr3foJFFUT00D9qZxVc+L0lKbgAXFQ7QIotQSW8CMXLXPyHAibLKKQ91RRTEhj0Z8/Mve7CQUKA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6120.namprd10.prod.outlook.com (2603:10b6:930:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 14:56:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:56:21 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 01/29] btrfs: btrfs_cleanup_fs_roots rename ret to ret2 and err to ret
Date: Tue, 19 Mar 2024 20:25:09 +0530
Message-ID: <b1eaaa193879d4ae920a76dfa3bc5f2e6c7f8a4d.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6120:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gpTR3ilVJaaMXz6BxpX9ugIoAAbpjwwAYva6sO/79jBJ7OIB5YDb694TjlhyclHAU7sxgOWf8h/K1AeVRoik6mDkzUa6DGNqZH1QB3WBkXVZxqFmI39glE+8tgEYKcWtfSRlUygNXupcKcjEzEWANjs8ia2OeePlVVb7oodmuY7jLn7JkUZv+CCNSUemMb/qg59YfIo+a16qFe4Sd03SIIU4xpPqVtu772SPjcovyh8IVu46XYGEKQXR18NpIlOaoFfOBce+g/oB9JY+BBc7WEYDCRx69jrwnagjLZK2YZkFZV4mK4sTq/7FaQ/lk6wKOVpgfuE1jTrRWm3MLOM5+oH2IpG98QoGZushyUD/RC33n1mv8VL4S4+gsQTT8tTs3YhyyJ3dg8bTTCi4OpM1sDV/pe0PybbekYrdOYyGqVnxnhBXkksvjvi9eTvQs7n+PWYKalMeKoa0Q5uPWJ8k4qFHub1wltvgx5VJRuunFCR+85h3+9drsjftZIyM3qG8BqYbQ1roARorXtptcN6tcdL6G5vOfjBY74Fwr1+LychgIwYdw1RBDAn1g4hALcEP+jdw6hplHJkHDTYE+/WUhFeIoj2vPZuXc1Qx8c8tIgRA+E/6lFn3AWP6SDPi+y1y4581lDfV9i3yKx0zIA+/M1BeSyzJSPbtJGGdSlig0NY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uQbNbPzMxDbfwT2nlpf/F6EtKEdMwZyWjahUUxbB32s2u8TS+xGP790oiaFN?=
 =?us-ascii?Q?U0LJ/7lmhZ6/3w2sUGqU7jkO9XRQ0eMObucQzUw4Y+WsQ7fxxhpJs1vlSPau?=
 =?us-ascii?Q?rzg4tl1yBDSE0V7uT7sKPYhEQ1fBFDKQUhmShkfz0ZnQZzapzaPzXtcmkc7N?=
 =?us-ascii?Q?X+XjlGJFJ/ZHlwwPzgKfTge0lwnnlXoTEX+3thzyf+8r1E+tEpkOnJwr8RQr?=
 =?us-ascii?Q?m8AD9J7OaGytMVfF6zZYWKfApdvVkIN38CjveaHWIGXP8QELT45v61sH1461?=
 =?us-ascii?Q?RYg4yPqtFAecepxOuqulWLY53vGK1jPzscc3P7NH/ghTSx2mHi8XWE+bCazQ?=
 =?us-ascii?Q?hgGpwvlaScffQlkI/zVcIr+s+fWe7feBP8GmHiNjApnyde5eD8/sZyQwC4jO?=
 =?us-ascii?Q?Bk11hgn/1Ij4v6CYIg8c+fD/RA1qG18yR+B3nEhNmw+p9guz9A4p+TnVVUDe?=
 =?us-ascii?Q?eFfM6a9b0r9VctCaVaBlTKmgh21QLih7yHaqEsMfFWMX3OjGvbxXdmA+AXsn?=
 =?us-ascii?Q?JEPYTCi4q8TWutPO2RkVSw2D/jEQJ2zUcs/a7QWcZ067Y6KpLI2jKUSvZ9pA?=
 =?us-ascii?Q?NBbqsq9/0F07bbOqLP7G2ja/VmpEcJv00RsB0uZ27hgCLDdsm2oaAFr0iUSk?=
 =?us-ascii?Q?3rPSD9wkVdNE+vq6uR2w7u/us2gK1j9vjrLmptYk9mAY+cdTO2yqLOQa3T2L?=
 =?us-ascii?Q?sO4p1WwgSbLrWR1XU/LSpL18jQgz9OO2mj5SCXYlbtLX84qUm2nY8OmEVb7P?=
 =?us-ascii?Q?cY0JVIwz+NL53Sro9U6nQ604txEn3VK9nhz1Is//gVr9yk+NtUZeHahenwzL?=
 =?us-ascii?Q?+jqElZa7h6ACpFACaG2/7U95ZXrJvV+VRTHBYJds2VBfhM8QJLnbCwC4KRAT?=
 =?us-ascii?Q?ZK9EpLQIG+IDlcywguzYJU490KxjGhAxca9Ev343Cj4Frqh+P8W/y70+INYJ?=
 =?us-ascii?Q?1moUTFnmETE+EP8E9Z28Db5NsgIDxzb87GCeUasTYsu4NKCUnSThZBVwl3bw?=
 =?us-ascii?Q?OFEVeu06sp8XaTrAWKNrYQyLAeb1G68U+Q2XOJ8wS9KDRof4UdwWcBUfh9wd?=
 =?us-ascii?Q?w7VA0nglED2oBnYCA/RaZYoEqTbavjJjiyZP2BR5upulyqoXnbnNS8DFn+ak?=
 =?us-ascii?Q?9QJVbHMF/yRM8nUxg71usV5SogUrS/8IeKmoEv07ziYAXCs7rN2/OnQPSx8a?=
 =?us-ascii?Q?XGT5jN1WQOFLmrikdSFid2X8KF/yg8nz07GweaaCitiJ9NUuGTez+mPdF9TO?=
 =?us-ascii?Q?DpGe12TeVqILTq/8Md++1ZV/1fb6DtkTPZhNbL57M8tK7lIY8r9CpFjOjjje?=
 =?us-ascii?Q?U4UuOt/ctdF3tec4yFlyVjrfuzHF6iC8qnC2z3r0QqJVjwJNgVYsWpebDprf?=
 =?us-ascii?Q?3vul75St9GazQ3K7v+6XNxKOvbDKRxA32sPO7r6TYXlqngUp5S1OC64N9wDp?=
 =?us-ascii?Q?HNjOgtYKJ/guMxk1ILj4ocL2DMHKNsYRdHFRnsCRlWPlavn96X8py1rAt41s?=
 =?us-ascii?Q?zc1RoL5LUw5vUJRTB3bCDMqw+WMHzHKpVhkBgFRL1YhSBSKJyUKlvH6QfgJA?=
 =?us-ascii?Q?3/oC4aR3sRB6LHRMCXzqxXFJry954+GnoluVnEK5caQpL8aZJY6Z7sPZ8pP0?=
 =?us-ascii?Q?a/5Z+p1Aw4Oh9zkD9W3slevUXU5if8F0Q21PJk+xHO1t?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	G527QCCsoI00URFfb6AwZm71GQuHCTO+gCvcXJhC1ACv/ekaV5/Eq8vD5pX18W2PezQ+CSXLVfyDIQRpgq9T6S/v52egF3mL+mMX0Wu2zrN3tpZfSkXseZg+51+qzNMavivVAlNZnnVBFbr38q3uOeOHiCwsfGFoszAndwKCnOYLfjq6ja7naTYm5KNgVRl46wy3P6p6OlnlsuZSMt+KANzm3vClRe/aS6g6YBJcVXLEx4I3+YRcXrwrrmxhdXeF3F2cDjyTK7XS7ydFlAo0EkbHRFI8yxP+0RgdVbeZ6slRgodCRCyjFBkmAurPUNMbVu1emrKTN4hzDa4+LqS68tqZJsYdv4EeyfiVedYsYV0lpNxUAyfWmLHmYqMZJ9bIyi8vH0GIFz/oXN2fmd23czAJNs0YJDTNftcTfyHrpW1OMHjFZIAD6M37HTXCzke0c45Dn4TQmDC53MQTxcNxeFGg1NNKYXvA4GXJhcGCxs8E1g+5+lKIAFwN37MhRIKVcXuvIt1renPAFNyX4q1LR8ueo/6kt63bXDoRyc1WXGM8Oi3feyJdhhgwgzl3uPcswGKlKsB2uwt4ICnYjMd5DZORcZ53LfaqN993Ocgep/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb7bf4f-10f8-4687-15cf-08dc4824bd1d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:56:21.5154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/hRvVlaeUcm1pUg3F9yXhOLNt6DfMhmGj8akh2aaRwqIV/p8soVI6CiD5ToaUUyHjj+e10SD1zH+1d/8KQWpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190113
X-Proofpoint-ORIG-GUID: bvuavUVG86O04Z7zYGFOamVEQEgzfUte
X-Proofpoint-GUID: bvuavUVG86O04Z7zYGFOamVEQEgzfUte

Since err represents the function return value, rename it as ret,
and rename the original ret, which serves as a helper return value,
to ret2.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3df5477d48a8..d28de2cfb7b4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2918,21 +2918,21 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 	u64 root_objectid = 0;
 	struct btrfs_root *gang[8];
 	int i = 0;
-	int err = 0;
-	unsigned int ret = 0;
+	int ret = 0;
+	unsigned int ret2 = 0;
 
 	while (1) {
 		spin_lock(&fs_info->fs_roots_radix_lock);
-		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
+		ret2 = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
 					     (void **)gang, root_objectid,
 					     ARRAY_SIZE(gang));
-		if (!ret) {
+		if (!ret2) {
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 			break;
 		}
-		root_objectid = gang[ret - 1]->root_key.objectid + 1;
+		root_objectid = gang[ret2 - 1]->root_key.objectid + 1;
 
-		for (i = 0; i < ret; i++) {
+		for (i = 0; i < ret2; i++) {
 			/* Avoid to grab roots in dead_roots. */
 			if (btrfs_root_refs(&gang[i]->root_item) == 0) {
 				gang[i] = NULL;
@@ -2943,12 +2943,12 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 		}
 		spin_unlock(&fs_info->fs_roots_radix_lock);
 
-		for (i = 0; i < ret; i++) {
+		for (i = 0; i < ret2; i++) {
 			if (!gang[i])
 				continue;
 			root_objectid = gang[i]->root_key.objectid;
-			err = btrfs_orphan_cleanup(gang[i]);
-			if (err)
+			ret = btrfs_orphan_cleanup(gang[i]);
+			if (ret)
 				goto out;
 			btrfs_put_root(gang[i]);
 		}
@@ -2956,11 +2956,11 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 	}
 out:
 	/* Release the uncleaned roots due to error. */
-	for (; i < ret; i++) {
+	for (; i < ret2; i++) {
 		if (gang[i])
 			btrfs_put_root(gang[i]);
 	}
-	return err;
+	return ret;
 }
 
 /*
-- 
2.38.1


