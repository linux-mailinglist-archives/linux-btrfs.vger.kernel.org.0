Return-Path: <linux-btrfs+bounces-12237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DA5A5DE47
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 14:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6033B6EB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 13:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404224A07F;
	Wed, 12 Mar 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BDDk2J7o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WWVEitEV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BDDk2J7o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WWVEitEV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3875D24A047
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787105; cv=none; b=TZSegP7LZmp7SP1KvWcDi79ZXsy1jhluPFA26DeXX9VDoF72CmgQaasNsOxSoNA394jdfpiTLkhqgJnXk6fS7Ba9A2V6H8NAAR/wEYK6pOTvOSaCHlZlnte/DPYrm8lWmPyjvHOo1s/THZfUgmN+CL0+vdlp9VFWgoM2599Sa7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787105; c=relaxed/simple;
	bh=g09X38fdY8q10XKN4pD+ejjPRZ2LKBtCf8CUnIc7W/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvjr9JZBRuifbd2kJHvzbQYee7LBWalBaFCPJihpSPnbQNOsFA4XSeXUrFM8NbIrhxeNzELvnWejyXUOovSBHwP5nYj5R1LMQKzV/dv7CedXiwNgWCTy+cEa3OC+xrp3gABqKU4QkQKF4VHrMJ4XROSV/QsSWSswWrf8sqEDZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BDDk2J7o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WWVEitEV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BDDk2J7o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WWVEitEV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1048C1F385;
	Wed, 12 Mar 2025 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741787101;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GU81/xXJ1++0zsbDjt5tkGzQRiNcjtpOlp16nykRks0=;
	b=BDDk2J7oBBJ507FwKCPYqoeblHCjIWfO2B+xHNufwindiTeJ0JvEHLVA0bzmUOGSrteOEe
	CYYmBNX+JORszjk1Ccz67DFW3X4SSXzFD2/YwcqZ8OP+5JW6aUPYJtmxL3W9PCxpsQ0hMV
	lixGC1oIMuMpvbdwDW6QLucNNEo41R8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741787101;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GU81/xXJ1++0zsbDjt5tkGzQRiNcjtpOlp16nykRks0=;
	b=WWVEitEVhkkXwpOm5bJbE1DmeQ4t+b0yQAsGEoFVyJdM7ft1/d2odNmgoH1k2It4aR3Jl2
	tVfRRZyZSYSmk+Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BDDk2J7o;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WWVEitEV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741787101;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GU81/xXJ1++0zsbDjt5tkGzQRiNcjtpOlp16nykRks0=;
	b=BDDk2J7oBBJ507FwKCPYqoeblHCjIWfO2B+xHNufwindiTeJ0JvEHLVA0bzmUOGSrteOEe
	CYYmBNX+JORszjk1Ccz67DFW3X4SSXzFD2/YwcqZ8OP+5JW6aUPYJtmxL3W9PCxpsQ0hMV
	lixGC1oIMuMpvbdwDW6QLucNNEo41R8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741787101;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GU81/xXJ1++0zsbDjt5tkGzQRiNcjtpOlp16nykRks0=;
	b=WWVEitEVhkkXwpOm5bJbE1DmeQ4t+b0yQAsGEoFVyJdM7ft1/d2odNmgoH1k2It4aR3Jl2
	tVfRRZyZSYSmk+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0F301377F;
	Wed, 12 Mar 2025 13:45:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mGKhOtyP0WfiaAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Mar 2025 13:45:00 +0000
Date: Wed, 12 Mar 2025 14:44:55 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] btrfs: prepare for larger folios support
Message-ID: <20250312134455.GN32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1741591823.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741591823.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 1048C1F385
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Mar 10, 2025 at 06:05:56PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Split the subpage.[ch] modification into 3 patches
> - Rebased the latest for-next branch
>   Now all dependency are in for-next.

Please add the series to for-next, I haven't found anything that would
need fixups or another resend so we cant get it to 6.15 queue. Thanks.

