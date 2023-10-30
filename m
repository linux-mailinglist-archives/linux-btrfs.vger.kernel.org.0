Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DB07DBB87
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 15:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjJ3OPb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 10:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjJ3OP2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 10:15:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E8EDA;
        Mon, 30 Oct 2023 07:15:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDpWx6002573;
        Mon, 30 Oct 2023 14:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=YJJchDpyG6ImdacZ9HqFQiCokJYWvh2AUH5fyvSlrLY=;
 b=sr0uUFPNmr5bY7R9hTY0UYLa6lr38dJ8WkwfraOHnu/hda8pQjN508/IRDHEx6+BIT6F
 KrqpOdb9gcN5jGikuOjz1F8d7ZOOtqGNY5SmYbUyCiXpk4KfPGM9qfCBbmGt7HVAp2Pv
 ni7M01JK2kiCVDiQmk7m3GA3wFfPV73hn7HWGMWHYxp9XZ255oDocrIOQErXAiQoqs5n
 ub44v5jddpsHJt4lLOMxYbcVwXe3W1/6Jz+iAoO7VMP+ybZr33nGin6ZDGRVuZcmB9dH
 Pzg8g+rKJ+U5mf4WOGddGQaOZwk0nlL0aCpCMyXAoFBJwoY06p4eJt3kzyq4W1HBrulV Dw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rw22v98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UE3QV8001099;
        Mon, 30 Oct 2023 14:15:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr4p7fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=io+vTNRWnB9t7KDIMRP4Xo/8Q1aj/sHpy7FFsZpTT/fQRCmCNYc67Xj9bTdRWg3KIX9zHWxrrO5lFeMGG/GCwVRPbZ4WumTymaD0kVXi/AgAO5MP3LUXpPLBRqaqrY6K3/v5ESBSy+XO7gbQIyIZpcK1a9xjL7r5xe4q/VfJX+oIm8ynNzWX+hVYg4frwY9cBG4s5S8WR88cuhONa6VJRA7OInMLw2sEiKlQlcmkURCjhDiAwMLqH6L+5PSTAZW0HVveC6THiuNONkXC8ax0c2YdfSI2i5h02ajST7MpJwnTbRZFMdXNHLJGXDVFuvv0bd0hVcFAohwRu3p/cS6UFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJJchDpyG6ImdacZ9HqFQiCokJYWvh2AUH5fyvSlrLY=;
 b=nXAZd/kWU7eZIewb4o2ssAJdBcUe3Y4orwQw9koCBWrJxCefuoR+rKP6SVX6Erj+HVvc/RGdmA/dLVRNtw326QwQaQRSURRYdKnLTotMMRT9JdduVTeYkdI5PHWb0IoK6GxH72Dv3zVFM38bQngePcrtpDQAYMhunmY+M+TSMly+gFomhZ7VeYmSd+nTVM57uwUUTaihW8bfWg+wTw69eOSADrfsx7b/TDQyiHmAxxsPOuhIOhBw3RNaMqr73A2fcG591rpdLFRq1NDOwWG1/FWQ2JeWySaX1ckMUIaOx0sPRuba+/GFbBmDRJoBSktLS54Cyda8izalNtVWUNje5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJJchDpyG6ImdacZ9HqFQiCokJYWvh2AUH5fyvSlrLY=;
 b=OpFwHgsyZFAk0tOQlPerwkHL076dK/fA4JYvupaA0ISiFBgNrRA26cvWvfj0MwHLVkJhgyL+l8o/VgcoCkL1jTyz+TShC13TywL8A+6oU6ocz+vSK12Smoq7CqvNynbZy3IT6fgulqHQd2A1BMfjXbfTw8x8HPamVS2Eb051Uw4=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DS0PR10MB6127.namprd10.prod.outlook.com (2603:10b6:8:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 14:15:19 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab%6]) with mapi id 15.20.6907.021; Mon, 30 Oct 2023
 14:15:19 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH 1/6 v3] common/rc: _fs_sysfs_dname fetch fsid using btrfs tool
