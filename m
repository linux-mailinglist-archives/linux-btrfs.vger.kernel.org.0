Return-Path: <linux-btrfs+bounces-3585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC13E88B641
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 01:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261011C37C24
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 00:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079161C68F;
	Tue, 26 Mar 2024 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fo9kmjL+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J520MivX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A781BF2B
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711413710; cv=fail; b=Pg0qR2YBKfGiHm232GCuvNqWcZTRtzI4McjJsoikkRbPthbCxpghiY1wm0plgiozoBYN2h7VPmHX4ClMo7zmQOqe7zDV1LToIVSfXG4jBLvuZ2Z+YvT7HdMPIWQHxCiltUFyH8Lf0z1X44jEVt8kFA/maYvd6DOpawwOjVpg4RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711413710; c=relaxed/simple;
	bh=o53+42hqrDpSzXtuBPZHIUL9B3d6rXTrE3Utm1E7qnk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pFgTbBzxlBETechmhViqRhoz0GKoXXm3L12NTitpnb77aqFh03JP6BxDJFqGCo2/NHoyHPq1Xq1TjyhDDJN9j9J7HWAuuntGt+2/hjk8DjAhRn0w7hmjinpRIfD/KFcq09OIIhG+B8Fkdcn4XddoL2bF1m2WkflysJbVO2dOyI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fo9kmjL+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J520MivX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PLFvac032449;
	Tue, 26 Mar 2024 00:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=HQj76+XpSg9elD4/pdshOA2zXdhvP75wYcrZdH5gr6Q=;
 b=fo9kmjL+/P0oVWZiZ2FZ7bfZoDJDPW75yIx7n/+uHnxQGs3oyfvsrgmy9LdTjziuRxwW
 iw6Ke5BbwxKQYOduvO0IZORRg8a6bst6pAw7s2Ff03fWmqBfUt7yuu3PUepIDna8o6iT
 HDDOkzyzVgjY/39BB85G9/JSdgRzl28pZnT8yPFIMG7rI2p8rR+KoMDCUcdxNvFou898
 ib/d+/eSO2azmxxY0FK0p6SCbMbJinpq5myGyKKIibvEdzvanFXQuLAvD76mysfkLGD/
 GP9aajVr4q2zU7x2dhQjN3M1DTmp+kIli9YnJ8U0TsM4+axtTjU86dX12uuhp8xP3PVB nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2f6h2vv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 00:41:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PNc9Op010778;
	Tue, 26 Mar 2024 00:41:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh6dsn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 00:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWE6MPvWJmtmsWdiWnAEJ8wR0Xab6nloNw9rQtLhGuuS0UXx/i4zhOak9YFCJydoczG6lz92X71KKwUNxF/K9CLWgyF4XgLJIR8Wjicax0D6Km7G6zycD5qtsMHKwfbx369ftw9CXg/2dgAPzRcL7fPA8OScyD3wh4r97N7vD5Uwm+JbRdAgxOwOC13KzvD+AdVOEzZgmFuJhkePdIo7JKSIcGaaULjPlE/91oTmSwur2xoaePl5eGuCUL882zicD7EomaSvgq8QjQ4Ia//yU/Pu6RWer5qIvNJ9hh658lvcm+w5PhJxFt4mpC2xb6j+Pycz6IqOeydZmNehIgHxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQj76+XpSg9elD4/pdshOA2zXdhvP75wYcrZdH5gr6Q=;
 b=nlpbM0oN7o9QnDsk+kkPZwftuzzoQfMQ6yy2uyWec6wm7AbxNpwukHoo/S3yYQBlso8REgY2eW5xBf+NQsznzHYwLKXOxFsel/7VX/dFP5gZH1NdpqgUv5oLeBTqzylONx37eH8m2a00AkY12N9hYmSBHTd0KjEd/zo5gJwQKNwAzRPbeUfzYuajtifbf/Hv2egztEwqRFDFi70hgS/ul1qkyD6zT2YEJqhwf0r+F5yZYfnPES0HwY+uXprlg+kGVdPUEQZInTf75VrxFJmM1G22xcJ3LaNqgdeAzx9xdo8qDAVytIXMwjYFFO3gDHonXzQPhy7uDajiybMlHAxUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQj76+XpSg9elD4/pdshOA2zXdhvP75wYcrZdH5gr6Q=;
 b=J520MivXs9IhCCB9nqQ8niqVIakUbWgBXrGl90oEeA7rGPtCWwy5jpx2wCbkWT270U2RsIdf7zl6GVrCfd3vw4OydJP7jl4V63WmE+hxjKrH8u7nXQ5lFgflLRkJI1/y6ZedU0/Dcxm/NlBp13wrjqobb8ACWMa7KXR9Me1X04w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7503.namprd10.prod.outlook.com (2603:10b6:610:15f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 00:41:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 00:41:41 +0000
Message-ID: <e2e42863-bc27-4780-b864-c9f1afb1f001@oracle.com>
Date: Tue, 26 Mar 2024 06:11:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: snapshot fix user message
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
References: <207156d802739bf6225591450dfc19b710be0350.1710857220.git.anand.jain@oracle.com>
 <20240325213608.GQ14596@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240325213608.GQ14596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7503:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	laQvGUgCKAn1XrPnGIh9cK/yjiS94wr5kwzS4Zk89/sEnlUkCZU0dnnKau7N9QFFUwiKGGZlSptj7FO6A6/j2zHoa2SnCoCfodEuiknTkAxPeGI4MzHjJwOoL+BTDGAYW9tKvXugpZQyJK4eeKQBpXGMXGKbgrNexjPtNjqrjw82jorFi4xv4chFA8TZ59QFAuV0Jnusr2iur2cBUGKj/ggY0XBQyOWMWa4Af5VqHW3XOL3+8Pzn1LmAgqtnaorz0puWtlMhIuPdGFKI/UqkrCtea7ULUOo0dT0/9bPgyKE5bLvo11kYmmsCsf/lJf++RKS2XtSZ87eX2A2nYESJdCheI+nJ4igzXESrtEZYmJ1LHHvV8DOgNonYBEm7K/wmE1Sk4OWFZiI9wg9hE2cXsw/BtiyWauqX7xa6VhmgMTFfgxJI54+LdXvngnpgRdpRvKvzU7X/dcOCW/lYq6uapoqNd1CGhcgXrPnWPh4DLXH0gPRqhIY8xBsHERLrPtmsN6C8+IBB9jvW6Mneyh3QxUYOuaG+r+leezsX3sX+jMzewQo+qHyMGsYjJyBWariSxw3wh4j9jdyPk683oexvowU9taV+L2GgIYxKWs7QuWlVKAPSsm4b/sim8I42czfDxwoECe8WdRwoZFKhyXhStdELoqAV2rqQrcaFMGL1WBM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eUFGZEYrRlpmMGVEdXhkcGhOZm82ZmxqRmxnUEVRcEY0RWVmWUpvLzQ0N0VD?=
 =?utf-8?B?VUZqRHB5MHlWajEzUGRZeVovQTBER2ZsWlZ6RGw4eU9VeENtTENudi85NUx5?=
 =?utf-8?B?UHROcjQwMm5yOVdZZ3V6WDgwN2U2S0dRUFl0NGViTlNpU2NNMDdibFYzWDVw?=
 =?utf-8?B?YStkNVZHdWE0clExdTJVYVRHdTNhVllEcmp6bUphUDloN01ycXJuUnhTMS9a?=
 =?utf-8?B?aFhSMFREbFNTeHNCYUJpdWFyclhpNUlGR1gvTDlsRFY0WnoxOHhZVUxTTEM0?=
 =?utf-8?B?TEVrR1h4Skt0ZG1MaVZFQWZGZ1RyUHY1UnpmQzdrKzVYNGFxclRPdWttV2ly?=
 =?utf-8?B?NkFFdXc5MzZrQ2UzbkY1enIydloxcFR6V0hieVFwOUNhVFl4QXJ4QnBQQjJZ?=
 =?utf-8?B?eTBKNzYvY2xRVE0wekN2UDZnR09LRXBKZlEyQWZYbXRtbW1qVG10eXlZWkhi?=
 =?utf-8?B?cjFTUEtYcTdMRDdQV2tiYjlnMndBWE42aEYxQlFqWU1BMUE4cUdwTTVrZHJl?=
 =?utf-8?B?SU5VUHBWUVFuQ2lFNlFwRFdTaWg3OEVvbVFKQkVpOW51VE90czVhRUNQMW9C?=
 =?utf-8?B?Z2UzNkh0TnlKclUza0UvVE44b2NMbHZKNHRyM0MzYlhITklqWkZ1K1grTlBG?=
 =?utf-8?B?VitBQ2xTeGlLUG1lVVdwWXBWM0Y4ckJ6SlVRZ2VkdWc4aVNna1RiTnhHalJI?=
 =?utf-8?B?VTRFVG1WWDBHMXdwemJLczA2Z2JmSklLbzFKWmlKZEtWYm55bHJSTFVaMEl1?=
 =?utf-8?B?V3drMkZ4U3U2RnZHRjlJNStJd0lMY0tENWNHTUJmb3ZORUhNNktOMDJ4bzN0?=
 =?utf-8?B?OE9nQjFnQzFBTFdyQUNkcDRqTVprR2k1ZkkxeDVxR3RMYnJJQ0MybXM5bFpF?=
 =?utf-8?B?QTRhL1BBSUlTWGliK1hwMlJWZUU5YjE2M0FpZDhwSGtFUVV4TXplekdnNndO?=
 =?utf-8?B?QlU4SStmdlZTdisxQ0NWdzIzaWsxbSs4UkRmdjk3bStDNkNabzIzU0FOUity?=
 =?utf-8?B?S2RTaHBaRjFYQ2laQmpVTUc4UWN2UFNEOEVZK2ovT2NWYk1NOXdNMDFmMDNW?=
 =?utf-8?B?OTB0L0ttNXkzeXFId3JsZ1UveVNOQ2FOakhOUnFLRUprSWhQdWt0dEREaEdw?=
 =?utf-8?B?ZXVnVnZyMU83QSt3cWVIMWJ3c3NoMTdwZUxhR1B1enl0TGpnOHVXNjFNaEN2?=
 =?utf-8?B?MFBmVmV0a28zZlJ4eUtXMU12K2phSG4za3JzbWMrR1JnaHBzZHh1dFZlNDdn?=
 =?utf-8?B?a3lsUFdwelh3NjA5blR1ajhWbnFzYURqZW5YbXByL3FoczFZS3R1SUlBbWVo?=
 =?utf-8?B?SitSOTh6MGE2T1FybUdVTWRLRUhzUEJNZFJXbzA3RlZ6ZzNQZEtmTDZQd1hv?=
 =?utf-8?B?aFIvSlJVSHF1KzlFWWZVSEhqZm9PdmVxTmNTYzJTWGtBQlFKQWRZTDFEc25M?=
 =?utf-8?B?Q0lWT2dEUVg5MTFkRFU2NGJBNXRyY2dDdEVPc1o3eEt5TkVzTUVRRTJYMHRr?=
 =?utf-8?B?dnNoTFl0azByZzVlOHR4S2MrQlRlSUwzMU41RDBtNm9mZWtDeHdUQkkwSEVG?=
 =?utf-8?B?dXEzd1BwYXhwVXB4UlRrczhBci9aM0pPMzBrTEdqRWtrMjd1TmpGQy94TWtL?=
 =?utf-8?B?SXBkSWI4QlF1V1pDNVRXMzMyRGdJZ0pPbVIvZGQxaFZTUnZPN1ljUWIyaE1a?=
 =?utf-8?B?a2FROFFveE5HMGQzMTl1TXJnd1F4WC81MlFSNXRQVzR3b21JSHFoZHJKV3Qy?=
 =?utf-8?B?WEdKdmxlZkJaaitIZE9UcWYwMng1c1pQQ0lBQnduSWxqU0R1dHdMc05SUklE?=
 =?utf-8?B?bk5XYnpOMDlsS1l1R3FONHZkdWFIdUh0cVIwVUY3Z0JUVWhsZ3R5SnNscno3?=
 =?utf-8?B?TnNWL0NlRjVPSkpYWFU1K3FqMGVZalRNOXV6dUlwR3JnaXgyK3YxVWdyc0pT?=
 =?utf-8?B?alFQM3piUUVRa0FleVUwUGdRZ3VPcVpac2MzZC8wQkhQZlRVcFp5cUpTMTVC?=
 =?utf-8?B?QzhNcVU3c2NqdmtVcnBrcDlGVVE2QUNUKzEwbXBoalp6ZVFsS1lVZkVtSkhT?=
 =?utf-8?B?ODE3aDVBU3lZMG5lcjBhdzBtMmlPc1U0djdNMG5XMkpFeDFZWFNGQ3ZGcU5x?=
 =?utf-8?B?T2I1Z2gxTVNtY3EvcnhpUGdMMmZHYW1WUk5NTE5qd3pIWmcvcmIvU1RFOFl2?=
 =?utf-8?Q?vPanVxrmvSXvkhNa0cHAkeb3UbsWYZHE4vViiF+VwI2U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	E26BHpxYIW3pftU77uXB59Dh666O3dyPVvBNmtdyPaFDa0blwuH2kAZdABENvlkOlaW3ofjHac9SnRinwvKNpUD7SqUZJi6iZNW16sFm2qEaG6CUN5LV4DPFKCc5h5cduHiM5JNYLocp4hwlMuyNcNNWi4ZTxggzMFTrums/lME21I9XAnnx/JGLRKUmPd+9EDX/atAS6JU6GcljCGdZqkrabFjev4gETvd0cbkVXFoUUdzXicX3amW/0UelKFtMde5942dsX12mYT0xvZhPS86k9hFowxm2SibLwjyyu5vnjbxLqlr71yxSVvGl/vhMcl3D23o0OFH90ZC4JgT5Idu1l7QuFwelmEQZe9sAGiRwE9jXA/WbxTse+iA0j+ysOHgApbIC0kKOmfcH9rB/HIqllhmrZ7amjJrmXTU7rwUpPS9PDcL2njstCqRH/XgeVledm5AuMudVsyqXBpzYPlqlvYGZ25bbIP/uMsGBbs5jwkPMa/a3Snr4HRDdlpVLVtem3jk7qeHhOR1fiXT3VSMXcyzeLtoyrZMTa6yPI2qH6lNILeAeuEjb1elyt57yDDE4+qwJsC2HL28/eubpwgKB7F8haCTq4dy5k2CPJ/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7254d115-5989-456a-f881-08dc4d2d80ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 00:41:41.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fm+UaA8MpKeHckvHtmr/+wrImqv9DepMsvDVNUKMYxuqkpIjV/zILaXMuavIph38fJro5KTBltX7U//zHBLkZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_25,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260002
X-Proofpoint-GUID: ZF1FTn8IMxXIq_WsrqySv3mOvB2HF6cG
X-Proofpoint-ORIG-GUID: ZF1FTn8IMxXIq_WsrqySv3mOvB2HF6cG



On 3/26/24 03:06, David Sterba wrote:
> On Tue, Mar 19, 2024 at 07:41:29PM +0530, Anand Jain wrote:
>> The fstests depend on the output message of the create snapshot command,
>> and if it's changed, the tests fail. Bring back the original messages,
>> as they are also grammatically correct.
> 
> I removed the 'a' for consistency with other messages. That fstests
> depend too much on what applications return is not a new thing and the
> breakage will happen once the user-facing error messages get updated as
> they get the priority.

  Alright, I wasn't aware it was an intentional change. We need to update
  the fstests test cases. I'll take care of it.

Thanks, Anand

