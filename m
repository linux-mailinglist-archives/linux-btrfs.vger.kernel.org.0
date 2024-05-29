Return-Path: <linux-btrfs+bounces-5356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 262618D3EB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 21:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB55B23994
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF88E181324;
	Wed, 29 May 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p7pfhp7K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eg3uY0Bk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KJzs4WlY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k7rsWAh5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211B31B949;
	Wed, 29 May 2024 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717009270; cv=none; b=FMdQQ5fiXjt7gmzNfFRNMQzTIcUXFNwW5oYxF5qMS8DZHWoFBSSknfwhjFmwOmZniff4Mzqn4DUMal+L7MAB0HPpvxTOdtx24xDMbxtazJOOxOt2kgCWgIT3PK0uJ19Vmyy2/8TvxEEQnT5CSoYSGgHf04qTF8+3wrFg330gMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717009270; c=relaxed/simple;
	bh=+jnnZTUq6/BwkwWF5eJnUty9lyNMM5PD17zS14+zCfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sApgm3SbNikhcVQzwDmJk+kr1yd/DuWa7fBfsgnQK0U1KY6frnbnDxs1JaDuelZtbThL1FNUwN8BaCjR7wr2Xfri2sk+kafDdFw/b7btQi7tgYqjhIi2CaBmNOyCVBVcHJhe6EyS7t76+jeNiI+b7UMfAbgcb41HFhO+aDWFbms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p7pfhp7K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eg3uY0Bk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KJzs4WlY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k7rsWAh5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2187205F7;
	Wed, 29 May 2024 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717009265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iVHStC3cHDYoUi4IFL9yxFoo6Ze7RvNnT7yV6Vs3l1k=;
	b=p7pfhp7KON88hEEUVxjiwW0/T4tVa6HXAVcZK+5aapYPR9A7J5cMUo2GLdAxx5QaXxIKO3
	HFp8JcQY3bfEBLlYFIo/TjbBBP0nyjSsrvCJd2BBL+VWRg0cmloyUr+dCOl0Um34sy6SRQ
	LBm6sQWGKEtEmwdNRUTLGTgoIQitMwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717009265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iVHStC3cHDYoUi4IFL9yxFoo6Ze7RvNnT7yV6Vs3l1k=;
	b=Eg3uY0Bkveqcm7j9TLET/Ba0FSmBScwEvz2tW/D6I1tk/Bx4KvOPeI3SpQ5QrBtaOEZgIo
	JVWLsuw2uF/2JhAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KJzs4WlY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k7rsWAh5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717009264;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iVHStC3cHDYoUi4IFL9yxFoo6Ze7RvNnT7yV6Vs3l1k=;
	b=KJzs4WlY22W7gZ61jZo/UAJz9efmNyoKI9cKQQ9CajuivVV3DDv1+JtdKjRJvlb4SCde3c
	3XHBAt/9OePpqsHyIi/a2Irtb0gzmiVtgsHHa6oBeZIUZbzHy3rfyVvZbDAHrABNY/cGOs
	UBmsRhhS8Mq4TCTV452N54x0MyZpWfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717009264;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iVHStC3cHDYoUi4IFL9yxFoo6Ze7RvNnT7yV6Vs3l1k=;
	b=k7rsWAh5im9Nq6lEscR9Fj003HuhJbCX74kPWK+PDG0UBlw+OrMdWiEYM5x8409AZllUIw
	k8veQoeQFIJZuGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6AC013A6B;
	Wed, 29 May 2024 19:01:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CSZXMHB7V2ZeMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 29 May 2024 19:01:04 +0000
Date: Wed, 29 May 2024 21:00:59 +0200
From: David Sterba <dsterba@suse.cz>
To: David Hildenbrand <david@redhat.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: 6.9/BUG: Bad page state in process kswapd0 pfn:d6e840
Message-ID: <20240529190059.GM8631@suse.cz>
Reply-To: dsterba@suse.cz
References: <CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com>
 <CABXGCsOC2Ji7y5Qfsa33QXQ37T3vzdNPsivGoMHcVnCGFi5vKg@mail.gmail.com>
 <0672f0b7-36f5-4322-80e6-2da0f24c101b@redhat.com>
 <CABXGCsN7LBynNk_XzaFm2eVkryVQ26BSzFkrxC2Zb5GEwTvc1g@mail.gmail.com>
 <6b42ad9a-1f15-439a-8a42-34052fec017e@redhat.com>
 <CABXGCsP46xvu3C3Ntd=k5ARrYScAea1gj+YmKYqO+Yj7u3xu1Q@mail.gmail.com>
 <CABXGCsP3Yf2g6e7pSi71pbKpm+r1LdGyF5V7KaXbQjNyR9C_Rw@mail.gmail.com>
 <162cb2a8-1b53-4e86-8d49-f4e09b3255a4@redhat.com>
 <209ff705-fe6e-4d6d-9d08-201afba7d74b@redhat.com>
 <ff29f723-32de-421b-a65e-7b7d2e03162d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff29f723-32de-421b-a65e-7b7d2e03162d@redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -2.71
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E2187205F7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,toxicpanda.com,suse.com,vger.kernel.org,kvack.org,infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]

On Wed, May 29, 2024 at 08:57:48AM +0200, David Hildenbrand wrote:
> On 28.05.24 16:24, David Hildenbrand wrote:
> > Hmm, your original report mentions kswapd, so I'm getting the feeling someone
> > does one folio_put() too much and we are freeing a pageache folio that is still
> > in the pageache and, therefore, has folio->mapping set ... bisecting would
> > really help.
> 
> A little bird just told me that I missed an important piece in the dmesg 
> output: "aops:btree_aops ino:1" from dump_mapping():
> 
> This is btrfs, i_ino is 1, and we don't have a dentry. Is that 
> BTRFS_BTREE_INODE_OBJECTID?

Yes, that's right, inode with number 1 is representing metadata.

> Summarizing what we know so far:
> (1) Freeing an order-0 btrfs folio where folio->mapping
>      is still set
> (2) Triggered by kswapd and kcompactd; not triggered by other means of
>      page freeing so far
> 
> Possible theories:
> (A) folio->mapping not cleared when freeing the folio. But shouldn't
>      this also happen on other freeing paths? Or are we simply lucky to
>      never trigger that for that folio?
> (B) Messed-up refcounting: freeing a folio that is still in use (and
>      therefore has folio-> mapping still set)
> 
> I was briefly wondering if large folio splitting could be involved.

We do not have large folios enabled for btrfs, the conversion from pages
to folios is still ongoing.

With increased number of strange reports either from syzbot or others,
it seems that something got wrong in the 6.10-rc update or maybe
earlier.

