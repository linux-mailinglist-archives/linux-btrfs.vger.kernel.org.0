Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E04F6E1B8E
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Apr 2023 07:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjDNFQ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Apr 2023 01:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDNFQ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Apr 2023 01:16:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C24C9D
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 22:16:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E4L2fn015029;
        Fri, 14 Apr 2023 05:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6yFoEeTGVNAOW/UYGUGISujjlQeSZ+8Fj+i9ekEASZM=;
 b=UFAMa6U4l+9R8kf4kzdtcgg3xf54sVEEbaa5Q1seZFatl4foHujO3xDkmArEzHgdBKTs
 +t4EUYQulpGkTBrD5IbaS6c5AtoTSo2eCQp+eGZffUmkDl6m22FP6jbCAx1NRbeXjrFf
 OEO+bWvaMKqDeeqMWmPnrg6eu2edQhrpLa1ntK84kayDJzM3qxJsVeMQUNQcy0WPtlki
 QxMPGQ8+Eey8dMbxMAcAft9XcBa/YlAMF9QLkO7rmL6XSsg9FgWA9wKdn6lQTYIW7KNk
 8m5Ws5aohJdkeoLGF02R+7LM4hCiqbIksE3Nc1ljOFZ1CfR+WNFfI6CDynM1ysXHUbWA 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0b3571c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 05:16:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33E4rd5C013049;
        Fri, 14 Apr 2023 05:16:52 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pwwgs13pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 05:16:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kW9PFMqbS19lkg4kWTU1syJyOQ/4kh7QCrTbJYQOMigFeqmJH6hDY3dySc9pA9uW4QLraEtU+wbeuuYNqJAaqHTeDi1KNa11t5wU/lO8z/1plbrJAmAswYs2CdVtyrnYDJrNrL3hKUcM6sBEfNcwPdDXFL30RDXWMhUmIvG7fFOQaqcQy4f63amq0XGnjbuphHenkTgVkHd7ndHh1eRPxFZfza47tank/QId7G1yDiMZgtf3aXwUQd7NCA1gPIxv1t0brrwlt8wYgiBAlEdMpiIDyrICpBr7IRCJiLdvXeF6UaI6U1nJsM1VSMJtftxhzcNw/b+XhmY4eSTrg1DD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yFoEeTGVNAOW/UYGUGISujjlQeSZ+8Fj+i9ekEASZM=;
 b=RQVWjcdmRPi3rdirnFEmk9UBcnuLoWYvxFecPKhGs6tLYEjL+EY11RG4XShshx+kluW0P3BVoAWyu3fQ2z+/1ZQFcunFFJofX3LLT0mQCEOUL+0kMFfj/hfYXBz5yFdsa2e+GZWYiCx8akQOHzHP+/Lve4pksR9WDb6dviPnicQQuc64rb+ki1tMkL5WZ346bK/262B+sGEkiMfg5Nq8d8XcKyvX9Trasuj1uBR3kampLda1qQa1adjBl2JTCGcQdPAjzR39xS3iGM8mrpyexIJXlo7B5MS0B3TJa4bFwWWiiLfkOmCG3ZuLqkshymqRJxZDTCVr884z7MQOvykTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yFoEeTGVNAOW/UYGUGISujjlQeSZ+8Fj+i9ekEASZM=;
 b=kuGs6ik8F1+lhJWhuyOnT3z/rB7WcQiLxsqBnqPlUKmC+RYQ3yToZt7KN4ZluJJasz2lBTGaeAekl4BpdugpdcQIDVO3cbTTQ0XCg4qlMthcvMe2mY1rguzPg7CTlX7HnWpn/wQZARvU2pv4+eU2ouAssOE1NvqFKxQrQ1CiLd4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 05:16:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%6]) with mapi id 15.20.6277.038; Fri, 14 Apr 2023
 05:16:50 +0000
