Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8319C412DE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 06:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhIUEfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 00:35:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19090 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhIUEfS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 00:35:18 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18L3TWTT025468;
        Tue, 21 Sep 2021 04:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=oe5Fa40lu0L1A5UokrwJxGfeeSp6dFJGvJMXXULTqLw=;
 b=mraOLqeWeUcK7J2/wqKZ4nDUpjBRgUYeg6zWDp+YOXEcL7+sQDd3FMV8MCQPPepH7VSE
 hazA2maU4plRL/E/Gl6fJNOERSLMEc4VY9RWzuMEfA22Cn/cffCgM3QVmEcxjxBSwHC6
 40lSQkaB8z2sXBm7Y9GRcj8Ot83bfBkE9NntdnY3QxTNmecQiTJJo2mMDOI+bSFB+WR+
 sUS3ADUjj5tugVHYyUFsHUDh9VrTaYWjg3jy42DY9C006DPMN8pz+EWFG0hPHhB8zFjw
 0X9XQY0RmSWOPssdpT7XU0lCYN3uN1naZqH3jYHE5gq7sgIloejq8/BYTWHpNqqzfsgK gA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b66gn5fne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 04:33:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18L4UuJn125435;
        Tue, 21 Sep 2021 04:33:45 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by aserp3030.oracle.com with ESMTP id 3b565dgq0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 04:33:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+clklxrFe6m6LfsLBZiY7uiSyodP5Ie1Nxtgf5Btre2zP7T834wdhVIU9R2Ze/Tb8pWRQuZOUV9nvkrfT0hg7mqel/CXHfbijgQDSqibJ0yuCCQgTU6QDY4s146JPOknvaIokNKnIjKbEpumx0AgzSpiIKPvP8bN4E6Tgq3hWG3wxhTqwFNvNN+aLA44QxWJKGeLJ9H9Tksv1NBzIuyrZgv58Zs5TXaHHtC7MUaY9SSLDDOjAg9v+f+YQQnvIwD8S+oUGozsOvUk0lhyur956nLpOO117/a5OZ0vrLY6dwA8nLS8z74CbYDV8vxdz4ApsXYMmpLJQ9BHoYvmiTZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oe5Fa40lu0L1A5UokrwJxGfeeSp6dFJGvJMXXULTqLw=;
 b=P6QNkxwXH51nJ7h5DR+NEjL3XtP2c2qxKl55klCLIBo/HuKk15fyvztlHpazM+tP3YmiyVkwe0t9dQHL+87c9EreMruyzJ6OUkqYbas/bC4Uh+DnF4vhTL8+rU2mSVcBv8A3gKq5AE0CljI4ZjP3oub3E3G8jQQfe7WYXBF0nqHH0RYG314IPMQ5A+qHH154SHlNBf/4kyfTn4ZsuzR0ydi2Q5Ntb/AW1KNr/MBYyuk0jU7pvvNfYL8JdyUsBKDdJpEkdQmOlG7Jj68LHyaUYN4B1/o66A57gVqPfzGvmJXWkzbGdluIhoc/Q0iMKJFLDaZKVQqT7SggHEVoXOzbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe5Fa40lu0L1A5UokrwJxGfeeSp6dFJGvJMXXULTqLw=;
 b=CJ7/oALHFP2hyvhtnk6XiURhxMfvPzx4eoMKTduy2w3FNdNLSeMrm3kNGu6RQASad/VgdLHaGYFnlFzD9U9LpApXnn+23hgVmV7yIq+X7mZek9CwnFWSOwd8JILidI3veubd7pPjgNRtX15amg/UAdQ3L3iPNfW/RjibFh1MHFg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3984.namprd10.prod.outlook.com (2603:10b6:208:1bf::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 04:33:43 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Tue, 21 Sep 2021
 04:33:43 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH v6 0/3] btrfs: cleanup prepare_sprout
