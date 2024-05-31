Return-Path: <linux-btrfs+bounces-5380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8D78D65EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 17:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A2F1C24948
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DBB1420DD;
	Fri, 31 May 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2q+3WGE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OJrNp+CA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hzY27cyr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gn9fkxIa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B741770FC
	for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2024 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170055; cv=none; b=h05ei7xv/UJVnNA+Bl3Rh4l7cgHgCFatElWCUtQnTflI/SSfzgoM90V5tIoOlxAN55ocLWqUILXe5kg39hg26xIZSfP6/URaogaqAWvhbEMjalkM1aJYDWsAcOyZojAgp/uf2HhiqnlH/mSvGCIo2uBoJkB8+wUxThbVTN/xZ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170055; c=relaxed/simple;
	bh=WJ/EqkPDBuat+xOduwhif0exmB+qJQforKGVUp7x7hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0RawwOT34psPWO56JVnAmBN5iZQikx1RH6KjE3UsDKXyvMSyNLKP9mBVWEkiwEHOy+vlngZv+IsVfI8KoleL+csOKF9rZkjfWE96wLWO9aDzlU7QS3TED8A8lvFiVBEK7iYlsDlZlttV5hKR6NJzkYfZ3D7tu8L4RrhTjSeLiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2q+3WGE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OJrNp+CA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hzY27cyr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gn9fkxIa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACD521FB8A;
	Fri, 31 May 2024 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717170047;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nOZdUF2HPkFxnCzuo9kDuVGq954jVQdA9MikLRDPQrk=;
	b=B2q+3WGErdNA40d17n43adEbDL0v9qB250O7s+Dx5X2XiOS7nVwmvi2RdADzVJ6QdBbxtC
	pAH0qyM10emeZ3V78gb7rl85ul4bh7NuB6KV07QKHNekbKjeInk7DPCSjPr7W/9xCNhWmv
	DBa+DdWgHhWBCNmQ09nqBHvli5a4O60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717170047;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nOZdUF2HPkFxnCzuo9kDuVGq954jVQdA9MikLRDPQrk=;
	b=OJrNp+CAWXpTDe3Vuli/V8hdVsxnCM3qfnZl1lFMn6+dE3qbUoIWSpLV94dOrJgc9/7A+V
	m6Bncv63OOMCIYBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717170045;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nOZdUF2HPkFxnCzuo9kDuVGq954jVQdA9MikLRDPQrk=;
	b=hzY27cyrpJT0I/yNFHkSrgnNtKECCSeuoSCmRnZUIdk294HCJaHZwv4CJmxknpVThBfyqC
	jiR8df9czJJjPekvQlKyayyouUI1HINJRy++Adrx9hm5comxNsdlQ+7yGBQCR13xojcfdS
	5Sd3oWsRxouE++UsXvgxSOAQg55Ppuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717170045;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nOZdUF2HPkFxnCzuo9kDuVGq954jVQdA9MikLRDPQrk=;
	b=gn9fkxIar6/2VUXwOeWCvgfrQ9xXPyA4tOvQkpt79/bix8I+8+BumSq6YCkcE9VDyl2d0c
	HjiDgZ0HBVNPD4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FAEF132C2;
	Fri, 31 May 2024 15:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CaW9Hn3vWWadDgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 31 May 2024 15:40:45 +0000
Date: Fri, 31 May 2024 17:40:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
	Junxiao Bi <junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	Anand Jain <anand.jain@oracle.com>
Subject: Re: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers
 support
Message-ID: <20240531154044.GF25460@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240530053754.4115449-1-srivathsa.d.dara@oracle.com>
 <20240530174625.GD25460@twin.jikos.cz>
 <DM6PR10MB43474C588F4C4002C673BE78A0FC2@DM6PR10MB4347.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR10MB43474C588F4C4002C673BE78A0FC2@DM6PR10MB4347.namprd10.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,suse.com:email,fb.com:email,oracle.com:email,suse.cz:replyto,suse.cz:email,rasivara-arm2:email,imap1.dmz-prg2.suse.org:helo]

On Fri, May 31, 2024 at 08:58:08AM +0000, Srivathsa Dara wrote:
> 
> 
> -----Original Message-----
> From: David Sterba <dsterba@suse.cz> 
> Sent: Thursday, May 30, 2024 11:16 PM
> To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> Cc: linux-btrfs@vger.kernel.org; Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>; Junxiao Bi <junxiao.bi@oracle.com>; clm@fb.com; josef@toxicpanda.com; dsterba@suse.com
> Subject: Re: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers support
> 
> Hi David,
> Thanks for answering Anand's question on my behalf.
> 
> > On Thu, May 30, 2024 at 05:37:54AM +0000, Srivathsa Dara wrote:
> > > In ext4, number of blocks can be greater than 2>32. Therefore, if 
> > > btrfs-convert is used on filesystems greater than or equal to 16TiB 
> > > (Staring from 16TiB, number of blocks overflow 32 bits), it fails to 
> > > convert.
> > > 
> > > Example:
> > > 
> > > Here, /dev/sdc1 is 16TiB partition intitialized with an ext4 filesystem.
> > > 
> > > [root@rasivara-arm2 opc]# btrfs-convert -d -p /dev/sdc1 btrfs-convert 
> > > from btrfs-progs v5.15.1
> > > 
> > > convert/main.c:1164: do_convert: Assertion `cctx.total_bytes != 0` 
> > > failed, value 0 btrfs-convert(+0xfd04)[0xaaaaba44fd04]
> > > btrfs-convert(main+0x258)[0xaaaaba44d278]
> > > /lib64/libc.so.6(__libc_start_main+0xdc)[0xffffb962777c]
> > > btrfs-convert(+0xd4fc)[0xaaaaba44d4fc]
> > > Aborted (core dumped)
> > > 
> > > Fix it by considering 64 bit block numbers.
> > > 
> > > Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> >
> > The current conver tests passed, can you please also send test case for this fix? Thanks.
> 
> Sure, would you like me to send that in v2 or as a separate patch?

Separate patch for test is ok. Thanks.

