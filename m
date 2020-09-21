Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8392735BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 00:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgIUW0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 18:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUW0h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 18:26:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DD3C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 15:26:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so1184610wmh.4
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 15:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WccDkq61Cml7m5sKePWZYRUGRV9EpqihJQFfPfeeu8o=;
        b=qCHRL/oyrRMa+ZdqYwv64CiN9krQbjtfdkpSyiSpHswBfhwh27IJO4v1z7XfVvKgp7
         55XTl9vHodSyrV8u9dhEdGvMVxxfB8YvNC57vbcGbxbX5oB5/bQifB9gY16tgSydtBVS
         IJVNwHsTQf0RizhDJp/YX1U+h9Y3Sp1PzGFRmcVpFZ6NKZ0mr8ggESBbfpwoFQ5Z3e5u
         V/qk9lnexAXcyUnALMpopL5MBlpI/ymrWPjkdluQVZnfpiI8osfFL7SCqkAwzCkRTKgu
         cyGNRvT5K+i0iMXsKKKCKcMH5GHqCzsNxEcI95JNg5mPf+YNzt4gTmE8qEPGrQZjkP1a
         pkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WccDkq61Cml7m5sKePWZYRUGRV9EpqihJQFfPfeeu8o=;
        b=tUn9BfYyV7xLVd0grlzo7uwFaDEz6y87Ii00dJ/sPTQhbNGuCewswFRUTHWYz3xWc7
         7kKMDJd2pjiBfR1wucJbovQI7vmicHcCtAp0w6I4mKAkyTVqQxzBg/xQuDDIOe7zJl7P
         Te68W28kn4AEDbzSZxdMDNXxyu8ef1DCnyfFUDYjIEkRSj9KHs57Vq/yVri/IGtz6jP4
         5UAWVteGrffDl92u95P+OLzM1cFF8M0f1EF15qS7G5xri00WXeDXMuMSTNZdO0hyzIKE
         yfvXMQyh/mZGBsY0VW/vYgt6hWhmeeXkEJFTl+KfkJ2DAbDv/KrkD+3kSOwwArINMw/f
         aIyw==
X-Gm-Message-State: AOAM5336JtvZwyZtfvquBZbhzx6nVsjGOYpqXcyBUsqfPmTWpIrwQHdc
        c0mLVjIGs3D4fVxKs5UMGdWxT/E3tRhkqU1WN9/vtw==
X-Google-Smtp-Source: ABdhPJyNknDQPGqcnjAopYr+ySiWo3MB2nYvPMuwyBPF/KpnnAIcGwUbu1OMfGpT82HQeADhXBRUo/rNaa6bbfPHh5g=
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr1363149wmf.168.1600727195478;
 Mon, 21 Sep 2020 15:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <1978673.BsW9qxMyvF@merkaba> <4131924.Vjtf9Mc2VK@merkaba>
 <8d2987f8-e27e-eedb-164f-b05d74ad8f3b@gmx.com> <8020498.oVlb7o6SH1@merkaba>
In-Reply-To: <8020498.oVlb7o6SH1@merkaba>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 21 Sep 2020 16:26:19 -0600
Message-ID: <CAJCQCtRck1FWMh7gVzZwLCe70bFJAy_48EkeFEHKGOFZD5Yx6A@mail.gmail.com>
Subject: Re: external harddisk: bogus corrupt leaf error?
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 21, 2020 at 5:46 AM Martin Steigerwald <martin@lichtvoll.de> wrote:
>
> Qu Wenruo - 21.09.20, 13:14:05 CEST:
> > >> For the root cause, it should be some older kernel creating the
> > >> wrong
> > >> root item size.
> > >> I can't find the commit but it should be pretty old, as after v5.4
> > >> we
> > >> have mandatory write time tree checks, which will reject such write
> > >> directly.
> > >
> > > So eventually I would have to backup the disk and create FS from
> > > scratch to get rid of the error? Or can I, even if its no subvolume
> > > involved, find the item affected, copy it somewhere else and then
> > > write it to the disk again?
> > That's the theory.
> >
> > We can easily rebuild that data reloc tree, since it should be empty
> > if balance is not running.
> >
> > But we don't have it ready at hand in btrfs-progs...
> >
> > So you may either want to wait until some quick dirty fixer arrives,
> > or can start backup right now.
> > All the data/files shouldn't be affected at all.
>
> Hmmm, do you have an idea if and when such a quick dirty fixer would be
> available?
>
> Also, is it still safe to write to the filesystem? I looked at the disk,
> cause I wanted to move some large files over to it to free up some space
> on my laptop's internal SSDs.
>
> If its still safe to write to the filesystem, I may just wait. I will
> refresh the backup of the disk anyway. But if its not safe to write to
> it anymore, I would redo the filesystem from scratch. Would give the
> added benefit of having everything zstd compressed and I could also go
> for XXHASH or what one of the faster of the new checksum algorithms was.

xxhash is about tied with crc32c, but it's hardware specific. Chances
are the computation of the checksums will have no affect on
performance. But the size of the checksum can. The xxhash64 checksum
is twice the size of crc32c, so it means the csum tree is double. As
there can be some latency as a result of csum writes, when doing heavy
writes, moving to bigger csums increases this latency. If you don't
have heavy writes workloads, it's unlikely to matter. To avoid
collisions with crc32c, it probably starts to makes sense to use
xxhash or better once the file system size gets above 8TB.



-- 
Chris Murphy
