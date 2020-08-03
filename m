Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B80B239F6F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 08:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgHCGPy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 02:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHCGPy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Aug 2020 02:15:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41816C06174A
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Aug 2020 23:15:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f1so32473302wro.2
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Aug 2020 23:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DT5l/kWeEvd9AyzpCvAquGCHZ/tHN3vZxtKI6VeA+0=;
        b=Gw/7oUC+0p5lZrgn7pSNJbQZYSZl7YRjcXXHBQqd/nS+wsrIuf2VDGT+hznDft1Ayt
         yyVkFM8UtWUU/9jPANrKOKyurLhv/eOyjeC9UixLbyf6cn+UpriPXqTOsXCV7hbmRTkN
         UNoGpQaMWR8WOajkOBMefSD/KVHws/1+mr7CWIQxcEs2HEwQaV9R8LKyyc2TEG4f2gYe
         56+ERx5afCHRthqMwRPOJ93GksQwVj3qwB0KELAEKqHdaCeqS9p10/puCbxFe2x/Yk5s
         5yrqHLb+RYHBB7Nn+zCmZRuAphqwelO631bEu3oLYt7rmo9nPkhwj5L5xiJzBxjYCsRn
         KSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DT5l/kWeEvd9AyzpCvAquGCHZ/tHN3vZxtKI6VeA+0=;
        b=ZOpAv/oe45I+/+xKVmBOGzcB904wLpmFv07BO9zkpopPd8artOw2a+OzLcnsKobcM3
         3mKfyp5c7vwY2tAL+2eoiPTjO8/opHy1aGyB9y5qfLJnwLgI9V1+o7n5WqxsgX3o1vJI
         Ixa6TxpEBCDf/F0C/ucmXdthV98IJrdJ3+ATdV35XtdHEWiFxd8lIo62v+tdkvn7fgAf
         OySqk7uPSrszMb+PWVAN3jZGhOCgl+L580fjYzqVNBtJCqTpUMRB3sWA9hnFZtqjdte5
         /M/+ONlbnq+yfF0urvBjU22lFDPz03Yl0E0QQlJsgwuH0WAHkGU11toUl7nN6awuHS99
         cBPw==
X-Gm-Message-State: AOAM5319AbhOPovQK32hYOmKzjQNMKFNe0OdPr8kLCWcN2mpwLxwBzyn
        /NRIy0hUeFajFnwwEPmMphxdl/PHgHsb4KlWda/IqUThh5k=
X-Google-Smtp-Source: ABdhPJyFq9sIqzUzwZnrB1HFl2GjjRhpX2Dg3y4a2g9ZbBKud1xoby9o4k3k6FnX1VMKiGo9+YiON7yxwJwV2e3yiGY=
X-Received: by 2002:adf:eb89:: with SMTP id t9mr13376089wrn.65.1596435353016;
 Sun, 02 Aug 2020 23:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200803052651.GA685777@bulldog.preining.info>
In-Reply-To: <20200803052651.GA685777@bulldog.preining.info>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 3 Aug 2020 00:15:32 -0600
Message-ID: <CAJCQCtSeZCVpnxeip6D1nRb-nuvTYyJdY2SFWeDUQMV0BnAbyw@mail.gmail.com>
Subject: Re: replacing a disk in a btrfs multi disk array with raid10
To:     Norbert Preining <norbert@preining.info>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 2, 2020 at 11:51 PM Norbert Preining <norbert@preining.info> wrote:
>
> Hi all
>
> (please Cc)
>
> I am running Linux 5.7 or 5.8 on a btrfs array of 7 disks, with metadata
> and data both on raid1, which contains the complete system.
> (btrfs balance start -dconvert=raid1 -mconvert=raid1 /)
>
> Although btrfs device stats / doesn't show any errors, SMART warns about
> one disk (reallocated sector count property) and I was pondering
> replacing the device.

Some of these are considered normal. I suggest making sure each
drive's SCT ERC value is less than the SCSI command timer. You want
the drive to give up on reading a sector before the kernel considers
the command "overdue" and does a link reset - losing the contents of
the command queue. Upon read error, the drive reports the sector LBA
so that Btrfs can automatically do a fixup.

More info here. It applies to mdadm, lvm, and Btrfs raid.
https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

Once you've done that, do a btrfs scrub.

>
> What is the currently suggested method given that I cannot plug in
> another disk into the computer, all slots are used up (thus a btrfs
> replace will not work as far as I understand).

btrfs replace will work whether the drive is present or not. It's just
safer to do it with the drive present because you don't have to mount
degraded.


> Do I need to:
> - shutdown
> - pysically replace disk
> - reboot into rescue system
> - mount in degraded mode
> - add the new device

Use 'btrfs replace'

> - resize the file system (new disk would be bigger)

Currently 'btrfs replace' does require a separate resize step. 'device
add' doesn't, resize is implied by the command.


> - start a new rebalancing
>         (for the rebalance, do I need to give the
>         same -dconvert=raid1 -mconvert=raid1 arguments?)

Not necessary. But it's worth checking 'btrfs fi us -T' and making
sure everything is raid1 as you expect.


-- 
Chris Murphy
