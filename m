Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6092E6C6159
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 09:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjCWIKs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 04:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjCWIKp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 04:10:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ABD7A87
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 01:10:43 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5hoFO019279;
        Thu, 23 Mar 2023 08:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=pK89AvaPWcNkacD5dPqAPkyPoE/ycumGK3ZymQRvJuY=;
 b=gleV/Xkf6EzAMgFTzxI+eR3zmqnu1P8TpbPnsiydqbtrrK9YJ/K1WEOpkPUmoCHweQSJ
 2dPogKtsfLCHnTJnOtvsg4ZHkfFsjsNX/qzrtKSxurUR60nGd9GPTWL+m9VK2+YsSohD
 BEB8Kc7Nh2uFcO2IVOQdDhi1KkiXSrSDndRwBYYD9Zjp3jyeD3300p0RvWa9qORkaBA9
 90PM/sj4T7f46r8Qf66W2c2uBL2tAiR1/IcQQxvULwnfRH1xT1U7QuFpZiiYNVBuwXya
 B9dEi/Ab6gBZmqTZouV9/8fZl1aOuM//UA1WCLL7HV+7wRNHp613lhCdjSVa0TwJOZr3 ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bck4b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 08:10:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N6iX0b017038;
        Thu, 23 Mar 2023 08:10:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pghrxkdy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 08:10:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq3pCjzjPM991hYUW1VGMdSN0vVTgW99MwQ8b7wx1TfhNl73CSpjXiKiG28EpRaHcxF4kmzMIlT+EqI1f49QFL6COhvk5FhJSKK0bKn58eS/7CXhMuPENj3B6XvDJvlezWTFapkywHGuMdt+MFUFAPqz6ZwgSaQRaVSZc/+V9aAEDbHE898lLzO+wllkaderfhbFi+VEUpK8xoDwFoGmgAqfnh+45ibccwnsxMlJeG4oQjXKHzEyDgoLxo2Exd4wtVTf0SRrXbby30QH5JiF4CxV4xp7Ejnp4C2ddfQTgqItdejyvcHiD8fXzFTLTvIIh1c8UmQXOi7ktKB4Erg2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pK89AvaPWcNkacD5dPqAPkyPoE/ycumGK3ZymQRvJuY=;
 b=R2snslf4Wq7s7+voeYwbXbADJ5yyyVO/3UQQnODw7wNIghvuH1PAM2piOU8oBjuSbHIgSL77hR5rasXHLIBCjLe2gujpCV+/TtmFEn1mWg2xfV6n+tvMTlgMYmxPEQ50YSSjN1JLKpT8OJbafsJIw5Bp+Zb36GqNJQvDtvXcgGzGYqLJUBIg1w7pXkhNvpJe1JHhICujW+tsy0P9CLrSYBLXgH8L3GAz7hvRKqDf5FaSNhs6FRbQLUu9wfXd9+S+kaiI+HsEjbFk8H3RVQ/wpBW6LJjzWQMeYT1hV4qtnpW9oZhvcnayaV8MN9R5cxjGD0uVgKNgssv/P+4do12Jpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK89AvaPWcNkacD5dPqAPkyPoE/ycumGK3ZymQRvJuY=;
 b=D2qgsUnnTykPC62E463BKo6YFnviCML92/jbHQDAz7m+yFZKMereapyQMdxKXJhFmsO1FBiQrr9QTtlbXUHVfTllhwzUygKxU3JPjubmVdTas7HXMrrgvwr7x5rVpOxpgmi0JFFYhM3Xw5r162lAnyjZ/8/ILtGklaFE7Z0sgns=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5693.namprd10.prod.outlook.com (2603:10b6:a03:3ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 08:05:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 08:05:37 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>,
        Sherry Yang <sherry.yang@oracle.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] btrfs: fix mkfs/mount/check failures due to race with systemd-udevd scan
