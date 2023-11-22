Return-Path: <linux-btrfs+bounces-286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6E77F48D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 15:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2D91C20BA1
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 14:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8BB4E1BE;
	Wed, 22 Nov 2023 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bKlSWV//";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nm0p26Yv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5391F112
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 06:23:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E24AC1F8D7;
	Wed, 22 Nov 2023 14:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700663001;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtqZEx919DvSALOYcdGafgy7c/RdaRAHGSHGEJcmtDk=;
	b=bKlSWV//5Z9jTbGSiocI24DmC6mWBmERzzQfCo6ntlMVuw83PDozBQSRnTjtJD5NIw8uaa
	D1KePD1uNrlc8UUmPVT8nfBYXhPnZJH2krBNHojPaNtYIeJAv65HSYzv16be7s8RpyLFA2
	LZFMdxwkIlKRng8m94a/0m4IeK76a2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700663001;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtqZEx919DvSALOYcdGafgy7c/RdaRAHGSHGEJcmtDk=;
	b=Nm0p26YvVzWkscDX5ewdlMlszUmdZj9gXy0A0RBF7G46901YhvXssq44APky1pfUN2Kjon
	svGnsB5ZN3RoosDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC7FF13461;
	Wed, 22 Nov 2023 14:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0zdQMdgOXmUaBgAAMHmgww
	(envelope-from <dsterba@suse.cz>); Wed, 22 Nov 2023 14:23:20 +0000
Date: Wed, 22 Nov 2023 15:16:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/8] btrfs: use a dedicated data structure for chunk maps
Message-ID: <20231122141611.GC11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1700573313.git.fdmanana@suse.com>
 <777320fd09dfc68a89180723bf5d7368dab06299.1700573314.git.fdmanana@suse.com>
 <20231121182314.GU11264@twin.jikos.cz>
 <CAL3q7H5-H2czrYap6XEBJeGDVkKDHJdLt3wCyD0VHFuPjEfLgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5-H2czrYap6XEBJeGDVkKDHJdLt3wCyD0VHFuPjEfLgQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, Nov 22, 2023 at 11:32:33AM +0000, Filipe Manana wrote:
> On Tue, Nov 21, 2023 at 6:30 PM David Sterba <dsterba@suse.cz> wrote:
> > On Tue, Nov 21, 2023 at 01:38:38PM +0000, fdmanana@kernel.org wrote:
> >
> > struct btrfs_chunk_map {
> >         struct rb_node             rb_node __attribute__((__aligned__(8))); /*     0    24 */
> >         refcount_t                 refs;                 /*    24     4 */
> >
> >         /* XXX 4 bytes hole, try to pack */
> >
> >         u64                        start;                /*    32     8 */
> >         u64                        chunk_len;            /*    40     8 */
> >         u64                        stripe_size;          /*    48     8 */
> >         u64                        type;                 /*    56     8 */
> >         /* --- cacheline 1 boundary (64 bytes) --- */
> >         int                        io_align;             /*    64     4 */
> >         int                        io_width;             /*    68     4 */
> >         int                        num_stripes;          /*    72     4 */
> >         int                        sub_stripes;          /*    76     4 */
> >         int                        verified_stripes;     /*    80     4 */
> >
> >         /* XXX 4 bytes hole, try to pack */
> >
> >         struct btrfs_io_stripe     stripes[];            /*    88     0 */
> >
> >         /* size: 88, cachelines: 2, members: 12 */
> >         /* sum members: 80, holes: 2, sum holes: 8 */
> >         /* forced alignments: 1 */
> >         /* last cacheline: 24 bytes */
> > } __attribute__((__aligned__(8)));
> >
> > I could move verify_stripes after refs or move refs to start of the
> > second cacheline between type and io_align. I suspect some cache
> > bouncing could happen with refcount updates and tree traversal but it's
> > a speculation and I don't think the effects would be measurable.
> 
> I would prefer to have verified_stripes in the first cache line, right
> below refs for example, so that
> everything needed for map lookups and insertions is in the same cache line.

Right, that makes sense.

> Do you want to squash such change in this patch? Or should I send it separately?

I'll do the change, thanks.

