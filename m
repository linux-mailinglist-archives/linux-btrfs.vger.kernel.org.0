Return-Path: <linux-btrfs+bounces-3418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8680C88001D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458532827F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48741651AF;
	Tue, 19 Mar 2024 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AD+g7d7k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cJySF6mm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0531854FA0
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860321; cv=fail; b=r8JUpPRl7I3iOVR8UVuZbl5j1n0elagK4lvzkwx1bHyIqOBDRi/kGtX7H/puXbBCTqlvTk3YPF8EMjjbmH81QoJdh83C9u8N10yuBBMi3cymuSoYjICp3SrL68qYIk5Kt3+08ULz07eqwwcCGyyGmizLGuVUa1ixnf2wi0RaZI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860321; c=relaxed/simple;
	bh=G57TnWmGKQ+N4auwkjbvekmQGDl6sNqIu+z1vvwJxfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C0hRtVW5V8DWUVrK8c4LOhLAsCgKMdUSkGK5hFiKtfA+mawMaRWJf/WaFgl7nNcp3+LXwHKjxKEkk/x6Y5lN+AoCyXWCxxyF8mFVqBK0wgYcet7zbTVy8V+lVD9XmcrRKeXPHAYY86PMgZ+oon8L76PYYit4wJHclGtFb0HnqfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AD+g7d7k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cJySF6mm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHtB9010428
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Dba3Md79KwY0Wvn0RdnB+Sk7m41HLUmGpeQwsOrab8c=;
 b=AD+g7d7kS4biS4c263MFiT7ukincnbxGLD0feChZpkxRcwmLndHzJO5f2BZbSdd9FLuU
 ecw4Bz33TzhmVskKvTfygu7hhFcM7w4dw40tVqimhgdcO4kSbk0preEU+gLaeNip/nvK
 3nHieAZSH38iyhFddAfKVFbNW0t8Q83kcxF4HKMzb1WHGoM1xHAAx/Ul6IPVdTAGzqjq
 ukoxRmJMGtt0Mhg+W1nj+M8QcOlHEvbcaY9n+RtkMzsbjqxd9hZPfTb6gfCm6i4qSSnb
 GhC0GCFpoNyC4FHS0IRpHVevf5BDzJ5a0zSlXAoUnSyEdYd8RX12zHFVGNf0lxUgIPTf Jg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3yu5m0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JEXPWt003788
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6c9gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIXAZYKF34itk72ocb8V71kX+EbmWuFhjc4iWi39NerULZEHM8JtkbndjY14f3Ld/6dwFfv/8JcsgBl9eiNgjze1XwekynJQ1xuhwjRI6jHGvtY27sIv6Rj3xLlBfbokX+oLIwVFCkifuZRnLoE0mLBjY7Q93ZcOvJyxIC9fqkwTrb88XpezM6rklnwW4+1vn8kMosqMhuy4Lde42WhM5r//WQvE+iVx+8khJLTmxTrYhbKQ4mF/jcwTR6UHncR4jkazkLSQiPPjMCb8Ciy+A1jVWewjW+5hnwKg8GolK22yHEKx+oDXLbKNEO1ZI3saaDebiRkQ5YqvXxEFm2bvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dba3Md79KwY0Wvn0RdnB+Sk7m41HLUmGpeQwsOrab8c=;
 b=aU4wTEK2FMu8q6ijs1sUfuoLh11nmpbViz8xhioc6vScAf8dz69sAn5QRgFVAVjCFdVEwkITl0JKtXDTonqXDaPGJ+Jwz8LFBzycdsehmtHAWeOIVdp9ipn6Jv/NW+elG7zRFKvMpxBltnXDbajLT98/zkcwgN/ma0SFJojKR6PyxqDVRVbjovzCqhRbgZBSeN5uLn0dQEiFvQpLajIjG4hj4dccowRYvucRiQwZwYnKupZImoWyp/S5ASGPvkRAYhA3469Kxk8nujDtp9Vh7pAl8gUcwPYu4n466i8J7AHkFcSBEFV9hRWU+g/gSFHVcmBZIa4c5smSbQpiPpnHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dba3Md79KwY0Wvn0RdnB+Sk7m41HLUmGpeQwsOrab8c=;
 b=cJySF6mmHVd0fQldUc8hsYmNWOtXZ4hMZ5ETqpRMaWW4puInvMRmpkoTxBWKS29Ktvjtg48MxkVNkfUOuOcEnzzIWuBatbTvWm5O1vbnK1OdFmKs7zQ5JBTlP8ZrARDbfJQkuX9c5ymNVSOLG33iDY6lg9d5Yl0PJGJiFTv8XNY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7460.namprd10.prod.outlook.com (2603:10b6:610:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 14:58:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:58:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 23/29] btrfs: lookup_extent_data_ref rename ret to ret2 and err to ret
