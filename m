Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64601F970D
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 14:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgFOMuo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 08:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbgFOMul (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:41 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A340C08C5C2
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jun 2020 05:50:41 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id q69so3883850vkq.10
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jun 2020 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=0xmp/ckEoZpdaOYLe5rWkRZwx/ZjyxRHnmmsnXQvcBA=;
        b=MHrtoenWcMI23temMhGH/EdV6uqit9IkzJRayZE6qnyMUFRMdwOqpCtCZmIALD9SkB
         h8AkXOoJRgR1qPLtJ8pObfJnU7Py/5Tz/3ooCaLRZHlrNasiOpq822UcjFyISjiKYHo5
         qSO13wMogmhyNS1k7mFBCBhJAFq9yL3MDTLk8lz9oPE9Y8WumCMkgCC+8EEGUPM3bZgt
         zDvly99nqffm8aFJYGgeL57q8T/xB00qR+nla5VHjB0fGgINagQWCs8qCqk2LgcnlBhH
         EQ3o8tqHY+480u/me5oEWO8M+d5pGgmffh928kJh/FMeq8iWlSqte5jmiEpg4e52UbH/
         gHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0xmp/ckEoZpdaOYLe5rWkRZwx/ZjyxRHnmmsnXQvcBA=;
        b=Vrpvi3QSbkcKgIhwMfT4HovnoprdXb6FPBOWeuxzXKAG87wpBMesg+7CC9EUuZt0Ur
         HMd+YnFybjZVaApq1y/V2m7dT0rQmnS4nEAfZgCkiLpobKdE3px9cFDEVIsOsa2C8Ngf
         OvT5jhdfhQG1eRgp1zC9WJ6NH2OwpH3oDP0YvncgeIbwrwlRkFvlixQD1WIR4v1EFS9g
         p/XKCD2agYjG1CGFh/jug1s8TT7JgqDXWqla9ZY6kjXJO3XxeX+NLuzGhFHyr8eoUeuH
         SrqR/Zk9EKFLToFSeA99dBtGRHa9dGtzzRwZciJDbsqtqtkgp18AIefHgN3yYKEXL4oy
         rXfQ==
X-Gm-Message-State: AOAM530lFAxzyOqZK9WTZ34aQmdbgFDOJDuK/DgUbR3kAa/YQkGiA1Cm
        onAIVTN7liErsysR7bHsV+HYr3Y4ejcjZ4jIexs=
X-Google-Smtp-Source: ABdhPJwO07KTo6A2osTN/tXkK8omtYkykdQRe7wqecCpNulAhc+86e3mY/aLqPHOjo0n1dYd64NFclHARUTf6NB567U=
X-Received: by 2002:a1f:ac51:: with SMTP id v78mr3423534vke.78.1592225440119;
 Mon, 15 Jun 2020 05:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com>
 <20200611112031.GM27795@twin.jikos.cz> <a7802701-5c8d-5937-1a80-2bcf62a94704@gmx.com>
 <20200611135244.GP27795@twin.jikos.cz> <CA+UqX+OcP_S6U37BHkGgzyDVNAud5vYOucL_WpNLhfU-T=+Vnw@mail.gmail.com>
 <20200612171315.GW27795@twin.jikos.cz>
In-Reply-To: <20200612171315.GW27795@twin.jikos.cz>
From:   Greed Rong <greedrong@gmail.com>
Date:   Mon, 15 Jun 2020 20:50:28 +0800
Message-ID: <CA+UqX+PxF=prEHeS_u_K2ncT1MGqdmFsQeVTkDYLS6PqhJ7ddQ@mail.gmail.com>
Subject: Re: BTRFS: Transaction aborted (error -24)
To:     dsterba@suse.cz, Greed Rong <greedrong@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Does that mean about 2^20 subvolumes can be created in one root btrfs?

The snapshot delete service was stopped a few weeks ago. I think this
is the reason why the id pool is exhausted.
I will try to run it again and see if it works.

Thanks

On Sat, Jun 13, 2020 at 1:13 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Jun 12, 2020 at 11:15:43AM +0800, Greed Rong wrote:
> > This server is used for network storage. When a new client arrives, I
> > create a snapshot of the workspace subvolume for this client. And
> > delete it when the client disconnects.
>
> NFS, cephfs and overlayfs use the same pool of ids, in combination with
> btrfs snapshots the consumption might be higher than in other setups.
>
> > Most workspaces are PC game programs. It contains thousands of files
> > and Its size ranges from 1GB to 20GB.
>
> We can rule out regular files, they don't affect that, and the numbers
> you posted are all normal.
>
> > About 200 windows clients access this server through samba. About 20
> > snapshots create/delete in one minute.
>
> This is contributing to the overall consumption of the ids from the
> pool, but now it's shared among the network filesystem and btrfs.
>
> Possible explanation would be leak of the ids, once this state is hit
> it's permament so no new snapshots could be created or the network
> clients will start getting some other error.
>
> If there's no leak, then all objects that have the id attached would
> need to be active, ie. snapshot part of a path, network client
> connected to it's path. This also means some sort of caching, so the ids
> are not returned back right away.
>
> For the subvolumes the ids get returned once the subvolume is deleted
> and cleaned, which might take time and contribute to the pool
> exhaustion. I need to do some tests to see if we could release the ids
> earlier.
