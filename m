Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911C07DF136
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 12:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376270AbjKBLbV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 07:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344733AbjKBLbU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 07:31:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6B3131;
        Thu,  2 Nov 2023 04:31:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A282hAp023642;
        Thu, 2 Nov 2023 11:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=zBkz+63hNoVtfNsH7p9MY4VqutBIuVr3zNb4l8C4EmI=;
 b=xjr+RsHLjRlh1o2yGjGJjZKw2Kz4McyBfumGT2nmHxVkRw3S7dGtgWf95bK7CfAzzXEF
 4X1W/LJX+FoWOvFWj5L7nuNAOFqW7Z8riV33bdePhssOcIsfpK5Ok31hlB5r4Tz1EMEx
 kDZQ8W0/isyA9KRsmYUXAu9fLbywqWZ2yc9qxqINxCwu4tycrHIhpmiY/24xZP9/KJ1s
 S8TgAmzXvoy6VbrmkwzN7e5fvcW3luDaJU2nBJRyGic43KQlkgvJrQXjgId9G/o2HwDM
 HNys8nXf9jJFSA9ZDUeHJb+rAWPoaOUV75xnWwhFrAKauk9r1fbpIjhiPEkHE2yrmGoA YQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rw29etc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:31:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2AVBXT009166;
        Thu, 2 Nov 2023 11:31:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x89ewy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:31:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaJpCKR4iJCUA4NHnlpYuWVtZWwt+J//EtiBkRM67iM2ziT47MzZZOo9uX6jBdseJLnEYDbwKrvM5OE9hOxkWZwZKAy1NDuWySa6zlNa+pUWixTTddA8cZiMtY+iV/gKnPwB3DU4BTLIkgPAReicz0Q85mEqQRqJ0ChUUcVvvEbv3GclgdODF+OWz/RlvAChGXdZDAgTsQjiBrYHRsTAkTUZLJ68W8DHc07c/8GVHfCdYosjq/HWYw3ppOTH7biTmb+N1T0n4zWoho0B9hQo0DjaVeMpsVS8UUh3DLTRJU//nqSM+FKco9C9s1H4q/FLIzKeox83UrkUMY/WJuheCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBkz+63hNoVtfNsH7p9MY4VqutBIuVr3zNb4l8C4EmI=;
 b=l6HFDoiKl4fADlPAAQoks/74sylVxNfVSFnf58J08EVEGpbX5bsGPM7PlYvRPooJWJ8T6VGFC31imA/HgcjzTBbSFQpQ8YihmTccQZBoKHYYgkqct8me7adTRdP0jUQCjdJPL93Tv7rh5+jE/W2f8FO0TSjUUVs4OW8HwXNfmeJiplIdUZmkm/8Dl+axKPpAgm8I134FW1a3xQpmyT6vHXLkv7OT4GiyvKQh5WojwRaWki6mw7UG4bAA6NEkFzC4AzBap/YTfzEgLbnTPlEWryESp4kdWpKHvaeXOdBlB7WasTCmqFjdOogmK8imrOu7PD1gYYybb2Kiz41Bm4Pm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBkz+63hNoVtfNsH7p9MY4VqutBIuVr3zNb4l8C4EmI=;
 b=XNRxSbVidYeQNUFg59Ten+nGEutt0nEo1lXwywmIAZLfz7a/mTRsBipjkEKODKhiCaOQi+GdhvyPLqKvGR3cILY57zf7UFmPX+C4T4q4XjpSttkYrK5ebbQk9rsUwPVCvN2k/BZhYXvSY0+CGHiRQnLBgU8DTz4m8xioO6Jv6Jk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4552.namprd10.prod.outlook.com (2603:10b6:510:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 11:31:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 11:31:08 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org, fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v4 4/5] btrfs/219: cloned-device mount capability update
