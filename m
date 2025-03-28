Return-Path: <linux-btrfs+bounces-12662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA19EA750ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 20:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B84817467C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 19:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5671EB5C4;
	Fri, 28 Mar 2025 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vIW1Tjqs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31C1E5210
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190773; cv=none; b=ltvwLPHSTlbEHuVI3nWF9U+hqj0OD1R7e5crDSOOphrHLGRt6ZrXeUl0uqlZOFTnlv4p+559AoLTfZspZoqpS0TaozKU9Joq578amnlhwpl+vm7gW1UMKJOWsROQpyl7qg2Hl3zIN4ovoEI5BSuaUba09LGxODpawMjXtY38iEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190773; c=relaxed/simple;
	bh=V0K7NbtT09jiv6bfsVBCX7tzAVOx+L7chrMHACvLMv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aR9A1A9z5Y6+GuzJXXQzVAMzfNZaLTDFgsotbRM8JtczNsPyMQ2TQyBQku0HvJOeTrZktChwX2M+0WWC2mOJfU067OgNk5eZSygxqk0tKzXeoWxgyJz7jtp52zkSS/rw1yl68w5FpKO699T2s+VndNnt4C07T2YMz0YRJfxpgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vIW1Tjqs; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e573136107bso2584009276.3
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1743190770; x=1743795570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdBtrPZStDtsyWLCiRnfvRgxPmCLX0qoCErlhSiCBc8=;
        b=vIW1TjqsAfSoZ/x92P2rEeAApOOxGGal0miDIvUadPXd87KDdlJ1/isPX08Plh8BoD
         2JUPbUoNZzJMVY6FV6jFO+6qFjTWlz1qbNQfG2E81+BCa8UajZUgdD6dZsGYHNX0roB1
         iTIb2Jfnk8WYkzX3g6K1W0FtWdlFreBLn6lmycvhjDR4SxPLJEBq8iQdPaR1zIgvnRBr
         Me0LX8kYAw1FnK0DjJqCmIc8ZAHWtkU1h5Tu/jMCuAty80TW4MyW4Ri9JlhWu6Uecs+4
         WGpdCInt6moEV7pqSSCBwCY3TpCwV96OaEzS1Sy+BYeut7/coemX+/lAJ+10jpEt0sRx
         ZSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743190770; x=1743795570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdBtrPZStDtsyWLCiRnfvRgxPmCLX0qoCErlhSiCBc8=;
        b=W3p0RWROvjV996zUHu3cVbT2N7Lu4/BBxRimGUATEdFysS7traLtA2nYl7bXR4c30S
         ntEMIZZYyftShvJ0JHd6AnVOJdhYRObrEWrU01zGAtSC4UbXIOp32noWRM3H9epjJdly
         /x6w3jGTu1nZ+kTy7WkzB7cE7rk/RngEOG0cu3tnJXe3slb++NW7GwUu+mjY2lnVk2Sa
         3ymzzOVV0VbU4tFc3TqCeiX8qQcMMYfzXqV0BOw2PHYwZUBCg+kwtVog/H0a0wOMXdXX
         Mk6klxe+scCJHoXaSAwK78ZqrmPBiy2sAW2fC3QySwK5Rtz0rnqyPE3VjVKDH8r1aFvt
         Klug==
X-Forwarded-Encrypted: i=1; AJvYcCXsoLQhcdqZ7hRcO3WdyK/cjoJBUgDQvLDh0voz80yyvtPbY77dZTTiU6t4C8XRt5kMg4Cy4tNIKrfCPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1zWP80WRqjih9aL2QM9MMA01HxwEQOvUV69aFG8doYgKkJS3O
	qz0o0+Nt+A7QHGDO3rJaTHPN0kODRh5EuRPr7IvRbPN8tLOy+U7YB+HOiT1W7bWrjzo2USY4DEG
	wRQyhhQ==
X-Gm-Gg: ASbGncsu+nA9aTognXHWk2Xs/8iVwJe62VTYwcjF1grGTPYmWQcWo3DLW1TLLAFlgs4
	g8X3lj/eXbUgEtHXcF4NiHA3Uo2jWmcY2URlZh2fueEPJug2t852J2Q2SKXLc7rZHp36wYVY683
	q8PdohR/uouuVWfkHYFjT+QHN0ODZsDchFl1JVDK5qThQUcBH7BsTXN8yAez79nMm0YzuVozr5w
	3gEQCdLyxflDC0eIiN0I7rIXTq5FFh4+c+K1pmBmqz2CdCZSTgf7ZDbiIjhHIAcHOsI2JVuVru7
	akzCua1FGIItLlMCFGh082F881UUsgbuaVgOmxyKl6KUkWcFeaOR9Jn2qIMMtBwYRA5McZmZoua
	Hjujxng==
X-Google-Smtp-Source: AGHT+IHrsBUvTqaZaBAWOxQU1QoaCLNRXeuDrpf1OqYF9P4/pPyigy4d05V5j2oveEeDXeOIiEyrsA==
X-Received: by 2002:a05:6902:1a44:b0:e6b:757e:d84a with SMTP id 3f1490d57ef6-e6b83a32bfamr581156276.31.1743190769910;
        Fri, 28 Mar 2025 12:39:29 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e6b71200ed0sm667632276.26.2025.03.28.12.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 12:39:29 -0700 (PDT)
Date: Fri, 28 Mar 2025 15:39:27 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.15
Message-ID: <20250328193927.GA1393046@perftesting>
References: <cover.1742834133.git.dsterba@suse.com>
 <20250328132751.GA1379678@perftesting>
 <20250328173644.GG32661@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328173644.GG32661@twin.jikos.cz>

On Fri, Mar 28, 2025 at 06:36:44PM +0100, David Sterba wrote:
> On Fri, Mar 28, 2025 at 09:27:51AM -0400, Josef Bacik wrote:
> > On Mon, Mar 24, 2025 at 05:37:51PM +0100, David Sterba wrote:
> > > Hi,
> > > 
> > > please pull the following btrfs updates, thanks.
> > > 
> > > User visible changes:
> > > 
> > > - fall back to buffered write if direct io is done on a file that requires
> > >   checksums
> > 
> > <trimming the everybody linux-btrfs from the cc list>
> > 
> > What?  We use this constantly in a bunch of places to avoid page cache overhead,
> > it's perfectly legitimate to do DIO to a file that requires checksums.  Does the
> > vm case mess this up?  Absolutely, but that's why we say use NOCOW for that
> > case.  We've always had this behavior, we've always been clear that if you break
> > it you buy it.  This is a huge regression for a pretty significant use case.
> 
> The patch has been up for like 2 months and you could have said "don't
> because reasons" any time before the pull request. Now we're left with a
> revert, or other alternatives making the use cases working.

Boris told me about this and I forgot.  I took everybody off the CC list because
I don't want to revert it, in fact generally speaking I'd love to never have
these style of bug reports again.

But it is a pretty significant change.  Are we ok going forward saying you don't
get O_DIRECT unless you want NOCOW? Should we maybe allow for users to indicate
they're not dumb and can be trusted to do O_DIRECT properly? I just think this
opens us up to a lot more uncomfortable conversations than the other behavior.

I personally think this is better, if it's been sitting there for 2 months then
hooray we're in agreement. But I'm also worried it'll come back to bite us.
Thanks,

Josef

