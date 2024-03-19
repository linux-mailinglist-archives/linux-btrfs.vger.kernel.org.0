Return-Path: <linux-btrfs+bounces-3411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3577880012
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595A42850E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF556519D;
	Tue, 19 Mar 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q9YigOyL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DyAngMQa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A6A54FA0
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860278; cv=fail; b=fIklQjD6sQ3kO0GX075UyC9TpDjCaPMKVlmb1BUPiBMivPF8KviVbJupC+O8Y9ZP40cFQ2trMsc6INTW8H+gtzsUQyG2zI+z39HZ+mG1OBn4QfNMlUy1Ie8tFjwN4POmdSsYr8YDEWhlmzpLaTGFRNdXgYpF5Y7arrAHmWNFYzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860278; c=relaxed/simple;
	bh=StqYMg3/HefFYJWxpyuMpkF6oB24iOmaw6niagpbb+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aLzZPe03fsNxlu7DEMcUDYfrvCGGPC2C6pptb5Shewj+KgWHwLQLWSZ3VhkxVL03bLcEqE6aSW6D68Siv1gsZk87uDJIKiXNVeTclEMgdOLP5VXF0T+jCb7x88/Gq3eikemQ3RzWODP25PycAKvKsOLapoL6NP3Z9Z11xlBqbd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q9YigOyL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DyAngMQa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHkq1019658
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=iT75wfBZ6Bq9GtM2PoAMdOFQg8iNtka83tSrvS8gXMI=;
 b=Q9YigOyLDZnmnpxJGrV5yuzg1wmMFh00n0fWXhuAKVwirzW4RA6yAIH3QXmMhw5a2C4w
 ObVFbmBhkxdVZCcrcsA2X9fdRHclY+bwbHaBOPrIrnQT8HBbY4T3a0RgWBPM3IPQdrhb
 VG03SbipO+wP1QoVwYc81UOVOi4fqbZRRQ0qxM6iHa4FmuZxqYrj7wvQwujlxZJ3OBRo
 Es0EOX1wf9J4VmhECocsojATgTaFMV+jMs2u/zw0X3ym9W2kqEZqwJitu5Z4ppqJuQ6Y
 rrFWj/jzpi2nqtwNhr3QpxGZWdm072EIadwn5tKMTZtVKe/jq6dJRWqL1IGJf29w2M1z jg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3fcntkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JDbQYS003718
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6c8uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rnau0Z1NHHXmL+GnyZoN48aBwdaOXL1OxLq6E4y+Vc3EQq0g13BTUr73+Mz+BwhfvbdjQOL5oTMPytG/AQEAm92OaNKi63v3X0AOWbfpCTeu65Ye7UzhKxz6doP9qsOse6qon1rYupT2z5eyAzOvoqYqlcFYeGvW3+BEnA2RXjIzso2hesmHYwEIXMHVChtm58iqy3Ow5PEwgw8cCiiXX5uHcf3H0aJ+HBXjk48H6BZKUD8PEDOmlWXTEWM64ThDODgi3X84/mocegtBiFwmSfSOsNyMHn8+EmT5q59RRfUd4atdmIAms9pKTws3m9AgTsq1E4Bja1tGfByT75EP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT75wfBZ6Bq9GtM2PoAMdOFQg8iNtka83tSrvS8gXMI=;
 b=cP6Ip5FxuHRMoSKWvv37Z1FXNkB1xQWoE8eMwI7hOxACcCW+MMhedILrHOoKUyi4gFP13kaSTtWSpFbKP/8XHXMThPVKPF/qofuhUbikm4MYU5ulSmUvXe5ltkbIhulizVRrYex8h35bDHrIQqDVLSdM/y/BDX5zM4S8lzdgYnkpOvgxCZi2eRQwMvrF3oETfcIHPu2u0HkVxRUANz4rrqPxq1yqSJLVUyGdrqYSbYYpBDUu+JRuuEVgr5reWl0whQ9Syq3xsK+6LvpR6LdPgxa2ntZnNGLlFhlKTPwbYYEtB0QdNkiP61NGgmzlZhRpffy8dboN4xbbdXAbmWMoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT75wfBZ6Bq9GtM2PoAMdOFQg8iNtka83tSrvS8gXMI=;
 b=DyAngMQafseZ9LdVLVPlkNb3u/0bkiCJNUGZepcJAfzkaNNKELce5FkWsAakQL5ixMyxuLUy0+VCgxzzwusOA/QPzBlzdFGkjv89KOZV4V5LYyPD56C+5xjvB6hzvbnSajN11QLA71DGErF05PflyNw5gzFPATUE30+GHc5B8U4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6479.namprd10.prod.outlook.com (2603:10b6:510:22d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Tue, 19 Mar
 2024 14:57:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:57:53 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 16/29] btrfs: relocate_block_group rename ret to ret2 and err to ret
