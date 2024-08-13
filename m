Return-Path: <linux-btrfs+bounces-7179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ADF950FD7
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 00:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0351C21F46
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 22:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE76D1AB524;
	Tue, 13 Aug 2024 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X1uLl1F0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8cqqWuTo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X1uLl1F0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8cqqWuTo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427A21AAE2C
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589079; cv=none; b=Vnx7mBuVXfTI35zzl2f4rGXtYqunIXfQo5xuX9ORqPxHDTOwMaTVNK1rWGmT6VsCWjBz6UAk9CT6Mrmnyh3OucQlb5qFTrE96TkOrRdyRp2/ekpe7K+IEHXkjI4y3l+8FsuOQqArCKq1AmJT8KXDNZ/u/ZkXkWWBqwhzAplstv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589079; c=relaxed/simple;
	bh=VfJs7B8xNVs3k4bJkJKShDyzObd+57wpVhNnkP7oTiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPo/Lt3eE41YQWIkPkaWY/S7CO6Q2g3kXcFxSoxP1gyMkRBlY6NDo88k+VYG5eMtXKyYuk9gD+tCs1rZ+mznEFVvQsSAkuPDfC86jFIaCZhpH3z90MLdrpVJ3FVGblunUCB5TTN8lG3lhMSuKCrVrEk+qFi9zoj+N78zNXHNpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X1uLl1F0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8cqqWuTo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X1uLl1F0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8cqqWuTo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CC021FBCD;
	Tue, 13 Aug 2024 22:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723589075;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcWL0O6o4WhTEU+95jFDdbjDRmTqhpj/4jh8XMXVUqc=;
	b=X1uLl1F0o3TL6WiiGJrDmf5OZhpQUZ9Dy2OIPoiUk7ZYvn2cj0mP4KeYpsslVFv1fUeIQm
	y4nKsOgNLweNLG4MlCIxqPU/i/iSTg2SOcosnV1iX065mALr9/ydkynaODQFRMe1ibjJ2b
	LCFasTxQi0NPixPJ9BbDzcYUTI0bBTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723589075;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcWL0O6o4WhTEU+95jFDdbjDRmTqhpj/4jh8XMXVUqc=;
	b=8cqqWuTo6ssk5nQx8jf9aRTlMsIjCTGotV9YinVNRmGQxPNcdF17/l/+NG7BIk5xksaVkP
	s/et4hoZ0/P+4xCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723589075;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcWL0O6o4WhTEU+95jFDdbjDRmTqhpj/4jh8XMXVUqc=;
	b=X1uLl1F0o3TL6WiiGJrDmf5OZhpQUZ9Dy2OIPoiUk7ZYvn2cj0mP4KeYpsslVFv1fUeIQm
	y4nKsOgNLweNLG4MlCIxqPU/i/iSTg2SOcosnV1iX065mALr9/ydkynaODQFRMe1ibjJ2b
	LCFasTxQi0NPixPJ9BbDzcYUTI0bBTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723589075;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcWL0O6o4WhTEU+95jFDdbjDRmTqhpj/4jh8XMXVUqc=;
	b=8cqqWuTo6ssk5nQx8jf9aRTlMsIjCTGotV9YinVNRmGQxPNcdF17/l/+NG7BIk5xksaVkP
	s/et4hoZ0/P+4xCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E24A13983;
	Tue, 13 Aug 2024 22:44:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T0y7CtPhu2YBKgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Aug 2024 22:44:35 +0000
Date: Wed, 14 Aug 2024 00:44:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Junchao Sun <sunjunchao2870@gmail.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, wqu@suse.com
Subject: Re: [PATCH v3 1/2] btrfs: qgroup: use goto style to handle error in
 add_delayed_ref().
Message-ID: <20240813224433.GV25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240607143021.122220-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607143021.122220-1-sunjunchao2870@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Jun 07, 2024 at 10:30:20PM +0800, Junchao Sun wrote:
> Clean up resources using goto to get rid of repeated code.
> 
> Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>

I had the patches in my testing branches, no problems so far so I'm
adding it for 6.12. Thanks.

