Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B073F577D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 07:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhHXFGg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 01:06:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1804 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230038AbhHXFGe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 01:06:34 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O0x6Wn014800;
        Tue, 24 Aug 2021 05:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Vgowj+hHT/nuLjd8cRnKFHuTZZlYmmKnABlNfvjXU7w=;
 b=vnyh2lLivK+A5+GWpSsRJ2fBEy2h8M0fD1QRZ76pgbcqXM/loVGj1xY1YhuRvw8Po961
 DTE7K3UHIB0QCAh1VPjvYcJnsD0XS0tSbmXs0V2IzgZn1g7bl85GFM+904exMbY9Jvok
 THJn/zLPun36K28JAX9+ZrTaWEk5/Z6frZf7U2SDnNzhCK7+U45EhFPkhK0gqUGwZr4f
 NGP1zPsy4Isu31d8tuX0otrt4GRvBlnKnMYoce4gh3hbpoHmT5Q0CNp8n/Y3R1PeRCxG
 7hD4uK77qzZk6EutPD8ErzhK3zPo8EqP8j6tKUGLV6YGuLq8G7Ljvhuf4S+fmV/1i3Fe gw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=Vgowj+hHT/nuLjd8cRnKFHuTZZlYmmKnABlNfvjXU7w=;
 b=g1RBA9K+C8ql1Un6dLLFqY5NTS1RlREWvPFQmBc1lITP7FgzPcovzFV68cMVKqcidiOo
 RT4JdROr4KrDoRFUj60LGe/Mly/Zzl+/7ZiXqQB1kzTmZAOwI6U6MNsUGbOZC/h0eqKu
 pIhvbK6t9Z8pRumxHpqMCwqSbWCJxSLUWq6zWg2Q79ZKMdzorcdiP/Ezvkp5T9vyvENw
 vnG3ZE2nnIQQGwedXMyzl+p9y2MPvdJcVOWCpyZ+3RQWRsXO3dyHkslrrT/G6NDapB1R
 /tyhAV55yXKp/r+r2Rlt7NdoeKqcfm58OsuFT6A9lFcRp4Gd0dvqEBBXIDFlaowqnTtv lA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akuswkby3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:05:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O55KCI121891;
        Tue, 24 Aug 2021 05:05:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3030.oracle.com with ESMTP id 3ajqhdwwp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQRQ02I8UTOXRrLR8JuXFIxZbvv/Z+Ae/vuZo/Cbba+KXXdJSSwYyCWjvJooafGxOPZBJqB1EoXuMIuGUL4cNdIg51Q8AAZbh7r68e7xJKV95fI5bKkoYuRBG6ic2M2JSRE4ZFnCcORavqgx1J/OxHdDFVh3aoHKvDXjhOcNlEqb71fV3cfTEcRwLkLwoY8FBV7oUgS+F1ytxH2Wzo9hVKbJvM0ODn+eNW7DgewMnTP8GdQJJDCzlX0gDefBVJ93Vt0X7jJHYyO2U8cqSF3xFcrywWX3CKJ1kFwWEYWPQ+r5Kppzt8mhmypBM0chC2+G3z8bZK2ehYhQIEGTCdIrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vgowj+hHT/nuLjd8cRnKFHuTZZlYmmKnABlNfvjXU7w=;
 b=gnYVGpNycf7HYw6mEm7AkPKe1VzcZUIPEUrUQ2PibMaL9sdR6reRO2GW+A1Af+lNZk31hBOWfWKEuSMzV9Mg/5C81m8RL07OQjannbSSCqInucjrUo80HPQLq4gQgRkTI1XR62uO60hTHWfI+73Y5UYgFchMSWQjR2WQVbMxYS9qcTYd2IdB7HZFYRrw64jo8X1XyVTLPvRv5XJZO8gtIasSVRW+cZDdfapq/Y+s5LTf1dXNuH20QwbVXXKWbXbSnV/63yuqNUpRNPVMROvY3SSyG4amcGFVppOJ7/BPprlkcOHlJWpCdx04B8RXgzdyod4KkxVRVLhyyp8RIHzPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vgowj+hHT/nuLjd8cRnKFHuTZZlYmmKnABlNfvjXU7w=;
 b=jfGriVYN05G4ZP/7fAGOYea8yBZOQmMHxk6uU1m14o6sGhvVKNHCp+Jh7fvxSx1zmD31DdReIX44SiuLYp1KTFPFekcgIMI2Y+XZt2RArM6MfqWfOYKg1WaxrvFG3rsV1L9BM9lRWQDERldp9SCR4EwsrSAIaaNtW+1F8RMEahY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3428.namprd10.prod.outlook.com (2603:10b6:208:7c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Tue, 24 Aug
 2021 05:05:43 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 05:05:43 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH V5 3/4] btrfs: update latest_dev when we sprout
