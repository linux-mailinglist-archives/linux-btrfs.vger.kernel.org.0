Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3933DBD759
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 06:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405101AbfIYE0B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 00:26:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45859 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390426AbfIYE0A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 00:26:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so3072090lff.12
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 21:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lHQObc8VQbZxMgaOaGLOQ4q6IzbV0SlnDKNnxpbc02Q=;
        b=bIxNLT99kIvN5HPLFXw1UjlrVdpMmTWo+I/ABAevMtPtgwSzWkP+LXwxchy6CfQrTv
         +NlhcFgiun2SIv6XzZ6dYscp0jt87pZnxpi52atsLDqov3oPYCLN47oeP4y1xdpnc7BT
         r2ynzSHo5OMSaYUmd1TUDnnoOWOHO2aeowq0NrZqPW8pzpWJVhf/IpKN7zhR0QKTDnnO
         OTztUpwJ/OK20e1YmbEkeH6CYwJIlp47Z3ilPyKGItRJ0ovvLdviS92OdSS77A4Q6ozh
         qbnffDDQttQ1jsojREoRqgZqiOUnSf4LFojv+F12fjjop8pL0V7ukYbDHA6iPbajZ3OA
         uMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lHQObc8VQbZxMgaOaGLOQ4q6IzbV0SlnDKNnxpbc02Q=;
        b=nYd7vkusVgf0+bGeMhvb6wOD6+MuycFxf7In9RGa2s0fbUlEhzGi0kdB+GZ01kGtm/
         VyXKVr+/6T1AfWSAIzRVLruom1IZBAGrPrr/I9HN18K3tOq/wVo3u4NEFQ+zfVz3n3CW
         Xk96AbROBb1s4BmIJumpuscW7vk1dXYfbqhaUdyBi4foHE+7G23oiLyWTZgNbBxfMAoy
         KYRym/DQwKWf7Yt5J4lhcCennB3mJnlYeZS1R3GdGRBJXlvSkzTN+R8kC0RDN54ZRy/b
         a2XMdD3Mvu62z2f07AWdX4KlMULYRJdcMfYVrJUOGyJfBP8wGDrvgyHL3/G8bkBOM9u1
         U2ww==
X-Gm-Message-State: APjAAAXjuIpXRy3v89OfmciMalprpkRnQ9ZdG43h7pEgKONCmPs4MXe8
        1F6o5540gyS0XD14b6Obxy71V2tvzw8BHmwz0abXDhXRjcdPuw==
X-Google-Smtp-Source: APXvYqxRPZ/E9ByoWAf+JkyFRtBMlRFq41eZ98ARx09/HuN66xw8YvnIyVy48PX0YyR50UmhN7+qqsH07fM6P+FRhew=
X-Received: by 2002:a05:6512:512:: with SMTP id o18mr4207711lfb.153.1569385558733;
 Tue, 24 Sep 2019 21:25:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:534c:0:0:0:0:0 with HTTP; Tue, 24 Sep 2019 21:25:58
 -0700 (PDT)
X-Originating-IP: [24.53.243.131]
In-Reply-To: <CAJCQCtQM_Pn4SubsJw9t0TjF8WNoqguxVf--UYH6K82Ch8Dm9Q@mail.gmail.com>
References: <CADyTPEwDifK+YA6-kh6F8Wpf9C0+acQjkxGBJhf1ATTpZbMSYg@mail.gmail.com>
 <CAJCQCtQM_Pn4SubsJw9t0TjF8WNoqguxVf--UYH6K82Ch8Dm9Q@mail.gmail.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Wed, 25 Sep 2019 04:25:58 +0000
Message-ID: <CADyTPEw=g7y+DroBt+CO-=8T3=8kO5Muj6Ts3LrkwDtKx2=zcQ@mail.gmail.com>
Subject: Re: Btrfs filesystem trashed after OOM scenario
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019, 18:34 Chris Murphy, <lists@colorremedies.com> wrote:
> On Tue, Sep 24, 2019 at 4:04 PM Nick Bowler <nbowler@draconx.ca> wrote:
> > - Running Linux 5.2.14, I pushed this system to OOM; the oom killer
> > ran and killed some userspace tasks.  At this point many of the
> > remaining tasks were stuck in uninterruptible sleeps.  Not really
> > worried, I turned the machine off and on again to just get everything
> > back to normal.  But I guess now that everything had gone horribly
> > wrong already at this point...
>
> Yeah the kernel oomkiller is pretty much only about kernel
> preservation, not user space preservation.

Indeed I am not bothered at all by needing to turn it off and on again
in this situation.  But filesystems being completely trashed is
another matter...

> > - Upon reboot, the system boots OK but now btrfs is throwing zillions
> > of checksum errors.  After some time the filesystem is remounted
> > readonly and I lose the ability to interact with the system at all, so
> > it gets powered off.
> >
> > - Now the filesystem is unmountable.
>
> The transid errors look like they might be caused by the 5.2 regression
>
> https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fdmanana@kernel.org/T/#u
>
> Fixed since 5.2.15 and 5.3.0.

Yikes, so my decision to update the latest kernel two weeks ago
perhaps was a very bad one.  Should've stuck with 4.19.y I guess.

> So if you're willing to blow shit up again, you can try to reproduce
> with one of those.

Well I could try but it sounds like this might be hard to reproduce...

> I was also doing oomkiller blow shit up tests a few weeks ago with
> these same problem kernels and never hit this bug, or any others. I
> also had to do a LOT of force power offs because the system just
> became totally wedged in and I had no way of estimating how long it
> would be for recovery so after 30 minutes I hit the power button. Many
> times. Zero corruptions. That's with a single Samsung 840 EVO in a
> laptop relegated to such testing.

Just a thought... the system was alive but I was able to briefly
inspect the situation and notice that tasks were blocked and
unkillable... until my shell hung too and then I was hosed.  But I
didn't hit the power button but rather rebooted with sysrq+e, sysrq+u,
sysrq+b.  Not sure if that makes a difference.

> Might be a different bug. Not sure. But also, this is with
>
> > [  347.551595] CPU: 3 PID: 1143 Comm: mount Not tainted 4.19.34-1-lts #1
>
> So I don't know how an older kernel will report on the problem caused
> by the 5.2 bug.

This is the kernel from systemrescuecd.  I can try taking a disk image
and mounting on another machine with a newer linux version.

Thanks,
  Nick
