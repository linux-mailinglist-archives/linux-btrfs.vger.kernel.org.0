Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D219C3F2B3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 13:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbhHTL3z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 07:29:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46972 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239377AbhHTL3x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 07:29:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KBGbfa022494;
        Fri, 20 Aug 2021 11:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=HrP3Z9Vk0zXeU8k9D0BJJqhO08gP4OyGDqPpqPXJQNk=;
 b=TnQIshvwi4n55Hx+5ZqLeRpb62MaYJAs2rRYnfEtRn+LXOkPVETiW6wVH1wMcH0VWdEU
 jOBCOWQiIQZvu7bRAbV+vE/ReO6WLCCMKvTCaQD7VBu7RkrvdEN9nAH9WJw5NMtKVuIf
 pFxcU91nkozjwdGXu4KrvKnopVHgt2OmmUTeZAdlL8MZdyd0+3CkRN7CQ0hhhgJZwbqO
 tiWWGfXBtngqgWS8p2d4YSgl/tB0ozXGqBrwYiiqAlG40CMEOX23nFaNhp/rITW7yXcn
 GPEJ+vu1ze31PpSX4O/z1F1A06+ptj1ougnCuEi2jqrAxhN63n/8v0A5Chgk0zzK+Is1 7w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=HrP3Z9Vk0zXeU8k9D0BJJqhO08gP4OyGDqPpqPXJQNk=;
 b=h2NNrZYk+Gjq3PtO6TtqeH1mfHfGz675sdasJZpfhw2WIJ0q8vFTza/AtQJdMixqTJIH
 OWjpU8w2X2pG4bOPMMR0PTEfq1y5VXBcnoWLXjxbWw2ffzVj9+rfs+xXjwsIDAR/G+vq
 +VqJTJNOnVBtjeiP0cdwiTMMfMvgbl/cZEqx/DYH1yDtozuWLkFkcEyUwuxVDtOqxw5n
 d/Vs00j0Zzag+FRTiKThoUmJyhPh0Yu7p+Nx54X2+wMWG/u9WK0TCDkRasORIzlMgrk2
 jotCT3XpUmmWjOzo+Mo8xzJKi3g+kUjXvcAnmDBrpmfTJa6Zq2O3VjwjCdpok9PPWxQM IQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agu24pajb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:29:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17KBF6QY008066;
        Fri, 20 Aug 2021 11:29:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3ae3vncmew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:29:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8dUeBe+gjferFv/T1v2bKijV+kJl+iuLohCRWrXLoF/7Xu7UxJezVQA1iIgRJ+I2bihU22GJV+tjwNhV2O7QqUjlzO5RHgad8UPAVbgODOjdUBZ7jAjKlypZYXwppL4JOr9Wv8ECtLCfdVeoqUWnLMuOZdke2VvFP0WvU2ZbsJhCm0BX4+AMRp/C7uTjWUV0IAAkdC+OkYVjS0yMJW15lWxfOcLgbrakSnqBQJq2OyJQ48A5nqqbLbuk7TuhzDA565LSsxY+FnqnC9iCl15oiZABzgkb3/km7OKPCtdQ0dpj+WwxHkHqu/cgFwP9Eh+lrSxGjMyrEvZWuRj8erdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrP3Z9Vk0zXeU8k9D0BJJqhO08gP4OyGDqPpqPXJQNk=;
 b=MHXDTwJs1qL57+K2K9Qo+fkfCwK0jI8gaNd7jiqRCIGv95HcwdQJe4BFtZPTv9eOzCc3mdsTU5fjZAWuEv+HInLJrNQVriT3Bi7blL1618OvY/WzfAB7gscTqOlRfr1f49AHzbqbuvLOJjlQwaRZ21LRWGpCOlEpwiCDmJ9dhPqceHkZL17uEMvnmLG4k3yXrFDQAV1sKvAeXE1w3dWkgBrLMSpGv5ypEMZRuwUb8VRHSFR08fl79TDSiPoD45fXqBU0E0PxiaRXJSyQ/m0+tKITChCTQ5H41ZXEIsv3wN5zUMtRghzWW4jP+X1E6A/D978+9B48mxeq5ZK654AuxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrP3Z9Vk0zXeU8k9D0BJJqhO08gP4OyGDqPpqPXJQNk=;
 b=w+XFAU1lQplL0C6FTPZkrb0JGR6rkrWBeTAhRVzJXV119cUETPbHkKJ0nAJTMSQapfrVPa68ynlxS+WnZjvwe2q9mgnQgI/X/4dBqrW+Vnrga02PP1smFisO+bK5qRJvma69tgPvD5wrLOKlQRBoEvKRwoWeL4g9qmIW3Wn2FPw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4094.namprd10.prod.outlook.com (2603:10b6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 11:29:07 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 11:29:07 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH v3 4/4] btrfs: update latest_dev when we sprout