Date:   Tue, 24 Aug 2021 13:05:21 +0800
Message-Id: <7472e04cec179abc351e1ca86cd257c848ef1175.1629780501.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629780501.git.anand.jain@oracle.com>
References: <cover.1629780501.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR03CA0127.apcprd03.prod.outlook.com (2603:1096:4:91::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Tue, 24 Aug 2021 05:05:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cf62e0a-c6de-4f46-4ae1-08d966bcd373
X-MS-TrafficTypeDiagnostic: BL0PR10MB3428:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3428D6C67961AF3520257DA2E5C59@BL0PR10MB3428.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLRtSpFxGemXrd+Off4JQhV1bbwOKkwIpoPSq1YpnePGKS/lMGGe++8bXRPmfiRlKWnDMEwdHGoFgOql+UbJyHpfRfXe5Ia9H34+vYVqsi7zftZSf9dCizmRGAMTvtofUOQgRN6KHe9oefisJNxb2vgkMA3s307VaIZ9t/Wp9QX6lj5BrDLbdRrGl40taFyKC+SAK/PYBqJ6RoWGI7kKvycdu6cqUGOEeUnxbfgLDQufFQXFyHUhpUKcMCbFnj7QBBg7DDWZc1rafmscuiMtKA1JWLEVriDvERJ1d0va1ugq0TTJORIbk2rTZdBQJJvWNMV0bI1UZ7RA3T0GA0H+/uUfrCXxR5/leJAoY7lYHh/FMB4hJbXPP24ObqCUYBtBS+qN1D2+YWWzXuc6bpv9mM2N8KCEXDu/StpfYLnEApz77XihqBXdIMwwT8YuQywkY2hf9zbOM9vAc+ikRTGHOHNTI/s0k53fkYBZuce32LyqJytOPDg6S/9WcUPiQb0Onct36WZ2VzLBq+teESFPHHVBW+FcnCNjNQ4ba0zPeSLzqejlbfrOQmUW5+qeZVEQhSNFLYRxdjOnz7K7xBhguWC/LBR/2LnDgY9Dk5tY3B/lDMTqkPyTMom/cFguiZTm6mtZaN4lPrzef2BSPz8qpLhTbMWVTkQXpaSr407E6+vcKFKTYt1ZtFEPUB1XNvZbAJZ6oWF8wB/tt3DQriNoEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(346002)(396003)(136003)(8936002)(6506007)(6512007)(956004)(86362001)(8676002)(2616005)(66476007)(38100700002)(66946007)(38350700002)(83380400001)(5660300002)(66556008)(478600001)(52116002)(6486002)(316002)(186003)(4326008)(26005)(6916009)(36756003)(2906002)(6666004)(44832011)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4qsVO+96JgLDHM1x8M99LV8BZcmIsbzEAMgz+OqKgV3IX8w+Pfsk8s/UOqmz?=
 =?us-ascii?Q?diznKz5EVZGUUkU/94g1SnMTeqtUqmDBQPEeqisow4ka6+kEpwjJNbIUuw/m?=
 =?us-ascii?Q?pmuajNurs9A7z0+o3chKQsEZlP8LIL+bpJDXwnyQnSHBvWvBoGsBx3VdD9EV?=
 =?us-ascii?Q?WctcGZf27UQnTyBJNrTbc7mdR5WZ6YJUsZT43P9kunS4wafmoIuGWESnOhCT?=
 =?us-ascii?Q?Q5z75BIjjEnAacZKlFKoV9mbCfsnTNExtDYXBVsES1CuHAEjRl9ot7nDoVwt?=
 =?us-ascii?Q?lDu3PH1/riLtD9brCojwANqRAPKxEJRJ9jIju7Q4LB2uEDQQT8rsqm9+ERHn?=
 =?us-ascii?Q?uyhOW8QUvDIHfUJXSpo0oKMvQHUasLPdiKiOUq0hLxiuND2Oqln4wHvh+bAn?=
 =?us-ascii?Q?Ke2pxUQTWz/MI+UU11X7jOfBzDC572x0da2Zf9470klLia7c2/XeLxaLCfLW?=
 =?us-ascii?Q?oXZLPdZY9q5AN2EqakZY4q7jwmaNjLmQIv94QyUT6v73QRYyjl3LsgrsNLSH?=
 =?us-ascii?Q?BsSW9vXl71UfM3ISlcBCKtDgsPhXpZmXGdpBBpi6jJiaToKcpGjOK2VHVD7f?=
 =?us-ascii?Q?DGmIryA05a+vdYHxzZBUkDXu3CYjykN2lyf/GfSQD2B9pwvcwbbtg2WAIvN4?=
 =?us-ascii?Q?h0z3hHT85728aKPD6RZ75Z5kvV2oehDX34+ZiOhJ8zb3nw/LepnUlHHghPcZ?=
 =?us-ascii?Q?/JFPqMhrGKd++TDiyUmd+st/e9fPt1FEjWXByVPKd13G1yoAdLYRpMa/i1wH?=
 =?us-ascii?Q?kbirNVzNW+FFpaj1gRAw1CPBz+Jhb//pCRR8mL6UP9hHIU+mlFbfPpgoF/jt?=
 =?us-ascii?Q?L+P0+dlsT++FDlIo3L3mK3RJIOgOgQ+ZWXtwyrAuQLc/tBxkWTivDejzkhbO?=
 =?us-ascii?Q?3DJoX+Tt8v0Mjq5gEg0fJiGWheUtqwtQBVe0oSKDh2JBnr1wl1XONX1qUpOv?=
 =?us-ascii?Q?871VRfuP7LU23+plbxuvB2HpYbZDGJbpdZdyj1mHx3yvLruiUa0rXF2FK1RJ?=
 =?us-ascii?Q?Pl9dLGD7djaMpu35PnnzrGBqvlCccmU58I2XXUtUjvVT3JIfrkr116GuR5AF?=
 =?us-ascii?Q?gvz/e8P3Ox/WfHFFUH/H4y5C8+QA1mRkV9hVmuB2vkYZgtiZTGHMZtPNUMte?=
 =?us-ascii?Q?WasE0zrfBdIYSwqT4+fWZAOwiGzn+tjyANyf+/TLQV/83HFxTf44ktajf/IM?=
 =?us-ascii?Q?TKw4P1hnBZ/uN6XRAwgSehGvzROm9Re3CrgfGX6i4dtrO6SIsvt0LtAgMeFV?=
 =?us-ascii?Q?sfJsHV7s8bNB4YR+nBW1/51uNXuwgoe2SBh9fuN8V24Tlk0wWRO2obvTK9vT?=
 =?us-ascii?Q?EWBfKCR/uG3tG7izPMOF3pBa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf62e0a-c6de-4f46-4ae1-08d966bcd373
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 05:05:43.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClyM5hkHSdq854JTfW2SimlLPONxlRb2FPOc+832jTQ4l6lJA8zhrJqxAn9Ew8CQBU0LBjsItwH0J3gngQvtjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3428
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240031
X-Proofpoint-ORIG-GUID: 3g-XPDjFtc0dWqAbhK4jZc3N8tzNShSj
X-Proofpoint-GUID: 3g-XPDjFtc0dWqAbhK4jZc3N8tzNShSj
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
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ae317b0c39a3..8470c5b5f35e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2600,6 +2600,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 			btrfs_abort_transaction(trans, ret);
 			goto error_trans;
 		}
+		btrfs_assign_next_active_device(fs_info->fs_devices->latest_dev,
+						device);
 	}
 
 	device->fs_devices = fs_devices;
-- 
2.31.1

