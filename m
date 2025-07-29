Return-Path: <linux-btrfs+bounces-15742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F62B1546A
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 22:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D49E97A77CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 20:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F0277CA9;
	Tue, 29 Jul 2025 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktaK16OR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436E136348
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753822168; cv=none; b=iKPLUJP+gDJ6vM/nPaOxzfDCQVuXv+lJ8JmbJF16esVfCNP4iHumc+CcBXEcEMSc/gbXZgA+5Y47fUEE3NoMIXB5vxz5vGOHjo3zjsJriCry8bq7LTYKHG0sTm2EK7pFfQ/ZivyH0Sn5MgNx43yCE5RQ+qf/pE1xYoCHxbjDdWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753822168; c=relaxed/simple;
	bh=500f+40Pf2nXD96ty3u9oYCew2lsNNdS8De6nTRIJRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXi87dpCi1d4CG58lttLyKe6/3RH1qnyuyAN1EJN8O2vLjeb1exHNUvnTbzVPxdXaWX2DCUPWbgVQTFTVw0oKZ3zwzBMkRbcHPfneN6CimU66IKUEdzolA+wEWwjG2dj7yCETxdmXix0t+k8QYe9D20vjYSO2+vxf3i52DM9OSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktaK16OR; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e740a09eae0so5504201276.1
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 13:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753822166; x=1754426966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTUCgrNeeXvGeGKFUShMjzDrthQo9NVK40bDVAuQOL4=;
        b=ktaK16ORFqKdBkyub45sYqgPuqYUyErpJybSuaGYxoV9v2kajMxa4R3Rljt9FxlDKm
         47aMGXRQRDPINkbwsyHSN3nyicwD8zmgk0lhDwAJh5XiWVcYv45SJtKJG3rxhMk87OAy
         8p4+s6jDEv5maQ2ETiz6Jkj5yl6wNR+wP31XyWvkhAfirXyN952IvBYwkj6prNEwHRTY
         eXCG3DqIVqO5vLzDNEW3lgrkEmFS2C8T8RcvgQynOhrzBL+hKsIjk+OkQc1Q2S6ELpU/
         AQQJy+hxRIgRZ9mQIPJWFnYaRYDlqcNaQ3UjexFIk8nr94SZPLQqIAbZd1vGK083xAOr
         /f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753822166; x=1754426966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTUCgrNeeXvGeGKFUShMjzDrthQo9NVK40bDVAuQOL4=;
        b=twCUknX8VRXVERz1SCkR1C/SYXC5qFAP87BK3ZfJBtWanou8UOLNIk3OXCCIAGErnF
         Ef6dcik0T+XW3kYTYUxbBnpb9L+Gf/OG7H6N4dwic0nUp5oijg1wUT6LnaIblDSacMKx
         HivH2kCtsR8VUdo/z+JrRK8SvWtKJ5JSLZOEI4bZjsY77R+69H4L930xLuFZS8zyX5nz
         9lpOPxJQHOdJt1gA0oYIIR+08oasH7gMgtKm5mLRSF0C7LdRL0bQiAKAvvjdbl7D54CY
         XpPNRdk5bGpdNykJM0m1fvg0MRORpNm1ZT5QhBMmFvSgvv6fAzSd9FFXLCmWdcv5IysX
         V/fA==
X-Gm-Message-State: AOJu0YwdzhlMkE8EnN2Fae+//3qzENQVg53qJMnmbcfUjjY4Y9pNyVW+
	wt9Mnm+HW6Ua1lwminf9b7+v854XLgdjQRCNuRE6znnrgqltRxxxosi9
X-Gm-Gg: ASbGncuW0FzGGscIUpoc5dyQHNOIIQgn9wLcO/aTFJNdnpTJsagAj4KF1Q+vE4QoXXQ
	IpHhy1BNBhwLHYSIPyTVOgpqaQT9we2DE0S3x2rPGxVYWbo2W2QoPK/z9f2JG6y0cKEjrkblWjx
	tff4mWHcVxKbRZGZDegnRikSsJXLhnyOHmc388o+DfO7RP23oeCB0klS8Ah0HczJg2gIagO/Ou7
	MF6W8qPs0KiQ5wDAT0+4W7etLBhcz6ibudeXKH998ovuG+aH6OWH4054s8tWjl61A4cTMXKc2Lw
	S4rYa/DWoiMd4FtC8eCotdvmohknD1b4N4xP9bAuWB9B10th+NLFKpCcZp5BdtfuxAaHZCawZN+
	EokF9Qt5u9v+v0KI7ug==
