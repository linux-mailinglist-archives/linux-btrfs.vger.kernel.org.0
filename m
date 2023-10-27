Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A707D998C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 15:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbjJ0NRo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 09:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345892AbjJ0NRj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 09:17:39 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BFFC4
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Oct 2023 06:17:29 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7788f513872so156171485a.1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Oct 2023 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1698412648; x=1699017448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfz2Bqs5iMW7RXtRSpeD8StEjBYEn/6IXOAwCBucGLc=;
        b=K1r8e1FeR7Q5UC+xd6wvRiPCgY832yvvN8W/S55POL8SshumYtf/OdUC/WH75XVDZX
         +501ktg9o9NDSw7qwq3I2UiIAFv5y66HZz6f71QOQuOtX4J9M6fII4/DZNvWbc2vUGRy
         GPjeSC1JhsnOaJGDlWwW2OGiiIcUMKCZOQyPTtiCO4fTTNC0JsK9MVdK0EYHPlys8SLP
         oOg0EWP+nIe0sRO67zXa9QgjuLLbo19HHWcEQ2jzZ6VpS4RmfQ+NihUQLKCIDSEmMqHR
         zaTJXR7G3C6G0HG1Jd0gUheMVMkbS+AVWrhZwP/TiEoMhclbHnMqiqJmsWtFxLsL0nZS
         hvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698412648; x=1699017448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfz2Bqs5iMW7RXtRSpeD8StEjBYEn/6IXOAwCBucGLc=;
        b=AqwCUbpZ+mJOIa1JYZmcvwwUuMJVqr9H+q7rGPCa+N2ZleG9o/dsLgdHDDtgxjH5L1
         6uiJeK74HcDmMG4tpvRrslvHh+HeB7jlxBEWrhu/0PUjjEX1faF+J4QMO7oSZrBfa8cp
         xtyYJLSdhFcbi0Q49P6BrXj/5WkA+4Y1NQcHjU/vf9yJ6N92bT752TeUU0i8HHbr6J0d
         qRqIZSeS4aP03ET/y9xQ0LN7wh9eRgFoV8++GQbuTsGpQ956OGR5vS+r7iXTz/ELtwEA
         kI26tz+MAjKJdVJ4Tsud+fwtIjvyK1hahq9s84Ty5N9yHlBPlyNX5GNUUyV99xXpS6bc
         vdrA==
X-Gm-Message-State: AOJu0YzEkxsazbka0PfdfMqK9abDRy5c4g42hKzush5GSyhCE4OdpmVb
        kqdhIcjKvYIlPyidhUV2BzfS8CWfrKi5bHuwbL8NXw==
X-Google-Smtp-Source: AGHT+IH7/ohkWLF0+aCKgnhC2MdbpmoBu18H1F3h/HjHu/1SCtZzSSZKky/PkY5gCI2oXZZwMFd3oA==
X-Received: by 2002:a05:620a:d8a:b0:778:8f9c:38e8 with SMTP id q10-20020a05620a0d8a00b007788f9c38e8mr2682344qkl.37.1698412648072;
        Fri, 27 Oct 2023 06:17:28 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bq14-20020a05620a468e00b0076c8fd39407sm521741qkb.113.2023.10.27.06.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:17:27 -0700 (PDT)
Date:   Fri, 27 Oct 2023 09:17:26 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231027131726.GA2915471@perftesting>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTtOmWEx5neNKkez@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 26, 2023 at 10:46:01PM -0700, Christoph Hellwig wrote:
> I think you're missing the point.  A bunch of statx fields might be
> useful, but they are not solving the problem.  What you need is
> a separate vfsmount per subvolume so that userspace sees when it
> is crossing into it.  We probably can't force this onto existing
> users, so it needs a mount, or even better on-disk option but without
> that we're not getting anywhere.
> 

We have this same discussion every time, and every time you stop responding
after I point out the problems with it.

A per-subvolume vfsmount means that /proc/mounts /proc/$PID/mountinfo becomes
insanely dumb.  I've got millions of machines in this fleet with thousands of
subvolumes.  One of our workloads fires up several containers per task and runs
multiple tasks per machine, so on the order of 10-20k subvolumes.

So now I've got thousands of entries in /proc/mounts, and literally every system
related tool parses /proc/mounts every 4 nanoseconds, now I'm significantly
contributing to global warming from the massive amount of CPU usage that is
burned parsing this stupid file.

Additionally, now you're ending up with potentially sensitive information being
leaked through /proc/mounts that you didn't expect to be leaked before.  I've
got users complaining to be me because "/home/john/twilight_fanfic" showed up in
their /proc/mounts.

And then there's the expiry thing.  Now they're just directories, reclaim works
like it works for anything else.  With auto mounts they have to expire at some
point, which makes them so much more heavier weight than we want to sign up for.
Who knows what sort of scalability issues we'll run into.

There were some internal related things that went wrong with this when I tried a
decade ago, I'm sure I could fix that by changing vfsmount, so I don't see that
as a real blocker, but it's not as straightforward as just doing it.

I have to support this file system in the real world, with real world stupidity
happening that I can't control.  I wholeheartedly agree that the statx fields
are not a direct fix, it's a comprimise.  It's a way forward to let the users
who care about the distinction be able to get the information they need to make
better decisions about what to do when they run into btrfs's weirdness.  It
doesn't solve the st_dev problem today, or even for a couple of years, but it
gives us a way to eventually change the st_dev thing.  Thanks,

Josef
