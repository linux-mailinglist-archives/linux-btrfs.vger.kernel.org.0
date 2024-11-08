Return-Path: <linux-btrfs+bounces-9395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8644B9C1FF8
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 16:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF99284491
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 15:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F13E1F582A;
	Fri,  8 Nov 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xDwP9Iku";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WSrHRIUN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xDwP9Iku";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WSrHRIUN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C761D0400;
	Fri,  8 Nov 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078228; cv=none; b=Qynit+vu8cyvj3FxoDnXLV9r4mh6aRd2DwDbDa/M2AbHGcrfX+92LxBsIuAp+OoBiGxdH5QpFZKIuTAMxEeQs/fM5nedVkKaau6aNp+FKryX7GTMqTrLpsJCfgugMtQfYXaKVnxQ9NAPb3K31L2SoUIN2EpcYZu0c8gcRPqfIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078228; c=relaxed/simple;
	bh=F2BBCV5UtSfasZHSEbvfSPmOvKCtm5srso/IOGQxV60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWs+0Hk2YQjNuHjG2RC+KwaY3or69SKvvUZ58FDA7kWIeyqri83Rn+j6R+Ap9GTnNRKR9TGj/PEO7iSltkfHkhD2stnW40T41oGEyHoldc+kKZ12em4uqoKAiDgz76D1dtZGGVqKf+Tj77gr6TgETaFjm0WuGNiBGANFW3BSfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xDwP9Iku; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WSrHRIUN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xDwP9Iku; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WSrHRIUN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 873081FF98;
	Fri,  8 Nov 2024 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731078224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJE4Kk/PK6/AdtEAxBANfQL9F2PVsBSMImx2Gx8nC4A=;
	b=xDwP9IkunwwfK6Te4YiEGV22jj6jTI41X0cYpvjaI7anGA6aAEEG7RMPq4L6Vu2tObcK24
	zkU8jYFUyEY3XxLJpC57KGIL7wx4OayFp7RJPrgiFP5mCpZAM/suCvrVcoyyPQrOJ4KYPO
	u/Y6hGKx2WLq8YU4vnfQA7uSYpZUtBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731078224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJE4Kk/PK6/AdtEAxBANfQL9F2PVsBSMImx2Gx8nC4A=;
	b=WSrHRIUNs6iFnRE/8DSLlsHF+k9S8m6YpNBSQH60nU/tBVTUvoW0CVqNLbKQ2QVoILTKuG
	EpyekGqnMkgAoxCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731078224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJE4Kk/PK6/AdtEAxBANfQL9F2PVsBSMImx2Gx8nC4A=;
	b=xDwP9IkunwwfK6Te4YiEGV22jj6jTI41X0cYpvjaI7anGA6aAEEG7RMPq4L6Vu2tObcK24
	zkU8jYFUyEY3XxLJpC57KGIL7wx4OayFp7RJPrgiFP5mCpZAM/suCvrVcoyyPQrOJ4KYPO
	u/Y6hGKx2WLq8YU4vnfQA7uSYpZUtBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731078224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJE4Kk/PK6/AdtEAxBANfQL9F2PVsBSMImx2Gx8nC4A=;
	b=WSrHRIUNs6iFnRE/8DSLlsHF+k9S8m6YpNBSQH60nU/tBVTUvoW0CVqNLbKQ2QVoILTKuG
	EpyekGqnMkgAoxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CECA1394A;
	Fri,  8 Nov 2024 15:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cLY1FlAoLmfgEQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 08 Nov 2024 15:03:44 +0000
Date: Fri, 8 Nov 2024 16:03:43 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: fix a few zoned append issues v2 (now with Ccs)
Message-ID: <20241108150343.GN31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241104062647.91160-1-hch@lst.de>
 <20241108144857.GA8543@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108144857.GA8543@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Nov 08, 2024 at 03:48:57PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 04, 2024 at 07:26:28AM +0100, Christoph Hellwig wrote:
> > Hi Jens, hi Damien, hi btrfs maintainers,
> 
> How should we proceed with this?  Should Jens just pick up the block
> bits and the btrfs maintainers pick up the btrfs once they are
> ready and the block bits made it upstream?

Sounds ok for me from the btrfs side.

