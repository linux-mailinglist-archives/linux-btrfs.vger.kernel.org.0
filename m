Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3D760477
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 02:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjGYA6t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 20:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGYA6r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 20:58:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B1010F9;
        Mon, 24 Jul 2023 17:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVgiYuhXTy2lEs2HUXIYso+uIippSHcrP5v5DWMR7diYxU6qzwCY+KvXhXGZLrHipEzI7hZOgy0oUPqqX1oBMawG8Df8SQgkUUl8Oypyc9/+BctdyIP8Jz5CL8fQiV9aJ7DlI+JbVJ5qzqshjo1np64jkZm6yjjVaylGS6VlBT7FoL9w4ebShUvV2Kow+rMKXkfbxkNTIaXbw8e9dXOT6SQlqEbKddDeVARU3jNOWjX50YhlzVxV+sCKUblhmUBTK1kWgR1M0mkLsYKcsKdjEsZFyFJSlZHiY60kWkkAcLXd9IIXd1beD6rqJE39e5ksT3ZQjDcpnJ/ukkNHmOGRfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVZLPxKE4UU39td9rhu2opLccDfRKypU7tQJndDIORk=;
 b=ItZy06D3Wr2RQyLY5z6dzgRfH7GsDGMVdJOiz3W5xqEBC/IO1FbVdG8e+S1zMh5hncpqPddBNE663xjAUBu1gszVZ2T85l+18P0nHkHckdC8cI2whKlO9neKpDuu3j2Pow5XiumSlSt0aI+wtk6ooUX/vQX2FTrJOvucJcwy4qMm/0qRVgRdPvBpd5+jsVzp7pI0RS5o3I/I7p2kiNwfLXc0SjdXsxFQVjKcY3MGu3q2h37G0xWXqyIPHg8tjXdH1C9ZdvFKrK/VEJBpm0JIQsgSGac87KMzDNbP636zqQ0hOTPW6+vvmZzNhE78eZ4YglGcchoI+FgEivkuJvh3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVZLPxKE4UU39td9rhu2opLccDfRKypU7tQJndDIORk=;
 b=JaPwHvBKhc66Gk0Z8YuqLT0hoE/42534U0N5MV/Lp3JHxQtbEm3u34MpLcNaSGKqyziJoTZcvbevSZB6dAd9f3IbQlT7ckCjtxriv5mtehS+yJLQ19rhkBQVURHJ6cN4yRgOss0DV0f3F1KK3kWtGkup63VcT0kYhIH1+3EhAdkbbanYGnP7dChBpbj5Wm2BPv0VkIlT+EciFltm3FBoUFwtyXgYBcPeDd5jJt+z4p6lSZlLBmWz2BNckwrg/i/FQ+timqfR8/UalzmBmgb1ugxWR+9dSeikBGuzpZDpOOquy44wgGJ/hEsvw+qPBuD/LvWPEOlatD9iHD9hy4aa9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB8390.eurprd04.prod.outlook.com (2603:10a6:102:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 00:58:44 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4%7]) with mapi id 15.20.6609.031; Tue, 25 Jul 2023
 00:58:43 +0000
