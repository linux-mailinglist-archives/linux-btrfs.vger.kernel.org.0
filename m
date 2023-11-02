Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1A07DF135
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 12:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjKBLbI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 07:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjKBLbG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 07:31:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6FB133;
        Thu,  2 Nov 2023 04:31:04 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A283NN6015629;
        Thu, 2 Nov 2023 11:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ETT3ECnU3VLMCZGwI9susN4oaZNX4CFpMvdIFeHFrf4=;
 b=oxx0lo3OOLrLehF7AfTlS5HKZdftOoJJxdKVyg+9CIB5r66Aa+ORIOW1tfhxA8W+suuA
 rZ2hmDqQ514HtY5dQilu+Ep24Ria0ujOmi7QrQ8x5tFQoBpLPHsYNHz28kVO7x6lTrZC
 pSEZDTDpKK7KTGgaQQdwT3LXvf5EPauu/198lO9+MyPVIUZkdNTYZ8pK28wpwHhcSDhV
 kebQixCuJu3Ds7sgRiW0/01djKkqQkTiMndMdNuZuqPNRsu4ma0/AbPx2Jsj8PAvrpkT
 5o1Enq+A33VPicGXjibSv5ZMmDhRk/RRi3S9WKoSFKpVOzW90WaSRWZBiUB9eQ48vs7m ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7c1fy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:30:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2BEJ9p009117;
        Thu, 2 Nov 2023 11:30:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x89enk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:30:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJ7mjjeR8gJXEZLnYhrqstixohIXdXEWqZ/6F9owd3bxkB03F7sl0nOTCTIY/o1GqfAZBsQjgQKhgynK0h1xaXIZnpwQwlHh9cWpSrhPQ/VLSix5nhlCSBr8uLfOfOprYUfCoiqbdCVLqvwzNsQde47zzsbFaBJ+hGLXa6DF68+7Rg6/g6MNreUK1GNelWLUI0CR6sTKnrBO7D5DlsRtBKeWmrACQqkdvj0uyLkHPdddyMBz4+knvj6LQM4Bwi6XV0Po+UtvYVdJZFd6cYwP+FW7/+wAuck7Dpx/n0tP2MhLGxV7q3Vn4K9S7bgUqNyquUOHzqq2jG0CWtacbKbHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETT3ECnU3VLMCZGwI9susN4oaZNX4CFpMvdIFeHFrf4=;
 b=ByHxTbzjkQEBd1VTBiIjA861f84WRvb11ADrk6yu8tyRNqClfji9c6pUyUPkagjonqU6Ynwan32l46GSw4VPObna1CPyBYN3hepr8Mp+itOKsqwedfJKX8BLiQ0a7eAERjWS4EEfNGSH4GzEivKBjgkxpF4YuEd4ByAq0m5GLvga3Yr1kw4bBanvEYYDYWUrAxR9u9PvRFFTDqvkWCLTay9MLOeirEGqJQGs2ZWue4WFmt61DjJz+aviCsQ9g5Wci6tgZ7zZ7EfDXt7KIa3kmdQlBMS5+rMMjp/tpEmh/DNWUBW886NuMYEj8NfdMH4gNCDn6DFFa78ENXoFN7XEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETT3ECnU3VLMCZGwI9susN4oaZNX4CFpMvdIFeHFrf4=;
 b=f3S0jUxolTxPQBS3KMAig6I5GyGFs+G0xCVFGzcFqLbL1FpAh5NGofdmw1JQX0GMlm45cFtN8+J7fyGNkaLCJRJxat7CuOHEoc+1KLszHq4+Gp9gqYRYV17ZpS8BYtgFs/AKxi2MmjQZwzYDRla9cdY4Sp5Lpd9McHDIiJejwXQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4552.namprd10.prod.outlook.com (2603:10b6:510:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 11:30:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 11:30:56 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org, fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v4 1/5] common/rc: _fs_sysfs_dname fetch fsid using btrfs tool
