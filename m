Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E67F7A3478
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Sep 2023 10:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjIQIjL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Sep 2023 04:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjIQIjD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Sep 2023 04:39:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D89BA1;
        Sun, 17 Sep 2023 01:38:58 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38H4XqNl023561;
        Sun, 17 Sep 2023 08:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Q+WjycSBzVEP3N/MNYWG39QhgugOOp5p1eQqg8EeUJU=;
 b=V3mHFsC2IqEnXRYaPm0nrZCqkykmFbiiED0CzWgxNR7mM0Wcv7Sdx3k/HD30YKowuorJ
 XM4u7gxdeZs0VqPsCwIsxdZPqyIy6uht1vISTl0haJGuoYMOgV0dH747VYLLZfRf3DeL
 pP+Af8ni8yCU/+53I44pBraX+xG8ZoRv06oZzcd38DFvc3dYEZdAtg7ccFWBZbe4kCJZ
 mq2Osh+n4kc/qu3UEdkxykRcsCnDAnEc6m16T9FQTQ1Td9E7QiO6FqxmrGCKnkhnisvp
 4E0sEZq7CvMerlx6e3xJ2MGhDy9ju3oEhEbiNjpfhyN6maywFCnzkH9S6y2bnjVDwA7A YA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t539ch5uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Sep 2023 08:38:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38H6Xhvj016120;
        Sun, 17 Sep 2023 08:38:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t30yua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Sep 2023 08:38:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IK+f8/xc1dqnYetV2Eaaf61aHxn2sENFvcucS3l5mkVxx7yVwPT/iMqI71MJisBtBYlFwabGGl/hcYhZw9U2ZKSP05ABsgRMw9TAvpkeygtCj0EpTI6vFG2Swwmwjgk+pai7qNlwkLymTsgvi/Zq8/pupzp1WyZNbadmaH85mShLTG2NeSSzxEioOEpfx07bpi2u103XA5i+LKvHDv35PxLtJgpAb8tIuAEDZ8nPXD13Q8+DA1j9MkrouvPRQ2/WLdqmC6lFvJ6w16dPq9HfKo7HxpjE3D5R9pUtDw1ceFOjDK0TjI5S6ZCetZ/uFREhpvbZ+Crgv3n1YfU1rEsBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+WjycSBzVEP3N/MNYWG39QhgugOOp5p1eQqg8EeUJU=;
 b=cFOYswkuuId0IaS/P0vliidfrQmTsB17OBvu7iqQGg8QPfVaZMdvuy65zeXAue+UbSo7rdrWOHCmcFOoM9aEx0Keah9oKgyw6sevs9WLpZfvOwpQIl951j9XFOHc0CGt5e+xR73QBXtnEMRuV5yegkulLEUf6rHzZTuRVNi0ZKNiPZ2UIMkwzsU9iIWkJu+0jW62SgYJ2qQ3f5z7O0mGkLzPPNRER9fmRreH/x6GAs9e4oWti727QZSu/gan606oUYk9bjMsjV+vzm52CChBjx4yR/cI5uLbaNFWdmrwAwLySSGYMRdX3/GbfVOzv25+QegqDVKVqC5qWfs0hVWeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+WjycSBzVEP3N/MNYWG39QhgugOOp5p1eQqg8EeUJU=;
 b=pTPE0Xrf/WScMstzB5PJfkJZLCsl8JYQ9IaRKE0l9i8+qb39ub9FGqtwCko2ICgEPtlgCCJZ2snSBmJkTauzCWDoVcVqxkrK3DHBgSTxMhFEbFSfZ5t5VUmgs8Ev37YGB/Qj9dk/gxusztAVLIDJlqWDxhMXe7a4/KSHSE9ncYA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM3PR10MB7947.namprd10.prod.outlook.com (2603:10b6:0:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Sun, 17 Sep
 2023 08:38:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Sun, 17 Sep 2023
 08:38:25 +0000
Message-ID: <f8a610fd-b9b0-699f-6611-edd610728c0c@oracle.com>
Date:   Sun, 17 Sep 2023 16:38:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] btrfs: Add test for the temp-fsid feature
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, dsterba@suse.cz,
        kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20230913224545.3940971-1-gpiccoli@igalia.com>
 <0ab7fabb-a59e-df61-7a16-44457df2992a@oracle.com>
 <10911f40-b4df-43c2-4843-c97dbc7af583@igalia.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <10911f40-b4df-43c2-4843-c97dbc7af583@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM3PR10MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 186e53b8-d739-474d-7119-08dbb759751e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/iZ1ek6x5bb9Kupas1EeZX+FNX5TBsgZ6O1R/WdV8+BzW3jl2OpQ5WFHvO3HHfASQ6uNS2rl4omUME/ZmFlJNpAaR2HrzqF5W+ItieaM3NJNq9hv4JQNhQXXLaLXWETlLJGtstqgGDcGaOIbCNVlMAfabJfZk0+wJ0IDDbDlwaBPJn4VAl6xLARbl1fIK9FXlrnZOYl3PSzUi+fX9+LtG/eQ/8ERqXuf4phpapf51AyPjh/YUwolNmQ57ALpS1gdM8FiYrNGKuE/OSrx5XIZu0VdX7CIVTb+qs8zlWLhT7DfcG4GbjEueyfElGUnzVLonyLsTVSYqlZ6Kam/leQyu72N3jB0SIrqvt/UrYb2IsLkNlcoXVJc+a9gRY6Om34wnmOXqJe9f5Jagl1yPnjdUK5RrQii1H8iMiVYcka3yPHXTt8V8r55vIehQfTD4BiSCn5y/Ts3qZVcX6jyjUCXbh+r5xYRjBdFkxJO87WlNIhPTBeM/WKFQLX9zbF2rsPQPMxddbrpqFxyDfiwVNHZ4WwuL/BQPM9Z0SZJaiJf93LD4wwwjoQS+1/PVRgYqjdjAX5tj9emIf9x/jp8MOHykLjaErosyM0d49Hojtw71MZQQbXaDYxjTsf0wSiPOh88FtyE5B7QSmqmMhw1O9YCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199024)(186009)(1800799009)(53546011)(6486002)(6506007)(6666004)(31696002)(478600001)(26005)(2616005)(6512007)(2906002)(316002)(66556008)(44832011)(66476007)(66946007)(41300700001)(8676002)(8936002)(38100700002)(36756003)(86362001)(5660300002)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJaVWVjZkF2OWE0Rks0YTdGckNjdjZNazZ6OWZTQU5Pc3BKWWExaTAzMG9H?=
 =?utf-8?B?bnJUYTdkV1ZVc2tnOUJ4S21TN2FxWG5vNktMWk9VZnVseGYyWjM5aWFWMVA0?=
 =?utf-8?B?cVVCTE0zS2R6SWYvK0xVNUlKZDZVQ0RpNXk3NDRHbnVqZ2xvNzE4bWNtdUVs?=
 =?utf-8?B?TkJnU1l4eWdES2R6Wi9TemluRWlRTi9OMFp2VXBPZmMwRDdHQnNmZi9CSk4y?=
 =?utf-8?B?TlMvRm9STDY3Wlc2Z2ZhVFB0RG9SRnpSOWNEWFZENTcwVUluZFR1aGJ6cXYv?=
 =?utf-8?B?bWlGN3dIUW12RWJnMTR5OHU2MWtUeVVvbno5eitVN2ZKUUNRaGdJMFVBb01B?=
 =?utf-8?B?VDNaUVlTKzdMbkFQT2RaS0JHSHgvYXBlZWV1S3hoOFB0OEthN0d0OTVKY2Q5?=
 =?utf-8?B?eDVtZ1pVOGpnVzluR2VQNkd6cWdZMnpPUEkwTG9QdGtkVDZyOUZQSHlyWnZ1?=
 =?utf-8?B?SGd3MktkS3ZnZUxFYTUxc1RCcEh2bXExYmIxeWpudFhiZEhDVnlWU2l5S2o1?=
 =?utf-8?B?TFFkSXJEVkorcEFmMC8zcjlES0RyMHRYd2h4OHRYL2UzNHBZbS9RMG9GeDY1?=
 =?utf-8?B?c2UxQXNZZy8vVzNIVXhsRHUvVUw5UklMaXQ4ME5wckZWTnV4QklTMm4yOVdL?=
 =?utf-8?B?UnlZNWgveldRK1BGOXVmaVdsWWFLbTFibnNvRGEzdksxUzMvYTNDcUt4RHZZ?=
 =?utf-8?B?VDlpNi85VVlhS25jZzFNYUVYTGt3UzBVMVhOVk5PZC96Q1dXYWxpQ2YzWXNw?=
 =?utf-8?B?c2U1eEhiMTFpSkFza3h6b2VoN3hKcEdlazVocS80UnB3b29DaExhUUVkN0xj?=
 =?utf-8?B?UFh2M29YREFzM3ZlU0QyUldLV3U5NlQ3b0VwYTdQcTJjQ2ViQ0NFZWRnUmVC?=
 =?utf-8?B?NW5zelJLdzNNNDhMSWhIOUszMk0vZ1dieHlaWmNCc0JCQ3IrUlo1dGt5R3Nh?=
 =?utf-8?B?UFArdTJWSzBWTTdwVVJMcUY5RTB5c3VlSkN0OXowc1UyVW11eThRa2I0V3NV?=
 =?utf-8?B?dXlQdXlFUTUzZDM1Z2F1UjY3ZjRscXFzNVc2Q1lCQTlWNTJHcG4yMERIN3BO?=
 =?utf-8?B?ZUpJZFFUanRDa1dVeVhHWDlIeHVPemd5QVZFQ2dvZ2hkVmh2OEZxZE84TWx1?=
 =?utf-8?B?cHU2WjJCY1MzOGpKN3VsMitSR1pNK0dUd0RZQ0tBdmgrSEl4ZzBjUzc1UnJ6?=
 =?utf-8?B?cUsxSkdNaE9NWU1iUVNRVVVqZ1poS0RuK2txdC84TUJBV0dadERKY3pNcTd6?=
 =?utf-8?B?ZVlnMWl3YU9LVTd5cDU4K3o0SnNnREhFVmFha1hRNHc0ajFxN0owVCs1bDJq?=
 =?utf-8?B?bGdIQzNiMWNQbVdLQ0d4WVBwdG80VUtmYmN0REJsN2pJSmNYd2luQVJBZVg0?=
 =?utf-8?B?MWpsWjF5SzdTSzNLSVhnQlFXQWp6Y2VpVW9kbGNLbXpWTTNjMHg2NUgzb1pD?=
 =?utf-8?B?cHMvVHZYSWMyZFRaOW1LNlYrS1UyUHlRTXUxQ0tiVkVCNDVPMEtPMUlUQ1ZP?=
 =?utf-8?B?WHZ6U21RZk8yZFJ4a3J3L2psMFlBY0lGTDBldjFRSEpnc3BBOEpaTEtEZkFh?=
 =?utf-8?B?Nm1pZmszK2tFOVNRQXA4akVRQnI1QW5iTUlKL2RaR3JXSWhzSXNaSmd2S0gz?=
 =?utf-8?B?WC9XNk9vY0dGUUZGT3NiVlNnelE0Q0c1V29TVTJubzlUaVZwZ3BnTDVQNWNE?=
 =?utf-8?B?QTFRWjl3VkM1aDNIdzJmcFFOWTBOZDNacFJnR3lXckV5ZUk0cEdyWWFZUG5H?=
 =?utf-8?B?c2JwcEZsNUhrZUV3NFpvcDc4all1M01LVldwN2lJQ3JFSlJYWGNlTHRyMlgv?=
 =?utf-8?B?d2JjbUpNaXg4TzRVeWlrTk1UZWpTN0NJVDBHNXIzeVpETXFqL3BIRGQ3Rzk1?=
 =?utf-8?B?Z0N0aWlING5jK3NkaUg0M0ZKY0VVbWNoRitnWXpieEtoanhCdDZFbjBFaUZi?=
 =?utf-8?B?cTUxZmE1MFc4amVVNDlIQXNWWEdxRUd1K2hxblBhdklqRStqdmdRWDYxaTRk?=
 =?utf-8?B?dGduWjB1MWU1VHl5bEFBVFVMYmRXL0p0V21ZRDRhMHNrbHZhMjJReEtuNnVr?=
 =?utf-8?B?RlBEUEt5K2VmSHZ1cS96VDFJbDloYmdYbUJMUzRHRENuRXFRMFhjSnRPWTZi?=
 =?utf-8?Q?e7qhy+Llye/S03f1qS9szkyzE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k90kVhdnUWZezXrCc7bNJzaHwIzEZXWpAuQ8vDV7j7s98kh9GpMXaL+tHxATNR11FX3agjDbqPC1hpKF4mR22ugpnYGletOdHGaP19upZrMWP8ziub8wjRyvAeq9kjYgNhVIXP0Rm+mn53jQ9sEtoUinjw6jYe9SRtO2afbEsjiXxyQ0VyZGSUbS8eHam3JYLFo5cF1wS8eTVmTIg1M+9QzW52mIAUDB/gq2ap8/PgCdRV4sXodSDXj1lpcQskYxsKzCdZJUjfxvqLBB1Q2Kevy2ccou1DwtBygq0W5m3s2UM8P0JV4CNITH/Sr4u9X6JQdgZYzQPnq6HSu+PloVby2FMX0YkVGv4hl3OfCyTo8kS2UnUmsQYZ/TN5jZSuuw1bhAmxI+E/cEISPRSLVzokZ7Gq0CcPzQKOohJy9X0pe9C1zoDnLnEwznTBXViGgJMaH2TELjzgGqXeiBkRAJVAUl5stFCc901xARn/M3z8wOJa70/xKaw4kfgjbgXL5NrULcFKF3uzXugfOFs9UTRRz8LnP+tf25aATKdgcCWbX11wArsue/2jcDS0jPxlrpl5H7+Xm8YbxYz/yNnws6adQEdiNOFLKEP3IEGwRZ3s8YSr6n74F7AJWE4PKkyUzTlR9CQedrLjC2CGQ+8rEbiWuRm027tVI3QYnG1O0LzjeqR8Jz87Rk9NBsJZlMYm+lx3co0tMnJjOuTcy9iCwLd6gnfF+8OBicCybGJbYsbcvWL/eB7cPBXlXsabFHx3TMkjN8yPq1PTDlRqO72cbn3ohXXeg2fOR6KAxXOgjnhmkbPOQpc3Rjic+7TtT/q3aGKiWwZHe6BBBQUQ5goCf7jfNJDKPBSbWfarrfK5S50PPtnhtMMdE9JHYfJrhXGjeStEslhTdDUlx0GE6UI3Ra4r78YGeikUsoERyvInXz6go=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186e53b8-d739-474d-7119-08dbb759751e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2023 08:38:25.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWLmYAvOpOi3U3JqoxUVnmOpl5XamnO0IjlAWec6eeQaiMxdDxuqfVYzLBZPIikT0DLv2H29jr4UUDxY5JyplQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309170075
