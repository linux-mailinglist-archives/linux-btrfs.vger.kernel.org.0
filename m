Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68FAE171102
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 07:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgB0GaV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 01:30:21 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:51086 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgB0GaV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 01:30:21 -0500
Received: by mail-wm1-f53.google.com with SMTP id a5so2162965wmb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 22:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4J5yK7qh+zqeAdtbTC/NHYmorMn5wgf5+fS8b6H2Ye4=;
        b=WpEwb8zdVC2y26HsJ6aQbadCAa4BrG4U1QZrXdEpmI+z8iu7lH/yEc1BE6xCuaPB83
         uCEzjGehuwmXEMnbyqPm9BYHp1CkkyadZRlIovZEVf/hJCQFG8ZFFeiWkV3tH8epxOcs
         FpkIAnaVyPy0wTXyAqoiYrEzhlKxWsj7scQEaP4bzxa8YGvrOI2WbPmYRtoR+OnvsbuE
         iYJm1zOqLEAv5/tbP6E+yKK8FbtVRhHTseEEtVcF4sGYgYxnJTmhHimRb1ZYogKHMnu6
         BlUcaKB64zSQlK9RsDhCtcx3dBIOr07ofmPt8Odo+5jAJ2uwC5dXVnsgxCIh5IFmBs4n
         vf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4J5yK7qh+zqeAdtbTC/NHYmorMn5wgf5+fS8b6H2Ye4=;
        b=AxtGR7ZyEkZJK0G658lW7yJ0A61/tDleSYkW5KarB0CKtQziWEsZVSSFIZVULgs/ZS
         uF1uHyPEbwIsseNQy2VA/qSpFPa54zwqrZwcX/0LMNcx+bMILlKprJ7Mq+iuF47VVmZv
         W3OiPvpAVhef62GZudNXTeYkRvbRRK74Iyrr5wq1RiEy8fBI2pExnDMXbsaq/magLQT/
         1iej0IEZ32F0/A0FqSGhHL0n6GIMVMsSn0osb7BQWan2cGmWzUEgxw+AofXUHyqCU2pk
         zhuDsF4v9yRRqL6GlkB/Wd4WBk3C+8+WEQ5rjyf5s03KbkmbrcuH7XNmPwqY2OFCaFQU
         VTaA==
X-Gm-Message-State: APjAAAWgvH8dIlEmAIbRRcyKTQXaCrxzXEIaM7nffP0OCou0u99K0xQ4
        LB6T40iIkc2dzwfjlsxcmj3462vBVBZiQIBa57sk+Q==
X-Google-Smtp-Source: APXvYqzzPnMzmn3zwlEHGkxFAbqU+7mpmRAa1KBrnzSlfjJUCJ5yP26vtWPlG2VFbBmbec5tvjr9DAbbMacSN1tLr6c=
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr3307042wml.182.1582785019096;
 Wed, 26 Feb 2020 22:30:19 -0800 (PST)
MIME-Version: 1.0
References: <CADq=pg=g47zrfKiqGFUHOJg8=+bdSGQeawihKcVcp_BahzPT+Q@mail.gmail.com>
In-Reply-To: <CADq=pg=g47zrfKiqGFUHOJg8=+bdSGQeawihKcVcp_BahzPT+Q@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Feb 2020 23:30:03 -0700
Message-ID: <CAJCQCtR3r+nGU4pvRfZooAvDZemr2woWJQFDaMUZT4zMaSzQ7w@mail.gmail.com>
Subject: Re: corrupt leaf
To:     4e868df3 <4e868df3@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 26, 2020 at 11:00 PM 4e868df3 <4e868df3@gmail.com> wrote:
>
> I updated kernels recently and now am getting a corrupt leaf error.
> The drives decrypt and mount, and I can touch a file briefly until the
> mount switches over to read-only mode. Extended SMART tests show all 6
> of my drives have a healthy status. I have a backup of the data. The
> array is configured as RAID10. As the BTRFS filesystem remains
> accessible / read-only, I am able to take an additional backup. What
> is the best way to recover from this error?


>$ uname -a
>VM: Linux server0 5.5.6-arch1-1 #1 SMP PREEMPT Mon, 24 Feb 2020 12:20:16 +0000 x86_64 GNU/Linux
>proxmox: Linux pxe 4.15.18-26-pve #1 SMP PVE 4.15.18-54 (Sat, 15 Feb 2020 15:34:24 +0100) x86_64 GNU/Linux

Which kernel is reporting the errors?

> [   19.448971] BTRFS info (device dm-0): bdev /dev/mapper/luks0 errs: wr 13790, rd 387, flush 0, corrupt 3532, gen 578
> [   19.448977] BTRFS info (device dm-0): bdev /dev/mapper/luks5 errs: wr 13673, rd 207, flush 0, corrupt 3540, gen 705

Btrfs reports at mount time significant number of dropped writes, and
other issues for 2 of 6 drives. This are problems that have already
happened, the statistics are recorded in file system metadata. What's
the history that might explain this? Any power failures or crashes?
When was the last time it was scrubbed?

>[  130.415056] BTRFS error (device dm-0): block=2533706842112 read time tree block corruption detected

What happens after this line? File ends here.

What do you get for
btrfs check /dev/

This is readonly, and repair isn't recommended unless a dev advises
it. The check only needs to be run on one device.

-- 
Chris Murphy
