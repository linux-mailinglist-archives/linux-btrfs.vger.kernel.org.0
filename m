Return-Path: <linux-btrfs+bounces-18797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0EAC3FE23
	for <lists+linux-btrfs@lfdr.de>; Fri, 07 Nov 2025 13:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED833AEA25
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Nov 2025 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D013529BD95;
	Fri,  7 Nov 2025 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZSiMdnZX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DF28C014
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517980; cv=none; b=eu1QrAMzwyxcxmBr4psN9pTnvwa9wUfJuJaOvfjh+vzBBw7KiQInJ6ODy313mynvB12aPp0DQlvLcsUBnh1uwT/Zfjo813bEoVx3d6OSVjCIZ8lehX9pExMLav9HQ2TDSzzb0SBsdWLNAwJ3Rqn8Z/2gFKyqML6VONoAbK5nRV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517980; c=relaxed/simple;
	bh=tYiZvvS9Heus934i97ls154pSqby0o45QipVG5VEhGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaRQ2CGhx7fuW4zAQVnX1gFJw34BPPg2047UXmPJz0YrLvukMyWwmvYOA8NbpXdJvsx8g0nqZlnL0owiuEgWrS+GNJxB00zi00+fbT0SEj6WupyAkKNVAJ25zEbsFLwTiMLUCqTUHIJb2JUHoeEBYSkSEbHpc9yPmtAKHmOT4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZSiMdnZX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775638d819so3798405e9.1
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Nov 2025 04:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762517975; x=1763122775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fCH9urCYEJXt1gARaqy/f2IbxslywgtM97/AXM9iUbY=;
        b=ZSiMdnZXYexGEU7xMh2Zb3ftGMDyWZxGXm5ZraV7LVaxQ7/VLhkOg5frGZPZbcwpMn
         oOajkVFcBHpVLmx2zqX7AYWA2wm7hox7+OORB+XvG+c+NJ4BWQx+52r/DsWiRZD2DDrK
         JBu0Xs3IkgtS1GtYheRZSEw+ClEnjI3Gke1b8iV7Fb37PMLP/sdsgbz7HFVRq0V1nH07
         OSoLJTfVLbj/PQA5F4YzDZvVXRRJHCGE/G4DKHHj6jPEHT1PTGxYWu8apAGKqZ4nroLi
         nehD8ZwHOuCG+pvSSxJ3rFwQ2ZkInx56bbwIrLQOonAWNhcGY0TRSk2nW6FxrFkCu1YB
         tBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762517975; x=1763122775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCH9urCYEJXt1gARaqy/f2IbxslywgtM97/AXM9iUbY=;
        b=j38QQ2J0ryvxKnP4e5m5RftXHC3ghCWoTR8cw5ot2NCb6vlFpeDNQaFRjAm/3+H0sD
         bbl6wdShdZOG+ZOqiEFsziR/XqFU2b+xVhWMIXWKeXR+9duUBGCakzkQkdppmSbR2xw8
         Ebe92ANuDT+2Q7sA6uxY1Ai2MJvpjzYnqJu77GnX3CeLQM5UJdRfC1RqhVKKw3H9ToNy
         /V0bwYOHuttIE8N0oLsYlxOAw17VDeQP//JHJv2Px2/CkiaAjYzX4JgOaNgnyEqfeTPi
         Nt4zirUKeANU0CPXokF1NaERbFFM7blbk+yb48ABCMT7t4JYuD70sP33/dSaL8W0ZmTe
         PvvQ==
X-Gm-Message-State: AOJu0YyKV7wzXdLJ+Y2jpu2MlN/CtXco13VaIOSrgesOyeaZioKz9iHh
	LEd6m7WYbFpyJ7KNmH6eLkJoP4HRUnYXe15F5N0v276qLx5FTfLUalKrZ44705NcH7lrKO206su
	NlB0inFp1osrOjkRl6q9uYpVGp0Uwpo1QQh/3hmXd/hMCFaWj6Rjai6A=
