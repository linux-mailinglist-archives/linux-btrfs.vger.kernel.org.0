Return-Path: <linux-btrfs+bounces-12440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FECA69C4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 23:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A68C983493
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 22:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5FD221F13;
	Wed, 19 Mar 2025 22:53:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from nt.romanrm.net (nt.romanrm.net [185.213.174.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E1521B18C
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.213.174.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424803; cv=none; b=cE0eicDPg+M8qRZ4pay4hGBaRw0oqIYF9E+7dxeZEUPzIY51Q0rTSp0Z46HgfmImcMhBvtw6/usYhYUznjAd+GlK06un/TcK3AUBgrQ39Em/O/3H2DliwZCeeUbAfT1pFbJM4TqkrXmKheTfLOkpm/Di6880mIkOHnHrvj4FniM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424803; c=relaxed/simple;
	bh=eE3AzD5fTYiZWUGRWAJH/6uDb5y1rzEGtWmtaQg54rs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZZuuvNccrlQZuSjrOWzACLn4erPrI9xoSKjmBq8e44fa0H/7nXQeAfm2jkxGpQFQlMWp3cRM5j1zMxxuwIkjuXhIMtPs+a4fcWOBXSxqwKXk9AiflRPQUbmAfn6Wc8nk+Xn7+y069ueKzC++RYe8cgf55MTJMIyTr5aAhesopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=185.213.174.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.2.romanrm.net [IPv6:fd39:a37d:999f:7e35:7900:fcd:12a3:6181])
	by nt.romanrm.net (Postfix) with SMTP id 82C664054B;
	Wed, 19 Mar 2025 22:46:14 +0000 (UTC)
Date: Thu, 20 Mar 2025 03:46:13 +0500
From: Roman Mamedov <rm@romanrm.net>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: btrfs-progs: -q/--quiet not accepted for "btrfs subvolume"
 subcommands
Message-ID: <20250320034613.47d65814@nvm>
In-Reply-To: <20250319221256.GQ32661@twin.jikos.cz>
References: <20241217195649.143d2c94@nvm>
	<20250319221256.GQ32661@twin.jikos.cz>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 23:12:56 +0100
David Sterba <dsterba@suse.cz> wrote:

> On Tue, Dec 17, 2024 at 07:56:49PM +0500, Roman Mamedov wrote:
> > Hello,
> > 
> > # btrfs --version
> > btrfs-progs v6.6.3
> > 
> > # btrfs sub create --help
> > usage: btrfs subvolume create [options] [<dest>/]<name> [[<dest2>/]<name2> ...]

^ This line appears to instruct that there's one place to put all the options;
so if you're looking into a documentation fix, I would suggest modifying that.
Like,

> > usage: btrfs [global-options] subvolume create [local-options] [<dest>/]<name> [[<dest2>/]<name2> ...]

But this looks messy. So IMO the ideal would be to just not require the
separation and accept global options also after the subcommand name.

> >     Create subvolume(s)
> > 
> >     Create subvolume(s) at specified destination.  If <dest> is not given
> >     subvolume <name> will be created in the current directory. Options apply
> >     to all created subvolumes.
> > 
> >     -i <qgroupid>             add the newly created subvolume(s) to a qgroup. This option can be given multiple times.
> >     -p|--parents              create any missing parent directories for each argument (like mkdir -p) 
> >     
> >     Global options:
> >     -q|--quiet                print only errors 
> > 
> > # btrfs sub create -q test
> > btrfs subvolume create: invalid option 'q'
> > Try 'btrfs subvolume create --help' for more information
> > 
> > # btrfs sub create --quiet test
> > btrfs subvolume create: unrecognized option '--quiet'
> > Try 'btrfs subvolume create --help' for more information
> > 
> > Same for "snapshot". Maybe also some or all others, did not check further.
> > 
> > This is the case also on btrfs-progs versions 5.10 and 6.2.
> 
> The global options -q/-v and others are supposed to be right after the
> 'btrfs' term, like
> 
>   $ btrfs -q subvolume create test
> 
> This is mentioned at the top of 'btrfs --help' but maybe it needs to be
> made more visible or repeated at the end of the help too.
> 


-- 
With respect,
Roman

