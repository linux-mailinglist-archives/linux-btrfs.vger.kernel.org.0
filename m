Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64672DF68
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbjFMK23 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbjFMK1z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:27:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD671B8
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:27:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65Nhx028732
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=ELpCl4ugUYOxIq5QExPAErPb0wC3jYAGgigKOfaVpOc=;
 b=dO7iOw+dTc5dQFZQyJm7eJ+HRj4O5gWCiWzcpKeuCDv+BV8dFs839AZn1509wnV7kozi
 1b73gLdeut00s3ppEVzJxrwa7dbjuSMYgVvMPv4PaNYCtOrXfEkaQ4XR7bgd4QHrJKpQ
 OcqzV/PDruK9PsEX3qADGCbuiq/9qcpDjCEo9Azp55ER6hWubFIL9d5Urr1FhgKOjXoL
 Z9uu3ICVIu3/BzdAH48STmbW+NumplkdFl8iA/F9oT75TQTPlS4nuvvhzg31KaCVmvSs
 HIw41orSR+6aFabe+PHhAT/+0/x0+GTjli3OT9hnl78WKXgyY8D+ydlPX6esVNGtduF+ wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdmubc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35D8G4on017727
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3qf34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGsD+RNQRTKmjcUw+DrRDK6KwS+IJY1xMfIDJuzN/G7/bzxlDF+1nGvIehniLldAnke8+OgToNq66ena/hDYw8VCV/sZC2Q+B/I8mTBbshqZJpra1AAAePcIDgdU+Eg/g+NwRYMBVcz6pv/9rcSnu3qH4jggyz8ZaDWs6ulrH0f8AN9RJSUH3+R2xgXgTNKgVdi37R0/+2Z/Mr7qCXUDekAB/r2K2949U7vdcAGDayJgDI9kXJIBSP1Ml+PnUBHki0UQMq21LrDswSsgxk9WiZ9Qf7dI096dm1c3KdtElnyzy6iKMT4jACbm+4qci+7tf9KSqCKc8CPvII48UYdO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELpCl4ugUYOxIq5QExPAErPb0wC3jYAGgigKOfaVpOc=;
 b=Gmhu2IIf4Rpr/LsuOf2B0LcO8PNzQ2YBh4uP8jOAHerWpzigkt2X/Hm5AleXHF7LTZQ2zJdYnX94b1ZhMyHdTexyo4mTcAiL8a03wz7XrC2v1iCknTCR8qNV0Q3KvXBeL7iT7aqU/8MndM5dxvXgJETWnrHepOzIvoEtrGeICGTelPg3OI6Kdh/yXm86Z75jYmMiP7TszLnbx51+PP9XE6Z7H32TB49JAb4odum+TqW2ilvhmYNAfRp0/KBViOPtibnWyfkicJ+idz42PWR81XWwiqOG/y6DEwD6rw/vA1ydNuQ+SHEw574YgLMHR/e5GWVEgdjUsrLq3JI1iQ7xMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELpCl4ugUYOxIq5QExPAErPb0wC3jYAGgigKOfaVpOc=;
 b=c43fw41D6HgxjNpYMbGPfq3riHfqV+bWs4q8Y2wuDC9i9Xl29N+EUy55tSvYXNx8Sy5aLNz9hNoA/8H7h3nHwT/fwcMT+z+NJSLEXna8qf18OzcArk+3ZU7uYXLxAKDu5xmJOy2c9kv8PNm16ffsnxz0ustGbVGX3zvNf/Cc0nM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4398.namprd10.prod.outlook.com (2603:10b6:208:1dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 10:27:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:27:50 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs-progs: refactor check_where_mounted with noscan argument
Date:   Tue, 13 Jun 2023 18:26:57 +0800
Message-Id: <a6739fa4e4e764b78f791cff7bb7b52260ed1c74.1686484067.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686484067.git.anand.jain@oracle.com>
References: <cover.1686484067.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 622a954a-d411-4d7d-2de9-08db6bf8d6ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeGa5p7zrJzH2EVoQRIcF2KXYImZvLkG7T5zudLaax2BF4K6hKXqsZI+bv5OSozIjGhDJhNRywJT2/0I440ofmm7XsP3C7E8owribqJ/JlyqrptSOJOWRlz4kQ6x10WwtxCE5be3/jR/C9+KL8V2QtqB+r5ojnkdbWDEk6mZl15kWA0goetDH7YYLOeJWA0NOfcpV9kdMh/hVjcBA5pMsXfkc2FGwWexuU9WY74lGXDSEdXVU11D8DHmTcJR48k8JR/N9pQhsFr0gud6KbrCmSCUHDYnaVNoVmjhQPs5aNgI2lpqy2SXLiQXcz/+BK9hwUMG+RUeTkL/m2sIHcRqBEDtWdAOfHOlIiYl2HWiH3YalKj9HMyWeWlb1wdNE02JbCqY1m7Y0rAYagce6TTn0azAf1tuTR63ROo9awiOFpAmbpmtOakTkmIcb+H0bVM8hvLaHwp92E7XVMfa1D4lIsMcc8Kdia64VYJ9NNZ2FZa0OD0tf3Z9PIWOqOuUPbPc9+gwpUtpeuZ1cEt603/Ft+bZ6k59WBHUrwbuWkuhmkP6TU3qa44UrBQUSqZfzzNS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(38100700002)(5660300002)(478600001)(316002)(6916009)(2616005)(8936002)(8676002)(66946007)(66476007)(41300700001)(66556008)(186003)(83380400001)(6486002)(26005)(6512007)(6506007)(44832011)(86362001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xps2F0vrBU6V5Q99xEkeQlaG1F46rT6BRqQLIynp+IRkS7TfdhRlnvVdVBY3?=
 =?us-ascii?Q?eNeSx/JjN0WfoPmWGcWKCgqLBosTL0DMhfTLkrw0jnKYPaFXg2iAVlwc34jb?=
 =?us-ascii?Q?Ja2w+UzzBcV6VTV7jb/b32ndrPj/0zUdjSvuxAAXEGMDd0vCWJF4ZIaGArZa?=
 =?us-ascii?Q?De8PKifcCzpfAlkfqGl+RRZtNsdqQjhZ+obwV9gbJv+WAZCHvQq8WGXQ2lns?=
 =?us-ascii?Q?OF32VzfzJAeJ/wv6s0/f7y1afcnF/2FNtHXEHqU9Qt612/P5hbnWaFjYQUf0?=
 =?us-ascii?Q?zRbDqW3R6azrjxDOPh2bjllcXoXSLJk3nzdcyL/tBOdO+dfAivb0nyhwVKUN?=
 =?us-ascii?Q?AxqaI9iWLLyUt/ln2v5K/eGtk0975kNz11NClNEXhXXxARHk1O6XXrYZ6m6Y?=
 =?us-ascii?Q?5tUFEauIufyIsGQnWxil88Ut560i7qIqaTcoMHHDZaBDCq6vS09eCckqfW89?=
 =?us-ascii?Q?B133WyAHUBIJYYWDDq8t9wPFovlenoDkawSFuP2IBXpOv95zA4eU6SAYWIoH?=
 =?us-ascii?Q?zqTJ2NjLx84PnN3LGDJHjL3QbKLv+UZzfo/vU3IxFXacHDf0hCULPGL8StVp?=
 =?us-ascii?Q?jo4Qs8800bRqV9pr62NT2FUulwYznPw2XnQhLl0NAUUmHRrJvAaWLaRekyAj?=
 =?us-ascii?Q?gWHTD67NkpA4IhUhfpVfPRRquwY4hUNbyVOYhUPlgTKTtkg3yBadYa8KRTdT?=
 =?us-ascii?Q?S8mU6Jssci+aO54zi/0KFYQpeGaOYyFKFW+mrWLOh9SMHKCIxCNcwSU5Gjbt?=
 =?us-ascii?Q?YSj/5nD75LRWw/VOxEWlAirArLM4/BpwWk3ymb3w/yxQYv4rRt4eZAfaFVvr?=
 =?us-ascii?Q?uA/NAiWTAD85TsOgSiywAG+96D8XhjS+WUSTvAdOV3G0nTB/Upz09ZMcUirD?=
 =?us-ascii?Q?HDnIN6lRcCUn58E5usni8K9oWaVj+LdHtQd1p8p5ls8hnuQSByAOxYuAJ07s?=
 =?us-ascii?Q?fU5kg31bQgDiOYfOzb84WbivuQOyoOx8oD3KvKL0v7HxWRzNkwCVJbWudQFF?=
 =?us-ascii?Q?JTCp6eg835PxkWIl8T9wrNDxPwqcfPpjabIJR43UJ6xYp1Yux5YeZ9uDcTOJ?=
 =?us-ascii?Q?SlmTUsSumO6qvW7xzi2eJa/rd4plZjrV4i8goCZ2tcPWyXf3d8y8zmKe8zTj?=
 =?us-ascii?Q?zycA5DuSJVYtb+XNWbsabJDj0HcvLzN6gDqBwoYnbmV+XSC7/3F6q5Syhha4?=
 =?us-ascii?Q?5bTmf9s+AQd5SL8ccneJI6Q8AtOG7WptAEU+1aWmdmApe8GDpmDeDetToIfO?=
 =?us-ascii?Q?ByyyWeZVuuEPQo0vzwQNlmRRmlJpZz4z1WXagpNXoZyaTF/ounP54VWfUYY4?=
 =?us-ascii?Q?vczTpuVdzaftyRTefNd9KhsSb2nPozfLOoj4dyAN1QCLcD8u3vobACaN0nHM?=
 =?us-ascii?Q?IYbs+YoLC2JiWTSit9GJWt1r68jGgCSTs+3yVdoXCjwlKtj/CMLPQ/DPtYDW?=
 =?us-ascii?Q?mca0juZxQrX2FTgem+86dnly+3DpaOFkpY2dgivrc6CoktbFkNfAlIbKnmLP?=
 =?us-ascii?Q?XwqLDMXgivPlYyXVgH8GU0nUftwb3w/XXSvWcPYbNTaXWsFRg9df9hE4vSuW?=
 =?us-ascii?Q?L08r5t4f2+JjffopRW4ckp4LOypl7Mb0n7suxctJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XwIY64cuPkt0GqhafMiiZ/okwZc6XkD0jG6LtPJcdx3/9RyaAF2Qe2xhITSX+FVWfCYxp/HrxV8mknLgjbV0sLSn3AXV7cZbLDTVc3VIH8pMLS95/SQ4xd60wuoDYZ8mf5a6QiNWwJH3nT+ahL1gs4T6x3jOmUK3V51P/bfRxUXEA9zCjwmKH6ArBmYyVOxH6c7u5tCTZslkSRvoHB5WGCeDUwHDIrEfHRq7uMqvKqt4ru0f3iHWzxfQ4mPqLnYcmdIGGWx1JTnI5OvefM0ZSVNpX19T4zo1NRLxQR9PFGJ42261W5YASudWn7xhXVe5cz/0o5+bNmsZ3M+sRFpNU3EQDW73gURVGHlruBM+3XiG50z9OfA5XG0fNR2VMiiPZNq460uN3InGtPdrnZ+1mdviekit+PPUN6NBqaWjmwXRJt4zRDb5trmVKNI/LOBsm4ESQ65BiHH0reR7xGx3Bdtbz8oGToAXGAJ1Z+m5e/iYYIegPvTz2CxOJxsCGB6GxixbWke20iMIbuHIJUOGrkFSH02JmxWuPkEYho1lgm7yawILo2DweJq+IexjHuDX+y3qDNkHsjz8w91Tn8+2dJvt3Izq8VSOeR2N0eRZTzGy3m3Oq2h17PdiNt6OfEhDHg41bnxXZlc09ByCwBUeuXEDIfVT0N7sFgj1bkCITGrfWwFH2g1ThFczqEFQeH2NXxyqgSfFzlmnLFEa+Fb9SaPC2rvqdDjnf5yjTMqFafrvOfzGWHgo4BJMy8YS/6zeOOHmuFcEPHbHOkQb+9gx1g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622a954a-d411-4d7d-2de9-08db6bf8d6ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:27:50.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YURdqchP9xrrDCZbhesMwejTjRvozWnXh8UOH/Vvbq+VibrjdlaZIMA1tFjjPCPlEFx8taxBxv/Pt9UCa0RNRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130092
X-Proofpoint-ORIG-GUID: f77-E7ayMKnVuQdWTT0UUOnfstrrFhsv
X-Proofpoint-GUID: f77-E7ayMKnVuQdWTT0UUOnfstrrFhsv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function check_where_mounted() scans the system for all other btrfs
devices, which is necessary for its operation.

However, in certain cases, devices remained in the scanned state is
undesirable.

So introduces the 'noscan' argument to make devices unscanned before
return.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/open-utils.c | 9 ++++++---
 common/open-utils.h | 3 ++-
 common/utils.c      | 3 ++-
 tune/main.c         | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/common/open-utils.c b/common/open-utils.c
index 01d747d8ac43..111a51d99005 100644
--- a/common/open-utils.c
+++ b/common/open-utils.c
@@ -53,7 +53,8 @@ static int blk_file_in_dev_list(struct btrfs_fs_devices* fs_devices,
 }
 
 int check_mounted_where(int fd, const char *file, char *where, int size,
-			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags)
+			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags,
+			bool noscan)
 {
 	int ret;
 	u64 total_devs = 1;
@@ -108,6 +109,8 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
 	}
 	if (fs_dev_ret)
 		*fs_dev_ret = fs_devices_mnt;
+	else if (noscan)
+		btrfs_close_all_devices();
 
 	ret = (mnt != NULL);
 
@@ -132,7 +135,7 @@ int check_mounted(const char* file)
 		return -errno;
 	}
 