X-Google-Smtp-Source: AGHT+IG/QRlmBGHZOx6F7vFwexO58Aw6rHL7kDBrTdKh7JbwPMCKEweXOdQKDyFCTVhFpBYFfQu5cg==
X-Received: by 2002:a05:690c:3613:b0:71a:32b1:b6b4 with SMTP id 00721157ae682-71a466cb830mr18462397b3.36.1753822165670;
        Tue, 29 Jul 2025 13:49:25 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71a44bd9669sm2480227b3.26.2025.07.29.13.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 13:49:25 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: clear block dirty if submit_one_sector() failed
Date: Tue, 29 Jul 2025 13:49:12 -0700
Message-ID: <20250729204922.3820916-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c4e6696127d2205d7faef094e0b951ca88098410.1753781242.git.wqu@suse.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Jul 2025 19:01:45 +0930 Qu Wenruo <wqu@suse.com> wrote:

> [BUG]
> If submit_one_sector() failed, the block will be kept dirty, but with
> their corresponding range finished in the ordered extent.
> 
> This means if later a writeback happens again, we can hit the following
> problems:
> 
> - ASSERT(block_start != EXTENT_MAP_HOLE) in submit_one_sector()
>   If the original extent map is a hole, then we can hit this case, as
>   the new ordered extent failed, we will drop the new extent map and
>   re-read one from the disk.
> 
> - DEBUG_WARN() in btrfs_writepage_cow_fixup()
>   This is because we no longer have an ordered extent for those dirty
>   blocks. The original for them is already finished with error.
> 
> [CAUSE]
> The function submit_one_sector() is not following the regular error
> handling of writeback.
> The common practice is to clear the folio dirty, start and finish the
> writeback for the block.
> 
> This is normally done by extent_clear_unlock_delalloc() with
> PAGE_START_WRITEBACK | PAGE_END_WRITEBACK flags during
> run_delalloc_range().
> 
> So if we keep those failed blocks dirty, they will stay in the page
> cache and wait for the next writeback.
> 
> And since the original ordered extent is already finished and removed,
> depending on the original extent map, we either hit the ASSERT() inside
> submit_one_sector(), or hit the DEBUG_WARN() in
> btrfs_writepage_cow_fixup().
> 
> [FIX]
> Follow the regular error handling to clear the dirty flag for the block,
> start and finish writeback for that block instead.

Might be a dumb question, but if the page failed to finish writeback why
are we allowed to clear the dirty flag? Wouldn't the page still have dirty
data?

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c11c93bcc7f6..f6765ddab4a7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1548,7 +1548,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>  
>  /*
>   * Return 0 if we have submitted or queued the sector for submission.
> - * Return <0 for critical errors.
> + * Return <0 for critical errors, and the sector will have its dirty flag cleared.
>   *
>   * Caller should make sure filepos < i_size and handle filepos >= i_size case.
>   */
> @@ -1571,8 +1571,19 @@ static int submit_one_sector(struct btrfs_inode *inode,
>  	ASSERT(filepos < i_size);
>  
>  	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
> -	if (IS_ERR(em))
> -		return PTR_ERR(em);
> +	if (IS_ERR(em)) {
> +		int ret = PTR_ERR(em);
> +
> +		/*
> +		 * When submission failed, we should still clear the folio dirty.
> +		 * Or the folio will be written back again but without any
> +		 * ordered extent.
> +		 */
> +		btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
> +		btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
> +		btrfs_folio_clear_writeback(fs_info, folio, filepos, sectorsize);
> +		return ret;
> +	}
>  
>  	extent_offset = filepos - em->start;
>  	em_end = btrfs_extent_map_end(em);
> @@ -1702,8 +1713,9 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>  	 * Here we set writeback and clear for the range. If the full folio
>  	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
>  	 *
> -	 * If we hit any error, the corresponding sector will still be dirty
> -	 * thus no need to clear PAGECACHE_TAG_DIRTY.
> +	 * If we hit any error, the corresponding sector will still have its
> +	 * dirty flag cleared and finish writeback just like below, thus
> +	 * no need to handle error case either.
>  	 */
>  	if (!submitted_io && !error) {
>  		btrfs_folio_set_writeback(fs_info, folio, start, len);
> -- 
> 2.50.1

Sent using hkml (https://github.com/sjp38/hackermail)

