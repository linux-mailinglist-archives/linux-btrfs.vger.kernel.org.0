Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DCC3F299E
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 11:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbhHTJzM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 05:55:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23818 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238938AbhHTJzM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 05:55:12 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17K9kATX026176
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=GCpm8K4o5UZ1b8aM8TIxWA6RU5va6lLNvEd/WvmpFqg=;
 b=c+cU0rwilIAaYuBH0UobuBRy46+mcHpc06kyoP3CcQtC4wl8ixujRuvMhZ6khcz6VKsQ
 4rXKqCPcxt0ywGbJDJ6+H9W1i2xOzwEUTVlOlCOy96RcVW4Q4LYUt1QmBcU33PsvaZYs
 J73orw/+ZemNghbPv+kzIo5YlC59o6Yu0mI4sIyaAF8n3D5vp7hAb2W5Hl+p0fsn2FKg
 xKUO2Y1/mXsitGjhXZdMmggtxpZDQ3OrqlRl6n26QV19p+j8s/NV4jifCuH0v/QKWJsG
 QxzZ2+qkWIaLVRnFDfG7Zu7w+mM+uy0bI7NlEOn2wQjj/S3MHGTlPQuWlgHIjW5ALfKV sg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2020-01-29;
 bh=GCpm8K4o5UZ1b8aM8TIxWA6RU5va6lLNvEd/WvmpFqg=;
 b=fTQlKJpxifPzwsoNrepIeFxchpkbxRFh47FD3Y7zp7XhBFqSXWWA/CZvA5drl8uh91S3
 c814VqQrWBEzCCWTK3dWVipWSi8Kp6g2XP/p2Wbatq0tr1yTt7LLdlJ0tapdFypLSr6R
 ZRBxMnb9q2TgSbeFqy1K3fssqTtb+J1y+4PT5DAymsGM4bVN8vSspaOdopGNxQrcGdiq
 2qjwQ2/owY5BeVG45wvuC/+vXyMwNIOZ5ziItcCVvX5gQMz6FZuExR2hXCpJpW+XW+9V
 xnnHpjRKvHfXHDiqDbQ787h0bp/xOx6uq7OcR8gv/igTCiE5JPx5UVQg19IWLvpeHJiJ LA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ahs40j2rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17K9jGV7168035
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by userp3030.oracle.com with ESMTP id 3ae2y6auws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzQCMuOKEnW+b9tTpKrjK0ZzKItlgP2jzZGlyRds/s092xdg8eGU7m5m+4GMXraWqYwPP6AvptnTZZ5FCKBdTRMiEOmPqN4O+KDjE2V8BUhnUlwtX4HkUX7V894PZ02DWx7BpXADo+1iP5sSHtXup9aaDOUoKewacf8oTsOCCRUCjYSfI7b54w+XcXdap3BhUDThhg54nibvxzDBg/H+F1khMMBVRwguM5DVm7Y16VfuQWj0z3ZaIZuq5mgb6EqOW0Ylfh2XwO/czfZkURx6iKJErCyhMdZvEy9POYa9s/yTslSuiXiveQ/cybLfvz1AhLH1/LKc11JgQmZ003OrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCpm8K4o5UZ1b8aM8TIxWA6RU5va6lLNvEd/WvmpFqg=;
 b=Ce/xbw+faTBUpdBd3imsN6gdWFoy+IBgjNZNRsSSYeKEINHOzEQEys7CMR8UaGqWBJBYCWEZTtYHQY7A0EFqBSukrFqk4qe+qrjoFQULLW+VLX23l0Ahcs8e5s+R3dg6lJn3DtzQRpqYnqEB730H+FHWp6r5cCXUgl/VpoDQ7iTI/mKPBLjXanW0cGL9IBtFCukr5K0C/pKGIeodf1PUeKRsGoOBttxlOt25fYu1H4Es7pwlNg42+GmZNvz8OM0MUqdIiuLjBne9vhj+eOGW6UtS41SWiHKrBMl8c5IOMJ5+5wW9gqzhW/leeERBohhhP/3hzhbeGFsd+nKNqRR89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCpm8K4o5UZ1b8aM8TIxWA6RU5va6lLNvEd/WvmpFqg=;
 b=gfFwirdd/YNQJG1eVIYTR5gZMKdXHprOK1qS+UHYYhLj2vYx1/QGitGMcbEXat8FSGzgFDTQExEpFPsPXqKRg2arE1PcZ4HC4IWLdBeWWGVqibzn+Gn9nO13GsbxFvJFZzdO+z1FxdVLWrYeURsJxCqtv39xjWtIF7nUp0ZtNpQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3427.namprd10.prod.outlook.com (2603:10b6:208:7e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 09:54:31 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 09:54:31 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs: update latest_dev when we sprout
Date:   Fri, 20 Aug 2021 17:54:12 +0800
Message-Id: <1e53559c7651fa4dd8897ee933dbddc9df8f4c57.1629452691.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629452691.git.anand.jain@oracle.com>
References: <cover.1629452691.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Fri, 20 Aug 2021 09:54:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 620fc55b-5656-4754-7b64-08d963c081f8
X-MS-TrafficTypeDiagnostic: BL0PR10MB3427:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3427F0B94454D27D18A2A2ABE5C19@BL0PR10MB3427.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9S0m0uxDfzz4h/kH408VX0TMrOEoCV9v/ndOgnC7LPWK3lqv15xCS2IBqtq2Oia5Yv8kvU/bOkpaFRzJ/FWwOfOpFM5qP1mp0nCXYM07b/F2yq/vvZYwXvzCG1Uu3VLgwrDVNpj/AgK9gEGI9LUEWIBAtQ4ys1UDLdsrOuUNn0rq3yC/OyrdpuH93taF7B4Jh27K6F7BUCvE6psRR0jMsPQwQUequ3PEE0eKH5nQEbBNZgZPbfrRDduF94YxTvcUoAPS2ma9WRVRlvVOabW/u10big4ZDlDq8oEYgTPjjyppZLQBn6JD6kzgtzlsYdkf7y+pn5ofh3CB/9DPHZET1tQC/Q6SLZMOc++MMVAI75wv/aid7ATXYZi266sz2KE9SRVZ6ji+Lxvwbh6PHxGas+EZLJeyoTAZ+ucyfbo5GobyeWhEDyqFH/520eawndE3I9f5axpcLmNGWMfkP2giAhvo1dUgvjoTvWhvuuFv8YAjt7UKVWWx9HALf2IXfdIaofgTrM6DyL9J1Jo0KAOe3b3mx48BtpEFFoHe5WnoSwoj47WxvHMAkLcWe8GNwOXasmNS0stl7/0+uhan8qYWpP/e5j/Oh9U+RpI0oL4RzBuhdx1SKLyKn2i6Ss/UtfaB52Wj6xjVbdx8f9RyplE9rCkssJc9a5e3ySdWGNL48w6oQ09JOdwo+EldUWkYNxxAm5yQwQhb+/OWeZS/Mn/bGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39860400002)(346002)(376002)(6506007)(5660300002)(6916009)(66946007)(36756003)(66476007)(66556008)(83380400001)(186003)(15650500001)(6666004)(478600001)(6486002)(52116002)(8676002)(6512007)(8936002)(86362001)(2616005)(956004)(44832011)(38350700002)(38100700002)(316002)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ehI+i4ZrI+qElmnelMqHWXUNPt4wH/0v7Q9pB9uV0ME/pUVZWw+HsOIpGDe6?=
 =?us-ascii?Q?jcwoasOekWpiDoIqnXd+PhCbl7zsG9Aj0+aY0Egcs5Cb24/HT6cZ5UiYClHR?=
 =?us-ascii?Q?h5NXuvcl35D0eDUHKb3IkR+wmGFhYXUJAuKOx5wMjY6yTf/J0p+eALlgQs6h?=
 =?us-ascii?Q?41fhxEgxJjXyEkJldBBr+wE5WLayfKldaC1DHd8xHiAOFEz+gk/wd6VR2ovx?=
 =?us-ascii?Q?5XogY9vaK+nam4rSQ+lGcPI7SYZlXq8EQWByNEAZMszWLRHjhow6K5gETihA?=
 =?us-ascii?Q?UuK0+8cl983mHCfPECNktvoSl4RDCdd0tKuK/V6IgPI1I8XwqwCtYKmLDyPx?=
 =?us-ascii?Q?JQ0gB0T5M1iiqoOOM3uJi9McgPOe57+VJ6kDdRc7Vb0+MOfqSnJnhwCzOB81?=
 =?us-ascii?Q?RRtMaeQlztLmXAF7r+qk5UCmwjE92FIqtRA+0UJFltCuh6fYQQr7TZrw8wny?=
 =?us-ascii?Q?dqjSEc3/WPHXPzzoCvyTVLnPB1liDQmt1pohPZFZO8Wo9F1L56Q2iGNVb/Fl?=
 =?us-ascii?Q?hG8HoWLxL828ul9FyxNqObnc7mxZzJZJHE9bt6SNA0b8UJ6nWpHLXiTcEh8k?=
 =?us-ascii?Q?KRXpyzJVK1JFJg0jgSJiAJOprtGj1OQVJ0H4UXm7Lk4kxtY0zp1a+xZqT4ci?=
 =?us-ascii?Q?2TpsxP1MXJHlxShb3mWQhwfzhavkmo2hbphbiBLE+5UEPxzhm3lvEQS0or4l?=
 =?us-ascii?Q?zmfXgGwIieLFs8Q31beXYWJnNTpwZxpQAxKLCqnmnzM+xstuK5qzcm+tY85h?=
 =?us-ascii?Q?GwaQLtLnd4P2d28dmBJKUoetI1kkMCCUfXHE3EJcHfZrxJgmdlE/TfvFBEBQ?=
 =?us-ascii?Q?EDKJoNigMl45nkoYgCB2/YTb08HTzSVVxbDdqpWQvK44rxS2FZbwPkBU2ID4?=
 =?us-ascii?Q?zUwOK/sWTyly/UuMKBcy8U2xvN3lh72rMUi4CuPbBhNIblRK8XS8t5UyK2ZC?=
 =?us-ascii?Q?9FGvSRXV6xI97DGYHkByJuuWrH+kV3nSYqq4spMacHYqzHPqUA8ZkPY/lyww?=
 =?us-ascii?Q?eC/63bZS6XldlQKZIl0WG7ftnc4vAbNAezR5oia/7+Xrd7DmrIx8rKbwSYkI?=
 =?us-ascii?Q?Lj+j/+ObQHzeKPpRief7nurTj4pKAQIeB108IDN7cI+CWPm5peytexGwkpoz?=
 =?us-ascii?Q?oFYqSpBtFz3c5d/BkcwAhpDyZ9hmImCewFgaNVGkwau1mgfgzq8UZFmD5ctY?=
 =?us-ascii?Q?mD1SkN0qqVX5dygK3sxQLvFu/d61fXZIFuOdKPyaI7E4EPSZQYhMO5pKkzX4?=
 =?us-ascii?Q?WTOWgzyOs9oDibqGhCY4ZLqs9CileGXzrGsWbd8aMnzUlZgBUfpQKn8AYVbx?=
 =?us-ascii?Q?DuvcQPf9UrXRz4DJrXcM4PxF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620fc55b-5656-4754-7b64-08d963c081f8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 09:54:31.8367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWqv0qLiBmiAW5ltV+TQMchG5wXfY0NCPhT+MOuvoecbGYxdMvG/faSb8OZDsyMLMb1Ua4bW4bKVsOeTNsQMUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3427
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200054
X-Proofpoint-GUID: diF-AL9_XhqjOyVPHmhamaxyS9cYuyr5
X-Proofpoint-ORIG-GUID: diF-AL9_XhqjOyVPHmhamaxyS9cYuyr5
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