Date:   Fri, 20 Aug 2021 19:28:42 +0800
Message-Id: <e31bc6c24a676834482a7eea5e36df128f96717e.1629458519.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629458519.git.anand.jain@oracle.com>
References: <cover.1629458519.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 11:29:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d61df031-70d6-4a1c-a9d0-08d963cdb8b7
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4094425A77C9A0E873774C47E5C19@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Ctikn8OaJmHu98AcSCkIIGiChYeGshl1OjRwtbqvJal6V6Ay2L5JzMT6VB92bW/UhaA2K+HNcZVxyJQXHntbTFjDeh7ykaNqsIvB3VJoMsNUfgv/7H8vmACoY/rqF9XPUoU0fdpH6PVC1GFhs4ncXwCnmB969qSTZ3Q+2PpAFCbM+pQXwKvBtVGIQwEDuGFlSlaGA4YgWGI1TdhhTCrTBtwReTXv7R2h79zOBO3dDGoA7hifCjcNziVjCGCEcigB1oNn6h3+SEB9W2wpf6ACw9SIPGlNrLwazCoAxlrPg/zfziT2OZakVtcb4AIZmKaC4QlS1QldpnHRqJ8C5Z5r6kGIV4b6MKw7iXuSRCRo03zYC4bY7n6atPbIqW3IKfIvS9RjsxCH+OU6x+isD3g6Qup3465WWZAceHDNx0KvWFO00+LdZfnBJY9G33z77Z/Xs7GxL7t19WhfNJo2eApJMsmentnyjvBdezgg6gmpR/IMUsm/SHCB1FqmA4Pt7jrk7u0xx5U56xRoXm9T3KP/mRGrNvr54Sgz+Gwi+flcFCS0kOoQc/obb0GjJyDeLqSFm9ET3gPGLLQGS9eP6yG7yMOLTuK017PALYgJ+yk8mCJQgZAiWXxPnV6ntg4jdReIkcxdp8YblEculDLdNxYoaMEVhqPRwKbvXRF3fiiZ5ZXk+hJ7ZZ+AlZS06uXtz7fPxzf8uqrBfahwvpySJTA+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(136003)(366004)(376002)(5660300002)(956004)(44832011)(8676002)(8936002)(2616005)(478600001)(83380400001)(6916009)(6506007)(6486002)(4326008)(316002)(2906002)(38100700002)(38350700002)(52116002)(36756003)(6512007)(86362001)(66476007)(66556008)(186003)(15650500001)(66946007)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bg3SbEYxTZjYIY7SsGAqvKLJuKhGaD/OOTmSPxW/LdHoIaL0resCumPnO5aH?=
 =?us-ascii?Q?x0CKYOjzb3gZWYFD58a0J7qV7BJ363jQAUr0vdPR3etkZVcDWU8MvRCldOaJ?=
 =?us-ascii?Q?Aj+/7o4DboCmvAS6vtOnTjo/l1xBXML4/pt7tjsCRErBTQ5kBuzzo+ig/9T9?=
 =?us-ascii?Q?lHi6fdmM5/U8qXGwl5Rc1ssQcDkufoM32dDcCZFoPWDqy6/Zv8GM1cLsehq1?=
 =?us-ascii?Q?Exm2+JL3TlBi1vOqn87sBm64W/fYy+BklkQ1N6usKGrErFmBeJu3cUgalSib?=
 =?us-ascii?Q?6b6ejTlI9AU6IsRuniXylmk3W0Qc8/nzClD4P4y0+FoAsYJTLkMbTja7S1WQ?=
 =?us-ascii?Q?dhuNTkLUt1HA+DGr3TIzUjvdjLFysKLnYRFKsSmDAECoB3y+CAW3YLvuKasr?=
 =?us-ascii?Q?MwKHc/7KCTxel+5Fhk9GdoSLfpdUS1YJL9dZZOah+eQzUCZmSpbuypi3YSF4?=
 =?us-ascii?Q?TVshzfVueOU5EzqMz27F27eUJxQaRI7A9iNp/ySWsaLvueMo9itCJgWOQBxv?=
 =?us-ascii?Q?+UPn/3cTnlIVau2ns3utMtYK1YVUMe2hKsJ/sCQY70Ee4GPnmJwmM8uH+LoR?=
 =?us-ascii?Q?I7yuP086U+xGNTG25Q9BeYiT2j+aQZBJQ4sUr96nq1M5f2UGVRru7uzzcFMD?=
 =?us-ascii?Q?BbpPPGy/ZloewOxG2EN7EkIVFIY2vp8btDa687X0bw3yd4NyKboKe6uNUTfL?=
 =?us-ascii?Q?PrknSkxylE1UqfmaviEG8mKtBFpJCZB8j+rj/KZFoWVYPMilmaoknd3V6dG+?=
 =?us-ascii?Q?Pxk1GJcpO6hsjhuJAc3EFT1457uTfEkLhLP/dY++9b/VOAnKHxJXmI9BkKUw?=
 =?us-ascii?Q?5dVley60B984sQbiBqMba/ZHJFXAcAabb25rU2+6gL0j0Np8+hHNkjLXjsP3?=
 =?us-ascii?Q?rU7Tg5+smT5strQGCo8QMMtYZiaVzeMdc4TUTXvGsWIUdnpMloRo1JjhJQRA?=
 =?us-ascii?Q?rMo6Uybt2TU4IwUlIdonBIfMa7CZ/E1NskFZ0KsHmAuuSz4sLIiS+rQx9oM7?=
 =?us-ascii?Q?EEi6u4djNj/3gilQHzy+acVId4A1NTpGkYpou7hDPtiNu4Mtrh/kC1edNZhf?=
 =?us-ascii?Q?xlNAgzAFPZdxuC5G90WR6cjLkWJ/Snv0s93Cgi16SoiLSiSa4eEu5+Fp0BnK?=
 =?us-ascii?Q?sCMhpt5nuDlHwhp6l0Sa8psAztkwWtgblRNpbLCcQsLyMLk+3CEqOqE6ZN3G?=
 =?us-ascii?Q?gazeYIu80l/2hmiAU3dvGcEiE2t6nMjEsvtfdZyy6KwDX0HghwuwwAt2pcm3?=
 =?us-ascii?Q?CrdPLZ/fYNUXgmtNAorJmKgWfYy6JNdKHwI/m+q7/kl8DfvVHOiArzLjjcom?=
 =?us-ascii?Q?ziSgWfVJzdRoKhCFqC3n3dfd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61df031-70d6-4a1c-a9d0-08d963cdb8b7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 11:29:07.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrOJZLsODNQTLu3L+l3dvW+kpOSqLWCK5LX2cv6K9LFq6tsWwbi/tIofpenCQuX7Gb+FHkLpvAsEhMUaMCxrKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200061
