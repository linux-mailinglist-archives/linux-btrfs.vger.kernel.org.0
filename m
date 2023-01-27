Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D3067DAE6
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 01:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjA0AtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 19:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjA0AtM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 19:49:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D33C51C47
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 16:49:11 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R0NbE6007729;
        Fri, 27 Jan 2023 00:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PqQLXJgRGCnTGXyF3L4s2MLdZA6aqo7xCuVNvUiQwww=;
 b=g9NT/AHjgtG7i8GAeWkLKPLiQfeUhrZkrWGG4crz3YDiFzFLXNo0LZe0QlbUZuRZnm8C
 PD1CiC7V7degfMrxrrL5E8RTlSblK6lFRf3wEK7wIcmQER1zfZvyIlLSVdUbrO45+1j9
 JaVxHhHaysCFIUUp8bz7nkE04RJE4XUOKb0fHChMZeJWvlcNtwJ+tSqIAIit6wjpJe7P
 52SohaCqFKk2CCY9kvb87nc+OpBRSMo/FREZ+eERSautlTk75qb3o8VVW1jDGZAbOvtm
 kNGvZBTFilbgTlbZOjkNcqJjsiyO+0I/2mguTjqG/R97VsC43Kh+TXJ1SScBr+KeHnWO Bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n883cbu84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 00:49:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30QNXvpP010626;
        Fri, 27 Jan 2023 00:49:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g8kbgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 00:49:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXljHjuo2SI7KEUiv0UorY5jFkIaAFN58Ho8B4TtfusmZ19BRXEZnUhFJKmsuijsibFQ4ez9OGtYgq+SSqBeblMdYl8Fi7rVZFEzCSZJvlGshgqiXop3kPGphLaSg0ZypVO/U1h2pFTTrKjnT4ZnuKdqcjZ8S2K/SY9g68KpgK5ngleTGawRuf7bXWgmrjV3MApyUona7MW11H3EXa+xCq6mWP9+EMO+atDe7jNoRQDU4T1+8W3eEnJla0vQleYXhyELVZMzIv2M5pj2KcwaIEpWTkMtra/NyNKfbnGpU5Gb6y2UxCR/pqyoocnuuxo+qPrA+CT6e+NPYgSSRlvKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqQLXJgRGCnTGXyF3L4s2MLdZA6aqo7xCuVNvUiQwww=;
 b=e+Bqf4HDStkUZ8tx215emf5h1UXSLQ4GE5jmK8zkZVdckFip+oxrp0ms4S6HcQskg46k/KgMNLJXNSc+ADIAFD93kJ7cIDZ2gdbdQYIeWHXegKnCMKCopgVm9xUAd7/bulrXJregNg5LPtm+ZJ7uc70g3XfSUxaUYBqMvCCCJ4OBJaqMPh+KujmSmPJHrjV2XwLPSol/+T+09eApo0ImQTl+yCkdDmSuO9tBsPYgimCUhsUygrRC23JKu6ysmjr4aVCA/AWMjKfLnQ93hynDqXPibO5jFa9m7AaGKpz9pdSyqFONDR0gHp7c24jo0eFaZvf24ZIb8oP+wVQ01ykdwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqQLXJgRGCnTGXyF3L4s2MLdZA6aqo7xCuVNvUiQwww=;
 b=Do1AbyAxZQh9rMInsFrlw4+267wSRC3HG3OGMeOuRtEdTBoFVBIWJuyPrkGd5V3ahaPpRimvWItaXiw69cHhKOIqgrFCpTgw0a9OCj0HAOPe0LOR1v48st8gcVARRmpuxAeXRvqiIqMEqy6aX2sRNyLko5BLHxOGtisTsuSLGMA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5752.namprd10.prod.outlook.com (2603:10b6:303:18d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 00:49:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6043.009; Fri, 27 Jan 2023
 00:49:04 +0000
Message-ID: <5fc376f1-e3d9-b56a-a2e7-d56f729b1b5e@oracle.com>
Date:   Fri, 27 Jan 2023 08:48:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v3] btrfs: allow single disk devices to mount with older
 generations
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Daan De Meyer <daandemeyer@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <1bf56a77b8b57cc3b993fda00752e79830685ffc.1674772170.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <1bf56a77b8b57cc3b993fda00752e79830685ffc.1674772170.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 08907e41-4ecd-4cbc-a75a-08db0000497d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQ+E3DSm7TX7ieRCtZ32sULcuv7ldtNQNtWcCwqdptQHSWqN4YRni9Lyfiv003UVSRd5CwEgzGgVUEYV1g1Prr1/yRKinucoI/fYWvc8zM+kgNvss5hA3Lg7HrhsX6FgQ1qVNJkSI40w45XM6pvPWepHDhWQsxb2JcvRhXRgcnsszJewMlWOvNmUVzrjedyCqExGuXt8tyHnJvExRdJ5NRNa98hL+S5UPEzD1MacFztpqGWi8CH0YCdTu+VG3ZztRgTNkCT//vkKjIIhitbR84MhHgtKGXQ0YYyPUm8Mj3kWLhXC0Qg7m0ITq/oSEosCbgFQbhHKksFSY165xFn8t5I2oRTDJe59NfDpJFGuhOlc22KZuhdCgqhrQRqO+HXi5+qyh57nfsu0aK/pB8s+mT/Suq6qzo8mZETCYCM3RQKMdOJkYKtuS/nHc32bUOYuLI1MnLqdojLhPyOLS6TiQoChQip1L3jzUTxCPmS6KVRv9gok4ujE1k5CBzWj977HAZibODHuQA41XQI5bivw+ZRmPsQlurdXpsOp7R+WUNt5BzP9DdxGNwOJgFqdGJHQINiDrz+OWttduLZoU3O6Cn/T2PHGy5pPDfUdXDvi4lSd37Pv0fWBkvjdSho8xQUcs6HdyAvkskP6/88ipUGIrAxhBdYxj+pgGjcSL4zloyl851uZtdgaqPqTDE1sGdgX8UhEOMSMi42FFEjGAESBcsDE97H//6UyyPfcS1RMeOU5/9HJDRCsrxh9/drnOBgxpdOQhLlblEFdUUZxhSnnCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199018)(36756003)(44832011)(966005)(38100700002)(53546011)(26005)(186003)(6512007)(6506007)(478600001)(6666004)(2616005)(66476007)(66556008)(4326008)(5660300002)(6916009)(8676002)(83380400001)(66946007)(86362001)(41300700001)(31696002)(316002)(2906002)(8936002)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU8vNTUxTjdXaGQzRVNOeEdXZEFZSUR3R1huU1FyZHhvUm5HcC9qTXI1b3ZS?=
 =?utf-8?B?allvR01sQnR4c1RJdFFIampMWG1LYlpMMjllWVVySTBJM3BUZURSYlpHcXRu?=
 =?utf-8?B?Rm0wb09ZUDExZjgvWHc5Y05aYXQ5WmF0M29aM0t4VFJISmUrSmhIQzRWcGNL?=
 =?utf-8?B?ZWFtaUd0SjhHM0YvTEVGbWdjUTZhRnFWVkdLV3ZsVS9MNUpMdGtDK1g1anhV?=
 =?utf-8?B?Z2dCdUtKRnRHaWVQaVNWRDM4bFJmVzkxTjdYbURkb0Z4QTgvUWZBRXFWa1ZI?=
 =?utf-8?B?Y1JXQU5CVUpobE5hdnFXc25NK3hJdCttd2ZnaUJGY2p4RmpqUzRIdUxaQXlF?=
 =?utf-8?B?UnJpVnFjWHF6LzR5S2ZCMXJwQWpXVHc3OVp5cEpITk5hbmxJOXFPRVJLRGVu?=
 =?utf-8?B?VXZFUzY1SThFM3Y3c092NEtzT2xWVmxIRFkyT3U1Y0c1UDByK0Fya1NRSGlt?=
 =?utf-8?B?UUlTNXJZUzJIejdxbUEwSEhLeGhrelpUMkpYU0RnaC81b25TN0J0anNOT0xZ?=
 =?utf-8?B?Y0REQmh3V0FHWkhNY0lWb2NZZEMvOGpxeHVTY2pwNjVtOGJCYUljSU54bHA0?=
 =?utf-8?B?NllrcHZJVkxndHA3eXdVR1lFWktBbFVLbHpJcmNNZ24wQmR2RkFzcVVyRXhN?=
 =?utf-8?B?VW5ZSXd3MnVvc2JDcUxyT3JEeVgwU252M2JtaUxKS2lZc3JlTHI2enJGRFZs?=
 =?utf-8?B?aXVPbm1kOU9oV3VXd1gwZHVIZFFheU5rb1ZyTzQzdzJvaWltc0U5R2M3T3N4?=
 =?utf-8?B?aThhRHU0SHhhVlB3eWdlWWJUZkN4NUdZbUY2VFg2alRMM2FSV3hYc25ZTS9n?=
 =?utf-8?B?T3I4N0E4aW9NYUp6cC9Pdm5EL1RkUG91T1JPNkFIekNocloyMWZsRXRWcnh4?=
 =?utf-8?B?Q20rT2dIS3RjOEExbGZVUUx0NkhMak5abjI3Q2NMbStJSklrazdpWnhJTEdo?=
 =?utf-8?B?RjdUZGhNVTBIQmdsajhyWFZwTVZTdmM3TnVaWUJWNjBpRTRlWnUzM3JQMTJ3?=
 =?utf-8?B?STNXaTVreWIyV04rWHIyVTM2U3ltVjNEbk5XTmpHUm4rUEhzLzdCS2dtRFJF?=
 =?utf-8?B?bWJnZEVMRmh4YlMxYkk1amJmNEJrT2lmcDYrVGh3K0IrNEpZMElPM2JXeThy?=
 =?utf-8?B?bndmNXRsUUZvWUJmNFZpeGx0eGJsdFl0NldiMnZTZno2YnllUFJtVEpONFRZ?=
 =?utf-8?B?dTc4ZnVSRjMxMy8yMjlTYTlobjc5NEFMWUxpa1JoYnBscVFCWEdjejZmYnhK?=
 =?utf-8?B?anpnODJJVGp5TU1VMEI1bGswOEtJaXF2R000ZWdpSTI0RThnSkZHT3JyVHU0?=
 =?utf-8?B?YUxFTkJLL2dybCtDQnFpbTdQTFdvTHl0MHB0Wk1ySXI2TkN2WUNYa2VNMEhp?=
 =?utf-8?B?THZyV1FUNkJ4eUxLL1JkV3JtbmtsM2ZRaWN1VUJCTnc2OFB1bGFSa001UUpE?=
 =?utf-8?B?elZWbFExcjBpbWhRY0xaVExIQmNZQmZibFRDeDVEM3hhdmdGY0hrMFVpY1Vp?=
 =?utf-8?B?WXd2M1NBTE8vV2QrMzJkNTVlazlSYiswRzl2RmcrMWFKc0E1ZG5CbGZ1Q2x3?=
 =?utf-8?B?bVZyamYxRTU2amhBTWJUZHhvNkpwT0x1T2J4NStrNEQxd2w0UmtmYVRJcW9L?=
 =?utf-8?B?Q3BsdVdXUmwvc3YvUzJhM2haWDh3bEJWajNqcDB2SnFrL3hhOURKeElnY2xp?=
 =?utf-8?B?cDVueTlVbGZDRTdESmhuU1dPODdnbENVQmpQa2R5OUt6eUUrUGdjcGVLQjZm?=
 =?utf-8?B?ZHp0WGZ4cjVVN3hTQUNIK0w4T0wyakFwSWh5SHYxT3c1aXRMWE5qUll6cGky?=
 =?utf-8?B?WHZHSXAycGdHSUx2MTZTOUtCNDdxV0Y1aEtXT2k2SVUxOEJSWGc2cWhpcUFQ?=
 =?utf-8?B?UWFYdi9QLzZNcW9jOWJqQ3Nua2RwekU5cXB5eFlYUmcxektwUnpqeU9vNGxI?=
 =?utf-8?B?SnlITFV5aGZUSGZ0cmxzM1c4NkNDRHozTzY4L1dKOGZrWnFHL3dEdFg2SDFN?=
 =?utf-8?B?RTBOOHBFakgzeHZ3T3YrZnZWL0tCN3ZZcytMZlc2Y0VXYThkSTRnWkhCWFhS?=
 =?utf-8?B?N3kwc2hWTFJ6WVNzV1RXVW4rckMrRzVtU090cHNaQzNQK2RYUFhIejhjY09T?=
 =?utf-8?B?cW9iQ3M2YTlmcE10NU5KNlpxWmZHaGZ6ekN5aHcyeHErVlZiZzl3QkRHTHZ1?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ertbIG+sfothb+cYvGsvKucDRlRmCj9JdVkMVEZ4lDTBE5tUvRKrXUuooZp5gnZ2+d5mAEJ+V8aT4AQu4mDsNL8IVUnj5p/SBXL+90LaVYS9oNKejXgHdvDdgcpKPJ0USoDHsiVLHC5ko5fpkGXTDLRNDGT6WJiIE/hRlnWMDRhQBbCrcKRLt5U4Prx8m04mchzL5+Zl8VsdxmxYh2xIVzg8nXq2srAdJCF0JuKqMtqtWvZ4SbIFOvaMqsmRN/C/Tk3n+UKLRikffJndBAr+LaRiQk0CqcqKBI5saMKvl2aXUJhIbtXghe38a+2VvJF7R9WGO8+90xVMH3sO1HC66cl/QpFPRiDAxJo8YEyhy0RxZlinvnK0O0uznPUE/KhDmzV03mZkdTeymErteEPtft55TDLGst67k89fYPLbwhDzX5Ct/KatcQUa5R1Zm/w4vVhr/RtV1QhTAhaP55X0bHTcjnwDzJvuzkYRpeBoWlgxfdo0O7jXd2CU04jrWZWWIkLiWq0SlvaKU2nPLEqTKny6B5F+m5oM5y+c2gICpB3MO3wDap3JFoByNDzI4A84hPdp3nW6a+V6cqk87oqGW/FFH9roBMR2E2C5HPNGyjTAJ2oeYratj5tQRVriNSWIp2L5foqQYHvXuGunqdkZnNkORZf1MKBBC5PIAM+u/cOjDxP4wA7+iMG73LdTz2B8j6UtahNDzOAP2L3ohXFGqxSXWO7NLkWOOHzhb+4RDwPoxWtq4bPTRGGtG8HaYVZ6mhyAgBKYqAvuCwe+UGM448GIMsmVsRSCHzB3YkqTiIF7ihBJGOXEYffJTxEfAeDB
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08907e41-4ecd-4cbc-a75a-08db0000497d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 00:49:03.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrp9MAX3mLpYJjIbJvC56GZHu1oz/08lBg2TJLHIhIznK0Kg6BqeScuNItOYbtBPuXNlNg34UaT/douI2maR1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270003
X-Proofpoint-ORIG-GUID: WN0WxJLc14eSgJnJvlCGqveOzybgu0kk
X-Proofpoint-GUID: WN0WxJLc14eSgJnJvlCGqveOzybgu0kk
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Josef,

