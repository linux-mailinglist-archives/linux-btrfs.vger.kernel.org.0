Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C65F6CB300
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 03:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjC1BLN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 21:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1BLM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 21:11:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFD31991
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 18:11:10 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMXQF-1pzS5K2Mb9-00JcSe; Tue, 28
 Mar 2023 03:11:02 +0200
Message-ID: <75000ec0-cb6b-9d44-0ec1-0683a80f8094@gmx.com>
Date:   Tue, 28 Mar 2023 09:10:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1679959770.git.wqu@suse.com>
 <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1679959770.git.wqu@suse.com>
 <ZCIoQLysbLrQW0pX@infradead.org>
 <cd8a91ee-2e30-9829-b50d-599fab3fb490@suse.com>
 <ZCI0DXvc+h7DoZvB@infradead.org>
 <7ec722e8-d685-004c-6c24-6bdac7982e0b@gmx.com>
 <ZCI6hOjU+yrQ9SCE@infradead.org>
 <7aa553ab-b019-b5c6-235a-4c17a9cf3b4c@suse.com>
 <ZCI9ILRIa2G8WzWE@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v5 03/13] btrfs: introduce a new helper to submit read bio
 for scrub
In-Reply-To: <ZCI9ILRIa2G8WzWE@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:I2uRCsjtGKRXL/2ZrWuTkqChBOgP9IHqD0ixmIQ4u+v9Y0SHDjY
 A7l/IdADLQk6owaDzz0I/b8K1S+IosVDucTpmeQCqHFFQ7Zi/zWMhDFpKn2qF5qTSgNyqvy
 NpDKpnvdOvINu+vw6hfow/8p9zN2+agHMHge1Df12FO8CN3FdWVYEcCNC3LkV1GHt3vwz2l
 wW7+bCRFhQOlceLqzsVjQ==
UI-OutboundReport: notjunk:1;M01:P0:ongdJRgQnBQ=;j9t+GvX8x1X7CgwaTvOYIv8N/gD
 fsQ3pDYwFSBnXqIL17v4VgWGe39JpL3reaWhQjxYvwp1YNo5+bl6sEpEKkvmZaayLjHPLtpR+
 q1eoKpfJhVC7xsZuwvGVif1A8nL96laQv9Hdr0ehwzTNZneoh4GHs1WQHTdJNPIu4SqFNpSO/
 qIAwqhm4Z03W4t/8tT0J+uWtYtmwLP1u1gGOM84n2CmCeLEn3W15uJesSybjw1GXhGQsOJJLo
 bAB0x7B7Eqto5F6jo44XQW6Bqp703jsUwT3AjGgfJE7rHDktVoPwTB9ZgHm5pPK76nPNBDZYG
 +WyjJa5f+9hKv9GBF86scfQXIWhRFHh0bt5mtAOG7UnnD35ch8ifyVki3dbBs4gkJcW6YgjQz
 pScpY7+H8edy0H7FSZTsuUediAJkBcRP+CpcdnsECQcOzkV8D55n3YwUOnCplKOHvQy5RVQC4
 FGNsyVGhXElsgdEf2E4rg4OcYex/Z+6K/f/NF5cdTKl1BlWGfiMcfcWU2FF8EdVx1yuz6592X
 7oqewXK0Jdo5KQ4ei/+UN5AxpJpsNwvDJhvTSV7RcNzeGKsrMJxO9adGOKX22kfOvTV34Xwn8
 Y8AWK+k1rfnz/MDkQDV6Dd4qQ3ZaEt5YmRks3uN9BKCK/AE6lHJbAEF9KHHSAiSfox8gBWaeu
 ieyTolVp87DkxQtGoqvb4QoQlgT33VSY42UsmpXi1Ds5FpRRII6BPKVXochfcXPOsq6/O5WMO
 2pumNH+apwHc+YqbScDI4qULbCNXkuCueqZySoTdqwLo6hVneNvtr+ARqscbjjYQ4g5fzo392
 1gnJODCx159/2Hn5fNUKV88ts6W9e3ex84+y/wuCUjuFrBw3qjQhBKGBU7wd2ytTqCImJz4YQ
 F6wxuWVJHaKVIDJikquH4m43DfZXNEoEtaNDkhUR4shTiTcGFXGh+DO1AqJN2iyQxCoKICRTn
 T6RoxWJaQOEKjQVV83m3O5SVfz0=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/28 09:04, Christoph Hellwig wrote:
> On Tue, Mar 28, 2023 at 09:01:57AM +0800, Qu Wenruo wrote:
>>> Well, if did just call btrfs_submit_chunk, the RST lookup would ensure
>>> you only get the length of the RST mapping, and you get the behavior
>>> you want without duplication.  We'd need to make it non-static (and
>>> document it), but I'd still be much happier about that than yet another
>>> I/O submission interface.
>>
>> But in that case, wouldn't we just error out?
> 
> btrfs_submit_chunk is greedy.  But yes, if there was no mapping at all
> I guess it would error out and we'd need to find a way to handle that.
> But that still seems better than duplicating the logic again.

Well, to me the whole btrfs_submit_chunk() is already super modular 
(great work from you, very appreciated), thus new scrub_read path only 
goes less than 30 lines.

At least to me, a few more lines for a special path seems worthy.
Especially when that scrub path should never be utilized by anyone else.

But I'm still open minded to merge if proven the change is small enough.
Let us see what we can do after the next update of RST patchset and 
determine then.

Thanks,
Qu
