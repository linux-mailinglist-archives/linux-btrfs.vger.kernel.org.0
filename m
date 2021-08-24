Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3703F5780
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 07:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhHXFGi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 01:06:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5010 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhHXFGh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 01:06:37 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O0x7da014806;
        Tue, 24 Aug 2021 05:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=qIa6aD6Jsyg9+rkINDAWL0ATP4JqXH6C9z1yEs+odd0=;
 b=Z945kdAVaEk64jYoRUYiqfqHpChvPMs+/pgzI96jQHvM5Du4TUuXDToSHpn7APxQQVBk
 bYIG6blekE1zFHz3CQRh6kaRNleH4JgCAY8MqqSNDGfeP6DM8BO3iJVo32oUjiUDLBU9
 3wOx7vnLwc+8AdlnwHdC6FAIdJn+QgvkfSFFxfvtQqDLM95neiN6v6LAMbepWEgYXq8a
 8an3WpiewdSw0ULXFi3al6nojKKgG3+DThSZHUKl5oynrQFn+lGDLQomK4EEX/HEN+W9
 Ln4IuBqLXrKBKiIyt+1JszgXFABIj7WAtTJOJ68132xlwNem/QSWBHS9vOmzjXYVGywd GA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=qIa6aD6Jsyg9+rkINDAWL0ATP4JqXH6C9z1yEs+odd0=;
 b=etyN4NOxG0+oQ8hVtW/fHGUqT5HYQmihyAI82dunMdrIbB6iaIMrvij9WSbtEu1R1ZBO
 mA/BVdNkmSG1QrVp7GcUDDu6QE+V915I5zXwTsaWwGFhWOMIU+RvusJevOrAz7pZ3Urp
 WZPb61VX1JkF6jQEziHA2/zSOzaA4rBYWC47rBTmxAYmOe6gmXJDRKZNZh+ptJnfpaq4
 oTu4vvwr/xMlSt93isdkt28pyZ2m/rmNXUIhgI4ecFyTpnLKkrIDPHd5Ml4u0C6T1Eee
 qZEh6MbV5AgF9CfXdDVkXrtnSXoxFCB/rkJdj86a/SpAUehYT8U/sroyftu4PNSt2P2c mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akuswkby4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:05:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O55WpX047144;
        Tue, 24 Aug 2021 05:05:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175] (may be forged))
        by userp3030.oracle.com with ESMTP id 3ajpkwjyg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:05:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5c3PJKwrEO+i51zAsXXxUuXIfPIMZ3YFPzKEfUWcBRMCV+Rx2N/3PeYHa75MPBK/t19ptJE2N2iuGoXLmTkKl+p6At0L8R71V8CmmSarLZftnapt2/UfYJdwITYbYNCOEaT8mYnfTHwCo7v2MZBVntA8ZGWl6RA3A1yVPnzLEIL2bDW09l16aWI4FS3/yNMQgkWiuNc5R0wCdizUgNSkLIdJwrDpVLdEZMCSheQyqSh4bcJXybxyn5hTZw/4/+fLOt7cxQnkuUZU1tnN9Hu9UnG2gW2jSl8bEAvoSMnS04gOE/s7bzlVjW6Vblm5eZ0iag+Fu6HSdVEiyTgh9i1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIa6aD6Jsyg9+rkINDAWL0ATP4JqXH6C9z1yEs+odd0=;
 b=GgWK9RR/2gEfdeRw7qoGng/JxhEQ9IGEVuG+5PkRrfkJdEcMAiqVl05s5Es+2SMHY7wkT0fArsEKAgG5iIvEYV6ONjtqb5HL6qJbC9sYEruA5DJbkH0fzv1MseUlK3pJuEOLH91A3vB0tOYxFBKcJ5YKGE9zE35e1pkpJKerLiGurgWqx9wZuQQMwB71eZtKLSyNK198e4XxuKl03eDdc33QmN7CK1rzAL0v7ZLuwrBRltkzBkKrNYi6SXERRxbJkvStccED25w+Jh3uf3RvWdttVMmfCiNi0vdPLyhBy5hoMnU5QCZop/VJuXuN0LgJ5FfqoaV4J3iax/6KE4ESyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIa6aD6Jsyg9+rkINDAWL0ATP4JqXH6C9z1yEs+odd0=;
 b=RvhhOlwE8dOsdpY9Yj90DcNeWz5Kru9bdee4G9TekkPRudi6HWzpK8T9Vn+ozfnZZrk2wACCbApTsK24G73mj6whOEl+VsUfINy/GgmFwVya/FkQBbDqA0ZFpMCnlHO8hxcf9PkwN+n3R2zyHcyQnURz6WSH+un79oNMPEhKWxU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3428.namprd10.prod.outlook.com (2603:10b6:208:7c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Tue, 24 Aug
 2021 05:05:46 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 05:05:45 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH V5 4/4] btrfs: fix comment about the btrfs_show_devname
