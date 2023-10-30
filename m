Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399227DBB89
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 15:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjJ3OPh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 10:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjJ3OPf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 10:15:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB75DE9;
        Mon, 30 Oct 2023 07:15:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDdmFi021009;
        Mon, 30 Oct 2023 14:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=odNJi9PHlhXSuWLaj2HvnihquTDl+bi4PHcRPfCmTr0=;
 b=v89XjiWVXBgEjObLO4SSN2qd5FArT4eZqm9RHaCfmXu7T+rvd2wFEe5ArDjZBrau9Hbi
 5gCIaLpXi5HIga0dD52iPbG6iR4FFyGi1Cq+WKMaUhEqQ40b5queKOcvhzDWbrl0GWEa
 aRQjDh5NX+hWO6ABKvHceHXsqjgOTFTYHI75H4BOLlHZPioL/GS8YM/2hSW8Cm5rDowF
 Z2NZFDSkpDAqzS76tUN2RqpwxI7K6NtVfTqDLbTSMcdySwISIoqbrXzeIQdn7OwtrFsM
 EtuL1ZxjR7L0uneqX3eCOAqkYrIwrkvHIARfTTUX+NzlVCV8V/TV515Ryh1sNwmldvw8 QQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtjw4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UE47WW022584;
        Mon, 30 Oct 2023 14:15:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr4aujn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:15:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/TvXFUDPCjsYVC/IX0qu9KBH7xo3cbIYakw6mQ2OV/hMIo6qjdeyMqlfaVxSnfyNe+ltXEEiOx4TWnybtdzjSyX8RrS2CTQAE5h9rP0TwrmxeEEq34d8XS09oX02QJdeJr7jaIXxKUF+rF42gsRitwv0FkDH4g89m9u6eanXVSYZMZcavmXS96lDGDdhQk03B7Mwv6IAUpcihY+Qags8lJ63cRzbhxr5T4+Sd5k55FpDlsqDkOa+ld6K+8+/DDHzes3BjKYuAOTt6vBQW0D048zw8E2+ustj258sItuMrYMhVkD3OMIhrg5Hgt0nnlulKBOzTZrYLmVVepPBmoZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odNJi9PHlhXSuWLaj2HvnihquTDl+bi4PHcRPfCmTr0=;
 b=DhZRQTLKTtw0K97tNkd5SlWtVOPsSGIiwAla842F47cWPOrtMNUKGkO36TzMQdMrRJ830jUzNl1sXiRe7f4bMTfj7+CX4998+3GeoM2FxlKg5YCT+kp4comZhoEapRQbZnqoAUYW0Q1kXUFgxhjrOc9e5AWQdGI2/Kz8x1tbVyZvFN41hG1s8Tc/kt6TSIzIqqYCTImhMmJBCp5U2QF3SfhlpCyOmjePItLw7yrNruu9q7kKOoVr/UKghMXgHiKrRPIBFOxR8kX06SZRLOR6QTlmQZGvJo+Zw+xzcrUHkfnpFBs6NK4cftTiKp8gl2Gavd6AV44kcFBz+jqlvdbFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odNJi9PHlhXSuWLaj2HvnihquTDl+bi4PHcRPfCmTr0=;
 b=hs0AJ9OrPJblixkUQ2fCwnbJ+2T386xclh2IHTpMRhmI62It10GmrAP4dAeF3dDtZquNy9QTfKE00mV5QStX+BCcchJ27Sfh7VP022fqK99ohMChKfEgFnUx8ibR0G52Hp31JzlbCD2xp0sWzrGdVQ7ToBFraNNgpzlm+wIrut4=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DS0PR10MB6127.namprd10.prod.outlook.com (2603:10b6:8:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 14:15:25 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab%6]) with mapi id 15.20.6907.021; Mon, 30 Oct 2023
 14:15:25 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH 2/6 v3] common/rc: _destroy_loop_device confirm arg1 is set
