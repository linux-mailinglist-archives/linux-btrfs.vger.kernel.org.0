Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870FC6A9424
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCCJaW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 04:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjCCJaO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 04:30:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6234C6EC
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 01:29:59 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3233jZb5024521;
        Fri, 3 Mar 2023 09:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qHBLHDpv0J2eRdY0WzeqfBuk+SznnkuARAxKSyd/tKo=;
 b=pJR5IMnsGiDwKzq6HKXH4WSYW3QFVAXEX8pBHU5bEOv4wI/cFVLrCDfpPJc4PsS1lX75
 jo7AbaenapKSw/j4Lh+jkUeBVGpeqTkAcDihc+K5YLNjGadifuB0YkR89CE85/J6t1tG
 yHeMSKNXhDCmwE6H9cJiI6g+p6tht/kG7GZ/Y9ev++sowSxW1/17PujUuHuXrS+5br5A
 +YZk5mL84w7a/eRbOGVuLLlvX9k0Sk83pXoJF/nigijwm9+4UuOD8/IyNnceVnXqm4P/
 7G5GEVaKbmfdtVvN56ORrMrpvFMWg7NIB9dSdipK4l4VPqmjU/GrfCHOmg2AsHHhVox6 6A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7nt9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:29:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3239TW1x034856;
        Fri, 3 Mar 2023 09:29:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8shbq5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=He/iGV0HfQZjb4V1rL9jQUSo+qGvN2ZreXZZRBsF7sTe+VPcej27//9d8Z2jJCLNit6md20DNdIw3InIkEKUwuDA/mRwy2JUpJweajWnJV+dSlMKPo0/4XB19wcUov2KDNaRw4Lw/pjBUaYCGQTfIuq4HStyDMTcDwhIx4gsVNoBxIKVHC308JBpUYRAo7U7jkMgdzjbOObm3FZOYAGSZA32sq3ZxJacfiMPcsmVNDvqpV+mm4CPu0A2H+Wtx03x7dyCy3JKRTgTGVqAXsfIYMl0nYcl0Pah+gst6szbvXvQYI/fgj6HnUY6vWbkpUSjFHOU5Q/SpnOWmkeUTpEBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHBLHDpv0J2eRdY0WzeqfBuk+SznnkuARAxKSyd/tKo=;
 b=WH/J01ZzzV5BrgFFLWykYfgGyHqqwIuWdIPy8k7DGwUH0CGnS95FAUAZEIm6Wy9DzilwYaWEJ9keO4Mu+1EaxhDHEe7kXLY3oG2/JqWdS17yxnh2cpUxI3UsBVgzAfr+sIBE8qq50laGwW7HejGkyYNLwswLm/2GuH7S1C5DuYe9kAtrYUBxJizCgPclH3W8Z5e36DxJJsv8UbOKL6mQKIJ8/LNiPWuK/qKTeUJbIuWW56pAdf1m1k34g5DaLizdDGjKG+NccHZJ4Nof695jX2zOCSI/32NClpPv/5wpyDc/C9BT0aDnjo+wgVjNqY4a5tkn0zTg9m8110CZ8BC+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHBLHDpv0J2eRdY0WzeqfBuk+SznnkuARAxKSyd/tKo=;
 b=gmxnnBgVE+raUr0AvxL4mmfBV1isnNEYdvX+vKsVumRLzmGPLPQVPcM8dzk0bd9o7muqq9ySj8n+k/Q5/8t47AsGofwi1luoAO3POAumKGmtee/pNyUrvqkSieJdPv7StdHXaKaGRdz3VzpaprwBZjH9+S4BcvfwRudjLNALU0U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6966.namprd10.prod.outlook.com (2603:10b6:510:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Fri, 3 Mar
 2023 09:29:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Fri, 3 Mar 2023
 09:29:48 +0000
Message-ID: <f1ad5ce5-4976-0243-3434-522d71687139@oracle.com>
Date:   Fri, 3 Mar 2023 17:29:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 00/13] btrfs: introduce RAID stripe tree
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1677750131.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbe9ccb-0d93-409a-8f96-08db1bc9d500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwbMxcdsD23/DyOxn0R51dtRMW9jUEF+dVM5vSKGtOeEN+637FU7sFbe+paAAxw1RX0rkfsYYoV/CBuhlLhSDTxbAOupnW0RYx7lRE195FFavOLb1+QzMuprYm0yDCmUU7qJAW2EQD/DXywz2qGnHjkeIdVPSnrkIjb80nrxj6Lqh0Z371Ip4qc/JysRLvJehchqGNJeJFMNRWFvhNghdWTPqFcySThY7+zpIDPBD6aBIC8ETgKxgJ+bWWKzCzyK7CxhDO1x23vPOg/r7ca4YW8u14VSc0I6LVlRPSon7t2ERKPftnpwa/ZVOxilcbdfjWqE2fOTLYJgT8RaNtWtoUUbsJmbXUysCawFlB7nK4WN/O3jGk10OEVTGYudKU5Q4Z7P/j0x8Ic2Hx2EtZqJBnbL+DUteEHfmH6Gl5SvmL+iqq22hoCLLjd1Nb+WfJ3FmEqU5cNw5q62WyOpYboqgekS1H+s8ellITEfupE6MKlQlByt8Mpdq8Iv2Jg17TJjCK+N4nzPUKjUZtc+NY3Zphm7NCu+hsfUDxyhBjNy4ATszsVBPR8jpnyGpuLy0+kx6hUlNYMJ5B0YQbekkkfLjPzAAoEjKBVOB4ZH5IcvXMhMEswed4jNFEQYfSqEnkucODaSQ2yoHLGchSMh7Cry9sYRy54tyDEjMv5hWUrTu8JVn+hLI1Hb0xGiDJeRXESeogK4Dcmb7pvvB3NFsW+8F2/CtFQbTiunD32LRiZ3tx7krt0rTiblwhUSSpder6pZmHq8aV21FdZx/D6jXW9Px+JEKHr85RJ7cZEr25O6YFgigIsIvXrCRd9R2SZet1bxI5BPJbrrvCW8IC7W2QqeDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199018)(38100700002)(44832011)(31696002)(86362001)(36756003)(110136005)(54906003)(4326008)(26005)(316002)(66946007)(66476007)(5930299012)(2616005)(8676002)(66556008)(6486002)(6506007)(6666004)(966005)(478600001)(53546011)(31686004)(186003)(6512007)(2906002)(5660300002)(83380400001)(41300700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmNScEo4RFViZzc0Wm1wU3J1ODBLRGYzY000TXU2K2ZpcjE3bjdycjhiZ3Vm?=
 =?utf-8?B?aloyb2lnN3lnRkhxeHdvaXR1dVVYNGI2TGpBSGZiT2RyTnFRUHZZYVFVTTdm?=
 =?utf-8?B?ZUlCZHYvTm1oTktxNjFrQy96UW1hcXoxZ2VGUktldk5heUY5Z3NJK0F3dEhE?=
 =?utf-8?B?RFRmVUkydnZqQWNlTks2b3VHdzZ6eVhOYkNGMEt4S1A4V1RkZVNzdGxzL3lB?=
 =?utf-8?B?UWRqZUQzT2I1RkJ0ajRDZWdiQmh3RVlrVk9RTDIwdllLUTdSamVyK1NFR1BO?=
 =?utf-8?B?WDEvZWs4Ulp2ZFF6SEtzSjBXRitEcldYbU1wMUoxZkl0MmZhTFJ4VE91TGVE?=
 =?utf-8?B?NytUMFVYZVdLL0pzTlRqUDlRa2VwNFJBdHMvR1pjb0p2a2w1VkxPelRyOENR?=
 =?utf-8?B?NmpjZloyTjUxMEJkZkxDUFQrNk0xdmIrTEVJcnFVWUVFWUhDbVJTRU1vSzVL?=
 =?utf-8?B?ZllHMzV4TlU0U00ya2kwQW53cnlMNUpTK3VITXh3VzQzQnl3dlhPbUo1V01l?=
 =?utf-8?B?eTZYSGUzb1lRekZDSHFueFZVRlBjditEWmhxcjhBenVGcTdrQzhkSXFzOFFM?=
 =?utf-8?B?Nkw5TXJ3elN6SEZsUytKV2VOb0N3YkFXK1VVeVhIRFZyelg4OVpBYno2bVNZ?=
 =?utf-8?B?ekpJaFpRYnpJNm5lbFZaODFHNGZ0ZjVoVkN2VVRObTh0ZXFoWnJ5S0VBdmpr?=
 =?utf-8?B?WEZNL3dtTVEwelhPVkhON0NWQ2xERFhvREJTa3pGdkFWS1RVVnh3OXdMOVRs?=
 =?utf-8?B?a0VsSk9XSCtDMFdEd2tSMUErTUF5WTRuUnJEL3Yxd3hOcG1pL1MvRzZNMk9G?=
 =?utf-8?B?UG1jZnhIS1Rlek9Dc0hIS3JpakhzZ0llSkc1U0hsOUdUQmNENjJIUDB5NXJX?=
 =?utf-8?B?R0VOWldXUU9aOFNuZFZ6aFp0ZElyeEQvNURyYTltMkY0UDRyNWwvNEpvTk1E?=
 =?utf-8?B?dnJxLytuNTdleUlIQTlyZDBpK3o3NXlEejErVENHbUQwWlYzMThnS1dicUVY?=
 =?utf-8?B?cXhyNVJtYW9FZWJ2SDNEMCtIV2VyRW5IelU4VUNycVZaUnZQM3FCQzlHMlVU?=
 =?utf-8?B?S0FuWWNMYVpZbUxKd2Yxdm9XQVFpY0ZsK3MvamZqRjdVODlxWE4wKy8xeCsz?=
 =?utf-8?B?STVEek1rUDMyTjFUNHpFS1JoZFFUN0pQWkMzRFg3b1E1MmNxRlcwY2Z2Yk51?=
 =?utf-8?B?NTk4cFBaU1pRVWp0K2Zza1RHMDEyMFBZSzJNMlBaVndaRmRCU09JbWNVRWc1?=
 =?utf-8?B?ZWlQNXBrZnVBNVpzOGdtQU5OZWxpZThsRnE0NktrVUlNSlNKVkhpSFZTeFUx?=
 =?utf-8?B?dTAzMzBHSi9udVZpSDZxWXFyNWo3SkFqUGNNbExXNmRHdVNpMzMyU3NlanMv?=
 =?utf-8?B?RzhWdzlqQktsWVRNS011ZmcwajYvcFRUU25iNVNJZVkxeXoxazZ3aWg2YzRu?=
 =?utf-8?B?ZzJhd1hDazU2YXA2eThHWUxUNU1rUy9kTzcrWnZhQm5ybHNEVUZMZ1NQR21j?=
 =?utf-8?B?dzQ5YzFDMWw2N3Rla2twMjBsM1Z1TWxRSUVpT3FUQWNycEs5U2dKbkcxdGdF?=
 =?utf-8?B?NXFMdWZybEFMZkhhMk1td0NGMGFVdWxYQlJ5eEFrOFYwZHZGZm5ncTErSFd1?=
 =?utf-8?B?ZHFJZXJLQkZHQ0dOQjJ0cWhza2RBdmUrb0dLcWZUSk8zWndaeU9rdnVSTnFx?=
 =?utf-8?B?QWZHMVQ4YmxnTm9hemJhUnZrbGJOa244a0U4NHA2RGc5eEExWklRKys0UStI?=
 =?utf-8?B?cDFpVm9MQUNlN05MNWZWL3J3TlhTd0lrR01wSnZnYUxmdnZkSFFXRlhkNm1D?=
 =?utf-8?B?TFY5TFI1aitHYWtPTG9KeHd5Ukx6MjR4cHFCYUp5OGJoQkVKbEtGbldhK1pU?=
 =?utf-8?B?OXhUb2FZUHc4S3hoMlFFYnNPRFppWGdBZzJTYi9qVmFReG5DWEhqMFdpejJC?=
 =?utf-8?B?RlU1c3VHSzdWV2d1ek9KTy9HT1J3dWNwZCt3VnNxWFdRUE1DeHk0Zy9tRHpR?=
 =?utf-8?B?TEJNbjIrSUJldkJISzhkUVgrUUNRNGdkQ0s2NDlmc1QvMHplTlowUTRsY1V6?=
 =?utf-8?B?UjZacTlmL0Iwc2xWK01KS1NoVlA2N1M2dUVRMU9naDBzK056ZEF3OC9wZG9r?=
 =?utf-8?B?aTRmWStEVlBwc0VKbDJteUdMTkJUOTlBTEx0bmo5TTBQeEdpSkFEVHl5N0I0?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CmvzseF1YyPhScdmRzVyO2rObfa4n5nVNqRMB4OhtZGEUc4gtBBAse9+NBhtjwjuJraabAOG+VX1XYZ+KaEZeiO+2hKx1HvyI2CoGYp9kbpPbxPjH7Hgy4n6FAwoFUDiJQ5Nx9WkECiNM+CPBDJnp1+96TozqdYYqOcZE2NK306wlwq1qOUVWr0F5iMqfS2FsOI7N9/l9nVjF0dHmBFC/YF4blZ1DLNNqbD96X67fX0YU9HLc8zICQBIv2x+4XHpEB+5b4GrVjeZqNCS7rI5XdzfJ8tCfaJmiAO4hg1oXaHvtH6/ZO0dRgQ7Pxs2FCe/g6MDh/C2QaC2z7nsOBTBr8B29RfE2KXDiVlc8PSVjjffTFzaNQZAvxPEAR/hwNzR725v8asXGL4kg00SLGa0TPrJfNYu9nmdMH9Bz7ipDcPzKlyNI3IpeCw71GvqGk/0iGrhFxfi+5rJgWwBCewXZJzTKRyOz2vtlEbwdetByJlS/lnzl0rcW796SBJS1G9VFgUWruPyy/WzhWgDLBvrcsDY1wy1XTU105X4BBPWIqc53HF3kejIFW366+zXDf57TqNGbZODRUdn+/4cZpEkidZK9SJc+6ERteYRo9KFalvd+MvF5xHxcgruEOJMxqKWTnQ4jF8CRq8+Nh9djGHCo0ajkVjZt8HlnlrKfDYVjnfE/00ykkSqj/11h9z8Sn+DgmjPuFFFPVLIuEUe+G+IdzMZN3OGUeOW1V3D94HjueDYrqR07RgyJ11ursUTDUeMdcr1gqeUG5czM/o8e7G/KQJnOAp0S7mZchTtCb9hTfPhnmvChuXQIXgH48YDyKWJH0iR6Pt8E7wk5EQ/u3q9noM2nZtd+9LJeG2NLIHXbp0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbe9ccb-0d93-409a-8f96-08db1bc9d500
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 09:29:48.0267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRqMQZDwCedMO+q9gj1RLLyDgeNTdJzmspKQcWBuj45K3jXodXwyuhS2hTIrvBlWO7HXh5oLzDn7Z40mN2Wv+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030084
X-Proofpoint-ORIG-GUID: jEPEk7ISUCrEaK_krw4y85x3NDAPTyj4
X-Proofpoint-GUID: jEPEk7ISUCrEaK_krw4y85x3NDAPTyj4
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Is there a plan to rebase this series to the latest misc-next branch?
Unfortunately, applying this patch fails at multiple patches.

Thanks, Anand



On 02/03/2023 17:45, Johannes Thumshirn wrote:
> Updates of the raid-stripe-tree are done at delayed-ref time to safe on
> bandwidth while for reading we do the stripe-tree lookup on bio mapping time,
> i.e. when the logical to physical translation happens for regular btrfs RAID
> as well.
> 
> The stripe tree is keyed by an extent's disk_bytenr and disk_num_bytes and
> it's contents are the respective physical device id and position.
> 
> For an example 1M write (split into 126K segments due to zone-append)
> rapido2:/home/johannes/src/fstests# xfs_io -fdc "pwrite -b 1M 0 1M" -c fsync /mnt/test/test
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0065 sec (151.538 MiB/sec and 151.5381 ops/sec)
> 
> The tree will look as follows:
> 
> rapido2:/home/johannes/src/fstests# btrfs inspect-internal dump-tree -t raid_stripe /dev/nullb0
> btrfs-progs v5.16.1
> raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
> leaf 805847040 items 9 free space 15770 generation 9 owner RAID_STRIPE_TREE
> leaf 805847040 flags 0x1(WRITTEN) backref revision 1
> checksum stored 1b22e13800000000000000000000000000000000000000000000000000000000
> checksum calced 1b22e13800000000000000000000000000000000000000000000000000000000
> fs uuid e4f523d1-89a1-41f9-ab75-6ba3c42a28fb
> chunk uuid 6f2d8aaa-d348-4bf2-9b5e-141a37ba4c77
>          item 0 key (939524096 RAID_STRIPE_KEY 126976) itemoff 16251 itemsize 32
>                          stripe 0 devid 1 offset 939524096
>                          stripe 1 devid 2 offset 536870912
>          item 1 key (939651072 RAID_STRIPE_KEY 126976) itemoff 16219 itemsize 32
>                          stripe 0 devid 1 offset 939651072
>                          stripe 1 devid 2 offset 536997888
>          item 2 key (939778048 RAID_STRIPE_KEY 126976) itemoff 16187 itemsize 32
>                          stripe 0 devid 1 offset 939778048
>                          stripe 1 devid 2 offset 537124864
>          item 3 key (939905024 RAID_STRIPE_KEY 126976) itemoff 16155 itemsize 32
>                          stripe 0 devid 1 offset 939905024
>                          stripe 1 devid 2 offset 537251840
>          item 4 key (940032000 RAID_STRIPE_KEY 126976) itemoff 16123 itemsize 32
>                          stripe 0 devid 1 offset 940032000
>                          stripe 1 devid 2 offset 537378816
>          item 5 key (940158976 RAID_STRIPE_KEY 126976) itemoff 16091 itemsize 32
>                          stripe 0 devid 1 offset 940158976
>                          stripe 1 devid 2 offset 537505792
>          item 6 key (940285952 RAID_STRIPE_KEY 126976) itemoff 16059 itemsize 32
>                          stripe 0 devid 1 offset 940285952
>                          stripe 1 devid 2 offset 537632768
>          item 7 key (940412928 RAID_STRIPE_KEY 126976) itemoff 16027 itemsize 32
>                          stripe 0 devid 1 offset 940412928
>                          stripe 1 devid 2 offset 537759744
>          item 8 key (940539904 RAID_STRIPE_KEY 32768) itemoff 15995 itemsize 32
>                          stripe 0 devid 1 offset 940539904
>                          stripe 1 devid 2 offset 537886720
> total bytes 26843545600
> bytes used 1245184
> uuid e4f523d1-89a1-41f9-ab75-6ba3c42a28fb
> 
> A design document can be found here:
> https://docs.google.com/document/d/1Iui_jMidCd4MVBNSSLXRfO7p5KmvnoQL/edit?usp=sharing&ouid=103609947580185458266&rtpof=true&sd=true
> 
> The user-space part of this series can be found here:
> https://lore.kernel.org/linux-btrfs/20230215143109.2721722-1-johannes.thumshirn@wdc.com
> 
> Changes to v6:
> - Fix degraded RAID1 mounts
> - Fix RAID0/10 mounts
> 
> v6 of the patchset can be found here:
> https://lore/kernel.org/linux-btrfs/cover.1676470614.git.johannes.thumshirn@wdc.com
> 
> Changes to v5:
> - Incroporated review comments from Josef and Christoph
> - Rebased onto misc-next
> 
> v5 of the patchset can be found here:
> https://lore/kernel.org/linux-btrfs/cover.1675853489.git.johannes.thumshirn@wdc.com
> 
> Changes to v4:
> - Added patch to check for RST feature in sysfs
> - Added RST lookups for scrubbing
> - Fixed the error handling bug Josef pointed out
> - Only check if we need to write out a RST once per delayed_ref head
> - Added support for zoned data DUP with RST
> 
> Changes to v3:
> - Rebased onto 20221120124734.18634-1-hch@lst.de
> - Incorporated Josef's review
> - Merged related patches
> 
> v3 of the patchset can be found here:
> https://lore/kernel.org/linux-btrfs/cover.1666007330.git.johannes.thumshirn@wdc.com
> 
> Changes to v2:
> - Bug fixes
> - Rebased onto 20220901074216.1849941-1-hch@lst.de
> - Added tracepoints
> - Added leak checker
> - Added RAID0 and RAID10
> 
> v2 of the patchset can be found here:
> https://lore.kernel.org/linux-btrfs/cover.1656513330.git.johannes.thumshirn@wdc.com
> 
> Changes to v1:
> - Write the stripe-tree at delayed-ref time (Qu)
> - Add a different write path for preallocation
> 
> v1 of the patchset can be found here:
> https://lore.kernel.org/linux-btrfs/cover.1652711187.git.johannes.thumshirn@wdc.com/
> 
> Johannes Thumshirn (13):
>    btrfs: re-add trans parameter to insert_delayed_ref
>    btrfs: add raid stripe tree definitions
>    btrfs: read raid-stripe-tree from disk
>    btrfs: add support for inserting raid stripe extents
>    btrfs: delete stripe extent on extent deletion
>    btrfs: lookup physical address from stripe extent
>    btrfs: add raid stripe tree pretty printer
>    btrfs: zoned: allow zoned RAID
>    btrfs: check for leaks of ordered stripes on umount
>    btrfs: add tracepoints for ordered stripes
>    btrfs: announce presence of raid-stripe-tree in sysfs
>    btrfs: consult raid-stripe-tree when scrubbing
>    btrfs: add raid-stripe-tree to features enabled with debug
> 
>   fs/btrfs/Makefile               |   2 +-
>   fs/btrfs/accessors.h            |  29 +++
>   fs/btrfs/bio.c                  |  29 +++
>   fs/btrfs/block-rsv.c            |   1 +
>   fs/btrfs/delayed-ref.c          |  13 +-
>   fs/btrfs/delayed-ref.h          |   2 +
>   fs/btrfs/disk-io.c              |  24 ++
>   fs/btrfs/disk-io.h              |   5 +
>   fs/btrfs/extent-tree.c          |  68 ++++++
>   fs/btrfs/fs.h                   |   7 +-
>   fs/btrfs/inode.c                |  15 +-
>   fs/btrfs/print-tree.c           |  21 ++
>   fs/btrfs/raid-stripe-tree.c     | 416 ++++++++++++++++++++++++++++++++
>   fs/btrfs/raid-stripe-tree.h     |  87 +++++++
>   fs/btrfs/scrub.c                |  33 ++-
>   fs/btrfs/super.c                |   1 +
>   fs/btrfs/sysfs.c                |   3 +
>   fs/btrfs/volumes.c              |  46 +++-
>   fs/btrfs/volumes.h              |  13 +-
>   fs/btrfs/zoned.c                | 119 ++++++++-
>   include/trace/events/btrfs.h    |  50 ++++
>   include/uapi/linux/btrfs.h      |   1 +
>   include/uapi/linux/btrfs_tree.h |  20 +-
>   23 files changed, 973 insertions(+), 32 deletions(-)
>   create mode 100644 fs/btrfs/raid-stripe-tree.c
>   create mode 100644 fs/btrfs/raid-stripe-tree.h
> 

