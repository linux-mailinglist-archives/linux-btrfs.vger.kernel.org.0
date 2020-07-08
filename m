Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF00218E54
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 19:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgGHRfN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 13:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgGHRfM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 13:35:12 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88746C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 10:35:12 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id h18so20846563qvl.3
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=o+0RLlVuYO7fawqbFu7Xpxqe7C2HHy8O4wxlqT/fuwI=;
        b=usG7yGQMZ0/hJ/g9ng2CnvuGjkM/vLdDYTBzXKb2xm1l/+Ul0nJOn2+gqWTR0FNwsZ
         jd75uKghNiqS2lRJYcv713eghvMYRiBLmXF2PdyPUCL/K+7AhVxgtGN50JSP9ValXqHp
         2owt4dN17Gd0cUYK88xJx7LVjo6sz5Ir2baBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=o+0RLlVuYO7fawqbFu7Xpxqe7C2HHy8O4wxlqT/fuwI=;
        b=suVJgUoIxftfXMuG1ua5OePNcwPr2j1CA3W4GbSt0RTFnEBFoo7q5SsnGgPqxq0VC4
         imd3MTOM0BmxpVVty8LycbmeN7dgROpkdGWCNQdma6XOWBFvwsIqx2mMijBbkDC+Xge0
         w1fGC46DrpoKMOJAs/icHnJ/yW8+Kx0xxkwNCuwqWqGrMRduip9GX7xQHaL7W6RMwvaK
         1dJG8V+SoJlXKPibS4Zu0/gUXMx23e/nx8iiYMTH4aUjR1FcMKQKUeYCre+DXhihpj4/
         s2LUOxPWiqfp5SMIqqgNnqq+DpTfgnsILsn+k/GWifGyOvl3huYBk3Siob7hZBlX1x+6
         HnEw==
X-Gm-Message-State: AOAM5339XAlLB7/J0SEOo6n/QOPVe+c2VKqYxW4DGJTnr1vfXQexjEsC
        g+sp/FqW5Q/wHFyh6BcqhPQ83l2sJO/ZIw==
X-Google-Smtp-Source: ABdhPJwXzrAHIGyfYkcZj6JuFQv4y0usGnB1KTNMafTlMpnUuYOJEbdNp7Ckr19Q0wnfOsDrSN0LjA==
X-Received: by 2002:a0c:d84d:: with SMTP id i13mr12306698qvj.167.1594229711619;
        Wed, 08 Jul 2020 10:35:11 -0700 (PDT)
Received: from saya.kepstin.ca (dhcp-108-168-127-144.cable.user.start.ca. [108.168.127.144])
        by smtp.gmail.com with ESMTPSA id 125sm528441qkg.88.2020.07.08.10.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 10:35:10 -0700 (PDT)
Message-ID: <96009f54f7548080513ab2100d420d82f50d4e90.camel@kepstin.ca>
Subject: Re: first mount(s) after unclean shutdown always fail, second
 attempt
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Marc Lehmann <schmorp@schmorp.de>, linux-btrfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 13:35:08 -0400
In-Reply-To: <20200702021815.GB6648@schmorp.de>
References: <20200702021815.GB6648@schmorp.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2020-07-02 at 04:18 +0200, Marc Lehmann wrote:
> 
> When the server is in this condition, then all btrfs filesystems on
> slow
> stores (regardless of whether they use dmcache or not) fail their
> first
> mount attempt(s) like this:
> 
>    [  173.243117] BTRFS info (device dm-7): has skinny extents
>    [  864.982108] BTRFS error (device dm-7): open_ctree failed
> 
> all the filesystems in question are mounted twice during normal
> boots,
> with diferent subvolumes, and systemd parallelises these mounts. This
> might
> play a role in these failures.
> 
> Simply trying to mount the filesystems again then (usually) succeeds
> with
> seemingly no issues, so these are spurious mount failures. These
> repeated
> mount attewmpts are also much faster, presumably because a lot of the
> data
> is already in memory.

You shared kernel logs, but it would be helpful to see the systemd
journal. One thing to note is that by default systemd has a timeout on
mounts! It's entirely possible that as soon as the mount kernel thread
becomes unblocked, it notices that systemd has sent a SIGTERM/SIGKILL
and aborts the mount.

See the documentation (man systemd.mount) and consider increasing or
disabling the timeout on the affected mount units.

-- 
Calvin Walton <calvin.walton@kepstin.ca>

