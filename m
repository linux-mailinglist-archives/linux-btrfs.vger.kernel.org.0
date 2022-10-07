Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E015F815F
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Oct 2022 01:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJGXvS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 19:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJGXvP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 19:51:15 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50059.outbound.protection.outlook.com [40.107.5.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA2751417
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 16:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDTZcaMJLDXcaoYPlqB000yKSD/vVmbHYIv2rahevqKm7KGh8D2uCJG5cygcrDRI2dvtkQh/mxpeRH70g7mZaNbJkkh6u+WzVExF8aSRVk+4BNJrNBnosn1zAGzuxSUupU25p0FF9ucrn0XhRon092Zm1OgiRrNhyB6stOF48gc0ot0t/RHRMogxySoEBWPWG9LXY6lv7rV3V7JiIzLTeCDiC6T1UjA649R6SNoWnQfZomy+jjaFqN73GuSNt0TKcDC5BUC4ku/eHRQL5+SLrQ+sTbnsmfLJeCFMvi2E+CBiE9wCLqUBTKkZNNwWk0Tkkpprz0284b5wim2Aoxwo9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmnkDRD08qJFwcep+PLvw8n/dKlC93ZZvhol3lkBzDo=;
 b=fUWw+fOg6F7utgrpV3TBSC0mgS6Ayc3rgQW20sQ5bX7eAQSB5QjspJeYOPP0hUYtSN+4Haxr27H5DH0v7Z1d/J8x1leHh1i9pzD8PQgoBLfkD5YH+hnfboURtwKlmUQFuAZAE3xVvpe6PhITekHhbLRkn6YsS0w3FbSdzWQgybrNTyzWUAXnMnwepayOwKc2D8yJV8tBShLYmjsoMau2q2MF5P0TX4BLo01mgHFm2CmAG3Lj6n7d9YDiIA7vIAh7KJygVEb1kxvWqhZFy7hz13OKkmbANoaYBZYrUaRob9isxk1ZbTuvTj8C2rmRXNb78nHAxQalI2FnuVXIzKpRWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmnkDRD08qJFwcep+PLvw8n/dKlC93ZZvhol3lkBzDo=;
 b=4L5bNHpeRSGyXKKI1omjOf3NvtNYChh0iookrKGqJUC15UifilK7ArAPb/6t+7aHiwCN4iSum1HmRjMX1PaBRFXQdKUASUcy6FHt2IU/lbpgnqtm9Kg4G33OAevAou5rEHS4XyhPwQsmUKq9lwDx8LfvYvtZeAw5JqepoAIMFxwGCClVIrF4DyfTPI+gBTJUUADvCpfT1ubj7ewZY28uu+CGvI0IZ9fsNm5yRNdbIZ5L6ULcWwbjnPVaiQZJWw6qG53AAratesnNo/O/0pU1ky8ohfXfN4eJHdbgp3gEVXhmVk0dJRHgqvd/ZkqRo0YSk3RVWabcoOZG4It6usePuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU2PR04MB8806.eurprd04.prod.outlook.com (2603:10a6:10:2e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 23:51:10 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%7]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 23:51:10 +0000
Message-ID: <e1a2eca9-ea59-0826-6181-c19b446cdf79@suse.com>
Date:   Sat, 8 Oct 2022 07:50:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 04/17] btrfs: move btrfs on disk definitions out of
 ctree.h