Date:   Thu,  2 Nov 2023 19:28:18 +0800
Message-ID: <d63c4427d1dc9db3c18a07cb9098459de242fbd3.1698712764.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698712764.git.anand.jain@oracle.com>
References: <cover.1698712764.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 423c55e9-2f35-4e0b-ac6d-08dbdb972df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSRYs1pHreLZZ/vJuiF+NKmrwHFouhJGbKm6i09IHox1nB/D8+hll5H4EItThDiuR2q/jin1iv4PwjO4uypAhRXarPjZ296WSxPfnqGlHiDA7ZlSgNcSa9vPHUewfOrtjyTqEMNyH+5AtXqCWY9dRVkA9+RzYvWJrxLVrYYkQ3O5Kk41AFviOjfTnED6qrFkjuriMx+Sml4usYGwYcaAeXn12YRGKVTGEX2N0T/CUpBUjNuMW5HKHN3LULz53LCRsIZKlhS7fCSPRKjJ9TZFc1OFZU+rRH7S8AzDTpNmE3FS8IxRxmCDg4CpfwgYWuseqZSyONY8kxR+WnIGA+Gxt4HxCA/00u/j7YJfSufSeD9XWZjTt0RJA1HJpHq/DzcTACyIo0yZPvd814OHQtt8BwnxUC+E64zKD53LDY5dDCYEhgIbkpAwubRdjVDEOuqx+C2fvObwd/QEmsVdXVC8p6SJVWeNDANKN5AkZfpxQuSZBZpnbUaFqxt0hgiutKl9jR96zKCwBfutnZdMBm0/7ifoSXhIy2LiROdZR/vwPRSRjq9jrulsrjyxF4T/wAtS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(36756003)(86362001)(4744005)(2616005)(478600001)(2906002)(316002)(41300700001)(44832011)(8676002)(4326008)(6666004)(6512007)(8936002)(6506007)(83380400001)(26005)(6486002)(5660300002)(66946007)(66476007)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s1/BQ+sUxcYfu0LDF9U2W/1uPr4IJjLPjLvfSXoNAOxUHG/EDydUZd+UwlCg?=
 =?us-ascii?Q?u/nQEiXTHS9i4ok37g3RcJEzb0UxPCn0A8evK4E4yEAIdRH9wBrBEyZQ7/3p?=
 =?us-ascii?Q?U00DPoNmZDjFF0gFS/fSin1LNqeUgccKi8723BZX7HYxVoDT7uqvCN2WGV4T?=
 =?us-ascii?Q?8bQQxI7BXZ2/QP8vbWJwVH0Q6SX05byYqaQPk/hG5GVvg46NncIeucISX3a6?=
 =?us-ascii?Q?Gzc80g+8KKF7ZM6Jl1oJgcOKjHVpcLv6s3Ur75F1/ieLqLPneYu5BG+b235Z?=
 =?us-ascii?Q?L3g0fQmsposZt9NffV3Mt/ZVmis9o1hh5eJ2fZd/vPlYlKez1akGdZWy8wGh?=
 =?us-ascii?Q?jju3YtN7eDraYVY4n8UNzOu4HX9eJrZxKCwNEhT/+7uItFPFKgt76QqARqP9?=
 =?us-ascii?Q?FlQbmQhBHjJu6qDsQsnXNyNwCz2qPtoyA4Md3WnAu9fUZMUQe5vRz8ti3Qa0?=
 =?us-ascii?Q?dT4CBm0880iRbrkJCPz3MV7CEjHgxssy9DUdL9GtUb9jxNrN5QBn2PsHUQAR?=
 =?us-ascii?Q?NDVhk6AePQ5g4JYFveTpxaE7vH1DGhX1bYcaFTIFwfMucqRtPUtT7/YA119Z?=
 =?us-ascii?Q?jL7b4+rk/ivnVMAyOMyxusPITZZbBLQpsVCsJNK2H5HJx/i4jdJ0cAcg4roP?=
 =?us-ascii?Q?QzZSww9Rs5qk8Bw1tSk20tgorqV9EyDiHwPNo1PYzOtngMmnKOBR3sD2Xymr?=
 =?us-ascii?Q?w5cOBPsJtlq5azYZ73A2By1iEDgjKng2Xry1B1M1jCSgCT5pJGjopUhyXOCs?=
 =?us-ascii?Q?W2E4lLqbtQUmTMjdxcK93MModtIqAM573sUCuHiPymKsdoM9Nd5tjPKwsqsw?=
 =?us-ascii?Q?YlnbYgTGybm+ohgWcwuIMD2TUrj1Aft8NtJJazXRcw95ZiApBk7Hvdrgatif?=
 =?us-ascii?Q?oxgBpn5XxFEMxxEvEgfNtgv64Qg2dmvD2RFV4D0xe4/GQoKJvLdj4U+fuYxp?=
 =?us-ascii?Q?kSvyJjn1TOh9KXlXMIlEIY3ehR0oWjSp3g8I3NypzLi9KO7iFZ+AYutPkObc?=
 =?us-ascii?Q?nht8V352fVLtAPcEbfxoTzZpvgMzv/OkT6t0HPJtsNaFVu74XNTPaTGHCM20?=
 =?us-ascii?Q?bK8Zi4vd/98J+F0E0+huaGrmdIEbOsfw3ovTaWbCvO+hHtXkYQA4fQ3w2Hb+?=
 =?us-ascii?Q?6ZVQnktvI6tIdapQORicqy18/M75fS5Cyf4L9J+5ZT1BSUAyfYO7nFtez0Dx?=
 =?us-ascii?Q?4FMS0EJT13J2ZN5s0DmS7AwxZLoUWOBNDmae9wNI/G7XiBbYbeNw0DRD/pEv?=
 =?us-ascii?Q?hbIx9ecUkYV40r1xqpmZeLtmd9zyVyciw6k1nuBYW6MWT5SrTczG4qgaEkeO?=
 =?us-ascii?Q?upWpAb//HSYcmeuVe1FQCsyi/iX098gzrYiMJSm69xVMhfxNVfHT/5Zo//FB?=
 =?us-ascii?Q?kPa1yvgOrdPdhzisjTxXiRKUxahmLCP66r6tteMwGyybpxMizf0AbcnHNWB0?=
 =?us-ascii?Q?f7Sk1tUa1Ja4WuNfDudcdhElLUP+1/sfGPblH9k4WmQUW2S1jwq0+Nya7uZM?=
 =?us-ascii?Q?kuu0g+pjDvor877oqjaeWcf+obmklpoE9end4Sh3exgoLDbREp+xTQIob6XX?=
 =?us-ascii?Q?cuPPFAB59kqpJF+LeahZKIrKql1NGresm4mlFU2c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6fHI/rGsa2qa4qkGdxI3gWEAXffAF7lDOL7Ooc/vOkiLVJ8ELGTxV6wJvfD5E3H/V0IpVOm3wsyPQU0RB+BxMMOaAti1pheYlqd/w0hc11D8XD0tny08hpUTOgSZOnuK/CCuTy6pRLZ5wyW34jmwSix967jI/QYc9YUnCtc8r3W2qzjm0v1+kv+O3MmqCRTJdw+fndxxZl5+/0Ip46k4juRF4IhD/24JdYt0b69dn6FNPYLaAJR0EaLDBm6eZSclEFcYil7E6TDzKSqdZzTxFIGkziBNsF5vNLAxoFLdDAhq16/kGRzCrjcusPXmMw8GeQvdaCXRF3yZfIfAuNxlzEaZpDWUllg4TXrmlX7Lwz7+UDvgrZTD4pmdhRkkvjwrJxxxK1lq+LlQdwjOh7Ghu8qnNYPw5st6Ci2Rx/8Vz3K5fU5LZGFlKiKcxdTrjNrC3Qc1qBmjSuMY3y+rKECPPVMy3sejF3aVBqpwK26ct5PJho85a2jjBXPFuDk0AC7C0CQPUGE7zZ0aDg3qgknG4XLAg/FJCTuSLygNjxA6oD+AP5y063EIj1/rUKWG7UPf/XPKDKaLBtkWvf6KrYiD1MOTQeULakzr2c/rRb9hKbr8yHx5QXDU/xta7lZvD4HM0uMhvT0Q8A7eAjy9Sp0ZD2/RyfQFIAl78aoZCHpGSyxiLXQ8pSx83L8zmajM/GXT8/0MMqUsRXntxPMDKym2ZgOHXV9CqYAJ8WaRqM28WcQX4LMoV52r9/W6Ia5BMwxltUbXI9jf18g7wTNsotgzIoqF/1NQLhowcUI587IRkHA67MRB2Fu46YQoNGqvimQR
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423c55e9-2f35-4e0b-ac6d-08dbdb972df9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:30:56.1890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANByid3Q+JX8t+XwgPtEWXAqv4uxYXDtJWVv/Nzco76vXgPmllFatdLJ10n6VtvpTptPOc1uXsRsj9jlkxCfFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020092
X-Proofpoint-GUID: oKLW1fPckWMEkSfNSJDGfMIBgumEgzUJ
X-Proofpoint-ORIG-GUID: oKLW1fPckWMEkSfNSJDGfMIBgumEgzUJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently _fs_sysfs_dname gets fsid from the findmnt command however
this command provides the metadata_uuid if the device is mounted with
temp-fsid. So instead, use btrfs filesystem show command to know the fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
v3: add local variable fsid

 common/rc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 259a1ffb09b9..7f14c19ca89e 100644
--- a/common/rc
+++ b/common/rc
@@ -4721,6 +4721,7 @@ _require_statx()
 _fs_sysfs_dname()
 {
 	local dev=$1
+	local fsid
 
 	if [ ! -b "$dev" ]; then
 		_fail "Usage: _fs_sysfs_dname <mounted_device>"
@@ -4728,7 +4729,9 @@ _fs_sysfs_dname()
 
 	case "$FSTYP" in
 	btrfs)
-		findmnt -n -o UUID ${dev} ;;
+		fsid=$($BTRFS_UTIL_PROG filesystem show ${dev} | grep uuid: | \
+							$AWK_PROG '{print $NF}')
+		echo $fsid ;;
 	*)
 		_short_dev $dev ;;
 	esac
-- 
2.31.1

