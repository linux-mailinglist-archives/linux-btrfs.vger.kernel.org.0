Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB441F93F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKLPTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 10:19:15 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42628 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfKLPTO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 10:19:14 -0500
Received: by mail-vs1-f67.google.com with SMTP id a143so11000622vsd.9
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 07:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=eO0j9JRjYelXm10rGnFR3JrxhulTJ/8wa25ZUP1PYKk=;
        b=MeUPx327TJ3bJ215RtXQDL6hS8Rk08HBBnBlOHEiSvjcYn1wwieHp0/zynHAiphuzk
         1OnRUzHI5XWcZ6tbw7J7FQM6kg4zpH0Ae1D2cL46AqDyHzy1UOtlaeUlcHCKPnwx0jbY
         uU61XgbqeO+sJA3WGsYTLRQa1FASf7HtkiAQybl19FQYzKBo/5K2ld4DWkZQ9OeTWrsN
         WvtqS2aJeXf6whpGmMfAUbIvtaEjRyFZBLq/iSpfbd8ADB7pLqmoez+ixX0d1Va1scSt
         dr1DDPPKDX79HEa8haWAQIWBuYXbupClBbVNgeY4pBgqeqXxoFxiNS2VyPrXyfUagdQo
         whnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=eO0j9JRjYelXm10rGnFR3JrxhulTJ/8wa25ZUP1PYKk=;
        b=rxOj12CcHiEeEOsjhLHLrd7av2V3OX8jYIf++ekLmlA3RakSvwrvaFjnKvOFENa+ha
         3hlDgOmVQItNTNdRo7GC+FeMGOcZYw6Tmp//vcVHk62Ll1iNSpq13TYK3rd6DbWKEN6v
         k0BM4Ior3i4A8FqpQaLiY4TVbSC+LVFSGl7Cuwk9h3dDHpz84iSIRxxZn5veWr45mqSZ
         EdxwhhMpF6cYL/TSN0yOUVlWyT546HaLLZoUzVFXxu4IEmOOq5vzqetcKF7eSpHZiXcv
         kw4ZgOKgr214SV4Em0le3+072zZjInJRzcJXzFMYJZCwXD/fcziz1DnQL68min3g32zz
         8ZQA==
X-Gm-Message-State: APjAAAUUnXaUmIzHVYhUu/9noHUKnfAmad7L9gYlg/1DyCDRpE+yKPdZ
        bC3wAX1MLkO9El0KZbn4S8juuL5H8FHv0YYBVE203W38
X-Google-Smtp-Source: APXvYqwU1fFlBAgU2MWbCAZ00bdPv2z7ahUJOTENwZiza8U68xClGmMc/u63amxEVgLxnJCq9JGAeFVyL4OEeRJ47UE=
X-Received: by 2002:a05:6102:2375:: with SMTP id o21mr23371061vsa.90.1573571952379;
 Tue, 12 Nov 2019 07:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20191111065004.24705-1-wqu@suse.com>
In-Reply-To: <20191111065004.24705-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 12 Nov 2019 15:19:01 +0000
Message-ID: <CAL3q7H5nA4JqKSj90pYjB2_1trRtWva_oCYst62zMGc_cLzTFQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: mkfs: Make no-holes as default mkfs incompat features
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 11, 2019 at 6:51 AM Qu Wenruo <wqu@suse.com> wrote:
>
> No-holes feature could save 53 bytes for each hole we have, and it
> provides a pretty good workaround to prevent btrfs check from reporting
> non-contiguous file extent holes for mixed direct/buffered IO.
>
> The latter feature is more helpful for developers for handle log-writes
> based test cases.

So it seems your motivation is to get rid of the false fsck alerts.

The good part of no-holes is that it stops using 53 bytes of metadata
(file extent items) to mark holes. That's great.

The not so good, but necessary, part is that fsck (btrfs check) stops
checking for missing extent items, assuming that any
missing extent item is because a hole was punched or as consequence of
writing beyond eof.
So any bug that causes a file extent item to be dropped and not
replaced will not be so easy to detect anymore. That can make
bugs much harder to detect, such as [1] for example, which is the most
recent I remember.

I have been testing this feature regularly since it was introduced way
back in 2013.
Since then I've fixed many bugs with it, mostly corruptions happening
with send/receive and fsync. Last one fixed was for send/receive
earlier this year in May.
And I have yet another one for hole punch + fsync that I found last
week and I've just sent a fix for it [2].
As I don't recall anyone else consistently submitting fixes or bug
reports for this feature, I don't know if I should assume people
(users and developers) are testing it and not finding issues or simply
not testing it enough (or at all).

We started having a lot of false positives (fsck complaining about
missing extent items) from fstests test cases that use fsstress since
fsstress was fixed to
use direct IO when the test filesystem is not xfs [3]. In an old
thread with you [4], I remember pointing out that most of such fsck
reports were due to mixing buffered and direct IO writes.
So using the no-holes feature is a way to silence the tests. However,
are we sure that at this point all such fsck alerts are because of
that?
When I looked at it after the fsstress change, I couldn't find any
case that wasn't because of that, but since then I stopped looking
into it, both due to other priorities and because it's very time
consuming to check that.

While I'm not against making it a default, I would like to know if
someone has been doing that type of verification recently. I think
that's the most important point.
Just running fstests with MKFS_OPTIONS=3D"-O no-holes" is not enough IMHO.

Thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D609e804d771f59dc5d45a93e5ee0053c74bbe2bf
[2] https://patchwork.kernel.org/patch/11239653/
[3] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3Db66=
9b303d02e39a62a212b87f4bd1ce259f73d10
[4] https://www.spinics.net/lists/linux-btrfs/msg75350.html

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/fsfeatures.c | 2 +-
>  common/fsfeatures.h | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 50934bd161b0..2028be9ad312 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -84,7 +84,7 @@ static const struct btrfs_fs_feature {
>                 "no_holes",
>                 VERSION_TO_STRING2(3,14),
>                 VERSION_TO_STRING2(4,0),
> -               NULL, 0,
> +               VERSION_TO_STRING2(5,4),
>                 "no explicit hole extents for files" },
>         /* Keep this one last */
>         { "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
> diff --git a/common/fsfeatures.h b/common/fsfeatures.h
> index 3cc9452a3327..544daeeedf30 100644
> --- a/common/fsfeatures.h
> +++ b/common/fsfeatures.h
> @@ -21,8 +21,9 @@
>
>  #define BTRFS_MKFS_DEFAULT_NODE_SIZE SZ_16K
>  #define BTRFS_MKFS_DEFAULT_FEATURES                            \
> -               (BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF           \
> -               | BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
> +               (BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |         \
> +                BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |       \
> +                BTRFS_FEATURE_INCOMPAT_NO_HOLES)
>
>  /*
>   * Avoid multi-device features (RAID56) and mixed block groups
> --
> 2.24.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
