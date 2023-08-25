Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964FD788BEC
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 16:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343857AbjHYOsq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 10:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343846AbjHYOsR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 10:48:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EC32119
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 07:48:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDOXml009444;
        Fri, 25 Aug 2023 14:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Prun5xbqsPd8/AZiam+eDFNiFyBWa433K6nUBs4+lFQ=;
 b=zNsUzlX6bavm7PVAicOITFbpXQzf9UhEZ5TCQo30B5U+Pw0EtecYzgs30K+5DAcJHkSz
 24+DhkIfveGgZaTSeigeK+kvBUupEypHmZANOkC0WgPM6vEtIXXbmrRiWawGNL3Rws+j
 nIIMM3gVgSE/CrKMlKi/Jy3TZ+XY2L25piFk0GErRBvzTnk5NxJ/0dIPUVRmMBIoZ7vP
 RKqHUV8tyev9wj7icsg+4x7I2T8OSgoKSIX0nXc90yEC7eLwy+mgjnbCD4BiY1XwZ8wM
 RzW2DFAKz3sIkw5Vjv+dDbh6VjF0X19ujM5Hk1FTjX8olyRKppq3JR0/rGufeMwz894L mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvxf7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:48:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDKIXO035989;
        Fri, 25 Aug 2023 14:48:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yqx0xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:48:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR5Ptm4yiZQHbA4R7RJqctimcdXIcgwapOke4UkqNRMxRU4Z/a3czIJ47bIFdVn43VNBgqvD7on3RUn8TummlnYTKYLz6Z7YVU6gLvyWnEs04KP/QIRxrLLGukkssY5Uw+ZwCF6Ths36feN93qerlMtOaxuB/38h1sOgSmyhA66+MEa1+pVqD9u0krj723vxjg+ScECu5RzOu5/RLSU0CqirvpJvFdhb9/AMqW8bmy3lYg8d9GqKlOm/1AQJG2gaLO5rrnVFdFtHv+OHk4vIKRQkek8YwM5oo+L02JXsx0VTCMV/3DQM7yd6+4HHUkJfMHAQb5pOYqbyoOg7QMWLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Prun5xbqsPd8/AZiam+eDFNiFyBWa433K6nUBs4+lFQ=;
 b=HZpTTOVKM9bKTUDyBhKgTFKESjxwNg9fstidd/XoFg9mBfRvFgyx7+fXcOsR8pFqp9I8FEtvEgvp9aDmDkvuBvCZ3+GZw/HTZ6J4yLBsNa8ffQd/IBJPHJaBOy4txD9ugY9pQV5Ntpvn0kpzcyhb0DqLbKNyHwiDEX22HZtIcH3dtwqEqaKUyExYTS5T1AcApz8Ol25det1+wY+ajmnFW5J1Pra+jOrJ0qEvvYY6/IV0UFSAxDh4VFZC85IGt5SE6sLCBQ2ZHReeq2HmJcGKhA6C5ZaL84bRBA3fKiaIdVDW5ddz+Es/Pp4RTc4tIV/OXl0/8U00TiaxaO8vvb4YSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Prun5xbqsPd8/AZiam+eDFNiFyBWa433K6nUBs4+lFQ=;
 b=aB0J2ZZ8RqJe88u3upxDGN5aEdhYRVvL368SGKPUZ9nK9lqZ6ulDoi6ko/4oayq/2MhMG3gzCPAcJso7hnt1Lp/4kxOu0HJ6kKD5WF/4VCgjFXpXiP0nCQIcLFOuEZ2qAfbsSSr3s284eEvIDgxhB+yP13phTN7gE/OYLsVmqso=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7338.namprd10.prod.outlook.com (2603:10b6:930:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 14:48:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 14:48:10 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 1/5] btrfs-progs: cleanup duplicate check metadata_uuid flag
