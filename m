Return-Path: <linux-btrfs+bounces-4721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AA58BABD8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 13:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D261F22CF5
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AFE152DF6;
	Fri,  3 May 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z8q3yB+s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nu5BhlNw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z8q3yB+s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nu5BhlNw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335F21514EC;
	Fri,  3 May 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736954; cv=none; b=YJZOBlAMaTWDeYJzs54k1RcsIfo2z/Q993h/FXY6mko+zHGdAzyjqwbvUyr4bpVx5Hm1W1GRpQLE49ARhIt4v7aYx/CccY7AhOOVNBFZb1yxXvhFKWXFBdWgdnGqnknNN0vo+4A/GTjfI7660BCYz+aP22GgOD0zEo1S99apekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736954; c=relaxed/simple;
	bh=0olbmm/rhnyyWFl8CFQCj+jihIf93v16oUU3K4TJGGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOTjTOblI7LutbAEPFI0Z+DDqcsua4Z6vgF7P2pvF7tTqLVWoS9UxQ4dWMZqQzMty0pQLjWLGzQ+CTo2qpXWZMs67J6Ze71jOs2y98U8EqvSNTzTdX3h9xg3sqvZpdS+U3nZqAM8wOxOJXQhJomfAb6nPafYubl6jLhu1cUpOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z8q3yB+s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nu5BhlNw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z8q3yB+s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nu5BhlNw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 482E4338D1;
	Fri,  3 May 2024 11:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714736951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GghGE3RoR280WxEMPHWgb0E/MkQeJiphQvMzgeN7j0=;
	b=Z8q3yB+sM1YED3AFa0XIw+qOhZ1+5kPXqHrpiCtE6jcKs2KAditYfCINq3hEksSx0Cun1k
	M1fqn5z9CRL9l/dUeRbcbKSFSFqmoqSVzK0SWWH+ckXTj+hmHI2krlWN3rr6O1kEdHwunU
	aKrjFlJyjmrASJnhQ5MfW6cfpJpKMk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714736951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GghGE3RoR280WxEMPHWgb0E/MkQeJiphQvMzgeN7j0=;
	b=Nu5BhlNwI9U8KJIiFTGNK1G6+e75IfYztTL19ozqczwAf9C6+XZy4IXpoSI1bmkyIPgUA/
	0NhyIgr2UnxaYBBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Z8q3yB+s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Nu5BhlNw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714736951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GghGE3RoR280WxEMPHWgb0E/MkQeJiphQvMzgeN7j0=;
	b=Z8q3yB+sM1YED3AFa0XIw+qOhZ1+5kPXqHrpiCtE6jcKs2KAditYfCINq3hEksSx0Cun1k
	M1fqn5z9CRL9l/dUeRbcbKSFSFqmoqSVzK0SWWH+ckXTj+hmHI2krlWN3rr6O1kEdHwunU
	aKrjFlJyjmrASJnhQ5MfW6cfpJpKMk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714736951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GghGE3RoR280WxEMPHWgb0E/MkQeJiphQvMzgeN7j0=;
	b=Nu5BhlNwI9U8KJIiFTGNK1G6+e75IfYztTL19ozqczwAf9C6+XZy4IXpoSI1bmkyIPgUA/
	0NhyIgr2UnxaYBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 386AC139CB;
	Fri,  3 May 2024 11:49:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cIeYDTfPNGZrYAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 03 May 2024 11:49:11 +0000
Date: Fri, 3 May 2024 13:41:54 +0200
From: David Sterba <dsterba@suse.cz>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: Fix spelling mistake "decompresssed" ->
 "decompressed"
Message-ID: <20240503114154.GV2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240503094040.2712326-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503094040.2712326-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -2.22
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 482E4338D1
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.22 / 50.00];
	BAYES_HAM(-2.51)[97.78%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

On Fri, May 03, 2024 at 10:40:40AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a btrfs_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Updated in the patch, thanks.

