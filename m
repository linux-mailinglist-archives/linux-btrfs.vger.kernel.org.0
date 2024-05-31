Return-Path: <linux-btrfs+bounces-5379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94258D65D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 17:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684111F22B47
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 15:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15EC78283;
	Fri, 31 May 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gA/86kyK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fSRZcLWr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w3pQwnwN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A6cXkjJj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA42D61B
	for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2024 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169606; cv=none; b=JGQE9A7nTVnihqsUNsuHhKqEp/X6j4/2nBAZuD7Zh3iyL5lQMHPx8SAw6FLoCvkpdnNfc6pPW8ml7N2/tRSG5dX8Vk8ZD3FsKcIulLOmpu7HtbyOZIKOzsSBeyUuI7ZAmc7mixHovRwU4y6Kp5YzWshDjYtYPaj8NhEYA3oXlXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169606; c=relaxed/simple;
	bh=IKbx7s0HWELJOssFtO0UzbZsX/4lZQv72PMq4YQAxA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfZcXL+I5HF0kQdWRmOMOiiwpGFH/a4MZ/yRtYz3SQqZFRInT9HhJwMOyt6l0VaC9jcyDM8CrW1xxEsu8g1u7dlO0hMisB3f+CKaF9mx4BGt7EL6VNQV0j1eZD6+PavTRf9CjORK9s9eN0650k09acQMnTIY18Yzz98LcityKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gA/86kyK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fSRZcLWr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w3pQwnwN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A6cXkjJj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFC361FB85;
	Fri, 31 May 2024 15:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717169602;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yfqdZNvBHxZ18zEFdXMAq1RrpNnqgvHmhB2YHnQNTA8=;
	b=gA/86kyK7MCItWRQrGZ9dRNP+vgwIjENIUO5Hx1ozgS+37cTHKq6VuANvojq7JYF1rMcOh
	Sjz9JzfFnhcS6j/GZVfmYtQNk+dGLE6yP03x84nh8OnTH0vLw7JaV3a5hAubW/Ll/3BAFK
	NRwlclXmAeU8OXbqG1Ec4ZaYDEc/B7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717169602;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yfqdZNvBHxZ18zEFdXMAq1RrpNnqgvHmhB2YHnQNTA8=;
	b=fSRZcLWrGa3yINR2qfe8S1TNHIzSlnhGL6L7pUOA+7B5eaveIg6SvPLBa/hjM5IWzb2uV9
	vKfVRsBfkcsnEODA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=w3pQwnwN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=A6cXkjJj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717169601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yfqdZNvBHxZ18zEFdXMAq1RrpNnqgvHmhB2YHnQNTA8=;
	b=w3pQwnwNYldxGTk5sdSMJxc9ghxPnD5ZqP8kVNwt/BvONbRvrSGZrw5NSOU2L2goQEtv0o
	BeysSSY3OVmCVm9Hsa3oJ25MAKaY2wr2/q0Lfyszn89X+E5tBT3ZZrk/IFpNVDUugkwRII
	6P6LIg0kcCGcSWpgAf47mmfdpc64fyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717169601;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yfqdZNvBHxZ18zEFdXMAq1RrpNnqgvHmhB2YHnQNTA8=;
	b=A6cXkjJjQ2/ZqV8vaw6+KXxo+fi3ooAEycQg3fEFaHBqiCKEzs2tZjb42ciyIkGEaRLUMp
	DRG4HWzKHgtkkWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0EB0132C2;
	Fri, 31 May 2024 15:33:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pcODMsHtWWatDAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 31 May 2024 15:33:21 +0000
Date: Fri, 31 May 2024 17:33:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
	Junxiao Bi <junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers
 support
Message-ID: <20240531153316.GE25460@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240530053754.4115449-1-srivathsa.d.dara@oracle.com>
 <20240530172916.GB25460@twin.jikos.cz>
 <DM6PR10MB43476059C588E8136707F28DA0FC2@DM6PR10MB4347.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR10MB43476059C588E8136707F28DA0FC2@DM6PR10MB4347.namprd10.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.63 / 50.00];
	BAYES_HAM(-2.42)[97.33%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EFC361FB85
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.63

On Fri, May 31, 2024 at 09:04:13AM +0000, Srivathsa Dara wrote:
> > > @@ -46,7 +46,7 @@ struct btrfs_trans_handle;  #define 
> > > ext2fs_get_block_bitmap_range2 ext2fs_get_block_bitmap_range  #define 
> > > ext2fs_inode_data_blocks2 ext2fs_inode_data_blocks  #define 
> > > ext2fs_read_ext_attr2 ext2fs_read_ext_attr
> > > -#define ext2fs_blocks_count(s)		((s)->s_blocks_count)
> > > +#define ext2fs_blocks_count(s)		((s)->s_blocks_count_hi << 32) | (s)->s_blocks_count
> > 
> > Looks like there's missing closing )
> 
> No, all parenthesis are balanced.

Oh right but it's confusing because the expression should be enclosed in
a pair of ( ) as it's an expression in a macro and it could change
result once expanded in random locations.