-	ret =  check_mounted_where(fd, file, NULL, 0, NULL, SBREAD_DEFAULT);
+	ret =  check_mounted_where(fd, file, NULL, 0, NULL, SBREAD_DEFAULT, false);
 	close(fd);
 
 	return ret;
@@ -168,7 +171,7 @@ int get_btrfs_mount(const char *dev, char *mp, size_t mp_size)
 		goto out;
 	}
 
-	ret = check_mounted_where(fd, dev, mp, mp_size, NULL, SBREAD_DEFAULT);
+	ret = check_mounted_where(fd, dev, mp, mp_size, NULL, SBREAD_DEFAULT, false);
 	if (!ret) {
 		ret = -EINVAL;
 	} else { /* mounted, all good */
diff --git a/common/open-utils.h b/common/open-utils.h
index 3924be36e2ea..27000cdbd626 100644
--- a/common/open-utils.h
+++ b/common/open-utils.h
@@ -23,7 +23,8 @@
 struct btrfs_fs_devices;
 
 int check_mounted_where(int fd, const char *file, char *where, int size,
-			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags);
+			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags,
+			bool noscan);
 int check_mounted(const char* file);
 int get_btrfs_mount(const char *dev, char *mp, size_t mp_size);
 int open_path_or_dev_mnt(const char *path, DIR **dirstream, int verbose);
diff --git a/common/utils.c b/common/utils.c
index 436ff8c2a827..b62f9f04ad5a 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -230,7 +230,8 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 			goto out;
 		}
 		ret = check_mounted_where(fd, path, mp, sizeof(mp),
-					  &fs_devices_mnt, SBREAD_DEFAULT);
+					  &fs_devices_mnt, SBREAD_DEFAULT,
+					  false);
 		if (!ret) {
 			ret = -EINVAL;
 			goto out;
diff --git a/tune/main.c b/tune/main.c
index e38c1f6d3729..0ca1e01282c9 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -268,7 +268,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 
 	ret = check_mounted_where(fd, device, NULL, 0, NULL,
-			SBREAD_IGNORE_FSID_MISMATCH);
+				  SBREAD_IGNORE_FSID_MISMATCH, false);
 	if (ret < 0) {
 		errno = -ret;
 		error("could not check mount status of %s: %m", device);
-- 
2.38.1

