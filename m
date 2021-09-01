Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36653FDE04
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 16:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhIAOwA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 10:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhIAOv7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 10:51:59 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0500C061575
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Sep 2021 07:51:02 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id w17so2764873qta.9
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=0Qlu17gh+QPFWl8sQ7KvlWMO/r0U2Ci+MLn/YZ5UVVw=;
        b=gYCxgdSPsTppurqVbf6DcXJbj3tW1tF/CNm4ewO1tenVK8irzJhnv2bpccdErT+GcI
         tatGkoxv77hS0sCN+07BQT1V9geI5sv74F/CLMEDsXSqfAB2aZBwpN5EwuIGfMF5NiNH
         N3l2zJl0lsQeZe2cieaUdgytlBm7mjaz44HaxQafzbxJ5S9Lg2ja3R6XJze3nILuakzA
         S8xrDv2B+m2OEBqail6qjkrKbjClBexGOfQfvXuTyApLcCWtfIJTTKMzXHJFwMmFFRPf
         TBQeTWnCULKdc6P1RQsfj5HGB2HvehNtDvCntuWf3kgzWR8duYzWndlDqG8GtFcNDpXB
         94gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=0Qlu17gh+QPFWl8sQ7KvlWMO/r0U2Ci+MLn/YZ5UVVw=;
        b=TG4j1LLxR6WWAhkviLCoLbaSequ3GQxXdZCA0juwrcfCz6BUxFFLRXO3oCkiNN3Cae
         0uD6itJhUtzUWQvRdCxoIfFcHXGj3JIe4/N6+naTMCIW6hWYBmVX+Qsq1HsTiC+Vxy1k
         WdtIy1gPAE/y+fwrkBAlTlAFy0XQU+X40SrKf1eRLkkYuE0O9wP6AHQDA20KM82DM6+k
         cH0TwjTqJ8THGLi+EwGfkLeP/koUqhFCFBxBTqW8XRSr3ExyKl9bTRQDWehaAmyZTJiv
         b6F4tmgBr/1oWSfiRx5rEYFIepIP4TkB1+lm/uUlAWp6MTmG364OQHeBvh4IXqWYTNY+
         tHuA==
X-Gm-Message-State: AOAM530XNwh6Xbnt63HOgjI6gRg4hAIKnOwkTOvtvNX0i67hruxzgen3
        LKQM4KYHdw/pY/XVdiGCLMZ+W7xAN1E3snNmahD2VOaPfUQ=
X-Google-Smtp-Source: ABdhPJx8zTRRDoZw6YA2zdvcB5mRljm1/b0UW/OzjOXgo8fO5KE3yYA1xJRjvHzLAWeeqhIMhUfjur74sonFjjG74Vs=
X-Received: by 2002:a05:622a:58f:: with SMTP id c15mr8713179qtb.21.1630507862065;
 Wed, 01 Sep 2021 07:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
 <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
 <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
 <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com>
 <CAOaVUnUwoq69UZ_ajoxYYOHk8RRgGPNZrcm9YzcmXfDgy24Nfw@mail.gmail.com>
 <CAL3q7H67Nc7vZrCpxAhoWxHObhFn=mgOra+tFt3MjqMSXVFXfQ@mail.gmail.com>
 <CAL3q7H46BpkE+aa00Y71SfTizpOo+4ADhBHU2vme4t-aYO6Zuw@mail.gmail.com>
 <CAOaVUnXXVmGvu-swEkNG-N474BcMAGO1rKvx26RADbQ=OREZUg@mail.gmail.com>
 <CAL3q7H5UH012m=19sj=4ob-d_LbWqb63t7tYz9bmz1wXyFcctw@mail.gmail.com>
 <CAOaVUnVL508_0xJovhLqxv_zWmROEt-DnmQVkNkTwp0GHPND=Q@mail.gmail.com>
 <CAL3q7H7MxhvzLAe1pv+R8J=fNrEX2bDMw1xWUcoZsCCG-mL5Mg@mail.gmail.com>
 <CAOaVUnXB4qoAyVcm3H03Bj2rukZ+nbSzOdB4TsKpJjH8sqOr7g@mail.gmail.com>
 <CAL3q7H7vTFggDHDq=j+es_O3GWX2nvq3kqp3TsmX=8jd7JhM1A@mail.gmail.com>
 <CAOaVUnW6nb-c-5c56rX4wON-f+JvZGzJmc5FMPx-fZGwUp6T1g@mail.gmail.com>
 <CAL3q7H6h+_7P7BG11V1VXaLe+6M+Nt=mT3n51nZ2iqXSZFUmOA@mail.gmail.com>
 <CAL3q7H5p9WBravwa6un5jsQUb24a+Xw1PvKpt=iBdHp4wirm8g@mail.gmail.com> <CAOaVUnXDzd-+jvq95DGpYcV7mApomrViDhiyjm-BdPz5MvFqZg@mail.gmail.com>
