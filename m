Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A21B1D8B99
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 01:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgERXYG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 19:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgERXYG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 19:24:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF60C061A0C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 May 2020 16:24:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k13so11664091wrx.3
        for <linux-btrfs@vger.kernel.org>; Mon, 18 May 2020 16:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udyklszmFAR42I79mJUedTW7pQebVBOxfk2NtLIL2Kc=;
        b=lty+rix3smCrTaoNVq4+Jidwyaig4hKRFq/uas4Qoh1+NfNgBwNWdi8RD9tOaEZ43l
         9hjb8/XvheS3JheKeEXUcvTmz/Xqv+b2G+7HB+MIO/HjpKXWxiqrm+wH3ozUKzCtCceU
         Wbm9/I7wv812r7JlhhSvdaB4rLfN5IXW3lAV6Sg1ieMlSmqgS+7v5b87yoUWLOjyvr6/
         xjeALnWVQtU9iC+ni3OjLWN/SjnzVl4rruvf1DgL+p+eG2mqi7/FEFuSjg5G2tBnozt3
         MNhoK4LwuIxbURkucPrVatNsMN+dipSyAhHS6ijJpTw/5QTy+A8uS7zUBF2Ls4UlC7Lx
         nVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udyklszmFAR42I79mJUedTW7pQebVBOxfk2NtLIL2Kc=;
        b=nQL60zyA08fhvMnUxhuFFZo6MZdaZzZjFfAGgjT6L48vYaKwdGSwYiiXvJ5mH5/iSS
         mZPMeGAVhMZRotVHUbDZRae/wA686jPtfiXImKgaObt4Hmj1puWIU0u3/1Ghty8ZmNjO
         zNP/CmR5PEs6dgnJsD1xDNDF9CDVTftqZ6SnRO8p0WAv4PvyYBGdz+tp43HPPN+pHu54
         CjwEOtUro5xXrpZj4RwsK6y4IKH4AeDH8UAU5aKKVYyQrBcFwsJD8Aa6cH1z/du7uJ6R
         0JoquRu0s+bX/mU9uYEkhr3+bvn+O4pqwMkNqTGdousJLwjOIKbM8N7PzTTBclaLSc5d
         JU+w==
X-Gm-Message-State: AOAM533mZUkGISVW1qDNk6HVNZI8Mcm/SF7svzotPpoTUUjvjS2Oo22j
        N6p1bcSTxrrNcJEQ2EIhXw2gfT6dfF858+B4H6Pgx5rk868=
X-Google-Smtp-Source: ABdhPJzwjxH0LrDsvZ/umcXkdmGSSGdAcgF/nYpEYAP7YlDFEgTQq15bfdiR8hjbkDL/vQOoKqs3oFgxRV+KbDmmFbM=
X-Received: by 2002:adf:f38b:: with SMTP id m11mr21956850wro.65.1589844243198;
 Mon, 18 May 2020 16:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAGAeKuuvqGsJaZr_JWBYk3uhQoJz+07+Sgo_YVrwL9C_UF=cfA@mail.gmail.com>
In-Reply-To: <CAGAeKuuvqGsJaZr_JWBYk3uhQoJz+07+Sgo_YVrwL9C_UF=cfA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 18 May 2020 17:23:47 -0600
Message-ID: <CAJCQCtR4zz+JzETFjmwPvqyzkSBYp-9PC7T6aP2+_Xkg5n3tSw@mail.gmail.com>
Subject: Re: I think he's dead, Jim
To:     Justin Engwer <justin@mautobu.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 18, 2020 at 2:51 PM Justin Engwer <justin@mautobu.com> wrote:
>
> Hi,
>
> I'm hoping to get some (or all) data back from what I can only assume
> is the dreaded write hole. I did a fairly lengthy post on reddit that
> you can find here:
> https://old.reddit.com/r/btrfs/comments/glbde0/btrfs_died_last_night_pulling_out_hair_all_day/
>
> TLDR; BTRFS keeps dropping to RO. System sometimes completely locks up
> and needs to be hard powered off because of read activity on BTRFS.
> See reddit link for actual errors.

Almost no one will follow the links. You've got a problem, which is
unfortunate, but you're also asking for help so you kinda need to make
it easy for readers to understand the setup instead of having to go
digging for it elsewhere. And also it's needed for archive
searchability, which an external reference doesn't provide.

a. kernel and btrfs-progs version; ideally also include some kernel
history for this file system
b. basics of the storage stack: what are the physical drives, how are
they connected,
c. if VM, what's the hypervisor, are the drives being passed through,
what caching mode
d. mkfs command used to create; or just state the metadata and data
profiles; or paste 'btrfs fi us /mnt'
e. ideally a complete dmesg (start to finish, not snipped) at the time
of the original problem, this might be the prior boot; it's probably
too big to attach to the list so in that case nextcloud, dropbox,
pastebin, etc.
f. a current dmesg for the mount failure
g. btrfs check --readonly /dev/


I thought we had a FAQ item with what info we wanted reported to the
list, but I can't find it.


Thanks,

-- 
Chris Murphy
