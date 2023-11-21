Return-Path: <linux-btrfs+bounces-230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A13EB7F2E01
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5BD2B21ADD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DED4A989;
	Tue, 21 Nov 2023 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sm7PREpT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QEx1iHNi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C17797;
	Tue, 21 Nov 2023 05:10:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9097E21961;
	Tue, 21 Nov 2023 13:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700572224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqg8B1Cfy6FxrdAzeN1cVHxxKFT4Kxba9fydGibvXb4=;
	b=sm7PREpTMHoagXGVOOeISV/D770oLS3kztQsSBml/7ohykRkHkXh582U1IR4J+SBWUVZkV
	7KpJrhMA9NmN1ZlD1DemUrePdmXkpE3sNp9Zdjqc9g0484i9EYwdT7tfBG5Ch8nAYrDlBe
	QnriHgQtiJ5HQV2DG9b3r/FOeGYA4uE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700572224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqg8B1Cfy6FxrdAzeN1cVHxxKFT4Kxba9fydGibvXb4=;
	b=QEx1iHNikLdHtI8E5AooFBcr6KffnYEX8Xr1S0JYdb7QRjjU1URfKUJLR9xeuEUo96RxIw
	HnA74SfUlbZs7UDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D757139FD;
	Tue, 21 Nov 2023 13:10:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bkcGFkCsXGXYJwAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 21 Nov 2023 13:10:24 +0000
Date: Tue, 21 Nov 2023 14:03:15 +0100
From: David Sterba <dsterba@suse.cz>
To: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] btrfs: ref-verify: fix memory leaks
Message-ID: <20231121130315.GP11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231118091012.14818-1-bragathemanick0908@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118091012.14818-1-bragathemanick0908@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.64
X-Spamd-Result: default: False [3.64 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[d66de4cbf532749df35f];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.06)[60.70%];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Sat, Nov 18, 2023 at 02:40:12PM +0530, Bragatheswaran Manickavel wrote:
> In btrfs_ref_tree_mod(), when !parent 're' was allocated
> through kmalloc(). In the following code, if an error occurs,
> the execution will be redirected to 'out' or 'out_unlock' and
> the function will be exited. However, on some of the paths,
> 're' are not deallocated and may lead to memory leaks.
> 
> For example : lookup_block_entry() for 'be' returns null, the
> out label will be invoked. During that flow ref and ra was
> freed but not re, which can potentially lead to memleak
> 
> Reported-and-tested-by: syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>

Added to misc-next, thanks.

