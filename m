Return-Path: <linux-btrfs+bounces-13040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403F1A8A54B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 19:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADF43B6719
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C49F21E0BD;
	Tue, 15 Apr 2025 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="y+O8vCRX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D221C19A
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737741; cv=none; b=rd5iLF4PZdq2uRjMwhH1OOGPgXWjWwJ4Qnco95W8p0ONvYCKhDIAVPtOPdKMpId7JbpdL3WKsu8DkPwpuVzwAJCS15C175IaPJVs/K9aVUsjPMujsl16IK50Rce8dgA0Tin+0DgFwsmitk+LLpkn6vFpjUy53eULrSH/yY9gzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737741; c=relaxed/simple;
	bh=eKNiLE/YwNflKjQVIRnpf1DABe7fdm7RoryWNX41sUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9YUjKZIV83GqN9LN/wh1cnm+s0mR/l5s5FVWcF9+OchAIiCWiUmdrQx0x6WcRt/J+3F6krvqwEJFTbf4KAV9sWLKEqAh44DCucoHRnXPHcMQ+q6G1i6nTJCITZFT+TkjnBKtws43sGCyGPiO2smEzhIEXC8FvrWO5hMCw+UN1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=y+O8vCRX; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ff4faf858cso43125357b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744737738; x=1745342538; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=62meE7UGs+DL+98eD/kQGAdhLDBUYjlRKrShxwXFsmQ=;
        b=y+O8vCRXulmrMNq/6LS9Gm01ljrKbLBREJ0wjyqKNOAEV7wC0waEJjVIIRgUCnSZg0
         v9fG+DgcmV2QCLho1lvEfPXO8KfO6/jjQvi6Dw2DW1O/5W+ybyKrAHd98GsKQI3j2LLX
         dkUJcGq85vIwCuD3S3+raUZf4JeIL74DjPMb/okYsD42wmxmIgJGkqdl4iPuwxDUQhKI
         lY60czjyFc1N0t+eKrR3UXKPvLZfySwVKTbS4qMN88BdlAcAG0PUmw/tP2gwa+3CTNq0
         jTu4KdBZm7Wc4gK0ywvYizs0sgHqGXQ4m51EheJOavkbBFw3cbxqTiDjRg8GlJhg62/v
         J4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744737738; x=1745342538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62meE7UGs+DL+98eD/kQGAdhLDBUYjlRKrShxwXFsmQ=;
        b=if632K76oRb/h8g0LCNIIifez7IP3hZ7jxjH061DnhmcY9lzlQlsfEmOGVm5v9G3YD
         cESURdw+Gm5gNfnDqUFc7HjxLjfl5V1cVOHPES3fKbNkuf90lkn/Y3CcJ3Q7H7Low+gF
         wIJYK5J1hf23rhqaJFO3uE37YPIxGAEooIbIgcgGWv+ko8iPv6Mudq8I6I32iRgQ0j5a
         w4PFRT2v1N2HIEPbEBQQYR1seMWtaQw4/yT70oad++LqFjUeepd+Onz5o6MpkYPYFkmP
         TZBZ5XGdqyHhAWXawHJcMIs8oC9U2uJ9UFXDNUAsAFVrILA8VtRT9vTxeoUcVTvZjPRu
         OhAg==
X-Gm-Message-State: AOJu0YwypdYlUrP7VbDRgAjzig3ANJbaVOYNhKVHYD8QsUf+FXIR4LZR
	OUD9FKvSkbsgRTlu3/h0p+49vGTYbrUmVNf/mPlk3wZgSrzNNGxuBComUQZX7o8=
X-Gm-Gg: ASbGncu7IiYlJ6tc9YtbhIV9mXmuZ2jkPYl5fKMUuDGvBEk6ki0LiKf0rPsvMGSdS+/
	qcdso0UoS2VBrz8AL79OvMWWx7itZ8etm6YSAsH5yqkcYTKh2fTXY60suLm8Hh7JjarFInlVFfz
	tq0hmAGKq2616KztztuXGaZVrE7KlBxZ5wYZJP7073IWCTRgRysb1PiHsieF3hi+NyYrlXmZRTc
	GCQZFv43Bttnmp7Q+jvhDIDIVr3ZJdXenQx2KaohVCeuh8pYPjTAyY1Fi4/Zx4xqd9c8Fr88/bQ
	TjFSBf0Ww9uIkigZuY0CyXej30rrz5BMGi4tJbTTFmpapfHk23VndWcGhRGTI8VB4i68l3STRii
	uxw==
X-Google-Smtp-Source: AGHT+IERClXjZ/h1SKLN5ai4hqqQW3i5lk3FmnyOsWVEFs2CCe0CfVme9o9Pcdhx21dWXNlf4dA6CQ==
X-Received: by 2002:a05:690c:74c9:b0:703:aea2:6bbb with SMTP id 00721157ae682-706ad1c5dafmr1465947b3.31.1744737738134;
        Tue, 15 Apr 2025 10:22:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e11af16sm37133287b3.44.2025.04.15.10.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:22:17 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:22:16 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix race in subpage sync writeback handling
