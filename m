Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB77764F09
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 11:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjG0JOR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 05:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbjG0JNZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 05:13:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A0935B3;
        Thu, 27 Jul 2023 02:04:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R0sFLv006075;
        Thu, 27 Jul 2023 09:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=V6hQmwk2GXPVZKMG6IClauZ9p7gWAqDyLlhJVj6fsFs=;
 b=Ebkub+N12txJSZ0lkwaHH9uZGBIrNn9E/18OsfW7IDS8llQElTABT+BPSv82R6pL6UqL
 pSB772niob7f0hIm8FzFQpF6Z2vYreb2b5tcXkh3CSxmhvrp0sRqHDlGngoU+Bw/Avag
 KyXu+A5VEpkweadjwEvohuJW1dBuaoRVNmTPF1FfqYBZ3SAJM4Yw4CIG7e2eTT+5lyhY
 5rZq0iB8kwNOBK6kIVKWFKeBvNlFjedSBdbNqx9jpi/xpemOtQvw6B/2F+IsUL/neOda
 seKdsKqJfjxQbHWGJT2gI9I3RlsOB3HN1UQdj2cws2WpOISlzSpzhNyMNNo3cpM4tohf SQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nus81t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 09:04:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36R7fOn5023025;
        Thu, 27 Jul 2023 09:04:40 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j7byx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 09:04:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Grhtd9/SGLQzX3dXRTjN29NG9bx+LMvgdIdDhN3Dz/CYDJnL4+vaznuwucJ0PMupRWd5GYlveE0j3Th3kJs78RthNFEYz/GEYYpMY7p9eN10vQxUVDs93g+ZNSq+BW1a+Shklz5fj9I+fMnKZ7ZRjFPvULkdY8csP5NxtZbzjxacad34BWqBI+Yo3bKlVQDdU9vAScLcP2ctmTmyLfvsXHVHss6dkQh8HlLd0/C0ImqS0wl3p4B+ObgLDViY92H2/QmHALuidTaljNRLDdfggWEy5BARPD4eQqyiiOfwViCgf1U1VVV8fYnvvPhLILj/gUGo5R9lj83Z5NauETdHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6hQmwk2GXPVZKMG6IClauZ9p7gWAqDyLlhJVj6fsFs=;
 b=FEMS3JS2MLcN6tRc4ymwDuybqvJR7V7QIrA4+HnqysIaV3UkQiGe4QmAghqrdXwOlthSTAGMJnX6i4mgg/yNTNomFeh9BjJ63ReO1WNQvQWPWMYmeEngbRPnDpn38cRO+Wg6x3a6XlnAEUYJ/6j8jOKpwME9toGV+fuPQTu0H0u2DW0kFkOZFgciC33r90bS90DszT8A1wNjRDNxNC3NgjWsIrQwNbDjTaAGH2bEjEf3DXKDR3kBLxo69HR3Syvr9eIs0Pn9N+8Axldh1dAjIOsqSQcyWz53RM8Rq7kOzh4uneSaUT5xdaYSe6jLvyzLzayuyNKnIh9lRciUcPhpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6hQmwk2GXPVZKMG6IClauZ9p7gWAqDyLlhJVj6fsFs=;
 b=rdZpQquCGTB3ohcaNyNa6CF8ELDPwMhdmGkYAdIbRroPzV0+iSM+HQOO4MnuanFoGbp69EddG22j9AptGRwqPmqF3dqMTkknDE6Irp/X3s/JG8r/NyvCdrIOiCc+kuXmJ8JW9zrhHsMYr2Kf10IAJrRmrrKAi2WdwUpmAoT5SGY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4898.namprd10.prod.outlook.com (2603:10b6:208:327::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 09:04:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 09:04:38 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] fstests: add configuration option for executing post mkfs commands
