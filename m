Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF827DF0FA
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 12:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346709AbjKBLOt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 07:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjKBLOs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 07:14:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53577136
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 04:14:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A282hVp020932
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Nov 2023 11:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=SaNnYZe1nu8SnpYE2diVrU69VZgpIXKp68v7GDLZkeg=;
 b=zb6i5yn3ToS+rTb+t1R24gk+t+qIuqnHfacbDgGcEm7Lf6Q6CMbyZC6guuTuftVYTdx2
 OlDx9j2P3SSq6Ur1V4OE2xzAeFYRM4gCnSEPWzO84HbcTUVzJ2bTf3Fwh+G2shvdj5D6
 cGQUTYoBqZEhiwUFhzPnfmVlzvGRPnTdP+iW+fm3m1SRs/qDVZIJVNOEXecCzr8cCJIl
 vsqrrXY+rFRibeldIVG/UR3jXKd+bYMgOdWg3FlR0/lZ0lAvPaxF+Xo9Ch4CbO1Cb8cu
 KUmq55Qq/3WIPiaKI+HxuE4WeewWUx+bJrXOxH/xPUOkT06/1aIrUr9OusNMy2Mc/aVg 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdsjmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Nov 2023 11:14:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2AWbrL022427
        for <linux-btrfs@vger.kernel.org>; Thu, 2 Nov 2023 11:14:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr8dpj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Nov 2023 11:14:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1mGD1Biw8pPulYvuzIp+iHP6z+00oGiQwjhZAPoYCUHsUhh28Rd7u9kDluDzOu5egbm3OceAoGrHxPaTI7vOTHl/xSNGPYpbITKMmGpzJQPihdJrHRneoIfgWuFytlngf6XmrVUI0D+uis/AMN2yfAurDoiIaRkzzKj8dqfGh0WiON4tWhQGFrn0C/KYiNCagPyQSBUfkyrn20UiWPVUZTC5GjZZkpsJc0/IU5NXxYVkyOOlfAl/aSSwGTZuyn+FvGDSb/SfphzMLfIMYbh9fr9hqmQTu166clWbOwg8vs1tCmQrAgM3Bm4dSGGj3vvkOQ3AGaxUILp5g7OtSMz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaNnYZe1nu8SnpYE2diVrU69VZgpIXKp68v7GDLZkeg=;
 b=FzLJg00uFKejBLGq5n6PP1Amj9nw2y/zznLlxEmDWDOIljpAzgmbGIqhQi+xySjEbQZV6rViCOIJaHQ20CBtuxftSfNHk0OGLYMrbMT97Ew2+5DEHXthpfPJ0fbyXM/unzf/2EEZF4o9soM4rJwPBpEBdjQiQLJRkRvkRQZ+msfOeK+o6UIlwziJFVAjRydfLqQiptO+rsko6Z4FQdXRTZyidYnaaEnmKBDA0vTMuaH1ylB2MVtcAhWu/0ilqbpd/YCUssds5woJPLOLuI64OC8ruPVRnaYFSJN3mIMumA6JAmpM2W3o0+Bcadr4XobyVrd+InL93VtjUx1D7Pnn+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaNnYZe1nu8SnpYE2diVrU69VZgpIXKp68v7GDLZkeg=;
 b=OrBKVEAXeFw1RloiO04511kP3DHVjB2RRTlQWDG/MmEQeoOP/44IOBphLV9LADDNPu1Gz5y/HqsMuslO6QMc2FUEShmTbNM6meVeMnMIG3OJu8V1OCHHoXhnQRKWzKGMCIvOvC4OL1yBoaYU+q8bdhJCg8f5aftrghRtijF12Ks=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5571.namprd10.prod.outlook.com (2603:10b6:303:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 11:14:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 11:14:08 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
Date:   Thu,  2 Nov 2023 19:10:48 +0800
Message-ID: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7b8156-56dd-41c9-dde5-08dbdb94d504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2V2cnroTmqYoxIWVQtNB+Mu726DbwECDI9jlgoyIt7CkgKmcBhu70T8toytQbwaGd52Sdwi3cQXEQvglxljIy4DAbc5eRJ7LT+ZrBRUJ8wmqCCW4OX2JJK6Rn+uNpkBil+93TLG4LmyPHoe5KqIxBbj6enYL0YsvqJk4GDOkXiBZSO0GXps5cU3u6KdGWkRQ1wvlXY7zTNUa2RiRHSY5VC+A5nHclqqYIPjcvo51Zr1ly/nZ+oqCaVO/hgxwGrZ409frJOyNvnsV2TZ9EkAvSocMYZWIKIjFzcLJvut51tiT5vAYBCbHyr1ADL59DJ8OtklCXA2ahjRwx2CKA5/JKDv6U21LpqBfXdTwqEqtz+h18Q+k7Tc1NT5NgO1uwsauFg2vZk6MSpzaugdSolkhoOeebwuE8rZM07HP7dWjBK/a2NsK+pXqQPCckPy7nwZtQ/eKNScvUBQ39DKfqghP01e60f/Cj+JQZpZvMTRERG9FwCLaKAhOoEp7SskLu3TE20bXiIrhhZ1j7uenLxqlcGxFiPKUSJy7UyZct8s2KVzdoQ4g6ONPlenBCFUh6aT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(6512007)(2616005)(38100700002)(36756003)(86362001)(83380400001)(2906002)(8676002)(5660300002)(6486002)(6506007)(4326008)(6666004)(478600001)(6916009)(66556008)(8936002)(316002)(107886003)(44832011)(41300700001)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XgEVMVy63BUCikRNg81u8OZhoUSq+7kyCagRvoqhEIdRhgFA2PBQ6TQM/VzE?=
 =?us-ascii?Q?zgEwqTD/xux+Ea7iwtSPWjZzIhtWzYAix++tjCkSlZGHEUxWVUufkA5jNUZZ?=
 =?us-ascii?Q?OwogqtjszqpKpZnuQ4ApTEzs6R1w4ilmis1d4DxTKik4jdzhoyy+HOJqwaJd?=
 =?us-ascii?Q?4BEpY6uVeNBtVlafV06EqjrtQvpfOh8uAEQBvJU0kdus6DZG24B0Z2+mHpyg?=
 =?us-ascii?Q?5/i5v9OC/rXUUlQxT4dpFvdcd2uFlG0fwJfgxJlFntLAppa7jMVH4YYUdpJn?=
 =?us-ascii?Q?18IbVKw/+lBS0gF8tD1kKqqxDTH+ZgBjszSrFHQEICrn9oI+OTWLUZHM1syQ?=
 =?us-ascii?Q?4RCLWzEQvZ6b8EvcuhfBFQm91jDpoHt7jKwDKigsH9UsFgEbGtJKFslnnk3T?=
 =?us-ascii?Q?0FmjaGmpK8VdoknX3+17DTiBBVT8yMlslAX11J4+7epdYeTMrkqH1yFiiiuB?=
 =?us-ascii?Q?Ez+wa+iMr0pqIncuYJ08lIeXke6peJ4YinAoeCm0Wmt6kKG6hvH3ybESPxwH?=
 =?us-ascii?Q?tq1/JqbWwmAEDKRbbk2tE6H2QNGlZJ+XzF+M6/EFz73cBgCUc7Gpfh2CONUJ?=
 =?us-ascii?Q?qulnV6cqzHCsxJh2DQH4WyqYXhbf5uh7NEiuesfACZn4wFLjlxYgb4PtE/rY?=
 =?us-ascii?Q?PjZGP4W9xpFYEO1TB53pYi6kR0hLCxmDZBMcXjgaiUoOXX4XzUkPkt5Frljf?=
 =?us-ascii?Q?JklaVWf7lEnUtez/2yX/jcu1gn2Tx5edSs94ME72s4fsmrY/uisBwQiLsmxP?=
 =?us-ascii?Q?p9NdcRzIOpe11c38hRmCLPpY/jsAukA2PYs44Wa0oOxv58350SCWJJMBP2wP?=
 =?us-ascii?Q?IYFxDkT2QvAGbpbpH0E/IURS8HRmwW+XHQUB6oJvMRNFnnx1bJwmeXRzVx7B?=
 =?us-ascii?Q?zCH24yRQszNlFdztE5UFjOvXZq8S0fcCXqK7Fnj4GVgWxBR5wcX5fg5J4aQY?=
 =?us-ascii?Q?M2LVLQdJbDkd7WuKCwG3ZQX/LemTnhJNVrcT0kwPknkHnSh535WOb79wnie1?=
 =?us-ascii?Q?7jX+l80tO/4/u8lkkHDZGhviWsZgC7++/lRoG26PjbCrD8Al50oydvKi4rH8?=
 =?us-ascii?Q?0fmEM06yCSc1Y3YWTzC+dah9s5uo+OFuw+ZVXMaNfq2X0DNDU5dP9gfBsuPT?=
 =?us-ascii?Q?gRt5LMihfzu2lgU1FF4PhXLEfQcYgQwT+K4it1tYMq8acI/oDPRZoN8jm86e?=
 =?us-ascii?Q?mlW56ufIp7vC9C1nqKRJ+R4EBa5tFvnMVzbuSH9dPiSgxXBdKXsE71ZHzDnl?=
 =?us-ascii?Q?5Y1qNQ8hZ6qY84+xxrtVNUT4VEm2BcZqndc8+K+vhYf2m5PELRg3aoCf25eF?=
 =?us-ascii?Q?fELON2CKWcPxnCUMY8Nvcfyx0lagW6ApLqc6qnzgRDcNg6F7yxOfB/BeY639?=
 =?us-ascii?Q?1heKyZP87PaKSJGHykIcnOl1ZN6fdVyFGbg5hNSoDHjGqnYE7I7zB0f68Tn2?=
 =?us-ascii?Q?e0PT8FLcPe21e72nOTiaMpecdELkVGpd8XWRfgwAxyOFHp1nOUCvSHnbK0DM?=
 =?us-ascii?Q?Gy8albjW+xIkW0VTO0rqYQnAwozZnShGg09sWqXm70jeNqXqA0UwC4C6aOCU?=
 =?us-ascii?Q?tpx75isdVdB1pEquHAtL3cGp86lm54cvbEhvSEDL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: padzNye0EDVL+gnhE/YaomfoOI7+XykaruBo3JpPbknpZfQ/5G0FUeWXpbuEXmzwa1wrQqp0ir4hOIUboN161giDIs74p7ShOpQEUbWx3MxJ4IkKmIwo/Poo6VbH+jcWewPsxtC2B7AvhEVxeiJ6jqBSEfejAwg3+EQsvl1c5Jd28V4XRuF00sGuh9JbK6NbLtZzpVMiDZK2TOieVQOynbALbulvf0HLSpFcGmaJS0g0oRHU+JvEkJfxgOpK4edmFg3/NLvG7qWHkKpVnxSSDxLTEYLskcBHQQy9YQltg4X0Iggu4aEneBhvhRHf3SOVCqJyJfoiGtAwprGaOncDQAMo3pjb2YhKxVLMgwX4rtFqZoLNSMmg5hRI+DWQUzh8N21aNk/C+UiUlSGrHpUeViyE0YUGv4hysesdFyE9Uzrd4bPJo3fy6x/D832rzEVgl/wSu3NG5TVefoJuyrVrcVa1Ljr2j1ywMXGCMsr5Mr4HrMIM7fCX/RCoWcLI8ulIIYcGv/zRfK+2LRfmA5sQ2aatF6kzOvqPEd+ZArjcnQn3d7X8yly69M7edsZOhrxFWOW1j4hTS/q4DkEONyOgs8CXFvcwe402iZ4n3Tee2Rn/tKpJsH7simEyZuhm0yZUFKKhLYD2ncZiraR01C7WViCWJSSN4i8j4oXACR2opufqjanLF1MDSg0myZEYYL3tvuf+PduBo8m/t9PFyqdoRuO7wvy+oK/gsI/rTxYHA4NC11LbedM8nMvLB7PbMHwQ0GqWcXoTTFowh6UO70cQzg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7b8156-56dd-41c9-dde5-08dbdb94d504
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:14:08.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2xP+lV1HQedrOBH0yYEZIX+6Yd1f1fZrh0kC3sBPaxm9Jlk1mXDs0jVRr3ohtN6rGyW2D8TWrmt5eAm9Cay+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020090
X-Proofpoint-GUID: xp80c3xopsXCRjlS1YaquTtETGQ1t-YQ
X-Proofpoint-ORIG-GUID: xp80c3xopsXCRjlS1YaquTtETGQ1t-YQ
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In a non-single-device Btrfs filesystem, if Btrfs is already mounted and
if you run the command 'mount -a,' it will fail and the command
'umount <device>' also fails. As below:

----------------
$ cat /etc/fstab | grep btrfs
UUID=12345678-1234-1234-1234-123456789abc /btrfs btrfs defaults,nofail 0 0

$ mkfs.btrfs -qf --uuid 12345678-1234-1234-1234-123456789abc /dev/sda2 /dev/sda1
$ mount --verbose -a
/                        : ignored
/btrfs                   : successfully mounted

$ ls -l /dev/disk/by-uuid | grep 12345678-1234-1234-1234-123456789abc
lrwxrwxrwx 1 root root 10 Nov  2 17:43 12345678-1234-1234-1234-123456789abc -> ../../sda1

$ cat /proc/self/mounts | grep btrfs
/dev/sda2 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0

$ findmnt --df /btrfs
SOURCE    FSTYPE SIZE  USED AVAIL USE% TARGET
/dev/sda2 btrfs    2G  5.8M  1.8G   0% /btrfs

$ mount --verbose -a
/                        : ignored
mount: /btrfs: /dev/sda1 already mounted or mount point busy.
$echo $?
32

$ umount /dev/sda1
umount: /dev/sda1: not mounted.
$ echo $?
32
----------------

I assume (RFC) this is because '/dev/disk/by-uuid,' '/proc/self/mounts,'
and 'findmnt' do not all reference the same device, resulting in the
'mount -a' and 'umount' failures. However, an empirically found solution
is to align them using a rule, such as the disk with the lowest 'devt,'
for a multi-device Btrfs filesystem.

I'm not yet sure (RFC) how to create a udev rule to point to the disk with
the lowest 'devt,' as this kernel patch does, and I believe it is
possible.

And this would ensure that '/proc/self/mounts,' 'findmnt,' and
'/dev/disk/by-uuid' all reference the same device.

After applying this patch, the above test passes. Unfortunately,
/dev/disk/by-uuid also points to the lowest 'devt' by chance, even though
no rule has been set as of now. As shown below.

----------------
$ mkfs.btrfs -qf --uuid 12345678-1234-1234-1234-123456789abc /dev/sda2 /dev/sda1

$ mount --verbose -a
/                        : ignored
/btrfs                   : successfully mounted

$ ls -l /dev/disk/by-uuid | grep 12345678-1234-1234-1234-123456789abc
lrwxrwxrwx 1 root root 10 Nov  2 17:53 12345678-1234-1234-1234-123456789abc -> ../../sda1

$ cat /proc/self/mounts | grep btrfs
/dev/sda1 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0

$ findmnt --df /btrfs
SOURCE    FSTYPE SIZE  USED AVAIL USE% TARGET
/dev/sda1 btrfs    2G  5.8M  1.8G   0% /btrfs

$ mount --verbose -a
/                        : ignored
/btrfs                   : already mounted
$echo $?
0

$ umount /dev/sda1
$echo $?
0
----------------

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 66bdb6fd83bd..d768917cc5cc 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2301,7 +2301,18 @@ static int btrfs_unfreeze(struct super_block *sb)
 
 static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
+	struct btrfs_fs_devices *fs_devices = btrfs_sb(root->d_sb)->fs_devices;
+	struct btrfs_device *device;
+	struct btrfs_device *first_device = NULL;
+
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (first_device == NULL) {
+			first_device = device;
+			continue;
+		}
+		if (first_device->devt > device->devt)
+			first_device = device;
+	}
 
 	/*
 	 * There should be always a valid pointer in latest_dev, it may be stale
@@ -2309,7 +2320,7 @@ static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 	 * the end of RCU grace period.
 	 */
 	rcu_read_lock();
-	seq_escape(m, btrfs_dev_name(fs_info->fs_devices->latest_dev), " \t\n\\");
+	seq_escape(m, rcu_str_deref(first_device->name), " \t\n\\");
 	rcu_read_unlock();
 
 	return 0;
-- 
2.39.2

