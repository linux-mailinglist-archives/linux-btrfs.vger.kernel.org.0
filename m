Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005E6147A5F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 10:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgAXJ2l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 04:28:41 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42198 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXJ2l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 04:28:41 -0500
Received: by mail-ua1-f66.google.com with SMTP id u17so546224uap.9
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 01:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4ZXb8Thzm8cPz4DOP+EZ3V7BUXQde77HrV4ctpuJSRg=;
        b=rdRX5Ru58/VLozXCp27R7kpyYaFGNnAp0BkRzFy408/6NeYnNksXOXB5w+BYyKm8Qi
         8JueTjhiStXgtJeBMt0gSK3vRsEWjw09aBsAuqqPQTKV9XpEThnY9H7SF1ks41CrIina
         t5U+kbPOkGe14+/anE1zqMJvzwPrUf4m+u7LeqrpdgFYGiULAaLZ7xU2jujrqFDvUaaF
         tC3CT8nAX8gyzDBBaaxfCRoqutDcsMOdI7bHqnQCG2xpo9KvIsJWijdbSKyCodUtNyd8
         cWe1zITFLuAID+6U6rJlHNKwMvYYYvYLRZcCuytjLGPPYQSvVxH/F+dWl2y0Kl348bwJ
         5J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4ZXb8Thzm8cPz4DOP+EZ3V7BUXQde77HrV4ctpuJSRg=;
        b=mKKJTItoRsjO+zdWDTCcS3ltXkVLvuvEB1f2O9bdrzY02OMCYXKpKgmUDcK1/1dDum
         hCrH5eWR1vKbYHgS5xfR5x82leDYxzepjPh1JeEgvxhnJIMKe5sJ3J4EavslDwVtqUD0
         GIEje0x0rK8BtKNd1aUME5UQpgWX78PMDf4NFfO1axk+58dHxjZVaawkoHm2Cn1E4G+v
         EnDPthaFY1mzyI4I18FkxiTe7W2iBI1ovYuj25hzJIVUzN3bSO3WTQglrEukNyWA/Bxh
         XZF0w75uJTUcE8/hVv9vKs6gf4gKPa7rODyaUNbBVd9N/FmKd5DN9opxC+rq9RmNdPyr
         WjVg==
X-Gm-Message-State: APjAAAWAIA4goJtSzTfnAVdJM1g0P4cxBsDThX1Nfn4BTLvCSelK4ClJ
        ni3Ra1uGHDrycdIKaqwDyN82p4mRRHLVb4oFp8yDVTg8jdU=
X-Google-Smtp-Source: APXvYqwWaFu8iPllDGGPqxTIHdoa31D9ApgLqZ5aKj6cUNL/BBj8FrlctyzhFl0DLMoHbgPrBV0Cv6maTD5Rr9D+Bjo=
X-Received: by 2002:ab0:738c:: with SMTP id l12mr1186384uap.135.1579858119577;
 Fri, 24 Jan 2020 01:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20200123203302.2180124-1-josef@toxicpanda.com>
