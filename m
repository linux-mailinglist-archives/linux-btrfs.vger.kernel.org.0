Return-Path: <linux-btrfs+bounces-1371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A08829F20
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 18:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F041BB21614
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 17:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29CE4E1D1;
	Wed, 10 Jan 2024 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I/SDhBzP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ng7pge6M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25EE4E1CD
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ADmqo9024878;
	Wed, 10 Jan 2024 17:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=v1BKuBGnrIjEg3YS0rRRzqmxSXdJ/Y3A3NJ2x6yOHLM=;
 b=I/SDhBzPW0T9gmVEHZtc9oky0T+X1CV7ylM4P7lI29fIpU0zE/e+OWym2er9wQ0uQhHY
 iez8v0liFtL7MkwFUjThp3ULQCw7XXV+6yv4olnlHGIVm80zAYAlIkwXsgLd59kib1YD
 970Ei/w7hfjr8BUBn5KNzsAuwt5kpC5K4J+8hkyQ6PHU5R0c/nDXYtZk7u6U0RvDKEYr
 Ig18NOdVh1craBx5JJPUwT/uV1AUJzVgYy5sk3PG+fQR6MaMWKmj+dL6bqohGmBvuNFF
 BNAtFu/voJrP2wGFNI2sZs/lRNq6djWYJdFKTOGMFyM8lk7YuHJ7OqRygBbfNiVS/Hzt 6A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhs1x0x54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 17:25:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AGKpmd030139;
	Wed, 10 Jan 2024 17:25:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutnx5w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 17:25:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjqxiJrrAMgZCHU9/YjyDB3dyRKr3GgbRfm/N3aH88w4e82P1iPmroiB9UY+1+0hFYOb3Uq7sWimQWYGT5UQLD4k0SdnxCRlrDS43OtKGs51Gogc0hijiI7FD7nUQf2Q509YdSs6x3/s3xno2rQlFquEATPV7rmdEpd5zP5YP31EPUh3Qx62o5wuSbaTKi0xtPcRKqs5eAdjTRAUWW1UAmlGqQnWGQ/0H3got6mBk55S3L9cnPTbSqSqcGrQjKqLW9DrVS80xoLfIjVTq+k449B9pOMIEKS8Ivhd+UG7kzq1cXz7Jtap2NDluHlgcw+sbRjfJlF5DQO+BiMz1X3WTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1BKuBGnrIjEg3YS0rRRzqmxSXdJ/Y3A3NJ2x6yOHLM=;
 b=L+0B12T16N57xc4z9/eTE/taFwlk1sEpkw4Spt60b2xG/uSzFh/vn7TetmGW+rb9fV5iufeo5wlWO+ud2DM+9zULPpBz71nCLO5h47SLHqBVWlUXg13XsMVEqJMTDdtnDSlSF0HbWJBqPOle7q0a/fwSELBX2RKR/jPrTYLYBuRHKwi8iCqQJjA8xp3WG28V4Q/4FFedLF8v9dvRLQcKBio6qwI1WS7oA7w6cbVqYbWj4SXC3fhUg7OG2TxOp3sAQ6WGsJsn0b2tEvA3V0OSQvFj6INqopiutnVD4pPy2L72cdRRJ3SN4yD4IPbpJpZMpsRWiNRmAwogJjzOKYe/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1BKuBGnrIjEg3YS0rRRzqmxSXdJ/Y3A3NJ2x6yOHLM=;
 b=Ng7pge6MTmvOXZfWws6wN+IDLMnVs4u8smDHktQymSSEPApLA1Cc0aAEd/x0yqEpwamVDqq4qOio7Uh5XStlJFCRTKuOKeWd1iH7vcuKGKw82vx9ngh3011NxTxOl8mQGJS4b7PorK6wwGa/DnxbiNa+jg1ZbY8kXReN984AbJk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4439.namprd10.prod.outlook.com (2603:10b6:510:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 17:25:33 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 17:25:33 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com
Subject: [PATCH v2 1/2] btrfs-progs: Documentation: fix sphinx code-block warning
Date: Wed, 10 Jan 2024 22:55:22 +0530
Message-Id: <c3de4580548fcd242497a32c9062c5e1eb3eab7a.1704906806.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1704906806.git.anand.jain@oracle.com>
References: <cover.1704906806.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac8ced8-95ee-435d-1676-08dc120126d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mEwhTI5t3XZKFWfVyBZrg8E7PCGaXvnl19t4liUrUuXvBudy5IeLevuSZAPD1DOI5qnDOTyFPhtw9EWipBhi6eh3y+2nD5xEKgZlNx7cOJP/Z2rQvT+OXSFPo5XrGphVBt3JScE+lMdg73CdnRVcnPl7zSkaNOH1C8dtQwZkyZkHTV+mMBqrv/1mGtJQvqT2/AeEqK3/Fp2K/4VqC2T0UwQdVLYenAKN57V6mu/wBzbcTmFq4XPNhcv3ABg6Fh87vzEl+G2sNbpN2ui9xaQk2LuT/hWn5zQzWGHD9iN4aM+sd1jtpWAgN1344nxxW7TURxPE5V2D0PJR1iY3ylEePb0HbYJgH39geBDlTzpZnnjqfnT9P66ZB7yuZMQYWHk1jo3gczUcGZnO/vleuvfLKT1L2i2eX4TUA4sIL/7kKchInsW87ONPzFI4lwTY7RKdBTBGH+IMc1XL/wwde87pWciONM/1ghox9NBoT/xp7XhrFLW1jmGk7/SPYQy2OrJBtbM4Dh1DX/Q3R4P5c066fJOVJrXc8ACGGK6WQog/bYXdHLLmJKb9J6ovMtgke2jOTEXXYtwOABB5x0tjXuL/pl3q54/c1v8ApaxeuRJFSiLXHTqpRTvUALnVaBcIa7TS
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(2906002)(5660300002)(6666004)(478600001)(4326008)(44832011)(8936002)(316002)(66476007)(66946007)(66556008)(6916009)(36756003)(41300700001)(6512007)(2616005)(6486002)(8676002)(6506007)(86362001)(26005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SThmSzN5cXgvQ3RQM1FiYzdHdUtyWTN0OTErdy93aHduOFk5TFJ4OVBOYTVS?=
 =?utf-8?B?a2svYS9CUjZOU2I2NzB3Qm12cmUvUm1xZUxNUXo2MXV4dWo2NGpiaExTQWY4?=
 =?utf-8?B?eFUwSmNJMVFvRmFQdGVQMys0SzhCZTNuRHdPZkE1Z3hBTU1RTzRTdEtYSHVJ?=
 =?utf-8?B?Mjdabzl4U3lTVXpZWkJRMHJ2MlR4QW5oQ0NsUnlidnFhd1ltUERvU205K2lG?=
 =?utf-8?B?MG1SQUZaUTc4M1RUOXJFNGFDbThLQ0VJZVVrSTZzU1BNSmdKNzJ3R3gvWEtC?=
 =?utf-8?B?QWdRWGFwWjFQY1IvNVF0bWxnUHJ4RkZ5VHZaN3FRNGpucDRkZGhxUUMrRi85?=
 =?utf-8?B?VytLTEMyWStRL0V6TW41M1ZSTjRtekpkOW5LN3FJSFhoZ3ltVUhKTjZ0a3FO?=
 =?utf-8?B?bWl4Ym5MaDV2aFRERDhvTkRBU0IvTlZSUHQ5eThTeCsrdXlzdkJNV0VlYWdY?=
 =?utf-8?B?K0llT3hnellSMGJGa3FsM2o4WFdyUllKeTdUZndBeEF1SW5IbFp4cysyYzBM?=
 =?utf-8?B?emFobGVtY1Uxb3dnWjh4YnlqVERPcGxDVCtGL3R0bWNaenZEdW04Mnp0YTdL?=
 =?utf-8?B?YlJhT01YQ3AvTzBwZ0xlcmlpVUlxdzZaUmdwaVZFbWxuekNFU3loa3kvLzE3?=
 =?utf-8?B?bEkvVFM0enkzVUdtR2ZabDM3dlo5cjU4ajhMYWt4VkVEb0VLVDk1ZTlyRXlh?=
 =?utf-8?B?cTVEcXVOcnhFczd4ZitrcnpLOE9OSHV4OXNuZmt1YVV2aGZKQUpVblNlRURN?=
 =?utf-8?B?enlpREtEYlIvTzViM0poSjJkQ3BNRXBkRXg5ZDJST3U1TFJYNlFDazZHTEVZ?=
 =?utf-8?B?dllhdU8xL0JoRmlVNTFEc0JzNlRDOWRPOHQ2YUNUQWhkcXRmaFExdXR3cUE2?=
 =?utf-8?B?dkI1ZUlxMjQ5NzZrVFV1OUZqbVB3a3prUkpqbVhMeEJmRENBaDM3MmxwbUFI?=
 =?utf-8?B?eVhFb0k4SFR5cGprdTNUQ2Y1UWo3b09TU3ZuVWhHQkY4TGIvNkwyR0FvMVdS?=
 =?utf-8?B?RjR1WmpzWElYRnNYSDdUYU9qOE9ONTBWWGFHQkc5Y01EOG5vNXo1bXJtL0d5?=
 =?utf-8?B?Q0g1eVFlTFYzU3k4YmZ5OXhiaVFhK0F1a0kxdWdvaFJoZ1BjV2h1Z0lGcnhJ?=
 =?utf-8?B?cWh0VnVLWUl0eWx4djUzUC9Kc0NBY1hEZWNGb0QrUEpETW12Snp1STdsU3Ry?=
 =?utf-8?B?Q0tJVFQ1L0N1Y2NtQk11Y1NaSmRPbkErRVJENkc1c0hhRXZRZS9hZEZQTnhX?=
 =?utf-8?B?NlltV2dEQXFlMXE2SmRpOWR1eFJ3VXJqQ1psKzdPWm5PWmxiMDNtSDNWWVlM?=
 =?utf-8?B?RmhwVUc1cEpTdit2K2pycW93TjlvbVdOT0hBYUFVZENxcU9kRFFCZjJYSzFZ?=
 =?utf-8?B?WTNYanBZWWZvbi9hUTh4MGQrOFZFYlBQVXpOQkRrRDZaU0wvTHExOHIybCtY?=
 =?utf-8?B?OThWRjNGZDFMSi9BL3U0ekRBRXNOb05LbkZtamZLQS9ESStrTHQwZ21kc091?=
 =?utf-8?B?dXpkelVsaEpaWGtsdGx6Mmpvdmh5eXJUVXl6bHBCNlUxNHhldEVnNHkrbEJv?=
 =?utf-8?B?Rms1VXJDQm1lL1gzYTJYZW5KNVZtb1czcHErYk0wK0lseTQwNXR3cFpNRHBq?=
 =?utf-8?B?U1c3MUlvUEhTaE8wN1JlQjdSM0VXdFFNQS9reFl1VFdoVDNrOUtra0dtSUxV?=
 =?utf-8?B?M1NsRUpmckd6MlA1NGZKMnVuKzRjSVRRQ1RUZXFiTXl2N0dQeHdGRXVaUVJC?=
 =?utf-8?B?YWxPZHlsbmFwL21ESGVuRkh3YUhXdlY0QzFQdndFajg4dG1HckllNHFONUtm?=
 =?utf-8?B?QmZDeWNObnpaZXdtckVNa3YwckFpV2VuOXBCK1ZCNDZFdVBublhmUFJwU2p1?=
 =?utf-8?B?TUFsektXR0JieVlXeDBrSkZISkttbVBRYVRLTEZ4am9xWE0wSExZdVdKZjhu?=
 =?utf-8?B?UHhuMDdac3hrMDBUL0dzR2huZk5sRWhXV01VQ2dncFlvVDdDQk1rKzFpUDFM?=
 =?utf-8?B?STN4bml0YjR4L2ZVOW1jb1JBZ1ZHcE83RWRMSllSSTlHVzFacTJKWXBnd25P?=
 =?utf-8?B?U2JPSGZDWUFFM09kV0NRdUxPaGxKUU1VOTh1SG1qVy8yTlJwd1BIRHJsNUN6?=
 =?utf-8?Q?K58FTpa7Dky0JNtwDvFIgucoy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3heAcCOdxT9Js31+cuXEFZojMiswNmx+RwI1wvakGMFNw1rhyHNarBGQLJ4hpkI7C/RMxVCRbZpESQtDc50FzAnsrmEumlgODVWAiIJvZY7+j0sxhxzOCbXAsUl5/o45Lyr1IK/YX83PVtxMjgg3BG2IZef1Bb2kgxiuby07dH9M6XS4xypspjVN6EjvQhircBjrMZWsnnHYKwz5xTY2xeQtYcS7fRk5mQwRs0rSM1RF4Ag8IaG36QBGYdYhWJ7tHM/CI8tuTR24mkaYhz7lzE3M4ZoNcAJWf4rQ+eM37mHA1Y7QD2hipygdtLBQnu85y6cVAnXWwdz0rUXa/5MA7vXRGkcC1wy4FjJv2Vg7T8lbgk/ugd95VW19eH9KPWqcSWCBO5oFVWlnnoITiMJvju0wt8GXxbgZ0DuFoNbkbpgT8zZRBiHwQjYloxKQ1art28Q44sK2HUYo/+XC+ZyYuaDaosAgJDygKsNvnP7EvUDCyCD9kGHqflBvyIDhVH1wI1MvU8190sAmHGR7DkIyA7EzXu1yQRqEz5PbwedgumP8Ntd/NNXvNRk2bW1iKpzVviZYc6/MkmehLRhsr0T6TEK7/J8vXNhw5MX9juzb7vc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac8ced8-95ee-435d-1676-08dc120126d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 17:25:33.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXIS6NnxjIdURAniDED952JDWz6oTtzEfueRnr27StUeytxYMRB4f8UZobi0W2pUE9HSJS9DMLISuKoSRGWn9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_08,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100140
X-Proofpoint-ORIG-GUID: FX_wmWzvw_ycbDH4aHfE54KxKJKdPeMq
X-Proofpoint-GUID: FX_wmWzvw_ycbDH4aHfE54KxKJKdPeMq

There are several warnings regarding the absence of an argument for the
code-block directive on some build servers using python3-sphinx 0.2.2-17.

For example:
Making all in Documentation
    [SPHINX] man
ch-subvolume-intro.rst:141: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.

.. code-block::

   27 21 0:19 /subv1 /mnt rw,relatime - btrfs /dev/sda rw,space_cache

 Etc...

Adding the none argument.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 Documentation/Tree-checker.rst         |  4 ++--
 Documentation/ch-subvolume-intro.rst   |  2 +-
 Documentation/dev/Developer-s-FAQ.rst  |  2 +-
 Documentation/dev/Experimental.rst     |  4 ++--
 Documentation/dev/dev-btrfs-design.rst |  8 ++++----
 Documentation/trouble-index.rst        | 16 ++++++++--------
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/Tree-checker.rst b/Documentation/Tree-checker.rst
index 68df6fdfa0de..620c203f098e 100644
--- a/Documentation/Tree-checker.rst
+++ b/Documentation/Tree-checker.rst
@@ -30,7 +30,7 @@ fine.
 
 A message may look like:
 
-.. code-block::
+.. code-block:: none
 
    [ 1716.823895] BTRFS critical (device vdb): corrupt leaf: root=18446744073709551607 block=38092800 slot=0, invalid key objectid: has 1 expect 6 or [256, 18446744073709551360] or 18446744073709551604
    [ 1716.829499] BTRFS info (device vdb): leaf 38092800 gen 19 total ptrs 4 free space 15851 owner 18446744073709551607
@@ -54,7 +54,7 @@ checksum is found to be valid. This protects against changes to the metadata
 that could possibly also update the checksum, less likely to happen accidentally
 but rather due to intentional corruption or fuzzing.
 
-.. code-block::
+.. code-block:: none
 
    [ 4823.612832] BTRFS critical (device vdb): corrupt leaf: root=7 block=30474240 slot=0, invalid nritems, have 0 should not be 0 for non-root leaf
    [ 4823.616798] BTRFS error (device vdb): block=30474240 read time tree block corruption detected
diff --git a/Documentation/ch-subvolume-intro.rst b/Documentation/ch-subvolume-intro.rst
index 57b42fe7a97f..9ca39d0adba2 100644
--- a/Documentation/ch-subvolume-intro.rst
+++ b/Documentation/ch-subvolume-intro.rst
@@ -138,7 +138,7 @@ Mounting a read-write snapshot as read-only is possible and will not change the
 The name of the mounted subvolume is stored in file :file:`/proc/self/mountinfo` in
 the 4th column:
 
-.. code-block::
+.. code-block:: none
 
    27 21 0:19 /subv1 /mnt rw,relatime - btrfs /dev/sda rw,space_cache
               ^^^^^^
diff --git a/Documentation/dev/Developer-s-FAQ.rst b/Documentation/dev/Developer-s-FAQ.rst
index 6d8d78e54b4d..496900415a67 100644
--- a/Documentation/dev/Developer-s-FAQ.rst
+++ b/Documentation/dev/Developer-s-FAQ.rst
@@ -178,7 +178,7 @@ For the next iteration, add a short description of the changes made, under the
 first **---** (triple dash) marker in the patch. For example (see also Example
 3):
 
-.. code-block::
+.. code-block:: none
 
    ---
    V3: renamed variable
diff --git a/Documentation/dev/Experimental.rst b/Documentation/dev/Experimental.rst
index 4817faa56c79..70d14850f5c8 100644
--- a/Documentation/dev/Experimental.rst
+++ b/Documentation/dev/Experimental.rst
@@ -11,7 +11,7 @@ filed as issues.
 
 In the code use it like:
 
-.. code-block::
+.. code-block:: none
 
     if (EXPERIMENTAL) {
         ...
@@ -22,7 +22,7 @@ where it would break default build.
 
 Or:
 
-.. code-block::
+.. code-block:: none
 
     #if EXPERIMENTAL
     ...
diff --git a/Documentation/dev/dev-btrfs-design.rst b/Documentation/dev/dev-btrfs-design.rst
index c3a6d73872e9..befd30a114ba 100644
--- a/Documentation/dev/dev-btrfs-design.rst
+++ b/Documentation/dev/dev-btrfs-design.rst
@@ -15,7 +15,7 @@ The Btrfs btree provides a generic facility to store a variety of data
 types. Internally it only knows about three data structures: keys,
 items, and a block header:
 
-.. code-block::
+.. code-block:: none
 
    struct btrfs_header {
            u8 csum[32];
@@ -30,7 +30,7 @@ items, and a block header:
            u8 level;
    }
 
-.. code-block::
+.. code-block:: none
 
    struct btrfs_disk_key {
           __le64 objectid;
@@ -38,7 +38,7 @@ items, and a block header:
           __le64 offset;
    }
 
-.. code-block::
+.. code-block:: none
 
    struct btrfs_item {
           struct btrfs_disk_key key;
@@ -311,7 +311,7 @@ field of the root block may be different from the objectid of the
 snapshot. So, when dropping references on tree roots, the objectid of
 the root structure is always used. When a backref is deleted:
 
-.. code-block::
+.. code-block:: none
 
    if backref was for a tree root:
         root_objectid = root->root_key.objectid
diff --git a/Documentation/trouble-index.rst b/Documentation/trouble-index.rst
index 8de7d6232a11..4d07c85106fb 100644
--- a/Documentation/trouble-index.rst
+++ b/Documentation/trouble-index.rst
@@ -12,7 +12,7 @@ Error: parent transid verify error
 Reason: result of a failed internal consistency check of the filesystem's metadata.
 Type: permanent
 
-.. code-block::
+.. code-block:: none
 
    [ 4007.489730] BTRFS error (device vdb): parent transid verify failed on 30736384 wanted 10 found 8
 
@@ -59,7 +59,7 @@ persisted and possibly making old copies available.
 The most obvious way how to exhaust space is to create a file until the data
 chunks are full:
 
-.. code-block::
+.. code-block:: none
 
    $ df -h .
    Filesystem      Size  Used Avail Use% Mounted on
@@ -98,7 +98,7 @@ action is possible. If not, ENOSPC is returned.
 Error: unable to start balance with target metadata profile
 -----------------------------------------------------------
 
-.. code-block::
+.. code-block:: none
 
    unable to start balance with target metadata profile 32
 
@@ -111,7 +111,7 @@ Error: balance will reduce metadata integrity
 
 The full message in system log
 
-.. code-block::
+.. code-block:: none
 
    balance will reduce metadata integrity, use force if you want this
 
@@ -126,7 +126,7 @@ The preferred way is to use the :command:`wipefs` utility that is part of the
 *util-linux* package. Running the command with the device will not destroy
 the data, just list the detected filesystems:
 
-.. code-block::
+.. code-block:: none
 
    # wipefs /dev/sda
    offset               type
@@ -137,7 +137,7 @@ the data, just list the detected filesystems:
 Remove the filesystem signature at a given offset or wipe all recognized
 signatures on the device:
 
-.. code-block::
+.. code-block:: none
 
    # wipefs -o 0x10040 /dev/sda
    8 bytes [5f 42 48 52 66 53 5f 4d] erased at offset 0x10040 (btrfs)
@@ -172,7 +172,7 @@ at 64MiB, the third one at 256GiB. The following lines reset the signature
 on all the three copies:
 
 
-.. code-block::
+.. code-block:: none
 
    # dd if=/dev/zero bs=1 count=8 of=/dev/sda seek=$((64*1024+64))
    # dd if=/dev/zero bs=1 count=8 of=/dev/sda seek=$((64*1024*1024+64))
@@ -180,7 +180,7 @@ on all the three copies:
 
 If you want to restore the super block signatures:
 
-.. code-block::
+.. code-block:: none
 
    # echo "_BHRfS_M" | dd bs=1 count=8 of=/dev/sda seek=$((64*1024+64))
    # echo "_BHRfS_M" | dd bs=1 count=8 of=/dev/sda seek=$((64*1024*1024+64))
-- 
2.31.1


