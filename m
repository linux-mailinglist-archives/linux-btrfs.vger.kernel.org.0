Return-Path: <linux-btrfs+bounces-640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C63280574F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 15:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488E71F21659
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 14:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A636465EC7;
	Tue,  5 Dec 2023 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1uSvj6Vl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c09nCdIi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BB8A4
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 06:29:49 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82FB021FF0;
	Tue,  5 Dec 2023 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701786587;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gKDC1ggJGIROZKad3kArWhbRGqeh3CiXvtEmo9u8n70=;
	b=1uSvj6VlTCsPeRa3Tshxzkg/WJi+a12nbdYjJQgKimRb/UCvejee+6o+gCj1Lca7o3wh6S
	Hn1Y5GDy65UZY0ZvBOqiYuIuTrHxKWLD/44GffXJWMbQXHehyva7E/mQVSUaVu4dxatGAc
	yLzqfzOIRtJdMCWopLFYaWgwc/bcJd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701786587;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gKDC1ggJGIROZKad3kArWhbRGqeh3CiXvtEmo9u8n70=;
	b=c09nCdIijqVMFWNrtjBZ5zy7ntzV6VWX/p2EE++5dAvNKbpvSsyj/p7oJU7hJd7KL6SBkH
	EiB6g9B4pJMJHUDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 252A013924;
	Tue,  5 Dec 2023 14:29:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id dgdtBdszb2WcBwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 14:29:47 +0000
Date: Tue, 5 Dec 2023 15:22:53 +0100
From: David Sterba <dsterba@suse.cz>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop unused memparse() parameter
Message-ID: <20231205142253.GD2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231205111329.6652-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205111329.6652-1-ddiss@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.933];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.59%]
X-Spam-Score: -4.01
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 

On Tue, Dec 05, 2023 at 10:13:29PM +1100, David Disseldorp wrote:
> The @retptr parameter for memparse() is optional.
> btrfs_devinfo_scrub_speed_max_store() doesn't use it for any input
> validation, so the parameter can be dropped.

Or should it be used for validation? memparse is also used in
btrfs_chunk_size_store() that accepts whitespace as trailing characters
(namely '\n' if the value is from echo).

