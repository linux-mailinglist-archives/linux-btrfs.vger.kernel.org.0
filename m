Return-Path: <linux-btrfs+bounces-9568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E63C9C661F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 01:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145772860FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 00:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950438F6D;
	Wed, 13 Nov 2024 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ja/ZMskC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34152AD24
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 00:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731458343; cv=none; b=KuR8icHM+JKzwRcCEzNDxRdxt0z0GRIo8N/yBhYHYZzJi6oLoVNIBo6mpLbBpw8OlwZScuwzJwnDph4jfCAMdJM53jfFTpdLY9/Mt3Zv6W8Rb4bQe+QWEwN+rtcQtUzWgbyq1s35z0lgTkzi9YDHz4YtkYlCBONTnLUPba4U6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731458343; c=relaxed/simple;
	bh=YpobwbtA2+vKxtJu8xZ2FUyLg/btakBlHfnLUEUx69o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbV7UMLXmtGxshTqaGP0QgQKODuONtOGzF2FFiRhxvCzi7duPnguj++ijloLKoVcgTNwWu9EHTcO6iMKU8EMakOQ4nbJ1rRQppHJnS8oZaKqD/NU2jYYx1aMG600GGUMFkLq5EkmaYEKhR30JXvQv6mGIVZjKx8B5CBlY7XPNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ja/ZMskC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9ed49ec0f1so1062061666b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 16:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731458339; x=1732063139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HToIlSDY7cOn93fCLokqkKx9Z4UBbjM0FNxhpulJNm8=;
        b=Ja/ZMskCnUA4Xq/kHps1IIfUqZ9+S9yc4I7icnSUUBo5X5d6KEwn0etIF3WZ/uMZwh
         ZxVIg45NOS0bTG0o4NLg8h3p0wgTKY6tuaEVrMEoODZXPn+R/8fF9BwzPoEW+r3umbW8
         8RPsQl6enlHASxWOWrApkO2ngg8E0gmTRAm2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731458339; x=1732063139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HToIlSDY7cOn93fCLokqkKx9Z4UBbjM0FNxhpulJNm8=;
        b=ZWLPDHUvNAusXoRxX+O6Huoj60tkbnqzFrBFxt2h9Jb7AhH3rGONDReQdUmBbJul7P
         47VoHe7AI+QFwbYpyrNgQ9XEkYIlOEggc0fV8b77J6kMGvCB6WX80Vz5v/ZnSwlvMCY7
         ircKApuQ5hJNNlBJ/6M3WU4OAQyUMUfk4rPBeIhYObCY3MLOOsNjKuCk0p9545TJrfFK
         G2x3Zpk5lWwuyCl3QnTis4PW+hblWEzij7HbGxLiAI80O79vV66TFYzYiuyZ5//LGlum
         Ivef+h1UXppQk19Gx2jXmJphiDPIySe4e1ThbYTVHQCptn+WlKA5Vd64rV12+43oYyQK
         9STw==
X-Forwarded-Encrypted: i=1; AJvYcCWV5nm6/8SxrGWbBrP2ziI4K9Ap1NgVkh88gO3pHlKJD9kjhIpQvHkFtbhLHh/EEyrF2SATIH1d0W+kKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrOpMhhW/VFHE1H/zAl/ExQG1RHrb+63NiQRO8JLu+mj2bcOvX
	2pW1/x6VZBCoIT0llcJZDyU+F4i8+vGbUlrfOF1EpIGaYN0dW2MDPlQWJC6E7V0QiiM9H90lKpY
	FueB1xw==
X-Google-Smtp-Source: AGHT+IHGF5p1EIqkoIYOy6vB2mcv73F++TCWNC5gADaSnj7b+ygY0oNWQ9cqnlDvVy3qUXLla/O9oA==
X-Received: by 2002:a17:906:4fc6:b0:a99:4162:4e42 with SMTP id a640c23a62f3a-aa1c57ae66cmr536723966b.37.1731458339143;
        Tue, 12 Nov 2024 16:38:59 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a45dsm784432266b.53.2024.11.12.16.38.58
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 16:38:58 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so501036566b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 16:38:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7/2lXww4YTB3t2Pi7Ye3RhCrtN4OPBVpgvK9p/0oXHW7I/+i2JUAOJVPdF7E5VZTepDjuk1YzzduNNA==@vger.kernel.org
X-Received: by 2002:a17:907:1b0e:b0:a9a:1792:f05 with SMTP id
 a640c23a62f3a-aa1b10a45a5mr487896766b.31.1731458338247; Tue, 12 Nov 2024
 16:38:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
 <20241113001251.GF3387508@ZenIV> <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
In-Reply-To: <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 16:38:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVzOQDNASK8tU3JoZHUgp7BMTmuo2Njmqh4NvEMYTrCw@mail.gmail.com>
Message-ID: <CAHk-=wgVzOQDNASK8tU3JoZHUgp7BMTmuo2Njmqh4NvEMYTrCw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 16:23, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 12 Nov 2024 at 16:12, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Ugh...  Actually, I would rather mask that on fcntl side (and possibly
> > moved FMODE_RANDOM/FMODE_NOREUSE over there as well).
> >
> > Would make for simpler rules for locking - ->f_mode would be never
> > changed past open, ->f_flags would have all changes under ->f_lock.
>
> Yeah, sounds sane.
>
> That said, just looking at which bits are used in f_flags is a major
> PITA. About half the definitions use octal, with the other half using
> hex. Lovely.
>
> So I'd rather not touch that mess until we have to.

Actually, maybe the locking and the octal/hex mess should be
considered a reason to clean this all up early rather than ignore it.

Looking at that locking code in fadvise() just for the f_mode use does
make me think this would be a really good cleanup.

I note that our fcntl code seems buggy as-is, because while it does
use f_lock for assignments (good), it clearly does *not* use them for
reading.

So it looks like you can actually read inconsistent values.

I get the feeling that f_flags would want WRITE_ONCE/READ_ONCE in
_addition_ to the f_lock use it has.

The f_mode thing with fadvise() smells like the same bug. Just because
the modifications are serialized wrt each other doesn't mean that
readers are then automatically ok.

           Linus

