Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BEF7AEEED
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjIZO1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 10:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjIZO1r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 10:27:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1436911D;
        Tue, 26 Sep 2023 07:27:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QDP9H4009112;
        Tue, 26 Sep 2023 14:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tGLpoGL2Vc2TipJITwCDv7rkau7YuvmiH09sGh/pbEk=;
 b=r0+BuaIuqYXqCAhBOZtOu24rDH3Nru+9ZdvG/LcEcLEbgcttp9TnKSTDE8leAeOQIUT1
 jdygnPGDkBZxrmYp1vwhcGzsNNEmifhKPPwvFrwgWAtJUZxEZDnFpykko9W/95CikqHH
 9FGg4Xk5FE4GdjEWrKUikJc+tsSf0vMRAnsKmt/L2OGZvjYfLMumt41regs1E2ezUZmZ
 bznxeZGvGkgvIaxEvP+GQ8ft9aryyxw8L9oYDuWtEnCsW3oxlbGAaDLy8nP/o24OPA/N
 n6gBITMbdNJD5JrDEiqMbFkQ79S+d4yfg9/NeqyRfcrCrXuvXA1wb445hMSiDdL1OD6+ sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbep0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 14:27:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38QEHbfv018004;
        Tue, 26 Sep 2023 14:27:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfc7sh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 14:27:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CX0WAiHQtykEq9KS7A00OkGXZgHMudle1GdOjy1lTs1/c1ZlzjBiTPICZtzqVvsTUrQGtCUd2CXjBIqHeazdyqkj7zNFDUaNSgMbQZhDU0/5jjHgMR8LQt49CCuGkG6EWqcpexiBsXampTQBS6fcZtub+YmSFmBsCxW9wvdWrH1Z/HA8Uirya/+rGj22pulF8++o+EC6Tlm26BQvfZKqAxgxbXfw70fH5Iq7Nc4lIkUZkAJnIGf+9t/bmzELzxABo29/pVJoFs1Ab779yC3w5oTR17u71dZJHc0iPseIjseA61QmZXTd9xJ68K3opA38F9vhkHUcd6Hgp7faXPcs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGLpoGL2Vc2TipJITwCDv7rkau7YuvmiH09sGh/pbEk=;
 b=isnfhC1q9yglHJAvkxbnA8P6AsKNq2QkulXCzoGJpdK3//dmIRlnl59OTqXCO2IT8VqSgjctUpepQ6cMf2e+BGtGIcy5LKDy+bRH9DlvHc3UGXET5ugjAI71Uo1gtCtVImstVHbflsX0DMon/Eek+lF0c8KeIF4Q4S3a01o3MHML7zmVU6Au59ofeBNAKwKNo0ctEZCXeZvXxEkx6Vw2B2e6FUPpGQ+FW53Le4/BQfH34Ql/xk6O1fxsLLGi6g2EP9hdrJ95SWzOTC19hQqqRN8WdhCwrATcP1rjpSA7Ip8tQYceP3G/pQOjmc/2ljrjO8eOIcJ2XXnbzXagPOGUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGLpoGL2Vc2TipJITwCDv7rkau7YuvmiH09sGh/pbEk=;
 b=Ch0kihJxVfSpGR+Vd51udDvHMCNp1odhHG4ovI1z9/VbbiwPBLTnf24aTd7tgPAToYj4DzI8j3/16YGulvULCB7HZJPU2DqUQUNTKBWAalKEJ7nmS++xCp+r/tD5eqHpABm2Cerilp6cAc7kTquCpw2u8dp/oupUiIbn6chz130=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7353.namprd10.prod.outlook.com (2603:10b6:610:12c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 14:27:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 14:27:35 +0000
Message-ID: <56fab235-51fb-07e3-8f32-5bda65ba3cea@oracle.com>
Date:   Tue, 26 Sep 2023 22:27:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs/295: skip on zoned device as we cannot corrupt it
 directly
Content-Language: en-US
To:     Naohiro Aota <naohiro.aota@wdc.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20230926141147.471503-1-naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230926141147.471503-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 4362763a-a02f-40e3-1111-08dbbe9cba54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEmYeEJojYstBS4+gDMmOl+uSrSeyGWVxz1FxNcXVqxi3YoCdsVoHwrgmxv9uMbopfi+3VTNtp+xZP5I5Y0EPW6WGb0HdF50FNtc/EZBsVgN872NYJfQOUJh+jubQ+W+r8ZuKMOENyZE9MxlGd32Ag3wil/6OHVSZLU2SQLNTA8NTEkPUahw5rOM+lk15yghFWMg9VhjqCWIQ32wZTuo63VAsx8+kWIH8JMlxkXNk/Qx0frUVi3ajb3AFJybzfcle3fLJJjaHSbrLTn10ym68nYQlDJ6WTj/4YpfQ2bcAZ59VmWnYBTAptDxdqItuXipu9RpsQ9Y34u02ZP4JEdnGmLtEZvHN1z+BjJYfg3ocE82GOPiFqDP5jaYqZW4+Pwx5ERtbwB24sk9AmzkD1fmtYwCFID8uJvBzQobeFSCszNKlUQmAWnYXZyCUmpDEJ0LAv9TyY+ZsQnqK01CnGHRlLjONLgTDcB4fQF4wsyCOOFwrQhSPSRxjoNHqYHG7hI319za4IrrO7f94JYv3cOIuIH29a8VN/or0w7IOgwoRmpRiff0LHoR65SyJwobdRxQjuUf7RM4CJ0bMi7HYEPnjzYx5kZ5PWcXkXrQqw0+aRSYX5dUEvstbpAwpoi1uSM+s46q/Yr1s2t7PmVkbQ6FFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(26005)(6666004)(478600001)(86362001)(2616005)(36756003)(31696002)(83380400001)(6486002)(6506007)(53546011)(5660300002)(38100700002)(6512007)(8676002)(4326008)(2906002)(8936002)(31686004)(41300700001)(316002)(66946007)(66476007)(66556008)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky9DZ0hoTEo1N1pGZ3hSWWlML3hUbVpMTUJWZGlPZlhMN1JQLzkvRW41MVJJ?=
 =?utf-8?B?QjhMUVZVZ1FkNFhWa2s3UlFSYzFiZG5abksyNnFybm4rcWYrcHIyK1N6SEY4?=
 =?utf-8?B?SVRURXVqY3BaNGhqSlFYRWlIM1o4ektOQzVyVnRoREwvVVljOXM1V3VXTllC?=
 =?utf-8?B?UmFiUUtGdkhwb3hNMTN3UkdUcVFRejBPb1NjYXp5ZjhaZ0VSR0hobDNkTDMw?=
 =?utf-8?B?MHEzdW1tK0V2LzNZV283Q3lseHdQM3lBT0J4YWs1aVM5RTlFaE0zR0VreDFL?=
 =?utf-8?B?Z0tVRWxaaGx3WGRVSERnTmRDZjZraGlWQ2l6T1dNZUFHcktpOG9MQTFtbDFw?=
 =?utf-8?B?dTdCcTlidUdvendyaXgrSnRDM3ZIU2x1eUNCZmVUM1M3ZmNBV2pGdldFMzVJ?=
 =?utf-8?B?UDFRdjdtZFRzUU80ZytUbFlRVjRobW5tb2NyZmNZaUxoSzlsZ2FhUzR5M2ZY?=
 =?utf-8?B?ckpBNFhYdEluQmJmK0MyalduYUFoaXBaRVFlaHBXQVBhSU9JYmxVMHA5eEhm?=
 =?utf-8?B?eVNnV25tcUtBaHBDN0xjbitNMFBlQ2VGQWxGUXdMR1hrYTJIaWMzY29UUjNz?=
 =?utf-8?B?cm9xVVFnR1RJWDdEdnZ3MEw5ejJWZEdSWmt3NkJYQStiYng0dlptRGYwSHZS?=
 =?utf-8?B?b2tNZU9ZM1pDTXQzNGxzaXJLc0V5R25QZDQvbG9pL05leE5jcHN4YjQ3WTdj?=
 =?utf-8?B?bTF3MkNJSFFJSitBWE5aT2xRNGxHU1BPRGxUUlFxK0FuZTlwQmNvQUxDVlU0?=
 =?utf-8?B?b25WWDdJNlI2dHZ2Q2RUbWRiTHhjN3E2MG5YcmFsWUJtc1I5MDdnQzByTkgw?=
 =?utf-8?B?d2YzZnl0WUNmZ2c3d3BYVE5BTUN4c0VlOGZyUUQ0VTUxL0h4RUVPVy82b0hP?=
 =?utf-8?B?ZnZNTmRHUXB1UFIrN3RNd3JmMTAzVmRFc2FlZmZZRGdtdHdURkd1Qy8zSkJx?=
 =?utf-8?B?cXYwQU1GNUczeHIwV1VTQmRJN0ltdEVjWnZodXZZRWxCRDJHaXE2WUp1OU90?=
 =?utf-8?B?cjdmMFFxQU0xVTM3dUh6Z2lYazBiRnlNN0lsWXFoR3lTZjlqY1lsTVFhZjl6?=
 =?utf-8?B?bzl3ellHVzlXQW41OTErSXZvMlRPdlJ3RldibFJSb0kvS2Y3S0M2MHhQUzMr?=
 =?utf-8?B?Sm1kcmdZNmgyK3ZMUDRYRms3bTRwZFJ5bHFoV1FuWnZuc3V2ak9lOTV4NW0w?=
 =?utf-8?B?Q0MzTWhTbzc0d0JSdkFqYnNseTNhVzU5YitPNUx2R0cxSGh2a1FkM3JpK3U0?=
 =?utf-8?B?d0tJWmFuV0NGRmttR25iMFVZNC92V1NuVm9hYlNHelpWZzhmL3BDcTUvSTlW?=
 =?utf-8?B?V2Q3eE9kODRJQTJWak0zRFBZaXFkQ01CYXlhblU2YWtRWGZtaWljV0lsZXF4?=
 =?utf-8?B?OHgxM0ttQ3Q4bHJ1S2EvREMwU0t1dGtRUTlheUZoUkViaXU4RWlzYm1mUUlv?=
 =?utf-8?B?TWxKMkx4NVJDcG5EazIzTGFMbkZLQVYyY0JvS2xGeHFIbkU4WWFRMEdyNGtM?=
 =?utf-8?B?QkR4cWUwYWw5ZlAvMS9BSjZ2REdLSFozL2l4ekxVbkJJeTVyKzRSS1FzSnlv?=
 =?utf-8?B?K2R2ei9SUUtEQXQrSTZpK2Y1V3QvRzhjS0xRUUdnSjVVbSt4TnUybXN1ZDVx?=
 =?utf-8?B?dk8xTURRNVNnVHcvNFNqK1pUR0ZoK3ZwMENmd1BaTjR2U09DNFl6djJKZHlU?=
 =?utf-8?B?blFQZFNmc0wwQUdjeE1tYm1pRjFvYWpmWExybC9jUFo3RHNSY3p6L2ZjTW9w?=
 =?utf-8?B?OTRzUU5wdWdCckdsUVM5STB3eEJRb2lRZDAvd0I3MlJ5V0hyY1d6S1Z6cUsr?=
 =?utf-8?B?SS9VNy9CTExtMTRnS3pETDhJd0xyT3lxSFRVc1gzVTF2b3d0STNkSHNBQ3VZ?=
 =?utf-8?B?NVh1OXNlcVdHc3dFZmEyWFpiZzU4VVNUZkJySzdWOVVhQUZVQ1VkbDljOWZq?=
 =?utf-8?B?bXJ5OEwwYTV4NGJMY2xkUDNZWHpsaE11UTRKVVpBQURINjh4TXIzZ2c2Rnow?=
 =?utf-8?B?R3A1L2tuQXVuNHhaeW91TlRYUTBncjNDd3VRUFlmZ3E0Tnc0OWcweVZmbjdy?=
 =?utf-8?B?ejdna0w3YVlKZjVqdWhLdG5mV1dQYlY0V3lXMVY2K1BJejVIbUFVaGc3Qkcx?=
 =?utf-8?Q?63oktyRzfAaSidHCoLJOo4TDV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 605ZO3VcAC70aPEargH/7egKgbiq1pOxEcx6ox8cOWocNhsji68Oq4EYPx069ZpXIWKNcKynuw3Th0NnK254W+g/kyqM9LqhEJ9AXLjWef5ziuykqLf5pCHj3TN0ZKnw98/LwKbRgzTsFgr8mFq6uWMPFczmSZTzVkipE9OKYvEBX2HJwl5caN9Uyddinrgm2D0yZZp9B5Mg0CppNFXQDWAWlvTptdVCOOnomlFZvN24aTzAbnD0WTHUhWfozMV8c2HJ28u3IHZ14tJUJU9ONMTm+Lx3EGt/JWaViGw2kOP8EttwIcMKqurEVfcbZ49beSfvwyPP5I6iMitjwB6K3bXJAUEfTJ90qQph+VnQMiuf/B4r3lUbXrHpUfl4a1R3yAPsK2pj3tVuGKcplr9vWxRhnwPRCt63WDNGp7pQGrfzCMSwuvAM3HGnB2cyasT/TjfnFv0+3QzzdNH2wwzWVwPcvwq5/5dbUsBQueMlBu9kJBJRHwGmsVuyVTqQFOudxO/BmeVuGd3lGgm0IYMS9KCjuCppzeol8a06vgsl/AmooKfjT75n4Ir44yvjkGkgdeqH8c9KwbU0dHtBjvjyrSIH/Hy+7an+2EVPZMY6ZWExODyLsuDOIJmJGa1K74u9Dh8GpmB0x9iHs0J7yBiP6FyRxo7GYkEDqQV3lOMSACik1IviczjRymZQJ0dJxAoOfVb/cqz+qqXMXkfN8+Qrl201W++gwOtwp2O0OM/WMyzUAr71Cqz4EUFgno8g0NDvIhBSx0wXQPx63CUn/Bv1iwhb8MfusKg7ZpZeILSht9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4362763a-a02f-40e3-1111-08dbbe9cba54
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 14:27:35.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIJgHgD361aw7RpGyI/g/OQO1J4EVUuHO60ZKJsMGAqdoSlYqHSQNW7qALLs2AfBV7U8IjJfd8TBI75g8D8YIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7353
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_10,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260126
X-Proofpoint-GUID: lzL4ZYx78QAXTGw-39ofwekMmR48MU37
X-Proofpoint-ORIG-GUID: lzL4ZYx78QAXTGw-39ofwekMmR48MU37
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/09/2023 22:11, Naohiro Aota wrote:
> We use _pwrite_byte to corrupt the root node, but such overwrite won't work
> on a sequential write required zone. So, skip the test on a zoned device.
> 
> Technically, we can run this test case by checking if the physical location
> lands in a conventional zone. But, the logic should be no difference than
> the regular mode and I don't think it's worth doing so.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   tests/btrfs/295 | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/btrfs/295 b/tests/btrfs/295
> index a9a8e5530a80..00a5c5680b86 100755
> --- a/tests/btrfs/295
> +++ b/tests/btrfs/295
> @@ -12,6 +12,8 @@ _begin_fstest auto quick dangerous
>   . ./common/filter
>   _supported_fs btrfs
>   _require_scratch
> +# Directly writing to the device, which may not work with a zoned device
> +_require_non_zoned_device "$SCRATCH_DEV"

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>



>   
>   # Use single metadata profile so we only need to corrupt one copy of tree block
>   _scratch_mkfs -m single > $seqres.full