To:     dsterba@suse.cz
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <058e41f7732823196f030916c04134418688cbe9.1663167823.git.josef@toxicpanda.com>
 <a67b963c-1f2a-bf68-c0b3-08dda678c629@suse.com>
 <20221007170723.GW13389@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20221007170723.GW13389@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0069.namprd02.prod.outlook.com
 (2603:10b6:a03:54::46) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU2PR04MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f86148-a12a-4889-5e50-08daa8bece0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95DtWumq7jWUp9g5ZTDhG4fF6pvOv3eLo+xt84+VuZhhsu4LCHjHGxHk+mZagEY0O4avlGiirqxK0K40hnMNomhg+VyXmdF3Rjzq/3PKPsDb2Hl8ss9jvSxLRBcSs6OCQyRvz9hhF1ZWMM9FIv+yR1c9SVzQp9l1gURejsG+3+yxyqieZw45265/vYCloffjBPgFm5RaWwNleIgFMkcL5x3q8q5CXXTQrs1UIG1i5DpclvMMbwxAtDunwGWi/Srp/3Re4ImmXCiqo4+YZJ6ZR41ynXl2K4G6JhVeaduzyZ5Cf2z3FKYFKHhd/u23SIoi3vWUeimXK76046eqJL1uKbfTL453XGnjGzuojqo2NuE3lS2zBuzr0R1dt3b9wmGVsm6ekPjeIBD0nJz8Kqz1am4XrZZ6Tzxrb+aEKDgh+GoD41QYhUVQb7xqTjthRX5nezaI7Y2oGbUb9PXQj9cwneuUAP/5qyfjJW7tzGhKTbCEBUXuftSB+jXyvHpXE3Ai4q0TM16tGDJ+3CumYNERVe7eh6IwTRHwB5ixU6uLk2NsOS8Z5UrmT3NdEg8LuC6/nr/YGReDYygcHnyAQ1NAdMVv5Deuxb83Ujx8kTw/QoS6wriDW7PKIJsDdkMo/sWSPjrWQ5E+iszqTP2NE25cXW4u4ZDft0kEVKHqVUjC3WMXdwcY2FdQMIttuCEc+uVYWe0n/Il4P++pU5pXVczFFojcygaMa8rSlHQ5E3bGetDljCCYblp/IEAk1bZPbDyvF0kcPjnAdY8PiQbnR+t9BqxxyCFSD6C3UGxBCzynKU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(6512007)(53546011)(41300700001)(66556008)(6506007)(36756003)(2906002)(6666004)(478600001)(6486002)(38100700002)(31696002)(5660300002)(8936002)(186003)(2616005)(83380400001)(86362001)(316002)(66476007)(31686004)(6916009)(66946007)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVuSllNNUhEOG9aYUFVcnJ5Q2FNeWFJekRRTVp4ZFFoZXp4b1RXY1dxOFlP?=
 =?utf-8?B?L2ZPeGVpUEZwTHRpM2NOM1pUU1p1SlYxeFRXRnlaZTJ1d0x2S25mVWZQNWpD?=
 =?utf-8?B?eDY0QU4rVDExSUZOTlFSYUk0WXkrdW96b1RrVnlTdjhjM2NNb05GSGpNejBu?=
 =?utf-8?B?S29kdE5SLzNETEdYbHprZW9qSXAwMlMwaDlpK1UyYTFlQ1kydTRjcEk3elJW?=
 =?utf-8?B?eTlTN3pKT3I4WmJUSit0cjlieDVXSDhhY0crSmVFQWFsbUg1MlJ3OXg4L0Ix?=
 =?utf-8?B?UWRTU25TOGdvY2pma2NscXN6YjZOVFE2U3kyTDBHQ0FyODJGZFEzY1VDOW9Z?=
 =?utf-8?B?MHA1cW5TVkhRdWlqOTNEVk9yWFI4TzdEcVkrTnZuYW1VUnJnY21qdDdQYjF0?=
 =?utf-8?B?dTRXQ1ROTTRyODgwcjdqSmM1QkhMQmNjWDlQZGZmTUdEeXNtZC9GQ2JZTnZv?=
 =?utf-8?B?Qk92a1RkSmN3UnROZlZUSzZ6clJmWFdVMkZvNGpicTZrMWFyYm5WYUxIYlAr?=
 =?utf-8?B?eHhkK0pvYXhkcThCN1lSb2ZLZFArNi9GNy95QUR1Mk9ERzJnNzREWlhqRFpY?=
 =?utf-8?B?QWUvR3BRcXZEREtBVk80K1d6eERVODIrMGY4VGsyMkV2Um9RaXlPdEVqTHhv?=
 =?utf-8?B?K0FhZkNGa0Jrd2NDSHIyV01OZXVBdlF3QnE2aE43cGtLSFFFRjlSK2lWejlr?=
 =?utf-8?B?Y2E1M1FMdGQrbUJ6NUtTK25NdWRESHpCandtS25zUTFQZGh3VEh0ZjZZcXRM?=
 =?utf-8?B?QTB4K3N1STZweW53YWhUMnp5b3lacUNiU2dyNHoxbFUvdlgwNTNzajByb1Qy?=
 =?utf-8?B?TnNLQTNBc25DazdZZTFNSlpubFlIZkVZeWMxQ1c1d1JXZktYRHdxV2lBYVgv?=
 =?utf-8?B?TlF6OTB2V2RLbnJzSklFOUlPYkVUbjJ2dnM2VTRFQVE2dkoxWjBzd3o4Tjk5?=
 =?utf-8?B?RC9zTFFqYW9pdFNDS1NNeERZUXZsZ1hsMzJyS3dxMVYrbTVFcVVlalZ1Zm5p?=
 =?utf-8?B?TURpK3FzYnNyU1ZZUmZmeXJQTlovQ1BKa0FLL3RyOG14Vmwxc3ZiUy9lNmlq?=
 =?utf-8?B?bmNnQ3VXRi9oejdlT0RicjgwRDlUeXExNnhNR21nSFhJd25xZWJGK0RFNXN4?=
 =?utf-8?B?T1pMcHRzMUhFUkNnTEw2WjMvM0xWSUVqSnhDUjJRYkFMSVdoYWVSZCthUGZC?=
 =?utf-8?B?N0tURG9UWnpwdjNMdnllZDZiMGY3dy9uK2w1R2ZTVmxBNlN3UmhxNjltOXNh?=
 =?utf-8?B?dGFpeVhnRll1Snd6N054M2xjYXJmdUFBeXBYbWcvR1J2YzYxM0haRXphbmlI?=
 =?utf-8?B?WjBMWjFQdzBuVDZxQzJ4SXN0empnMEtBcUxLT0tpUlBaeUF0YnR1cVJza2JX?=
 =?utf-8?B?V3pTM1BwREdqUW1UY1k4TFVhTGg5TDBiS0dZNDl4bGNVZzJSQWkzQ0paejd5?=
 =?utf-8?B?Q05qWTB5N0lwWEx4RDIxeGZtbFJPbXpnUFBMcEtkM3o0alR6NXdHSnJrWFky?=
 =?utf-8?B?UXRJenNWaDVyTURkVEsxTGFndDdLYmIyTGJHSzRQSjliaXdqRk1la3B0VkFj?=
 =?utf-8?B?WEI5M1BmZ0d4SGdZQkpBTXg4RWJtOVVoZ21TUHkzTEVpbGJtYkNQVEJvNjZi?=
 =?utf-8?B?SUZhWXBPUHJUTlByVXhLNjdOcUVNd1FqRE9jVTlZdkh5NFI3TUtGbks5T2pr?=
 =?utf-8?B?K3RXYU45YUtJVVpzbjg1YVlsLzBDdjNGalBSeEZYQjluNFB5b3BRS2QwdHZO?=
 =?utf-8?B?QUgwT1NHQjZOb3B2ejA3VzhKVHE0aFltRWV1ZXJISFBMeXdjNURTMGtEZkI1?=
 =?utf-8?B?c1RkOXRsUTRCRnBJVGFQcFJXaEpoenAyaWF3TFNvZjAvdXhzaEV0TmE0ZVR2?=
 =?utf-8?B?YzkrdkN6cXhFNVhGbjliNmhKRFRhb0ZGNGdvclRLV00wcURiaXp2emdWS2ha?=
 =?utf-8?B?cUVNWnViNExUU0p4aDZZWFByY3ExM0IyQmY5RURJc2Q2eUVPTkdYdnVocG9D?=
 =?utf-8?B?VVVKTUdsclBjWkVqUmFpc0hycnljaG91VEY1ZWlqWlM5WDc0cXl4eXBWUlFL?=
 =?utf-8?B?NUc5VkZNbTgvZ29BM1ltQTVyQXZiZ3B0eXduK0hZZkM1VjBTMHd5MkY1UWRE?=
 =?utf-8?B?cW1teC8zNTBWWGxOeklFaGNsQkh0Uk9xWU1ZWTNKNUtFRVc2WU9jKzZWV1h1?=
 =?utf-8?Q?DVTXEG1Fzdldfcv4MBraM2U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f86148-a12a-4889-5e50-08daa8bece0f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 23:51:10.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wbuxBl3xH1OVPnlwosa88CMS4K1lwr9aCt7rEUcMRAaP8kitLIaOMfp193gaeuF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8806
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/8 01:07, David Sterba wrote:
> On Thu, Sep 15, 2022 at 05:07:42PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/9/14 23:06, Josef Bacik wrote:
>>> The bulk of our on-disk definitions exist in btrfs_tree.h, which user
>>> space can use.
>>
>> Previously I tried to move some members to btrfs_tree.h, but didn't get
>> approved, mostly due to the fact that, we have those members exposed
>> through uapi is for TREE_SEARCH ioctl.
>>
>> But I'm not buying that reason at all.
>>
>> To me, all on-disk format, no matter if it's exposed through tree-search
>> should be in btrfs_tree.h.
> 
> All the structures are internal and not a guaranteed public API, we may
> want to change them any time. So if we move the definitions to UAPI then
> with a disclaimer that it's not a stable api and any compilation
> failures outside of kernel are up to the users to fix.

