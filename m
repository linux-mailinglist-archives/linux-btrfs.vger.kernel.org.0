Return-Path: <linux-btrfs+bounces-1152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B76481FF5C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995B9B22324
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC15111A2;
	Fri, 29 Dec 2023 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N4gm3nxs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DZUmq6yv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188A11195;
	Fri, 29 Dec 2023 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8PgOC007078;
	Fri, 29 Dec 2023 12:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ppQ2C0H4XQlmdUl+patWgKSEEnl80hSU4J07iJxVUQ0=;
 b=N4gm3nxsRfW/Pj0235462wXUOWO40/8HEVCmQJ1//UI1Cfu4/F7czt7KgOYBMH7Ep7xz
 JVLwSHr+3DnuClN7+71vX/p3QtSekhSfKt+sMtrqz+NUVF1MmR+jPmSNkHLf/HvXo9SE
 c0DdjhQyGmrY0m/ltnb1fO33netpgJc5V7dFuBZy3QyVMjmoIK1dXMBk/QWPJRSrznZw
 gKwJexb9hKdpD1MKpoCCIAKq5elgTvIivUCtr6bQcBdLBvj4Kli2KuB/MXGlr4e7RWhU
 UmpqubzY5OMKzuqQ/meI6PNjLLJ3Phhbhgdym4VgpviWoEveGdHQLUQIwfUh4D48N81n 7A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v7f3a4wqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:22:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTBhqsi018891;
	Fri, 29 Dec 2023 12:22:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p0d869r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:22:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2rhP7lgaNG4ismonyFEtWX1T30qQ1CydxKd1hU1YFdqO6NpDeusWT+oQDgcn+XMqMBvEulfgMYNyup4ean12zkz72Zx3PWiinLlPY1vJyEgE78m6WujaW9P7qJNNoszgWERs66fF4h5euWlR7I/22cXu6M6MRuve2SfsJ4iAkU5vqWlImn0A87bHd+ncYJCDaePI5YfbrhYdlYpRKIKXNVB5irLPS/2q2W11i9efP2rckEqLYs5BVnLGm26SP3bFXsGXvg94Ooq/4Ew4QndD4Ft42FAGYzjv3xSMSK1wEHYBRBrfdlTJE7xMkNeYvTBjUakuruE7prfVuVyfw497w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppQ2C0H4XQlmdUl+patWgKSEEnl80hSU4J07iJxVUQ0=;
 b=JAVUZNho/zGVroIRoaGvbJ0sgN/LnjV+SC6gLMO8hdyJTPqf21ehPX8z/oEWUEJJQaEEiOjM2SgtcNowKvStEogUPL6IEOTiI2Nxho13Bs43B4OUqpq/urxzTtNRARS96fZ8GiKUmDCiggzMJmmNmxzXDFzU+9eTN18///vzJh372kLE2mZquD/HDr5SgEHAnJaNKQ2/AykxV9wgTY/nOfuZG2iWpA+E/Fn6dh1O7aErX/6JmhhTUx5vnIrdP8YKTanUsXtDUR/Ik2N0kCxC5Wam91IVej33YFCWMYSiYS9Wx8vgNLo8n7OalnufLQsfXGtXyp4cv282qdPvvRVSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppQ2C0H4XQlmdUl+patWgKSEEnl80hSU4J07iJxVUQ0=;
 b=DZUmq6yvy5ozV+Hv4CH9X3umiV+phH/3nPbnkJivfIl8DxdiqqsyrYtaCp3EaHDcpnV8Ab+h+fZEAcz4WziTQXCwiyi+PMfceXTocBXMz0xtm6cb2BZBEfeVVQaTX+6H1VPZ9FJ6+oISHf98Ixv4iUPH0wcPWf+xkhBVF+hlX34=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 12:22:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:22:56 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: [PATCH v7 0/10] fstests: add tests for btrfs' raid-stripe-tree feature
