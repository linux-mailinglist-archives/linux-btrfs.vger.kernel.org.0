Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAC369B68C
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 00:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBQX6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 18:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjBQX6n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 18:58:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C05B2CE;
        Fri, 17 Feb 2023 15:58:41 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HNY8Q9031224;
        Fri, 17 Feb 2023 23:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=3w9KU2bUb5LI+QWDB5hK7rbXlU9WY2kQOZ8oA6F2Zz4=;
 b=P1kzN0nOE3mSR9YJnbuB6Ep2wRylmUx64EM7ELcQJjoFv7r690DzSgIyYRlfhfmJ0Mzr
 l1WKSn9GFSbBcVz5BzhcEF+zYLvDKhOIEb6mIIOcJEVflNGcOnPhSctVyJLbRvgtfqvQ
 8RIEjeVCfCs2n4pJJ6jthW8ts2z6mMfLNnUDCnr8vt+F0sZylzbkuiTmyj+Se+DRJ1Mc
 /eo4rO2QwVXAvMCCdXw3DJaOkuJLBYFv83tHQP44JSApfIKtdturgYhXb2265FO6/Apu
 00LjAhiUyLjpUBTReQrJHDS4o9PBGiMfXQ1g4XdntJQfYtM4bCQ11Nh1WWo+xlMYnkUy WA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtq6h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:58:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HLZtLQ013834;
        Fri, 17 Feb 2023 23:58:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fadkmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:58:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDIHEFehOII7jiMUV3Qvks68fwGb3/zl+8fGHgKcksW8C204RqGQxwzbgaIipkfsfhbnfI4YF8cqn4J79SMQmqO+c95ZpXNgR+NNxTTvyVWExkZ8SCDkywgudEkokwDyPMLP6CumQPU55ZSDmpPSMP1l0WISYBAigFZBnKL6Q+ZEi4mBkGp4Tj5YIIOCGZoS21lTQLpeBcsYW1voTUq/M5uM/GLQt6taMd4ou1b4y+PVqnUgJecYixcxSegSJQS2Zp2PUYuhH6zopPluYFmRhR7MGQASDQhLE9LY38MogqbAYASnDkQGTs1QaEdPJuLDPFfBHJ4J28umpR4GpDOirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w9KU2bUb5LI+QWDB5hK7rbXlU9WY2kQOZ8oA6F2Zz4=;
 b=njBxzA+l+SNj/EIV7cSTnfY9xqUSfK7BRmXE6Wh9qUynm0dGBIH83ISN94My8R/3U4hdI662HMS8solBdbEQUa+v0q0+xE+9uJ0evbBc2VZa3eArwHlt+wQ8jAWlxto3IbrV+MaB2tuCaGuCOavvhkmNcJD/3MJkITJ6pN+nXtW6nt1vR4nJVE7RDUkSyoZ3lYynMPBqOtNDzXaqYyPMdxqU7LevOf7z1+20Z6QAddATYrJJUPNcUKpcIwbGNEq2qWkzzcB1pLiLO50vlavQL9rqLNayYrtJA75RYwx76udNtGWQqVj87uGk5cRwwzKaofGuZIoaylR6MoUULl9HkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w9KU2bUb5LI+QWDB5hK7rbXlU9WY2kQOZ8oA6F2Zz4=;
 b=NZJ6/qAKBv9MAIhlN1FGCF07RY/aPSOveMgRaU+PZBqEb+xO7yc60RSm0sxx6i0081fZeFPcI8X/rloMC5RcMZF6smZ2uusRiPUfhX8tnOeTWGewJd1U+nssN1hlrDaxKF7YU6qhwhe2oiS7FizAPcku5HUuzxS48mQFGfEZieE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5696.namprd10.prod.outlook.com (2603:10b6:a03:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Fri, 17 Feb
 2023 23:58:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 23:58:34 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH v4] fstests: btrfs/249: add _wants_kernel_commit and _fixed_by_git_commit
