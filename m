Return-Path: <linux-btrfs+bounces-5920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E1F91522C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 17:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294241C212DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBE419B595;
	Mon, 24 Jun 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RBjyq9PV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196113DDD3
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242718; cv=none; b=V05aw6Ve5MPzBEzB1mSTfSphZh6njCsfKWcFBPH7onybFVTCh7/Xw3Kc0xeNlUsIiqwfkNaUD471o54zhvlCKiK1Ry3U433K0uQyoTzRW72JGHuFkwd6ItwzUxfe1CCXAemSjZSaSfvrTIbrQRUG26Wk2uGySMh33PNTt7mPqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242718; c=relaxed/simple;
	bh=120uHXGSYq9JoX50DVKaLlhzjeoIlWldq5zJpvgNsuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqoChs0Ee+Bikhl4dk0YKn0bmXRSwUlCl9qkCyNS0twY/V5BZ3SA46hJ9sOYF2uV69hOj25I7AvJTWqnkZh2HlouTIFc5XJkrXbQhHJmv+MI5wkchew+R7s5dPBV53HL3rn7YqdCOJWSMWQ6F4FNWaEN74z2sLz9ivKyBgpeWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RBjyq9PV; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-444e9ca8b68so3784271cf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719242715; x=1719847515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GNZ3KXlPz2Pjsp4xs04AAi4xW69YpWyEikpZEegsEEc=;
        b=RBjyq9PVmSpo7E+E0ejJgZl30YElp66d7cpuPDcUn7LuhXTyYYt719M9EgjqVC+Y/7
         2ef5TfyRolO0MHgWhh6vdmuJxXNw1k/x6O4O7z7MPWHfWinfZEWzpK3s4Yx/FI+8QMTc
         cOGXf15J6lNIoqxVXwQUnAmHBW6oacUPFLiCxFQCCwgHigC2MvvH6ljEckZwdrDUT1Dk
         6zah1BHhMwHxd5fPZ54XOzJfLQRlfVKDYakyHOYwWYkIKNL9D+3I6qwRl4JAfIG3NSdD
         ub+MMbAUycdyrK/9bHF6Oez4t4Oj5oaSyB11/tpJaIP2oKEU5k49Prfwq10woCn2K3Cw
         pPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242715; x=1719847515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNZ3KXlPz2Pjsp4xs04AAi4xW69YpWyEikpZEegsEEc=;
        b=MYCbQeOxhOLUmR6FQrNw3cftqrQEl4hO7rlpg7zdamFm8aO2ZaHplWS6dHbr/fZ9yN
         KLf4fB2KFBfeRMChOMdGzRNBINOFqbN5LkKd5WgP1nx1rkYyz//GnbafCmZW+AyWUDj3
         ISNrdruJxGAgWcirfcD67++NHAvv1nPQq1P/Tgl/o/qIV9V/Al7xfQ6+eexmGbboubdX
         Wv5It2qYwGz9TN6dAB5RbNYvyPCx36elfNUcOzWvx9J6hNB6pqLetJsbD1Br5BmwMYul
         eJxc8uXN79jkirvXHV06sFwIfTilU9BzujWH+z8apO6/D/S2cy0sok3PLssEkSkGb/h3
         ZsWw==
X-Gm-Message-State: AOJu0YzSZWxEep2wbTWmyFZDNIu8cifKY4UvCbMcphF9j3VcWpManXZp
	ukaJYjrA8FcZtMV2c4n7rfW3PUqiCx6hPiv/azylc20hGuZ8ppottRQcmzz2JoA=
X-Google-Smtp-Source: AGHT+IG0vdWXMqmPZ5dlxqxQ0UHyKloBvSDWY4PA4TIUWjNWxncHQzNYvaklCsjBenfKOMfEtnC69w==
X-Received: by 2002:a05:622a:609:b0:440:5256:9a7f with SMTP id d75a77b69052e-444d9370fa1mr48577891cf.56.1719242715105;
        Mon, 24 Jun 2024 08:25:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b6bb8fsm43756391cf.33.2024.06.24.08.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:25:14 -0700 (PDT)
