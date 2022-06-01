Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1E553A3A5
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 13:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351027AbiFALL0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 07:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352525AbiFALLY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 07:11:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B818A32A
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 04:11:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251AiGdX020883;
        Wed, 1 Jun 2022 11:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WianCkSYFzQAU9+UGfmUydFzk4qEs78OPxCeNN9tvv0=;
 b=gomkBgOGLa3Pk/dQCqU1mCFAJ123FQJuPr7tTgrV7JpaTenWdtSi+C6jvLxsoBjK1SHK
 h6j5RXTIlWsK/p5mO50xV0+2nskCoeWm4lj6foV8zfZpegV5/ul5qGx48BFeLv87c3DH
 3JZfDc0JwB/HEtIG2hxLUbrqMhCbtGbqiDNaAnIKikEso5+XmphjraC+wI8ibDg0f9Xs
 hSlO/CvGcoFjzY/bsPvBHIYMkL1dZ+5/u1TaSFKSRlKlP/ZdCitStcOx1IwxlRBpyYE2
 HQsbK8UIRXUt29ypFWlzrXuEB49BFk386yva3TeDqE1OePlEjRsOCD5KWx5BtbWK4EI9 dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc7kqb41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 11:11:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 251B6Dhj032503;
        Wed, 1 Jun 2022 11:11:17 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hx2j8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 11:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxQkSCQvjvMW/6zsfiokNL72r4F9T0JhW9DhY4QO24JQ9e/ORv22jOZiP94+phD35feIFhEu4h0DjRDdsvCuEqSIbHkTH0s37hmv6hdm58bydg96IoHlmOThKQb2hP+7L2FqQ3shn5ZlSYxtcL7NmK+6xsFnZx17nsL1ySWkDWcZBlgakPAykIWdGnem6QXZY1VS+agXu/RAvv+OH2kB/9NISNNzJgXDdPtx2nZ5gxpw0+nPZ3kaVsBjNeEyVbONkCN9pgdSeKAnDr+rabif/gkX0NMf+sNfPydfQyF7d9QnFD4obonRhve0nNNYYHT3e65muMMsklkRL6Z0OMQeag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WianCkSYFzQAU9+UGfmUydFzk4qEs78OPxCeNN9tvv0=;
 b=WTcSe2l0lod9Fs2QjCOgORawN4G3cWQK7qKBTGCjRaRml6PdoItTF0AeAd/D89wBJ8f9KNVDavzpO0kdw46Ek3swbp9cthxvOT5ahndBwBGHdjBZqNsJGh7Sjsh5t1U/C9xxw3UGl3a4KGzEcMFjqjHQ51jQhVCHX4C6G4GnR4CddNaCAilIdmp6oelNaufYg0S+CG8RPjiUagg7OW9YOP3tadhvkWBF6CaMz4WD5xtIqivk+iznesENGXpt8IjB1cncnEHH7lNRQIBcZewewCyjWkEpWNYv1njHHlN5v7d9qb/aMCWp++xI4mx2aIM6J7UDQKURnjgq9Cqptm0lVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WianCkSYFzQAU9+UGfmUydFzk4qEs78OPxCeNN9tvv0=;
 b=PBkDS2eWOFiJRf6w1X7Wgdiw3lk8CcxTnuA64W23+1VhmFyHMneOCA9Ujj1Uv1mvtqxXGpi7JW/6kY2XXmhtbB31yuteChCvwpdIKp2uIv28UmNMqDh4xK6JJcqCADVS6DPKI5X/CaG/k92RhYrdN94/G28trYWOvpxwHtcW/b0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB3404.namprd10.prod.outlook.com (2603:10b6:5:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Wed, 1 Jun
 2022 11:11:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf%3]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 11:11:14 +0000
Message-ID: <e2548660-462d-1b08-9824-1f7fd4655fde@oracle.com>
Date:   Wed, 1 Jun 2022 16:41:02 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 02/12] btrfs: free the path earlier when creating a new
 inode
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1654009356.git.fdmanana@suse.com>
 <b3c7ae5b6d09c442fc7546660dd5535302d11a7e.1654009356.git.fdmanana@suse.com>
 <44eeb8b2-e826-4aa0-56dd-5ec90e157018@oracle.com>
 <20220601093433.GA3279070@falcondesktop>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220601093433.GA3279070@falcondesktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfd02910-a0f8-4a99-97b5-08da43bf70fd
