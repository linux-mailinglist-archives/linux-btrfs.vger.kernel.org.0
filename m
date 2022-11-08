Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9368E6207A6
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Nov 2022 04:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiKHDjz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 22:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiKHDjw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 22:39:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB4C615F
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 19:39:51 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80Nrtr014382;
        Tue, 8 Nov 2022 03:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7y2OWGV0rkZUlU/1mWsDgLQPIPGkuwl0gHT8iNLH3ZQ=;
 b=SJN07qdOl5GbIpr6A2MRwhH9oiX2EMB/J+Qv5GScvC6AtOrLRj50qIfseAcZvm5su5s1
 jc84wT+XxVMs6cnk2G9HDoYUNwQUYpYCRYgApEfaaL/j6lT9Kn9JMgBxRTawUsghBTlS
 /k3ole+xDLkWfLvAFoDdagCH8McqB+X0ljaP/6hx8tLxIBUdzxSljZSJnxsPrwDa4YF4
 m1MxPLmsCHzVdfu/VLkuwF9e9y0drZp2glew+fp2ZuCUrPI1pfTM4fRdPOPLzTr3bmtK
 tD6PCS99ndeETBlqcBBxLxWhi+1RUEgcwsa6VvafUiuPlGUbPwIg4H9FSh5DoyaUL9VT aA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngmj5na6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:39:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A82U1CN014423;
        Tue, 8 Nov 2022 03:39:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq1f65t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:39:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBPOORx/pCtzbBOmMaYzckG/06eeBVGlv/PC6/1Y/TDArqBGDl4joGzCUrqqDuM/kzGoaB3u/bAixZUDlXv7PJhvWe5As0wvlE6Eh/qlC5I2wcddtCCSKbcwzTDFYDkQc+D7B1IkFsuIONPpHezzU2Zbr18m8Bh021TZKouCQIZk1JwA7Ta4RZzcsmvqlE3iyRJF2A4TcY9dLiBmlTbD/MxHJAik3kQdQziTszqQ3VZlyLeXFdIP1j5rb+qsayALngncqxUgkUM9P9kAJtPHnuif+MjvH01Ip9mLYtonX4Gg6H20Zwd73M2W4dmRr452Q01jKXSQbPprXdJFBJWdiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y2OWGV0rkZUlU/1mWsDgLQPIPGkuwl0gHT8iNLH3ZQ=;
 b=WNn55MwKVyr0fZC/74wxtGY3fETdy5p2R/bv6sL7emlOtzIZ5/l4r/dsQU2tGwwRaTiF+6mi3LZo1iCODURC6wpty/SksK3daGBzPKrvdPKjXVwo5mZl9dNL0rpuwUNNzIdDENNGEuveof+K5en/jBaUfH2wtTblj2dn1rNaJk9spBSN3urjlQh6BKQraPM8/i/xVIhXTfJ3JiFWfi7eEmAM2j5QMsRK+PwhmSZkwgrU4eC44nNHqHJfARxGoe7cRqF6mZAaPkqJwCB2D8/fct/U5G3zAv3L9XrKn358hwUKkV0XaxZ+rF4EIqP/2hqIoKCIFJl9SvMTo0C3GJha/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y2OWGV0rkZUlU/1mWsDgLQPIPGkuwl0gHT8iNLH3ZQ=;
 b=dD/cXUjfq5oCpXaUlh+dIpbohP34U12nlMWf5w8/IBeWxYxbVNs52Y7+dYRV8aqmDawx2OXf5sqV8o2UcBVhywHo4g8GzWxLH88rpENC4nUD0PidM/iWyLtKmh4AmISbaqsnOKT9kRNh+d8KhTuxfYMX86ZJ5q9GT3Xu3C4zRw8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5326.namprd10.prod.outlook.com (2603:10b6:5:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 03:39:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56%4]) with mapi id 15.20.5791.022; Tue, 8 Nov 2022
 03:39:41 +0000
