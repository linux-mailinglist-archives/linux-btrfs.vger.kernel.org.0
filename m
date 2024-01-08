Return-Path: <linux-btrfs+bounces-1312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E133C827755
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 19:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920DE1F23BC6
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 18:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE6C55795;
	Mon,  8 Jan 2024 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GqhpxxDc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iXiK/HXp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GqhpxxDc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iXiK/HXp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850A55780
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 325421FD06;
	Mon,  8 Jan 2024 18:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704738213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuP+vHmMS2HbuNl+iXJ7cTsLVcSXu8sGMKXBTHk35HM=;
	b=GqhpxxDcZf+AhCGzmwwvQnToAPQzcAgYkW4fQuO+h4F30ybCHa3EFonX273F06A6gIf+p8
	5vPfWavnmDcfUeYWqiySJcJJl8Bsg5DJXfL+FXx8ZQfYPT1XudM6GVEJ/4/XgP2aKWpJ4f
	zhZuEn57ChrSwbzMIqhBYEEpe59ZEQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704738213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuP+vHmMS2HbuNl+iXJ7cTsLVcSXu8sGMKXBTHk35HM=;
	b=iXiK/HXp8Jn0ZIKZ39kYJAZRxXAE0utjXNp3QdbdRbXwpdw8yZfUAUKoPYYz6E6FYVvAkw
	6a2rzMuGSG+hpGAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704738213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuP+vHmMS2HbuNl+iXJ7cTsLVcSXu8sGMKXBTHk35HM=;
	b=GqhpxxDcZf+AhCGzmwwvQnToAPQzcAgYkW4fQuO+h4F30ybCHa3EFonX273F06A6gIf+p8
	5vPfWavnmDcfUeYWqiySJcJJl8Bsg5DJXfL+FXx8ZQfYPT1XudM6GVEJ/4/XgP2aKWpJ4f
	zhZuEn57ChrSwbzMIqhBYEEpe59ZEQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704738213;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuP+vHmMS2HbuNl+iXJ7cTsLVcSXu8sGMKXBTHk35HM=;
	b=iXiK/HXp8Jn0ZIKZ39kYJAZRxXAE0utjXNp3QdbdRbXwpdw8yZfUAUKoPYYz6E6FYVvAkw
	6a2rzMuGSG+hpGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AF9D13686;
	Mon,  8 Jan 2024 18:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gPjBAaU9nGUcYwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Jan 2024 18:23:33 +0000
Date: Mon, 8 Jan 2024 19:23:19 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: prefer to allocate larger folio for metadata
Message-ID: <20240108182319.GF28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b2a33b0d75b29a0945b58342d021b24cf157114c.1704434178.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a33b0d75b29a0945b58342d021b24cf157114c.1704434178.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.12 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.12)[88.45%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.12

On Fri, Jan 05, 2024 at 04:27:01PM +1030, Qu Wenruo wrote:
> With all the migration (including the previous ones which are only
> detected through this patch), we can finally enable larger folio support
> for metadata.

The good time to add this would be after rc2 so there's at least one
full rc when 3rd parties start to pick the 6.8 changes.

