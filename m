Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378204B86E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 12:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiBPLlR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 06:41:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiBPLlQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 06:41:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2035B179730
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 03:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645011659;
        bh=V5neiFyeMqmkRo9HoStqA/0Jn9qJ3D6pMbgZLip18mo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=egOyutp7Stbt0OmAXiTY23siiey2geg8+Ty3AbuwXuy+DrRJjlBA5gL2QPlhIdNNj
         8PmzSYoeKWoxhEDtVlBo5rWIJmf+mf0T5j6PE7RG3SuvX8xaeoNVZ45xm4hdWePEq6
         uQ8JmQHwvMKyzrUY2xz1/2I4y+eqsxVpV42in0oA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4zAy-1oIYkI0oo0-010xju; Wed, 16
 Feb 2022 12:40:59 +0100
Message-ID: <7bbf404a-7a78-4594-572a-2ab87693543c@gmx.com>
Date:   Wed, 16 Feb 2022 19:40:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] btrfs-progs: Doc: update autodefrag mount options
Content-Language: en-US
To:     Graham Cobb <g.btrfs@cobb.uk.net>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <90c29d3ce0096d1de56c898b63c40ebcdeafbba0.1645009831.git.wqu@suse.com>
 <d1d5f904-f8d1-d328-edfa-f918dca728eb@cobb.uk.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <d1d5f904-f8d1-d328-edfa-f918dca728eb@cobb.uk.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Sgut1uL0x2gOheQvS9WlKQpwuXpOHjYbwfHg6D9FiW02oIq73d
 o3DIafbPBrphHjJeY8lKioIri5e0/n+o3BCf/tOwV0+8wtwt70zbB9XQjFkwf8UOybRnnrv
 SUeM5Pkb3Y7trDbiOjz3H/hTz7tFKubRPkcZHo92Gzx2OdHyPgJYuaAbKUv1w1DD0q/4ZsR
 0phbUHhnChPibZXJjUnuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OJ5RNTIgL98=:IVUvlaKDO1KcTz2uwMJ2wc
 b4C96zsFIVQueXHZ/pd5xxihDz8tkTCGiCtaTI9Xgpe8EkmIynTzvNd4rhy3AYd6xDHwxZKwP
 iWUDCjzRv4OiqmeXpS9FvKvGwZ3rnvXzaULpyt6qHBXazvDE/xyFvq4XgWoHoNUlJqRhNxkm0
 aB5J/bacOXXELo2KDBfgbPFlTSpK49vW5Ps1yF8gHEIEPO1tfj7vGCx/Jc68Hx09b/acJkbsX
 R6MIOvfwCT19maxrMeFfKC1m94peLRxy4Bcc84YGutxsM+y24cNW7F2iRfs08WcHLDJQreaGA
 mMlkBZ7IJ9IQJjsbm9TA1XbndwYdm3IrRxagzsDSmKm/qZ5XqZXfMcGXJDhtZRbThSzhTA1nw
 iB7EyXB3a8ZHRgWyi2gTrOZg1092e0kysIXmplnVc5GVOjuJQwv4Utb6Df+588A9bWoJeCwQp
 D0D1zNETWVBIZhRN1p9k3PsN78ho31127qiJaky/KyZdKCDGGwV86+Zhf0KooFfGsMJ93Hp9H
 h2fwUUeevuAg4ySTbKp/ybe86ZM0mMyLdvHraFkevLEsEiIK8KtuWNZlSIWMdPvWfUXIqvdEU
 dwqJHT1Tyfv3dNME1J2ijQwrDZBbfU9HJ9swL81PnhbTp0e2xoaTNKhfsIq6hv6AKIgEhYlEg
 kTRzmr7BVOoM8ed+pNAIxSkLOugFomdpHOudPHSw71FziwNZAc+OtyB6A0NQtw7aG5ke7/wn2
 3FoH6GhWPB3/3PhTF/osbZ7rcCh788WyQTDI0nggSIciShy35iJnwZrqG7NWpQtG2EzKHYIgG
 3yVpmF6Ub6eRrAPsx5+1/McYefF2OhWsQNVwBh/SIzJ4AOMb1fgU3rHZUtxgzxE+r0+Ao5uLN
 ffKaCoyrxadEkrTXuo3jGHls4Pe+9k0rxpwY13YgtGTW50YnowhZ/lcenYfWjPebQ0y0Ichz7
 26jPxoBk0EapP9TV7jJHbHEGiiuCQxa/zoXUiQNiTH20hw7WI5f1ex/4YmpZNlKgkafiBeokG
 1RjEaSXE7dNFsPY2eSCiJW4vc1TBGJ0EiWjZCJEYCjDQRIrCeVhvxKmBwWOsV2lKdbXbzY0n0
 Xru9pMgxAYMgMk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/16 19:33, Graham Cobb wrote:
