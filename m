Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2168213BE6
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 May 2019 21:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfEDTPT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 May 2019 15:15:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34809 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfEDTPT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 May 2019 15:15:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id s7so2476863ljh.1
        for <linux-btrfs@vger.kernel.org>; Sat, 04 May 2019 12:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rq+Pcdgx1DKkN7ZN4tSPNWGRfjAesDa4W+qEJofxTas=;
        b=tUhEz2OL+aUVGm726Ke0782quz9cqLIKmb3mCQseTEplNAQ1RLR0p0h/lJSZL3h6Ft
         uKNZVzu5azP/JsSTw/3XSjcdTM95JoH5nmlagbpO18juDqMbX+Ra1cAM/j0ei7NZm6gp
         b/uw9zxRheDgcg+IFwcgw5BqgcE4Hz/Pd90yJG/Cpe7Ov+GB22epVdXWMgFaC2oeezaC
         8ftsha+6Ofer+dLyAHnEiVFe2BvytrRUiUn6lm7N4wHVBOC5bYCBL+BAAksZAgcMLmrt
         q5cgNDSvl1kd3uyyUCF69zGkooPkLQbg0E8DWInHwHJEMkHhNtsNKmN49nOTpnntjqbj
         tj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rq+Pcdgx1DKkN7ZN4tSPNWGRfjAesDa4W+qEJofxTas=;
        b=hLBdV3JLV4u/dtdPqGiZ7AnGPGfE9gwxzqTi5UN7Z86I/wOLmgCTQhncB4T/k3q7dL
         TEtuQKaddke3wgdeqh9IWggbpIskWu+MFrNEBxZCYROu+ulR3TkuUYV9v52QSIBtjj4/
         1Z8Y8u077YYM/1mJSVQj3h8f51PZ2fJ+Sg6TAWEbj6o8YwbDUM05/Z8lt/HvX6CLvk9G
         RQk4jDgg7nJkzXyf/8LMxoKxQGXWKwmJmfex1H21RjI0Q4hYIlKl1mnUhx9LuyaUam/T
         UMpUKvoBpzyYQYolAso1KQPvdAoxH1fJbwee5Wpfq3RLOwwXb6WWDouvo/9gpKJZ0iNI
         cznA==
X-Gm-Message-State: APjAAAW4uzn2v0qX+IVa32t0b0RoKf5PGoOwsVOLpxgXq8IOr+h84hAo
        d1J+I5JL6Oubs/ZmdjcpoaSswFqivwWiyLEo/BV6nA==
X-Google-Smtp-Source: APXvYqzI3+RtJVGpU1XIlBgVovA9qT3f5R5srTdN5nC19ZciegQg1T2AE4ZAQDg1cSCAkxqT2LLwJYC+pAh4VMoXvGo=
X-Received: by 2002:a2e:9e9a:: with SMTP id f26mr6884329ljk.170.1556997317602;
 Sat, 04 May 2019 12:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB5-iCfWD3NXuNHU+QVF4RWKptkzjyYwX_HteR1wshVV0Q@mail.gmail.com>
In-Reply-To: <CAGdWbB5-iCfWD3NXuNHU+QVF4RWKptkzjyYwX_HteR1wshVV0Q@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 4 May 2019 13:15:06 -0600
Message-ID: <CAJCQCtQdnnrkGGYVyQUCUWScXM=rej6R8B-x5eqReE8TonpmnQ@mail.gmail.com>
Subject: Re: ref mismatch / root not found in extent tree / backpointer
 mismatch / owner ref check failed
To:     Dave T <davestechshop@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 3, 2019 at 6:22 PM Dave T <davestechshop@gmail.com> wrote:
>
> The filesystem has become very, very slow. smartctl doesn't show any
> problems with the HDD. My usual btrfs maintenance (balance, scrub,
> defrag) did not show any problems -- but did not resolve the slowness.
> So I ran a btrfs check -- the result is pasted below. What causes this
> and is there any solution other than recreating the file system? Would
> the errors shown below make a btrfs filesystem slow?

Slow reads? Slow writes? What's the workload?

What kernel version? And what scheduler? e.g.

[root@flap ~]# cat /sys/block/nvme0n1/queue/scheduler
[none] mq-deadline
[root@flap ~]#



>
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/bak_luks
> UUID: 3ac770bc-e7c4-4792-2d2d-1d3ed19d126b
> [1/7] checking root items
> [2/7] checking extents
> ref mismatch on [374849568768 16384] extent item 0, found 1
> tree backref 374849568768 parent 6835 root 6835 not found in extent tree
> backpointer mismatch on [374849568768 16384]
> owner ref check failed [374849568768 16384]
> ref mismatch on [374940549120 16384] extent item 0, found 1
> tree backref 374940549120 parent 6835 root 6835 not found in extent tree
> backpointer mismatch on [374940549120 16384]
> owner ref check failed [374940549120 16384]
> ref mismatch on [569319473152 16384] extent item 0, found 1
> tree backref 569319473152 parent 6835 root 6835 not found in extent tree
> backpointer mismatch on [569319473152 16384]
> ref mismatch on [569329385472 16384] extent item 0, found 1
> tree backref 569329385472 parent 6835 root 6835 not found in extent tree
> backpointer mismatch on [569329385472 16384]
> ref mismatch on [569516376064 16384] extent item 0, found 1
> tree backref 569516376064 parent 6835 root 6835 not found in extent tree
> backpointer mismatch on [569516376064 16384]
> ref mismatch on [570749665280 16384] extent item 0, found 1
> tree backref 570749665280 parent 6835 root 6835 not found in extent tree
> backpointer mismatch on [570749665280 16384]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 3655790232414 bytes used, error(s) found
> total csum bytes: 3534402188
> total tree bytes: 46277705728
> total fs tree bytes: 34533392384
> total extent tree bytes: 7925743616
> btree space waste bytes: 8021706864
> file data blocks allocated: 30545889550336
>  referenced 31161532510208


Hopefully a developer has an idea how serious it is and whether it's
safe to try to use --repair. In the meantime, I strongly advice
ensuring your backups are up to date while you wait for a reply.
Extent tree problems can be serious.

Also, what do you get for:

# btrfs dev stats <dev or mountpoint>

If unmounted use device node, if mounted use the mountpoint.



-- 
Chris Murphy
