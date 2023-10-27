Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983A57D9CB5
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 17:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346139AbjJ0POe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345887AbjJ0POd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 11:14:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6D418A;
        Fri, 27 Oct 2023 08:14:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDV0GS013713;
        Fri, 27 Oct 2023 15:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3WCr0KaXk6d8AngFCb1dNevACTSvwtBm1ZzTXKPVS9o=;
 b=OIKxEJU/dL0STg51R8XMGJjIRtyb+CpF27e+rZd2yp6r3e9bsAUdRRhcIrmtJjhzdIPh
 ESQFewQADs0lpzW3M5FQXc6NYLW9acJEPq0wn00B6RhEDAPU6kX1YsKUGXSJ8Tc9XUtK
 kqLZiaaN6V/BHz96lFqoLd5MwBImN2laE93bLB9QygEHVKgvHmCmrdrTcwaEqHWFUiiU
 wkAhFRKrX7xmj4tU1ROK6O3C4B+teYzJf6NFr02v5F0p0BJaDxg5SHN76I4HULgHANq/
 LDLw9bcI/dW3n6vOSmqqOSf1TxTXp39zAn24k0trABQF+gZIbdMxKAX3GSv1eNoLEel2 uQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx3nhq8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 15:14:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39REtLRH008151;
        Fri, 27 Oct 2023 15:14:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjnm8j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 15:14:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDw2qRSubRuag/lY0fqZr3Ppxxain1zPs+Fca41VOexjVpE+JKIfH+80XoCYRLa0YhLYG+gVFLZozFnMhVLXk2jiggjcRFLvTOkH6cACOUJGDYUQ2nRYIdRuvLF8PLTwcZ7rnYAyavzwLMaYkH0nSyOdFOGgB4zSYWXXLrYhOoduGkLwl0KGejtMPgmzo0ZlqY+68RKC80dHu6Pe2GoF8sOZS7h8E6xMYUIrvCe4R7rjV7ETscAitGjiwYkj3Ephtsqi4iG54pee9Y/IDAcGhEw/mxmg9aV+IjR9nG5zZI9Bk0QGxiwncWsxbGPySCMqo3NQ9hKEKH63oRbwqd5Znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WCr0KaXk6d8AngFCb1dNevACTSvwtBm1ZzTXKPVS9o=;
 b=XigkMQF3hC9G0KB44Ncj0oRp2nxPrI47NjXN1MoktH/5gI4K/SDLFkduAJS+iGK3wRYy5EXVwYTRpZY5FS2uCO3EAqLVxdo7rWohhcVFosUvtqNLOS1U9SUfMi1LZL3fmPS9BfUWtpWC9b/0A0tthEGrwmaoVWwVXf/9QrHZhn/A4YANETtMVojfr+TqyXSS+AKkQs7JB6F4YE8uIzYUpM/ocw8iEWPomaamUkaWBELK5pDERcGPcKH3UI5cCVD6sGmrb8vZE0KQAB4rK/AKi1YXuuY5QmwBaaGQWzFj1dB8FEMq6ZEniHAKNhk3jdEm5Tw1EfORuqhpWuOjJed2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WCr0KaXk6d8AngFCb1dNevACTSvwtBm1ZzTXKPVS9o=;
 b=ENzrRGAeTpJiTvIVQI9K+1HmZ8kDKMXXzdNED4UvDdj7fJaMvgTiJRpVQkMGJKeXaYqbvdfI9cdr1nL4vgsCrqMxzdoyPVY6sq2GZoVMdgm5C7Jw2rCuCZkrrvmgMH1VPiUjXfV1OVGQa/jTuyE5UAoOdCG5GXpt2fmYRzwUm+4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7785.namprd10.prod.outlook.com (2603:10b6:a03:56b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 15:13:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6886.034; Fri, 27 Oct 2023
 15:13:57 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH 1/2 v2] common/rc: _fs_sysfs_dname fetch fsid using btrfs tool
