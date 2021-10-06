Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC15A423A0F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 10:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbhJFI4j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 04:56:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61864 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237593AbhJFI4j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Oct 2021 04:56:39 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1968Z2h8014783;
        Wed, 6 Oct 2021 08:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=bpr3A2gCles8+dWwOrc6vTWwnvr76IcGutah0dfEYbA=;
 b=iSphKK5Nza6wytcma+3DIlcZ6TrcVJVI0i25V8erzXbPte3ssjnt3SO0JguVQ2NkPU1d
 6+jkNE8h9jVSjHswrYka7Y0isLhbblBVqP2jb5xGh/vbCk5k/DNZpeQJq+n1cu5Btch5
 qCQ959Wpg724RAh/vAkjLo/0PdsUmitaO0nbnptbyXlwV0377WY0sJK9qAPy1tl2A22B
 yM4QQc4mk9GMXvgWGNIrJyTJv+c/3leAsmZmJxAgPGssz88Jj15Lt9mD6VWJwP/a9OkN
 vC4S/GinGezRF2k/fRLqVDIQafi3C1m2gXm6011DGsKQ9tI5ABMgNDvVAGOw5LIgIK62 Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh3y59ey1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:54:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1968sh5d051048;
        Wed, 6 Oct 2021 08:54:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3030.oracle.com with ESMTP id 3bf0s82qd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:54:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQuHC/pnutrEHMJvkn0rso62tOa+y8N9xqN4GXPShqCJvje4G2wdlS3JM3etvRE+/8vv+29YjRTWH84pVtkLFeTRZeHWUuMeDnE1Th+HlD+FKAQLhe0vO5f3MYQTUXl4/nsD5P0FWpiAEZK35ilmknfTSLEbwhvUbSpAPS/2jDbAyug8YTk8Jyqp3pw1oO5P0lxLQYPqNRnHzOBi5o/Upmpv1LoiS/Z9MTKMHphSYmdSqxrG+jZfVAeOGYeBbNe7NfvBMcCaDX4xWmd5xgjykeHKqF3PY20zMnIOmkJ6aqYIEg/zHCxDCptiR5lS3QIK4yPT5pE1BccopTn1tEGDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpr3A2gCles8+dWwOrc6vTWwnvr76IcGutah0dfEYbA=;
 b=IKoLANal4J3RAKS1N9fqWopATGrun9voDkj5gXSzn/gvp9UA2IjbRl+namhh2aKb9Vpn80/xdXeI5Z63dOcvoNfUnsgZH07AzKHc6Texzhfes7FtEAFNQifG2gOkHo9nlUjP4vhnhN+FcTylW6XJQ+EyCaMaPasSFdn1inqJqhksC/rD6UgNqoOV7T0qR8Du4wozNebHnDvUDn5rw1U+2hNJOJFrHImnHFC1mtG7OaT3IyYlQhU+KyQHpRATKppDGuiU/F5WeV4iASYkFzuQo+KN64gePmMLRuj7d/zkkIVFJYOk/96INuKTQiRxzvdsPqdIMpIqoBc1gxezZYUPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpr3A2gCles8+dWwOrc6vTWwnvr76IcGutah0dfEYbA=;
 b=TpCIdzEZ6bzHQWmKPV/D/eI+p7IQ4UHoQeImYfNxZMjWprBWYHUDG+sOF4Nety3ycDzsj7QRCuw1Qhlx+XCO255Vow00+bMlj9eVOamB8cCiaI0hVLWlWBFiB4J5cVvkCEaQIQpPMYtg13GNDuy5TqfsGIKyfeDXDndordO+cbA=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4658.namprd10.prod.outlook.com
 (2603:10b6:303:91::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 08:54:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 08:54:33 +0000
Date:   Wed, 6 Oct 2021 11:54:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     wqu@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: refactor submit_compressed_extents()
Message-ID: <20211006085424.GA11818@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::24) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZRAP278CA0014.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 08:54:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e541dc1b-bc7c-4af6-9325-08d988a6eaaf
X-MS-TrafficTypeDiagnostic: CO1PR10MB4658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46580D2AF70EE1F9FE5EF8BF8EB09@CO1PR10MB4658.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6BO0Y/qHjd90/gaDDef0at2oQZYhYMi1klzcA2RbpWY91F+GAaEndM9QoOXB/nje5FRqNs+4VPWsUKQmroabVuDz+5W4TNFbk0nxR9mgNvoNawZmFDc2OGou/c3PMQ+O6/+2LE75rtTonSeJ2YEFXYpeEt8naE8+OcbrPIHfl8j59HnnENd9w30sdvcfh3eSj5cE2T6GyZGfH3MHC3XTHqPg8i/0/x6yHsDa352LEDJBL1KlMpmJZyjGBcTkbPlw50Thcr53QUAEWWcKwQP/SeVqCl7LmAq89gh8fI0Zmsgwwd2NZFkHQSAVw7o1YEHzbwvbDrILgFKgpVgrsM19JhFER7pd5XZdKA/OX/GmipGwJIaoSVKMRZ3fQY7UbZEiY92L94BRF0xDO4JKpvNRuzkYJrbIqNFDcrhsAhTJOhgNrmKK4iaskGww4QfTY7k29Hl6RPuIBY9KlYuqhL+AIet8xmqOE5Mit6MHDaE7bWC10pFrkXpV61BZx+tXmOmMgwF0VY+/p2HKx0MqxPfvym030+PDrDG0g6qKlvdUSu6Fl1cTRdD6ndQd+KtzRAnDwah/ootWlkt3ONfQTk6RwOFqTaCuU48WtbzcBSIY3Kg25TVDMecTUWLXi/ERx0tE4a85exU5B0xpzRls57vzJx9f0rcoOvu5GV+Mxmgugy59FkNFF8sUW+y0cIneYT/CizkNeoVNjrkI+DFBILJXQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(1076003)(6666004)(186003)(33656002)(6496006)(66556008)(52116002)(66476007)(26005)(508600001)(66946007)(9576002)(8676002)(55016002)(38350700002)(38100700002)(83380400001)(4326008)(956004)(316002)(9686003)(44832011)(5660300002)(6916009)(33716001)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I4uvvtrhHJ/wd58GauGxtdETeMJVheMuR3HlSVXdrIj5wr39zrftOXRaHM6k?=
 =?us-ascii?Q?ck5NuR5oAHPNXipxOr9UlH1skVvQUwWDgoRyqdHJc4zdetKbXKxE9DcwkfNq?=
 =?us-ascii?Q?HSos6fLu7/aROjd6mjWkY5RiYfTMoRjjDXuBrY82Maa4hOvPL3WpacdfQvoa?=
 =?us-ascii?Q?Tnf2falM/EmNbJdj0FCuovPgIcVhP2k6xZ02lYuzSxH8xIhkLrcAmrxYUwYY?=
 =?us-ascii?Q?PH6ZIptAlKKhOugaOBnw/+WDX6C8z9Cg1Vh7nx7l1DnOVBp/Hn+38PSA46BD?=
 =?us-ascii?Q?d0l7uUv1VG1obl1fBR+W1585AzKVS1MtWe84oPJoCOzCjZBGc/1hj4FJvRrY?=
 =?us-ascii?Q?g7GEfYOoJ4RIdrX5FqeMOF2+sbe/729w69L05LJeEjnunXB+HH0/v58dWyF1?=
 =?us-ascii?Q?kmNmQYciQyQB0d+NDfrcE5OSctHPYhEKLPbumz2sKnn/cX//SNjrLJUx3a9s?=
 =?us-ascii?Q?Z0nZde7lDkE0GM/YntjInPWqnAG6Nj1CDWn6muEylHsXXT2UwYLOL6RMtVeO?=
 =?us-ascii?Q?3oaTwW1Sn+u8Px5T86SAdtkZabYbzpSERFkZNJGmiW+1FJZ1innUkZZO12xM?=
 =?us-ascii?Q?2SRlpyhsh0luwMRZ5dw/cVonEX1TZNZRBu3RzTikrWXfqT/8wY6x4tzgUlrW?=
 =?us-ascii?Q?XPLRwqyF/cvReQ+ZRFnU2o4Zzq2YRmvlVF3MAqK1TCxzSghfJHn7uy2awHiy?=
 =?us-ascii?Q?uikMlKpIJZTpmuqzvPszGb5cvKeIqQW900kBN1eSakDNQn0dwyMjcTOz+Nrl?=
 =?us-ascii?Q?m6n8VQn6LGNoItAvOUL8IClwQ/Lq+CDGnhFchCICEMG4TfPsF5BJcGiDa3pk?=
 =?us-ascii?Q?TAAs8sPBLxgSXCfzQA79ubOoPejoDx84HKXMtpgb+LBDNfvB4kd14wx3HqXt?=
 =?us-ascii?Q?R/smG33EfSKSFn4HrjQ/BBo3FJV/nFd+4gngLKH6tX/NOfvOIE3pxQZDelFB?=
 =?us-ascii?Q?vIgMTobTGxAiPMHZN6PJmlpIGuD8PJUKL00GuDRGNxQRzFYDmwSUtnHXjyS7?=
 =?us-ascii?Q?HHFAmOtFA3eagT3IwqyOr7agOUdWgT8OojspqGfVW80rvpJYa5LeSASUKwHw?=
 =?us-ascii?Q?8WNvRS/qZXu2svyDmGnEgjcpB2Yv31UTOioXQW107wptKHu4yKzOm6p5zt1l?=
 =?us-ascii?Q?2JN8DoYV6zvlYnuIyvbjiNdPhG3hBxj1zSrbR7ZQxzfKY4c/q3dWE1vpcUGr?=
 =?us-ascii?Q?IHhhjiRUJjDs7Xjgdu4oiuXX5VWxxiWA0r+3StjUReVRDpywVPZLDd9eZ3JO?=
 =?us-ascii?Q?RFD7ONCpOSnFf9C7FpPBf4Tld+fVmevnQAnSHoTshNF/QHappudDdM/t0THr?=
 =?us-ascii?Q?uXJELE9P2WSvUoqzVeOn0ilc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e541dc1b-bc7c-4af6-9325-08d988a6eaaf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 08:54:33.6347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srEuayAFr/qNL8shj3PBFGtfR/cBF0m3u9tuGdoGTwW3h8VwPGg9WXSgXAg3/bFWX7Z2FyjkWS1kaBmbhPr6MeSqfr9igriJhBff4FJ7BqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110060057
