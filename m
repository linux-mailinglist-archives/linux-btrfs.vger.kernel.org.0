Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB677A2ADA
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Sep 2023 01:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbjIOXGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 19:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238107AbjIOXF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 19:05:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB5C2707;
        Fri, 15 Sep 2023 16:05:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLwmrU027829;
        Fri, 15 Sep 2023 23:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VaJUaL3Qy6ErSAcnC9H1wve129BYoR48IYC8TGJqoIg=;
 b=sSqDhhJdap/x7lfuENGEvSX7WoAlp3q8BtrHmFniwHy6uL+lH1EhtqHQpzzCQBV+k6t3
 hxQGOwjXF3rxtFoFIph0kP7w/ePh/TKUdBV5u8pHByrle31SLxnPvn73Ppw1AF9Vnl/6
 MMsM+dVq3Drpus35Sijg+AVQn1Vh6yaqeoGXva9BDscjgmeyK59NknZDU9sLN2c8IKAF
 bPQ2/PCxUacC3K815cEdPoFhZPdLW3zIMBGnnK64MiMqJ0LS9KKay/azVejoGue3PSpJ
 O6IEuZnmlh2RevQElggzyNQcbULQSFJbcrQvcyr7cwUdTQwEMPzTMYgNy9eQqrSXKVaM EQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kgtxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 23:05:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FMoYfR007339;
        Fri, 15 Sep 2023 23:05:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5beawg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 23:05:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zxl8E9dA9u6FDvNgzVUfjmrj/nzbXfBG47ehqkj9S2ssgjGocgsQ91yQlzKgFy6EgyX6mKXQA+ecQ8GS9nE8mP/FnaT9W+MKvGG7k1vwu370VGM++yNX9JZ/4nhdoUFpqrVXo8w4iP3EcmvPpTKA2UqzdhCYWDHqh4pBF0O0YHHXeWlR1+8Up8Pfl+FJrC2mw/B2616yEUHp/KTXpjAQLL1otRio7D0Ojz662YJjBTv4sMKLRFCTftupJeoFkv0agkyJPjLuR+ZnccjGWmvm+hIHFzksgUF/5HZbG7TwAuzdwC6fIAor/bclx1UNImaIE2CkITKUaiS1MdQruGed3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaJUaL3Qy6ErSAcnC9H1wve129BYoR48IYC8TGJqoIg=;
 b=ECv+OqUvDZuY0EhBugHZ6ETAtYaP+b1/AC9Wul5nh0PT5EVQZ+pyRp1xnvxUOCrAk16ihiR73Hy8wPHX+DunCcGJVb+y0aAUzD64S/v4RwKRh+NEZOMo5eyDfsCHsfoG8vi6UIm81EI4ueHbMYdPeHA5dCso4R0hkL9Am0SL/3bUvbszzQ07t8kbSD4fQogj+inzkCn+OHYkAZgnFrIXLfMYt/l+X9s7lecRhCV2i2Prw0OJv0UehCUo9kfNaSTKuCZyNv9qq7fwPVAf/ZYxf3ofU3xMv8LrtbivHp8BD6ueJ3HWLY5CNd9muV9kVcuMVjO37+TyfMbBuBXy9Rkg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaJUaL3Qy6ErSAcnC9H1wve129BYoR48IYC8TGJqoIg=;
 b=zeZ9IjSvhaoRWTP0UltAWOIyEClV/rECCUDAPAjxl2Q0rvwhfxtzAZiaYgCAI57keffAKcdkNCMnLRSVXUa/B61xNHfhYzv0htvozesJ9lvjPntMXftEMxPJFl0b9xoYwt/6/m6MAVawcBi0QsE4I1658nt2bsXnc87l1PtEZnY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB7745.namprd10.prod.outlook.com (2603:10b6:408:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 23:05:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 23:05:40 +0000
Message-ID: <a0bcfebd-b5ca-c868-8ed8-49baec5862bc@oracle.com>
Date:   Sat, 16 Sep 2023 07:05:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: add missing commit ids for a few tests using
 _fixed_by_kernel_commit
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <be0250a9232aa614dd07b40e8cbbebb591fc3e0b.1694769988.git.fdmanana@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <be0250a9232aa614dd07b40e8cbbebb591fc3e0b.1694769988.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 2015dfb7-74c6-4b90-dbf3-08dbb64047c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0Kp0vpgKvSequnSHm0rab3asuaHDonZ9oPSNDXdJCspoRsGoJWtHk5E5OZ7SuwevPo/a4mlwsfFyLuJiXROAx56rTJl/Zb5ygFbthGoXDGhYWfdXsd7ffVJuWPU7pxr/XoUR8v7ijt4ZO7aHJ3lOpfIbcW4qfoRoG46mej2qmXSLN9z9WxJPiyN0tHpKWusWdLoPM2kZAlC4ZxfQv/+B2vtNZEzhnL5cZ8gNILemqr3oA1tr8zURdQo61qrfVAv0eRFoVFA4D47l69DzjhgFs+dFreLd4uf0JcKU9Mi8l1zO+FKT3h7LllEaXqfO7PpeAgZRzbcNGEllwuCMhNVCRwMIu2Vw2YaswgilDf9TX4Rm3qsc36mmdIelGlLJlwKBYOtYRQb7uiI9pCzosEDE7Bi9wPYjBASIeqeV42VrOk0wzHg2EcywhNpa0Ns4pSltrwkbNNGcH6x1VC2RMlSfjmBYFfQSrSX4uOCYnal3TQN+D+sGz/yzv0snn64HCtlHufqhZ98ziXpQ1xvWQ+qyubk4tIA/U6h1L6Qqf5WSoA/W66ZHh5vmfjOEze1QBM8YlIMGiHJ89y9pfl1gkWkl5e4frus4aEUdZ0d6iVs/vjxjltJyifmovzpcLn3g+E6hA5gqGtB1fhAwYm/SYBBsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(186009)(451199024)(1800799009)(31686004)(38100700002)(478600001)(2616005)(6506007)(26005)(6666004)(6512007)(53546011)(4744005)(2906002)(86362001)(44832011)(4326008)(8936002)(6486002)(8676002)(5660300002)(41300700001)(66946007)(66476007)(66556008)(316002)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXpPbHNuWDZiTXdiZnJqaHJPUkprY0NTM1BxbEo5NDVha2IxL0k3ZlB5T3cx?=
 =?utf-8?B?TEVLV1Vqd01reFllRTNGc3ZiVnlUcVlhSzcrQmR0d2RIRmcrYmU3NEgySzFG?=
 =?utf-8?B?RUZyLzgwL0lOOXVncGVoNlhpWTI0RGlhTGxiZW5wMGRhM3dCbEhJM0xBdm83?=
 =?utf-8?B?MjhZMjlNT3hMTU4zUVQxVndwZkhFNStSb210VGRvQ3dTQ3Y2dEZVODRSWDhN?=
 =?utf-8?B?RmZBMWFNNk1WRStKV0lUWm5aZ0VMNis5dG1sMmlnQ29XZmZBK0hYTEt5RVZs?=
 =?utf-8?B?R3NobUZRcDBmYUlFMVVka0lkNElJcFlqV3VPbE9KMjkwcUwyRkovR3EwLzNM?=
 =?utf-8?B?R0JWNlEzRWE2QkJjUWl6a3FmdlZselJJYUNUL21nbVVSeDdIWXAwK2lEQkNL?=
 =?utf-8?B?NjN5N3JhV1JWWkNlemNYWk9CVm80bFFZTWVwaEUvR2kwYkNGZllhNlh5OUY4?=
 =?utf-8?B?bjk2VTJBeGpJWHpWcUtBOG1ibUFjbjZvOEFmVGFqZzJzaGZzVDdaQzNsN2FR?=
 =?utf-8?B?Q092Vnhsd3dUbmVtbFg3anRzVVdPTEZEZ21uS0xBQXZRM0N2WUlTY2MwWm8x?=
 =?utf-8?B?S1MybkJPZWtxd25uTW52Y1BHL01aZFhhb2NqVUhLU2QvMk9lM2ZNRjRuWXZ0?=
 =?utf-8?B?WkN1S05CaWE1UWpFN25WR2kzalNJaGhSTmpHakFEbHhTTVA4ZGpIS3lkYk4x?=
 =?utf-8?B?MkNnMi9FUDRUN0NhVlZxNVZHd3RWRXpHZ1NwekI3cTBnMFVoUnlHN3pMQ0Ra?=
 =?utf-8?B?RENiUFJMVXZoWGxzeXFvZXU3SzRGSVdxSDRIZkRFWHNDTDNQUDhHWFVGWTZk?=
 =?utf-8?B?STlWMVlnNU9MVXlpQmNaVXlEOGhENXRSSUVTQjBKV1kvR1FwMVRjeUtIVk1F?=
 =?utf-8?B?NkxBR3dnWXFRakdZKzJZbWllNVJ3S3c4eXNIUWVKQm5MMXBJS25DZHBjaGJY?=
 =?utf-8?B?Z1B6bDFpcFF6RkdUK3VWUVhDeHNqd2xOWjZsTDV3bzdNWGZSdG55UlZQYklZ?=
 =?utf-8?B?ZVhmejBXNXp6eHZsYTlxcERmODNodElteXp3VnBlMHZvV0w4RG5xdWNJbFpH?=
 =?utf-8?B?OUkwTDVxd3EzN0Z0SmFGMnhKNlQ0MGhSVFFSKzF0Wm1heE5vbWJkbmtyYytp?=
 =?utf-8?B?QnJWSW9nMHV3R3lKSzZ1L0hoQnlNZndhZGRRbUVVYW9HcE5SQlNwd0p6NGp5?=
 =?utf-8?B?T2tXMHEvRnFSQmFPUHlIeEQxV3JRbHJFbTFoZ0NUU1NKbDJOeE1UU3Fzb09Z?=
 =?utf-8?B?Z0cwQ3ZHeDNhVWpUYTcyZW5JdG43OFdxM3lRUzU2Z2hEandhdFZHZ01QdGVG?=
 =?utf-8?B?M1VRUWk0V1VMRWJvRlJRVTBBcXBnZ2xZYkovNU9xTUo1TlRXVHNMOWN2dFNp?=
 =?utf-8?B?YW9XNTJLR1F6Ty83SFgvbk1WazFTeEJ3OWkydjBkam5peGZ4VzgvQ1QzcFBQ?=
 =?utf-8?B?YXZZRi94Z2ZJNnhDZ3NqVCthNDNJQTE3QUhKMEUzMVpMdE14bUF6Zm4zck1y?=
 =?utf-8?B?OGtCR1ZVc0x2MWRYQ242V281UnBkTEwyMG8vYUZLOHI4L0ZqUHJHT0g5UkFx?=
 =?utf-8?B?RFdLd0ZzejNwM0hCdDY3ZS9Wb0RFeVBxbnRhNGFqb2lraktXS0RCZ2E1b3h6?=
 =?utf-8?B?citVNVdqRWRENERvZnBMZDJDc2pZMjQwYm91VlB6NU1YS1JNQW1VTnY3QnM2?=
 =?utf-8?B?VmNncW1ubDZUYit0c1lXbkFncnJOOEt2TXBJa1N0M1ExUmZGcm9xSWFzNmhU?=
 =?utf-8?B?ckowblM1dmhkemVwb0Jpbm9UbVRTNnVMNllhMm9pbHplbHMvY2kvUlFBekVJ?=
 =?utf-8?B?cGc1cXRUUjhoRTJaREhOQVFOVXkveDY1clV4QTFUQ28wNVRqSGo2WWVDajhI?=
 =?utf-8?B?MXBUditYS1FzN1ZSNXQyWDd4VmlueEFJZUNHdW1iQzE5Z2ZsckoyNG1Bb2FP?=
 =?utf-8?B?aEg0NEpYQzl6K0JxRUNPbEs3Skk1QmM3aE1zbDhvWitQY3VjS3NwMkJQcmVZ?=
 =?utf-8?B?dkJFeDR3cURpRHFmcVBtTXozRCtpOXVjYkJPYWlmWThSbklsUGl6WkpWMlFE?=
 =?utf-8?B?WVpFK3FrVFpkakJsOUdQaG00TjRPSWVtSzk2WDBkTUlJbDJ2MzgrSXo2N0Rx?=
 =?utf-8?Q?BorC6rbmx6AA6ZHNFdtYJlNu5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3rvZTzeddTL8Lsvc7urxC0nqspV4W61R9LmQUSey9oGnfX4ba9f2DRucn5UfxqU0wXa+qnN1C5dISWHXwyEYB3dslxtsRCu/8876mf+iEMem85lgjcxQRv8N1J39WqDENh5PZDZlZeuIXS2bKPzAqRWeLM4kC1xlTxBfKsfrb8+w3qV8JWR624MHDrg0Sd8Pfz0lbDYZOH8HSh9CmXl+CHYNB1d5x8jLcVzAizcbzvFDeq2b8tvYY+N5Q3XXxdr7riJsGkZJAWwtSRnEWE6oltKY+JzQLEzFNSjox3vQlC8YKi68Pk3hkQ0yjCa6d8k3t/dhTZ2XtQ5FhCJ2GIkUT0efmcWUUfSwT4Lf94GfQBKVqlktkKEpxotWFO8sFVJrpk4TCs3v7aNDh0NP3auaDuL7NvYfhWSzmIF2Bq3S0jteDjZnIhY1Y7VeGS7UNgZt5u7BW7nu2IkodH/TnbOQVWsjNc+MPIJ+kEEKLQWhb7qC1t3F8Qs8XbJhYQu2cVXBxUzPI0O1XVfpxB7L0rJI0n05ITKz3q/j9BNSgDLJwbccP4mwwc3edZRqMOJT36Nsu7R9AGNROzpfsJABL4fNiulUhAx4Ar0pcPaXEch2upkdKHWATQi9GXehmxyCz5mD6ovKSojOI8s62vCCFUAz1M8UOA04FQQeeXRAsNmXrJLm+gVoRtZIjCZfkyHVNOAX1vPJ4Nz2ruYWSWh9AY/OBZGao1SE42B4MWKakVOg5g6D5yqmikivj4QmsphzFT913ftXtHSz3+g5JR/Ae7DKVIEb+TFKtf2EhFHFdXB9LWwsXgvL9DPIK0ymD9XyaNPh
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2015dfb7-74c6-4b90-dbf3-08dbb64047c8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 23:05:40.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PvrthcTRW94ymdRVLWh+02sohwH+p6Ev+CMK5QK5G5ApJPUEfFeAYuRIZW98AEK3BhpyQPjkRb7nhb/aZtj2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150207
X-Proofpoint-GUID: 9_hf-cYoyy2B4IhU231KwQ8UZuHB-pfy
X-Proofpoint-ORIG-GUID: 9_hf-cYoyy2B4IhU231KwQ8UZuHB-pfy
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2023 17:26, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The tests btrfs/288, btrfs/289 and btrfs/300 are using the "xxxx..." stub
> for commit ids, as when they were submitted/merged the corresponding
> btrfs patches were not yet in Linus' tree. So replace the stubs with the
> commit ids.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

