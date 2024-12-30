Return-Path: <linux-btrfs+bounces-10657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D939C9FE9E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2024 19:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3ACA188356E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2024 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EAE185B76;
	Mon, 30 Dec 2024 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fa1jrUJN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7DDEAD0;
	Mon, 30 Dec 2024 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583737; cv=none; b=kzRSHqVoG+9JL0+F+Eh47lkzVRBQAMzzyHkjKIlsH6dJPPD9t6oVsthBCA/5FPEARr2GnwEW+es5P9gWqZPHRGm0JXZYp2KNbSPAD8ttQfxSLhG+4pJcJjvw1Xhs+e4rE52EelxwB3jrICatZfoNXKmV58sfvAOPeJjNWguomR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583737; c=relaxed/simple;
	bh=oAsZTqA7KCEX/Dr7Pe4Isw43q5D9gYvHYO7KuuLp22M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl5XsoVVDHzv+yRKJHrL4GcTh2KXBVkA+xMykLwjPt+0KxLeBvRSzKFseU/HxF9aw/STJwCgw+tOiMOD4B2TAhsnBskGJxFQYPjA6XBPHqqXzY+WZ5WZ+9ailWOa0a99ICN04jyi1KtEx8yzRsYxomWsHYjknelSrlG85L9su6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fa1jrUJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6067C4CED0;
	Mon, 30 Dec 2024 18:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735583737;
	bh=oAsZTqA7KCEX/Dr7Pe4Isw43q5D9gYvHYO7KuuLp22M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fa1jrUJNeH6jyt2xAbZael39xMy4nTJq3OLDg64tKT//H4V3VMKJNCI1+IUuPc7bo
	 MV+AcKIMz/fXJjLgF0nLghHYgPJWPuY3yJHyJZteWI8k2S6pODjTJFPBDNVuemkhgO
	 TqqwbUmk7vaBb59faMZjGMQlafiXS8bVkwcYsgj8=
Date: Mon, 30 Dec 2024 13:35:32 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 6.13-rc5
Message-ID: <20241230-electric-coral-boobook-b49274@lemur>
References: <cover.1735454878.git.dsterba@suse.com>
 <CAHk-=wjkHJSqXS6RnJnbMiDM9Rk58oLWLr9T4qyUO3omX74-fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjkHJSqXS6RnJnbMiDM9Rk58oLWLr9T4qyUO3omX74-fg@mail.gmail.com>

On Sun, Dec 29, 2024 at 09:41:08AM -0800, Linus Torvalds wrote:
> "endianity"?
> 
> More commonly called "endianness".
> 
> I left it around, but I really don't think that's a word.

Clearly, it refers to "Endiana Jones and the Least Significant Bit Crusade."

-K

