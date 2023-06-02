Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA5720085
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjFBLjK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 07:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjFBLjJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 07:39:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168CF1AE;
        Fri,  2 Jun 2023 04:39:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351NtqQB021203;
        Fri, 2 Jun 2023 11:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=F4d8253nED/NG36l9euRnBa5+vw09sZcaEXIyNqGW2Q=;
 b=f4K/Jx4uaHOaiu5lqg0lf4S4OWKmT+vpWBsKkhL5gkC0C6HcpbvQRr84vVM69buUvIOF
 qJT/A7R+2Zr3vtSfUx6PgsHr8kCDCBA6GkhMoVV7VBZ9d4OG3yDMIAnaNPU9UopILbTs
 IUw8eTrL+LzLnxojjXyI/UOpeolDmC5uDyMw2Z/vQdAgz5f8mZc0ZYF4O+0pNLwTA5r5
 0oMLbtvmvfYOL8iPVbwtxnYvWPjYg3NUkbFhsZVtfcUy9VTKQjTxBOG/CHpdhUPJBsml
 DYePH52PQKWhR8WKagrN7HaHJRgS/t/x/jzlCtt1crubIFThWvW4guE6h4pUoP5+4mjE PA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb9ar9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 11:39:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3529IrZg004438;
        Fri, 2 Jun 2023 11:39:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4yg42kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 11:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mer6fhUgLVsidisdRGVhoWh70F2V/OTdBPGEQA6Evw9hBJoC5jwQfaOjaSQqaH5dWQjIY8eIF0nAhLxJPMSYpzhzyfExlwoZJSVtrRgznM3AtYHHlqBZKXkMx2wJRRvCk5CgLwJMIUKVEXu/xtv6u8AelbraGe8GRhFG9OM4/jHzQFO0UYauwYmhF/F1701QeaGOdGaWOiphbSk8ClkRE7lEp3TfO7TjxSqSZFai1n4WFymWSZ3zoO3f/dV3Edvz9byBFz50iT0Van4kaueSsCDEOBy0jDiBhnLWXJ4wHr5y6cyqQXE6Rl4vIvdrpb1C8mUOyA37kwoionPYZaGEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4d8253nED/NG36l9euRnBa5+vw09sZcaEXIyNqGW2Q=;
 b=KG4uQcCK3COV7EWmOWKcP78zMsPr0fDDAvPLsL7XKuAiKX0O6C8+IvXr66YxjBtevMh1Qh3ULOXYXO1Oz1BQw0CWWitLpNaMsEix8BU+Wj+IXK8tKHfM3rbbSNAC17h/5h+cm85DX72wuQJy56CICVHCzjmDni9bOfbzl0HpidaXKiS/UYRvFVpKANYE6EPgnxhJf0evuaCl1YYUZPNeDJVfnGFhEoscJTA/S1ga/Vs4gRox9aGqBpRe9K42/xCPescPjHWjmdYOxxOLL4xFQtHxgeldbvwPvkhBtWhZg5KamyPLgM5ypURIxiEv/Xz4ntFcYREKxAouuIFo+D5cOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4d8253nED/NG36l9euRnBa5+vw09sZcaEXIyNqGW2Q=;
 b=Ge7+fwxtZ/a2oqnOzipKzXTQbTAeOQxlBsTlLU+IEoOK+DE6Q5r5tOtW54FfWbvLCpWif1bNFGjHQwGBrVwZvXkQHAYOboTGfarpL5rRdo0TSKnat+tSGj7+H9UfgIFJTBUDg+KO3+7ukcBewwttcYXWLsEHSTPhJDm/VcdpFy8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB7238.namprd10.prod.outlook.com (2603:10b6:208:3f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 11:39:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 11:39:02 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs/122: fix nodesize option in mfks.btrfs
Date:   Fri,  2 Jun 2023 19:38:54 +0800
Message-Id: <a45349aa46e0b185acf59f3914e78dce245bb696.1685705269.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <04c928cb434dae18eb4d4c2745847ed67dc3b213.1685365902.git.anand.jain@oracle.com>
References: <04c928cb434dae18eb4d4c2745847ed67dc3b213.1685365902.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: b69bb732-429a-458e-a6f8-08db635df694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vzkBj/QNbzirt51U6D2BZo+KYiEWueE9AUKCxlHKiTSk38PvehC0U44vdOPwzuoTMj1ZcluMimMvjk+cnV6xganAIgVlO8kIDE/1CUmn8uEgJE50CLWr6PwW1F47CpeBnrX3zglFAMfA4FQQj9WckCgf5NlLFNEOg2b9P0mhkDOgV62Y0dprHpLidHbmdPBtKnRcg8Nfzy7yZeXFu6YROJilvZt3f0L0fdinw/iqL1XRBw6zPtdm0ptVYpI3jY4sXayDSlrdoR9OG+hAKM4eXEiS1k43bfCh/N2IuMJTkq+TV5pTLTpxKVoNZsUyBHNlqOUh1Fe2q6+I1aMdU0//it+Y+fd+LDNFKcozuGAWrioThW1vp3ZBWOWFFDtjAkTajeU8Oh1JXlaio/f6W+TcgooTxWMpdF9B0oQ/lzCKN5YT7yE8KCNyL1pQoQxMIg1lnmikMtO1so2X/Tiujxb6cMJgHHV4qj6kUhj45O/d0XL5X+6XDfmh7l4+17ViPlwBPpt4QU5Yr7aRhc42PA//Uo1TBEzkF6S241VV4ojvZyLK9OH2rMQj5e6fOYNOeU1L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(26005)(478600001)(8676002)(8936002)(38100700002)(44832011)(450100002)(66476007)(66556008)(66946007)(6506007)(6512007)(6916009)(4326008)(86362001)(2616005)(316002)(6666004)(5660300002)(186003)(6486002)(36756003)(41300700001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rp53AwwVNIOLJtswKY/dkztusdKzaIt4ZkTyQS0ji49fqKqkXSk16DI93yyr?=
 =?us-ascii?Q?vjgdHKvO5LXfYJhbc4If8oeeLOxQz725Mb5rrZjhteHHou0vu88hoH2ufWS/?=
 =?us-ascii?Q?24fjOf4+los1jQBCxL6vkZlfXpfKiRFfHjkbQcxL70KgLCWDHIcKPfUaeHkw?=
 =?us-ascii?Q?xZoGk/j1p13Fo2YzcSAUr41DGE7xW2g2J19Kyuj1X9bOrNNIB0HJG/XyjaHo?=
 =?us-ascii?Q?0uiwlZ+5uHFO2R6ZTfA+fSYhn1sPS6DBaFzwiaBGAH75b9QRz8pzWrk+Yw/4?=
 =?us-ascii?Q?lPGOnMkX7Cr6kqhxu3zEQokxiBvz6/xZ0yt7JxsXOtcijy3a2vGiWvtl/UX5?=
 =?us-ascii?Q?MpdRBR6OzVDWpILbPLFET8FuJJ+r79Nagm49+jFdTaBCUySXmO9/+eqEVh6Q?=
 =?us-ascii?Q?wA1zj60uoGfqTwESuf+ZVqK4ouMI/PacHvjxK0Lv6RM7TOFr5IYB5GH2F/Oo?=
 =?us-ascii?Q?psBkqeFRDNlW4+fiX6ud8f2U8cWKZXxe2Kr9x43x9SOJbsCO7ptVDjOrPqZY?=
 =?us-ascii?Q?uX0KnDGm0qiGc3SlPJHLGz1OtH/g4Gibrsr5qHApQij5DKEWEFuK4NxT7Bta?=
 =?us-ascii?Q?0djMs6eWtzTf5HZihiS3zlJmYaqcF5m+X4G0e4dESxYeL294MriH0d4IqF0+?=
 =?us-ascii?Q?Fl/v5TaHwerfp54i+lr9a6xsna6Fg8TJqT4oV989a8fuXPIHgBbJLxW1j9La?=
 =?us-ascii?Q?Vq1Qfy5WngJ9eq8wFKjbAzSYiCI3N/c96xqEXRSr4J5VemYYnnTKQFLQ2N/x?=
 =?us-ascii?Q?XTEO/pL7Ymkf/J53q6/Z8CSdQqjofNzu1v0Pg9Ox9vTKNqFSMEaL57IZLtKg?=
 =?us-ascii?Q?D/e2KccMLIMz+JaXyYCwGdjjPNULwMeyR8ny9z+Rze5Rh9AlKWsocgSsQ5ZF?=
 =?us-ascii?Q?ME1wy30Io5cnP7AsiPqjRMN6t/KJ6gdTseTf6yQMHnQF+vwRgnmU2A/5j5ei?=
 =?us-ascii?Q?WkLsvfbMouiADOY4bnm6Gf/3b0wPHAJLm21gcDAD2vUrh3cZvM8skaE0eHJb?=
 =?us-ascii?Q?FRtNaB1+IwCtHqOwbehPWNmTslsfMnGAHRLMYZ86cU5eH2raa7+V0A3OTglG?=
 =?us-ascii?Q?vsMUNM/CHraGD4OPaZzM390R5STK0bDOX2SugfSLeUHzwqtGQwFwSEkMH4f3?=
 =?us-ascii?Q?f0F7TB5JL4KD17GX4CaAUfiWzTYDhISCBjA/v/9HOTsacCe/EF5B3rzMsrgY?=
 =?us-ascii?Q?0CVhYDfEYll1H215wDw3doalNWQ/dWOhHwc3949kET0ZZLPZEJf2j00uVYs5?=
 =?us-ascii?Q?mOf3Wd9a8zOddqePN0rFEcaDObFh00FJ7sRtAb+1EjeqZVCSzGJ6PPen9tuJ?=
 =?us-ascii?Q?+7q9tyODJQr68+h2bprY46wPeFHoterJ+G4Ab/gL/Bt1fEEcPnIAoSJ6t6Pk?=
 =?us-ascii?Q?SWc98+wlldR85y8Ihs+SQeW5pPIsrK1itrP4fL43iQsAM+fvQXtItmqs7/UY?=
 =?us-ascii?Q?MxcVKlJsGNhdk10ey1DI4OyFEtVL3ouZh2F6Jk7sN3tPHG0WrGDULz6QpM0A?=
 =?us-ascii?Q?qQejBdBU1wXcTv6OmlS5BaeGIblZbUic8pO2fM738C5+kCYpHi0Al1IzwN8F?=
 =?us-ascii?Q?q0XWoU/mRmgVKu+Y1VjE+b2wsLMlX1W3BhCgyPaPEyXJ/9pjJXkbj//OK8YH?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O7f3JzyJpU+N3/sVOi8qmskMHC5c5EEBFKZS+QjbVnAGn6H6m66XAn5T4U+ouGFaqDpFoUQSeay9a2iAQ6EJcZel4rtZ5WGY5zMcFbBqEPVze4s1r/uU8Sg8ol8HsBwaCIsDUpKWs2AX+fGrGa/fRwYEQZpsQ+ko/mI1tQvNjXzBGvS4CMYOHewk5biqleLmpu9wS3ImlDuWXSXDo+m+0peFmEvz7qxDzMnnudsj1FItCI2RdGjNCAcABTxoARTMKgBnhhoWNIe/N/qHSSj1bKIZ1Vs2MuRrfia1eopQmgnrzLUbR3lIgmUeI1HIodnPd9ovG9w678LNGluiJhOYfsfok54QrJJBfFdfw+3NV8bu3BqQ+BXVMzoHWN00BqgB6xtvTyMMq1Hhp+2o/n+StyNe7q51VDfEKaySTF/HCJtiE7wusyIz0xJDfMf470wM/W1WJxg3xSkR0hCi0QAUNwoucW38XFBX63oxw/sx825xDIJW7giZQnbB+Ceo6346AQ6QUfztJUo2G4QUkGJ4v6/DddblJKCA+pAZFN8t0yyQbd6u82NgORhvvG5/MMfQkQiP/RWTPP+lnL2zeHQPZI/0gCNgaavRgIkV1lH46kdR6qYydTa2aIPXJgAo9TadpMuj2Hgn6MjlfLMTsmsPytTXIVRWkG5ORi/bgjq29RVGTexWWLr8vImBBHdLI5XqO87elvIEHUBjcw0rDJGDENakSbAUjplG9r/KZ2K9+tOcQJI8jXBVv28y3XL24Mi1RQ9NYdFT8WTZfTDrhkGtWw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69bb732-429a-458e-a6f8-08db635df694
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 11:39:02.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzxtJrYMlCmOo2KhnUFOM4ltrk0Cg6OKa7IqNAqfp8pt7MbW7TpY/DuyUv/NsOHMU7fIrKrRAaD85UEJsuujeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020087
X-Proofpoint-GUID: KhaHXkKWJK_wwwN9in-xjt4b1tbdbHvl
X-Proofpoint-ORIG-GUID: KhaHXkKWJK_wwwN9in-xjt4b1tbdbHvl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrf/122 is failing on a system with 64k page size:

     QA output created by 122
    +ERROR: illegal nodesize 16384 (smaller than 65536)
    +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/vdb2, missing codepage or helper program, or other error.
    +mount /dev/vdb2 /mnt/scratch failed
    +(see /xfstests-dev/results//btrfs/122.full for details)

Mkfs.btrfs sets the default node size to 16K when the sector size is less
than 16K, and it matches the sector size when it's greater than 16K.
So, there's no need to explicitly set it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Remove the redundant explicit nodesize option from mkfs.btrfs.
    Changed: Title from "btrfs/122: adjust nodesize to match pagesize"
    

 tests/btrfs/122 | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/btrfs/122 b/tests/btrfs/122
index 345317536f40..9d5e9efccec7 100755
--- a/tests/btrfs/122
+++ b/tests/btrfs/122
@@ -18,9 +18,7 @@ _supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
 
-# Force a small leaf size to make it easier to blow out our root
-# subvolume tree
-_scratch_mkfs "--nodesize 16384" >/dev/null
+_scratch_mkfs >> $seqres.full || _fail "mkfs failed"
 _scratch_mount
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
 
-- 
2.38.1

