Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E37727FA1
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 14:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbjFHMIp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 08:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjFHMIk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 08:08:40 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEE9184
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 05:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPrfTt90VfBYF8yJRUbFL0yY7hC3trKaehYqf+/JGEtWf5qt4xDSCi0pHGOQQ6FS222wfwQjGknx/sMDkNbWlYe8M5CGDT9YQKmwzBvZSM571xLYLVLLwViRXMvYzypBPIGgeT+yW6FuxR18wiqiMPLygzbukGoay3fCy66yL3AzTyEd36rYL1rrzr1uOOWFzXijvihZALXi56SX2T64e8yrx3ZMRr2iz8X7Et2aBeUj00X5FpQRC/IXUp9OzEsNgfz0Eo8PJDeUXeoj+DX583TQc2LBJ46grZ7zy3skQ5M2jIHryt+u9KeZlaY3/xwBAhuBdW7Z1p1FBY6qhv2imQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjIHZuXxnzzAmIY1C76+rp+CR/cTQaQ7zlH+U3/Qky4=;
 b=Arfr8GAqqVnvswiQt3umk3jLUtlhTIwZpMzlMZY1p8lsRjLD4ibcgtaLlHHBx3n9CdNRNfwv2dFPq2wE/8kw1CvV479iDF1j9C/4lcf+iDh6n5KdznpfIWm7fijeh/ZU4VwhDXXpjfZA5PxYQ0sku29n+eG0zm3GpVTHjoNPDbHSQhCh34odPQ7HaXQCQu6uUHR0Pd1sGLF6Mh/x0NFm9iLhCvhsm7MlNZUwGWEDG3CBH6o+AF21zlfc+5NrY7ixGPRjyXT3mFdxYX6WcWCyk+gRJwq6KYBdlqGwF11N3rAALKaGgAwAa3/BIXKGuGvJow+VeVsZ3LEMykxbKb80xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjIHZuXxnzzAmIY1C76+rp+CR/cTQaQ7zlH+U3/Qky4=;
 b=fBfVE6AFwDcCEQeqUvI/wf5uN2/tJRMvilgHblvFOsNDQcThH+aEAiaUIEV3ShWJczr7dJw5B889fEhP3Rffw+yhH9Qlz9nUUaPa+0iAT+9bLuKeO+Nkga9AD/WaZQsW0X8YRDx0+tEHo6yPp3gFxz8obptweOAjc5bQD31h6lLhUge9V92h+Gb6pzUOdMIg/uY9wTBuG+GED5ylV3vJFFcP1kWhFgcI2T4hPy18FBM7UYo+h5ymdXGxlMC8VZE4ck62yRoZ+0Bq19IX1F9g96YVHaQS9jzmJMeBxtMMa/a6xZlKbsE6ofP247QQ6PUyLjW+vhrl3lJhFLMqtDnwZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Thu, 8 Jun
 2023 12:08:37 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%6]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 12:08:37 +0000
