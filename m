Return-Path: <linux-btrfs+bounces-1212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED61823BE5
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C4F1C24A23
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 05:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6F1CF9B;
	Thu,  4 Jan 2024 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VdHI2pUA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EEcEMGNy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE31CA98;
	Thu,  4 Jan 2024 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404280oQ012406;
	Thu, 4 Jan 2024 05:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ijUAp12V3dDfgQ90I8Rfe+pqOOXv0G+gzWhn96cqsnw=;
 b=VdHI2pUAl56Hmxa86eQIBRdCoVcCqroU38gtKj2g9ziH69ZbzfKXRPnYgkdse28AiJTU
 KEG7D7RUckri7tX9rf5lWy280fv6PJYr+Ze4RRcrNAblpSNo+PtwQT2nHk9EqeAnjG9v
 IWe1UMW0UwcI75cXLqwvbVxNyemWC5WrnzP+UoyinNHmtsB626eQLN5gkWsXMC/0GWtH
 LhaX4dBjXNRENNrDe/I8HsdNkxfnR16wc894IUFc58tHuVtOctkg/JSkeEPCxh4QgltQ
 fSLfd2+b2vWPUbtWmfQ1cZH0jL5UvV2O1SwljTj0kra43yiBkreaP7j2JAV4Daoc2wTy Jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vab3axcgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:48:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4045K01h025378;
	Thu, 4 Jan 2024 05:48:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdpecspnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:48:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWjuGum6avw27UnlcLeEn7awnTZlVD5bFqG2vhkJSLDKDwVDGDlurPzgMVVHa12+jYqQ2xiTgukGnsBIr4aOQgl/4/w4DInEElIaTEMCGnh0aw8EKgKzq6tFKHGVIHtJlPYVHilRftJ26nb3LIyB5LfKWSpzp3/71gMI4cCCW3/R6BbVWrek/iTBDQWaghPkEKSKJg/wBOJkMtUpoDKTrtZojbSfQsN6LCAfuBZLRLzp2jOOZ0UvPgTZoF45sSSv5BGXmZVHUX6u9zZqKtrZHk2lj+7kFY5JgKSNDmqSA/FjQeez6f7XgZYTnWAHPm6Rx106XPAaWya1eVQGusRLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijUAp12V3dDfgQ90I8Rfe+pqOOXv0G+gzWhn96cqsnw=;
 b=iJ10bGjOB98D8zeYaSLB6L+dl8kssW4dDVeK0AGYXTiKeAD67mVBtCGhSGjtdl403vcptKk5QK1D++5tM5n0bhlOtpDHpBDkkHcyVBVz2BUwYRoB3ZoDFmelmPtm/YVQ4gUtzzuEBN9C43w/gChCJIQb2LxLAZdMq4ObxGWD/7wK1i373+0K9pcsXj/wBI3tzMOXDBu2n9KrZkT7kYIXl/okkjx1DDGPPHY23/S7vdhxUYzhr596pJV1AUhhO3o+Ld8Lo0s9KQn80WqGfbJsNczS5ZRlIsjBmna0BtXx+W72gtE68lzgOwPRO2bV8DQ3bIKY0V0HeD6zV5qdDx4ukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijUAp12V3dDfgQ90I8Rfe+pqOOXv0G+gzWhn96cqsnw=;
 b=EEcEMGNyDUVANRnCKYv6nqLuJUQ+PHOk49tFJ/e06+M3B9L7xjW+6ycvzy88zd2UC5lkAxmpy60YcXiWYqjE/P00x/CGL4AiKOGjHewYc2xGax890xtBwk00VftFqwXgcAj1WPiR/v3RhcrG05PJF5O9pmUZHl/6e0804+Ofy5A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 05:48:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 05:48:27 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        fdmanana@kernel.org
