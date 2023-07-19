Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A92758F79
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 09:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjGSHss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 03:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjGSHsY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 03:48:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8C5212F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 00:48:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ILedKB031168;
        Wed, 19 Jul 2023 07:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Eco0psDdtBjzTLnAgCrGlvnO9kOQy/OkVFk0QE8YRxc=;
 b=UYxCgSDBcwWi27bNfhtZZ6m4xMi3TirV9WHPJ43x5dHJLr8MrPg1Kv2hgb+1vVTZc/YY
 s2HSBjiBvSdkfE6bBJd3RDQ+r0YC8mgszEboOlWapw/6RVLF9/XWN6mLcVf3DMeUH9p4
 3bI/NyzlnkufIye4SuSvuSb5YFRVXYWYvplqxOBKqgsYD/dXjwps8niK0e8UgIT+OyOj
 pzq0vgSCpeXDZp0/4IVsHbvdWrRsxTVtRL38rEG4Fb4pUOXVIu7Xf5ETLEir15aW2kVj
 aGfRFWyxEdUMBS1Lcq5RPOUdPPwqPJ+qAiN6GRHx39SSw9xKYeKVb05hBK84qNIKWYPR Ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run786sjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 07:48:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36J7Ps38019314;
        Wed, 19 Jul 2023 07:48:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw6vhp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 07:48:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOmHr/RkG/eI549xMATQ97MfRtfAo2oueRe6HcO8CV5Y6WPlBmVki9mqzPcwLv/sZ2PolYKP+fg9mQUy+gWsQNarm5PrPdvaYcIRAFsf5CaelXPmfW8QWI5kzxoGqtJf92HQIMcDfQWazx0BHM7TS88nXRjffPGlsZJdBQIRkiwP/eIMrYxaXWP3cZjB86wsSGLHOtmxn7OsAN3Je7Lw0EB2KsKQE2qEQv+o+KWddJq5xaEVxlzIReioeQk5ghUf6leAFUj5Hnc3tTAfyHfdORpvfW6yZRLN7VUIWPvE0tV5SrDt7WBjx0E0VxS9hsHzFvF7ZEig9fjY1R1qEFW8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eco0psDdtBjzTLnAgCrGlvnO9kOQy/OkVFk0QE8YRxc=;
 b=OWYeeqdl0C2M3D8fpkkIJLq9GedQ/T2QDv50UeJ4Z01za8zsckVtNDC91Z6p9V1j9ow5oKjjAwhoTcGpipuEHFg/qcv6uWVI94K4J/X/DTcoM7nKJpJ7ZcnkiIr4uihcVZ0OsS7DsFAWEUYge1PtPn1rDl6m9ZixOfbAOhzglgABNRLDbfDddb6vtXw9Gzxz3aMrQzWsoTQuEOZsYwiBdw7qi+1gmnJlF3a4QE7lQvYByFM0hUabb+mZ0Rl2orhweX3qruVn4ARP/vGuQaP6fPZr+dWv9WDX2aPdgLKsH8PlIjPVDIdjLKiDS+YFHxGfm/qFXN65tCyGikkGhKFVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eco0psDdtBjzTLnAgCrGlvnO9kOQy/OkVFk0QE8YRxc=;
 b=dy+vGJkbZb73D14fmaKvN2PUJBeudF+8j1fZKfdetrQLT7L+IPwqvWS4QF26eVVU3d3Z56wJQ3fwPrd6ZCK3ylvr8e2FcFBk+kJcw/3mSUGCCHf0g2eMBVdi2+rmNJcIesSF6jhrWS/Nn3nzmaLQSgXMCbDkH3k3BcMPjqVUhaQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB5915.namprd10.prod.outlook.com (2603:10b6:930:2d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 07:48:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 07:48:13 +0000
Message-ID: <320bd2c8-ac3a-1e7b-ed04-6bc7094745d0@oracle.com>
Date:   Wed, 19 Jul 2023 15:48:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 00/10] btrfs-progs: check and tune: add device and noscan
 options
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1687943122.git.anand.jain@oracle.com>
 <20230713183523.GZ30916@twin.jikos.cz>
