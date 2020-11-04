Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06712A67D3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 16:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgKDPhF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 10:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgKDPhE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 10:37:04 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946F2C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 07:37:04 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 140so19644100qko.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=aH1jDg15FN2PDuMxjlWwrp2+KZJ9KL4wT1bIyvn1AD8=;
        b=bTqFOgZFlWOwcowXHvzAXw0YXK5JW3DuwLY3xG1DRgKrz4pLmdrI0ugdfyqn6gMmrT
         MCWNOY3WSp1phOlE1Cl5m/FZXlTU0t15rnoM2erIXR9j5jE76XUuda//9dEbLQZB862i
         clIa+HNzbUxAiirBqe6lvzlQ8g++pJ/w80vY8TKnGyzc5MkBAgnkWHakmyqn5xt3F+c7
         rPIheOJZYjHZxMQMUJ4et1rPNuBs5HTb+HDcNzCruR4l9GuZexmqicL9UbX1M6/WvWdV
         dJordFgvtGOUdHSmbENPu9RWPg0FZ1l1Pa2omM6AlKM39fZzqDIF6HweQo/Mfobwimfs
         d5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=aH1jDg15FN2PDuMxjlWwrp2+KZJ9KL4wT1bIyvn1AD8=;
        b=oBqOyk2un0wBco92MaaZaepNcmEGQicHnj/pQSf/S4sVRUjK3aCs+Viy3BMTMriLue
         lB7X9WJMsSkKCVUz/ARy1Yho27XvrRGjcep3iuXgQYj6F8EKvrc1X3zOVG7hDBQ3Ha7n
         cMiy5ZmWRdNRpJb0rbYj4fw6V8a/iT7aNdhLKwCSExxLyPdnUotk4s7EgsvBjhEdOGxk
         Uw9uqrduTMdFcNUiZKKcIt0bAhVJvdBBncxkj0VS03cu13tZ1cpkCZnh4hhq1hg3XW/p
         EeDDBhTLY6DTF0skx17cxW/8/XTh21JVxjLbcsXDpJTH1Pirzk4nLDhz2/VFXbozuNGE
         qFqQ==
X-Gm-Message-State: AOAM533MxSRXi7Edm0WJFUe7xlEQg7dFlESeoV8FujiECzdbNijcEPDb
        iuAmWq99tOYicwLkpqf+RsftqwpGFz8lmIftG1g=
X-Google-Smtp-Source: ABdhPJzZcVLOxoEtCvLkc8YlX5pyzDZ1mwt508MgLCDOBI2XLztlp2Cl+NX1qB2Slxe1KWjMfop1B3YupI1tSglQkgo=
X-Received: by 2002:a37:7c81:: with SMTP id x123mr1137562qkc.383.1604504223836;
 Wed, 04 Nov 2020 07:37:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603460665.git.josef@toxicpanda.com> <129622d0259e8e3209d4c9f9fe9a44e58a011b93.1603460665.git.josef@toxicpanda.com>
In-Reply-To: <129622d0259e8e3209d4c9f9fe9a44e58a011b93.1603460665.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 4 Nov 2020 15:36:52 +0000
Message-ID: <CAL3q7H6q35g5cYigKuyO46L+fAZJdf_rmsOKzwQ60ATHeXKjwA@mail.gmail.com>
Subject: Re: [PATCH 3/8] btrfs: explicitly protect ->last_byte_to_unpin in unpin_extent_range
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 23, 2020 at 5:12 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Currently unpin_extent_range happens in the transaction commit context,
> so we are protected from ->last_byte_to_unpin changing while we're
> unpinning, because any new transactions would have to wait for us to
> complete before modifying ->last_byte_to_unpin.
>
> However in the future we may want to change how this works, for instance
> with async unpinning or other such TODO items.  To prepare for that
> future explicitly protect ->last_byte_to_unpin with the commit_root_sem
> so we are sure it won't change while we're doing our work.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Ok, looks good, thanks.

> ---
>  fs/btrfs/extent-tree.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index ee7bceace8b3..5d3564b077bf 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2791,11 +2791,13 @@ static int unpin_extent_range(struct btrfs_fs_inf=
o *fs_info,
>                 len =3D cache->start + cache->length - start;
>                 len =3D min(len, end + 1 - start);
>
> +               down_read(&fs_info->commit_root_sem);
>                 if (start < cache->last_byte_to_unpin && return_free_spac=
e) {
>                         u64 add_len =3D min(len,
>                                           cache->last_byte_to_unpin - sta=
rt);
>                         btrfs_add_free_space(cache, start, add_len);
>                 }
> +               up_read(&fs_info->commit_root_sem);
>
>                 start +=3D len;
>                 total_unpinned +=3D len;
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