Message-ID: <762f030f-c8e5-9b94-b961-c9d55618380f@suse.com>
Date:   Thu, 8 Jun 2023 20:08:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] btrfs: scrub: respect the read-only flag during repair
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <85514d999fd01d20cbabed1b346f58f0fb6f7063.1686017100.git.wqu@suse.com>
 <20230608115617.GC28933@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230608115617.GC28933@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBAPR04MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a1e18b-b654-4aab-5170-08db681916f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v30AWc/Jac8LAKNXT8O0YQ20S9+JaUnElmbKy6pTkjsx7YEKTpQG0DhYSzXjoqvYvPCG9ev7sbPshsbjnGz/TdCuP2ERxQqsVdp2tb/4QcStALnR0Up6VIAJlfoBlZheJg3RrZzT1wE7GhkE7LFAhdVParGQz3HERPkRyyab0dCPSnVm8zXVI7J6JlrIlR9yoQmfYGywRUNoBpVrE/ZWJBWhqnClMSiqgXHAx4zb1M6AApvUOP0bAkiDXWwBvMb1PWC+iypI/cNCuwT1BcOv1rIGPGhp5TTMg51pdyH/qpBZbYBzdTzPgA2Y+9vCvswYMEvw6HndMR1mOoDo5KECevbSBqjpsl5e0jPbFXvuy0L8S3sfbhxrLIMj8oU9E/53Ivs/MWzxYZ/JtPIxf1jsxyo2NvEMJMY67SfMs1yb8rAX3v32YXpg0cgGzBHF6yTYfNb9bQV+rhpnzc3wC3IHfw+cXUlKOt1GMHzKt8zCf6igUlbrkEVlS+EKwos+eSAIfk85bWeggDo5NgwDxQ7ujEFfhb1muInrg49KfDxiLsBdDNlko13B4J5/plUO135baHKek/poQeOtfNGh7bKaT/TjgbWLNwlLX1gNxkEmryJZSeMKblv71eip3y3ewdkfICKoFSh8zIhd+5WzE20cFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(478600001)(2906002)(38100700002)(36756003)(83380400001)(6666004)(2616005)(6486002)(186003)(6506007)(86362001)(31696002)(53546011)(6512007)(8676002)(66476007)(66946007)(31686004)(66556008)(4326008)(5660300002)(6916009)(8936002)(41300700001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkV1N2pRWjUweGlHVmlJUGxUd2FIang4aCs2dG1kS0lpYWVUS2IyYVM0Ujgw?=
 =?utf-8?B?akZSRlRmQ09pN2ZhaUpYK1NPNk5BR1BSTEZXNDVJd2gvZFF3T1VzMWZvL1RE?=
 =?utf-8?B?Wk5kalUxVnd2M2M2dzk0cTNIcWU2cjJOUU1ORDdCVXh4b3UwMXREcWpqWjI5?=
 =?utf-8?B?eGZSKzcvN2ZEbFcrSzQwaFJDMEc0dG1aS3Y4N28vUHVPbFNTUEhyb3N2WUdq?=
 =?utf-8?B?UjMycll4UXN3cFlTZHlFMVlpSDBtNDcxYWl0U2p6Ym1WV3R5N1ZlYzBySmov?=
 =?utf-8?B?NjNCcmZVdlh6anZyZVZBZkoyWFVBb2tNZTdmTEFrWnJLMmNBaEVEdXVMR284?=
 =?utf-8?B?QXVQc2p3dTFOamxtd3d6VGpQMnlabW42ckJCQ1hJQzA4QVk5eS9mS2ZLKzMv?=
 =?utf-8?B?OVhyclR0SkdkVklrMGZCazN2T3A3N2dTTjZzWUgvRUI4Yy9Nd2lkZWZ4ek15?=
 =?utf-8?B?ZjlvU3NLY0dVMXRxK1dqUjQ4RDFDdUlxUnFpdUZ0djgrK2RrQk9tSlRwVjRx?=
 =?utf-8?B?OThrU2t6elJJNzhMZEZqcWlpaThVeDlUWHZ1R1ZJSnJmL0RZbWhmUjVnTm0z?=
 =?utf-8?B?MWFnSU9xZm9tc1FkOVcrOU11RXEvMmdnS0Rub0NBQW5tUkJyQ0Y2Rkh3VWN1?=
 =?utf-8?B?a0J6WHdyYjNiUHBqRDQ2VGdvOXdDYm93ZzBCRmpDSEU3d1RqVEhLTXNodnVF?=
 =?utf-8?B?QitDOFEwN2dIbXNNdks1UjhRUk5Sa2dXM3JqYjhMYWxYUUhFZHNKVkd6YVVn?=
 =?utf-8?B?TmJ6RHBOWTRVMHV4cWc4a2NmMkdhQXRSZ1BOM0dvK3YvcUcyem5wazhaMTdt?=
 =?utf-8?B?anM1QkNpbXFpRGVmSjQvSlNUTEdhT3NNSk90YmdlQXRYMXRrY1lhSDdmcjZG?=
 =?utf-8?B?eUhvSDQ2K3ZsMG9OTDRraGhUMi9PSDJ2M2VoSjh1RFdMUmY1TFhjWlo2b0E0?=
 =?utf-8?B?N2dQdklKV1JRYXQ4M0lNeUVtUGZEVW4xVlJBRDJJZmIxVHNNdTdjMjMwMlNx?=
 =?utf-8?B?QXNQbXdHV2pTbzYzU2VpYkIrNEgxK2J5RHpXSkdRNEtXTGFIS2hmWkVWUVh5?=
 =?utf-8?B?MUY2a216eElEQzRUajhmbGRuRHpvczhlZHcxVFQvSDNCUml4Ky9DV0N3UGhR?=
 =?utf-8?B?bzRXeExOL0w3OXhlTUZ4a3JjTWNCRGh4dTNKZkpWNnlyaFpkUkt4ZWp1L3BM?=
 =?utf-8?B?TVkwZC9BSERMcmY0a3VVMjNzUXpneFV0N3NCbkhFTHpqaGpRY0F5Tm5lUEVp?=
 =?utf-8?B?NEtCa3pyQWxGd1VzZ3NRZk14QzhoNGNyWjZuSzdEMEJNOU1SU2t2eDR3TUhP?=
 =?utf-8?B?MnNYbWpBNzRVaDYzemtxcUFLTzJ0dFRFVGhseHhEOUVaTVNybGtPZHhubG5I?=
 =?utf-8?B?SFcrYXlMZ1RPKzRZVzhNU25UMk9UOGNKWHVnYkxHMHhac09xdlgxTjBqb3E2?=
 =?utf-8?B?WkZUdVpTQUtBQWFwUVBNMlpCSE03RjRVWmhPTzFDOHBSQ1NibHFQT3daNjEw?=
 =?utf-8?B?Z2ZZZG9oRGorbm1RTVpYVnI2b2ZnTmZFOGcrdmRScXpkbngydEtJbzJhV0Fh?=
 =?utf-8?B?dXBtMXVtbDlZd3pOWGJTdjVmQXVIZHg1WTZDbURlMjFNQ1cvTkFuOUkvbjJR?=
 =?utf-8?B?dXNGQ3dYRGxUVjZxQUU4ai9GdUk2Q0x3VGloeFR6ajJFL3g5TnA1VlBJY2pT?=
 =?utf-8?B?QjhzZWxXcnVncjlxT09keEZpenVlQU0xczYvbVNDMHFMR0R3czlBSmhJNkxz?=
 =?utf-8?B?MkZIbW16eXlRaWtYQjlNeENBMkpLSXM2WkE0eUx0OVNiWW82bWpHSXlqdWZF?=
 =?utf-8?B?Y1VCMjhjSlJyMnhYMEZ4NHVuRU9kUHZyTTFva0R5d1FxckhTMndybW94SzF2?=
 =?utf-8?B?Vm5MTnJrUFJOdmt0aGdVVTl5OUEzKytkTGRWOFB2VncvQU5jM2hMSFJrVzRS?=
 =?utf-8?B?RVViYitIODg0b0tSbkFIcjRweWlVd2pXWGM4OFFmbzMzTmIvOWppTTBDaDc3?=
 =?utf-8?B?UWI5SFp3aGFuMDN4YXNlbmZYZHdXSlRXLzk2Nmg2TTRxQXR5bW16UnRHZUhw?=
 =?utf-8?B?TWk1bnBHb2hZNW9Ecy8rcUFFeUQxU0NucTgybFBpRWlYWlNCVS9lK0NQY0pm?=
 =?utf-8?Q?pUlsB90REyxSVdfJqNvpf9YXI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a1e18b-b654-4aab-5170-08db681916f3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 12:08:37.5357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H418HZllt1h0KCq/0OxIP136vqaeRmLVmgT6fDrPcYRxt198VWEiLz14tUwZGixR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7318
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 19:56, David Sterba wrote:
> On Tue, Jun 06, 2023 at 10:05:04AM +0800, Qu Wenruo wrote:
>> [BUG]
>> With recent scrub rework, the scrub operation no longer respects the
>> read-only flag passed by "-r" option of "btrfs scrub start" command.
>>
>>   # mkfs.btrfs -f -d raid1 $dev1 $dev2
>>   # mount $dev1 $mnt
>>   # xfs_io -f -d -c "pwrite -b 128K -S 0xaa 0 128k" $mnt/file
>>   # sync
>>   # xfs_io -c "pwrite -S 0xff $phy1 64k" $dev1
>>   # xfs_io -c "pwrite -S 0xff $((phy2 + 65536)) 64k" $dev2
>>   # mount $dev1 $mnt -o ro
>>   # btrfs scrub start -BrRd $mnt
>>   Scrub device $dev1 (id 1) done
>>   Scrub started:    Tue Jun  6 09:59:14 2023
>>   Status:           finished
>>   Duration:         0:00:00
>> 	[...]
>>   	corrected_errors: 16 <<< Still has corrupted sectors
>>   	last_physical: 1372585984
>>
>>   Scrub device $dev2 (id 2) done
>>   Scrub started:    Tue Jun  6 09:59:14 2023
>>   Status:           finished
>>   Duration:         0:00:00
>> 	[...]
>>   	corrected_errors: 16 <<< Still has corrupted sectors
>>   	last_physical: 1351614464
>>
>>   # btrfs scrub start -BrRd $mnt
>>   Scrub device $dev1 (id 1) done
>>   Scrub started:    Tue Jun  6 10:00:17 2023
>>   Status:           finished
>>   Duration:         0:00:00
>> 	[...]
>>   	corrected_errors: 0 <<< No more errors
>>   	last_physical: 1372585984
>>
>>   Scrub device $dev2 (id 2) done
>> 	[...]
>>   	corrected_errors: 0 <<< No more errors
>>   	last_physical: 1372585984
>>
>> [CAUSE]
>> In the newly reworked scrub code, repair is always submitted no matter
>> if we're doing a read-only scrub.
>>
>> [FIX]
>> Fix it by skipping the write submission if the scrub is a read-only one.
>>
>> Unfortunately for the report part, even for a read-only scrub we will
>> still report it as corrected errors, as we know it's repairable, even we
>> won't really submit the write.
> 
> We can maybe present the results in scrub status in an different way
> when it's started as read-only, e.g. not to say "repaired" but
> "repairable (read-only)".

Yes, this is much better for end users.

But unfortunately we're still introducing a behavior change, even it's 
just the report part.

Before the rework, read-only scrub would only report errors, no 
repairable/correctable checks, thus it would report csum_errors=32 and 
corrected_errors=0 for example.

Now we will report csum_errors=32 and corrected_errors=32.

With progs changes, it would be an improvement, but still a behavior change.


BTW, the rework also fixed a report bug (I didn't even notice), that 
csum_discards is incorrectly reported before the rework.

But I guess no one even noticed anyway...

Thanks,
Qu

> 
>> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Added to misc-next, thanks.
