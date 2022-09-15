Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A865B9857
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiIOJ4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiIOJzh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:55:37 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EA59C1FB
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYuFKajO8RGFRDDm4Mth3AwqUt1tEXzaDiGD8JEJ82zfqGONzHt9s/PNKalKHgxHvNx8jIorOu+Oua1JUowriT8c82ug2UX05bsIyUPyypuAo+xjZRdXGnv4wF9a3pbhiqt2qS42Y6Ve2jkNLTzzxAQNGk8vd7dO2bn9giv4EWB6IMT24MP2fhJ0rBqya3JXO2oTRcTGblMjPwXeOQaLeciBIl/kqYKFmxDUvNLlEgzr7Gs+L+878VU7zSHAgZty6Fxjm3pc1S9/IWan+qHp381bFwaJGhI6hAsrBLcXweSunbOpOqwUCDrZxda35t1EvOMC4tDa5tsfpvIU+PE1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HGRT87X4/wwhv0x9T5elVYo+AWgjx3gT/ABBkaUklk=;
 b=N/nCSjoPXHj5DSO3kQmjNJlUym/lADEq+cSLqQcTPwRxqaYKdsf1XDRjPG2X95MXxdzTwFan30cCPep+lTmY00GZtwsmXo99RadBfBC5KaOnoF6+X7HQU2BCYjdyMGlkzfvEgLVjuMEj5LYEjuc3VAUHj1L9Cke9hHgtu6shNslq2FP7KnYKVhdLrPdvUfkl0d293j9VVXDQSh8KFiiIHCB0/X22TwobOLga7U8xDbFOLMjmZZaDnkzGF4wxN6+7EiRs2AtyrBN9T58BTHZ4j7m62SIF8FZEKVpLrta22hALOj+4ERdcCgMw01bq3GSJe4iXW8aS+u/oOiSR2yqhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HGRT87X4/wwhv0x9T5elVYo+AWgjx3gT/ABBkaUklk=;
 b=m9dWUgsepk1SmXa1ge7RsOZXXLK7nciQ5sCnNkMTC3E1yTEaOvpaTKd/nLBybhMQCbdO3G6zR/fvjUouGTTqXDusip1jRG6m92a+1hkmoxzk70gXSl+mOLSur83OqZF6tXorcJvdmSx1zzho+phbbcgZfklqAP9WeNZZdnd5fAwLdT9AkQgTI7MLzHp0Lj0MAtWuFRDbEVbHFB028PztjHUr/phQTqx2K9jSs9dPSCLAyxIWqU4zBImg7yUIuT0fdyNzDPO08PxQGlN/TMr8yeMHlAf/zVXazezA0SkpoDrN/6vgMc61otH5HvlNqBKSULDK7UWUREHk+nx/d4s8NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU2PR04MB8693.eurprd04.prod.outlook.com (2603:10a6:10:2dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:51:21 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:51:20 +0000
Message-ID: <6887ace2-0427-e1fb-89ac-e13bc0b84317@suse.com>
Date:   Thu, 15 Sep 2022 17:51:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 00/16] btrfs: split out larger chunks of ctree.h
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <cover.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0097.namprd07.prod.outlook.com
 (2603:10b6:510:4::12) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU2PR04MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: b6541806-b730-4bf4-0953-08da96ffd7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZGYEg5G+oDyZ0ee3gK1lDabrugTe51mswBn6mHeLONKtG89JHr/HtWUs+nZ+8THIcFMsjdgowmLbKNKnAX0pjoECOoChA06VCv1CUsKVb0O6oZADI5EkYoeGk1srpVDjmy1UqpY3NyV8tlYBixWYrDWUn3nMsBbNm9mS30wxUal93Ju3tbNWdx0JUT59OjpjVlUUoXwpgntz9WgTTzJJEDImLOCam2pxuJWaKWugfIwwgyen1n9xjUd8/wDzwjKsF42YDOSPYrIwOl/gq9uFmLnpokWgu80MgatdBhho+8RkSGXO8mR+yvjEZK9O9ARHThIDdBW0wIVkltmKtPUPF5vyANG3bFqIrk4otzA2sOFToSqV8wa27Cx0f7n7TEIX3Mt8Ol+N22g0znNwtsrPwg5aQMQlHDA1CNyTsufyED61hnLN34wddYpMmffJLhkh+Ep0AYXQkJtINxALq2wxdpx0Ms0JpiJb1Sgy1u/dPHrj2wIBe6ZdnF2BnAh+twvA/bs0MRsnf6P8gyJeKzS/IFoAh1w7bZ/qfDYrzxAOi7wfbNMWAGrFDbgjgqXdlLWD9ZmCbGXL9VKepawGr6ovEA89odi9LLUvP9g9+m1nAvU2KbEOkcqtCQXqo98E4LQcJ4rdf5409lVvW1rVt9loTJqpPJdp9eL0yC3zUkdQ4QQtISI85uqA9EGC6SFIactCFomNtXs5amnqt9V4ErsNQVElyY8AkWJxqVBKTaCIDHxKCrRA0wO6ozPv+2B4en7c+W0N6x7k+A75gKYV2EHcHgCpZkR2Dmuf/8U+VHqmrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199015)(6512007)(2616005)(66476007)(31696002)(2906002)(66946007)(41300700001)(8936002)(316002)(36756003)(6666004)(86362001)(478600001)(53546011)(5660300002)(38100700002)(6486002)(186003)(66556008)(31686004)(83380400001)(6506007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXoxN1UxVHBCKzdibXRvY25WaDd4WGg0MnhHUnRxT0VpSnRjdFhxSWZGSThR?=
 =?utf-8?B?ak9sODZsenFSbG4zUU9PSVUzQXZnTGpWc2UwRzhsei93TUtlMnNpaTYzbHpk?=
 =?utf-8?B?dDZpc3Y0MVRDTEdTdXVQNzdlQnY1Q2EwckhnVTZEdDdiTmtHWlpDSjZHOEpM?=
 =?utf-8?B?aFpYN2I4Ymk2Uk1TRnp1eXpRNGQ1NWIyemlYOGsvMmh5MlBPdHBQVWk5VDZ6?=
 =?utf-8?B?VnM2QlR0ZHpEWjAxSFpQaWdVb3Y3djZrbzFzS1dnQUk5Sm1TMFk0YUZZZXM0?=
 =?utf-8?B?MWNXNHhNamptYmFJNGFrdCtlSnpOZTR1MzZrd0VBSXM1MjI3RXpSaWhOcWNh?=
 =?utf-8?B?RFJSWUNCaUNQL0JzZUJWUGViS2t3MWhRM01QbytBY2Q1N1RmdU9XdmRvcG5S?=
 =?utf-8?B?LzhZRE1ybmZhZGlSUWU1aGxqODlBMkd5Vjd3ZXVHZy9uM0VzWXNKV3dHR3lV?=
 =?utf-8?B?dnVsa29ORms0dTIzWUVETFBuWEJoVFVnN3lHWVZUVkEvZ0prdXFmTVYvM2dW?=
 =?utf-8?B?M2RxTWtaK2pudW96ZkZJajFFQ2FOdnF2RmtaN0lrN3l3Zi9hY0hJaCtJdHNE?=
 =?utf-8?B?NTdlcnF0MExCZkJkdnVqN0tpUms0UkU0d1NLdFFjVGhsZmo0cTdvVXF3dW1O?=
 =?utf-8?B?V2NrOGZVUmxQeGVXa3F4eDkvV3ZnM3d6NGdVUzVXemtRLy9peVRqM1Q5Tkd1?=
 =?utf-8?B?ZEtIOHhKbW44WDY0NkUxSDZ0b2Q4alRQMzd0NjRnNnJ2L09kOGkySmQvZE5y?=
 =?utf-8?B?Vk9HMHhZZ1B0OHlhWW4vOU1UbkQzQ0tFeTFvbjBCQVovVHlmTnBwSWMyM0Q3?=
 =?utf-8?B?ek51cVhoU2psY2FqMnRFT1RWT2NIdmRmaVgyR0JyQnJEU2dCeUY3RjlPeFdU?=
 =?utf-8?B?SjhmVERQOENlSkdPRTlJNjhpcnd1a2tUdTYwYm03ZGNXUTNMUmo2ZUYydGdw?=
 =?utf-8?B?L0czaE8yUlJQR0VaaEFDSVplZmxVRWNIS3RHbW9LTjlxQnFBMFlBQVhDQXdx?=
 =?utf-8?B?WHAvQXNBLy9hb3RETXJ5QUhiQVV3SkVIN2hrUVFoYktGU2F1T0VqMXpHdUFk?=
 =?utf-8?B?OFZ0RnltTS9QS2NNQVh2TFlmbE5FL0cyM3BEb2UxQ0FTR1UxeWhTSlg2SUdP?=
 =?utf-8?B?bmtMWjdDTlRTdzc4QTBBSnBFelkxc2tQK3pSU0s1UGlTQWFIYlFyK3lDVE1v?=
 =?utf-8?B?R3plVFFMM2hQcGdFYVYwV3Q3MFRVY252ZktQdy9sSVdUYzdVU21lc3BNdkVI?=
 =?utf-8?B?SDFLWUZqa2htMC9tRThVSzJZa3FNT2g5ZXZPNHAwbXZMM2dOOXRJNkRaMFg5?=
 =?utf-8?B?ajZRQUU0bmlPM1l3SjVLcGFoY0VMelpVbmtkbkRveUNhNjVXVmFKVDZkL2pn?=
 =?utf-8?B?V0pQaGt3SmpMQ0NoME1GTWR5dnBIQVZaa0lBN1hSTTFuTXorSmlUTG5oTW9S?=
 =?utf-8?B?WHNaVy9BUHp6RURIYnhDVW5PUVIwVnpEUUZnb212aUNCNVRJbkNGNGJYQlBE?=
 =?utf-8?B?aGkra3I2UU4rS3dCb3ZCam5HMTNyODlHaEpZUXNmUmdGbVowOGxmTmJEdDRp?=
 =?utf-8?B?NER0VmdaSG5jbHpMZW8xYmV4Y05CNEdyODB4OTE3YmtMOEhkZjc4cnZTWWFy?=
 =?utf-8?B?bDh6Zi9kakV1ZWdwSzhDUHNlbDdZK3BFQWhtaFI2ZEdOKzBMUmc3cWJRMVls?=
 =?utf-8?B?MTJUV2VGdTJzVnducjZqY1NsU1lHTjJVaVV6R2hMVUxsQ1U4d2QwRWIzZTRi?=
 =?utf-8?B?RTZZaVoxRC9tdXFCUllLS3U1RlpDNWJuVkx4THlqalh2UGoraEs5eGJZbzZY?=
 =?utf-8?B?UTVFQXlnZ3lCdnFLQWo3STFEcm5yblRNSnJoSWU5eURiZWxUaUUrdDRYT1M2?=
 =?utf-8?B?WGJiWFlHZHBCWS9Ud2I5LzZWQnp2dVduWWhWV01rRkZCUTdVdXRNTi9sakNt?=
 =?utf-8?B?ZnhvUlk2MHh6TlZka0RCYSs2VVdxR01pY3kzaXF5K0prODlxNzA5OUpKUUJQ?=
 =?utf-8?B?VUJ4cDBqVTRLRTFtL2pNSkdtMGhxaUdIRVAzbllrSjROcW1XOUxOdW1JY1ov?=
 =?utf-8?B?NStrWmhiclBKMTh0NWNpWGFKNmtZaWFPdEtscFZwMEU4bytYUUNsQ2tTRkU1?=
 =?utf-8?B?ZmVOam9jaEN1TDR2R3VJaXc1emRGZDdtWVl3MWhnZHMvR2ZtNFhjMERiK2dT?=
 =?utf-8?Q?HBXMBtEpu/BX5qo9tbWA2Rg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6541806-b730-4bf4-0953-08da96ffd7d6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:51:20.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TTF4SEuVrVko6ziDmSKWrZoAb91dUD2T56lOseB2SyXAGgFjux7W2yymjmSQ7kU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8693
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/15 01:18, Josef Bacik wrote:
> Hello,
> 
> This series is based on the series
> 
>    btrfs: initial ctree.h cleanups, simple stuff
> 
> which needs to be in place before applying these patches.
> 
> This is likely going to have the largest patch of the series, which bulk moves
> all of the struct funcs defines out of ctree.h into their own file.  This isn't
> really possible to do piecemeal like other changes because we're using macros
> instead of functions.  However the code is well organized so it allows for a
> bulk copy and paste, so is straightforward.
> 
> I've done my best with naming, but I'm open to suggestions.  My general plan is
> to have all fs wide definitions in fs.h, and then separate out individual things
> to their own headers.
> 
> The biggest things I've done in this series are
> 
> 1. Move the printk helpers into their own files.
> 2. Move the main state flags and core fs helpers into their own files.
> 3. Moved the struct func definitions to their own files.
> 
> This is by no means complete, this is just the first big pass, but as you can
> see is already 17 patches long.  Subsequent patches will move more code and do
> more cleanups.  Thanks,
> 
> Josef
> 
> Josef Bacik (16):
>    btrfs: move fs wide helpers out of ctree.h
>    btrfs: move larger compat flag helpers to their own c file
>    btrfs: move the printk helpers out of ctree.h
>    btrfs: push extra checks into __btrfs_abort_transaction
>    btrfs: move assert and error helpers out of btrfs-printk.h
>    btrfs: push printk index code into their respective helpers
>    btrfs: move BTRFS_FS_STATE* defs and helpers to fs.h
>    btrfs: move incompat and compat flag helpers to fs.c
>    btrfs: move mount option definitions to fs.h
>    btrfs: move fs_info->flags enum to fs.h
>    btrfs: add a BTRFS_FS_NEED_TRANS_COMMIT flag
>    btrfs: remove fs_info::pending_changes and related code
>    btrfs: move the compat/incompat flag masks to fs.h
>    btrfs: rename struct-funcs.c -> item-accessors.c
>    btrfs: move btrfs_map_token to item-accessors
>    btrfs: move accessor helpers into item-accessors.h

Oh my god, I have "accessors.h" in my btrfs-fuse project from day 1, 
finally can see it in upstream btrfs.

But one thing to mention is, "item" looks more leaf oriented, while I 
believe node accessors would also be in the same header?

Thus what about just plain "accessors.h"?

Thanks,
Qu

> 
>   fs/btrfs/Makefile                             |    4 +-
>   fs/btrfs/backref.c                            |    2 +
>   fs/btrfs/backref.h                            |    1 +
>   fs/btrfs/block-group.c                        |    2 +
>   fs/btrfs/block-rsv.c                          |    2 +
>   fs/btrfs/btrfs-printk.h                       |  206 ++
>   fs/btrfs/check-integrity.c                    |    2 +
>   fs/btrfs/compression.c                        |    1 +
>   fs/btrfs/ctree.c                              |    3 +
>   fs/btrfs/ctree.h                              | 1784 +----------------
>   fs/btrfs/delalloc-space.c                     |    2 +
>   fs/btrfs/delayed-inode.c                      |    3 +
>   fs/btrfs/delayed-ref.c                        |    2 +
>   fs/btrfs/dev-replace.c                        |    2 +
>   fs/btrfs/dir-item.c                           |    2 +
>   fs/btrfs/discard.c                            |    1 +
>   fs/btrfs/disk-io.c                            |    8 +-
>   fs/btrfs/export.c                             |    1 +
>   fs/btrfs/extent-io-tree.c                     |    1 +
>   fs/btrfs/extent-tree.c                        |    2 +
>   fs/btrfs/extent_io.c                          |    2 +
>   fs/btrfs/extent_map.c                         |    1 +
>   fs/btrfs/file-item.c                          |    3 +
>   fs/btrfs/file.c                               |    2 +
>   fs/btrfs/free-space-cache.c                   |    3 +
>   fs/btrfs/free-space-tree.c                    |    3 +
>   fs/btrfs/fs.c                                 |  108 +
>   fs/btrfs/fs.h                                 |  320 +++
>   fs/btrfs/inode-item.c                         |    2 +
>   fs/btrfs/inode.c                              |    2 +
>   fs/btrfs/ioctl.c                              |    2 +
>   fs/btrfs/{struct-funcs.c => item-accessors.c} |   10 +
>   fs/btrfs/item-accessors.h                     | 1104 ++++++++++
>   fs/btrfs/lzo.c                                |    1 +
>   fs/btrfs/ordered-data.c                       |    1 +
>   fs/btrfs/print-tree.c                         |    2 +
>   fs/btrfs/props.c                              |    3 +
>   fs/btrfs/qgroup.c                             |    2 +
>   fs/btrfs/raid56.c                             |    1 +
>   fs/btrfs/ref-verify.c                         |    3 +
>   fs/btrfs/reflink.c                            |    2 +
>   fs/btrfs/relocation.c                         |    2 +
>   fs/btrfs/root-tree.c                          |    3 +
>   fs/btrfs/scrub.c                              |    2 +
>   fs/btrfs/send.c                               |    1 +
>   fs/btrfs/space-info.c                         |    2 +
>   fs/btrfs/subpage.c                            |    1 +
>   fs/btrfs/super.c                              |   51 +-
>   fs/btrfs/sysfs.c                              |    7 +-
>   fs/btrfs/tests/btrfs-tests.c                  |    1 +
>   fs/btrfs/tests/extent-buffer-tests.c          |    1 +
>   fs/btrfs/tests/free-space-tree-tests.c        |    1 +
>   fs/btrfs/tests/inode-tests.c                  |    1 +
>   fs/btrfs/tests/qgroup-tests.c                 |    2 +
>   fs/btrfs/transaction.c                        |   29 +-
>   fs/btrfs/transaction.h                        |    1 -
>   fs/btrfs/tree-checker.c                       |    3 +
>   fs/btrfs/tree-defrag.c                        |    1 +
>   fs/btrfs/tree-log.c                           |    2 +
>   fs/btrfs/tree-log.h                           |    1 +
>   fs/btrfs/tree-mod-log.c                       |    3 +
>   fs/btrfs/ulist.c                              |    1 +
>   fs/btrfs/uuid-tree.c                          |    4 +-
>   fs/btrfs/verity.c                             |    3 +
>   fs/btrfs/volumes.c                            |    2 +
>   fs/btrfs/xattr.c                              |    2 +
>   fs/btrfs/zoned.c                              |    2 +
>   fs/btrfs/zoned.h                              |    1 +
>   68 files changed, 1915 insertions(+), 1823 deletions(-)
>   create mode 100644 fs/btrfs/btrfs-printk.h
>   create mode 100644 fs/btrfs/fs.c
>   create mode 100644 fs/btrfs/fs.h
>   rename fs/btrfs/{struct-funcs.c => item-accessors.c} (96%)
>   create mode 100644 fs/btrfs/item-accessors.h
> 
