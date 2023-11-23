Return-Path: <linux-btrfs+bounces-328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263A87F66D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 20:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20AA1F20F82
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9784B5BA;
	Thu, 23 Nov 2023 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B//tGx8Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnfJ5d1+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1940B1B3;
	Thu, 23 Nov 2023 11:00:34 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C0C0A1FD64;
	Thu, 23 Nov 2023 19:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700766031;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDA8dmYxhpCdPSbLyUHBYmKqDFaNlmT3atNokd9KUXA=;
	b=B//tGx8YniH1GiHs3keeEPe0/aUZ3Z26uolrBdLSEYVle9nFkqP27PnDkODrrDtJXKQAqF
	L9ovdJC8liFZFu99aQI9B0C7Mp9S5HxbVP9N7vPg6kGq3FW/m2P68KkDS73k/j931le1J9
	Zp7QtwE8Z611BUbgZMmucxXWsIkimxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700766031;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDA8dmYxhpCdPSbLyUHBYmKqDFaNlmT3atNokd9KUXA=;
	b=lnfJ5d1+1xVgXi11COYBah+oKpqOI7rIDDJ1e32IQzDEQ6WL10n6L98RAyRAexOnOX+Fhf
	n796VCoqGlMbecAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id A2F502C16B;
	Thu, 23 Nov 2023 19:00:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 6B3F0DA86C; Thu, 23 Nov 2023 19:53:22 +0100 (CET)
Date: Thu, 23 Nov 2023 19:53:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v2 5/5] btrfs: reflow btrfs_free_tree_block
Message-ID: <20231123185322.GB31451@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
 <20231123-josef-generic-163-v2-5-ed1a79a8e51e@wdc.com>
 <CAL3q7H5yRnxZQzvSoD0H6fWz2dmToxeE7v1v7gFt1Vstc6Q33w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5yRnxZQzvSoD0H6fWz2dmToxeE7v1v7gFt1Vstc6Q33w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: +++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [17.29 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2]
X-Spam-Score: 17.29
X-Rspamd-Queue-Id: C0C0A1FD64

On Thu, Nov 23, 2023 at 04:33:02PM +0000, Filipe Manana wrote:
> On Thu, Nov 23, 2023 at 3:48 PM Johannes Thumshirn
> <johannes.thumshirn@wdc.com> wrote:
> >
> > Reflow btrfs_free_tree_block() so that there is one level of indentation
> > needed.
> >
> > This patch has no functional changes.
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >  fs/btrfs/extent-tree.c | 97 +++++++++++++++++++++++++-------------------------
> >  1 file changed, 49 insertions(+), 48 deletions(-)
> >
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 4044102271e9..093aaf7aeb3a 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -3426,6 +3426,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
> >  {
> >         struct btrfs_fs_info *fs_info = trans->fs_info;
> >         struct btrfs_ref generic_ref = { 0 };
> > +       struct btrfs_block_group *cache;
> 
> While at it, can we rename 'cache' to something like 'bg'?
> 
> The cache name comes from the times where the structure was named
> btrfs_block_group_cache, and having it named cache is always
> confusing.

Agreed, using the new names in new code is highly recommended,
unfortunatelly we still have too many places using 'cache'.