Message-ID: <f0695163-d613-52e3-3443-2921dc2153c3@suse.com>
Date:   Tue, 25 Jul 2023 08:58:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs/294: reject zoned devices for now
Content-Language: en-US
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <20230724030423.92390-1-wqu@suse.com>
 <ZL6Ga9zRjBmAEmA/@infradead.org>
 <olqvt73droizibdx445my4uekl7gmcmlpkhn6e4oedk3gnmikf@pfpwcncjnxn7>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <olqvt73droizibdx445my4uekl7gmcmlpkhn6e4oedk3gnmikf@pfpwcncjnxn7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 66844d5e-a6b7-4469-f002-08db8caa4aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpsIjs/SzGhK4X1dzw3OD5nDl7FufYpYiTlKQgFKfLrnQN8CvPmUVaiDRwdMJAH30aoRcJpZ5PRUkLFwmSsWds30/Dm/FNVI23EwFpqplNgyxzNb5ktgfqgvYQ4Cw23LNQqbzlHp4Rm27IXv27Unj4Gjl5XbLRkMjj3Me6jY3qURxF1k+3fE/EbVph7zFm9DVRIQsCTl1qlcQ+BV6HLjSHedwIA/m+eAr8u0K2KPjW+tfGnQKUO97Ewp9DlN6WSduJxlPgo+6DpEP1e0jtUPRAuU5rLgmyw0XfdwxV34xMnwFe/joSWD+A0mBa3/QA1kWSbpDh5b59nxWxBJ8Tfe0Q37ZfLcZBhZQsJCAFlMIpU8ZbufXefvcLEqasf8kplzSu4CMMxMjd6FtNgnPdG9+mG0cdOOce42N0u57PYrVf4fBL1dIwI1n1sSAXLkShQIci9lMpkWLU2EBIaQ032CkKQXLGjwViYHwcgB2G4XxHMvmLFEvSVHLjimA2ib+TNVU7vsOJ4vxdfh89qhrJqiyzHJcfkeygTzYjaiRhXjofva3oiaEDKyo7eIqHzLiRR7UwmgKILkBJspgLH5PpQ7O/cDEiTG9RNnzbimoMdUCyr8u/jAR7bS5ztOns73xpHvSIty4ddLjL5d7jgkCnQQHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(83380400001)(36756003)(2616005)(2906002)(41300700001)(5660300002)(53546011)(6506007)(8936002)(8676002)(186003)(31696002)(6666004)(110136005)(54906003)(66946007)(66476007)(66556008)(86362001)(6486002)(478600001)(38100700002)(31686004)(6512007)(316002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0JTUXBDWmZwb29leXB0cU83ME9abWFXQkRRRDRTem5Fb2VCb0Z1ZEhYZGRZ?=
 =?utf-8?B?Zzkrd0liWDBXL2c5KzVOK01MTVFLUlkzMkxxbmpkQlQzSllDSWpUT2ZTeTJL?=
 =?utf-8?B?empQMG1idGNKSXpwSGVBWCtIMSs0WVRQYmlwci9FS0xEZTlKaEFrL3FGU05P?=
 =?utf-8?B?Ync5dkwzazRKVHdnUm9IVG00WVQwaGpkNUtwMzd3QTlJOURMNXNDOVY1MTRt?=
 =?utf-8?B?R2pzUkQ3ZkZXcjMraE5BR05zMjd6TnhZZkFuY1FqKzZrbmF6U0tKSWxldWQw?=
 =?utf-8?B?bldRQWorK1RhUDJCZXh3NGhiVS9OKzkyOGREVUwrb3p1OVY4SnZremVVNXlt?=
 =?utf-8?B?ZVdhaHRBQWRjRkJuTVFEY0RBb2JnVzc3WHYxZUVvZVp3eWRvWTRPamU2em1V?=
 =?utf-8?B?eW1PSWlsSGtiWEU1aU9OenhnYUJQVkxyeElMWVBtQ3JRdmZ2K3JOdmpNWXZi?=
 =?utf-8?B?YnhvUkQ5QUp1VHJDNHpGd21CeUlxbkpkeGZEbWZxYnk5em82d0xXQzlXMkhn?=
 =?utf-8?B?ZlNyV01PT1dRcXlCSXNQSW5GdlpvSDBXZG02aUQzaTA0NFg1M2J1SnZVc3JU?=
 =?utf-8?B?bm0wU2ZXRW5WNThWbjVSUkVVOHgrK3p3UkRidEtCWXNvdVAweFhyRHpZOCtU?=
 =?utf-8?B?WlUySFpQRG9CUTcrb3hydVUvWldlVEgxcWZtblN3UG03R1VUYWdBRjlmZnJD?=
 =?utf-8?B?Wk9CRG80UUhmVEVrbGxkTDhvaVZmb3A2c0h5QVBrVEtFT2JNZXRvQ0RmbzV4?=
 =?utf-8?B?ZGN5TmsyYzNLOTVoZThEWE5NZmlzZ201NllwbFpaQTFGR1dZampOQXk1bE05?=
 =?utf-8?B?ZWhaOW9qM1k3NVV5N3NMcFlZblJnMzAzZmRqaGJsSnZHaC85bVhkcnFHTW9j?=
 =?utf-8?B?QVFiS001T2RJV1FsYnFVYnR5b0JRVXJQODlDWkVSa0wxMVlTUHNjUXpXeisv?=
 =?utf-8?B?T2IwTzNjb1crdkI0UVowak5DenhsUjhuRUpZU3lTU3ZKUkFOb3JlLzJITzFI?=
 =?utf-8?B?Tkpad21rQm5aQjZFdjdSL1VPVER2SHpmdmh5dmFxQ292TXppMHdDSkdURWV2?=
 =?utf-8?B?WUZpcXFIN2p1UDNwSHV4ekNvMlEwemxjVHd2ZEY2M1RNZjVVYjNIQWZXWHoy?=
 =?utf-8?B?ZkN4SlU4TTROa3JkR09MeFR2Slh4cmZzcnRwUG91aEovbXl1d1dNZ25UQ2xa?=
 =?utf-8?B?emptRkFpVHcvelFaUVN5TTBpZVI5bVV2ZE0yeWR6UFV5RlZKbm5kWGp2dzRx?=
 =?utf-8?B?aXl5UGFkRWR5bys4RmU0MWtjZm5LcnpCVjBDeEFIS2hzdVR5b2IwQUtzVFNF?=
 =?utf-8?B?cWFGa05qQzhEZjdkNkJWWDVzUVl6SEFJalFLTWNYTklwaGtDOTZ6bFdMTnJL?=
 =?utf-8?B?VjYvYThWV3FxOHRNQURRUHRYcXFzaUhjRjgwMllET3FyaVk1Q3hWeGI4NWhq?=
 =?utf-8?B?cEZ5d3Z2ZVgzV2JGa0lNSGptOFMyYS9oQkoyTDZuVEw5eDZ0M0FVK3BaTmV5?=
 =?utf-8?B?M1FzRlZIL2djSWZWWnY1SnRxU3RQand1aTlRUWNsakJDeVlHY05iczlTUFZI?=
 =?utf-8?B?VENRa00zc1JkUGkwN0s0N1k5YnFQZGh5VDJVejhLZC8rWFdmcG9DcmNyMlBq?=
 =?utf-8?B?ZTFXYXIrU3dZWmY5dm1hVnh6eXpXSjRrZTZQeDF3TkZwQjcvZlFya2lTSVpJ?=
 =?utf-8?B?Y0pxL0YvTnE3LzFZd3ZkQzg1WVhVbjZvMjN5d29PdVZBcmhad3k3eUo3czFa?=
 =?utf-8?B?L3hsMzFqcDl4QjZZS1dOM3lXMHROdEdGZUVwTjVueUdLeTlVNUFVUTlJT1Yz?=
 =?utf-8?B?bVFkVlUwOE9sSVBaYnFXV3ZyY0FqZ2h4NVN5OHY4elB0YlgvNzhBRFhQd3VO?=
 =?utf-8?B?VW5BdGZsWHVySUNuQmRiSE0rNEx2Smc3cVlka0lqbDJYV1NMajZsTEVjWENR?=
 =?utf-8?B?MFhVd09iMFhTT3kvMnFhQisrcTNWV3VGeXFlL2w2bXkwU1luOEt4NXJiN1ov?=
 =?utf-8?B?ci83d1h1MU5ablp2ZnVrVE5OeVNQNnZ3bFh0MGZwTVpWZUtMQmZNY3JQdFhw?=
 =?utf-8?B?aWZ1NUVJVGpCUytpKzdIQ0dRZ2gxZmVSL0NXdWF0RFpmLzViUTlLRENwb0ht?=
 =?utf-8?Q?fLR5Z4nsx+XYGOj+SGKgSYhIm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66844d5e-a6b7-4469-f002-08db8caa4aef
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 00:58:43.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odH7ytwhCNrAO8ByoB5+PNR/0jSnmSqJrmc0jWybBpEkx90NNqvL5Nu/mkVYUjKX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8390
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/25 08:22, Naohiro Aota wrote:
> On Mon, Jul 24, 2023 at 07:10:51AM -0700, Christoph Hellwig wrote:
>> On Mon, Jul 24, 2023 at 11:04:23AM +0800, Qu Wenruo wrote:
>>> The test case itself is utilizing RAID5/6, which is not yet supported on
>>> zoned device.
>>>
>>> In the future we would use raid-stripe-tree (RST) feature, but for now
>>> just reject zoned devices completely.
>>>
>>> And since we're here, also update the _fixed_by_kernel_commit lines, as
>>> the proper fix is already merged upstream.
>>
>> Hmm, instead of spreading these checks, shouldn't we check that the
>> RAID level is supported, and have one single nob for that based off
>> it, similar to _btrfs_get_profile_configs()?
>>
> 
> That's beneficial. We need to declare which profile the test going to use,
> something like this?
> 
>    _btrfs_require_profile raid5 raid6
> 
> or
> 
>    _btrfs_require_profile data:dup
> 
> as the zoned mode cannot work with the DUP profile for data.

The latter one sounds good, considering zoned support differs for data 
and metadata profiles.

Another thing is, do we have any sysfs files to indicate what profiles 
we support?
For now we only have a "zoned" features, but no dedicated zoned specific 
sysfs files.

Would that be a good thing to consider?

Thanks,
Qu