Date:   Mon, 30 Oct 2023 22:15:04 +0800
Message-Id: <1f320bb0c1e11dbe441dd44eac006873de5f267c.1698674332.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1698674332.git.anand.jain@oracle.com>
References: <cover.1698674332.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|DS0PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: c69bc734-d8dc-4e0b-fc6d-08dbd952a8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27ZnuGwn+2jh4bgr4o78umMw7BrieLwYrolPvsIhwgC3MD80JMnnTp4IYrG2l7FA52c5Nk5ToOOzxZAxd5ChgBDDK5M0DDKw3l0FyUQGBF7WWaCwW5N1Otuey0Dz0ArH9uTdy143q5mQhoqZvR6lAAO4eX0Ztb97uBhCPhN62oC1gPNs4FAf/k2JJPHoMgmKs3mytWfwaEIwavWIQovT8Eq4dRuqwolla3s2jXpOnVMnuhiSQlmFxYOuYBlQ8nX0mlMRC8SYHPmryAAf6MlzEXQZm1xMMmRVJHxdw0xHLMoJBoi42sAryP6HGZ/boxr5Xob7KPUFzf/qGONIwkkerXpFRcBs89o7k3nNrXrK092V0OwV2eyLQqNUR6qd+8qAtszDzchqhL9cgGeoaXqoplzE6cSVHBghxmqtUPuKvy0mwbeHOTMc/jUvZbrgDJVoGf7OhcIYg0Fez66HoyjZNS86+eTMiUqk0SKkifLq1BbQubtHbQz37N1jeA6ZBbpH6dXysFH5s3f5WQsgij9hEYc4C69BhHhEm/OFg1V2b3r3Qz34Xj1kshSTeUrjL3kB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(2906002)(4744005)(83380400001)(5660300002)(2616005)(86362001)(6512007)(41300700001)(44832011)(66556008)(66476007)(316002)(6916009)(66946007)(6666004)(6486002)(6506007)(8676002)(26005)(478600001)(4326008)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PKQKr2M5eaVj7xG45o74I/luR9D/c26W55Q7PHK0UxyI5OQEMSoWq6bZiRCu?=
 =?us-ascii?Q?a1VIw+twlqPGn3iFKER58Rvu59HNJcyc7Xk43vjwiwAlD4AtVlFjHOtTdqjM?=
 =?us-ascii?Q?syUnTwBOky0acbwaO+cdezys6gSA1/f6RcHpys+bE5AUufSvnTw63QIR3dsi?=
 =?us-ascii?Q?CXBCef8ZIriPBCLufDsbDqPYCo8aaNYNKn9sfigrYxDg5UJrgDOIRhv3Umuk?=
 =?us-ascii?Q?UkNhMw9zpAfgU5QrmS8fzcahYHyRBdYR3oQPrdgjRMNjEEojWPv5FMYdKb64?=
 =?us-ascii?Q?odSLwmMKd/Fqm4oQnEDI5/jL7LpCbrstZD1aMQEViuF1MXgm+cU0HCL920H+?=
 =?us-ascii?Q?RI+/M1MeXJ13itA7andBBgH0XYAKrVJ/b8PYwRfmBr9WSwCVbfXgeCbSoQoa?=
 =?us-ascii?Q?Df09OJ3BNGfOyuvJvVNyhv0yPOQAUC1AEmajnCPmqLStTOrULYc58CsMa3Vt?=
 =?us-ascii?Q?hOOpU6RIKl5XyDOIARe5H+h0oiPYQw54Jw9R5VngvXOrB956HxQlTcDrhG0T?=
 =?us-ascii?Q?kTGohd10dw/shngt2os19loNpd8dy/giYkMogRsNQx8S2ocU7M6HKJRAgCp0?=
 =?us-ascii?Q?nlKMoNFBuK0cSPoZVQn8yA9P/qL6Wx7JAHMWNh0t0rUJb5KQOq7jjLh83WXH?=
 =?us-ascii?Q?VGdNcahN4YwmNfGAxTTB+sRGiJWhkwebvXHT5D0GGQmBnT3FTpjXRCDvDVNC?=
 =?us-ascii?Q?mAolLEY7G+qQMs0QUH5FSvVEInII/+CWOMTZnpt/+tlaCRd8nT95B+rbfSwd?=
 =?us-ascii?Q?KLq0Ha3gC5FXkNdZX9v3rnricBvSBV9mqvqZDuEgXVlK7nh52QdeS7lCRCuE?=
 =?us-ascii?Q?Vv118yG7DVGxYTcE5YShOm+Q4SL4Jojkk6aagsH/1v9Vz+E3nJb6BF8neTVj?=
 =?us-ascii?Q?3ojOTQqOVwmUZtteqXHuy4OPRkHMlf+XusZwYb2lKMXc/0+Gouib8OpkrDwU?=
 =?us-ascii?Q?cjqZJLP8PhSypsbltXmBlkzCgSqZZhOdZJHtJ8c3ocTEK/YDKRb4Jb6x5t0u?=
 =?us-ascii?Q?37vJERPMnr//IU9OEX/szZC4jGocOB4v5eGcMt4gRezWSnmdixMYxeQL0/gX?=
 =?us-ascii?Q?jiL778zLu8LM0L3sESbaVz+ugvdyyb+muS2/D4iF7UGltgIVexycO4n6QEff?=
 =?us-ascii?Q?qdERgr6HRqG7u4wYHhmfZcZTgU9ltBlLipB/OM5vd6wUf3DVTtmKdrlWmkYw?=
 =?us-ascii?Q?KL5WqB+eZ1GymyIfKBPcJQdhdYhqxgew52PLkIelV3xocsjnG5vpesxOh5kw?=
 =?us-ascii?Q?lLvMcLW6gJod9xX6NyiqY2a/7uJrqZFvYwur25SNKrxocHCUzWDy7aP3/EH4?=
 =?us-ascii?Q?Vp3nWFH3dxhac3PEozUSojervw0BlHzobompmkQ8kWZTY1cOMWKj0Gxsdm9d?=
 =?us-ascii?Q?shU1BMbNQSRk2GaUm3/o0tqmacMypqU3ErkqS0v9nHUqlmEYHarrjOhYOuyP?=
 =?us-ascii?Q?NVR+B3YwHGkKlSR2ou1poKi4nLBTiawGHMqN5NiiOF/bkVTnDwy6ydE1EQht?=
 =?us-ascii?Q?t8bujn5aMcYj7I5nsHntaEsrRvQrajWUB8bY0fjKumbG8P/vnNqg/B+Eky6X?=
 =?us-ascii?Q?Q4xLyKwCapDccBU6/zPCTJ+GLCeLkkJAzoKQ8uFV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /UgdD/wSrBGL5o0rvn7R8q+hTiTaX8ozdKXsT2yUvPRSczaccpjeI3lE8Liu2iY3y64t7P9gRI9y+6cR4OpTPHW/YXBXALWGuNIHOQHLkX+/qfTmPI7k8LwGKPYzzhn6oX2middOwXaJBREcVbVpe2fG9SBw2f8XzCBspzQMLOj9XyVmJjB6DkRFZ2j73d+dK8JLbaPj1j+/PsM83kbwuvqKLETq+3WrmSV0B/YVoaXmRiL4hHvv5ZQkJLi+WZqmNmYRtmhnJIly1AQ9PhETdSwMrZPF9Ke2Op9ZVmqSOsIJOEyU8RrGyUg1GDKZe4/AYi/evO0mD5kmjrZboQelirAklBm/Cv7NXT+rJAB6Cj8neMZFQksRvoh+cD/WwBz1LdJdvZt9CQXpP5IUf7+FE1SBN8U2tLmUuz4C31bhPnO1xHM4uYL4TzZ8TxNfN9i1CA3zGzgCukRbr32kVAiB9t48/X9n1q6msor1F5HduS9sePWCneI17cVnTvL7bE4jZBaIWz7rli6wiirOD9mlDD47iltO3G2Ix6bHt6tH4bQkMtGqtrIGVqBtpBFfA1tGFY9bVfaW2PJXbSfbiOtEYqD34m3PFX3BiWMB9xIS29/PZGwrLDtiWU+kdKpkCQuB4og0Tour2u7npZEHnjOhkkVQsFqGoqFbsJZxbCsK3IGJVo1AMXm2LWkZZTmwIBHoa58rPCqgqYcK1jHlcPPNLgrBsSDwsshLRaTTGxa/OnFWiBFNgVDwhmQ/DHuGpBtcYY82mxn55o+80ZJz4gWh4kxjPMVeuqh00fWN53Ze7PY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69bc734-d8dc-4e0b-fc6d-08dbd952a8b1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 14:15:25.0824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6agnP3Kvu0ISEXsngtXBjti8FxVIGj7F1/rgJ8MaJnSA+7tWUQOSIEXM9QOZgvcC5LGjrDLtlv5qB+AYg/kWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300108
X-Proofpoint-ORIG-GUID: 2NfRpVUq6us3S1Nz2i1XpfTZHXbgSSYG
X-Proofpoint-GUID: 2NfRpVUq6us3S1Nz2i1XpfTZHXbgSSYG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Check if the dev arg1 is set before calling losetup -d on it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 18d2ddcf8e35..e7d6801b20e8 100644
--- a/common/rc
+++ b/common/rc
@@ -4150,7 +4150,10 @@ _create_loop_device()
 _destroy_loop_device()
 {
 	local dev=$1
-	losetup -d $dev || _fail "Cannot destroy loop device $dev"
+
+	if [ ! -z $dev ]; then
+		losetup -d $dev || _fail "Cannot destroy loop device $dev"
+	fi
 }
 
 _scale_fsstress_args()
-- 
2.39.3

