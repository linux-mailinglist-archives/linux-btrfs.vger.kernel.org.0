Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78F542BFEF
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 14:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhJMM3W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 08:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhJMM3W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 08:29:22 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C25C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 05:27:19 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id s64so5890741yba.11
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 05:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3GsBhG5rE6v1EyIgFG9yG5XQ4O3YvL/n0asZjSc6o8=;
        b=AX8BvPdmtqNXiE92Pkg0jPZBw3vWEVAwMX3oDoUQOMDPUJlkT84A0N0K5zHbmPjrN9
         dJzgqjFlw9Nv6h/+nFcH/QMveM9Xk3rHt1D+c3ihXTyAjXosvfQtALcNXd/Qy/wmQ1eo
         iaMjGXs/lV60k7+Su+UR6ehcIa7baSVOJtZ28HVn/9itwxm2QFNNcuj+IXE7fuJEzOT6
         lxiQll2Rjt8oK++eeZuZldmVceMAZfFBNGeDWDRPNAFiG85VY4/+W+xudKx4eVWT+lRu
         p2T7Y4uRX4xPPomBc+HFZrwp1cQgRFKt0oBgY2+QNOTNHgCofwwuINSrSQL1vAMFPQKw
         HIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3GsBhG5rE6v1EyIgFG9yG5XQ4O3YvL/n0asZjSc6o8=;
        b=i38RGFeoMuz2MzIlWqTbvarZTXPyfhOYnImvcIboRsiPLpXdsH29MgIV7gCjFOMvzW
         N+nKJRL46zZKjJCLB7XRnw4H3pn3kr9sPJREyU8qS3QYhLe46pr74/zlVuCmvxvL7X0z
         HjB8uxCSIaY3wY/5hZKIeC51bHW7/h07yscTN4D0W+BhCAF/lm8PPD0uMyvvO4pgLCMs
         8gO5ek3P/tI8TFXce97bJrj43MxiLIWimu9pSqaNKYYNe7kdN65Wq4AZMu72b9JGkB4t
         iq711aibv2yVLs7u1vfxWucNDQtvCQmOs5M0cVZ9mzGQX5CuBVpVs6u/ywFERjS/ZgnQ
         5YIA==
X-Gm-Message-State: AOAM531WQln9UTP6BE5GGlOcDB6wRtYK1lfmKqgycWDJQyUPU2ukcqry
        48mwvlllGI+QKWzp0MxBsVyY8EXZEJ7yNmwJmuEb0w==
X-Google-Smtp-Source: ABdhPJxC/h+4FhBm9Q2/U43RHokPyhrzAWNSc7cy0RGO+ZcsAs4sCSN1hRSTMOOOKwgB1XLBRWmJl66RbbIeIliI8tY=
X-Received: by 2002:a25:db49:: with SMTP id g70mr32177717ybf.341.1634128038527;
 Wed, 13 Oct 2021 05:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com> <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com> <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com>
In-Reply-To: <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 13 Oct 2021 08:27:02 -0400
Message-ID: <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Qu Wenruo <wqu@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 8:18 AM Qu Wenruo <wqu@suse.com> wrote:

> Sorry, it only needs the last the stack (submit_compressed_extents+0x38)
>
> The full command would looks like this:
>
> $ ./scripts/faddr2line fs/btrfs/btrfs.ko submit_compressed_extents+0x38

btrfs is built-in on Fedora kernels, so there's no btrfs.ko, when I do:

$ /usr/src/kernels/5.14.9-300.fc35.x86_64/scripts/faddr2line
/boot/vmlinuz-5.14.9-300.fc35.x86_64 submit_compressed_extents+0x38
readelf: /boot/vmlinuz-5.14.9-300.fc35.x86_64: Error: Not an ELF file
- it has the wrong magic bytes at the start
nm: /boot/vmlinuz-5.14.9-300.fc35.x86_64: no symbols
nm: /boot/vmlinuz-5.14.9-300.fc35.x86_64: no symbols
no match for submit_compressed_extents+0x38


> The modules needs to have debug info though.

CONFIG_BTRFS_DEBUG ?

Neither regular nor debug kernels have this set, we're only setting
CONFIG_BTRFS_ASSERT on debug kernels.


-- 
Chris Murphy
