Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7332A6559
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 14:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbgKDNix (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 08:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgKDNiw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 08:38:52 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9390FC0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 05:38:52 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id h12so12141854qtc.9
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 05:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Yu8hLa3QRkn1pfPsAWrHhuqsiI/crQLSOechx4OBg78=;
        b=u/StCwBG/8dUSEjnOOFh6s9PzZ2+1F5h7KjP9OYT8GR7b0oC414kPvZvokjbXe7M/8
         uPzp2fOATIuqJy2b9jeRUFIH9YxP/jIKMvAT7g5pMLvSLTyMICgPzLym3LomSc5nMkam
         NxpUSWtDRa3L7ulFnBA0cbBuvpVkOOP6YFZSxPmDsCfcnp/CCbhOAK1KKu4xyMsCKcHe
         T5yJzbWE2fYOB37Nya6PiEP8YemBrm5+AE0Tqq0bdzlkFfdyTPyTgmtaKtGVHa/YcUh2
         hG6Y2PnjGKV4iPRNW41Dzpj3tbkbM2F9cthVoss8nlTk4X0VF+LK/DSRffMgm980g2ms
         cNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Yu8hLa3QRkn1pfPsAWrHhuqsiI/crQLSOechx4OBg78=;
        b=bCWg3nk0hCTRAeQFNdpD6QMLAoGHgkzA5YTSkAesowb39BFbjGdAmhG5ckPs5QhCxj
         KDuPxpPnyMDTBRNTGmxHC9JvpQDxOXIUQjO49LVBNwe2iUM0Nf6QgH4N2bg03VS7Rgfy
         CCMbIqzVAy3Bs/YlKBAkCIuPOAXjUScGRVroDkhB3OKTSSgl/cyRKLc6x9D1X71Jqh6z
         vwAQM4d77IeEkE2fdP/FNwSol6Syq+T+ZVH6wo0YgRgWjX7RpnG5ypKzrzYJ5UYdomBF
         hKUp8OgeBQ7Y+A6guwlaDVsBDqiGZ2z+kKOkqnmkY3kBJhW4+RBZIiaCizPzLUXhi5qY
         bGYg==
X-Gm-Message-State: AOAM531hBdkiubOsisT3zdlq7LRl0N970HWUEZg5gkWw6Q4zF1es0lgD
        ft7fSCXI8jw26eVp18tFxaRy1MZfCwT6efYpb4I=
X-Google-Smtp-Source: ABdhPJz2viX0iikR1hDEzovok2i+zkad5mgQpT9rWPVGa8EMqDWYi13AFEg/7f2z5xdrVrT0skl4VcyUlELgUXSPf64=
X-Received: by 2002:aed:2321:: with SMTP id h30mr19181058qtc.213.1604497131844;
 Wed, 04 Nov 2020 05:38:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603460665.git.josef@toxicpanda.com> <1e88615a596a6d811954832a744d105f94e42645.1603460665.git.josef@toxicpanda.com>
In-Reply-To: <1e88615a596a6d811954832a744d105f94e42645.1603460665.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 4 Nov 2020 13:38:40 +0000
Message-ID: <CAL3q7H60udtDb6vjSVf3ZNnqLqK4_iPg7_9bKLyQokY4rRgryw@mail.gmail.com>
Subject: Re: [PATCH 1/8] btrfs: do not shorten unpin len for caching block groups
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 23, 2020 at 7:16 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> While fixing up our ->last_byte_to_unpin locking I noticed that we will
> shorten len based on ->last_byte_to_unpin if we're caching when we're
> adding back the free space.  This is correct for the free space, as we
> cannot unpin more than ->last_byte_to_unpin, however we use len to
> adjust the ->bytes_pinned counters and such, which need to track the
> actual pinned usage.  This could result in
> WARN_ON(space_info->bytes_pinned) triggering at unmount time.  Fix this
> by using a local variable for the amount to add to free space cache, and
> leave len untouched in this case.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/extent-tree.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 5fd60b13f4f8..a98f484a2fc1 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2816,10 +2816,10 @@ static int unpin_extent_range(struct btrfs_fs_inf=
o *fs_info,
>                 len =3D cache->start + cache->length - start;
>                 len =3D min(len, end + 1 - start);
>
> -               if (start < cache->last_byte_to_unpin) {
> -                       len =3D min(len, cache->last_byte_to_unpin - star=
t);
> -                       if (return_free_space)
> -                               btrfs_add_free_space(cache, start, len);
> +               if (start < cache->last_byte_to_unpin && return_free_spac=
e) {
> +                       u64 add_len =3D min(len,
> +                                         cache->last_byte_to_unpin - sta=
rt);
> +                       btrfs_add_free_space(cache, start, add_len);
>                 }
>
>                 start +=3D len;
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
