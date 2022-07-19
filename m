Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C41578FDA
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 03:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiGSBbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 21:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiGSBbm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 21:31:42 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60064.outbound.protection.outlook.com [40.107.6.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7631B17ABE
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 18:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGRdnn/Hgz/4EsM4zDRs++dEg3bLcNqFD+XWVoxKVSujUtDHELgvqpmjZYldu3SzeqkSpWyz0TGV1WF0KvKP9mtnfQ/J0NxKHTv8CtvXPZ9yNSZTv8iuP2+rueYmdZlCPiVCzZYWi/2ZZoUxCwDx7zQVuGSwCCXnmXOOFcPwo5h1zEaQedF8feA/blYAR+LPC6bTOsphWeYUOOInrmYTd/0eaUWlEVmqSSQ0SX6mqMVAxrcrO5z61obpMK9BHWVfl0/3qfU0PiqBqbql3xc4N1BQ9oH6UsIp2DmDKj6mmrG9TmrKnIl2FDSPt5bFlvH11qrR3xxN0YtY0IukHuydLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZVOCSwmY4vQXM2WMXO0h8XTnW4sg0E9svh5ccDIGyE=;
 b=obqhO47uYSQ1elae+qBS143/zM8werLm+GO22y76w8tmHAuK+yK/76KxejujySaCuLV2wLrcHu7fCWHnTz5vGaBayZb7m0ksMmqCgEEJGpTP1t5kfWJUEVnugZhnDOnO80L6W15Lwi+FjsLJHfWpNPt6BhmLVqwrwWefjR76dwVZYdZc/jtNie18l/HaNUCDgVKOWPx+ir/zD9WkREXNseJFftejOvjeXsFHsg+mxS8UzmcqHgWnM4riJEJKRAwPYOulRJxBtM09GdqzomJyTj6GPYh7c1bbymWGNWlEBlCz/rKZdwTvu811xaUZ1+PM2p9Ytz+V1RIKwPFYawoFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZVOCSwmY4vQXM2WMXO0h8XTnW4sg0E9svh5ccDIGyE=;
 b=HOadhA0mHHNE+mvEpJYnhtkK86ZO0+Jph2WzzC/9cv5/vAS7ioB8G+Pz54qCeaG6fI3pmQ4YZX19sSKAOF5uoESZFYBN8C7mG/gg4cHzBhxUeSxww7HCH1eU+cwzYooJqE36iF1HyjXe40HV6cjEJvhAN+un44qR1/DjoLQDte0Y/SzASY1O48rR81wmUNHXof55povGakVTvt30kYEfZvrntPYlOXlRJliFGRPCUm/YFZQlp5/wB5H6v9gK1N3fK3SLG1LtdCAyGf6Mgr++t5QGOYvFktq3gKM27lf0kKBVjXoa0BLz2Zacu8ub6let5jb0XTg0nl59abWeen9tmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM5PR04MB2947.eurprd04.prod.outlook.com (2603:10a6:206:6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 01:31:36 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f592:23b0:9094:cd33]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f592:23b0:9094:cd33%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 01:31:36 +0000
Message-ID: <03436e26-8408-6771-2f13-d4bbdbd99b7a@suse.com>
Date:   Tue, 19 Jul 2022 09:31:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs-progs: make btrfs_super_block::log_root_transid
 deprecated
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <ad5b8dbe66567eddd09025cf46114cc9412d1add.1654603274.git.wqu@suse.com>
 <20220718153410.GF13489@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220718153410.GF13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::32) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21782514-f3c1-408d-6f61-08da69266b93