X-Proofpoint-ORIG-GUID: gBE6xtmdjYMVLfaTqnA9tn7zoTRdjLDu
X-Proofpoint-GUID: gBE6xtmdjYMVLfaTqnA9tn7zoTRdjLDu
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/09/2023 20:35, Guilherme G. Piccoli wrote:
> On 15/09/2023 20:25, Anand Jain wrote:
>> [...]
>> This test case's integration will be timed alongside the kernel.
>>
>> Running this test case on older kernel/progs without the feature under
>> test must terminate the test case with _notrun(). I find that part is
>> missing here.
>>
> 
> I'm confused about the relation between _notrun() and
> _require_btrfs_fs_feature(). I see that some tests (like mine) make use
> of the latter, but some tests do as you suggest, using _notrun. They
> intersect only on tests 125 and 192, and it seems they are aimed at
> different things, based on these two.
> 
> The _require_btrfs_fs_feature() seems to be used with the same semantic
> I'm using, i.e., to check if a feature is present, given that the test
> requires it. Now the _notrun() thing is used like (in test 192):
> 

+_require_btrfs_mkfs_feature temp-fsid
+_require_btrfs_fs_feature temp_fsid

This will suffice for backward compatibility. My bad. I missed it.

> 
> # We require a 4K nodesize to ensure the test isn't too slow
> if [ $(_get_page_size) -ne 4096 ]; then
>          _notrun "This test doesn't support non-4K page size yet"
> fi
> 
> 
> So, there's a secondary condition here, and the test is prevented from
> running if such condition is not achieved.
> 
> Do you / others think I should switch approaches and use _notrun()? Or
> should I somehow use both?!

We don't need this because the temp_fsid feature is compatible with 
other page/sector sizes.

> 
>>> +_scratch_dev_pool_put 1
>>
>> _scratch_dev_pool_put
>>
>> takes no argument.
> 
> Thanks for noticing that! Will fix in next version =)

No worries. If this is the only change required, it can be fixed during 
the merge.

Thanks, Anand

> Cheers!

