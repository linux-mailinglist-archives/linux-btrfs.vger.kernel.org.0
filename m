Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC28E21C662
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jul 2020 23:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgGKVSp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jul 2020 17:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgGKVSp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jul 2020 17:18:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C15C08C5DD
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 14:18:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k6so9294410wrn.3
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sR+YI9uTDljOekHikoPs0Cykh4hZERul0Ibofayn3I=;
        b=GqxnMnomPbAWOU0LebWZkQ3lv7qONL6noLKpy+9SH8hebfFAI8bs2ZVATMhgFXyuAF
         wpCeOAyr7Qq4tokPzoVcuM9xF/aI2NWD/n+nHFABoNWa5gHdMFOJauw3i6FZRoGCCKp5
         u4W1b0q8YDfEbUD6crMQcdTPDa0vIGwpm//5SzmKlXKzoLC5agKvaY6BwqqZ4CB/cCCY
         45Gx9Eiy286xYjyqAWGie3c4ExNdZdFwl3KfWwwthPyV7QkS1DpYIqszGX2Ouiw2CrJf
         lIObt7ULmEU+In3Wg8IjNcL7ll2196F3bNVcyyd8OqKavAU0TTlrZWG4bLH/f/exoT9F
         BYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sR+YI9uTDljOekHikoPs0Cykh4hZERul0Ibofayn3I=;
        b=msn4fcwNInsTX2kZJjnCGLlKrCyaFUEdXHxSwv118Zv7VTVxx4TcEsSwJO0LKeudqi
         BEyMvc6IM5xMoqfabN+9MkNeit3y7VxBesBeYDf8HGGzP7e97EtK8kVZFEbODNIIF2BO
         Y9cxezd/vjNsj8RWovsZCh9wPCi3fP+bchcgxS0PlyIu2B/YHDQqJLXQlp/rmyHuP22X
         /izhi0TLiVeDyDEs2hl06aqhYzAAo3t6oxZctUv4+juUy89TL3yhFkWjmfpploAQRjEM
         O1Qluky03angBvJyHDBuymhIA3Fm9CeXFlxPrjMdmBUz8VVJOoJPTabez7tZ8Dbgwi56
         YBtQ==
X-Gm-Message-State: AOAM5301SMbTvU7Wynt+rWAqzS81SYe+LXrdV7TsBEvxxxsiGxsu/Vyc
        uL80ZAk632WcOHNaNHFFpj2/LTXWOsD+KSdp/2rKU233eoE=
X-Google-Smtp-Source: ABdhPJwzSJoxMZNTa90Q4KklyQe2XhQc47zYbCOx3w5qGUJqC+DlGzbHf1n+v66jjbGZIv+4XzjGBQm1zxzsAqfsVQk=
X-Received: by 2002:adf:fc90:: with SMTP id g16mr72593911wrr.42.1594502323698;
 Sat, 11 Jul 2020 14:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <933824829995390cef16f757cab1ddbc@jots.org>
In-Reply-To: <933824829995390cef16f757cab1ddbc@jots.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 11 Jul 2020 15:18:27 -0600
Message-ID: <CAJCQCtSbBCJjKcwuNB9b2ZZQWjkwxvBQpC0C7UWVsAjBAN6BgA@mail.gmail.com>
Subject: Re: Btrfs default on Fedora?
To:     "Ken D'Ambrosio" <ken@jots.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 11, 2020 at 12:44 PM Ken D'Ambrosio <ken@jots.org> wrote:

> * Swap files.  At least last time I checked, it was a PITA to take a
> snapshot of a volume that had a swapfile on it -- I wound up writing a
> wrapper that goes, does a swapoff, removes the file, creates the
> snapshot, and then re-creates the file.   Is this still "a thing"?  Or
> is there a way to work around that that isn't kludgey?

Put the swapfile in its own subvolume and don't snapshot it. One way
is to create a (nested) subvolume named "swap" inside of the "root"
subvolume created at installation time; use chattr +C on it; now
create the swapfile per 'man 5 btrfs'.

Since btrfs snapshots aren't recursive, making a snapshot of 'root'
will not cause a snapshot to be taken of 'swap' or its swapfiles.


> * When Stuff Goes Wrong(tm).  Again, my experience is not terribly
> current, but when things hit the fan, for most FSes, you do an
> fsck -y /path/to/dev
> and hope things come together.  But with btrfs, it seems that it's
> substantially more complicated to figure out what to do.  Have the
> tools, perhaps, been updated to help end users figure out what choices
> to make, etc., when dealing with an issue?

UX of the tools needs improvement. But for various reasons, it's
difficult to repair a Btrfs file system, so the emphasis is on taking
advantage of more tolerant read-only mount to freshen backups. Also,
stuff going wrong implies some sort of hardware/firmware problem, not
just Btrfs sensitivity to critical areas being damaged as a result.
The offline scrape tool is hard to use but really effective if you
stick with it.


>
> * RAID 5/6.  Last time I looked, that was in an unhappy state, so I just
> set up a RAID with mdadm, lay btrfs on top of that, and call it good.

That's fine. You don't get btrfs self healing, except for DUP
metadata. But you still get error detection, with path to damaged
file.

> That seems to do the job, though it loses lots of smarts that would be
> had with btrfs running the RAID.  I see discussion on the wiki
> (https://btrfs.wiki.kernel.org/index.php/RAID56) talking about an RFC
> submitted to address the underlying issues; is this still broken?

You should read Zygo's recent write up on raid5, most of which applies to raid6.

https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/

-- 
Chris Murphy