Content-Language: en-US
In-Reply-To: <20230713183523.GZ30916@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc9fa33-09fc-4abf-4e3c-08db882c80ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgM3Ecmt4TAm6kHMSsn6U19UUrvZD6OJD7PCUFIy0Qd3TuzNsfs8NPrS3t3EsfLhQD54CZ6pg0/3h7Ih/EVnNPB4g14XsjQluYjuL+Sp4fDPs9UI1G6PGabWOMI75uERmFACcxcM6Q4y+blcnYO3GFligs5gmiZ8c5iKRxNnxpHoTemvrXxGOK5UwYKauz2/vJgtVdACv8f4eEnNCCoJNa3fAG7Dz/d5oQraZrzGZLnJ2g34m1dRQeaFqcypam9grxvRyRwgamWwmrH4wHjX9qS4cQo67bkVbzYJzhXkEsVgac7729qsR/pZ+HXBkHMLhgJJJdbbt3lcC7f9DlwdqtNf3oPvDztmWiwfd5bSMxKxPn+GSc81g0gutwXPVnVmZ3z0Vh40KY1GZvJOEHeBb2M3etUYJO9Mwik09O/qC6V/zlAXQUsQUhhNfLLCFDYp69L0hm9LYz9/LM4A4oBoa5QbFeRJxMpucJTX3X1DTtPFXDnZ1GqiWspoLne8I3Ug5XuzFFc/ErQeYJM6VZsydUcMg5yT6QYfhX0PDVLIaPWNgG/t02wrqDna1t5jBh+1+FAAwiJAwvLaWmM2wHJZly+ow5iifWqCu4CT8SffsE5mLFWU3OOa6Lyzgt5qIep7LdcTNOxQXCn2JcVtK4cnyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(86362001)(6916009)(66476007)(66946007)(478600001)(4326008)(186003)(2616005)(6512007)(6506007)(26005)(6666004)(38100700002)(6486002)(53546011)(31686004)(44832011)(66556008)(5660300002)(8676002)(8936002)(316002)(41300700001)(83380400001)(2906002)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmo4b0pNOWU4ckloZEVScHdwSFNnSS8wekZTTGw5SkJWeVJvYzl4aVFUc1Rl?=
 =?utf-8?B?VkpGT1VqY3o4cnZLTS8zT0lvYU0xMnovaDd4cEwzSTQrZXgzVHN5d3pYUGpN?=
 =?utf-8?B?Z2VTY29CcWR5d0lIdEFFNE5ZaEVocElZc3RxZDMzdnJDZnlpdnpUNnI5aEto?=
 =?utf-8?B?Q1RPNllIZTU4NWlhdllYRXl4REZjVDFCVDF6dTluOXpYTEt6SzF6NHg0N2ZU?=
 =?utf-8?B?SEIvQVVQSFFvQnMwbFRWNEFmZ3FlN1JUTkI4SXJTQVVwTDZQVzhEQkROcURY?=
 =?utf-8?B?KzVpVnQvdmpLMmtPdzB1eWhKRThCSEpjbXA0aUliQXM0QVdBOUNxdWxjaXZK?=
 =?utf-8?B?ZEI2aEp0TzdYdDN3L3g3dEh1dVJ4dUozTFcwOEhqRjBwckIyZzVHUXVOVHlY?=
 =?utf-8?B?OCtKeGdidEwvOTMrTzdxZGxoemtHS1p0NDRWS1VmQjVEaCtaSGtFakRkQlBO?=
 =?utf-8?B?S2lEUnJxcWoxdHN2NVhCOXF5aEpqNklPd0pjVDg2MDBlZDBUbi8yN0M3Qkpt?=
 =?utf-8?B?UjZ1RE1scXJXUnNRcG9MenYrV2F2TG83eXZWQjRSbFpRb2JYdEtqZk5NTWJi?=
 =?utf-8?B?ZnFrdU16UCtUQmJqRDZScVVCMHZoMGVuRW1pSWViZEczYllLZVYvTW1SbHNU?=
 =?utf-8?B?czBaVGR4R2IwZEJiakQ0bkkxMktrc3kzNEcyQmlIWGdQR3hsV0YvSElmSXFQ?=
 =?utf-8?B?VnJ5Rm1nTk5oVUR5d085dmlwbFRKMWFvOHdKNWdKd0U3bjhRVVJsRmsySDNr?=
 =?utf-8?B?Zk5Nc2NlSGxBZHFmYjh6TVpXUVNpcGxabGNsSU80Yk1kZ1ZLSk9OVXVVYU51?=
 =?utf-8?B?RWliMTk4NzlYNUxaUkJqZG50UkZFQlc5RFFMU0QxMGNOQWtnTDlrVVdTQTNC?=
 =?utf-8?B?cVQ3RXg1ZVU3UkQwNktyc0l3bkJVVGhVMHBkUVptTjNvQTF5eFVIVjFrN015?=
 =?utf-8?B?QkhVVXBtQjVCckdrZ0hqYUpxY0xnQ3QyUThERkwyYWRuK1hyQnNlT01HdGY2?=
 =?utf-8?B?YlJ3ODN1NmRGMnRENnNNckFRSmlZNytobUFNMUFYVkZXazZzZWtjKzBaL2xq?=
 =?utf-8?B?VXRHck9SL085b3VhQzJlVFFnNG5ZMEMwQWVLNVlsa3gvMEEvMk40YjVtSnV0?=
 =?utf-8?B?NjIwNitla1BRTVM4ZjVYbW9ERVhMUFhhc0czL0ZSSWg1WUhXTWR1ZEl5MGNG?=
 =?utf-8?B?bmVLeGhIREdkZklOTmQ3eGlycG0rcWltY3RCVXZGMmk5U05DeXo1MHFKaUJP?=
 =?utf-8?B?Z3g2cEFTdm1xVFBIZGVBSExjSW8rVDl3YkFvSjQ0dFo4UXBUNWhEUVBHM21M?=
 =?utf-8?B?cFlkTjNCY1dJQUQxbk9HczJPeWRtZXhmWktNdnBhMkcxRUloTGdocHBOMTh0?=
 =?utf-8?B?ME10bFdUWDFrcXptVFFLbVpmM1AyUU1MMzVRNnlVWHNNS0JQNitIb1ErcHlm?=
 =?utf-8?B?RFkyaWx3all4UDZPNlBCcXZjSG5NOFp5aUM2RnNFR3lWU1ovRTdEYlFyMmlE?=
 =?utf-8?B?d1ZiRW1aTkpya3djOXVQS2RCZUQ5ZHBveE5KejREeW9RcENGNmxsdUpkK2c1?=
 =?utf-8?B?LzFpL21ON2hVVDVqR3NIbUtVQmtTbGtOOC9RM3NHdFhxTHZMVzJHUk42dkZa?=
 =?utf-8?B?S2NjNVdHRTFKbldaTEJ1Zm9iYk1RbUpyTjRjeUl1bC9COUtQUFNJdlhqd3Ur?=
 =?utf-8?B?ZmJ6MDZpVTBWSXJsRzRUN0VJYTJ1V3BOOEZCZTJub21Gck1KMDlYMWtRc0Vq?=
 =?utf-8?B?TEdJdERWN1E4RHdFNmhYZmRkcmRtSEg5a0tUMmlEbENwN3pHRHBtS1Z6bTRj?=
 =?utf-8?B?N0RpU0wxRWN1azdnWlpUK1NmRXJTWTUydVVGZWExL1NCVzRCcGN3QzBUMkYr?=
 =?utf-8?B?YkRkY3NtZjhvbUJvVjRPT2dkMDQ4a05IMVNHS3RQdWlEMTZFbEFxYWpLTlFv?=
 =?utf-8?B?cDNEOU5pNGkvRUJrZXp3djI3UVl5WVAyZmEyTnlXd1ppUVBDMEp0WnNhMkN4?=
 =?utf-8?B?S2FCZENjYlYwV255cURnVDNIMXltdkRiZTcwL2R5cjRwSjNuc0pKTndHQXRB?=
 =?utf-8?B?LzM1SFBOcS80YlI0S3A5VEFJT3pBdEVsTU5TRnl5bitueEVDZVovZWxiTEVo?=
 =?utf-8?Q?fm8rRYHbwmZbYXMlG42a2HnqW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3CYnl0nu9+FtnSJhLfE7Tw1a6wMnrRytUQom5S6+JvZvlYTHIaCuxoLHYWpIKjqsMvu+HPvGWLwi1SEjsi9xP/W2AzrmtMmwxxwdjqQ5dRR5TIsZT5kKcq5MPcEJ7nEWloDr4uIH97xYxe2Pv/EzlIYuF/QrRAmUP8eJz2nYqan10m7osrVwFxi085yRLMRt8HSrj1qAnNP0c4ryCZk2kEFXxjaLA+0FMJhRyI9fzoUXCxEcbCIAx1omMRrHlD19YqTd6AhkRcK5pJMZo4WCBQaXZexG2+Hao56oxj1iYI/v1z6/E8G/IZHYsYw3AxXvAxF0WQMKDD736fUn1GCYzwF7jRM0eutMXSdq+XKRpgptEsQ6WsaDUu4ZKO6uXazzBhfhPrKvXBBisiP8mfqUNKz/m+UNM5hbEY+D+Gzl3i9R1hX6T4HPtQUS9Np3s/EpsJ695Ux5gDdkeKUzI1a2AdJBAAbkN2lyytThhSdxX34G7Xc2wPgxk6WXeDwiztK8YwKXsK6N8m86DgOhX8+1+P+Cx/nkB9ZTu3gdork5MZPsMVmwfJuaqjO7kTYKv7UK4GT73G4lxe4YNKlTvSOnCqFzCwJLpcddNBHSw86H8qPuDjzC5NcT5C9e4nqv5Krc++uACBxN7CWVURoljU/ITI3fcEH01n9IKgdWaJcP4LZKec2fYzBKtFsNGKtLnjDsFsyw/2pdd0zu5OcN1hlKuxIjYCP+zLzlJz2pGeePkd+RymEWNFw4wGP4S0ms6U9YNHuBnXyPrrX2A+vMMKLlHRVVUwoqOx4WwdLN5JqdbdA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc9fa33-09fc-4abf-4e3c-08db882c80ee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 07:48:12.9428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFAjYPCZmJgnuQeiFqkVPeJzoXOv5WoB/PcL4JLsZv4HnOjPwbXcN+JeoekZoQPqoehELLZRPANZ0ZFqlywVdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_04,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190071
