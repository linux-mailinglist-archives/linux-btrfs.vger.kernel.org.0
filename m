Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB23E5399F1
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 01:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244351AbiEaXMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 19:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiEaXMP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 19:12:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985C664BE8
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 16:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654038731;
        bh=jXARXrhMU/XFYkGmW8EsaU3mu5EUh2OxyjBeHxl93HA=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=RN8mnKt0dAkXTwsPm+1EBtce6KOniSOapU8GXJxRM5TTEG+2GAP3x9KrHypAPuSuz
         hPStC07Gpe3WnKjmHtqeiy91j1hdUcz8JqvYu4gmZQrv8e2UPhMjUHmPuEak0hXo3s
         k0NkJyqkbiB3tRSMoIWkEdssKWGK0x1gRUARfrNw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fii-1npTxC1AaG-0124Aa; Wed, 01
 Jun 2022 01:12:10 +0200
Message-ID: <a0a1b6af-30f4-d785-a905-60a053a60bc6@gmx.com>
Date:   Wed, 1 Jun 2022 07:12:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <de8cc48c6141a20fb2ccf2b774981b150caee27b.1653988869.git.wqu@suse.com>
 <20220531144328.GI20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: add btrfs_debug() output for every bio submitted
 by btrfs RAID56
In-Reply-To: <20220531144328.GI20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K48RqkuFV0QTKtRjIFj5WrGMsWgGIWQkACGtnCSF4fn3YmEq+yM
 Wh7SVUqyJSAewkfaA+alZYDBbvB26u6m7/8gDJ8coQGd6ejmXnKv9PdhhdyApt0r0Gj1wgZ
 b7WlfgeOFiIVd0k+6sRcmbniAR+CZsmgcv69anlXXCH7FOg2u1FVfALGldP5kwjdLV2Ed20
 rqCOUyMs9sh7nL2L1jNHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S6Pz/sRcq7M=:NPJ5PREIztuA89xQOnU6is
 BGV+TKcvWfD6cUwbFBfIGbXswO3HfJh9dHdijQyymKv5UlhaPbaBUrgjiBNItijxfTjB70gGB
 QSfBghleqceFJ5kVFpjJWwicuYi+diefC6RtKhw6LD2+1n+k7i3PyYDWuZdF9A5hjajRZj3yy
 cwxXZzgBdbxtb2lF5q/Tx8x9tQN7XuzefpKHQ/ve4gex4foPgTXtAnZ4SKuUpz+bjdNJV2/GS
 z7OX3KFRSPUmmS3NAERVoxvj1azISqPfpuzIPuR23yQbs3KfAlvQ+Yfw1MZuEu6uDUNTE2foD
 wbH+2BqRWbcRwqoMtsnONhwbeBY5tMlOgfCaGf/pm1pFH3oIWho8x0HWZAoSmQ1RBihCZp3f4
 9FC/jv5yGyXAQf1SxMFEXswFYK6py8m7t+BXso/I1GuYG6NFbWSMs4BGy3ktbY7SWjM72lJhO
 PZvRV0m4EfTmh5P2KdDJAQqk9ZjXvAc8dTHakph1M/ZNf7xofQCTvS61Qw8TGq6/RZC7udreE
 wD46f+USpLqMhy6sJrrlRt4I4HZZqIITeJN+OkcM4vBa5BUs6qrl2rrbE/qGxQR2FB4DBrOlO
 A0PrDcC/5SfeHgTIr+tob0B2oL8C+8rVeTwzK/o1Hf7zF2otWeTOHcF8aW7qAZyRgCQCU73JZ
 /9fpwz6ppUPxbJrKsazXgvc4fDkzpFA48ruciUELUS93eVen7QC/zThSUzMuEjDL8yH0si14S
 DJnXGyrn9m82u/pwGP/3VHgOWXhh+LxLxHT5FNr6MpYcS+E2PCn0pJxSBqiMTOHFH34wlS1Sk
 Ye4xXynk9jUAeZAIdkuAYNb7jKuEhlHyjd/CIGlqzSXdDg6/NRkllNq6remTyujnQMb080h9f
 gHu5gpg+knv4sKymgCOYgwp5VimW7fpoDVvRBngtDbnycTO5KGv4MlASjYvLPLFfZmDmhKm4O
 ZiUNVdTuj3jNNryrXxs78V3FXGmFC2GtBVQNhq5ozOYGhUFoVDTM9NUeDD9mwj3KjZWVfAaXk
 g5PNilcFuMb/uTbAauHxQr84KQZOjN6HdUpMpcJA8UEGFVc6bqPaq/FUql/cNb8VLJZRh00Xv
 VTNtYKpDcAGkWCMqgiNu2rhWFF9SwsEstWeG3piMdp6s46wWWhP/msm0w==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/31 22:43, David Sterba wrote:
> On Tue, May 31, 2022 at 05:22:56PM +0800, Qu Wenruo wrote:
>> For the later incoming RAID56J, it's better to know each bio we're
>> submitting from btrfs RAID56 layer.
>>
>> The output will look like this:
>>
>>   BTRFS debug (device dm-4): partial rmw, full stripe=3D389152768 opf=
=3D0x0 devid=3D3 type=3D1 offset=3D16384 physical=3D323043328 len=3D49152
>>   BTRFS debug (device dm-4): partial rmw, full stripe=3D389152768 opf=
=3D0x0 devid=3D1 type=3D2 offset=3D0 physical=3D67174400 len=3D65536
>>   BTRFS debug (device dm-4): full stripe rmw, full stripe=3D389152768 o=
pf=3D0x1 devid=3D3 type=3D1 offset=3D0 physical=3D323026944 len=3D16384
>>   BTRFS debug (device dm-4): full stripe rmw, full stripe=3D389152768 o=
pf=3D0x1 devid=3D2 type=3D-1 offset=3D0 physical=3D323026944 len=3D16384
>>
>> The above debug output is from a 16K data write into an empty RAID56
>> data chunk.
>>
>> Some explanation on them:
>>   opf:		bio operation
>>   devid:		btrfs devid
>>   type:		raid stripe type.
>> 		>=3D1 are the Nth data stripe.
>> 		-1 for P stripe, -2 for Q stripe.
>> 		0 for error (btrfs device not found)
>>   offset:	the offset inside the stripe.
>>   physical:	the physical offset the bio is for
>>   len:		the lenghth of the bio
>>
>> The first two lines are from partial RMW read, which is reading the
>> remaining data stripes from disks.
>>
>> The last two lines are for full stripe RMW write, which is writing the
>> involved two 16K stripes (one for data1, one for parity).
>> The stripe for data2 is doesn't need to be written.
>>
>> To enable any btrfs_debug() output, it's recommended to use kernel
>> dynamic debug interface.
>>
>> For this RAID56 example:
>>
>>    # echo 'file fs/btrfs/raid56.c +p' > /sys/kernel/debug/dynamic_debug=
/control
>
> Have you considered using a tracepoint instead of dynamic debug?
>

I have considered, but there is still a problem I can not solve that well.

When using trace events, we have an advantage that everything in trace
event is only executed if that event is enabled.

But I'm not able to put the devid/stripe type search code into trace event=
.
It will need to iterate through the rbio->bioc->stripes[] array.
I'm not even sure if it's possible in trace events.

So I go dynamic debug, with the extra cost of running devid/stripe
search every time even the debug code is not enabled.

Thanks,
Qu