X-Gm-Gg: ASbGncs9vOHQ1mjebipcXOdX9i0zhAz7T+WaVb+SmjZ/2fVhVvDtjBy3tTrBEbYaKpA
	3HUNVduAVv+yqlU7d38YBuPQRWOoxU0KtxPDlaltv+zm0me8QDercwjffey3ESr0hmmOEGLIicU
	DG07dm1zwag5Ao6FJPwY8fCCafMvSqpe9rmZ3pkWKIUJNWCMk6xL4y3SMssKy7dBeUyf85Z2qTb
	kM67Uw2Sm/HsierVT9XJ1mqWC+fS33cIANPIUPELUeYuxSTu926mGcwnhwvb91PfSFzMEzyrtsX
	KqsRgzQw+9uj9ckZ8yH+UviwtBWR87rqy0NleI1nuysifoHThd9S+XO7+Q==
X-Google-Smtp-Source: AGHT+IFq7RTz5BH1UHHsmH+oVE7fshxWj4fMlMz9rW9InpXm8u52oOOXfhBMvKI8tXE+DwWuxVWecDxG5cBFg4PK59I=
X-Received: by 2002:a05:600c:1d10:b0:46f:b42e:e366 with SMTP id
 5b1f17b1804b1-4776bcca384mr27045405e9.40.1762517975335; Fri, 07 Nov 2025
 04:19:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <58baf1fc6d077aacc5db3b2bf42677fc3fbbb6a8.1762503411.git.wqu@suse.com>
In-Reply-To: <58baf1fc6d077aacc5db3b2bf42677fc3fbbb6a8.1762503411.git.wqu@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 7 Nov 2025 13:19:24 +0100
X-Gm-Features: AWmQ_blPNcRBGgJIuCt0jMZrjaw3ItRGgvVeC68SKX9cbmFzwHNZz79BMPDnvNE
Message-ID: <CAPjX3FdP4=NgEASSh+oOTAkWgggd98Zbhs=XU9chF364m573xQ@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: use guard for btrfs_folio_state::lock
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Nov 2025 at 09:18, Qu Wenruo <wqu@suse.com> wrote:
>
> Most call sites are fine for a simple guard(), some call sites need
> scoped_guard().
>
> For the scoped_guard() usage, it increase one indent for the code,
> personally speaking I like the extra indent to make the critical section
> more obvious, but I also understand not all call site can afford the
> extra indent.
>
> Thankfully for subpage cases, it's completely fine.
>
> Overall this makes code much shorter, and we can return without
> bothering manually unlocking, saving several temporary variables.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> We're still not yet determined if we should brace the new auto-cleanup
> scheme.
>
> Now I'm completely on the boat of the scoped based auto-cleanup, even
> for the subpage code where the lock is already super straightforward.
> For more complex cases the benefit will be more obvious.
>
> So far the only disadvantage is my old mindset, but I believe time will
> get it fixed.
> ---
>  fs/btrfs/subpage.c | 112 +++++++++++++++------------------------------
>  1 file changed, 36 insertions(+), 76 deletions(-)
>
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 80cd27d3267f..85d44a6ece87 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -225,14 +225,12 @@ static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
>         struct btrfs_folio_state *bfs = folio_get_private(folio);
>         const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
>         const int nbits = (len >> fs_info->sectorsize_bits);
> -       unsigned long flags;
>         unsigned int cleared = 0;
>         int bit = start_bit;
> -       bool last;
>
>         btrfs_subpage_assert(fs_info, folio, start, len);
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> +       guard(spinlock_irqsave)(&bfs->lock);
>         /*
>          * We have call sites passing @lock_page into
>          * extent_clear_unlock_delalloc() for compression path.
> @@ -240,19 +238,15 @@ static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
>          * This @locked_page is locked by plain lock_page(), thus its
>          * subpage::locked is 0.  Handle them in a special way.
>          */
> -       if (atomic_read(&bfs->nr_locked) == 0) {
> -               spin_unlock_irqrestore(&bfs->lock, flags);
> +       if (atomic_read(&bfs->nr_locked) == 0)
>                 return true;
> -       }
>
>         for_each_set_bit_from(bit, bfs->bitmaps, start_bit + nbits) {
>                 clear_bit(bit, bfs->bitmaps);
>                 cleared++;
>         }
>         ASSERT(atomic_read(&bfs->nr_locked) >= cleared);
> -       last = atomic_sub_and_test(cleared, &bfs->nr_locked);
> -       spin_unlock_irqrestore(&bfs->lock, flags);
> -       return last;
> +       return atomic_sub_and_test(cleared, &bfs->nr_locked);
>  }
>
>  /*
> @@ -307,7 +301,6 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
>         struct btrfs_folio_state *bfs = folio_get_private(folio);
>         const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
>         const int start_bit = blocks_per_folio * btrfs_bitmap_nr_locked;
> -       unsigned long flags;
>         bool last = false;
>         int cleared = 0;
>         int bit;
> @@ -323,14 +316,14 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
>                 return;
>         }
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> -       for_each_set_bit(bit, &bitmap, blocks_per_folio) {
> -               if (test_and_clear_bit(bit + start_bit, bfs->bitmaps))
> -                       cleared++;
> +       scoped_guard(spinlock_irqsave, &bfs->lock) {
> +               for_each_set_bit(bit, &bitmap, blocks_per_folio) {
> +                       if (test_and_clear_bit(bit + start_bit, bfs->bitmaps))
> +                               cleared++;
> +               }
> +               ASSERT(atomic_read(&bfs->nr_locked) >= cleared);
> +               last = atomic_sub_and_test(cleared, &bfs->nr_locked);
>         }
> -       ASSERT(atomic_read(&bfs->nr_locked) >= cleared);
> -       last = atomic_sub_and_test(cleared, &bfs->nr_locked);
> -       spin_unlock_irqrestore(&bfs->lock, flags);
>         if (last)
>                 folio_unlock(folio);

This is really different to the well known and established linear code style.

One idea - how about closing the scope with something like:

        } /* bfs->lock restore irq */

