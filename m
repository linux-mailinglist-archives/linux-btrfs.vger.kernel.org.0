Return-Path: <linux-btrfs+bounces-108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AAB7EA26B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 18:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4505B20A4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 17:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8B2225A4;
	Mon, 13 Nov 2023 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AQqUUSXR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CCApTrYC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D088F224C0
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 17:52:10 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7310DB
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 09:52:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B8781F6E6;
	Mon, 13 Nov 2023 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699897927;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u24lfPN2iqyUlloJ3Yw9OHKA+RHGxvaPV3bXBSfgZ1E=;
	b=AQqUUSXR15PMMP8DnztnYxZAv9X4zSraSzWgYO91y5EZtAKp7BcV8vF6P5/0vtF3NCY/46
	4iavPoMs8o41vZC6wB+PqoEOGpUFcB1pq1AP8IWJ+UfpIlsqvRfG8lY5mNdKg+RWLc+O03
	BlzLMeAgkHTlyFaBxgTxYAY3pcpI9EE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699897927;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u24lfPN2iqyUlloJ3Yw9OHKA+RHGxvaPV3bXBSfgZ1E=;
	b=CCApTrYCOZ61OwrD2VWKd827lkFAP3v5og2btmfMIX09SMR041WvONui1r2Zaufh9et2Oy
	E9ArGHIpxMl7B4CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 757081358C;
	Mon, 13 Nov 2023 17:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ABXwGkdiUmX1FQAAMHmgww
	(envelope-from <dsterba@suse.cz>); Mon, 13 Nov 2023 17:52:07 +0000
Date: Mon, 13 Nov 2023 18:45:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add dmesg output when mounting and unmounting
Message-ID: <20231113174502.GX11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)

On Thu, Nov 02, 2023 at 07:54:50AM +1030, Qu Wenruo wrote:
> There is a feature request to add dmesg output when unmounting a btrfs.
> 
> There are several alternative methods to do the same thing, but with
> their problems:
> 
> - Use eBPF to watch btrfs_put_super()/open_ctree()
>   Not end user friendly, they have to dip their head into the source
>   code.
> 
> - Watch for /sys/fs/<uuid>/
>   This is way more simpler, but still requires some simple device -> uuid
>   lookups.
>   And a script needs to use inotify to watch /sys/fs/.
> 
> Compared to all these, directly outputting the information into dmesg
> would be the most simple one, with both device and UUID included.
> 
> And since we're here, also add the output when mounting a btrfs, to keep
> the dmesg paired.
> 
> Now mounting a btrfs with all default mkfs options would look like this:
> 
> [   81.906566] BTRFS info (device dm-8): mounting filesystem 633b5c16-afe3-4b79-b195-138fe145e4f2
> [   81.907494] BTRFS info (device dm-8): using crc32c (crc32c-intel) checksum algorithm
> [   81.908258] BTRFS info (device dm-8): using free space tree
> [   81.912644] BTRFS info (device dm-8): auto enabling async discard
> [   81.913277] BTRFS info (device dm-8): checking UUID tree
> [   91.668256] BTRFS info (device dm-8): unmounting filesystem 633b5c16-afe3-4b79-b195-138fe145e4f2

On a fresh look, I' suggest to write the messages like

BTRFS info (...): first mount of filesystem UUID
...
BTRFS info (...): last umount of filesystem UUID

This is not for each mount so it's slightly confusing.

