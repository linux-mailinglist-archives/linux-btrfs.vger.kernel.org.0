Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560713CB7C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 15:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbhGPNSm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 09:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhGPNSl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 09:18:41 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C40C06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 06:15:45 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id o72-20020a9d224e0000b02904bb9756274cso9809717ota.6
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2kcChKNrMNgA7OXXt8B2RmPMnCrRR8FXDHRacooL5o=;
        b=opyO8UFN8jeYuSd47ZF534ZW59+mhEwqILAt4pUCc8SqSFGQMV2fAtYTw+JhWCwtgy
         uzz4WBzYsQYmVGWWPB6WAiuUNbWJ0dRIOzAcrH5IOjV5AnLP50pVFw0MoU8w99UXUJWf
         EmWjfZmxUJV1+5bfldLjP0xH8etue8kztPTNN46lzGCifwnRrMSQiVCFD/D/rn0moXmg
         lMQLYg2+549c0M/bxi5od9b2GUpY6M2n2JN/3qP6AGHyvT7CsB32Ej4jGVpInOqJVcr+
         PcNaP8z9Gwjzzbk0nTWs0cob1GKPNVXRRxX16hOsd1Wba/+PcyAC0cvKwjSecJ+EhVmw
         j6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2kcChKNrMNgA7OXXt8B2RmPMnCrRR8FXDHRacooL5o=;
        b=cK5GT0OuYsgAGObhiaqR/cLKBiA3OYLb7ONskMLDVHe6ThYQPtGXJwupkx7ocqZ/fU
         5/NN5k7RGzhP5HyzILMed8wT40CDvKHO2VmWDjDDWG52mi7/fwFYo50uY5ijMfZfS1Wa
         kctzXrty36sOI3CozcLAXHuSFlj4TN4cklhP7tmi+sDy3uo5S1kCurs4H9ExjZ2lD1I0
         9l+QWsDJZRFKj6hkwXCE8EXAGnMsOztzbC9zzbPEwp70eE+PQPNibasoj5kcxzrMsGzD
         Ai+7745BpAsfvAzyPplu0acSEVE7qitintzVu0qDndKkD3y1a+SM6rGUEXa2P01RlTrO
         JOpA==
X-Gm-Message-State: AOAM533oj5FUCQNr/dFg9HYbjeoWeEGuO9dS7qjLg4oT4d0lr+VQX+o9
        jfO9iZvOU6WZL1HyVoSce9B879tA/lifbikkxFQ=
X-Google-Smtp-Source: ABdhPJyk00Rlp2Mnx++jpxmhQ6OEruweiVhFiLbmJPQP9O1PgfKilZtF+tHDyP0lP9M3NR5mjvo616BIFZxKOm90GTY=
X-Received: by 2002:a9d:410b:: with SMTP id o11mr8058158ote.211.1626441345269;
 Fri, 16 Jul 2021 06:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com> <CAGdWbB44nH7dgdP3qO_bFYZwbkrW37OwFEVTE2Bn+rn4d7zWiQ@mail.gmail.com>
 <43e7dc04-c862-fff1-45af-fd779206d71c@gmx.com> <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
 <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com>
 <520a696d-d747-ef86-4560-0ec25897e0e1@suse.com> <CAGdWbB6CrFc319fwRwmkd=zrVE4jabF0GTpqZd5Jjzx2RcAo9Q@mail.gmail.com>
 <e4cc8998-fc9e-4ef3-3a49-0f6d98960a75@gmx.com>
In-Reply-To: <e4cc8998-fc9e-4ef3-3a49-0f6d98960a75@gmx.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Fri, 16 Jul 2021 09:15:34 -0400
Message-ID: <CAGdWbB6Y0p3dc6+00eTnf1XSS1rUMbPUckQabi6VJQXdjRt2jg@mail.gmail.com>
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 15, 2021 at 9:05 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> > I've been running arch + btrfs since 2014. I keep arch linux fully
> > updated. I'm running new kernels and new btrfs progs. However, I
> > created this filesystem around 2014.
>
> The change that don't allow allow compression if the inode has NODATASUM
> option is introduced in commit 42c16da6d684 ("btrfs: inode: Don't
> compress if NODATASUM or NODATACOW set"), which is from v5.2 in 2019.
>
> Thus such old fs indeed can be affected.
>
> >
> > Is there an option to "update" my BTRFS filesystem? Is that even a thing?
>
> I don't think so, but please allow me to do more testing and then I may
> craft a fix in btrfs-progs to allow btrfs-check to repair such problems.

I hope that there is soon a way to run a btrfs-progs command to update
an old filesystem to the current standards.
Where can I send you a small donation to express my support for
something like this?

>
> If possible I would enhance kernel to handle such existing file extents
> better so that what you really need is just run "pacman -Syu" as usual,
> nothing to bother.

This would indeed be a fantastic solution!

> So I'm afraid there is something different involved for your read error problem.

I am less worried about this specific problem than about the general
problem of having an old filesystem on a fully updated rolling release
linux system. I was able to restore all my data to a new SSD and I am
just testing this old SSD to give you feedback.

However, I do have some general questions. As it stands currently,
what exactly is an "old filesystem"? If I run "mkfs.btrfs" with linux
kernel v5.1, is all data in that filesystem somehow affected even
after I install newer kernels? Or are files created when running the
newer kernel not affected? What about files copied?

If I do a btrfs send|receive from a fs originally created in 2014 but
now I am running the latest arch linux kernel, what is the result? Do
my transferred files still have hallmarks of the 2014 filesystem they
originally lived on?

Are there some checks I should do now on my other devices with btrfs
filessystems originally created around 2014? (I have a lot of such
devices because in 2014 I decided to run arch linux and btrfs
everywhere.)

> When the read error happens, is there really no extra kernel error message?

I can do more testing and let you know. Can you suggest any tests you
would like me to try? I could run "journalctl -f" in one window and do
some file operations in another program, for example. But I am not a
developer, so there may be limits on what I can do.

Thank you.
Dave