Date:   Fri, 27 Oct 2023 23:13:47 +0800
Message-Id: <678808b10d005e976f5e299816b63c8e6fa44c4a.1698418886.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1698418886.git.anand.jain@oracle.com>
References: <cover.1698418886.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c697d98-5d51-4a7c-fda3-08dbd6ff579a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: feyn1ZSintkI88NOYCj4BoHa8s+1y/p0iLD71uBOJVNrHnCZPLli3FSRHt1Ak4pkyxC39uL/wr/HUgAS0vxzAkNmFhSVGcbdQtp18HdskMqgVJZ2WbasETJBBHPLI4cZlD7ktbiUd+lJEYQMvW/XWYNQprhWIna21q2/KvBmzPpQ5LG4HPGk10INpNtEwxz9UwPJnUSRmyG1NbzMWVfcGf6g/wjQnUOgMhMa4NhYSGjOLuioMUdlliVcO297sYkiea+vb3cooBxyXkIPpDyH+HN2hma/IuR7UL/F2mqeTeXGbhQIguRBEPYvxB9CiDizhEFdIxLDGCRtFx1Hk4GfpdaUAPHtcMolZPwp/TByNO9mZVUQdVE3P2ZNrWgvKWa53jYX+ZoSgR2HNPqeK+jM30HWwNorDcAjr79TZ4KHrQwPlzuB2aCwV8WQB7sMBCXuyVRGaJYHXJXdwmneURfvyhL3jAYe4z+Oa+0Aepe+UAm33uu90l2sIgGYGEtC9onZho8k8EjXSFSDG8F586XsBVjlonBLs0UdUUlMJ2VWvdB5hHVt92hbKSt2CONO1Bb0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6486002)(86362001)(38100700002)(478600001)(83380400001)(36756003)(6506007)(316002)(6512007)(66556008)(66476007)(6916009)(66946007)(2616005)(26005)(41300700001)(2906002)(6666004)(4744005)(44832011)(4326008)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xu0LVJ7xmxyG3M+5Hy7sZ9jK7XsLfA2He/FHMLWHshS3TQyA0YKemI1ZnA/N?=
 =?us-ascii?Q?2PFKcCY8DnPWIdSyWM1lBlQPNz47vqGubA74GQz2VfYls2ZHUz0waMfhJ9WK?=
 =?us-ascii?Q?Y9eazznc3t+t+GRX7E9hqE++9fqMqGGAKQnFlzzbc+H3HGizm4dPQ6m7vEzH?=
 =?us-ascii?Q?lMCaIoh7Gw/T60CPsd8esQRSSJ9hDaGgF3pP/dukk9jFU6EBgHQwfYctJxVZ?=
 =?us-ascii?Q?66YJbWIg10NSlOsIoZU/H6mxs+yB2aGgmObh0yj0Ed4K8Uszjksfr1vJOVxc?=
 =?us-ascii?Q?cLf6kPMNxi1UT0rLqS2WvmcbfkkymlFuzgHLy1O5C9XtUfYMzDGNmVzY0v4Y?=
 =?us-ascii?Q?jcT2WshhDVOZac4HuZVKIxgNnE+Y1B2J3gcROGZPER3IO2lqvJrZ1wkTSmy2?=
 =?us-ascii?Q?zqniDkkP1gWZ9hdMmTg6oJVHejPeaOK8IKfoAhnk3F5nbwzdG60RvDzmfQUO?=
 =?us-ascii?Q?ipPUO8/lDA0Q8mPEFnkqB8w9ZtLZ7/0hts1PUGgcnVoa4RYY6Nzjhists5Oz?=
 =?us-ascii?Q?/ESH2fnya7KBVkpMHJ1jhn+M4+ez2asvF1zpjtb3VQG9BCI/J2kp1GgbbFG2?=
 =?us-ascii?Q?ZOn08+ryurMyz2gowLT+W7A1XCbs96IT+x4yVtJmevGSmqXsKn4aBxUeS88N?=
 =?us-ascii?Q?k25nGSFvZdxzHRpa+dSFu901odeXkHTlVNd3ICKpFPRXZnJnsW8vC+hRZ7od?=
 =?us-ascii?Q?e7uOWZDLquDvKLehSizP6Jzsxv8gNfSjy2rHzsgednL/ACGY6Ith3cd3qYD/?=
 =?us-ascii?Q?hjUELTA68NQUM4NAAd2CcCg+stg2eoReNy4iGR9mYppZ3gr1I5JSCb3bzIHN?=
 =?us-ascii?Q?St2a9+vL/E3iWHKkuoNh8PsuL0ZqLz4UI8TgW3Jx3SuIQvkOl1Ej9mredDcD?=
 =?us-ascii?Q?cl5YGmxAH6uegU6QcwaWmKT3H2AUyT04VuLD1O0b969C03/5hsaFbm1iepfl?=
 =?us-ascii?Q?n6q2wmdSGnFp60XpyPnbapjpVPVs54wZ0KRa5+azGyJkRenhW6cXTUxJ9e3R?=
 =?us-ascii?Q?Rdo+QNusc7VIi/AD4Ci+T9DEiDQfJDAI7vrbCZ7ODc8PwFNIUTmxD/bZb/HT?=
 =?us-ascii?Q?GEZKrxyheIUebNgicGDT+ea15BxYipaHSnbaZ3j6Y3JosyPasrzAmzf5dyHF?=
 =?us-ascii?Q?r+KFh/ZgBNQ7VwYuI5DmnP+LsXjWGgDyaC5HozXd7m1J4Gn+OPA1gVpidHGW?=
 =?us-ascii?Q?0L/jnXNvofJBMRrX8IgGrFVvWkaslmaMcXHnlFeaRvga/miPX9CAEhFV6SQ9?=
 =?us-ascii?Q?pWlycckZowAWJjktnUSMt1wc6myYya7kDRiSEu2pFrXVEPquo2pdSsaTN9CD?=
 =?us-ascii?Q?84VgjCY3qeIVPPjy6wpHCqgbJZM7NufLu3EaRzKsTu6uwXBcqz0BwAt8SNRN?=
 =?us-ascii?Q?KFLIwXi3BoWhk9v0PtZ5EljkKXMAXeX0+0wXbPDdfBMH+T7Ac/eTuv2coX4g?=
 =?us-ascii?Q?urYEM+qnYo5ljERnQMj7v7xyUGFeCO1VWS2xuAvQihlfIVhHYoo82i86gAmi?=
 =?us-ascii?Q?HPLd/c6eNzX3/+WHqdthqNX/LLeN+SA9JHdkpmJMa2oSfCIpcGZJ0el1T11W?=
 =?us-ascii?Q?0mgqEFR7gR11HYSJ9RWOFIW3GytrNTcfPJ4SsUjZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4Lxi9xJcEb2AS5meGs+eZ/G2MEDBAL99NKOM3IykixJ1RYC6Y0QNRKdUXkKHHwEmcPcaBPuEqYBWB/oTw2iMNjhd9A6+vCJtC/TqhhnbchiDh0ZZSoRdXNmtm+tud6v4LMUO1Gm6DOQ/af1w0/TmEcmuIEBCeArwC0dpvO/ufQ+9AdTI6BGr19HUyoO7WTHrg3FmmKADWuSW08fT6pBcBNVoeZ4zGkuDDTRanFJ4XXaIAAqQA43AzC/8APutGNl0kHbaWCwiKP8EvGbiMozkVBHFiJTqpmDBkg/EmxgsVhNG9INzqXTZrrvF9iZWoG5y9Vpug8x+Wrp3YBPxfyhlT9ziWojvBmtXsWL/WMSKrL7PAXzKFIiRP7M82vIhD9ZGLTHZgxRBFjmPEIBZ7BTN+Z0hnp+aMsOv7AZE1mUUHlFMHConR9oQu/Mte3AEcyjkwS9AMvsGsoaDgy514wM1gYOZdwno9aneZpqujSDcthugIcmOGVLM7c78o+lmeX/laD7timeyEiyh5TpNfF8ooUW/9SWuCFsjDJaw4FpkKs6FFstxH9HWB0Aw3ohQIaq5FSwBrPGRGnQi3pSQXC6SaaLQKvL3U4T8FnMd9c5Q4c4RjWfm+BdQxTMFp/yToWM2uFQQD50YyPQOQC/0NUON7nDsIBnEYh2/B3zJAcbb+hR/8AgTm/QxIByCOjjAHsraPXl87EtH9b3LZVLjp9FxmjUATCCTTKp8/1jR9rtrJBRON3FDXOilEvbuzj1FB5DfBCVYFb0uUHof8VkssTAZvAJQu/YRGlHxS6ZGQCp7P7U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c697d98-5d51-4a7c-fda3-08dbd6ff579a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 15:13:57.8754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vyysjh5JGS+uE/+qiHAlcYdIfdJw010EGhb6D7Ux1dZ+91TZNhtXpK2kUR8scSyrPUMEf0nxXgC5BlzBX5LbQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270131
X-Proofpoint-ORIG-GUID: _aX3uhMZUYBgCTM_qxfXXbef2syd3ml2
X-Proofpoint-GUID: _aX3uhMZUYBgCTM_qxfXXbef2syd3ml2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently _fs_sysfs_dname gets fsid from the findmnt command however
this command provides the metadata_uuid in the context device is
mounted with temp-fsid. So instead, use btrfs filesystem show command to
know the temp-fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: new.

 common/rc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 259a1ffb09b9..deeffe4228d4 100644
--- a/common/rc
+++ b/common/rc
@@ -4728,7 +4728,9 @@ _fs_sysfs_dname()
 
 	case "$FSTYP" in
 	btrfs)
-		findmnt -n -o UUID ${dev} ;;
+		fsid=$($BTRFS_UTIL_PROG filesystem show ${dev} | grep uuid: | \
+							awk '{print $NF}')
+		echo $fsid ;;
 	*)
 		_short_dev $dev ;;
 	esac
-- 
2.39.3