But then we're close to back to before. So what's the added value? Is
there any reason for this change? I guess that's the best question.
Simply, why?

I'm not sure the scope_guard is worth it here.

But I'm sure I can get used to the change if we really need it.

Finally, my take would be to stay away from using the guards style
unless absolutely needed. They hardly solve any real issue. So far we
were perfectly fine without them and we did not miss them. Or did we?

--nX

>  }
> @@ -359,13 +352,11 @@ void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
>         struct btrfs_folio_state *bfs = folio_get_private(folio);
>         unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
>                                                         uptodate, start, len);
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> +       guard(spinlock_irqsave)(&bfs->lock);
>         bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
>         if (subpage_test_bitmap_all_set(fs_info, folio, uptodate))
>                 folio_mark_uptodate(folio);
> -       spin_unlock_irqrestore(&bfs->lock, flags);
>  }

Here I'd add a blank like after the guard. Kind of making it like a
variable declaration.

ditto. for the other changes below.

>  void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
> @@ -374,12 +365,10 @@ void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
>         struct btrfs_folio_state *bfs = folio_get_private(folio);
>         unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
>                                                         uptodate, start, len);
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> +       guard(spinlock_irqsave)(&bfs->lock);
>         bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
>         folio_clear_uptodate(folio);
> -       spin_unlock_irqrestore(&bfs->lock, flags);
>  }
>
>  void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
> @@ -388,11 +377,9 @@ void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
>         struct btrfs_folio_state *bfs = folio_get_private(folio);
>         unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
>                                                         dirty, start, len);
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> -       bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
> -       spin_unlock_irqrestore(&bfs->lock, flags);
> +       scoped_guard(spinlock_irqsave, &bfs->lock)
> +               bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
>         folio_mark_dirty(folio);
>  }
>
> @@ -412,15 +399,12 @@ bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
>         struct btrfs_folio_state *bfs = folio_get_private(folio);
>         unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
>                                                         dirty, start, len);
> -       unsigned long flags;
> -       bool last = false;
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> +       guard(spinlock_irqsave)(&bfs->lock);
>         bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
>         if (subpage_test_bitmap_all_zero(fs_info, folio, dirty))
> -               last = true;
> -       spin_unlock_irqrestore(&bfs->lock, flags);
> -       return last;
> +               return true;
> +       return false;
>  }
>
>  void btrfs_subpage_clear_dirty(const struct btrfs_fs_info *fs_info,
> @@ -439,10 +423,9 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
>         struct btrfs_folio_state *bfs = folio_get_private(folio);
>         unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
>                                                         writeback, start, len);
> -       unsigned long flags;
>         bool keep_write;
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> +       guard(spinlock_irqsave)(&bfs->lock);
>         bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
>
>         /*
> @@ -454,7 +437,6 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
>         keep_write = folio_test_dirty(folio);
>         if (!folio_test_writeback(folio))
>                 __folio_start_writeback(folio, keep_write);
> -       spin_unlock_irqrestore(&bfs->lock, flags);
>  }
>
>  void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
> @@ -463,15 +445,13 @@ void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
>         struct btrfs_folio_state *bfs = folio_get_private(folio);
>         unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
>                                                         writeback, start, len);
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> +       guard(spinlock_irqsave)(&bfs->lock);
>         bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
>         if (subpage_test_bitmap_all_zero(fs_info, folio, writeback)) {
>                 ASSERT(folio_test_writeback(folio));
>                 folio_end_writeback(folio);
>         }
> -       spin_unlock_irqrestore(&bfs->lock, flags);
>  }
>
>  void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
> @@ -480,12 +460,10 @@ void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
>         struct btrfs_folio_state *bfs = folio_get_private(folio);
>         unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
>                                                         ordered, start, len);
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> +       guard(spinlock_irqsave)(&bfs->lock);
>         bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
>         folio_set_ordered(folio);
> -       spin_unlock_irqrestore(&bfs->lock, flags);
>  }
>
>  void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
> @@ -494,13 +472,11 @@ void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
>         struct btrfs_folio_state *bfs = folio_get_private(folio);
>         unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
>                                                         ordered, start, len);
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> +       guard(spinlock_irqsave)(&bfs->lock);
>         bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
>         if (subpage_test_bitmap_all_zero(fs_info, folio, ordered))
>                 folio_clear_ordered(folio);
> -       spin_unlock_irqrestore(&bfs->lock, flags);
>  }
>
>  void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
> @@ -509,13 +485,11 @@ void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
>         struct btrfs_folio_state *bfs = folio_get_private(folio);
>         unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
>                                                         checked, start, len);
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> +       guard(spinlock_irqsave)(&bfs->lock);
>         bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
>         if (subpage_test_bitmap_all_set(fs_info, folio, checked))
>                 folio_set_checked(folio);
> -       spin_unlock_irqrestore(&bfs->lock, flags);
>  }
>
>  void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
> @@ -524,12 +498,10 @@ void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
>         struct btrfs_folio_state *bfs = folio_get_private(folio);
>         unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
>                                                         checked, start, len);
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> +       guard(spinlock_irqsave)(&bfs->lock);
>         bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
>         folio_clear_checked(folio);
> -       spin_unlock_irqrestore(&bfs->lock, flags);
>  }
>
>  /*
> @@ -543,14 +515,10 @@ bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,       \
>         struct btrfs_folio_state *bfs = folio_get_private(folio);       \
>         unsigned int start_bit = subpage_calc_start_bit(fs_info, folio, \
>                                                 name, start, len);      \
> -       unsigned long flags;                                            \
> -       bool ret;                                                       \
>                                                                         \
> -       spin_lock_irqsave(&bfs->lock, flags);                   \
> -       ret = bitmap_test_range_all_set(bfs->bitmaps, start_bit,        \
> +       guard(spinlock_irqsave)(&bfs->lock);                            \
> +       return bitmap_test_range_all_set(bfs->bitmaps, start_bit,       \
>                                 len >> fs_info->sectorsize_bits);       \
> -       spin_unlock_irqrestore(&bfs->lock, flags);                      \
> -       return ret;                                                     \
>  }
>  IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(uptodate);
>  IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(dirty);
> @@ -688,7 +656,6 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
>         struct btrfs_folio_state *bfs;
>         unsigned int start_bit;
>         unsigned int nbits;
> -       unsigned long flags;
>
>         if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
>                 return;
> @@ -702,13 +669,12 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
>         nbits = len >> fs_info->sectorsize_bits;
>         bfs = folio_get_private(folio);
>         ASSERT(bfs);
> -       spin_lock_irqsave(&bfs->lock, flags);
> +       guard(spinlock_irqsave)(&bfs->lock);
>         if (unlikely(!bitmap_test_range_all_zero(bfs->bitmaps, start_bit, nbits))) {
>                 SUBPAGE_DUMP_BITMAP(fs_info, folio, dirty, start, len);
>                 ASSERT(bitmap_test_range_all_zero(bfs->bitmaps, start_bit, nbits));
>         }
>         ASSERT(bitmap_test_range_all_zero(bfs->bitmaps, start_bit, nbits));
> -       spin_unlock_irqrestore(&bfs->lock, flags);
>  }
>
>  /*
> @@ -722,7 +688,6 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
>                           struct folio *folio, u64 start, u32 len)
>  {
>         struct btrfs_folio_state *bfs;
> -       unsigned long flags;
>         unsigned int start_bit;
>         unsigned int nbits;
>         int ret;
> @@ -734,7 +699,7 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
>         bfs = folio_get_private(folio);
>         start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
>         nbits = len >> fs_info->sectorsize_bits;
> -       spin_lock_irqsave(&bfs->lock, flags);
> +       guard(spinlock_irqsave)(&bfs->lock);
>         /* Target range should not yet be locked. */
>         if (unlikely(!bitmap_test_range_all_zero(bfs->bitmaps, start_bit, nbits))) {
>                 SUBPAGE_DUMP_BITMAP(fs_info, folio, locked, start, len);
> @@ -743,7 +708,6 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
>         bitmap_set(bfs->bitmaps, start_bit, nbits);
>         ret = atomic_add_return(nbits, &bfs->nr_locked);
>         ASSERT(ret <= btrfs_blocks_per_folio(fs_info, folio));
> -       spin_unlock_irqrestore(&bfs->lock, flags);
>  }
>
>  /*
> @@ -779,21 +743,19 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
>         unsigned long ordered_bitmap;
>         unsigned long checked_bitmap;
>         unsigned long locked_bitmap;
> -       unsigned long flags;
>
>         ASSERT(folio_test_private(folio) && folio_get_private(folio));
>         ASSERT(blocks_per_folio > 1);
>         bfs = folio_get_private(folio);
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> -       GET_SUBPAGE_BITMAP(fs_info, folio, uptodate, &uptodate_bitmap);
> -       GET_SUBPAGE_BITMAP(fs_info, folio, dirty, &dirty_bitmap);
> -       GET_SUBPAGE_BITMAP(fs_info, folio, writeback, &writeback_bitmap);
> -       GET_SUBPAGE_BITMAP(fs_info, folio, ordered, &ordered_bitmap);
> -       GET_SUBPAGE_BITMAP(fs_info, folio, checked, &checked_bitmap);
> -       GET_SUBPAGE_BITMAP(fs_info, folio, locked, &locked_bitmap);
> -       spin_unlock_irqrestore(&bfs->lock, flags);
> -
> +       scoped_guard(spinlock_irqsave, &bfs->lock) {
> +               GET_SUBPAGE_BITMAP(fs_info, folio, uptodate, &uptodate_bitmap);
> +               GET_SUBPAGE_BITMAP(fs_info, folio, dirty, &dirty_bitmap);
> +               GET_SUBPAGE_BITMAP(fs_info, folio, writeback, &writeback_bitmap);
> +               GET_SUBPAGE_BITMAP(fs_info, folio, ordered, &ordered_bitmap);
> +               GET_SUBPAGE_BITMAP(fs_info, folio, checked, &checked_bitmap);
> +               GET_SUBPAGE_BITMAP(fs_info, folio, locked, &locked_bitmap);
> +       }
>         dump_page(folio_page(folio, 0), "btrfs folio state dump");
>         btrfs_warn(fs_info,
>  "start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl dirty=%*pbl locked=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
> @@ -811,13 +773,11 @@ void btrfs_get_subpage_dirty_bitmap(struct btrfs_fs_info *fs_info,
>                                     unsigned long *ret_bitmap)
>  {
>         struct btrfs_folio_state *bfs;
> -       unsigned long flags;
>
>         ASSERT(folio_test_private(folio) && folio_get_private(folio));
>         ASSERT(btrfs_blocks_per_folio(fs_info, folio) > 1);
>         bfs = folio_get_private(folio);
>
> -       spin_lock_irqsave(&bfs->lock, flags);
> +       guard(spinlock_irqsave)(&bfs->lock);
>         GET_SUBPAGE_BITMAP(fs_info, folio, dirty, ret_bitmap);
> -       spin_unlock_irqrestore(&bfs->lock, flags);
>  }
> --
> 2.51.2
>
>