Date:   Thu, 23 Mar 2023 15:56:48 +0800
Message-Id: <998486a6a1bddf36c3d3dc92df08eaa1b3a6ee7f.1679557827.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c3f2ae-e05d-4ed7-ed1b-08db2b7562a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjGTuYuGkUSdyJFrahM6hT8bS8f5DW+l3atX+Q6VBEOL0/qKzARsdw7f57reWtQTPSCdif/Ji/czRdKefoAvWQeNkYMO+tcNKlizwtyTpEMXkcnrjuCwVaFS4KonqUlMnKGpGaaKAaT2iZ+kbNI2n69qPLO+BjFkfLSoxS0UMT8OZimuL0cMn2+u++6mWner++NVzFmSJ4e2tNIMEL4h9zx0y12sxwwo7C1ntyaungLaL73wpoQYZTAXAhqJOlAcDAWsprRxKz/0HoNbL4DWzrel4aYKdiNRh81qFQrF7r8UrUscZbUk06wUe5CdlHwwjwmZa8kfAX8ThUmd19GEcQXzh47geo8J0XmpvNfKYWzQCKS4yfPN3LuErqAnDzUV//ooV/XpRVFHAijOqGMBM5Kh6DRsrrEII8vm0Ez9NDdsx5IvQT2vqYQKRn9HoxrTOE45P6gqLLbLUZYYOyov2u3viDHMVOs8kjlSRmvI9ogeHdWjPszp2Afx26wmdpIkGBxFPfPoRM+/z9zUs4a+SzOUYE7B7NixnKOZNZkqDBZU9B3HHzzLOviD8O5Uk+NU8AQZU6rkL2LQ5awg87+RMW2HZwJdVZkt5q4DEWrvHbuHnxgT40ZdIg84hhMVKVm4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(2906002)(83380400001)(86362001)(186003)(8936002)(38100700002)(6666004)(5660300002)(2616005)(41300700001)(26005)(6506007)(6512007)(36756003)(54906003)(478600001)(316002)(6486002)(966005)(8676002)(6916009)(44832011)(4326008)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VujSbt5lO+9WGdiEg4BcBcrUiT/jSXRhFW87QO5cBTK62K8ZKgWrkkPP/Iqj?=
 =?us-ascii?Q?7IqrBTijYBJrOwIyoWUDy3VJCwz1OzhIKDS1sktWWlZcJVT+VuzgckHeSiog?=
 =?us-ascii?Q?05dWpuBO+ndsv3wZasuycGaR92d1G5NVrgDhryxcdwlek+08iaynZ8O2QXam?=
 =?us-ascii?Q?irEh30LNJP59+wXQEBY7fPfOVdOcXlu/+d4Tu8ZHO6ksCS08w0ZRzEpss/Gd?=
 =?us-ascii?Q?v9VRt8ebl5Zz3kOaQByZpQitMtqAte/eDkr79u1LvOJJ3w0paiUKfRoabsp4?=
 =?us-ascii?Q?ZLPT6WBrDTGqbWzxXTUozc9yJZy6n912U4T56r2TGBEokoyvI0wprcSuX9eY?=
 =?us-ascii?Q?W5838hcZdE975rbew8z9r56TpTSWBppEJ9Ag3GjKEw3sDlYsgbtZGAoL6l0d?=
 =?us-ascii?Q?QT8IW4YEAeP5i5ae3Fvs4veF0Q2JivwNtrgnAtErcmMJRCaPB8YkZ7TxjhZr?=
 =?us-ascii?Q?Hc41k3vk+OX5TH4jHZYtPQRbjjfdbKITuaQnhnVKWUoGQgiqDnfCBXg0/4n7?=
 =?us-ascii?Q?rgXUBP7I/J4DV0xo/WF8/O2JIX4Fnd4NdtAEwZ4+G6w/DMZuffakY5uRiCbs?=
 =?us-ascii?Q?by68O//FVET0TKAQQVp8fOHRZZYAI8UGbySDfLkjccpC9y9f2+YdL4BpY63C?=
 =?us-ascii?Q?+edWI7ah/+wnmbrS4WkTqYF56oFqIGZ9la1Im/rXEQYl2HUgFwuGwYMQCI+Y?=
 =?us-ascii?Q?SsfRg+HSslgBDnw88lTisyG3oOJdTNxvLg3XlRptyT1eFnVNhbexzUvNlBWy?=
 =?us-ascii?Q?yR6o9sfyK4MR/S88mWn7VfP/lz2yxEiXrlrg/4egMxXdrjxvAtyYxxS39Tfr?=
 =?us-ascii?Q?TQqwNWfwOa5WvqYSVAKT/uTU6q29/xgEGQgwxrVkYZ/J95QxRJR1fh/lq94S?=
 =?us-ascii?Q?rT8Ty4N+i72UKCUymTUedxnESThjQ9opdUmFpCcVcxb6ehS05RDQHXhq2kXd?=
 =?us-ascii?Q?baaUxCCTmRgKCpu42SHNURMq52JrzliXjEd9X0ZrZh8PbaHLCfyovNxDVMu+?=
 =?us-ascii?Q?9qNeDnw+ITVpewcNjBN14vOwJHh/N1uq4h30Ctvtmq8+nE18e1mwuOpov6fJ?=
 =?us-ascii?Q?nSTSLSQVziG4foozlG/uGoPjyFHg7Nrk7z59nw8BZVL0c71Yn0mtLp24NGLj?=
 =?us-ascii?Q?a1I3YGqjZw/qe/yvINgRycDI6yDHh3nCzxhuuDTBsHOacYU00C4njLQjOY64?=
 =?us-ascii?Q?eexPf9OzeuO4SMwfX8eugGvouRCOeKXszsB2vhwSfAHADw1qpe0lm7ZIt3rm?=
 =?us-ascii?Q?ySHLjnfhvLOsAcgDxE4Iwzz34SzW+apO9RkQ8A0ZddkPuHe/M7iMBIAU91Iq?=
 =?us-ascii?Q?rnTod998jEbN0yanrnt5KJzAU+v4kL5i+HAyAjWOn19YWqiYXCgIp/3dowmL?=
 =?us-ascii?Q?w0nHBEbhv7ySQmdXBLoMn3AzhFiRDYCq9tczGtKrM2JMqdYJFpHPSpSeQ6Az?=
 =?us-ascii?Q?fvRMpJAwruYNauZDeNBfx+p9iSbsC6VDjHHirM08X9ApBPJDps0WwEID4YWM?=
 =?us-ascii?Q?A5FzcunNGBadzyPFgzSoui+2+bxIuvaGh211rFyMNeWnJC9gNAmH1593IxdL?=
 =?us-ascii?Q?ahWCiTI6nwax7LhIUSA0KSjWi05cBfthLSm7Oslq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: luhepXKHSxFZ+EfW57K9RsO77YLsLSNxy4xt/TC2idUnbV7VZ9ED2bD8Ae8JRvtu9JqyRY7ewzFxSI3TRFWkLUDKzMTYKuV7Dqjk6I5ukhbFR392UXJrLluf6hjIT1k4QXpOJO3R24yc+nWvxX4lAEgvGTXY/T2frV9EsojzR3qpluGobhSk3Ea4WuOkLc4q12Pa3c0/hUMnA3jQQDQAhuK1pOdSsH/jVE7C8u7l7rSMxvGHsT0gZ5eruiQqjJ7pbxuASFTl06dLroty2inqikd/aExRmEvSGLwl+JwplaI6i1bYxDSH2n8C2TNvcwqMrViZs2clgxhuoQsj9VZoIKNn3bklIFNQJ85RwmqIvUFuavOJN/nVFS0qF0GI5mOr8veL/rvO9KowbnKImaHRU6txdlOe0T2pH8uNS+zVA4DWNK/xDCjU6kv1WFu3Q8lwUHrzqA4QO92j/T7oI6Hf2dAsxtVDq0z/bb0+7cmSlmfMGuVyWQYA4sPGth29inP2nNGFcCNgKUnRJqYEYN2v6J/UbySYwVkqTPvWHWMN4VzqQRVy/UDbm/kPBF7pIucp+NJpjOneipaZqxWpgTRJpqcAXMhIOkNhtvJe4g/7ChzFdr62h7HzMLCmFY6TGw0FLWFEwtAb2jhkwqt9C+slfz2J/SW6KBjrLm2TYJNUjX+qYNKjSIJaML6O6KJBqRyApEvxDcmnQ8/0XRP9qumd4ElFNvTdwfYva4wFD3qwxYFlazyT8+n8llDGslTmz5NkWwsxLc01i/RxrEudL9ZhQgYvhac+GGsCXIR62IZYXyw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c3f2ae-e05d-4ed7-ed1b-08db2b7562a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 08:05:37.0697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fitGB9W28RYXRndSb0Xy1YGfrZ3+CA/HLFYm71E12BAXoFBcJn9jddsLwT6mFJtp9GGP/UUKd3zOvm9Jd349Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230060
