Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5401B10437C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 19:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfKTScX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 13:32:23 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:34189 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfKTScW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 13:32:22 -0500
Received: by mail-wr1-f48.google.com with SMTP id t2so1130228wrr.1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 10:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8P3tRMYhes0m0/6PnKOqx0x4rQzObOdHhTBu2kRR0o=;
        b=jyt94aHd7DhMux/33ytTsMwMmJltzlz26sLbbyPQ/BCyTvRrNGfyKnXQ4195FYERaz
         +LwUAeKjS48ML3WV7RAEh7ewD7f+pqI5GMr+CpTj9i5pWKg+utoYu+WQfEnqrt73/N+B
         62n+nXCpMmis43MxndFqY3o8gaKjKCZTjjtWR2YJ0FoSgEFILophcW010wGHCX5+KfVe
         wf7OhhvWp5YOFEXgKxoS3e135zvd1EE5j28Z6DZhxHPMINQXTgH7WyrRD26nvJ8/K+jA
         mxGRRIxbu4sKfixZzkcaxRmYlZXHv+NmsC95QCCc7dcyiTIyTj69wq3C/aeqd/ULBihg
         n6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8P3tRMYhes0m0/6PnKOqx0x4rQzObOdHhTBu2kRR0o=;
        b=sNfA/iemFRmfQue7IGoGrLGZaCr9BYvdopRl5JsmzN2DxbzoYKB49M5xg5XiPyafUv
         Z1UJOC16Ac9vn+yk5w1E4c9ZlwC+h7j44ibqEQbUZJhJW9h11LL8VbzYIEoyuUFCKd4F
         vJdbEQMA/xh8YaDzGoh/9/r+dUDvITkZcKWgKfBzhD81Bl2tlaFZvVsF6i82/VRrt82b
         piqiUoQAKIdLu4OqWS7wKNS+7cnmxk282pz0qBuNUwO0HRs9Ln6QiYMHW8hMdGfnD7wX
         xeSSFlsLIdwlJzGO1TIYnPum9JTKqGOqmu6fKAybI+x6XcvzH3t95nT2QyRSP9zfGcwn
         aQ4A==
X-Gm-Message-State: APjAAAUqx5aikRH7uu2JlYmuKPJ/70EUYyM/du0mfijyRfEWPnFsWg0v
        arbPK8Z0CkC6YTuAqzlQaVK4DMKKKMCgp28oc1NDeg==
X-Google-Smtp-Source: APXvYqzSP43NeDAyLWz/WHZQEcyFHdRYoF7/4crVJ91wNz6eCfRZQN7VENVS2i988JTXxGwynTj5m9BcaQU/h4vX7Rk=
X-Received: by 2002:adf:fd85:: with SMTP id d5mr5449895wrr.101.1574274740737;
 Wed, 20 Nov 2019 10:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20191112183425.GA1257@tik.uni-stuttgart.de> <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
In-Reply-To: <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 20 Nov 2019 11:32:04 -0700
Message-ID: <CAJCQCtRQwizZHPvMXYiZk4B370NrgdcDNeakL2-NscE07ObRWg@mail.gmail.com>
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     Christian Pernegger <pernegger@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 20, 2019 at 9:36 AM Christian Pernegger <pernegger@gmail.com> wrote:
>
> Hello,
>
> I've decided to go with a snapshot-based backup solution for our new
> Linux desktops -- thank you for the timely thread --, namely btrbk.
> A couple of subvolumes for different stuff, with hourly snapshots that
> regularly go to another machine. Brilliant in theory, less so in
> practice, because every time btrbk runs, the box'll freeze for a few
> seconds, as in, Firefox and LibreOffice, for instance, become entirely
> unresponsive, games hang and so on. (AFAICT, all it does is snapshot
> each subvolume and delete ones that are out of the retention period.)
>
> I'm aware that having many snapshots can impact performance of some
> operations, but I didn't think that "many" <= 200, "impact" = stop
> dead and "some operations" = light desktop use. These are decently
> specced, after all (Zen 2 8/12 core, 32 GB RAM, Samsung 970 Evo Plus).
> What I'm asking is, is this to be expected, does it just need tuning,
> is the hardware buggy, the kernel version (Ubuntu 18.04.3 HWE, their
> 5.0 series) a stinker, something else awry ...?


What are the mount options? And what's the workload immediate prior to
the snapshot? Or does it always happen no matter the workload?

I use Btrfs on a variety of hardware and storage devices, USB flash,
NVMe, hard drives, and a Samsung 940 EVO, and I can't say I experience
anything like a freeze or hang. If I'm doing something like updates
(dnf updates, RPM) and do a snapshot while the update is happening
(bit kooky because that snapshot represents an inbetween state of the
update, essentially useless except as an intentionally poking things
with a stick just to see what happens) I do see a user space "hang" as
a flush is required as part of the snapshot, and I see this flush
using top. But so far I only see it affect the snapshot command itself
(it's a delay rather than a hang). I don't see it affect GUI
responsiveness.

-- 
Chris Murphy
