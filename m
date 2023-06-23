Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB95073B22E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 09:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjFWH7g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jun 2023 03:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjFWH7f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 03:59:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D16F1BD6
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 00:59:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N6T3Yh023965
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=bDy7poz3t08co9eb8fN2eitCToUEP2YMTlQAXa8RZVU=;
 b=fFXkUPiXyIOyi/LiC/BJaCuD9BZCtn+1RLK3exgcyZK3rwSMGsRDF9v0sEjDQ1C7T8Ua
 p0DrjEq8TSV0Mzmq8eWJQ6oIkR+Qu8Li87QcETua9Q03J8+FHNB+inVL9iZPbQby4uQV
 tcN/k5+qKrvL9uGXiTUW7kxlYPZ9XWPdGaCXe4PGELui/mIXNj+aD0PZYAW/YWLdBjh+
 WvOUJWdpU5xoJ2Fom4m0F7bCWS52IhWhvIg66MugI6WXE0c8m3deKRO4JCM/Qrek+mdL
 eyBQ7NGFxu0v3V0Scen3dn06cUQ4+VMt95izVLhes7kGiONe4ES2bIAFZ9PmB+MF5pUx eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qaba4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35N6ZXTU005898
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9398f3wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 07:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4VBSvn9DxQWUfOBRAHlFUsGTWV216D12k9i7QfWLVHndvnET3hhRYytNg2bFwmgLBI0J6V9pnYxvziV+vN8BtXnPTFUaBVuKBhNfHsVYVrtT6VcLKXRMJt9Ot8u3VI9YPNhTFDxTZy5Y0FPHWI8HpGtXUuCQPJRL5uGlnjTiwAgemoUdEJ37ixM9qOBm/m5vXmRyOLkb2QfpcwkugsLMj8+YbOkEAiAXGeHvDMDxLuJcQ4cWAOAZlkI/QFJO5IkIhx+VOLa2vUvLj2htBV2zxRA7Bl3njMSBAtZEgO7VAIZgLWzmFJA0Ma6oIRaQlLf282BJgOWJZWdRnr6AWZt1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDy7poz3t08co9eb8fN2eitCToUEP2YMTlQAXa8RZVU=;
 b=fjYdxy3/xnXif/CZnEaGm5P0pseZt3k23uL9jnyLvP4IOwg8Uwrsfd1D78BFic0vvjCRhHR81hdmaBq6GKLOQ9aCvMbqXQbY+cISdlZFToauE3fY3cCv5VMarE709kBvfv/Y3HQ3xLZJweYyApZa3o0XALlF187iY+ZzFCtBbSn58oh7L8oXDoT2TROD718wM/OH+Ic7ZqcCmvw52pWJrd2PTTc50Gqv6hh6hQgYWkF77qxqm7BDPotu1e9v+JVd7JgNieHzgpJyr/f/H+9T5LnOiS2+nZcsD6nK9En3on6zoBc1CKtVWL0PcpFAXGrVrXMDl4T5WnNdMYG7v7n0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDy7poz3t08co9eb8fN2eitCToUEP2YMTlQAXa8RZVU=;
 b=diUpiyOSb4LJArSfeedt4y5mGr3MIse4FBpX7/q3aDl7nvXL3Z0fRPWLnZUj1rwX6orvpzlSzDX/9rtOWzEPtEnFDiOJ/q6+K/PVyQ/r/z0qXMnqfgCbNYktKHpnPipcEsYbPa2kbQ8EZDjCXaZkdNxlQGbzUwCncMS3sef0LKY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6523.namprd10.prod.outlook.com (2603:10b6:806:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Fri, 23 Jun
 2023 07:59:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:59:30 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: tests: fix warnings during make test
Date:   Fri, 23 Jun 2023 15:58:58 +0800
Message-Id: <cover.1687485959.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: a598e86b-c2eb-4d8d-3e55-08db73bfc648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5I1R2yPCtEDqXZlKRd7c4RHaQ8Mx0EeqLou+Z0pWWQad7aHom4Brg5e4pPDSoLqWHSmjenGtgzmHYfIjanSiUjHVfDUcjOb9IZzWPy4xzN9mOV0XptX1aZE0v3lrsaKr2eDHutCwCJhZ9OAIFdC+su0YJ29kjgFKpAp9zgAQiYDZO4VD0GPsHUU2Bkbn+NFdyeXheskHiHxQVJ/vuhzQvhG1O+LHIciPCa5JaKiylySE/P4YHVuP2XQeSBfcgnIkBpFGnD6T1rOXJ9AObxm/TrU0QM8YaAId/dpSQKoIqjfMDxUQEsQIs2RrtWCYUNdLE81ilF7sKF2PX9Z6HAF7Y0q5Wki+8LfhaUjL86KY3X5BeB1LJGI9IcLaJIKrN6x2lq4rak9Z68+9AAjkU2SOaDbzjvyQ4hzH+hCtwObWg8ABekms7N+ZFfqQZCsVHr3b3P5qqlQLRiD7SF3J3ChT5Y8BYhbmMX9MXg9OeMx88gPZL8vLVBwKfRuqCCRzWfue0a7Sh58pqKl35cO6jWbg/1rRA0M7AgF+7fdxLeIwLq9GLhYvArEGUK6LMkP1Bcl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(4744005)(2906002)(44832011)(8676002)(5660300002)(8936002)(36756003)(41300700001)(86362001)(6666004)(6486002)(478600001)(83380400001)(186003)(2616005)(6512007)(26005)(6506007)(316002)(38100700002)(6916009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkpSZXgvT3dDUHU0Y0MvYlVXb2JLSVkxTGtUVkpyZVBDY28zQ1VOTzgvdHp0?=
 =?utf-8?B?ZjJJRjNSdFhFOWNoZFBzUFlUWFFKWmZ1SEZiZkVwbjdHTER2Vnc5UkpDUGpQ?=
 =?utf-8?B?K3BCRkkxNzlwazNiRHJ0YVRWMnVGNlUxamlDejNQaVpPOEtRNGN0d01Ib3da?=
 =?utf-8?B?Y05qMlhBY3FVQmNaZzFaNGdINGVlOERkZzlhc3h1MHcxNzhGdUgvTUZMVUdm?=
 =?utf-8?B?bzhuVkhvbDRQMjBxc2wvb0IrbnpueGV4TnFaZEhsSVNUbm03ZUV4bW1GZnJC?=
 =?utf-8?B?SHhYNFlmVWEvUGI4bEkralhibzdZQWxwTFhGeXFWSDAxTkxmdmlHSWVFTngr?=
 =?utf-8?B?QVcxeGJycmVIbThldm5QTC9Neldrc3hRMU5Sb29pQVgrQmE4OTAwYjVhcUJH?=
 =?utf-8?B?aUFNdEQ1eDBTNnRYRXE4bWU5eEhYaHJzQkc2bEtnN2dhMHltWlNyT3R1Qk11?=
 =?utf-8?B?cXJRbmNvSFBnV3dyR2RXSk9oZkZOK3NiMFBld1NxNFJQNDk5VkQ5Y2pDb2lk?=
 =?utf-8?B?R0tHdE9rT241b3gxeUNLSmc4UHEvN05hK3FicFdNYVp5amJjTGUzOENrTC9E?=
 =?utf-8?B?T1NJK2JkRkloUTdzVGNIN2tCOGtOTElrbitpaU16Q1JsVHAzeDRGQmQ4WWo1?=
 =?utf-8?B?dWN5WDVVKzZQdzI3aW1wbXFpSnZPS1JnaEg4VFc5U1F0aE5vNkhlNTY4NVpS?=
 =?utf-8?B?TzJyU1RZc05tUlVCUTFVdys5aVZEQ3FGS01uaXNLSUhRZmkwT1FtUWRiOFRC?=
 =?utf-8?B?NGtMellrRDdNQ0liVzBURU9CQ2E2NkRma2twY1lTM2o5QVdCTThtZHdFcGlw?=
 =?utf-8?B?b2cvYkVPZHlhTXVmV0ZlNHB1VWI0YnRSZ3hsVGlNRXJ4V0ZaM090ZVdSRUJR?=
 =?utf-8?B?SnNJeDlSbW9UditsZlhIRVMxR1k3ZTVKdGhSK1psRU5YTnFMRTNkeHFkRHVG?=
 =?utf-8?B?OGNJTWl2OXJ4Sko5ek1uQnJWU3BPTklhVlJ1VUdvdTYvQ2premZ6cmZNSWJ2?=
 =?utf-8?B?bFUvQm5yZCtpa2l0bDMwM0lWczZISHlIeFZqallIZmVNV1RhSm1nUXB5WE1K?=
 =?utf-8?B?NG9jSElPK0JxNnFzcU5qUWR2dklYZFlEeTBzeHZwMWZQcHJQK3pPK2NpYU9j?=
 =?utf-8?B?RHBTSjR0NUhOWnJoMmhuNmxka0dkNkhUUm5SY0hOQ3RYcW9LOGdiWjFBUXlB?=
 =?utf-8?B?T0lpSG5sTEhCcWE4dXVQQmhtMWU2czZMa0VUcDFQdGVyUHEreWdDTFg1dGpm?=
 =?utf-8?B?enFSdzJQOFpSTWRWZXl4eUMvU1FqZDFzZ1JkMnF6ZmZIZzBTWXVhbE1PV0tl?=
 =?utf-8?B?S1c3NlppSkM1MFp5ZnRRZTNTazl0QmRoekU0amJSV1hUSG14ekd0R0lTSE5Y?=
 =?utf-8?B?NTJraUt0S3FHaUsyNzAycGNRcURkYTloaHVkQ1U0RnR2ZVlNS1QrYTZTMkJ2?=
 =?utf-8?B?ZnBvd2dHb0tyRTAzcG11cmNZRnVlbDdiV3lVQ1YwYkZvSkJoNjhWcjF4TkRZ?=
 =?utf-8?B?QzVwYmYydnFQVGp1Q1pyTXBVS2FPTXFEUFE1dTlDNUpHTVA4NHAwcDltMW1G?=
 =?utf-8?B?a0NMaUQrbnJ6KzhUTlExMlBtOFBqR0EybENPRHBRcjRLYTlZZFN2RVZCQTkw?=
 =?utf-8?B?TjJMWXJuK3VKUHhvTGpVMTc1NUxNK0hNbi9oQTBBcHpjN0Z0ZzU5WGdQbmJs?=
 =?utf-8?B?dmg3RVQyWVFIZmE3cUpvamZ5TjA0c3pydzN6Y0JwczEvQkxGbE1SSmpzcTc5?=
 =?utf-8?B?MjREVFdrSlVhRjNocmRmc2VUOEE2eTdsakFNUUFoTUV3dWMxQjVSbXBXdUFl?=
 =?utf-8?B?NmhEUTFXSjBNdFF3VG5BenhwQ1hpeGV5RDU2L3QxUlcxUWdRYkpqdTlJQUJS?=
 =?utf-8?B?NktIamt3ZHhwWFFqS0h6VmZqdHFyK2RMNFIwQ2hOb04xR1BhR2VraHQyYVNZ?=
 =?utf-8?B?NzRQOVA5bUorMXpJaFJscmk0bDhXdzk3Sm94N1RxbFU1T2dMcVowTVhjbStP?=
 =?utf-8?B?OHFFd0I1RVcrdWo4b3lmUWI1bTV2N0xGZU14L3cyUXpZcUc2VkpHU2MvUDdD?=
 =?utf-8?B?UnpzcG9lL2E0M0k5bVJrYm4rN04xKzl3RytXVHJBSVVPcW1aZjRYUXdmdVR6?=
 =?utf-8?Q?v4L6peFrU54h/sZl6no9yrkg5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uDyH9/PMHUfv9sDcpqCsIgFO3alJYNSw1Wkvrc1eyrvWaJJLz6VtM4rRTa9Q5euFIBg2NXMY4WUmLuP4lL8qjj8XpbIT4K5bx4kcea84gNTo/qxLdubcy63bstzAQrFDbchumyvci3TwJNNRSUHnstI/qsaT5Y7JjoHOLUcXVo+RolgAL/04wxTah1QbbC2tCCeVYnRWf9BCiM3BYutOPllHrWKdVqKVha2foQm9dA4NbQ8p2TjDScCBCAoRWo8v1PGHv+K0PDOz5OfT4HZ2a3U0cHh1u7D4U0oO3v3KsTpukd9qLsVt8QnYNQpAhO2yHjRyq3cz2mGjjNvbT2IVBtn/ftsSAamcivXgbhf4qQyMUpBfvgUhJ/MfXx51K+Hjdn00138cvFSYP0se3rf+8am3edk8jENDpzH3BD/u9CiGqXwLHliE4JNy8nej2QzIEFO+COPwnRceQg2qd77MDVHvWysaodTysIigfWyaI22GwuYJFb6DqmnNui6mZsbsu9LDMYYPNL1KTQNzi2KuLXhZQD5frYptX2SddCegb4LrL6wVAKqbqKSN+53xh+rgb8n/7hg4z1YL65vMkYeHYmjJ06Gd0Sqa/eGf0NofCXw2pZrikln7rhW1qS/+9L5780y4UXvBdZ3QZCRHmt1SNdZcOXacX+ZkqLvN3maAwQDANx/mcAk8fd00LsYQqdlZ4/iCItUVLHEhReP3jxJIcrJ1CyrNMO88xCk0UseHGvNwc8Dr1+02FTmPeuVo9dyyKFeHeiVSz/gFPHb5Gworfw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a598e86b-c2eb-4d8d-3e55-08db73bfc648
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:59:30.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6t6zwtnsClqREQnOPztyCx7QoAJYuwL8tnC1cLc4gK3QO5ra+eS782LIXGI729hNyg7bJ/RR/U5UpXPzi17htw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=922 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230071
X-Proofpoint-GUID: AXgStXbJQT45Bpt5maE7Y7kBc2yiiqU-
X-Proofpoint-ORIG-GUID: AXgStXbJQT45Bpt5maE7Y7kBc2yiiqU-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This set of patches addresses the warnings when running the following commands:

  $ rm fssum fsstress
  $ make test

Ensure cleaner test suite for btrfs-progs.

Anand Jain (4):
  btrfs-progs: tests/fssum.c: fix missing prototype warning
  btrfs-progs: tests/fsstress.c: move do_mmap under HAVE_SYS_MMAN_H
  btrfs-progs: tests/fsstress.c: move do_fallocate under
    HAVE_LINUX_FALLOC_H
  btrfs-progs: tests/fsstress.c: move delete_subvol_children under
    HAVE_BTRFSUTIL_H

 tests/fsstress.c | 10 ++++++----
 tests/fssum.c    | 46 +++++++++++++++++++++++-----------------------
 2 files changed, 29 insertions(+), 27 deletions(-)

-- 
2.39.2