Message-ID: <ec13ced6-b01d-50db-1c6f-84bf18727689@oracle.com>
Date:   Tue, 8 Nov 2022 11:39:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] btrfs: move device->name rcu alloc and assign to
 btrfs_alloc_device()
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <558d3ae7ad53788c05810ae452cece7036316fb2.1667831845.git.anand.jain@oracle.com>
 <3b5ebb57-af2a-7cf3-6f2e-75d64f17e853@gmx.com>
 <20221108001258.GW5824@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221108001258.GW5824@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: b35a6647-996d-4770-4f60-08dac13ade86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XNVvdCZtkGtgDE43ZVnYZ8R87XqfFr4J3WjZal1uLTWt8LP37Yy04YU3Hm6G6z6FAqOEdacZ4eFg0D5OZQalViYax7f8sO5vAdYf15LKFKr47aFjJiaJk237txJaQcg5TnCZNWXjWbS80G/Rzi0vHI0Rcy9vH7UXeQaHvKgXZqUXXVG8/Km7u+ioeG6jwJDVlbpu7O5ZrcZPvOGROpMjxOHfmPNyzTpA/4vZxVuUWfAS3KD0fLS10IAmOPmSWXBuO+lyM4ZKvZxkBuuZoWLgD+GxJMyCwFnQyJLs53WVN8aFe3pEdHqzgz+LjFF5K950Ts0v0y+lFJsLGI1Q9f9uDPZV9s2soG+XLPnRsRGBvGvKNOTMNKRBbrDyyKVw43WmcWqItV1zTLQRlHxjbWrU5z+Hbbn4nyHQzpVoZFh1/dCWOogtdXahe1DF5HtPa+NSLD9GXMmpAH8w+Ei5o7Xu9dlSZ/NaNLhK9BlNIZHZgAGO6+e1sgYCjBsBKzG3MCV2jQ4X/XqVbQuWQ8KW5ro+DBToyE9/faYoVIsKwj/ByByFz2OXHfEHn1+y7EF/KHe5C2U6Ndg5bCvxkZnXroaoqoDXf/twBp3/zo15JMi0Gi7NowYKZP/j3fO3s7TqUDINLsT6CgUv47Ylt7FSH04jRDctMBTFT00MKPTSALkdWYPETOOphRydrjq4+tFXAWA69AizHzw6LThwLehCh8ru80+9pfe3hgl/uRH4vfQ8MJFqPV1Bik/rVkdShvyUSYRKURV1gvLvj+AjEu7TBFeDrLti5QWtzenkRD2DC//wdGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(36756003)(31686004)(38100700002)(2906002)(86362001)(44832011)(186003)(83380400001)(6512007)(8676002)(26005)(66476007)(66556008)(2616005)(6506007)(53546011)(6916009)(316002)(66946007)(4326008)(31696002)(8936002)(5660300002)(6486002)(478600001)(41300700001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0RiaHVnS1g4K1k4N1NRZmxRRldVbW4wcWhEcm9DOFovKzJ5NTlOdkRrcXhH?=
 =?utf-8?B?dVhEYWZsc3QrckVKK2NrTnZra2hMcWZUV05MUGVDcXVHdkp4WERXenVGOXpP?=
 =?utf-8?B?TktVMzdHYW1KSFNkZ2QxSlZ1bmx3d1hWR0hia1NnSS9maG9PTXhnNityYlFD?=
 =?utf-8?B?WkJJSVUwSGZEQ0xnd05QM1daYWNBRjhoRzdweUh2UmRYQWZKanZaVmM4UVd0?=
 =?utf-8?B?NVNMZWhUd0x3TkZTVjUwelJVRWpROTl6OG9aSVZ2bVJ3UXJWV1luOW9zN3pW?=
 =?utf-8?B?alZjKzNjZGFGaU9UVUtQTG82b3VsZUJKMWpyR2xQeFlLS1E2R1FqbHpnUk1O?=
 =?utf-8?B?R2JZQnlWZWthcjhRVlE0UHZHc2NxMkpRSS9OUFFVY25UUDdDYVhCYVpkeFMz?=
 =?utf-8?B?YnpNMGVVSkdiS0Ireml1SitLL2RNaTd1UVEvMVltT1BjWnJuVlhmcGpYUEs4?=
 =?utf-8?B?eTNHU3k0ZFJXZXFoY1RkV25NaVNpS0hqRDIrWldoeWxyWDh6NFBnVXJ5VWwy?=
 =?utf-8?B?c0VJaWxLVE0rejB3Q3krUGhIekVlNTFoc09yS3VGRG52Y1FPU0YvTzNOQmR0?=
 =?utf-8?B?V0RXZ0N0YXQwc3VWeHpVMjZsTEpCcHdYZ3NJcE9rZDE2L1BmUE90UW1HYUZJ?=
 =?utf-8?B?UUJ2R21CUEZ2ZDBrOTNwemVXb2JVcGJjbjBpaTRnM0dYMFFBVXhPcHZzeVI2?=
 =?utf-8?B?Zi9SdTYwRjgzRTRFZVRTN3QwSUJUOTJIR25uOU4xVWxqTG5UMXBmOHpRd1Bn?=
 =?utf-8?B?ZHp3Qk13bzNJUjd0aWN1Q2NQa0R5cDZ5Uy80NzB4RUJNRDFtTDJSK1F3djU0?=
 =?utf-8?B?ZVNlWmJtQk9VbUdZcHUrNGU0VzR0MGEwWGhYU2NQbm8vaWNOR04rZXBOU0Z4?=
 =?utf-8?B?S2RWUEZTMmYvMXBKWVMzUUNNSENMUTlrTzJ2UjJRZ3JmcWQ2NGJ3V0NyN0FI?=
 =?utf-8?B?UVVPQi9za1d2NGVSZlJPcDZOREhUUmpaVG4vZ3lxVzhseFhMcVUwMWhld1cy?=
 =?utf-8?B?ZWYxanJlWGIwaXhFQ3JhWmZab0h6YmNzVjd4Tm9OK3lIMlQ4TDFaYWhNd1FL?=
 =?utf-8?B?SWdwNmgxajYzem03L3FiOXI3WCthM2FRTXRUMTNhUWhiQ2tCSS8rOU92MUg1?=
 =?utf-8?B?TkJna3pibjRJMmFYSlJQb3JGYmJ6aDNodE9MUUYzcFdsOG5sWnNRajFrUFRm?=
 =?utf-8?B?R3A3MmhRc0JPd3NTbmRoMjdyUnRxaG5keGxwZTFmNVY2eGw2RVVHNTVPUVov?=
 =?utf-8?B?ODdQekRQYzdkT2huSkZhVnhhR1hSNUgyVlVqWkZ0SzVpc0N2SFlRMHQ5bDli?=
 =?utf-8?B?amN0MTB3YTBRY0FSaHRJMWR3MTB2MWtmNkg0TWRzYmE0azVjaDRmMmp2dFBw?=
 =?utf-8?B?OVFvUCt6RWRjdWZtRlpNUzlLOGoxZmZsSHlPYUw2NHc0cHMweVJYaFRicFdO?=
 =?utf-8?B?aUZGdXM4QkF2bUFxNXp0OVU1WmtPSERwTFM3OG1LUkk1bVB1emtUOFF1UWlR?=
 =?utf-8?B?bXh6ZmN2bEgvTjNiT0ZGQ2EwajE3RldUN0pwYVI1THhHeEs5NXZwZlU0eTZD?=
 =?utf-8?B?V1MyZnZacjhTWTd0cjF1bGtnSlFUTnVNOEpUeVRiWVlrSFZnVkRLVUpXNEVh?=
 =?utf-8?B?TXJ5cS9HcTVGbEw4d3Q2OWQyeFVrMWtjd21BQUJ5Nm5LOVk4M0JiNmQvTVRT?=
 =?utf-8?B?UFIrSitDWFlGS3QyaW1waEtTZUhYMGhyT0t3NnorS1dsUzNFUzY0ZzIyQjRC?=
 =?utf-8?B?NmQ0Z2FtcDZWcDhIdUxJaGFEakk5bWtmZEZZWGVMbDhuVHRvcjRKMUR6MDdX?=
 =?utf-8?B?OFBYa3F4TzJWbUlSR0JwVVhGTmN1OXd2UndPeE5BVmt0RFdNM05kRDVJN3Ax?=
 =?utf-8?B?RERSY3kvYURmZ1Q2TkxZbTdWVk91RXBCY2h6bXAwTDFZZnYyaUVRY0pIRGV1?=
 =?utf-8?B?T1R3UzBuZ0JkMDlyY0UvSVVJWXhXdlN6Q3VrOTN2eDFpQzRuSE0rU1I0RXlp?=
 =?utf-8?B?dm5vMGdWbnlzZXBtQXBpbDUxcjd0VHNPRndXbVA5bHlJUWpzc3BKdUNDY0Rr?=
 =?utf-8?B?RStUcHQ3c01CSVF4S3ViUXdqSFRSMHlyc1NjMTJsRkNjUHBjSWdKd3ROck1R?=
 =?utf-8?Q?OyHq39VQJvmxVDUKgi9f37Yji?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35a6647-996d-4770-4f60-08dac13ade86
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 03:39:41.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: id4/bxsSRZIbWO0XaoxlV4sGhfAgzEQMDb6XcOvUnTaTlsBQo85QYG2bPqWofEv6dMPdMyRLOpbo/I38AW3dxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080018
X-Proofpoint-GUID: HerWXDNeNBiqxwLD1CY1wnZ0At2gR1K1
X-Proofpoint-ORIG-GUID: HerWXDNeNBiqxwLD1CY1wnZ0At2gR1K1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/11/2022 08:12, David Sterba wrote:
> On Tue, Nov 08, 2022 at 07:45:08AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/11/7 23:07, Anand Jain wrote:
>>> There is a repeating code section in the parent function after calling
>>> btrfs_alloc_device(), as below.
>>>
>>>                 name = rcu_string_strdup(path, GFP_...);
>>>                  if (!name) {
>>>                          btrfs_free_device(device);
>>>                          return ERR_PTR(-ENOMEM);
>>>                  }
>>>                  rcu_assign_pointer(device->name, name);
>>>
>>> Except in add_missing_dev() for obvious reasons.
>>>
>>> This patch consolidates that repeating code into the btrfs_alloc_device()
>>> itself so that the parent function doesn't have to duplicate code.
>>> This consolidation also helps to review issues regarding rcu lock
>>> violation with device->name.
>>>
>>> Parent function device_list_add() and add_missing_dev() uses GFP_NOFS for
>>> the alloc, whereas the rest of the parent function uses GFP_KERNEL, so
>>> bring the NOFS alloc context using memalloc_nofs_save() in the function
>>> device_list_add() and add_missing_dev() is already doing it.
>>
>> I'm wondering do we really need to use RCU for device list?
>>
>> My understanding of this situation is, btrfs has very limited way to
>> modifiy device list (device add/remove/replace), while most of our
>> operations are read-only for device list.
>>
>> Can we just go regular semaphore and get rid of the RCU scheme completely?
> 
> We can't get rid of RCU completely right now but as I read your
> question, it may be possible to unify the read/write accees to one
> locking primitive. I'd like to get rid of the RCU and have tried but
> some sort of locking is needed around device name as it can be chnaged
> and read independently from ioctl and many printks.
> 
> But, the device list and RCU is a bit different. The RCU access to
> device list is used in the ioctls that basically iterate devices and
> read something. Here RCU is the most lightweight we can do, next is read
> side of a read-write primitive.
> 
> I haven't looked closer for the device list, but the rwlock or semaphore
> could increase lock contention in case there are multiple readers and
> writers. So, an ioctl that reads device info (read) can block any write
> access (super block commit). Here the RCU allows to access the device
> list for read while super block commit can proceed. There are maybe more
> examples of the read-write interactions but I'd consider blocking super
> block write as a critical one so I pick it as first example.
> 
> What we have now is is quite complex but works for all scenarios: device
> scan, device add/remove, all vs super block commit, mounted or
> unmounted, device name change at any time (vs printks). We could
> simplify that, but at the cost of increased contention "correct but
> slow", or "complex but you can hammer ioctls and your filesystem will
> write data in time".
> 
> I don't want to discourage you or anybody from finding optimizations,
> small in terms of performance or plain code, like this patch. We might
> hit dead ends before finding some viable. I thought the RCU for device
> name can be replaced by som some locking scheme but it does not improve
> things, RCU (and the _rcu printk helpers) is still better.


Thanks for your thoughts on this. I don't see any better alternative 
other than RCU. Maybe if we consolidate RCU access, it will help us to 
stabilise it. Let's see.



