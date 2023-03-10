Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF66B37F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 09:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCJICS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 03:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCJICR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 03:02:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE30E7C87
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 00:02:13 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEUz4-1pkysW1Fne-00FxMa; Fri, 10
 Mar 2023 09:02:07 +0100
Message-ID: <17c86afa-41af-a8d4-094e-81f1d47e8788@gmx.com>
Date:   Fri, 10 Mar 2023 16:02:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 05/20] btrfs: simplify extent buffer reading
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-6-hch@lst.de>
 <52d760f4-dec8-7162-40b7-4f0be14848b8@gmx.com>
 <20230310074723.GA14897@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230310074723.GA14897@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BoUnAcwtAz5inNNkpGK1nytqLCDScxKG21bTS6XQmEjzBdmI8bB
 +zo75g0k10GAwJPqyUNaKpCCGUwI8xHorQgEbq8C1nCzZeJx0DHjHzYpI4xc85fFO128IEP
 kPQh769OIovdFbAlKu/xkx5B3q7moTHPQOwbLaLnWwUu8/5uAgdw2PwMyPnV6GqAmbwjUjP
 V/4X3zGXJm3Kfl9GaELug==
UI-OutboundReport: notjunk:1;M01:P0:tGLpEMUhP10=;VZCrrlfJ6IG+zcWUCl7gdGjHqge
 mHco13Ve9EBPiRTOlYiqzioBMGiqSnwRN/6+bZQhvqXfxJlbKUmPAaAK9gNmfDXwTvkwTtXzV
 JNaRp5JscmpRTnOG5RpMSMMhuL1eQRUEAExVuzPCL6BtgcTtH8fFsMegOXUjWXx5bXpfdapKK
 QJuuv9HWABJoV887KfSQji0tOnxppSie5AKoDsmd2FVsEHXhEkbHhs2an5Z91UXH6wA/W8U9A
 GDTetfKkamGIwOf5hTmm24paWW2Ava2WstGHc8ZeAsJHumLiPpUG+Wg3n2hetPVFYF8MEQBHH
 ZjEiCEs38mv7+sD2cdor078ciTfdmMtntSfA/tOhtR3iuKhTNaSOP0szu0gYGY2hZMlIgm3P+
 +1j1f8tQev2VAhaYNu5VSVAx14OAnOBfKq5/7ON9RIEMNYwtwLRKn8mTxbwdfBC+6l62NKKdi
 NWrULdgxX8M7442DkhAK4q5IlJIuh3pbQwUFuNaUJqsS4/hdqL9w62jZGzfdQCcKUrWSdwQ2/
 ZCAOm8MHs5oHQ2QWfv0lgsz3hT5BuaF0US6DlD6pLv7NznlZtEsUUSaogveKgOceMEwYBqr5E
 AjiobUpWrm+4T4/leBZRK33JOTAqL/MkmaockTLXAYEsnMdNOy8JBDjivG3AVr9Utc/q7zM2k
 mHihUm/QRP7h2z+Yvk7cbPe2doSWe0438+qlVbyjM43Je0wyCIDPxLwTVUMGI4C03micuqnbX
 jYv/SqjITKtKKejqwjrP/8hBkTlDzAOVPUqn4FW1uHBHdt6dcTG8Q9cHeKwU28UivASBXCYvu
 MxcHBSfFyC41k+QeJ+nxmbGsIQ5zIN9WMl/DM7tLQOYC8JCjAahg5IXUtUfqGN5bUmd+wMz8G
 ZCkEiWNVwX/AejZqnIJcV3S9jQQ/vHq1zyEy77RJOdbJRI5MWMG+Plkg+7kBNKwzIxClVPqiE
 RBP362K3aRISwwlTsfWqaWBbwM4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/10 15:47, Christoph Hellwig wrote:
> On Fri, Mar 10, 2023 at 03:42:04PM +0800, Qu Wenruo wrote:
>> This is the legacy left by older stripe boundary based bio split code.
>> (Please note that, metadata crossing stripe boundaries is not ideal and is
>> very rare nowadays, but we should still support it).
> 
> How can metadata cross a stripe boundary?

Like this inside a RAID0 bg:

0	32K	64K	96K	128K
|             |//|//|           |

There is an old chunk allocator behavior that we can have a chunk starts 
at some physical bytenr which is only 4K aligned, but not yet STRIPE_LEN 
aligned.

In that case, extent allocator can give us some range which crosses 
stripe boundary.

That's also why we have metadata crossing stripe boundary checks in 
btrfs check and scrub.

Thanks,
Qu
