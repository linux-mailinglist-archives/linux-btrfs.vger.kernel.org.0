Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EEB432B2B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 02:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhJSA0O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 20:26:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10840 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJSA0O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 20:26:14 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19ILXKn7004896
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 00:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BKN6oavQhyki5bGdptRPih7y+R7HipATJi+NMbwBkrk=;
 b=Z1l1EWQ86cLwnH3DAuAS/ZDHP2ROikUARMxdYk5pHVQ93ZwVMv/TZxcQJnCIDU5UQ2d7
 IsDGGdwgduoCnf4tQVyQCkHwN109h3so7jSti5yEkqUJpj1SGW4T10Dr6iDl29n/Xp7x
 qMgGFlYZ9HURdqZwAodt+o5l3pVUwhTNfAIP9KESwhDqxu9/S8dS3PXwBw+74Exdhhfh
 jEK8xUJXDFssYEpyLCmhMVal1P5ieHaDjf/a/tlHAONNLzxqByQvEj8KhVd25aaiVpRN
 NNtZNvDbblsAjfsfRXjwNxRgEz0Ulmb2c5cbr88qP+sZAO8XfdslPEava0/yRM1EJMPx Jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3brmrkesf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 00:24:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19J0H6EB001897
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 00:24:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3020.oracle.com with ESMTP id 3bqpj4k2tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 00:24:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxgVINKlZCkDCP2yY8hJkAGgARYWqw1dc4kJsm1brs8VmxTfJgp/EDx4/CRCJ2D72+b3UsAyQgFtYkEScBfEHExskOMV/sxD2ZQO8VbTCb0Y71z2PYNfrwuGOqt6Yo0wHl7lpywaX+LHqn75paDgLu4W6rKeSQVoyUlWUG3enqxZ93Ds3Q77/i+KTKGF7/TFpvGC2ZSHspBqK+UhvvPa4AogNzGTLXKT1saIkSphyFAVLRcaNFb9KIEYOTXTdIGyKINjmVgb4RljjhcsW+5zHWXQJyeiFGpX1N6ZRJNPOCNqDREwP5tHy18DDotlwxn0IixOKCdZ+9bVQI0UIPURbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKN6oavQhyki5bGdptRPih7y+R7HipATJi+NMbwBkrk=;
 b=dQAbJ2DqdKlGW7cVPox1ifgr8cZ6R/fbcN7X4EqmDHehW7yzBNg5aw1xSPYHXksgAp58sCkYlqgXHh0ZCMlNQWBPl2U60JhroTueDISx3MKJ71vsevKr9qpUS5UXZkraoQoSA48biuqzr6qC2BR1f3EmiNhDi6EBF50+A+4Z/4W1xVpfLqTa+zfCEzOiJXCk7A8nXsRpYw829pbPLAaiqt3Mncj1ISo2tRHi6MzrQKbcNP4wJZuh0Wt3gKOT1A+FKkk0KqQ78p9BXpVmASfLxp9PAzQkD6B3C3EX3ZdGAJzCcIDjvIG9GEK1NIvFTBQcKZ/9yHhQOS5B/FXtyolSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKN6oavQhyki5bGdptRPih7y+R7HipATJi+NMbwBkrk=;
 b=x2aoyFDdQrlFlyN6tkAUV2XZbZFAxTCViPbtlSXwR6i+Eli9L91A/OGHzAidux7Fdix3q0ZE2C3tUg5wUsfckxZxfT/VJP0zDde/vqMBzqxq7yaAH9LqxQmvRLHfzE0sYK5FPvJdMPlgdd1JTMgYezWADRW7L69q77vAjZqHXsc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3427.namprd10.prod.outlook.com (2603:10b6:208:7e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 00:23:58 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 00:23:58 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: read device fsid from the sysfs
Date:   Tue, 19 Oct 2021 08:23:43 +0800
Message-Id: <cover.1634598659.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR02CA0018.apcprd02.prod.outlook.com (2603:1096:4:194::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 00:23:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2175c5f5-d607-422c-24e3-08d99296be01
X-MS-TrafficTypeDiagnostic: BL0PR10MB3427:
X-Microsoft-Antispam-PRVS: <BL0PR10MB34277DB79D74068430C1C36FE5BD9@BL0PR10MB3427.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVmIAf4NTBpqE2WVH/23d3AgNftTW6rU9ROk67wFBioFaPqc3/FnVCXoTyZywwcr/rukrJSwbCPckYr0CcxfH8+teP9e0qQRmro+SpM0oug2crHwT/0lUkD367oDIiftqZTxXryxqf+e2V7Z8gcjlEQxixcTxg9Czix4q5/zMehjnjKfk9xX8MnHAz9lQEgL1XaK7fPJDd/wAYBziIrF4Wwpdpubx3NZtohp+rDWkAMwMgxfNAcIpzPpY8YT88rDP2l5QrwTgV1SuGouM/A5ge2hccQHBQ7KLZd+BQ24vEIAFpEN0SVb10SCqcAJ304mvwtpmNuE4OhcfEJSuHr5rS6kfETUjS+52++T8nOR58HXVNiWUq9X5Z+EY7GanGLoiyiCjS/PoTRC0vyqJx2u+hNvnVP9S2BElQ5ulL95hJGkbd36ujw+UJnT7E43ke6HUWLuCP3fv0sQn6JRMGXnS6u75wuW5CSJG9OMTcnBjO6SBnWvyCOHXPeYtrVT4YiIEul+DNYpDY1cFbaqjM/KAU09PpCrOnfQaITqfdSpZ11u7wZcWUtaCylduz3V88FSvqNOYw9111xx1eHPcrvrsjtQ3AhPIj2GLSVMryPlDG98+7SIIdlUPRtJOGn6mRNV7i+AEUztXKdFVS7zN7Zy2iTjHvi4CY+aLNIEpAvjVYvXXJF4KR6POA8F9KrZeABgSUTTleIkdJ5PjnHX0OiSiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(5660300002)(66946007)(186003)(6666004)(508600001)(8676002)(66556008)(66476007)(8936002)(52116002)(2906002)(38100700002)(36756003)(38350700002)(83380400001)(6916009)(26005)(6486002)(6506007)(316002)(2616005)(4744005)(956004)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8vx7m7WWkLsmNtzLKkr2pM+3NHM9tCojEtwdZ0R+DTzXjKwrmQasjS//CqoW?=
 =?us-ascii?Q?AuJhMoYXS2pfPoxHWuLdz5+2u25nXfeLXdXP4gMdSVAb0f3C78SXzakVhCyl?=
 =?us-ascii?Q?4mAz/EptvgdCb06S4ECgHJEmtQOQDHAk2/3XdvBWK2pHVl+fbMpLrQEkoLoL?=
 =?us-ascii?Q?JcjmO++Dm1om/g9OvmstgBRo8LYQQK3HM7Acmso2rDWgRqoA59rmI3XF4hXe?=
 =?us-ascii?Q?I+YCTwr0bdgtsIEjx/UOim02LmWDzvAsUf7ypQOxswRonxczciqQn22j5WsZ?=
 =?us-ascii?Q?R2vEbMzO3teLizB1RQ2q+b0XQ2wDaQUpiNYsxKZqM/mcPIHmLsN3qwsx24pX?=
 =?us-ascii?Q?dUskFHJvHANFOmjqBE+HBvkCed90RWFShKgkpoDpv4XYRO/TN2fp8wk3aIoU?=
 =?us-ascii?Q?iphldsE/OsilvXVNXfGlQERr2mAaksgwYNQdgZmgHeJuGgcGkzPHJlIWj7Qy?=
 =?us-ascii?Q?GHe5WdU74LV7N+tn+hK8Ax3gSMje9+mzXGAMUyEspFUV/VAUkYVxGXlTv4Xy?=
 =?us-ascii?Q?qHAeGCRPRiwkVPp1vSnuA3j5hwfkYawn3mYPAQcigXk9L01rkA6zYtfoWF3m?=
 =?us-ascii?Q?hv2OTkVUHwezKc9b+fD0kADG3YmfPI4TZSG+maQGCrnBLZSiswSxOHhKwXKW?=
 =?us-ascii?Q?F6T1KEhla3hB5D2ZQGGYPc9/ixlCLq+Viu0pvs5QnYFIgG1yqHzmiUguaQ9d?=
 =?us-ascii?Q?FKF10cWMAiyFXtAqHK5+O54zcEvJjdUApBERKA5HIWT4Yv8Wnhns5Jjmh5Py?=
 =?us-ascii?Q?VJ8l3sQrv/0Vda4wOWlIzj5fSSvHM1AsK4wLEg3xHDMmRJ7AATdsZ7/NJbwZ?=
 =?us-ascii?Q?XK8pCsdk86UKB6+DfJjS+kPIde4fDxh74pBY2hQqLJTn5GoK+OrwiZIG+UQE?=
 =?us-ascii?Q?Ts3XAdWq+dQUvQAWmok19wd//pOe0EpD3FRHXs1Z1M5yHdC/Wi6xBKFhlBHQ?=
 =?us-ascii?Q?etkzpRoUXghU81esLZuj7mM5zuiDcqzlgyzE4nc9bLLRTBHqMfutoznXsJmy?=
 =?us-ascii?Q?utWThhHtD5N9/FDDDZ1xbegou57aDdc7FWMSysl0aqr9iABYbj1mUiKqynKh?=
 =?us-ascii?Q?IoEoievFzVUe76dZDPa6GQYahwQvS5K2JTwI2pKQ43cXZ5HAITlzp78Fe2v1?=
 =?us-ascii?Q?PfPtwfw7Tj4iauby6hcsQMgAKfk4Q+v8NPVVaK9/d6IikIe2nHuF8EFpbzAn?=
 =?us-ascii?Q?UtPS0lVFo/gop6UdVN1F7Jbb/AMOw7PcgVsFTO6K+edZxsP95gjSd3RGCDq+?=
 =?us-ascii?Q?BqgG/I4hJFJUHctK68isNLKW80q2V1HGy89XAzOUqLnOqAefkaJdOwPd8Xcs?=
 =?us-ascii?Q?i50zNbMxJ2DL+rXMWhvxWfqY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2175c5f5-d607-422c-24e3-08d99296be01
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 00:23:58.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERZPLWvrwai1kmxYgnq1Iq1xpttLQtOMk+s8dE83GJKdOb1PS6y7qviWBmVOZ2wPur9DlhylhGNpD0hDuxeC9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3427
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10141 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190000
X-Proofpoint-ORIG-GUID: 7wujIP1qxO9yNnLuqXV6aow2AaY0rM44
X-Proofpoint-GUID: 7wujIP1qxO9yNnLuqXV6aow2AaY0rM44
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following test case fails as it trying to read the fsid from the sb
for a missing device.

   $ mkfs.btrfs -f -draid1 -mraid1 $DEV1 $DEV2 
   $ btrfstune -S 1 $DEV1 
   $ wipefs -a $DEV2 
   $ btrfs dev scan --forget 
   $ mount -o degraded $DEV1 /btrfs 
   $ btrfs device add $DEV3 /btrfs -f 

   $ btrfs fi us /btrfs 
     ERROR: unexpected number of devices: 1 >= 1 
     ERROR: if seed device is used, try running this command as root
 
The kernel patch [1] in the mailing list provided a sysfs interface
to read the fsid of the device, so use it instead.

 [1]  btrfs: sysfs add devinfo/fsid to retrieve fsid from the device

This patch also retains the old method that is to read the SB for
backward compatibility purposes.

Anand Jain (2):
  btrfs-progs: prepare helper device_is_seed
  btrfs-progs: read fsid from the sysfs in device_is_seed

 cmds/filesystem-usage.c | 47 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

-- 
2.31.1

