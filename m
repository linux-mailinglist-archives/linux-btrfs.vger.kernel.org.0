Return-Path: <linux-btrfs+bounces-6408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE092F2E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 01:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6018284451
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 23:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEFE1A0711;
	Thu, 11 Jul 2024 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="YHbJV0YS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF96EB7C
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720742375; cv=none; b=M+L49wcSiRcD3ZuGqIblGJN2s1jFP1UPR3sOTsBEXtwmE1rn4iTRIK8q+ruQX7CuWCQa90NCoJiag5uccM2Zy3s0TbW0S+tlpyKmSAnTHSb6Lw+H53wK58YmtmwgYzO8q/fb/ZSX67CFYUukQxbx7h4dbzNLkepaRRa1KCMru70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720742375; c=relaxed/simple;
	bh=IkWj9zMhLBBiikKt9+oFxq+xN8vx3B4GCl072AfFOpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+ObvuZetUr9auYxYxBuMXSE+bUt3dzLPY/b6kFwXrS90sG8YSr89dKt2Ios23nsLGSpoj10RebrzonniOTR1W5CffkZrljhcJpT/SqameoQCKtCMkxUD8UhzuUXsd27NQhdYvZPnqKjvgZzDuBrc5rr0Ts11abKbGdbFiSDMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=YHbJV0YS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c9df3eb0edso1159089a91.3
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 16:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1720742373; x=1721347173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fR65BlvBfJEhSMVJlfmGvXpypo/A/b5pVup32b1gqqw=;
        b=YHbJV0YSNHdwcz89VqGnPyT9+rcB/QoMqsr57wgRAvTChX2k4/m/1tAHPXSiFgRmqV
         +IvlOvZpnw/rS9wAIM7jWRAA2WRGpOXqv0hWZcTDf2c/Iv9HWzOi19P9N0cN8utQcyB3
         +mVje/HQzD4ff8t20pOeOpN1WRX3OT3NWJUNa4X2waFt5exm79RxXU3Vq4+nA8fKzCYj
         hemRMknLg9Vz7jOTASnEeF7sKIimVjozNfTjF1LK69FYwgnJfEYl5S70hQRoRqsIYjRF
         /M4yoiB20+D+ZFNjXRDe3+L7YdLAuTwjzV7yDUhjXrSwKzQ9gl6eVcFpfHroZIqszX9p
         6bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720742373; x=1721347173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR65BlvBfJEhSMVJlfmGvXpypo/A/b5pVup32b1gqqw=;
        b=VUvbf+v+SAf3moCD0uxZzCmy3HMslsVBY2xfcgri0VZae3GHonOUhDOaokNoPwsjF7
         z9IBSbgIFkVvj9zQLPuzUPb2LHiVXlf2n15l8pWgw8Dsf2/euWn5IcBXmQ/gnZAjuDFK
         ySn9cWttAMAZBM1Zc7sZuFahpkBUYh4DAZHzPvjfL6AYNbo6tUNk2wPWvVBkx8m1grym
         we/Vn9PSLRYONavkvb2xn5XVBlmgqSexLjBCpA22q8cMsPVJx1MqkxFvdSRznWsQbike
         N/5PS5zjuREHdB7ssfAOCYgoXvBTznVxsi9auPny0xVrRNABL2zW2fYrfypkk6H+FD33
         oBaA==
X-Gm-Message-State: AOJu0YxiVKkkwITLKG8l/InRJJix8BOFbU6Jku10Cbp8XJ2G95cLcYqd
	OeCmyz5JxGXtBNqcd/DFZpknFfIlHLBFfstjZhOtajoqtVu5JUPqWPHzBvhVrog=
X-Google-Smtp-Source: AGHT+IFLQcVF81APbLKA7SohhEensmQp+72G6N/PFLlXFNmKjR3qwVh4EPZrxDyO9bXZuKqMPy5zag==
X-Received: by 2002:a17:90a:be0c:b0:2c8:6308:ad78 with SMTP id 98e67ed59e1d1-2ca35d3a66dmr10335521a91.34.1720742373176;
        Thu, 11 Jul 2024 16:59:33 -0700 (PDT)
