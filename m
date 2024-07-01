Return-Path: <linux-btrfs+bounces-6116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C34591EA80
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 23:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51943282984
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 21:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97987171E5A;
	Mon,  1 Jul 2024 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="stU33CKr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B43A2C1BA
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719870726; cv=none; b=PdKVZDUlwFccWRyFoLbekblaT4VBmiF5Il3+dZcf092MxgcJZdFdav1hSGhtKJsdRQ9EqDSVfO1ZjRNW8bMQ+CMsOIJ3WpMc88RYG4PWEasbEaBAlnqNflJ4+DKOCLxhvqSlQVcOpkzqSOsHOHe3dgYXHfAuEXMH04PVFNFyHi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719870726; c=relaxed/simple;
	bh=n07fWRet4wuJ6yE2VkTSwmQg1VEzerZaMf4BvfSAEnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFIqvH82Nj9ieUYUxxGcAE1den4TGyJsEcnXrmSbEt8M1dJOdn5e+86efbo8BTttfilaBuO4CIC824Exuc1omk6TMWPnElJmt+Cs6vwgjkQXyB2wgYU3QiIu2GKsonvJ0IaStzDjsvnUZJKeu36fnyurBB+AJwm3D4ALRqPSfSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=stU33CKr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1faad2f1967so34269225ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jul 2024 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1719870724; x=1720475524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wdy/3A2eaikN2kSbaou4irQf6vNopatZuG96Ka59Ac=;
        b=stU33CKr22A+aEL+dKc6U5oOqT7MRKb+rNFvQTwO16wIFj+9DfdtXywuOfKtqtET+m
         x8brJXAOvQ70TgEDigVHkC+ZrcJ+AQ+z08++8MKJfZU3BqqH+HnwDtv2pXQ9SKjLXjyN
         SJL3k1OxJZYOll34uXkPV1EUHgxNVMO61N6LEEGR4x6Ik3W0RGtVVhYtPbT43fG5tPFS
         zPOuw1kHVjrmyU04ZbXKwKls0708JFDzFOdrqp0uZrgel/MHj0dFmBL9YSg0krIq3eOm
         YcYPcypdLH3yh7xS6E3YxBZET3BswNAWd74JsjbBgKIZBUO0xB/+lWNo5KqA0OS028cR
         qnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719870724; x=1720475524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wdy/3A2eaikN2kSbaou4irQf6vNopatZuG96Ka59Ac=;
        b=nEDlbz/Zu2VRj/loDrMQe2Z7N/D8Bybmpjx7TQVQX3dHxuKx8cvrOinqNIH+hc4VOg
         Lw+HJ2KMudF/dtFcA4xSaNIjOSRUGZwCa7X2xisaWrZLOZqwq/F8lKxaqnCU0MyGh5eH
         3JVwKiFPIlCzwCT1aK8sjGGKMILN5KS4w5VoEc6GgY3CEcpRyaq2901fqsFcmozEXthv
         XNPOAMu6hWDE/B5SvksT9gTbkjqxx93gXPkaPaImprcLxTtjSBA436KhMXd1gb5BAiPv
         MzLaZM2tvTLd09ZsMYADj1xObKTRgyo16FZL93+GAnWAvCfIza8pjXFaFJhcsLRQbiOU
         LbxQ==
X-Gm-Message-State: AOJu0YwEk8agg/rfKy9Uxhfi8bM/H3DraVYqFxwtQIzSX16Aq1xJJmX1
	RRhTCHZWZn6aZo2BDKmI3g5JYvQmMyeHiZUslcB9okFLF/7vC0jzmYU9a8vBuhXqAIcw38O8n9p
	f
X-Google-Smtp-Source: AGHT+IHfEWpVerpo3sRfB6s3YqaG5E+5V4QW9LG1BwwG5967+T8/gCOP1xgvPM43OdK+FhO+EeNSIw==
X-Received: by 2002:a17:902:d4cd:b0:1f7:1d71:25aa with SMTP id d9443c01a7336-1fadb42d78bmr116200865ad.6.1719870724505;
        Mon, 01 Jul 2024 14:52:04 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:500::7:a5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1bd8sm70137405ad.10.2024.07.01.14.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:52:03 -0700 (PDT)
Date: Mon, 1 Jul 2024 14:52:02 -0700
From: Omar Sandoval <osandov@osandov.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/8] btrfs-progs: add subvol list options for sane path
 behavior
Message-ID: <ZoMlAvDuVIikCuuW@telecaster.dhcp.thefacebook.com>
References: <cover.1718995160.git.osandov@fb.com>
 <20240625153438.GW25756@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625153438.GW25756@twin.jikos.cz>

On Tue, Jun 25, 2024 at 05:34:38PM +0200, David Sterba wrote:
> On Fri, Jun 21, 2024 at 11:53:29AM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Hello,
> > 
> > btrfs subvol list's path handling has been a constant source of
> > confusion for users. None of -o, -a, or the default do what users
> > expect. This has been broken for a decade; see [1].
> > 
> > This series adds two new options, -O and -A, which do what users
> > actually want: list subvolumes below a path, or list all subvolumes,
> > with minimal path shenanigans. This approach is conservative and tries
> > to maintain backwards compatibility, but it's worth discussing whether
> > we should instead fix the existing options/default, or more noisily
> > deprecate the existing options.
> 
> I'm working on a replacement command of 'subvolume list', there seems to
> be no other sane way around that.

I love this idea. Do you have a work in progress anywhere?

> The command line options are indeed
> confusing and the output is maybe easy to parse but not nice to read.
> Changing meaning of the options would break too many things as everybody
> got used to the bad UI and output.
> 
> We can add the two new options but I'd rather do that only in the new
> command so we can let everybody migrate there.
> 
> > One additional benefit of this is that -O can be used by unprivileged
> > users.
> 
> This should be the default (and is supposed to be in the new command).
> 
> > Patch 1 fixes a libbtrfsutil bug I encountered while testing this.
> > Patches 2 and 3 fix libbtrfsutil's privilege checks to work in user
> > namespaces. Patches 4 and 5 remove some unused subvol list code. Patch 6
> > documents and tests the current, insane behavior. Patch 7 converts
> > subvol list to use libbtrfsutil. This is a revival of one of my old
> > patches [2], but is much easier now that libbtrfs has been pared down.
> > Patch 8 adds the new options, including documentation and tests.
> > 
> > Thanks!
> > Omar
> > 
> > 1: https://lore.kernel.org/all/bdd9af61-b408-c8d2-6697-84230b0bcf89@gmail.com/
> > 2: https://lore.kernel.org/all/6492726d6e89bf792627e4431f7ba7691f09c3d2.1518720598.git.osandov@fb.com/
> > 
> > Omar Sandoval (8):
> >   libbtrfsutil: fix accidentally closing fd passed to subvolume iterator
> 
> I've picked this patch now as it's a fix.

Patches 2 and 3 are also fixes, so those would be nice to have, too, if
you don't mind.

My real motivation for this series is so that some internal workloads in
user namespaces can use subvol list. I'd love for the unprivileged use
case to be unblocked in the short term. Would it be better to add just
the -O option without -A and all of the big documentation changes? (This
still requires the libbtrfsutil rework.)

Thanks,
Omar

