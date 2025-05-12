Return-Path: <linux-btrfs+bounces-13892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F39BAB3EC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 19:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9880A3B4315
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 17:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA4429614E;
	Mon, 12 May 2025 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JUpZFTRZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C2B25179E
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070060; cv=none; b=ET9etARPsxqy92f+xeBjptlqqIeGTjM219iBBAhdgou9eFM8wAHpspmQVGfuuZqGFLA0oSfiUFkTQ7pBLTkKSa2ntpMxlaIXD6lHGTDxMlJX4VRCETeBzQ7BP8Bczlu8F0PtRUhN7IpxdNS3Z3UcFSoRgyGFIWrcTvg4jAvOkJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070060; c=relaxed/simple;
	bh=ABojIAIh6l1CnGObd5Nl8h6husnyP2t2AjapslYWz3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVmkrE5aT18aTmKJTUiK+5ixKLayNcN6i02R7SBcWmBjQwQSVoKXNcSc1hJZp243Mo0hOFcL2DW3e8f6f5PJPYzRCPc5xFuKFQUc3M23MuK9gEb3nv9ovO8+Y6/F54vzppHEk35Kj4c64zKVITKFnVqyUD7EfKEqUxxmDwPAH04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JUpZFTRZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso785449166b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747070056; x=1747674856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ip4hjBugcV7uNPy5479duabM1077Hm7kINyPkAMIh8E=;
        b=JUpZFTRZ3Hd7ndJJZ7HJgcFSwPc/mo8m1SVijEO/GmFkBS+FEM2NxYGzg3bX+2JQul
         xGBiKdmsBs6eVyd533aeA3YT0BNyflYaoJA9pXS3RbvWIjk+gnqYRzlK8VirUCtG6AwP
         PCQ19DITHe9VyGi7RIYP3rnWUE904vPtvCoybmD7De0nk2Z75haZYogskGuY/qHLqsBx
         V/rRvzT9qSQn3LgF21rCUTiXWvP7UyFasu92SbojSZ3i1Fe7Abq7/A0XOOABcxHovvQn
         9bzE/LiavjjU4U1ZB8GoTSFYb9JF2NHMjl9Z96L1wnmEa2OWHjQ7h9W5nq8TumGSoKRD
         C1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747070056; x=1747674856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ip4hjBugcV7uNPy5479duabM1077Hm7kINyPkAMIh8E=;
        b=dp3J4+p0eNHZlPtUcXB0hU9cXINLL5IEfadJAqDjYaKEPED+raut+NVZqVclKRgLbD
         qejQwAmq+8X9IFBRvB4rRGj+EWoWpv1rh0L3YZ1wZdNFXZjY22dvOuZChkvYfimWPKi2
         +y9PCSaIYNnVwGzdmwVD+IPnhr/6FtCPQsxDoiXkQygowCe3orjpQoAHrtN19WW0QIjF
         xeHh1pWo8RDCGqJ6RQtFU0FpIdMszaxiSotEgsRT9j7ExMNva77PlHxy3vFhkg5GWrvR
         OAQl6UMsoSfA8aoBlsrcQtcxgqlPw2ZorVzR1nCur15q+Kb8GwD6ZqblEw67/7VJcILl
         pXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX70Iyo6vNiCIirLBq9Ehvl+2tQoqI6ps7KMIOlnyDQ2EAUQwN2qEKFe+uhxmnRy63f3r2cJn28/xBpNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0odA7TiQcMjetflhq3h6oi/OXcfZ9/oU8/H8GLm9df10gCxxA
	rXTYIUBYpO2po6gNndIuQSS4zisqobo0gSOrSIHbhhQDYRTJh0wzZMU4pH+AIJJIu1Lplmt5gLE
	yNwFKcNt9gm1q03C+XGZ6wtRFzDzKLajO2Z4Uag==
X-Gm-Gg: ASbGncu6MbDngwrai9QNCagog1x7JV1wIol1cd1kQXpNE4f+Rx+Rm6lRFDLebs9KqHj
	hqRL8zgHoWxtL90Gz7oFR2tFHFlmKG39eS+YTYCEtZVZ3Tqb2Pdy6/dg8nzGvJzFaJeY4xIykkd
	/QqUI7T3NKqkBmBD6hIwI19zn5tNgz64Q=