Date:   Thu,  2 Nov 2023 19:28:21 +0800
Message-ID: <5261fa17bc666f72fa3d7a5e77ed94872f2fed78.1698712764.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698712764.git.anand.jain@oracle.com>
References: <cover.1698712764.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b36004-2172-47aa-abe7-08dbdb97352c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0Ku9cMY3KPDUUTjvd4NzmyJ5e1sWWOUjPGvwfhG91b1p6k0wuAgUt2OAa/r0ygS2zeXvlqtDLF5DERhv2gLkJG0IMe3knPcVXAO7hG25T+oBTg/NF5/rphAG6TXIs6CPUSmT4uw6l92N/WvM4eQqrvI31v8H/swljb85uSAMOMU0WhkLb8VCw63hDKKXWEP6IxhRUKX+6TaiNavW/nDdGMaCviv96Et61fbA07Ev7SaPoc643CsXua+eN9ALwXOo9O0EftUJvjF0bde745+QPMIZjb/NZYnMdf5dOT/LCyB03kqcaeV+n0AATLx4I2v06A8moBUxxhapnVLWOfIm6Yo3whX+/AZX/Qa9Sb5acNQJeB8BigTIbie9exqQO7/c4JiTKy3bneEmdq6KVUxhk+o+xIm4fUbjq7VS2p5vdV79SsKyWFXMr1g5mllN/UzDOh9qyyluLtYU0IB7YA1PB6TpQE7X+AAj1zHq29cri+88M6xStgRtL9v5oOFrnl1C/8eVxC0z4P1o/TdsPT/Lh1ezP8ojVzu50Gy5qtNEA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(36756003)(86362001)(966005)(2616005)(478600001)(2906002)(316002)(41300700001)(44832011)(8676002)(4326008)(6666004)(6512007)(8936002)(6506007)(83380400001)(26005)(6486002)(5660300002)(66946007)(66476007)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sqbDwGNxkvSMNzHyV8aOsGoV6rD/KSA7sesJpEQE2xd0GSCaFO1SxRPyDxIl?=
 =?us-ascii?Q?5wdKijb+GCXS5yovd8OXB2gFWMk5ismKOX3anHKaIrBGBujxNq+X9uGniT5h?=
 =?us-ascii?Q?tL0GQEs8os73gh8mYYSfUnZzdIfOVgwIn3i8Df3R2TrS+IBsxT8Btumlsmpz?=
 =?us-ascii?Q?R22v1LkiyBCyBKHngyzGTe1Rt396Q1+fPZjbrvkdMyawJJGg2QZHq54XZTfG?=
 =?us-ascii?Q?HRXFBgeEGfM2AoK4cM5aT+THQZe3K4QIHY9dHW0WuRgb8yw/W3b+db1JMgTN?=
 =?us-ascii?Q?vxeoSgWv6iW+O926H5PSsaHvMFe2p0564q+d+osrOlzPR+JyI31EXjv1ALJy?=
 =?us-ascii?Q?/C6/OhxvxDgsS/Vw1tBS5iCNDygas61jYWfIyDY4P4cNGQrm8Lh9SsXNPJ/e?=
 =?us-ascii?Q?9c7b/lZUbpym2Zjzasy/MbXM0OowJtjkqR9pJ1luYbgYDRnNF5f+0J1fA9rI?=
 =?us-ascii?Q?HQZcMVyxSwJZUUghPtPDSTBKLNPGRLTqXP136gusFOJIbnxR/GSMtQbeY6xf?=
 =?us-ascii?Q?5ddVimxSSBsO3TqRVodoJeUvGHxAQ9IIYnIyWnjQOm0tJxirP+r7GL7dKpiM?=
 =?us-ascii?Q?b82J/dEdZ8/0ViMVs9XmmjdJ7wP5vWEpJezNETHTvz7E3CYiY86KlRjceOlX?=
 =?us-ascii?Q?kHQT+0tGX+oZacRS9/HO+wqz0ZbnDa4Aq/TDThUA8vWQaHmlOYs/3Jsf7h3c?=
 =?us-ascii?Q?yGef5X/PoP5CQkUOw3MnmuHSl9OrQnyHo3ulJprPoRtxpvqqqvnuDrGCTocU?=
 =?us-ascii?Q?X9snew/VdsKGLgZyAcfd9OyWvblo5oJqEn3zTqZQM3LmbNytDlMSkTbhauor?=
 =?us-ascii?Q?uiQZIGZEJdQR0/ZllbVMT1UPrMl3k3k87Id1i+rAifH8oAJywnuSr/MWw4EB?=
 =?us-ascii?Q?vUNZFYJcPuCdrmKSiJn1RZSnK2YpjQvRVdHxGhv/3EUajSZkMw68YhSKR8T6?=
 =?us-ascii?Q?ttW7OwbqQHdS7bd71wuRUQO11Vw1v5nj56z00ibGF13Fsrr2cUY43JpdQolN?=
 =?us-ascii?Q?/KkNSHxGKzYCJIW0tTisJ37aripMK0we9CyddWDP2F3DHBDZKTFeUw009fTV?=
 =?us-ascii?Q?6Ck3fBNTyZGlAEfyOAudKvgnV27QJE6IHrKnH5PdYXIAexx5TXM9YuSrJRc+?=
 =?us-ascii?Q?cfci5sQNIQ6snddwujj21w1inHhzyBvj5Th+J4YHOQgIRYjazIddevWtuKke?=
 =?us-ascii?Q?otrJZtkWWAW3A5tYfq09L66huD50+HpRBVo/oobYIBPdvxibjAkJ7aO6FsDr?=
 =?us-ascii?Q?vtub1NlHfu0YfizmbBLQrlxXPZMdgwe4KYhBgrn+R9jVI+Tv969u9wR0GA0M?=
 =?us-ascii?Q?70OtRZsqaozuboUJLoxZq5E5xEKdxkA1m1/BwqM5l0WRNVnFQxQBEWLQomAi?=
 =?us-ascii?Q?4VIICW9LcxF+61Eh8O4Bx76lsd/jsuE26Pa7+dmafY+QZ8nh9jOK8iSrfXot?=
 =?us-ascii?Q?2aZEpyV+Bbs8AVLTsafPz3wGkmTUSLDiXUDeUNOt18xbemrrX7qvxaaNhDtl?=
 =?us-ascii?Q?0HRmJ/sh207kcCWYeuugRalnjtycxAIj8JKL+sq0So68ltCPLVe6EmibLN3b?=
 =?us-ascii?Q?/jxvO28LKI0DRjC+g1G44EGbwt7nB9JpmW2pybjI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uiNBygk1gLWLfGn7CpnoMogqviey0TQhSSOwvtZmWaRlkHYpN52NoaW9qF598G/pSF3nKd0RZPmUw81TNTwdvwrtrtlrdnryO78t7Cn8QgYpEdE+N5hS5KfFEnN8Zf+jS0MV6zilaWFYg6Za1XpDile4zA1eKtW7GhfYhPeYeYiHBrPYCTOGstcBru/wFUhT0pE1xg5NChXJaXMCdLpBBY7WD0ZF/ppwtD3dt8oLK8qWHX46DDyRJiBwz7fOygK8nZQXbzUopxfSMoMpnrV3TC7qNg4fJOW8Ny4z9u6zT1rwk2TELWlaBbVge46pjV3TQLd2Idvkg1kywoVj9GycyNr23EncARZfZe8hJ5BlgLd2/IgIgRjw3LlIhFXfpfU2ghe0R2prRw1K98Dy3RrVsjEDhKxNQxN4mTrVkXZ6hj9cj6Vb4vRV5oZOaDVaRUdbdN+X3SFse/IDS84fpI1Zbrv61PZ/nXEYn/ns5S2ON9VYT0cxJAzq+owtRvHWsgFv+Tx86pSPIeKVzbUnD3A0BU//bbTucPzzR/YAukdWo4yXsur3dxw6GwU8Xvh8o9T/rLH2rFW1sQNobqT5as8x7NIg4O0ygQ/8YNhYxdV1kiWkPtsKjpYr1oATWsPwJDEw8DGRq7LfLzzIS/wR+D1X4F4OFy1QzAQqj95g2hLowcp7lwFf3iwqBa330FQrdlZ6yIr6SI8F5Y7ZPpdN7CKjMHIPlHp7vUzcHLeGfKSARI7L+c4juFXJnE1eGVPWnznxut5FCFGTK0e8BujMyaAGD89UG5otN4aweX55oX2PoHbmYX/WvFFSlk06hEMiUQZY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b36004-2172-47aa-abe7-08dbdb97352c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:31:08.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKXq5wpsylTfkejOoGQWX3PHAjSW1tqfxeuzbpPz9D1+m+2m3g83qq+T6M1cOa4qkkWxySYZvWYfWYvPgyo3qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020092