X-Proofpoint-GUID: pmpDOt6VKKPYSSFNILz6BgUswLIfCYGe
X-Proofpoint-ORIG-GUID: pmpDOt6VKKPYSSFNILz6BgUswLIfCYGe
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu Wenruo,

The patch 36976f50745d: "btrfs: refactor submit_compressed_extents()"
from Sep 27, 2021, leads to the following Smatch static checker
warning:

	fs/btrfs/inode.c:1066 submit_compressed_extents()
	error: dereferencing freed memory 'async_extent'

fs/btrfs/inode.c
    1050 static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
    1051 {
    1052         struct btrfs_inode *inode = BTRFS_I(async_chunk->inode);
    1053         struct btrfs_fs_info *fs_info = inode->root->fs_info;
    1054         struct async_extent *async_extent;
    1055         u64 alloc_hint = 0;
    1056         int ret = 0;
    1057 
    1058         while (!list_empty(&async_chunk->extents)) {
    1059                 async_extent = list_entry(async_chunk->extents.next,
    1060                                           struct async_extent, list);
    1061                 list_del(&async_extent->list);
    1062 
    1063                 ret = submit_one_async_extent(inode, async_chunk, async_extent,
                                                                           ^^^^^^^^^^^^
Freed here.

    1064                                               &alloc_hint);
    1065                 /* Just for developer */
--> 1066                 btrfs_debug(fs_info,
    1067 "async extent submission failed root=%lld inode=%llu start=%llu len=%llu ret=%d",
    1068                             inode->root->root_key.objectid,
    1069                             btrfs_ino(inode), async_extent->start,
                                                       ^^^^^^^^^^^^^^^^^^^

    1070                             async_extent->ram_size, ret);
                                     ^^^^^^^^^^^^^^^^^^^^^^
Use after free.

    1071         }
    1072 }

regards,
dan carpenter
