Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C0774AAD2
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 07:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGGF6g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 01:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGGF6e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 01:58:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3A71FC6
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 22:58:33 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3675Blbu023277
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 05:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5M8WpxIBodUXSmzhZLFmhxei8k8knPLwOTaeu5y+78g=;
 b=2BwuEtFRyOyt3KplJdav6m2AR8r7XPRq2yXV8k9Kpstc763j+xWq1jhAchhl+0gfD8ed
 weddT6KdisRRGFFWQg18gtwoznW7ENeXLjUsmh7MSPApXyNzV6Nl45FyeFoRBXKSYnpP
 FflL1yHg6/WE9Jw88Pno3e3jSDMgUTnxnk48L8g8Jw2g8y8J0b1aCtFt1z5Bnl/0IdcW
 0Lumf4kgMn5m2kiBrymDvYIVXN4vIvQZZOks4mSqlZHk8jAFAABOxE+wTmGfWMkVHTE1
 BrFGlChrSXf1GLPsMKUViN5n8LIBF55Lpic7NJHjisz66q5jVIM7R5i3dhIart0El6o/ 1g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6ctc99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 05:58:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3675M2PJ010481
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 05:58:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak809qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 05:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEaWamgx3OtUQv44h3IV+2yXTon3XQZpUFTSIDKEwrrE+n5wtm+j6Rsi49lTv7eawGqMFa0X4QPrleXr1Hh/53xVLzEedJyKz/UW1OKvo+a03y1fFl/a75jfomhrcNBapPJoD8R4DbhNuykr4kZ8FBCT8eI0K3rdiGTyM1Vkwub+xYC6eo7FRip1rVn+zAwHYUuPqgqZbTNmtCaiFGDS2gzhOBDSBfGD7etyNMN99FlWkYqs6+m5AfsuJHmNpJwkG8HgBjrHaKVMjE4iiAOVayzsi0+pFnaRShVlcec1xwg0kDav1Lnln2QUNau0vVY0osNedUl0kDLwoa4bpAUzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5M8WpxIBodUXSmzhZLFmhxei8k8knPLwOTaeu5y+78g=;
 b=RXDP62kzGdgknMRpVRNPy7EVQp2ujgoDcB73+jd6Ibcef8zSSjew2N1Vja03aSohC5MoHxU53Ss9P3LTUoE86YtyBU6BkG6h9WTexKZPMGBKRxKD9u7j4X99AOw2ISRwpw4Q1tmixhirLPOH6I+LTW62ESJoo2yzUyspg8TM0mZgDXzhUHdx9HwZ3BSt5xfUGAK9dWVK5AtZb0jfqB/K8LpIMNwEuA2UPTcBw/sFsSKTlxVWmsfLROimXzYM+vXG9a3pq0o65e2EIKhBd3L3zbIRFACQr6GTvRtTtVMgr8Mdl2wGQkj6V56IBwJw3cHOquWEWpYtcrpthcWXzucQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5M8WpxIBodUXSmzhZLFmhxei8k8knPLwOTaeu5y+78g=;
 b=Xv81eXiKnh5Gpug17dskDe/X7F7BpprnLQ2mbKdu1gZ6ch55cdg5JIJFrO4vuYCFz+TFlWOXPF9EY37jEAaLcKyxcunlMvV2xQnsb88Eqn8i2sVfMGJvXfUXCJhryGRuSnt9R/yOeQ+lOdVAfXB3DYOSTSoxuPPhDzfV9l4dd8M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB7411.namprd10.prod.outlook.com (2603:10b6:610:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 05:58:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 05:58:27 +0000
Message-ID: <7013c126-9642-256f-7434-6cc6da788bf5@oracle.com>
Date:   Fri, 7 Jul 2023 13:58:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs-progs: fix duplicate missing device
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <4c5c6c8543aeae91544f8a64bda35a76e6615d7c.1688362709.git.anand.jain@oracle.com>
Content-Language: en-US
In-Reply-To: <4c5c6c8543aeae91544f8a64bda35a76e6615d7c.1688362709.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f1eb23-b4d3-4a4b-3a83-08db7eaf2e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6f4HzBdTRTiSNesaWxkZZ2uOVWZi51evnZTqoQPskI/l1WpjJ8DZb9jtJ+wxRdS61HGCFnQW6fvUSvMu0O5aG8iDuQQT3BakrCyst8tAKGpIRfuQxGPzJPKtc1FlsasNpW/TVR+hTVJr08uJgeMnT2BCP51KFwhwbly726oW9OMZtkTU/+98y3hNu6By4pgRmc+YvQ/kxhA8WFmRhHApc1co3BYyMYvIEIyKW9r6F9te/OiWzgrTjXuGRIsDFRcdFQvcuQJnVD4mSe4aevlSm0UmnT32vOTn/424pjEXEVgFCAgm/m18g4obUa4npW3AJVMQgNtL8o+l9pWhHyJKXFNOq9RgX5K32HqJQzFG/cHBAj59muOncXAzZiqavlwxnFTmpeldAf9TkjH3A3a9Pklu0saJcZ1DYVtZWQWm0tJdaafzwvuB38QOd4htZy1jiapfmJYGzK6h06UVsZQznk4wgL6zWqmpi3ShsaLdm1dcsUi/HuJVw88PIDPEQzJ+fk9GexyP/E8jXbaxMvIy8QggvHtQKXuUnMmsTbOmIHMSu4OjJJpLdqsitvFr7BoVeFH8P+lS4YID44JTMAT26N3u//oOtWZiOch4fqRfwDqVttA0+3zL94VKhINVVdnNRVENJjxIdeENjEknWTNhGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(31686004)(6666004)(6486002)(478600001)(2616005)(36756003)(86362001)(31696002)(558084003)(2906002)(26005)(6506007)(6512007)(186003)(38100700002)(6916009)(66946007)(316002)(41300700001)(66556008)(66476007)(8676002)(8936002)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW5SUlhNY0VZMjlRWFJrN2p4eDNoaUVDRVBreUhiMG1ZbzdCZmo5QjV0OTMv?=
 =?utf-8?B?RjBRNGJsaU1PUzg5TWNETkRTbmkzTlVsa0hwTncxQy90WlZHdXQreENPMmZq?=
 =?utf-8?B?VVdXQlpCY2FWbUNER0hzNXhtYzVNS3BCak1sbzVUc1NyOTRqeThzYTVxYzhR?=
 =?utf-8?B?VDk3bmk3Z2RWeFZrRFQ4VWZPQkxUMElRbzhBWVFDYXd1cFZPcngvSzVXQnBo?=
 =?utf-8?B?Zk11VldzOHZmbHdqclhHRGh1eXRZd3QrZk0xazFiSGRxb2ZIRHVodkh4bFB4?=
 =?utf-8?B?NTEyQXVEbDdhVWQ1dW5SakJQdFltSGRlRlY2aG9jMm9aWlhKOGVweFNoOXBN?=
 =?utf-8?B?V2dTWlNVNmVFbEE3S2gwL2ZFZk9mWXBrazcyc2tNUjVOTjlyZ2R5eXI0SFFy?=
 =?utf-8?B?WGZ3MHdaaFNHMGtMOSttVjMydU13c1NadFlWYVU0YnltYmhXbDFHN0x1aWE2?=
 =?utf-8?B?b0NkcEQxYnlNcDR2R2VmV3ZYLzVSVnpiRmN6eVBCZ3FLdUFrb3pYb1FCbE1k?=
 =?utf-8?B?dVM3dDhTbDFZeGZCQm5PaTJ5VjRTUDJUNmk3R1dtNVhSbVl3bjhqT0E2SFhC?=
 =?utf-8?B?SUd4c25lcHBXZHIrRXpYWjhLY1BnVXdZbGtuL3BpaFRQM0h3MEkrSTljczFP?=
 =?utf-8?B?NUR6SzdSM29kamU1VHIwYlZMNjVTVmp5T0dXWVh2azhWYUFGVnNadWlxTk9l?=
 =?utf-8?B?a0xnSHcrazBVVS9YWVIzVGhVSmNuL1BVeFpCbldiSmMzYmExcllZMm9VZ3lj?=
 =?utf-8?B?U092VzlVNENtOXpseUcyTnRTUjhZaWxXd1VnZlQyaTVJMHFhbUZLUHR6cU53?=
 =?utf-8?B?RFNyUkhaM3RLU3BwM0diWUQ0bzVZNXVvcHAyNFRWa1M4elZzdE5BZitRYkI5?=
 =?utf-8?B?TUlLU2tKbmNiZTcxd2ZSQ29McjEvZWtaZEl2MHMzblBjdzRRY1N0QXh4YlJP?=
 =?utf-8?B?QXh5Z1duaVBaSjBjVS81WlorOGZoMEhZenZwcTI2Zng0YXpsZ29RRmJPR29L?=
 =?utf-8?B?MFUxTkc2c3lROUdwWjUzZnRiWjVBS3R0Q2ozZUNMN3ZyWExPb0dJZWgrR1RB?=
 =?utf-8?B?SHlhcmFKTzBKdkdnbFdPN2R0OHFtRHFNWWw2TnoxNzZBa21vMHpocFpKdzl6?=
 =?utf-8?B?NUh4SllnZkM1Zlk1UUwwRExtaEw2OE14NEd2aWtsVURVeGVWR2dFOFpXZ3Jn?=
 =?utf-8?B?NHRFOWFQQm0rTmZpY1d4UU05NEtVOGlrRE5RZUhGYmh0NHZHTFpyc011K0Fu?=
 =?utf-8?B?VS8weHh5Tk0xc2FYeWs5bDFEU1pnSEZJQ2pEelZ5RzJSN0x2Sk9Xamp6NlY0?=
 =?utf-8?B?MFcwcXFLMmtTVG1yZWZPTStMN1hHSlhKWTJIZE9rRzFxMjBWamV4K280d0RJ?=
 =?utf-8?B?clZLTHkxWXVicWUyanFFZEJYallEenREUVMzM2ZyaWYvbDFzaHRXdkZDZnBQ?=
 =?utf-8?B?MTRVQmlXNnFoazcxWnJUdGdocDVDeXVQZkFHYmR2TldPdVQwZGFrZUh4UmtZ?=
 =?utf-8?B?WmhkSm9EdE1xOVdwd25uY3I1L3gwVEJJZWw5R0NKTDdrVFpsVFZ3cFhuZUZk?=
 =?utf-8?B?WHFtb29ZZURPVXdYRlVJNVFSdFdOOTl3VDk2TmIzMU9YK3o5RGJ6Nm5UZjQr?=
 =?utf-8?B?ZHcvYnppWE9GVmtucSt0UUIrZXg2S1lGclZ2K1JCMmJhTFpvaFZLcDZ5QVkv?=
 =?utf-8?B?aHBnUlZDQjh1YThPY1dkTzBCeitIK3ZUQlNXb2pLRlJzK09uaDRQaXhNNExB?=
 =?utf-8?B?bFE3WEdjRithV2phVDhBcW9aNXluMEY2WW9uTWQwSzJPNUdlenNoU1pCNEpn?=
 =?utf-8?B?YnovQzlaQ0l3Z2x3Mk1MdmhUSHE5Nzh1TFdUT2FHazY1OG44aXFsdnV2T1FI?=
 =?utf-8?B?TWQ1YVVkR0RsTmd1NEZVeGtNUE9ueXd3d29FRVVQWVZsWVRBMmNqNldyRExK?=
 =?utf-8?B?ZEU3OHNLaEthWGp6WVViQTNyMFlNKzd3blhYRmU3Y3MzcWNQakRNLzFKMHdi?=
 =?utf-8?B?MHFUYnJIUHlHVkNIb0YzTktlRkZlYk13SEFJL01tK0JlQytYN0ZtWFRIbHFi?=
 =?utf-8?B?Z2lUNFdocGRldnBaWFpwTXZ2cDBBRWVRa2lHV3A4N3RQVjA5T1BWemxKcTFF?=
 =?utf-8?Q?Lon22vZkmDKWIOi4U3197Xrq2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MAyV/I6qyjuUXvxVvwUdltp0iJiRG8qH/EKqm8H7Cp/rdDxCZfdrQeQRZxytKGybTbpUSk2c4qHujy1S7oDNOqa7hj/5bknjGtGZiOYjKN8up8BgknlWocf9J+JG/6vUp9jfGTD0We5v5WalIutZHgFKf9++Ia+8uDTPX29G4yCl9pXsRkx4qjyLnPTC6LfgufXftdcFBoxL6a+XitN5BY3Tg7iFU3yE2OajnhEAGgt8UzqvrNFvT0jWHtr7h27b0192rAbkx/U84xyhOD+Fyz1sWblrxOwXWVlleWbkb4esu/i2lhHzuupqhxgV9bV57JbbMpepvkuRnqT1e/kfJiVYPyYm07IQOZpFjhZZVAcBQT01o7W62eMyraMCmT6HZu5GOOIZw0KSBiFoS8JkIbECTp5KxrgjhLD115NifdvCR1u21ubZ47nvM5jDIOf/1c7Xijo6jQzYW9cgykXwn3imIjOZOoz70ND/AolCpLUvFcvE/r4i0qILFnGdf9Env4eimNtI4tDnTzJpPkRbA53f0IugnE3TswGcYILMjcJL7d9/zgR96ruEyeHCx+DAeMGTdXIW5cgRFyfIYlvEi5I/bxTy0vTnG4R31ls4CwAewcK4jkVUiC7rFUplhmkYveNJdxqspqKsV3NMJScZjHTudtDoEvSSCtD+bruJta27qeIJbQJNC92L7LxlU8PTsUuvzpuSGzFgXbLbEUeSoYKxaYOc7MP97SwuqugcYQXNFGUm+0qHxC5RO6ZJeCAJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f1eb23-b4d3-4a4b-3a83-08db7eaf2e9e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 05:58:27.3468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnGzN8ZH8QlhE0YdF4KbV3H2I7QFgEJTA4lVvRPeNr71F++xzYpLeyyRxs3wUGgCG6kB4WySPDPPwRqYfUJWJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_03,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=879 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070055
X-Proofpoint-GUID: Sn_oUlO54XmyUPIxarb-9RNLCiBubagA
X-Proofpoint-ORIG-GUID: Sn_oUlO54XmyUPIxarb-9RNLCiBubagA
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Please ignore this patch, as it has been added to an upcoming
patch set that fixes the incomplete fsid change.

Thanks, Anand
