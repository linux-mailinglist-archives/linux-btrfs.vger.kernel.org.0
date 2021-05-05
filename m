Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D65373D98
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 May 2021 16:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhEEOYm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 May 2021 10:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbhEEOYl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 May 2021 10:24:41 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79992C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  5 May 2021 07:23:44 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id j12so1870212ils.4
        for <linux-btrfs@vger.kernel.org>; Wed, 05 May 2021 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bObMeSVRUGZmftnP52HT14RKpUY5SjqVEgmi/QuGXWk=;
        b=diqAjy0bbH2AEUrUw8ch6f9pqTSmtsSeSIoTSNNBrP693HVXxrUexUKERXpKB0I9AH
         sumigdSmHmzvkghWI0hgY7wvN6WTbsun5MDceG8JG5tCSa6iPklYtn6YDfNZoAYs/DWh
         Ncp17MO2tPvJXAnIN2Ek1CxrLnQEvl/9IsP64MPMEPoYgnCrIVyhaXDCxlGsqbDMgafJ
         uIlkyK45WXQAWI5ubM4LbgqfRfbmO5bc8d6w29GEM/BQtOxA9sRldGbqNvhkJ8Mhy4ID
         cWGm6ei++Pl+Ew2G82R3t/6GbpE0aQxOm2UdnNB+CUJDkSWFgdG4OjDKldMrdsxkWMQw
         vVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bObMeSVRUGZmftnP52HT14RKpUY5SjqVEgmi/QuGXWk=;
        b=eJCthZQD9iih1RK3HEpEmEZqEO4fciBeacltJhqQ/5ocLSXMHwzD4MSNwR3K5Z+FlV
         zZB4LgN5K4ZQwAzlmhVHWnFA/4ozTWzicQN2itqJ0V5HQJZc/mlaYZ20yD83EdZoZn96
         nrtxZtYmoPydKG4wlo4PiAwIgk+Sy0Yt2IViuNS11WYxqLmOn139Yvz2GMpg/fEvBFcj
         OZrUIk8/tsaRviKPYBfoMqmi7/KrB1AsyuUG7Z5NG7Kbb1Yi8CDh0wX5lp1pTa6NH1VU
         SFyTUg+YgKvCKTpxO5CfY++koGvSjr9CtBjruznXp/aUZuiIGLGxAcsIG8ch9YTsYIyf
         FOeA==
X-Gm-Message-State: AOAM531ZBEo8dWP9Bc3SPyBb9XYbSr86+cULzvGWgJbKxMc5s7bjcoCE
        mWXBKBJOEIplBwwHPPTg4MSMTDPdkLmV0jzaADmKvE5z4fU=
X-Google-Smtp-Source: ABdhPJz94vLiYEzjN63Z5GsORfDbWSQImw5YWBD4iS2s4AEWKSiVGz5r7TqmGl3m0t31EobqR1+AYlnHtfGuRxhHJWg=
X-Received: by 2002:a92:b111:: with SMTP id t17mr26513133ilh.208.1620224623823;
 Wed, 05 May 2021 07:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <CADOXG6Fj3zCzu46q-nLKOdszxQHPGLk6r5rDn80KNLKY5sn3iQ@mail.gmail.com>
 <5b563f2f-9057-44cc-8ec8-5367548aef6f@www.fastmail.com>
In-Reply-To: <5b563f2f-9057-44cc-8ec8-5367548aef6f@www.fastmail.com>
From:   Abdulla Bubshait <darkstego@gmail.com>
Date:   Wed, 5 May 2021 10:23:33 -0400
Message-ID: <CADOXG6FZBh-=P=JB5DMdPxH63sG2BspY6oWO9KA5yqUaqFrGAw@mail.gmail.com>
Subject: Re: Array extremely unbalanced after convert to Raid5
To:     remi@georgianit.com
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 5, 2021 at 9:59 AM <remi@georgianit.com> wrote:

> Sorry, I don't have a solution for you, but I want to point out that the =
situation is far more critical than you seem to have realized.. this filesy=
stem is now completely wedged, and I would suggest adding another device, o=
r replacing either /dev/sdf  or /dev/sde with something larger,, (though, i=
f those are real disks, I see that might be a challenge.)

I don't think they make disks larger than sde.

I can get some more space by offloading stuff from the array. But even
if I offload a TB and give myself some breathing room on those disks,
as soon as I run a balance the freespace on the disks will quickly
fill up leaving me again without any unallocated space on 3 drives.

Right now I am lucky enough to have some space on sdc, but typically
after balancing I would have 3 disks with 1MB left and 1 disk with 14
TB unallocated. And I can't seem to get the balance to start using up
sdd and freeing up space from all the others.

As things stand I don't know how sde ever got filled up. Since it is
the largest of the disks it should have a portion that cannot be find
a parity anywhere else, so part of it will remain unoccupied. At least
that is what I could gather from the btrfs space allocator site.
