Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221777DBB8A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 15:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjJ3OPk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjJ3OPi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 10:15:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43812D3;
        Mon, 30 Oct 2023 07:15:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDPp4b029827;
        Mon, 30 Oct 2023 14:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=n30dq1749UuUblcvGipTeRsEhaoyfdQM7GjLaWKFkXs=;
 b=rBfBBGmW/jl7+oMR0KhhJeOGQ98YvqQvum7spcTKJxqY5GTQ/EHBcxgpdivE/lxNa8Uh
 2u9LYErCB5/r1DuH+kSBC2d5beDixM4Wwp7hEBATb5piMPLA5Vttr9jWgMCXdqnqclwQ
 ZFgQ7Vjz23K2DdzloXrBOizJw5cIIOz/9N5iSP2qN2aqhrNBalInixWePYDcdNO5omDj
 9nhPLb5M4f1LxqfqcSYE8AXwqM/NA4UzLvjf8x85F/IfjdFHw69RPoMcYXX74Z+i7cRu
 e9qgNwOVOTUixxylQwQlbqxAQ0NKmlgi6YBm/udmlXduW+SzcmstfH+JIlimSNrIp9C2 jQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqdtvxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UE47la022595;
        Mon, 30 Oct 2023 14:15:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr4aung-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AotuGd8VgiKrhWhsCPDUbwxe7k2s+LmGYnse8FAnpnyUoRAASIhS1F2htCEaekS3jroTpPT1NKbgBGsTbsCTcwNF9jyHdiH/rEcpLXuW/rRm9tLMTM4Xulu7klk21CJoyBl7XVuhD03NUOn2nrdYtdiSlZk6P3q39RCE+6pyRL/D+dUTVcG5aQTUXywkVxSz3G4YTrzkgWWkisGqABKJ1uHAJyXCz71c2n/d6/GLZzDU3CWlf/ecYNVZ0WcX009iZ7QaL+/maBtbKYlfiapVaSykhaSObkxKxY4GAMdj3so8jezi90mbV9PAj1TEz5HHHmtjdkB3to277X32tnH0Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n30dq1749UuUblcvGipTeRsEhaoyfdQM7GjLaWKFkXs=;
 b=VREpGpmkhAswNSXnScfXt14wOu4IHFHuhXAKINZY3sLOxmXuBgzeaUEQI2lhBA259bWf+ipZkqYr5v6RzoSYxc72jTTVoDX2IpSVw+GiNhJ3xElmfbw9RUkSF5G9tPHoGeoEJbJQljUc0zeZiOmQ+IOx+kT/pDfA2T/EJckLi/OHQPddmEZWlkZkQPSfYb1VGA1bfoJ7bjf9N4LX0KwhbgW0BHAO0Lf9GnhnhN5bqJ7qvJElWSfrkkYT5l+1rvEmS3Ib/FgSrjj2HWoOGesprxgswiyV2A1Uo8ohstEcVtAFfnIN5Aj1qlbnM9xpAQFf0LxiKTrAHt+qYtBF0zgHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n30dq1749UuUblcvGipTeRsEhaoyfdQM7GjLaWKFkXs=;
 b=xxaCUWQYgZjX5V3gPTTIPpfcSGBnQsHK0g8Cj/6BNyvLQWbxl41UtRjtTu4HZRe/Iw7C3KheJ8bbjjGRCT4P+TpNsji8eclBHk1XlBWwOtxw7VRRpzXIOKHFA3vXvQc1+Wkxa4JXMNQB1Z/KQYmZhVk1u2+pf1los7zjidEOO/0=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DS0PR10MB6127.namprd10.prod.outlook.com (2603:10b6:8:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 14:15:29 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab%6]) with mapi id 15.20.6907.021; Mon, 30 Oct 2023
 14:15:29 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH 3/6 v3] common/btrfs: add helper _has_btrfs_sysfs_feature_attr