X-Proofpoint-ORIG-GUID: kd7zDcbZcFG_sQQIMX8-cyMMdk4uHINt
X-Proofpoint-GUID: kd7zDcbZcFG_sQQIMX8-cyMMdk4uHINt
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

During the device scan initiated by systemd-udevd, other user space
EXCL operations such as mkfs, mount, or check may get blocked and result
in a "Device or resource busy" error. This is because the device
scan process opens the device with the EXCL flag in the kernel.

Two reports were received:

 . One with the btrfs/179 testcase, where the fsck command failed with
   the -EBUSY error; and

 . Another with the LTP pwritev03 testcase, where mkfs.vfs failed with
   the -EBUSY error, when mkfs.vfs tried to overwrite old btrfs filesystem
   on the device.

In both cases, fsck and mkfs (respectively) were racing with a
systemd-udevd device scan, and systemd-udevd won, resulting in the
-EBUSY error for fsck and mkfs.

Reproducing the problem has been difficult because there is a very
small timeframe during which these userspace threads can race to
acquire the exclusive device open. Even on the system where the problem
was observed, the problem occurances were anywhere between 10 to 400
iterations and chances of reproducing lessen with debug printk()s.

However, an exclusive device open is unnecessary for the scan process,
as there are no write operations on the device during scan. Furthermore,
during the mount process, the superblock is re-read in the below
function stack.

  btrfs_mount_root
   btrfs_open_devices
    open_fs_devices
     btrfs_open_one_device
       btrfs_get_bdev_and_sb

So, to fix this issue, this patch removes the FMODE_EXCL flag from the scan
operation, and adds a comment.

Reported-by: Sherry Yang <sherry.yang@oracle.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202303170839.fdf23068-oliver.sang@intel.com
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

 This patch should be cc-ed to stable-5.15.y and stable-6.1.y. As for
 stable-5.10.y and stable-5.4.y, a conflict fix is necessary, which I
 will send separately.

 fs/btrfs/volumes.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 93bc45001e68..cc1871767c8c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1366,8 +1366,17 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
 	 * So, we need to add a special mount option to scan for
 	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
 	 */
-	flags |= FMODE_EXCL;
 
+	/*
+	 * Avoid using flag |= FMODE_EXCL here, as the systemd-udev may
+	 * initiate the device scan which may race with the user's mount
+	 * or mkfs command, resulting in failure.
+	 * Since the device scan is solely for reading purposes, there is
+	 * no need for FMODE_EXCL. Additionally, the devices are read again
+	 * during the mount process. It is ok to get some inconsistent
+	 * values temporarily, as the device paths of the fsid are the only
+	 * required information for assembling the volume.
+	 */
 	bdev = blkdev_get_by_path(path, flags, holder);
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
-- 
2.38.1

