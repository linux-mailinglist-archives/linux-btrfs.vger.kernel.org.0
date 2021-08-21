Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A1C3F37DA
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Aug 2021 03:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbhHUBFu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 21:05:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:43619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhHUBFu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 21:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629507908;
        bh=wgMVcuoQ3fcCQU5a1VnM3O8D3MDUvBSwwINhdFAgv40=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=Ad/ZJWCuiVAiXuutcqiFOaWYL7wQNLDIXJqx6webDujHQMPSZgmSb0qGxlgDNMUaS
         nNyvAIRsEZWXXF0wVAau7co4Q9dRugWabggl9JkED9o0UakwCA9jNLxRkbRdNPitS9
         opDDaI7B8ZdayznfVQbAIv4m7Q00X0qKbDi+rX54=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3bX1-1n0Aus2w0B-010ZqV; Sat, 21
 Aug 2021 03:05:08 +0200
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210812054815.192405-1-wqu@suse.com>
 <20210820131625.GU5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v6 0/4] btrfs-progs: image: new data dump feature
Message-ID: <99322fd3-8c9f-50f7-44f1-02f649b22bc8@gmx.com>
Date:   Sat, 21 Aug 2021 09:04:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820131625.GU5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RWit0+kmYIVMAHrejoWM5glWI7KeiCzEW+GgMr7y7Y6FGPUltXJ
 xS9xOpAQCTjW66CgU1qNeWYg+tWjNsgztbZ6rJ3rg8Lf20kP6vH4T0rH/MvTJsMmwD6ckgm
 yK8SoKe9NoUA2dfxc0uSPe0oQSQDQ6GjrM/mW+x5ZrfgrHknp/lxv4+G8jzFybRnTP2A4Av
 V7BmytHH1ppbBCMMuQIsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4YlK8wGG5nA=:YnkakzREgdZJ0TfbM3Yt91
 Fl6ivHIV5iwhHbxbS42G1Y+IIhOdwSu+yY1FyDaoPgA9lBn5tMi4MIz5zjuFtmPxDwHeobCqs
 skQ0ADK1auF5FqLDuLpTd6FyDCIdNersZ/CHASYDLKFZHLLUSFZISO7VOWT29ciOfU5gRZg+c
 sBGX+UqfPbwxYRJ9cRE4vLLuAd4YL2WAhG3hAwXpIjcpt+v4JoW2VrUCr9bb6RCcohOx3nabT
 BHe1t7i9UcAbmuzQZP/VpGYe7FHCux86cxjLjMTS7+PkEngA8yBRDZNk1Ctq0C46L/pYWv13E
 QZ1pTbz6Vae4zTzIjX5RJ7NyEhNr4sVOpI0ML3/Tr9KiVtgiA3Qg3w71/lXJ0W/xJSP6GnMJY
 sFXPmJGNXQ7QORlrv5gIXfP2Vg6S+n6DhuIBLSDZxlEMR1QdppiTzmlwXncs3+ERV9ZhD9Oi8
 gOoxNeRwikiHh7eqixz97L3AchSbEZZbpPIsh4Vkt12Lp+/iQ7YultBp+1OEe6OTbw0/p5fHl
 BxMfQukByMsP6/rd5cDAzjduB/MItsbM6kC5jqw8BMi9afe26YZQI/NN84feB15I+xiFQKElp
 SyMhd7c1Z81gkDh85KUuDsqNeDgZuSL41WJ2wRlFezrBQuKgpUVLQEg8IhhA6u8xaHxa1Mjd9
 add+elEuRszQGC0lhp3NhDJ1McMSJ3wYkrA00zZdMu/pYDB5/i8xhJdIawAn2Bu/0PPbxTL5z
 McHie6FyTerRBsriDxJlL+TLBDSWv3Amf15RJVGMcQ1Y6BdCLtnRdirpKDaFFw/SGSMHXMJM7
 FiSXY0eaZGxUNPIrd9zmgNE/yNLEbIDhbVcgCozODXpaypE8ppATFIOFN1bMFGY6ay/AmxiQX
 TKtlHop5klIKx6w8VizZ4i4ymrhXT+bFVd+vmrUhr8frIHfxcH+zgcUD3rHvyT7LJpZJ+JrNo
 UJbPGbjxuZnmPhYpSC/tIw+xl2+xtci6jw+peijkzggJYjsnyvj3RV8EOiqa6bZ2apouRVlX1
 8eF3Aftu2ZDteowcLAEV3eVSf/RTmu5biFoHUfIAr7qQsAZqO4uu3U9cNDPrQlp9LLeO+EMbi
 e+REnWmxRvIZchlukvr8TZpB0D1jsAX932f/GqUPUkXyunGrqn9VY3VOg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/20 =E4=B8=8B=E5=8D=889:16, David Sterba wrote:
> On Thu, Aug 12, 2021 at 01:48:11PM +0800, Qu Wenruo wrote:
>> This patchset includes the following features:
>>
>> - Introduce data dump feature to dump the whole fs.
>>    This will introduce a new magic number to prevent old btrfs-image to
>>    hit failure as the item size limit is enlarged.
>>    Patch 1 and 2.
>>
>> - Reduce memory usage for compressed data dump restore
>>    This is mostly due to the fact that we have much larger
>>    max_pending_size introduced by data dump(256K -> 256M).
>>    Using 4 * max_pending_size for each decompress thread as buffer is w=
ay
>>    too expensive now.
>>    Use proper inflate() to replace uncompress() calls.
>>    Patch 3
>>
>> - A fix for small dev extent size mismatch with superblock
>>    This no longer affects single device dump restore, thus it's only
>>    for multi-device dump restore.
>>    Patch 4
>
> So this looks like a big thing, new format, new version, bringing all
> the fun and problems with proper format design, description and
> validation - that we don't have for v1 either. How would old progs
> version handle the new version?

They just won't recognize the format at all.

That's why I'm introducing a new magic as a newer version, not just
changing the limits of v1 image.

> There's no proper detection so it could
> just try to use the dump and then fail at some random point (I haven't
> tried, just gusessing).

The magic is at the very beginning of the dump, so no way to get screwed
up at some random point.

Just like this:

$ ./btrfs-image -d /dev/test/test  /tmp/output
$ btrfs-image  -r /tmp/output ~/test.img
ERROR: bad header in metadump image
ERROR: failed to build chunk tree
ERROR: restore failed: -5
>
> The version cannot be selected explicitly on the command line, only -d
> would silently change it.

Because there is no need to change the version for metadata only dump.
Nothing is changed for metadata only routine.

>
> The documentation should also come with the patch though it might not be
> complete until we agree on the whole feature or implementation, but not
> even updating the command line interface in manual page happens way too
> often and I randomly notice and have to fix it myself.
>
> Data in the dump could be useful but I'd still like to see some usecase
> description.

The main case is to properly dump data so that we can verify the data
mismatch and maybe find some clue on which is to blame (hardware or
ourselves).

Of course, creative users may also want to use this feature to do
offline backup.

Thanks,
Qu