X-Google-Smtp-Source: AGHT+IFsm8OallosFPb1HI0zjf1sz6OgzEjW4UhgBWodWbpL74XNwEPZUXAE8spD+Pohbvhz7xOPkVSbeuWfxJcbg/k=
X-Received: by 2002:a17:907:d91:b0:ad2:40e0:3e56 with SMTP id
 a640c23a62f3a-ad240e03f9cmr865015866b.57.1747070055974; Mon, 12 May 2025
 10:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <78713bfb50cb72321bd6026dd2e29cfef0b2b047.1746549760.git.boris@bur.io>
 <20250512145939.GL9140@twin.jikos.cz> <CAPjX3Ff+XrWHJq_cBPUaK5memR3eMh-xpCeR7rk3uOa3yPE8Mg@mail.gmail.com>
 <20250512155256.GM9140@twin.jikos.cz> <20250512160909.GN9140@twin.jikos.cz>
In-Reply-To: <20250512160909.GN9140@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 12 May 2025 19:14:04 +0200
X-Gm-Features: AX0GCFsxrwrhHRfJpfS0A0KxXeL0jujEWIjQRpgtNV9ajkyywiIXxWR2V6ZNUNs
Message-ID: <CAPjX3Fdzs3K739Tpu4JGJO8MCjStp_ndNAjKjBq1weOH2Jcq1w@mail.gmail.com>
Subject: Re: [PATCH v5] btrfs: fix broken drop_caches on extent buffer folios
To: dsterba@suse.cz
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	fdmanana@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 18:09, David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, May 12, 2025 at 05:52:56PM +0200, David Sterba wrote:
> > On Mon, May 12, 2025 at 05:07:12PM +0200, Daniel Vacek wrote:
> > > On Mon, 12 May 2025 at 16:59, David Sterba <dsterba@suse.cz> wrote:
> > > >
> > > > On Tue, May 06, 2025 at 09:47:32AM -0700, Boris Burkov wrote:
> > > > > @@ -2852,9 +2850,27 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
> > > > >       return eb;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * For use in eb allocation error cleanup paths, as btrfs_release_extent_buffer()
> > > > > + * does not call folio_put(), and we need to set the folios to NULL so that
> > > > > + * btrfs_release_extent_buffer() will not detach them a second time.
> > > > > + */
> > > > > +static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
> > > > > +{
> > > > > +     int num_folios = num_extent_folios(eb);
> > > > > +
> > > > > +     for (int i = 0; i < num_folios; i++) {
> > > >
> > > > You can use num_extent_folios() directly without the temporary variable,
> > > > see bd06bce1b387c5 ("btrfs: use num_extent_folios() in for loop bounds")
> > >
> > > Not if the loop does eb->folios[0] = NULL; We've been there and had to
> > > actually change it this way.
> > >
> > > Using num_extent_folios() directly is a bug here.
> >
> > Ok then it needs a comment before somebody will want to clean it up.
>
> Also this makes num_extent_folios() a bit dangerous when the eb->folios
> change in the loop, not what I expected when the __pure attribute was
> added. In case this introdues more subtle bugs we'll probably have to
> revert it.

Yeah, the stack savings actually show the compiler does not cache the
value implicitly on it's own and rather it's being re-fetched from the
eb object each time.

If I understand correctly, you may have rather wanted the const
function attribute and not the pure one. That could possibly work,
though I'm not sure how portable that is [1].
Pure means it has no side-effects, ie. it does not modify any memory
like global variables or the object given by a pointer argument (in a
sense the arg is struct foo const*).
It is described similarly to const attribute but: "However, the caller
may safely change the contents of the array between successive calls
to the function (doing so disables the optimization)." [2]
So any changes to the eb in the loop block effectively cancel the pure
effect. Which is what we see here.

[1] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-const-function-attribute
[2] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-pure-function-attribute

