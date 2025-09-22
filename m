Return-Path: <linux-btrfs+bounces-17059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3722DB900EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 12:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4532A1DD5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 10:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDD62FFDC6;
	Mon, 22 Sep 2025 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VBeeOxpq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/iUUoBaF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VBeeOxpq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/iUUoBaF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F44288C34
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537287; cv=none; b=aoAqoqPd6is0PPPYiAdFZZumWLzhgqDHA+AR5ngCkKb4OGsl/SDRFpqFv1eGt3t4msxf9wr+/6Konui1nAPyRJ9kA8hey7dPeXGJeFsVPJh6qT6AhJgymtL6nkBZV3ja40TaCzBNBHzSdT+hVdqt8ozblDTKPuzV2PDnZcroAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537287; c=relaxed/simple;
	bh=SvpVRH1Rmm2Oz5mJNd3LRYxacW2IuL1xezhYlATPGWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJNv1/UKvKZliZjwyETdk0KbVQ2CKtLZRVU1cJE+10giTf1uRy46o5QiFybp+uJeVFhTz77+NQGy9wkuIUJj3HIhYvUO3smPGtH9DLk0zZNfXRRJ6aBKcT9X0IR1K/WprrOFUMSp34sjr0Irpil+XYlh2ogAY0PKG5mfvTK+fuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VBeeOxpq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/iUUoBaF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VBeeOxpq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/iUUoBaF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C64C51FD42;
	Mon, 22 Sep 2025 10:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758537283;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qst3Vy1v4TuZqTg2IJNm8R2g+V1pVUud+f+YYek2eLU=;
	b=VBeeOxpqmXnJAPEBQijfWdhEkVAUA55J5VsteRuJaN6Z27nrJjc46kLTLovHbLpYbIWHIg
	KCce9oKosyt6FpSyT6PnThw4BylRabFQOvyrmJWIpr2sTpaPBoH4LCq63L01jEQHm9ZYg+
	/GuZo1QIABb/4mi4o+TnPXWM5xA3I6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758537283;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qst3Vy1v4TuZqTg2IJNm8R2g+V1pVUud+f+YYek2eLU=;
	b=/iUUoBaF6K3P+eiHKDSNfbtRRHrjEmqIpoSnfqiZp59t6ETQcUHSG6dS1qY3Q7BeRk5HSl
	nrpwthZnTxwwkHBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758537283;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qst3Vy1v4TuZqTg2IJNm8R2g+V1pVUud+f+YYek2eLU=;
	b=VBeeOxpqmXnJAPEBQijfWdhEkVAUA55J5VsteRuJaN6Z27nrJjc46kLTLovHbLpYbIWHIg
	KCce9oKosyt6FpSyT6PnThw4BylRabFQOvyrmJWIpr2sTpaPBoH4LCq63L01jEQHm9ZYg+
	/GuZo1QIABb/4mi4o+TnPXWM5xA3I6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758537283;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qst3Vy1v4TuZqTg2IJNm8R2g+V1pVUud+f+YYek2eLU=;
	b=/iUUoBaF6K3P+eiHKDSNfbtRRHrjEmqIpoSnfqiZp59t6ETQcUHSG6dS1qY3Q7BeRk5HSl
	nrpwthZnTxwwkHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B827C1388C;
	Mon, 22 Sep 2025 10:34:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U9ijLEMm0WiBPwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 22 Sep 2025 10:34:43 +0000
Date: Mon, 22 Sep 2025 12:34:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: Prevent open-coded arithmetic on kmalloc
Message-ID: <20250922103442.GM5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250919145816.959845-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919145816.959845-1-mssola@mssola.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Fri, Sep 19, 2025 at 04:58:14PM +0200, Miquel Sabaté Solà wrote:
> The second patch is a small cleanup after fixing up my first patch, in
> which I realized that the __free(kfree) attribute would come in handy in a
> couple of particularly large functions with multiple exit points. This
> second patch is probably more of a cosmetic thing, and it's not an
> exhaustive exercise by any means. All of this to say that even if I feel
> like it should be included, I don't mind if it has to be dropped.

Yes there are many candidates for the __free() cleanup annotation and
we'll want to fix them all systematically. We already have the automatic
cleaning for struct btrfs_path (BTRFS_PATH_AUTO_FREE). For the
kfree/kvfree I'd like to something similar:

#define AUTO_KFREE(name)       *name __free(kfree) = NULL
#define AUTO_KVFREE(name)      *name __free(kvfree) = NULL

This wraps the name and initializes it to NULL so it's not accidentally
forgotten.