X-MS-TrafficTypeDiagnostic: AM5PR04MB2947:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OjzEVrUgVG1GojnUXh2bqpMcRxuXRYeIqz9a8Qe9pdQkmaVfeDhUt9j5GDCWSQtCXgs8me1HR/ktBcWU4tIjkSGXQ2AwKyjzIgP5djTtkF8PyBOmJZuB6wp1PgPHq/5HWmfPTjaB28UGZgQMQV1omThQgGHzwaMT9oTfnESdT86Rfz3F8aViAuruZO7Ixl+BL0+EOKMCLKgxcuXuiUzY9PkY2uw7cU8PzkV7/BF1Q2Sh7liVUsAQmAHTY8a6mtP0nDOp/aQC2JyGT/mV0GDGyXyqeQiBrZ7d/zEiKEwjTbMNGu7GsBL6mMqdATwI6px8U51A3Myusb0o7FChCe1MMGC76vafaqjLdxzaY317cbclLDEAHnM41KvOaVZF+dAA/ee59zadtx/yVcg5utXJ/ywWq0I0SFnVByQWEdOAdNMgzKhIr/m4zG1LjsOiM7YpNC0WplDCozQNe/vFb3HTBrLtUrtTqde3dAQlCBA78zW2Lm2IQWu581CbRS2R0wIYYsSl85CpE+Sy5aZbVbqbiKJvMcyqRE6AslZALV+XL3o0NRpAvAEZ8sHBbhmwebTsBw0lBa275VBgx864AnEBQaV9nnHwZo682gBLqg4lcr8Knbf43qbVmlVys5+jKi8G5MMYDGAqnPIm31mPOsf/Fx/3oqr3O7rYMuwDtIiFYb15AAmfljp22mGWn99LMtaeui3FU6aiG1dSvj8mzEtOUeTLb7G+HVAV9enQ9TMROp/pBOmJCF0uPXxVGVGoJ9sTtIj8fuCHw7m8IMntWUG2jq1wq1/ZuPfmvYOSrnYqLiYrTrzeZdZlizlxF7L8p+EwyjP8wsnwg/TR/KTINhPlKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(366004)(39860400002)(346002)(396003)(83380400001)(6512007)(2906002)(41300700001)(6666004)(86362001)(478600001)(6506007)(5660300002)(53546011)(186003)(6486002)(2616005)(31696002)(8936002)(8676002)(316002)(38100700002)(36756003)(66476007)(66946007)(31686004)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3g5STNtclFhK1NEWldMOTRXa0R2TWZ2bVBoZnluQS83VVNkdGt4TmVPVWJ2?=
 =?utf-8?B?QTVCbEFVbWFuYU0wb3U1ekhFUm16SUxEZ0RIdnduNmJhbERDNXYxT0lEZjN5?=
 =?utf-8?B?YWg5RVQ3ekhuUnpiVDFkV1pQcUhod29VaDhKQWh4QUNzUmhYVk5SMmcwN25w?=
 =?utf-8?B?dTdocVcrMDA5OFQvMnhvS0M3WVAyb1NlRHd0NjdsMVVtMSt3cTlYeWMwb0Q3?=
 =?utf-8?B?dGhFOENQWXJJeklpMkEraDRFenZFVmhaL3VKSUx2SkhTYiszSEU2Y0l4eGxn?=
 =?utf-8?B?MTJqYXBVNXVZOS8yc3lRbTgwUnlnWGVCaHAwRFQ1SHZCQWhTeVNyZVc3dkox?=
 =?utf-8?B?Q2pJaXptZVAvTDlzQWt4NktjTG9rQXhVNTVNSFNxYlJQVGFsc0NaODJIMWQ2?=
 =?utf-8?B?NnBhYndDNFNOUDZxL2tvOGxIblBnUk9sWG56K3NoVmdDS1d1SDZ6Vmx0R0xi?=
 =?utf-8?B?WGFuQWw1bDFBVm5meWJ4TFVuWmMxWHp3UXRLVEJjRUdpSHQwSVVkZE9VaWdr?=
 =?utf-8?B?ZFdWVnU1by9VaE1Fc2Y3QWQydFdDZkhXTzZ5dldYSnl2ODZSbG5ndlJnaVJ4?=
 =?utf-8?B?WmNUc0trSjIwd1VKOHVPMTJlMC9rWFpESWZ3bjNZQ3N5ZHcxdjV2OGZ2QU52?=
 =?utf-8?B?Vzh1OFNXTXcrQmlSNDBZektmMmU3Tk9vYmJ1VkJxdEZVME10SVVKVnlGZUc3?=
 =?utf-8?B?MlJUZFVwMXZoQStWMXRrRXdIN20xaEFUZXU3YW1WSnBYb3MxcHYxeVlzUlgx?=
 =?utf-8?B?QlRHdW80cGpvbHNFNlhlUFgzV0t1TTNkR2tzdGcra3RybzBRNGNvYUJzdi9o?=
 =?utf-8?B?Y08vVlhUSldtNG01WU9GdCtaYkF1REx5dnlBVE4zamdLeXJWWUtZTTd6MWh0?=
 =?utf-8?B?L3RDMFpxNzJyMDYzK2hPMXpZUU9DUFBXOHZlVUVoTVFXQ1dCTmZkK2kxSFF4?=
 =?utf-8?B?VXEwemtxWk55VnlTVFFkTUtGUW1jWmkrN05Ub3d3d1RSRGwwQXcxYklicGRr?=
 =?utf-8?B?NlBOZHovQnlway9MNzJET1Vpb1VUVkRxSG51bitQV1JBbUxpQzVjc1FNVkVp?=
 =?utf-8?B?YWdlcm5XamVmVHVPWWZOcEZVWmpiNnEySmpHbndDZm8wL3orSlhINTBzTEJy?=
 =?utf-8?B?L0tici9xTHVxT01vQkE4RHZBZmZZQTYwRk5vZmFZZElrc2FuRFArS3NEM0sw?=
 =?utf-8?B?MFhzd1ZGc2w3MHNybUxMTmxNVFhuMVVJNWxJMW5iZUsyQzRLSlo5MDhKOWtv?=
 =?utf-8?B?Q0xnZ05kSGg1WmlOaVBVWjJtVGs1dFFDK1dTWmNQUGhTWkh2TVg0RXBjeFVE?=
 =?utf-8?B?N3ZqcFo3cSs4eVkva3Jpb0VMMGJYQk5icXk4Wk15R1Z4V3RHV3RDb1ZuK3M3?=
 =?utf-8?B?cTFKRkhUV0V6KzZaNkR5ODFlbG1wZEJPQmxsWjM5RlEyeVRtUjRSQWdPKzlz?=
 =?utf-8?B?T0phMUZkcW1MSEFaVXF0b2tQb3M4b2tNZXM0ZUN2NDcrMm5xaktjTDdTMGhk?=
 =?utf-8?B?by95TkY3dmE1aXNFVFFhY1BJeVVod2Q5N2gzVWZ1VlBiZW91ZW1aeWlOZDIw?=
 =?utf-8?B?U0d6WXYrWEd0UHVnZEt0eHQ5V0tPTTdMSjc2TmZwUWU2WnVLZTFFbjVlcWdj?=
 =?utf-8?B?V25NY3o0amN3bDFjNjBHZEN4TDNSUzZvUnNpT05rdFRjQjdadjIvRU4xcGJ3?=
 =?utf-8?B?THNvb2NNRFdVdmVjMEllNzhWSEIwR2ludDU3OFdmbDJFQzhieURCYUQrRFVa?=
 =?utf-8?B?a3BHMHB3KzN2ZlhJdGs0cElhRk03U2FhcHhJMHBoZHdlOHV6eG1qaVU1SFow?=
 =?utf-8?B?aFFBSkd4MGNXOWhrRmZYNGVxd0lFbDloZ0h4UTdlUUVqaTQxb291dFVnNVpi?=
 =?utf-8?B?TEtmNGJXanAwR29JSWlNTjlXc2hXN0h3UVcralBibCtzazVxWlZkc3N0Z0xN?=
 =?utf-8?B?Ni9DdTZUVkNOU1dnWXBCZ05ST1dQMkJ1TUVOWFZpSjhncys2aGI3UnlWVUVs?=
 =?utf-8?B?SUM0cmlSemRndXZBWjl0R2tDL1NqUi9TY2xPRHlXeEplRHRwcUQ5TDVHeDlz?=
 =?utf-8?B?eU04UVd3NmVQYUpaVUVFTEF5VmRRTEhqdldja3JsRXROWHpySXpPY0pjcE5w?=
 =?utf-8?B?SzFvTnlKZTczQzdiQjV3MmpQQXlMWVFiR1pqeXBEV0NpUHJmV3pjNlZTYWhz?=
 =?utf-8?Q?TCSmPaulRq1cwHV0x+3oeQE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21782514-f3c1-408d-6f61-08da69266b93
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 01:31:36.4295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuiM0+aDUwnexSZXHddzx3TvmyeiORCFAo9c6Tz218vtgfpXdB01+HfbxcHpNm6e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2947
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/18 23:34, David Sterba wrote:
> On Tue, Jun 07, 2022 at 08:01:17PM +0800, Qu Wenruo wrote:
>> This is the same on-disk format update synchronized from the kernel
>> code.
>>
>> Unlike kernel, there are two callers reading this member:
>>
>> - btrfs inspect dump-super
>>    It's just outputting the value, since it's always 0 we can skip
>>    that output.
>>
>> - btrfs-find-root
>>    In that case, since we always got 0, the root search for log root
>>    should never find a perfect match.
>>
>>    Use btrfs_super_geneartion() + 1 to provide a better result.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Added to devel, thanks.
> 
>> --- a/kernel-shared/print-tree.c
>> +++ b/kernel-shared/print-tree.c
>> @@ -2014,8 +2014,6 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
>>   	       (unsigned long long)btrfs_super_chunk_root_level(sb));
>>   	printf("log_root\t\t%llu\n",
>>   	       (unsigned long long)btrfs_super_log_root(sb));
>> -	printf("log_root_transid\t%llu\n",
>> -	       (unsigned long long)btrfs_super_log_root_transid(sb));
> 
> For dump super I'd like to keep it there, same as we print the value of
> leafsize even if it's deprecated.

In that case, we only need add "(deprecated)" to the string and adjust 
the offset.

Do I need to update the patch or send a incremental update?

Thanks,
Qu
> 
>>   	printf("log_root_level\t\t%llu\n",
>>   	       (unsigned long long)btrfs_super_log_root_level(sb));
>>   	printf("total_bytes\t\t%llu\n",
>> -- 
>> 2.36.1
