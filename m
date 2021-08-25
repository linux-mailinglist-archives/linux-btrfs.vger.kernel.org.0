Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7C53F72DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 12:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbhHYKWd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 06:22:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61482 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237516AbhHYKWc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 06:22:32 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P8OVU1021191;
        Wed, 25 Aug 2021 10:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=79JcTGXP9FPYTyBC4PnZfJBCNZQhwB1pry8Ej1+EcG8=;
 b=DWtmKRCddes2slvNQ5rOufZL+mokV7k5zDZlsNbPZgV7i05A9K4QhtOYaKgGcDx7krNp
 +XKvai42U6VOiygJbRy5lbRMcK5/JqLfVVMwxmV3lByNMFX91TLMxjOVGQFF34DCojwE
 PwPE6TFxsNE02l5HWwQ/1iV7LjEnIcHvuuKIfiSeue+Fwuzd0S99l8/4fFsD8D1v8g9J
 d295DlMNN81CHlqk6Bs1VVzdZuXUp24l8Zcagnn7kF++okEv1+wbd3b7DUKr8/S0PVGI
 X78xplkGAyL/rYSHXGx4UbBgdKJSUcKQ5YeWV+jzlBEsh8EON7PP9z9ofsFcwQw5Ph4H QQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=79JcTGXP9FPYTyBC4PnZfJBCNZQhwB1pry8Ej1+EcG8=;
 b=x+YSf4+/lTUG8WxrLHRZfXQamFmO6+asg9WX8PmuHi8e2aWoan/R4aDKI7fg0Dkg0Z7f
 d75Egsi1/6t3kx5YUhpZRr/gDRHgL1Da9QU6U262FGY5pMnQgBfXRvZIvR2QeEGvNTsm
 IcNyB09a+ACCjuMYfbOZpUvkfCaSGiFAErro4Yw1RnK3cW5a+RMNyJrUyfg222gyrlXS
 YVlNPuH2zUkVxpaBRwiCX7MVhkERvDFuc0w13mMO+2gLlRyyBsHdqYvMuwY6VOH6N+Ss
 ZQZduzw3hkXnfNpqu9AVxJO4Y3f/AYmWiXtFgDceIOAqRiZGdw3HnKb2nhF3LsaubWwi Aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwmvb4qs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 10:21:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17PABd5S036916;
        Wed, 25 Aug 2021 10:21:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3ajpm04qqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 10:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obwJJrWqWaMdgiXjnCPuGwL23wT+AixfZUOKjlpImQp2xWwAKu7HPmy1wyDAHI6oqaD6kFZEQBhv9fWLYOr0QYItPKzzL15xLqoTqqt4JN46KIw68XEKjW+fZySB8MNO/5ifqJNO4fPcbxsn2Xjh0QCMzGa19Wqf7n8tL7BlgLlcMJyklwUONgBUoinVq+kxGhVqz/6Mkz8rNcYOoPaBtafts/a+Nh7qoB7ywQnQyJwV/cjdPjRqNzWe+FyCVHKW/p9PD6HdNACT4XfzL7t/QRGgvFNqOg3w1/7Zao7qKzzV/4KkfuK3GeqGcxZnz6o3xJW7EUZw8e2SP+nRAyBGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79JcTGXP9FPYTyBC4PnZfJBCNZQhwB1pry8Ej1+EcG8=;
 b=jXPsKUB3Dd76F4TCcrFmVwFA/7nlyDhjjtqW9jjznMgf2QiqTF2kwt4Tcg+riu/q/IiEU7woGnCNBxtjY68zVRXrnehAapphk6aYmNgiywjTL8dZhuUfhEGdKFA4hxnUc2ylt/p/bXsF0ybjfvbSC2v4au6EW1O8kByfe7LRx4fksdwNNG4mv7TgtmbpT5xdMhuyY4VihZucAMJXz4qW6AoJ4UDp/DIRE1G2TOeywZGMmYtZBFnTbAKcopoigQvd5BJoadqmpngywW8SKrhPk7WYhkyoQy5jWWVXHwAryXBeSJyJ+ZB8/1/ztwu5bv2Ige8CmTZyw0KeYxxkIWAPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79JcTGXP9FPYTyBC4PnZfJBCNZQhwB1pry8Ej1+EcG8=;
 b=nh11uOdrNbz7VOa/+Vk/Sw4pcGmYwSVKOTpLKwBYDO72lz2HYHmArf6RqihnHyWjekTF0cD7FdOWw3a17gr9fYIuHUqJBNoduKopcquB7frG34k0FjgLtvTR1GXjbV2llqzS9VQrYWlUp4pALPre9LV4ZHHlwk0AGTqJeUPxHBI=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4707.namprd10.prod.outlook.com
 (2603:10b6:303:92::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Wed, 25 Aug
 2021 10:21:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 10:21:41 +0000
Date:   Wed, 25 Aug 2021 13:21:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     wqu@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: subpage: only call btrfs_alloc_subpage() when
 sectorsize is smaller than PAGE_SIZE
Message-ID: <20210825102124.GA1822@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AM0PR07CA0016.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::29) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (2a02:6900:8208:1848::11d1) by AM0PR07CA0016.eurprd07.prod.outlook.com (2603:10a6:208:ac::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.16 via Frontend Transport; Wed, 25 Aug 2021 10:21:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26acca30-3373-469d-f0a2-08d967b22124
X-MS-TrafficTypeDiagnostic: CO1PR10MB4707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB470767A7291771A081F9D0EF8EC69@CO1PR10MB4707.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrDyThca3h6KGae3GYPvIpKV36ecVXr2D7ROoU7A3vsVVQzFpt9ZGqCM3wje9W8Uzzf0IOiyByFLc4qUp0VA6R701Vgn8cqHThIFu5/1zQq5lr3J5gF/uU8nteo23SXow1lhIVvRNItHI30HsN8Sk9IvZuEDrEIkK5t7bLECF1GiBCrtWDyM2HUtFSZr/9wd0NYeMDkEOY95ThTGwW4meIwhfXAQBEnMqzWsRzZ5q0B71evoByWEVoVHYOs56KmucQ7uBksT+eQdWtu+6VDpilFzhItwr/QLienc4hBQbN2+FtS7MWAUhTpjSwH4X/5/v/X6Wm/cqboTCbLRPLt12gx++DBJ9f7cVC2Zixzff1mVEDZoUcsGOuhLmv172s9ubV2BDddWf+a3UOAETnkP17pgBqbp5k8CTohvxdLpBzbkgnHv8jmcrOfktVtt+zCcflVmAOMkSHl/uQjk8GPXi+7Fa3/JcM2AigVqwmInuTSJeBq3KIUSOIcSMf0DtbCUvpn4GYHGZpgIjfG+o4ZHtF4h54VowvjHiuf6FmzxcFC06AJI/ekZ87PrW5BgySJDKdRzOsxAQKuTy8mJ1zaUZCe/53Cjr3gwpYFm0CS4Yv9ieTf6fX2j/rkdWXR78PdpkE4qbYOnzQ0cH3/D0lYhAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(396003)(39860400002)(4326008)(9576002)(8936002)(55016002)(33656002)(52116002)(44832011)(6496006)(2906002)(83380400001)(33716001)(1076003)(66476007)(316002)(8676002)(6916009)(186003)(86362001)(66946007)(478600001)(5660300002)(6666004)(66556008)(9686003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?raH9fWgFH7PCs7VEjjMpCEPHeRzF7xwmih+/L1l8zyprIOe5jJohw0kItLR8?=
 =?us-ascii?Q?sFEsqxaFT/baF20GOu9m3iA4F8TfU7G+Nzrg1Kx+rHRk9lr6oO9oS5auFvz3?=
 =?us-ascii?Q?DLOYiZgytYoG/s5fK8mLSPX+R5ZBdT1B9rdWADQzksj0Sho/trthVm4yx14i?=
 =?us-ascii?Q?KAR8jhqBSfB0EtqjB7b3TKb1pMmMkwz5pJrHLdsiaPvO5OYanyNHb5nkBevN?=
 =?us-ascii?Q?r6dlMO7d1y+rm3AkQ3ugwmKCZW02Cd69bK1o4JqIm3gQaPTrliA75MPThPpL?=
 =?us-ascii?Q?fSWYbUYnb13pzK7YrvV3oI8omi0vou80xD16GjyZhDCs7LxY95t2m46iDeL1?=
 =?us-ascii?Q?JgLYCLMkC7/fun0nvaQozcnzJg4sVja0DAkuRjabxqmOOC50JZOBhMgu+URx?=
 =?us-ascii?Q?8cgJQCSHHTuZY6zY3orpxLQuj8y/EpQKMEQVx2yEtnFBf1AyoJjFw4kCJ1Bl?=
 =?us-ascii?Q?yz2AcVUd5j8W8hCEpRWN9EQ/ZP9JXg7/FSYYg9gjmB975dRuECVKl6cSqAZu?=
 =?us-ascii?Q?XkAU+iAyHjIiUJlS72R/YVYICJCrMQJZrBQR9bEVcoti9NFXncl7JXuI4jhb?=
 =?us-ascii?Q?qepLNln3dJ/MB9PqyO+9oTcM+QCb9qyy/I5INTZQHm3tMA0xxKyRlH+u6nTI?=
 =?us-ascii?Q?N45VmFOGrBrA+YwlYMubfS+pEa/bNyoWvEAmXxqqHErU2KGECST6ThTMZK3O?=
 =?us-ascii?Q?HsG5eWJEUs+mjvJu1znfcM2pzVScJ9Zo5mnGeAR4OdgVCYM7cize6eLpsh/v?=
 =?us-ascii?Q?0kt5YoS/bZvXWBIwo/HgoJ3CHw7qFnMQNEMU+U9EZR9F71z1MBXA+BqkIdxB?=
 =?us-ascii?Q?21cZSnvgQjSqgomAKczg/OAg7JVksvxBSjztdhVd+d5cB+C1pWC3s9mncKlo?=
 =?us-ascii?Q?YGGMQ6DipF/xw+dL515zAJA3o2eih3yOf/B+u/8XybInM+6eWBmxN5+2rz+q?=
 =?us-ascii?Q?rR9hZYnVLO1ULUB8prEU8ahUvAJvnotwTuNHWWVz6cimBi4r0Ui2+8Priz+s?=
 =?us-ascii?Q?B+zLfRnJpgLtVE2dFJHt5NvN1xy8aaGD7ZKTF8oub+aeYhyGPeAVnxOg37vu?=
 =?us-ascii?Q?jFXoBfik2YG8uG856KdFVm2smpXb6LqrR1wiWSHM/yml+WugPU0atc2hg8qb?=
 =?us-ascii?Q?bENmaHehMHyGbcqjgZEtRXCojs51dpxVl06yXu3gzx4KO08IBUwk/+JlU8cv?=
 =?us-ascii?Q?FsNc0O81X1eL1QfBR0CF+svbU7J0y/sD2z5E1Lyrp/bX/QtND039s+9TZqfC?=
 =?us-ascii?Q?+6A/5c6DeMtMNWMQJ8DAQhyFf6uRT/WMW2fl3/v6e/gr9AmbhDrI0Mz/mQ7T?=
 =?us-ascii?Q?jyhgFAC7OO2mpsmtt2U+vq5rtvm4YVT6L/ehxLclWnUnaLVzLCSU1cO0AV6L?=
 =?us-ascii?Q?YHt0MjY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26acca30-3373-469d-f0a2-08d967b22124
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 10:21:41.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eakSVllaEns7i70XTks7ihaGJkN+35pwOyJ1RnxZUT3XPfkWAtI+IWIOgsnqtU5TaDm1+sKIJTkMrxorLxRZvMXSyiWCOOhr0bBTq+6OfBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250060
X-Proofpoint-GUID: kyVbvPjQR4uK73rH-WOXVf3hB-2CBxbe
X-Proofpoint-ORIG-GUID: kyVbvPjQR4uK73rH-WOXVf3hB-2CBxbe
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu Wenruo,

The patch 4c1e934ee490: "btrfs: subpage: only call
btrfs_alloc_subpage() when sectorsize is smaller than PAGE_SIZE" from
Aug 17, 2021, leads to the following
Smatch static checker warning:

	fs/btrfs/subpage.c:110 btrfs_attach_subpage()
	warn: sleeping in atomic context

fs/btrfs/subpage.c
    94 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
    95                          struct page *page, enum btrfs_subpage_type type)
    96 {
    97         struct btrfs_subpage *subpage;
    98 
    99         /*
    100          * We have cases like a dummy extent buffer page, which is not mappped
    101          * and doesn't need to be locked.
    102          */
    103         if (page->mapping)
    104                 ASSERT(PageLocked(page));
    105 
    106         /* Either not subpage, or the page already has private attached */
    107         if (fs_info->sectorsize == PAGE_SIZE || PagePrivate(page))
    108                 return 0;
    109 
--> 110         subpage = btrfs_alloc_subpage(fs_info, type);
    111         if (IS_ERR(subpage))
    112                 return  PTR_ERR(subpage);
    113 
    114         attach_page_private(page, subpage);
    115         return 0;
    116 }

The call tree is:

alloc_extent_buffer() <- disables preempt
-> attach_extent_buffer_page()
   -> btrfs_attach_subpage()

fs/btrfs/extent_io.c
  6132          for (i = 0; i < num_pages; i++, index++) {
  6133                  struct btrfs_subpage *prealloc = NULL;
  6134  
  6135                  p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
  6136                  if (!p) {
  6137                          exists = ERR_PTR(-ENOMEM);
  6138                          goto free_eb;
  6139                  }
  6140  
  6141                  /*
  6142                   * Preallocate page->private for subpage case, so that we won't
  6143                   * allocate memory with private_lock hold.  The memory will be
  6144                   * freed by attach_extent_buffer_page() or freed manually if
  6145                   * we exit earlier.
  6146                   *
  6147                   * Although we have ensured one subpage eb can only have one
  6148                   * page, but it may change in the future for 16K page size
  6149                   * support, so we still preallocate the memory in the loop.
  6150                   */
  6151                  if (fs_info->sectorsize < PAGE_SIZE) {

The patch adds this check which means we only preallocate it when it's
small.

  6152                          prealloc = btrfs_alloc_subpage(fs_info, BTRFS_SUBPAGE_METADATA);
  6153                          if (IS_ERR(prealloc)) {
  6154                                  ret = PTR_ERR(prealloc);
  6155                                  unlock_page(p);
  6156                                  put_page(p);
  6157                                  exists = ERR_PTR(ret);
  6158                                  goto free_eb;
  6159                          }
  6160                  }
  6161  
  6162                  spin_lock(&mapping->private_lock);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Take a spinlock.

  6163                  exists = grab_extent_buffer(fs_info, p);
  6164                  if (exists) {
  6165                          spin_unlock(&mapping->private_lock);
  6166                          unlock_page(p);
  6167                          put_page(p);
  6168                          mark_extent_buffer_accessed(exists, p);
  6169                          btrfs_free_subpage(prealloc);
  6170                          goto free_eb;
  6171                  }
  6172                  /* Should not fail, as we have preallocated the memory */
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This comment is out of date.


  6173                  ret = attach_extent_buffer_page(eb, p, prealloc);
                                                               ^^^^^^^^
If we don't preallocate it, then it leads to a sleeping while holding
a spinlock bug.

  6174                  ASSERT(!ret);
  6175                  /*
  6176                   * To inform we have extra eb under allocation, so that

regards,
dan carpenter
