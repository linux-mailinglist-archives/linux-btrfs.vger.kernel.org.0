Return-Path: <linux-btrfs+bounces-13961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD8EAB4DAA
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 10:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CBD8179822
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 08:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9B51F4E57;
	Tue, 13 May 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KXEI0iAX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4341EB1A8
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123698; cv=none; b=Fw8KAtDUZ9KOn5YdZxS5oOpuwE/5UVVvQmqB1xniz5paBONDhDDiB5mk8GoNjkgVL0rrDr9gSf0xTXvcpUYS1GPBoSBNgRwkLUjhEgPZAB4m4g162Rdc9IJNFQ+FCIwpG+FaxAKbrjgr1GG+eBaY+xQduTBuanZpgKp2mZuwkhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123698; c=relaxed/simple;
	bh=L2fUONMvwnW8yiHGxt/Cv3eCXBmSe0K4+Yn3jlPnreU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOoQnPChHuns0lqT65egD5vzUT1kwpKxzazCIm8g4vkMnn1GWwojvydHjDpquHmloKlaElRrGv0fkzFR/lU/YhOzubSZyDo/d7mq5OY7JVmmNmA/EEiNX1G09891Fb9yEIpNMlr7R7uu8E4/d59OIm5Gh5dcv2cBQQtnPygE0AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KXEI0iAX; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fd0d383b32so4337274a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747123695; x=1747728495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L2fUONMvwnW8yiHGxt/Cv3eCXBmSe0K4+Yn3jlPnreU=;
        b=KXEI0iAXx2Zj4xumoxPw7G6SuLVZzZGf5ovqJlrs/fx9weVgXtah8kMNbeIq9XwWjr
         tAeHUDLhNXypPU8lACn+aBn64nS4lLhM1WVDz1x21x22whp5YxnmiquD8JEEYvXkHd5e
         PJ1nm36zNjF8v0+rALqQ3h5UebhL8v26qbPbzdtL2fk2IjqEYeSJPnpnMN+NXsS8Q2Vg
         JSgCYi2Rnu53hU0+0rrdCJtNNDPg1UawvqlUrYwRDBKMqNYImr63e7ME8iPnjKy5p+N4
         x9fuV3/GzL6SXxWaEtSw8WqSn2vP8HWzQ8LhMYIKiQu/Ekrg4XMqxzNPXygzP0E/hG2M
         MqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747123695; x=1747728495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2fUONMvwnW8yiHGxt/Cv3eCXBmSe0K4+Yn3jlPnreU=;
        b=PetGEmYXHD2aWjxkh9EqS5+TKj+1luG5qGyJY0kVcfWjV928EFesbTCsHc128v695y
         v3XAIABBpEjtYoLEg4huGmoXG+Cp4jRml/DPUu5vt+tUzoZyJTgXisRlFGeScrX9dGBT
         1Mqu4qTcNXr8CpBLvHC8U8FNMbFP6v61flYxwWyVB2AzMH5uxdWULqY9SBn/khsPrKRe
         eRQT0CgRavWN1QgSxIva4ZoGvfWFQxbctHbqIjvNLvsSJtdakRIUYr+Bsy656GiBmxnG
         n9p95crQL07UgtLmq28GjnxpF6k7coEt82hz3mQpwjoTmZrl+sBOey4KumdY9Y5hDYim
         Zlwg==
X-Forwarded-Encrypted: i=1; AJvYcCXzYk6QCknseGXMsKEybO5WFur9/dJVzOdAx3LAoSlQOY/Vu9ZeR3P5/APasTZd0PjfsC0fjrZT1stM9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Z/oRHe1WgyOsaMGXxGE8xrY4yIlqKOgkiS+iRCkjt+3YlCwO
	dFC9SLn8AINKASpbk/+6YCkXsJq1IlmTwlOWWUSFGaNL4RWdLA/L2CxfzD24LFmB8clIA2QKod+
	Wk8kefn1a6fO5BfM0zi7H2wIq8qI+/sf7DbbqAQ==
X-Gm-Gg: ASbGncsc2pXB+hSxLILrKf/T+jFQbNRUq1TG51wq02zWdCPHvWbKTCGzHHKePQnGFKG
	kFlZr5mlghj+AGc23KM3IMj/DeD903YO/q9EsMRfCx0xewyzicju6Sh8zg6fhQoY9iXsA4Joqlb
	ZcMNXkb9i/ee7fMmW9LhU9yCMRWmDQdWImm4YGS0NvNg==
X-Google-Smtp-Source: AGHT+IHads4QlEtEqDY0AcLA2qwd9nCVGS/i83MACpvcqYx3SKhyrTWngOEajmlG/EhswkvR+dusb++aWne7YfpHpW0=
X-Received: by 2002:a17:906:adce:b0:ace:d986:d7d2 with SMTP id
 a640c23a62f3a-ad2192b5c89mr1251560466b.49.1747123694914; Tue, 13 May 2025
 01:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512172321.3004779-1-neelx@suse.com> <20250512202054.GX9140@twin.jikos.cz>
 <CAPjX3Fe1izCGUJhTWk1mB=9uK7kNHeCOj51_TZQG7DOe_aooig@mail.gmail.com>
In-Reply-To: <CAPjX3Fe1izCGUJhTWk1mB=9uK7kNHeCOj51_TZQG7DOe_aooig@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 13 May 2025 10:08:04 +0200
X-Gm-Features: AX0GCFup9GV-6iFM44V2E1_7oBRjVed2wfgAv6JSFREeDOMW27ll8odrJ9yyM5g
Message-ID: <CAPjX3FdBCqDLyOyoQkm16-rQLGbPu-3mdesepd9KbpCa=mPxwQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: index buffer_tree using node size
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 09:56, Daniel Vacek <neelx@suse.com> wrote:
>
> On Mon, 12 May 2025 at 22:20, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Mon, May 12, 2025 at 07:23:20PM +0200, Daniel Vacek wrote:
> > > So far we are deriving the buffer tree index using the sector size. But each
> > > extent buffer covers multiple sectors. This makes the buffer tree rather sparse.
> > >
> > > For example the typical and quite common configuration uses sector size of 4KiB
> > > and node size of 16KiB. In this case it means the buffer tree is using up to
> > > the maximum of 25% of it's slots. Or in other words at least 75% of the tree
> > > slots are wasted as never used.
> > >
> > > We can score significant memory savings on the required tree nodes by indexing
> > > the tree using the node size instead. As a result far less slots are wasted
> > > and the tree can now use up to all 100% of it's slots this way.
> >
> > This looks interesting. Is there a way to get xarray stats? I don't see
> > anything in the public API, e.g. depth, fanout, slack per level. For
> > debugging purposes we can put it to sysfs or as syslog message,
> > eventually as non-debugging output to commit_stats.
>
> I'm using a python script in crash (even live on my laptop). I believe
> you could do the same in dragon. Though that's not the runtime stats
> you described. And I don't really think it's worth it.

Eventually you could use a systemtap or bpftrace script. Though both
have their pros and cons.