Date: Fri, 29 Dec 2023 17:52:40 +0530
Message-Id: <cover.1703838752.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0228.apcprd06.prod.outlook.com
 (2603:1096:4:68::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2c5440-6d5f-4395-db4b-08dc0868e37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ft025IV23PinGT9EcumNy4fCGQP6hhoK8MTZx1DCxAXGkWz3N3ufNFmwYphZscNVG/3KBeXMhGldr6Aq5iEBnJ/KqNfyem4nBUIYkeCbv2JbsjSXm+mqZ9D+m6V9IPXDNYuFEI+DVxh4H16ngTu6n/5blDkWW7relnknG+HdJLuARJNwBf9J4nx34aUs1i7V7Wm6nrLFRDcFF93RPWVALnz2bMh5D1o/YF4khtDCCev5dL5XfpQ/cS3QC9yM9EyJLssC4IEtFRIgi3JF575tyP1954c9rB4bx6qYAsHw/cIIwfYa/x8eEz8ZkA4wRc4ZGr+y4QX7A6JVowedu3AyMLBdI1i1rKlJmhrWhnIv/gFBhZl1j0KnWeD1saVhmjEBUqNe4EgTKhCr8hYmX6a2YX5IGwQW7xajHHvbtE/9PzKqdzJ4NnrpOOPnFpeim3RSwd5HPmC/tEC8W5YOkcKwUd2wwt+9xBsc7FngKSOOd3MbYM3kaEDw+Ng08vbiqKFTw1uVL9sawMScTL/AZNq3kR7tJsd9NE/gxT4OfCWGhIo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(2616005)(26005)(44832011)(8676002)(8936002)(5660300002)(2906002)(6486002)(966005)(6512007)(6506007)(6666004)(478600001)(66476007)(66556008)(66946007)(316002)(6916009)(41300700001)(38100700002)(83380400001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TBcGPDFd13MHxHNw/1mUwNFE4rAo9iXd5OTXplcHWPdL4QnMnVEWH6tkc2si?=
 =?us-ascii?Q?IthsU5iI/6XrLFfXJ5BMR8evMuv+8zWYMTwXDcLCCMRzq1dMTuhk2dTKnrPd?=
 =?us-ascii?Q?DdCWZgYK42B8a+jZYP2u82hl3IQrhkCYcpFqNk0HmtfHTFk0BPmJhA4bpZ3j?=
 =?us-ascii?Q?IuTyAxV8up3O34GQFs+oNbENIsFXYOX5W/av+SeM1gLCYuyxqG+6Bhv9aKYi?=
 =?us-ascii?Q?IoJlo4kYO3u/GeVH2KtZ7XIaOtUDPjtGPxwysGzy2WaQbItWoE/KXp1yS9qU?=
 =?us-ascii?Q?TLgAm/2iWOupBgE4bb4Yq+isF7n9bhD8sTzP34XnOPTGMpb74Fa21B/FdAMi?=
 =?us-ascii?Q?KQqtxltOIT4Xes7WcRiC0NQKi+dwL/JbpdLIktCxAISdlPgxLy8l4PaxWHgb?=
 =?us-ascii?Q?voZ2jbFW3lS9u8+MCqcZooZrB1jTfbj+SjDRPytJR0wF5sWcdTX67B9e58MX?=
 =?us-ascii?Q?u/1eXl+J10A+RC5hqdMGa9wKXC5JgRWlVfq6dOCzXQd7HxyPGY/YSDY7ycJP?=
 =?us-ascii?Q?u5HAxcCg6yV942+l+65T2g+1CUCzEd45pKjf84STVxz0FwtjFofB/ldO0ypU?=
 =?us-ascii?Q?upl6AnsWsiE7qG+yGGGI44eoYF52sUVE92D/9OZBlUTD7vu9NNtrJHj3Vckt?=
 =?us-ascii?Q?GLJCCAOL3+sCdWm6WR7X6QpHX6Xr2dpJ8AV2iQN5xK6oiqIB45rQ6fQYBIXB?=
 =?us-ascii?Q?7jJmirFf6h33bbKmoFVNZg3XzA9ctJ1z/k6FtQYG4QF88De9OU0IBzlXOLwL?=
 =?us-ascii?Q?pa4RGIUPXZJIOxDWDBSaDmcsP34/niLm0npQyZW2r7VtD9cwRCUG8uJoU1M/?=
 =?us-ascii?Q?Z/j67U06opT+7Ge393zM31jZxbhrw28TQ3Ebo7c7BzaQT6aimqx5Ld8t7mbc?=
 =?us-ascii?Q?NHtpgrBfUf8G63fY7Ir6XLrp3KI1l2miCOoaH/UkeMebDEGt+qBQaZqen05Y?=
 =?us-ascii?Q?5nezxVN6pIxQFflDE0BxCMY/JovxGQdsRUpBssf9Hp/wNHSNiKtwJNwehnuy?=
 =?us-ascii?Q?UT+KwwIcqI4iaGZTJmlKCEv2MaJmP4Ak2TyU8/BnL0aGBdC0JfgTL9kc5Psq?=
 =?us-ascii?Q?2kQrCXVJRPoyCu3WQMH5nlmrUmYiEmaO4z+ylpT5d1d4hqLrF6RSN58NZsGm?=
 =?us-ascii?Q?sadSrpQvqImK7Ilyl6DT+B6/354Go/cdeOlDsc5uXSWa/APlkjSSWGMDpQKd?=
 =?us-ascii?Q?19C4sxunUfcnk8H0sDcgoQz/taXptGlseT9RYycB77Z27lNYFMeKUTTFi4XW?=
 =?us-ascii?Q?HcGodN4kTukrlaQRKM34Q+s6KThI+KBfIz3ghS6qUDACISscsHy6c+cQj11b?=
 =?us-ascii?Q?5kEwiEe5pfTCwSH873ZDSMXojZlSHyiV2z7IayikJnsxki0zKibo2XzW9rPR?=
 =?us-ascii?Q?Oy8uuMmgUvYKt1Abql3N8OVOyQDyxedVbHZ38DqOQ3Nc/++0xznWcL07jQ/A?=
 =?us-ascii?Q?BQWXQgcWVC1sucYoXPmHdEk0vyYD7vdtv9Kn/KPnqkazO/13TaWBVVNsNFQ0?=
 =?us-ascii?Q?HUOhOqWFAw9wxG2P5E3KlB7bMeU3s91TuN59mtEdMVrfAn4lsNtYVrF8/lri?=
 =?us-ascii?Q?lQ2j/v7y5S93/Eyf5mYgNWlJ+lW6MitbvBwdEJTf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ukGTcloYmrxwQd1imrHw5FH1SxLNfGTiCahtn2C4B7IVYDyNuWX7M3R9hCveNYsWZ3eaX6G7BeMI5s696V73dpjTt0zpOQuIWCKPPS6APZ6y+yVg5m5kT7OmflM1SSk3Xmb2JQdXTFsGX30BsfrjSmJKp9B0CjCMyng+OTqqyF50iWfUgy9OH1DsOWTqiHHJ84ZpVogSR/RzEjIfX1Jv/VkTpl35Q1y+9brgpSdivT8vwSl6Mf19IVm9LZU67qSHsDL6CDYsID/OaKtVm4qnEE9TysHgrrG7pGaqwgOKB8uOaCKVu+NbBzk2CRPA3JBergLqytC+IRH1YDXNOCUlM4wufg/owS9/dPsIucs8ZHHXESsVCqgINYPiezhtMfXIKnp8I7ZtdvJYk+eLQUkhcO0WILr8I3skwTl/bknUlHmQTi7w6jzy0gFDfIWIPPfELqKfsIy/gslO6QsxYpXRaCuC98m7LHPoxGj02bLhzRAWdoDSOBPZdJ45rFf2E956NvnhPY9zesnYpLsCzqhlttC/G3DO/TbSOfcuHYCJYtmWe/w5ZOcRG9XmmLx+s/qAdWuwwMEt3cqR5dxwvgvW46qsYmQtR59ee1dU1wc1ctk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2c5440-6d5f-4395-db4b-08dc0868e37c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:22:56.9099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVMr0FZo7taX/XdqwKMLvzNAa2Zk3czu2Fb2t1KMrYz6NTluuxz4fd4QZ6Gj++zBZOPVB/Naj6buhhPYNN2HBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312290098
X-Proofpoint-GUID: brfZtPd1Oea5aDTcwqhGjN08WuKfxhXs
X-Proofpoint-ORIG-GUID: brfZtPd1Oea5aDTcwqhGjN08WuKfxhXs

Changes in v7:
- Fixed trailing whitespace in the .out files
- Fixed the following test statement in 30[4-8]:
     test _get_page_size -eq 4096
- Link to v6: https://lore.kernel.org/r/20231213-btrfs-raid-v6-0-913738861069@wdc.com

--- original cover page from Johannes ----
Add tests for btrfs' raid-stripe-tree feature. All of these test work by
writing a specific pattern to a newly created filesystem and afterwards
using `btrfs inspect-internal -t raid-stripe $SCRATCH_DEV_POOL` to verify
the placement and the layout of the metadata.

The md5sum of each file will be compared as well after a re-mount of the
filesystem.

---
Changes in v6:
- require 4k pagesize for all tests as output depends on page size
- Add Filipe's Reviewed-by
- Link to v5: https://lore.kernel.org/r/20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com

Changes in v5:
- add _require_btrfs_free_space_tree helper and use in tests
- Link to v4: https://lore.kernel.org/r/20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com

Changes in v4:
- add _require_btrfs_no_compress to all tests
- add _require_btrfs_no_nodatacow helper and add to btrfs/308
- add _require_btrfs_feature "free_space_tree" to all tests
- Link to v3: https://lore.kernel.org/r/20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com

Changes in v3:
- added 'raid-stripe-tree' to mkfs options, as only zoned raid gets it
  automatically
- Rename test cases as btrfs/302 and btrfs/303 already exist upstream
- Link to v2: https://lore.kernel.org/r/20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com

Changes in v2:
- Re-ordered series so the newly introduced group is added before the
  tests
- Changes Filipe requested to the tests.
- Link to v1: https://lore.kernel.org/r/20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com

Anand Jain (1):
  common: add _filter_trailing_whitespace

Johannes Thumshirn (9):
  fstests: doc: add new raid-stripe-tree group
  common: add filter for btrfs raid-stripe dump
  common: add _require_btrfs_no_nodatacow helper
  common: add _require_btrfs_free_space_tree
  btrfs: add fstest for stripe-tree metadata with 4k write
  btrfs: add fstest for 8k write spanning two stripes on
    raid-stripe-tree
  btrfs: add fstest for writing to a file at an offset with RST
  btrfs: add fstests to write 128k to a RST filesystem
  btrfs: add fstest for overwriting a file partially with RST

 common/btrfs        |  17 +++++++
 common/filter       |   5 +++
 common/filter.btrfs |  14 ++++++
 doc/group-names.txt |   1 +
 tests/btrfs/304     |  59 ++++++++++++++++++++++++
 tests/btrfs/304.out |  58 ++++++++++++++++++++++++
 tests/btrfs/305     |  64 ++++++++++++++++++++++++++
 tests/btrfs/305.out |  82 ++++++++++++++++++++++++++++++++++
 tests/btrfs/306     |  62 ++++++++++++++++++++++++++
 tests/btrfs/306.out |  75 +++++++++++++++++++++++++++++++
 tests/btrfs/307     |  59 ++++++++++++++++++++++++
 tests/btrfs/307.out |  65 +++++++++++++++++++++++++++
 tests/btrfs/308     |  63 ++++++++++++++++++++++++++
 tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++
 14 files changed, 730 insertions(+)
 create mode 100755 tests/btrfs/304
 create mode 100644 tests/btrfs/304.out
 create mode 100755 tests/btrfs/305
 create mode 100644 tests/btrfs/305.out
 create mode 100755 tests/btrfs/306
 create mode 100644 tests/btrfs/306.out
 create mode 100755 tests/btrfs/307
 create mode 100644 tests/btrfs/307.out
 create mode 100755 tests/btrfs/308
 create mode 100644 tests/btrfs/308.out

-- 
2.39.3