Date:   Mon, 30 Oct 2023 22:15:05 +0800
Message-Id: <077b252e8affc50ad3d7826d57ba42a2a8746d13.1698674332.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1698674332.git.anand.jain@oracle.com>
References: <cover.1698674332.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|DS0PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: a361b643-4519-45c0-6648-08dbd952ab84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKafzI/1T5OUdF6ajAGesCZ7FICge83ew+mzdyMosgsErIfTB9Ici1VbVURCjBcZPA268aTJouQOkx/poMIFAXb5zA+Kx1Som7GBsVSna54Rbm90V1Z40XE5oPeP/a93FcfeM/JnnmmEmlkxSL+sDRRMHwV48rKtSmtVu1lkAJfPdaAnDTYKAVTKJUHVdSTGTbO3+QfYgtV1DXTBymXiRl1Lrb+NEolkwfcQ7dBDdHv7BcQi7X7AuLIIjghtB5elCjPs9UQ3cNrXv7YTsy1RorcmGuBPbzQoAJOGi4VtXFDWQSxUcG7kvvQV48DF3PM6ScFbXd3f74zgdK0IpRCXSHbjks7L/iMEPOr5Q6BSbqf04p4V6ejoXzjSlEZxUw1ToMwrfGl3hsXZngX7mSP2RAiD6T4n82iIjPXJB59nchCqCVfh9WFPAtkVgux2oAwY1AJYcJ2o9GbJELpvOi+F92nrtzBA1dATnkiG2JKjE96fuXGl5mAQTwbnZWjVOoyHJYgZHxoVS6zXoaUaZU9spyZ8AVEvue1AkV4N5LjmBsin09DQ7AUlsRz5dcq1RCfH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(2906002)(4744005)(83380400001)(5660300002)(2616005)(86362001)(6512007)(41300700001)(44832011)(66556008)(66476007)(316002)(6916009)(66946007)(6666004)(6486002)(6506007)(8676002)(26005)(478600001)(4326008)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j5ExTMChO2+29R/NtvSL2NLbytRcuz1TpqMzoEcL8sjKNWuAS1F2VXorOWmD?=
 =?us-ascii?Q?Vwel2QisPe9iz2GikBDhsoIu/7k3RhMyDRIz+4wKS4AHADfYNMfgrd7fwf1/?=
 =?us-ascii?Q?LTOAcmnAz9O+EDtWAYbeaPX4Qg+5ZyQPKFQpR1sY0ZhbRNBgftJDZKsSzOU1?=
 =?us-ascii?Q?I4uvZvo7ZSr2aABw6Z95QNIpXsnY/7ubvR7tA91lLU5a4Um1jRahr2oJJmAo?=
 =?us-ascii?Q?yzX1seaCuutKswaZUEUww6V9nkmpK5ShrGdh9bcJDjlp+rUmKfEVLQLW2zJ3?=
 =?us-ascii?Q?LSJbYkcepMmNUZY/u53hJiDtWDOGLZy7kKge9M+lZb2r5QFmOa3S7+kG+b6a?=
 =?us-ascii?Q?CGYjidtDBiqpkdEdgx1hadmjMA73GPioLelrF2DG3bDtAYNNacyGpkb5mWDG?=
 =?us-ascii?Q?fhy0HuRrxXhZkRHB4nYCRoZvqGBr996xaAwkTimjG6c2eEc1/LoicXKiIVk/?=
 =?us-ascii?Q?BrE2R0LcGCZzU3YSLjc/PVDtj7Yq2m1Ul8J7rF/AuARu0UtbD7VCgeL6UCvc?=
 =?us-ascii?Q?yxkzNgWXY7yu5BGL2yWaGIqF9Xh8iZZa1P/NQdgO9kEqT2xPGW4z4gu6QJM+?=
 =?us-ascii?Q?hhklH8dXlSbi5eTm23WitwFHSGrJAXeMb3U8gmi6PszFOkGT8/zKd5DFbj30?=
 =?us-ascii?Q?alrDIDEDSsyPyiLBQXiKaX2wkSZhi+xpHGSu6uapkBP1jvdt3XM0snkmfrHz?=
 =?us-ascii?Q?IoN00xKiW0+qobog5h9nfCpaX8Ea/aSo5v9/ZHj+rysdAvtCUq3adYSko1Gx?=
 =?us-ascii?Q?r0bqCciP6OcjualQaIoZ7hx1Hvlb5cekRqd8ZtCLBpQVGYrkASroN0gDvUt/?=
 =?us-ascii?Q?XdPNcjUpVNQA0yuvquR+//d+4VaNhrsIlcjJxh+Ic5vCIletiSuuEtKc9b5N?=
 =?us-ascii?Q?NtK8JDnQDsf50of3yJoEEES8JTh5S/M1bNBP6FZyKB0hKtRVwA/ISOriKMJ5?=
 =?us-ascii?Q?lfRri07KsE1RtSYa+RHDRqqoEfOZ3JxGX9W2fYL1NxZzWkDnDLS6n0BHiYid?=
 =?us-ascii?Q?N/u6B/x0HWwvXoquPgeKlgRTlOo9hJLVmw+plBkP+bSRp5Ysc/lFp4dKI9aS?=
 =?us-ascii?Q?mQ+q/kd9zXZqNFMgtGLlPPJ7fyn7SqfsmisRhI0bhd9iwWGsxNXw44C0hqoG?=
 =?us-ascii?Q?YobU48DDW5m7jEO/VYROSpZ953UmodPwXJWbmK6aJGkcybZWfhHb2NvAf+8T?=
 =?us-ascii?Q?9GOuPLIRjlmxcAA2LQBURospn2141Ehd2NdNrW3Eug93+fdVwG3mxIk4J3+o?=
 =?us-ascii?Q?diloPcCga4olDX7d1X5pckx4VGoeIXKWpJplQxzA1uZvRxoafsQyqFSnL2kS?=
 =?us-ascii?Q?ayUb9Pi6LCIQdto4gWCO+Vyw6icBJJA0H11V/XunTU3Ks0SkqcdAW0vrT/WD?=
 =?us-ascii?Q?jg0Z/xopoWNjXQRhnd2rY/uQX08ISXRhZvHqOxBWj+4UcIAvagnVVyt63gTX?=
 =?us-ascii?Q?ntY5eujc65CpQyxOLjfaW/g6Cbm7DFb5ZB+IrXyjZ+uXjD9YNb2jXmGW+2Uc?=
 =?us-ascii?Q?EcmgO2tI9fPxQuCi3ZIgjQgFQB6dRFbb/C2yBu0eYtNPgDBxbyCObrOJMX2O?=
 =?us-ascii?Q?KexqgOpGUHUoDAKdUrL/ZOgsJSHTJuZe8LxBSbOQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mrczD8g3ETrtlPEerzG4Kq+qgMQkWQqw8HjX208FfcoWJDg25jzzxiDzuDxtGHLV1FsmeHkU0TOrYiPquA6gHWZJFgd2im+3EsPLa/7wBaXRZlcHwTOqPVuCuvK+n/Pxoe605mYXexW5O4kzQP429ZON5UCEjLd/08kKNw5VD9cNFHG19qyRJGdMR9FOqGJckPZw1wSeh/5qsDC/7kM/202ZdJxmf6ZgM8uGcMho0093s2b7gxRkrhWXbiEMncbdDG4lcYN1lJ+pVxspXJiA+k3BZk/GcU6IeWu3eg++pERjMw2EVQLH0EdXmM4X61KIKVaKew8ziYa4KVM3ZCpLLjsOQPN4xr62TPRAYF84lK3PX00zYYZxuvVJ+dtdnXDqr3Z99FvnQrIR3lH5QZCB6AP6QWc8hdhGkX2EaWe3MlThI/1XE14uCA5urQFEULW1NyZtep+3c9UoN1YpcZG7Ys8u6NMwqJ/gfQ1zSI79AZGJe/SnkZm/m2XPWjagbOCvtigp7sbUgIAOa5M5Mbkcj7yQUloCkzcttfso+nrVmq4rwDuTE4dKWRUMoPkTlH6iXPVbsThXR/AT87oFLYPW35DRrB6r7jwpJbQsRqRIk80y3KITyHWjGkuLpPZM1mizOm/q/AyBMhyM2/8OMhzd3XdvhtiO0CrTjKLuzMy3ndlRxMs52IxgjNcWsppHdjWWPIOSR/OzBtQ/WsnK3a4IQ6jBOk9UICY3j3tBz+VCznQC1NiqU0K+kpANINvuaYMTStpD2iXteO7wY+ZTdL1r9tiAR8L35nY+MNLRAbT+lto=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a361b643-4519-45c0-6648-08dbd952ab84
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 14:15:29.3220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FIuv/cvWY9kaDk1D3fMwZ6joj+SSp/p+HX3rzB5q0J0ZhGqd4QD6I3x9Fvf9ik99WFhO28YNRractioxTUqGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300108
X-Proofpoint-ORIG-GUID: yDnSvSdngyBu3iq4LBEW3hSSa2g2eVGS
X-Proofpoint-GUID: yDnSvSdngyBu3iq4LBEW3hSSa2g2eVGS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With this helper, btrfs test cases can now check if a particular feature
is implemented in the kernel.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index c3bffd2ae3f7..fbc26181f7bc 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -753,3 +753,15 @@ _require_scratch_enable_simple_quota()
 					_notrun "simple quotas not available"
 	_scratch_unmount
 }
+
+_has_btrfs_sysfs_feature_attr()
+{
+	local feature_attr=$1
+
+	[ -z $feature_attr ] && \
+		_fail "Missing feature name argument for _has_btrfs_sysfs_attr"
+
+	modprobe btrfs &> /dev/null
+
+	test -e /sys/fs/btrfs/features/$feature_attr
+}
-- 
2.39.3

