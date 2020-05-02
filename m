Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EE11C2327
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 07:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEBFBM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 01:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726058AbgEBFBL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 01:01:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F36EC061A0C
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 22:01:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s9so180322lfp.1
        for <linux-btrfs@vger.kernel.org>; Fri, 01 May 2020 22:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tT/Vy4B7qaNslTQscfoHOR35JRcZ9zwtO5MDs6ZmA9c=;
        b=vmt7CXN8gkENJbml4aFrQjgN1wDb/6cXjI+2u1x0s0M4QlcJvAo2k2Kv60jjrIAxW+
         Vvj2S6tS0qBWr/jK8fEaeLj9M+000H+1a0jP+BBO25bdcgqqAlSRKj88I3EQypCpianC
         Qc/Q9RI4b+pJyD3BThqF358i3g8EM/T/9JevtzgAFgJrch2Ew8WN/6ab9Y5SKMMBdMeD
         ED7WjdMvnbRKp7uNbyL5mmhE+Rdt0BJP/DqhgcjOt9R6N2m4pO1QInUJnkKuqvAvLPV7
         yqANLH++3R6IUS4BNe1mOrIKBAP9VXEe4BsBoejW98ZikYT3ugYimRKhbbE+T5RnGwwX
         WFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tT/Vy4B7qaNslTQscfoHOR35JRcZ9zwtO5MDs6ZmA9c=;
        b=pO5p8XaYOcUaVH+fVUOO5HenmSDFQzjfAbWkAol+UfpENuOHeEVBgP2seKBmjrmGtj
         tV8xBpHpDoaKFTIXvMCyot5X9AIhxbXGbpii0jCJP2C2QdZI/SRMXPj/VC55/qlx2PKP
         ooR3FNL3hdJpL0j5AYeKfZv4yQbjIC/5hZIosbBPEwseVE6grXr6UW1MdL/ZUjy7pmHk
         odBq5fWWvl0SYY+jxBSyZo5RY8gjeL7d/pfP7/zDtav3TAm8lmv3XAHWCEBde/cMHLCG
         CsCLdMHiZvHPn8oPdYOhy7NOIZo6Hu6LKx1Ax6IUYsy3Y9rtyvUaWH0jcUc3cR23Ca/2
         VYqw==
X-Gm-Message-State: AGi0Pubd0C4a50JsJQeEzTOWSZbIm8IBtBragymw50IosRfzQ+4xOcAN
        rGeNbYUU2VndWMrhqolXKhQ+xkMRbjJeL06O+Boh7A==
X-Google-Smtp-Source: APiQypImE+obSGjLS83cjShNnNdd498AV6IhgaynNZIgoprKhaqW9saf5TTJP2l9i3FI93/GeTqkYsWw7f85Z3J18VE=
X-Received: by 2002:a19:ee06:: with SMTP id g6mr4654970lfb.90.1588395669624;
 Fri, 01 May 2020 22:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <CAJCQCtQqdk3FAyc27PoyTXZkhcmvgDwt=oCR7Yw3yuqeOkr2oA@mail.gmail.com>
 <bfa161e9-7389-6a83-edee-2c3adbcc7bda@ka9q.net> <20200501024753.GE10769@hungrycats.org>
 <b2cd0c70-b955-197c-d68b-cf77e102690c@ka9q.net> <6F06C333-0C27-482A-9AE4-3C0123CC550A@dordea.net>
 <bc37ccb3-119e-24da-4852-56962c93fd2d@ka9q.net> <20200502041826.GH10769@hungrycats.org>
In-Reply-To: <20200502041826.GH10769@hungrycats.org>
From:   Phil Karn <karn@ka9q.net>
Date:   Fri, 1 May 2020 22:00:58 -0700
Message-ID: <CAMwB8mj+XtCG5bRZuS_2+x_9duNnsy=Zafz8KPusbLFVOvXbbA@mail.gmail.com>
Subject: Re: Extremely slow device removals
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Alexandru Dordea <alex@dordea.net>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> So even if you use 100% of a 256MB drive's on-board RAM as write cache, the following gigabytes of
> a large metadata update won't get much benefit from caching.  The drive
> will be stuck a quarter gigabyte behind the host, trying to catch up
> all the time.

Well, at least in theory the cache should still make the drive go
faster by reordering the writes to minimize seek and rotational
latency. Only the drive knows its own layout and latencies, so only
the drive can do this optimization. I suppose that for a long time you
can assume that writes to LBAs with large absolute differences would
be slower than writes to LBAs with small ones, but I'm not so sure
even that's true anymore. Especially with shingled drives (though my
drives are not shingled, and I know that's a whole other discussion).
In any event, only the drive knows for sure.

Oh, question about transaction queuing: can each transaction on the
queue consist of any number of LBAs as long as they're consecutive? I
am trying to figure out if 4Kn (4Kb native sectors) buys you anything
over I/O on a 512e drive in multiples of 8 properly aligned LBAs. If
each transaction can be of any number of LBAs, it's hard to see any
real benefit to 4Kn except that it saves 3 bits in the LBA number.