Date:   Tue, 21 Sep 2021 12:33:22 +0800
Message-Id: <cover.1632179897.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0129.apcprd03.prod.outlook.com
 (2603:1096:4:91::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SG2PR03CA0129.apcprd03.prod.outlook.com (2603:1096:4:91::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.7 via Frontend Transport; Tue, 21 Sep 2021 04:33:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ea09228-7036-43c3-a1a8-08d97cb8fe05
X-MS-TrafficTypeDiagnostic: MN2PR10MB3984:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3984D0A07CE3FAE6B8885A8AE5A19@MN2PR10MB3984.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFSV/7ih5IYRNLyVRSv95OueBdSkBXdRD5ijps5A4mbFkBKizvF+3/dAb8B8q1ACi06GEBC5r4TaKM0Zb3kUAyYYI3Mniw8K0X5cUqkjMY1KyTBvh2PD1irW/Y+2YSF8CAQcPX6fOOy7YMXqertyQ3ofD+6/gbbx8bV+7Qk9+s3cT5XNuuoPJU+kYXDcSdMUZC9KzrXFHHNOYCNe3RwCbPdxDRDlsXffpDrTnbn/9pDv1LWSFMrQd8OeK95CF5KwFxMBDQP8oxWBNsjfJYdGUImKDidAOSZXx7Z0EfIA7n2925IxEbmoy6+0UF8atuYHs/R4EjLm+GunZ6/zCs47TQFuADBGdAYnZXdXdB8d43EZSZaSN4JW9NvG2y/+xK5VQwFuG/cX5/L1ftIKp8+nkunRsPZYpQofc3Nw4g2TNDHHHB2Xdu//fyWRrk7uHlQPZeOknAvO8EsvgXUx+PwCjQYCEGnQORani26eKcFYl/kvpCJ+Pz3/MyKcXOEmikCxAb6I/3s27CQg7xW9phTchgbkZz8MvXi1LqHQ5BaqnnCzGuuB5lX/Q62Tl09oae8TnKV+tJj3mLDztVO1NOFOh/3s0h/NFurP8oXhVv1z39B1zQcP7mMYqUJJDoHQfR0W9x3tOsWoXWggZd3NbeTlxIZ1TwPZPyE0uvpps4Bjxtc2tEVf6eduzBBeVvzyeJLn1s2tZXNW5N2VQgTj+75rIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(376002)(39860400002)(52116002)(2616005)(83380400001)(956004)(478600001)(66556008)(66946007)(8676002)(8936002)(6506007)(5660300002)(36756003)(6666004)(6512007)(38100700002)(2906002)(38350700002)(316002)(26005)(44832011)(186003)(4744005)(86362001)(6486002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FN3VsY5bfdArz4I9UnVhRNLoN0eI42fX06WvmhXpVhzKhPmIiVdEDnJqywcZ?=
 =?us-ascii?Q?QOg9BV5DFIe5JQWJfr7QgFMBRk7M+nXs/4AB0tXOa82saVQPhj9FRk4Xkh7t?=
 =?us-ascii?Q?3Pu2P6Kk1W31kk3LBZinwrP9daDB6sUlUaBulymYRdpDUHB3PdmxNwNUl/8r?=
 =?us-ascii?Q?pG/J8xD+AznJP3cxWMawpKf1h4rPu7o0UpgKjuCgx90RdJHa9clW8d+2R63Y?=
 =?us-ascii?Q?wdvnOLGB7+ua6D2fbXHGKeR7BTxcG4xiT9foN/Wb4YrtAk3gBYEHNZU8VFmt?=
 =?us-ascii?Q?StDq5evouELzPHWxXJ8mwruR62A8BXJkJ8xMBysrc8pq5RWnpH46+i5Aiz25?=
 =?us-ascii?Q?xUk8CX+Y5BZUHSJZ3FlU5/qoJVKU2yFIzAqWPZDq1pEyx2E5jmHTB0IjVm47?=
 =?us-ascii?Q?WeoVxCdTgOsM2fi2CSYSMqjSZnTm3WcEAc0gDN52aZggCKYJuOm/Rc+BdXSC?=
 =?us-ascii?Q?J/YUgYue/uYVqxVotd4n1vhPqrCOVSahB/mY7KxDaG0F5zuZxERSUlXqZA7R?=
 =?us-ascii?Q?Bbkvxv4c+6wqpeK0arege9CwJEfh2C7zY96581SHUqP5VC6gLhIXsw4b9hwh?=
 =?us-ascii?Q?tHXnDdHi+Kq5I82Pw9Drbrd2oPsn01yTasAwbs/nYOLQNgGYBwPt2XJUY/vu?=
 =?us-ascii?Q?5SEVMvbXoAvlfd4QRm7/Z5G9lhffBHnS2dR7SoOk9ZERdGwejM8vhYI9dh3O?=
 =?us-ascii?Q?jFJHKqGaO6EYEO1ObWRtHOXDTJwNBpL5mm55HJ2chc8opAMy7X064EgOuhWj?=
 =?us-ascii?Q?MwTm+8AyqP/LSxjeE+T6ubrcNMg0sCo1fqjXuLN9nI4n2Qm9YVIQGKncLrhS?=
 =?us-ascii?Q?28RVHLMHGFEDJWjcSF+NclXc5QQLy7hrdcqX5MNWq3Ud3HR+zvsSmQZinRS2?=
 =?us-ascii?Q?dAC9PDcGpJSDODZ2ZCMoQmSVzZV06b+82MGTr4+2p/PLVf1aKlEMUnRkuNzW?=
 =?us-ascii?Q?YSqAnRhZPHOHcYmbDizWqGLL0SKLTpk3GMuIgKsTvC+HNs0Z1lp5oYw2dURt?=
 =?us-ascii?Q?4Fa89Sy1B3w7e9NKvudYvFsYRacfuUakdTRxpoJpyZG8L8Mu0/CANV5cJgQL?=
 =?us-ascii?Q?4yZYvGVBsd14gCC5XX4jzOvWVNVZ1FzIANIq7aoawMYyFl/Ytyr3YbvSS925?=
 =?us-ascii?Q?KjGxfzsMkDgxNRR5tUW41yKwB7ci4RQ5udeyVblnM6pBufd5nkofcC6s2Z0X?=
 =?us-ascii?Q?kqlno0wLU/ZB+ApE3PM0ddH4uceikR4cLuyZcFCcQ8D4atk2Z70editzwXHl?=
 =?us-ascii?Q?Zp9+WwBWyGn/OoneYjMS86sbqkege8ey/T0Ch5cY8UZdT2l0xkX0UvU/Vqqt?=
 =?us-ascii?Q?DMMd1oa1cACwqYPz1LCkOKK3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea09228-7036-43c3-a1a8-08d97cb8fe05
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 04:33:43.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hi1nE2oF/GxvSBCGdxcq0nZq83FraJGKATjmQPOxV4234T95niEhzKPGu3yRMG1izkiE5gRnpPRBXS/kpOPcVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3984
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=639
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210026
X-Proofpoint-GUID: gLiiQxeKhj1b3gpWZJDmMmuEeEy3EeoR
X-Proofpoint-ORIG-GUID: gLiiQxeKhj1b3gpWZJDmMmuEeEy3EeoR
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch 3/3 was part of the patchset [1] before.
 [1] btrfs: device_list_mutex fix lockdep warn and cleanup
As the patch 1/2 in [1] is already merged, so the patch 2/2
in [1] along with the other cleanup has formed a new set here.

Patch 1/3 and 2/3 are a minor cleanup in btrfs_prepare_sprout().
Patch 3/3 cleans btrfs_prepare_sprout() so that a part of it
can be within the device_list_mutex in the parent function 
btrfs_init_new_device().

v6:
Patch 1/3 and 2/3 are new.
Removed RFC from 3/3. Take memory allocation out of device_list_mutex.

Anand Jain (3):
  btrfs: declare seeding_dev in init_new_device as bool
  btrfs: remove unused device_list_mutex for seed fs_devices
  btrfs: consolidate device_list_mutex in prepare_sprout to its parent

 fs/btrfs/volumes.c | 51 ++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

-- 
2.31.1