Date: Tue, 19 Mar 2024 20:25:24 +0530
Message-ID: <b710eafb205b77a2631da961149964c1790b443a.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6479:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qIPxP1UA/UsZxe9nJ/xxOZLCCdhVhm/wUduijyznJjlG4Ifk4nczjdAnWt5hsuNwGVt3OfJQQRbEjZoRcMlEu51yyIh7kA1I7mn/iozUHWcos4qGbGRIlu5+MGMQRkS5zJ3aySjpA1lcprJqD2YSLyNMdMufC050wGsbUMRc9lZihzvHGSZJwtE3pQ3TcRGxEYJaM9bP5h5vi9orlsVcgSOz+R7Zn48vAmHjw5iYK0HAK1y1BfWGhBHMczUr4Lbj0MvU5A61kSLOnFlU7XUTY3kRyF86uw12orPwTTElL5Sj+HN94LLiyuVyZCgtAIUqU0afUd5lcahX9Ziml1GqcuAnAotcr5M0GcdYQmJWvNS34qw8rVH1fuAEWIU79rb0eaHQLvH4VFwLepC7TGgmw55p8XK0YuPpnXoRnQ1ywgpO89/jkePU2Jp4qY6dFx9CJbDSbZTJehAgkCdWNViOEzR7Yd7ZERvkNd5kLje2hmonCKcuGgt+0i1FVonGVq4O89S1kaqMGGa5LSki7559z9wPaC4agY3mnk7ZcLIGVD7OFNdy47Um8U5snFQ9WT2gtxw1Jedc6ZF/KPe0LmD1wq65MPCpweYQ8SOGNT5Eyw/Sz2LUHFXJAu4T9L88tNP3hF2d9yr1KPTTuPP1FEuRe8W5CFo/ZngiRBJnwSko2JM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yH4UkYl60/WurP+iFPfHhG9W34/aHd6MUSv+ouskPDiZEIAMfyYb/aa8N4yD?=
 =?us-ascii?Q?jxoC2jDnJVBam22DRjvGvwE96dD3KS2VK6WXLJ74Kpp48L72SXnI1Zov3yyK?=
 =?us-ascii?Q?wRAxwcSgGlk7O1V6Pg2Xaqosrqk0Vg5zms4oL4ZdHu0QXPW8HEWZYA7L3V3b?=
 =?us-ascii?Q?6wff3drhbOZ7MgIdoxCqeL2YaxqYLxEnMciDl3DUUowc5LimD0oGBtc9qfne?=
 =?us-ascii?Q?q7c+opOd0EH1WGXjHwO3ByOP9l2gOgAEy5OACbbC6KYYigdPS9lq1WChYJGd?=
 =?us-ascii?Q?90vLvLYFPVe2sY7LvM0+9HRcU2TWuQc8COVSSZuPbUfiLoSIMFBAuXnaWPqx?=
 =?us-ascii?Q?o0jPkP+kvUTQS6/zanV7eS3udthUy98KAynhrag1YOy9PO/cJl9RdNU5NDfy?=
 =?us-ascii?Q?+v3cG983tbYSBU9kJbWXDLzRP9f1ZX7PuWe/pM4MMt0MYGMwsTl8peB8Kel+?=
 =?us-ascii?Q?iMJgnX5Nh4GK3hJwiIlCPMhCj+ELS9HH6ghBZt8I9/vHg9M88P5usCLqz5u0?=
 =?us-ascii?Q?qcHA1ANIyRffmvMfCOJeFtatpR3nrNdbRkZmxQSNHZtMYBBsVUYOHA5lYNc0?=
 =?us-ascii?Q?JABobR0hkHQZLJMDBxPOpnsLlQj/U1g0M4vIp+0FUSiAQDsifunKMEsF+Q1c?=
 =?us-ascii?Q?xISBgMS58rcVjj3q+HoZQuaBjCWEYqW9PFcGr9eXrml4YNI4Euom8Wp8I33z?=
 =?us-ascii?Q?CjRVTw5YbbGpxZR8lpnN3GsloYfnQ/Ut71PaU4877QUj9ZW+O/mlUfGLqpqd?=
 =?us-ascii?Q?4UKee/RufYp2vgYjbEdcUeJ97rwq8dMEuKA1XoZWjOtX6FESHvrcJ937fIYT?=
 =?us-ascii?Q?Mo+deNdlfaHA82hFDGTzhOtoQB5jZe2b9gXyTfFhf/RQGC+v1JOzbVRSRmMx?=
 =?us-ascii?Q?aap/TqMqAqVFv6bUneEBf/+4ItBZKKJIAGdMoFXM0Xiejuh00GMRpRpiMYNh?=
 =?us-ascii?Q?RnmZXsFp4J4UAL+SYcizRo681MCLWUak6o+kTghNTLm7LMpcdbVVRn8iPywz?=
 =?us-ascii?Q?kL/UdEw5zFgpVQQs1wtCVYQTy98J7iflAaxhKHfKTesLWW95EMAPYefNMsx7?=
 =?us-ascii?Q?+1rnEw7kGqv8/WZ6OSNv8xM78LFxvlDlqhxK3bQCVbcc7uVi3Y/FB8ZTY8AB?=
 =?us-ascii?Q?W45X44dLwHV0GkN2uywgkE8syNOZfMQAg6xz9xnXUY/5fnrZXeO3+B4i43pQ?=
 =?us-ascii?Q?TkzZtUrvmfZP5Kyycj6NNNYGVrTuS60SQjaqYDzBKeEj4oKhRNnOt+x8NjNM?=
 =?us-ascii?Q?PQ2izd4p3Z8ay2b/2x5irC9zrMD5V2a3J+DrgutDW6vFHw59q4cBR4qYMxuB?=
 =?us-ascii?Q?hQVbY2Urxy7cbOPtMsIOC6BRYJAgoTsKTye76kXkVk+JnaPhske/y1kk3cME?=
 =?us-ascii?Q?QahDq8jUF0hHe9UT/SLD2c4KH786NZaLgpr6jMdJITf2YIBGYd7525YiC9p3?=
 =?us-ascii?Q?rnTi8aybyac0ZObP8Kqj2QziB904gAd42FBU2lg5p9IXBtpkI3ZsamytHYqL?=
 =?us-ascii?Q?e4EYe2WVA+Lgp4aLjZOpPm0+zKTTGBTcxOteuzJHh6X/v1gKkYXkhAVxACfu?=
 =?us-ascii?Q?FBIvHIHM0bj+PVKC5e++d7oG+IwW72CItZNPgKfl7DktB2lOTsnBovwTBd0B?=
 =?us-ascii?Q?GiGq292r3UrYJxh59gb1qaThq9hLCmma0r2Qdw85ACS3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	smfbJcxo0VU2zmw7kXcbfdx/A/Xx3JeE1HTVfMzAsKMGhBjwYzsdqf0QG9sduk+ARD6bLnVqmS6B3LvbPKDS+pwbu1fI4umRujuATJCQ+Dv3tmS3oQdPbhVNtHgLVThp/rbXdR2BrP3kP0S63fS+bnjbttLwDocNt31PHdcDreoyX+wOK9xluiixp9nx66YXyDwWdrhbv1wjbEdiLKibJU/y941yJytzgcoo584s5xUCVC1KfXIo3h120mwKt7+zGEdEVtwi68qkE2sZkJUMnQmY1mUW6U4JPLy0UirWXJBPRsnfeS9K62zoMzYAD2d+DvudVvKsmDMHDEeGJd7fqIjflSp1C4s4Yvz7FFJRVTSMMllB2n4YEXh8CuhhqAjZjHgGTgnWHWT9eXeTtn/SRjE6ruWQbPzRMTVbkuaLcevgaF2x6pW/AL73WPqSpwfwaa/UvUZB3cpiIWrwqr6Duh/uDv8SsJSKAsJsPLrDSuHqEHn5HppzDPdI4ykm8pRfrbPo5TQ6WnmRXEIueWdBmzn4QKGXfv7fhW5RMK040HDdkzYMGrn/D3APLnrcoYFjUDCrLADftA3QcD2UbisVnHKmCP5g51Flgle+3Mfzs10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db65da35-f164-477a-7c78-08dc4824f3ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:57:52.9539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwVUNMLsUFicrJSNvM+TEq6TPhPSmI1E2Z5EhfkZjnnSr8IJ7pWzIRiIF+hEJ/zVezRvkaH09FX/dbEC5jOCpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190113