An alternative approach is to free the device allocation for a single
device filesystem during the close_ctree() [1]. In my opinion, this
solution is more elegant. I would appreciate your thoughts on this.

[1]
 
https://patchwork.kernel.org/project/linux-btrfs/patch/faf1de6f88707dbf0406ab85e094e72107b30637.1674221591.git.anand.jain@oracle.com/

Thanks, Anand


On 1/27/23 06:31, Josef Bacik wrote:
> We have this check to make sure we don't accidentally add older devices
> that may have disappeared and re-appeared with an older generation from
> being added to an fs_devices.  This makes sense, we don't want stale
> disks in our file system.  However for single disks this doesn't really
> make sense.  I've seen this in testing, but I was provided a reproducer
> from a project that builds btrfs images on loopback devices.  The
> loopback device gets cached with the new generation, and then if it is
> re-used to generate a new file system we'll fail to mount it because the
> new fs is "older" than what we have in cache.
> 
> Fix this by simply ignoring this check if we're a single disk file
> system, as we're not going to cause problems for the fs by allowing the
> disk to be mounted with an older generation than what is in our cache.
> 
> I've also added a error message for this case, as it was kind of
> annoying to find originally.
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> Reported-by: Daan De Meyer <daandemeyer@fb.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v2->v3:
> - Dropped the printk as we now have a printk here to indicate that something
>    went wrong.
> - Validated that it still fixes btrfs/219.  That test validates a few corner
>    cases that I could think of at the time, and looking at it again I've covered
>    everything that comes to mind.
> 
>   fs/btrfs/volumes.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 707dd0456cea..b17b4a66a8d4 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -766,6 +766,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
>   	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
>   					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
> +	bool multi_disk = btrfs_super_num_devices(disk_super) > 1;
>   
>   	error = lookup_bdev(path, &path_devt);
>   	if (error) {
> @@ -902,7 +903,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   		 * tracking a problem where systems fail mount by subvolume id
>   		 * when we reject replacement on a mounted FS.
>   		 */
> -		if (!fs_devices->opened && found_transid < device->generation) {
> +		if (multi_disk && !fs_devices->opened &&
> +		    found_transid < device->generation) {
>   			/*
>   			 * That is if the FS is _not_ mounted and if you
>   			 * are here, that means there is more than one
