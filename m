Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D550E12750
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 07:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfECFwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 01:52:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33969 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECFwt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 May 2019 01:52:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id v18so1366604lfi.1
        for <linux-btrfs@vger.kernel.org>; Thu, 02 May 2019 22:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjAv4oi11KOeefKjFskPlLSCTLpzuA94sk9Q2EciqoI=;
        b=smjpCVvQ5nO4QX+coQLtrJ6OH6bTc+Rja332k287kmRO9ElCF4KSOjb11l5fIZz/ON
         17Kjlr3iT7w4P7Owc6dJmF7Q7O+fsxH7AMPDeHn2pHFmu+jXCtv9lMcJ3u7LfEXfrSYL
         NYIy0n4RBpcR9l6K/LCVeokSw4x2clZIzI5YXbxYfnxsOkYgn9T0qj0BxS7bzUxhNC4X
         UNfLTkgfUn44Mf0DIa6/wdPF/yoqwkoQ5lK0qZXuuo05LOS7cYthsCHWTfvkCUDAMdtd
         iltm7vu4frRV/wDU5uUr/yl70OnlQC/qkHt0+zBL64taJlvHknVPIygS3n7O+zV5DSJU
         ZNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjAv4oi11KOeefKjFskPlLSCTLpzuA94sk9Q2EciqoI=;
        b=sALRZq2E/eHXvab61W3CVAUyrFuj61+BZWUShaDAwbPkBLgeLmhQE3RLcusP6j9upg
         p/U628cQ/NoOqZCwU3pWtNWc8k0wV5ok0IROT/ysVqnGaW8h3Q3ees9A9SU2b3MifwTt
         sjFoa4f+2/tf2WbgNbgJ7m9nyCFISpaZuuQ6Gr3LRUdUWoi7MrzXplXaZeq4HTDAbxTP
         vOv9HlEoRKV4ddV6DKF/RxpY8X8EFhrYOEiZSlgyR+CYkgKgmitKCdsmI8ITcnMwa5mZ
         OD/N2fwESkhvJTdY77MQXvBSutxhY2rzyXmBy3lK6RwVGiD48APyNs8MF73cVq0AR3l4
         XmJw==
X-Gm-Message-State: APjAAAX3NjpsQf2WuLvYsr9Spm5PpoHJ4feiVHJRS9YqpVLDiIngo0Y5
        3KfCQ8WeXJ8lACpYD3kEfyYCwZ3BmcKgAOM9a+ymsA==
X-Google-Smtp-Source: APXvYqxBKMyFMWIfV4o0ZNrBJ9v3Omz3YdIIINahGDXsB2lnIJZ9XInDaS0Y2tZ3QDV1CgIbVlNSLtzeRLjUclcD3W4=
X-Received: by 2002:a19:4a04:: with SMTP id x4mr3958957lfa.124.1556862766841;
 Thu, 02 May 2019 22:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen>
In-Reply-To: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 2 May 2019 23:52:35 -0600
Message-ID: <CAJCQCtTCi3Qns_r=M0DtKjg00rTpVz_nLwNZ8bJaRL4e-ajXcw@mail.gmail.com>
Subject: Re: Re[2]: Rough (re)start with btrfs
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 2, 2019 at 1:02 PM Hendrik Friedel <hendrik@friedels.name> wrote:
>
> >What scheduler is being used for the drive?
> >
> ># cat /sys/block/<dev>/queue/scheduler
> [mq-deadline] none

At first I thought you might be running into this bug
https://lwn.net/Articles/774440/

However:

[Mo Apr 29 20:44:47 2019]       Not tainted 4.19.0-0.bpo.2-amd64 #1
Debian 4.19.16-1~bpo9+1

This is actually based on 4.19.16 which has the fix for that.


[Mo Apr 29 06:44:32 2019] systemd[1]: apt-daily-upgrade.timer: Adding
36min 35.299087s random time.
[Mo Apr 29 20:44:47 2019] INFO: task btrfs-transacti:10227 blocked for
more than 120 seconds.

Literally nothing for hours before the blocking. And I don't see
anything off during device discovery.

Qu would know better but usually developers ask for sysrq+w when
there's blocked tasks.
https://www.kernel.org/doc/html/v4.11/admin-guide/sysrq.html

Basically as root issue
# echo 1 >/proc/sys/kernel/sysrq
# echo w > /proc/sysrq-trigger

What I do is run the first command and type out the second command but
do not press return; in another shell reproduce the hang, and then go
back to the first shell and hit return. That way it doesn't take a
minute or two to type out during the hang. The result appears in
dmesg, so stop the operation causing the hang if possible and then
'dmesg>dmesg.txt' and attach it. Also, you'll want to reboot with
'log_bug_len=1M' because the sysrq+w that gets dumped to dmesg will
fill up the kernel message buffer.

> Done (also the two smartctl outputs).

I don't see anything weird there either. The errors are a little weird
but predate the Btrfs error by a lot.


> I was tempted to ask, whether this should be fixed. On the other hand, I am not even sure anything bad happened (except, well, the system -at least the copy- seemed to hang).

It could be a bug somewhere, but question is where. The workload is
only copy? Seems trivial and not prone to lock contention.

You know what? Try changing the scheduler from mq-deadline to none.
Change nothing else. Now try to reproduce. Let's see if it still
happens.

Also, what are the mount options?

-- 
Chris Murphy