Date:   Mon, 30 Oct 2023 22:15:03 +0800
Message-Id: <6ac586f4697e84c846a36cbc42b005c254b83de1.1698674332.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1698674332.git.anand.jain@oracle.com>
References: <cover.1698674332.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|DS0PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: ae860652-24c7-487d-59cc-08dbd952a5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /RaMlVfLgiIdhAOzThvGkr5x4YV3rk/O0MFS4QQg075+X8UjmdaSgNNBaakIdjOriF//xtsOORqwgpb6CopzYGGwWfGUF0TiqLNdflpCwlvcW/G1z/8bNq/ptfFJJpm4MTSXNXpvVjchdbUUBMxGePXBZY13oiJlru7Th8kHpDGFDpGKh9YDCkQ8aF++huc4ZFsqd+CZP+nzcf2NHNCLHL4gPE+9GO7kL0/LIyolFwWEaYix6wLS3XiXsvmY7+CCj2BefFOWntSzV5W33+eOyGrCj7BxhpTTHUH/LuMylJua2f/O+oAgVmuQFmeyt3sfrTuk8SuM2u9l/PdduOS2E/gGGsS9Pja661GZSQIiao+OLtcIRwuJ4lVZ13J45CXzmCcA9b//g4RJNNa3rmiukhES19cKoveauvbJDKHSt8MqMTOerwEHsIwvK3v1KfGvt5wcIFOTWscxqHIdJWWDtA8o6xEo0RezURWhCQmMwlM17w4kRfHYGtGYAOlZcI8S1LwTLkZF3INz+QhQn1BtdfOA/gb6IHbx1Bdg6+H5DUxP7m5OY5NT4l3Z4PctiGWP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(2906002)(4744005)(83380400001)(5660300002)(2616005)(86362001)(6512007)(41300700001)(44832011)(66556008)(66476007)(316002)(6916009)(66946007)(6666004)(6486002)(6506007)(8676002)(26005)(478600001)(4326008)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0dU+1gx3Frf8e+/+63p7Kd60NiV3jTMmfvaH4WqDO4s5hvC36fAjxuX16IPi?=
 =?us-ascii?Q?lSSP7rASLUsNPTLB5/Ku9/Z0F5yFbeiqZ7i7GBCRnkpagiPdTPZfQTHB0x3f?=
 =?us-ascii?Q?0aX4isO7ohW0Zm7+4IyYFxCjU7tKm4KuB8y/z4JgJEvGZ8cGw7cPvEmLzg3t?=
 =?us-ascii?Q?M/2yUD8lObhc87io6zfUyoGMi3EbvtKQ1I2CVdHh7Pm3/jPCrhyNxpiHcROc?=
 =?us-ascii?Q?/GJnrTYR3hM8JApDjtfCiLBVcDBe405GDFvZZPY7s+Yy3W2NP3z6cx8jGP11?=
 =?us-ascii?Q?3UfrMuvVzsQBxtl23M2SZJ4Z2yivGogYXAVUsxs8JJCZt4zyqKD70dW+VG1m?=
 =?us-ascii?Q?PJXMT+BeLWB8tX1N8uE5Ow7iloXHG2wK1YjDljKIoFA/z0QLeP/0f5zshkPn?=
 =?us-ascii?Q?2GLB00+7RD/GMU+Hqt9c3cV4geoBoMPLfQPyq0XZok8WA4St1icp7f0qCUSJ?=
 =?us-ascii?Q?/O4rhjHRclBLQyj7f+Aby7xo+2+/DSkF348gSv2qq5dt2XupGuzkp6uIz8Dz?=
 =?us-ascii?Q?7J0GjL7RMLlo1NPubnXOxPwL3rgyj6YKEo9V/Ank2X0mzuj6X8PYR14qf4yC?=
 =?us-ascii?Q?I4gVT3OYuFhAD7ijMbZaAThW67svAWlzq2b9aiuN14qKd7Vfi11/Tw3zM9oV?=
 =?us-ascii?Q?O7rE8LryLQ1zlvejaVTfCPajCw1HJBhA+a/zKOw/hz2gY5OPKpLB3ZO+i5ac?=
 =?us-ascii?Q?6l94sP45xDlEfK4d2gxsyqsxBxfOBbgA1wPlvpnsPlOdGn+MbVvwN9+OymNr?=
 =?us-ascii?Q?IuvZa+Skgy0rtt4uxe9NESh3NDl5P+1lcytuoYRAfDO/j79spxKYmhtYf65J?=
 =?us-ascii?Q?1BUVpeK/iDDHXwUuLAx1XCd8LKLYrpg2992IA/6qJwsfzyOz0bTwaFjpTMv3?=
 =?us-ascii?Q?3ZI1s+Hqn9r/Z/qcyEf9LjK1PUkbtW9J0m3DE5jbZGe37GtJW0QB7RhC3xC3?=
 =?us-ascii?Q?UzCnqkdaQkXqOkwlC2+mZcQ2ukjARFGlOsVWuHUo11XebFPpFW2MF8O6E1Vb?=
 =?us-ascii?Q?inLsJA4EhCBAILYmFVYGgRg/HKlzZ5FIBF4WkN95Dq11gTg7M0xZyPmtAzt6?=
 =?us-ascii?Q?5XJ/LwJlNm5c7DzPHiZYdg8pT0qExd4ZpJuRAjULD+RbZCYuVzueTlx2uMAc?=
 =?us-ascii?Q?2BIX4pd9K2Y2Uc7okMhXfeSH1rzi4rx6EaJ7MicPlQFTiY4XkaUJnQm5D1y+?=
 =?us-ascii?Q?6uDsuvCgjm4biaDWIQ/W2PS0pmTeO7qd1vFUzl4n2CD3hde88q44/Cgsx0vN?=
 =?us-ascii?Q?qPxYTBn5Qqu26E9OqirbV+pyTVAy3QTs8Yw2TFhN+fQAlZ2cXhd0fCzoZXmh?=
 =?us-ascii?Q?GvUPbpbuhAP62Vul7y1iLKe2rRWhCEu6VQSxc94Hsw6IOsg8E6vxFrpUhUwG?=
 =?us-ascii?Q?6SSc7y49+5qLKtp93ZV+kHLd7tgwTWCml/N2zME5ZNR9DV5pz5Q4zkOAuMzU?=
 =?us-ascii?Q?Cxk1TE1QEhc0gdOunrTdJg7v1Jd/kUvmqg8fleaC09+sFaJbpcNfk0WTLZVL?=
 =?us-ascii?Q?+Fa6wh4FAOsM8AStaP9lZECilomJiZ535jLVEEQqXC6ByknbMTggrGTmX9t5?=
 =?us-ascii?Q?tRa1Cw+fekmq/pqhVQiJ2HRXI4F6CwJ+MaCl2joM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Rop1oiQ1VVCZut1KMN4l7tkgr7EIuYAbgImBeos16YJGIaq59LLgS16NHRTQsxRdKx1HOUnMuMij0eQAVY1KiFfffaY4OZSENGaAn2JXX3pnXYGg8b6YWnaGSNzWMzNAQhqiOwJv2l2rlEOqRErtantNROMa7+tCTvoM6Q8Cu9Btje1drAXaUcZukU88Jg0OSpr8NBAO3D7N1xoVCRbCWSIXZwe6ujfSOw5jBpSQgZ32c93gYdDRKFwA4kcgiUs2jUH51sEenFTXri6BOHZi70CGQqgpOBfmXI7ZJe4VG79H6Ur+/190cCrx3tB4S4rDTGssarSs/rA57yDXrEBffydRnAlpuLl1YFE0R5YKsfnBytk8s8SDOfLpRYj2gIdthlY7Lfku7UTFKXYM/zpYTZ+ehtVV/oUH19/4zpQF7kSXxtUPSH9Tl766Beq3XlonUHaBiyW1d0L9MzPJrUb1UFBlXPQnC7jBfsSSynCX56mNF2p/fXAJamUXi3fOgQJpeycWM6cam3CfLPKNYeZzE2PhzwimN+ng+cOsQH3ZIuu2yy2d6EaHBgd3cYdKkxZTlsVO+9RCbn08ruherwxNwvquh9w5FB0nOWrPmr4t6v/A5yin3f2efhWas+65PPD1GNDi3g9wuhQumk4yNzFXlRoZqLhMdp0SnDcdE9sf9RnUUufvMFfu0vAguFQeC7TwDcOugRK1ax5tW1qDQiCJAwTArDoDrFGHmuMEbMW7rfVLY/YWXvK8PtbWdUN5p5m0KWjx8XMw89V6Y0dB6wLTTSC+LnuGMNODc7xMRQN3tXU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae860652-24c7-487d-59cc-08dbd952a5a6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 14:15:19.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHJ8gIYX7GlICsQuTRYsgzs1ACN2n6DySWBn+aKLQRJR7UC5azmdNLnQXK4QPOZc453k0L3Ja0HNtZk0pPFy5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300108
X-Proofpoint-GUID: XgVbmtZY-4tdYtf6qpIRzTg6LrHbXHLQ
X-Proofpoint-ORIG-GUID: XgVbmtZY-4tdYtf6qpIRzTg6LrHbXHLQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

v3: add local variable fsid

 common/rc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 259a1ffb09b9..18d2ddcf8e35 100644
--- a/common/rc
+++ b/common/rc
@@ -4721,6 +4721,7 @@ _require_statx()
 _fs_sysfs_dname()
 {
 	local dev=$1
+	local fsid
 
 	if [ ! -b "$dev" ]; then
 		_fail "Usage: _fs_sysfs_dname <mounted_device>"
@@ -4728,7 +4729,9 @@ _fs_sysfs_dname()
 
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