X-Proofpoint-ORIG-GUID: 8jIyedoFLiXWQHoO7cINuv4G0p6-ZEb9
X-Proofpoint-GUID: 8jIyedoFLiXWQHoO7cINuv4G0p6-ZEb9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 14/07/2023 02:35, David Sterba wrote:
> On Wed, Jun 28, 2023 at 07:56:07PM +0800, Anand Jain wrote:
>> By default, btrfstune and btrfs check scans all and only the block devices
>> in the system.
>>
>> To scan regular files without mapping them to a loop device, adds the
>> --device option.
>>
>> To indicate not to scan the system for other devices, adds the --noscan
>> option.
>>
>> For example:
>>
>>    The command below will scan both regular files and the devices
>>    provided in the --device option, along with the system block devices.
>>
>>          btrfstune -m --device /tdev/td1,/tdev/td2 /tdev/td3
>>    or
>>          btrfs check --device /tdev/td1 --device /tdev/td2 /tdev/td3
>>
>>    In some cases, if you need to avoid the default system scan for the
>>    block device, you can use the --noscan option.
>>
>>          btrfstune -m --noscan --device /tdev/td1,/tdev/td2 /tdev/td3
>>
>>          btrfs check --noscan --device /tdev/td1,/tdev/td2 /tdev/td3
> 
>  From the examples above I don't understand which devices get scanned or
> not, there are the --device ones and then the agtument. Also for
> examples please use something recognizable like /dev/sdx, /dev/sdy,
> otherwise it looks like it requires some special type of device.

