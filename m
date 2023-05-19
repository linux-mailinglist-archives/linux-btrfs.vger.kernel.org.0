Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46885708EC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 May 2023 06:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjESER0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 May 2023 00:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjESERG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 May 2023 00:17:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37CC10F7
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 21:17:04 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IIx3sE018492;
        Fri, 19 May 2023 04:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1VhwJIaDWnqXhEJ2Dre4dSttmF7WXjCaf68DgLLKxWk=;
 b=0+Wg9DIDv1tA7m8XiedKcy5Ltq8if8qJcVLDFMG2FJbEyZa2rEbOvf3d2wdjd/0rpbHy
 J5jN3+y71x2iM77yHELOAaVRvXaCRQmprd2jsKnQSnTE+kPdpYpo+tl0a3Za/bnnk03d
 +4Yf7av6YliIeemWqgYI7QsBM+F/ji3waIPu2qot5J/5+fWso3GiOfdRjt2X6jSKtMW5
 mtA2ATDTOi01wuW+a+u5evT4uz026yTDgPDS2ljQZdTsYxa6HQJLfFVhu/B/k/D7NugJ
 J+uusUhTRAF/Q18mAQCBETm4id6qQw9Gsc/TCxTdtXvU0rvYrC/yYXYyUoj/8oly/apO tA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdsr44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 04:16:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34J3P5CU032199;
        Fri, 19 May 2023 04:16:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10dnf56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 04:16:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTAlewukBX2C7cucPgtdrdRH1yCIAMzsKvWgyqyk/IoNeDBj8cwNgCm5EyF2F4OTsN7ancu8hhNk3kxyAYOs5+lrVX2Dq1tfk11l9OhB7sUTOtEEEBnAinRxpnSSJU/JETwqbxnoUA0nVJhBaOi+S+B1/l3XoIxvarzzeRWwKfRQ1R8xNkX1iggoSZQRcCPPRMuRQhryQW/VKkiaXrAp5S1dpPj8pUXttnFBnfPfFTFCmi5WlfEeeNCO47cf88YK+mrMDCnUUPTfOfeee2dOzc854CF6+/SxVgTLR8GTqX6/BPKytRZvenMKGZEne/OgnuQF66NYCOzPw0vAdZmStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VhwJIaDWnqXhEJ2Dre4dSttmF7WXjCaf68DgLLKxWk=;
 b=f4XRetZzw8IEqp84agbjMZHYdUxbdZSF/wnb5yeH8tFtXFYO2DVa7fSbsp2Leni47LHCI0IY9GcGqsEM+RUndfMDFmByKj6IUdMrXUDBZm6uGjpf5RVCFW0I/p2EcXg+RqorN7PeVyUFZTeqvAMJzUeTk5Mny1Mj+Bti5n5Z9yCmphAYGjzi9oSPl+i4xL/9kIF8/sAU7YoNbJyHRqAdE+i04E78YUPkmJHvidKc7qvm2u2CzxzblJ6/xwCjyBYcrblu7QqZq1tjdVXbaO75DbSTEM2BCVSX3ceSgQXB30xZW3mYAFgMuGptJI4bctTsrxUg5QREHppmhkcsyo62tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VhwJIaDWnqXhEJ2Dre4dSttmF7WXjCaf68DgLLKxWk=;
 b=pJEPdE3+zVykcgGNTU+SVAHqgQEdZk9CATaC32n/lnHX6Z7eXC2Mx3BLv5wQ5wfijTWh4gGrrrAr620vrkB/gQI6tUqV+s6VAEVb1W2M9WcOk0ZxztjcySdVs4sQPWJLEQlD5+tekr5Fh8h3D4wJsq7EPJnjTJsGoiWe//sMmhU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6276.namprd10.prod.outlook.com (2603:10b6:510:210::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 04:16:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 04:16:55 +0000