> On 16/02/2022 11:10, Qu Wenruo wrote:
>> This will add the following contents:
>>
>> - Add how autodefrag works
>>
>> - More detailed cases which are not sutiable for autodefrag
>
> Typo: suitable

Why my git hooks didn't warn me...

Anyway, really appreciate the typo catch and feedback on such docs, as
you know I'm really bad at writing docs...

>
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   Documentation/ch-mount-options.rst | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/ch-mount-options.rst b/Documentation/ch-moun=
t-options.rst
>> index f4ff0084d00f..f2dd12e6f841 100644
>> --- a/Documentation/ch-mount-options.rst
>> +++ b/Documentation/ch-mount-options.rst
>> @@ -28,9 +28,23 @@ autodefrag, noautodefrag
>>           (since: 3.0, default: off)
>>
>>           Enable automatic file defragmentation.
>> -        When enabled, small random writes into files (in a range of te=
ns of kilobytes,
>> -        currently it's 64KiB) are detected and queued up for the defra=
gmentation process.
>> -        Not well suited for large database workloads.
>> +        When enabled, small random writes into files (in a range of te=
ns of
>> +        kilobytes, currently it's 64KiB for uncompressed write, and 16=
KiB for
>> +        compressed write) are detected and queued up for the defragmen=
tation
>
> As I think the target audience for the mount options documentation
> includes system admins, not just btrfs kernel developers, I would avoid
> the term "compressed write" because of the plans to add a mechanism to
> write pre-compressed data which the admin may have heard about and be
> confused. How about something like:
>
> "currently it's 64KiB for writes to uncompressed files, and 16KiB for
> compressed files"

Something similar is also considered, but one of my concern is for the
"compressed files" expression, won't end users get confused with regular
compressed files like .tar.gz, not the btrfs term for compressed file
extents.

Any better or official expression specific for those btrfs compressed
file extents?

>
> Sure, this is hand-waving over the precise decisions the kernel makes
> but anyone who cares about that will check the actual code anyway.

Well, I'm pretty sure that almost none of the autodefrag users are
reading the kernel code, that's why I put some simplified comment into
this part. :)

Thanks,
Qu

>
>> +        process.
>> +
>> +        Then btrfs-cleaner kernel thread will try to defrag all those =
files.
>> +        The defragmentation process will scan the whole file from offs=
et 0,
>> +        finding out mergeable small writes since last modification, an=
d
>> +        re-dirty suitable targets (small, newer than last modification=
, mergeable)
>> +        for next writeback.
>> +
>> +        Thus autodefrag, just like regular defrag, will cause extra da=
ta write.
>
> Typo: "writes"
>
>> +
>> +        Not suited for heavy random write workload (including database=
 and
>> +        torrent), as such small random writes can get re-dirtied very
>> +        frequently, causing amplified data write IO, while the file ca=
n still be
>> +        heavily fragmented by the new writes.
>>
>>           The read latency may increase due to reading the adjacent blo=
cks that make up the
>>           range for defragmentation, successive write will merge the bl=
ocks in the new
>
> Graham