Received: from telecaster ([2601:602:8980:9170::7a8e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd429d2esm169207a91.29.2024.07.11.16.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:59:32 -0700 (PDT)
Date: Thu, 11 Jul 2024 16:59:32 -0700
From: Omar Sandoval <osandov@osandov.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/8] btrfs-progs: add subvol list options for sane path
 behavior
Message-ID: <ZpBx5AkouCZPu4vf@telecaster>
References: <cover.1718995160.git.osandov@fb.com>
 <20240625153438.GW25756@twin.jikos.cz>
 <ZoMlAvDuVIikCuuW@telecaster.dhcp.thefacebook.com>
 <20240703234054.GU21023@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703234054.GU21023@twin.jikos.cz>

On Thu, Jul 04, 2024 at 01:40:54AM +0200, David Sterba wrote:
> On Mon, Jul 01, 2024 at 02:52:02PM -0700, Omar Sandoval wrote:
> > On Tue, Jun 25, 2024 at 05:34:38PM +0200, David Sterba wrote:
> > > On Fri, Jun 21, 2024 at 11:53:29AM -0700, Omar Sandoval wrote:
> > > > From: Omar Sandoval <osandov@fb.com>
> > > > 
> > > > Hello,
> > > > 
> > > > btrfs subvol list's path handling has been a constant source of
> > > > confusion for users. None of -o, -a, or the default do what users
> > > > expect. This has been broken for a decade; see [1].
> > > > 
> > > > This series adds two new options, -O and -A, which do what users
> > > > actually want: list subvolumes below a path, or list all subvolumes,
> > > > with minimal path shenanigans. This approach is conservative and tries
> > > > to maintain backwards compatibility, but it's worth discussing whether
> > > > we should instead fix the existing options/default, or more noisily
> > > > deprecate the existing options.
> > > 
> > > I'm working on a replacement command of 'subvolume list', there seems to
> > > be no other sane way around that.
> > 
> > I love this idea. Do you have a work in progress anywhere?
> 
> Yes, the initial version is in my branch dev/subvol-list-new but I have
> recent updates adding more optional columns. The patches are not
> polished, I'll update the branch once it's done.
> 
> > > The command line options are indeed
> > > confusing and the output is maybe easy to parse but not nice to read.
> > > Changing meaning of the options would break too many things as everybody
> > > got used to the bad UI and output.
> > > 
> > > We can add the two new options but I'd rather do that only in the new
> > > command so we can let everybody migrate there.
> > > 
> > > > One additional benefit of this is that -O can be used by unprivileged
> > > > users.
> > > 
> > > This should be the default (and is supposed to be in the new command).
> > > 
> > > > Patch 1 fixes a libbtrfsutil bug I encountered while testing this.
> > > > Patches 2 and 3 fix libbtrfsutil's privilege checks to work in user
> > > > namespaces. Patches 4 and 5 remove some unused subvol list code. Patch 6
> > > > documents and tests the current, insane behavior. Patch 7 converts
> > > > subvol list to use libbtrfsutil. This is a revival of one of my old
> > > > patches [2], but is much easier now that libbtrfs has been pared down.
> > > > Patch 8 adds the new options, including documentation and tests.
> > > > 
> > > > Thanks!
> > > > Omar
> > > > 
> > > > 1: https://lore.kernel.org/all/bdd9af61-b408-c8d2-6697-84230b0bcf89@gmail.com/
> > > > 2: https://lore.kernel.org/all/6492726d6e89bf792627e4431f7ba7691f09c3d2.1518720598.git.osandov@fb.com/
> > > > 
> > > > Omar Sandoval (8):
> > > >   libbtrfsutil: fix accidentally closing fd passed to subvolume iterator
> > > 
> > > I've picked this patch now as it's a fix.
> > 
> > Patches 2 and 3 are also fixes, so those would be nice to have, too, if
> > you don't mind.
> 
> I picked only the first one for the 6.9.2 release that had little time
> for testing.

Ok, no problem.

> > My real motivation for this series is so that some internal workloads in
> > user namespaces can use subvol list. I'd love for the unprivileged use
> > case to be unblocked in the short term. Would it be better to add just
> > the -O option without -A and all of the big documentation changes? (This
> > still requires the libbtrfsutil rework.)
> 
> I think for the time being the saner -O and -A options can be added.
> Their functionality resemble the lower case options so it's still
> understandable and can be released without delays.

Thanks! Let me know if this series needs any updates.

> For the new command
> I'd like to do a public poll and comment round that will take some time.

That makes total sense. I'm happy to chime in when it's ready.

Thanks,
Omar

