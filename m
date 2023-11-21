Return-Path: <linux-btrfs+bounces-229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960B57F2DEE
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C56282BA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114A848CFF;
	Tue, 21 Nov 2023 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J4sZBrKO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ti8XqvRr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2B7D54
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 05:05:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4784621954;
	Tue, 21 Nov 2023 13:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700571943;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUxuRbn5DLD9nQgpwIjQ/XbguP/njoPKAZKw/QkjvfM=;
	b=J4sZBrKOLiUJ5iQluifP1p+hBoNf709DWsuOXn/KyUkZZLsKeIX++hyqq7XvjE5RAlSUDT
	XxJQ7hKbNaEchb1a/qIV4x1isqXdIg57RMaUZTdQaSufg7ooHngeNT0aKbvYrCLSlr+1H3
	p3wNy0nHJOBrjcc63kRLIagGZ1Ceam4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700571943;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUxuRbn5DLD9nQgpwIjQ/XbguP/njoPKAZKw/QkjvfM=;
	b=Ti8XqvRresNteZ6BLSzCiuhqA4bbg1e7CtFZc99ZCQGbsRUky6lCbLpK6ggebpK0AZCNWf
	vtA+UdMfcnX+vZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15832139FD;
	Tue, 21 Nov 2023 13:05:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id kWMaBCerXGU8JQAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 21 Nov 2023 13:05:43 +0000
Date: Tue, 21 Nov 2023 13:58:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: migrate to use folio private instead of page
 private
Message-ID: <20231121125833.GO11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b4097d7c5a887a0e9d8bdedd9cd112aadb716d58.1700193251.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4097d7c5a887a0e9d8bdedd9cd112aadb716d58.1700193251.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 1.90
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.30)[74.93%]

On Fri, Nov 17, 2023 at 02:24:14PM +1030, Qu Wenruo wrote:
> As a cleanup and preparation for future folio migration, this patch
> would replace all page->private to folio version.
> This includes:
> 
> - PagePrivate()
>   -> folio_test_private()
> 
> - page->private
>   -> folio_get_private()
> 
> - attach_page_private()
>   -> folio_attach_private()
> 
> - detach_page_private()
>   -> folio_detach_private()
> 
> Since we're here, also remove the forced cast on page->private, since
> it's (void *) already, we don't really need to do the cast.
> 
> For now even if we missed some call sites, it won't cause any problem
> yet, as we're only using order 0 folio (single page), thus all those
> folio/page flags should be synced.
> 
> But for the future conversion to utilize higher order folio, the page
> <-> folio flag sync is no longer guaranteed, thus we have to migrate to
> utilize folio flags.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

