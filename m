Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E36741C76
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 01:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjF1X10 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 19:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjF1X1Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 19:27:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCD719B4
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 16:27:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SKnTUt002712
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 23:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=duOTaz1PDnTNP7I0gfU9GydIRRb+zZpSYlEd2els1kg=;
 b=OW2bgVKFNQIpiOUPptf0Z06CVLSHzV1AHJzuDMfG/IV38rNe6OoDbzbCAgOfpgWj+DQS
 N4dFi4vEzO3nNmEgFw4FN8vqLIPLavl4avXzWsZWcK5Qf4AFZDMopvG6bZKYxzvyEbY+
 bc3DUkxQOEVM1TzpBqcuwuIrzX1JVWFw4Sy3tEWIsGTkvczVUKMU8DXMXoWzT9iY6c8S
 rtc+KQUsPydr3SxFzquQPmSWW1qISbW8SlvcBTlipEgv5qM/CrLUQpADGPymo3MN5Gay
 S/RpLxxRs6Qrzps7ULEFP3KPP/oefBvmePrTiP/u/XvReaQuvFf6/ldKtkyxygZLx/Az bA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq939mgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 23:27:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SMrPu9003967
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 23:27:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxcqqx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 23:27:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2vX8T7N7gr8WjU8Fpqj4iqlUTwlH1/7WDKu/uIZclIxDeACvY3F3qxiYXRJ88DGeIa65DYAiOrAjgmwNvFWio6JrThXyxFmGKzjjZqawXKDEH8OmXE/QLXS+ZlMseezUSw5gT6bzwI9TJjT0YBEshYpf14lgz5ZFZL9mPnWfgxbomkqYBNoL2cYx4fgdhI1TEus4XKbEvAD/1xFL+TdXoaxLzsWtvUsQA6w6q4asxiNGMbBWPGnqB9WWHsclHcUQxBVrsOts6HQpwkTj4QGzPrGURoAs/3fshUKdRDnYbM2tNeOYPgvKLdZ3O0nwkhUuPkWNWng1dzh1cktVAzsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duOTaz1PDnTNP7I0gfU9GydIRRb+zZpSYlEd2els1kg=;
 b=YPKKL0ryIB8i9K/ui21pBRNpByAK4aoGNimhK2PaNBdnY0A26DvXQMSD0/WReRnQg57792kNwkQUI+1Ofx06YRN2kWP/Mr5WJicm1dsB4GOsWVvH+HyzsL7F0yQvSXHu9pNnHXrogqdXjURi8yXl/Lld7gHb5+L+ubQ1gBiG6MM5YpU8Zt09KKde+LVOOy7obTxj4kplnVGtxBbDxMhBrIKiJsHuM3Tq9+DTUPBD8HWduLsi745HpXJRQETdHfFcs6ufqDlbjhcAOJSx/FyN+yGIvrriKH2l/U8tRhpooHHvve7qHF+R5VlxW8plyQu/OHa8NY9/Zxo5ThesfizBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duOTaz1PDnTNP7I0gfU9GydIRRb+zZpSYlEd2els1kg=;
 b=wtlJjPPjQ0R1wI4bQ8XvwrtAlOtCacsjG/R+yKqoaw8AvuVUhsMeeTG4NxiG5Lzr+0fGQ3FkI0f3BiyZu6kEf6OGdGuvPTBNdjqqWa8Cbhr7Fxvw8lKPjhHQVHscmSHpzA/Xwey1ahHsO+S0Z8J/vaXgJYscfVhhkB3uop948fk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4910.namprd10.prod.outlook.com (2603:10b6:5:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 23:27:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 23:27:19 +0000
Message-ID: <40e0c434-c0f2-22b4-42aa-bb2ca643d6b2@oracle.com>
Date:   Thu, 29 Jun 2023 07:27:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/4] btrfs-progs: tune: add --device and --noscan option
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1686484243.git.anand.jain@oracle.com>
In-Reply-To: <cover.1686484243.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b193638-c4fe-43bb-0487-08db782f378a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F98mYHeofSScmB5BryXrR+5i5utQCpVh46f6KRvx3I1MhjtjAspUC00rdUnDznd8JQavP2c9tDUQ8+o6XQGFJ7NWBAKioVZpluBFWM5tVYSYnDGSOPmp/QJf0hHSj+Uomd9OxQuLf9MckHjDNI0Ynuv5cbHy6/nLA5OHBhLbXKfbeGElTcRNvI9t9NGy5BK4pwoZLarPjOEtUeehzkgI/9DYapkjWcNyLQ1EZIc+jjSdy+ueDOM3oPdmOagJFRS3Z4dnmJ0t6rHRlO91VnwLX3GghPy7tx04+qbZnblzQeDMoYitPvU4FK1v525j+zWpgfi0qim4BksnoCHTs33M8c4cKjGCjYUTfwUqAuS6qrdyUPhLGLC8KSiVdDAoUoxi7h9hKZmxX0ZoDmWLi+2pp1xvqtORxNS4Ogw6mfjV9zPhanldxEI1t4NV1RDC6Wt3xIJ8rOHajiD+m2PdoyAyb1zbObrz9zCz9vroEQB/Bu4IUhXpN+yo3dxRKQy5DtuFamOIfU5+R8QnC/Qi8OJYeK1VugxU+ExztLDUDC8UOoKSRks+CorQl1Ed07niW2BtEsTznUEgI7TKcCj7sRDqpYhwymka8QwGm1WO2SvemL23hab7JI+bF9KkAmML0JkPuXyx5oW8Xdzb0eUccQqshg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(316002)(8676002)(66946007)(66476007)(6512007)(6506007)(186003)(53546011)(6916009)(26005)(8936002)(6486002)(2616005)(6666004)(41300700001)(66556008)(44832011)(5660300002)(2906002)(478600001)(38100700002)(31696002)(86362001)(31686004)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkY2ZDZoWFF3K1QwdlBuWnJPM3EwRVhGNUx3ZnFiZlQ3ekJYSEU2bmVvOVRG?=
 =?utf-8?B?OE5oMHNaRUlrUFJLek9VNkxES2VkVVdQcFYzZDZqVzUzdTJ5N1BYbWc5SXhF?=
 =?utf-8?B?Nmt3YitES1l6TklmVTdSeG4rVlBqL2FmaGxVTmU5S2VrdndsUXFQVmQ3eGln?=
 =?utf-8?B?RnNIQUhuUU1lYzQ5UGg5V2lJb1FCUjNYNitRNXkyTkE0QzNVOTg0RGMxZnFv?=
 =?utf-8?B?T09UUlUzeDBIQlRxWWp0dHZraXFnUSt6L2xpRjJUK3FadFBYdnd2NFRRL0xC?=
 =?utf-8?B?cHJkZVQ5SDIyL0lvTGZsOXNoWERKQTNJM0NsaEpUZWZTNElZYnZmTzdwVGFU?=
 =?utf-8?B?c3Z1bWR2eXYxRXExdWpXRXg1NGpZN1Q5eW9lQURhMTlSb20xQTZQVVlzRWN6?=
 =?utf-8?B?bjRraUpld1Y2NmtDUm53d04yQWxQb1JMbzJEK3FGc0hORDQzZlF4OHdYY3ZE?=
 =?utf-8?B?UVpYSEtNbHpBQkdkOGJ0cXlubmEyVnd0THV3SnFRKzB5Sk5qdk5TcTcwN1hD?=
 =?utf-8?B?MmNUTXZRWFI2VlUzK1RXbytIL3lXM2U0dGUyaUZXb05Fc2EvSEkyT2J6OTZI?=
 =?utf-8?B?bytuVDNrcDBEVFJBVmthcm8wdlIwVVBvS1g0MWE3cWd6WWtjclhCSnhDU3pr?=
 =?utf-8?B?cmJlUWNLUWUrL3NvKy96RGxraG5sTzRkQUlDWGNZTUU1dVZTZU5rM1BYVjVq?=
 =?utf-8?B?OXFHdXBnT3MzWGFsRUgwUkpicWtlTnZOejRycERFRmNPbnhTbGJ5QjNJV2Jo?=
 =?utf-8?B?K09tcVlhNnlOaWFHakJWZFd3RDZkdFlkMFdTbEgyZWRLd3g1aDBKbkwrazRC?=
 =?utf-8?B?QkZwZFFPVFVka1VOQ0tkMlJvRXgxcktkUkdSenZNRUNUZlJQK25RZHBwSTB1?=
 =?utf-8?B?eXp2eE9JTitkUXprSTNGdHNNMGRuWEpvaUUrSlBWVmROclFwdE5nQzNxeFMr?=
 =?utf-8?B?M1lnM3ZHMnRnWkx4YTJSYUI0aEJuYTgvcnU3SlNzb0NPeUF3NWI1RUhta0pC?=
 =?utf-8?B?WndxWEMyUzNzYzdvdE5wMktaWXNzVnZEaDNWLzFxNTN0eVZmMFhpM2h5Zk8x?=
 =?utf-8?B?eTRIT1JDTitpWHEza1VGRVJQQ0RzN1NjY2dsY3B1eWk1WElvK2c2eEdBdHBa?=
 =?utf-8?B?ODBjVC81TUs5eTV0ejVRbzF1aGY0SkZ3dVJLS0M3eFJCUHRzTFhCSGQ4Yk42?=
 =?utf-8?B?N0ZBeUNQazdSbUlIY0lBQTlkT1I0YUN4YWtlRnhUbE1FRnBCRWVrNEw2Yzgw?=
 =?utf-8?B?aDczd3EvUmpOSGVTT0VIdnB5NllVVTYreCtLbTcvU2VLNURGd2xCdml5Vy9G?=
 =?utf-8?B?emFGdE54UHp1TkZIZVU1amhpUzZiZjl3QXRTcnlWZUlXdmo0NXFoMjRsVG1q?=
 =?utf-8?B?VXBGalZjWFFQcmI0d25wMlhrTGozSGdjeHNxdGhhYmo4OFZjVkx1azJtbU1L?=
 =?utf-8?B?WHhtWkRZbzFqSEN2c2ViZUo0ZlFzZ21JM05NVStwdXZYVVNMYmZEN0lYNWF6?=
 =?utf-8?B?OWsyTHdkM2U4NHhmc2d0VG9wc3dMblBXSUxsa25OdVFleEFVN1hBZFNFYWdZ?=
 =?utf-8?B?cit6M2RjZXZmVlRuZnJSdGROT0dGT1FLNW9LNHNTRldBYjhBMkNmSWZxR1Fk?=
 =?utf-8?B?WHFtb09TdkNFWUhaN1lHRWYxOW82dUl6RGY1bkk2QnJ4WE9kUHcrdnUwbzV2?=
 =?utf-8?B?d0ZyWHZDQTdqTGV6MFluU2VRSksxT2sxbllPeW5wZUkvRmpIQXNKb3FFaitp?=
 =?utf-8?B?NW91anNNbWU2dHRhRE5lTGwyTzBCS0ZMNnRQTHlMR1hsdjBXQTJINXdzQ1RF?=
 =?utf-8?B?cWtGeWZveWNGNk9SaXIzcGJ3U2duQ1NjZno5NUVOM1NraXJGNzkzK2VoTGJK?=
 =?utf-8?B?OFE1S1VVTERQZ2preDhpYkpDN0RmaDRHNGRwMVYxaWplWjdCMlVjUUpNSjdP?=
 =?utf-8?B?NnZ2WUhCVnJhd3lBUk5lZ0t2TjF6a2tNMy9JYzN0VnlwTXVkUXVRL1ZOMTZU?=
 =?utf-8?B?emxrb3ZxcFQwZW5OYmVHbUYvNU1vRVdwNFRXOWdValltc1dlK0RIRjFnNmh5?=
 =?utf-8?B?YVZDWGRrRCtWcFZvVERYdkRybmF6NGxFZ0x6YUw4NW9OUW5MazdtYzh6RTh0?=
 =?utf-8?B?aTJJRFpMam1lZlVYQzhJejE2Tmt1eGdTL3p6NlhEWk9wMUg2bEFoeWNmUFg5?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B130Zy/Y9FPYd3euPy/v4+c/4iY5PlTjfEHRqUdM8gAexYob7e2JlZvlve9N4euUFaTobI/Th5XkU2qxZvrnUxMS793En+PewrldG58GyJfSzaZ6VsqQcTN0Iin98Syt8FmZ/rRfvQMTD2Thzgno4QkPBZBgSSOMr03zf+LR376Z43GJ9FlpBUx8v/wUbs7duQ3PjJWgTUsLicIX+pyiFAQAkj1jmsUKeT+9cIzWt0vfe0/DvKxkl7CHnJLsU4neV2SaH5V6obrg5ufu9tNHPMA5WneEiCay9g7I56NUKmVa8l3VexOys+MzQXhIs3d2n2lcKGsSrQhxZC/lXftK9jl3oEYNCIcarLVd1yf0bbHozyVarxXTlIScjB/tTkof56oQbn5SiwzK6rIBEkoXZghz9mcat0c1J184taOQ5wIrvq1ca58YQuzVVDXclBMPZAW23z29j1Rzl/VN4TkB/ZV14m4VBLD/lKiR6HeoF4LxThIc4OD1btcWA5MeFCLRXp9ruQJuMd3kKdVgkmZsfgDZZAMAXyqXEk0fWoQ1AIDCvq37cL7mANjSZWCz68IQfZWx6Ttap4UiRTkEXGhMQdePYxE6xbUkVLWR0OeVPuxsnkyyzQC5y30DbMRCyLLTEhxsnvvZfCToR3EiGggLqwFd6XR5kktctnZAHUZwQAnoeCKDuWucRjtdkuAiuP+DunifyBMi7vRBcbzzOJst46dSNs7lB5MBqNVVFs/wPM9dJOBiFlX5oCMyYSTzI3B8ld5WCEiRERxRZ1V62ZnZaQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b193638-c4fe-43bb-0487-08db782f378a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 23:27:19.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4jxXPF/eVFj7cVxK20YRfLUbdArycY+96fXjOGSPWMUpQaQ3OFOlw5wUxLYwhwxnOO0zpL4Rut4fLSAvbQoNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=883 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280208
