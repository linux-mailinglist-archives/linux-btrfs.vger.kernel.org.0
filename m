Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F621136E9
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 22:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfLDVJd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 16:09:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34946 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfLDVJd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 16:09:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id u8so1357943wmu.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 13:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wHQYSfFCO3cZAzHdSDXokXlIz4skAAp+ngfvD1TQXmY=;
        b=Bz3m++Qro8a0Wot9a3MCLVO5fR3fcFy1T1md7D+s8/mC94RF6Eut2ZWx31bRQyAf5A
         fH14xQRFqowCcvD17eG6RJ75tdXnAWrG3DA4g6wHEUH2X9SUvIfMGnxK44H9mdzA8pyT
         95BPuNzllnOZryxu229OGXHxfWltCrXezR6OB+QhEWMUoeLkjtzpxsdhocq7tcxWcr8/
         sd/lpg6RGofgdGJHnRvqOewQlgNKkH3u4bCJ1knTrQNxDeFwL9WTTPGnPo7FdciUjvc+
         hfuEbZqQyETDjjHXM9GEKUW/RABqfOi5fj5wg4iPwAhCUoGMUEf/cB4FEPQe5Rg03Nr2
         4zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHQYSfFCO3cZAzHdSDXokXlIz4skAAp+ngfvD1TQXmY=;
        b=elME8ICAIjH6ljUosfmnPI3rJM8I0gt8+I6zuSu84u665IpyAGO5gRkEbxCU2O8MrL
         dzf8cYgoYz7ntOrRa3bu8k0XFeKUwwi0CsIU0EaoaSQlCjN6fB6LjB7U0rk8F5jy/kHp
         7uCIXVbUoTLdw0Pz8qx3PtOwYwVSrnbqmTrtogMpCsBXe6kawd9u5qsBoTl5a83EgH6T
         9QcuiYk0a1tNx9+1+ltTcaTo0M4i+Rogc+t8JCpunMUpMbtPUTDcAyTYKHVlJSmOJWlj
         DCN2D2gFdfk8Hb/C22Vm0qhJ+GO+TpSWI5oZHY06nqRvWS1WY7WyTe7pcARWY240DPzA
         xq6g==
X-Gm-Message-State: APjAAAXJOnMFBflEFLzopQCbWCKz8+tZU93secUhJRYDxgzzBrdLLyeW
        6T8BtfUYeJWQgjlL6BErV6MoC3RDH7kC7yVGele4x+DCGGA=
X-Google-Smtp-Source: APXvYqzynMEH6+Gg5e4qm2lvrlPP90baiwgxGhcraddRl3QBqP5zCvwS/zTO1XtKSdZKgCoLxIm7pAAm5Lk00ORj23I=
X-Received: by 2002:a1c:4483:: with SMTP id r125mr1545793wma.97.1575493770986;
 Wed, 04 Dec 2019 13:09:30 -0800 (PST)
MIME-Version: 1.0
References: <7D7AA867-8B53-4CD5-83EF-95EABAD2A77C@megacandy.net>
 <F7C74BD8-4505-4E74-81F2-EB0D603ABCEC@megacandy.net> <CAJCQCtRA2+X-ke4yJ4H8o49ZA9mSOFabLpNeXd=4ULDg99rFgQ@mail.gmail.com>
 <B154F1B0-C80A-4E7E-B105-B0E654279E28@megacandy.net>
In-Reply-To: <B154F1B0-C80A-4E7E-B105-B0E654279E28@megacandy.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 4 Dec 2019 14:09:14 -0700
Message-ID: <CAJCQCtQW+-VyATVzi47vtBvN34Ev8j704tiQDVZKxHqT15qccw@mail.gmail.com>
Subject: Re: Unrecoverable corruption after loss of cache
To:     Gard Vaaler <gardv@megacandy.net>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 4, 2019 at 1:17 PM Gard Vaaler <gardv@megacandy.net> wrote:
>
> 4. des. 2019 kl. 20:08 skrev Chris Murphy <lists@colorremedies.com>:
> Why do you think it's complaining about the journal? I'm not seeing
> tree log related messages here.
>
>
> Thanks for the reply! That must be a misunderstanding on my part (it's called "transid", which suggested something in the journal to me).

Gotcha, yeah transid is just a way Btrfs keeps track of separate
commits over time. In effect the file system itself is the journal,
there is no separate dedicated journal on Btrfs like you see on ext4
or XFS. For fsync performance enhancement there is a log tree which
might be somewhat like a journal, which is what zero log is wiping
away. Pretty much on all file systems, it's best to allow log replay
to happen before zeroing it, and only zeroing it if there's a problem
reported about it, rather than as an early trouble shooting step.


>
> Is the output provided complete or are
> there additional messages?
>
>
> No, that's it.
>
> What do you get for:
>
> btrfs insp dump-s /dev/X

OK so no log tree, therefore not related.

>
>
> Attached.
>
> What kernel version was being used at the time of the first problem instance?
>
>
> Fedora's 5.2.8-300 kernel.

There's a decent chance this is the cause of the problem. That kernel
does not have the fix for this bug:
https://www.spinics.net/lists/stable-commits/msg129532.html
https://bugzilla.redhat.com/show_bug.cgi?id=1751901

As far as I'm aware the corruption isn't fixable. You might still be
able to mount the file system ro to get data out; if not then decent
chance you can extract data with btrfs restore, which is an offline
scraping tool, but it is a bit tedious to use.
https://btrfs.wiki.kernel.org/index.php/Restore

The real fix it to make a new Btrfs file system, and don't use kernels
5.2.0-5.2.14. Fedora 29, 30, 31 all are long since on 5.3.x series
kernels which do have this fix incorporated. But the fix found it's
way into 5.2.15 pretty soon after discovery so I'm gonna guess you've
got updates disabled and just got unlucky to get hit by this bug.


>
> The transid messages above suggest some kind of failure to actually
> commit what should have ended up on stable media. Also please provide:
>
> btrfs-find-root /dev/
>
>
> Attached (compressed).
>
> btrfs check --mode=lowmem /dev/
>
>
> Attached.
>
> The latter will take a while and since it is an offline check will
> need to be done in initramfs, or better from Live media which will
> make it easier to capture the output. I recommend btrfs-progs not
> older than 5.1.1 if possible. It is only for check, not with --repair,
> so the version matters somewhat less if it's not too old.
>
>
> As you can see, it terminates almost immediately with an IO error. However, there's no error in the dmesg on the underlying device, which makes me think there's a bad bounds check or something similar.



--
Chris Murphy
