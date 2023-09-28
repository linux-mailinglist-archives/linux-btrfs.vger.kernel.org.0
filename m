Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987A27B1179
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 06:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjI1EXh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 00:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjI1EXd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 00:23:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672DB12A;
        Wed, 27 Sep 2023 21:23:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL6YLc020316;
        Thu, 28 Sep 2023 04:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=0D6IgKM7Gre4gQURb8JJa4p7hoJqYGnfCLlWKJVS4bM=;
 b=vcqBMkZ5kRRw3YiZrXUlt+mG6XLRL7OkRvPFz7hSjtIx3vDIqei9Rmm3g2h1Hium5MtJ
 PP7cqimUf4TkKXj0u1cEqLRshR1reNTqLraOvFURmW2Di4NGpMHNxKHlTxVEJj27xjjk
 5DMCx2S0+ErmUsZbM3R5eqUF+Pwies5kEJPfzWkVG/MtQdbHPKz+yJLYqzt3umf5Jlbw
 QJdJi3m3RFj7fvwkEXxDKG3GusfD11GT3pj5eLmtc4BMIWB8vIQCUx3v5FA7LYJs/t34
 xwd08aFMdt4yxMueos1LfEBmexFQXLvas22qOK1s5I+cStTlbgueDqWoczG0T0nC9a5l Fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmuk74p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 04:23:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38S1STF3034915;
        Thu, 28 Sep 2023 04:23:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf9b325-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 04:23:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUXSJb0oXIMEWdFPkgaUDakJVJkIMNJ/Gwk0OcJN0/posWNBtm43sRw2M3OBwNctJd73EBmVhHP3c9jYBe4+2AQVHCf7nkCE3YMwUGVhVa+pd6AbnNO/NDmf++oSv0polo59Og4g8y7UrQKj6SJwCMPpuNjRGlFoArBjTnt8P92eqs7FWW4SmauDYM5wFASEVfrNA33NldPf13pH4+fGJ9DuLIUNkmtVfbjfzW8UcvgH44bpFx7CnxlYoohBcY5XF+te6OGybLxMgNmVmSSOD1JK2bK/6NoVwgJlGAiBaAZDBc34tMu8QkfylcYQjpmmsZowp4rJmZnS6g/9LjR3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D6IgKM7Gre4gQURb8JJa4p7hoJqYGnfCLlWKJVS4bM=;
 b=ENLq0jalLAR0g76JhYN5QxtcxGdmJRADi4f8l0dYd+UmtdXMlvsGlUsDXjAMGkqvdsNAwWTtPtcFeYxHYhaglcFONs8H6jo3bfwmXGrkzFpOEbvktbE1U6bU+FxXT+bzlfwSB65aDAS4ngc/PNRZW/6hZfL3uZ2DIz9fNo6NDvDpMnVVozBnxGuEP8ZipbsvfgkePR8I8jkGD4VtOF0de4m3cIM//7+TYfv5Ck8YwFsTd4idc/cMYg5Lr7hP1ddjClsCd5wZ8dqLmApQTJx0BvAlwzmZqNrERuDXBxpFF+/02igynNydEql0rLGYG4qXrccGpmJ0qcZ399ZDVv/a+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D6IgKM7Gre4gQURb8JJa4p7hoJqYGnfCLlWKJVS4bM=;
 b=GCtl2hS0F31kSFdeWb1LaKWP1DiF31gweOKLKnevi6KFnOhNBNgLz6U3ibJvF2yLfmbCgyEua3fNBEBUuL7u8nBq/uQ5VypoDu1/75ckm+gpNpi6s5LJC913okmaxX6m+gfmlz6IG82PaCzcf09OaTguLme7ohOkWnpkawn9WRU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 04:23:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 04:23:13 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH 0/2] fstests: add config option to run after mkfs