Subject: [PATCH v8 0/10] fstests: add tests for btrfs' raid-stripe-tree feature
Date: Thu,  4 Jan 2024 11:18:06 +0530
Message-Id: <cover.1704344811.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac7caf1-12b5-466a-e2da-08dc0ce8c58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fxL1BWAfAo0787gjnpvZgOM4UUjpyyNzJkNadaOhKYvXcm4Uopn1UmY7x3RF3AA9ciZt8Z92cWK4+4cA1tSLDc88uIAYcvmVPFmjGKgsYb5cwPHvTK7sWVPLQknEVzEpQcKRnGPyYwCkg88PkT3NqpMF5wN5lcptcsHxuXXpJr2pmfcsSTT+pVzOK08Od00Qj/hT1FuSU3yeV+0s6CZTnzhgZuErmNzlhzZgGUBJNLA3vKNviJIoHdTmq6L9Iowpu//lPe0XLKhV5HEQuM+4blhl6tZIyG5NX6xCYR9PCl55gzBdA1El/JCX1VmdFVlazdAGWcCavN8ToiwGnTBOnYoa9Hxl8sA9Dh+M3kKG8l4zpdM/ALuEMJKoKniRz5Rexn5122TDabu4x2c9RuDuOTwq+cWwgqytckaOaolsujG0C89lU088rLlJclCE7ahIrb7H3gd08hAYSzJ4wZiqPy8FfZaNhM5n9d+ZFZMy+YvkbBOkwfr0ZmHOnLM1Ym5L0KL/LbkCEjn+etSBR1hQt39FQT6HrFTKvumajVFHHPY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(4326008)(316002)(8936002)(8676002)(66556008)(66476007)(6916009)(66946007)(44832011)(2616005)(26005)(6512007)(83380400001)(41300700001)(38100700002)(36756003)(86362001)(6506007)(6666004)(478600001)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZK5RiG1/TO/dcKPm+bJjrQRCficZ70BvJMbe7N60FTJ4BJjx6F3C5ltrhwTl?=
 =?us-ascii?Q?GKW669bNRZmIay6on9t3VwPOzSsbPFiYuvB0HFJ1a2orfvozByC4HgXWaLNF?=
 =?us-ascii?Q?eBX34wZ/6jSnruMLcMqQ/Y5VfRYZH8HTkbNV16r/DukoKIJkTRmtySc9nuuU?=
 =?us-ascii?Q?5LsCsE7mxMDt2PWtAzLX3VmniHAGMng3LPaKJufYLFBReJ9YWE07pI+RHb/3?=
 =?us-ascii?Q?H2q8jpH4ukPTX2UUOwQfWCLdAycdFRaAsqLDt243USZqdk6MjLlXqXviiftr?=
 =?us-ascii?Q?ocZRHLGzx/g/xCA+Hmy9JLyiMuUoIzaV7hnhTwn+N6hAuAiRYmxMWu/4aXpw?=
 =?us-ascii?Q?37Ds6MohtllKNpRBLsLdbQyr6JacbdQV33Cl5Qm0PusSs+vsdN1UPJnQf97T?=
 =?us-ascii?Q?GqmLf2fGTBtA2xmR8yC0cvtj0LUjlMoMt+X1h6wR8XZ+iu/fS3s3YzkTxG/c?=
 =?us-ascii?Q?PqqEJ2BLb3JQ+09nKKvs8gW9qDgNqe3jQybRabKzf1nGuzL5ijZFTp/T2FOU?=
 =?us-ascii?Q?iemxKTVYiSqLwv7V706kx08YW0101pUZibtBtuh/4irrjK+KRKaAGfnyFKq0?=
 =?us-ascii?Q?qOwKovbQJ4i59Dt4HY9OSvdNpRCxMs+Lcr5Aza0QDR6gv/mqZB8oOziGN1ca?=
 =?us-ascii?Q?suY8mo/qXgXxxuTzt0Iv2mkwg+C5N6/IX6pYngVHajY44lhg/IwS8CoILkuW?=
 =?us-ascii?Q?r5tbdj6bKlGow8iKl17ipV+BazDuS26Q3bg82ENgEw0MtnFqXpW2xi0drQwE?=
 =?us-ascii?Q?UgDu8338k5sXod5yqvUn67nS/AeN1OP1fWfmYCKnzhhF94I4aRXoPqloOCeg?=
 =?us-ascii?Q?G6/L+ybYZOdp8y5dqnd16IgeB9bCz2BMvSz23mt2W4rFw0KP8EaTYjVUoapb?=
 =?us-ascii?Q?TEuzFTp3tvWRSTd9KuZ2F/0bRwQgD7kmG718ga1AenJF/Y2QRd58gjYlSZkU?=
 =?us-ascii?Q?kJRp0f+xRYcruGoXLnYkkvrlYbrKcZe609wTsWt2+dGSLyVBXp2yut7q8f4g?=
 =?us-ascii?Q?+TY4R9u2V8M9e1Kr7HB7NWezsca5uF3KMVcwMGgqEIihDGxoR9kl6gj05HWc?=
 =?us-ascii?Q?3OsFF/Eks+A6/ZMJ355P1b1yvTfB1wE4zBPdov8SS3/CpCMq5uHeTlW+bjOS?=
 =?us-ascii?Q?YdZMNaBcACbDe1mTF/jbV7wUzizQgZg0/mx1gyyw+a2wB1MBovSeuX/hIOVM?=
 =?us-ascii?Q?wDYUq3DWvhBw7sj0zkSK9Mlglff0Rw8qbN6t7RKvyG2zEBBtWQ1Yp24WKdWg?=
 =?us-ascii?Q?aNzyK0zhmosKmjn0gmcVZc14E/orUYs1iUDN3Nq9ZDXRhNTE2GKcpSwCYThv?=
 =?us-ascii?Q?nucVWj0X1gib8GgkPQSaBaBZKrjusCJyOIqYFhPRwSqpiowf01wu7BVCtMHi?=
 =?us-ascii?Q?NFlx7fL1LsW6RsTaPwCkEc6OzqWlNDqnzBGS28GAC05a40gSliQY8YEFlxbB?=
 =?us-ascii?Q?bD/4SHvLoOXEnN0JRnwc4gf22u6sCftri1LpfdbCuzvv0h6EamCbo+1IMgCu?=
 =?us-ascii?Q?LS17oPIikZq4lGe/dhb0cM3E6/By1XKfs3PJ2OmhgMQk0DmL/da6cFq819HJ?=
 =?us-ascii?Q?fBFTUAHJf/sXdEQ6JbK0p5tw/8EplLTi4YEnqyDi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jxGERdmx7M1ILfW2hqnQOnEijBvQuexyuSxGCa2c1uaTfHsH8qsZg15LwxoGWc+9ZtRuSSZXfX6iChZXWjPij7g8s++UJ90X6TPQSkszhiWUTHWm2vuPHXkJFilnka+O9/PUiLK0+NWWK+9RqDH1nBrJEi+asGZRN9XVvNbsh4PtFHDs8kw3da3W/Jn3xYfPwxdy52Zsgzx9i84AFDciK6opTeCW2t1EFIkxpLPSYtqo7y4s1yF7Rgs30kaEIhWXKnnq19yenLLQk6KsESD/TSXAxD6SwCTdV3Klh+z175yKxxnHI4mhiBbKiFaT+o492xq2UI+euAPc9R8EA7PKb/CA8jq7QLRqwLcVBTDX6wXwKQmEDHSb7PvmfM9R9twKfyRkJxa6NYRMn1N5MdG3M3hVoNe6owx0S/IXlkmOugZ68QHRL+6gzliYLwTL0j6QqC8+x4APcwR8/fJKbTiOph0yHaRmbapW4aCN1uyIJEwxIORXmWhxdZ+TlfNNT0DypwDQ2FuG50t8FHZorNqppGM3VZzkYqJcSOqgPxSFVHFZ3ZgSRALa5ulMspU6u4uYrIhCRRtgYtWTlNIse7J7Y6nl1dOXIVVqQUUnD//hhko=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac7caf1-12b5-466a-e2da-08dc0ce8c58c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:48:27.3112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XZHcEtbaeqrfGTBiZu+zXcf8kFAIUdwOtjiM6DFcp2VcuCZ6XQjXS8XNDcJlcuIJApgW8rN8DpZv31i6+R46A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040039
