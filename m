Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3E2109834
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 05:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKZEFk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 23:05:40 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:34167 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfKZEFk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 23:05:40 -0500
Received: by mail-wr1-f48.google.com with SMTP id t2so20716177wrr.1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 20:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=zAgjLTevnkBCvaBiSJr5VrWXd5jJXG0Y6KVbAHal7rQ=;
        b=l1g81pFWvQVAttvEbAae+Tg1x9bw9+0WXQ1cKSapQVq4iMhMco3+2aDAo2uolz+Umk
         SjHKj6pH9OGquRTCUsSDMfchD/SYz8Pwv553vYgYiipqwCsS5PpSUIey4YYg1nTPzcDH
         xViFtX/3oDBhi/VGKjadSPuh3rJKFrZ/+iM6/vB22QUsU+WIO2CXGuA6Z9v+OQmVdrSY
         Xtx4H4TFi9YUxSwQuBCjl/3l8ZHUWKKJqJ+K046rVG/KG7GA9kwV+epglt8IzCKifku0
         aWMEOOMDXKBRabZ/o8IX02W1y81LzMm9SbL8+nk9XAfXuQO11R+dAmY/PSmDz5sGxAMb
         0Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zAgjLTevnkBCvaBiSJr5VrWXd5jJXG0Y6KVbAHal7rQ=;
        b=Be4uemgjY4/VguxzeXt2mb+qMw1RM3QaoAqhpL5FcUgIkqg7OC3sAcJBPqn3sC0mwh
         RP2uAfHTLh7cAGXwZVAlJd2g7kYi3xfAgR7IvwxnKwpc/ehEZ2VuKoB6Xoc7b0nECaJn
         Xo8X31Z8rYSHGiGrzHtp8htLszGNGfyp0dN2irJBQrrVMA46q3vDtZPN5E5Q0cabiprp
         LujRZOjswmCS/wlcf+kRpMyhKokRFL6MDUUjpuRc6nJA3x1aCNvHuW5DH9my7m1QcwHp
         2N1kNUwTigwqd51hmPLUjCdbTiaPJYJKG6zbeIIniOFID2hcs8cHPTqEjYiNmK4GhfaH
         gbQQ==
X-Gm-Message-State: APjAAAXtAE9ORaCdG8FTdaTfN4kO94a/IUm3s/8C/WYKH7CuZESLn2QA
        o/KkMUDm33vqVWNWmHHwGBVokSbUta2SUpF7NfF4h/5nskwP2Q==
X-Google-Smtp-Source: APXvYqwXb9D3on9GlkU4bROQNcXgFVVKNbORO+c0BrOHR99MRuD58ikmcqnb6z2tzur1Iz84Iw4MoKxzDPU5X29ZUTY=
X-Received: by 2002:adf:da52:: with SMTP id r18mr34876784wrl.167.1574741138198;
 Mon, 25 Nov 2019 20:05:38 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 25 Nov 2019 21:05:22 -0700
Message-ID: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
Subject: GRUB bug with Btrfs multiple devices
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

grub2-efi-x64-2.02-100.fc31.x86_64
kernel-5.3.13-300.fc31.x86_64

I've seen this before, so it isn't a regression in either of the above
versions. But I'm also not certain when the regression occurred,
because the last time I tested Btrfs multiple devices (specifically
data single profile), was years ago and I didn't run into this.

The gist to reproduce:
1. btrfs single device, single profile data, single profile metadata
2. device starts to run out of space; no problem 'btrfs device add
/dev/'  voila it works, reboots, keeps on working for a while, but
then...
3. install a kernel or two or three or four

I suspect that at some point kernels end up on the newly added device
due to new block groups eventually being created there, and GRUB
subsequently gets confused, starts spewing a bunch of error
information which I have to page through. Eventually it does find
everything and does boot. But it's kinda ugly and I'm not really sure
how to gather more information.

Shaky cam video of the boot is here:
https://photos.app.goo.gl/wvJbB6kBEFzNwogo6


-- 
Chris Murphy