Date:   Sat, 18 Feb 2023 07:57:58 +0800
Message-Id: <c4f20c8041cb28ce55a1a8a0c1a0b605cda68136.1676678109.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
References: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5696:EE_
X-MS-Office365-Filtering-Correlation-Id: 477f50df-0f1f-4bbf-2c8c-08db1142e0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xx6sFTBB1+68wYLEWJwPiYexseoKUbQ7859RCMi6IrI4kslU0UckIaQTmwSIW/YRIzpSBNGdDBYqMzzKdQgg9gcSqnsmAZhmobiFsg+1WRyUZQLANHmOEJm9N0M9qacjnkHcknWnuzoccAamk4hRS/EehQhfyqCU4oH/4i4y4bYbS8YrMQedJItK9zx74xwkQ1phaCnTFpwdxF++OoccjV7MVEDqwWu9q3v8OVR8CPnslSnvE/UtjAt952Jg2ne/eIbzwj93+rJzRzeqiX+5915iH3/9wYtPI6wvkGsD+qx1SWbfDZ551JJOS2jYmiB+2N13lo91OxH6CN1auFGr2uft0KJzXrkufZEmLMMpWcbHCv7pz32Gfu1eucHYtGZGi884jsdNvOk6pCAI9sYI0Uf4CWx+lq6kTwleaipdE2gAoj8Qsa+3n3cWV8Wv6aq5/BPsBpWJXVDyPh7Zbfv8yBhs7+OsnLVmGNaP5ViqmDhdfmGVs9pWQ6sGWa6YmZSQJqxTPdVreLf7CU3hLPCCmGxuXr/XsxwCuUHkrdq2yMnSLYJ53Pn7flEZFi4dvKuHYUGNIasGNbIve3LktVK4mjEkSG0Q15hxT1MsqA3pmgbMZTp80M/i7g6KETxuR62RtD2jNAnLCntxA1zynIp96Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199018)(4326008)(66476007)(66556008)(8936002)(66946007)(316002)(8676002)(6916009)(41300700001)(2906002)(6506007)(478600001)(186003)(6486002)(26005)(6512007)(6666004)(2616005)(36756003)(83380400001)(86362001)(44832011)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mkk0Gjq2P4FGb1uPCANmmBncLSZC6hI1nlTzNmzJ4q5ZQUtlVnLM5VF7zUYu?=
 =?us-ascii?Q?pL9Jpb+tHKN3X/1BCpceToHPV+wXgUXf545ObxaqA6kkQsJDdMrIYHb4KCdS?=
 =?us-ascii?Q?OliUP/C/OsEIQ3SjUnzbkI8/YN19NlFjbeA0hMMHO2P7QcRVo/wRtD8hjhZy?=
 =?us-ascii?Q?up6r4VfO2nlDX5ELLYDIhm+iOLzKF8txrrRQxzOcETQ/BQG+u17kUZqcc+dY?=
 =?us-ascii?Q?gBUVgx6yc4MDPhKFIUesX+VWV/DISiHBaZgZHo39Dunh0QQiHFbh3HdiylVi?=
 =?us-ascii?Q?cVF2OCP6yQ18dbLeofej+XjAXHbp1T+/3EcktSPqz2D3Ip6A4IgGwzj8lzqE?=
 =?us-ascii?Q?0F+Yt2c+O3ZQAcb7sc8uX2NNFf0EG8P7SwK+6wuX697CIxNsGbX/D6GfgNm0?=
 =?us-ascii?Q?lnHmCcuCeFEm8OmvuDz36eIJQj1ZjoCkifmvus3W2p+JW+zcneHjayCPN9Uf?=
 =?us-ascii?Q?cB6ur1HMh3hgywN6RDTV+X/ZUu/sCvrK1UzAVLUoUedi0EzlltmnWa9ZQ0On?=
 =?us-ascii?Q?t5VicGJiaZIIFfAj9ZgORCWL46/u4o8HX0lZclT0vmUBZxvpGrSLtWXBCGB1?=
 =?us-ascii?Q?GOngewClDwelhb78nnfvfMfFz6apQOgvMsTOdVIlG5Q7kMsxGsjl9ksJ3D22?=
 =?us-ascii?Q?xwmUM7u8Kc0zV2sC/guF+VdlYnjswnzO48cAZ1I9bZZvmT9N64QHn6q9N1kj?=
 =?us-ascii?Q?FQHRdOGypWB2E+eu7F5GJLr16LNafUEgN2kMIqHQPipQbs39bMJWdHyYLOEQ?=
 =?us-ascii?Q?dweLsRZsrcZ1RH4BBFmb+A8Gnj8YSGB1pfOm9donn9/yI92SvviPARfRIJ9B?=
 =?us-ascii?Q?4bervyE3ZHBP915taqgdE4vkKk8JkOFFyBfoUs1u9en6rtFv+PToCEnQM3yh?=
 =?us-ascii?Q?rsCS7GVtnJ1xZFOAkUOS3/VGjkXfunyJA/xvuQZBuvSbxh6KdDL2kXRXxvwc?=
 =?us-ascii?Q?sLP/BiKiDxQ8eJqdm4ukKMGKvn31vNUsF5u+vvj+ZWnQveYTF7h3VtriLAfP?=
 =?us-ascii?Q?S1REjFGy2wiNF7awfX78o+OcRvVIguW97Y1T5X/iERuBvkWsCHI2cwIulA16?=
 =?us-ascii?Q?8ioXmENmsHkksBXFg1s1QyRbMyFp2SiuVFiy8JiPY2RgBaUty0lk9U+t3kHW?=
 =?us-ascii?Q?pAl0IR93PnpYvC0hLA+zH0NvlLO/+P0ZEsuFS9Yz2+oOpTOuIUYbG4n8iPq+?=
 =?us-ascii?Q?j/QorWWH3Ovrohornt2CHM6guv74LkqjvrkINJAhjjCTUKsoZGQB7XltqQM0?=
 =?us-ascii?Q?fmNVlYqnkSLkWj6QZEVof/OsQ88gQhvs6TSABRBCL7s5fCMUXI7s29CHjI+g?=
 =?us-ascii?Q?z5c8f0cAnxDH8rO2sgTpzTmsC4yjKcH9i7I8Hch0yf2lccSrJI+NG9wIjT5z?=
 =?us-ascii?Q?ZJNByuZ2suSx2zDxaX9aJT5rMmSHoPfDxfNFsZlUAGKR7YyS3eXisVwVJtWr?=
 =?us-ascii?Q?vmSlFcdn0iDnienM6e8wPO8Uu0L+p/oqVyFKKWBmaiL8VxNjxyPV2ypoi/iD?=
 =?us-ascii?Q?1EkrZuxfCYwKVHpodYL61YkbNFIClbiYs5ovuRlS5Bu25z+We21br1x9FoTt?=
 =?us-ascii?Q?h7FSSg0CCX+FbdCqys2qFTXbmpUK1g9cIYsktKyLmSbu+7vVFlidOyaOAQf1?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2mQvlSXxeCZ0Y6T6qA1/OW2EqxiVlza94g0SciW0KNbOPUz9HYPTN6dyUv6rKk1zxwd0C/4PfHY1Kk4cWtVwBlM2O6xSvvILDffPqSHVOS2BvYsXgrAKEtZJZcbh/s5LDspdSV9swm+uCpaXuqH98iMI17aTyca7I+yFkAuoLjqDNgbnpGcKnG7vl5bkli/ylkSZct8VWgyJolth1VWiU0RpJWwfxexPn6lagwUqOZLEtRYHbLBbQ/Nyo7qgMU7r7+Kr5ohaiKNwrXdZIybgrCNYHtP3mBMEwgUf8ZIExh4nuF70TFEvu0HHtJ/TOHmvpcaF4saZFhGdzAD0SYJ7TJeKreBbc+gsgL8TeHB55OCJd/A0dYLZFw0v+N+9ftKGULRFcSq9sof8uanVkybXKHcnFug7NgwPnwpIQdE5xNg9A0Td7+9xHBOhgqDT0cigGxiTIrEmpBJwRKp6x6naW2D8a3IVlmTaKVmIwzIHqXId056CTD3O+af4EHKXNyFzhIcegGwIlL2jx9439PMH+ERw5nPYwe2FM8z1sqkXECfOr07uuKsAbaPYHWNTuoMtfANSZuS6nJytlV213HldLH0EAK6VAgtZR89XDebRCMLaSwR/vSGEqeYHnvh78llsjLZW3cxPdykWIo7EoWS6xvscDQMS6pRhDBPE3xGAWu3AHvrhkSHGGsOGsvI2n7SUip2Ink7NehPMmokE+DyNzVf7f10QfRm/3uwRrHPdE//30NY/y4AP0YbfMf7MBMQwnKMbqLfCDRwFKkaKrngSgGkWeRuJLlV8gEkVBY0D6dI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477f50df-0f1f-4bbf-2c8c-08db1142e0ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 23:58:34.1635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bz33ZL3nSlygRjiZaJ0ZZvBC3/oSWQliDbGftZILqmhwj6ULRr+01M2pSCZ9yTkKadDp5urxdXZAxNpq2MBCMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_16,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170207
