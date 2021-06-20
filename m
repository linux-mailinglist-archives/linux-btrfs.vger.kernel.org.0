Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D7F3AE0C3
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jun 2021 23:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFTVvT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 17:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhFTVvR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 17:51:17 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315EFC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 14:49:03 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id j184so25604541qkd.6
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 14:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYIo4PECCKteC47LbdSZxfNF3sAviSnrS+VwkbUAnKs=;
        b=qGdi9oA0kUwK4Jc0y7445n+p//eCQg1J5Mu+FRlvKb3wNgiUzsOPaFbVaGPCYTyMKj
         iTsphTUkPYO3Bq8WOsl7SOPfpQI+uNVWEB3OaSlFpN9SFTJT2Z64b8IFrUyc7qPl4Afv
         JyJmNVZJLpOdGBEeM+1kTG1+kl7yMQjFo4lX4ksAni+i6f4X3BrcpVUd7ElrRnMc23ST
         jHChpTXmyQTu/oX0opGnzPrjOwOSMJK2sAJ6/lSX9No8v5an4DWUunqflZGnFJYit2MA
         Lv04/9cYcuET0a3WCUIi9TrBhqc22kvK7yOHHnIFFb1ikyGI/iLlZwHT9DeNGBiSzeDY
         zupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYIo4PECCKteC47LbdSZxfNF3sAviSnrS+VwkbUAnKs=;
        b=aFOh3fDA+vJuktXPNCrhD3h7PqoecxLKAx8WwEt3BzlBxL5DIUdT75dv8GZ42UZwhY
         kn7Xizi/u5/QuIiwpZYunvXu0Vucy9b7QtBEuQef5VV4/+ukHEOqplvY0vE+4Gy008ee
         dK0y9QW9hPMwV4PzkRnaKmyK2lC88qHUSS/Sj4fRNyLrTntNhtHmR7LHRVSiSWfwA53E
         HtRNn629vBn5JDe58mwVeJU8BfONEBAqxRW64EbbkSuCXawYD2whC3d6Qc9VN7jeWJHT
         FfAX4bSCT2zYtuMembF5hVoUNoizzOBE4ScCAy2t5VDZDaYzfO2dLVi1EjAIN3d/SOr/
         DaLA==
X-Gm-Message-State: AOAM530nEG2mXo5hoX3BFxFrmUw5pBcQlzWzTHkNx/HMg37WfGe721tC
        Wewo+EcTkF4K+o5Wyn2EYvbAD0d5ZGi1RrTNX3I=
X-Google-Smtp-Source: ABdhPJz9HoDoANUqiWPZGm4effnW9eKFXxRrIPycnRivJh/S1S8gmKaGiLBo5DTnQoADl7VBfmRnyQmFi1tfQ8UHiDA=
X-Received: by 2002:a25:8111:: with SMTP id o17mr27062030ybk.244.1624225742281;
 Sun, 20 Jun 2021 14:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAEEhgEss-SusbDdw1qz-7hB3SbQyWhkYNkVLHdQuE+NhMXe27A@mail.gmail.com>
 <CAJCQCtTHu=ZQ92Y9g9MrUewCSK190dDB0hEa+yxAO7r6aHCzSg@mail.gmail.com>
In-Reply-To: <CAJCQCtTHu=ZQ92Y9g9MrUewCSK190dDB0hEa+yxAO7r6aHCzSg@mail.gmail.com>
From:   Nathan Dehnel <ncdehnel@gmail.com>
Date:   Sun, 20 Jun 2021 21:48:51 +0000
Message-ID: <CAEEhgEvGSk870yzCFZorcyvSBfCa-bRR8sE+0UmgxpGBYn+5gg@mail.gmail.com>
Subject: Re: Recover from "couldn't read tree root"?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>I suggest searching logs since the last time this file system was
working, because the above error is indicating a problem that's
already happened and what we need to know is what happened, if
possible. Something like this:

>journalctl --since=-5d -k -o short-monotonic --no-hostname | grep
"Linux version\| ata\|bcache\|Btrfs\|BTRFS\|] hd\| scsi\| sd\| sdhci\|
mmc\| nvme\| usb\| vd"

Unfortunately I put my journal logs in a different subvolume so they
wouldn't bloat my snapshots so they weren't included in my backups.

>So I'm gonna guess a single shared SSD, which is a single point of failure, and
it's spitting out garbage or zeros.
It's 2 SSDs in mdraid RAID10.

>But I'm not even close to a bcache expert so you might want to ask bcache developers how to figure out
what state bcache is in and whether and how to safely decouple it from
the backing drives so that you can engage in recovery attempts.
They didn't respond the last couple of times I've asked a question on
their irc or mailing list.

On Sun, Jun 20, 2021 at 9:19 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sun, Jun 20, 2021 at 2:38 PM Nathan Dehnel <ncdehnel@gmail.com> wrote:
> >
> > A machine failed to boot, so I tried to mount its root partition from
> > systemrescuecd, which failed:
> >
> > [ 5404.240019] BTRFS info (device bcache3): disk space caching is enabled
> > [ 5404.240022] BTRFS info (device bcache3): has skinny extents
> > [ 5404.243195] BTRFS error (device bcache3): parent transid verify
> > failed on 3004631449600 wanted 1420882 found 1420435
> > [ 5404.243279] BTRFS error (device bcache3): parent transid verify
> > failed on 3004631449600 wanted 1420882 found 1420435
> > [ 5404.243362] BTRFS error (device bcache3): parent transid verify
> > failed on 3004631449600 wanted 1420882 found 1420435
> > [ 5404.243432] BTRFS error (device bcache3): parent transid verify
> > failed on 3004631449600 wanted 1420882 found 1420435
> > [ 5404.243435] BTRFS warning (device bcache3): couldn't read tree root
> > [ 5404.244114] BTRFS error (device bcache3): open_ctree failed
>
> This is generally bad, and means some lower layer did something wrong,
> such as getting write order incorrect, i.e. failing to properly honor
> flush/fua. Recovery can be difficult and take a while.
> https://btrfs.wiki.kernel.org/index.php/Problem_FAQ#parent_transid_verify_failed
>
> I suggest searching logs since the last time this file system was
> working, because the above error is indicating a problem that's
> already happened and what we need to know is what happened, if
> possible. Something like this:
>
> journalctl --since=-5d -k -o short-monotonic --no-hostname | grep
> "Linux version\| ata\|bcache\|Btrfs\|BTRFS\|] hd\| scsi\| sd\| sdhci\|
> mmc\| nvme\| usb\| vd"
>
>
>
> > btrfs rescue super-recover -v /dev/bcache0 returned this:
> >
> > parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> > parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> > parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> > parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> > parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> > Ignoring transid failure
> > ERROR: could not setup extent tree
> > Failed to recover bad superblocks
>
> OK something is really wrong if you're not able to see a single
> superblock on any of the bcache devices. Every member device has  3
> super blocks, given the sizes you've provided. For there to not be a
> single one is a spectacular failure as if the bcache cache device
> isn't returning correct information for any of them. So I'm gonna
> guess a single shared SSD, which is a single point of failure, and
> it's spitting out garbage or zeros. But I'm not even close to a bcache
> expert so you might want to ask bcache developers how to figure out
> what state bcache is in and whether and how to safely decouple it from
> the backing drives so that you can engage in recovery attempts.
>
> If bcache mode is write through, there's a chance the backing drives
> have valid btrfs metadata, and it's just that on read the SSD is
> returning bogus information.
>
>
>
>
>
> --
> Chris Murphy
