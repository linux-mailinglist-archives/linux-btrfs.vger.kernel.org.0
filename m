Return-Path: <linux-btrfs+bounces-17901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A1BE4F5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 20:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9413E1A684E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B523184A;
	Thu, 16 Oct 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HT1UX00a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E57223715
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637519; cv=none; b=JR7opJWW1uRKUXt0HqjerXDCTIv2Of5e0/KG4PFAOjHRNOdesy1abZ1tAXFY2AaenAciivMfd3K2+WzvD7pxPq7hlRpXmOJGYxy61X+IYJwHmLwFEHfvuWzylb14YZTigUyK2LtlqjBUlT7OrmcDRVI213kmND5cedmAIxJEJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637519; c=relaxed/simple;
	bh=R3RwGP6QHDreMcxjaLIw71PUQygCZwdeGhPBMRoSyzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqB6z1IFOFNFYjyBXn2MRaFj6hOsUPTPQ1Pz8r6RgO7Jq83uUd1nCnYDx838Juyf5Bqe49zHqo4t2jFho1kWjfpMgJ1WgmsDDWDcny5zwL7UsvU1H0mcWMVfib9qhmMwPWVheAUKpFVn4thMM+dVIX1ziFHvWnBhskFl48uYjag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HT1UX00a; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3da3b34950so163320466b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760637515; x=1761242315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fZNdo6IOExcFVFfhr7rwkSFSNClAo0oWYAwloq7HC0g=;
        b=HT1UX00aRfcMEXc0Co8J+L4FNA7f+AQFJERoYX6Ye8Ecc3y5RyWAbFIBCdGtRQFVhE
         1iwvIUtgmuHJJsbTiudjRSNIVbWd4LR953x9VP71CePdtqLyfg/ByRpd9HSRdwv7w9zM
         k8lpxRS09zmrDgM6ILJbL6AsSDutfwPWySlF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637515; x=1761242315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZNdo6IOExcFVFfhr7rwkSFSNClAo0oWYAwloq7HC0g=;
        b=YU2OgvBEuoPznQ5IyyQBoJhDysajenHDZXiHNXpv8ogEFgQ5RLJKzanqEpklJxskAf
         taRj0DqQMKGOX9erdYoifMhvgFPDpkROSbyGmhWSHbb7LyCR3aoZLP3CSdXr8rTNa7O6
         z70hAcXBuzZcNeuKfUpnQumjfZB2eUcaY0w2rzMLD6+5aWkbnY72eSPE69iEHpo+Q8Wv
         aIjAlZt7eW0N/r6nYSSVz9AjhxCOFyRjAeXqORKIpo+t6dCAEZiCTImKXNy2roljBu8I
         5SBT0CdZBDWfW4GMsLWWvBvauo0Lw5wB/V1zX+qikSJ84UBgqbQMxQv7eHGzZu/fqOei
         qYIQ==
X-Gm-Message-State: AOJu0Yzjemoh5QudvwyNFNki9QAeQ1jW61GDK3ZbnKuc0YnnQk3GSo4K
	beJ3oSOq1UY6NxoFtBvezGKqNZcAtPxl16uel/YrPedU5w77ypGcgjlJtuoPbsr33Z9xSydb8+n
	5zXTzMqM=
X-Gm-Gg: ASbGncv+N3NkKV9Gk631T1aUtSr4IT3AfdoHcBZ/Sa56ZPiGffehPyTOyivGsIg4BR8
	TGRE1NPXU3XoQSlYgbPYJIDawwNQl5c0UrusubMBjKnNEKKpwVEnj70DdchiGGVuH7BrsYyOIMI
	33Ywg8XCwwv3Kk6XHHcl1Jzojx4Y/dcRkSXlHF2udvt6eOoqBz7tVgGMnGHNigGn4M7X2RT0gb+
	Bu8cqWlP06BEXRMmjVPLTkjs6AwtaSyO1Qqt0pa25yuDbDlvILnLEVVcmc1kS4GyoYHQmcwnz6/
	310VDF8GMKmOphYJu/Fs/wterSZ8GfNr6Ii9ZhWJucZkAzE1P+BMH9M/Sw3OL8LU3x8hu+crgyT
	aGuZbfXMl9Pxu9h9nzWsONyEIGp+CJ+S93/njNv5FrZzUZKhl3uYT1X7m5C8/WLe0go6U2Ex/df
	84YWR7ygHABIVUbaTpQPu1+bGe11j0YRn3HpTanZTESXUJ8+64DxSoW2oN0OxM
X-Google-Smtp-Source: AGHT+IHOU49ap0k6bbwRu/6tIa8Epvc4Ejj98wzqL2QUWegHm+Jo9iJ/E7WeHNdOrkhl38/iMjnehQ==
X-Received: by 2002:a17:907:728f:b0:b47:c1d9:519e with SMTP id a640c23a62f3a-b6475510e14mr91316266b.64.1760637514791;
        Thu, 16 Oct 2025 10:58:34 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba06b7f6sm594755466b.30.2025.10.16.10.58.34
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 10:58:34 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-637e74e9104so1394979a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 10:58:34 -0700 (PDT)
X-Received: by 2002:a05:6402:280a:b0:63b:f4b4:a005 with SMTP id
 4fb4d7f45d1cf-63c1f6419c0mr820839a12.10.1760637513765; Thu, 16 Oct 2025
 10:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760633129.git.dsterba@suse.com>
In-Reply-To: <cover.1760633129.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Oct 2025 10:58:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiysgAErOobR02zECiniaM69AacAHjTOSKsv3yDF2R+A@mail.gmail.com>
X-Gm-Features: AS18NWCW69bbQCilJuwzNh2MGEz8nRlr1ju2SK0ZTD_7Tzbzhzpwc98VIVLFRSk
Message-ID: <CAHk-=wiiysgAErOobR02zECiniaM69AacAHjTOSKsv3yDF2R+A@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.18-rc2
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Oct 2025 at 10:00, David Sterba <dsterba@suse.com> wrote:
>
> - reorder send context structure to avoid -Wflex-array-member-not-at-end
>   warning

Ok, I took a look because this sounded like a bad bug, but that flex
array member really isn't a flex array at all.

It's clearly intended to be a fixed-size inline array, just using a
flex array for syntacting reasons.

And that not only resulted in that warning, it also means that the
compilers can't actually check the *real* size of the array and won't
realize if there's some actual overflow problem that they might
otherwise have been able to see.

I do see why it's done that way, but it's not wonderful.

I'm trying to think of a way to do this cleanly - we have some similar
things elsewhere (like the DNAME_INLINE_LEN for the dentry, which has
a similar kind of use-case).

But in the dentry - exactly to avoid using a flex array when it really
isn't - we have that ugly "calculate things by hand" (and the whole
union shortname_store, so that you can also treat it as an array or
words, but that's a separate independent optimization).

Sadly, I can't think of a way to have the compiler just calculate the
right size at structure definition time without just having to repeat
the whole structure definition twice.

So that flex array may be the best approach even if it has these downsides.

Does anybody know of some C language trick to get the remaining
padding size without repeating the struct definition?

"offsetof()" sadly does not work until the structure has been fully
defined, so you can't use the "obvious" trick

    char buffer[256 - offsetof(struct .., buffer)];

and anonymous structure members not only don't name the container, the
strcture type also cannot be named, so you can't do

  struct outer {
      struct inner {
       ..
      };
      char buffer[256 - sizeof(struct inner)];
  };

to create that buffer.

Oh well.

                 Linus

