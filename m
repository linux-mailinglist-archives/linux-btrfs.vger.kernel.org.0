Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEF13F47E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhHWJpC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 05:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhHWJpC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 05:45:02 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E563CC061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 02:44:19 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 14so18517452qkc.4
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=T0eUkdXGxIxegYWbYcV/qDT4mo91cIbyDaySCKqFJNc=;
        b=A4YhXspis1/U3RfYoaMZrFLtqQGSqd75ALsprAqh24qQ8NS4cZRfZtffMvBGrzMRYV
         nPCPs5KbhrcAdiTNqdzj7DOLRfzcHxJ4NY8UrCX05z+xRiV7zGdV4pdyc0FGm481LWt/
         pepPSwLHlToH388YgA8IpxSKsrBXpMfiFZhZHUq4GN5cgeOfsYIQUeY3mAVY38WHc0kd
         Em+Hf4EnlWtorkgaml8q8tlFZiOq8/x/6CxRyEsVq8Sl6SO5/J2FYW+IS5s2pqh7uK3c
         QM36Ll3SFjyJoeUKyOtwUsSg+fEqb4DYBkLeM6c/DgPXtbF3Q0MgKA6SK/SGSrlC1HQf
         G1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=T0eUkdXGxIxegYWbYcV/qDT4mo91cIbyDaySCKqFJNc=;
        b=QGRbr5k9sYrdfrt5YgDFVTg9ohtfoIwzC03xxUntMXJcvwRvyZcLc2vz93HJNFb8M2
         /xJ5JHK0R7e6Wye6xdBeuqVcwt6lPsvZSpF+qdfPMz3qiItF5LwHTeeKZwc4EajmdYHq
         68kH+flScRyMoBYPDScU0heMmylOx+pQaoTmlcLUtmHB2TmbvR1B2dGDIw6OnQHsNuJH
         vuf9VS1zP7S5yCccWsEzJTJJAjHFdmRL2u/hGaE2zBg1cCP7GSHLf68pFEvOs8gMhw5n
         uzchdMibOJQNhbWM2BxM+vdP95d6Up+FHvlLPSpSaAkaOwlMQdUVgxEBQJVGs/22cUNR
         JUYw==
X-Gm-Message-State: AOAM5320vGVrIvUZL0TLRK6goCk8YgykFVYPzQXetyvF/LwBe8n1MBFz
        Ld6IHuUJWItfQO3p5yu3k49AnklZh/qVREokslM=
X-Google-Smtp-Source: ABdhPJz0h2FJpu/Cl7hIHGgtemIfSOq032GgLsp4ZlgcSthkV6eVJO1xxlPi73km1s45Q7jjM4uSxUFGpyT8kA9GspU=
X-Received: by 2002:a37:607:: with SMTP id 7mr20868578qkg.0.1629711859135;
 Mon, 23 Aug 2021 02:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210820004100.35823-1-realwakka@gmail.com>
In-Reply-To: <20210820004100.35823-1-realwakka@gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 23 Aug 2021 10:44:08 +0100
Message-ID: <CAL3q7H5UvRXk7TLQOt-bnkN4Tca-v7c6JBW6vz90KEaYJuMp1g@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: reflink: Initialize return value in btrfs_extent_same()
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 20, 2021 at 1:42 AM Sidong Yang <realwakka@gmail.com> wrote:
>
> btrfs_extent_same() cannot be called with zero length. This patch add
> code that initialize ret as -EINVAL to make it safe.

I suppose the motivation of the patch is to fix a warning from smatch,
or other similar tools, about 'ret' not being initialized when olen is
0.
Initializing 'ret' to some value surely makes the warning go away,
even though it's not possible for olen to be 0 at btrfs_extent_same(),
as that
is filtered up in the call chain.

However setting to -EINVAL by default is confusing and counter
intuitive because dedupe operations are supposed to return 0 (success)
for a 0 length range.
So 'ret' should be initialized to 0 to avoid any confusion.

Thanks.

>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v2:
>  - Removed assert and added initializing ret
> ---
>  fs/btrfs/reflink.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 9b0814318e72..864f42198c5c 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -653,6 +653,7 @@ static int btrfs_extent_same(struct inode *src, u64 l=
off, u64 olen,
>         u64 i, tail_len, chunk_count;
>         struct btrfs_root *root_dst =3D BTRFS_I(dst)->root;
>
> +       ret =3D -EINVAL;
>         spin_lock(&root_dst->root_item_lock);
>         if (root_dst->send_in_progress) {
>                 btrfs_warn_rl(root_dst->fs_info,
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