X-Proofpoint-GUID: H1M60ribEogLkS_tTZ4XdEz9UQdMghdm
X-Proofpoint-ORIG-GUID: H1M60ribEogLkS_tTZ4XdEz9UQdMghdm

Changes in v8:
- The RAID stripe tree dump filter has been updated; now, it also handles
  trailing whitespace and version filtering.
- Patches re-ordered.
- Link to v7: https://lore.kernel.org/all/cover.1703838752.git.anand.jain@oracle.com

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

Subject: [PATCH v8 00/10] *** SUBJECT HERE ***

*** BLURB HERE ***

Anand Jain (1):
  common: add _filter_trailing_whitespace

Johannes Thumshirn (9):
  fstests: doc: add new raid-stripe-tree group
  common: add _require_btrfs_no_nodatacow helper
  common: add _require_btrfs_free_space_tree
  common: add filter for btrfs raid-stripe dump
  btrfs: add fstest for stripe-tree metadata with 4k write
  btrfs: add fstest for 8k write spanning two stripes on
    raid-stripe-tree
  btrfs: add fstest for writing to a file at an offset with RST
  btrfs: add fstests to write 128k to a RST filesystem
  btrfs: add fstest for overwriting a file partially with RST

 common/btrfs        |  17 +++++++
 common/filter       |   5 +++
 common/filter.btrfs |  15 +++++++
 doc/group-names.txt |   1 +
 tests/btrfs/304     |  58 ++++++++++++++++++++++++
 tests/btrfs/304.out |  58 ++++++++++++++++++++++++
 tests/btrfs/305     |  63 ++++++++++++++++++++++++++
 tests/btrfs/305.out |  82 ++++++++++++++++++++++++++++++++++
 tests/btrfs/306     |  61 +++++++++++++++++++++++++
 tests/btrfs/306.out |  75 +++++++++++++++++++++++++++++++
 tests/btrfs/307     |  58 ++++++++++++++++++++++++
 tests/btrfs/307.out |  65 +++++++++++++++++++++++++++
 tests/btrfs/308     |  62 ++++++++++++++++++++++++++
 tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++
 14 files changed, 726 insertions(+)
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
2.38.1


