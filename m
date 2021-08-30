Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5382B3FBC85
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 20:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhH3SgI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 14:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhH3SgI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 14:36:08 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCEAC061575
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 11:35:14 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a10so16695166qka.12
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=F4C8FA5qjblqw9MqS8IoSzulq6kxeP4sGsUyt6Vx2Tk=;
        b=OxNeI7tJ4Q/Pqcdx6TgcovwpIb33OJzKHaDERCkPn2e1MnedqE1IOQ1uU4Yb4tCeRO
         CuuDDKXMgA0T7drsau0SRKF9Gr5kFGFCkRQug8kgZEeNmGvu9IoKuVh20dwpPOyVvnu3
         SNbABYYX5usVOHBjNMC0bCAvMDdQYfGhsKfdmD8u5JyalH9eS6mOhOkSuLZ8mtzInE4d
         x43So/AcBa1gLEkw8fW8qNyr/eNOaAWjr135op8py19ONukaBc3uClc1vAougefT2i1H
         j1IA/MrfC68qm+9Mwz2c6E3BaCiZF5OKEYBa9t+MoOt95RsfQEfoCgxrTb4S4Oz9ulcD
         DNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=F4C8FA5qjblqw9MqS8IoSzulq6kxeP4sGsUyt6Vx2Tk=;
        b=OU4u9ims4+qflN6eDCclcq55iZpnvzLguQlEtLJiQi3fiHKCJAkY5yUD1SUUuzkPvb
         iGwXdSBmtSlBQRiV73dWusyxpgei8vCAxkdnTJt08eTKYiHxMyi+j/Hb4RqSg5Abqszo
         gzFm7irSYkUTtcslfx2nl2QyKJ+6WgqUTVtNK7+ZYSLoAtUOV5z1NKldILXIdp3N5xx5
         k93UglaEnf2Q8NhIsaebpT+0dIh2O0EsNbC8tvMiXoN0MJbF+mMOU9+U5E3SbJNNYCrv
         5XyVLzMm7zG1bvpCQPnkrwWZXDdKPWzBTGzzgQBH8LICUM1OiUO1iI4CQnnGJz5ocJk+
         UtiQ==
X-Gm-Message-State: AOAM530xca4hT9fLnmoKSpYD3W07DCgDUgfsX0rUGtwvzZpGid/cp+Va
        CE5G93KjEiclMfoEN0VYyoEONOXCnvUQ6RrJS+Zg/q3JWLg=
X-Google-Smtp-Source: ABdhPJxm83X8PHK7JvQl462GqWx2UgOXFcrhjNLFsM13HEnmkzPciwok5lJ+4mr7oB5RbPct32GtDq6ANfzt+/0YloM=
X-Received: by 2002:a05:620a:444b:: with SMTP id w11mr23655924qkp.479.1630348513551;
 Mon, 30 Aug 2021 11:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
 <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
 <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
 <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com>
 <CAOaVUnUwoq69UZ_ajoxYYOHk8RRgGPNZrcm9YzcmXfDgy24Nfw@mail.gmail.com>
 <CAL3q7H67Nc7vZrCpxAhoWxHObhFn=mgOra+tFt3MjqMSXVFXfQ@mail.gmail.com>
 <CAL3q7H46BpkE+aa00Y71SfTizpOo+4ADhBHU2vme4t-aYO6Zuw@mail.gmail.com> <CAOaVUnXXVmGvu-swEkNG-N474BcMAGO1rKvx26RADbQ=OREZUg@mail.gmail.com>
In-Reply-To: <CAOaVUnXXVmGvu-swEkNG-N474BcMAGO1rKvx26RADbQ=OREZUg@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 30 Aug 2021 19:34:37 +0100
Message-ID: <CAL3q7H5UH012m=19sj=4ob-d_LbWqb63t7tYz9bmz1wXyFcctw@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Darrell Enns <darrell@darrellenns.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 30, 2021 at 6:38 PM Darrell Enns <darrell@darrellenns.com> wrot=
e:
>
> I still have the snapshots, and will try and test with the debug patch
> later today. I am actually using -c. I was doing this using snap-sync
> (https://github.com/wesbarnett/snap-sync), which uses -c. The full
> command for my test is:
>
> btrfs send -vvv -c /.snapshots/327/snapshot
> /.snapshots/374/snapshot/|pv|btrfs receive /mnt/backup/test
>
> This is taken directly from what snap-sync does (just with the added
> verbosity). Is -c potentially part of the problem?

Nop, as long as:

1) /.snapshots/327/snapshot is the snapshot with ID 881;
2) /.snapshots/374/snapshot is the snapshot with ID 977.

Passing only one -c without a -p, is the equivalent of using a -p with
the same argument (and no -c argument).

Thanks, for trying it out!


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
