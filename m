Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA16731B2CC
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Feb 2021 22:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhBNVe3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Feb 2021 16:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhBNVe2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Feb 2021 16:34:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F895C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 13:33:48 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id w4so4466007wmi.4
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 13:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lXVNgA57t/fbzIyzm+JAUbA0yotiHPWSKIkQLk4HaEE=;
        b=uIqoPU98JpyPtyiYK22dTcV/T4vtiepqGK3BFl7z9JPbQlhJD2VyiL/PwAj8LBiQbA
         W67o84Rq/6xYuXDNxRFywymHViE3MSF19erDFbOB4yR+zqphUHNFLkCdD3NiZ5rtf27Y
         TgQ+QE7pMudOfCEiud2md2chbbCKQSBsQZ4IlwE1juEE7f8+Zl/TqzvAgVLnsJXQstJZ
         KOLl0O0fZ6ApuvQx2Rt27G8tc89jPXbGgy9IKemVJmo31v94GDBBe05yEx1Rf72N2QYz
         oaejIUmBASsbJXxPJhmVgl7qVpgd4hWCqgdA69uuV0sg/tsfoCexy7A4vY6AIMznsmu5
         CAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXVNgA57t/fbzIyzm+JAUbA0yotiHPWSKIkQLk4HaEE=;
        b=oMxcNqNfH7dbsR3AyVadCp7etjL1mRRZKKU/UOpJwnJNIPDQ0d0/rUr8VeNP3Rt0vF
         FtkMk94raeYAEKeQe1diTUCB8HF0DnDgP+3G4tu5lO55gr4WF5Vbso0y4OGePOf3YTdc
         Bm9aPKg7hcxOPI8w1m/lFPcH3ZRA22O4LKJz9KwOyjVJ6jQ7ej7eCzYeX85nrox9il/D
         mpZzJ+stpDwgKUOf1M/jND8fc3jt8K9NiNVdHnW1PrytbCQrM6LJz6yxdXBaJLcX4ypO
         JZb4TxoqBJGl484LErERmwwtpFMEo6iAIn9+wRg5kVlXovC2lKRAWj0ijqtvxDaYzwZZ
         bjvg==
X-Gm-Message-State: AOAM530mvGpcchXk9TeqB0qok8Tq6Yad2YfLOcWB7vukpZiC6li2VA7n
        h1rRZcGEG2x4QpZ5wN0bYeTxv6bPnsin2P4hvb/0hyIWu6Xw77A5
X-Google-Smtp-Source: ABdhPJy0rnXTa8M3QcK++aHe0wHUaO67zjZTZ/Qj8MJ2rdz7LTS8mdJ8p5sB1DjcNIUVnkIDhdUeGL3WDX8h805pA08=
X-Received: by 2002:a7b:c304:: with SMTP id k4mr11473608wmj.11.1613338427170;
 Sun, 14 Feb 2021 13:33:47 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
In-Reply-To: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 14 Feb 2021 14:33:31 -0700
Message-ID: <CAJCQCtQ0NgehOFhJvmBinpymZvCPfWH6Byj_rFDLLygAi+kA5Q@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 14, 2021 at 1:29 PM Neal Gompa <ngompa13@gmail.com> wrote:

> > Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
> > Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has skinny extents
> > Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
> > Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
> > Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
> > Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
> > Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
> > Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
>
> I've tried to do -o recovery,ro mount and get the same issue. I can't
> seem to find any reasonably good information on how to do recovery in
> this scenario, even to just recover enough to copy data off.
>
> I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'm
> using btrfs-progs v5.10.
>
> Can anyone help?

>has 888896 expect [0, 888895]

Off by one error. I haven't previously seen this with 'invalid inode
transid'. There's an old kernel bug (long since fixed) that can inject
garbage into the inode transid but that's not what's going on here.

What do you get for:
btrfs check --readonly

In the meantime, it might be worth trying 5.11-rc7 or rc8 with the new
'ro,rescue=all' mount option and see if it can skip over this kind of
problem. The "parent transid verify failed" are pretty serious, again
not the same thing here. But I'm not sure how resilient repair is for
either off by one errors, or bitflips still.


--
Chris Murphy
