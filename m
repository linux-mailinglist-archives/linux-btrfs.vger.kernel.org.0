Return-Path: <linux-btrfs+bounces-15149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF582AEEE91
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 08:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605F43A35F9
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 06:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36D523BD1D;
	Tue,  1 Jul 2025 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="anH1Z8n7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB5E21CFF6
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351008; cv=none; b=PT4DexjpL9/ulZLV8gOkMaEBDXhMCPeaxl3nIJipW91vAGEhVvpce3O+6sNA1qdtQd0GCTeYRGlSq00sKd+pn8o1zT6WP1uym1qfCphN2uqKKX+Suv84vUJpO6DRW2zC8LaoiWeN8s7d2tHyBDc+v42f93Inh96ziI7TsFfIr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351008; c=relaxed/simple;
	bh=6yttm5Qep3NBN0kX2vSnM3H0+zpYWdBsyhzAI2zpwU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1Ia3OIMVswL3+t70QRuDwMrXj/TuWrDynRrVWC6iSpnQixSbEcl8Auf8nKsdKKavDd5SjZjHL1IW6rAdJ3LA1k+++8iS8d/NaFn78rzNBH2oLkqRpV8ptZnGRmsMz5hAHAy9gin+LHnPuZv6NYeN2hOQm99cCgYRAff2noOdtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=anH1Z8n7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a58c2430edso56137481cf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 23:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751351006; x=1751955806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6yttm5Qep3NBN0kX2vSnM3H0+zpYWdBsyhzAI2zpwU8=;
        b=anH1Z8n7gTpIxKbFXysvAkXY6GYcSGYyp2kwpBWDuRqq+tzHmXpkCIpltC3K528TKm
         Vuc1gJkLA9+OpRWfvVJAglU3eAbF6O9fFqvO8Dx6qN8yERI+DTJuusNxo3UOTfHvdzlH
         B4Vy9k463Wo10p6viP/ivkGKuM0IW4f3aRE9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751351006; x=1751955806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yttm5Qep3NBN0kX2vSnM3H0+zpYWdBsyhzAI2zpwU8=;
        b=uI5X/kAhDUTaRzNt2DYg1Axb0kbHfPNqVo8KZ4VzGbRs/GcMdIaEMBFkQqyvvb+XzB
         rf0n0hXiep89pAH+8KZMrk3mXU1CYzEddA4vr7lNODYz4KOGDgax+l8rAZtiP2GZvqt1
         3hicW6IpUP0Ojh0fdqBDtSquko0vkT2CqQuj6iZSNGSv0scDq86GYg4UDLxwvdzHTQUY
         tPMFej36qqn36wqUANyFGVtGQZGLHbWB5/JwS1lkJupYMnep/L/TX1OyFEjrib/j8eyD
         xH3N8kQIZveb9MEFQxfZyDAbkR08C6tHNVhG8NAFKbdKPETCotW+bZjAD1k+H79oUsTs
         DUpg==
X-Forwarded-Encrypted: i=1; AJvYcCXvlD0y2GCF8oRnDlLD0k9o0WipYQglcus0S31PtlWmSCOk0c2+rfNUaBlXef/ahNPzICma3uZtmxCOtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxA55ew5dIhyk+MMvwqSFtwGGGJ98pfrrwMixRcz2n4J++I89i4
	TidmNQTUl4gdJaW78upUS3iPkozwIRLoJFETh+E146qVQ4IT2lZcXqAh1oMHBoiLPNh+WkBP7oE
	ErVyzRdEHSNjsweQ7qZhTH/TGPPalScbkpHpBIqOP5Q==
X-Gm-Gg: ASbGncusCPCNwnxXWvkE1hY6yOTO4Bj/3e7GMYsA2YqhTCRhgAaDez4sF2ROh6thIiz
	rRZiTqCBQTIH6zoslccxaZlvoxwv5Qkf0sSZ2kn1/YX72VKb1XAY7B5+807CH3KpWFMkoQBEDGv
	2HLFvl5zKdjp9lJsdsdgnHeSb6wAiidrDfDks7itDgk1wWhn8fY/mXGghnINeen4X9xwEAM5cmw
	96u
X-Google-Smtp-Source: AGHT+IF/4eCMJfHhQh+NomYc895/DRC2IEJWxiuPw7wJwiLPtRg1dt/Dr1B22JHPC3Z1DLGs7QY/n9Jj5bCLzyMZhhk=
X-Received: by 2002:ac8:5806:0:b0:494:b247:4ddb with SMTP id
 d75a77b69052e-4a82e9b8105mr37293761cf.4.1751351005922; Mon, 30 Jun 2025
 23:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-6-joannelkoong@gmail.com> <aEZoau3AuwoeqQgu@infradead.org>
 <20250609171444.GL6156@frogsfrogsfrogs> <aEetuahlyfHGTG7x@infradead.org>
 <aEkHarE9_LlxFTAi@casper.infradead.org> <ac1506958d4c260c8beb6b840809e1bc8167ba2a.camel@kernel.org>
 <aFWlW6SUI6t-i0dN@casper.infradead.org> <CAJnrk1b3HfGOAkxXrJuhm3sFfJDzzd=Z7vQbKk3HO_JkGAxVuQ@mail.gmail.com>
 <aFuWhnjsKqo6ftit@infradead.org> <CAJnrk1Zud2V5fn5SB6Wqbk8zyOFrD_wQp7B5jDBnUXiGyiJPvQ@mail.gmail.com>
In-Reply-To: <CAJnrk1Zud2V5fn5SB6Wqbk8zyOFrD_wQp7B5jDBnUXiGyiJPvQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 1 Jul 2025 08:23:15 +0200
X-Gm-Features: Ac12FXx4vgjv5ycm_1iHhIFxMh2pxXOzEd-Q9OTergY2osOj37o6vwohMHvjQOk
Message-ID: <CAJfpegvOizDZb9Lw1f0BHbH05owLh7-KOqeB3H8bgZhwRpN=5Q@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 18:44, Joanne Koong <joannelkoong@gmail.com> wrote:

> Yes but as I understand it, the focus right now is on getting rid of
> ->launder_folio as an API. The iomap pov imo is a separate issue with
> determining whether fuse in particular needs to write back the dirty
> page before releasing or should just fail.

Fuse calls invalidate_inode_pages2() not just for direct I/O:

 - open without FOPEN_KEEP_CACHE
 - FUSE_NOTIFY_INVAL_INODE
 - mtime/size change with FUSE_AUTO_INVAL_DATA turned
on/FUSE_EXPLICIT_INVAL_DATA turned off
 - truncate

In most of these cases dirty pages d need to be written back.

Thanks,
Miklos

