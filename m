Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF996F6DCF
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjEDOhV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 10:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjEDOhU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 10:37:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1F5ED
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 07:37:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DTc98005255
        for <linux-btrfs@vger.kernel.org>; Thu, 4 May 2023 14:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=7QXqzv1aQWQuCXzXybYT1nmIM1bL5IVdsEaHx3Iuyuo=;
 b=tFRJIDKQdPQU8d3+ysByz0aDCsNnauxKKo3V/jOSIOO2b8DhLnmfInlWFOjBrW7zTM1Y
 FZdxyc2j/fcIN+D+IuoHHmlQXQOpM/gODojhyzoPTrYNdKN+zHBVt5GRxHKO+4BHRNcU
 JQgo1KsQtPxlWgc4CSX0KHckgsugW7vVTxesoizymSKp/atswal6fPDwJOxoYiPJVRl5
 HkoW4WsHDFvsRISDYMW4cTaUDMKp/+MdvtFuljCtnLMdnzIoUoyfhoi6sPL+yue37kXm
 YgO7sZRP7lDD1djJzYvOa34ywiuCkM9kHjMasSP9rgeYs/Jxj9OV6cd7jdkjdu8XtlP8 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1t0k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 04 May 2023 14:37:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EIDCQ025048
        for <linux-btrfs@vger.kernel.org>; Thu, 4 May 2023 14:37:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8t6jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 04 May 2023 14:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wz4XylDk9ZMdzgYzKE9pcO9zop6VVmuKSr7cqr93pNpobkX5r5or0Dux0yzbUo3Vx4EZUweA7yr3BkrkNuOxI50YCa4oNK6yFbDPh+mO54pO1QlaCtetX5jEFx4jpp5jSQzCrYwNZWfZnVBb4uicTFGfdPdZWrQT23ztJ2DUV7HKxDgdAUX51SS1Anvz9a4UvbzmewDEqCFr36CqtsxRYV6u/KlJv1vFzSXzb7CRGK0z5o6guMzkIaQbBFmEtIS6q8F5nV6qXhcBMZE21OlDcue9gI1y3w+8ugny8gwazlABMb1c9JSaNjeEuMZ4tuKI0tTMSjJYhbZ/1rFqTBndMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QXqzv1aQWQuCXzXybYT1nmIM1bL5IVdsEaHx3Iuyuo=;
 b=M856Bky7rjZx54k+sFyae2cc7zK1oG+cQx9b+hZJ/o7LBk/iSWf0m14OnlADLuJE85TCckiDbGPkUW8Wv4NH004JVKGBM0KoW5FX4UMJItyUAdFsi51RevV7JPNP7ZCU6WTdtIhcSCcJPFQyuhykVyDUgWeNPmJj4msA2WSvSpIeF/lTXFSFsL1iMxcavbfbeju3JhNw8m/Ve4TCTaIdzj4VplcarqrKDiw2aXIU+f6QefWOyESPxVZ1iKbyPgxF3ffeWGbJnQYxZjRWrzLwY1FJzYq6UlraCJn4m8Y3ZTs7QTqhg/VbSXr9MIE2uuQYjMFSUn8Qh98JKxpDmjW1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QXqzv1aQWQuCXzXybYT1nmIM1bL5IVdsEaHx3Iuyuo=;
 b=ujwUWsxxibrX/MkbpLKgJSkl8xjdzfdPGsGl/xc6CP7XJNhmCIj+qLND/loQCy6kxMRNIClVwBkH7/ny5so/klG5a5/kkKFmCYVLWOjgfl1R4xpOPuEZNSQYPNZ+/OciB4LQ93cnnLiZeg8bDDMIgyVjzN11gr4bGUp976k8Ae4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5312.namprd10.prod.outlook.com (2603:10b6:5:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:37:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:37:15 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix may be used uninitialized in __set_extent_bit
Date:   Thu,  4 May 2023 22:37:08 +0800
Message-Id: <377fe88656a9ebaa34e60debc5ae80638e277076.1683210012.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0169.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: ea819cb7-82e6-4a53-bbdf-08db4cad0e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwMlUKWl2P0skZleDTri/n6qdU+TJBaIKDEtuT4JT7B4Kk1fKhA3FB0EgFyirvd8xnJgBLsDoLotWuIy+8PWsnYTph1Kn6BVmUhjeWyO6NbBr5+WkCgjr3g0VsSPwcT7ccY1CIRxW9R9PPh3vKcUNlJX7KTuwA8mlkmThqi3W/iMEogOEt8UiIx13YuMO7ZZv0lgb+dj3cgm7N1F9E5Q3bwz+S4jYfdRoLPykrzbPsrR/3jFWSp/2PQGrlZFA4IHp4VZyVUDwqprLQ9B9PXldhIuexNUnJo4E03Vcb/qecitmgMa55cA9a/aicVXO9sRSrjgnt8k7BvCBsV/7Zt7D3WKUoDiFgGUkrCph8GdsmFfnuuD3Yc6K2HQeGbyo6IFCiSutsThqs4MV+71H6I98OGzaOzyfgAXYBtXFROnJThRwPV//gMv45JBzKxWMWO8WiksCHHk0f4Qe1mAjXdit04GzqcSwJWIzqPkPj8cRAjikj1sy2rzREigfXioMTZWHbAUjdegUhtbUtn6AqaEEFXWXEf538ETgYEUEerTucVSEAZmtayH5HWWzPkFLnJ9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(83380400001)(5660300002)(2906002)(66946007)(38100700002)(186003)(316002)(8676002)(8936002)(6512007)(6506007)(41300700001)(2616005)(6486002)(36756003)(66556008)(66476007)(44832011)(6916009)(478600001)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkpsRWRtSUZCTFVoZHRUZXNSSU9XMXNOZy9zOVRkMDFpbTJHbzErc1FtTHpo?=
 =?utf-8?B?VTZMdXZ2WUtSK0VrbmZmTElnU1N2YWpjWXp6ZTQzaDNJME5sT2x6ODlhaHRW?=
 =?utf-8?B?cHp0VGJQYkNSTjFRNWFzR1R5RmFJL0dRbUlaeE84OUF5NW51S3pqaWtJQlZZ?=
 =?utf-8?B?YzZ4US9DQXE1ZzA2WC9ReTh3VjFMU3JxR1hjQ2Z6VjE2SGdWM25MWnpIZDNH?=
 =?utf-8?B?RjFMQlIxcFExeWEzbUg3NG9qQjAwcVdVNWFOWmMxa2RIUEIyNEtkZmU2RFY0?=
 =?utf-8?B?UCtYclFPanJjNk5vT3FzZkkrOGhpdlUrQk52T1ZnQXc2ZEJuZGtLNzNvbUt0?=
 =?utf-8?B?ZjFIaWNBMGlITVI2RU5VcG5sZFRRQ2pwWnQ2bDEvdkpKZ2haZnN4NlQwNkht?=
 =?utf-8?B?VnBhN3VNSll1Vlp6RGZQV2VmM3RScmE3UXlJQWlHNGo0UUt4QkNhb2l3OUow?=
 =?utf-8?B?Mk95eDNRaE9lV1ZVa29CR1dYeURZUDJ0b2VjenFOU0hyQzRDSU04NmRYU3Zv?=
 =?utf-8?B?MGNvQVZhd2IyUkovNk5ydnBBWElRR3hKZmJIWVlPV2tNMnpoYVRXYTY1bG5o?=
 =?utf-8?B?Zm1jWjJJVG5CSUNCUkpGSHBsZTVFUVlWVXcva3QvY2grMzBxclMzSzhiRzBU?=
 =?utf-8?B?SHdtWUZWRjFHck9FOSs5MUFGaGM4MDUyR3Rid1pZRXNZYSszZVBPV0JFZnow?=
 =?utf-8?B?YlFyNFRTS0Jvd3lFc2NUUlpMREV1VThBV1RkNnFVL0ZRZnBuNU1CN0FiUG9n?=
 =?utf-8?B?Z3o3RVR6VCsxd1B1SHlxZU5VemZZWlV2SEZNU2laa2g1d3FRS3BtYmV4R1Fj?=
 =?utf-8?B?ellNL1FKbVhoekp3R0hMdHpqQmdTVzZVbVRXcU5scUxBYW1sTWFTQk1OU0JT?=
 =?utf-8?B?dXlqcW0vd1dhcmkwV09XaFljRUNvMlNxV1UxQlFUOTlLUE1pRGp6RSt5WjNE?=
 =?utf-8?B?ZkhuY29JaVMxZWR4cXNKME4vSWZYVDVHaWpHQSt3VXdBazNJTWcrRTBaaUoz?=
 =?utf-8?B?dFpQeVZCTzlOUVUycGF5N0ZhNUtOMlpVMkdCSWxSeHpCZDZUbU5ZYUVSVGdL?=
 =?utf-8?B?WFU4ajJKMlRIYnNtQzhSUm5paG0rdGlSN3QzNVVDN2Nia1NQUE9EQVVpNmFR?=
 =?utf-8?B?WFVkV290USszbnZWdGdiZG5PWGloM2tlL0F5aE5RaTc5V3RKb3JrT3IzeUhB?=
 =?utf-8?B?d1Rkc29ZRmFmV2xtRmZwU29ZRzFLdFpaZTJzSXZabU0rbjdDMnJ0eFQyZzlG?=
 =?utf-8?B?N2t6WDdNRlBEZTdFT0Z0V3B2cC9Yc1Jjd2xiY0lNZ0ZZZEZVVEQzb0pQZTlK?=
 =?utf-8?B?dmQwUEN2TmF5UTNvUjZiMnU1c3JDcW5vMk9TdUNWdmdKMHIxa0lRMmNHL3Ey?=
 =?utf-8?B?d3RFTitjcmZGOG02TXRzZCtLTXF2MndReVhndjZOS0lqN2dlbE5OVHVJcEJK?=
 =?utf-8?B?ZnNObDJ4dnNZMVp1czJvaVBJT1dpWGRMVUVPRkUrRlM0eFdrTjVyRE83cjBN?=
 =?utf-8?B?NEkrQldnUkhleDZIdURkWHBTRmFyNldtUm0zV1RmRVFUUGRPYTZrSDU5Umpj?=
 =?utf-8?B?eHZUN0llYUF4eDZZME9nUW12Wndjc2Zvc3VUb1VDSmZlamhMSmRYUVFybWNh?=
 =?utf-8?B?QlV1Z3V6ZFpJRllCVzh0QS8wRUlyYlVLNm5oaU5BRUltQ1RCSFRGMDZneUJC?=
 =?utf-8?B?ZFFENnBMN0lRT3VMV0JGTTh3UEdOZDhWVVFzK05PS1pPYXNuM2dzRnZsSUYw?=
 =?utf-8?B?UmxTQmdNRE4vR1dpTllYR0FiL01yUGZjRWJySjNZeFphc2pmbnEwU0ZtVVFj?=
 =?utf-8?B?K1lXWWZkVnVmejBHcW5ucWR4dFRxOUxTakFRR1UySDZBNE9XODhoSzB6RGV5?=
 =?utf-8?B?NDRYaWhMR21ucDRzZmxxc3FVdzhoZmM1UElNZmhjMVY2ZjhMUUR4Ylo0YTFO?=
 =?utf-8?B?cTZFWTdEeXZDU1hJc1NnUjFHVTNaMU02bndEdEJza2p0bC9ZYWMwWkwvb3lC?=
 =?utf-8?B?eGxXOFAxeHdhcjR1RlY2SGZEQm5vSG43cVhhcDlzc0pNcmZ4WW15bFE5eFdM?=
 =?utf-8?B?UGRkaU5zQjl1R0RBR3JFMnM5cHRFcXlqSFU4WEViQXRSN3pweGxlUURJVHg4?=
 =?utf-8?B?RVVYczBtd25kcjVraVJqb3pzM2FsWXBhY3hITHIvOW5qcnhmb05GVVhyK3gv?=
 =?utf-8?Q?RJJsRUFMd+6ztBRd8yFzIYI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 64hvwIrvOuhJR01UYcWtmDa6Sbke9oEAUqqPp5ZflVQfVIq5wvfrlPb+P8DBhqa1VMbQcRyOSkVvYn6/QX/x0uvn8wgrP3d8lVIE/8D3pjlWxm2l/1Vw0XPqBeqxuf/bwbVFs7Th+MQiLcSIBt41ju5rttAk7+Z6FJ1AtwWI5oP8aIWt8G7oOsjRcOFBXx5xMRx8WinIKeheoro8LmwpftgtNJj31KxqQCD8Ck187KhBJ2jr+2ZfpaQF9tNSrKEvWv+tIFviezIwKbH2dO+Ao5U3ob6do1RE4shJfeAnKDosVHUlFaCzWAjIleqVJo4lUvMxfARU5GyknvfUeibl4W5eZA0tMj0SodoZNmDAuOXz8FbkJvXEe1Pwcn+DSot2/oxQfDVBf3H4B5J1s8H7fBkXb1VYBLFDhXxVyZBVKdYDu+ktn+UXxi+SVbBkCyDnO+viDFBzfZLmCjE5L1GEuMI2IvGuoYFJK8m7cQnMZzz/Aty26QWQhzLe2UETFaufOebhr8g2YMoGm/ixO38MvtGzTk3Ua7x8xGugT4pQqbdwAWVPEaf1fCZfZEE/Mf4wE8atAWLGjRc2vBOFQRKz+h6PONRBtIhDpZ/KOjiJ4xCjZJZ3rBhCAK1n002YTMUf5+wW0qDXRoRZWQXlJ+wTe0LySPMOSBq68ed3RTTy0/Ue8jSEL9tQnVQf88qah3wkOy5D4v7adB4qY7koTJmQPOn9RUxsIpE3GDtk8bgzKLta3AQ1SKSLIcTWe73llbtU
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea819cb7-82e6-4a53-bbdf-08db4cad0e07
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:37:15.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7scBcbTTIOI2KRNP6XPZVYGoW26+/A5EebWlseMOsRE5hSjc118w52mL1WhEGP+bhnKbGbW6ZcDpXiiUF5IUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5312
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040119
X-Proofpoint-GUID: 6W2uJCoBzTtfwFoBE6EVqrQTrUZxwruD
X-Proofpoint-ORIG-GUID: 6W2uJCoBzTtfwFoBE6EVqrQTrUZxwruD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Compiler is throwing out this false positive warning in the following
function flow. Apparently, %parent and %p are initialized in tree_search_for_insert().

  __set_extent_bit()
  state = tree_search_for_insert(tree, start, &p, &parent);
  insert_state_fast(tree, prealloc, p, parent, bits, changeset);
   rb_link_node(&state->rb_node, parent, node);


Compile warnings:

In file included from ./common/extent-cache.h:23,
                 from kernel-shared/ctree.h:26,
                 from kernel-shared/extent-io-tree.c:4:
kernel-shared/extent-io-tree.c: In function ‘__set_extent_bit’:
./kernel-lib/rbtree.h:80:28: warning: ‘parent’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  node->__rb_parent_color = (unsigned long)parent;
                            ^~~~~~~~~~~~~~~~~~~~~
kernel-shared/extent-io-tree.c:996:18: note: ‘parent’ was declared here
  struct rb_node *parent;
                  ^~~~~~
In file included from ./common/extent-cache.h:23,
                 from kernel-shared/ctree.h:26,
                 from kernel-shared/extent-io-tree.c:4:
./kernel-lib/rbtree.h:83:11: warning: ‘p’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  *rb_link = node;
  ~~~~~~~~~^~~~~~
kernel-shared/extent-io-tree.c:995:19: note: ‘p’ was declared here
  struct rb_node **p;


Fix:

 Initialize to NULL, as in the kernel.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/extent-io-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/extent-io-tree.c b/kernel-shared/extent-io-tree.c
index 206d154f09fa..35e21feed4cd 100644
--- a/kernel-shared/extent-io-tree.c
+++ b/kernel-shared/extent-io-tree.c
@@ -992,8 +992,8 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
-	struct rb_node **p;
-	struct rb_node *parent;
+	struct rb_node **p = NULL;
+	struct rb_node *parent = NULL;
 	int err = 0;
 	u64 last_start;
 	u64 last_end;
-- 
2.38.1