X-MS-TrafficTypeDiagnostic: DM6PR10MB3404:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB34049A53CF71EB3EF0A389F7E5DF9@DM6PR10MB3404.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InG8KLzmRMXGp9fKK/xbqy6yVo58e1G0NxF02UwADay+Sw2rWboiiiIb4wC4ySo3rLPr6lsI/ZylR9gJkfxOzmJKTHsMIUkesWzABNhuWwSLeyMU+s9XHTrPjaP/F7+tQug3JoH9XOwRlEYs4NPkLhbslRgNDACNLwsnC6M+jisw0YZ9xXdAhIX+A3RrEXkKq7b5YJmG0IBesZObLMmGkp2gcgLOyXbNxEcciL9vnu9NjpAqVsGjoyDQy7/UhdITWElx1qc0EbiL/YYWdjnl9slZiWC5bU4T6i8X0wEI+4kX+6VZGbI3sq8ZdUuwB7T1lw7F7dGj1uifUwXBzwTgB6n0E/p/h8jilv61Ct0RsnNyKvZ9NZvMOazs80BSbJK6gGN40/p5zUAoZXie7oTnKryWarSyEd0rNvd6kFvFW7EMPLL4jsf/Owsla1ToLpKoCtLPUsuKKy9hK/vY1yiUoZq9wMp6WqY9OtdpjadzPil/e99WrJ3wd/q63q4BTlu0ZroroHL7Z7vjaSr7C4orhnkXCHuHaoH12XZSd806zlhOe0K3eBtdkSK98p0J8jeLtpeIB9Sr+24lj/opp4iWt+7tGY0xb/IppP8KkOm1ytUA5TPlydFUYDKeUdBRiKfV33G+bWsOj4YSLreoOGA4V4zzowLFKiOCbPHlMcPXwkzgVtxwUd1HBHhyJygA2cxIODjCMv3VwCxzmOXnhNXA/9MAaupQ4nVObkGBFmsjvQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(83380400001)(86362001)(6512007)(66556008)(31686004)(66476007)(66946007)(2616005)(316002)(36756003)(6916009)(8676002)(4326008)(5660300002)(6666004)(508600001)(53546011)(38100700002)(31696002)(186003)(2906002)(6486002)(8936002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cktRbEtOTVE3cmkrL2pRajV3MVVzd1FzZWJ1Tm51UVpLR2RHOGpyVEphckVv?=
 =?utf-8?B?T2lDZXhzd3F2d21zMmgvRWMwUHJDaG5nSDJIRG9wNGo1SWEyVlJTamsyQTJO?=
 =?utf-8?B?YmZieHdlOEFJYTdoMmpXU252NlBhbml6YWJwVVZlSGQ4NUs5Zk5FU0tDU0Yy?=
 =?utf-8?B?NXVPTFFUWGt1WFVuditjYzh6cWFvUG9pdlpsT3hIS3lCdXgzWno2SXgrVDZj?=
 =?utf-8?B?WWg5ek5hWEFleXNuSm0zaktZN1FEcGVUV2xPRGNGV1VsT1FDK0xHWTFCaWY2?=
 =?utf-8?B?UWFxY3FYbWp3di82cWNJSlZXUmVnQ0VhRTFFWVlJRTkrREFweEcxdEZBQmQx?=
 =?utf-8?B?dGxBUGJ1UVBtUUhtdVRVVnJxZGpKQjBQVlBwL3ViMGR4dENET1NmdFdpN2RQ?=
 =?utf-8?B?VmZXNGpmbUdncEJzSlVOWTMzUmRmZEdJRXFhVUNUTTY5VkxaYXArb0RCWWMx?=
 =?utf-8?B?YVZjbXRucTl6UzNhSWFBSUlJUzU3QVd3VStDL1FmaHdPUUpTZWp2OEtsSWRB?=
 =?utf-8?B?YkRyayt6STR6bldhMGY0a1V2VUZFVVZqUllRdEtTeHNVSzQwVExoeGk0bHdB?=
 =?utf-8?B?b0ZVUE42ZmcwSE9BRUM5U1BGYjlnVXh1UFlGTGlKa2RRUHFBQ0hWWWhnZEkv?=
 =?utf-8?B?SlRTQ1VGQURKdXVoMnE3RnQxYVkwVFQrODN0TUxiczZwdjdmMzZQWU5HVGFi?=
 =?utf-8?B?NG1HTkpBMEdBNHYwbFpXS0tsTDFRVGh4V0g4Tk9Xdzg1TXM2OXF4eWEwclJT?=
 =?utf-8?B?Q0pOYUw1NkFVaENiZFd4dGlVZDFJRFRzeFBKVCs1MFh4T1FCdFlSQ2Vla3Ni?=
 =?utf-8?B?U0kybHg5Tm10dzJvRVBiS3FhcDM0WXRiYmdFcWVtQkh0eld4YWNOTEtka3h6?=
 =?utf-8?B?VHdPOTZQS2xyc1VsdXVFdDVoejVJRFhlNVdMOFlhcm5TRHRtS3NZcDdWUDg3?=
 =?utf-8?B?bHdWYVpDYm05OTJnSGdIT0lXSXdGYkwxbUc0OW1QVWNkdmt6RnlsZHNjdWg3?=
 =?utf-8?B?N1pTaDlyV0E3a005bUNmSk1sa0d1TUlLbTMweENDQVdrWXdFRFBIS3l5Ly9R?=
 =?utf-8?B?MUEwZDZuN05KcTFWdEM5V1dBRVRLaGU5VlBndGhHRkVqTkZmUHcxR1pkRlJl?=
 =?utf-8?B?bzRqWGllY25CV1RUQ0NLRitPZG1LYm4yKzV6TjlqbGZ3eksvTjF2ejhMQ09C?=
 =?utf-8?B?MXVCQ2NsMUVUS3NHVzNoaEMwSHJTemh3a2RLV2wyZitMWHRJeUVCeEpZclVU?=
 =?utf-8?B?L1dlTEtyeVZYNlRvMWVqcmp5OEI2Rndnd2pPNS9SNFZYdDNNUStYdVpnUXdS?=
 =?utf-8?B?MEpaRzBLbHR5SXYrQ3Y5dy91eml6MWdZaitYdlNYYVovcnNXVFpiMSt5TVNv?=
 =?utf-8?B?cTdOdGRXbVpvaFBKRGZwcE55Y25OZXlYd08wVkZWZWdxUnB4c2QzMHdSUVI0?=
 =?utf-8?B?bzVGbGYyak5UNmVVNFQwcFdwUnZUV3cxZEFjNjlic0g0NGo5SlR3eVpidWp5?=
 =?utf-8?B?ckY1ZDU0VXpwa1BJMGU0WWRsMXUzNFkrTjgvZ0VJTDU3YTNKRytjYU03NVZQ?=
 =?utf-8?B?ZjVLenA3MzN2c0YxZHV3QWJLUFJUL3FBVWJyQ0VrVW91djMzR3lGTm1sSnJs?=
 =?utf-8?B?WHRkcFI5YStqTkI5L2hhM21wc1NnQ2tOcXNIUUhES0lQTXhINWlkeEFVNDFl?=
 =?utf-8?B?OWEzOHdPUkw2d21zZEtmdm8wL0oyMGVrUjhYdmYvcjhjbm1keVp0V2luSmdh?=
 =?utf-8?B?NWwyTGM3SXFOWS9CUGZnazFMMzNNWi8xSmx6MHFnajNhRm0zMnRIMTB5N3BD?=
 =?utf-8?B?Sm5wY3VhT094TnZFblZHWDlmMmhaUTlEL3RmbGJTekxrVk5OMzlsZ3pRTzE1?=
 =?utf-8?B?dFQ5c2ZqZkxMOStSMHplejVmL0drOHNhN0JVZ0lDeVFKUDVQOHl2Q2V1YUd5?=
 =?utf-8?B?MnhSeDFNcjFhQjdXRHZ4MnJ6dDJFZ0hCWnBxUEJHQkdjc0FrWEVvNGpkZlJL?=
 =?utf-8?B?TzJIdW50bjRsMWNVdEU4YkZrVmZUM3drcENNbEM3V1NaSUEvMlNVUnpNTXdt?=
 =?utf-8?B?ZVJsL0tUcVRsRTNaUUNxaUgveFlIZDB5dG5qN3BnOGVualRYUUZrT3ZydXJH?=
 =?utf-8?B?TkdrU01FTzRUMGE4Z2paQTNCbFUycFhZdllOM1k1NFBCUzhCcitpQW9OUkdv?=
 =?utf-8?B?LzBlUjN3UmVBNk4xcDJGMnozbzNGNnJ3U252SXdhbTFZZzFsSENnWE5wOWph?=
 =?utf-8?B?R2RYTnFXN2xuNkhhTXNUTzhnRjBUcjVrS2ZFdUVuZEpXWk1ES1g1aFdnNVVF?=
 =?utf-8?B?YTc1NUhJaXdnYWFsUzdkZTV4bVFYNzdXaDNXV2YwcTRad0RCWGg3MmtoYlhW?=
 =?utf-8?Q?E01QZwalFuXd7DljMrdkl5tpZ7o3dQAdglPnIaWCaI1Ji?=
X-MS-Exchange-AntiSpam-MessageData-1: tbE1V8xLgbUruA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd02910-a0f8-4a99-97b5-08da43bf70fd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 11:11:14.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3AoFESFI8rjfRkPvkdudbyK6lTnJ3SH216N46C4YfVvsqWId6EJbxG6+g5+V0NSFZV6CRZrdoOEVHJ1yb3zRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3404
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-01_03:2022-06-01,2022-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206010051
X-Proofpoint-GUID: CGbJJwgZbC7mN9eyLebB7ag4Yh9Ifj2B
X-Proofpoint-ORIG-GUID: CGbJJwgZbC7mN9eyLebB7ag4Yh9Ifj2B
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Reviewed-by: Anand Jain <anand.jain@oracle.com>


On 6/1/22 15:04, Filipe Manana wrote:
> On Wed, Jun 01, 2022 at 04:52:54AM +0530, Anand Jain wrote:
>> On 5/31/22 20:36, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> When creating an inode, through btrfs_create_new_inode(), we release the
>>> path we allocated before once we don't need it anymore. But we keep it
>>> allocated until we return from that function, which is wasteful because
>>> after we release the path we do several things that can allocate yet
>>> another path: inheriting properties, setting the xattrs used by ACLs and
>>> secutiry modules, adding an orphan item (O_TMPFILE case) or adding a
>>> dir item (for the non-O_TMPFILE case).
>>>
>>> So instead of releasing the path once we don't need it anymore, free it
>>> instead. This way we avoid having two paths allocated until we return
>>> from btrfs_create_new_inode().
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/inode.c | 11 ++++++++---
>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index 06d5bfa84d38..3ede3e873c2a 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -6380,7 +6380,13 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
>>>    	}
>>>    	btrfs_mark_buffer_dirty(path->nodes[0]);
>>> -	btrfs_release_path(path);
>>> +	/*
>>> +	 * We don't need the path anymore, plus inheriting properties, adding
>>> +	 * ACLs, security xattrs, orphan item or adding the link, will result in
>>> +	 * allocating yet another path. So just free our path.
>>> +	 */
>>> +	btrfs_free_path(path);
>>> +	path = NULL;
>>>    	if (args->subvol) {
>>>    		struct inode *parent;
>>
>>
>>
>>> @@ -6437,8 +6443,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
>>>    		goto discard;
>>>    	}
>>
>> At discard, we free path again and leads to double free.
> 
> No, there's no double free. The path was set to NULL after being freed.

Got it. There is no double free. Why not make btrfs_free_path() inline 
so to avoid a function call.

Thanks, Anand

>>
>> Thanks, Anand
>>
>>>   > -	ret = 0;
>>> -	goto out;
>>> +	return 0;
>>>    discard:
>>>    	/*
>>
