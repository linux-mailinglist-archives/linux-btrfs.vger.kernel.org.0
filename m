Return-Path: <linux-btrfs+bounces-113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713B77EA560
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 22:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DB61C204F6
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 21:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2012D619;
	Mon, 13 Nov 2023 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hlEAh4W0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LJLirbrQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD762511A
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 21:16:41 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF38DD67
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 13:16:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F3821F88C;
	Mon, 13 Nov 2023 21:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699910198;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4jjLMDmYMXsvK79YHiQA08RTNu6pPnVVqjH7C7VnEyI=;
	b=hlEAh4W0MAB9XAI+wfAOoUFCl+QLL48KeNiu5N96Hzzxn3v3saAinnOWn86FWiaIbxhZPJ
	luyam2YH07h2/6uG3TmJzKyuQIJNXiqs+/lq+V4mpV3U93A1A2ST9EEArQ5D5oPY6OK1MU
	K0dZlwNyHQ4W7M50aK0l/88aWeAkQ30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699910198;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4jjLMDmYMXsvK79YHiQA08RTNu6pPnVVqjH7C7VnEyI=;
	b=LJLirbrQLioKhFhCEYcIlxCMBXnHStRmaZD0pFau/2luyGi3/X1abOhW53+lIpywIAUWCh
	c4rvgOl0VmEEERDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B43313398;
	Mon, 13 Nov 2023 21:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id TWRGHTaSUmV+bAAAMHmgww
	(envelope-from <dsterba@suse.cz>); Mon, 13 Nov 2023 21:16:38 +0000
Date: Mon, 13 Nov 2023 22:09:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add dmesg output when mounting and unmounting
Message-ID: <20231113210933.GY11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
 <20231113174502.GX11264@twin.jikos.cz>
 <83b7280d-6396-45c2-aa5e-fcd1f6f44963@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b7280d-6396-45c2-aa5e-fcd1f6f44963@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)

On Tue, Nov 14, 2023 at 06:37:15AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/11/14 04:15, David Sterba wrote:
> > On Thu, Nov 02, 2023 at 07:54:50AM +1030, Qu Wenruo wrote:
> >> There is a feature request to add dmesg output when unmounting a btrfs.
> >>
> >> There are several alternative methods to do the same thing, but with
> >> their problems:
> >>
> >> - Use eBPF to watch btrfs_put_super()/open_ctree()
> >>    Not end user friendly, they have to dip their head into the source
> >>    code.
> >>
> >> - Watch for /sys/fs/<uuid>/
> >>    This is way more simpler, but still requires some simple device -> uuid
> >>    lookups.
> >>    And a script needs to use inotify to watch /sys/fs/.
> >>
> >> Compared to all these, directly outputting the information into dmesg
> >> would be the most simple one, with both device and UUID included.
> >>
> >> And since we're here, also add the output when mounting a btrfs, to keep
> >> the dmesg paired.
> >>
> >> Now mounting a btrfs with all default mkfs options would look like this:
> >>
> >> [   81.906566] BTRFS info (device dm-8): mounting filesystem 633b5c16-afe3-4b79-b195-138fe145e4f2
> >> [   81.907494] BTRFS info (device dm-8): using crc32c (crc32c-intel) checksum algorithm
> >> [   81.908258] BTRFS info (device dm-8): using free space tree
> >> [   81.912644] BTRFS info (device dm-8): auto enabling async discard
> >> [   81.913277] BTRFS info (device dm-8): checking UUID tree
> >> [   91.668256] BTRFS info (device dm-8): unmounting filesystem 633b5c16-afe3-4b79-b195-138fe145e4f2
> >
> > On a fresh look, I' suggest to write the messages like
> >
> > BTRFS info (...): first mount of filesystem UUID
> > ...
> > BTRFS info (...): last umount of filesystem UUID
> >
> > This is not for each mount so it's slightly confusing.
> >
> Sure, I'm totally fine to change the words.
> 
> Do I need to resend or the change is small enough to get updated in the
> branch?

No need to resend for such changes, is more for the feedback and sanity
check.

