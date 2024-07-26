Return-Path: <linux-btrfs+bounces-6732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDEB93D723
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726B91C2310C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33217C208;
	Fri, 26 Jul 2024 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WHcrYE15";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9/rpWt5O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WHcrYE15";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9/rpWt5O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DDF63CB
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722012184; cv=none; b=El2ZEn9/N/nhbLMgQoeyCqCd/DxNNXvmFsS+YKviY2TQaZM0yNAV3q2u6VbpX9Ue4oS8Od+wDJu3bMslpsawVsfiwAIiPhYESxIAViE6l0tBetw7Qa1vhw6fdXzY3eu+EtbmZT0vBDU5KAGHjp3yRZDSSMUdflWMAAbAbwbcxs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722012184; c=relaxed/simple;
	bh=BhAgmONqHoQpPcw84B+bc0YbyskezUJ8ghD3OP644DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjI0xerzp4oK0NljlVRWXAsJ5bh4lGMJRvC94lyxw195cRpox2uQwggIeNAT1NfWkJiYdHdZMBDpHtNPzoHnQwJwjx892MB71zKauiPp1vcPxUsfIHft7goO1EPL4Fp28WX5dHjBJK9lMUoNFmLGiZMluiZCqw3rrvh8vauSwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WHcrYE15; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9/rpWt5O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WHcrYE15; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9/rpWt5O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B48A1F7DD;
	Fri, 26 Jul 2024 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722012180;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKyat+dz+yvVoEh6jCy/RgPR/z7CIgCs5YF2z1udP14=;
	b=WHcrYE15jpyDGVTcGDgDiI3djRbU/0aj/BgLiHSteGoZk58aDJzA6xO691x6HSN5fK/LrJ
	kAw7nQ+AzxkXquLxHvLNDqS6WfP0iyXJY0O1khz8ZNiBXRwdjOyY5gLdNxYjGxLggkPfkc
	dWmSgi44lTRbTPi/sUf6JBARydUvzBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722012180;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKyat+dz+yvVoEh6jCy/RgPR/z7CIgCs5YF2z1udP14=;
	b=9/rpWt5Oy5p6LJz5EUrL28+Ae+CLaTxk/dhuHYaqj0bw7pC461H+aw33bBK0HKCRAOYe12
	mWA0b30Lohn5BrCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WHcrYE15;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="9/rpWt5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722012180;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKyat+dz+yvVoEh6jCy/RgPR/z7CIgCs5YF2z1udP14=;
	b=WHcrYE15jpyDGVTcGDgDiI3djRbU/0aj/BgLiHSteGoZk58aDJzA6xO691x6HSN5fK/LrJ
	kAw7nQ+AzxkXquLxHvLNDqS6WfP0iyXJY0O1khz8ZNiBXRwdjOyY5gLdNxYjGxLggkPfkc
	dWmSgi44lTRbTPi/sUf6JBARydUvzBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722012180;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKyat+dz+yvVoEh6jCy/RgPR/z7CIgCs5YF2z1udP14=;
	b=9/rpWt5Oy5p6LJz5EUrL28+Ae+CLaTxk/dhuHYaqj0bw7pC461H+aw33bBK0HKCRAOYe12
	mWA0b30Lohn5BrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0ECF9138A7;
	Fri, 26 Jul 2024 16:43:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IltjAxTSo2ZDRQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jul 2024 16:43:00 +0000
Date: Fri, 26 Jul 2024 18:42:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: "dsterba@suse.cz" <dsterba@suse.cz>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
	Junxiao Bi <junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"wqu@suse.com" <wqu@suse.com>
Subject: Re: [External] : Re: [PATCH v2] btrfs-progs: tests: add convert test
 case for block number overflow
Message-ID: <20240726164250.GK17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240611073443.1207998-1-srivathsa.d.dara@oracle.com>
 <20240612204416.GR18508@twin.jikos.cz>
 <DM6PR10MB43474D88F345AEACBECAF32BA0DA2@DM6PR10MB4347.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR10MB43474D88F345AEACBECAF32BA0DA2@DM6PR10MB4347.namprd10.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2B48A1F7DD
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Mon, Jul 08, 2024 at 10:27:48AM +0000, Srivathsa Dara wrote:
> > From: David Sterba <dsterba@suse.cz> 
> > Sent: Thursday, June 13, 2024 2:14 AM
> > To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> > Cc: linux-btrfs@vger.kernel.org; Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>;
> > Junxiao Bi <junxiao.bi@oracle.com>; clm@fb.com; josef@toxicpanda.com; dsterba@suse.com; wqu@suse.com
> > Subject: [External] : Re: [PATCH v2] btrfs-progs: tests: add convert test case for block number overflow
> > 
> > On Tue, Jun 11, 2024 at 07:34:43AM +0000, Srivathsa Dara wrote:
> > > This test case will test whether btrfs-convert can handle ext4 
> > > filesystems that are largerthan or equal to 16TiB.
> > > 
> > > At 16TiB block numbers overflow 32 bits, btrfs-convert either fails or 
> > > corrupts fs if 64 bit block numbers are not supported.
> > > 
> > > Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> > 
> > Added to devel, thanks.
> 
> Hi David,
> 
> I don't see this patch in the devel branch. Is there any issue?

Sorry, I don't remember why it was not merged back then. I see some
issues with test:

'prepare_test_dev' cannot be used in a loop like that, besides it can be
an external block device that won't change its size

A temporary file needs to be created instead, I vaguely remember that
there could be a problem with underlying filesystem not able to create
such large files, eg. when run in the CI. The workaround is to create
another btrfs filesystem (can be on the default test image) and then use
it for convert.

