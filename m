Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3927D6998
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 12:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjJYKyl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 06:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjJYKyg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 06:54:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F5213D
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 03:54:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OLUSnc025369;
        Wed, 25 Oct 2023 10:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=E0DWAl4t6xWtycpYnAu0lxTOYSiocrZIHNFJBQ2kDL0=;
 b=3zKxGfUA6gzY4LhhZvg6ZyuCfYAV0MdszxgA7xBPBsPg2xxhsDU4f71VMjzmwr36xdp0
 HYvxYcSe+JBbrTu0Vg7seMp+YQoPDxo4maYmpigiHZMAOAz79jlumY2Fq+fe2P7iYAqR
 N50zcgMIHFDMwsoqMYPurTWk4hS/b3euAroHS9Q8QPYtniikYPzxtRXMQshxHLXUkdRM
 y18Tm0YiT1p+DUXet/JqWFjI2rhcbjqs9qc5wOutaTeIe9kGGXmTRlM8gd4D8v82e+i7
 wTs0uBiqLO5Svr4qfREyRT2yGQcOH+WPCukd5lxQ/sWGbR6lTZKLOrojW1T9k3huLkdt 9g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e37ep2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 10:54:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PAqlrs015127;
        Wed, 25 Oct 2023 10:54:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv536gc4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 10:54:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS4Eb+7n3rLGk0uqLQi3bF9Dtpi4KA23VqCHyW9dOozd0y2KE9hO/w3r7tn1A2UvL3gjVCwzqkSpXT2YJgLVUzfLQ/C945cbLo9myt3KMzYSQK5qLF5Iqgozq3dHh7c1vmfVkPUJ91lrTFED93Oz4G4qQ6sRhzCrmjTev8ZxUvZyuCFrbbxip8A54UfguC11SlgfUpJQ9uFkMx52+3ltU4b8SNBAtH27Dh1wAxCcElmZzLdia9BA7q7gu+y4d1W7A2Sgrs+9hlfmcsM9GvIwAQUJWLMqGThR4XbyrU8bEgGnaH0jPMl5Ztbczf5wk4pXy74JU087Qm2v9VzVQNSssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0DWAl4t6xWtycpYnAu0lxTOYSiocrZIHNFJBQ2kDL0=;
 b=Ap7IajRA0+KZisf5GUve33B8kBQYNX6soQx34EnFmoY7kAX8zmTrDj41ebRozeKBURjL4wxOSE/7pQAtiqUwhQVrtM1ndkfBlsrGVJqetLk+Jc1p5bPBjXcggObvRogJRTPEl9NgvOK4Ah74MieIrK4kDzlSZ5BcSa2DrmGvmuXDyOdpL+2Ajyo/J/usvAvxjYM2DG7d3ZRqCpkzO4h11w4UDc7N5Qi9AAipJMdNO6WzGaqlymWJcQMy3RmQaw+DX7M6n31Aw4nmsNqT4p7m/md4HJDhI/vLcB+EtFvfCM4SZZ4EndrLYoGnil9Z0ULqka4m7+4Bycqg1ab2Ae0lBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0DWAl4t6xWtycpYnAu0lxTOYSiocrZIHNFJBQ2kDL0=;
 b=K7IF2Sz9Q7553HG8SQ0X6IKxFrCvectJNyHVsnyxl1EFK/8LwK7m1t5QU2R6tkRoq/Q8LmA8PbahezXIU/KveEcV4YA9Dne23nUBiYrYInlstaL8EbFx5b0IE4SI0gZ1eL8c56Vts5FDsco/Pq71qVVMMoo33j4GyyIu3bRAYZc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 10:54:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 10:54:04 +0000
