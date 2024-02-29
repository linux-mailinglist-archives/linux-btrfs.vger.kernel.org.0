Return-Path: <linux-btrfs+bounces-2886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4C286BE7B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FF5285F3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF69E36126;
	Thu, 29 Feb 2024 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DnZ5SwLl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A4vcQLt0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA482E63C;
	Thu, 29 Feb 2024 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171422; cv=fail; b=r2k2IbFiyFxi9ecVYATM0Gh8Whs04sxiK4AuqmmKXx3/aqKyVRhioYowMxS8nwlj87/V+Dp0ZRDDWyqK9/w2b36+bkUpVcfURobt1U18nwuasZmAZb4TVwYbTlVyrQm0NbqiIN21GVJsugl3Eik5hcbsyEktjgoejoueQ7wQCK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171422; c=relaxed/simple;
	bh=d+Nk/+yLZGW35zSOi5zzmsqg9g6AixRMhi/R5gs652A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pY1PjdI1udT8St6zKJTTREwXoRJc8ZmGVnP+1g0HYR72QCIuOffEsVXl2ySX6icyrrKoolqjhdydcT4A0V+kIZiQEESlnNmwXULW/ZSG6kCrZLh2vzN825gk18KMpjwCckdnz2zQXdUZyQw5WPDcfNS2Sm5/nP5V2pmF5vTXqqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DnZ5SwLl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A4vcQLt0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SKT0wB007353;
	Thu, 29 Feb 2024 01:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=mhChnu5BVvKCqbytSjlf8iS6TqANET4W+IhZzfPQsZQ=;
 b=DnZ5SwLlLWjMAGIErBUITcNSf0x8oS4EY0Y88SXBlHdlqZhlHYmxcW7KkVGPYBa59la3
 kOEjlb3/Jyw/UpLBO/DIBjg0tJXosQLleFYUGOQ4auBCoUX/8YnWOO1+4FWOa+zwNu1s
 FUp7o15RX11lVCg3mYdsfjcuLqu+d1357RXQyYjRZV2G9yswnsQ3sOkUsQh4NrMp/VTh
 Y+5fPq47TNcqndZN7BBSv3qHDUq90XmQr7C/q/Q+B2HIqKQ79NLQ42pyLFiAM3BJlvv2
 ywiotUN5+zACfe76xFz2GzIicTXzkwG90USOpT/XHTDxocqtLdq3Jf7kZmdZ7qgF84bO oA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf6ve3yha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T0oFe4015303;
	Thu, 29 Feb 2024 01:50:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9yxaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnejGYNpJ7b063/2iK3Hy2KEoanUrmdjUQoqisifU6id8aGq6TCWxPxiTv4tAtKNxobjytuexq6nS67RVCAYWYgZU6zFM3McmBpqzul4zCGLJzLiGbs/RylRUrm64Kp2smmVwq2/gGUrylbhnSDhTvT8K7oq/igssHUgDrkLWuCJg5HFRvV00+1MtYZeDM7OBcvpuCN8aBHmwNprRFA/RCpabT6VExAiILbraAWm7WUIjZpdP9ef1why1EhTGDdS/PGWQAFYs2DQ22E167KthWIec4l7O2xUd5cNMmcfD6B51eMVYPevmvEQwr/ro+Sa96BesFYo2BcmP3CopqvCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhChnu5BVvKCqbytSjlf8iS6TqANET4W+IhZzfPQsZQ=;
 b=lhR6jun9iqYVZGfKmfRiOhEewzAlBAlC/DTqlskbpNBQB86ErBVSDzpGOF6D8+vYRS32vcYG6QvOW5V9xMO4oa2XV2Ly0OWdAJxlHCGiR7CIMvn86BJxs84+FfE44UiFk/uPfWTQhyQC2CF1giT5L5fWqnQ/gNL1QrVQMdzc/wEKgbC9wn27WFIEJ4BA4oLtyr3O3bI9MC8Juj+J2E4UYgaWdypckRD8JABPR9JohSznbJHl951EbuJlo2IY6YvgQo5F5d3IACQ9Fv+HLYOdSCjHylAIKGbW8wTWE1mrOcMNjxAmyw7Kidnsa8GulGOUK+rrEGzDLHjEeW/KnQEu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhChnu5BVvKCqbytSjlf8iS6TqANET4W+IhZzfPQsZQ=;
 b=A4vcQLt0zLzP8La/jZf9QNSi9K5zOM0FsXl5g8ctt8J5n7wCR4gYnbdS56sPqtO5OdOYNqJPBryJCWNb8FYxAJXiNatX5zfo6XVpVo3d3Dya1FX47K46TY6AgZHD6okN/wsxHWQ92MHtgaInkx4VHD0iZYwT3s1yMnr2HV/dr3E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 01:50:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:50:14 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v4 00/10] btrfs: functional test cases for tempfsid
