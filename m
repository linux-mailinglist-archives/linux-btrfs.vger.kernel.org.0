Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF94E2538A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 21:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHZT5a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 15:57:30 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:36485 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZT5a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 15:57:30 -0400
Date:   Wed, 26 Aug 2020 19:57:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1598471847;
        bh=AxioEnail6XEeTsiIrFxzRuEPL+EU8uWWyN5S7stJQg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ppK0rjrvQHGbCC9DR5Dfcl2wEbshiCbizXR95yfJpYs13jwOhSWcotXF07jxF7hkV
         KWn3C+1bFo8/4FhTm3yTeyEMiXZlPLjUK86FkvaFDGxj52o09fYLBSK3QMCznyKmHZ
         AwmxHvZddmj99kx71x/u8f9BQ4L1O9irXgUuae3w=
To:     Chris Murphy <lists@colorremedies.com>
From:   Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Reply-To: Andrii Zymohliad <azymohliad@protonmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to fallocate failure
Message-ID: <gp99KJ83xX5hsbU2_hXblYTSDI6Rmkk2fbRYAcKNoQik1CH8siYdTw11qFuFdAqo-iC48cJcB_vbMJgY8HuSySoWoBW3hcYHewIgB87Kzzw=@protonmail.com>
In-Reply-To: <CAJCQCtSVMAEZP5OT77yCEBw9Z3C=oyVKcicWbRV9p_+pKcRwoQ@mail.gmail.com>
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com> <CAJCQCtQH3h=NNr6PX3HZp7SbkgqZtNNdihi4aBMFvx+DN79XeA@mail.gmail.com> <6LDov933WqF3kLH8jtkEh-pfK6pRe0o6-Y9l3NcO2mVhswDL7rhbHyda71OnztoJKfgqqQT9jj1Ba52lz_ugNFmmRtzN33BlSa5pCvds0F8=@protonmail.com> <CAJCQCtQDt=x7WCX7KhWz_pPn4yB1YdZm9jN29jRuQDFy=ZTOjA@mail.gmail.com> <emBWetDIaC_TYsBRNRlPcz-yLjIOxlhIBny_K9bTqHxLO_kdKRZlGjMoHrVj4CwZ8aZAnMcXEyCj95vBFBxxOvJ1AANQr1sbeQ_CfZOrTH0=@protonmail.com> <VTDsoZlxoD7U7UxD61VnBts_awxM0n5PgKgeH-fCQOy4VeCCCj27DmdMt_oP490t0cKWbsY9qlK1hci8o-1uD7vtBcVQLub1Gl3JjIGU-o0=@protonmail.com> <CAJCQCtT8gLGNU6E+f=eM9SBPa4+tG+K7AbiCd=KjD2o8QrpxpA@mail.gmail.com> <dHPyoaNUuxoqxJjpSUjcxZvk21ew2ObKWFFhX0efJKBqjG8m27px3mPupviQuM3HYQDEcYQGFQ9jOprBuAX4x1Em3oVOyDl6EhKwEJSiuXs=@protonmail.com> <CAJCQCtSVMAEZP5OT77yCEBw9Z3C=oyVKcicWbRV9p_+pKcRwoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Actually, if you can reproduce the fallocate problem and strace it,
> that would be helpful. For sure, homectl deactivate, for starters. And
> then just 'strace fallocate' that file the same way you did
> previously. I assume it still fails. Put that strace into a text file
> or pastebin (month expiration should be enough) and link it.

Yep, still fails. Here's the one with exactly the same arguments as before =
(-l 403G): https://gitlab.com/-/snippets/2008996

But I did "homectl resize azymohliad 300G" so now "ls -lhs" reports:

    228G -rw------- 1 root root 300G =D1=81=D0=B5=D1=80 26 22:50 /home/azym=
ohliad.home

But even "fallocate -l 300G -n /home/azymohliad.home" fails the same way. H=
ere's strace: https://gitlab.com/-/snippets/2008993

(I hope gitlab is ok too, you can add /raw to URLs to get raw txt file)


> And also paste into your reply:
>
> grep -r . /sys/fs/btrfs/<uuidofbtrfs>/allocation/

    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadata/=
disk_used:474251264
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadata/=
bytes_pinned:0
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadata/=
bytes_used:474251264
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadata/=
single/used_bytes:474251264
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadata/=
single/total_bytes:1073741824
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadata/=
total_bytes_pinned:163840
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadata/=
disk_total:1073741824
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadata/=
total_bytes:1073741824
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadata/=
bytes_reserved:163840
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadata/=
bytes_readonly:0
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadata/=
bytes_may_use:74252288
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/metadata/=
flags:4
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/di=
sk_used:81920
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/by=
tes_pinned:0
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/by=
tes_used:81920
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/si=
ngle/used_bytes:81920
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/si=
ngle/total_bytes:33554432
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/to=
tal_bytes_pinned:0
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/di=
sk_total:33554432
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/to=
tal_bytes:33554432
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/by=
tes_reserved:0
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/by=
tes_readonly:0
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/by=
tes_may_use:0
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/system/fl=
ags:2
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/global_rs=
v_reserved:68730880
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/disk=
_used:314346594304
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/byte=
s_pinned:0
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/byte=
s_used:314346594304
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/sing=
le/used_bytes:314346594304
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/sing=
le/total_bytes:510463901696
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/tota=
l_bytes_pinned:4096
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/disk=
_total:510463901696
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/tota=
l_bytes:510463901696
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/byte=
s_reserved:4096
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/byte=
s_readonly:131072
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/byte=
s_may_use:4096
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/data/flag=
s:1
    /sys/fs/btrfs/b68411ce-702a-4259-9121-ac21c9119ddf/allocation/global_rs=
v_size:68730880

I also added this output to the collection here: https://gitlab.com/-/snipp=
ets/2007189
I'll keep all those gitlab snippets that I shared in this thread online for=
 a while (some months at least).

