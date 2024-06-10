Return-Path: <linux-btrfs+bounces-5614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 831F290296F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 21:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93EA282778
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 19:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7455214D70A;
	Mon, 10 Jun 2024 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TJRFrrQA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A11EB5B
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048431; cv=none; b=R/TdfNMsaBWll/aNANxU1+HO1Ubf7+C1nG0x+x+kjCaO6EeWLZl+v9o4Kc+vkT9FwDOok6+ti4b2MlMNHdo6nz5UjnUZzajManxV5l09KWMuGL61DtMpX4x+OrWP9WiLBOvF5TSWjXP2thFJSGjt20CrWeaGTuRTYoKhfuPDYn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048431; c=relaxed/simple;
	bh=Et5sExLDmsQCTgjEe5G4JdfSv7iOc5BWuOLHcMDX9GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsa2WoeBQ2wWX2TQt37d5BLxCasYJbDLZ+pKi71Gw3cqSp85VuCb2EjI1nQZFWuHUyWlkFeTXysW3CvEYAmUqTfs7plrNSWG7niFCuL4t3m8TEKkuq4UIMUazLnxQmPZIXAgf/SvZ3yzbvM3ugesxZ7SxVtEzmjxF2touBb+c3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=TJRFrrQA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a145e0bb2so53610457b3.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1718048428; x=1718653228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fx/aC0nBAVdRHtO+N8Fa/KCAqCyA4v2vzS0vLVAqKEY=;
        b=TJRFrrQAtzdVNDrfBxD6F1IVWdmbQDcFIYQUx7qMXcYtl0N1cyPFin6NzCU5ViqsY5
         viLtpobSVZoR+G5NrmO669G4jXuoH+ODic4sr/9FJvHDd2Lx6V2gB1BDZggCqVs/kMLi
         ywxoZHaCNPXK/uc17bmU5G42FqxfiHlsgjE5UMhhybGqYz1T8s0w3ymvQXEFoPGJXp/v
         V8ns+LK5/bvR/wWKRmGvctwqX9/4uRdwQKWfyntxcK740uKiczSiSVSqOrDRGfPf1GYK
         SINJsDn029g1Xqtw++sWlUa1d/CMa3J6xnvVMJAhvLUmHXn4eeTceeNaXYpPjXyqmN7k
         1ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718048428; x=1718653228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx/aC0nBAVdRHtO+N8Fa/KCAqCyA4v2vzS0vLVAqKEY=;
        b=Y46STlBMSEDSV/HA8Vb9fGZ29lc77hhCc/E4Y5BdVMWo18egFwiVB+1DeGROJ5DtYi
         MCFY5/7dHRfcIbN95ZvyasSr8pxk2p/pDktN+pznapyQwY4RN1pACXKik06WCfmVQNkL
         h077tB73tw9fHQrPNcayASJRTotZeq6rXkwFSgA/0K4wia6oHclsFNmtqt1uvpjsrPRe
         9olapNVWv8S6LlbfvnAXScfCQwPvtjQuatA5TUEr4HnaOJTr+IMWmEYQ06XZMD7gH+Lq
         j55QUyQ9OxnFIVUTBxTvswhD9+ncj1GtxTo+RRDWZOjlFKdokfZ5PAtkocFknNVi32aG
         k1xQ==
X-Gm-Message-State: AOJu0Yy+XDOTC5GcbCu+8Y9BMukES+LU+fBFwL01twLspEn5Ky8k8Cch
	o+T2Wt5zYqNWNKIRRQN/UnCZc2kT7IRMpZsUKiHU2r2Co1ZWZXB+tMgHiQPFzH4=
X-Google-Smtp-Source: AGHT+IH6RUi4tgl4H1dy0k5sfJ40MlHyjDCv0e4pUl1rYg+YFay8R4XBc962dPMwn74ue8IplN5T3w==
X-Received: by 2002:a05:690c:d91:b0:61a:cde6:6542 with SMTP id 00721157ae682-62d02253a11mr59256987b3.16.1718048428085;
        Mon, 10 Jun 2024 12:40:28 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccae4793csm17261487b3.97.2024.06.10.12.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:40:27 -0700 (PDT)
