Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83FD7B831E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbjJDPBG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 11:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjJDPBF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 11:01:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37330DC
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 08:01:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948imht030725;
        Wed, 4 Oct 2023 15:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=duLxO0h8lUS4rMym+w26ecDpt+BxTc6oXk4Q34FAGZY=;
 b=WkSwwVQ5ZhEuh+tCX1NMjNLxVj4y0n2PELTRSI2ZQXC5qQnGWssW1C2mOU1zi+N1aVi6
 Y0Hcke0IwPD/zml9VsW0oRIKWeKkdOLredUTo3V+S13w3bIYx9AJRzZMj4fa3vfI5hzr
 WQsQp9RXvGTYKGBWlPZW+aEtHssgeAA7iu7kbOhwQKMWSMn96w8jSTte1rX4DDcqT0qt
 YMCDnMljAdddom0vzgRQZIadN2dvb0smydmUzSBduKWHcJPz6s2UCMY9N5tjiOW1ghHL
 F2Zifiq8jAnXJ0vU3pYzbcgS8R/x/H32jjRi8uR+B4jxKBx64vvzQG45IAZt2YrjSGaa XA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9ufbgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 15:00:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394F07b6002877;
        Wed, 4 Oct 2023 15:00:48 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47p69t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 15:00:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LndDOIjFygGQwFbJ9+iBUAj+ipIMklVuHergV6saf3VAHvqTHM8qWzv9+gvDfSohqt9p3sxhgnT8h3CWWM7wv4PfX3DgPTdXXmKGA5IZIHjcwH9zlxfVI4JyiFJaF0mrE+KjvAPHCUdpKELIsD0JP3sfMhPDhInW4+reiWF4oxzMjFKa24p0zwRfqXRJlBvncwnSaRDrOYFxS1LLthOLTn9PpXQjrOn7Eu1JrsXtsDGfQMS+XWOtK4A2k+bKZDGNjDg+V0+1d0J9Z6y/8YYyWg3jSs8p8Y8DMcCovMQOnYc0SLYhvpSphb6a3dYdoAbvUJszfjJMx+V+tzo44Wqovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duLxO0h8lUS4rMym+w26ecDpt+BxTc6oXk4Q34FAGZY=;
 b=nMmpsRuS/T0Ri2PBFJPg7npaznOzgMgQALEzDEN9AdfEufFQtwEhD/rWKJPDtoEYVW4O5FItQueuFTlbBp6nkNU/2BO/2b4Z+f9okWXCEydCaAr8imiMiHoCFywRf48gbmo8b/6okgU4DUylLWtjpDGHafcwd49LOQRL70TY6aPUXtBMeXGFpAgxGCph+PDUUhCLTlvOU/Ticp/7el+um9VqJGXl336n8CzQyeYrj3uy+ufFfbP0IAm9+yfD6dd2QZUkPOt0FfHGOtelEZdruaNDaGtq3KTN/KXK4C6JH/V0JzzJ/jOUXs6MpVAxjsQhTnYOZhNaJkzipDXddZD+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duLxO0h8lUS4rMym+w26ecDpt+BxTc6oXk4Q34FAGZY=;
 b=ieNOkVD128cqcD1zxbnVnVEa8GBpOsJ+QL5cMiP+XLjj0ocagmqQHAbH1xiTNwjN78v6XWPLB23aHin0wVsEJ2ZdkKt15pJ84SBLaVn5P5f6ANzB60YHaW1wcFej5lEu6kkyWYTPD2eUPk7QOg8pVPFrcKg4yinuSd70v5Yswws=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5818.namprd10.prod.outlook.com (2603:10b6:510:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Wed, 4 Oct
 2023 15:00:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 15:00:46 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.com,
        gpiccoli@igalia.com
Subject: [PATCH 1/4] btrfs: comment for temp-fsid, fsid, and metadata_uuid
Date:   Wed,  4 Oct 2023 23:00:24 +0800
Message-Id: <9e564f1c251d757f2f0c5a62833999b512345eb6.1696431315.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1696431315.git.anand.jain@oracle.com>
References: <cover.1696431315.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a49cd8-e2bb-40f4-81ba-08dbc4eab078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4D8nj/BMCTV63qvHdCCc59DiG8DQlFWl7srdfbyL8QpYY3xsYe+Zyqr9aoZjVM/xHpSbrQd1GGyZu2THf7+BTyoC+T75NevFXtMvKi53L/kbVR9RB1edbb2y87bWlIzuI7AMRc+mGYkpriqKLwumYP/6mW8osi6RG214Voo9cEhxKB0SDEw6rLDELGq4EQl9e+85egjPCQoLXoolDZBGd0wbOd9Ek3vMia4XNWsbkOduUSE8y2slSUP6E3fYXtXg0uz3RwtLp4jdCzDmKmWCK43M2FXOWJuTfmFoASXfNI8jRqBlzCAEdNyzbVo/BcKHbOewfQpEvCjcRUtbCRD96qE8wJrfqCUxVHt69bl7mCFoVCxy1bYwkLrcTcjb9vxpSFsYBwsI+EJVjRmvTr/5uCkXTmEpUbgDsoMhaCzDwoX5sFwgaGwuJd0EQxtZxgivmRGITCbRwTA4xUvpeIyWHSHtB/Uyz3IE86NFmyRrY84gY75BUQN85UkbZnBsQvhFnsZErs6P7YvvqrYtxzVIP2GXh1asKyUdcWRI/YLiVithzNqLlHtiq10Jd3E5Fao6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6506007)(2616005)(6486002)(6512007)(6666004)(8676002)(4326008)(2906002)(4744005)(66556008)(26005)(66946007)(6916009)(44832011)(5660300002)(8936002)(316002)(41300700001)(66476007)(478600001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1qU18dSAo31GUqqdwwQBtTLMBaU5SDLyRdSCl/72wrjKahzTWIb4sWAR1N5C?=
 =?us-ascii?Q?H5rhJbWr87/2fLg66M1Uztetm7GAkfyESSZCZH37KJG0EX299vfiOaK5lZsC?=
 =?us-ascii?Q?+eOXZybd11CK1RgwQY/K5KAzqVI4wpNW0ySly0eNkuQC46kcpSQUfoKqcKLS?=
 =?us-ascii?Q?+C3ZUKY9f+K9W4ZIKIs85BwWRTEYNCAIh1FCTwV/E59aWd3mvAnfw5qbW5Hi?=
 =?us-ascii?Q?1eheSnc8nEiVe3r36mhcRA0NVplO6WihMHCoVBJhoW7bWU98D7v/I1cXf+CP?=
 =?us-ascii?Q?YhnpgdZ7bVZond7kJIgl8PGutTMjcL4XthUJSf4Lbw20A688+IYqbXR2UsNv?=
 =?us-ascii?Q?kyBCQnm3IJSF35f6Ztstz2YrRuT5WNeDZiqt0qRHnuDNDNZpf8yTQeoeoxLJ?=
 =?us-ascii?Q?Z4qcq6NStN9EjKMdUIWo8q7naTd6oB7ot2LNGUZdZ8roNcyNJNOFcCzsnTWG?=
 =?us-ascii?Q?8u5K/obXe+wnuqQ92wgoBycFGr9KGvkLUmdMP9ZAnN56yVZaFhT7braIh6ow?=
 =?us-ascii?Q?UYjLJMQLo3LvIhWumzFsXyQrHI0DTFu+Dz3KijFJRQ9CHIxhDyL0g3supHHD?=
 =?us-ascii?Q?LmAgLCs0eqSbMJLkrkg1YgWzMxpvX8xKIi0iIbJFyiYLmohGi2wST91yu0uG?=
 =?us-ascii?Q?rNEAJ0G2fD4l/NGvgEIoCSRnnO4q1pFX+yskZdMW8LhBrwGX3wyo9Ws4ZYfH?=
 =?us-ascii?Q?tobfKVkuGnna0IXLeOdNxvmHJAaSeI9EyVRhmJ7askQ1Fa7uyjGYrK4jqMDx?=
 =?us-ascii?Q?Yn1G+t/WfYAvg2HIrXPKe7oTHcQBC1ZCO9y4h4BgRK98oD1pulXYA04zPjMJ?=
 =?us-ascii?Q?rMiXqBH1m1EwdCoVo+6CQuKikipzw7zgi1QF9bBpABcIy1wixymS7ke+NVCC?=
 =?us-ascii?Q?lstEb+yyXr1RY6v1AgdNX7h1N+m8KqdrWHb1AhFdBZxMtZfCBIumWZfnRVK4?=
 =?us-ascii?Q?kH/7I7KvB+1WOalPkLXK+WoVnYSgLPqi3gOqOOvl9mv/QKyXbFs4lrJHVvNZ?=
 =?us-ascii?Q?23UBqA0gjpO4yFMYylURY4kJxNrWIYlZ2qEF+6l8jZ+lKfqC5YweTIIYO5OU?=
 =?us-ascii?Q?WWS8qvqtv4Gkg/py0jwQFjy+s00ipPwWe07a+J1+zsg87Vvvts1V9W/CDd2G?=
 =?us-ascii?Q?Kv6Al5eDq2+OowwQRoa4WUBPmcw1EP7yM0rQvh2me4FxCyRG/q0JGDQ6fT+I?=
 =?us-ascii?Q?Z0G96mOBrMUk7t2Uf33S0vE+K5b7Eo2A0wTLQF4omyJJ+N0GAIjObIhNf4IH?=
 =?us-ascii?Q?MiZrme25Te/+hyNYg5BkJHfG6Xkijmezc6JPqpneXsoxXbWNaLBX9ghy119X?=
 =?us-ascii?Q?JbiRhseUkLF8X2rY0RS9Ni9lEnhngnJRNub44u2kQpqRENHS5ZWEPxVYYoXw?=
 =?us-ascii?Q?xi4cOlF0uHXQ/0fbW9ZXrXgy2amNP8cYcifYdunBctLhCc+UmDEPA/bPB70S?=
 =?us-ascii?Q?KYLlvZb1N7JjzcMiyCWzJi17Hew4SFDp34d4Y57KHCEIQoldcyyJxVx1oLiQ?=
 =?us-ascii?Q?kwY2NvlMg85diVRFGl60CdKXeX0FlfpVr0z38Vsd6IC5G0Zdb3hdZoEZ7ij6?=
 =?us-ascii?Q?LvclkljxqD6Roadsz56qzwHQrVhY0BU5DPHnh9bi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: quPP6HKLL60paRZltzfGQlWH+BChBWddQzGz8cD7aLaMA2JvFR0x+z7f1h798ycjkfLPVbKraAWeE2qhyFTFmaWEpNSDmy+mONNW9SmNTr6GhGY+JhbN8986f/xYcWbjWTcWuzlZB0+vqwXuQawQmWExk7dlg4iKxYrN7FD9cieiJuMD61+O9rxEKi2nKuz7bqxQEgJiR3SAgL+8Fao7IXYA4xnyp+SdOOJ94C2/7+2mThuJ68t0raEg49WjWPlZGjKSl291bTsW+C/9nC8VM7N6A6IA1QxQGpjkFsYNcfc3MF53vhiYmpVT9XQfLd89t/Glx+9W9AKJBZ7bN0VoQoWyeZSXwYJ1YEYncUZh7pxCuACO73SXVKYWlAoNAIFZpDuPM7ukkIFDTtld6ZgBnVyH2uOJT/RFzS4PssTaAMtTvIf4mMrNxYGN2bTbZAosTZl2ossPgOj/GwKY+gBObYmTcuwDmCsY7tIfJ5XOM2m71vSAnngY+RgrNmi2EM5Dbqcp4l9wlfcPRIf/4C2qNM1Ss8vLuUkyggq/oMoOnUKrMLYxAVnOOFJaBQBrhPmg6eoUaPyRYHvcC4ZZA3tPoziY2fVgMH56SJjdSJxsVZNNFFATAqOrFZfomBLywypP1BnvjVBPTa4UDOkDAEo0MTD7ignr/nHvfsumddhCxP7aE1eMgv3pFPxJK600Wgl9DLOU1SNYPDmKCyQQROMhC57sF/L9e7CFUeuBLBftEqly+0GKowZYiR1PkxWvZoMLpAOzWVtGnOmY5rXY19o+XtgaVG03gJlfd8Yya9T364HvxJG3rRoJHivVI60jJiRb
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a49cd8-e2bb-40f4-81ba-08dbc4eab078
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 15:00:46.6151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xel0XGHMftqn7+IEsDq+mjrZhI1l+IRyfpRzBz5lnqQneWRhcC3x0EAESArpgVIHXNpH7zKQCStkj0nKS2mBug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040108
X-Proofpoint-ORIG-GUID: vRtcLlzyXSlBPpBswSYIp_X6z7jKwumI
X-Proofpoint-GUID: vRtcLlzyXSlBPpBswSYIp_X6z7jKwumI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a comment to explain the relationship between temp-fsid, fsid, and
metadata_uuid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index fef46c0dbf19..5dd4ad775e5d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -299,6 +299,10 @@ struct btrfs_fs_devices {
 	 *   - When the BTRFS_FEATURE_INCOMPAT_METADATA_UUID flag is set:
 	 *       fs_devices->fsid == sb->fsid
 	 *       fs_devices->metadata_uuid == sb->metadata_uuid
+	 *
+	 *   - When in-memory fs_devices->temp_fsid is true
+	 *	 fs_devices->fsid = random
+	 *	 fs_devices->metadata_uuid == sb->fsid
 	 */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
 
-- 
2.38.1

