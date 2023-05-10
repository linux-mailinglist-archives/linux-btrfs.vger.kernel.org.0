Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9066FD663
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 07:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjEJFvS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 01:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEJFvR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 01:51:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570F43ABA;
        Tue,  9 May 2023 22:51:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349KgDJ1002965;
        Wed, 10 May 2023 05:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MQw/unzjYpFr/YwvGxpsg6bouZlpw+tS05RiW41hCDE=;
 b=nHRGeBc1ZoSwXxZvchwhd/qocq2Rt4PCNVFa/cqsQnhQErCbYLQjdPTOfLVebecUQOTx
 Hv87CpmAyEoQlaHeY6F2cZNC/WgzPkrcslpkR8nozGrAREPReMPmZOLHpuK0P8yn6TK/
 Y57hDOXLMcavlUwii070V7ltF0mL2SPkj/vN9QZMppRq2QOwcBtG0MhKohgu4vIf8uaU
 6OA52Z/cWAWrdfTIBvILYHdmH2RDVYklBPN78Kk55Fot/Av4QthUpWpl5bP10e71h7vX
 LcZ/YUrIWvOLy+rT/xofQilayInqAVQx3rDKkVhoETuI7enWWq/Q8jnpUwKR6AZi3tPf dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77c3gys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 05:51:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34A3pJxW039385;
        Wed, 10 May 2023 05:51:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77gxf0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 05:51:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP5DfegSE+wF4RnSqsLyBgVXZvtPz5hRlqXgAhhRD3rQ7hX/Z3UlpJ6wbkeg2jmI5FLe8v8LVfol7eRnLmR1AkXWC7ZOHkjrFW/cdfSHce9zr2LGeB/iDCNcUGmS8LTy8svU9SDcdF0AJtzbtg1iuiWQximvy1Kv5lQX0M0yLvFcxaX6FSTApkMBQfZG35PtvtKBLZFTeJbITXJMdHR/vURQVNNWpN/Vg5EGkVyRFrtLemB4mpMLAGCsuO+PhACc5BaQJ+KP1Tc7fzB0GVo1oJAQB+aWaO8lTUuIv1WJtwsiyHORGvPaIDuouvoWU1tAhMtmYdbmxS0jvrELE8brqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQw/unzjYpFr/YwvGxpsg6bouZlpw+tS05RiW41hCDE=;
 b=RoepPP5kRH7GUIu53DyWSdOU4zDiMfZIIZa0ejLxUtv+hvmEPwn5Xa3sFse/YbQZp0VZtcryqMB4/OJSdn04zHAKrG5xq5woVsKmrKVK2KqdXo+TO5aZVnb2IH9Lhj22kZ2ZPXmGmBpd/R0rtQmqNuL8XreNFb1i0pg+s6e7EkBA+KAJyKtr6TERiySXUb8jEVGLaOusmx3lpJAXsKM8z6HqhzEnkAUNFcMNeyKfhUohAFY8Qeg/siehq8SlW22IE6rgCSPbU8uYv1LJqLVBHNQr8VJ/4rP9VPtyVTtrmAxYKwnmIoT8zGRlXfmWZGJ/nAyZXX6ZGNXvEQRwn+VnqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQw/unzjYpFr/YwvGxpsg6bouZlpw+tS05RiW41hCDE=;
 b=lUZsNfZMLd0p73nXkbE6yfG0kfdirlYNwxYmfQyTGI6DW8/DjDvwmWDVH4M51HRsmY9azn+/llYpUfflYIa3lPHOjimR8RYUvh/VSta0cJsGwW/v+8shkzTRm2PQuPEkyIHraYdXvs2Tx1JqjbYYk8d7OSj+J9W0kiW2SqXElwQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6142.namprd10.prod.outlook.com (2603:10b6:930:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 10 May
 2023 05:51:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 05:51:03 +0000
Message-ID: <838040e0-1096-3f52-0452-5913f256d94d@oracle.com>
Date:   Wed, 10 May 2023 13:50:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/3] common/btrfs: add helper to get the bytenr for a file
 extent item
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1683632565.git.fdmanana@suse.com>
 <cf702a744eea3d163061afa789aecc5b2d2677b1.1683632565.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cf702a744eea3d163061afa789aecc5b2d2677b1.1683632565.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f41efd2-609c-4433-2149-08db511a8a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5qIlE0FsqECoUS23hSrhmkGh5YMGxdlahloAnAMmmISuqo2Z/GqD3iayGK2tVWGi0y/ATpxNRddWZua7bBdwQjKdWOy+JQEoc6vsvFTQSXPXZWMLS/mEU+nB0j/ITQm4xDridgyWCo32IG+yQIOoTbjEuGk/arxvfEirLZfawKMxDwjqDtO68T92ZAMVldfuGedI19ZNZDTt/jlwd78fCsDQ1siLaOFbrsSDnoKmPm2rRTpIahWYcLOAUac0ALwq+H5wM2Ys8DPbs1z6s/DVl5cvukKicG+IrasfGqaJDn3gthqvRFnm6UeFKuL6jCz+O/v25bkGO5tfM8gjYLVaeu6vkLdOZPKAnEvvVVtd4bJYyzbCeM1lbt4dgE6FRBOUpuYZoBAIvT7U3Y3qKaZbvU2f7b5XPLZFrryy0e5scFUSf/t19/rS3jiUUyJkFttq4oKAmH+zwGIs4oFfrBqLdGVy2YGb89kOQDv6COAASQQEkGCJ/ZNy150AgH/wAiGRDMjA+yXRn4SLCmZ95mdpkg6wyJcOlU8TO8OM9YGjCN1cpjmWE5V7BGXCO9bKxVumvYseU2ziTlOWFMdM1o+oKi9xsb338QzB36PDRltOZKsDc73IWiLRQvh9CacU0A+NCqdfhrmtjvhRBKIsJRSNHDu05KdcbGlEQ3aRRg8SfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(31686004)(2906002)(2616005)(4270600006)(19618925003)(186003)(6666004)(41300700001)(6512007)(6506007)(86362001)(26005)(31696002)(558084003)(5660300002)(44832011)(8936002)(8676002)(38100700002)(6486002)(478600001)(66476007)(66946007)(66556008)(4326008)(36756003)(316002)(15583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2tCTm9vMXBaNFVoZkcvd0h5RDFCT1JYakdEODdodFp2TS93aHhiYkNvWkhO?=
 =?utf-8?B?NG00UWxpU0N0U2lJdndYTXMzdS9LWHZxcWovSWZ0bGRJNUxxMmVkS1hGNEJo?=
 =?utf-8?B?Snc0MGNSa0tueVdHVm04cUlVajl0N1FCSWJBYjBnVFd3UnhhckRTTTVXbFU1?=
 =?utf-8?B?Z0hRMFBJVkd5SHJRM1ZqOFhnTDNNQVQvdVJmVkJHdzVHdktkYXF5enlIZ3FY?=
 =?utf-8?B?S25iWExVR0xKZWlWWUVMTW93dVd0ODBPRWRZZTE5UE5odEpCbnVaN1hTTHpW?=
 =?utf-8?B?L3c4TzhUcEVzM0EybE5FTEhnV0F3RnljK0trVjJON2p3M2E4aFIyaWlyMU5q?=
 =?utf-8?B?V1ZNVGpIUDIwTGJrS0hQK2FDdWgrSXBUVktMd1Exam9FN3VyQitTWEpHZHZV?=
 =?utf-8?B?S1VNL0Z6UTErTk4wclBKa3h6WDhvSXB5cmxyaFAyR3RIb0tPL1VnR3djZlpt?=
 =?utf-8?B?SE16ajV1WDJsbXpYS3BZTjJKRjUzb1ZCWWQxcTZRcXBBSTZiUytZb2tSTGFC?=
 =?utf-8?B?UnhtZVlkQVBHYlN2MXZubzB0cGZMMDBheS8zWUplVk55SC9BN212WGxkNnpq?=
 =?utf-8?B?WG03aXFoaEtMemdYV3lRQ1B0VFRGb2QvZzZ4Vkg2cCtaMWQyN2t2TmxLQnJa?=
 =?utf-8?B?U3cyRWQ0Ui9pMWhCajJDTVJZNm02KzVscVZLQURsdmZyS0xwODhUSU1qRGll?=
 =?utf-8?B?RThHS2N5R3IvdmVFdlRxdGJMcEFFWG9iVWFualZQWDBseW5VNFRzaXVsY2Vj?=
 =?utf-8?B?WXFwbUtPRzZwa1RUSXJMdm5SbHRRZm14Q0NyTS80NGprTVVGSjNtRXlBbWJQ?=
 =?utf-8?B?Zmh4SGxERFl3Tk5NNDIyY0VkOVVFejBIVDErUnpnU1paMHBoK0RZQnNxdmhW?=
 =?utf-8?B?M1FIYVhIR3pENS82dXlPSW1IWlFXYllsVHpGZng2M3BtYVAzQzZzMkFzUWp1?=
 =?utf-8?B?Yk5BZGl2dHVKbTZvMlJ6aHdKN0FwVzA0elR5QVNSMjRSams5U0swUzQycHp1?=
 =?utf-8?B?SE9EWDJJN1R6SDAxSTdhczQzTnptb1ZFUHZlTFBjVW1iNDVpenA2Z3dZNFJN?=
 =?utf-8?B?cWFTYmwxVVJkUjdUVmZsRmVxRnNOYjFoS0pPZDEzRlNmM3R1Ly9CYVNZbW1J?=
 =?utf-8?B?a0RReEdHOHdHdGlveUFjSDVwR0d0V3pUR2ZhNW1GcVVic3d2ci9rc0c1ZGNu?=
 =?utf-8?B?YXlrRWNKb0ZGSzBmWGN6ajZZay83NGNHVEFEcGhrdXdDZFRLTjNYTW1XWWVi?=
 =?utf-8?B?RFlieWJMQ3hBcHhWZEZhTGtlQXJZV2tTbUtHd093Mno1aXhzNmtrOG0ya2RS?=
 =?utf-8?B?dGdjbWs5a1drdlpvR09MUDAwL1YvOFNTTEk5Tyt0cUZGUkw1cnh5dFEwdW00?=
 =?utf-8?B?SFJQZWZPOC9iWjNvTmptZkFIUkQ1aUVBWmZhRWVYb2RhVU9qcDI4MUJXa1ow?=
 =?utf-8?B?NmVqR29QMmJJSWdkeERuSkV3VlZNWWs5RGpwV2V4aHlWLzU1TW8rMHNGaDcy?=
 =?utf-8?B?UENIS3RyUURuUlplSGFoaUZJbjgyOC9NbU1vL1lPSzZ6eXNCV3hZYlhUT2tX?=
 =?utf-8?B?VlFHU2x4UFdsZHd5V2h2UXNHWUV6THQ2RkZMUjFMSGhQZC8rUTF4d0Rha2RR?=
 =?utf-8?B?dCs3MktLZkpZeTdUS2FndUVGbnpVL01LUkpOS21FbWlIb3ArZ0hBNXhGbmxk?=
 =?utf-8?B?U3FSV2g5MEdGUEhubWpWcjAwOS8rTGtiNzlQVXppSURzb2JwWTk1MGM4K1F0?=
 =?utf-8?B?Mlp6WE1LaXdONUZPZ1VwMmZlU2pvL3VJTks1N1RCby9ac3BXM3FkUEhURHFl?=
 =?utf-8?B?YWlvU1pXa1dwblkzMlB3K3BQYUhFa0h3Mld6UGI3dk9NdW54Y1J2cDFudndL?=
 =?utf-8?B?NDArbXh2YWtHbzNkM3lTTlVtLzY4Tjk1aENJbW1Nc0FDWmpoQkc1dk5rcDdS?=
 =?utf-8?B?V3g2eU9uZ2M3OTRNNmV1TDA1cHBtYWp5eDh0Q0swRlNwVkd5emhnMDVuQUZn?=
 =?utf-8?B?a2F3Vm81UVRDS0pNQUl2TFFYS3NBN2ZsU1E1bm43VW9ZNXFTVVZiQWg1a0NE?=
 =?utf-8?B?KzFjZ3ZIanpXT1FHU1NOL3YxU2RkNzIrMzVkY1Q0VWY3bm8xa05kM216QW9x?=
 =?utf-8?Q?gkVS67bOsEbtOkfnO/2Evj8z8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iQ86OOBE1F7yEi2yq78kAmE83w+8PR6Q09DPz7PRgQQJW9tpxW/Mb7IkxJq0ek+gWLirMZXEdfCnBRAHAJSIrrsJgc/iQyhHdcerouoZB7h1dwyUKXs2fmTlRU67hIdfrKYG8xhZz0G/96mGkMzt6f3Q+abTD35h98JPsBWqLzH1WM4LUxEc7PQGJslcSugJaGXOIXf+CVxRVygW9JbEuOZN/ERcL85mIGMAX/CrwGjJT3plQFqoDbbcH4Mhr8y810n6MgotSOpm5GnYHFndBfrxqogCNh2LcKEZ5NOWyEv9Ng4d3vLAyCpx7dMtPATPc8VbSd5N1RBH7L/hjQrJs9jQRV6A4v8GhcgV64+BcK9z8JSACoUHUw0nikeva2SWqWRxZx23Wq4gZb8ClCLWAW6q1f/1oyiKqfCZIRAAHJNPnMDVkQKKlcskVvqkFmawh9NBF/wO6M5HT1U3/z7gefU9NWpZVpacTSLRxf/lTGE4Co0j2rZkXDE2oO9N4TAF6OfVqbul8jtH4DSQ4ctFDitSgUDxkbQiz15eK5xZaHTRFgxU9bW4zupmR9Q8AqqdNtbmi0G6/9XyD66apU0bvba+LFDZSdZtypBToca77cSouA2mlPI4VZ41d+xARreiENI3FhrP1m+d5J697m3IlzWAHEW7ACLQBSuWb8GdN2bbJrZcgulZ1z9v/5rzw3m+eoxljfu8V3tgSa9cTJWR+PBDjloA2hkQMYyXf7zeiB2w3tTqtH5dOIBoj30z9KdOgHsu1LKCdiYRS09CchnnZyyv9b/rUqBIqCldar6yjMNrDquH69t0ipPUCHroWYYN
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f41efd2-609c-4433-2149-08db511a8a48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 05:51:03.8108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHm/3tKwuR67OnDg012MuFfAZPZw7HHhRN9zac/QzxyEjWHyTgOoxgpYXnE89PqoOK/qvY4lj2UuxgXTw5oYYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100045
X-Proofpoint-GUID: wFHB3mnKpR-vYBGorCbV5v93jigFRg-m
X-Proofpoint-ORIG-GUID: wFHB3mnKpR-vYBGorCbV5v93jigFRg-m
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


