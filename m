Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9E95BAC6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 13:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIPLao (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Sep 2022 07:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIPLaf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Sep 2022 07:30:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6245A157
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 04:30:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G8oJoX002397;
        Fri, 16 Sep 2022 11:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=F3n52xpyI8QlFqr3b7Dbxs7I4j/cIsnamkEzrIppFjE=;
 b=u6bu08mRXtKuZCDpK4j014+iwYGFeD25TMfg+W3iUaVDIVlWzUsymcCM2cFoFYXBDiSa
 SAuJKQOqzBF9HHvykmCTkzS0ppgOreu7s5QIbgW9KBq/8yRPwTr0hLNx7TvHY4TBphvH
 tRuW6fxAiYBRDb1NOUx/Nx388IY1iwnhGpa+8v/kN5+8UaCDsOal5dDATaEE8Hn59not
 Y5vDzrkFxkqiXueLyKjsISZ8PjwEBP4xEyYRzDsT3eTF1k9ANdXz7cXEG9slvij3yDiP
 tDTp8sr6ZzLyK/S/rlBjcqgmslkuDDXqGUogYqpu7Wd1/uWivrjU34RF38tiOWm+IK+U 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8x8t79k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 11:30:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28GAuFq3013029;
        Fri, 16 Sep 2022 11:30:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8x9m7bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 11:30:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apiSYR12FaK7Iok3RlrqxKZDosxmJYwP78rzbHuOa5b3S5PGeJ8QzYNSZFy/l9zQbD+qunW5gYCWAyUBiFhfyLkw/Z3/EHhueBAznOp0EdvuMY4GWMvr9ctq1hhQ7zR63Vg6ozkINEEjirnkN6Yy94akztC8w9+4bJ7N9oSGcoCu+Y8nH7po/vOlEf8Frnjq021CYg5iM1RS8D9hmSmSBBNR9HSi5C4xMmN2R6pihCyhTPHdQ6pVKmRAxjhgracn2+X5m9rcNeaJg+AGdT4e1DMY11iI/qmC/ffPtLirT9DFsrGyKqYKE1Rr9Y0o4r0AP/1gg2q8DggHE02zWlNOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3n52xpyI8QlFqr3b7Dbxs7I4j/cIsnamkEzrIppFjE=;
 b=GPqHXh0dO24CbgDW9JYAsdowvq0dYtVSAfmT8UOJyljreCl8R/IX5uUIbXONrQ8rOLAhjf6znvPZZGa6Vj9Khes+KjKUt/iTRBuOc2MvGnH/AjM2FLQHOqbalgz3YXOv0Huw9wqC2gPDc80xlhrze5WbUGSfKXHbfGSGyXAIUqpw8R4Rmi0KGPfmqFC8Pr7PzRRgJTrq6U322vivo7cSF1/1y/ndNxpDzMYvx54k6VZ4tMIbNlSn9mvPXcCiYLo1ZfvgWnGE9htX/ehYGlbhIHqnfvmI5JMfmDY3d7NCqkURlGZ0L4wBlq29e+cUoq6gwhrPYqDIG6x6M8xenuL0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3n52xpyI8QlFqr3b7Dbxs7I4j/cIsnamkEzrIppFjE=;
 b=MBYlD+OfxTkZPpmqL1nI9FI/f8AzMjJjtepIn5oJ+MZ5wv56Csvq64bVZmIhBtXolR/fcX0JgLRA7oUN0yECZAKCEPS9tpbVCsbByTPuVoPuploXIMCBbD6HpjyoB0EBZ1EyeCZslgTTdTVp47z8lLFzl6Y++Nguifc8RBJQCv4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5264.namprd10.prod.outlook.com (2603:10b6:5:3a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 11:30:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 11:30:30 +0000
Message-ID: <11567519-ea4e-b599-ccfb-96d86aa6bffc@oracle.com>
Date:   Fri, 16 Sep 2022 19:30:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 02/16] btrfs: move larger compat flag helpers to their own
 c file
From:   Anand Jain <anand.jain@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <92a20e2cd0cbf74630be86dfe0998aa3e711529c.1663175597.git.josef@toxicpanda.com>
 <2ccd2670-56ba-da73-9261-a0ed1b685ddb@oracle.com>
In-Reply-To: <2ccd2670-56ba-da73-9261-a0ed1b685ddb@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a20e89-ae85-4a37-7c75-08da97d6dc69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6/GFoL7oMf0hKsOXI+xMQk9VOuciCsVsqQkKTsjQfSIzQzZltu+j1ye9+8/8FvxgmopbIHl5tvUv70o8Acipfu04Syua7gZb2CdlJwq4zMRsPX4az3l3WUMuq1QkxVYAKNpx6jb+cUpZX3ulonKFRtdF5HrCRQrMVguWGLTdMmQDMiwcEEqDELgOVDeg8N4k1hzZatKq/IUdQn8TywgWvvYX5r79GZm220XIUEb1aSLYrzV2ES2Pht+cRcdGG3l/oDjwSJ33M6xc2p5lUp1bSR0jMB8uw9XcBFeROdedIgZIxe6o9HwSTqOJYAvCi33AwuSHke77lVXQImAyK3/exTMXZulVm+g442cWGz/QSFCJeXRAoBSmIYR5lNkJ3Gym2J09Y4tKynLz9EsrM0Cr3/fVBp1dXS2o/EwU1qivJcLfrK78AdidtdG5S9E+LO+KNMkP5q1v/x37Ox/zYJMav6FsDrluP7VRWr+g4SrtENytIgxpZ7tfHZlOLzKtuprl7vlXOAP6ltJ2z3OhRMoYYTureyAwctA1/VUxnsU3LeUcwMhci1qfAsnbs3ZupaF3G3+miZNBPlhuIY6GldufSKtOZaLfRFhAoVd7ol+QPgVsMri3Fhs32ebW6F5dZwypDf15/rVdboL4LSYlpGjB/Ks/9f44hYA3wdSYPolZIoNrwd3+BTatezz9ApDskyPfm6xjwBa51gaptnJx3NDVBRpt09vmPHaT3UYz5s4Vo1nRYJrvlRa7ZjtD8i2h8K51tQiHllgAtzHgirlGdad3zIkuEvFBhHVWPtWOzL+HOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(26005)(6512007)(31686004)(36756003)(5660300002)(31696002)(86362001)(44832011)(8936002)(66946007)(2906002)(66476007)(66556008)(4744005)(38100700002)(316002)(8676002)(6666004)(478600001)(6506007)(186003)(53546011)(6486002)(41300700001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dStjaVVXejRoN3IyUnV5eWdyNnV4YWlQTWc4MDErL3M0Zm1KZ3ZrbGN6aE5I?=
 =?utf-8?B?WDl2bGpCTDcxcE93bjY1Q1U4Z0w2VDdhaHlrYm5TcDh5Sm1rQUdKbkRFSUJH?=
 =?utf-8?B?d1BINHN0YzhTTklrU3NtNlJWa1B1TEZnWFU1NU1XOXBIcFZiamh1OUthUFhS?=
 =?utf-8?B?Q2RJU0p2cXdPRzRPQWNuYXNIY2JSVEhma2dVWjVtR0ZnSERuZXJqSXpwZThY?=
 =?utf-8?B?RnY3bUxUL2ZIbXJ2byszdXp0NERNU3hNeG9iRDluNmdua2FhT3d2bEVTa1hQ?=
 =?utf-8?B?eDl3dThVN2ExZEdpMU9PMGJ3NDJsWmpqMnNQVitWY3E3OVMxc1N6bzU1UjZo?=
 =?utf-8?B?cTBucWZpbVZLN0wwZlgzenFUVStGL1VsYWIvVTc0dGdDc09teGFWMmg5Qkll?=
 =?utf-8?B?dVN1ait1VEVMeVJVbXZIcStDR2UzK3YycDNQWTNwQjBpai9IZ1BJTlJjNENv?=
 =?utf-8?B?MFM1eUhHSzltRUhPc2NmTWZFSHZrUFRVQ3ExdHU4M29nZ2pEYmpUUHJZTXNK?=
 =?utf-8?B?OFVOaEFWZXNvekdFMDlmSXVJVEI5WlNkMmhIUTh3Q2JVQnVITXZNdVF4M2RX?=
 =?utf-8?B?d1Nxc1NHTW1vMVBRN3ppdGtTeDI4V1ZMb2UyZk1sY3dYY05MWmtwdFVzWEU0?=
 =?utf-8?B?bVBtZjU0aWpkVHdSS0ZKbG9YcWN4cjJSWlJsdCttZ0dkM0Z0YXNFRU9PTll6?=
 =?utf-8?B?YUZ3d0dLS09mOEY4UlhPL1MrakR1QVV4S1pVMlNDSy95dDIray9MYVY0YjYy?=
 =?utf-8?B?VFVveGtKdUJjR1YxdktQVnowSS8vbll0WnRrcTVpVlIwdWxQdG91YmI5U3Bz?=
 =?utf-8?B?MHl1L2xWbzl3VHJKZysyMVZlMmlOeGt2Z2ZSbndWT0xJVXhzclZWT05iS3hz?=
 =?utf-8?B?djhxajZsQ1lRbWsrd0FSVzFuTlhla0hsUUlIWkEyaFo5R3VycTV5OUxQR2pK?=
 =?utf-8?B?dmd6SUlObENXU2luOFNqc3VjYkZobnVOZTVJT0VEVlBGQTd0OEFHVmV4RXc4?=
 =?utf-8?B?SzJXN3kvYVhSSHBXQ0JMMk41ZHd6RFZadjVTM2tJa2VVUzZ6ZE02TUt5NVA3?=
 =?utf-8?B?bjgvckNiZ2tEdTZEeUExSWtPdEJkSVpIYVp6S1N4Ymo0VWprR3poV0NYNTcv?=
 =?utf-8?B?c05vM3cvdGg0TG1Xd0s5bkhkeXBiekxyUk1McGxqTXVCbFlFUDFWNHNta2xR?=
 =?utf-8?B?UTZFa1JHZmd6TjVkbm90U0tpR2t0blF1d3VOTkRhV0hpOFBCUk1taHc5UzdP?=
 =?utf-8?B?Y1dJOXZ5R3hYRW82ZXIxdnVDaGx4OXhOOUx6VitlUk1yNU5OTlh1eThvNkgw?=
 =?utf-8?B?NVYycnVmSnU4QTU2dVpoMEY2dENjRytJVFFZMGNDV0NnWmR3VjUxRmxFbkoy?=
 =?utf-8?B?NkN1Sk5vWDYvb1kwcnFGT2ZyV1NTU2RVV2VXbGpTWjlxVHo5YzVTMG14VnV6?=
 =?utf-8?B?VmQ5TVVQcUN6cDZKZ3NoWFNrZXdIemNSbHQ1bTdUYzM5WmZGbzNaZzRKcjZC?=
 =?utf-8?B?enV6ZDBndCtQSGxzZitUZWVGUTRxTHhWNzRKdTRjT1M1WHdxZDQzcWJzRkdo?=
 =?utf-8?B?VFhkL0k2eDE5QmM0eWlGNndxSFRvNG5oOVhXamxZSGoxV1BCYWNNNXFmeXlD?=
 =?utf-8?B?ZW9iQmNma1grWlZhNGhGc01YeG9RUStSM1IyNXRhMHkzWVNWWSszaTd5MGlH?=
 =?utf-8?B?aVZDMmYzd1BReFBkaWp0NHN5cXp0OUd3QW1uS0pmN1VGc2tjQk5yM1ByZHFB?=
 =?utf-8?B?UXpObEQremluNTg0VU9XbHpTK01sbm4rWFZrTHArUlRQb2tVUFJ2M2M1OUho?=
 =?utf-8?B?c2xMTEVBZkp5VjNYQVFrc0cwSEVBU1RITG92V3dQUU1QeFJZVVovT0xST3pB?=
 =?utf-8?B?T1JuMitMQkVDbEsxdmhMQWQ4djhqeUhNamw4UkViVlVuTUhVTnBJTUppM09X?=
 =?utf-8?B?eUNkd3N2K3NyQjB4OHhubTlSZTRHeWtodVE5Z0h2NFVIM09lakcrTW84NnBB?=
 =?utf-8?B?SG91V2dsMnp4N2YyZVM1dENQZnVQWkJBZE5WRXozMm9UcHJBNG9hRTArcEJS?=
 =?utf-8?B?VzVpbVVVZHFFeDFObU15TkxoZmJjdDFFbWQ5ZkZSbUVZV2l6b2E2TlQyZHg3?=
 =?utf-8?Q?A6RcYSclLl09wWD8zvh500LTE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a20e89-ae85-4a37-7c75-08da97d6dc69
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 11:30:30.5854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sH/gFsmhOVO+OWtZF4jWnK4wsHqVpK1VS6VU+NSJ2Om16KN2f7TAetrboHpNnsN50+2bruzlYuFGrD2ih8j7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5264
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_06,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160084
X-Proofpoint-GUID: ZTSsVXKLJHgHBiS5Bg_Zf3_IzAIsZKeE
X-Proofpoint-ORIG-GUID: ZTSsVXKLJHgHBiS5Bg_Zf3_IzAIsZKeE
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16/09/2022 19:11, Anand Jain wrote:
> 
>> +void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>> +                  const char *name);
>> +void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>> +                  const char *name);
> 
>   There is an extra definition here.
>   I think David can take care of it while merging.

  With the above fixed. You may add

  Reviewed-by: Anand Jain <anand.jain@oracle.com>


>   While here, I would prefer to have functions arranged.
>   Like, first, set-function and then its related clear-function;
>   it improves readability.
> 
>>   #define btrfs_set_fs_incompat(__fs_info, opt) \
>>       __btrfs_set_fs_incompat((__fs_info), 
>> BTRFS_FEATURE_INCOMPAT_##opt, \
>>                   #opt)
> 
>   Further, the #defines are in the middle of the function definitions.
>   I suggest they be at the bottom of the file.
> 
> Thanks,
> Anand