Message-ID: <f9b99c05-9ed7-de24-1a01-cc39011fc69b@oracle.com>
Date:   Fri, 14 Apr 2023 13:10:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] btrfs-progs: move block-group-tree out of
 experimental features
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1681180159.git.wqu@suse.com>
 <4cc5819796bd2af6de78b7a1919b4f8ed02b985f.1681180159.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4cc5819796bd2af6de78b7a1919b4f8ed02b985f.1681180159.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd79895-d6fb-4bfa-f8f1-08db3ca7735d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAESoZ8gsy/dH7IK9jiz/hOK7G2bAaTVz22NRkGwP91BdOvyydRbhhYCXvEHzxJnQThEgoFD+x4oC7GqBmWVtO18EehKwgBZr/NfRSoEaJqTJ1fwf8/OB68U1qQWmyXHJZXs6VXrLmGCTrw4v4EAcGHI1hTV8g6+vvdUTfSiWrazfoA40Wa1k1/61PAiuWUF2N+AfyUjsBJZIK/yg3f34ugTMbpObpowlxXv+2jtQ4Cg8BJSsp42LeUNZ9rqMyr0qSFHTMOZbrFIA/yYZY/uIkHoGbLUmEju6z4K0wvr1LpnToU/3wjQPxiCZFgEKxchC9zGfNcueGqxxWYKFag+r42XdmFjO0X5LTSqxgNsBwCI7ikFQXwb6i0jqjW7vN+lzah21yZJqsPpVzDJ1TiPYxYimR1UjD24EiUXWITutVyzWvUuF8TmoNLTGRpT9/p4Gg+GvLYP3YshyI+AiRkwZTEpE/yUVakl2Cq31WkblGG2GBbsEf9Y/ztB6PhaExKMTEwL4PyOyqMAe4UNLOjRVCu+NElmVffsK1WDSbDk0UcMGpxfNwOgBnIzB94oVZjR4LyLaFbziWo9nko2zFYo/vyLoDcdcL2ogFmYp01YYd4P+FD3pDfV8r6F/9WagEJzBSwR4qc8XEWJUIdMjuED7ZoQlgVAXzjkUbc/TG6ZB+2LB6137+E+EwR8zaYGAPob
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(316002)(41300700001)(6512007)(38100700002)(6486002)(53546011)(86362001)(6666004)(186003)(6506007)(2616005)(83380400001)(66946007)(66476007)(66556008)(31696002)(36756003)(2906002)(44832011)(5660300002)(8936002)(8676002)(478600001)(31686004)(461764006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUxTQkpiaFgwekdad2F5MWVhcXZybUY1cks4VFoyaWRlQ2orekZrSmN1YkVM?=
 =?utf-8?B?bnFIa2FyMVk4REo4aGNUYnNJYWQwRkVpc3I1MmtDSmxudkhGKzVBeDc0aXc0?=
 =?utf-8?B?bTg2aFArbnk2T3dhbUlnTXFCVEZkYXFDcEN5dTNwL1dMQ0lDbm9Sam1hQzlv?=
 =?utf-8?B?T2NPZThueHA2M0VXd0V4UnhURjhXMUNaME5LcE1PbXpOVmNnMjU3RmpoOHhN?=
 =?utf-8?B?SDgzeXBEKy9pRWFsVW1aSFYvZ2JXd1ZuYk5qWDNVL3RLQ29XOWNtKzJlZENo?=
 =?utf-8?B?Q0FDdjFTZkd2NFZUZ0JGeE9rTEQrdkIrR2gwNnJwblpIRHNqZEZha0c3RDlZ?=
 =?utf-8?B?MDhLWTFMQTBTQXlHUnhHMEpFc0RpdEpDT0JrczBhSU5JYlRDT3ZwMUpPNmRh?=
 =?utf-8?B?U3l6bFdLc0NOR05CclZFT1lTOXlHTU1PaWpNOVVnN1cvVy9qVHhBNWFYYTVY?=
 =?utf-8?B?NEEycFRsbzNlQVYrYUlrVHpGWnY1eGl2UGVzbk1vK050b013S2tMdHFuVUFX?=
 =?utf-8?B?enVFRytIazhxRVNqaGgzaHVSNGNzelg2TUMyejQvY1gzeTFMNmtBeXlGcVdO?=
 =?utf-8?B?c0ZhZzJ1bkx0R2dPTDRQZTBha2ZZVWY4bFcxYmZuVk0yNXhzYzFHdWNMWUM3?=
 =?utf-8?B?a09YQzdCZGRUVHNxNmZOb2JVYzMwUkFlS29TeWFhWnlLS2JIU0Mzb2RIcDBs?=
 =?utf-8?B?eHRyQmhZVktGL2lkdnBpaGc4VityOHg3YmZQbXphbUt2WUxrWEJjazh6SDVF?=
 =?utf-8?B?RUlkOTJRTlhNYkliQXROYWkyY2kzSDJXTmdaV05WdWoyUWJNcjFlcDYrdzNF?=
 =?utf-8?B?WmFxSEc0amNVRUdHQjB3ckFGREtsNDRNd1ordDVRWnp3akxqNkdGN0ZEaGVm?=
 =?utf-8?B?OXJSQnJXTFFRSUQwaFczdWcyTWhmbnRQV1UxSStaNnR5RkNRU2N0K2JZNTR6?=
 =?utf-8?B?cG84TUlZMXUrTllQWUR5aG4yY09MOXdvK3h4aW9YME5Nb25QZkkzVGkrZlU1?=
 =?utf-8?B?eUx1dktNMmlUWnFHMkxrUzY5bjAxbUZLeVRqbXF4S0pWdXFnb1FESVFHbWsr?=
 =?utf-8?B?bUJDUDc4VmRsaWErRXUyaU8wYm9BSmRIVXZzcHp3a21TRjJGZDY3YjMxdXYx?=
 =?utf-8?B?TUwyeG1DZWVzRUJNRVN2UnVaRDFZOTZlaEFGVjBrTUNKUm8wazRqNmJudlht?=
 =?utf-8?B?cTREY0M3dlJFdHNuQkxUbC8zUVVtaDViYitNbUg2SUF4akcvTzVDcU1JT0tH?=
 =?utf-8?B?WEE1OUV1ZE4rcG5oV3lVQW4zRkl2VnNYY3VpbllTckdXZnZXcGFKM2FXK2xa?=
 =?utf-8?B?RFM5cUlBZjVvc3ExY3Urck9LTjJML3A0bnI3elhUYmNXZmZ6aDF5L0tpSDEw?=
 =?utf-8?B?L1ByMWpMNCtiVXhDN2c2dlNSZ2hidzFoRWxQbXhUQU11Z0xjc3AxS25LbW5q?=
 =?utf-8?B?bGVra01sbWIxT0E2cUl5RGpMbzVTYnpwY0ZaRlZlelZrMmJOdUlLTDREdDhs?=
 =?utf-8?B?ZVVtcUJnT1UzbURuQ0lTMlZiQkhTb2UwM01aUVF4M0RmUThib1ZHTnN4QzlO?=
 =?utf-8?B?WWVjdUZjdW1ydHlQc0Y1bVVWTExNME1LaXlrZ0hyZm05eUpJcWdRWThyNzBz?=
 =?utf-8?B?TjgvTGhrdTJ3eDlFeEJmRjVWVlRCNVdveGIvRU1Yem4zMmFYNGlSeUZlRVNs?=
 =?utf-8?B?VC9TM05RSlI5QlBZMFNlSDIwWnhSbm1IQ3lkWUlKYzdwc2orbll4L3FjejND?=
 =?utf-8?B?NFo3b3pQZmx4L0JOVisrcVhXY0pTWlhyWmdPcG5CR1dGZTJxVmYxaHF6UlpJ?=
 =?utf-8?B?VFVqUzBIVXhHcGlaYjZUWFZKL1YraTg4YjM0UWxkb1NQOFVHaWxzQ0R3YVZ1?=
 =?utf-8?B?TUNrdXdpazBNS25SaWgyWmQ2bWl5THpmU1JBeHpYNHlXUldBSTZRM1VGU01Y?=
 =?utf-8?B?OUE3NnBnZ0NKWlBJNURhdVFNK20rLzBrcjdoTmRWcFN4SkE0Q3pyaXVzWk4v?=
 =?utf-8?B?VzA5QTRyTXdQSGd6Mm5YUUI4OXllcCtCZi9NQTF4QzY2aXNWdktVdmtSdDQ1?=
 =?utf-8?B?Y1kveGF0RGhOQlhFUURZeDlkWTlIVVZ2Vkdhc0x4N0FVMFVvbnFRWnJFQ3dp?=
 =?utf-8?B?WTZuZ25ycDZ3Y2NDRWI0Z3cwQmVUemM1blZPbGltMVpPSTlud1ZOcmtZTTBy?=
 =?utf-8?Q?7LnCzpyWXjE2VbIwnLHQo2fOlhsxTxY9UIIPGGQ3aClO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MPIJiXvXvM2NP1B/YbWFZ9HLR0qwqTK5oY1HMzMQly/Xe3KeLxkjUuBEHCm8blaczdzqxqb55y6LeFjrcRqpGltcc42W1QsrA40+b47Prd5KmT5r//bwulxFncIocjYqyCKuqiHeDcnYFdNWpkQUX1JSBCTRTV4rqd0vz2TW852i5Tu+e7RdHgkeS0kESQt8DFhYrdrN94QF+UIJJsQ0jDhovnidQfL8ZCGB0YbjRzd178/nx1RCBrSE333dkthfDhXZU/KoyAnM573fBVWJsanYYU0jp/MjGWu/P2sef5bYx/PbzRxd1DzQulvJExJYU5XMwhECtrUHcaVqOZZXcRhK5xLOQhqluy88VMrfu1Jsf+NQHat6xj0Fagl7lGVuSNOo/YSBLAw1KeEL3/JzjSUAFD36LqgFcQ1oRFZSPMfoXAFE+aTWtVCYrUCXRXbcIEfdLBRmRAuy8+tF77YhXADYTwl/vH+RQTl3XZcE7yySvpaP1sU/aHHmb3mUuuG7Vv0PrBRSvmxKJVAEOfhuiPC98TjgOQawKphMMrazjnZQ9ZDDU+jzXQopl74GFpBycWP1HI2zwFVSpOoJDeRcgL4Y/WDnxed1WMT0t3sVoMVv9F/BsucoeRQKakpgfv2Q2T8uY9nN7di+kVm4qhnjErZV8Jw+Gad0DodDTa7EIVZcOyC5VqvgQi0ntA9667RM1aYDtaDvYm/oiwhMNy6wDCaekGWMSss/XsWWObdozT72lcDw+NLTdUOee8OTQ6UKCpP9p8UgJUOqEkfl4EgzB54FlRiT7V5B4Bo/9TkbU6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd79895-d6fb-4bfa-f8f1-08db3ca7735d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 05:16:50.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c75SmxTDj1f7+WvInPxGZCajanOPckHlGFPeNGKEqiNbr4TJGTDzZJG4CWuC7bKXAwARqetug1JPfx5TO79W6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_02,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140047
X-Proofpoint-GUID: 4gzM2aIWjzDSzCJwgUBGTAXBaSJ3YH0R
X-Proofpoint-ORIG-GUID: 4gzM2aIWjzDSzCJwgUBGTAXBaSJ3YH0R
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/4/23 10:31, Qu Wenruo wrote:
> The feedback from the community on block group tree is very positive,
> the only complain is, end users need to recompile btrfs-progs with
> experimental features to enjoy the new feature.
> 
> So let's move it out of experimental features and let more people enjoy
> faster mount speed.
> 
> Also change the option of btrfstune, from `-b` to
> `--enable-block-group-tree` to avoid short option.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   Documentation/btrfs-man5.rst |  6 ++++++
>   Documentation/btrfstune.rst  |  4 ++--
>   Documentation/mkfs.btrfs.rst |  5 +++++
>   common/fsfeatures.c          |  4 +---
>   tune/main.c                  | 18 ++++++++----------
>   5 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/btrfs-man5.rst b/Documentation/btrfs-man5.rst
> index b50064fe9931..c625a9585457 100644
> --- a/Documentation/btrfs-man5.rst
> +++ b/Documentation/btrfs-man5.rst
> @@ -66,6 +66,12 @@ big_metadata
>           the filesystem uses *nodesize* for metadata blocks, this can be bigger than the
>           page size
>   
> +block_group_tree
> +        (since: 6.1)
> +
> +        block group item representation using a dedicated b-tree, this can greatly
> +        reduce mount time for large filesystems.
> +
>   compress_lzo
>           (since: 2.6.38)
>   
> diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
> index f4400f1f527a..c84c1e7e7092 100644
> --- a/Documentation/btrfstune.rst
> +++ b/Documentation/btrfstune.rst
> @@ -24,8 +24,8 @@ means.  Please refer to the *FILESYSTEM FEATURES* in :doc:`btrfs(5)<btrfs-man5>`
>   OPTIONS
>   -------
>   
> --b
> -        (since kernel 6.1, needs experimental build of btrfs-progs)
> +--enable-block-group-tree
> +        (since kernel 6.1)
>           Enable block group tree feature (greatly reduce mount time),
>           enabled by mkfs feature *block-group-tree*.
>   
> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
> index e80f4c5c83ee..fe52f4406bf2 100644
> --- a/Documentation/mkfs.btrfs.rst
> +++ b/Documentation/mkfs.btrfs.rst
> @@ -283,6 +283,11 @@ free-space-tree
>           Enable the free space tree (mount option *space_cache=v2*) for persisting the
>           free space cache.
>   
> +block-group-tree
> +        (kernel support since 6.1)
> +
> +        Enable the block group tree to greatly reduce mount time for large filesystems.
> +
>   BLOCK GROUPS, CHUNKS, RAID
>   --------------------------
>   
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 4aca96f6e4fe..50500c652265 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -171,7 +171,6 @@ static const struct btrfs_feature mkfs_features[] = {
>   		.desc		= "support zoned devices"
>   	},
>   #endif
> -#if EXPERIMENTAL
>   	{
>   		.name		= "block-group-tree",
>   		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
> @@ -181,6 +180,7 @@ static const struct btrfs_feature mkfs_features[] = {
>   		VERSION_NULL(default),
>   		.desc		= "block group tree to reduce mount time"
>   	},
> +#if EXPERIMENTAL
>   	{
>   		.name		= "extent-tree-v2",
>   		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
> @@ -222,7 +222,6 @@ static const struct btrfs_feature runtime_features[] = {
>   		VERSION_TO_STRING2(default, 5,15),
>   		.desc		= "free space tree (space_cache=v2)"
>   	},
> -#if EXPERIMENTAL
>   	{
>   		.name		= "block-group-tree",
>   		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
> @@ -232,7 +231,6 @@ static const struct btrfs_feature runtime_features[] = {
>   		VERSION_NULL(default),
>   		.desc		= "block group tree to reduce mount time"
>   	},
> -#endif
>   	/* Keep this one last */
>   	{
>   		.name		= "list-all",
> diff --git a/tune/main.c b/tune/main.c
> index c5d2e37aef3d..f5a94cdbdb5f 100644
> --- a/tune/main.c
> +++ b/tune/main.c
> @@ -70,6 +70,7 @@ static const char * const tune_usage[] = {
>   	OPTLINE("-x", "enable skinny metadata extent refs (mkfs: skinny-metadata)"),
>   	OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)"),
>   	OPTLINE("-S <0|1>", "set/unset seeding status of a device"),
> +	OPTLINE("--enable-block-group-tree", "enable block group tree (mkfs: block-group-tree, for less mount time)"),
>   	"",
>   	"UUID changes:",
>   	OPTLINE("-u", "rewrite fsid, use a random one"),
> @@ -84,7 +85,6 @@ static const char * const tune_usage[] = {
>   	"",
>   	"EXPERIMENTAL FEATURES:",
>   	OPTLINE("--csum CSUM", "switch checksum for data and metadata to CSUM"),
> -	OPTLINE("-b", "enable block group tree (mkfs: block-group-tree, for less mount time)"),
>   #endif
>   	NULL
>   };
> @@ -113,27 +113,22 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   	btrfs_config_init();
>   
>   	while(1) {
> -		enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST };
> +		enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST,
> +		       GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE };
>   		static const struct option long_options[] = {
>   			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
> +			{ "enable-block-group-tree", no_argument, NULL,
> +				GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE},
>   #if EXPERIMENTAL
>   			{ "csum", required_argument, NULL, GETOPT_VAL_CSUM },
>   #endif
>   			{ NULL, 0, NULL, 0 }
>   		};
> -#if EXPERIMENTAL
> -		int c = getopt_long(argc, argv, "S:rxfuU:nmM:b", long_options, NULL);
> -#else
>   		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
> -#endif
>   
>   		if (c < 0)
>   			break;
>   		switch(c) {
> -		case 'b':
> -			btrfs_warn_experimental("Feature: conversion to block-group-tree");
> -			to_bg_tree = true;
> -			break;
>   		case 'S':
>   			seeding_flag = 1;
>   			seeding_value = arg_strtou64(optarg);
> @@ -167,6 +162,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   			ctree_flags |= OPEN_CTREE_IGNORE_FSID_MISMATCH;
>   			change_metadata_uuid = 1;
>   			break;
> +		case GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE:
> +			to_bg_tree = true;
> +			break;
>   #if EXPERIMENTAL
>   		case GETOPT_VAL_CSUM:
>   			btrfs_warn_experimental(