Message-ID: <fd2583ff-797c-4e37-b168-7050e892e1dd@oracle.com>
Date:   Wed, 25 Oct 2023 18:53:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [btrfs] a5b8a5f9f8: xfstests.btrfs.219.fail
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        linux-btrfs@vger.kernel.org
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Sterba <dsterba@suse.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
References: <202310251645.5fe5495a-oliver.sang@intel.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <202310251645.5fe5495a-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2a6884-98bb-4dcd-9f75-08dbd548b468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkIv+BMkadwtVvs3LgwHqYJgu/XgRezJT5ZCbGt9MuLzidOj8+lFDIkZoijUkSgqwo6ZXHl2GtBeawkF8cnKbrQWhCSYJ54pFu8HOJtLbybQeNSAsQexV2KJ9H0ZO9pTY3rHH10sjjtHWn4gukIb8mQdMYMcZ7gyde5D6wyI9IviZQIeHisFDx/DiS86b3zNI4Y9KVcdBsVxUcwycGT3KFGGDw/5y9k/jhlloqiPk+5rZtfFTtWHiw6i8K/rkSOVBGO4u//WMGgz2MXBC+pGgi5MQQEErU6WUgMnIEN92d9K/Lpb20/mzv507P1IuSe62J+HtY3wFqhp7tl1SoWHTtrn/NvZC+IR2jyPWsYVnvw4ExWSNiuiAojizL1QdQxdxufT00d9DyXPZqR/o5v/updfqjplmZG3/ea55PeEP69cpr/xbXGTO87uLLbuaM7dpG9ApdYGBRtkbWPCueB1B2laY15HORwVQMoUQgAMEr+8MpVcZ/IbOKZ/2k0r8zpz7SXA3Eb4/paOBtZW8Rq1fdMW8MglXtBabF5CaMvlmBy04q9O58aQJ/C3hpuLUGg7qgJTZF7KH4tXENFWBM/EBPDBkDKNFtQ3kKg04CViU4RA1Pe3Z/720XlR5vN7uwqV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2616005)(26005)(31696002)(54906003)(66476007)(83380400001)(316002)(66946007)(6506007)(6512007)(6666004)(66556008)(31686004)(6486002)(966005)(8936002)(478600001)(38100700002)(44832011)(8676002)(4326008)(41300700001)(2906002)(4744005)(36756003)(86362001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDFhSmcwN3U5Z2MzdUFFNnkyM29vaDBKdlAyOVhpbGZMcThDbXpmSjArQVli?=
 =?utf-8?B?Y2NOUEdxU2RKSzFOTW5KZmMwU0pLZTZwaTFURjE0MzhhK3VEbm9NVFloUGFM?=
 =?utf-8?B?RHFkdEZkeUZEYVR5b2tLVm1tT0NkK1JCZGdOTTNjNmJ3cStHNmtJTFhiMUhG?=
 =?utf-8?B?MHUzc3Yvc3NiakFORy9LYmJVdHhtUDBlV2dyV1YySy9pdjFwcU05ZjJFOHpv?=
 =?utf-8?B?d3U1bkZnNzZzN0w3c04zanpjVGR0SFc5TWlIeGMrbndnWEhZZStLMUxYVEpB?=
 =?utf-8?B?YjVMSDdpSXFvNHkrMmh2TkZmOCswNVkvOWlmUzUxcENxMUFLTk5TR0tiQi82?=
 =?utf-8?B?RWI3VkJmcWdpdjJOMmR3VExZaFhQcFBJL0YwalRYaWZIdm5sNVowQ3pGQWtE?=
 =?utf-8?B?bmdzVzk3Z1ZheWRxdHIraUxqSXhjT1dOR2twSlFmTDA1d0dkekNZbnBPanJ3?=
 =?utf-8?B?YnBpelVzZEdwTmJmc3Z3eXRIanVjZ3hpY0ZLbkVNOEc3QmxmTk5pd2loMGZp?=
 =?utf-8?B?TUptWWhKa3kxTXhhZ2s1cXdEY3RlWGJTTFQ1cWVvaGhQa0lseDdMY1MxL2Fr?=
 =?utf-8?B?R0tUUUVsQjFBRlBJREt6SmY2TUx6NmVMZmxvK0tHVEpMa0w1d2l5S2JBc213?=
 =?utf-8?B?azlwVUVaVGpRZk5XV1pMTngvdkd1a2JubW1SY2V3NkJQY3Z2Sm1XbFVlZ3o4?=
 =?utf-8?B?UlVRREhUMkhYRmJlVExGMnl2a3lKM0R1UFgzdFZ2Q2pJZTV2MlpCWlVUeUEy?=
 =?utf-8?B?QTVPc2ZRbHU2K2QySTZHa2ZpVHBqNXNqaDZoVHAyNXRwNnRwYU05Si9sbU9Z?=
 =?utf-8?B?eUw0eHhXb1oxZ2pVRzJYcUZpbXVndjVJdTFCKzBkbW9wNWptWWlVZGlnZ21r?=
 =?utf-8?B?eXlsM2lmMDlRekZUdlRjSVdWUkV0NFpXSysvclNQUUdoeHVtdis0SnpHM2pS?=
 =?utf-8?B?RFBORXA1STlEUHJUL1VYZkdEdGFFY1liNWxJTk5PNGJxemZsRzE4VkhkTlla?=
 =?utf-8?B?QjQxSnFZbXVkd1R1R0FEa3ZJTjVyVVQ3eDM5cnpod0N2SHBhOFFmNjFEWWN3?=
 =?utf-8?B?SEwvY1lSTnVQcFlBcWNxbmxkVmppNGpYSHJCUmhjcHd3ZlErdkU0cWN3NkVM?=
 =?utf-8?B?cDh1alk0VVV5MjlkSUJmdTFYeUQ3b280NXZjTW9meE9OVWlZSUNiRkIxa0o4?=
 =?utf-8?B?N3g3Wk5BYjcyWmZJcWZxUEY1NFlnTmdxZDFDVFhNSGRHb3liUDUyV1hlNzMr?=
 =?utf-8?B?MVNVMDVvM1h4VXIvZTNZYUtJQ0VVMnQ2Qkp6ZHlyRmk2UFFFSlRlamxoRG42?=
 =?utf-8?B?Q2RMZE03bUtTSEFWSVN4RDlpWmFTVVEvazUzNllXazRBZ0ZGc21mdjBQRWFB?=
 =?utf-8?B?V0VzeWtJK09IdzZldzhreW05S2pJVlNSZkx6Z3QwMzlkenZ6M2NiRzBQbDhj?=
 =?utf-8?B?RGQ5b29BSXozZjN0aklSZUtqQ3cyRDI4UTVkUGx2d3FralZwcy9YYVNMVk1V?=
 =?utf-8?B?QnZWZ2NVS1FWMWNuMzhoMDd4VW1FMk0rb2RRbzJVYS9sTHhHMkxxUjhUanFT?=
 =?utf-8?B?TzR4MzhlUGJVV1hMVlpCTEtHaXBIRTV1aWFFZkZQYzA2ZWUvajBIZUJTRG1O?=
 =?utf-8?B?ZFBzeDVUT1NoU1AvR3pubjdUTlgxV2FCZkMxVjJoam96bnhrSk1DTm5HKyt5?=
 =?utf-8?B?SFBQcUtVY1BVZXFydzF2a3VHaG9PKzZ3bm1uZEVaRXlDTlQvRDB2T2NoZXdH?=
 =?utf-8?B?RldBenI4Z0p4VUxzL01CTWNYbDdRL0pMcG5wNXIyaytQZjJ0MlJPTnhidlZj?=
 =?utf-8?B?MStWS1FrODdDWHIwK3dXVjBaYzBrb0t3dDlLSVJBclVEaUZFdEZFV0JwdVli?=
 =?utf-8?B?YUQxcWRJMzk0SUZiNUdvdysyMGZDRUtiNWVCeWNxL1NoV1VFQitLZE1iZ2E3?=
 =?utf-8?B?UDc5a3p4WVhlM09LUCtYTGZNZXZJWkwrRmJlZTlFTmFwbHRsNHBYQ2U1U3o0?=
 =?utf-8?B?TnJ2b0J2eFQwb08yRUs3ckF4OS9jdlNpdXcwNm1Uc213ZG9seEVzd3lZNE5W?=
 =?utf-8?B?bFVNViswTDFzLzExQStXYUN3S21rcEZCMVIrMVcwQXp5VDRWbzAvQU9CUVdU?=
 =?utf-8?Q?mBqacN23xGnN3DxP68yXxie7G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kSWD1cb2hLmQVZ1D7hx5ZdGhiaEjTdQVEVpSYeNqg7rn1UJ1fHHKbBKcaGhPV/KyxXHzCGLDKgE18QSO36l+djZfSTrnZSSxnODE8+oHlzKIG5/vIg7XotdLdN9zaW/KU4YlKgIWVtbNqY0X1cZCDszGXjNJ4BBW7kuGes+Yas+BvDR9Bw7fkHnatKZk9zwXs/x4Z68dXCHmYoEml/fhmM6mxjNVPnqF+8yLW0sNKmPEj2BoWX9f8DdFMUjiSefwc0lV0KxKkuTwjUoaYtshhvSXUF4u7EKr7yWTa+/UWIBT3dP1ZaLgGBuOFrvhhRAvxQlrdoP5yA7Bu4AU2hP2qqLd9dA1F3L5R93gJwD6aYHOYM5GrwR1TiFk6QXdvFTcJgRPe7TC08lBXwyK6z4dFfJT6ARP6z96IxOC1hmUVX+taZqDcP/PC6YXfVPz05xM7hqbUKjW/K7kkWhgB8A9tKz+tZ4jO8oYAJHeGrg7CNgK6gGB2rDIdtyPNjLVJqiC4dB8UpXwTqICDNUNRVxFuovqtLqlZ3ZlrrpUARqpFy2wL9a9C0HAlG+3Fm0ULn6i8mZbQnvNCxUifz5k5DUGSjVhyu+hoUySLS0B3AVSjAyvBwluw1FE50e87wUuiUeHI81J/eBCtq5sYsNv7vnzdBY9R31p47PVk3Ol/3qzQiQy4jY0WNUQfvhs7EhQJJoa7W63SMuWgUhkQJ09EkzVN1f2nNQr/WxzYpPxZ+cwMjPLcMopfeFChQ3A2wIEYBINa+M1nfPhTuF2B0fbf8HmqVAeHCiLelgdyu5Z2UeebChKkkQA+wN5U6ZcsaLVTYZKjzgBh8x2iBKZUl7pcZSRN/5W/wetff0/C55QB8applIw+i8UGq9ZftUuDSNJ0iwayn1f0NlhoKl30v1/Ls3YCpfyKRj4tiO/DOxegxDglHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2a6884-98bb-4dcd-9f75-08dbd548b468
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 10:54:04.7377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paJiBVQ7w8kN7ecCR2u4hkyme+k9k8mDJ58WN6vemCWraXFUHP3b7SxA/nNBGu8IIFJibbNjTUfZ0juTxxzSvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250094
X-Proofpoint-GUID: 6lQFkd1OgRxUQYRDOArSAfTslp0ZQBBw
X-Proofpoint-ORIG-GUID: 6lQFkd1OgRxUQYRDOArSAfTslp0ZQBBw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>      +We were allowed to mount when we should have failed
>      +(see /lkp/benchmarks/xfstests/results//btrfs/219.full for details)
>      +rm: cannot remove '/fs/sda1/219.mnt1': Device or resource busy


This is a false positive error. In fact, we should update the test case
and re-add this testcase to the auto group.


Fix sent:
 
https://lore.kernel.org/linux-btrfs/39311089b30f9250ff7f7a0aabb70547616a4b3a.1698230869.git.anand.jain@oracle.com/T/#u


Thx.
Anand
