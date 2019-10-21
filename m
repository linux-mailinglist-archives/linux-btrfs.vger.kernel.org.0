Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76668DEA03
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfJUKrm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:47:42 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38171 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfJUKrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:47:42 -0400
Received: by mail-ed1-f52.google.com with SMTP id l21so9635748edr.5
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KoissbUg+G69tRkz/kr+7FVs6T5cnmWW9Qh6xDfMmg=;
        b=QxIlu+LLsxttbPoVn82023uOzesYO6bW5xT6xxdeDnxbi+AI5ZGhlasJZ1vTGKu5hp
         vE4inbcSLysWTgzb1gKgXJi2A9zQrClZaZT9IFJFoDyWSom/30eyHVoI56PsVOEPF0Yw
         ZTvgraHZXSQJgg+fNomEi0WZTngoy6KO6IGE0r0JJSuiIDwLpSK8VstEFV+TU2G9JaSi
         MvAI+zZY0xdNXXoAQfLWya+3lqnMVrpVxWNdkFnPl3cmxB/Pbn7VQwJ5J9Gj5khD6zzn
         6jZZpXQuXsdXyK1uEBs+wwC0f9p+GE6QupGkGZ4lTJ3mOTNpBvco2boXrIPYK3v+H+7r
         7wKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KoissbUg+G69tRkz/kr+7FVs6T5cnmWW9Qh6xDfMmg=;
        b=kEoSBCj5I4Bmm+PdhvjmWyXwl+wxhqNZOB3pnn94SNfX8vQ45In1ZfEsWMdinS7/d1
         5wktUQK5Mn6nWw9yI6ZwEeiOfN/EErjWIgWDHBqVvB47q1EU4bjKdmyLcV0f8h9hS3di
         MUmJQ2JJN+3/fK1XXReFXFgugq8WdjXCfsNn8mFb4d+e4iQj3B+k3Rj7ImLDq4Zo0SKG
         LkSXVbakM7Pdo4kGvhkyxsIdje57+bmIBuDg3mCuMn7EsZuhddRvyOxMAnEsKU7Yn5Yc
         EFNNCTE+D96qorO5NF4gfMlqAKS0+E6i8GN7Zzk+yrh5MsCKw8wb1YULiToIfs7bGa71
         jhEQ==
X-Gm-Message-State: APjAAAUFz414wRh2jvsqifDK8rIUaO6shiKOs59DkyRmg5/rv0BJUVJs
        xcALW3qIsZcT4A0mLgv2aeiFFjgOw9wUJ4XmTbDt42k=
X-Google-Smtp-Source: APXvYqycFqMynIAMji+8ozRA5qrHvpltUy0XMR2N/ZWYRNgen576HmVCkDZ8ka0JsYYFS9pUdM5AsHZ5VTui01bRmFM=
X-Received: by 2002:a05:6402:3c5:: with SMTP id t5mr23612022edw.125.1571654859956;
 Mon, 21 Oct 2019 03:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com> <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com> <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
In-Reply-To: <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Mon, 21 Oct 2019 12:47:03 +0200
Message-ID: <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Please CC me, I'm not on the list.]

Am So., 20. Okt. 2019 um 12:28 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
> > Question: Can I work with the mounted backup image on the machine that
> > also contains the original disc? I vaguely recall something about
> > btrfs really not liking clones.
>
> If your fs only contains one device (single fs on single device), then
> you should be mostly fine. [...] mostly OK.

Should? Mostly? What a nightmare-inducing, yet pleasantly Adams-esqe
way of putting things ... :-)

Anyway, I have an image of the whole disk on a server now and am
feeling all the more adventurous for it. (The first try failed a
couple of MB from completion due to spurious network issues, which is
why I've taken so long to reply.)

> > You wouldn't happen to know of a [suitable] bootable rescue image [...]?
>
> Archlinux iso at least has the latest btrfs-progs.

I'm on the Ubuntu 19.10 live CD (btrfs-progs 5.2.1, kernel 5.3.0)
until further notice. Exploring other options (incl. running your
rescue kernel on another machine and serving the disk via nbd) in
parallel.

> I'd recommend the following safer methods before trying --init-extent-tree:
>
> - Dump backup roots first:
>   # btrfs ins dump-super -f <dev> | grep backup_treee_root
>   Then grab all big numbers.

# btrfs inspect-internal dump-super -f /dev/nvme0n1p2 | grep backup_tree_root
backup_tree_root:    284041969664    gen: 58600    level: 1
backup_tree_root:    284041953280    gen: 58601    level: 1
backup_tree_root:    284042706944    gen: 58602    level: 1
backup_tree_root:    284045410304    gen: 58603    level: 1

> - Try backup_extent_root numbers in btrfs check first
>   # btrfs check -r <above big number> <dev>
>   Use the number with highest generation first.

Assuming backup_extent_root == backup_tree_root ...

# btrfs check --tree-root 284045410304 /dev/nvme0n1p2
Opening filesystem to check...
checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
bad tree block 284041084928, bytenr mismatch, want=284041084928, have=0
ERROR: cannot open file system

# btrfs check --tree-root 284042706944 /dev/nvme0n1p2
Opening filesystem to check...
checksum verify failed on 284042706944 found E4E3BDB6 wanted 00000000
checksum verify failed on 284042706944 found E4E3BDB6 wanted 00000000
bad tree block 284042706944, bytenr mismatch, want=284042706944, have=0
Couldn't read tree root
ERROR: cannot open file system

# btrfs check --tree-root 284041953280 /dev/nvme0n1p2
Opening filesystem to check...
checksum verify failed on 284041953280 found E4E3BDB6 wanted 00000000
checksum verify failed on 284041953280 found E4E3BDB6 wanted 00000000
bad tree block 284041953280, bytenr mismatch, want=284041953280, have=0
Couldn't read tree root
ERROR: cannot open file system

# btrfs check --tree-root 284041969664 /dev/nvme0n1p2
Opening filesystem to check...
checksum verify failed on 284041969664 found E4E3BDB6 wanted 00000000
checksum verify failed on 284041969664 found E4E3BDB6 wanted 00000000
bad tree block 284041969664, bytenr mismatch, want=284041969664, have=0
Couldn't read tree root
ERROR: cannot open file system

>   If all backup fails to pass basic btrfs check, and all happen to have
>   the same "wanted 00000000" then it means a big range of tree blocks
>   get wiped out, not really related to btrfs but some hardware wipe.

Doesn't look good, does it? Any further ideas at all or is this the
end of the line? TBH, at this point, I don't mind having to re-install
the box so much as the idea that the same thing might happen again --
either to this one, or to my work machine, which is very similar. If
nothing else, I'd really appreciate knowing what exactly happened here
and why -- a bug in the GPU and/or its driver shouldn't cause this --;
and an avoidance strategy that goes beyond-upgrade-and-pray.

Cheers,
Christian