Date: Tue, 19 Mar 2024 20:25:31 +0530
Message-ID: <3dacbcffa8d7c4e70e934b8b977676a1072878f4.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::8) To PH0PR10MB5706.namprd10.prod.outlook.com
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
	pEiENrKwqfVkFd108MvVU5UBBYUZgs3LEVk6fpMWA94o2Wl0chMTcrA579uBpk7JK6Z33rvgA2V5ZDb6SCoKelFcoK5uiSMWcKjEKrESALvSRqKXglUDK+Pn39NbDwD1Pzle8G4BCWOWd5fLDtAaVhhg+xHvSQUx9uA5oUKDPUnps4MLCwYF9PSgthuYbnGsk/KXfUlMijLvZrCU4lYl2S+4/cS3OKG6qupvJgjV7ozZNEGHt18XhQYddY/rjVFJI3CdCsMN3DWBTMuwo38NXdLV1q+HqK56k2lo2f7YfxjKVPWnKHbf5IdO+09OqOfIzyc+UnCGf/eR6dksAeDSiTDnMIUpH6g0EoTMmfYOd9fOKxBo5SjNw2LTgpDv+LWiiy/LnGAEbTAVZViJFKDYNIXMrsHZytNMdU3Zf2zWqgvZvMRIEO6rZIolzi16ElnFHIsaErmQ8QJzTvzWCIFCVLM8jsLD8OTm7fFPNqwbcPks2nXXAU/fuOcih0XCvuVumRnswh0IdbVhMwFpjJHo4diRJir6bwSHHhrCvvR8vvas5hlbEWcJQ4NIZYWglgoXWCODjrOOFw80Z4RFcMmzJGmCLiFwAGuAxV4meikhSJrBR6ewJMopHEtfi3raUDVfq0A1D4/+i9NPl3YJOCaEnQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0B2P20jhTPbPlWSFhRC+Dnz6fZsLw6C21ZQ4IyNrhSDcV5zilSUzD2FcjCqz?=
 =?us-ascii?Q?Eg8Uu7gvsk3MCTjbILaM+x2fJBYuVcygakRKDFTPHVPOLiLV7mxxMh7vNuaz?=
 =?us-ascii?Q?k+wgVuXGmXCIEXU/ZfJF9MdJq/51w4yzmza1gbxsz0OtCgDKxKYTnu1YYXtd?=
 =?us-ascii?Q?IhqPIG4SbjGDqjREm1KmyToueVXbjNovVjmYKhV3aaIO5c3ttsgKBjygYAPD?=
 =?us-ascii?Q?IA2fz4/W5dpDVB88hxsXNSOx6BG3UnNBFG4/pNMlHlifK/CI5TUW+qrGTQ3/?=
 =?us-ascii?Q?P+J87LzToFWaVSXPE3qi2VQJVOwiKZeBGg/30bDEg2JPyvphQ8vWGqgpU+2+?=
 =?us-ascii?Q?iECAaL8s/bmPhchh4XMJz257YpLibYXtQhKgu2R261XmM84waysU5EunFSoG?=
 =?us-ascii?Q?014KItmQ1E4AQCE76W1OTK3hK/16RDVupsxJz3Q0ck1NswqpHT5KmKuOHVaN?=
 =?us-ascii?Q?jl1nTdg9mlNCIpaUp2c0c/aa3p4rPVDnmkHC46OiKBh66+Ph0N/GjdG43kVU?=
 =?us-ascii?Q?ZZdDm0t9aTNho704QbN03habil4J1hC9Gv/8Ua/HC18mHCw1KqMPyeEsVHn+?=
 =?us-ascii?Q?Ii2cKrRgl78VYD1V0Qe7832DBS8n69bereJBAbdIVHQUvuX42+dim0nwhxkR?=
 =?us-ascii?Q?wFAGjhyunSz1ahzPoyXY5otc4gr/C7CYKpiryx6h+cGIOuxkO/Psksa70j7u?=
 =?us-ascii?Q?NXcKD4TETMCYunNEIjKMMxB+kZGTeA1kwzNIOItpaHyOBHBaJzXD5UtsSC7j?=
 =?us-ascii?Q?GE87WBY3uICjDML8efDnPq4avxWS2e9WXIZuIw2XTqFltfHQ3k5Iww+hpZld?=
 =?us-ascii?Q?jX0C71L8M3AlrtO1pldXNLs32/C0NGYSM+o6OzG4e35V9GBklGTrU5eXDzFX?=
 =?us-ascii?Q?R6T7IckvXvol8WuZON4Hf2VdtRJNZ7447ZEdAkz1q54ic9eozNgv17DCYeJ0?=
 =?us-ascii?Q?F/S4OZqrzYCBbBo5w2IlU8rOHhhav5JsJkW0XwaSwKRF2ye5gOqM4I2TCHGz?=
 =?us-ascii?Q?r6tCmz6+WA5/RwRmxHV2eYbMeGXpGkBL50w0Pyf5FSsOzXmUYR80dnMBCY8n?=
 =?us-ascii?Q?bwTvf2itTrW9ijps7DDOdWIzD8oVly0rPcO9FzznB1p/JMgyP81VlTCuT4lf?=
 =?us-ascii?Q?EyYlwFFGIVS7MYazeoCDmR1k7R2w+/LkxhbVqzSEvjxmDQkW+rQHXmkkdn0N?=
 =?us-ascii?Q?3iN0GFLjCTZ8Bi0+R/N72c2QG1KUsvMqlPpaoicjPSA4Czl8aJbu02Zpue0P?=
 =?us-ascii?Q?8ZxXMHv8EUz6NZH0oREDb4WcTb0cOHhw2x4H4vQU4LqbZO/vmQnhe07vZWaE?=
 =?us-ascii?Q?UBGwsnem59owDIxISB+O5H5aFduYaVk5WvyAYfDq1F3andP6aDgO+Sz8v+qT?=
 =?us-ascii?Q?Hvkz7rGwIFF+dfY1tfvvevBg2Y8PcIoh4c6JfPjd5ivADEGjJ8TFnpnnYpw6?=
 =?us-ascii?Q?JIk0BeYz96nJXc63gIll95l6kwj2l/CjxprzjG9aoj8egm1Nuw2prDXe6OhX?=
 =?us-ascii?Q?zxFaWd9Ukx9TIXzMALcroCrpwjMqG6bNsPCiIpQOhCR5QrWWpWf6AS0P72nv?=
 =?us-ascii?Q?F4t79aw+SG8oAEJ/g//eOi8epJo/FyEIdXIebL2a+VUqH6sYos5+pEPJVDkj?=
 =?us-ascii?Q?+1cABaUKLmg4reQnGyeo7TfxIWiG0o8An6WftIfmSiib?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fwz/p81npHzQFdfNVV45EedEI4dyq3mgY1AoP87UVgaMn7sVVWh+SB/hCnSiOx/MYFiCJnIfNaD3uVAiy9i+FxML42Skow1JRGBU7sECxVqRHslD1Y7rZsQJOS1SgsFEKFI9hwMiQuslv0ctE30ECQJOaYLnQ7pyYt2X83MRaeSnbURtudKSvAoI7nwvstRAs1H3VUSTqa+ck2GoleuL65H1y6pF3xbNHSExfUSJiwiqtsRv9+ovCNkuInZSYqq8ju1IuWusT1sWm0ilspCxXcf/vf3i+Qv1qHXAjM8amwzQO07IHeBpG7k66HU51MYJlhYlOW9zT69KB8HnprUZLH2ovNs1+VlYPeaZpZIYce+xG/m+BhxMhzPkBPmmIJCvdNnrb49wu/mYvLRwRvwtz7iMEUgj+foWEBxw/0wZPL6ZZ1ziH+EUX+oDl0Q5Fs7BD2ttyyKuLrgMWNdLh19yhn+nQPTM8FBpB5WGDBPHmwYou/k6WBQXT2Jj36vc7onFgg8IUjsrjZGhf+BROKOy+GFcQhWx3PvLMGzF6AKCXm4znSV0paTJk7qF0J8w+e+1y8AIV65MJro8kvuMadmm5K9lW59NFukZOcxcXudg+Uc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b65710-1a4a-4188-21b4-08dc48250c5a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:58:34.1268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thbRNytwqX5k7eAvhL0JzaPSqh4E3MSaOtKbYQFUbauJt9uIHK4giT8mK0RWodgkOGF9DNSEURlDYtdJ/0MD2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190114