The point is, if we're changing the super block format, it's no 
difference than changing a on-disk structure.

It's still the same incompat/compat_ro/compat change depending on the 
member we change.

> 
> Which does not work in practice as easy as said and we have reverted
> some changes. See 34c51814b2b8 ("btrfs: re-instantiate the removed
> BTRFS_SUBVOL_CREATE_ASYNC definition").

That commit indeed teaches us something, even if we deprecated some 
features, it still has to be kept in the UAPI.

But that argument doesn't really affect the super block move AFAIK.

Since it's not even part of an ioctl, thus I don't think user-space tool 
would really both that.

> 
>> Although I'd prefer to rename btrfs_tree.h to btrfs_ondisk_format.h.
>>
>> Thus to David:
>>
>> Can we make it clear that, btrfs_tree.h is not only for tree search
>> ioctl, but also all the on-disk format thing?
> 
> It is for on-disk format defitions, but that's a different problem than
> the internal/external API.

Then, what's the proper way to export btrfs on-disk format?

 From an ioctl point of view, all those on-disk format things don't even 
need to be exported.

TREE_SEARCH ioctl is just returning a certain TLV formatted memory.
Yes, the basic things like btrfs_ioctl_search_header, but the content is 
still internal, not directly user-facing.

All the returned TLV members are really implementation related details, 
and even the TREE_SEARCH ioctl itself is more like a debug tool than 
proper interface.
A lot of things are done using TREE_SEARCH ioctl because we don't have 
better more defined interface.

Thanks,
Qu

> 
>> Reject once that's fine, but reject twice from two different guys, I
>> think it's not correct.
>>
>>>   Keep things consistent and move the rest of the on disk
>>> definitions out of ctree.h into btrfs_tree.h.  Note I did have to update
>>> all u8's to __u8, but otherwise this is a strict copy and paste.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