Date: Mon, 10 Jun 2024 15:40:26 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [RFC PATCH] btrfs: scrub: don't call calc_sector_number on
 failed bios
Message-ID: <20240610194026.GA235772@perftesting>
References: <20240610144229.26373-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610144229.26373-1-jth@kernel.org>

On Mon, Jun 10, 2024 at 04:42:29PM +0200, Johannes Thumshirn wrote:
> When running fstests' test-case btrfs/060 with MKFS_OPTIONS="-O rst"
> to force the creation of a RAID stripe tree even on regular devices I
> hit the follwoing ASSERT() in calc_sector_number():
> 
>     ASSERT(i < stripe->nr_sectors);
> 
> This ASSERT() is triggered, because we cannot find the page in the
> passed in bio_vec in the scrub_stripe's pages[] array.
> 
> When having a closer look at the stripe using drgn on the vmcore dump
> and comparing the stripe's pages to the bio_vec's pages it is evident
> that we cannot find it as first_bvec's bv_page is NULL:
> 
>     >>> stripe = t.stack_trace()[13]['stripe']
>     >>> print(stripe.pages)
>     (struct page *[16]){ 0xffffea000418b280, 0xffffea00043051c0,
>     0xffffea000430ed00, 0xffffea00040fcc00, 0xffffea000441fc80,
>     0xffffea00040fc980, 0xffffea00040fc9c0, 0xffffea00040fc940,
>     0xffffea0004223040, 0xffffea00043a1940, 0xffffea00040fea80,
>     0xffffea00040a5740, 0xffffea0004490f40, 0xffffea00040f7dc0,
>     0xffffea00044985c0, 0xffffea00040f7d80 }
>     >>> bio = t.stack_trace()[12]['bbio'].bio
>     >>> print(bio.bi_io_vec)
>     *(struct bio_vec *)0xffff88810632bc00 = {
>             .bv_page = (struct page *)0x0,
>             .bv_len = (unsigned int)0,
>             .bv_offset = (unsigned int)0,
>     }
> 
> Upon closer inspection of the bio itself we see that bio->bi_status is
> 10, which corresponds to BLK_STS_IOERR:
> 
>     >>> print(bio)
>     (struct bio){
>             .bi_next = (struct bio *)0x0,
>             .bi_bdev = (struct block_device *)0x0,
>             .bi_opf = (blk_opf_t)0,
>             .bi_flags = (unsigned short)0,
>             .bi_ioprio = (unsigned short)0,
>             .bi_write_hint = (enum rw_hint)WRITE_LIFE_NOT_SET,
>             .bi_status = (blk_status_t)10,
>             .__bi_remaining = (atomic_t){
>                     .counter = (int)1,
>             },
>             .bi_iter = (struct bvec_iter){
>             	 .bi_sector = (sector_t)2173056,
>                     .bi_size = (unsigned int)0,
>                     .bi_idx = (unsigned int)0,
>                     .bi_bvec_done = (unsigned int)0,
>             },
>             .bi_cookie = (blk_qc_t)4294967295,
>             .__bi_nr_segments = (unsigned int)4294967295,
>             .bi_end_io = (bio_end_io_t *)0x0,
>             .bi_private = (void *)0x0,
>             .bi_integrity = (struct bio_integrity_payload *)0x0,
>             .bi_vcnt = (unsigned short)0,
>             .bi_max_vecs = (unsigned short)16,
>             .__bi_cnt = (atomic_t){
>                     .counter = (int)1,
>             },
>             .bi_io_vec = (struct bio_vec *)0xffff88810632bc00,
>             .bi_pool = (struct bio_set *)btrfs_bioset+0x0 = 0xffffffff82c85620,
>             .bi_inline_vecs = (struct bio_vec []){},
>     }
> 
> So only call calc_sector_number when we know the bio completed without error.
> 
> Cc: Qu Wenru <wqu@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

