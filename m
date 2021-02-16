Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2450131C948
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 12:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhBPLDY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 06:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhBPLBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 06:01:10 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731BEC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 03:00:30 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id a1so4443604qvd.13
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 03:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=D8H30sA17kTl86l43+m0AhnUpo6/9Xc/mrnWZW0/Vqo=;
        b=C8WicJWeQKSAH3Bl8e/kQFpwvTjEmh8HaeZdeZ025NQB9LfUmZeXnCb7bbODUL+oTA
         WVADkoR3iz6cdmv0O7NW4N9cJfp3ftHJ4DK73722kaCQlsOYppBwRooSKfBECleU2ZC2
         SCzu98F4o0M43dP4Qn9HSrqBKN44M07kFiDAP2SzmmvC160hJLHrN4pijm0NrqxaSfmo
         rqQbtsjCBk0LNQwrb3biDePlAnXwViWvsz1xWzuf2WESeGcAcKrH36Lw6/UBnUwrsZt5
         2wgy393xIesvbuNpYaIYRGeq6bfBKyPewNqulPEpDxVP7afTFLGghvVwAiDtw/VsyDhn
         CHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=D8H30sA17kTl86l43+m0AhnUpo6/9Xc/mrnWZW0/Vqo=;
        b=KY3021CgDYlHvmkykeZJomvufuwAJzzi4H4G7Cw/2lk+WnxtHdlNJVvmnn/Qk/dgmd
         0HkOvIwwNNJM3MZrpSLuMQFV/ZxGW8KEfeohnyZeBki5Y93G5vDz5cFtsyL2rEb62ZTU
         j31n0x+ONcOtV0PqNS5BOjLuahDFetVb74NoT5DsCHcrq2kPcFHMoZyoZTkj3J86DChB
         M+ZSSuHi3f5drdbUvlXyocAUvzCRhuYiaz0s+WW1YqtaAbOllStuPcHfb+W2rLdtrlyS
         7uLizwF9Ss7WLdX5qlr5NJlYifVKz3HOSv/YM7CAZqAJMSGtrCLnHxkCzOmENygBYBNU
         iEzw==
X-Gm-Message-State: AOAM533lFC9u9+iDKTTC47M1bC8n5fsu9H0sMRX5xIASwXsGFkpdHd3N
        dihsyW/5IOVyzOoyP0VcHdU/vVv4bJL7+3n977NKA/fymez3NA==
X-Google-Smtp-Source: ABdhPJwLo+KCptg+gZnMhAXfEBCJLj51NhV/y6t/UM47YqBF+uTrtfDnJ21Bu2ORU1vatVxp7LGsze+iajMG19U4REc=
X-Received: by 2002:a0c:906c:: with SMTP id o99mr18768186qvo.28.1613473229626;
 Tue, 16 Feb 2021 03:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20210205112506.4274-1-dsterba@suse.com>
In-Reply-To: <20210205112506.4274-1-dsterba@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 16 Feb 2021 11:00:18 +0000
Message-ID: <CAL3q7H58PJk3Fyq4b7WTWGrzVmz5zATDDTCKO3SPS0EF=x0k4g@mail.gmail.com>
Subject: Re: Btrfs progs release 5.10.1
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 5, 2021 at 11:33 AM David Sterba <dsterba@suse.com> wrote:
>
> Hi,
>
> btrfs-progs version 5.10.1 have been released.
>
> The static build got broken due to libmount added in 5.10, this works now=
. The
> minimum libmount version is 2.24 that is not available on some LTS distro=
s like
> CentOS 7. The plan is to bring the support back, reimplementing some libm=
ount
> functionality and dropping the dependency again.
>
> Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-prog=
s/
> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
>
> Shortlog:
>
> David Sterba (6):
>       btrfs-progs: build: fix linking with static libmount

Btw, this causes two fstests to fail:

$ ./check btrfs/100 btrfs/101
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian8 5.11.0-rc6-btrfs-next-80 #1 SMP
PREEMPT Wed Feb 3 11:28:05 WET 2021
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/100 6s ... [failed, exit status 1]- output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/100.out.bad)
    --- tests/btrfs/100.out 2020-06-10 19:29:03.818519162 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/100.out.bad
2021-02-16 10:55:53.145343890 +0000
    @@ -2,10 +2,7 @@
     Label: none  uuid: <UUID>
      Total devices <NUM> FS bytes used <SIZE>
      devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
    - devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
    + devid <DEVID> size <SIZE> used <SIZE> path dm-0

    -Label: none  uuid: <UUID>
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/100.out
/home/fdmanana/git/hub/xfstests/results//btrfs/100.out.bad'  to see
the entire diff)
btrfs/101 8s ... [failed, exit status 1]- output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/101.out.bad)
    --- tests/btrfs/101.out 2020-06-10 19:29:03.818519162 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/101.out.bad
2021-02-16 10:55:58.105503554 +0000
    @@ -2,10 +2,7 @@
     Label: none  uuid: <UUID>
      Total devices <NUM> FS bytes used <SIZE>
      devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
    - devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
    + devid <DEVID> size <SIZE> used <SIZE> path dm-0

    -Label: none  uuid: <UUID>
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/101.out
/home/fdmanana/git/hub/xfstests/results//btrfs/101.out.bad'  to see
the entire diff)
Ran: btrfs/100 btrfs/101
Failures: btrfs/100 btrfs/101
Failed 2 of 2 tests


Is there any plan to fix this?

Thanks.


>       btrfs-progs: tests: add support to test the .static binaries
>       btrfs-progs: docs: clarify scrub requiring mounted filesystem
>       btrfs-progs: INSTALL: update build dependencies
>       btrfs-progs: update CHANGES for 5.10.1
>       Btrfs progs v5.10.1



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