X-Proofpoint-GUID: i4IphdnLjdVgjW4FxWu9wssUEC7LQ22u
X-Proofpoint-ORIG-GUID: i4IphdnLjdVgjW4FxWu9wssUEC7LQ22u
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we add a device to the seed filesystem (sprouting) it is a new
filesystem (and fsid) on the device added. Update the latest_device so
that /proc/self/mounts shows the correct device.

For example:
 $ btrfstune -S1 /dev/vg/scratch1
 $ mount /dev/vg/scratch1 /btrfs
 mount: /btrfs: WARNING: device write-protected, mounted read-only.

 $ cat /proc/self/mounts | grep btrfs
 /dev/mapper/vg-scratch1 /btrfs btrfs ro,relatime,space_cache,subvolid=5,subvol=/ 0 0

 $ btrfs dev add -f /dev/vg/scratch0 /btrfs

Before:
 $ cat /proc/self/mounts | grep btrfs
 /dev/mapper/vg-scratch1 /btrfs btrfs ro,relatime,space_cache,subvolid=5,subvol=/ 0 0

After:
 $ cat /proc/self/mounts | grep btrfs
 /dev/mapper/vg-scratch0 /btrfs btrfs ro,relatime,space_cache,subvolid=5,subvol=/ 0 0

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: born
v3: -

 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 958503c8a854..1d1204547e72 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2597,6 +2597,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 			btrfs_abort_transaction(trans, ret);
 			goto error_trans;
 		}
+		btrfs_assign_next_active_device(fs_info->fs_devices->latest_dev,
+						device);
 	}
 
 	device->fs_devices = fs_devices;
-- 
2.31.1