X-Proofpoint-GUID: FwWlmN--g0tRhz6MkwDwIt6AE5i-_NHO
X-Proofpoint-ORIG-GUID: FwWlmN--g0tRhz6MkwDwIt6AE5i-_NHO

Variable %err carries the function return value; rename it to ret and
the original ret is renamed to ret2.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/relocation.c | 86 +++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 47b564df4340..412d328bfbfd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3683,8 +3683,8 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	struct btrfs_path *path;
 	struct btrfs_extent_item *ei;
 	u64 flags;
-	int ret;
-	int err = 0;
+	int ret2;
+	int ret = 0;
 	int progress = 0;
 
 	path = btrfs_alloc_path();
@@ -3692,25 +3692,25 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		return -ENOMEM;
 	path->reada = READA_FORWARD;
 
-	ret = prepare_to_relocate(rc);
-	if (ret) {
-		err = ret;
+	ret2 = prepare_to_relocate(rc);
+	if (ret2) {
+		ret = ret2;
 		goto out_free;
 	}
 
 	while (1) {
 		rc->reserved_bytes = 0;
-		ret = btrfs_block_rsv_refill(fs_info, rc->block_rsv,
+		ret2 = btrfs_block_rsv_refill(fs_info, rc->block_rsv,
 					     rc->block_rsv->size,
 					     BTRFS_RESERVE_FLUSH_ALL);
-		if (ret) {
-			err = ret;
+		if (ret2) {
+			ret = ret2;
 			break;
 		}
 		progress++;
 		trans = btrfs_start_transaction(rc->extent_root, 0);
 		if (IS_ERR(trans)) {
-			err = PTR_ERR(trans);
+			ret = PTR_ERR(trans);
 			trans = NULL;
 			break;
 		}
@@ -3721,10 +3721,10 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 			continue;
 		}
 
-		ret = find_next_extent(rc, path, &key);
-		if (ret < 0)
-			err = ret;
-		if (ret != 0)
+		ret2 = find_next_extent(rc, path, &key);
+		if (ret2 < 0)
+			ret = ret2;
+		if (ret2 != 0)
 			break;
 
 		rc->extents_found++;
@@ -3749,24 +3749,24 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		}
 
 		if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
-			ret = add_tree_block(rc, &key, path, &blocks);
+			ret2 = add_tree_block(rc, &key, path, &blocks);
 		} else if (rc->stage == UPDATE_DATA_PTRS &&
 			   (flags & BTRFS_EXTENT_FLAG_DATA)) {
-			ret = add_data_references(rc, &key, path, &blocks);
+			ret2 = add_data_references(rc, &key, path, &blocks);
 		} else {
 			btrfs_release_path(path);
-			ret = 0;
+			ret2 = 0;
 		}
-		if (ret < 0) {
-			err = ret;
+		if (ret2 < 0) {
+			ret = ret2;
 			break;
 		}
 
 		if (!RB_EMPTY_ROOT(&blocks)) {
-			ret = relocate_tree_blocks(trans, rc, &blocks);
-			if (ret < 0) {
-				if (ret != -EAGAIN) {
-					err = ret;
+			ret2 = relocate_tree_blocks(trans, rc, &blocks);
+			if (ret2 < 0) {
+				if (ret2 != -EAGAIN) {
+					ret = ret2;
 					break;
 				}
 				rc->extents_found--;
@@ -3781,22 +3781,22 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		if (rc->stage == MOVE_DATA_EXTENTS &&
 		    (flags & BTRFS_EXTENT_FLAG_DATA)) {
 			rc->found_file_extent = true;
-			ret = relocate_data_extent(rc->data_inode,
+			ret2 = relocate_data_extent(rc->data_inode,
 						   &key, &rc->cluster);
-			if (ret < 0) {
-				err = ret;
+			if (ret2 < 0) {
+				ret = ret2;
 				break;
 			}
 		}
 		if (btrfs_should_cancel_balance(fs_info)) {
-			err = -ECANCELED;
+			ret = -ECANCELED;
 			break;
 		}
 	}
-	if (trans && progress && err == -ENOSPC) {
-		ret = btrfs_force_chunk_alloc(trans, rc->block_group->flags);
-		if (ret == 1) {
-			err = 0;
+	if (trans && progress && ret == -ENOSPC) {
+		ret2 = btrfs_force_chunk_alloc(trans, rc->block_group->flags);
+		if (ret2 == 1) {
+			ret = 0;
 			progress = 0;
 			goto restart;
 		}
@@ -3810,11 +3810,11 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		btrfs_btree_balance_dirty(fs_info);
 	}
 
-	if (!err) {
-		ret = relocate_file_extent_cluster(rc->data_inode,
+	if (!ret) {
+		ret2 = relocate_file_extent_cluster(rc->data_inode,
 						   &rc->cluster);
-		if (ret < 0)
-			err = ret;
+		if (ret2 < 0)
+			ret = ret2;
 	}
 
 	rc->create_reloc_tree = false;
@@ -3831,7 +3831,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	 * mark all reloc trees orphan, then queue them for cleanup in
 	 * merge_reloc_roots()
 	 */
-	err = prepare_to_merge(rc, err);
+	ret = prepare_to_merge(rc, ret);
 
 	merge_reloc_roots(rc);
 
@@ -3842,19 +3842,19 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	/* get rid of pinned extents */
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_free;
 	}
-	ret = btrfs_commit_transaction(trans);
-	if (ret && !err)
-		err = ret;
+	ret2 = btrfs_commit_transaction(trans);
+	if (ret2 && !ret)
+		ret = ret2;
 out_free:
-	ret = clean_dirty_subvols(rc);
-	if (ret < 0 && !err)
-		err = ret;
+	ret2 = clean_dirty_subvols(rc);
+	if (ret2 < 0 && !ret)
+		ret = ret2;
 	btrfs_free_block_rsv(fs_info, rc->block_rsv);
 	btrfs_free_path(path);
-	return err;
+	return ret;
 }
 
 static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
-- 
2.38.1