Date:   Thu, 28 Sep 2023 12:23:03 +0800
Message-Id: <cover.1695543976.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf45e35-5bf7-4985-1e91-08dbbfdaa162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BivKgB3rIf4FNEVQei28Ef2kjVbo3a25s7uXBHtFvalRTzBH+jQzAj9RPDkh8sMpdBxGvVs7NLJgD8ywn2Ay93/9y6VrnnlXRrivb5LFFh39xUBdOZb5AeuK8Uu4FJoWXSRNF5RrQdB+2Ikpr1pdNxNXk2AVgobjQjoxhib9SZkq6xqP16l9sjpyQQ0f/2Y1wFykuf6yiss3dAqOGdAKlEMsXYs10HK+gfTOBYTC6BN48U+pILcXcn/n9vs47eYwGQNbM8NBwW2Xh4m28rnK3mxNsDd4GMoRkjnLUBttX1B5xP9g7aiLgRr2y9XIbIv0Vlurnnuh/YC+T9gCmecjiGvlwyS9jqBMOlKKJ5uort366AfVFLLaRY6dcGJJSR2Fh3gukqhY1D51Hrlb9nwjqOpFcXmm4Ke0xUxzkG0D7DSiaC0ekY1Ev8T9RKO5lUHbemdbBSygaHvk5UqpT5KwPEgZZZxdvAZ+rWD2iYbSEvcMsXnNnFuxVDprBpOFkUDlfyMEkkV+t5tdg3m0FoMI6Nwb9OV86NG6OEsyV6fJzDx99Tg2DynF+7zD3Aybwxeu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6666004)(26005)(6486002)(478600001)(2616005)(83380400001)(36756003)(86362001)(5660300002)(38100700002)(6506007)(8936002)(6512007)(6916009)(8676002)(41300700001)(316002)(2906002)(66556008)(66946007)(66476007)(4744005)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pqT4xr+ARd/WUU20bOWoz0HTa6kCg09cpyWBNTbZN832xh/oJ4ZYGxQJ8AJ7?=
 =?us-ascii?Q?F8FEJCMQsGdzO3Nq5GW6n9eOr3yd0+LZOAiuqahsE7SNxWtQ7AeHLGTqHz82?=
 =?us-ascii?Q?hgYU7q7BGZinowDh2xWUAgaFfpV7kiS0DeVgweBG90HXv7dBJqpS8f5N/YZG?=
 =?us-ascii?Q?cjmBpVBkdaG4+Gty9M7EKzeH7smE2WQZbvc7W1St+U3Dacnso1I3CyxnVXpd?=
 =?us-ascii?Q?9c8IVK0jrgZEsCjb5i0onNqnfQB5Q20y9Cf35jzKdZo/DyDQGV+7WpGONQaK?=
 =?us-ascii?Q?zoftcA3QKfo8lGUL0L9IbMYvftHbg76RFNnVbdSm/7ZA08lTRwTpZOkzHcbd?=
 =?us-ascii?Q?IB4pbB02ZzSLrr5gQtRMhE6Ofa0SaQjfVkEAz1we+B6tnVHC7PoFIchv2KFb?=
 =?us-ascii?Q?AvYjEEy9cS9EG036eV3eyQatKtz41/owzaIbvtEuNGVlj+vVK2n6y6pOIubt?=
 =?us-ascii?Q?1cCpycPHuoOmmfeT+zTY1sygU4dWITJD7Zok0df1iXhHc5nwCyoEErwnx+xy?=
 =?us-ascii?Q?kyXNRD5hl7Kd6uz3JxitXMm1oZxBE1I7WDtRoEbYWsR7dP1IwpTIRK9RJ8Wp?=
 =?us-ascii?Q?R52p+vJCoscp/yUWnChi0iREgsorXFWcWGnCfSv95ggwsAtnwGzunKmxyLCX?=
 =?us-ascii?Q?1Tgxkm2XoRq+ZhRmGChXKGj4Ps+WIYuSLyxfNT86e49hGdgU0mjN6sdpfs7P?=
 =?us-ascii?Q?iw6ITnxQztNr+ZkWOqdF/oCBeztAxygKU4Y2FS30GU5u1gB+5ZC8wvbczgYb?=
 =?us-ascii?Q?La2iIXnE8GxXJz42yVcweUkQYgF2KzcsA1Nbh31WPq+/W1/PsLiQU+cfYRSQ?=
 =?us-ascii?Q?DdT+U15YYhtnKA+t8r9qkDf719xtkUKvjtIrUluZn0jbjGdtebRYe6fl7YGx?=
 =?us-ascii?Q?Z23iXo8PAlGpUeGFdZMltQALvhYYoOliDE/EVlvV424IAyOR63U42fuqPcn5?=
 =?us-ascii?Q?y3nctFjYNIzAIhFsf9uLHvLiTSU8n9Cl3HTsi+qf02Ik69UefoYAhEJVt7ZN?=
 =?us-ascii?Q?MaIgQ+gzCha7jPGSUDmk+iQlhsKDnSzr4ldt2uKyxwbaEzuVDL43F5MZ69jq?=
 =?us-ascii?Q?SkziWv637AcEXqHtkM91GWDj9KpSlByClPR17kEZw9o2+R7K6/BW2mZIT9Me?=
 =?us-ascii?Q?Vk6riV6Qz75tJZ5JR2y/NuL0ZmzP0aQioplJq6+ke7NMUPJs4Iy51hUgVnEh?=
 =?us-ascii?Q?vrMxQanhaqL3trh1NvQOmLsCOXkYHVEtKuVQ3IQCp84TyULaIDSVrfqsJLvr?=
 =?us-ascii?Q?O9iQOxnd7q9WslTQDhVbR4t5bJREIB1hv/ujP02roNwn5ruVajCdn7GxoDdw?=
 =?us-ascii?Q?vLSRpHc9XOhYeK/1QYJ/YOoXoc5mxTLlKyG4kLRsp1fSVlQZvwZlgCZzflMP?=
 =?us-ascii?Q?LojhLLtc0kiZHEATZ6z6Ad38DKh8W0ttB18kMeJkvkVmFPLZwYOhPULhtgHI?=
 =?us-ascii?Q?V6W2XAD7p0+3x4iGQkeI9sfHZSE3J746D865ctHyNq3TighSErK4lNHPp/0U?=
 =?us-ascii?Q?QrwjZk4Ii3bieyhBGoFd11ax8OUEdUA75SlzAV01DX28whGBvEuTwtLURAj0?=
 =?us-ascii?Q?irNqMEnYbmPYnkjKs3gqVBhebazVUNOI918hDZGH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0L8+mfiq9lClXtWRjS7OC7zr50eqVsdNvVe0Z9V14GoleJZDmEwxtJNVEllMuNip4l+k7/b75cDu2zbe9G8gjOfugad0LCQWoJqF6TG7sL+Kd2DZd4zpX8sNqk2pE5SUGQAs6hk0ZsPxJrD/poALdHPReDPryggaCXgtvQGZUbAC/elTVGiSMohAxx0yoly+Qu+JaKT0rWZ49S/Wg5177588EIXNtnTppic1KqtdiPQ8ww+dta6DeSegAuuLZUENNb4N9PaW6sqyMTKKhVqo3jnb7XKhgZpAXrCSOo5Ce22Ph1wqlOOIPSy+cTokBRFVnIvEzBwDIyNCqkEkYViUtgK0rref5lwHf2Te2kAmbWcXBMdDyQHjwII6ysjEosPCC9ODOT1vO+A8r9ookFNXzrxtAe38z8DFnnhV9K/0UgvFTPHIcxMMcMp79n3sruF3FVCWxgw+MCF6M+C8rHmzn+n45KXHaqRIJdH1G3t7qUorQf6SFv7LvYz1ZirMEoiSK7ZrXLA1DTcOGYKBUL5zLwAPAEbbaHDFL+cV4FJBT9mQaojiodFVrCWTnXunzremmi3DFD0MmKfHGHfLM+e3dTfuSPUcZofcJB5cjni4L6stBdhnp+ZjXHuWwZONSxuJkuaKTWP6YQwnYznUuOnf0ie0JIPdsBFNX7wbQp/zQ/sSyH4KbNPIVCETgwFqrOszpWUK+vMS5jzoXZu5J5vEaGtsJH1vG1oFfWLJnu7or2QmsVNWL3v9rEf8llFuBHFARiyBJnPmi7/P3+AqzTS2D98TyIOFW9L+511AT1tLIXM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf45e35-5bf7-4985-1e91-08dbbfdaa162
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 04:23:13.5920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7xYqzx6ytuWLuWdKAdIbCIxP2OAFTDSIkKe++sCoqqLlJslhMathyuR9/epgEfWf9PKkeEYWBVBEyRv4RUJow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_01,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280039
X-Proofpoint-GUID: SB5yuzllWYvV2lIMD2ZK4iraoZ9MGLuH
X-Proofpoint-ORIG-GUID: SB5yuzllWYvV2lIMD2ZK4iraoZ9MGLuH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Adds config options to run a command after the scratch mkfs.

Patch 1 is preparatory patch which can be merged  independently.

Patch 2 add the config file option POST_SCRATCH_MKFS_CMD and
POST_SCRATCH_POOL_MKFS_CMD.

Anand Jain (2):
  fstests: btrfs streamlining mkfs command for post-mkfs operations
  fstests: add configuration option for executing post mkfs commands

 common/btrfs | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 common/rc    | 13 +++++++-----
 2 files changed, 64 insertions(+), 5 deletions(-)

-- 
2.39.3

