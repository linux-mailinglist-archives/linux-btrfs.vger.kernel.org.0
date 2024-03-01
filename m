Return-Path: <linux-btrfs+bounces-2958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723F86D93A
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 02:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DB61C226A4
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667E436137;
	Fri,  1 Mar 2024 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TkDax9JN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zz8CxkLR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5482E3F9
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257979; cv=fail; b=AHJLl9HHX3UMLWohOtDvZB9Htd6T6LmufNp8xKpjFjL409ctaXP4JDEVZStdz7wl3boIq6GJTmgWn7mauRGoED9cxezatk6PjNv+ApBfnmlWd8R6gYq5ZkHyO4SRCLpnkhbBxkQY1ty/zDF0d9bxD37Bsx1439Tx32jQDI1hPaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257979; c=relaxed/simple;
	bh=l0Q2/FXmsWippp3XkLuxZGdUDYIgvyXVy7Ht+GG/tu8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t/tteJplRiAMO68AbzuSDrWJgMN6IsjGAIOpCaR/Nej0DCYVEHrTFDzVr+8H1fbNWUSjHtCKUY1M5DeTAOWmZwaxD5UKY0Ahn8mvmq/YtpjGV9G/Y2hczXwXPjoW6fCuI2Io69JBoxj7oQo4Z2tJZ4YT7J9D4e0o6Reb1Ko4vKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TkDax9JN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zz8CxkLR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4210ifeL000730;
	Fri, 1 Mar 2024 01:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=n1IdZP9MUaMRDtvAZ72s9pTva3jrV8X/P1TJ3bNps8s=;
 b=TkDax9JNot/gV/lpkkyw7JUzqZDGnYmdaAFmQtAtv8XBeL0yb+gnxe2TfRuGj7ldxMqk
 /+h82QJ7FU2DqqI4vhXM7z86y2G3R13koOzZqqw/8sLetmeFC3XJHSA2DAZvrLVagD50
 ntV6CgojlFNXUob/xzQq6xhmS6T8yQO79iORca+r7g14AkWLkWS0M67cEtIf+yDSoFF9
 Tg7ueckDyGi3DlxbRvXL3nrJVQuhYt7aF0t7IYZz5WYSJ0x1geogeVfvbKILPrspe3tp
 AW8DiIy3jR34xrDps31PP9iW6P8By2dAUrPzlruSwoyzy4/789xaPd8qQw1LUa3zd/PI XQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82ueuhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 01:52:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 421055dZ004795;
	Fri, 1 Mar 2024 01:52:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrq73u8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 01:52:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oof9426f16jHg8fgACJKfwuk28zFCc4jLCVk5euairPQRP7dqqEudQY4Zp0tYt4JyB36vC+juf+YdwdgGHIwcJyNUBwKmJKRLoOFQJaGuMXB4Z2wyh48p2FWqlAZnqXnq8SwjTViftZVowOq5OSq/Ky908o5QERQ05Tmjk0A+23hoGC7l62RreNDlPJaXYEDOXYTwXlU0Odbr5GZVNGCMAwzU+A1Jg9PDsi7qzgW6BvVMEOIUQ97ic7/aBggmOb1qkhyy+Gz+KM3ecAC60WuyZbfOFFFq09LDeNFs+Y6D+VQaTrKwzdboL5RT6DJ30SfzDc74VbH0eXmhS6fQntxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1IdZP9MUaMRDtvAZ72s9pTva3jrV8X/P1TJ3bNps8s=;
 b=gWCqD9hBC4P8JMwHupDIiFl7mb5NILJSj0JdjaVYJ3T2xy7fWDx+We0eV1nVkFITl/ZimQIx1nMwhJlIZ4A2y5wqyg0mYYVq6SqAI/4xs36JtYXVF+ySV1x6tx8NdrWTbP3A3khuqtyAv0yRI2xhQnrLrdT2fQ8UfZy3WCrngQZEQAhDjnB79uS1ovBsT40N8PR9WFW0FqDZ4E05QgfKR6oAj8v5/RZyDyLwxbtZwMmxvWsfaQJ+YbN+kihY0jUo0cqBldZvL9KSaO2xUvD23mQHvcryElRk08ZP5j16x6i2W06+ywNJpXrpF4li3hxvLmxq9EVwnBbM0YfzNlieKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1IdZP9MUaMRDtvAZ72s9pTva3jrV8X/P1TJ3bNps8s=;
 b=zz8CxkLR30w2/+Qnp+cZmfcFGxSV4HiAfU0z/N+bH6nftvw9BNWdH28E2p4yGwQuSA50D6cdhMKq4SabHDWWxMT78IG9FLXG7qiL6fgFczEwdzpqo9xmxJHRNt4tpfXK08n+EVI6AVl2sCcLNbv78SZ8tjse0pAlxSL7RiaShn4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 01:52:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Fri, 1 Mar 2024
 01:52:49 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org, boris@bur.io, dsterba@suse.cz
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: validate device maj:min during open
Date: Fri,  1 Mar 2024 07:21:32 +0530
Message-ID: <752b8526be21d984e0ee58c7f66d312664ff5ac5.1709256891.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::28) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2c1b19-1ba6-4150-b564-08dc39924cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6EB3ALxLxhTxFOtjWQ4G6KOZWrrU4PaYYv8W+tC4Gxjn/K5AbZ0R1KzsDv5MHlgJmEUJuqNT/od8B6zg4UOvLMndHI9ZHOUHWPlWclyAMOmTwajTarOceAbaIQk/kQlom1vm/CI43SLyr5mSWAQeK1qY+SDwYGhD4OncS0lgEHiVdVFT0cNOoTaEE7hYxrWcTarNANSYzS3O4DZBvtimw1Jjyp6BuwpGeDjcI6u8oPc3Y1lntRZNzr8hUNFffEBy1y/K4UR59x7wCPW4P3zk2Nns35NCM+gKro72aweG3/0Obn23PgdT/2xQ/Pnph+3nbbGNl8wywUsDBanb7XGrY+lQFSDm+uODhOvcGB52awwf5cK/BnT6jo9jS9TOU1SVkKnjvcV9I5IZjKXbEj7WcP5AgWfDmqdnGt5NSbKBm3PlekwVcskfwrpyEuGPREEy9R/FTbsUkj3JGSl4vqUrNH4Ek5yr41N2TywX6zfJygQ3wHW2GVGdVSCshBKcU/WInLzRT6lmbeRaQ5vkCpftk2YyMSLOcK62YzvpcKp2rytK3PMWC+WksgC1OSAVeOI50j6/gxQCIj6cwNXBKjBk1yX8EIK2JmE62QAnCxVT7kwyg+OQ4SOLLORKYY9t5lNz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3tzxr5HzhaNN418AUovnVeLKv94i53+tqimZ4gckjvJDQ/gZImzzw9pdN+ZL?=
 =?us-ascii?Q?oYdgwqlWD5uieTUP4d7jUw4BmJJ0ipToMDtT6VEjy5juxDGxlIemRK8EMycB?=
 =?us-ascii?Q?hAVS2YaXYxXtCsDf9DSH+Qq8tGyYZgfCgQpzXXcc+6qWHmjaOxYlyy5YhguE?=
 =?us-ascii?Q?g7P6kYQF1OUu2U1187xBAs0uPj34vc78cEYWYmtbBfkNex1OC2iWZA8mqbz9?=
 =?us-ascii?Q?7c2Uf15jU8rFGyG39suY4LFxSm2ALE0X4I2+QN0Q0QtpC8fBIh3skmdrOHEA?=
 =?us-ascii?Q?ENw5w4d3NTK6N8xSd3AVsTMSwvo3kgDtlx5tUsm07GRUYaZGmMUU/LKG4q1R?=
 =?us-ascii?Q?neI8qvAhib0K4e8/XBoiX+1hl/Vw3wMt9rv2FtYrX8RjMGJP5RVkPXoAlw1x?=
 =?us-ascii?Q?Oy8ghk2vH29Get1uEufm+kBDhLok+WtYssTdm7tg8ZxudaeCogBQmU+l8NZN?=
 =?us-ascii?Q?+CtXHi5eKz3/Or3cbU7ALBwWNKGcydT2NMc9nap1H/s93ogC7FL8En3G6WP6?=
 =?us-ascii?Q?BPDlh+fshvafvM8s5uStfz78GohQqSwtAKCIae9PFaRg13EhJixapFttnU17?=
 =?us-ascii?Q?inAZAm76Ubm3d4MH9Ca9ZynXcskjImxBG92ABI3D8CiJ+yyxEt9nW7AGE0+k?=
 =?us-ascii?Q?iDVTYtLPqPhVdU4VB2Dt8qBobp+CAAjz9sy3aM4D/ZmyZC8LqRIRuTfGvitZ?=
 =?us-ascii?Q?Ro9TjavHyDQ6rozE92JS+gwRny8go5Q88W/ItOeLF+xtm4Ad0nkww2I/SvW1?=
 =?us-ascii?Q?/5CgDjD9O653lr4alxoiO6h7CI3haOizUpniBySUCP8uXSV8GUidFjXhLHWd?=
 =?us-ascii?Q?bvUzNUY30gZ63Qb+f8O2G+nvHLYSzfbCnMuhWDQn/RexT3MS9Ikd+CaoWHbx?=
 =?us-ascii?Q?ydSaimiFYGr3gdmTjjxQlq9l2HKKKHrqyxZf8QWFuFUUFB2eEOtx+gylArfP?=
 =?us-ascii?Q?j50BNzKeQX1VWIsAywDXgnuYLRaAJfRxj1yggpJfz+ItBPlkGd96C04Glp93?=
 =?us-ascii?Q?IWFvHYPgGN6KtWnLPEv6sJBvLoLOJEwMgJRUpNmRS6sn3adJTdoMmW3JeI+o?=
 =?us-ascii?Q?JW+rAE24+8oOpKjSN/W05amzqpJVFjyGWyrEBEjHvBJPqt6HMVhDtPVD5TAO?=
 =?us-ascii?Q?lytA1fRPdNNdhSoH/uS+PW+qiuGKHzZcTc9PZPfRbfiJ9l1t8SAGGxY1+aCr?=
 =?us-ascii?Q?Jy8iYPZd4FHJVpIJpHRn1youVuhFN9FXYYcs4cA+ftrYJI7S5ebGxPnJ/RyP?=
 =?us-ascii?Q?URQ2faeOqrEejN2/d2jLgGOTwfHExPsn1n0ib1Ien/Wd54zkyZcS8MSZU1Cy?=
 =?us-ascii?Q?WgKgpyMDNjxcrLs230XkLbPABpUZa8GBkDkU20M2OfC2UA9R8a+2U3PQb3D6?=
 =?us-ascii?Q?JRSYxVA2AogKoiFmFNRcMz6x3JLNFLIeRXIy34QwIgYw1bLllofT+NkFTUn2?=
 =?us-ascii?Q?CCwCOLhN+6p5xZSTZkUwogv0fXRJXcCNOoMZVAgJNABh9RjLx6dg5hxcOzFX?=
 =?us-ascii?Q?1xfFONKYvcQQ3IZoq6NOPwS6vWFyUWaefE8AymF/MUD/H+oFQpTOnjQjZ/eX?=
 =?us-ascii?Q?DcTTaYAkoPFCMsqML7lJDfckx6GMUwnAgfWxf4n94mqOjpKZvpLbKA87Vcr3?=
 =?us-ascii?Q?tI+dkOLPSJRS6E4Os3rh2YyAUzbDLOv67sM4vevd7HsG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zman0HYWNP8sOxIR9rpa6x732YP1SwiB12KyEd0fu0PoeZ0nsoFw339PhTgIKJJG/q1irpfLbIfrYMuoZrAcPCfQlajEzqR9HYsad8VfeRDZY+rQSWGd0Qk4mtVFWMeNPPu61FcdP3AiuzRw9otXlEJ9LwREYLGAv7ORQOnpzI3VMgwj3jdYp2T43h0eZcHO+VBXYlvfOHPuG6OBFI3W1OtK6ksjsx6g1gXLttvMsDS0nhArW5Cws4ICvfaBAng3G2Goosekv0I397uS9Ek6DpLV/vDPsfhkvkDsJWhZrba+KdysxAhiAmpCbaREsWaxzFOftqLWGkNQZNHQoVhwyTSvylvEdsXmzwKVBh3TKKUqQXdczBBOVwCacom4cYdxl+CWBBDhyHgfnqTApJPUGx8lIupDFmBDD03498QJ5OvVKrSYsaZMZ+0ZDK1pe8XaEPQQmi1ZLwuZfS+ER6GRgrlsBRYHKkgiql5UOIynRq4sqlnk6oS6ksLySxup4gw3yMA2HyeYIUrkQvVvvKU9a7WDm6CEVinf5/mbKvMQ2uOhX53q8/SnF7naSHQvC7i/CaRGxPZ3t6rhrCh0Mr+v8CV1luUzxWlTNAWfkkzpAhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2c1b19-1ba6-4150-b564-08dc39924cb9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 01:52:49.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jspmN5dRZ6YKFnjqLEhwOYFBKAqbIKXbJBqczgr360Aibue9ZaWWno+DYVq7SRY27O2Qsf+NRrm+KWyMAs23hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010014
