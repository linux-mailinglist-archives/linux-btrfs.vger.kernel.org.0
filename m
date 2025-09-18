Return-Path: <linux-btrfs+bounces-16916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C749B83265
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 08:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9E33B250D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 06:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79712D7DE0;
	Thu, 18 Sep 2025 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gs+WKVLc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052911E51E0
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177238; cv=none; b=uZvBNXgkTjvUkc+oUOm+Mqs0XrUmGyR6LlPlTvo1T7gCjbOzbGFsU87mgIK1aft8HIkW+4SuBo6Qy1k4Wp9GNonF+UHdDQ4HLXOdAYRTc1YhCpzby2DiSmNj2SBX2A0uDHQe9L2OULEuSrnQY73i+yn54B5KqGJcuQz3Dz2VSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177238; c=relaxed/simple;
	bh=YHeDYaUoZp/U4Wm9MukQB9NfT2AFoOzxhTULquMw1HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEYhxRSzEWaQWVYaLlcdzBOw+igGh+Yf7/S2laVMQwlHyJ0Eh0DeerP1MUxxyY7wYNRoDSieoovlTHnPnPrQ8wRB9JUljADgcXQZbT9VfGs/SCgUltSA1/O7SkRd4UqhaZL44wNs6zwgpIiG/YSKTOI3PajCh590WF9LgAi1sBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gs+WKVLc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3eb08d8d9e7so467669f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758177232; x=1758782032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5vbduuSLVO8f053FIDpujy2LOve0+Iw3Da5QJ4F5fOk=;
        b=Gs+WKVLcjZdhQSJrBFtMfs58mMhxG7IGQuWgMZ82eAiE+xcrN2OoYP3r7Ih0L76Cy6
         HBuUIIGKN3qyzXzoPTsORjC98H78nbyxkKUlyBV/wz2W5lda0Ugl2ZQTKIF3LJ/rdkm+
         OidRc9RUu8KOdTX4CdXbo0l8IE3hdTxdxX7DcPR1sYo02cEV6njaxc8nzi/JZk409YHZ
         5O85Tib3kYKpVDi3I6tO3BSBssCEaJYANyDhK5Ab/rvkHeRlJrjGG64ap2bdxgljJHVd
         aadxarBg22jTCRLILuydv5kqOwXUuYBY7rhzrl82dEjQwjCsNy9p5q7RSokt6mXsGTt7
         1/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758177232; x=1758782032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vbduuSLVO8f053FIDpujy2LOve0+Iw3Da5QJ4F5fOk=;
        b=PB2PdUrhsOsGDknS/e5mfpXT/eR6CKdSQpwXDj1fKF4r5ae1SPt2TpEhQ5UjcYNaQh
         oOKWmcex/B7Myez9RauBTsh1OeNCJM15uCkjt85C/Aiq8uYHd6Nvy1NXiZ8H/iD8iDal
         Mcb5LLOGbXPK7nb3X8JcPIYgDzNEaYgrQ8HIcSAvZ2Sz595IA6DNhAxwaXgUuRMJ4NI0
         OFvAXjQbfUyVNrooBBC395cfZ5k8RKISou7EjcjrylnxJAUBHpDDg+NfvHMS6PRLrEfu
         WJ/19jeQGJiqXC5jUUhdlZTAlkUTGhJcKVXzWLSrW0a2huMkI1zIJQr/vaal9HYKcLd6
         a3Aw==
X-Gm-Message-State: AOJu0YzxQv3JwpIghGzbG8KB347pTaVGMT50F/PpLyH3Uu9qlWHmPrZz
	+ZBVFAQ4h2HZ5hxHeIkwJnsR8GwrFPcdWmRL3kSJ9qlZEeGpf6oVwGozxBgJ2pn2DrN167W7apX
	g9ZW60rEunqdh4/eDAPjACxcH+sgXEOYoa9H1et9jVYuTD0+fNnxh
X-Gm-Gg: ASbGncswgHUzW21lv6eqNEifXHrczV64YFF4mzOiCWWl2CwWtUSy4nhz7YAjFLI6t68
	DgpJqUUfexIQ0b3UDaYIFPQgeEtFvgbMG0T3ZA0g0anO+BwSQ1FJlAL64B7lgs7wqlUT2FntVuq
	g+MdlX7y4P2FqY89Rhr82zvDl4WP/jqHhSzDWAb2D3yVhHAnugh4+lRlOXtUG9m3LKDdXoUm3HO
	GcmWcTfOiVRbM4TlCoPEZjt
X-Google-Smtp-Source: AGHT+IEZWVYYXQ93x0tfOdxNADtZXnBhdnOymoWx7rn+KN19KhyIilC5DpAsNaoqdMsyU4G7SIdOKBpGBs++8Pq6LZo=
X-Received: by 2002:a05:6000:2083:b0:3b9:14f2:7edf with SMTP id
 ffacd0b85a97d-3edd43ac9demr1089338f8f.1.1758177232319; Wed, 17 Sep 2025
 23:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2cb65804f04fa6cc129af20583e2b2ed939ffca.1758150636.git.wqu@suse.com>
In-Reply-To: <d2cb65804f04fa6cc129af20583e2b2ed939ffca.1758150636.git.wqu@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 18 Sep 2025 08:33:41 +0200
X-Gm-Features: AS18NWC2UC4QSs-cRTnOEN7GVjjLHMx9_EfSkKY4xp6I6NA8363mkdM3FfY1XYM
Message-ID: <CAPjX3FeDsfAH_yuE6maD0GF4NVMi6MOLGxrA3h+P1gzvWxv7NA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: return any hit error from extent_writepage_io()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 01:11, Qu Wenruo <wqu@suse.com> wrote:
>
> Since the support of bs < ps support, extent_writepage_io() will submit
> multiple blocks inside the folio.
>
> But if we hit error submitting one sector, but the next sector can still
> be submitted successfully, the function extent_writepage_io() will still
> return 0.
>
> This will make btrfs to silently ignore the error without setting error
> flag for the filemap.
>
> Fix it by recording the first error hit, and always return that value.
>
> Fixes: 8bf334beb349 ("btrfs: fix double accounting race when extent_writepage_io() failed")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

LGTM.

Reviewed-by: Daniel Vacek <neelx@suse.com>

> ---
>  fs/btrfs/extent_io.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 258658856195..5daeb596e99b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1682,7 +1682,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>         struct btrfs_fs_info *fs_info = inode->root->fs_info;
>         unsigned long range_bitmap = 0;
>         bool submitted_io = false;
> -       bool error = false;
> +       int found_error = 0;
>         const u64 folio_start = folio_pos(folio);
>         const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
>         u64 cur;
> @@ -1746,7 +1746,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>                          */
>                         btrfs_mark_ordered_io_finished(inode, folio, cur,
>                                                        fs_info->sectorsize, false);
> -                       error = true;
> +                       if (!found_error)
> +                               found_error = ret;
>                         continue;
>                 }
>                 submitted_io = true;
> @@ -1763,11 +1764,11 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>          * If we hit any error, the corresponding sector will have its dirty
>          * flag cleared and writeback finished, thus no need to handle the error case.
>          */
> -       if (!submitted_io && !error) {
> +       if (!submitted_io && !found_error) {
>                 btrfs_folio_set_writeback(fs_info, folio, start, len);
>                 btrfs_folio_clear_writeback(fs_info, folio, start, len);
>         }
> -       return ret;
> +       return found_error;
>  }
>
>  /*
> --
> 2.50.1
>
>

