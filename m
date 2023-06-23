Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD83D73B22F
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 09:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFWH7r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jun 2023 03:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjFWH7n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 03:59:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F01F1BD6
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 00:59:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N54pCT023459
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SdUSSadF3NT+u5E68xPaOhv4R110wJtU172UMKxl98A=;
 b=YafgrrHbNSzMK3ScfXBb6aEbXrGztXYVO8jGYxc/lfKHxnMxWZTw0aBjHKIg6rOGJ+g8
 mnKw9o0LUdSvv+gBmtRHdoiM2qqFEd8uK2d9jQT9FuwBeF5Iw+1n9JY4VwKAv4R7qZIn
 Bk7CbOvc2boKbMggagxq8u6pCenieOMvhEQV8+dlM/DPAlXQUXfxlYATMhDM9fO44YWG
 CM0no/+2HSoC6bsFvXkyUMh/o/t7B2AfqCuaoqDXMElhdH7UGP8sred+Ix87Lrvuulue
 2pxqxwk4QQ3XZE5Eo3JswHvqB8ddOIo1tTCXDci8h17ofBj1KLpt6ZiuHwgB+B1aVZzz /w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etujv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35N68l61032848
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9399mp7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZKG8l+xXDyYNFIkTWdjOFywfUT9+oiBVDZJn/ZVPiaVFa9wRcoZ5C+N0gZj+WFIW/BQG8orKauNov1o6WuIFNMEIJ0B+zuzCSt4e1znirkOUQUoZjuHgX3CiXYtNPkFSsGNX3wXIeawzJJhiC5dujzgobXZPiSpJaREB+/7JhXP3o7cZVjLro6tfEZDaF2w74z70jY1R5IqqtGmwkRRZjvc9BOSg9CsPlQcv88rsdhUInRZ6OCwd5OU0oF+dgDnbsEbtVQFB+ZH27XaIK6w23NpbqQd32wBKodtFferCP2GKQ3YnUAgWum4AtL3xIHT89SKypd2LZJEHFQDFMTHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdUSSadF3NT+u5E68xPaOhv4R110wJtU172UMKxl98A=;
 b=NS/LBo4sdCCFfSrpIvircVyRXczCmdCVNUfLm7ajacAb/HdKes1h0jdSTWk9c47TyoteZfrrTvE936mCUcrOqRD/8Cv6pjTEaAeHkQ9lzN/veSzrgDFplLvVJTnWMt7NC8qGi/8xsLSlellrpGRUPGMPI71DXrAFSxK/oiBUhfH1+fn39DnoksTr/FU5msopGKFtf7UPepv7FMNnadugivmd+8xj7ok9F2UpWC07ASTsuibOTK9K1BGLJm1dY6toGxNdxF7vtTutF5+bz6fjltHJsJxsDAa3R21WCwxE/j6nv60cI/mGh00ioVwgpf8NBqJ3+ohon1f4KSdkqRK8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdUSSadF3NT+u5E68xPaOhv4R110wJtU172UMKxl98A=;
 b=Ln6sHfoaZhvWxPL8ZnDqsfsQf7nuxBjp2Cd28wMMjL3qkhM+i1IMc8PI8XLGryEzyBt9lev/7EGgsf5oBzm2nvZpxUeRlxamKtHtcRywP+kZAbeFBPZarTPVM9cGXxn9M08GeckA6sLgBk4ow7Q99QAQvcvyJmD4tnCQXskKqWI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6523.namprd10.prod.outlook.com (2603:10b6:806:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Fri, 23 Jun
 2023 07:59:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:59:38 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: tests/fssum.c: fix missing prototype warning
Date:   Fri, 23 Jun 2023 15:58:59 +0800
Message-Id: <5fb60fc2bb0ffec6f67d2af6d09c65bd71d90111.1687485959.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687485959.git.anand.jain@oracle.com>
References: <cover.1687485959.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a60f7e-2bad-46e5-3477-08db73bfcaa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LF1AJRmTdraFZSNRZHSYAMickmHMOLXKKmu62RHybU7fgV7seAQ5l4JvAuMfVS8XdmFpqoYTtYxrT/N+LEuFm+JdmRaPLZS51MIwioBGCQaHC2AHtQVfEbXEJhFLo+9ut0/BLX3cPqmH9TXS/uFkABXtb9Tn8j7IE0v9W9fcXRtNRBGo0p9fDlIy1LUN7yia5eiX5Z+5uJlVduLwkbu5I57zAyWNuYcQ1iLDCgUcJXI8Suqik/EwKrkvvWsu2pR7NCbJSjxtgcuLyudmD17dVFXKWtAJvoLANw9ETGjftEykie09fY5Yg0s6+hnHTuI5RKd/5fw5+KHsgSPn0ehDniuTtWnmurtyhAa6+mc4mzBaQVxwH19uwAVlhJ/r4k3z/g1Ak+G+m6iue6XAuJ6ZcUw7QTQvk6I060tuuHpKF/SeviKl5WaDIQLBSGcttt0Dd7B1l0xpvnRj5x8Q4yxnpaq6YzgL7U2l+xk39qic/41y3/MxcmFMy6dvBbmvowWqIH7e63FYBf/P9qYqb1HwLF9i9GnT1ZiBr/BdxCx2LD/UqRgXzD9RYwk4VA7+XpzH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(2906002)(44832011)(8676002)(5660300002)(8936002)(36756003)(41300700001)(86362001)(6666004)(6486002)(478600001)(83380400001)(186003)(2616005)(6512007)(26005)(6506007)(316002)(38100700002)(6916009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azhKbkdyQTJkLzA2Z0REd01BV045aUlHMTlGaXU0NURDaVJLTExpbEI3K0dM?=
 =?utf-8?B?LzZaeGYxOUJCNTEvRXp1cEx6ZFNSMFp0MjdGN3Zld3FBVFNiK3ZMdHhNZ0Z0?=
 =?utf-8?B?STZ0VlY0OEpDSGJhR1JsRkFmYUVtUHI5Q00vaENBb0hOSmZDUGxjZythQWkx?=
 =?utf-8?B?WFBWeHNDZWNOWGVNS3pXY1JNUVZjUUlRS05JMGd4dmhYOWplRXRjTTdFdHJN?=
 =?utf-8?B?N1k3azBmSHEwQkIzOHRzSm1MTDRCZ0dQM2F0VTNZS25CY252d1F0anhqdlpO?=
 =?utf-8?B?ajJYVVY5ZDdSVnhialVBbWRFcm9aZWQzYktnOU4rbGZwcUg0eERpdEpzNm5l?=
 =?utf-8?B?dllXdGlqZ1hQSUZpWVBEN1B1YzFRMzlhaU9obDZPL0RwRmNnNi9iUXlHZG5m?=
 =?utf-8?B?K09OV2d0Y1FxWlBtd3V4eStPTjViMWQ4Zk1xNDJsenh6Y0tCdVQxRmZSK3Uz?=
 =?utf-8?B?Mi9lMUtIaWN6bVAwZ1UxTENGZTJtSlZwTFY5YlFaMm9ERjdCWHdRQjY0WDN6?=
 =?utf-8?B?YjVwbkN3TUdKS2lRNFJ3Ky92VkRaOEhDaG5UcUxBV2huWWRtaGN1SUdDMVFM?=
 =?utf-8?B?eWd3WWw1RUtKd1A5ZHJjRmRKM0JITTFrSHZ0eWptMnZLZDJNbVhlY0xwb1hz?=
 =?utf-8?B?a1huUXU0TjFNTlJWVGVqZUFzM0xnQ0ZHZFZUOVFlazhBTVM2TCs1Y2NCaGV6?=
 =?utf-8?B?d2NSaDE3WUdoT0xHaGdqM1dQc0w2MFJKbTBad3hkZU5tVEo4d2dxNnNyai9n?=
 =?utf-8?B?V2lxWDA3c1BZR2JsY3JmT3VoS3dxdWVBdG5pZnFJWjc3WTR6ampqVXlIWnlT?=
 =?utf-8?B?VjVQaWwvZ2VSVFNMWGZPRndsa2tFSUJuai9XQW8zYm53NEllQUE2NlR5VEN6?=
 =?utf-8?B?SllrRU16Z1IraEUvRUxQU2dTSDlHVVhZVTRDR3pYYU9qMC8rNzZiNTQ3VStF?=
 =?utf-8?B?eDlyM3doWWwvY0NVS3o3cFo3T01NK0RTcW1JSEJZZHBqVzk5dlk5WHpuL09X?=
 =?utf-8?B?djRXbFdiZWZ3VHZVZnhWMGJyTUxlbXNRL25XMVU5Mi9idmlNcVJCd0hVcnJJ?=
 =?utf-8?B?TEloY3M1LzVzNkxlZnlIcTdPcWNPR2M1N1RweXVjbExvbklmNWJXTE5pZXBj?=
 =?utf-8?B?WGNQemhYQXRHVy9KOG1OdjB1TERVL1NBbGo1dEZsZW9rSW1OekJLN2Q1RHhV?=
 =?utf-8?B?TWlicDU3WEVmWHMzSHZXRDVnQ1JGcWdERXFkN1hxcjk2aWJRS013amFnWFpI?=
 =?utf-8?B?VmpJdHFyWUNadENFdjRKUEVoZUNxOUV3K2lBSzhTdGF3ZTNha0taTzFqa0ww?=
 =?utf-8?B?SVNzcjUxcElLWHhzLzR5ZlduYlhvcDVaT1FobjNiNWJwakR0c2hWN2lMTy8w?=
 =?utf-8?B?K2ZzT0wwcE1QQUxJci9PZTBiODJlTVVyN1ZId0pic2t0cUFnemRiV0VCMTZj?=
 =?utf-8?B?d0ZSZmNMNlplMElXZlhqYWJzZ1EwK1RxSndrNHFVaGg2YkxlYzJPMFExKzRn?=
 =?utf-8?B?c2RFbGdIUUh4enFDK3RLUGtBRTRIdS9JbnhaYldIOGhIT2NPRlNOaVhYc21m?=
 =?utf-8?B?UHVicDhrYlB5VXhqNUVnZE10bXpTVGN4QklZd3ZUSjkrL3dkRURZYWhvSTkw?=
 =?utf-8?B?WThOTG5JOVpUTFpROCtNMkxLTkVhYU1raDhjN1IvdUVFaDEzWGxXaXBnYVVj?=
 =?utf-8?B?bnRWSUYxWDNtMlkzL2dBcUVNdUF5ODJZNzdpd0FYbWVFSWhuTkpuSjh4MkZv?=
 =?utf-8?B?djQ5VHJsbGhzM3VDcWVncDdwSWpVb2hqZGtNUGtkQTBsL25yT3hTc0ZOcTla?=
 =?utf-8?B?U0todDFmSmFYZkYvckpIVFpwZ2RKR2YrQ1lkQjVKRDFweVQzd3BFZ25RbW5Q?=
 =?utf-8?B?ZEJ6V3AwUXdwYk1xL2JkdHAzc1k0b0RMVy9ySk56NGRiWU4wdDhReFJZY2dH?=
 =?utf-8?B?YnJ6QUlTMkJoMlBLRkgrMHhNSTQyS0pucStiN3VKa2c0YlFBblcyc21McnJU?=
 =?utf-8?B?UTFaZDR3eWJaVk9vdjZIWEJsUDFyeDZ2cFlZMU0zdnhzR2hDbXBNRlBpb0sw?=
 =?utf-8?B?NGdvUm5BeEpycHJ0MnBVbHBOL1VPK3VBM3BqTWJZZ2FTc1BHQjFjcmhjZ25V?=
 =?utf-8?Q?jWor52SGVWjrEWR+oCFwCAPd/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vobxvvxBq6DLnkFxKxRU+Eyun7hJ4+Fi6bLh2uQWJmPgA4zNQCOd3nrgv8AI/JaKGDSkT8T97LvCfKx9ZgqJ6VMq6R+Rz2PpmHNVaE+6VDdLRAgeXcNFA+E4UY45sLSySXTrThoyFiPDrANVgUI4ilwl7DKKAHegj2tDsPySz0kwNL3+zubTNoeIvQF9ru8yeIqmS9/3aPDJO/Y/LVAingkB7VBfJ4yPrlLmYIadH9cmq2S3Oq93x7NJ1Z6P6C+ly4pNS0lvq5Xd1Yol1A1Rthe2nQ2NEcMjGVC4Z6AzOkieTKaTuUIh1DJ99Z3qaAdBUAYs8wgG4QKXK8dR4y0vfUCZVWs4CXV1ZTWOXANtC7u3H4tulcm6PUe32nWGYv1xHgYGDe4Te8sOx6qmwfZv1fBRhp7Ygqy/f/ItDOOR1/4Wh8/QEU3AHmWPjccl2tSrr7+jINnBPMIBGFhVPuwuu1FS+aYByOCCgwuArF7Q7vWVASY7fP5FVULQPkbZw/G+kFWOFEQaxUb8Ojy7cSadU7F6I8XVFe7fQDf9+vLb4ol5+ciILEXcsGdzADfzQoFLG2BFqBV9VXOHndlcJSZCGaYfjdHixQB1Y2IxU019RxxznKNmCPT8dJh3g4Dkvlm+E2+Szy7cXuX6Z+K4BOlVnu8EEPCPqiioZJZexErjfQ8XArksUGOZGuc9Z2OqYM8Q1evy8z2xeMg6UQSJyvSfmuq3YqUs9DlxD9MplOjt5QZ3lslbMEZzi6w9K/26ChZGhuWSuDyQVf1v7s4OCIMwHw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a60f7e-2bad-46e5-3477-08db73bfcaa6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:59:38.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04VwyYIK0PmKq7qvdWQgDAMXuW9IULlLAV6qaC3k/zzvySxIjMSXGYyQRtjoiO4Kjut7q6qUIaf34zb/CdWFkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230071
X-Proofpoint-GUID: -vBnRcm1HXgUlEHtKS_t9zhnh-FVsQwa
X-Proofpoint-ORIG-GUID: -vBnRcm1HXgUlEHtKS_t9zhnh-FVsQwa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Annoying warnings when running 'make test' from the file tests/fssum.c.
gcc version 8.5.0. Fix the it by declaring the corresponding functions as static.

$ rm fssum
$ make TEST=001\* test-misc
::
tests/fssum.c:86:1: warning: no previous prototype for ‘getln’ [-Wmissing-prototypes]
   86 | getln(char *buf, int size, FILE *fp)
      | ^~~~~
tests/fssum.c:103:1: warning: no previous prototype for ‘parse_flag’ [-Wmissing-prototypes]
  103 | parse_flag(int c)
      | ^~~~~~~~~~
tests/fssum.c:123:1: warning: no previous prototype for ‘parse_flags’ [-Wmissing-prototypes]
  123 | parse_flags(char *p)
      | ^~~~~~~~~~~
tests/fssum.c:130:1: warning: no previous prototype for ‘usage’ [-Wmissing-prototypes]
  130 | usage(void)
      | ^~~~~
tests/fssum.c:163:1: warning: no previous prototype for ‘alloc’ [-Wmissing-prototypes]
  163 | alloc(size_t sz)
      | ^~~~~
tests/fssum.c:176:1: warning: no previous prototype for ‘sum_init’ [-Wmissing-prototypes]
  176 | sum_init(sum_t *cs)
      | ^~~~~~~~
tests/fssum.c:182:1: warning: no previous prototype for ‘sum_fini’ [-Wmissing-prototypes]
  182 | sum_fini(sum_t *cs)
      | ^~~~~~~~
tests/fssum.c:188:1: warning: no previous prototype for ‘sum_add’ [-Wmissing-prototypes]
  188 | sum_add(sum_t *cs, void *buf, int size)
      | ^~~~~~~
tests/fssum.c:194:1: warning: no previous prototype for ‘sum_add_sum’ [-Wmissing-prototypes]
  194 | sum_add_sum(sum_t *dst, sum_t *src)
      | ^~~~~~~~~~~
tests/fssum.c:200:1: warning: no previous prototype for ‘sum_add_u64’ [-Wmissing-prototypes]
  200 | sum_add_u64(sum_t *dst, uint64_t val)
      | ^~~~~~~~~~~
tests/fssum.c:207:1: warning: no previous prototype for ‘sum_add_time’ [-Wmissing-prototypes]
  207 | sum_add_time(sum_t *dst, time_t t)
      | ^~~~~~~~~~~~
tests/fssum.c:213:1: warning: no previous prototype for ‘sum_to_string’ [-Wmissing-prototypes]
  213 | sum_to_string(sum_t *dst)
      | ^~~~~~~~~~~~~
tests/fssum.c:225:1: warning: no previous prototype for ‘namecmp’ [-Wmissing-prototypes]
  225 | namecmp(const void *aa, const void *bb)
      | ^~~~~~~
tests/fssum.c:234:1: warning: no previous prototype for ‘sum_xattrs’ [-Wmissing-prototypes]
  234 | sum_xattrs(int fd, sum_t *dst)
      | ^~~~~~~~~~
tests/fssum.c:325:1: warning: no previous prototype for ‘sum_file_data_permissive’ [-Wmissing-prototypes]
  325 | sum_file_data_permissive(int fd, sum_t *dst)
      | ^~~~~~~~~~~~~~~~~~~~~~~~
tests/fssum.c:341:1: warning: no previous prototype for ‘sum_file_data_strict’ [-Wmissing-prototypes]
  341 | sum_file_data_strict(int fd, sum_t *dst)
      | ^~~~~~~~~~~~~~~~~~~~
tests/fssum.c:369:1: warning: no previous prototype for ‘escape’ [-Wmissing-prototypes]
  369 | escape(char *in)
      | ^~~~~~
tests/fssum.c:389:1: warning: no previous prototype for ‘excess_file’ [-Wmissing-prototypes]
  389 | excess_file(const char *fn)
      | ^~~~~~~~~~~
tests/fssum.c:395:1: warning: no previous prototype for ‘missing_file’ [-Wmissing-prototypes]
  395 | missing_file(const char *fn)
      | ^~~~~~~~~~~~
tests/fssum.c:401:1: warning: no previous prototype for ‘pathcmp’ [-Wmissing-prototypes]
  401 | pathcmp(const char *a, const char *b)
      | ^~~~~~~
tests/fssum.c:419:1: warning: no previous prototype for ‘check_match’ [-Wmissing-prototypes]
  419 | check_match(char *fn, char *local_m, char *remote_m,
      | ^~~~~~~~~~~
tests/fssum.c:438:1: warning: no previous prototype for ‘check_manifest’ [-Wmissing-prototypes]
  438 | check_manifest(char *fn, char *m, char *c, int last_call)
      | ^~~~~~~~~~~~~~
tests/fssum.c:509:1: warning: no previous prototype for ‘sum’ [-Wmissing-prototypes]
  509 | sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
      | ^~~
    [LD]     fsstress
tests/fsstress.c:4363:1: warning: ‘do_mmap’ defined but not used [-Wunused-function]
 4363 | do_mmap(opnum_t opno, long r, int prot)
      | ^~~~~~~
tests/fsstress.c:3814:1: warning: ‘do_fallocate’ defined but not used [-Wunused-function]
 3814 | do_fallocate(opnum_t opno, long r, int mode)
      | ^~~~~~~~~~~~
tests/fsstress.c:1183:1: warning: ‘delete_subvol_children’ defined but not used [-Wunused-function]
 1183 | delete_subvol_children(int parid)

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/fssum.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/tests/fssum.c b/tests/fssum.c
index e35c027424cd..bca33c7714cd 100644
--- a/tests/fssum.c
+++ b/tests/fssum.c
@@ -82,7 +82,7 @@ char line[65536];
 
 int flags[NUM_FLAGS] = {1, 1, 1, 1, 1, 0, 1, 1, 0, 0};
 
-char *
+static char *
 getln(char *buf, int size, FILE *fp)
 {
 	char *p;
@@ -99,7 +99,7 @@ getln(char *buf, int size, FILE *fp)
 	return p;
 }
 
-void
+static void
 parse_flag(int c)
 {
 	int i;
@@ -119,14 +119,14 @@ parse_flag(int c)
 	exit(-1);
 }
 
-void
+static void
 parse_flags(char *p)
 {
 	while (*p)
 		parse_flag(*p++);
 }
 
-void
+static void
 usage(void)
 {
 	fprintf(stderr, "usage: fssum <options> <path>\n");
@@ -159,7 +159,7 @@ usage(void)
 
 static char buf[65536];
 
-void *
+static void *
 alloc(size_t sz)
 {
 	void *p = malloc(sz);
@@ -172,44 +172,44 @@ alloc(size_t sz)
 	return p;
 }
 
-void
+static void
 sum_init(sum_t *cs)
 {
 	SHA256Reset(&cs->sha);
 }
 
-void
+static void
 sum_fini(sum_t *cs)
 {
 	SHA256Result(&cs->sha, cs->out);
 }
 
-void
+static void
 sum_add(sum_t *cs, void *buf, int size)
 {
 	SHA256Input(&cs->sha, buf, size);
 }
 
-void
+static void
 sum_add_sum(sum_t *dst, sum_t *src)
 {
 	sum_add(dst, src->out, sizeof(src->out));
 }
 
-void
+static void
 sum_add_u64(sum_t *dst, uint64_t val)
 {
 	uint64_t v = cpu_to_le64(val);
 	sum_add(dst, &v, sizeof(v));
 }
 
-void
+static void
 sum_add_time(sum_t *dst, time_t t)
 {
 	sum_add_u64(dst, t);
 }
 
-char *
+static char *
 sum_to_string(sum_t *dst)
 {
 	int i;
@@ -221,7 +221,7 @@ sum_to_string(sum_t *dst)
 	return s;
 }
 
-int
+static int
 namecmp(const void *aa, const void *bb)
 {
 	char * const *a = aa;
@@ -230,7 +230,7 @@ namecmp(const void *aa, const void *bb)
 	return strcmp(*a, *b);
 }
 
-int
+static int
 sum_xattrs(int fd, sum_t *dst)
 {
 	ssize_t buflen;
@@ -321,7 +321,7 @@ out:
 	return ret;
 }
 
-int
+static int
 sum_file_data_permissive(int fd, sum_t *dst)
 {
 	int ret;
@@ -337,7 +337,7 @@ sum_file_data_permissive(int fd, sum_t *dst)
 	return 0;
 }
 
-int
+static int
 sum_file_data_strict(int fd, sum_t *dst)
 {
 	int ret;
@@ -365,7 +365,7 @@ sum_file_data_strict(int fd, sum_t *dst)
 	}
 }
 
-char *
+static char *
 escape(char *in)
 {
 	char *out = alloc(strlen(in) * 3 + 1);
@@ -385,19 +385,19 @@ escape(char *in)
 	return out;
 }
 
-void
+static void
 excess_file(const char *fn)
 {
 	printf("only in local fs: %s\n", fn);
 }
 
-void
+static void
 missing_file(const char *fn)
 {
 	printf("only in remote fs: %s\n", fn);
 }
 
-int
+static int
 pathcmp(const char *a, const char *b)
 {
 	int len_a = strlen(a);
@@ -415,7 +415,7 @@ pathcmp(const char *a, const char *b)
 	return strcmp(a, b);
 }
 
-void
+static void
 check_match(char *fn, char *local_m, char *remote_m,
 	    char *local_c, char *remote_c)
 {
@@ -434,7 +434,7 @@ check_match(char *fn, char *local_m, char *remote_m,
 char *prev_fn;
 char *prev_m;
 char *prev_c;
-void
+static void
 check_manifest(char *fn, char *m, char *c, int last_call)
 {
 	char *rem_m;
@@ -505,7 +505,7 @@ malformed:
 		excess_file(fn);
 }
 
-void
+static void
 sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 {
 	DIR *d;
-- 
2.39.2