Let me try again..

The --noscan option in btrfstune is designed to disable automatic 
system-wide scanning + detection and assembly of Btrfs devices.
Instead, it utilizes the devices provided in the command line argument,
at the option --device and the last argument.

I used devices like "/tdev/td1," and so on to indicate that it's
not just the block device as an argument but also the regular file
images. Seems like I didn't explain it clearly. I'll try update this.


> I'd expect that --noscan will not scan any device that is part of the
> filesystem that is pointed to by the agrument (/tdev/td3 in this case).

Indeed true, except for the devices specified in the --device option and 
the last argument of the 'btrfstune' command. I propose this approach 
due to the split brain (CHANGING_FSID) scenario, where devices to be 
assembled may have different fsids but matching metadata_uuid, making 
automatic assembly unsafe.


In my upcoming kernel patch, I have a test case that demonstrates bug in 
the kernel's automatic device assembly during the split brain scenarios 
and as below:

------------
Consider two filesystems with two unique fsids.

	267baf3a-d949-4e8d-bb09-79edab766d39 (/dev/loop0 /dev/loop1)
	b698d8f4-cc56-4480-b202-c29882cfa13e (/dev/loop2 /dev/loop3)

The metadata_uuid (271ca08e-ed4c-4c80-8919-fe59533a635b) is the same
for both fsids.

