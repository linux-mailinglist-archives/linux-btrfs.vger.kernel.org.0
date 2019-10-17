Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC14DB1A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 17:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436563AbfJQP53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 11:57:29 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:47099 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395161AbfJQP53 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 11:57:29 -0400
Received: by mail-wr1-f46.google.com with SMTP id o18so2934649wrv.13
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2019 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBkRMgxxfe/R2+hxgQoO0RezEMRixeqDijYHVfpof3c=;
        b=YJz1q1iyxczG3MUUgB5i4A3zo9y4MtZIjCu5r1XGPPJhtic+X8qRwVHQn18y5Ed3Gy
         dNfq+18xOWikFZFDXpbMh6y3b6Ws8D/d3RVyBC007Im6IFRmXtm/09xRk5V7oJvmDYeJ
         qKvj2nwZvjnN0lHKFJ+PSCR2m4S3uNXJ0YKFDkgQ74KIUIz6HZJUj7Gr34lZTxD1kgGI
         Zcx9DUd+G6/3HCx8KHYKEw5Ot5JU4oSyqWFI7KkPw38jc7QljY18mzDVsN76BTcr0N8/
         256F9WISgOuaMYP79Gdg8bxfj7ULUqdGFoDDGVohLCPkN36gBJw4/8c7eJLZYK3CcjVW
         lXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBkRMgxxfe/R2+hxgQoO0RezEMRixeqDijYHVfpof3c=;
        b=iGHO1ZDl4Pssy2B5T1C8ujU0u+fOfJfwbuvei1U/DYBGOwQIEODKgk9NjBpaRF8BSm
         kUV1bO3onNuIuMvd74MSU4mQ8YaZ023nsUJwqhUWp4Lftg24I97q0msWnJlccOCseyIc
         Y0qyz0wQdXnrStBXidxRJ7jFnuEcdm6hrf7B1+chxcy9MCS3+oWIlTz71zkHTKWWRkYp
         3p8jUc653s/3maoDTxyMw5JwS2b9rZakMZcqTzk02lp8qldQ4hlye1qzWE5A5x7z4J4h
         LJRIM6E1tmAMwiz70tcgoX6VlphRPiHy/gDwPbvQFlVnGEv3NlfqG5n5rdEX4GyODfou
         IuFw==
X-Gm-Message-State: APjAAAWwR9Vn/Mjoco85wc1wDj/SsOWZqcj0E657bUeUzl4CynjmdJd3
        Xe6ckEDXFbzuBtZPKP77qA/6rjfTNrIIaPZIGQw67NkSyC5cOw==
X-Google-Smtp-Source: APXvYqzd9zuATRVorQ8R/2bWf5DUp8Nzt6tf30dNzLReN+03fPd/eU9hDYKPHSdan6RztO4R2NJMK9tMHxFKDaoqX5o=
X-Received: by 2002:a5d:62cd:: with SMTP id o13mr3764139wrv.101.1571327845081;
 Thu, 17 Oct 2019 08:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com> <CACa3q1wUmgY9uTygYFVBer=QgZjtwX2NOvVT68kAYKAgoLpXRg@mail.gmail.com>
In-Reply-To: <CACa3q1wUmgY9uTygYFVBer=QgZjtwX2NOvVT68kAYKAgoLpXRg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 17 Oct 2019 09:57:08 -0600
Message-ID: <CAJCQCtR=NQd6uovvAhuTdxRNJtnMFDtkTma9u8-Ep9Nq+YQY=A@mail.gmail.com>
Subject: Re: MD RAID 5/6 vs BTRFS RAID 5/6
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 16, 2019 at 10:07 PM Jon Ander MB <jonandermonleon@gmail.com> wrote:
>
> It would be interesting to know the pros and cons of this setup that
> you are suggesting vs zfs.
> +zfs detects and corrects bitrot (
> http://www.zfsnas.com/2015/05/24/testing-bit-rot/ )
> +zfs has working raid56
> -modules out of kernel for license incompatibilities (a big minus)
>
> BTRFS can detect bitrot but... are we sure it can fix it? (can't seem
> to find any conclusive doc about it right now)

Yes. Active fixups with scrub since 3.19. Passive fixups since 4.12.

> I'm one of those that is waiting for the write hole bug to be fixed in
> order to use raid5 on my home setup. It's a shame it's taking so long.

For what it's worth, the write hole is considered to be rare.
https://lwn.net/Articles/665299/

Further, the write hole means a) parity is corrupt or stale compared
to data stripe elements which is caused by a crash or powerloss during
writes, and b) subsequently there is a missing device or bad sector in
the same stripe as the corrupt/stale parity stripe element. The effect
of b) is that reconstruction from parity is necessary, and the effect
of a) is that it's reconstructed incorrectly, thus corruption. But
Btrfs detects this corruption, whether it's metadata or data. The
corruption isn't propagated in any case. But it makes the filesystem
fragile if this happens with metadata. Any parity stripe element
staleness likely results in significantly bad reconstruction in this
case, and just can't be worked around, even btrfs check probably can't
fix it. If the write hole problem happens with data block group, then
EIO. But the good news is that this isn't going to result in silent
data or file system metadata corruption. For sure you'll know about
it.

This is why scrub after a crash or powerloss with raid56 is important,
while the array is still whole (not degraded). The two problems with
that are:

a) the scrub isn't initiated automatically, nor is it obvious to the
user it's necessary
b) the scrub can take a long time, Btrfs has no partial scrubbing.

Wheras mdadm arrays offer a write intent bitmap to know what blocks to
partially scrub, and to trigger it automatically following a crash or
powerloss.

It seems Btrfs already has enough on-disk metadata to infer a
functional equivalent to the write intent bitmap, via transid. Just
scrub the last ~50 generations the next time it's mounted. Either do
this every time a Btrfs raid56 is mounted. Or create some flag that
allows Btrfs to know if the filesystem was not cleanly shutdown. It's
possible 50 generations could be a lot of data, but since it's an
online scrub triggered after mount, it wouldn't add much to mount
times. I'm also picking 50 generations arbitrarily, there's no basis
for that number.

The above doesn't cover the case where partial stripe write (which
leads to write hole problem), and a crash or powerloss, and at the
same time one or more device failures. In that case there's no time
for a partial scrub to fix the problem leading to the write hole. So
even if the corruption is detected, it's too late to fix it. But at
least an automatic partial scrub, even degraded, will mean the user
would be flagged of the uncorrectable problem before they get too far
along.


-- 
Chris Murphy
