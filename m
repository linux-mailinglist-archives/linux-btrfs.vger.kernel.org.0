Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE88977F059
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 08:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348166AbjHQGAO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 02:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245411AbjHQF7z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 01:59:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4E02D56;
        Wed, 16 Aug 2023 22:59:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GNgVl4001770;
        Thu, 17 Aug 2023 05:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RrcQYClON9NLXP258hBiNh6w0bBajYojjXsOiCuxQJ4=;
 b=NGqkVjbMqHD3wFhaJwZVA52YC25t7waIGLO3e4oKqI2tcuzzIgYV9M47n0cwGlSeBoch
 BRbKg4a2cgC6Nw9b/xwXWI4t1ImlUzlNt42UZ3TttYIYbdA1BcWtwXYXiyuS0T0GqbIT
 7ZFQUe8zmBySfq5OvLr+lelzXuHuFuI6ohUjOSc+xJyqM6uccGoqLCCVHhV9xS4TLJ4B
 8sbPQoQeDN5HaErz90PxSSpBwThtXmoDfK/FsEIcQnHZTL2+zBZ/snurMEZJCxRM9nKs
 ipVK3TPa2TC98UHIkbQCHfFA+2HAv+R8TLmcCdT3i8wEuzwGF4vheCymxyDXwTHHFn4I Xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwrrt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 05:59:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37H3FWkd027586;
        Thu, 17 Aug 2023 05:59:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1ud1cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 05:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf2zexAHe5x3ka84Odb24B7Ske1F9dIzbrP2rRb67IrWPXD+X/dvOvF/SYQWkWBrG/8zieBWtWuP806asHbWLm4TuPuCzh+I4PQdVDHG2h8kS9b9P4xpVwx2Sd7lkYKBhTzBfp4WE4ESxeaQvWqnnYI9vKz0lckB41EUEWVuMK9vn0IlxYYhQKu1nQdxIta22Co9nqQmpiVUSs2PWyE99nHdnBGwwopZGBHbOA69nWvyje1m2H9Fea6RQGjTcHnO3v3HCAtmXmPSrWL91OEsa+X6BKYGnIta8eDUTy0p8JakpUF2iBO/LGNVxaHmN3wW6ryapHY4j1+jQbUKDmO9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrcQYClON9NLXP258hBiNh6w0bBajYojjXsOiCuxQJ4=;
 b=RY9V3oEueLGewxfb4koRxQHzcoYFVqoUKA4c94HqYGrV9FWfOQdcKCvkZ/df/SK+Q6+vFdjSykV6u819lN3v3Btb1QklTgLA811rGzKS/RMP8u16LhF5jnz1WtDLUvpgSPdIeRBgFcGzWi8fDdbXccAahNf1MQ2IDvLYugkwW5c37oK2cgN1x4Cj5JWpiwZInK69A0u3OIqJBz0klfGTJIq9vCQZgCzF1r8dRcXU0Xjuz4h6Y/ASElW9YmUqK4j7JoqdhwUyE3dTSKAz7SQ+gyYw6Y369incoqA4vNEb/h0qiuD5t1QWoEUSpcmabpF+Sf+WDdWLk4FNQi43YZ8Dkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrcQYClON9NLXP258hBiNh6w0bBajYojjXsOiCuxQJ4=;
 b=HkOpB8qy4aEEmwH8KCvIrScleO1DGyJ6ue5/y+BDYLyQJKJGglY6drLTfme0/0okcJFIQ1sr5HQBLN4KY7+6KoErLKwFPumTokIZi6B0kBWjlBb0Iu6gsCMuG9p2t+KpgP0+t9b2Yo3Moyh60h1Yjd6uuqfLEItzycys8M6SzmQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7581.namprd10.prod.outlook.com (2603:10b6:a03:546::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Thu, 17 Aug
 2023 05:59:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Thu, 17 Aug 2023
 05:59:45 +0000
Message-ID: <5d357e04-106a-a288-6e9a-eb102a768d23@oracle.com>
Date:   Thu, 17 Aug 2023 13:59:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] common/rc: drop 'fsck -f' parameter from
 _repair_test_fs
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>, David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230816103330.961-1-ddiss@suse.de>
 <20230816145543.ic73cnwhzayuivag@zlang-mailbox>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230816145543.ic73cnwhzayuivag@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0128.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ce::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: e65505be-693a-468d-841f-08db9ee727f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBWUakuzuwRiHoQ1mncYGrLMclmEZBYwWiJC8jzuTw2/QzGtfmVmjXnJMX2XrfFRQfiOfR9acu7smGNbQJGN7dC1WvayjuZICbyxkjZFLCyViSK2OTp4b2B/IaJS+H8onmMcy3Eb1Gu0YsnPsgf8c1HT+9S+XCG8ISyBRIr3h2i0H+FRtG7wNTH2P/UsMIcPri/zP5KibbJt28tpLVsSm/tmOrL7MedEAbgtBGjAB+qY/Ke02oY0iMvfAMKBFAz4ff28OCuH4bGeWGj5lGRn9bURo4Y+PdxWGvDx5dhAIDQWgEKPjn1a6nA5sJvlV/mb04oJKXR9ufw4TK0yV8Q9nronKhuQp6Enygno0xIoL7+evX+zEQJEzkQ+kLjddlHY40IiVbscdfgAwDml2XMpSqx9/idZc+ZJqCLQFYcXqwxFAJkK2zTlR7ylGv/UNfKlkgOo2feRnNATsppu20qAipafHSrhdbQTHfIJp55Q6V8dq5noX3ggdiV/eo2ErUljU9QrfIa9tO2edjCg9htJuS8Tpb2P/0etbOREN5sLIvAju276iejkBYrtXx7Ooe0a3YIVOm6BDs6y2XtOb3GBklRLFAbrqt7f0aew7+oXMmLXGH+sW+yevpTuZ0ffAdLzN4c7YByj7KnuoXsbqpjaNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(316002)(110136005)(66556008)(66946007)(66476007)(31686004)(966005)(5660300002)(41300700001)(44832011)(38100700002)(4326008)(8936002)(8676002)(26005)(2906002)(83380400001)(478600001)(86362001)(53546011)(6512007)(31696002)(36756003)(6506007)(6666004)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUZOQys3RmF3ODRxakZpaFFmYWFYU2c2TitVbDRzd0lVV2FyaUJDUzFqbE5h?=
 =?utf-8?B?c1U5T3dEQ0RKemNXMEZvZVpzVW4rSklIa0lkSEl4cXlnZnBnWkdVSm5FWG95?=
 =?utf-8?B?UXhQY1I1cUxURWhwZEZUTm8xOXdZdFJ2QVpVZzRzQzI1YVpJR3kzdWRuYVRN?=
 =?utf-8?B?SXVmalFxRCtDK2pZR0p4Wmhwa28wc0ZoYkJoNDRoTGMxZlU2c2VSRm9XT21U?=
 =?utf-8?B?V2YxTGhjVUhFVms2Q3NaQmhEdk11aEpTc3l4V2lTcktodFZRMUpiaTl5bUhp?=
 =?utf-8?B?M2pJaUMzZC93RU9UalJPNnV6WGlaNTdvdDBPbnYvaWhWU2MrTnpKemtyWkMx?=
 =?utf-8?B?NlVSK0RxVEdUVWpBelovNHBTVVpxbTZRRVhkbUlZTTJiYUl6MVdHY2s1eUln?=
 =?utf-8?B?Y1Z4UHlxbDIxbjZhdmJkMU8za2doRzhKN0pTSWcwY1RtY1hZdWhRakVKdDR3?=
 =?utf-8?B?UEZhWURoYXVJc3R4N2JiNngxVytzOWp2cjRmaDZzQ1c1dmpMbVBWcmtiOE1r?=
 =?utf-8?B?aUdFNXFsMld1SGR3S1hmWGFDSFBqZW5KUFpDZGx1dUExeXk0TTlyNDQrRzNQ?=
 =?utf-8?B?QUFFNnVaYXJ5V0F1TXpqOHZPWVpZQVNzZVVUNStOYXNsVk9sSnREVTR1ckFH?=
 =?utf-8?B?Y2hXVWFXOE54SDVpZ0t1a2xXb29hYjR0VVdVVHhHeGFNOVREQU9MSzBBZFlK?=
 =?utf-8?B?ZzN3TDRoUmNhYndDZTVrazZvQmNGaUlWSnpUZldLcEFHQ3AxZnhaY3d6WXJ0?=
 =?utf-8?B?NTAwUEEwclgxeG1qUDdsQVRTNnZHZTJIbFB1RVcwQ2JuODYxVFdwQzU3cDB2?=
 =?utf-8?B?NElNMmlHYWorT2hXZDg3QVN0c0grMmhGVWw0WVFUc2NUMGJvQi9vc213R3Zl?=
 =?utf-8?B?Uk1aSkRBOVlFQ3lGdzJ6NVI4OFQ2bmN0aldDdm1USTQxazBJbXZpWVg3OHJ6?=
 =?utf-8?B?OGtZdEVQM01sbVRSeUhpZlhSZ3daNEQ5c0d4RklPMXhNelcyQTZNTUxaQzRR?=
 =?utf-8?B?WGgwMENWdFFLWk5Ea1FVVVpaYzYzZzRlYlBuTjZ5TnlKa2pPQ0hUSG1kajV1?=
 =?utf-8?B?OFF5SEVWcHR4bENFQ3BXazFlZHlHQnpQd2x6SWFBQUE3QmJ5RExRdk9SaWw0?=
 =?utf-8?B?QWprSnlmYmZSMmlRSU1RVHc1WFlWdzJpRU9zWjlGTmhvc0FLdzVac0hsK29T?=
 =?utf-8?B?MGxtaE1UbHRLV1FwK21wR1c0dDZjR1ppUTMrck5TZFB2dEptSkFKNU4wa2R2?=
 =?utf-8?B?QlV0NFAxRGdPNlJnc0Z4WTVGYjBXSUlQT2V5OGFIczcwUzNwZnMzNjVLUUpM?=
 =?utf-8?B?M1F4UXFtRmpXQ3FQNnBjdHZ4SmJOR0hZTUJyL0JKQURZVnRxL0l1TjV3Vzgr?=
 =?utf-8?B?cEZYTm1sVUZTNGcraHl1d1ZuWHQvVW0yZHlNc2FldEQvRWJPaHhJaklPcjVt?=
 =?utf-8?B?aC9JRDdtN2tGT0RYRjE2T2xMSXFzdkFmK1lNMkxTcllBL1Y2cTlmeUdtaWhl?=
 =?utf-8?B?OURPU0RpRHhaaUs4RlhxNG5vWHJTK3lxR0pFdEpDWVB1OVM0Q01ORzFIWU4y?=
 =?utf-8?B?SC91MnNYN3hrRy96TTJkZjF4YWNNQ1ljLy9WUFFPQTBZbTQzMWFVeW1GZndz?=
 =?utf-8?B?ek83SGdIQ1hKeEhZVjBiNHBtdG9iMm1yVGw0REt2ZDR6RkgzdmlYWXVZWkZm?=
 =?utf-8?B?WVYvN1I1SmprUk5kNEEvaWl2Ykx3Z2tWSjl5TFQrbHo1MGwrOCtwS1VmOWRu?=
 =?utf-8?B?L0kvYUNyMUY5UGJzYUtIOHZIRWhKTkNkNmFtbXpPTE5hZ1ZpZFdNSWsvcXNt?=
 =?utf-8?B?QnI4d00yQkJWL3JNN0xXN25FZzNSVUxERVpNSlZ4T0FVNkhoWnB3dFRRMnlB?=
 =?utf-8?B?cWlXN3J6azVzMStJcFh6WUJiUWVBY2R0TEhZckY2TzBGWnlGNTY4NEwzcHFV?=
 =?utf-8?B?S1RxTzRhdjByRVRQTzN1M1oyZVZjRUM5Y1FBVjM1VUJGRE14RSt4eVhudmU5?=
 =?utf-8?B?VUdGd04xbEVoTWtkZnllZUhJOThRWHgzamFsbmIxaG1jUzA0bjFua0ZXaVBj?=
 =?utf-8?B?UXdNelZENGxveVZubEpFaFlFdEZ2SEU1cjBzbmFuYUpua3BqdFdsVFRaK0xj?=
 =?utf-8?Q?5XOOFkGbFG0Vfvd6KARCTqjOP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RvHPa84jgBU0wbxxUco9xuDmVaoZNDMLB3scFR39R9PJJER6lmyp+00rtbwiWNrxQH/P8SRDBvMEfljTu5K6WPLRMl927r+NGkqnbxUDarOa4u94zxdsoOP+dfIw77X4ebLNvH0cwntT471z1t/CkzU/znRFpTKqDt5+DnVRIgw6ykXJTraWWE9d7w+k0mjeQdBaMbuxHo5zNyxB37fZQo2r/OXKJAoKvx9bbho0767iec99pJCcti422JmM0FAHb51QqsGyZTBGvWmUqCTh1llymDSnCsK3zqJxTvK7tgIkLMwDD7VYWhQw7BfRyZW4LGtCDvz8ctC4OWymsGp0iPMX9+VGvFm3QyDEUKXXh9WTl6I8dbXHATCTecFqJjAPtZrTpml6lpMafBus9fYcWZXaNHixSssoAOQ2qGbsf6eCXymR6TP5I7SO1u4rvdyoXnjA7EO3lg0dGSVoYRFtGUd81YnE/hPG1kNq7mwTP0fSTN+igM4O6ISJe0zGoXmujvAD35DhhABfl6EvTJDEH2tQe7F49aXn47LI44R1aVCDGEyel+vxf1w/AlNNQ1MBubcD78KwyuJj3QzxRMFWAvQNY5jtpvN2xqflQ/AsNmFMxtq/B1yf9wvgt6eMNcnlNfdTr9M+QEdfIjD991duwfgZnq/dMC/i3Ym6l5fg3mvwmoLdlfpT+y2+WTOnW5tS6g5jorgnGpXXHbGQGskjqAcrPSo/IOREh6BMAfforC2iYEGvl68wDCKKmuThXPO0S26/CDj2F1kpWFHYdCz+RMQao+r+F7fh1ftWDZuUwu7Lq978EPohYhSeNqrPq6Jn
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65505be-693a-468d-841f-08db9ee727f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 05:59:45.2465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PF5aCko10kE1nDsYS38cbYJ3i8Wp1EyBCsNquwaT2NBH1ZE/rq8Vj5ywfgU+Xg0/njg0wN176/q16TcnX5pcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170051
X-Proofpoint-ORIG-GUID: hgRiDoLJDZAT34hYattiopkSrTRlB1QS
X-Proofpoint-GUID: hgRiDoLJDZAT34hYattiopkSrTRlB1QS
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16/8/23 22:55, Zorro Lang wrote:
> On Wed, Aug 16, 2023 at 12:33:30PM +0200, David Disseldorp wrote:
>> The '-f' parameter is fsck.ext# specific, where it's documented to:
>>    Force checking even if filesystem is marked clean
>>
>> _repair_test_fs() is only called on _check_test_fs() failure, so
>> dropping the parameter should be possible without changing ext#
>> behaviour.
>> Doing so fixes _repair_test_fs() on exfat, where fsck.exfat doesn't
>> support '-f'.
>>
>> Signed-off-by: David Disseldorp <ddiss@suse.de>
>> ---
>> v2: drop -f from default case instead of splitting out exfat case
> 
> This version is good to me.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> I remembered you hope to add a btrfs branch to _repair_scratch_fs and
> _repair_test_fs [1]. Is that still in your plan? Anand, could you provide
> more suggestions about that?
> 
> [1]
> https://lore.kernel.org/fstests/20230808091454.4skdyjnaxjqa7zyi@zlang-mailbox/

Thanks for bringing to my notice.

The reason fstyp=btrfs has not detected this missing part so far is
that 'fsck -t btrfs' returns 0, along with a message to use 'btrfs
check', which means repair is never invoked for the 'fstyp=btrfs'.

The appropriate repair command to use here is 'btrfs check --repair'.
However, it would be better to address this in a separate patch
as I guess some tests may fail. I will send a patch for it.

Thanks, Anand


> 
>>
>>   common/rc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 5c4429ed..66d270ac 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1231,7 +1231,7 @@ _repair_test_fs()
>>   		;;
>>   	*)
>>   		# Let's hope fsck -y suffices...
>> -		fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
>> +		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
>>   		res=$?
>>   		if test "$res" -lt 4 ; then
>>   			res=0
>> -- 
>> 2.35.3
>>
> 