X-Proofpoint-GUID: h7nfD28cwcQZQslX7XMFcIBnPgLmXBCu
X-Proofpoint-ORIG-GUID: h7nfD28cwcQZQslX7XMFcIBnPgLmXBCu

Boris managed to create a device capable of changing its maj:min without
altering its device path.

Only multi-devices can be scanned. A device that gets scanned and remains
in the Btrfs kernel cache might end up with an incorrect maj:min.

Despite the tempfsid feature patch did not introduce this bug, it could
lead to issues if the above multi-device is converted to a single device
with a stale maj:min. Subsequently, attempting to mount the same device
with the correct maj:min might mistake it for another device with the same
fsid, potentially resulting in wrongly auto-enabling the tempfsid feature.

To address this, this patch validates the device's maj:min at the time of
device open and updates it if it has changed since the last scan.

Fixes: a5b8a5f9f835 ("btrfs: support cloned-device mount capability")
Reported-by: Boris Burkov <boris@bur.io>
Co-developed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index deb4f191730d..4c498f088302 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -644,6 +644,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	struct bdev_handle *bdev_handle;
 	struct btrfs_super_block *disk_super;
 	u64 devid;
+	dev_t devt;
 	int ret;
 
 	if (device->bdev)
@@ -692,6 +693,24 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	device->bdev = bdev_handle->bdev;
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 
+	ret = lookup_bdev(device->name->str, &devt);
+	if (ret) {
+		btrfs_err(NULL,
+	"failed to validate (%d:%d) maj:min for device %s %d resetting to 0",
+			  MAJOR(device->devt), MINOR(device->devt),
+			  device->name->str, ret);
+		device->devt = 0;
+	} else {
+		if (device->devt != devt) {
+			btrfs_warn(NULL,
+				"device %s maj:min changed from %d:%d to %d:%d",
+				   device->name->str, MAJOR(device->devt),
+				   MINOR(device->devt), MAJOR(devt),
+				   MINOR(devt));
+			device->devt = devt;
+		}
+	}
+
 	fs_devices->open_devices++;
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
-- 
2.38.1


