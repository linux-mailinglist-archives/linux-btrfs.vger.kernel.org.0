Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC58D3305E9
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 03:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhCHCfP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 21:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhCHCfF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 21:35:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF367C06174A
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Mar 2021 18:34:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo2832720wmq.4
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Mar 2021 18:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCWFho1TGu6i+JeR9aj2kQeqYxeKLVfTf6jzdqZNe/A=;
        b=ioQExN4kfITcXOgiNrbDUPsc6uGA4cJIrEYcNRDzkMR1lKI7KW0+dF0vLO4y/8kaAD
         ndNSgmD44EYaqgJRYMgVqlKc3h4wjsRAYzLUZsOFF/NqdcFMWBdCtXXtW92qTwVb0WEu
         TyH8NKKT8OnO//4STsoMTMlIwR+I0Jr0SL9MfdTcPrp8P+aLtn4+7tU6lzx5XdvnkcE9
         q5rGF2Dpp65M82Ud3VK2RAAl1DkY6V6Piu1zkm1PludBbPI+yHn+jVlfy5Rn6p0nLpnD
         bYxrQm8Y/edPja8wOaR6Za78g2KAvHz4D6Is+A+VmeR3J+lGLndnKAxhO3l20V77Hu59
         l55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCWFho1TGu6i+JeR9aj2kQeqYxeKLVfTf6jzdqZNe/A=;
        b=kG8KV1xwYtxFoZ8RCtWsE7bpD7icweiWq116ZeLAhg5yHorNfb2FbpdpAJCmqY5zZg
         UffndpGMxsHHuiIs3JzwkozE7aNDWWTiXvv+R3ua0/VncIf1NJHKPn6CZtRjC4k1qWUj
         J+RA4cP4N+fuy8PLZ9hwd5d1smVppIqVYOh58DUzOzIqbNrk1tAV7rklDrzfGPRd61Ww
         jgT7PI7909aC64ZJFGArWkMEuIgv5IPsUt6vei0R0uI6MCfgQx5Unwxx+BHe8soThHbJ
         EXsD0EQePGKXr5hcfAFBt+7k9Xc6fTUuMfDUWRPLOQoL+fDLuH0mZJhdG/guLG+nmib2
         cV8A==
X-Gm-Message-State: AOAM5336UM6GIG4xueJpd1ceMOHnidNMC39oPW4zMKPeUZ1rM7Wu1zW9
        9Ka+2/hhuZhHyg47pDxv/GhF4pgQDmXP2NVGr0ZE9A==
X-Google-Smtp-Source: ABdhPJw7TVfuGWGX21kFW6CwKVQ5/SrBCCf5u/vttg8OdSVFhkl6+rq6Tgtcnt4imiScGwVkA5iJTo98vdN367hx+/4=
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr10596319wmq.11.1615170893347;
 Sun, 07 Mar 2021 18:34:53 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTn_O8grH5OBHoDfN7OfEOq5WM2Ryxffb-Z=qhVn_PLTg@mail.gmail.com>
 <CAJCQCtSZGGVamOUGRFzPXBejTW9Hx-2EkYUSCXdN6qEY3snW2w@mail.gmail.com>
 <YEV+hDZcguma9Pqg@burischnitzel.preining.info> <YEWJbxhR53O0PqaP@burischnitzel.preining.info>
In-Reply-To: <YEWJbxhR53O0PqaP@burischnitzel.preining.info>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 7 Mar 2021 19:34:37 -0700
Message-ID: <CAJCQCtRmQ115LStiWXp2ihe-v8bvM+mUirMkBYGgu9EzbWpXCw@mail.gmail.com>
Subject: Re: btrfs fails to mount on kernel 5.11.4 but works on 5.10.19
To:     Norbert Preining <norbert@preining.info>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 7, 2021 at 7:18 PM Norbert Preining <norbert@preining.info> wrote:
>
> Hi Chris,
>
> once more ..
>
> > > Does the initrd on this system contain?
> > >   /usr/lib/udev/rules.d/64-btrfs.rules
>
> No, it didn't.
>
> Now I added it, and with 64-btrfs.rules available in the initrd I still
> get the same error (see previous screenshot) :-(

I suspect something is wrong with devid 9 in that case. If it's a
dracut system, then it waits indefinitely for sysroot. You'll need to
boot with something like rd.break=pre-mount and see first if you can
mount normally to /sysroot, but if devid 9 is still missing then mount
degraded and replace that device. Or otherwise find out why it's
missing.

I don't think the scrub helps right now, the issue is the device is
missing. Where scrub does help is if the device reappears for normal
mount following previous degraded mount - the scrub is needed to get
the missing device caught up with the rest.


-- 
Chris Murphy