Date: Thu, 29 Feb 2024 07:19:17 +0530
Message-ID: <cover.1709162170.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9c373c-b240-453f-27a7-08dc38c8c5c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ytme/OFEy+bP4VYewKN4OYsX/8D2uCo8STMmeQVRRCNWlFSX26Pazwyb65VEXfwV0NqtrofpoPyQ9+HrnUd5HZM/ulq5gcKXUtz7fE8daAya+uk7eocOEGakwtRrSAEIo9utJ/L9pfe/Ud9AgMlF2tczIV2OEhaaOyLBBz60tPGRS12sv3Ag/MunqAWm4Flne7Qc/wO5Js7wcdwMCq59v97/+wS4736CS8cRd81dJzBLgIRMLuvkb4LAarzir7k9pBqnL8TTwBlXUACwh21A5eFv7Se7zYswaXGavOGWrQNcBICnbh5nOrrUDfDZ20V7Th64tMZXgIZthFl4W1ZR0kg6m4BD3ObvxuaBwSS/7lrLJrvcWtNx1BOe6CBYO2lRyqVpZ243nSO/yasAPH2HQhAGkq17sJWrlAX6MgGYw/193hWMgYadLPP7paMa1g+OfthQTZCJmTUc+evR66q7lha77H1y6egeXnd5jqJADh0IfFKKnbkXpN/zAViqdlOEhgq+E7xY1n/MBS/e9WfrXnJU3LJNee3NAeiC0NF957FL2MYkszBtbe81wTgGxs9nFSXaCigXHFrows1YBXqPGNZEMtbmHd+m5WXhZCXsB1uORjH4SqE1puHS8f32KVZzZn4zoAz0INM1OeADuQn+tg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+zcVVu7g95mrdCfh4nl+phqd/zqgs0cXNtBqcJy1INTcwf8JaKWApWdxvYCk?=
 =?us-ascii?Q?23ApS0v9Bl33BnFY+jpRNiAamrfBtbaNK9S4Jw/aGzmTeSHE4ECRz94Gv+oF?=
 =?us-ascii?Q?VV6wprAG0gVzDOTOuSDdlqUw4t9sjtTW6q2E5UPpigdNbgySgQNsxoZQAsbH?=
 =?us-ascii?Q?xbjB0k2pvZJ8jPQNnfgjilW8BOyjELQwp/kBw8VWIhju0lBaSfO51WiRmgJd?=
 =?us-ascii?Q?U6L/9lEIO/JxndpKYyHX5KUl8WgxgBfywe/OADfgaEKy8ON5fytWMpFCiVqv?=
 =?us-ascii?Q?HcuBYLXy8rv4lp1i1mSZjWQUifQj/TPUCi2vRJqvIInJ06LdE+liRaaqf/QM?=
 =?us-ascii?Q?HM1CzW2LTVirb7nZL5khu+ErQwbOZOItdoP+I+xC0ETMMQ3jLyINU7v8LYMc?=
 =?us-ascii?Q?ykw9Mv0LbQ/wiXFRw8/B34WIsMCNLxLijqYHVBgOKi6FUYf9j6fBMJ8kviBr?=
 =?us-ascii?Q?mZrk/o3ZbRpCzl8qf6ZEFKYSxf3nDhwdz8KVCR0yt+Q7ZLoCWATmT56/JZpn?=
 =?us-ascii?Q?KmVJWdIECKkq/5FcnStFY5tE82PySvgotta0iF19ZRPXpRxq+CtgJwEIKW2X?=
 =?us-ascii?Q?ouDDCO067ubmVqlF4lPW7I/UqAtJU5Fl2M1PvOTEEwLRRVz3RtwodgP6MJSP?=
 =?us-ascii?Q?SNA9QgqNo4kQtbRNxXnw4nIxYkxt7YYeHC45QA16I/qmADJeM90I3xuu0L1H?=
 =?us-ascii?Q?54rMSsC9y390ZhRS5vgwCN4f1mbaoz3MxpEqbvN+Tt0Eecu3+zJUzuI0wPIS?=
 =?us-ascii?Q?lctvzdl0870JpFymJr9B0P8lWtJiCVLbMpai9bogvNz0+wG+aoeRx7xLTwem?=
 =?us-ascii?Q?Vv1ZyoPfrnQUw6DijhJQ5RDeDfeqJstyz2DQoLpsvQzMciBf46ifwFzMlc6x?=
 =?us-ascii?Q?QBYwS1I8R0mle+ASemMur77GRbxeN61TK2kZKWydy+4J+w7fb7I+zu3pwbuP?=
 =?us-ascii?Q?OdhOgsyRveD7sACRMSdHCCEU7RyPnUU+Nijxt1R0KlmRuo5DUDWvOn+mJE1V?=
 =?us-ascii?Q?bXTcFoptPZibm9lN5iOLEdyWmEnwTjJlEBS51MWmxVFr9345fpGQ8GLU5vYs?=
 =?us-ascii?Q?cRePLUE+3+Bwa7VQzkMsOFWwx9jNguqHJPd0nDehcNAo1X+N+inFigfCk4VM?=
 =?us-ascii?Q?Un7lLO/OR+luk8uEmp6zH4Zxp61B6yHkOVPS1wjT6hrS2oU77Q4OvePVGIIh?=
 =?us-ascii?Q?Mn4x27n2ZOq9CEeIY6TqNrzQ4OZ13YZlIsBSNwwlW0VnxQkQvqbqGDNqB+GN?=
 =?us-ascii?Q?soKclJrIX8ZWz5mxQm09s/bFKuc99tnJuo6cfvQQU/g4Dhm0iEwzjK+4mR2B?=
 =?us-ascii?Q?zWoXI8bPNGCIEkUpAQNfqfPWJIWN4J+peLl74/j4b3HGqtpEFCCkLWpB3Pt1?=
 =?us-ascii?Q?Xc6bvOsGFuRtNcg2ViNpt6ozO6SGnaspMyAKKcRFqDjm0xneI58mvmNx0ibF?=
 =?us-ascii?Q?LBU514G+etwLw7Xt16gRQdpsKAPokCkiyAD4dG+TORZGIOReYjqiin7y3xot?=
 =?us-ascii?Q?gqT4vox5HMmVOrdfj+OU44w/RUSUeX/Z1zY+svRYKCuVa08RsiDJBJWP7GDM?=
 =?us-ascii?Q?Y4xlkndbc03I6CXGBGiCe22IFc1qrH5j+EXXYz+k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z5rqhylrJehAHf/5e1xq8c8fBGMLQgMxvzkf8oWgUfdwchWsnrMNLOgbbm/8s3m6uufpytNX7dAlGbx9I/fJtT6vvTV91F7dgDanjm4HVCTUwdTHJ5mVHnSyjJnEdSI2psCuCUMwapbKTQqFJxEOpeE5SdAyVOov6xzVWNANdohiWXm6rb5sntAv6XFK/nXBWPCRcY1NeUf+tIrhsQ6i6xZISJfQ4jXpxuFUn6ndPg6LHWisSR9ZD05vdDnxwgV9vT7JCKvr5HxUXhoOPKyV4Kg01su8SxpPpwI5pin/PcDRTrc0UHvWQXn7ZG/Hirl0TPgmkyfKTlEFam8un0/j6l6m5tNyvwVhhLhCwxhji7yh9Lsw9jyyY31i2V9Y+QaJHESyMyaPxL4e+DCHymsLBZx2P+LIUkbWPyJQHXtwzEpgcBF65fWgo/MmcKic10Fkq33bo3v7HTFJih8ZR91POsl3K7Qjf5kdfVrus9xbOByZegIR6cpO6q9S1xgHm5GWreVj7p/OloCfuX1iPs0Gh2cOV2R1rCKJG2fdzaEy6xRJX1mUAwaaLbAeRcnMJ0mFQBScznEwtfwMvkgrF0+vp8ogXOFlFeZH5wvMQnmOzi8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9c373c-b240-453f-27a7-08dc38c8c5c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:50:14.5607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNg+lsRzuAxr1SP7v/8Bn0dJYj1FUxC8/Whz11/bVGC9NswV/gb5smz8skjbRV9sWTe3E3isZI5zBjg3YdxbLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=550 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290013
