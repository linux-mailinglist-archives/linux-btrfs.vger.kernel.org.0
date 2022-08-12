Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166ED590F84
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 12:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbiHLKcd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 06:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbiHLKcb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 06:32:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19A912B
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 03:32:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CAQLRt028574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 10:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=84s40Scsvd8RoBmJgT/XPgpBV9XDA6gHBSZsjCHXY40=;
 b=t8TnIOUqgg0sQCxIwlaHh2/KGP/egkN8oA9Rm+pWe0XHBPPGToLXXgS6j+ODFLPXQ+Gc
 tOyzftJ6/k50G3mexd6GKffdQlvqU6MH4RIp0+qWu+O9/DNE6nzM/m/DLZ4kAi3pvGX8
 0+6iKy++TmTRsWiaqHTlT/VPJ35ZMhFtebuglYhUdssnxjJ4dcxrogZAPLIxMabIHqbd
 HXyXgOgz2L9bcx1kBAvNiz8JxqFSfDdq6wQisYaef0jhlPm8xavLGagORIp/tqtwl6Mp
 vQL7T7JZVOEPQLyf7vc+m7sJTJ0P+3pJjWJVVC9o7UpcJuzqk1Sy/N+AShRfrIMaV4pH aQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq9pwys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 10:32:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27C7xsPh004123
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 10:32:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hwf037r37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 10:32:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLfkntplHtV+e7D5EyTUFM8QebeLulg1HgQH+S65MN63dnH15vKxlaGxhvbBNx3GCNWFx869RvpVMStjx8+XEuA4dQQCeWpF1/ju0RZNXcENT4yKxhq8GDAvFOMe3f83xkydfhH1P7FxofZP92gBqSVKDzpzB/hg86s1vt2MT3KLcBZ5GqCxL+zqxBptXKyTMxSO5eWvDnvxaMr/4JteETOVEARlTe5qPlvZJnPTlVFxSqmbRkLPt/I+jgOBgc33f+1bb4S7OfMUCI2E7ui9IUrXdQfvUl0aLddHiJeSFAjHCj1JRCoHwRtBzoP2FK+tf1CuS37ARfnkjKoEwiP2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84s40Scsvd8RoBmJgT/XPgpBV9XDA6gHBSZsjCHXY40=;
 b=AFKI2Pj6kD5lV0EDMlxpAWNW2JogJeVzqzTkc2BlcZ/3evXEAZE+SQ+Dbz5u9sxfoVeZkc4WUKfGj3q3lNV0hZ/HUX8DIpgEyADgBnk9aH225BT5qQobGCJJMUOUiKolfnm75ZXbr+ycCxHI8nDODBKh5oTiSpbdhcOp5RDOeAZYCyTOZaGtcPKjjuKaOB66ODrHWn208sV9Gj72avkc2pjjyfrvtIuuIqdl66UR9jrPA2bd4l8A0qQlKefMWW/Lxnz7L+lCMGshD1bs9QNOh/jlRpuvnpN/ehSsj3I8bLN5zTzQYN7HycELXKgtyL/bmEPjPic3mq55w2DgqaapPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84s40Scsvd8RoBmJgT/XPgpBV9XDA6gHBSZsjCHXY40=;
 b=FeF0WekkOx/wsUGslA0SGUVpP25OcQmY3qgaYaqGa630j7gEN/doshF65dJgDoibr41jKMnaIs6QopAoOerBMcmAR+pq8OC/uRjp1CqDwfhSOSzjm55xK7r1rXyhV6t713OP0fXoWD1t1ceAieLKt48nhyxeZ/k0Z1lP2Ki421Y=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by MN2PR10MB3598.namprd10.prod.outlook.com (2603:10b6:208:112::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 10:32:25 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::1806:9736:d068:d5c7]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::1806:9736:d068:d5c7%3]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 10:32:25 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] fix issues during suspended replace operation