X-Proofpoint-GUID: 9DCi-ohp3qi0t-BTc7K4vmBxLLYTojNF
X-Proofpoint-ORIG-GUID: 9DCi-ohp3qi0t-BTc7K4vmBxLLYTojNF

First, rename ret to ret2, compile, and then rename err to 'ret',
to ensure that no original ret remains as the new ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/extent-tree.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1a1191efe59e..4b0a55e66a55 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -448,9 +448,9 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_extent_data_ref *ref;
 	struct extent_buffer *leaf;
 	u32 nritems;
-	int ret;
+	int ret2;
 	int recow;
-	int err = -ENOENT;
+	int ret = -ENOENT;
 
 	key.objectid = bytenr;
 	if (parent) {
@@ -463,14 +463,14 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
 	}
 again:
 	recow = 0;
-	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
-	if (ret < 0) {
-		err = ret;
+	ret2 = btrfs_search_slot(trans, root, &key, path, -1, 1);
+	if (ret2 < 0) {
+		ret = ret2;
 		goto fail;
 	}
 
 	if (parent) {
-		if (!ret)
+		if (!ret2)
 			return 0;
 		goto fail;
 	}
@@ -479,10 +479,10 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
 	nritems = btrfs_header_nritems(leaf);
 	while (1) {
 		if (path->slots[0] >= nritems) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				err = ret;
-			if (ret)
+			ret2 = btrfs_next_leaf(root, path);
+			if (ret2 < 0)
+				ret = ret2;
+			if (ret2)
 				goto fail;
 
 			leaf = path->nodes[0];
@@ -504,13 +504,13 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
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
2.38.1