Message-ID: <20250415172216.GA2701859@perftesting>
References: <ff2b56ecb70e4db53de11a019530c768a24f48f1.1744659146.git.josef@toxicpanda.com>
 <e13cf6fa-edd2-454f-8635-da8559b97ccc@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e13cf6fa-edd2-454f-8635-da8559b97ccc@gmx.com>

On Tue, Apr 15, 2025 at 07:15:42AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/4/15 05:02, Josef Bacik 写道:
> > While debugging a fs corruption with subpage we noticed a potential race
> > in how we do tagging for writeback.  Boris came up with the following
> > diagram to describe the race potential
> > 
> > EB1                                                       EB2
> > btree_write_cache_pages
> >    tag_pages_for_writeback
> >    filemap_get_folios_tag(TOWRITE)
> >    submit_eb_page
> >      submit_eb_subpage
> >        for eb in folio:
> >          write_one_eb
> >                                                            set_extent_buffer_dirty
> >                                                            btrfs_meta_folio_set_dirty
> >                                                            ...
> >                                                            filemap_fdatawrite_range
> >                                                              btree_write_cache_pages
> >                                                              tag_pages_for_writeback
> >            folio_lock
> >            btrfs_meta_folio_clear_dirty
> >            btrfs_meta_folio_set_writeback // clear TOWRITE
> >            folio_unlock
> >                                                              filemap_get_folios_tag(TOWRITE) //missed
> > 
> > The problem here is that we'll call folio_start_writeback() the first
> > time we initiate writeback on one extent buffer, if we happened to dirty
> > the extent buffer behind the one we were currently writing in the first
> > task, and race in as described above, we would miss the TOWRITE tag as
> > it would have been cleared, and we will never initiate writeback on that
> > EB.
> > 
> > This is kind of complicated for us, the best thing to do here is to
> > simply leave the TOWRITE tag in place, and only clear it if we aren't
> > dirty after we finish processing all the eb's in the folio.
> > 
> > Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a subpage metadata page")
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   fs/btrfs/extent_io.c | 23 +++++++++++++++++++++++
> >   fs/btrfs/subpage.c   |  2 +-
> >   2 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 6cfd286b8bbc..5d09a47c1c28 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2063,6 +2063,29 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
> >   		}
> >   		free_extent_buffer(eb);
> >   	}
> > +	/*
> > +	 * Normally folio_start_writeback() will clear TAG_TOWRITE, but for
> > +	 * subpage we use __folio_start_writeback(folio, true), which keeps it
> > +	 * from clearing TOWRITE.  This is because we walk the bitmap and
> > +	 * process each eb one at a time, and then locking the folio when we
> > +	 * process the eb.  We could have somebody dirty behind us, and then
> > +	 * subsequently mark this range as TOWRITE.  In that case we must not
> > +	 * clear TOWRITE or we will skip writing back the dirty folio.
> > +	 *
> > +	 * So here lock the folio, if it is clean we know we are done with it,
> > +	 * and we can clear TOWRITE.
> > +	 */
> > +	folio_lock(folio);
> > +	if (!folio_test_dirty(folio)) {
> > +		XA_STATE(xas, &folio->mapping->i_pages, folio_index(folio));
> > +		unsigned long flags;
> > +
> > +		xas_lock_irqsave(&xas, flags);
> > +		xas_load(&xas);
> > +		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
> > +		xas_unlock_irqrestore(&xas, flags);
> > +	}
> > +	folio_unlock(folio);
> >   	return submitted;
> >   }
> > diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> > index d4f019233493..53140a9dad9d 100644
> > --- a/fs/btrfs/subpage.c
> > +++ b/fs/btrfs/subpage.c
> > @@ -454,7 +454,7 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
> >   	spin_lock_irqsave(&subpage->lock, flags);
> >   	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
> >   	if (!folio_test_writeback(folio))
> > -		folio_start_writeback(folio);
> > +		__folio_start_writeback(folio, true);
> 
> This looks a little dangerous to me, as for data writeback we rely on
> folio_start_writeback() to clear the TOWRITE tag before this change.
> 
> Can we do a test on the dirty bitmap and only call clear TOWRITE tag when
> there is no dirty blocks?

This accomplishes the same thing, we only modify the dirty bitmap under the
folio lock, so this is safe.

> 
> (This also means, we must clear the folio dirty before start writeback,
> there are some exceptions that needs to be addressed)
> 

Which is what we're doing, and what we're supposed to do, even not in subpage,
because that's how the tag clearing works for the DIRTY tag, it checks to see if
the folio is dirty and only clears the tag if DIRTY is cleared, and it does this
in folio_start_writeback().

Keep in mind this is a quick patch to fix the bug in a way that we can backport
to all the kernels that are affected, which is basically anything that has
subpage support.  The followup series I'm writing will make this all much more
sane.

Thanks,

Josef

