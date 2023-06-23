Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEAB73B230
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 09:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjFWH7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jun 2023 03:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjFWH7t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 03:59:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCCA1BD6
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 00:59:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N6SkQH023760
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DiU+yL8xl7YescU/YRQBNQrDbs7XnOOq4y/HvoFWvpA=;
 b=El4pZpy/p3MyavuDNrOP6kAPd3c7MMbUOiJ/srRvfRLu89DfgxvlpHt9NdrH4Wjap0Qq
 qWTw13TrISbgCtWczyw3vJfmkanMTyBYCBhiDTxnJB7ZLA2yAw6WL8d0kv1yc56fj299
 tLJqy4jZNpJLykUrSztOql6Q7nHLQOE8i8xuejzzjAfjIPA+pNHyX2TPtFohcud3HvGl
 khyngwrtothwT3LO4SQMO1Oqqr7uPyzTazRIF5lFHyN5BnzvRDmH5Ub0mMQBlI4d2gb0
 i1HYIX/NkBcA/H+IspWXvSyI6+UJPCvurlHVCjpF1Ap1Oa/zxei8WdKpMakOB8anLras bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qaba4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35N5xYkA005794
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9398f42a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgsJUwyXR5sxrea5rUHCi/2wMDDQ+wLbfXBMjR6D+zIp29qyZ5y4ZMHwXFStpnB/OMeXS+BEkm6q5aCykkiCmGJ5YRCTx0t/HejVRfcEkewPe9SeyvVXETk/WetUn2ZqKnb1MmywXE0CU7u+Hlmijcc/P7Ewzg+/1/2M6brfPJ2eU6kUDvobULB4rhpLrdWjAIAtMFFKGvV7FUwmfpzZFr/Er1PYL8TbRr3Zttsu8YGpT2SLClCE3E1HFBnegJbgH2uG4uF6/bSrSAfm7ibnNWervIyywjc6xgr6RQ42Dh5JACYoUCNbUpNxgxlSi11/YtpkYk9IZ52+ULAa7og4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiU+yL8xl7YescU/YRQBNQrDbs7XnOOq4y/HvoFWvpA=;
 b=j2LO8OKrh3e62AjYe4lxIQJVWiFOqeX4cDCUEsQ8LWwnRFpx1MlRiG0/L7WuXvYuDRAIU+ssKIclvFskKcIGVw87oyrNFAfpEXQpWIZ6JKm83MR4UJeTzqVgzkxK+B1O6qFxhsEoOEBs6PsVI7wSN+pbVs8g8fBwdgpCBQwAybwFkLnO6DmlrS5CBxFr5NaJftPBQGH/fNs//uQbxsURgdeoPgsSo4ZQoCBOkkrY8drjPz2RN/ddfjqGU7JXFGO7qzCII8jSO2BJmGkPjKpwj7ME+Zyty5ZiOGHdvFLofMYQBKzFV32xXxkYVKK0rJmCO0q0ZnY6VKlDrPsIYDWj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiU+yL8xl7YescU/YRQBNQrDbs7XnOOq4y/HvoFWvpA=;
 b=uUaRiOxZW49uTo5NkWqFR3t8SnMGzZAUIHUfD1ku+g++dEutj7O1lKPL64gA4wi69qLXBIJG16kusmEMgclWQkwUdM3r3OpbcVrx0p29fSqZJ9MkE8jVbATTC6RYq15Wf72ZrK9eEry7I6FIjEaUO1AuE9mu5a2vh44LIZHP1Nw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6523.namprd10.prod.outlook.com (2603:10b6:806:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Fri, 23 Jun
 2023 07:59:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:59:44 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs-progs: tests/fsstress.c: move do_mmap under HAVE_SYS_MMAN_H
Date:   Fri, 23 Jun 2023 15:59:00 +0800
Message-Id: <08a12fed33d557de42bd74a010550689f9eaca3a.1687485959.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687485959.git.anand.jain@oracle.com>
References: <cover.1687485959.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 37030ce7-ce53-4563-8289-08db73bfce96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUARytO52cYQL217BSeQaySE2OWVXsKjJ+eEjKAo3Ndci5zoQqVeaCcgGn+JUvdOqUkLxbBx53SiMW894vKeRRFozTghd7BneRqv/XE5PGHvfsx4tjw+ZHl+bSc7sDJQVkvStN9BrEjIrQqR1h3o/cCt85iWbN2xavUG8ZaxX0Rb3jUJDzbDrAjVnP4ySA40zBN+2kxhTIT27sddIDxR3cpYUjdS9Ex6eLVsXvhPUHbDtPBT8QIPrI6dPqqWVvHADWEgY9ibhHz5pY95SdSr5u52bCWrudP2VDnrL2ozfUKbKYV2drTMqJ1TPIRDghK7UHCplFozYyuSMdfa6HiKGgk5Eu8Aktt3y/jnuroSmidAEAKSffWurCSiYmHKnVzryYqlrYy2vK3fr3/MXHIMRE/xhdkMRK3gZorlRw5bbRgK+acEfWxgExvYQ7RhlVNhazAx58F3YofOWUp2gcPA9Myp8iKLxDLsF0Zw8ybljj6jPdEBOcZXuLjcyzeK/P86a30VeR/DeUcpGjEQxjpHd55F9tIaBL9rC+IYPVzBtHu32qZ1Ht24WoqyfwTnVOcg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(4744005)(2906002)(44832011)(8676002)(5660300002)(8936002)(36756003)(41300700001)(86362001)(6666004)(6486002)(478600001)(83380400001)(186003)(2616005)(6512007)(26005)(6506007)(316002)(38100700002)(6916009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTA2MFRRd1Vaa2k3NUxRL013YXVaSHBJcmxUZ2VkeFM0UWw2UWJYa2JCUEp2?=
 =?utf-8?B?MExoMWpvYUlhb3dRekJXOEorV2xhV0ZUbFFVczBZbk84Ky83MVpIWnM5Q2Rj?=
 =?utf-8?B?bHdtcmhRUFdiRU13TjZzcmZDUmUvcklLOCtJeGt6dDBOZFlxWlJJaXR2T1Nr?=
 =?utf-8?B?TisyRDBxUlROYkttUnRIQ1RqTUNIWEQvRFpMay9jWUlQeWlnbFdGc1VZejFR?=
 =?utf-8?B?Rmt0ckJyMDEvaXV0VWwrcjFXTU9aVHhaRmhKVFdhNEFSV1J4blJEYTFnQThu?=
 =?utf-8?B?VzMzRXdvemZ5RWNuWjRHSzhla0V3MXhXZllrbG14YlFsYTRMZ2dOSTdVd0hQ?=
 =?utf-8?B?MkpFWkduTmExdWhtd21JamxINFNMMnJiY0tRd002Uks4MHVvVDZZcndFNlJB?=
 =?utf-8?B?TUNiWlV0S0I4ZWlBVkdnQjdpbzhLRGhSdVNselAvY0dEbVVudnJmaFJqMFZR?=
 =?utf-8?B?UVFKU1FUQ2htNlpkbnNWdDZhQWJMc0ROQjd0THlCOUtKMlRXWUxGRURrVHNm?=
 =?utf-8?B?WlArRUhjL1BDRXJodExJSFV1TUVmVXlMRVNEY015MldjWXQ5M0hOZU1LMDBC?=
 =?utf-8?B?YmczZVZGK2cwSlZ4N0YxVjlkTExmMTl5SDdpS0NBR1JpN3ltMGFLSEQwakIy?=
 =?utf-8?B?VGRlNVZ5b3ZRZ2ZZUEhNRlV2V1Baa3ZuN1VyOEM1ZFk2NmpJQmdYd0Y0MVRK?=
 =?utf-8?B?elhaTGEwRFVGaVBiUGxsMjh1aGdxeWpiTTQwK2FKeEx6eE9qcVl1WWlRL3JB?=
 =?utf-8?B?eXY4V01mREowMFZJdlZDTWxML1hhOGdNZGdmeGozMXlaZEVRQm96ZGZNeHRM?=
 =?utf-8?B?cmNtcDZoUVlYa3VNcnpsQUdHRjV6dnJoZytwbUpnL0dhSDFCTHZ0VVdDdy82?=
 =?utf-8?B?ck51Y2gxTVpRQnRCNE5Oc0tIMGhCeVJnbld4MzQvVjMvUFA3NHE3MXBVbVpC?=
 =?utf-8?B?UmgzemFwTmJIcHlUWUFOMEtHQVd6eGdJd21lYVRTTFVpcElFblZwTWlZVzNi?=
 =?utf-8?B?ODExNE1NRjR2WkxLeWF4OXpSVEFnVEU1eXVmaVNYT29wS1dHM1B2a1Rkdzhz?=
 =?utf-8?B?NmNSTVNHcSs1YXFHbFdpT1hJSUlJRS8wSzRoN2hnaVFlckk1Rzk3UzJHY3gw?=
 =?utf-8?B?dWgwSzFEWndLVmFOM1l1d2NlUUljelZIRHY2Y0QxWk9INTRpc0hWa2ozcGhi?=
 =?utf-8?B?Uk5xaDVXMWllQ0djNWFvWmZCT3FLaWc1Nkw5eXZ5SVNvTUc1Rjd2ZnB3SWQ0?=
 =?utf-8?B?RFQvK2NPN3d0aDFlNFM5N0ZTM3l1NVR0dVF5b01CMXZTR2FXampoQTNCZmRC?=
 =?utf-8?B?ZlNtcDk4OTNZcFRHcUtTdy9VSW5jVDBkN1lmbExwMXNXK1JEQnIyV2JRcEU1?=
 =?utf-8?B?SHFoeTFRbnFxRnpSeHhpNnJZTEdabUhIWHhLWkYzQTlPZjZtS1A2cm9SQVlQ?=
 =?utf-8?B?cDFZeUQ0UXlLOGRLQ2hMR0N1eDQvZzZJQXdRMGkzUGpoZlN4elU3Q3A1Qk1X?=
 =?utf-8?B?YWk3ZGRPUnFxY3FldmpyQlF0QS9oZDVCVUlYblRGYlRvR3Qzd0xDU3B3QTVQ?=
 =?utf-8?B?MnlMN2R1RDJhME00MHhDYTlXSmpPS2dUWWRXTjVDQ3BaNDhvRXozUWZMamJ4?=
 =?utf-8?B?N2JNSkZLUEJPc1RvVFlNSnlsdDNOY2RXM0k1bUxacVhJM0JWaVhFS3pNVUdW?=
 =?utf-8?B?SGFpN2lWTzRNYi9obU9aaEhERk1MUTRxK2xtZXp3VncvV0NRTEU1RFdJOVVC?=
 =?utf-8?B?R0dOZU9RTDZLNHl5ZjhaNmtDM3lJOEs5MTJOUjRFaHlRQmR4MG8wKytyY3Nq?=
 =?utf-8?B?K3FLamY4OWNob1NjYmEyeTI1YVl6Y082aC8yM01kWlRiS21jZ3JCMVI3V3Rp?=
 =?utf-8?B?aXh0eGJUYmNpZUxmTFpzOHlnR3VuekhOVkRVbkNNcWVWM2hBWGMrUlZaZi8z?=
 =?utf-8?B?OEFhTGt0QU9Banh5a2hYdEl6Nmc5VCswS2hvWFFIaGVDeWNuSmR2MGZDT1BI?=
 =?utf-8?B?NkxYT1VrczhUZmp0Qmc5ZlpBZU1nLzZwSTNscmF2NmlWSTQ1TkRROUVQTFNS?=
 =?utf-8?B?WDdMcWhQY2RLNEdINy9EdDZhODQyTEcvejg2R1draDYwRHZLYUdObldYd2Vo?=
 =?utf-8?Q?PKButDwT4D+LzyOqF2d7Qb+Hf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ERQPLBVn26QDTLs/2mSda2DKrBgjpjt9axjy8w3melOG4+8ZQ5A9LeIWA+GyKRuqPCEhRbYJC/DlsTZlvTkwFjYkEhKBj3DBWA7YJGZGFnz9jx1ZBImLfBlE6xrE1C2jcKTsccxJfPt9+7jMZlMMvgYvwYmTe7f8Rqpj44TK5kU1nZuzA01C44eZI6QsdUL0cCYBskyyRE+UzUYDjW5RL/ureE4u4PglTQSQylBtUXaNSfdZcum+qkNwsqQWf3fPYiGfRoiGRpHcOtdyL+gQaVmt0gaw4fDwawk3I4f1Fbvo2RdqUvKKWK1vLyOWZ6oKOTWu5UvhPpeYyIufnvkHiEcbq3hpjBVUXNfj0MKZQA+G3TZCYo61LWU7vzQWN+3WMwRq2xNVTaowHi5vgjp0DIdp4FXIdQAVOlkuCMiJ52d2cCVWHqPr6NCLiDNv4bF+x9S4ceIZSJEIoYCI+zAE/Rlgcs6QkH6px9/bOqrJyuurxl+qgd3ipM81076WkWLoZodv1XUd658fdtJ40/XMOPzJLuFodT5riGMZYnQ6C9VSQl8MBuEhYzAR4vNRe1BywvhWPBcY9oNW0KbqC5+szwD+AgyjiLpa34fbkZ1el4kADlwtwx+DYptdf+yIRvhKhHwabt7lhcPNZ+ASFmwpFrrN3+NODAETtu5nL6dn92SEO8zy7l4D0iypjr3m4woOXsZDVESiYWhtqVeN5Hk6LFzihHjhh6nKAtGDjBFWfIj8sUwmtmLFH9wb7DQBGN1uFAFsT88fXFj0AyhDCYzXuQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37030ce7-ce53-4563-8289-08db73bfce96
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:59:44.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHGPlRPNP+Yjeq2sq3Q6NCPt1vkzUHuvHfW08dDGqI6L23wZ10o5CHQTFlKn5d9le19EyXaO4jgLyc6law83wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230071
X-Proofpoint-GUID: _Xb2JDkx7QM-_Fis9ACWNaqczbU1ANR4
X-Proofpoint-ORIG-GUID: _Xb2JDkx7QM-_Fis9ACWNaqczbU1ANR4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move the entire 'do_mmap' function under the 'HAVE_SYS_MMAN_H' define
and fix the following warnings. This function is called only when
'HAVE_SYS_MMAN_H' is defined.

tests/fsstress.c:4363:1: warning: ‘do_mmap’ defined but not used [-Wunused-function]
 4363 | do_mmap(opnum_t opno, long r, int prot)

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/fsstress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/fsstress.c b/tests/fsstress.c
index f7d3a83a4e2e..692d7cfacaf4 100644
--- a/tests/fsstress.c
+++ b/tests/fsstress.c
@@ -4359,10 +4359,10 @@ struct print_flags mmap_flags[] = {
 	({translate_flags(flags, "|", mmap_flags);})
 #endif
 
+#ifdef HAVE_SYS_MMAN_H
 static void
 do_mmap(opnum_t opno, long r, int prot)
 {
-#ifdef HAVE_SYS_MMAN_H
 	char		*addr;
 	int		e;
 	pathname_t	f;
@@ -4454,8 +4454,8 @@ do_mmap(opnum_t opno, long r, int prot)
 
 	free_pathname(&f);
 	close(fd);
-#endif
 }
+#endif
 
 void
 mread_f(opnum_t opno, long r)
-- 
2.39.2

