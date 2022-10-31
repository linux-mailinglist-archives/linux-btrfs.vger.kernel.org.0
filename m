Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1406A613161
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 08:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJaHvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 03:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJaHvP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 03:51:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEA4764F
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 00:51:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29V3d8V7018117;
        Mon, 31 Oct 2022 07:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eMQvOJe6/nbRf78h3/Z5XPnTsYcO9nWijeM6i1/D4pw=;
 b=z7c5EpiLrXXLGOQHDc1V51PYrsoJEHU0wsQsB2O9F+r+fj59wHI0RuVu0BrPopZ0B3Bq
 JQ/uoWWV8T0XeKV+NINvpHQd/b/GSTQi/Ql71wDyYXJ/e4mUNQang1BFTVPzQL26K1S/
 htG2USzcR3hkjaVbIK2RHbaitYpAB8CVK2fc8QCG2DI2e4Wf/mc3vSSZpFjhnKfKcs8G
 vaWE5sNeQdHDnuW7Hfh9aWwKWThQyybN9AA3qGquPxYUKjsgn1O9ATZ18RNFe+Z/X/+d
 94IGkA970lJIVl6DgpmqrkQcDOEVpsS8n25WBSU+XWWRZIJuVNIXlutNQcDBWVXglAj9 uQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty2tt46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 07:51:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29V5FMFu023884;
        Mon, 31 Oct 2022 07:51:09 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm31e85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 07:51:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W56uDfmzEkYRfe1JHmt0UvNH6dVPasrhJammLFoe61nWePqFXxWSs3OfXG6EK8zJ7upgRWPO1H9GbSgaCsrKVz+o0YLfBlAgvzRyu+fwozdaqjjvFn0rrJwylzFxSaurhhi/tllGAMLfejYl/68hL4lbdGDAt9Sbe3BPZKiPgOIPWFlWvpJGeLRWsQZmqeeWoiT4lBMSZCsSfB2T50P85y/H5zj27emQmGLd3cS7MgmZg/sbZGKJxr2BW7KbZ5XhQxdw7xD4VwfQAm446J4kbATojTF8nqpwA/4/uTbVg8ZOyz+Mmb6BzNm5kALJQk5YTG6saYU19hqdNM4G5Ha6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMQvOJe6/nbRf78h3/Z5XPnTsYcO9nWijeM6i1/D4pw=;
 b=ZJFIvtJRRo8HNYv1q/2044ygOSl+Zlf3Q+a5q0rrpk9zfgiBzlAcm+8SxCfib8wx71iud7WId0+EkueeIK14lOOO5KHvXvp5C4QM6ieGFSgn+udzVBG4afZuvKxV2gdDGinVhk3RiKDUfQfUsoaxlprBiymFu86OE90g1LpkkjqnRBChh68Xj6GXn8BdKBLzOyqGMQRCC1LRU5MKT+g/amWieXJ1qCwSmjek9iAfdOYhoBRjB7Q3bQGDsUGX4GDxHsVwimNIh5l7UfDef6e+BYBUq75E8grc/Q/OYktoLJAVzBgH1Vn84E0fllLgdFKDbKyypmWfj8uzsYe2bDAmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMQvOJe6/nbRf78h3/Z5XPnTsYcO9nWijeM6i1/D4pw=;
 b=Ut7vACjv8CyLb2R9aqvddR/GpMTJ4zZFpq4xBUo1oAAmLUUhZ4oGXp95u/X0+jEDQbct1JyrWCf+oPGhijfIibFPNXpLbErL9Ui74xHKpQOAkmOpcMtrAtwVLEeJWrnP8RIA2H/UMtyjvCoPP/Cgq8KVeIh+lrSlKrQSVtxe70o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5358.namprd10.prod.outlook.com (2603:10b6:5:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 07:51:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b%4]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 07:51:07 +0000
Message-ID: <75374514-30c6-b75f-fbfc-b72b6475842e@oracle.com>
Date:   Mon, 31 Oct 2022 15:51:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 05/26] btrfs: move the printk and assert helpers to
 messages.c
