Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B307782631
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 11:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjHUJZe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 05:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjHUJZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 05:25:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4291BC4;
        Mon, 21 Aug 2023 02:25:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KNMb8N001943;
        Mon, 21 Aug 2023 09:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=Q5YGp7FOGPRW9WWTJ4VOTlsgSZo7HbGpXDpTnRmA97l0i0kVqj4EGy3LB3rEy4GeZfsK
 /Tx5npj6El43fU1+qFdIqjzDqES31JiCeeHz/98bmx85+9iOe7QgPnBDmty74lZDKkPQ
 IbWLvAgFGG429O0mfdqmenwvRSD4pikir3B3tbWfkP8cFn9Mm+z5EuQtseZD9f/c2jjC
 SKii1n91zJo7YjnITlDP/XRjN+nNpXvUFTW310wrQmhkIViFZhTL5/Q0Z4UmZUu3XPSn
 p8XBCysCPW/b2LeYBCm3hZXSXrptdMXzLVRKQeRZvLjKrz0rUGCuz+f3iGBdp7aCNIhh 5Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmb1tgn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 09:25:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37L8iIOE026642;
        Mon, 21 Aug 2023 09:25:31 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm63f97f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 09:25:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9MPDKQQyCzneYg1ZdAU41BHiCVM7m9jDLfjx0ejVpGO9Of+ledkC6lY8VvA1x6z8+tAPlQ66BQWRWoC910s2mAl05HZVRXzyRCohzJo8aUpB/L7NSdSX5ilg4F5hD8hGWtVcBIRTBz2/QuJajlMOQ0B+tjWky2bLxGoylSuySuIz3hQ/V+2DBm9Uw+z4MYjsZpOu5xJ5HEhdl3VoiHKuCNehJJSRvHa+Lft6dI+kjvgtYwoOq8iOAQbcPmbFAjzX2nVdwXu5y3VVqimlGve4oJih+rKQuuv/4qhid5mi+zqdNuBsmXAS2qYifOWBc5eopYIsQQT8XcN9tPuxnNQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=jOpKwyJhde1GRk6yR1h1iM+i43WRRkKHckUmUb3a7fw8JwGePcTdaMnO3OrZ+N7DDmBSdEAgczwvBDFbQsQYy6V3AYN0eYiZ2VSq+mdPWauE+8VnPUsIZ6vUMz41ZS5kU2adP64yNBD6tLN+7Us7mM4N9cUGktFThpHMXPq5V0lb2kiqB+f4DgEJisGK7/geQGUZ3Cin4AIOq0C5dMHblqUKQNKpIxymDA0qRTacPq7MgRyxsS1Z/nX2qtA+DPMLqU2558kSGbD/kaN8L7HM6AvSIuTUe0xdUElMVlc3hczh77abFDos+4JVQ54aOX6+NDFWkNhF7SJ6I/ISxZITUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=aOW6sCpVODkJ4HBP0t0d4N3rOp7lXo9vcPwOnHwgTkHD7yJvJog7GskVzSa6s6Qe6T6aoYC8Rgs+s9fbXNoDkXsaYN5hu+C4ZTtrDWsgXqHBFHZxXlkdqocSYwCGlUa8q1Wy3hJwtdwvon/2wCEnDR7nWHgNN6nGR8Sq+9rgDt0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5070.namprd10.prod.outlook.com (2603:10b6:5:3a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 09:25:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 09:25:27 +0000
Message-ID: <acab953a-e23a-db8c-9fb7-8c2fe537a1a0@oracle.com>
Date:   Mon, 21 Aug 2023 17:25:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/3] fstests/btrfs: use _random_file() helper
To:     Naohiro Aota <naohiro.aota@wdc.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1692600259.git.naohiro.aota@wdc.com>
 <e0a85c48d589623e04272804bd7c721c14722f73.1692600259.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e0a85c48d589623e04272804bd7c721c14722f73.1692600259.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: f3494ad4-0abf-4135-cc80-08dba2288e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oaZlM/3I1idhw4Rqy/ROPcJG03VTh7Dd8ItUe/EPR/ACnixn8yeKnGbqSrWBF4C4QAjvFlsecnyjTi51gftO/+ge3XfYj/Br89rFpVCA7E7KRMEdpkLCGalWiTZLg7jpui7IJ63MhVdLE1d/ct5vALGnftHORmcWoL0WjjM4baaLyjer+G52KRlEpU7/NgjXMrALpfRNgel0NtjD/zA1RPOi3dFTtHe8YT7mGgEj+00G7OCTZaq2dlxfojw1wsJmzzCKmMrC6MPYK2ZfEWYWp9IA21tr+ejUAvDLaaRmp4na+9+D/RClAzEXOu7j8Hye86ZyUmXBVzQn7+Pzvn5/3n1Fjq40BOVaqPu90GCd6CVLvFAqfC5KhIUskaNzLskpxIa/qKlUcoCYRDS8xGsSSW8WtT8MrXn3cUqYoxgYvHvvYl+3YLk0tPgLDgnPexWVdtwNL0fZ/zk2TkFSRMN534bU0mN1XasSE1iywBM54oVucegJdQU4lD5l4sZGMWQNitc+ZscTpCcAsmwCKtkWqiQtinnqSrkvYKbpbMfXtyp1GiWMqReLosqL14RxPOY5U7xS0MNv2q22GN+cC70KBKjGHIrkGaXxmUir4cb9DkIXBo4y/YO0pm8f/Ebw7o/4DTcHxxhxAKToKSJA8l3lag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(6486002)(558084003)(5660300002)(44832011)(4270600006)(26005)(86362001)(31686004)(31696002)(19618925003)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(66556008)(66476007)(478600001)(6666004)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFM2UTc4MVJpMjBZVFZiUStma2t4SXlVL0NOTjRkaW1rUGtjaGRScnhJZDNZ?=
 =?utf-8?B?QVJXdkZUUjZhQmFJQS95U3FMM2JJZEdRL001aHlLcVlDbDVhc2dXN0FZczI5?=
 =?utf-8?B?aFUyTGprbGIyQWtEZWJnUjNkSmo1VVF5TzR2SzM1NU05bmJwelpHaWlPOXdU?=
 =?utf-8?B?M2ErSFIxdDA2SUpmdHdzVXJQeVlnUlpGT2w0elhQbG9DMDVJUlBzVDRNaTFO?=
 =?utf-8?B?VDB3aCt6WlYzbkZWSGN6WVQyVVduSGhzS0k2dElzcThuelgzRzhMNlJlZm1Q?=
 =?utf-8?B?OXNPaGpkb1pkZkp3QUhsUkFXMTAwMFRWR205UXVkRHRyZUlzYmsyZHF2VENP?=
 =?utf-8?B?WHROM2ZRZUh1R0F1MkhZWGxnMkJOdzQvcGZsTXAyN2VOaTFTYnVRMzhjSlBJ?=
 =?utf-8?B?MTN2SWxyc2gyTDAzbmU4VnpCcDJaajBSL1RSaENjRVdaUFJPeUVJNXNITllq?=
 =?utf-8?B?dGtLSTdPaENHZUlOSXhCWUo1VVdiN1FMMUx6MFlWNXFRdG5QTDd5ODJwamFF?=
 =?utf-8?B?dzhldXNWVlo1V29hVG9MS1VyZ3M1V1RITzBjZ1RXMlVHSnRPV0F4K0tpcU5L?=
 =?utf-8?B?WUZQNWdRaDR6ZlNTd0xVKy9uaW9WOTlnbGRBcVdKK1NZM3FXWjdGUTRkMWlG?=
 =?utf-8?B?REZqQnhvVzB3MlQ5SG5jdlVCRll1Z0pnYWJhNVVDTXpwZ1hQVk1iSnRVRjZr?=
 =?utf-8?B?S2htS2dCMTBsSnRxeVlkSU13dFFiYVV2b0lrV0xTcmlPaWdhcHg1N0ppaHJl?=
 =?utf-8?B?RnFneGtBMTlKUWkvTUNuVllTQ25NWUQ5VEZ5ejB6WDBSZmdZNW9DTTZab09K?=
 =?utf-8?B?QlFzTVVsOEJzRjNYQ0c2bWJlRnlkK25ZSkROWmJMaGhHYmtvbnhXMU94OUhE?=
 =?utf-8?B?ZTVZbW9KQ0lsOC9IU0RlZjBLeDJnQWwyWGswZFQ0dklUNGVsc0NEK3hBWkZZ?=
 =?utf-8?B?ajNHZ01JeWl4T0dFeHRKVWc1Sm9pVk9abitVelhLd1lteUI1NlJycmkrRlo4?=
 =?utf-8?B?OTFaT3FINzJ6SGlFZHp0anlwcXpMNWR2R2lOalZiSEh4aGpmRCt2WTljUDlS?=
 =?utf-8?B?UEUwa0hDNTJjU2ZBdytxUWd4eG16STNyN04xTFRINGtvWWN4NE9Vek9kUlpC?=
 =?utf-8?B?Q091dC9Rc1lWVjRxczRsTHl1RjhlcVRzSUM0emJRTlMyTllBSnhadWVoTVBi?=
 =?utf-8?B?b09aNUErNFc5N1gvVE5TMFA3NTNkd29NeGxtZHQ5WlZXV1pTZVcySTJDbDY3?=
 =?utf-8?B?aFZZWjFYeDBCNUkwVXExQnVmMFRWU1F0ZVFhV080ZW1aVXk0SWM3N1JvbUhB?=
 =?utf-8?B?b014TVFoTVpQNGVCMkNDMEV6dzlsSXAxUUdlL0k4eEhNdmV0VTU1SEQvbHpH?=
 =?utf-8?B?SjJOUnNoMS9PTitRNXVxMzRmN2h2Wld2dUR6SHo3WS9yWXlyQ0gySzJSMEVp?=
 =?utf-8?B?Q0lzcHE1SW56WEpyTThVR1ZDN1NpdUhmQ3h3aGhmUDdkcFFwSjczZ2NJbm9k?=
 =?utf-8?B?dnc0NE11Q2xqemtSRTNSTzE0cStSdU1KcktOR1VoVDlWM2RmN0h1VHQ4UnBC?=
 =?utf-8?B?VGhzeEJtZDJZWDBPejdIYWtXL0R5eWZSSEszc0laZGlOVUlFRFFSbUh3dzZs?=
 =?utf-8?B?UHZmdStVNnJOcGV3dHpXRjl5L0RzNHdKN2hESHV1Z3NYWXJyU2d3Y3hpMFRm?=
 =?utf-8?B?b3RRV3lncDQwQ3llY080R1c0ODRoMEp4QTVLaG5zbEZocys1UzljWGhobnk0?=
 =?utf-8?B?MmRneWJGVDc5MHhOUXVtbkxTN0pCY3ViWmQvOVh0cS9KemlDQ0FMZ294KzJi?=
 =?utf-8?B?cjZQeGc2Q0V3d0sxeWhTVDhUSjFZM09pdjNQb0hvZ3lGcktPRS9XL0gvRW9B?=
 =?utf-8?B?a1JJWG81eTFuS1UyVEN1YXNNOGViWG5XMGNpVUNDcTFYajgxYzRjZDdValB1?=
 =?utf-8?B?UEdmZ1pYMGZXK0NpRTliUzBIMVRxQ1JCSXlaQXJtRHdObUgvSWI2ZkFEMlJB?=
 =?utf-8?B?bklqUGhsRUI0KzBWbENHRDhYaXFXUkJwVzBMbXlhNG44VHdtTjR3M2VseFJ2?=
 =?utf-8?B?a3ZHMVJMbk1PTTNUbStXaEw0Rjc5K2kvRTZOc0hUS1V6TWlBWFFhcDliNnF6?=
 =?utf-8?B?aU4wYWgySGROVysxZGtGL3FhYXA2bVgrQXA2TEQrRkxlOXVCNmpMeS90emhD?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lCgPHTe3PpIMORAt3ULfZhl6NY6UqE8L06SR+GuC777uD4JNLdU2JQyVxwWoSAfgLeBMcf6rssW4PF6vlbMp+gXi/4iVSQIGcLoHiQW+BSLZbRc8WE2Af3hBwedcVfzUmwaF5wigDs/+k5AVFU0HJAwejyXbSjM+dOdUgyKUDNeFRzaTzolDvzRsA30hHpEJNV9F9w/9sW+aGw6Xv0zEcRuYZdLx4RLm2mNXDTMs5K9TMLoy+MVVPnrzHm/Ig0TRolug6TBbcQ+TJ77DfgRLgFoHn9+Qa35mV3YtTZVh+bbM3BHIsrDNz99h28mKe0opGed/gWu6TlIbHIYp3/1ZGBIpAKlcb1my16jO88wWIiiO+6rGO9nMwLjHJxIwbwrDtt4aMkyPMKKGAiYq7fjGymkjfHDmujY6d2Pmxb/Qs6edmwNbDwGKF0aCdEIC01hbO1ZhbSdmuIV32lCF4uBTl6JV6q7MRRMWDm2Z/jjwy7Fsqy9IEi0/ZwioJ/UuBJCca6Mu1kDwnQ9PbQ7q7NFycgZTurEetdPjcPV/77Y6f99YOg2nAMR6dSKXMZxwTli5kYqG6vpIgd4EJ3fHU2bCWNnX3BFXZe5MnvHGVqR0DCdAQHaV00A1X58itarqjLYxD7d6iSIyfmoKJhCYrJEjhtlDsRmwZwCcLzAtUCPJlI/GDOt7AJMbqvyxFJePU2GQqvZ23sria2ea4SbnxRhqkOjV5hLUq8G7iTCeohhu6tW+3Pu6p06rOC3mcMZDC371zPZ0WinEGnHJVJa3co8cE8jOIjZ49cujspQK7G5C0/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3494ad4-0abf-4135-cc80-08dba2288e4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 09:25:27.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwVzb2NZM1TOFhJWg0JZ3Jq7d1871REzBX133Gj9a9FspyS7PR3kkFhGJqynqkKElemHbIfL40OtUl5cvYv07w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210086
X-Proofpoint-ORIG-GUID: yMKjyizIr2rD-BJ4cRt6JgLT4HjEbadR
X-Proofpoint-GUID: yMKjyizIr2rD-BJ4cRt6JgLT4HjEbadR
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
