Return-Path: <linux-btrfs+bounces-267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D658B7F35EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 19:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64205282BA5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 18:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEE355C30;
	Tue, 21 Nov 2023 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UD3SOIhY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Aqj4RAKY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F9212E
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 10:30:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E756621921;
	Tue, 21 Nov 2023 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700591423;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mDVkS1FTfuXVXrStn1Gs3iIu9bbSSE0GFmVNY3Wo9L4=;
	b=UD3SOIhYVnJNNg/gHr+jNxAdvKzrd57vMVP38+LMV9piXCt7lHdm2ZSz2eFKZM3yCM6dM5
	NvCZv07IWLL9tUNkUxUBpQLLrB29rAEXJub860QrcpL+vq8APv8WTOw5fTDbjJgi/VQr8T
	zLay1XAz9c0qCbuSoJF6JHjNMmmOWrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700591423;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mDVkS1FTfuXVXrStn1Gs3iIu9bbSSE0GFmVNY3Wo9L4=;
	b=Aqj4RAKYlHl2+3zQWzMROnTH4/EOPGFz26BfRbiudCJKQiHS1RGoA5HPl4w8hjwAMstvjP
	8sRbSZJC+nJaj/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD3EE138E3;
	Tue, 21 Nov 2023 18:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 7Mh3KT/3XGX4TgAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 21 Nov 2023 18:30:23 +0000
Date: Tue, 21 Nov 2023 19:23:14 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/8] btrfs: use a dedicated data structure for chunk maps
Message-ID: <20231121182314.GU11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1700573313.git.fdmanana@suse.com>
 <777320fd09dfc68a89180723bf5d7368dab06299.1700573314.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777320fd09dfc68a89180723bf5d7368dab06299.1700573314.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 BAYES_SPAM(0.00)[24.47%];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[]

On Tue, Nov 21, 2023 at 01:38:38PM +0000, fdmanana@kernel.org wrote:
>  extern const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES];
>  
> -struct map_lookup {
> +struct btrfs_chunk_map {
> +	struct rb_node rb_node;
> +	refcount_t refs;
> +	u64 start;
> +	u64 chunk_len;
> +	u64 stripe_size;
>  	u64 type;
>  	int io_align;
>  	int io_width;
>  	int num_stripes;
>  	int sub_stripes;
> -	int verified_stripes; /* For mount time dev extent verification */
> +	/* For mount time dev extent verification. */
> +	int verified_stripes;
>  	struct btrfs_io_stripe stripes[];
>  };

This results in two 4 byte holes:

struct btrfs_chunk_map {
        struct rb_node             rb_node __attribute__((__aligned__(8))); /*     0    24 */
        refcount_t                 refs;                 /*    24     4 */

        /* XXX 4 bytes hole, try to pack */

        u64                        start;                /*    32     8 */
        u64                        chunk_len;            /*    40     8 */
        u64                        stripe_size;          /*    48     8 */
        u64                        type;                 /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        int                        io_align;             /*    64     4 */
        int                        io_width;             /*    68     4 */
        int                        num_stripes;          /*    72     4 */
        int                        sub_stripes;          /*    76     4 */
        int                        verified_stripes;     /*    80     4 */

        /* XXX 4 bytes hole, try to pack */

        struct btrfs_io_stripe     stripes[];            /*    88     0 */

        /* size: 88, cachelines: 2, members: 12 */
        /* sum members: 80, holes: 2, sum holes: 8 */
        /* forced alignments: 1 */
        /* last cacheline: 24 bytes */
} __attribute__((__aligned__(8)));

I could move verify_stripes after refs or move refs to start of the
second cacheline between type and io_align. I suspect some cache
bouncing could happen with refcount updates and tree traversal but it's
a speculation and I don't think the effects would be measurable.