Date:   Thu, 27 Jul 2023 17:04:29 +0800
Message-Id: <9c6d36835c04f18a59005a8994ba128970bac20a.1690446808.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a9e077-daef-45fe-0c82-08db8e80816a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDwvVnSvC1TiAgC2TsafbvHaqtXqU2NrbZx8Fcn8hvbB1GiJDlnt58C3tHGRUGOlt/3HFYxDDbqpuMJMK5cHBZ+vp8gQDu/DzGMAzo+zzFZRc3gIGNoyjl4cNVKKrsLypMwVN+d31A86cO716ZXojQn/X6TH6qTEWph2CTdfmA0lao3tWig9fOV6sbTWQM1sel8ptMXQ5hCoc4PWAcd+pvPNQDRJ5TrEHG9cR2V9+Ft/XnT7oYthjabsec0oPR+ES2LTBxYN/PbKBDtawEd9wUakRy69gfXFusNLp2ax7o+jjokp++GE4hH+H7TY6TowL+X0Kw+0DAsecnUaHr4rPhLr11rupS2IESFATfRh8dTDXSgDlg1vIYD9mzOx6k7aYSjbUWZVmgSDAA5Vz2nzPkRYRseSWjlyjPf3u1vWs/kQQFXsf4pAoGUwr8ErjtHIcD95fvKB7hfidvTuJ6RU27aK9tXfyzqYExsMgHOY41N8AToltvxDiWaCumzoBaNecVfn6WnfsR24fE4JtMOmyh+Agk6rJt5X8bkMgEwRsh77amEEmknyXQZKHoteo4EK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(8676002)(5660300002)(83380400001)(2616005)(186003)(26005)(44832011)(6506007)(86362001)(8936002)(6666004)(6916009)(4326008)(316002)(6486002)(66946007)(66556008)(41300700001)(66476007)(6512007)(478600001)(450100002)(38100700002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lFDbzFomrxKHyPEMsAWdSeFVYJRbGGKxmH77L6mJi+cDMCHGH7fjuRu/cFje?=
 =?us-ascii?Q?KQxHaM5r4kG2EjhiygF0q/aMbHh4n19CEByWzzFcfd+xhviZqzQmGFIRKbM/?=
 =?us-ascii?Q?nAm3/PvWZdGzZeO4jSHL1a/YXklTYoDjWfYwMYbOSASGLwncJGzW9Vsw1Tzo?=
 =?us-ascii?Q?VXKT5LVvQhoDkVceDLQel3YWpGlHQV0IFgPv8skQk999qjdPIkpzXHSgBOvS?=
 =?us-ascii?Q?3bP9ZIjQWfhLq4IhSRCwsoYWnN0fD54C/Prw3Uor3B1RRL04URpP0xhJypY8?=
 =?us-ascii?Q?u8lNUoJuhBQQBuvwN8XyeY0q21Yxi4yWu5hmkQiRFwq4lUkSkhN5XzwYhD9H?=
 =?us-ascii?Q?Jplhgl7EjQBJ/5AIltyIjpWiB0RYEAE09zHM0ZCHwOHhrI8h4a1VYaZ1UJ8/?=
 =?us-ascii?Q?KNIeXuPfjkI0pboffV8caZyzKcRARhvpIXK0EVL0UoCj2yKpZu4wcZ6Yw9lG?=
 =?us-ascii?Q?fWjUZWZKC4QgxF4TSLFNiQk7Vkmgz0awgA3ikjIJzOjVI5h1Lk/6dInKHzxk?=
 =?us-ascii?Q?AXBWzkehhlHEc3kH3nT5tW+xfYX4WMerj4pb9+iQFFkpxTLoCKzPe3clXMCW?=
 =?us-ascii?Q?DAIs+athCkl4g8nSBuElPZf3QRFbXfpTGMvsDnySEWOUSx8v3hWUbdiYaz0e?=
 =?us-ascii?Q?bUg+y2RnJJfHYUoeMFMwshcDWO01SW+6oh7bqXnX501rxOQWadnPK1c3AFmZ?=
 =?us-ascii?Q?DYd8eozpDcleP3bJJtOBDkX6g4hKii9CcMGV7bTflX+bO7OeRo17B7Aw8nqP?=
 =?us-ascii?Q?0Q4wZ8DbAATvHxDikdBtTlVqkQcgjscppdNGkF8kJuLQJrPVm1OweSWT3HT6?=
 =?us-ascii?Q?6QhrnlDt7/NjX4VY+mO9OfNcXD7Lm/Tfzt18BHFkYYyqzlpOVW5x9BsC1BMT?=
 =?us-ascii?Q?W+0EHGNoLSO/On0G7yZwbRnGrG55H8Q90VjGUyt/cERG5Lh02kXsim8m7+vG?=
 =?us-ascii?Q?VKyfC5BElY+C7Ie36zQ1wEbBG2a37EzkJztRCxKkoUsdvzLEydjPkdtVIsTc?=
 =?us-ascii?Q?RhUozVHxef8+injJVAc4rW/5c0gTFo94+no/lO2FEpTFhI6PSc520MZzNVok?=
 =?us-ascii?Q?6FYMxpBq2M4PT3SV2hR5WUchrPLVjU2I6XOqJfAaPDSlnnRdvfEyi42h5bg/?=
 =?us-ascii?Q?KCEY7mpPjz5YHNABhgkH5EZbuLYwkuwSSHbWBvnKwY/Z/uaAIB57A2xLZz2K?=
 =?us-ascii?Q?Ibl65d9RhIDMEe7ji9yUfBKdCBuyNNrNdepYuS+ZtKSPQ/ceZP/oV+ip2ize?=
 =?us-ascii?Q?PDLhYh9XYmI59yHxTU8q3YtPrCJGQ9XwlnBft55pNfDHhkic4c8tg7UHVAUJ?=
 =?us-ascii?Q?cLK5uoY0jDYOuznqBPn7hJdtQlZXvWKWO16eh5e6cNlUlhAWf1dHM2GVtMM2?=
 =?us-ascii?Q?OGxRQtYirIZYMrAHZ342yyl1MvZlRxkA2NJSdtfazxBVQz1qng6WWuY56TX/?=
 =?us-ascii?Q?ytbt6MnKtve/J29avjImIi1O7g22WHOpM1ADc6oZfhHsnPpnBVWbaik5aOI+?=
 =?us-ascii?Q?XVV4IxCudtPnEOIMmgMS8zTlK9bWroYLl/nOxGSnOs3OOCEVdk330y8SoCGl?=
 =?us-ascii?Q?4Bql41fsWf8BPvY7sTbYFNxUkT2tEmnTnOORM0+L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fcBNmG9zaeWBHKQpbtq6446ntElpljA0PTQj+21lMg4sVC29qnj5hu1Yg6+07tehexXvGXsbgyisbXPxLpgNlD9WHc/tc8M9Ecxd//sA6ivMxk3S9tzOUsVyZJVHFSVMS+zVLG/bl8I2eJwHQMhNoWPR95ChSnDFcOK5+NzALpZVuqvPT4qg5b+1QWJHgBQPFcaM4oT3Tb2Y/xpWMnevKxX+Kbrff9TuCwqYR6z6lVDIMarYFKHAEZnw1zol7vvtOS+n7xHurPpsddO/YwXi7jmgyC/vY1/5HbB3yxfFzdiQlAyW4OmozLZ7lWSb5/42JJ+yrlZxeTLpvIRQxBaSC4+H1qqcScCbPsrmxWylH8qWpclQoecRiFQWsLH5xrOKkuz8SM0eh6dWeegHF9Uui7Z49TBIC5ge8YX4QltvO4Tt/aOpzx0NSBmWI6IKFuDNulh9To8uY44iJc5ZOYgeGriovOkJxk2/A5PX3KTj6bChNw4Shvy03fvFG/kkYHfSBPFt774dE9Sq8SE02MZ2/LkftYMlIVngqQ9gw10sKtBhQxN3K62xS4urcoUeP37I8eZgWI0fg1g9xfW/84nvSxibBcFUBCfcBIMk3Pf2Hy27h3nFmbWp0OyY3Ck0sV10Nrru4xo21Xhg9shCsArZEtnkNOSBXMz5AiQlhMUHleq65fGa6N4BRtbTvGA/srg37+h48KY9aj1HLlIpbXiT3q2wBGKENkBvEwSWm7Jafjc/J478wJPEtsTDmBY7WfnQCpj/IPPoIYRY8nGo5m5qTw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a9e077-daef-45fe-0c82-08db8e80816a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 09:04:38.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ookznoxZTaLfQqwEPdpc55kZ6Dg+EHidq117v/RfGowHa3CvBWbnsncwpky0/SQr9k88Or0wFX8PyRXx1vKscg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270080
X-Proofpoint-ORIG-GUID: qmfbRWUJaVRfwIZer5RJbijeSHqk38ZP
X-Proofpoint-GUID: qmfbRWUJaVRfwIZer5RJbijeSHqk38ZP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduces a new configuration file parameter, POST_MKFS_CMD,
which, when set, will run immediately it after the mkfs command for the
FSTYP btrfs.

	For example:
	POST_MKFS_CMD="btrfstune -m"

Currently, only btrfstune's '-m' option is tested. However, there may be
more btrfstune options, so having this parameter as a config makes sense.
Additionally, there can be other commands besides btrfstune.

The mkfs helper functions in common/rc sends the SCRATCH_DEV as an argument
to the set POST_MKFS_CMD, which may not be compatible with other commands.
However, as of now, since those usecases are still unknown, we can modify
it later. For now, I'm marking this as RFC, I'm open to feedback if any.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 5c4429ed0425..3e3c84259f38 100644
--- a/common/rc
+++ b/common/rc
@@ -667,6 +667,9 @@ _mkfs_dev()
 	exit 1
     fi
     rm -f $tmp.mkfserr $tmp.mkfsstd
+    if [[ -v POST_MKFS_CMD ]]; then
+	$POST_MKFS_CMD $(echo $* | $AWK_PROG '{print $1}')
+    fi
 }
 
 # remove all files in $SCRATCH_MNT, useful when testing on NFS/AFS/CIFS
@@ -757,6 +760,9 @@ _scratch_mkfs()
 	esac
 
 	_scratch_do_mkfs "$mkfs_cmd" "$mkfs_filter" $*
+	if [[ -v POST_MKFS_CMD ]]; then
+		$POST_MKFS_CMD $SCRATCH_DEV
+	fi
 	return $?
 }
 
@@ -878,7 +884,11 @@ _scratch_pool_mkfs()
 {
     case $FSTYP in
     btrfs)
-        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
+        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL
+	if [[ -v POST_MKFS_CMD ]]; then
+		$POST_MKFS_CMD $(echo $SCRATCH_DEV_POOL |\
+						$AWK_PROG '{print $1}')
+	fi
         ;;
     *)
         echo "_scratch_pool_mkfs is not implemented for $FSTYP" 1>&2
-- 
2.39.3

