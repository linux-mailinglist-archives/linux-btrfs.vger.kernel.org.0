Return-Path: <linux-btrfs+bounces-5684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2D3905F7E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 02:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F06283139
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 00:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D117E1;
	Thu, 13 Jun 2024 00:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ubkt9e3U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A14WaAXN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ubkt9e3U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A14WaAXN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFB0622
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718236940; cv=none; b=PFODp2I1QynfGJWImdA5Re3DG8g1U0KuZxpV2nolfMDXr/pHIy9BFCOrf4ymQPVO49nNEm74ixpFjUQqtsoQ4FxkbjUwF4aZAPTCwxin9tCEpPSboKpH5+tCTumETcGqoqBGDSpIVPkW9Xex/1s99qBLgEnDNxJaSAqFDVavtgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718236940; c=relaxed/simple;
	bh=mGAw9FGI7C9KP/wZFaQTRIe3/+Tdq4tk2JN72Dy1NNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syoVAH8S07zblhKqHvdGo/aRQ+dbV/KCkvprhne35W9XeNyQSFIyJ2J9GF+bmE2I2cU7BgIh5h8SzdzT/hkuFdLvVyfSKdbgcOoJjfSuSKvn0bYDIgxHQ2GcYc4ZIXbZKF9bYvArFFYAX7lHRANbD/qDfOMeHWmDgyG3Ls+WnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ubkt9e3U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A14WaAXN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ubkt9e3U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A14WaAXN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9ECD25C9B8;
	Thu, 13 Jun 2024 00:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718236936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Vp3jjZOI3TuhbcmwYDfOQp4i87ie7XEfC9ptFvwHa4=;
	b=ubkt9e3UsyK8ZJX7kmpnKrOEPF+v0KGrGRSf/zC0gjdBntxoPeb0VjJq/xeUFm1RNDLjrc
	Y05bWyiFQYHIo3xYhkaEsWeZDizG+uqw83KX7KSCIg8o2uUs60Ch0eoRdjuJhnSj2UPqMe
	uEdkcOHR9AfbdhE0djnFv2++H5zZQag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718236936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Vp3jjZOI3TuhbcmwYDfOQp4i87ie7XEfC9ptFvwHa4=;
	b=A14WaAXNgCgHvrbQFwsotRyrNFxDqfP8U98Tn2O49mKMEsB49XP3PadMiZUtW9HeG1IzWw
	qk+FfPWtnNCfksDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718236936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Vp3jjZOI3TuhbcmwYDfOQp4i87ie7XEfC9ptFvwHa4=;
	b=ubkt9e3UsyK8ZJX7kmpnKrOEPF+v0KGrGRSf/zC0gjdBntxoPeb0VjJq/xeUFm1RNDLjrc
	Y05bWyiFQYHIo3xYhkaEsWeZDizG+uqw83KX7KSCIg8o2uUs60Ch0eoRdjuJhnSj2UPqMe
	uEdkcOHR9AfbdhE0djnFv2++H5zZQag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718236936;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Vp3jjZOI3TuhbcmwYDfOQp4i87ie7XEfC9ptFvwHa4=;
	b=A14WaAXNgCgHvrbQFwsotRyrNFxDqfP8U98Tn2O49mKMEsB49XP3PadMiZUtW9HeG1IzWw
	qk+FfPWtnNCfksDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84A5113A7F;
	Thu, 13 Jun 2024 00:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9jUzIAg3amacXAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Jun 2024 00:02:16 +0000
Date: Thu, 13 Jun 2024 02:02:00 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Srivathsa Dara <srivathsa.d.dara@oracle.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
	Junxiao Bi <junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: convert: Add 64 bit block numbers support
Message-ID: <20240613000200.GS18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240606102215.3695032-1-srivathsa.d.dara@oracle.com>
 <c3060faf-f0e8-4bd2-865b-332e423a8801@gmx.com>
 <DM6PR10MB4347A0EADF68B973447C5591A0C72@DM6PR10MB4347.namprd10.prod.outlook.com>
 <20240612203743.GQ18508@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612203743.GQ18508@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,gmx.com,vger.kernel.org,fb.com,toxicpanda.com,suse.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com]

On Wed, Jun 12, 2024 at 10:37:43PM +0200, David Sterba wrote:
> On Tue, Jun 11, 2024 at 06:03:30AM +0000, Srivathsa Dara wrote:
> > > 在 2024/6/6 19:52, Srivathsa Dara 写道:
> > > >   	if (err)
> > > >   		goto error;
> > > > diff --git a/convert/source-ext2.h b/convert/source-ext2.h index 
> > > > d204aac5..62c9b1fa 100644
> > > > --- a/convert/source-ext2.h
> > > > +++ b/convert/source-ext2.h
> > > > @@ -46,7 +46,7 @@ struct btrfs_trans_handle;
> > > >   #define ext2fs_get_block_bitmap_range2 ext2fs_get_block_bitmap_range
> > > >   #define ext2fs_inode_data_blocks2 ext2fs_inode_data_blocks
> > > >   #define ext2fs_read_ext_attr2 ext2fs_read_ext_attr
> > > > -#define ext2fs_blocks_count(s)		((s)->s_blocks_count)
> > > > +#define ext2fs_blocks_count(s)		(((s)->s_blocks_count_hi << 32) | (s)->s_blocks_count)
> > > 
> > > This is definitely needed, or it would trigger the ASSERT().
> > > 
> > > But again, the newer btrfs-progs no longer go with internally defined ext2fs_blocks_count(), but using the one from e2fsprogs headers, and the library version is already returning blk64_t.
> > 
> > Okay, got it.
> > 
> > Tested the code base with the commit c23e068aaf91, it does handle 64 bit block numbers.
> 
> So, is this patch still needed? I'm not sure after Qu fixed the
> iteration, the tests pass without the patch too.

Locally the test succeeds (e2fsprogs 1.47.0), however in the github CI
it fails with:

mke2fs -t ext4 -b 4096 -F /home/runner/work/btrfs-progs/btrfs-progs/tests/test.img
mke2fs 1.46.5 (30-Dec-2021)
mke2fs: Device size reported to be zero.  Invalid partition specified, or
	partition table wasn't reread after running fdisk, due to
	a modified partition being busy and in use.  You may need to reboot
	to re-read your partition table.

This is the updated test case 018-fs-size-overflow and in the code the change
is the updated definition of ext2fs_blocks_count.

I'll put the test case to a topic branch and remove it from devel so the
CI can be used. You can open a pull request to verify if things work.