Date:   Tue, 24 Aug 2021 13:05:22 +0800
Message-Id: <c3e2f34f0d328196dd7cd6bdae67a8219cef840c.1629780501.git.anand.jain@oracle.com>
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
Received: from localhost.localdomain (39.109.186.25) by SG2PR03CA0127.apcprd03.prod.outlook.com (2603:1096:4:91::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Tue, 24 Aug 2021 05:05:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00300c2d-392f-4251-f152-08d966bcd46f
X-MS-TrafficTypeDiagnostic: BL0PR10MB3428:
X-Microsoft-Antispam-PRVS: <BL0PR10MB34286BF4EDFC5B44E1D23797E5C59@BL0PR10MB3428.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TwDaNLOYNpgJ8y268qsXmoDwtKYt1rcmjMAgosN+XM4+WgtoFuxEYYGOslssk+5SJZbQ+9C716EGB0cNpww7lRqjWxTKG/+bzM2GiZsbEHmSahmmBk+ljJiHqUbhaYkgvltcMnhGGLi3p7kYL+aMdGCFQYy5kpmvaw0SLU5XXHhFlLfaP7CLb/2A3FaxyJ0Aq/gywIDLzMMYygT5RouwKyNjvLDBtFTMxJiD2GBKE9M0CidoOlK5goapqKMXzUYHBiXZ+C8wzKaRFd5lYdi0bGyowrytQus7+fklHoNalSq5cspvnJA2ogyITsOXwovpGbnzYlFGiyBt7P11xHuxnA6D4+bBr/uldsXMKODpO/dwXUt+xm9phzQJybYR6SBfTfq6tncivdBqkvCG5zBH95Nd+kxZiWVTvOcA+sGblKZt9upayJSwRd87vDqZs9fHbahcDjlpM4L4rBExi5ont+91qXAGD+7dTKuhR1GBYzyu4OZSBU8uW1FQpDrq+/JGYEGLX49TC5HBGz8/UkB4FCCSTXLyZcktyLO9DjrySIqZvIPpidDPBtUsM/gzY+x7DOTpCvgcYhXRz5bCG3bAqK+6IKpzHQ87QcUOst7mMnF8GnN1Q74vxV6niK6qGJ+GQrp/Z1kOmevw1jUyUTT+mJobu2pDSeXFn2taQ03pyMf7cvao+hTHBrQXltIg3l8m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(346002)(396003)(136003)(8936002)(6506007)(6512007)(956004)(86362001)(8676002)(2616005)(66476007)(38100700002)(66946007)(38350700002)(83380400001)(5660300002)(66556008)(478600001)(52116002)(6486002)(316002)(186003)(4326008)(26005)(6916009)(36756003)(2906002)(6666004)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K8EMxvYVEo91SuwiGQEmtysrefjmL0dO/5PC9gF7OzhnM4LQsHFTDAOihTWB?=
 =?us-ascii?Q?UXLgNpHRxyoeLWOyIO9ASjbZDXWVbCaK2JEehEP/C9U5goY2o4sBxh6hOhzT?=
 =?us-ascii?Q?Bu4w6XJYrH1ST0YukkKUjg3X3Z2mrz/LrDLBAIbZU+zVoJNB8diSowI6stjQ?=
 =?us-ascii?Q?Uz7CEU6ewekfptdpphDVNwCk3KFU/2rXMUoG/VXyvu+QgpTpwZ1RgCLEE4WR?=
 =?us-ascii?Q?sSl8pXl9BVeVu0pr+aIG7zbQXBAXIXn1ODLEEHXF4usip4DF2pZfIdySZLKe?=
 =?us-ascii?Q?5MT1lxw4RXt7lMJ9raWNRIzVn3ULnpbl68LyHVLlvONAhEqLWNUa2t7XRq4D?=
 =?us-ascii?Q?2FhQN46/tC0IPOi8V8WRQkb5qX2QqsI4xBCYaAomLXRE9dbV33cUfTTY4O0m?=
 =?us-ascii?Q?e/kY6eii7v366CwA5uku/hw2QydqF0lZ6D2QFPbS7F8glvlM1b3U1ztMD5ao?=
 =?us-ascii?Q?ZvoWT1UCiACCa3OvNGlo7ejtRJ6hv8bTMMA/+9Bx6N5szPabQdecIZClQQ/F?=
 =?us-ascii?Q?Qz+VfQvoeVycH2ObzfzYKsvZvAjZjpoQC+cqVuHOei3ZFffsziE7q/gXTV5M?=
 =?us-ascii?Q?kLzQ/CMOjHbnEJhdnYXqa9hcbfiQmtdDcTN9l7FKybj/0m/+fQ2QfGkrXKx8?=
 =?us-ascii?Q?t5KMbK1VwXVTgVX/ef68HbHQwdw0aToplVixOJY98EOD3XjryxvKRLItz+wB?=
 =?us-ascii?Q?8hvVdlNAz0Mp5Aw/sVuNKPNWasFFfv5Y2uTBmj5QrTKUGuVj76T4AVkbw5+s?=
 =?us-ascii?Q?I1B06x/u0FDTmwnzBosqk2Uo3U0vDSU0RUqO+iOzDzOU6o6rTyN8TGhfolCk?=
 =?us-ascii?Q?xaefbV7g5SDt2yVWnjtZjOvJ5qA1YuTkm5o0u2GiEgAprp52Fe2KP4gC0Q1w?=
 =?us-ascii?Q?4SdPMR+hvAA2P7XHi7qYdjHCJGXZLF5QyDeKea0HOJ1GnsEml9RMq48TAcuG?=
 =?us-ascii?Q?KotsYFrVYMLKXTBzlcFb95UDaoHXzQeFI33TbcslLOOQQ0WCC4yIwzkfaUDZ?=
 =?us-ascii?Q?fy6ZqFgRsqpd7ZbuXKDwTFWN2vGORbWZXGxR48RTCHwfYy/3DMbFxgyTYgSA?=
 =?us-ascii?Q?Tf4GGlj6OHs9G3K6zg5gpshW9qMcJ0UPwi3QCiCOKxc4UL6E8uWsByyIYMi3?=
 =?us-ascii?Q?9kp0k2e/sN33v9rAhuKDSj52iPDbueJw0ccjXdSM2jxLV/H8QPBe1bgM0GtW?=
 =?us-ascii?Q?A/OyVOItWQohf0BgRDnm9aB4EJpGWVEN0mq+NUSC3cVW7vdSZTwQqTFO4jzE?=
 =?us-ascii?Q?1GUV9pCxFn97KorGmFkxGH0uz9FPFOL5/JoYQY1WJO3vwgMHEevIG28l3Kr6?=
 =?us-ascii?Q?hTRhFqZ6hyN+kqaLb6oVbl/l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00300c2d-392f-4251-f152-08d966bcd46f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 05:05:45.7230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHoqNvsNaFA/hOkr3Uqw4vwxvoH4gDcrRpp5+E/NkA5MrJ1HJ/9n7pioTmgrkzXD7DgXY3QKzHxFH3BH0eOgUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3428
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240031
X-Proofpoint-ORIG-GUID: 9tjuk2YZbsEWRu9io5LPhej8B4eYyUnb
X-Proofpoint-GUID: 9tjuk2YZbsEWRu9io5LPhej8B4eYyUnb
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There were few lock dep warnings because btrfs_show_devname() was using
device_list_mutex as recorded in the commits
  ccd05285e7f (btrfs: fix a possible umount deadlock)
  779bf3fefa8 (btrfs: fix lock dep warning, move scratch dev out of
  device_list_mutex and uuid_mutex)

And finally, commit 88c14590cdd6 (btrfs: use RCU in btrfs_show_devname
for device list traversal) removed the device_list_mutex from
btrfs_show_devname for performance reasons.

This patch fixes a stale comment about the function btrfs_show_devname.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8470c5b5f35e..1d1204547e72 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2278,10 +2278,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 
 	/*
 	 * The update_dev_time() with in btrfs_scratch_superblocks()
-	 * may lead to a call to btrfs_show_devname() which will try
-	 * to hold device_list_mutex. And here this device
-	 * is already out of device list, so we don't have to hold
-	 * the device_list_mutex lock.
+	 * may lead to a call to btrfs_show_devname().
 	 */
 	btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev->bdev,
 				  tgtdev->name->str);
-- 
2.31.1