X-Proofpoint-GUID: iCHAkZpixSiQi-5Sff7PB9X09o88SmCh
X-Proofpoint-ORIG-GUID: iCHAkZpixSiQi-5Sff7PB9X09o88SmCh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test case checks for failure of the cloned device mounts, which
is no longer true after the commit a5b8a5f9f835 ("btrfs: support
cloned-device mount capability"). So check for the non-presence the
temp-fsid feature and do not test for the failure of the cloned device
mount.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202310251645.5fe5495a-oliver.sang@intel.com
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
v3: check only that mount of clone device fails if temp-fsid is not
supported.

 tests/btrfs/219 | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/219 b/tests/btrfs/219
index 35824df2baaa..0bbfd6949cc8 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -51,6 +51,7 @@ loop_dev2=""
 
 _require_test
 _require_loop
+_require_btrfs_fs_sysfs
 _require_btrfs_forget_or_module_loadable
 _fixed_by_kernel_commit 5f58d783fd78 \
 	"btrfs: free device in btrfs_close_devices for a single device filesystem"
@@ -88,14 +89,16 @@ _mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the second time"
 $UMOUNT_PROG $loop_mnt1
 
-# Now we definitely can't mount them at the same time, because we're still tied
-# to the limitation of one fs_devices per fsid.
+# Now try mount them at the same time, if kernel does not support
+# temp-fsid feature then mount will fail.
 _btrfs_forget_or_module_reload
 
 _mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the third time"
-_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 && \
-	_fail "We were allowed to mount when we should have failed"
+if ! _has_btrfs_sysfs_feature_attr temp_fsid; then
+	_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 && \
+		_fail "We were allowed to mount when we should have failed"
+fi
 
 _btrfs_rescan_devices
 # success, all done
-- 
2.31.1

