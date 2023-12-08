Return-Path: <linux-btrfs+bounces-762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDFF80AC00
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 19:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4874B20BC7
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB747A66;
	Fri,  8 Dec 2023 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2drE1gfu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9wD4UuE1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2drE1gfu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9wD4UuE1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F65584
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 10:24:23 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 108541F458;
	Fri,  8 Dec 2023 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702059861;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iM9cVheboDEqAXnUqt4TO7I6grdyl/FVPCDQTFq4d3g=;
	b=2drE1gfuxB0T2oTYZ28aPGCp/rZE5cx/AViLM2NKhUZlBhGl3YBCEurRw0TRnBC6RoLSDc
	4OLFI08ie+ry4/nhA6PDdd6HMXdULSSMho+4x4//+k0lKfzRX8TGbTqbjlVmYafGvcyPkO
	xjmQmJ06iUr39WmaDHPldI2ZovFj7Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702059861;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iM9cVheboDEqAXnUqt4TO7I6grdyl/FVPCDQTFq4d3g=;
	b=9wD4UuE1kK798jQ+hXLXoHvU721uXLsSn14zoOOdPsZRIF4L6GVJefukLvZpmUdPYHEICq
	FMDDe24+y2kLIDDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702059861;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iM9cVheboDEqAXnUqt4TO7I6grdyl/FVPCDQTFq4d3g=;
	b=2drE1gfuxB0T2oTYZ28aPGCp/rZE5cx/AViLM2NKhUZlBhGl3YBCEurRw0TRnBC6RoLSDc
	4OLFI08ie+ry4/nhA6PDdd6HMXdULSSMho+4x4//+k0lKfzRX8TGbTqbjlVmYafGvcyPkO
	xjmQmJ06iUr39WmaDHPldI2ZovFj7Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702059861;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iM9cVheboDEqAXnUqt4TO7I6grdyl/FVPCDQTFq4d3g=;
	b=9wD4UuE1kK798jQ+hXLXoHvU721uXLsSn14zoOOdPsZRIF4L6GVJefukLvZpmUdPYHEICq
	FMDDe24+y2kLIDDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E1C3C138FF;
	Fri,  8 Dec 2023 18:24:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YCPINVRfc2W+XAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 08 Dec 2023 18:24:20 +0000
Date: Fri, 8 Dec 2023 19:17:29 +0100
From: David Sterba <dsterba@suse.cz>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs-progs: scrub: improve Rate reporting for
 sub-second durations
Message-ID: <20231208181729.GZ2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231207135647.24332-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207135647.24332-1-ddiss@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: 10.05
X-Spamd-Bar: +++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2drE1gfu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9wD4UuE1;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [9.09 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[11.77%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 9.09
X-Rspamd-Queue-Id: 108541F458
X-Spam-Flag: NO

On Fri, Dec 08, 2023 at 12:56:47AM +1100, David Disseldorp wrote:
> Scrubs which complete in under one second may carry a duration rounded
> down to zero. This subsequently results in a bytes_per_sec value of
> zero, which corresponds to the Rate metric output, causing intermittent
> tests/btrfs/282 failures.
> 
> This change ensures that Rate reflects any sub-second bytes processed.
> Time left and ETA metrics are also affected by this change, in that they
> increase to account for (sub-second) bytes_per_sec.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Added to devel, thanks.

