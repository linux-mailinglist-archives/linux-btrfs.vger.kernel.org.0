Return-Path: <linux-btrfs+bounces-9567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE99C65F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 01:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17BECB2D741
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 00:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A96B665;
	Wed, 13 Nov 2024 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Aro67tLO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856623A6
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457430; cv=none; b=n994/+dXeHcEq1LFXEzvQzYIGrI6e1y62GHihtP8LgxqXfheKfIK0k6QdkJUqeouiRsejim+1VIFFdm2QdZaHDjBAgO+rzbJmOhUBJKvpk5nQfwC3g6voll73ESwZvtWL76tIxaCroMVGGE6+q2B70eXQJF+CV4xILvH7Zslrc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457430; c=relaxed/simple;
	bh=3EvWd7pwnGEo7dSfx/lB6lTVU0t1HY+pMEl3MV/3ACE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2Mbx7ft8A87Ualvg04Eki/1Z+9WCQCpV18LWFV/qFyG6XJxJDW9mfPPQnOTo1lfGwYurNCfSdO4eJR8ak1yDkR9NsqBXsqGP0ccbeU5p0Hbk+cSVOAFaqkeijHiYHhVYhIgXwVP4/D1b+W8egsxgWeb7hDfe2k0sAxcwVN0mVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Aro67tLO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso1063505566b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 16:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731457427; x=1732062227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WupZbUO57pzsyzLIiF16uH4yNUQCRicfvRdbxH31iT8=;
        b=Aro67tLOzP3eQSWGa50i5YyG+88HpyzcwLe24wymxNxGfNBcFa4HIQN/5b/ubbIG/Q
         C5hbLHgl5W1kEnxpL4pFFsKZtBkUYyWn56k1NnX7oJp7S/Neu0lFWUuPAYkovUzcGRV2
         TuiDC3hEGTHsGkVCdwM34EosEW1CWGRWLF7Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457427; x=1732062227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WupZbUO57pzsyzLIiF16uH4yNUQCRicfvRdbxH31iT8=;
        b=JaLcUqyPetx1jFyI03V0Pn3lnhXYaXRDU+5AqHtESQTTZ87AfLjN4Wac29OjYmAQDU
         MxgZszR2hVPoXueKNVqW2li3fV8TCcptck0mCOosTdOBGwQG5mNOY6HBjcLwYmHQuIHr
         VRkajpGCbgIKIJC4T8rgL8uiaWsTDQ3G1HQjn2red1XKMUq97FkR1KsSQvUtNcwzA8P5
         M1YaCZXvpG7kviDMZ+cDSC/PrZk6+KQeazdbXEqbS+ddJqECmpBLr/3lH2ABOEuDbVvq
         X1poUDpmsMm3+MDtFoEdOUnybeSnLgTYolvRHVzNI2G4+/kSLzXbwX0qdyyYP5G64Lf0
         Cu1g==
X-Forwarded-Encrypted: i=1; AJvYcCXoXfHbxX8lCzgTji1KXvQ6ag9mPpRJZHXfyiBwH7c+fFI3rHO6u5m1pCEfnwp6tkyROSdY9+2+BfoGcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPHu6bFcnj4MvrkU5DrKfBuzEtS30T4PW90Za5jmMFBwc6eyKJ
	J6F2gCXV7VQYIiIfY8HSWQ6XDNRk0FEO25HkK4b+rSXItNjgjAbGU5vryLvaTsH6+rkFWHvx8+s
	OOC4v8g==
X-Google-Smtp-Source: AGHT+IGrU2cECYofyiR8y0UuHPow5a/z+1VA837fX1m/K51OVkrb6PGsGvZO4WuwugSZVOSSCZDKeQ==
X-Received: by 2002:a17:907:3e02:b0:a99:4261:e9f7 with SMTP id a640c23a62f3a-a9eefff12ddmr1673809066b.39.1731457426676;
        Tue, 12 Nov 2024 16:23:46 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc49e0sm792614766b.123.2024.11.12.16.23.45
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 16:23:46 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso1063501866b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 16:23:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMYMsJa0iP1Zl3ZVxzRmEotAaK3A+7b/ub+IYpvoNONO/O3kkKPD0qwVU4ovZZdaW0vLMt1CuSK4ZlbA==@vger.kernel.org
X-Received: by 2002:a17:907:94c4:b0:a9e:8522:1bd8 with SMTP id
 a640c23a62f3a-a9eefebd13bmr1910160166b.6.1731457424914; Tue, 12 Nov 2024
 16:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com> <20241113001251.GF3387508@ZenIV>
In-Reply-To: <20241113001251.GF3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 16:23:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
Message-ID: <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 16:12, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Ugh...  Actually, I would rather mask that on fcntl side (and possibly
> moved FMODE_RANDOM/FMODE_NOREUSE over there as well).

Yeah, that's probably cleaner. I was thinking the bitfield would be a
simpler solution, but we already mask writes to specific bits on the
fcntl side for other reasons *anyway*, so we might as well mask reads
too, and just not expose any kernel-internal bits to user space.

> Would make for simpler rules for locking - ->f_mode would be never
> changed past open, ->f_flags would have all changes under ->f_lock.

Yeah, sounds sane.

That said, just looking at which bits are used in f_flags is a major
PITA. About half the definitions use octal, with the other half using
hex. Lovely.

So I'd rather not touch that mess until we have to.

                Linus

