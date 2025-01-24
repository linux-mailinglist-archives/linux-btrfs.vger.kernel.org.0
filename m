Return-Path: <linux-btrfs+bounces-11059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90402A1B87C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 16:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EAA188A02C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD631531E2;
	Fri, 24 Jan 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KexfdTsp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163212F399
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731456; cv=none; b=VwyVcqTDOiFeRmXOWMm/p6nNDvm+KE9dtjNGB7KqSOoatUg8R6hCWjwvbJEOj+fQOkvwSZToFrzKQUe25DXrNEWj5ip82EMjWMSN1YvS+gC7LYlvNSeUOsUfZ2DHTcaj/V93xG9e3GfJIBkmnZ/OCL9LP9ZHM9bFqRuBAlio4Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731456; c=relaxed/simple;
	bh=aLI3i1HL3vvOoJmO8mONYMQl1dJ0MH8tvVgPKg4p/os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SY9yC/TByEmTpDnLGN5UXeVnssG9jibhCVyovRHFsMaK3v/YbZFlomUFiBe/XDXA5NiHiVq5jNRfECzYiN+KHO4KDI+sivq4VKQ/ADCXB1vfUFaOX6PUGgAyOLA3OH/by/QvVNOT2A/H/Fpip95Gp4ffK1GGr9umscIAZnRQpTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KexfdTsp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so392461066b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 07:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737731452; x=1738336252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Qbr18CbMqD5rbcELoy6ShQMpRgRWAIQ/5hrw/ytjWg=;
        b=KexfdTspGHbwGf/zBoE/bqIL5vBdhtZvvS3EJIoglOt+JNaPEYLUamvGqbmuQM4Yf4
         HxHeLDDkghC79pUzYg6VnmN2QzgEJvt0QUfvSiG5+u7ANyX0WsTUE4vRKG8tgewVyq9l
         G25EW2S4TUDKIkOpK/LP3GeP0G/b1MQBH/g3locm9xmpYm7C4rmrl7f7dCF5Oef9YH/k
         tcNlkjjT5RBakWj7+N2ixqpWfVbW6HQbLfuK9QpsuXrQrOcbXDNTaZWx76+LzmAhOjhG
         u5vmXCBGLwq9vixLGnTdz+IOtSWDFjw/gbnhLrYr83zW6e0Ee0bMRZAbskX3kD5azVlo
         b10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731452; x=1738336252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Qbr18CbMqD5rbcELoy6ShQMpRgRWAIQ/5hrw/ytjWg=;
        b=u61aXg3Qa6iViVBi16yiYXmFM8f4wu7TzvPcAuLE+ptXzH2hBCZ9ws7SRfqKSSqDKO
         kVDeHIAp+yn8WqxN98fWDCOOhSsmS8g/SkxzkbQlwG0nsu1KoRsGkFGkdt/S225mctS+
         8eYOUla6xaKquWkj2/VYZvVH+u4hT7jeFkC7cEqAw49xURx7nsDhwTQqrVk/9qPDTpPs
         AWyH0nhlS5upUECaWwwFQIQfOwZnoXfCI5zLBZSVCYFaDgR3TWMmcyp3DrO1h9neu0VG
         CqShAzF8C0sbjdv1ISpbTZU+j1vyUypowSah2r2CPQiPC0JD90l7bqtovz0ItDyIHCis
         UjiA==
X-Forwarded-Encrypted: i=1; AJvYcCXOOlFdce3Z4qNDy6fZSDBvS3P2RaHocRWFC2RaMigeWZsbGu9DUPwhBFnMFbKlRYp5fq4BZYYJphUb1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyROmUpW9VYjB4sz9vRQ5bifrQeRSrqct1L7TGEmsdV0rR2RecU
	dEPE6Fd3mgTBA2Nm7iPJRkmHjY2o6C24b7tuK11Fxh8Su1QOL4raJxvtlLmwcgoKOQ4PJLCPSw8
	9n7B6vRgZ4GCT1QGSpJpazE5SLOabnmZydoTrlw==
X-Gm-Gg: ASbGncvtR0NbTQJoouRcJOdyZaO/D8Bk/EvjhM/M/TE4UkOIQHVT2Wtkr1R/oIV7UNA
	d1s9N/akLOhVSsHLUk+APRhuWjkQH+DfIB8ZNlfXRx+2NoCJJFP3jwXRManSP
X-Google-Smtp-Source: AGHT+IF4O5to35Fp3uU8ZPty/LQsJGiAI4N3ifX4wI6fMkZ2fFE6ahvfXghwATBrmJBa3pCXcWSZNlV3gGchGd0nNxQ=
X-Received: by 2002:a17:907:7fa8:b0:aaf:4008:5e2c with SMTP id
 a640c23a62f3a-ab38b0b68bcmr3031867266b.2.1737731452364; Fri, 24 Jan 2025
 07:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122122459.1148668-1-maharmstone@fb.com> <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
 <20250123221122.GO5777@twin.jikos.cz>
In-Reply-To: <20250123221122.GO5777@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 24 Jan 2025 16:10:41 +0100
X-Gm-Features: AWEUYZncL2duuItq-89zXioYEQNiMpsnKuGcfoZbZ__fg_251rcSS5ghZJwHFrA
Message-ID: <CAPjX3Ff1QqUivhMj=uSeQMSFjrvpeOK6W1CfLOwE+3gMjLsiSg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
To: dsterba@suse.cz
Cc: Filipe Manana <fdmanana@kernel.org>, Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jan 2025 at 23:11, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Jan 22, 2025 at 12:39:21PM +0000, Filipe Manana wrote:
> > But now we always increment and then do the check, so after some calls
> > to btrfs_get_free_objectid() we wrap around the counter due to
> > overflow and eventually allow reusing already assigned object IDs.
> >
> > I'm afraid the lock is still needed because of that. To make it more
> > lightweight maybe switch the mutex to a spinlock.
>
> For inode number allocations a spinlock should work. For tree ids we may
> still need the mutex:
>
> btrfs_init_fs_root
>   mutex
>   btrfs_init_root_free_objectid
>     btrfs_alloc_path
>     btrfs_search_slot
>
> The difference is that inode number allocations are per-fs root, while
> the subvolume ids are exclusively in the tree_root.

Can someone else hold a reference to the same given root and perhaps
already created new objects while `btrfs_init_fs_root(root, ...)` is
called?
This sounds counter-intuitive, to re-initialize an already being used
root. But that's the only explanation for the mutex here, IIUC.
Otherwise it would not be needed.

