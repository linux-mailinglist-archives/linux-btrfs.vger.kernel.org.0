Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BECAF12CB1A
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2019 23:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfL2WHe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 17:07:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33698 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfL2WHe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 17:07:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so31260984wrq.0
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 14:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrxoF3ukpmupePobTwHvCt1HlLa4rku1CnYOz+BW58A=;
        b=yW8xPOLLYDz7BByfOE6GbqjpfDKOU9gIUzOIcIY1jmzbq6l3AQfw19bb5iDyuaK827
         MBJGTVqbezLGlH1uO2KoEMwrLpMYBnSg8c9LNxNODuaEmXAA6gBF0y/ksKoWRywS8nd1
         WyIiOeAj1rK7Nx+9vCs4dL7gH9/fkbYbWJhIpddh0fmTwYjfidh8j9C81ZHkoi0ZDD1r
         OG1l6mC6TmdSm6PYKIx/e5MhfBtzQZaWrCUozrP9O5esxD6q9DXMpfj9w+n2h/f2xmuv
         IS9jxNnbLe4HS3DximvroRE4EiaBPXigk0hKYi4bbGu+FbCrbsL4p+nqtErlJNClKpVK
         ePrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrxoF3ukpmupePobTwHvCt1HlLa4rku1CnYOz+BW58A=;
        b=Uvuc61mLivknMuOmP0mMwbJcOdkK9U+aNTpLZVOV4T6WV0EGSMcMgHHsqLygDuYcoz
         tuScXgcUeZkxcHIlu6E0ouGR2Tm5bBqPD70o8ADF1l874+U5C1o9Ix9rb2hqD8i2Z85m
         fgYI8n4Hw03r5Na6obBlNy+9MItTuI1CQ6KrSI7rW0zNs2dYvGGjJE/CMeMjpqcS/GNi
         bJlp6UDrDD74520AHAPxIwuMZLTVix9BT84CNuQzKMjVn0oFWsHhiGLNgk+Itmvu5oYE
         iz+lLbZO770NQL3ajf6Kc5ST8gPHm04uD9xTbu9BrCuwwRLvZV17VqA8B8Y8xpaaLv1F
         /dZw==
X-Gm-Message-State: APjAAAU04PjmjuNY7o9AGGDRUpGecNYU+pD6sVpcvQ0SvGwyIAssEKgp
        84n5OQP7f+oR3ZGIUMbxbqaXjJBIzKo44vYa2Svrou4u9mo=
X-Google-Smtp-Source: APXvYqzGNocIYdp9Ziuu/Rq0pxcc5hHAxajbEUwKioDLLMM1xnLoevGqDX9tdmcfmO2+5GV48S8Mo360CcUps8lvC2E=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr65094232wrn.101.1577657251826;
 Sun, 29 Dec 2019 14:07:31 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
In-Reply-To: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 29 Dec 2019 15:07:14 -0700
Message-ID: <CAJCQCtQwLrZxfc7xb8FpVcV9r9rpEpD0SRPebRtRpS5SPYM_3A@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Patrick Erley <pat-lkml@erley.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 29, 2019 at 1:44 PM Patrick Erley <pat-lkml@erley.org> wrote:
>
> On a system where I've been tinkering with linux-next for years, my /
> has got some errors.  When migrating from 5.1 to 5.2, I saw these
> errors, but just ignored them and went back to 5.1, and continued my
> tinkering.  Over the holidays, I decided to try to upgrade the kernel,
> saw the errors again, and decided to look into them, finding the
> tree-checker page on the kernel docs, and am writing this e-mail.
>
> My / does not contain anything sensitive or important, as /home and
> /usr/src are both subvolumes on a separate larger drive.
>
> btrfs fi show:
> Label: none  uuid: 815266d6-a8b9-4f63-a593-02fde178263f
> Total devices 2 FS bytes used 93.81GiB
> devid    1 size 115.12GiB used 115.11GiB path /dev/nvme0n1p2
> devid    3 size 115.12GiB used 115.11GiB path /dev/sda3
>
> Label: none  uuid: 4bd97711-b63c-40cb-bfa5-aa9c2868cf98
> Total devices 1 FS bytes used 536.48GiB
> devid    1 size 834.63GiB used 833.59GiB path /dev/sda5
>
> Booting a more recent kernel, I get spammed with:
> [    8.243899] BTRFS critical (device nvme0n1p2): corrupt leaf: root=5
> block=303629811712 slot=30 ino=5380870, invalid inode generation: has
> 13221446351398931016 expect [0, 2997884]
> [    8.243902] BTRFS error (device nvme0n1p2): block=303629811712 read
> time tree block corruption detected
>
> There are 6 corrupted inodes:
> cat dmesg.foo  | grep "BTRFS critical" | sed -re
> 's:.*block=([0-9]*).*ino=([0-9]+).*:\1 \2:' | sort | uniq
> 303629811712 5380870
> 303712501760 3277548
> 303861395456 5909140
> 304079065088 2228479
> 304573444096 3539224
> 305039556608 1442149
>
> and they all have the same value for the inode generation.  Before I
> reboot into a livecd and btrfs check --repair, is there anything
> interesting that a snapshot of the state would show?  I have 800gb
> unpartitioned on the nvme, so backing up before is already in the
> plans, and I could just as easily grab an image of the partitions
> while I'm at it.

I'm not certain whether btrfs check can fix these kinds of errors yet.
Can you use btrfs-progs v5.4 and just do a 'btrfs check' and also
again with 'btrfs check --mode=lowmem' ? I'm curious if either mode
sees the same problem the kernel tree checker sees.

-- 
Chris Murphy