To:     dsterba@suse.cz
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1666811038.git.josef@toxicpanda.com>
 <051b9887171d14d8d5eb30d3274a946427ed3c69.1666811038.git.josef@toxicpanda.com>
 <974d0f7b-1272-1c7f-cf34-88104642e7ca@oracle.com>
 <20221028193717.GX5824@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221028193717.GX5824@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: 626b29b1-89f1-45c1-d0f0-08dabb14ab23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAQCsSaW9275sLd+CtqlaMHbm9Q4OFJey90o5dqa8yy4OnofmwPcOUN+HKJvqNRqt7O8XYclQ7ORiiDOA8GiORcxqMCSphsnEaeKxUOpKHfkTSzK15by2vpIOtcbX6nldE9jP8t0XesA6by8P6e3wzlqNur1vdCTBQwSB0tzNoM4JUgWB+1UJH1om6H452AfHM5PD+5riFz1jmM3z3CQDFi98qgOM7sLKuy7CGfvONm1m/p1DjE+xVrOlLDkhAPx7mxuQ30oYNwQhLQOsM7F7F6d76ZkDEK9JuG8CxQhajZX4fLPSa6y92hEsku71tJEGqex0lqrZ4NxVqjOjFN4xawUlrvYZ1rXnjX9gdW6756cXrNg/5gxJ1LchXVqNyRyrzz8U/BRFalhb7/HCWoKghgTYcvh3p+pH+RUMMgRjICv566F9rKyv9kGPCWt3CQ7Ak718h4802oiO9nzNFCDOa1xV3F9GeSSSSom55GnPZUww4evFrpuyEdhgpyO1OC7PDxfjq2RpntKjKCpnnrxj5U7XQo6T/kT3FOv/hkZe7S97hbChkQfnuf7HN1YFE4Tw1MaQ4jQGiuFuHDxbdDBbbvXPLwRcLuRuPrQf9nuWt20Elhq7P/E9BmzL3h1AtKail08R0MFOQDZto17xXrH+aGrvbV26CTwitFmWfVB/6F78CzcP+hT84N6E9cRpr4g8tt417wE/HqvEB4H/8GJmrt2wQKbUuhRLuJSr19SvqSBb8+Hn80jnYo1gAPx/AQxSXCMn6R0OiA/bnhLhMomAuJhBZwil1nFOm7bpyvpaGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(83380400001)(31686004)(6666004)(15650500001)(6486002)(2906002)(44832011)(36756003)(31696002)(86362001)(38100700002)(53546011)(6512007)(26005)(186003)(2616005)(8936002)(316002)(66476007)(66556008)(8676002)(66946007)(478600001)(4326008)(41300700001)(6506007)(6916009)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXdHQU4xaDhKSGNpWkhYZGltdnNzTXAwRzlMQmRFckNRT3VJeTB2bUI3eGJF?=
 =?utf-8?B?SHBPd3ZwL3ZNMlhSQWV5eHhWRGtQekpTRExYanF0L00ydnowK2tRb0NYcWM5?=
 =?utf-8?B?TjhQOVZPb014bjdORFJvdTJXMnNjYmxQTjlTdWhWZlZZeW5FeXpuSkJoQW1h?=
 =?utf-8?B?MkxSYUdFdnQ2MG1zT0hFbWVOcEhLUlRaMVdZbUlEaUVpRzZiYU82VDJra1gy?=
 =?utf-8?B?cDBhblhzZHpQNWhPVVltNnJiSTZyMUdkZjVsdEtMbE1Ta0I1MmZNWDVZWVpi?=
 =?utf-8?B?cTFIb3daYWpoVjBUM0dmbExJQWR1R1BRT3lSZnF4YzdmSGVjUDYvRUdva2pu?=
 =?utf-8?B?YzZmY0dqa2lpTWhCaFI5cStLOUxhZWdjc1ZJRXJvUTl3Wlpna1ZpODBqQ0VQ?=
 =?utf-8?B?dTd4NDY3WGhKNGh4UXNMeU9mODJRQmFEUlFLMDBvdkZ2eGFrc3VNVWdJWWxq?=
 =?utf-8?B?cmVXOWdxOHNwcmFWM2h0YnE3N0RzM1BkWkU5eXd1RHpRT2p3TXVLb3o0R1Fx?=
 =?utf-8?B?cXUzWXNCNTVLZElDc3NYbHRSSnJEMnVESW5XSGdFaFMySnpxNjdxNkpuMXQ1?=
 =?utf-8?B?TGw3c0ZJczRCTFVGbkJ5NHZuV3lvRlhORGVBdldqV3NnWGNXd056bEluOGFi?=
 =?utf-8?B?Y2R5VkUzc3pSdEFKQ1pyOEVKQkJYZnVGT2VtTjlyeHpGVmVhVG9uOVhqL0hX?=
 =?utf-8?B?cUlCNlp0a3pPaExOREpiZlpHTTA3a3pnaDNBYWgwTkgzanE1UE9JbGdQRzM0?=
 =?utf-8?B?dW9ndStXNmdBL2FNeUNUUjUyeHNBa2tOSWoyNjRzeUs1QVJLdHU5ZjdJMkhC?=
 =?utf-8?B?dnQwSE5ERW1SbDRZMUtHVkRCQ2dKYzZxR29tTzFnSGQ0SFBrSENsU1lDUUl4?=
 =?utf-8?B?R1NVWlc4TmhSRnB2WFQwT3IyU3ZiNmZlbmhzZi9oNEJET3NWYjQyZ3ZwejhY?=
 =?utf-8?B?TUo1eGNiYnEwVDNBMzZKRzBzRk5LcHlQRmdIUlk3S08rMlIyQnc1SUYxb0ll?=
 =?utf-8?B?b2RobFNySUxwL3NmbFF6Z1FmY0tqYUdKQUo2ZXVQcGwzbTdWbEcrejdtbFRu?=
 =?utf-8?B?ZlcrUTN4ZEREMjd6VDN0eXlhZy9pTENBY005OHRmRG9makYvWUxSSFlSSFlv?=
 =?utf-8?B?azc2WkdlbllsWGZtZm84ZUhtOEIzNmk0dGhBeElUeUIzd2F3RmZjU1FVWGU4?=
 =?utf-8?B?cyt1cVZES1pDWFIrYWNpSG1HZHMrREZkSFpSb0tQTWJrcFQxaXNqRnVqQnVy?=
 =?utf-8?B?M3dQVkUvaGptZXM0eTBPWjR3T04vY2lQU25LcWZUdjZvRlBub093RU9teEdE?=
 =?utf-8?B?b3hSZjJGT0FNY0FVaS9rSWJPMXYrenRVMFRobHZZaTBVaG54WUVLdEpzRWpG?=
 =?utf-8?B?Z2hyM1FiNmZWajlNdnJJbEFHa2lBMTlJT2grY2NiZ0svRjNZdlhKNDIzZ3h6?=
 =?utf-8?B?MjVyWXV2aG93dFVVWE9Wazl3b3NON2tEb0RSb2lDY1ZsL0YwVnp3K3ozcEMw?=
 =?utf-8?B?VVNUV3RhQnlJTWl0THpjRGZjUzhRcGk5YVJrM2FHYmlFbGtmc3QrbmdrUzdR?=
 =?utf-8?B?ZDVqdDN3TU1Pb2ZmWDVkUTZnaWY0dldhOXZKRkZrUXNPWTlQNlpJc0dQOGJX?=
 =?utf-8?B?VmRGbEM0Y3pNaGhUSCs1NFJpS3UxVlcrQXNXLzhsdnhveGUrenkwdWVHVTRo?=
 =?utf-8?B?RUtnMWkyYm12WDZNVUpDak9ZdGJHZUVzMzdZTllRbjFuL0Z0V0t2WWc0bmJj?=
 =?utf-8?B?VHlSOWFkMnY1b05Ud0NSTkRYeWNZQVZGMzRNVnkzY3lWeFYwTFFXNUU0VWdx?=
 =?utf-8?B?NTN1YmdPMEdaWlNVcWcxS2dRWW1mdnptMlMweHQ3d3NHc3hldkt2WjgyRDJK?=
 =?utf-8?B?UmpYMTM4N0phV2hCd0RGdnRQWWRjbWpIZDhNZkI0NkU2NjBHd3BWZ2lEOUJK?=
 =?utf-8?B?eEZBQWRodDRVQW8zaVBMTzVMeGV4dGhUZS9iOCtNbENzOXQwUkpLY21Ibm5z?=
 =?utf-8?B?cEsxWXRsSG9pd2cxcnVKWUI0OW1TcHFGY1hmTHlHY1BBTWZCNHl5QVpjRFM2?=
 =?utf-8?B?OUdJVnFyV2ZlM2U5WGthMkpZeTIxVGkzWUNyQXVqZnBJdGJNbm4wamUyYkFs?=
 =?utf-8?Q?rf+n6S+syMok5CMEoIbtrHluG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626b29b1-89f1-45c1-d0f0-08dabb14ab23
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 07:51:07.3993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJFPFE+4QiV0O94DOBlXh9OuoT758nsTiImODaDYgidRmbVaXQi/PJwaxWLvS4VogHx3v6m86ndWcq68NFZn7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_05,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310050
X-Proofpoint-ORIG-GUID: 5ErVaby9zJWFf_NYyG7j8SJ9eN7ZycR3
X-Proofpoint-GUID: 5ErVaby9zJWFf_NYyG7j8SJ9eN7ZycR3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/29/22 03:37, David Sterba wrote:
> On Fri, Oct 28, 2022 at 01:22:54PM +0800, Anand Jain wrote:
>> On 27/10/2022 03:08, Josef Bacik wrote:
>>> These helpers are core to btrfs, and in order to more easily sync
>>> various parts of the btrfs kernel code into btrfs-progs we need to be
>>> able to carry these helpers with us.  However we want to have our own
>>> implementation for the helpers themselves, currently they're implemented
>>> in different files that we want to sync inside of btrfs-progs itself.
>>> Move these into their own C file, this will allow us to contain our
>>> overrides in btrfs-progs in it's own file without messing with the rest
>>> of the codebase.
>>>
>>> In copying things over I fixed up a few whitespace errors that already
>>> existed.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>
>> LGTM
>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>>
>>
>> a nit below:
>>
>>> diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
>>> new file mode 100644
>>> index 000000000000..a94a213da02e
>>> --- /dev/null
>>> +++ b/fs/btrfs/messages.c
>>> @@ -0,0 +1,352 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include "fs.h"
>>
>>> +#include "messages.h"
>>
>> messages.h is not required to include.
> 
> There's btrfs_crit, so it's needed.

Ah. That's indeed correct. Strangely, compile is through without 
messages.h include.

Thanks.
