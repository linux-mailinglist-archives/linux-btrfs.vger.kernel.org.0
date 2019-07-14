Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1362067FE7
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2019 17:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbfGNPkp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jul 2019 11:40:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32977 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfGNPkp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jul 2019 11:40:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so12536636wme.0
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2019 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8Stp6K1aTts0vtvDuwPQ5RlnYT4XVSbp9rYnUBvyww=;
        b=bl3vVWENZjF8tDp1ex3/jTM9oKXLqLw5F9dKtkvQWW2AUS1CYbKd99bIfkGYaYV+nA
         IAJ28JI2z5oP7rL/Xy9EGTisDu1pqlL2axgq320KjDkgumdt+mk+J9cxwV8ZFNgf3nBi
         Q2zHUqvsAfa0n6Xbe1Q3mvIGM1eBAu9fFFsb328h29n1dL4dqFIo+eZyjO/nGaJJojGV
         4CQcwnuY/Mw5zQiYKeAnjGYJw0dqwSQyAFJRLOxvb7R8lvDGRmw+f+pudGxy250dBe03
         dSdsmyuZwt4zT+yVgYTHbbhB+q62twGDJ8olhO5VWZcEa0tCOM90IDD7VzA8zPJrcp4a
         lX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8Stp6K1aTts0vtvDuwPQ5RlnYT4XVSbp9rYnUBvyww=;
        b=XNG3bd5DL+RRRK5w9KGeDoNVXeSP0OE102s3TBLjAKqHgqOlnNy88QGYsXI0YHLdV3
         hj/FHIJcso8N64l3XvjyeFERNho1F03XTw6bZJEAyQmgdNscOXIIen3WKa7ogFL2EY3y
         j3TQanujOtfkFvw2I2va5YghO5/yHH0+3xi10g/GYvfd4+aV8Wi2WTq3nms9VhAXvWJw
         YZH4xsYWrBFr9GNpVEizjnbGplKXasPVwVS0o4JNGlI9NtSuMNAaNOPsa/MetNKKCqPz
         H8NS5rcAU5votpnbACU82a52gEuLxcZARdEFLiciTTi278Q+SMYB2T6TXhNvN7Gc64d7
         k7rg==
X-Gm-Message-State: APjAAAXFUORZJp5VQo1NeCohdGgXMoYEnpt2d60Ipcq/ReA7AHMpblnE
        xU+qBGbkR7RUctGLIA25Xe8jl5S2DmMsS+u1vx4=
X-Google-Smtp-Source: APXvYqzbg5+pdwVX0rZvclgTljkjmhiHawgFjJYizgEPf2SG1n88cbjggErWp46O6hxOoNe2dOe0FxAwmCjp8wG/Z0A=
X-Received: by 2002:a1c:2c41:: with SMTP id s62mr19766545wms.8.1563118843433;
 Sun, 14 Jul 2019 08:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de> <23f33860-9630-2045-483c-f59ebf91b043@gmx.com>
 <057a7561-f691-d7ee-1dea-27acc5ea79cc@web.de> <6e764f38-a8dd-19e2-e885-3d7561479681@gmx.com>
In-Reply-To: <6e764f38-a8dd-19e2-e885-3d7561479681@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 14 Jul 2019 09:40:32 -0600
Message-ID: <CAJCQCtTNrF-Oj_WQ71_ApRRpVikwdG7mYW4iiz2iA+N1AAWkmQ@mail.gmail.com>
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Alexander Wetzel <alexander.wetzel@web.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 14, 2019 at 3:49 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> I totally understand that the solution I'm going to provide sounds
> aweful, but I'd recommend to use a newer enough kernel but without that
> check, to copy all the data to another btrfs fs.
>
> It could be more safe than waiting for a btrfs check to repair it.

Does the problem affect all trees? If so, then merely creating new
subvolumes, and then 'cp -a --relink oldsubvol newsubvol', and then
delete old subvolumes, won't fix it.

I wonder where the ideas are for online or even out of band fsck.
Offline fsck is too slow and does not scale, a known problem. And both
copying old file system to new file system; as well as restoring
backups to a new file system, is astronomically slower because data
must also be copied, not just metadata. Also a known problem.

What about a variation on btrfs send/receive with --no-data option, to
read out all the old metadata and rewrite all new metadata to the same
file system, taking advantage of COW, but without having to copy out
the data? And then after all of that is done, delete the old file
subvolumes?

Or a variation on seed/sprout, without requiring additional devices.
The seed part "snapshots" the whole original file system (all trees),
and create two read-write file systems: current online mounted volume,
and in-progress offline repair volume. If the repair fails, it's
straightforward to clean up everything while retaining the changes -
at least it's not worse off. If the repair succeeds, then there'd need
to be some means of merging the two read-write file systems - that
could be complicated. But even if in the short term that merge
required an unmount, and perform the merge offline, that would be way
more tolerable than the way things are now.


-- 
Chris Murphy
