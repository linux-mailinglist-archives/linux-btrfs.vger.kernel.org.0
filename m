Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D987655B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 16:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjG0OPx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 10:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjG0OPw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 10:15:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2203830D7
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 07:15:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RDcceV006111
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 14:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Q6tDRDmG3tgwk1TzVzGqPE44d5VBbaZ6L4rnCWJ2loU=;
 b=gstxRJO+MBNaj1FNGdUTzIgjQ/wMFk0pzzxc9T8TwOg0nkgimB2oI7N/+1MMP2gFhld3
 TgXm1cBAIbA0ny4yCIuGn1NOOtmahZsqA7OahzvvelkWN9Lmmrkrw7lDk34p9z8bbRUz
 OrI/nE+T3NjJL4q7CEDsWPm6oqH1cFvFO9+NZFnnNyUEBbZGP1XARUdRzKfYF9HJ6I5s
 bHa8tDH1HXlqzHZCKRHu+WkEYlczkcgQzc2q7lC7H6ebG1tOqyaIoTOCFzeJZOWlqqOH
 7KhW2INA38upbCX1grjUUiRxNK7Q34tzEkVEGXUAbNoXrq+SwkqUfTV7tJeljP+9wlCb 9w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nusrr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 14:15:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36RDMoLA029491
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 14:15:49 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j7q5p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 14:15:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c153f/9bN0+XRHUDHz2nKDPjr5BDW4Zwwt9SYZJ9zUXb1tiQMlPFZJ7OJTR+o6pHRO1l+40zDAB88IIbxE8cOXLUb1PG4d814gLwelMsgZJAKMbnViBc0heos/YDNora3k3s6YE1dlFLlbXtLvFEb8Bc+BTamr7ZH7/iSp5cZRMquplJJhXoeXB+eqfAa1Xkpwr1lNZ2/iZe9C5EHg+oJklZdaNgnfjGwR0Fh2000/LbhLppnJ5fryywX7KPHXd8v+BP1StpFjVblnhHbZiYiztlr5WAU3LJyc5C6LAun7ClRfPzxIhnOcbrigwFLZEx6sDeKvLk8HFR0Px5uoBEMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6tDRDmG3tgwk1TzVzGqPE44d5VBbaZ6L4rnCWJ2loU=;
 b=oTyxLfAW2gjxhDskr+FyvIzpflDt2wuEO3NRoHcI4LQ0B4a1YKcJTMbO+yX0YqgOWgXJ5LuZhPldmcnKIRXRMUizWB9sFhEYkajv/MI0Iec9TpinRQNTQoFAtuGFhjabIISa6/Fb2vnCGrq57hEse32kf9HLbp3YsOC6RLbRvuICvYOrO33ailo+/DponSUJc5GyZ8+jJg8Xm+JMdUC1jsMyNXrBu5ze9tmn3ZTY6Po85WkBnuo+kqV1/VhMjeXqKs1AuAZhWzwHmJlHQp5ZcCX/vWJERQv/mdmoUlP42kAPmDuVUFviispD79sd4UyOr1K4YqZ/84V9S7T11zlDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6tDRDmG3tgwk1TzVzGqPE44d5VBbaZ6L4rnCWJ2loU=;
 b=ijDQzQQZsXYuHv/tBkRnSyn2sJcYSM3TEQ7EWh3RTHHs8Y7/9Blu3v3L0VgaoOC0rpLDhfP4lrt7PhJbcjIMMzX87FdHn/bs4nu2Cq+mrMekVcQyG8J1eLK6TWhghyUthR4PWetTY32WWYK+yhCqSQ9kYko3xEplv1Y22iXjcGM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6235.namprd10.prod.outlook.com (2603:10b6:208:38e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 14:15:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 14:15:47 +0000
Message-ID: <e41a8748-bcf0-f0dd-0f06-d8ee9c261cd1@oracle.com>
Date:   Thu, 27 Jul 2023 22:15:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs-progs: register device after successfully changing
 the fsid
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <4b7b4c651700247046a32fce3148e510877ccdc6.1690448585.git.anand.jain@oracle.com>
In-Reply-To: <4b7b4c651700247046a32fce3148e510877ccdc6.1690448585.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: adf00acd-ac53-47a7-6bd9-08db8eabf8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mc2pAhD2YoNE8nmjQn8hSlv46rw2B2rK+6cjck5LWjtdNkEMbNeUazkevE9aMoEgKXnViQr4iYkSLiaFN1lqkI94+7+VgoT8PShpvDWZ8bIOGVOOHdCU4YfslZtVj3pE6ngxMuyHoB2+Y1isZeavX6b69JoD+6Dvbm0X81gPTk2KFjhIz70hO76rfZENh4bIrcguEm7NtF+rPLbjJnY3rgd74Qy+erQ6TpbrbBU8G7DIYDTZjyw7U/VUf7hICEyIODEiYsuA3o9fkI1BqtgsOwDsQl3MWk2qeLuEOSMonoMl/LutFJ2/6isQmZVK83V3KRCpSfpaVhRBaG7dCrYHU/xmag6P+GuXdByF40dkeyeUw6Hwm12S+yqFeS3L7uhoxOzv4v7kmV9LZGQzHVr23ZeoaUSyN94x+YrarP31/7QECXJpAEyqTpDsXSRLCu0W5Dxu3innqhZr3JlrV2ASNy0GdOtSZ8WYbapaXQqZKX5gPuj7VNG42Qi8Y7U/iZPb252KGs4mEviLeKPUDwBEWAZb/57aXkGUy0+tjUNIRQKzxFf1nvd18En/veYspYJAGPmpVj8518DPmLaUfitKRmIS+SNjBu8u/hEEJSx/08afqgq8ppelfNO0/KG7R1TGRxc+jxDpoY7+4E1Tzc5vNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(86362001)(36756003)(31696002)(31686004)(2906002)(478600001)(38100700002)(186003)(2616005)(26005)(53546011)(6506007)(44832011)(41300700001)(5660300002)(6666004)(6512007)(6486002)(316002)(66946007)(8676002)(66556008)(6916009)(83380400001)(66476007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTUvY3ZkNnZFS1doVjRiVjN3cFdxWXpOOFFRMmcvSzRkenBFTDh6VEpQK3Vq?=
 =?utf-8?B?RW90d3BiRlhlUjFzV1RJWnZpbjhBQkdHSkIvcFJWeUJWdytlWFNheFNUME82?=
 =?utf-8?B?by9yMEpHb3ZvZmRyTW8xOTljSWorTE4xcG00QjU1UnRIR1VrbkVpWWN0VkY1?=
 =?utf-8?B?Zkp4NDZXTDk4NktDTnhYVEViQ1AycGlKd0kxOVNYL2xiSjJURzhhZVp2MkI3?=
 =?utf-8?B?M3NIV1R6aVFZQVVadVBLWm1uaWRrTDFtZGVHVU9Rd28zdjFqM3ZLbFl1THFF?=
 =?utf-8?B?MDl4M0Y1dEZuc2JBd2hjaXZKczN0Y1VLL1k1NW9TYVRRZGJBTG8xdEJMaUZ1?=
 =?utf-8?B?dHVaLzdSSGRxemlXNWRFZTdQdmhWc1Yxc1NDdm5uaGFmUGVCSnNNTU1KMHlS?=
 =?utf-8?B?SENkNnd0SDhjRTRiN2o3QmJjK3V4OFd2Q1RqVGV1U0NsZUloclRvZmxaZWtF?=
 =?utf-8?B?cHRlNER5NFV4MnFjWnFGc0VjUFpDNmo2V2JnbzV3ZDhDamJya3NvTm5yL0dL?=
 =?utf-8?B?Uyt5V1QzWW9ra2ZXRHd2ZFFRSE9ONkhhSkwrYkRSTmttN0RYeG5vbmRHai9h?=
 =?utf-8?B?ZkVwd3llU1BzK2l1Q1pxNGRERjMzV3EvaXRBWDhOSVZlRTRIL1FMYXZ6Wmth?=
 =?utf-8?B?aXZiRlA4VStrT1lHK29JZFV3bUFkalFmb1l0VzJSSm1yQzZjRTlWdDgxUXIz?=
 =?utf-8?B?MENjVzIzSUsyeHZMME8vaDcvTVJpak1ZYjkyNVB6aDZ0WVlrb1E2enpROE5i?=
 =?utf-8?B?MUtiZlAwTm1KaS94VnJORmdBSmxiR0F1YkdxaDdtNXg0Nnl4SkU3ZjNWVFAw?=
 =?utf-8?B?L3RnQmRPYm9aZDZoWUc3Rnc3V3lvZDI5WXBuNXFLaFA5UmdPQ080MVR5dXRG?=
 =?utf-8?B?SGhEWE10c2dxTnVxODNkMitKSTVxeVpueVUxVEUvMElhSHZTenZZMGN0NmNn?=
 =?utf-8?B?cE8wWEtmaXd0RCtpcGdGM1ZJN1U3UE5MVFZHbGVDQ1VjdU12a0RmMFZITEtQ?=
 =?utf-8?B?clhlS1hRTW5XY3ZIcVdKa0xJZnlDQnJsRVhTU3BReENLeWJuSThORitxQXFH?=
 =?utf-8?B?V1piNXZVN3hQNDBnLytaRjNhYTFOd05rbE53UmZjU0NzYTdWVHE3TGhlcDZN?=
 =?utf-8?B?NCtOTGtSaWx2ZEpPWmU3OEFJbjVPUncwUFZ2UkF5T0VaNVRYaHExT1E2Nlg3?=
 =?utf-8?B?Vi9ETExyNjBTdVRsYlFMR2dkaU9RUXdHcnA3MlZ5R2VPd2NtVWlwYnB6WGRq?=
 =?utf-8?B?KzJ5cEpwZUJ3M2RxMTZuVEV5MVFVOGhCbHFoKzNyTVFaSTdQVGJSZjU1cTh4?=
 =?utf-8?B?Y3I5WkplN3hPMG83Ym8vR3cvdWNjWTgwRVZUUzBMbE4wOUduNjFHb3REYVhn?=
 =?utf-8?B?NGovYnU5Yi9URDdJV25kZWw2U2wrRXNwMS8vV2szamJSdmxObTl6SDJJVXd0?=
 =?utf-8?B?M0N4QnFycC9JWk9PWEQ3MVEwNDZqblpUZVBlYzZMYmNKWVZpU1ZGWi9DYk9Z?=
 =?utf-8?B?Z1ZsYnZVc3ZOUFVITVExTG5CUm5DamJhZ3FDbW4rUlFDZTJJczhkN0NyaTNa?=
 =?utf-8?B?RmJjSWlXdzQxaWowdDNNckpoMEZyT1V1SWt0aEx0WmZXbHdNcTdEQXpwVWJW?=
 =?utf-8?B?UG1iSlByVzY4a3RGTXpxWThrMzY3aTV5bVJRZVgxWjR0Zytib3d5d3VhTDRN?=
 =?utf-8?B?Q1liUkRRemUxYVVlM3lQbGpscVNPZWxCOWFGOEhpWEgvZklZeWR3aW1JNGVN?=
 =?utf-8?B?cTc2N25QTEhUd0dWbDBVMEpIZnI2c1pjT3UyeFArUEN1NExocW9PbUVOY0NK?=
 =?utf-8?B?RVBob3piK084OTFXQ3FlY1BoL3NQQWpwcFlDclVvVEI2cDJxc1VuTjlFL0Qz?=
 =?utf-8?B?K3lwcUlGemNkQjFmenBYYkxSRnFTN3k2QkxCaHVQZHZIVmgwUzVHaUM0bHVD?=
 =?utf-8?B?VGpZN0l2WWIzY2NXYnd3TWtNOXdpeGorZTBIZnNPZTZHZFNnWEszazFjV00y?=
 =?utf-8?B?aUh5cktKclRXTUhDcmQ0VDR0RVd2MmxZSENCeEh1b2drbDF0VEV1YmZaMVpI?=
 =?utf-8?B?bWw1dWp3QzZ1dXdqN3lwanZJSHVwbUxDNTNoSUExU3JZNUxMakZpaXZGNTdR?=
 =?utf-8?Q?YVYBp5ZqI82chrzeuWZ3g8ElJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m/6WnWWoMaJSFm4yOEVmoFEzT5yjA9PNKaNfbqwkEWsjvniitrZor9P8WMGyBm5SJWHPRGrG4IfqRtyMWBb9OjmOnyF2E+ig2gvp7EkdHI0FACqUOJhOhao6nZ5+pk8MdYIu7MUVdnbEA03TXQJj+CTq5n7VsbzKLdY/fk8jHYvOqtgK4wX4LGpMOnBIPkY3oEvW4FQNjBpo/DsIZZMmhwwL00H/gP8qX++CV+xbeeoS7zIwQ87bPFjs3eza3US+5MVejSN/qSmGAywVBxGRSviUPo47JwYJL0da5VL6tpFp0hH1JX8GJWPiXu5buveI9LHVtEQnt24ESM0Flg03n574H/r39NJu8Ru9phqogHg9vbweH84MOpYnrgYLXAqWMtNN6Y07srXS4aOYk+Wc+WGvdmnuzG6efQxOHPi71jBhDGWjQBfqJFyd7UuBxBQabnd5voBQyGxdgJ8KLWEp42D8I2I4N/+1eR4qk/+rNJSJiNsWPIUmKQiLNlxK0L+otRO2pHzg/e1EUGjpB/nAZfEtCm0qpJ0eeOP9hsDBXeyQXdzj16KIDUHM0TlJjzodcWGxw7pNitA7EzNurkUZDdDlMjRwfNbGKTZwxdn1eK6gAYDnw8DtbHr9no96jTCRyTeLK67YtYnt3qunj8ntGVlZLL5aKiqPJVBlsQ/wW03JiTiK63EgieGi6/qs9RE3H9HFqlBnAWV+qCfm3dZj+tjsc4R2DViA/dLXFxIqd+ZcqUt0uwUPUKlDhcAGnErD1y2NEuHu4BRubYTPImq14Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf00acd-ac53-47a7-6bd9-08db8eabf8e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 14:15:47.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wzx1cBfY0irTY/7SzGVK+1hDKS/j5mLJiUzafq5o/INfeOh4PRapLlqzZRpeKgIn1ACxPPeuYSKg6/v/Um4Nkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270128
X-Proofpoint-ORIG-GUID: _BorbIZnt5vto3ugmfCJDLNzBm5raKM3
X-Proofpoint-GUID: _BorbIZnt5vto3ugmfCJDLNzBm5raKM3
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/07/2023 17:06, Anand Jain wrote:
> Testing with the fstests config option POST_MKFS_CMD="btrfstune -m"
> reported failure, as shown below:
> 
>    ./check btrfs/003
> 
>    [111.635618] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 1 transid 6 /dev/sdb2 scanned by systemd-udevd (1117)
>    [111.642199] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 2 transid 6 /dev/sdb3 scanned by systemd-udevd (1114)
>    [111.660882] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 3 transid 6 /dev/sdb5 scanned by systemd-udevd (1116)
>    [111.672623] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 4 transid 6 /dev/sdb6 scanned by systemd-udevd (993)
>    [111.701301] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 6 transid 6 /dev/sdb8 scanned by systemd-udevd (1080)
>    [111.706513] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 5 transid 6 /dev/sdb7 scanned by systemd-udevd (1117)
>    [111.716532] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 7 transid 6 /dev/sdb9 scanned by systemd-udevd (1114)
>    [111.721253] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 8 transid 6 /dev/sdb10 scanned by mkfs.btrfs (1504)
>    [112.405186] BTRFS: device fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e devid 4 transid 8 /dev/sdb6 scanned by systemd-udevd (1117)
>    [112.422104] BTRFS: device fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e devid 6 transid 8 /dev/sdb8 scanned by systemd-udevd (1523)
>    [112.448355] BTRFS: device fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e devid 1 transid 8 /dev/sdb2 scanned by systemd-udevd (1115)
>    [112.456126] BTRFS error: device /dev/sdb3 belongs to fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e, and the fs is already mounted
>    [112.461299] BTRFS error: device /dev/sdb7 belongs to fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e, and the fs is already mounted
>    [112.465690] BTRFS info (device sdb2): using crc32c (crc32c-generic) checksum algorithm
>    [112.468758] BTRFS info (device sdb2): using free space tree
>    [112.471318] BTRFS error: device /dev/sdb9 belongs to fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e, and the fs is already mounted
>    [112.475962] BTRFS error: device /dev/sdb10 belongs to fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e, and the fs is already mounted
>    [112.481934] BTRFS error: device /dev/sdb5 belongs to fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e, and the fs is already mounted
>    [112.494614] BTRFS error (device sdb2): devid 2 uuid 99a57db7-2ef6-4240-a700-07ee7e64fb36 is missing
>    [112.497834] BTRFS error (device sdb2): failed to read chunk tree: -2
>    [112.507705] BTRFS error (device sdb2): open_ctree failed
> 
> The original fsid created by mkfs was a6599a65-8b6d-4156-bb55-0a3a2f0eae9d,
> and the fsid created by the btrfstune -m option was
> 1b3bacbf-14db-49c9-a3ef-547998aacc4e.
> 
> During mount (after btrfstune -m), only 3 out of 8 devices were scanned
> by systemd, while the rest were still being discovered. Consequently, the
> mount command raced to find the missing devices. Since the mount command
> in the kernel sets the flag fsdevices::opened, any further new alloc_device()
> were blocked, resulting in the error "the fs is already mounted."
> 
> It is a good idea to register all devices after changing the fsid.
> The previous registrations are already stale after changing the fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>

> ---
>   tune/main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tune/main.c b/tune/main.c
> index 82ae5a0ac2d1..4fdc2a0acce0 100644
> --- a/tune/main.c
> +++ b/tune/main.c
> @@ -446,6 +446,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   		if (!ret)
>   			success++;
>   		total++;
> +		btrfs_register_all_devices();
>   	}
>   
>   	if (random_fsid || (new_fsid_str && !change_metadata_uuid)) {

