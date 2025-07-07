Return-Path: <linux-btrfs+bounces-15290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F242BAFB367
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 14:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006FB3B781E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 12:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8305729ACDA;
	Mon,  7 Jul 2025 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L2xOriSJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F2E13635C
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891854; cv=none; b=ungu95RfWWqUgH5qNGmsnQyDsDNca1GiQnDyE0bZyaKKMHqYjflyZi9zzyrFoQOVfPAE4xa9RA/Y3qhiV4WUo6Xg8C/lE/UABwHFt7c2duGqC03g/FysEws7oM18jKbPLas0m1+RQoTd1/18D2goCZFF/unXD63CpWkeVmSvSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891854; c=relaxed/simple;
	bh=uDXQ/sh5nzaYsNNJ6nY/BuLrhCgjwCDbHF0+rclAATk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tK+v5UaqU3bzux8uhni9zQ68a2wdH1LhC4PJUf0p0peTjCo0xbB+uGsEeoOeR24hysLkDBVxaDyx1dqqAy9BlQdf5NJ98IwBRik0hTLT07KhNZmUk0adYInV5xTIyzzJxwqvBjBuWOYQYVrUoq5fbPvBz0llx8RseDKm9I34UF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L2xOriSJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-adfb562266cso482659566b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Jul 2025 05:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751891850; x=1752496650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uDXQ/sh5nzaYsNNJ6nY/BuLrhCgjwCDbHF0+rclAATk=;
        b=L2xOriSJ6vC8K8ZTrQ/kyUagMhoG0JSN8fC4ybk1sSY9Pn6EM4ZzqWjej3Jo99eW2A
         fAmD+oikPhPIAFuPInl0YLH1RA3qx0Pgvg+TKpoPcdklLyts+91kfFFSDhytndPF9Mjd
         s0cjzVcdtUkP1aT2KyEuHwrWY6wmyTtmAuRJ2r+3BhX4rMJAzduMwNzx8MuSiwZAt0Hf
         XTtOvl2tduiEyoKeX5E7SiQr5ZEbRE+iQexrjWx3vhkZ0iHGaeMiyQuOdAnYJA/RPyc4
         Hqs1w2zkhD3A3jQCyT7sPhFUZ5tJ/YiW+ZVxXU198QFh2pqvZbyvfgQjxGFhyqirjAcf
         l/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751891850; x=1752496650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDXQ/sh5nzaYsNNJ6nY/BuLrhCgjwCDbHF0+rclAATk=;
        b=Qh6WTeWKkpYyV34lJ5T7LW34okr1/VQID+o586ZfhKx9b4QOU1ohW0rMpQiArHbxy/
         tpG/+kt5iYozrfrTwlUEEqLpemnhYzbHNGeQj2zJlfmzRWrxTOi0izZkiLnf94X0KzAG
         GXDaTEtioHbaQ0nBTlrSMCAR2PQCp0VXpezhRypx2FWnV1taVWkASmRqdRv1CgQ4r6Wz
         oBVY9WFvd8CaToF+0cqR5+kx1/xgkBspobegY7JrCV0hFFFmhaytvu9JFDrtsy3mv1k/
         H0gMGkoHRIDAq4X1xnGjQrG4QQbKRjKGzSVY8pjqGfImDQ8uJUtCSHmqD2SeCg1DORTM
         eDUA==
X-Forwarded-Encrypted: i=1; AJvYcCUmtnIN+hqwc6YwKrZttZ+je8CFHSKICwELnNCfNbSMWwYkF4fF7F7dJRJSBSEFTvDhLbHrOAbl2YcOJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoulLcDlo0l3bW9XuxEGcZfVEyVg7asYsBxejyfG69Dy9xf4b
	9Al8cRgzl7HNWWg6sovkA3vqBVFsq/VT1wavSiE18wfuQnjg7+MlqqxPPR/vFmx+8dQ8yzijRYV
	5Zy3eFsuri1efcuVHd7qOioJJtl1/tEaJEb9siAgSRQ==
X-Gm-Gg: ASbGncsISGTqF4VzJlKYq0vAk4eeFsj94XrUa0u7C6UzRXFpa9NQvRGPBFFqmWaN886
	lxDfC8XAIhGJ2OAsy0Z8NLH/P2N5wtP7rPTCX/AfDk1tR4hK/aVgnarRQdt3zJ1QlUWnPTydF7u
	OU3Xss1UIbYtJZdeRS9USyvwHfI3jw2X5BwIEBpNhXyA==
X-Google-Smtp-Source: AGHT+IHxFtEikI8Eyk45DoTw3MShPiwVzUuB2DyWQNCcmEoN1QhdL1TONRO/s5l8Nk5Vgr63HipylA/ufemaBrcOsPE=
X-Received: by 2002:a17:907:7e8c:b0:ae3:7113:d6f1 with SMTP id
 a640c23a62f3a-ae4107e0468mr853051366b.25.1751891850214; Mon, 07 Jul 2025
 05:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
 <8abcc475-98c8-4bb7-add7-c4fa40065add@suse.com> <20250707123026.GE4453@twin.jikos.cz>
In-Reply-To: <20250707123026.GE4453@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 7 Jul 2025 14:37:19 +0200
X-Gm-Features: Ac12FXwil7MnHm9Dd1U3U8-_CSXh9YZFWvoof0-J_1R_txLZB-no0c8dfIoQFeM
Message-ID: <CAPjX3FcFRb53ZVnP=DkKvo9Uhw=5YgEV+b7SaWNK=yzLv9PpHw@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is
 being frozen
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 14:30, David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Jul 07, 2025 at 02:53:58PM +0930, Qu Wenruo wrote:
> > > Reason for RFC:
> > > I'm not sure if cancelling is the best solution, but it is the easiest
> > > one to implementation.
> > >
> > > Pause the scrub/balance is not really feasible yet, as it will still hold the
> > > mnt_want_write_file(), thus blocking freezing.
> > >
> > > Meanwhile for end users, pausing scrub/balance when freezing, and resume
> > > when thawing should be the best outcome.
> >
> > I have explored some other solutions, like dropping and grabbing the
> > s_writers.rw_sem during the balance/scrub.
> >
> > The problem of that solution is the reserved lock sequence, thus it will
> > be deadlock prune.
>
> What do you mean by 'reserved lock sequence'?

That's a typo - reversed

> > Currently I guess the best solution would be introducing a special error
> > code (maybe >0? -EGAIN may be a little too generic in this case) so that
> > if we hit that specific error code, we error out as usual.
> >
> > But at the top level where we call mnt_want_write*() function, we drop
> > the rw_sem, and retry other than exit.
> >
> > By this, we split the original long-running ioctl into several different
> > smaller sections (the split only happens after the fs being frozen), so
> > that they can properly follow the fs freeze behavior.
>
> We have cancellable balance and scrub so there are checkpoints that can
> be extended to also handle freezing in a way that pauses the operation
> and waits until unfreeze. The sequence "drop locks/freeze/take locks"
> should work. For the exclusive ops it's guaranteed nothing else will
> start so the state will remain the same.
>
> > The challenge is how to resume from such interruption.
> > Currently neither scrub nor balance can properly handle such resume and
> > will restart from the beginning.
> >
> > And even with that resume implementation, the checks in this patch will
> > still be needed.
>
> The checks peek into the interals of the freezing mechanism, which I
> think is not the right.
>

