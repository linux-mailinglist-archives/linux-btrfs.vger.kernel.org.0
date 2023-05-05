Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B886F7F7A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 11:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjEEJBK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 05:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjEEJBI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 05:01:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541BE18DDF
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 02:01:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3456Y61G028483;
        Fri, 5 May 2023 09:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=mo1eXVFKVn38iQEvn8ZdzZT0sEny+zTZSbN4r6LMRXqFV5R2EjAVLzfPLbxgcTPoDqxI
 ln79RtDGDxu9T/b1RO6zc3TD3FybfYLH0Gqf639onzezmUHoz570V80mm1q++HDoIFHT
 mMXADp8iD/puPg9YRmUmlPw7oItNI/gjDc84D7HcGwJKSM9k/dyf/RGEH+TcGVk7w5V+
 RW0ZMEB1uL9/iLXQFT0jox9SBJjF92xTbKgbxLdIDQGn0IrcPGS/mdbEA7YlhH40aur/
 adHTFDnzAjsBZ3ncuTNdCYjUqGnlBrR5+rLQyfdX5BbEfS3/mUy8CNF9Dn6upTsB72qz HA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d4f8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 09:01:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34583HmV026971;
        Fri, 5 May 2023 09:01:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spfwys2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 09:01:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcLSXCEwJKFNBNf42GaRssHXtQYvIOcuvRWHA6YgZAAjNVqy3m9MrFZEFBLA4EVuLyakBXxydT5mjqBQWlA2CQG6bbtwebKzeZP0xhJyyiEoLiwiQscmFB/AEdeiL2F/TEavpLpNXvfIrWP2oJ84mti67OGl00cAz5oqRA7ELP+ulJboXRJVIjFnEb4xDA/Escv9JaKsph1t7rHMncN8rfCpfIm7KcJFRxpkeC+0ZUOlj1d0YoU36yzOjUyjOxfXl7sQqq0ZnOmyPsT+QfM1EmdO4Rm3IE/PWFz+EhZEC+ce2v29/HnT+9NGWa0Z5n0MZ2k4GUleTq1OUx3FrntYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=X4EYRpCBt+WXP1qYWH3toUnB92U3hXI9k/YUSg7bOt9MIH5/xxC0nNtVbreABlrxx2NdmGBJSacbvwn3Ff/mHGeihyRebK0JIUcaGJxdQUnXDGeygVwkhJ1kmJM+ZL4Q01mmgOfOXoy+/+CNFpapmSu8UxGRnr+2XORztDnV0lelCwbE+5ffrpjdzFmWhJ5TkjVUEJ1Ec163ywKPdLlGDV54IW78v2j1mF7Y0nxE/zEzyZrwldGZFb2dhTJqeAxoN0Eik1NLm5WpqOUidGigSknqBQoDdVzLOTOYk5MGJyV2l6DZXZVY3+0i0o88LWJ1o+bYeY7d4k8Boa0lmB6Zqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=tnTx2lxMNj7ENqmtQB6QURxPW2JAW9sJGn5f0g750r7iDSNtJnKChDbrh8zV5PjlIxHWx0+FQu9w015Avg26g2wX1tMozMDfgY+146UjDP5ECF8l4XKDggHqKtJKAJCP22ysKEu7b3i9mZVzS8n2CAYSsmABBF3CJFJUgtElbuE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5892.namprd10.prod.outlook.com (2603:10b6:a03:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 09:01:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 09:01:01 +0000
Message-ID: <4180b3c9-333e-ae08-47f7-70ff733bb421@oracle.com>
Date:   Fri, 5 May 2023 17:00:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/9] btrfs: use precomputed end offsets at do_trimming()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1683196407.git.fdmanana@suse.com>
 <0a9ca970dbc9d8f3109c0ec25cae3227f4cc7e4b.1683196407.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0a9ca970dbc9d8f3109c0ec25cae3227f4cc7e4b.1683196407.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2adc33-c35d-440b-0431-08db4d473f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKVWWJQtagB5ifoIkyeC5gYzOdQlzvy/0AJXT5i0YfS2JIQj46gboxGkbGxv+ukPLSwa1bk8DsEAQTtNNe/9aEb2IUk8RHT+6hEku68JjPbtzfyb62ShTsjEPw9YQtdi0C6trLB/tft/yV++HwUQafdEUtyJk6MwjaMWDvGD1+CZRODN6Q+ZzTSf4AD+KxFiZwsTwgTvjY0GNJZ1kJ5VUQ0LugkyPILiNpuwc9VEkEFRS0vUCap1E6r6zVhTrh1JuWqt4d9zLN8jigM/+KoxQ5Mm1rlmVA903gqTUZF1BnoCqimkiVD8AxZtz61KpSajnjjjR1yO8Ilx5h2paU/b66UnwP5WN7IOTj4Gq6BpKZg45/uoI9LbmhcguozityBUQSfJBZOn3Gr18RvuAPR0A1WTL8/2WLQudiFzOPFLO9vOwkdtmLQckrmDEJlFn6PfcxfSpksoldk2YtXYHVLVSn25DyeOAQfkB+WeAFhmtctMIoPlStHYlZ1BuDoLOdNpXtGf/d/OZVUrMA9WgMt9qHEqzDnKGDhj81cDwdTTW76tCukwRzxXGdT8oree7NyD0sdQDn723igUlRSvdKe+6xGORtqe3MyIbMF/gTvyRALAmQp4o3twHI96jzOS3e7Q/KV3NHmuq9Xn0JhNq6NYog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199021)(31686004)(66946007)(66476007)(66556008)(6486002)(6666004)(478600001)(316002)(558084003)(36756003)(86362001)(31696002)(2616005)(6512007)(6506007)(26005)(8936002)(5660300002)(8676002)(44832011)(2906002)(41300700001)(19618925003)(186003)(4270600006)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWNlVzlkek9WbThyaGFKeEkyMC9sajREcmc3VVcwVmwzSFpkNlRqQ0ZTenJ6?=
 =?utf-8?B?LzIvWkZHbFlZc2Z5UFdFc0d1OC9sWmEwRGlXUnllVmpieTF6R3doZnZkQ1hM?=
 =?utf-8?B?dFJxdGhBMWUxeVpVV05zYXlrUlF2RXZVNjhNRWYvaHg4NThYUlprWGwxNTJJ?=
 =?utf-8?B?b3Y3dE53S0xFVXA3VlA3Zmh2eTMzM2Q5WWQ2Vk8vbWp0azFhYzNlQ1ZlTXM2?=
 =?utf-8?B?bmREUkpHZjJkc1AxU2NvRE40MWUvUG5UelI5enpreDNwVnFXNVA0UzhRL3U1?=
 =?utf-8?B?Q0kxMVpYWlFGTFFHZW5XelR0TTRJVUR3TjVRUXlUZE5lVnFqdzR6UjlRUkZw?=
 =?utf-8?B?aW02cWxVVi9OVDRYRXFSOU5xeUJNSC83T1plOFdyR1U1MVA5alZmOUx4SFFh?=
 =?utf-8?B?WmRhSG9HT1R6Nzl3NlZOT3JKa3d2Y3JiT3BlSHF1OGJqdkEyK1FLMnpxbnpL?=
 =?utf-8?B?UXVscTdRMC9yc2FoMXZIc0l3czB0Y2ozM2RiQXZoYnFucWYyYnZKZXJveXFt?=
 =?utf-8?B?blpXd1NQNk1qUmlOM0ZOZm85S2hHYkF0c3VyZXJSaGZCMXk0ZDV0U2NZT3cw?=
 =?utf-8?B?VnkwaXA4dmRLT3EwVkh3VHJiTkZrMVlDQzJRZkdXTUFwQTI4S3dQdHJvY1B5?=
 =?utf-8?B?MytaNnNYVVRyY2JDYUVzV0NSTTJCRGtndDRUUFlqMWpvdEtGQW1RWlcwR1cv?=
 =?utf-8?B?cEJYVHAvalRmSVFUU2RXcjczNXdONVVCM2VwdFpZRk44NmNvTTNlbmtMQXcx?=
 =?utf-8?B?YVlOTTVOWW5ORERtT25GeW96clhSWWV0QXA1U1pqUm05MW13OHlFYXVSaVZ2?=
 =?utf-8?B?S1Z3aFlmME1ac1REWTludWZ6NjEvbDVFV2xsN0tHTFVHSTBIZkRHeHdWbWQy?=
 =?utf-8?B?UXJ1em1vRGxVenkzUGs2R05OOGRuV1dLbDk4WE5BL3EvTGExMFZhbXZBejhZ?=
 =?utf-8?B?Nnk5NUFOQW81T3hONnZGWDYyV2Zna1VYYSs0Zk5wZEJuRkUwemRkRnRCdkFP?=
 =?utf-8?B?SHRMZ1p1YmhUcWxNT2N1YzM2WERPemVmL3FYVFRLamZzZlIydnM5ZWRNODd4?=
 =?utf-8?B?aUU2dk5NcCsyWDNiR0s2TW1PQlc3cDJyOG40dFBnZTh3akh1ZU9kZVhhS1Ni?=
 =?utf-8?B?eDJ4ZExjM2tlUE5PeFdaaUp0aU1VVlRhNDZyYWx4WG0yUEtub2FIZUZhUWVx?=
 =?utf-8?B?bXkrb3V0c3V4M1hvL0VOWnpHS3RWY1ZxQkxmL0dzbC9MUU84dzRZVVhCR2xO?=
 =?utf-8?B?d0xuUVhKVk5ZOVlvdkttQ0VrZ2RmZzNUZFJjeE5ldm5Qd0wzV0lCRmpzd2Vh?=
 =?utf-8?B?QnJOdnJxWkdMdEYrZ0tyY0ZzTm0xYXZNbDVrMG5kYmk0VENyOGp2R1FuT1E5?=
 =?utf-8?B?YmxVL2pieEJIU1BMU1J4a3RjYUFBR091Q3JxLzlqakxWenVLNHpBdkY3bXNl?=
 =?utf-8?B?Ulg1cEpzQ3ovdWpDOVF2Y21VSHlGMXg3VnJmNXY0ODB2M3NkdXMyNnQ3clBQ?=
 =?utf-8?B?YnlxTUg5eFRmQlhsLzd3NDZOYjdudm9mNnZ1RERueWZDWGsxZldSNk5CbEZS?=
 =?utf-8?B?SmhHZzdXR3FlV1RLVS8wUWMrbnJCTEgwMW9tSUhVZ2Y0ZXBYdnRwZ0NQT3Vh?=
 =?utf-8?B?aFIwZHdBbzQxODUzeUx6aGxkQWo5eXp4MEhlZG9PUEFjdVRKVDNhSkFyUkd4?=
 =?utf-8?B?aUVyaXFrNEc4WTBFVzVnWWYwWVFtejdtY1lXNUlhWHNOQ3hDakZtM1RjZDNo?=
 =?utf-8?B?LzFaR05SMTFxWStVQi83Ulh5NGlobytHTzBySWZiNlAyZVg4cmRnejZJbkoy?=
 =?utf-8?B?U2phNW0yMkxsVWI2MzhJNE5GMzRBdkNYRjM2V2hkVVhCeFhXMzh2bk5JM0l1?=
 =?utf-8?B?UE1ITlJVSHo4cnAzZWtMV25XRFdSNXVoanROUk1wMEhmNGphY3gyKzhrdXNP?=
 =?utf-8?B?V0UyY1FVbHVmN0FXZkwvUUZ2MGlZM3VvVTMvbGxDMTNBSktiZWRZNmdnTGFY?=
 =?utf-8?B?QjFSTFJYYnlwV256ckxuR25JcVhOQjZWdGl0dW54QytjbTlQZGVCRGdobzhq?=
 =?utf-8?B?MklvY0FIbEpEK2t1OUlkc2JnNWE3ZUZ0bW5iUTFVSVdVcHJaYmthNUlSeUVy?=
 =?utf-8?Q?Ul+9+s2x+VLqk2v7X/Qy/5TWS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hriJAMlySkMsn+PdGCnDylT/lXaMDPLMxaB1vMwU12sJwFhfuZ50PNae3lToByEjrF07xCLZrsjPtWWmpys9HtVGMlVUy33l4gWtbmgl4/Pyt4d9WQnDa6SAhnFO6oTvcQMkZRDd2nnyznpcBC6OyIgsFSmw9LbihjUU3xbYrXiWbP5/YDk+kUc3BV/Geo5Gzq/8/mNbaOMjHmmsaSkCpHiKKDnyyrVEOHITJ9udUsklflOT7vYXW604IcTy3dxhFLmBdPVNr4+JZ68wel/ht0tVo6ziUIrE/L0o5kP8viRXiqZtW2/+AYTuo0mH5Z4Rbzuxp3HnLWnq44jlTnLPUUqF6Zkxttwq9IFHy/WUhHm1/0cnQxJYdqulT3W/v/3BTfSteesy7GDixwjs+DQ594ooaCYZGYkfq9bvWMB4MtNEG5b1tb0Y5Pg7ajpty8/fuGMVoAcyzpx/3uwJuAkJhgtENUQlLm9+v2SEXI6jPuOGd1Hgxmg6z+JKCQtJd2YuDnMMAWJyKkLYq2nnOfLAguk5dN1kkz3ATxMGGAA6XSd19PEnPiY08WtTrjPdnqPlYMc/gGo6fw18UFupMbpdEQ2FwxZS+/lbhvOAGrdQV4uOCngiI1U3yaq/G45EPDVKsRM4/f2TIVBMHmRBxjSxKecjotdi6BbyWiWEnwjNVoIUFGKZyn2my/R8Cn+OFw+Ep76c+jSuztSpgDQNx5tIi0JjjYzj/NC26M7hFYXkKZeK8l/70qsmahnGQCwfMxPDEGrk1IshLzdQHdIZANSgQnjDyZxKArahvFYSefTDT2M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2adc33-c35d-440b-0431-08db4d473f84
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 09:01:01.0685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jh030mJRIAkXNr1SICRYg3JLujKTh7jHKehEDObQPZbG4PH1KxSEEwEBl+ZHjL+SNpfdf674oZ2B/bl5bbIW1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5892
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=993 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050074
X-Proofpoint-GUID: mNp2N9PoycDGqdY0qwPLOBYCf468pYe1
X-Proofpoint-ORIG-GUID: mNp2N9PoycDGqdY0qwPLOBYCf468pYe1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