Date:   Fri, 25 Aug 2023 22:47:47 +0800
Message-Id: <cd4366f46e9ffef7538ec385587d5fe2d0743038.1692963810.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1692963810.git.anand.jain@oracle.com>
References: <cover.1692963810.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: be073175-edd6-4eb1-c349-08dba57a4d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1KFdJ7wWq99h4a4ygabimDFTP/3Zn0b1kLUvPUaSSr1ktvm8UCQmujl1EEIE2IWmaPCXejjp7y6BkAQkxsmmt67JRYLO/kz8vkq8tzdBBWU+riKfnFUSo5iTw6d/q3MSOz686M2pTN4zUZx72jmoWYl/6p5AIXbLNOe42adLNuQ52w6UJswfc6VNxk1hSpSipbW/utGAiVqnd9Gg7iXqWzFkNWjl6XYOLsply/pfW8NIg8pEAhaEVg2yqN8/8viGd9MCd+SsDqLlRDZQyXrVH1nb6SBOfzYFuXdTSiZB1PNMRshwQIm5BFbE73K1QIFt8oQOtazI7HSZ1SEost1WsvxZxSdNWLmB73ueQXBWcRt+7SUEapy02Wfc6RmD2nqQATH9GEuf926EgSDtOo+P1OKU+0WVoLFq7D7wqef/uARXjFOOiqFdoeIVwYvcj3kkWjGrFcriWnOGbwWHNgfioHGFapo+gRsIuCptS0UsOFq/0HnzcbJcAro1JJT/cod/pCYhVhV+9kEZOsIQk17F2DaOFUWSFkXd0Ik7udZX0LPSnNX+JT7Jd3UoZ1dWK7/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(186009)(1800799009)(451199024)(6506007)(6486002)(6512007)(6666004)(83380400001)(86362001)(38100700002)(36756003)(26005)(2616005)(2906002)(66556008)(6916009)(66946007)(316002)(41300700001)(4744005)(66476007)(8676002)(4326008)(8936002)(5660300002)(44832011)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?51pQVube/53zubmbIlwtnGv87z7zb/nzbOPFetCs6fjos0xolV+FlqpQTM1a?=
 =?us-ascii?Q?qHPNfRUl4j1G8w4ZKLn6OmEqK3t2jPvBNgdNzmRUbQKjxzRWHQX2Ow3hGEYt?=
 =?us-ascii?Q?E8DpVaaFKQASrhvorwpJQiB1XWePSSvEH5EhYFrF+1x6YsMMIMZ/YrsibM/8?=
 =?us-ascii?Q?JL7FH+rxWcoM8zaNbxLmxb2nivzcwnEVIu8YiCivE5fcA2CNrt9JRqjn16vR?=
 =?us-ascii?Q?QZ/+s8MoS+wMSUOACqPs/qsrFhcv+ZOAAKvPoNzWrbWq/a8+CvbPuQLIfw4V?=
 =?us-ascii?Q?aWYn56hyE+Y9D3okh3T48UcMHjHxy4hKTC+Ld6Zu3DQbj5mRegCEhdtsoXEg?=
 =?us-ascii?Q?u9Fs32MS1rNB3lN399WI7LfSrPFdvQexBOAX/+8i0k8emkEP0hGvqMxv9KJe?=
 =?us-ascii?Q?ReIjy0eKD9/It0uepQFJoDM/f0XavxVeZJBcNoyPRA4X7Mc+qAjwmnFgyQdB?=
 =?us-ascii?Q?fFPHjcXyE0H+FeUYZ8PDnnNkfA7Kryb5MCqWw11E62D06sVesPW8FHdbBJqx?=
 =?us-ascii?Q?/hBZifpUm+0zjzim/QECIARFRbTFULqGHWGMvClJA/O3ijsLwpf+BLFPTM4/?=
 =?us-ascii?Q?EbmF/ue9awCH7IXBZF1+4FvSrp6lAzCOfgu0aWTIm2RvipLbmq5HPNMtFW7I?=
 =?us-ascii?Q?Ro+pcUqBKxKA20hHIoDCerM7ybKXFnaMiEgnXDhsarCLwLKeiayTMLH3G9VC?=
 =?us-ascii?Q?rdCd+3L4XdYPMZ9lEkFPMVHX3LQ/vYJyqcuWIow1h/SED7cJKn3ofYlxj72j?=
 =?us-ascii?Q?noR6eMXh0VP5wZ8vQ3XVbtoiyh1S8naPvzeYsyvdJSQhSIr8F8314GW8CVk2?=
 =?us-ascii?Q?92+g2BhsT/fIJUeo/xKDblz0m4YIrl8f8KUICKSQ0B8sgdE/bR5Y7TxXC2Lp?=
 =?us-ascii?Q?siG2ftB0hIKLPe0xZaH0rvBJNdNVyBnxo8/XASJbqLR3tI+NikzJBkMBpWV8?=
 =?us-ascii?Q?Fm1zTylTTNen5RWQVSs7pHBnZlS1JawvMCYD6uGyn1DIr/F8wIlvTWAWIYN9?=
 =?us-ascii?Q?jop/AL67KyoPXHZU3DRKYzuGa9gwBiQdwAj9A4Jlpdaly+8s7oHpxde2Ue52?=
 =?us-ascii?Q?Mzt5RMjdnA+LHsPh4wjt9jXG2sspgWDPN/PpO3mD3yP2/hwrmu/WDXDgPBkU?=
 =?us-ascii?Q?pJu75UuEEODfcQjLd7MNtAMyhAZe1My4fKE/jyqZXbPo8j8aFM1zcKzX6N1q?=
 =?us-ascii?Q?crEjmFBv2YyOuGBvrHNh0bvWI625vQM8HDnicbON9b+aO++LmeUtNAGTspot?=
 =?us-ascii?Q?bQBpUPaqoSyJtLk3/aWg14H+8SGhTf9sL8TP4ndUhBGDVbB6bCm8tblEmQdl?=
 =?us-ascii?Q?gdP64tO9/7WLr0qxc7S2PyHbxMkLKoYTRxWkAhTFXTuz8mrhypHmRUQkjqvd?=
 =?us-ascii?Q?FSCJP/qm1BwvfeOIoCM+x5FONI8PEfd3utCW3LNLGCDbynTM4A3kkPkfJ1o3?=
 =?us-ascii?Q?dXxJcU5oYyWH5pcHsUU+UDIBM9cQV8Pkf04Z42rKEP5r5Wp3P7nY7hrcHmN1?=
 =?us-ascii?Q?L4V7oGMvMa7mBR20uk6Nl8kGti93/4kHWLYtwGIFr6OkjZE0zMEiBlkiYjBt?=
 =?us-ascii?Q?Epe43j5v3AKiaJSkeJcgr7sAHoM5MAb4BK62EEZypO8oGuD67FhRsAmp1UwZ?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BtoxyAm6hnpFVYmg2FJ4/NtoI57CVuRyYs5chT0Rlfn/8szsbJI5Tea1up11SKZrrdnKujJrsRJT3OC7A8GHMoCE9iYETiDDZOHy8pIWAyRNTFvUK5h/HAR77/EeSS2bnTXGeQNCR4e9Owc56+PClLKOfZdMfI9EMpZ/ZX1oqd9sXO83dSRX95BIy7+mkZ532AyxV9k4ptQTk7e061PWUxpWRI8Jzgumsh8ffgf2rBnhZqRP+8LU/cNNk+f5MvHF8jpeMTGvfsbLopTC59WptNRfH7o2Ojxtg/CULWNhS3zyTghlQIq7jtVfLwnbOVOwDtP9OUhwZ2+9pdUg1LaVuJkXM+C0mfC9BKokHVXHbFNCw5lYJSNSR7IxgIXFTbfpddb1z+RpYebCWdWH/1kTgNj5ci3k1vPudwGAGD48Tc1Dw6eYRQc6HOirUJPIyH1XgSR514zqOPQSEQDuRk4DkmXazHnXMqo8jI3bJck0jEFybHnCPd5RNOh38B8CO60p7nRQ9Ts9RsaaLzYpmarkMFzQknTt3vBhK5FlKv0jVgkm8TE8bPTLFpz6Riwjupo9csJDC+u/8c0OX7zHEsmhiY/Bvn4IuIFaEPpoF3ylYVDucmhDplVgyle1fuyhLmsPp9XACSadz6QTPm/Zcw+ZMMrcoRPBgcgsYkHSHWwN8rasqicmEggDaQkpWZVs+FDZBou8fvl2wmJMJGqs1d8VK7Obns0pN8KLBlm4wgKM1/V6W0wGyeg8kOLd2MehYAn6kopWNfce14d8ch2tDd858q0VTzD63IBvI2ce1R0XJxk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be073175-edd6-4eb1-c349-08dba57a4d21
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 14:48:10.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKGRgjN22hCWQYbOUqUaZkxv1HbdszgmgoZOcNohY9as4QIFW0kIFevbvGpQ8Ljhr/zeoviQkn+1Rywl0lAZng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250131
X-Proofpoint-ORIG-GUID: yXyNfnxJk4XZBF1_AoD8g54gK3j19xiM
X-Proofpoint-GUID: yXyNfnxJk4XZBF1_AoD8g54gK3j19xiM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The active_metadata_uuid already holds the value of the metadata_uuid
flag. Remove the check for the same flag from the super_copy, which
below patch forgot.

     btrfs-progs: Track active metadata_uuid per fs_devices

This patch should be rolled into it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tune/main.c b/tune/main.c
index e3b199c10dad..d344cdad06e1 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -426,8 +426,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 
 	if (random_fsid || (new_fsid_str && !change_metadata_uuid)) {
-		if (btrfs_fs_incompat(fs_info, METADATA_UUID) ||
-		    fs_info->fs_devices->active_metadata_uuid) {
+		if (fs_info->fs_devices->active_metadata_uuid) {
 			error(
 		"Cannot rewrite fsid while METADATA_UUID flag is active. \n"
 		"Ensure fsid and metadata_uuid match before retrying.");
-- 
2.31.1