In-Reply-To: <CAOaVUnXDzd-+jvq95DGpYcV7mApomrViDhiyjm-BdPz5MvFqZg@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 1 Sep 2021 15:50:25 +0100
Message-ID: <CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-UL0aa0oYg+qQA@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Darrell Enns <darrell@darrellenns.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 31, 2021 at 5:48 PM Darrell Enns <darrell@darrellenns.com> wrot=
e:
>
> It's btrfs-progs v5.13.1. Debug logs are attached.

Ok, now I see what's going on.

Somehow you have at least two snapshots (with IDs 881 and 977 on the
send filesystem), that have the same 'received_uuid' -
e346e5a1-536c-8d42-ba33-c5452dec7888.
So these snapshots were received from some other filesystem in the past.

What's unusual is that they have different content - this suggests that may=
be:

1) 881 was successfully sent to the destination filesystem (perhaps as
a full send, or as an incremental, doesn't matter);

2) 977 was turned from RO mode to RW mode, some changes made to it
(several writes to the sqlite file at least), turned back to RO mode
and then used for the incremental send operation.
Or that 977 was a RW snapshot of 881, then changed, someone called the
BTRFS_IOC_SET_RECEIVED_SUBVOL ioctl to set the received_uuid of the
snapshot to e346e5a1-536c-8d42-ba33-c5452dec7888, then turned it RO
and then used it for the incremental send.

Looking at the beginning of 'receive -vvv' output, shows:

At subvol /.snapshots/374/snapshot/
receiving snapshot snapshot uuid=3De346e5a1-536c-8d42-ba33-c5452dec7888,
ctransid=3D39921 parent_uuid=3De346e5a1-536c-8d42-ba33-c5452dec7888,
parent_ctransid=3D35384

The send snapshot and the parent snapshot have the same UUID. This is
asking for trouble, and in this case it causes problems.

And the sending side:

[  391.131006] BTRFS info (device dm-0): send: clone_range() start ino
400698 offset 79134720 send root 977, clone root 881 ino 400698 offset
79134720 data_offset 491520 len 4751360 disk_byte 308100730880
clone_src_i_size 83886080 next_write_offset 79134720
(...)
[  391.131025] BTRFS info (device dm-0): send_clone: ino 400698
clone_ino 400698 send_root 977 clone_root 881 offset 79134720
clone_offset 79134720 ino_path
home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite clone_path
home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite
send_root_uuid ab408d81-05ac-c346-a99a-f525d907c532
send_root_received_uuid e346e5a1-536c-8d42-ba33-c5452dec7888
clone_root_uuid fb2c8e58-2ffa-ad4e-9e0e-9b494691db63
clone_root_received_uuid e346e5a1-536c-8d42-ba33-c5452dec7888

We confirm that send root and parent roots have the same
received_uuid, which is e346e5a1-536c-8d42-ba33-c5452dec7888.
This results in the kernel sending a clone operation with a source
snapshot of e346e5a1-536c-8d42-ba33-c5452dec7888.

The kernel's intention is to emit a clone operation from the parent to
the send snapshot, using valid offsets and lengths.

But because both snapshots have the same received_uuid value, the
receiver picks the first snapshot it finds with a received_uuid of
e346e5a1-536c-8d42-ba33-c5452dec7888 as the source for the clone
operation - but it picks the snapshot that is being received, and not
the parent snapshot - in this case the clone operation is invalid as
we try to clone from the same inode to itself using the range as a
source and destination.

Having two different snapshots with the same received_uuid but
different content is unexpected and breaks send/receive.

I wonder how you managed to get two different snapshots, with the same
received_uuid and different content.




--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
