Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED619366FA8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbhDUQDq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 12:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbhDUQDq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 12:03:46 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4806AC06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Apr 2021 09:03:12 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id i11so15040969qvu.10
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Apr 2021 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=x7LBdMzCV7k07Evmbqqqj2On2MhjiEoegZzBFISuFn4=;
        b=WMt9C5765X2iZ8QdWmZtMflbOrlyPevkxDb/SbeZU2HSQN1Lv69DmYknPPQXQmX6HH
         +WHDTioFpVF5EFemw1oAmyDEYhe2zxhF/2linzUGTjnYFThfhDhRlyt5cIuaZA7Y57Rs
         bfl2SSEuqa5KoLiAe98yHhfEIz60UgaCotNOn2lBmJg/5mYosyuU0eK4P80W8bIT/c6c
         pOYKMMu3LojBkN3w3qXA2bTx/5nVXxqtZRT1oJHjyyIUbR1UZKmBoNZgsBO0UPgdkJUh
         vRcuPoVw7a8M3HL/j3PbybDrsN7Vodn9/jkeKpZw3mlSV67zclnMnRtBSP8u9Kpr6wAb
         x/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=x7LBdMzCV7k07Evmbqqqj2On2MhjiEoegZzBFISuFn4=;
        b=eFc4ImgsIiDxkQIffXp5cwgg0520NOei+58CCLFfe8ZRRIR17z/1oXE0leFqrc2zej
         h8HKoyEoWWNfz/OzPSWPvAh2hFtyfMJqxKIMhMVhjxCOdc4araFNeQtv9e5/PpcvAPdn
         cA8FRcu4uNhR9GjLvJG1nvk7M07VMtiUQ92zEqPoOLtoczDGnMfLt+/3jBcS2OLxLsd5
         7PHDxHSSdG3TBh9xTUtJkCsi9kKR1uoQEKqdmqJ8gETXWICq3D35H7YWxb3WUhJKl2n5
         ut8+ZIlQ7A7xwxB/opsiY3hl1ADA4eGRZ48BYCtShu2epNUx9V98lAZRAaAimuV6dhJU
         H3WQ==
X-Gm-Message-State: AOAM530VM9xdot4V4Zk0Oak5iHQNF6NWlY+L9V0OyeCkBDLH4ERsn0Cl
        Yma3M6oinyp+RLDsVb8ox9KstUpwJlS+4i8pC5OtLLOLVDp4mw==
X-Google-Smtp-Source: ABdhPJwBNeMPLDJsq5xNv1SS8UPZgoJssTSpYOpBvDKumlJ2hD/C0jyuzV+L1lqTPmu3DpSLvszYlUnpgOv7/eipKow=
X-Received: by 2002:a05:6214:a8d:: with SMTP id ev13mr32665705qvb.28.1619020991470;
 Wed, 21 Apr 2021 09:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210421201725.577C.409509F4@e16-tech.com> <CAL3q7H6V+x_Pu=bxTFGsuZLHf2mh_DOcthJx7HCSYCL79rjzxw@mail.gmail.com>
 <20210421235733.9C11.409509F4@e16-tech.com>
In-Reply-To: <20210421235733.9C11.409509F4@e16-tech.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 21 Apr 2021 17:03:00 +0100
Message-ID: <CAL3q7H7j7eZ0r1xYJiQGr3+yuwnqkpbRoA3HxY=e8Ut8VDRCRA@mail.gmail.com>
Subject: Re: 'ls /mnt/scratch/' freeze(deadlock?) when run xfstest(btrfs/232)
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 21, 2021 at 4:57 PM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> > That's the problem, qgroup flushing triggers writeback for an inode
> > for which we have a page dirtied and locked.
> > This should fix it:  https://pastebin.com/raw/U9GUZiEf
> >
> > Try it out and I'll write a changelog later.
> > Thanks.
>
> we run xfstest on two server with this patch.
> one passed the tests.
> but one got a btrfs/232 error.
>
> btrfs/232 32s ... _check_btrfs_filesystem: filesystem on /dev/nvme0n1p1 i=
s inconsistent
> (see /usr/hpc-bio/xfstests/results//btrfs/232.full for details)
> ...
> [4/7] checking fs roots
> root 5 inode 337 errors 400, nbytes wrong
> ERROR: errors found in fs roots

Ok, that's a different problem caused by something else.
It's possible to be due to the recent refactorings for preparation to
subpage block size.

Will try to look into that later.

Thanks.

> ...
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/04/21
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
