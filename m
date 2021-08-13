Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E33EAE55
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Aug 2021 04:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbhHMCAY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 22:00:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41686 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhHMCAX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 22:00:23 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17D1v1cb008979;
        Fri, 13 Aug 2021 01:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=xS3M2G6+kjO+oxXkCiXpjOQIrLRE8ml8bol9IS0Nqu8=;
 b=m8LVCWnFNWWpF2Ceo+3X1V+nBaoSFCKyeHAMpv+WLWK7MABnJHZgrj17acCnovk9Y1Mw
 kZXUxZLPh5r7k+adKVcNkFttAl2xCPItCBjtPukZA9HLIe9JAE9aN1uzmjiRRXR2orcQ
 XbslnDN1nkNha4o0hQ2ljBGFmx0f0chHXkzEGTXFraojszYX2bb1ewIx0MSMtitx9IUx
 ltAS0K2fRGtya2ABqwIwFFcfVmoQxpglDW4Mw1AsOiOeXWLKtgBHcQciH+eiKhWDcuQk
 LwIgQwWO5nUVcjH0LhlObupYhep4cPZGzWIl3FGxMVe8PbKz5DWdY0Xgi+VqplUxuAVS 3Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=xS3M2G6+kjO+oxXkCiXpjOQIrLRE8ml8bol9IS0Nqu8=;
 b=O09W/T5Dpmmcnqo4mf6zmCqgsN+pTFiYkILKGfP4L+8PhkOEPs90SLfrTKygGkTvsi7i
 15HNYju3txSIVxnaDGaUXfIxV8EiAr/gsNK3We3vPBm+21nmgnq9GWArtpDytb1iGU+T
 /q7LAPt74PNXxnwrXRWKaonBsla2+3NInC/9o5+bienxWM3+I6+rhn7KoHstPiyDE6sh
 7Ah1dSBt93FtSFgftVRcQKGXw8S/ScwSEg4bZh7XAW0WuvUVH5lKqnmcFr0FUAZNWxHf
 OQwUuYZCqAjh6zND8GxTJ/80IOBmmw596U7ntogBHkei8Ix3UqE4tuaaBvWIv0vDBP5V xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acw9p29jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 01:59:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17D1uRfL107973;
        Fri, 13 Aug 2021 01:59:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3aa3xyeunp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 01:59:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwbT3jlKYNndpqonnCuO3sE4zmDMr9soWddVV9iNdWLPEJVQxuhOAIw2YlUPLTBfiS2nNP4TJwFDVjaQcXJ4FgJ9sHS5yQt66dswwGwFfPewUSsZzZ5iXTGf/IkFXnlVP1nvkOwhNZnWUChYnyNsAZHNlM5qNamqWpaNQDetdArt26Ie/k2gE6nmsM0qupwlndku51W+gb7ebga2ABHnwvwQPeUCOzVw9xgEgpnKXACtB6/6Zh2k370ASbiNjjuB2MOaIkcsx/QZhwHM1zTRtOliQQm7vOWFqvcEdgVTyYRijVKw8/buT+0DDMW1J3+OwpYZQV8EoQ/gmzpXv31q1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS3M2G6+kjO+oxXkCiXpjOQIrLRE8ml8bol9IS0Nqu8=;
 b=QgbDO+cO+8VSLQt8asTLLcQeS75p4mesJxp6e/o+hEqYnlO3UtB6jDL8WuTqa6G4TmuZ+RlDebTMaq6N9SrXR2E0mTe3SGKoytTwmuci2ucHIyiyrJQ2KYPtyo2Ajy28v6WKacPl99nb3KOvOm1ndjkV56yes1FeH/tyIVkZ00crpg9CVusww8wdeemXMu2iFmm3iic6F+5LnrOoiorZS7kfB/zOPtTfGwH9IgsSgH0tgIc0X00V0RcPa2CMYyj48m8sv2wQCqd5rlXuSXY/rpaTrbtA7+CVLdjaL+Gk2eA9LAbLIUD0CMcUL6oAoFeAITsx6d3TS0sbjH8zElNDjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS3M2G6+kjO+oxXkCiXpjOQIrLRE8ml8bol9IS0Nqu8=;
 b=OX6JcYvzr2Ikk7cRSxDQLfqWB/SS82RFzAZaNJXWU70CJr26qTIEjqPJ17fdW3YmpThKk/SOCkVmm9wSh0ndg2WLZuCuEYmG+Albfk2cOWgz8sjW4dVIA+O3XT0rsW+d40VSED2folqRkF2rrsNwZJrhrYftM/W/DEw5BlZsHBA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2771.namprd10.prod.outlook.com (2603:10b6:208:7b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 01:59:54 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.025; Fri, 13 Aug 2021
 01:59:54 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs/220: discard=sync support older kernel
Date:   Fri, 13 Aug 2021 09:59:33 +0800
Message-Id: <7f0731e5ed53fdd5b51ff1f2e51492415a46732a.1628818510.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628818510.git.anand.jain@oracle.com>
References: <cover.1628818510.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 01:59:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c85038bf-1f72-4434-8cef-08d95dfe0b58
X-MS-TrafficTypeDiagnostic: BL0PR10MB2771:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2771C49E2A1D0945415940DCE5FA9@BL0PR10MB2771.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxE90kVSBET4ExOdxVERvaJwDPzhreHtpi0Q32SurnkTkF1KOhKKufHNJxZRlGSdpoSeSaO7pnAGB7uSKoLyDrHS0fvSi2G3A/bqZKj6kl9BmWYFFu//2J0FBF21GplX32JVBWiMDAC1NzGwUMAB1auShsXLdkF0JR/UggGdiMH9aSbDsf4OHb9DdO0OhMqWTNY5XEbmyG+tO63wwzY7tYFKth1AvxP8depR0T7bn94W7ngAyZqnLz0UmOXFlE/SdtI89WeVTdUSO4rzRC9KjFPhESO8PCHtcbTLLmAu/t41rGjQ1gb90b9OD4s5yJFBmp+Naqrx+EfMaNUwJbzLFL5DdwzR6uUOCUz2+nDPf9WFd2K8o+7NBO4/TRTEWZmlrQrLR9aYcF91xZXpuNReqVhSq7qjkZP8fBJhAqunPax4CUx4312NRgDWOlqM/thvNlnPTBCQisUX91H2LHIfBadYhYIA2b85yWfzlLhTmVnLkuumpkk1oTxLRHxMzsgfGjCWhZpU5vHKKKa6OqcKTUzcHY99dwNxSuHCEeD/Ee7C6Rp9GdsWwPIQL08FByPVINyHv7aoQKTO5at6Dc7eI95nKwCwN6buDpe/sCKV/NxOMfqYdvkYsPvzoR3QePRIDLtomIsIDXE3mlebdKFGANlhfViBOGlhySrmIQaK8T25wWefet/hqk3ePHaU5vCCxcSGxPU3bmIpWl8lRwEHzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39860400002)(376002)(346002)(956004)(2616005)(44832011)(8936002)(8676002)(26005)(66476007)(316002)(52116002)(2906002)(478600001)(186003)(66556008)(66946007)(6916009)(6512007)(6486002)(450100002)(6506007)(86362001)(4326008)(6666004)(38350700002)(38100700002)(5660300002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mmNg1yrIXYO7FCw4TX+O9G7AsvODz0Skf3b3LtmAFUIBtq4aTcd5WNCkgMQD?=
 =?us-ascii?Q?u4sXI4XVzsRdXQ7xfUOMHdEOHPzI/5BMreN+F5/xCiIdJtzGixAsNIMkK0L5?=
 =?us-ascii?Q?46AKzqjqhcEY3JTSxBX3jCRvsFPnCRFBxWdsfH1MhccpYwapgBjW3E4kCllP?=
 =?us-ascii?Q?e5knRRMm4zwb5BzUmtJoA1plJTp8KqyvbSkhlWNIi15Scfgv/k1EWwfZQcy1?=
 =?us-ascii?Q?1eCYb3gYLLsGf2A7UNbltvmDkx7XESNbv3hxk7ExEuD6iuICykK2WAlZdFS4?=
 =?us-ascii?Q?uPKKZUNKmY0YCmijRvYh6ipgLSMQLqRzuUTaI+3ZVy2wuSQ06fMVlTUjcwul?=
 =?us-ascii?Q?MvG8CeDhZnnwLCOapEXie2gIRyvm1laWof35Qm2T+ERdEahNpfRezC3F8F0E?=
 =?us-ascii?Q?sSUI+RtcBSwaQ72aL1TT3I0oj9+e/cMX5k53dvW/Y9Otg0cOXti6m3t2zlrs?=
 =?us-ascii?Q?dngqVNsagvvLY7kvOz+6XXC4ItF8Sm0nx6lmvMI0rFHXkzqR+Eqy1qCVXVal?=
 =?us-ascii?Q?9OlEhr+5gAoISUQemFrAmIdPDdX9JGnf9SDN68adVMGPEaVqfBlM92USKXRQ?=
 =?us-ascii?Q?PC5aV5ERpn34vcUUCPyp7fFRdxfaouVaPCTdmWv9KO4DTUFKzBH1Vxz8k21a?=
 =?us-ascii?Q?UUOnD5NXsMS4tLb1hfssiqnlGTr5MPeWHlOSIRvKzCFBU9U+wnnh4UfNR9IQ?=
 =?us-ascii?Q?IweeurI3qkKXYbl24NNKoxFSO3AxPYSY9RLT+nvKmtCCXzUqjiI6ELWSdB1N?=
 =?us-ascii?Q?6b0mV+p+rhPQw8BXayH/gWJGa0GmDvil18byORosxpCAAvqhATQ3/J3eotUL?=
 =?us-ascii?Q?FRDyUrwuOigZYTuI4ClkCEL7XxBX3mIEejvwn4pXxnzi3mIr0w9kx4Y5nVav?=
 =?us-ascii?Q?0RCoHg6Uv5YeDdcQJFHxtWlJn7kVJBxuRKPv740ZNdRWj0uAo81HABhtK0i4?=
 =?us-ascii?Q?24NCm0BWUpW9aX1LaVZb2yVOaraxmbxIadnsih5Agska6f3sZpYtOGq2kcvY?=
 =?us-ascii?Q?n1t8QpJNB31F+jGiyoU2I9Y/UsIOLdzJqALteyi4YMaqiKleVVJqheTS2ktS?=
 =?us-ascii?Q?K0zEEbJ1sSx22uq1cZIkDdk5/EAQSTr6jn65rsEnUzrIwKyRC3sv98p3c1Or?=
 =?us-ascii?Q?yRpNeM2IA4vHlnZlrzC0kNLHHCBJTV7zcih/QnjGQPHWyuUPo6GRyMCHVREG?=
 =?us-ascii?Q?eUia22C8FKxKefLrZgYu0JlsgSSjmpmg8Pd91RnSenVMmcL13mCom62+AIGD?=
 =?us-ascii?Q?jQO0/JWyRtXg7Ih5yWHajHJBPoTxX7lVQaeUGhuoPxdxEY8BSEyt6cmxhLJw?=
 =?us-ascii?Q?mzHMK/t0peHS8HEMKkipKda/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85038bf-1f72-4434-8cef-08d95dfe0b58
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 01:59:54.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPeEKgq7qm6qUSXeHtiG3xNK8htFa4YYXFLxd9CS03QsK1mM2DO7LocvNCKYKOPTYaeIN7143omxGo575oGwNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2771
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130010
X-Proofpoint-GUID: LWl8VVBVcsSnMLFQpDFdgJvOnqYu7tMD
X-Proofpoint-ORIG-GUID: LWl8VVBVcsSnMLFQpDFdgJvOnqYu7tMD
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

mount option -o discard=sync isn't supported on the older kernel, make
this test case older kernel compatible by checking if the mount option
is supported.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/220 | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/220 b/tests/btrfs/220
index 7207c6967793..a01b28a6e42f 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -263,9 +263,14 @@ test_revertible_options()
 	test_roundtrip_mount "nodatasum" "nodatasum" "datasum" "$DEFAULT_OPTS"
 
 	test_should_fail "discard=invalid"
-	test_roundtrip_mount "discard" "discard" "discard=sync" "discard"
-	test_roundtrip_mount "discard=async" "discard=async" "discard=sync" "discard"
-	test_roundtrip_mount "discard=sync" "discard" "nodiscard" "$DEFAULT_OPTS"
+	if [ "$enable_discard_sync" = true ]; then
+		test_roundtrip_mount "discard" "discard" "discard=sync" "discard"
+		test_roundtrip_mount "discard=async" "discard=async" "discard=sync" "discard"
+		test_roundtrip_mount "discard=sync" "discard" "nodiscard" "$DEFAULT_OPTS"
+	else
+		test_roundtrip_mount "discard" "discard" "discard" "discard"
+		test_roundtrip_mount "discard" "discard" "nodiscard" "$DEFAULT_OPTS"
+	fi
 
 	test_roundtrip_mount "enospc_debug" "enospc_debug" "noenospc_debug" "$DEFAULT_OPTS"
 
@@ -292,6 +297,13 @@ test_revertible_options()
 	test_roundtrip_mount "notreelog" "notreelog" "treelog" "$DEFAULT_OPTS"
 }
 
+# Find out if the running kernel supports the -o discard=sync option.
+_scratch_mkfs >/dev/null
+MOUNT_OPTIONS=
+enable_discard_sync=false
+_try_scratch_mount "-o discard=sync" > /dev/null 2>&1 && \
+	{ enable_discard_sync=true; _scratch_unmount; }
+
 # real QA test starts here
 _scratch_mkfs >/dev/null
 
-- 
2.27.0

