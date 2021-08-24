Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE78B3F57BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 07:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhHXFzU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 01:55:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11294 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234052AbhHXFzT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 01:55:19 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O0x6fY014800;
        Tue, 24 Aug 2021 05:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bLLldLRqHpOXTTVa2eGdB36Ib0ZrzQnW8jcuB2koxWQ=;
 b=n6EmKxMjw2208dQN4ws/jvlmSFMioCqZad8SgMv6khGT8PvF8ZGsp/Eeo1bjtjpto0wR
 iv1fzGZqI7HQ91c5+C/IIngojp05DDqB/ATSgOB+yojE3jTW/OY6tuc/7bjuu3xLw3cz
 eXniZLXfQzcnFgdAVm4356xIRvYuH+AEOKSrliwLlnjUyj1SNlaRWi0Gi8HOlXtjr1bR
 42yhT4gI0chltcxfYC14vamZK2lbHzmX1IAxZvlMexoDL1uJntpUmHnuCY3wkZwiusfJ
 7NWomptt3QcN8884zmfocwIViJTmXPIXpZzzxXCvXHT3frO3JKefFFPPDncVgshk3PeL pA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bLLldLRqHpOXTTVa2eGdB36Ib0ZrzQnW8jcuB2koxWQ=;
 b=W+HGzw5JxOL5iQ+52aDc93090/tyOFvkA6v7/WMrkNVde0oxib1cVBSjyHhOyHCK++kd
 mU/0/MFrcNG0uLTFAcA8GhL5v66c2I1O0ZbgLUg3bo1UqZqe4ztKmN3045eA1VygO/T/
 sYV5L0AY3yCelVq/OClz0pEwEDnI3cvrTx+WsBD6A1spbr4Ug7ha49WK6X3ep3PJ6zHD
 cIFlhRujMSIUymj9muteD33FnW74i8blCNe9Kd6mWON1N5ZmbwgkZiNho8lMmRTUJqpT
 madOn/3EKoiMkz9rcqntQAfvJVsPyr1IMl2azenJ53DTgwd/2rAs4N86ITqnfp7f+wXd JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akuswkedv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:54:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O5jDVN149222;
        Tue, 24 Aug 2021 05:54:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3020.oracle.com with ESMTP id 3ajsa4nhxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:54:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFvABQSxhyJdOCteZKjU1FcUyRw5qGfNKo9dYLVNPPWmg5OQNI8NETMFU7OFCZsjZuc7yw8lHjJPoJCHGt37vBfFB5a6rFVmFdKgpwgT0epIQAnQA9uCC5nq1bfShrrVGCXggNwBerzQPXhcA3J8z65i3agSgpJzIY/BhkpsOl/59Z24xc1PT0pz3B7BRT+OIU7odoJAVkRaCcS6ym5AFlpWSv6L2OB3zSKdyoGJeKeeKp1oU0j+RBoWccyUDVwpdfni1GTzH7wXCYEAOzpFlfXqAn5k653rAML8YMmRPXTy+U74Ds2yrP7pYQ/iGW4MzMhtyimOfBUnsCRjXOPaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLLldLRqHpOXTTVa2eGdB36Ib0ZrzQnW8jcuB2koxWQ=;
 b=VfDWxrtpE10bVywzuo257u/6fzkNyTrI5PWNGIzo8n0KdlgfxLNFR3K4vU3dtj2G/H56GV9L7mPmwfFFBvDUKbA4CGNatged7Nk1ccAYlOoPZTmbgz3hFYElCZ8LeQ8U+vpd9+0MJVY03sMPbLNJ7j5cugKgk1DXw49crE60W1f6TQYXJY6Qf5R5MNRchn1XvX19I5oonXdae7Xsz7aZpQIlVyrFXeV0IggH4ZLZlKMySymw6ma2too7p6bHnALOH23PW7oYHxXdhEoaTh5RBSsZMDnlwadDT5iQIn2AN0oR0yJuwuyPMk6IQ0uh41TSWL5PChvzSV82sz69oLtAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLLldLRqHpOXTTVa2eGdB36Ib0ZrzQnW8jcuB2koxWQ=;
 b=jeWovj1BU96jZD3nB9xr/jNHms4Fhfms1L7fi9NeQBkk06fEqJr87ibKtrVkE7Z6WIEH28nysc+gJEVYcrJTSI+gCkkHvI2e5cxRf1X4q/eQK55p4ozrIqWzkpPR41B6uQbOHe9ViP+/Lb7A3g0V3/2JgaHxhjszMFyE4x+93ao=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3837.namprd10.prod.outlook.com (2603:10b6:208:183::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Tue, 24 Aug
 2021 05:54:30 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 05:54:30 +0000
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs: fix max max_inline for pagesize=64K
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
References: <bfb8ebd29d6890022ddf74cea37d85798292f6d4.1628346277.git.anand.jain@oracle.com>
 <20210816151026.GE5047@twin.jikos.cz>
Message-ID: <d418c51c-abc5-d08a-aa20-7781cfe1741c@oracle.com>
Date:   Tue, 24 Aug 2021 13:54:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210816151026.GE5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR01CA0170.apcprd01.prod.exchangelabs.com (2603:1096:4:28::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 05:54:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 001791ba-96f8-4164-0e5f-08d966c3a3e7
X-MS-TrafficTypeDiagnostic: MN2PR10MB3837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB38370777D9AC11A6A6EB2FC7E5C59@MN2PR10MB3837.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7KR33S+Zg4ue4K32b3KQhdt3w0auiEDuN8AusEuRSSraPWNjowTUf24SzcFlDsoS30lHQq1NFo7KVxRnkdkNAMZgW/P55KpCKjnYsY+dtqfvMRRtj9AO/k75XpGKUjYyA5FFovXMUDFgPrGJSgXQxVlPB+7UiUhTGp9VEiGf3SNCZQoTS1FKyxGNecodxNUK1TmpmFXc102NsDSXPb5WbpbgtRICkQSIVfKFPBb2pZ6xJUNXnwrAF4JI/FPSPn39Ii8mxk9dpnsCbs4xJFnOeZ4nqyFIrPqq2y+tU22Ku5GGems/EQXpefxbrcZsVF92tEc+t/8CR2dSxIg9ShYZ/8JGfM+y3PimkYLfSy4IktSBXzJY0p7Bpj3mWRbtg5J53ih/9PTVGJcCGN8LNfXJ1Agh9pk3naYWsdAgOj5PhZqkf8yXFywdcFnxezKtXPjrBbA8wRMx47DFAQHYgL7JjAXurFc/5AA1wrmtOTsMHWba+a8gMy9zjippkBVTlUwkpkscp5dZgPt61iXpOwTmCu8EzxK/mCB3yDxapwpa22WogL0sSjRSy89a9pZtxwGq4/m+JignPt7l9P5GM1ilgwuXO0sx3WkfUHUKG994DziJdtej6hppsSZRsKrU+vQBdeysZGs3jFaOX3G9begq9o2DUZjzhCQyE18lc3MMYwqkQXju7FTz8U56PsJy9wo8mq5AZN+jZPr2WDaaAX0a0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(136003)(376002)(6486002)(86362001)(8676002)(2906002)(31686004)(36756003)(2616005)(478600001)(53546011)(31696002)(6636002)(186003)(956004)(6862004)(66556008)(38100700002)(6666004)(66476007)(37006003)(316002)(66946007)(44832011)(26005)(5660300002)(8936002)(83380400001)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1hQZTlnK01hby9UYzhvNUtZRmtGeWxEV0NiSEZkdVJZUEdrbEJidiszbmtT?=
 =?utf-8?B?NG9pNDBBV0dWTDgremtvL2lmUGY5L1lodE5sUVdjWnAvWm53a2VPWVg3Z3dQ?=
 =?utf-8?B?V0JZeVB3MW45UEpnRE5yRUdpdTNDWk80b0VOZHVNeExJL1lER2R5dDY3cHRi?=
 =?utf-8?B?cW1VaHdRVXZ5Z29zWWVLVWxuVWQ4NzlydDFiRXVJOUU0Qmh0L2NGN0JLbXQ4?=
 =?utf-8?B?aTg2ZTNEM0xKb21LMi95ZE1DY2VPbTNWRkFEYWdGYjRkRkc4cVFQb2JXNVV3?=
 =?utf-8?B?SldndjExWkRWVzVQalZUNjY0bTFZWFd1bW1HWnNsL0k2WldCY0RQcjk2VzVl?=
 =?utf-8?B?cEw5ZnFYMTdxUEI5dVBtTkM4eVNlK1dvcnlHa0R3Y1k4UUxud2RRVk16aE5k?=
 =?utf-8?B?T3JIc0lVYVBma2JpaG5LYXQ2KzQ4YXByU3NqaUN2OHQ3RGFlMkhtdUVTa0w0?=
 =?utf-8?B?OGdhR3VENCtmazBkNEptdDNKbVhUT1RqOW8yL2o0SUNYYnhGL2NOZExib3lp?=
 =?utf-8?B?VUUrTFRuWGNjZ0dtSDVHSE1CaklpR3FzWTFzeVgwTHl1elQ2bFhFaUlqcUpM?=
 =?utf-8?B?M3pwbjJBcmlOZlFBc3pYMWZnUkpCeGJNVmpvNVNVY3RGK1Zha1hQMHZXdSth?=
 =?utf-8?B?MDNNZjdrNGszU3c5SWM4MG9rK09PaFhHZkN2ZEtQUmxWaHNsV0pvYlBjTHJL?=
 =?utf-8?B?OUxxY0l0enZsb0UxVER3QURJVE9Zc3ZWTHpiM0tudkRrMU1ta1dSRjlPc0Jx?=
 =?utf-8?B?NDQ1ZXN6YVRRcDVKVk5CdUd3SDVzeVFnczMycTc0eUhjanh3MS9FUlJoNEVw?=
 =?utf-8?B?WVFZRnVoS2ZMNDRMOFVWWTZHZ29HNG9UZklodmNlZ1ErRmNtN2E0bW1FU0JH?=
 =?utf-8?B?VnUwamVDbUVOTUhLVHpvaGQ0VlRzNzBLSUhUQXd1d3llT1lTOTJ2b2twejlv?=
 =?utf-8?B?ekJ2b0FBVEd1RVo2amdxQ0Qwd0xhc1A5eDlyVXk3YWxQTGNvWnQ5VDJDMWla?=
 =?utf-8?B?eFhoc1VkckM1NGR0aTVOWStMVmZlemc5NTN4OEdMVmljdForL3VOeU5qdk8x?=
 =?utf-8?B?endGbjNTYUljOWhpUXhPcUw1TWJvb2xCL00wMnJyd2dQbnA2aWk3SFc2YnZ3?=
 =?utf-8?B?WjV2bjFueFdVZ1kzVjdjSitzMWROZDlxUkFpcVB1UmdEbnIxMnh2UlIxbWdQ?=
 =?utf-8?B?TmNzaGUxNEVKTm5Yd0hNN2tycjJZZDZodjM3SjBXdENBL1dFTlFkQ1pFN3pu?=
 =?utf-8?B?TVp6aXcxU2VmKzNWNVBGeGw3VFpBM01LK2FKZWZWQlNKb3lHVFVtdGxwbGJu?=
 =?utf-8?B?R0ZsKzRmdDNVVVRtWjF6YS9ITmVVMHFzSUZ6b01KSVpadnVNSzVsejJoZnNI?=
 =?utf-8?B?S1IvTnQveGloeVg3cHpEZTlydjdwZ09jeGFFczlTWkV2a3J1Rm0wa3hHb1Bu?=
 =?utf-8?B?VHJHZGJkZmdMZCtpcXh2R0lXZ2ZhZFZOeWZ2aXJZekt1NngxR2hQMEFlT05a?=
 =?utf-8?B?ZnJrdG9vRTdZQTQ3dzg1QVpMVFEvOWF2OWVRa3lhT2k1QU5IY2xqUG16VkZY?=
 =?utf-8?B?V0E3QkVLWUhEenp2VkR3d29neVp6K2lYaGRMOFl2MGZkOHAzL0tpRm1kbXFt?=
 =?utf-8?B?dFoxUFZPL0dBSHZ1T0xlemZnQUN0TkhBQkhKMFROS1pldWUwenRFd1BpZXdP?=
 =?utf-8?B?dTBmYVVjV3BKMHkwY1EzTVZCbnBGNzU3NkF6NTRLVTVaVTRZK0V2NGkvZnBZ?=
 =?utf-8?Q?YNo5JQb7mbrWgGF8OcXOcyLYFCpSJhneIC1yjoz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001791ba-96f8-4164-0e5f-08d966c3a3e7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 05:54:30.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xy504JHWp18zWUwbdn+cqNss38X0I8G91VX1SA2DTZYIax5T9IgzAllZctu5fxF3XPPQGTiL/aj/hfpsbj/5Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3837
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240037
X-Proofpoint-ORIG-GUID: JeLYRfnxj3NwZ8cFYlaIQwnROSMUi8Ap
X-Proofpoint-GUID: JeLYRfnxj3NwZ8cFYlaIQwnROSMUi8Ap
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/08/2021 23:10, David Sterba wrote:
> On Tue, Aug 10, 2021 at 11:23:44PM +0800, Anand Jain wrote:
>> The mount option max_inline ranges from 0 to the sectorsize (which is
>> equal to pagesize). But we parse the mount options too early and before
>> the sectorsize is a cache from the superblock. So the upper limit of
>> max_inline is unaware of the actual sectorsize. And is limited by the
>> temporary sectorsize 4096 (as below), even on a system where the default
>> sectorsize is 64K.
> 

> So the question is what's a sensible value for >4K sectors, which is 64K
> in this case.
> 
> Generally we allow setting values that may make sense only for some
> limited usecase and leave it up to the user to decide.
>
> The inline files reduce the slack space and on 64K sectors it could be
> more noticeable than on 4K sectors. It's a trade off as the inline data
> are stored in metadata blocks that are considered more precious.
>
> Do you have any analysis of file size distribution on 64K systems for
> some normal use case like roo partition?
>
> I think this is worth fixing so to be in line with constraints we have
> for 4K sectors but some numbers would be good too.


Default max_inline for sectorsize=64K is an interesting topic and
probably long. If time permits, I will look into it.
Furthermore, we need test cases and a repo that can hold it (and
also add  read_policy test cases there).

IMO there is no need to hold this patch in search of optimum default
max_inline for 64K systems.

This patch reports and fixes a bug due to which we are limited to test
max_inline only up to 4K on a 64K pagesize system. Not as our document
claimed as below.
-----------------
  man -s 5 btrfs
  ::
         max_inline=bytes
            (default: min(2048, page size) )
  ::
	In practice, this value is limited by the filesystem block size
	(named sectorsize at mkfs time), and memory page size of the
	system.
-----------------


  more below.

>>
>> disk-io.c
>> ::
>> 2980         /* Usable values until the real ones are cached from the superblock */
>> 2981         fs_info->nodesize = 4096;
>> 2982         fs_info->sectorsize = 4096;
>>
>> Fix this by reading the superblock sectorsize before the mount option parse.
>>
>> Reported-by: Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/disk-io.c | 49 +++++++++++++++++++++++-----------------------
>>   1 file changed, 25 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 2dd56ee23b35..d9505b35c7f5 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3317,6 +3317,31 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>   	 */
>>   	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
>>   
>> +	/*
>> +	 * flag our filesystem as having big metadata blocks if
>> +	 * they are bigger than the page size
> 
> Please fix/reformat/improve any comments that are in moved code.

  I think you are pointing to s/f/F and 80 chars long? Will fix.

Thanks, Anand

> 
>> +	 */
>> +	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE) {
>> +		if (!(features & BTRFS_FEATURE_INCOMPAT_BIG_METADATA))
>> +			btrfs_info(fs_info,
>> +				"flagging fs with big metadata feature");
>> +		features |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
>> +	}
>> +
>> +	/* btrfs_parse_options uses fs_info::sectorsize, so read it here */
>> +	nodesize = btrfs_super_nodesize(disk_super);
>> +	sectorsize = btrfs_super_sectorsize(disk_super);
>> +	stripesize = sectorsize;
>> +	fs_info->dirty_metadata_batch = nodesize * (1 + ilog2(nr_cpu_ids));
>> +	fs_info->delalloc_batch = sectorsize * 512 * (1 + ilog2(nr_cpu_ids));
>> +
>> +	/* Cache block sizes */
>> +	fs_info->nodesize = nodesize;
>> +	fs_info->sectorsize = sectorsize;
>> +	fs_info->sectorsize_bits = ilog2(sectorsize);
>> +	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
>> +	fs_info->stripesize = stripesize;
> 
> It looks that there are no invariants broken by moving that code, so ok.
> 
>> +
>>   	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
>>   	if (ret) {
>>   		err = ret;
>> @@ -3343,30 +3368,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>   	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
>>   		btrfs_info(fs_info, "has skinny extents");
>>   
>> -	/*
>> -	 * flag our filesystem as having big metadata blocks if
>> -	 * they are bigger than the page size
>> -	 */
>> -	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE) {
>> -		if (!(features & BTRFS_FEATURE_INCOMPAT_BIG_METADATA))
>> -			btrfs_info(fs_info,
>> -				"flagging fs with big metadata feature");
>> -		features |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
>> -	}
>> -
>> -	nodesize = btrfs_super_nodesize(disk_super);
>> -	sectorsize = btrfs_super_sectorsize(disk_super);
>> -	stripesize = sectorsize;
>> -	fs_info->dirty_metadata_batch = nodesize * (1 + ilog2(nr_cpu_ids));
>> -	fs_info->delalloc_batch = sectorsize * 512 * (1 + ilog2(nr_cpu_ids));
>> -
>> -	/* Cache block sizes */
>> -	fs_info->nodesize = nodesize;
>> -	fs_info->sectorsize = sectorsize;
>> -	fs_info->sectorsize_bits = ilog2(sectorsize);
>> -	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
>> -	fs_info->stripesize = stripesize;
>> -
>>   	/*
>>   	 * mixed block groups end up with duplicate but slightly offset
>>   	 * extent buffers for the same range.  It leads to corruptions
>> -- 
>> 2.27.0