Date:   Fri, 12 Aug 2022 18:32:17 +0800
Message-Id: <cover.1660299977.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5ba5796-1a16-4655-bcac-08da7c4df277
X-MS-TrafficTypeDiagnostic: MN2PR10MB3598:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cK/WXM7fXAGPc7F8gX9ewzRrG7kRq9MDTJUhnC+Y/3dAJ3Lm+1seRG51d8IkjSMU43BSoUxSFI8jLuxWuff0f8cWvBeYOB9CF+Uciu4HjwFg1xMq3KRIgEDJkZB6y/BLX7XW9LwOE1P6lAozic+opPJGCZdAZCYUZIZ6a5oEmW4Fz/7+rxShA5Rr3U/nxr/IDYqxhU1tU8nt1gEpzyC7ltzDiYW0wHNNAjPZ6I6nfHGTI1SyzcY3BiJj6CUB26CLWooXesFhHG6U17Lafo7P6UVSrx/B56qOgO9mIfsOC6o3k/A1VPNLh3SU1jirBVxn5OqOaddmCul6H0/p8Tx2vvDpyK5KhsnV40BDu9F1RR4IX1TnnfHjEhb8MBRWiiSeGfkySvp+4mIhh7WoZYYgV6UhGdFYJxIr46J4fN7wwUOka7AscweWeY7dUiXvN0ZLqJNXno3mKyxeNixQUBlsJiABz11ET23ur4Uq/X+koSvp/1zpNgCzukrl94OBxuU9K2AmbjApSr9fwMi6cApW1jTXQzbtTbNRldd98MN4w+6jJ7P+XhqGS3Gt7NCWxeIjwMpiuHZ/zovyOtA91T07bsAwcMpyNfXlmxtxqH2MfsaZ/Ribp25pf5Z23NeEba4KJ3CouF6SVuhPAawtaB8Fu/nYWsA6uwIO5Iw4slrs5Xcx+A2FppAZ7bdRn+SXjW9dl5zQ/sr/P+0hvNIIh41QVs2ga+qskrZdpKOg/uqI45I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(346002)(396003)(376002)(6506007)(41300700001)(26005)(6666004)(6512007)(6486002)(478600001)(38100700002)(186003)(86362001)(2616005)(83380400001)(15650500001)(4744005)(5660300002)(44832011)(2906002)(66946007)(66556008)(316002)(8936002)(36756003)(6916009)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3uEdXQiIKeS98NtBh0s0Mnr22H4ovMzagBGU8cBvoYVCQi8TGzdUOXdhB73W?=
 =?us-ascii?Q?asUcfNclshyLDVHQ6OswjEYwckQ95A5a3WHtYwXI1IpFTfF+2zSmwtr2ClBD?=
 =?us-ascii?Q?lG1yRR6VpiyLqUOVm/xcUKaFOwo7NhF43QNdgzj08SVcQk5E6PykAHyyrEHG?=
 =?us-ascii?Q?FCG/38JYAVCD/oYJK6jG0VRWivMM/79JRXEMTHJNyhvbxs53f6Izzp3Dh5zM?=
 =?us-ascii?Q?sz7U9kUwArFys+7qrPe7wWkv7R9kJKMtBOXB5gTf2r7YyCZg4ECSa3m0OWmS?=
 =?us-ascii?Q?ROXpAKpgxYlQwEQj+JzSBKR0qN7mfa29VtXSQok7IxURQK4fO/4K7OYPrFPz?=
 =?us-ascii?Q?4clmR6ALkyg46cARFXQXQRDc+8iH7du3JjWDyn+MwmJIKzrEbbJeRcDbqgZg?=
 =?us-ascii?Q?364B4qaSSyBP3SH7FXj9W7oU+PXoGikQlyjH33aNZNGWIca8/64pKK8vkiq1?=
 =?us-ascii?Q?6dIDpjh5qLb+2yCDt8GebPVP4YPpGVIhem20jgJqxm0ga/SEixTZZB9Np/JR?=
 =?us-ascii?Q?Ykret6Kl/XW+AQIwsvoePIoUDxqW8vJ3eGpX34/txPqprvTp1pST7ZuHe7yp?=
 =?us-ascii?Q?HueMRIuV4RrCckW2gLqbp1ToJCmnVWhvPe4v6r0n6Kfy+fcL+hYziwY4UhAH?=
 =?us-ascii?Q?CNZkDrDKuR4o0pT3iy2x402vquDW+HdQVPm4QhRGmcy0tAsgIolcd7CXbYbD?=
 =?us-ascii?Q?QYrEx44N4zz+kopm+9dJvhN4xZTutPteA7BEURTjynKYklq+jMzaElCn50fj?=
 =?us-ascii?Q?RL+6lINXqUd0JNvuPtQod1ONfvBSDD7G7R7v7PXfGgt4DAwepMha+AvTWKN+?=
 =?us-ascii?Q?LYQPbmlxFjM3LhvL4J95b9cp3Zum9t3DArFgt3qsYZJv9IbMAZLe39uefoXE?=
 =?us-ascii?Q?UNYwMRXSPPcmZ7khvHGIdGvOyXcB+CC6wKABtQKtc0MJpdlXnSEBGl39fgKp?=
 =?us-ascii?Q?TS7Uibcc/QzIdBrTUyNAr/dP+6b3oM9pzkynvEuiCFMig+YWXuZI/RoZTkK0?=
 =?us-ascii?Q?O05q1vEdiwZJX61Yq9TUVfpIJxaU6zPVYI2n+83UAFSHZEjFnzI18YrhJ3Ps?=
 =?us-ascii?Q?2mO/3KUaqZSfCmjxqNSz+87aSj02qYepoilr0okj/O/2iAlhSpI5SFH1aHie?=
 =?us-ascii?Q?m/u+BwPCtvnCK9QEiEdWE72K+eTO2SUfa/qSKgFsAqv6FYwL10o4yXGXYGw7?=
 =?us-ascii?Q?pHjOd2UIjYTQ9oKNCBEMhCThYgBIuM0zdHt9PoRAz+JIr0qwOllGyU9YL0Gp?=
 =?us-ascii?Q?CCfNHR+3UqFfqpgXFWnTTrgkXOT7+TwVMr8T9gHO2o/Uh4Im16FtdtQqlHnF?=
 =?us-ascii?Q?6ImCJngOF64icfzFQe+4rrTt6FA/oRmgNUNiShwmapn8lXF4PMlKDj2uKBx5?=
 =?us-ascii?Q?sHRe8ldBleWyjSn8FEqDowot1EEYVDRe4so1+mvBp4g0nWIxWFBTJhnn2DCj?=
 =?us-ascii?Q?hEhl6D7Mjshuxd14e4R4nJPadJbeNnTqNZuyEV9zjewaa8JHub7Y/yVPIsMZ?=
 =?us-ascii?Q?wbAeWpk9fRUg19Wj0Z1e9fXXXz/0JeJs4idCkQ4GsofTSbmY1xHwtnOKVai/?=
 =?us-ascii?Q?zs6JxlmfqvN5kxeFEaq2374Ugo5G3QNsoHOERZbL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gCQjitfNbESIxmwd83rAkSn4wroGZynx03y4ip/YZL4XnD24JaGHr6WQiB4tPE2wvBpOylOHu6Kqlnf6Ac1bAG3qnxyV315wzvytQJkvlvURh4OT8IN8zr/Cpnc23HSfk2ETYtHht4EcBmPRyzC1rDjmadmVaiBN6q/2amkHjSUfEi6F54MB/fnfLRl/dQc05ORKqVVFdMNl+CeHbpOBV9+nXV6oRHRMR7gE827XImxTBWbSNoqkYxdJ7yJ+6X62U1CDbVE7IUThzb2oBIwSge8NYUWKmDc3rlVrKtTqNb25yQDVN952bfruiuRwbvcIEvmdMIKGS8f72QNkO80l0BCmmUnq2ew3GFml0sCxQVKjiz3TMseedZHyYvHsD9AmQN/w7/6zgmUSHhQHWO3xuyIXsJ0RQOU6aHfKIOqQGNFaDgqwInAA1GaUTnobVfZFH28tq60OnFtaSekZqCEMgV/ZmCNABp2HY+pkJFvJVsedFhxek11xSpCvLyczMRZlQcCvkuZhOYi7ReywJ1ORdun+Ozxa97lYG6KepAE0I9bSCA4TKACr6v1YdnZlQQsOL2gqoep/fnpLgGemJYs2Z/kF538DybNFhnRuMNYUzFbu2pc3/FozBFm6O7+T75vLG/LIefY8yR2GrZX1Ly7cIdLCBMXLJp1owkct0AhdSAZPQu0ZD6IXTSi8to7A23lq9Jjl+LKMRqN6ET5XHdjMGaCHet0durW5f8cLQlLFRgI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ba5796-1a16-4655-bcac-08da7c4df277
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 10:32:25.3136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pCE0ptXs+lF32O3Y4bb604fjnghVe4HxtZy3b04ir64fdbHrzBi71RxY0Y4dRxKAzzD/2eljKYjQQSjo7lyeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_08,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=761 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120029
X-Proofpoint-ORIG-GUID: _exyLGlDuauuQPhaB9nN8Svwao0db1j9
X-Proofpoint-GUID: _exyLGlDuauuQPhaB9nN8Svwao0db1j9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While trying to reproduce the issue reported in the ML. Found few
issues as in the individual independent patches below.

Anand Jain (2):
  btrfs: fix assert during replace-cancel of suspended replace-operation
  btrfs: add info when mount fails due to stale replace target

 fs/btrfs/dev-replace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.33.1