Suppose 267baf3a-d949-4e8d-bb09-79edab766d39 attempts to change its fsid 
using 'btrfstune -m' option, but encounters a write failure on devid 1.

	$ /incomplete-fsid-change/btrfstune -m /dev/loop0
	dbg: Wrote devid 2 skip_write_sb_cnt 0
	dbg: Wrote devid 1 skip_write_sb_cnt 1
	dbg: Wrote devid 2 skip_write_sb_cnt 1
	dbg: SKIP devid 1 skip_write_sb_cnt 2  <-- Last sb write failed


Check if one of the device has CHANGING_FSID set.
Also, note that
  All devices /dev/loop[0-3] have same metadata_uuid.
  /dev/loop[0-1] have different fsids.
  /dev/loop[2-3] have greater generation number.


	$ cat sb
	btrfs inspect dump-super $1 | \
			egrep
	"device|devid|^metadata_uuid|^fsid|^incom|^generation|^flags"



	$ sb /dev/loo0
superblock: bytenr=65536, device=/dev/loop0
flags			0x1000000001   <-- CHANGEING_FSID_V2
fsid			267baf3a-d949-4e8d-bb09-79edab766d39 <--
metadata_uuid		271ca08e-ed4c-4c80-8919-fe59533a635b
generation		13
num_devices		2
incompat_flags		0x761
dev_item.devid		1

	$ sb /dev/loop1
superblock: bytenr=65536, device=/dev/loop1
flags			0x1
fsid			54ba1e89-b754-4a18-b464-0cc5ec47187a <--
metadata_uuid		271ca08e-ed4c-4c80-8919-fe59533a635b
generation		14 <--
num_devices		2
incompat_flags		0x761
dev_item.devid		2

	$ sb /dev/loop2
superblock: bytenr=65536, device=/dev/loop2
flags			0x1
fsid			b698d8f4-cc56-4480-b202-c29882cfa13e
metadata_uuid		271ca08e-ed4c-4c80-8919-fe59533a635b
generation		15 <--
num_devices		2
incompat_flags		0x761
dev_item.devid		1

	$ sb /dev/loop3
superblock: bytenr=65536, device=/dev/loop3
flags			0x1
fsid			b698d8f4-cc56-4480-b202-c29882cfa13e
metadata_uuid		271ca08e-ed4c-4c80-8919-fe59533a635b
generation		15
num_devices		2
incompat_flags		0x761
dev_item.devid		2



Despite /dev/loop0 and /dev/loop3 not belonging to the same fsid, in the
context of recovering from the CHANGING_FSID scenario, kernel can
assemble them together.

$ btrfs dev scan --forget
$ btrfs dev scan /dev/loop3
Scanning for btrfs filesystems on '/dev/loop3'

$ mount /dev/loop0 /btrfs
$ btrfs fi show -m /btrfs
Label: none  uuid: b698d8f4-cc56-4480-b202-c29882cfa13e
	Total devices 2 FS bytes used 144.00KiB
	devid    1 size 300.00MiB used 48.00MiB path /dev/loop0  <--
	devid    2 size 300.00MiB used 40.00MiB path /dev/loop3  <--


[  984.959694] BTRFS error (device loop3): parent transid verify failed 
on 30507008 wanted 15 found 14


In my view, automatic device assembly is unsafe. Devices with the
CHANGING_FSID flag should be treated similar to a filesystem needing
fsck and fix or assemble them back in the userland.
----------------

> If the option --noscan + --device are meant to work together that only
> the given devices are either scanned or not (this is the part I don't
> see clearly),

Only the specified devices are scanned and used for assembling the
volume if their metadata_uuids match and devids line up.

> then I'd suggest to let --noscan take a value of device
> that won't be scanned.

Oh. Do you mean something like, for example:

  (not related to any of the test case):

     btrfstune -m --noscan=/dev/sda --noscan=/dev/sdb  /dev/sdc

I'm okay, but I think we need to rename 'noscan' to something else?

> 
> Eventually there could be a special value --noscan=all to not scan all
> devices.

--noscan and --device options are also present in the
"btrfs inspect dump-tree" sub-command.
I hope its different usage won't confuse the users.

> Also please drop the syntax where the devices are separated by
> ",", one option per device should work for everybody and you can avoid
> parsting the option value.

I kept it the same as in the mount -o device option;
I'm ok dropping support for ','.

Thanks, Anand
