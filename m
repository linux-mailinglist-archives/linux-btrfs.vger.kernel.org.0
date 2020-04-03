Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4968019E09B
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 00:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgDCWCV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 18:02:21 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37064 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgDCWCV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Apr 2020 18:02:21 -0400
Received: by mail-wr1-f51.google.com with SMTP id w10so10351002wrm.4
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Apr 2020 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7s7JuukcD6uB4Rsr9uH34gkWA5ucFMe4nU36/aMY5Y=;
        b=B4rPRNlOozDT4nDQl8l1Wydi5q1A3RPtA0dMTCmhESYcsK32CJIx7v5XUFVFHdaItG
         jbKq6YDFd7Wp887IZJXQdNO9HIb5k7ovnarTTt1ioWnoIsIzAICerpxcm2AwMRVCvssP
         6rl9mPE/36iw2eNGAgLoz7bn7LzGx/EgXywp64rRiWQ5dB1Y0EWqOop6gsRglt0aAg87
         fyav8HpB2kp7Oaly45C9SYcJAjbELAACUv7+MRri/ugE9rpKY5Km8zMoqEm9psNuOxVB
         CubjrSxDxZYemRL8pbkYod2JHacLpWwhyLFshaVO3PeCaRkSCTI2yYXs32gn5cfEuobU
         v1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7s7JuukcD6uB4Rsr9uH34gkWA5ucFMe4nU36/aMY5Y=;
        b=ix9IKUe7MHskXNRq5T62W+okXe8xNnlgRSm3W3dPX3WN8JefN1dP1HKYL8+1qFlIVl
         wRSJfsSJQLH2rDYlfTbAwUZgPtWN8dcc6YXWUZOZvf4WP1zNexVt1BWiXCU0to09PCKI
         D0DD3PAeKVkIZGlRJUO9OScpmJVSQlW7pJEbPl3mDF6XO7PU9ianU6ZUDEAVFPi4o7fk
         OVLAlSQdoiJS5AjMd9R2c5+6iMjnB8KDsn1+zu3d2ewOPnZ6QlknxVMu9d1k91bfRKH8
         Swfz7N6MAviRMy/OK5n7OQR6dLq5FctjWjZuoxO09vSRyyhrMwcZpVO0IAc/oULX07z5
         8/Nw==
X-Gm-Message-State: AGi0PubFwf88TLL7hmkbTb74djTC8758FSaLaHtNH73MFoJ1sWE5syVR
        ceh2WfMFu3kIEkQHqNShAPX7CaGv61KN4fJN8fmhiQ==
X-Google-Smtp-Source: APiQypImCihjcJumBx2R1sIQNVOWye7RbFw27upv/FDJHB30q1DkWwH9CXqijoZa5hRMTcEzm9vv14Y+TGqjoS2pP04=
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr10920579wrx.236.1585951337774;
 Fri, 03 Apr 2020 15:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <CANs+87QtdRhxx8gSsHzweMfbznJXLXRdn3SQDPd5uv-K-BZM=w@mail.gmail.com>
 <58f96768-79cb-89c4-7335-0db1d2976b59@cobb.uk.net> <CANs+87Tk=Havdiowgqt3NP6Q5VaJM4X6jVx0yXg+PidME1mT9w@mail.gmail.com>
In-Reply-To: <CANs+87Tk=Havdiowgqt3NP6Q5VaJM4X6jVx0yXg+PidME1mT9w@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 3 Apr 2020 16:02:01 -0600
Message-ID: <CAJCQCtQ8HySYrYRyuyNB3Gpc=qHPgj9W32=xF3tR7_-NH8LP+Q@mail.gmail.com>
Subject: Re: btrfs filesystem takes too long to mount, fails the first time it
 attempts during system boot
To:     Helper Son <helperson2000@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 2, 2020 at 8:36 PM Helper Son <helperson2000@gmail.com> wrote:

> Thanks for the suggestion, the main problem is fixed on my end. At
> this point I'm just wandering if taking this long to mount is normal
> behavior and if there is anything else I can do to reduce the time,
> but I suppose it's part of how btrfs works.

It's normal on large file systems. There is work in progress to make
this faster, but I'm not sure when it'll be merged. I think this does
some short cuts when reading the chunk and extent trees at mount time.

You could try switching to space_cache=v2 if you aren't already using
it. It's safe to do: mount -o remount,clear_cache,space_cache=v2.
Usually the rebuild goes fast, on 1T file system. Maybe it takes a
minute on a 20T file system? Just a guess. I can't estimate how much
it'll improve mount time, but it should somewhat at least.



--
Chris Murphy
