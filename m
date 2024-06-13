Return-Path: <linux-btrfs+bounces-5722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50766907E34
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 23:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E94B21CDF
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 21:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9C313DDBA;
	Thu, 13 Jun 2024 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mOUHzpxX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="etQmipCL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mOUHzpxX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="etQmipCL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695E57FBD2
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314343; cv=none; b=Tqpa8xUWSGIeQPRB9ENfEUofHgn49QSwG7jo4eHSWOG/1VDr5t7B87HmFuB+olpB3GqceT1wSFIxDKFumuCz+ZR3R9vr6aO+bQdFPC+pFzPX4OjKQOpR47dCkV9OF1pQTJXNMX9OPbZzrVwV66MiRYZpv5sNHHRe6q09C9atA4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314343; c=relaxed/simple;
	bh=yXd17+WwMXZIkYVQL+d2vRumM6PjhaUjqHorn4CbP7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwPlERx1SrW9lnRdKIvB3Upo/90T/WVG11+BUEMoDweedNJeo1llgkMsBtTjes1CKhuhH73DjeVj9SVVUUoBKneaUazi4nu7lf4vwgl+uVR5eBpTMrPnPC9HtKQHm4iNYLomv4qvv/+hro74zrgWKHX2rhW7YWcF3Aw8f4TgM2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mOUHzpxX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=etQmipCL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mOUHzpxX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=etQmipCL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9897D1F845;
	Thu, 13 Jun 2024 21:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718314339;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xVsPb16u9ADQ0WbjsJnPRSTWiJQB7AhSKYcYiCt07fs=;
	b=mOUHzpxXTqNtia1e5nGetKzN8lKIZHmVlLwgGx5mc26cT8rrjQnmAUpexB3OmEz+tFoWRn
	Npuwz5O57TNmy3hQtNWdrbGZcE/VzDMpCTW8Hdmczcn4jGZDOc5pwzobxsAynGI0SCfDED
	Z0enieYGIfIAg8xZDu/dTspzhfSykqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718314339;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xVsPb16u9ADQ0WbjsJnPRSTWiJQB7AhSKYcYiCt07fs=;
	b=etQmipCLFfN9xxPq8HTLV0S1j+XmnCl/W6QbdSjcopZVF+UhY8kZBupiYGz9+EyxfdGwLU
	0i9JiIY8sU7Wl0AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718314339;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xVsPb16u9ADQ0WbjsJnPRSTWiJQB7AhSKYcYiCt07fs=;
	b=mOUHzpxXTqNtia1e5nGetKzN8lKIZHmVlLwgGx5mc26cT8rrjQnmAUpexB3OmEz+tFoWRn
	Npuwz5O57TNmy3hQtNWdrbGZcE/VzDMpCTW8Hdmczcn4jGZDOc5pwzobxsAynGI0SCfDED
	Z0enieYGIfIAg8xZDu/dTspzhfSykqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718314339;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xVsPb16u9ADQ0WbjsJnPRSTWiJQB7AhSKYcYiCt07fs=;
	b=etQmipCLFfN9xxPq8HTLV0S1j+XmnCl/W6QbdSjcopZVF+UhY8kZBupiYGz9+EyxfdGwLU
	0i9JiIY8sU7Wl0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 761AF13A87;
	Thu, 13 Jun 2024 21:32:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hk6pHGNla2boRAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Jun 2024 21:32:19 +0000
Date: Thu, 13 Jun 2024 23:32:18 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: uapi: record temporary super flags utilized by
 btrfstune
Message-ID: <20240613213218.GC25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4b9edf48c6071085f376e9861faf4dd6ecdac95b.1717966255.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b9edf48c6071085f376e9861faf4dd6ecdac95b.1717966255.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]

On Mon, Jun 10, 2024 at 06:22:56AM +0930, Qu Wenruo wrote:
> [BUG]
> There is a bug report that a canceled csum conversion (still
> experimental feature) resulted unexpected super flags:
> 
> csum_type		0 (crc32c)
> csum_size		4
> csum			0x14973811 [match]
> bytenr			65536
> flags			0x1000000001
> 			( WRITTEN |
> 			  CHANGING_FSID_V2 )
> magic			_BHRfS_M [match]
> 
> Meanwhile for a fs under csum conversion it should have either
> CHANGING_DATA_CSUM or CHANGING_META_CSUM.
> 
> [CAUSE]
> It turns out that, due to btrfs-progs keeps its own extra flags inside
> its own ctree.h headers, not the shared uapi headers, we have
> conflicting super flags:
> 
> kernel-shared/uapi/btrfs_tree.h:#define BTRFS_SUPER_FLAG_METADUMP_V2	(1ULL << 34)
> kernel-shared/uapi/btrfs_tree.h:#define BTRFS_SUPER_FLAG_CHANGING_FSID	(1ULL << 35)
> kernel-shared/uapi/btrfs_tree.h:#define BTRFS_SUPER_FLAG_CHANGING_FSID_V2 (1ULL << 36)
> kernel-shared/ctree.h:#define BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM	(1ULL << 36)
> kernel-shared/ctree.h:#define BTRFS_SUPER_FLAG_CHANGING_META_CSUM	(1ULL << 37)
> 
> Note that CHANGING_FSID_V2 is conflicting with CHANGING_DATA_CSUM.
> 
> [FIX]
> The proper fix would be done inside btrfs-progs, but to keep everything
> properly recorded, we should have everything inside the same uapi
> header.
> 
> This patch would copy all the new flags into uapi header, and change the
> value for CHANGING_DATA_CSUM and CHANGING_META_CSUM, while keep the
> value of CHANGING_BG_TREE untouched.
> 
> Thankfully csum change is still only experimental and all those
> CHANGING_* flags are transient (only for btrfs-progs to resume the
> conversion, and kernel will reject them all), the damage is still minor.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Keep the number consistent between kernel and btrfs-progs

Reviewed-by: David Sterba <dsterba@suse.com>

Thanks. Syncing the user space specific bits to kernel was
unfortunatelly always lagging behind if done at all, now it caused a
noticeable problem.  Keeping the definitions in the place where one
would expect it is good, the kernel<->userspace sync is ongoing but
still slowly and not in full extent so you may find other examples.
Every bit helps though.

