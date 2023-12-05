Return-Path: <linux-btrfs+bounces-641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A425380575B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 15:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E308281CB0
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 14:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5194065EC6;
	Tue,  5 Dec 2023 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0JDT+4Ix";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nadiVzKW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722EC183
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 06:34:24 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCF3C22075;
	Tue,  5 Dec 2023 14:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701786862;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQPqLtgdYmIUwFKYb0JJJDtM9JlKCr5r1aGmD0yypUU=;
	b=0JDT+4IxZyVUvuLxbfu8tjkhBCk7tTp46MXfmRycq82VTFjjFjyIqlCvMWW5vu+3bMAnra
	4Zwt2tsIOdNZZDkYIHdspcsNQEBA1D0/taWiP/u2UBlX++2F3sq5wPrhhst98kugv57eTw
	Y3+HKPofF8Zgx83+9dXcSVNLf4B4BJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701786862;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQPqLtgdYmIUwFKYb0JJJDtM9JlKCr5r1aGmD0yypUU=;
	b=nadiVzKW+4T7cgZses67IyP1pCIm3UxzOpnzi7vhSKLujukjWH5CigiroQyvt1vCS7Fy0f
	I13Ui250qBUjfLCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AED4138FF;
	Tue,  5 Dec 2023 14:34:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vsiLH+40b2XzCAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 14:34:22 +0000
Date: Tue, 5 Dec 2023 15:27:32 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/5] btrfs: free qgroup pertrans rsv on trans abort
Message-ID: <20231205142732.GE2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701464169.git.boris@bur.io>
 <07934597eaee1e2204c204bfd34bc628708e3739.1701464169.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07934597eaee1e2204c204bfd34bc628708e3739.1701464169.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [0.05 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.15)[-0.764];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[18.19%]
X-Spam-Score: 0.05
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 

On Fri, Dec 01, 2023 at 01:00:11PM -0800, Boris Burkov wrote:
> If we abort a transaction, we never run the code that frees the pertrans
> qgroup reservation. This results in warnings on unmount as that
> reservation has been leaked. The leak isn't a huge issue since the fs is
> read-only, but it's better to clean it up when we know we can/should. Do
> it during the cleanup_transaction step of aborting.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/disk-io.c | 28 ++++++++++++++++++++++++++++
>  fs/btrfs/qgroup.c  |  5 +++--
>  2 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 9317606017e2..a1f440cd6d45 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4775,6 +4775,32 @@ void btrfs_cleanup_dirty_bgs(struct btrfs_transaction *cur_trans,
>  	}
>  }
>  
> +static void btrfs_free_all_qgroup_pertrans(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_root *gang[8];
> +	int i;
> +	int ret;
> +
> +	spin_lock(&fs_info->fs_roots_radix_lock);
> +	while (1) {
> +		ret = radix_tree_gang_lookup_tag(&fs_info->fs_roots_radix,
> +						 (void **)gang, 0,
> +						 ARRAY_SIZE(gang),
> +						 0); // BTRFS_ROOT_TRANS_TAG

What does the comment mean?

