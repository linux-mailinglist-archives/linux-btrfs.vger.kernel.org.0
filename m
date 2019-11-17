Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4D7FFC34
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 00:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfKQXYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Nov 2019 18:24:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38487 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfKQXYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Nov 2019 18:24:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so17325559wro.5
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Nov 2019 15:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yF/jL8YOV7FuBgNBtXgP0Ul6LhUYiGrDMA+MyQQlje0=;
        b=MTtziFbMypUIM7EeH1YyGi3q1DRsUTINpYfoRWcl2lodz6Z64qePzCTpBlMF0vczrE
         SZu9mf/Vu4PJngHJN8pXaHmL8uyo+I1DVPScPQmK6HPc3GEbyRyGt/pCFm8H7bFQyq81
         3r1lHwebWVLqTtIbDtUj/06IrzOQ3DcwZEGUVzrPmbcCZHVmHL8GBq02oxxGdW/5ZYnP
         A+D/c1yCtIKpAD//zjEP1XU7GSPaqgJ5PTz7P3dlUJe5HObEh+PFeVsyLMT+WQ6x1Q8G
         m7UvNpWxLGK4We5jT3Yq7vxXrjfnmZfU7hJqGv1ZSTI/MyDY8cCVu60YWUImEWVfqD6v
         2Y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yF/jL8YOV7FuBgNBtXgP0Ul6LhUYiGrDMA+MyQQlje0=;
        b=fv5OQr2wAjE0mLVKzt0dWzPgbRrwt4jR1EcP8zEdQcW62nba14JhoUrd6sU/WWh8IC
         bERjAVPjmsczvi2D5FasUGKPdWQMHVlEnKmYkCJKSXYvxHtA+CGs4h7XEH5mxqKz/P8Y
         t9y1knaMGT8Hby4qbsoyEenfhHQnOmg8mB9bvQtOkYaR0mIjsqWcO2wsSOiDJp9AdFuE
         ZuhHIuXftvjpCQB3pSp0dBTaO714Pp8/0ZkLeRtfazA/PPXpOUpkBVIPaVOEC/iPLYov
         /yUP4UJJyaGRhU1LprUzPPZl5BJveWC+oa3Xd4dcM9Gk/cELdKb/J9dAFGDiubbga4pF
         yBpA==
X-Gm-Message-State: APjAAAViXPNA3lV2oGQxub5c/qfKmNIeC5Gf3jo5EtETWERsq/Bn6ANS
        eQQ0KpFw8R219aIfEtgwn63GK88STtEW+ioF+tBM3Z2gUV5T7Q==
X-Google-Smtp-Source: APXvYqz+uFb3u7TrUGltxl7TID9bUpzW6+JjTtD4ZSpXZrC2j9wLnxqL66/mmxSHBhp+Qkbh0qI2MSgWWI2I4drOgT0=
X-Received: by 2002:adf:f607:: with SMTP id t7mr26807501wrp.390.1574033084461;
 Sun, 17 Nov 2019 15:24:44 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtS1v7waFA=ERafSCSCHmPJVytdFZkJLqNTC3U3Gw3Y7tA@mail.gmail.com>
 <d1874d17-700a-d78d-34be-eec0544c9de2@gmail.com> <CAJCQCtTpLTJdRjD7aNJEYXuMO+E65=GiYpKP3Wy5sgOWYs3Hsw@mail.gmail.com>
 <20191104193454.GD3001@twin.jikos.cz> <CAJCQCtSiDQA4919YDTyQkW7jPkxMds1K32ym=HgO6KHQLzHw+w@mail.gmail.com>
 <d2301902-bd5b-7c5a-0354-a5df21ca8eb3@libero.it> <CAJCQCtQm_5L9uvH53O3Qby3Ktwpvsc2_6rUhkBLGeD07RP5a7Q@mail.gmail.com>
 <4480d47f-1b1e-d99d-e480-b31220433340@inwind.it> <CAJCQCtTeYNvU-FueRKW6tnkNaRDDCAAUUCb5ZitA2VT+PR+K-A@mail.gmail.com>
 <CAA91j0WMinT4YP3oSZaPLc_aLHjL2ODXz=QQd6NynphvRJ2hBw@mail.gmail.com>
In-Reply-To: <CAA91j0WMinT4YP3oSZaPLc_aLHjL2ODXz=QQd6NynphvRJ2hBw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 18 Nov 2019 00:24:06 +0100
Message-ID: <CAJCQCtSVCVNfT-iS=vmJnZ=u0eoiM=92fWr_emy0A13u3C-++Q@mail.gmail.com>
Subject: Re: Does GRUB btrfs support log tree?
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>,
        David Sterba <dsterba@suse.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 14, 2019 at 9:19 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>
> On Thu, Nov 14, 2019 at 12:50 AM Chris Murphy <lists@colorremedies.com> wrote:
> > But GRUB does have a way of detecting core.img on it, and
>
> No. GRUB does not "detect" core.img at all. On Legacy BIOS stage0 code
> in MBR includes hardcoded absolute disk location of core.img (as list
> of extents). Stage0 does not care whether this location is post-MBR
> gap, BIOS boot partition or file inside another file system, it simply
> loads absolute disk blocks and jumps to loaded code.
>
> > avoids overwriting it by preferring to write in free space within that
> > partition, ostensibly to support multiple instances of GRUB (multiple
> > distributions),
>
> Sorry? What are you talking about?

grub-install does this, at least it's what someone on grub-devel@ list
told me ages ago.


> > and some degree of atomicity as the core.img is
> > written first to this partition before the boot.img or "jump code" is
> > written in the first 440 bytes of the MBR.
> >
>
> core.img must match block list recorded in MBR; as soon as core.img is
> overwritten in-place you cannot guarantee that whatever stage0 will
> read matches what has been written if stage0 update was aborted for
> whatever reasons.

Yeah what I was told is grub-install tries not to overwrite core.img.
Obviously if it's unavoidable, the update can't be atomic.


> This is outside of scope of EFI, really. GRUB consists of two parts -
> kernel (which is implicitly embedded in core.img/core.efi) and
> loadable modules. They must match. So to ensure atomic update on any
> architecture one has to
>
> 1. Write new core.img.
> 2. Write new /boot/grub/$platform content (new modules).
> 3. Switch boot information to use new version.

The need to update modules is sort of a problem for atomicity too.


>
> On EFI this would simple mean to write grubx64.efi with different name
> or location on ESP and then update EFI boot variable to point to it.
> Like
>
> \EFI\vendor\image1\grubx64.efi
> \EFI\vendor\image2\grubx64.efi

Yes, although I'm not a fan of writes to NVRAM. They really should be
minimized. It's not high wear NVRAM, and no way to replace it if it
starts crapping out.

>
> If you want make it alternate between two independent ESP for
> additional redundancy.
>
> /boot/grub/$platform is more involved, as a lot of code in grub2
> assumes location is always under /boot/grub ($prefix more precisely).
> SUSE had to introduce concept of "mounting" subvolumes on btrfs as
> quick hack to overcome it.
>
> On Legacy BIOS having two copy of core.img even more involved as it
> likely really needs some primitive filesystem to manage multiple
> copies.

GRUB Is just too complicated. i'd really like to see it simplified and
for sure no longer depend on os-prober. When distributions are
considering things like petiboot, and linux as a bootloader,
something's gotten too complicated.


-- 
Chris Murphy
