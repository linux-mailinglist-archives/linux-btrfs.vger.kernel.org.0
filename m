Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5FB68B5F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 07:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBFG70 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 01:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBFG7Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 01:59:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788A618F
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 22:59:17 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MD9XF-1pGMkA0aEj-0099rT; Mon, 06
 Feb 2023 07:59:04 +0100
Message-ID: <46998577-18fd-1854-8509-b1a4e330995b@gmx.com>
Date:   Mon, 6 Feb 2023 14:58:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1675586554.git.wqu@suse.com>
 <Y+CgXXV4wRh/PuGA@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/2] btrfs: reduce div64 calls for __btrfs_map_block() and
 its variants
In-Reply-To: <Y+CgXXV4wRh/PuGA@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EdX5ovDZaVwJ0UuMdeXVX7zznWQ7+Ql8IIDvBlhRSHPpyGrw4Uk
 WRDRaj21Kmrij3ohO67lZ91C3xVhXlqz+VnQIjb27Kmh0iqI3i0a6wb1xpMkPuXe9dED0yq
 qiYJG9aluyg2CHr9dKT0sSb7Dzgs7IESYjkD+y4IQ4GYG4osmntASUWb8T0+ymMK8hUWMRq
 trvZ6ANEic0Tt2OljNsCA==
UI-OutboundReport: notjunk:1;M01:P0:SMK7hswF5aQ=;o6uWAHt1andH//cwBuu39PLSQkl
 AU4PzUQCE/Ew3WS0HqXnojaqfgor1aZ6rHrdFk8ziUJ6HJpwlRgrryhJPWpP+MZGAi7vqtbYb
 Ch4vO73Zw6brSHohnLxQsOB2VN3ZNC7uUG6xkLw1dOtu6hrrvbzRC4m9AUfwy9wVpupM3rLf4
 dtLevCAWeaD2BuYZZeNds5i3o4Ie9Zi1qWXni+xdMw+346SfzjcziYtO6Ke9JSLk/PAtiHoEG
 LWdovTfA+dc4RBVPN3aiwUuiltl0T8Z1lm2PxkXRK1i5f9eRsXDqbEf0hD+VoHFsO2WiREPJ/
 5jqkG1JBrxan37P23Xa8OsK/0Hh68dQP+/wQQeWuG/fGxnhKx46sYOxfx06VtTe+UoyEau1Ya
 592oJ4Yf98MmkR051ZVNdxGq5VvIf1GV88sjmUBtejBRMvKY+dQpBkCNAnlgz2iJ5VNJJcdJ+
 i5sl+IWsTod0sjtYZExzeoFTrK7OZi7tXnberswAEv2hudyxJAFn6Wsypk1AjATfbGKytARe8
 lOk9MS+YWOnCPrZq1RoL6oBeiFwqOUaUNMAdsJGmpDqiglAq086S0/IHirHX+k0zeBomSDGfD
 mWxCR02NAjId/UQM/v8WgoM45k0uLdIUIG4BjL6XT4Yui1ko59zZEade3PEO7niFFen/T/RiQ
 49YQMF6HebVHi6cooog0dyae2S2ClPbf2O9LuvEnlSJJS7KznEbPfkNgUbf1y/mvsIwKpIovy
 04b7XD+4kIDvwJfh4tgkDhSNVEKHC05FWka1fVELiZOp+bKQ3YUhSvzgt69iPHBUiNPK7fkDi
 WL9jl99jOYr7faP2g62b8qyQdh8yFKz49jBkBaC5AnYAQEwNp8oYdijdg8eJQgLS9BGODV/44
 9YFDkxUnlPA6xZV1apLmjboWCPq6vqHcEPXEZ9Vr6e2BDlZDf4uxbrdZUKOPeRZkzfBjur5Xr
 RfstUAoC3cWcbZnpVFqN6ZZ8xIY=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/6 14:38, Christoph Hellwig wrote:
> On Sun, Feb 05, 2023 at 04:53:40PM +0800, Qu Wenruo wrote:
>> Div64 is much slower than 32 bit division, and only get improved in
>> the most recent CPUs, that's why we have dedicated div64* helpers.
> 
> I think that's a little too simple.  All 64-bit CPUs can do 64-bit
> divisions of course.  32-bit CPUs usually can't do it inside a single
> instruction, and the helpers exist to avoid the libgcc calls.

Right, I focused too much on the perf part, but sometimes the perf part 
may sound more scary:

   For example, DIVQ on Skylake has latency of 42-95 cycles [1] (and
   reciprocal throughput of 24-90), for 64-bits inputs.

I'm not sure what's the best way to benchmark such thing.
Maybe just do such division with random numbers and run it at module 
load time to verify the perf?

Thanks,
Qu

> 
> That should not stand against an cleanups and optimizations of course.
> 