Date: Mon, 24 Jun 2024 11:25:14 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/6] btrfs: dynamic and periodic block_group reclaim
Message-ID: <20240624152514.GB2513195@perftesting>
References: <cover.1718665689.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718665689.git.boris@bur.io>

On Mon, Jun 17, 2024 at 04:11:12PM -0700, Boris Burkov wrote:
> Btrfs's block_group allocator suffers from a well known problem, that
> it is capable of eagerly allocating too much space to either data or
> metadata (most often data, absent bugs) and then later be unable to
> allocate more space for the other, when needed. When data starves
> metadata, this can extra painfully result in read only filesystems that
> need careful manual balancing to fix.
> 
> This can be worked around by:
> - enabling automatic reclaim
> - periodically running balance
> 
> The latter is widely deployed via btrfsmaintenance
> (https://github.com/kdave/btrfsmaintenance) and the former is used at
> scale at Meta with good results. However, neither of those solutions is
> perfect, as they both currently use a fixed threshold. A fixed threshold
> is vulnerable to workloads that trigger high amounts of reclaim. This
> has led to btrfsmaintenance setting very conservative thresholds of 5
> and 10 percent of data block groups.
> (https://github.com/kdave/btrfsmaintenance/commit/edbbfffe592f47c2849a8825f523e2ccc38b15f5)
> At Meta, we deal with an elevated level of reclaim which would be
> desirable to reduce.
> 
> This patch set expands on automatic reclaim, adding the ability to set a
> dynamic reclaim threshold that appropriately scales with the global file
> system allocation conditions as well as periodic reclaim which runs that
> reclaim sweep in the cleaner thread. Together, I believe they constitute
> a robust and general automatic reclaim system that should avoid
> unfortunate read only filesystems in all but extreme conditions, where
> space is running quite low anyway and failure is more reasonable.
> 
> At a very high level, the dynamic threshold's strategy is to set a fixed
> target of unallocated block groups (10 block groups) and linearly scale
> its aggression the further we are from that target. That way we do no
> automatic reclaim until we actually press against the unallocated
> target, allowing the allocator to gradually fill fragmented space with
> new extents, but do claw back space after  workloads that use and free a
> bunch of space, perhaps with fragmentation.
> 
> I ran it on three workloads (described in detail on the dynamic reclaim
> patch) but they are:
> 1. bounce allocations around X% full.
> 2. fill up all the way and introduce full fragmentation.
> 3. write in a fragmented way until the filesystem is just about full.
> script can be found here:
> https://github.com/boryas/scripts/tree/main/fio/reclaim
> 
> The important results can be seen here (full results explorable at
> https://bur.io/dyn-rec/)
> 
> bounce at 30%, higher relocations with a fixed threshold:
> https://bur.io/dyn-rec/bounce/reclaims.png
> https://bur.io/dyn-rec/bounce/reclaim_bytes.png
> https://bur.io/dyn-rec/bounce/unalloc_bytes.png
> 
> hard 30% fragmentation, dynamic actually reclaims, relocs not crazy:
> https://bur.io/dyn-rec/strict_frag/reclaims.png
> https://bur.io/dyn-rec/strict_frag/reclaim_bytes.png
> https://bur.io/dyn-rec/strict_frag/unalloc_bytes.png
> 
> fill it all the way up in a fragmented way, then keep making
> allocations: 
> https://bur.io/dyn-rec/last_gig/reclaims.png
> https://bur.io/dyn-rec/last_gig/reclaim_bytes.png
> https://bur.io/dyn-rec/last_gig/unalloc_bytes.png

These results are great, once you fix up the one comment I had you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the whole series.  Thanks,

Josef