X-Proofpoint-ORIG-GUID: oaDyBLI48hIGv_nL7kj-ELaRTpDqHqfT
X-Proofpoint-GUID: oaDyBLI48hIGv_nL7kj-ELaRTpDqHqfT

v4: Do not optimize calling _require_..() due to duplicates at the
testcase level.
    Fix the failure of btrfs/315 due to changes in the mount command
error output.
    btrfs/312 remove unused ret and drop args check in now local func
create_cloned_devices.

v3: Mainly, move the prerequisite checks
  _require_btrfs_command inspect-internal dump-super
  _require_btrfs_mkfs_uuid_option
to the common/btrfs function mkfs_clone() and move
  _require_btrfs_command inspect-internal dump-super
to check_fsid() from each individual testcase.
A few more changes as in each individual testcase.

v2: Each individual patch has undergone numerous fixes based on the
feedback received. Please refer to the individual patches.

This patch set validates the tempfsid feature in Btrfs, testing its
functionality and limitations. Also, has one minor bug fix.

Anand Jain (10):
  assign SCRATCH_DEV_POOL to an array
  btrfs: introduce tempfsid test group
  btrfs: create a helper function, check_fsid(), to verify the tempfsid
  btrfs: verify that subvolume mounts are unaffected by tempfsid
  btrfs: check if cloned device mounts with tempfsid
  btrfs: test case prerequisite _require_btrfs_mkfs_uuid_option
  btrfs: introduce helper for creating cloned devices with mkfs
  btrfs: verify tempfsid clones using mkfs
  btrfs: validate send-receive operation with tempfsid.
  btrfs: test tempfsid with device add, seed, and balance

 common/btrfs        | 74 ++++++++++++++++++++++++++++++++++++
 common/rc           | 18 +++++++--
 doc/group-names.txt |  1 +
 tests/btrfs/311     | 87 +++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/311.out | 24 ++++++++++++
 tests/btrfs/312     | 78 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out | 19 ++++++++++
 tests/btrfs/313     | 52 ++++++++++++++++++++++++++
 tests/btrfs/313.out | 16 ++++++++
 tests/btrfs/314     | 78 ++++++++++++++++++++++++++++++++++++++
 tests/btrfs/314.out | 23 ++++++++++++
 tests/btrfs/315     | 91 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/315.out | 10 +++++
 13 files changed, 567 insertions(+), 4 deletions(-)
 create mode 100755 tests/btrfs/311
 create mode 100644 tests/btrfs/311.out
 create mode 100755 tests/btrfs/312
 create mode 100644 tests/btrfs/312.out
 create mode 100755 tests/btrfs/313
 create mode 100644 tests/btrfs/313.out
 create mode 100755 tests/btrfs/314
 create mode 100644 tests/btrfs/314.out
 create mode 100755 tests/btrfs/315
 create mode 100644 tests/btrfs/315.out

-- 
2.39.3


