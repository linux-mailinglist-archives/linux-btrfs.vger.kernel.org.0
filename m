Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7916A745C4E
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 14:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGCMeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 08:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGCMeE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 08:34:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E42BB
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 05:34:03 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363COecs031815;
        Mon, 3 Jul 2023 12:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=H0pDsFmlne9RG29XRUf7BmhbxeS4w3z3MfCmncOVQRE=;
 b=0ooppcxOfnPL2WXK0JIiWxBd2l/eh9HHgvGdpOFX9Vf3LjvFd1pxDLpkpdKf+1+F8a8i
 v50WRivKPoQx5sLhqxWG40GKdiWgBrXN/ZHydBeicWvOjz8TQS6Xz6HNHBtndIUYkF4U
 68XWQv7G+ekqPXK03IMDB2uQED7lBxKrdY5njdlcvo2Ls/TxOtNegbWCgtPK6kI3VM5p
 +ELW9C1pMNNAG8OeK47Jj7C8RBEI0PaBw0y78m10EqnJRNoulfhbFOiX72yWsOFOFtAQ
 kbGT68+8IGAcqp6yVk69fiRhLDwPxL4rz4cIxZ80jhnyzW5WU8n+mqGr9lAW18XxelAw CQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6cjk46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 12:34:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363BE2SL038631;
        Mon, 3 Jul 2023 12:34:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak31837-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 12:34:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lL5nSvqR1UJSCGa8rdfUp16JKflkrfoYRJ7nCBd1ff9Hh1AR2XsOAj5+KF+Qw+uGcogk8eYsLREnUl4K7+s8oA9DVl2OkWuFFPUt3EtAeIwc3WuuYGdmseNzoZ+swk1V/d4viPv3bUkR/7+dReDiHsR36UgilPZtHz2zxJzfvpVyxVDcIAw8nxwGuE4EcYzg3+D9aSLvi+ZEjh5hrvo1SPTfJI5ZOlRI1Jatvjzc7Bwl5lr6bt/eyyzBcafvr6tSIW43kacCJmuGFEsCjLenmEEP/TNiMLRkWubhXVUMtKYs1IDPs/k3f0a+FXc48mX4gOTs13NT4FQpxYGpF7Sapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0pDsFmlne9RG29XRUf7BmhbxeS4w3z3MfCmncOVQRE=;
 b=i66x2F/xQdOMi6Y6UxfjXBgyq+CFUft2AMCGSrOMt3FqpDahNH98dJ3fIzsbIM29WRcBC+H5+FL+d1ma9puC+d+Xq430TYZPpnHE94xq6pNBZDGpwoYT2yhJnEAPKmy1nl2nwNFrlUMz4r+yfsxauVsQKiuFqJslAcYDi7tn8w/sZitl1DgpiaCXZtC0OLjTqg4u/k7ylcCs4p9u/PTSZkAe6iJ3wzAc69XYsYEPqpgYFxRmZELntlB3JfuxmfVK6/82WJgkGfP3mQf3A9z/1Wg++cdO7FNIkDXkYcv8PRDXfAE1HQnid+IuxVJBJn76/a/v6SXWANaKVRK0ky1GeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0pDsFmlne9RG29XRUf7BmhbxeS4w3z3MfCmncOVQRE=;
 b=gHmCVk2nqPOYTWhxvCMLARDOJksVokOO9xwN2w1ipYtUlCopixZlo0sEEiwMl1eET8BmKWA0wYLO6HgxyEBHuRbkw6W6EGr8WMo1OCsz21l3SrmFBJeIw/5cpuX/fpDIzFOZ/HnodfT/pGJ3vBymPXCDdm5hEi0fkUAms8koBQ4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6448.namprd10.prod.outlook.com (2603:10b6:806:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 12:33:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 12:33:58 +0000
Message-ID: <14dc551c-d905-5921-5651-ab7bc798e4ea@oracle.com>
Date:   Mon, 3 Jul 2023 20:33:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/14] btrfs: raid56: remove unnecessary parameter for
 raid56_parity_alloc_scrub_rbio()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1688368617.git.wqu@suse.com>
 <1f848dbf2089ca42a3c17e2f361e7aabe3e91507.1688368617.git.wqu@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <1f848dbf2089ca42a3c17e2f361e7aabe3e91507.1688368617.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: db3eb8ac-8b40-45e6-d78f-08db7bc1c598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fuamNeLliQWnFaNBGYR0b1TAlR9pq6r8BzVSgj+jwQBdbyMZWvHere3SfD2YoBtotE+lsB6qlirBnB6r1aBwoLil/hv52pTzKsqsEyNQVfaCt4DM4AtN8lg8iVqgjF9FdNr3xuWtbl/dEF9HUX3eKc89hbSYvs74jV7Y/T08IBkv1aeFWOqtfaJoLpqeq0TqwuIooPRoGyIAp3mo+2H64hF0Cyzj+69QH898e8DUK6Xs9jMmNn9qtGEopOEFCO9ymeWux8chDmPB1AGhiQ1C2nzBFwp1su4UZwVRoA5t1KTcDfKkPVCavXW8mJrULLy/7960j9fq26advn15Q8e/rrCzsPJ4HKpevF37S6kSZwBfBfrH0nDHl1R/zl91VrSE4mBWggDmglycLNpzXjNRRfhvQo7yMNeC1TbbVSYOxTTG6ZnTWHwSHbGFJcTwswqiwl6KGDj/iZDJpCe1DXhYBZJzgYEuYbUkyA1gNUs6+IrZpFL9hE1oopAe9g150baByTzIsT68zYCokkgh64bIR9yehJCXYrQXaom8c3N3XJS0tTy5hiYPF+R/d6DP1OLsIq1V8DKBFt7CHg6x4M5pTUna41D3iRmNeh/CSqsGhk0otMRmDIQSUiaJB0jOMLImhDJrTcZjGeiQ7rmSF4maw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(41300700001)(6486002)(4744005)(38100700002)(6666004)(2616005)(6506007)(26005)(186003)(53546011)(6512007)(31696002)(86362001)(478600001)(316002)(36756003)(2906002)(66476007)(66556008)(66946007)(8936002)(8676002)(31686004)(44832011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1dXdmFWSWNLaGZsbnBjY2dHOG1jdzBSaENvOVFCbmtFcmJmczlSSG5PSDNI?=
 =?utf-8?B?dVk0M2NSNHFmRXp6dTlaVEs5TGRHUzZ4Rjk3TzNLSFB1OXFUUmFvVjJCRFZR?=
 =?utf-8?B?ZkR4QldvQktnRitYdDN5ZUU1b01Ea0hxZ0FJdzFlUElJeStuUzlYak9MWWlm?=
 =?utf-8?B?dkxuZ1NwU3ZVU3BaNDYwYzJzMGd4VlNTQi90WTBYTklUbkk2RUI3NEdWaVU5?=
 =?utf-8?B?WGVvdDE5MUF0eFgyb3M5dFd0cXcrKzlscHFxRmtlditVbzJZK1drc292L05t?=
 =?utf-8?B?OWZ4MHhDOVlORmxDQUczcE9OYWpjWWlOZCtrYWNnT1pwbDJ0Ymdlc1VLVWY4?=
 =?utf-8?B?VVdNbytnQzFSdUpzZDRReTJ5ZnBFMFVkZitLT2I3bDhuc1pXZHR0ME4vTXU1?=
 =?utf-8?B?M09wa05BQkkxekRKQUorVVp6Q0tQU25IQXNYYkhDVVZ4TEUzcVRDUkQ3aW02?=
 =?utf-8?B?eUtOU2dmRWFoSVA2aHdKNGFzOVNFeGo2RDRSaUcvbkFXVWNDMjFLdEJ4R3E0?=
 =?utf-8?B?UGkrTWV1akpQaDh4K3QrRmphRUwzTnREWkFGNW9PYU9kNDBKdER4Q2pUZUVE?=
 =?utf-8?B?bC9zcVNpTTM2eG1GM0JIdk13SUczKzlqUDlYS2sxdHIrdkdZbTNNWGxmcVlt?=
 =?utf-8?B?ejFYZzhpT0J3WHNLSE83OVVleUxjVFVNRUVNaHoxdlo2b1dVeklmcVN1STJq?=
 =?utf-8?B?ZlJJR0laZjNBQVUwWW8veXVoYXg1cExxWmh3KzdpdCtvbEJDdnhUZHFXWFFt?=
 =?utf-8?B?NmtzSVZ2MlV3U09yNmZVaC9lYUJKK2xBZHUydjUrSDdaT1Yra1NNN3o0NDlp?=
 =?utf-8?B?cTRKZUZ2TDBDeUVkUkhaeFEwRzdZZDk5cG9JN0tmSnZtMXJaTi9qT1czc1px?=
 =?utf-8?B?dllnVlh1dzgxemExaHJLSURYR2xOc1dpbHBmNndjU21tNmsvV3U1aTRYQ2pk?=
 =?utf-8?B?SFhmNkNvaWdwTkpJU3pwWlRvdGhVUk8yWGpoMCs4Yy9JdjdJVUNldHRqdEVX?=
 =?utf-8?B?ZmhhS2ZyS1ZoY2V6RUVLTGt3dnR3MUF4aldqcklJNk1CU0ZzbHFldkZmZkNo?=
 =?utf-8?B?SG1BNEhwd3h0S0d1Mnl2MWNPMldycFU3VWdLRUJnNDB1UXU2RjdXaVZnOFVi?=
 =?utf-8?B?c2dGZWJOOXUwVER6WjR4VTZmTFM3ZXBVWEE4SGRvcXBFODdRWmtOM1A1dEFa?=
 =?utf-8?B?c2U2WktSTXRSQzhwakYveTJiaUtFNThtTUw5aHptTU8zVSs3QysvRHArakox?=
 =?utf-8?B?UlJhb0NmTjNtdHpEYTAyVWNBajg0ZFI2RS8wQmRlM28xMWRsdjVLSkgrN1h0?=
 =?utf-8?B?TThpbEtkcXoyeVVmUGFMZGdTdXA3NnBrajlFOWVSdVJLcHk0TUp2NHVlbGcx?=
 =?utf-8?B?d1NTTEdWMVpkR1ZsZ25jNzJBbjBvTkNMU1ZaM2ExNzRKa3h6NVplRENhdXJx?=
 =?utf-8?B?R2RBL3REM1p1eEF2MXFFQmxJbEZteTV2dUpkTUJ4ZDBEMlA1RndyUmhOcmVJ?=
 =?utf-8?B?d1ZvYUpjc1REWW81RVhMSzMySzhqZVpnazFJTjVMRXVocTJIL2tzUTU2YTU3?=
 =?utf-8?B?WDlTTW1tUkx1NCtnQUpiSTRhUDJORjlhQitPajIyVUtIWmR4dzdJSzlCNDM4?=
 =?utf-8?B?NklSY1IvNFRPZlN3aHBEVWVpc3Yxemc0TTNwY1ZjTnhrM2NDeXNyVFI3OFpG?=
 =?utf-8?B?Z2JRZXgrL1RTR0lTelNHVUtmS0tiWnhaREwvdEtkWkJvSDVmbWJGbzVTTGhO?=
 =?utf-8?B?TXU2aVNiVEUyU0Z2cGhudEFMSEhXUGVlcS9xdjdTeTRtUExERFJpY2dLaWcz?=
 =?utf-8?B?OFVXNEtMTk55dDdpN3BXeGdRdnhsbHFzRkpacGVrTzJtYWQwRElRZHRoRTVk?=
 =?utf-8?B?SmxqK01HS1lsL0lzVmFlWGxWbzl5TzhJQ01ubThLZ2FLMENFQVpEMzVrMVNH?=
 =?utf-8?B?OENTSkZYWkw0ZzMrVVl3ZEJSM0gyUXljRnd6dURyeFgwczc0d3FIM2ZSQ0Qx?=
 =?utf-8?B?cWtoTHlRRitEbzJrcnl4elBqL2ZaUWdsUmlZR1c0WjBTSVpTVmJMQXZGMisr?=
 =?utf-8?B?dG5BTlVER2plOFhsclJTUFUxZHRGbUJaNy94dEFSd1JhS0p3eHpyY2pTVWZv?=
 =?utf-8?Q?5ZMXefqsR3ljA+8xrBNY4eL0T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ak2dbvlUpEvqt1KBqBmIocEjDRAz+3zxwQxQ2fencVLll7Hhpsvbo3Cm49l9igZnPy27V47tvK0ZvTM0WFON+KyyHGW+F9NKIKAcC9L5SKaJjr0nK3kg4Yr/JE9wjUvQkRK/f1xyU75hrh/m5RWeHbJnVZdh7RxVMr20rjQoKRiqxUHdaZagQSIOWHJ+X9ou2XSl/pStdH0zj61fvotRvkyCJmzsIgfu5SmOnifOjdrRN8IEpLuXKJ1gIny9ehsxNqi9SC12YzqvNEBJOV0CHddfJ/lsVHiV+HG2xHJuCFUG5x2xwyhJDSqYtZdB9kVTFeONSLlf0Dn3ObF5YAjn5LY4+HcmEtAFSpgwCIZeFEtTGkdlP/Aa06/RpSmHWdf/5279ECFpcaZeo4EEys68D4b7fAPPjsbWB55G8mczubzwkNs8Q5ZiqwBuHN+WSTRaqISWFXnPkAcMMRuiG04zchCPa+e+1PnJlX3CMd+281/XMHduMDZRbIbwLK0snhGMzN8oJSZG6pGeexQya3sEPhKwKaC4EOeWg4RJV4P71iX/QNaLWn+fg8NeKeaGXsr5DOlveomIwctCZqrwBAaO5gnzeBUkzopgmciq5F4Wi46TiGd7NLoAtbfnZFISONelfsYGLitZfQmTzZxYaGQEmgAPCZbrWSNq+aAxgWvzvQvQwVs/EoJvcv/QXNaOWqXJv3wQaxL5NYcTz0lYPLqcrpZjBtUNLuEU4KCICkbW48RUyo6dlnOm+b8mtdvbqP/KlkLFGfYuYX0MC5J7Rg1n6tRiXyRJtm6llvgmTThd7mk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3eb8ac-8b40-45e6-d78f-08db7bc1c598
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 12:33:58.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhYXJE32TGk9Dxu48dFReDFRX8U0MTOlb/amAp/5uQf0NYHfbB2aqc+JUmxIUH44dOPMavPo5/J3pKtcU/wnDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_09,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030114
X-Proofpoint-GUID: NzjGRDv5a_ma4cCVT9_LAZmtroUEokfC
X-Proofpoint-ORIG-GUID: NzjGRDv5a_ma4cCVT9_LAZmtroUEokfC
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/7/23 15:32, Qu Wenruo wrote:
> The parameter @stripe_nsectors is easily calculated using
> BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits, and is already cached in
> rbio->stripe_nsectors.
> 
> Thus we don't need to pass that parameter from the caller, and can
> remove it safely.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