X-Proofpoint-GUID: tYCoqZNxcB1qWHwG5z-_MgqSI8qtWN4j
X-Proofpoint-ORIG-GUID: tYCoqZNxcB1qWHwG5z-_MgqSI8qtWN4j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the _wants_kernel_commit tag for kernel and _fixed_by_git_commit tag
for the btrfs-progs for the benefit of testing on the older kernels and
the older btrfs-progs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
v4: Patch title fixed.
v3: Fix title and change log
    Old title: fstests: btrfs/249: add _wants_kernel_commit
v2: Include the necessary btrfs-progs patch.
 tests/btrfs/249 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/249 b/tests/btrfs/249
index 7cc4996e387b..06cc444b5d7a 100755
--- a/tests/btrfs/249
+++ b/tests/btrfs/249
@@ -12,9 +12,6 @@
 #  Create a sprout filesystem (an rw device on top of a seed device)
 #  Dump 'btrfs filesystem usage', check it didn't fail
 #
-# Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
-#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
-#   btrfs-progs: read fsid from the sysfs in device_is_seed
 
 . ./common/preamble
 _begin_fstest auto quick seed volume
@@ -29,6 +26,10 @@ _supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_command "$WIPEFS_PROG" wipefs
 _require_btrfs_forget_or_module_loadable
+_wants_kernel_commit a26d60dedf9a \
+	"btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device"
+_fixed_by_git_commit btrfs-progs xxxxxxxxxxxx \
+	"btrfs-progs: read fsid from the sysfs in device_is_seed"
 
 _scratch_dev_pool_get 2
 # use the scratch devices as seed devices
-- 
2.38.1

