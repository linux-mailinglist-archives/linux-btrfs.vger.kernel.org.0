Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7142B53692B
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 May 2022 01:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352341AbiE0X1j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 19:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiE0X1i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 19:27:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189A14C40B
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653694053;
        bh=xzYmHVbJBhwjoNZi0F3FD36BX4qjUwJbC2SjFKv0RRw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Cqle5BBRkXoTkGAtI5u6KgRfA4Tmyb17WFpdarrQbgsriSW1i5KvR57jIT+wKYQBI
         tUrdK7x32vmXnCAnYjR45cVPs+5hNoDJ9XpnR9MoIgtC/6O8nYNRy3ViwbLFDaBw6T
         7FrObpXoomvG3sGeDZMl/fuqCCCHTn/m5NA2mV0U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sHy-1nqrUE1SVe-004z9p; Sat, 28
 May 2022 01:27:33 +0200
Message-ID: <e2fea10c-2188-5bd2-5e37-ca1662507a73@gmx.com>
Date:   Sat, 28 May 2022 07:27:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] btrfs: use integrated bitmaps for
 btrfs_raid_bio::dbitmap and finish_pbitmap
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1653636443.git.wqu@suse.com>
 <354833cdd0b94908fc5a6064d2dee63f8ba0c175.1653636443.git.wqu@suse.com>
 <20220527140930.GD20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220527140930.GD20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bJdiJKfGevWHW+OEs3W+usKi8W2se7I2gsXkfEaXFK8ae0smaxC
 0dEumB1aB1pkyjuf1+4VSWqkMjjFwyCaLRKKLR7k1LJzJ4UswIPmcjzUhLsGvdyqWmdg/Ig
 h7023ivKzwsgUS5jX1rpmE8glsTh9PvjT4I/EPatv/dC65LM4RUqxfNGeVBHIHBdLd5kBuO
 36JNQiEh0T7y2S4P373jQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y5i+sWQS9MU=:Fa1Ka03WZf0XK53FRg5ODQ
 PCjJTtQhbXRGT62wdoYGhtYDgYF7KCljQwNOZpDCW4n5wa/e/qt5bxQ0rgtK4TCKg6qtxJBS5
 eQMg9RQcYgTuv12z1WqKGAZsijbXhHXaGTs3fIwbSV/rQC5R0GHIm/OOOOcRbQu4Lp9UONVEi
 Vvqs9cqjyxSjYY5rR90r2V76Uq8SH+AjrsehMrSSIIsY3M0FmhjCgXkb3W3PduVN/BPb4YlCX
 zAWVbvjVxBmlsAeyEtmBEcjadVLhe9zew30PVR7ZT/gyKTmFstf5Fc5e7s55rbxySnOiPeh87
 lwaEOSsZLB2NoiYty8NtspEuRlz9bYE0synltBvGD77AnNZzAndujEnpcZRchG7L2IeoCpk/P
 QS5XeXovyIvRNEI0Bw5ejrN04rHmmW85uBAiL+Cxb1wwv9FJGVxfXCBat/17k9cf1XrS83KRF
 R7Y0aliD6meN/SR4aLoxNJH/jUtU+otK1Ns8sSstejboLUMO25jGygVR7U/vYhLtbGGTb0q1D
 xTsuxYZ7s54vs3SdD6xlLxJ3lYUCfx9GOwu9MEnbSWNR65nkwsr4At0Sf8CKIOtyPY9vpodGw
 QjgVroAayvy0lVVSb3q4rHObRwEzOHIKQgbDr/UfKNf3aRPkq+q4lIY0nQ8l3pmRJNk+yNkk0
 Klo/tEbGLr+lS0I/DzdoAuB0tCWTu30xkQ5pIdlM/wCxyPBMKhrpjZ6scBdGBl+MpSz1aOPVM
 KbY5MJmgd3OVZgMgwQBXwFKyWNn/0NH/CycRKNmNph4zvDZaoHlELa0PNTxqwCTv3umAsOPlc
 zOJqbkMvloM5KLDw6QG4FHKX6gbNMLR8dEphq2JzXe7cTPZjoijRtZ+5iCWlgtzARYtUJpc7Z
 lkDnAHLZvuJddYqFox39CUyuvw9ooDq1wPRD9Z450eMdIjPZWNffeBisZ7kMW2dCipzSkaAaP
 z41AUcZwMxSjnz0W0BB0tdkf87jRWadObF8XB4a3vl6bDkHMzSk4KRc/rwRPwAVEw/743Yix9
 hNrxdp1DWkYYsoJdUj381vUMTqhbUsUen58NzJP6A8+P7tM7fy7ZDIk3qQC287M4QyyNXGQU2
 ISfr3sEIbXi0DIA1z7nh1qOF76yj7g6zpAYkhA2UvE1bwkdiFxD/3728A==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/27 22:09, David Sterba wrote:
> On Fri, May 27, 2022 at 03:28:17PM +0800, Qu Wenruo wrote:
>> Previsouly we use "unsigned long *" for those two bitmaps.
>>
>> But since we only support fixed stripe length (64KiB, already checked i=
n
>> tree-checker), "unsigned long *" is really a waste of memory, while we
>> can just use "unsigned long".
>>
>> This saves us 8 bytes in total for btrfs_raid_bio.
>
> Nice, also the indirection of pointers and kmalloc, for 8 bytes it's an
> overkill. If we ever implement bigger stripe size then it would have to
> be reverted but the asserts make sure we'll notice.

In fact, even if we enlarge the STRIPE_LEN to 128K, the bitmap is still
enough to contain them.

Furthermore, in that enlarged case, tree-checker will be the first one
to warn us.

Thanks,
Qu