X-Proofpoint-ORIG-GUID: AtJGMPX8GxblUSIgXNp1V4nMfCUxmGpE
X-Proofpoint-GUID: AtJGMPX8GxblUSIgXNp1V4nMfCUxmGpE
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Please ignore this patch bundle and instead use the new patch bundle.

      [PATCH 00/10] btrfs-progs: check and tune: add device and noscan 
options

Thanks.

On 13/6/23 18:47, Anand Jain wrote:
> Separated out from the preparatory patch set. Depends on the preparatory
> patch set: ("btrfs-progs: cleanup and preparatory around device scan").
> This set (along with its preparatory patch) has passed the btrfs-progs
> test suite.
> 
> By default, btrfstune scans all the block devices in the system.
> 
> To scan regular files without mapping them to a loop device, add the
> --device option.
> 
> The option arguments follow the same pattern as in the "mkfs.btrfs -O"
> option.
> 
> To indicate not to scan the system for other devices, add the --noscan
> option.
> 
> For example:
> 
>    The command below will scan both regular files and the devices
>    provided in the --device option, along with the system block devices.
> 
> 	btrfstune -m --device /tdev/td1,/tdev/td2 /tdev/td3
>    or
> 	btrfstune -m --device /tdev/td1 --device /tdev/td2 /tdev/td3
> 
>    In some cases, if you need to avoid the default system scan for the
>    block device, you can use the --noscan option.
> 
> 	btrfstune -m --noscan --device /tdev/td1,/tdev/td2 /tdev/td3
> 
> Anand Jain (5):
>    btrfs-progs: tune: consolidate return goto free-out
>    btrfs-progs: tune: introduce --device option
>    btrfs-progs: docs: update btrfstune --device option
>    btrfs-progs: tune: introduce --noscan option
>    btrfs-progs: docs: update btrfstune --noscan option
> 
>   Documentation/btrfstune.rst |   7 +++
>   tune/main.c                 | 103 ++++++++++++++++++++++++++++++------
>   2 files changed, 95 insertions(+), 15 deletions(-)
> 