Message-ID: <767041ef-09ba-6ce0-cddf-c4071d7c1290@oracle.com>
Date:   Fri, 19 May 2023 12:16:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs: fix comment referring to no longer existing
 btrfs_clean_tree_block()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <fc211eab020f42f28eec496aca5bbc4e58bc262a.1684320937.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <fc211eab020f42f28eec496aca5bbc4e58bc262a.1684320937.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 201274ec-6900-4939-c556-08db581fe159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aj98Od82nYgyQgomTR7iWdoBjXBeeafBvVIY9ZydcmC0DYcC9AGKCo0rLhCLqyDTdh7BdVGQhGa4KpdSqkhs4/M9jn0fq+3q3ZDN9WU6SBgztrQcxZ21J7YF3Iubc9zxeLaF0nar6HCveW+F7p3mCTIZO3RG9Q7OsEuEXy8zVN5zZ6miZPWmstYycxTIHqBGYXyNhk1a3emagSxYgwqiIlnYbIzYlDOyA9eqtiacoGKZLBucZrXv7CWNZ3ZJ2q9HMVgSGwTNZRrRJtwd0onLGYLbFkaD8T+HY+6c59NeILUDQ4vjM6V4ekePetu2m/oKCTjzn1SBpoP8/DQwwThgT94ego9kSeZ4GdqZvRzhOPSRhwEpeGGP4OJq2x//45ys2K89piFjQKnRh2tGL6AFV0dRJ0bm0B7/InrLbfcWb7MDRflc7MjIGa0TwRJwS5DZeLMthVpDSsc7My1v9gInx/TrIR8cYGCzS/wrtLmKlv8HKYgwllL7k3RQos9BmDRp8PZXGpf75O/7Ru5OLSLG0psniUVIf27QbLkweWlFFKIFdkTTy/sMBGyAjJxcS5PrE1rgvmMT483AfkJ62Ml1roy+sKyPcJO2x2s5NEPsfY7RWEPLox5vL1TLwxoiSrc9B9ovfHcxY1zXy+8uJjmOSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(36756003)(558084003)(31696002)(86362001)(316002)(66946007)(66556008)(66476007)(478600001)(6486002)(6666004)(19618925003)(8936002)(8676002)(5660300002)(41300700001)(2906002)(44832011)(38100700002)(4270600006)(2616005)(6512007)(6506007)(26005)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDlsazN5aE5PT21kWVlxV084ajdFakVqWTZuU055TUMvQzRUT2pPR0IzdC9h?=
 =?utf-8?B?YmxmaUZtTlQwWXZDYjU5bkpDNWh4N3RpTEZsYlVReGN3bmVUL0dWRmVKZEhG?=
 =?utf-8?B?VkZBZHpNYW1Xam1HOFZhYUVQSmp6TnFKZGlGdW1xSXVRVGZDWFBkbmEwaVRy?=
 =?utf-8?B?cThqdXlkK1hscE5GcDI0Z093ZUNlOURHdVZiaG9kUzZRM1VTYitvSGhqRHpm?=
 =?utf-8?B?cytHTHRhK2tObENCbDJram1qdU5yTFdrU1NrWi9aUWR4MHdYUTF4SldVK3ND?=
 =?utf-8?B?MEJ4NFVQSGx6NlNJUnVoV3FuMEw1MEFpMzhZWFBoZ3gzWjRHNGx2ckErVlBN?=
 =?utf-8?B?dmJpR3NMbExNMHRrRTRMZ0dOcXdmck5HT2pqZFNqSWRmdE9qZnBheHpBUXBm?=
 =?utf-8?B?VzRaQUVkUmYxU2N1THV3RHNMWU0xVEFidmlxSDhzeEh5TFZqVkpUWWN1Q2JS?=
 =?utf-8?B?SVVuekVhNS80QWR0NGJPdVA3WFI3U29VZGRYcFFFdDdhazFzZFpQWGlMQ1dh?=
 =?utf-8?B?Yms0L0dpUTQvWktlZ2FHTHcrTWVzbWdXYlZRUUtwUGJqVjJKdTFxMXJNbUEw?=
 =?utf-8?B?NnlJSS9lWUxvZU9Zd1p3bGRNa1ZmazZtUCt6LzZsWjF5cnVhVFAwNHVXNjNI?=
 =?utf-8?B?MjN4WjhhYjZKZXlLR1ZDb1lJSm5ZOXRKUlBVSVBjc1VVL3B4bjRyQjRJVGlN?=
 =?utf-8?B?dkt6ajQ2WDg2eThkZ2I2a1RrYmlwemhNZmdxcUkraHN6U2tGL2YyT1MyWUla?=
 =?utf-8?B?Q3hKUktTOG5PZDZMbTZKdmNvbHlNbUZwcDZEMlhhUFVnTDVRdmhRNWoxSllR?=
 =?utf-8?B?dXY2YzY0clorUUlGUi90aW82NTcvS2VDWTJFalBIOUhvK0lSaWlKMHFPMHBS?=
 =?utf-8?B?VlhpNi9SeFJGYldyZTF4QW1wM3lRaTV3UG9TLzRCS2w2WENUdjAzM1RtWkRL?=
 =?utf-8?B?anZlcGQ5MkhaZmgzYUVKSkJBS3JEWlVIT3VCbkZPRVp3ekJFcGxvTit3SUJi?=
 =?utf-8?B?bmZyMjV5Z05GZWVUeWdEOEgzS1QyeGtldzZOZDhXT3VLbUdjcGIyV1ZnS29a?=
 =?utf-8?B?VzRiZzBCZjNpUnVzL25SVXo0YnMwRXNyVFZXN0UwdWxDTEZ4QTA3MUk3SllC?=
 =?utf-8?B?Q0NPbjRvaG5GVFY3a3M3YncrbjFFTTBMS1RCcVFmZ08wTFBlTHF0aEQwTENq?=
 =?utf-8?B?em9uZDF4amF0Z1l5UmkrYmM3ZlMvSXpreThHNWFGdXRDNG9nZUVxRE9Yd3pN?=
 =?utf-8?B?ekY2M1VHd1E0MWl0bDh3NXRRVWd5dXVVd0lFckxSdVlFVnRiNW94WnkzY2Ry?=
 =?utf-8?B?Lzk0RHBkSXRTdzB6VnVvdGM1V05WQ2d5ZmZkZ1ZhaFV1Z044M0VBbTE5V08z?=
 =?utf-8?B?aHNVVEhoUEpVaXZFUjNSUStHYzB1cFRYMHJWSHB2OXdUelFBUlFOTVE5dnY0?=
 =?utf-8?B?RGtCb3NaRjdnaVJBWVU3SjRiYndXajloMTBpVFBDUW5wTTE0RUpZdGFoaTdT?=
 =?utf-8?B?UFoxVENkL2tscUxhR0hRamJQcTgzUW1NdEErYW5UYmZzcVpiWWp5OXJsaTdD?=
 =?utf-8?B?UG5Ob3diOXRPZWUxdHVoeHd6RUxZWTZSVXNSdE1KV0hGbE1QL2ZKeUdsSEw5?=
 =?utf-8?B?TkhRVWlieHI3Z2NhRytEckVaY0YzOVVLK0V1ekRxenUxZllsVkwvL0NJdlg5?=
 =?utf-8?B?RzhBcXhGTzlmYy9iS0FuQnR5SFRNODhVZ3hOSFZqNkI2K0ZJV0ZVRUt3Tkgz?=
 =?utf-8?B?YW5BVEEwUEh2Rk1vYUhHV0Ywd094MlpCWHZHc2s4VktRd0U0NTBjNXFjQ0c5?=
 =?utf-8?B?RlhVWWU3UDUyd3hWMnJuOE5OeG9rWHBucitYU0pjclkrUjhrRDQ5clAranFu?=
 =?utf-8?B?L0xXRHdIR1FXbFh5YjA4RjFrQ1M2WVpXUkpwZjVIUmhSZlBacUN3WllBc25L?=
 =?utf-8?B?YVl2Z2ZtZDkwcHVwdWVabDNGc1YzN1MzVkJ2T2VXZkc4MnJTOFZKTi9tYk1R?=
 =?utf-8?B?OVRFUytGVGNhVjRWNk5tUWYreGl0dEZMVERzYzlEMXRhbTM0citqSFlVYzk2?=
 =?utf-8?B?SWVJQmZpNlFLN2RBTGs1dE5BS2d6SHY3MEpQdkVmYTlydiszYTBQbTJuZjNV?=
 =?utf-8?Q?p21GoD6//5Z6t7+s9VnVOHhl5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MXkHSVAxUXzTdMPe8rjbWxKENt0K59CYSFuYse98GlWQ/zGTP0x8XcDRkPX8ak1mHjiD/yHJ75Z7cLmGewrRZgLGe6jXKWMkiAAcAqbquubnlhre28Rjg4AT8HE4DkRCLvipoDDnkv9/e0bl0OTbAru6+1Ztl4mhOylc6OHiOGYXmbtta/qWP90ALi7VYCaKPH8iJZ7GUQS0aQz3sf8688bLc6CjDN8gccE1NSxDEwMMmy60beW3UFZip1eqpePdk8rAwo74qE1BSNrOqrjI826zfPbKmp1qmLwBI85gGaayugjNPRFE1cohlwlssrUZJZoNVyKpeJKmmy8ooNVSfKmcbDS9Mm4iGJMlaFL0Tv00ezAAxYd4nbomXAdEq6AK6mb0USgP3MbYkaCWJ2F1biTRb8Vyo8fp7H/dpFJybN/GwmOH/nXNTivllEZHTqr4IL5Gz3KXQscikJaTvZfGVbkPJAVLhjV8YYuTFXy1E90iDmyN5gdbZ+fRQT9/+ke9S1YcaqSJNitAvHA6q5RbMR4vwcQBmtnO34mbgRzP+s/Y+pd8Uf/5CUHQCr6YXK4uCSYucJFNvTvNTO3uoxWulhOidTMCWPq5i1RgJXdlPv6HEimCqgUnhoYEEPKJn4YCitoKmasw/tK0rivrbXadvTsoixvxK/KpWPkorgbV9evGvVqhGnjyD94EnAK3NUquVKENW827CrZz7AWANd5tbIU/wlbYHc3htTEyCYaEiq4HMqOnfzf0OUErz1Fkv1NK0NvMh2z/YcrE9L1+5+3kFyzhi+SesS3KWL5HEqDyXYg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201274ec-6900-4939-c556-08db581fe159
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 04:16:55.5059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNgzWXPhVq2sz/1GqdHdvZX8X6mhbz2YCnldJtaBVl80OWDaN1dqcEtng7FlJWF9T+YUUoph/3sLSBBh/K+RKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_01,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190035
X-Proofpoint-GUID: Tn0bzChdL_VjvP5dLHSDEAPUi9b7Q7Nw
X-Proofpoint-ORIG-GUID: Tn0bzChdL_VjvP5dLHSDEAPUi9b7Q7Nw
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>


