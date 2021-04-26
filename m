Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EA236B60C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 17:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhDZPqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhDZPqJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 11:46:09 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E467C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Apr 2021 08:45:23 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z2so19924646qkb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Apr 2021 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TeWPf7+5rx+lzuTNZidJHQYUHJS7rTIsdadQdJu+0Zg=;
        b=dxX10aKEeoGcilUJma2mJRmD3ikwPBwsSy1dbudXrgPHLLBaYKdK66XnhWCTW9IjyT
         MAACdViFhaj7aJxMamprAhcZjw5SnNZRq84dZ4Gt+cNVSy1UcYdRzKbn8l+xj3ZF7uwG
         gcdFAZhGD1XNmFpVyf+PgfKVmd9sKsc809oWaP1ForcAeYVa5qzRsAv5a93hFhi8ELsc
         TBg2Ft4Enea+OMrK2tt6IL8YzT2zk8S5MD7Xdh9a+RgqYixOhap/rlT9HaVOAdicZzhS
         4H86lQi2qS58HjEl3UGFxgpT+h8OYPF+20BnurJoSrJAs1ZAvr1Ex6DJRGajGXna82eU
         VGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TeWPf7+5rx+lzuTNZidJHQYUHJS7rTIsdadQdJu+0Zg=;
        b=m3BxTvF32wmfxfvqQWmDjDeMMVcGFmV05mSQPBkkVMrPkZq4BJ7tsSnLYjdP9dOq25
         /7qLjzMmh7Z6QHPply0rZ4l2m3IoLKSWhux5f+Rdyc+mdBxsMp9JEtV+0KvLsWhrTVRO
         AjjewmSKB94+UQdBJsRQqmo6ude2NPqkDgHaSSiqmMbpA18kpOSHSMUBNLDIaz+3oDbE
         g9uePfprqycThY6lM4PLfag7kYFV4eYnVVO5uh3a04r7rxgYO5NyyyfQbMJ4JVWJhZHe
         +CRlbL4qlh+wgo+NWAgCqYNGUA920T4eokdMy8+NTN8EvCdnoKKnUL//ac6yEMxYQpmf
         MzxQ==
X-Gm-Message-State: AOAM533dv3cZeVOiCZRL02M1N+T+UgB1dIkCTSVolq/k8GanjHXjbiWM
        Q3wPsggGbeRaZPvwfyoT27Q3m1JgOWzGQuRNamw=
X-Google-Smtp-Source: ABdhPJw9co/aDmVK5nWlkHO7hhBoUp0PuewOkcXMAIRcST4TeVgy9WmtCdjOET+9oKLsIKb5z8XjVKJVH+4HRSSva/s=
X-Received: by 2002:a37:b741:: with SMTP id h62mr1244163qkf.383.1619451922295;
 Mon, 26 Apr 2021 08:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210324192858.19011-1-dsterba@suse.com>
In-Reply-To: <20210324192858.19011-1-dsterba@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 26 Apr 2021 16:45:10 +0100
Message-ID: <CAL3q7H6tRX9C9RYCCaE+PxBcVwht168Kb-m+YVSy2abctuQhWg@mail.gmail.com>
Subject: Re: Btrfs progs release 5.11.1
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Sidong Yang <realwakka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 24, 2021 at 7:35 PM David Sterba <dsterba@suse.com> wrote:
>
> Hi,
>
> btrfs-progs version 5.11.1 have been released. This is a bugfix release.
>
> Changelog:
>
>   * properly format checksums when a mismatch is reported
>   * check: fix false alert on tree block crossing 64K page boundary
>   * convert:
>     * refuse to convert filesystem with 'needs_recovery'
>     * update documentation to require fsck before conversion
>   * balance convert: fix raid56 warning when converting other profiles
>   * fi resize: improved summary
>   * other
>     * build: fix checks and autoconf defines
>     * fix symlink paths for CI support scripts
>     * updated tests
>
> Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-prog=
s/
> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
>
> Shortlog:
>
> David Sterba (10):
>       btrfs-progs: ci: fix symlink paths of helper scripts
>       btrfs-progs: tests: extend mkfs/001 to look for warnings after mkfs
>       btrfs-progs: mkfs: enumerate all supported checksum algorithms in h=
elp text
>       btrfs-progs: convert: refuse to convert filesystem with 'needs_reco=
very' set
>       btrfs-progs: tests: add crafted image to test needs_recovery
>       btrfs-progs: docs: change wording about required fsck
>       btrfs-progs: balance: fix raid56 warning for other profiles
>       btrfs-progs: tests: verify that ext4 supports extra_isize
>       btrfs-progs: update CHANGES for 5.11.1
>       Btrfs progs v5.11.1
>
> D=C4=81vis Mos=C4=81ns (1):
>       btrfs-progs: fix checksum output for "checksum verify failed"
>
> Heiko Becker (1):
>       btrfs-progs: build: Use PKG_CONFIG instead of pkg-config
>
> Jaak Ristioja (1):
>       btrfs-progs: check: fix typos in code comment and 1 typo in warning
>
> Pierre Labastie (3):
>       btrfs-progs: tests: fix quoting of sudo helper in misc/046-seed-mul=
ti-mount
>       btrfs-progs: build: fix the test for EXT4_EPOCH_MASK
>       btrfs-progs: build: do not use AC_DEFINE twice for a FIEMAP define
>
> Qu Wenruo (1):
>       btrfs-progs: fix false alert on tree block crossing 64K page bounda=
ry
>
> Sidong Yang (1):
>       btrfs-progs: fi resize: make output more readable

Btw, due to the new output, this path now makes btrfs/177 from fstests fail=
:

btrfs/177 5s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/177.out.bad)
    --- tests/btrfs/177.out 2020-06-10 19:29:03.822519250 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/177.out.bad
2021-04-26 16:25:37.708323523 +0100
    @@ -1,4 +1,4 @@
     QA output created by 177
    -Resize 'SCRATCH_MNT' of '3221225472'
    +Resize device id 1 (SCRATCH_DEV) from 1.00GiB to 0.00B
     Text file busy
    -Resize 'SCRATCH_MNT' of '1073741824'
    +Resize device id 1 (SCRATCH_DEV) from 3.00GiB to 0.00B
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/177.out
/home/fdmanana/git/hub/xfstests/results//btrfs/177.out.bad'  to see
the entire diff)

Thanks.

>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