In-Reply-To: <20200123203302.2180124-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 24 Jan 2020 09:28:28 +0000
Message-ID: <CAL3q7H53O3Q_0DivEgwZBSRCjdfhNTxGemi4grWzJPzWHueYLg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: flush write bio if we loop in extent_write_cache_pages
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 23, 2020 at 8:51 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> There exists a deadlock with range_cyclic that has existed forever.  If
> we loop around with a bio already built we could deadlock with a writer
> who has the page locked that we're attempting to write but is waiting on
> a page in our bio to be written out.  The task traces are as follows
>
> PID: 1329874  TASK: ffff889ebcdf3800  CPU: 33  COMMAND: "kworker/u113:5"
>  #0 [ffffc900297bb658] __schedule at ffffffff81a4c33f
>  #1 [ffffc900297bb6e0] schedule at ffffffff81a4c6e3
>  #2 [ffffc900297bb6f8] io_schedule at ffffffff81a4ca42
>  #3 [ffffc900297bb708] __lock_page at ffffffff811f145b
>  #4 [ffffc900297bb798] __process_pages_contig at ffffffff814bc502
>  #5 [ffffc900297bb8c8] lock_delalloc_pages at ffffffff814bc684
>  #6 [ffffc900297bb900] find_lock_delalloc_range at ffffffff814be9ff
>  #7 [ffffc900297bb9a0] writepage_delalloc at ffffffff814bebd0
>  #8 [ffffc900297bba18] __extent_writepage at ffffffff814bfbf2
>  #9 [ffffc900297bba98] extent_write_cache_pages at ffffffff814bffbd
>
> PID: 2167901  TASK: ffff889dc6a59c00  CPU: 14  COMMAND:
> "aio-dio-invalid"
>  #0 [ffffc9003b50bb18] __schedule at ffffffff81a4c33f
>  #1 [ffffc9003b50bba0] schedule at ffffffff81a4c6e3
>  #2 [ffffc9003b50bbb8] io_schedule at ffffffff81a4ca42
>  #3 [ffffc9003b50bbc8] wait_on_page_bit at ffffffff811f24d6
>  #4 [ffffc9003b50bc60] prepare_pages at ffffffff814b05a7
>  #5 [ffffc9003b50bcd8] btrfs_buffered_write at ffffffff814b1359
>  #6 [ffffc9003b50bdb0] btrfs_file_write_iter at ffffffff814b5933
>  #7 [ffffc9003b50be38] new_sync_write at ffffffff8128f6a8
>  #8 [ffffc9003b50bec8] vfs_write at ffffffff81292b9d
>  #9 [ffffc9003b50bf00] ksys_pwrite64 at ffffffff81293032
>
> I used drgn to find the respective pages we were stuck on
>
> page_entry.page 0xffffea00fbfc7500 index 8148 bit 15 pid 2167901
> page_entry.page 0xffffea00f9bb7400 index 7680 bit 0 pid 1329874
>
> As you can see the kworker is waiting for bit 0 (PG_locked) on index
> 7680, and aio-dio-invalid is waiting for bit 15 (PG_writeback) on index
> 8148.  aio-dio-invalid has 7680, and the kworker epd looks like the
> following

Probably worth mentioning as well that it waits for writeback of the
page to complete while holding a lock on it (at prepare_pages()).
Anyway, it's a very minor thing and easy to figure that out.

>
> crash> struct extent_page_data ffffc900297bbbb0
> struct extent_page_data {
>   bio =3D 0xffff889f747ed830,
>   tree =3D 0xffff889eed6ba448,
>   extent_locked =3D 0,
>   sync_io =3D 0
> }
>
> and using drgn I walked the bio pages looking for page
> 0xffffea00fbfc7500 which is the one we're waiting for writeback on
>
> bio =3D Object(prog, 'struct bio', address=3D0xffff889f747ed830)
> for i in range(0, bio.bi_vcnt.value_()):
>     bv =3D bio.bi_io_vec[i]
>     if bv.bv_page.value_() =3D=3D 0xffffea00fbfc7500:
>         print("FOUND IT")
>
> which validated what I suspected.
>
> The fix for this is simple, flush the epd before we loop back around to
> the beginning of the file during writeout.
>
> Fixes: b293f02e1423 ("Btrfs: Add writepages support")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

That dgrn, where is it? A quick google search pointed me only to
blockchain stuff on the first page of results.

Thanks.

> ---
>  fs/btrfs/extent_io.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 0b5513f98a67..e3295f2d2975 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4181,7 +4181,16 @@ static int extent_write_cache_pages(struct address=
_space *mapping,
>                  */
>                 scanned =3D 1;
>                 index =3D 0;
> -               goto retry;
> +
> +               /*
> +                * If we're looping we could run into a page that is lock=
ed by a
> +                * writer and that writer could be waiting on writeback f=
or a
> +                * page in our current bio, and thus deadlock, so flush t=
he
> +                * write bio here.
> +                */
> +               ret =3D flush_write_bio(epd);
> +               if (!ret)
> +                       goto retry;
>         }
>
>         if (wbc->range_cyclic || (wbc->nr_to_write > 0 && range_whole))
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
