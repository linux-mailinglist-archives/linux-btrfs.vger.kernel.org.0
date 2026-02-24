Return-Path: <linux-btrfs+bounces-21891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIsKHELgnWnpSQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21891-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 18:30:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D60C118A8B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 18:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB6543045231
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 17:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E04C3A963D;
	Tue, 24 Feb 2026 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N3jbnIBH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fKg3197w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p9aAEhfW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+fKGSlOp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD023EA83
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954234; cv=none; b=hvOOq4dt8MTIhOSgv4dCy03OZKCwb+dmtZzvdHy//wPLNhOEKTaPDm/WaC/9u1vyZQ+TeCwmBuot8WzRTeNIwLOSgNfvWp3KIjPZZ5oMcLKs+C6Igm7La+PJw30hKZ3aR4Biq+uDWgELt+HXMzhQF1bgUEWT6YWRl3+A3ncfZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954234; c=relaxed/simple;
	bh=G57ALwSGjqXzIVj+4zlJkEpni2xe7ulvqzJwh0VTvDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VX3yQ2hVj2r0UCorCRoD2Lmpx1+TVjoir5WMZge3KLBpVD3Kt0EnBQZK34lFl2oPQ2OYWUooI7HGFDcyXUzTd65oo+HsWjA+g6F20PD3/EXQ1NJpL909GS+pESHgCyu7UGkvuOItD4XYJQ3RJWB4+xArGrouIRE9h7W53l7EY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N3jbnIBH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fKg3197w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p9aAEhfW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+fKGSlOp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B3E285BCF9;
	Tue, 24 Feb 2026 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771954231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5h6XXnax5hD4rKz2lhow2L2IU1bWYYvQtu/6zIrGaTM=;
	b=N3jbnIBHpVBT3TlWv1JB+zh0zJRZ/Hxka9EhPGH0Hx21qF77GiD5JZZ/BFVUenNHNobtv3
	OwsEm/7T5kSs1oJmnKzCYH4A3IMp/o1RHyxub62ir3/wvstbOVswUxgIe7GZzgBDlwGYm+
	Vx5Nnen0I81lCTlsBYhf1+DdseRwryw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771954231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5h6XXnax5hD4rKz2lhow2L2IU1bWYYvQtu/6zIrGaTM=;
	b=fKg3197wddhKmyWPACkXIPfCHWwVL/fVjwHCU2H7nUut7T1iyVMh5Lg59MTeB47I8rPAey
	Mi82dQwilYWia4Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771954230;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5h6XXnax5hD4rKz2lhow2L2IU1bWYYvQtu/6zIrGaTM=;
	b=p9aAEhfWsjSJG4e6VaAdmovnAIw7u6SU80Q66p5BBI1mPX82jBbz8FGvrrgFB/N6rjywTL
	3qEvLOeMECUobDNA4VMhzPc9K7Pgg40VG5AMXMlipPZiE3nSF2XCa4GFaHXDfGG0HRVKvd
	DJVcNusPYN33xCAnJNIK4U/6LG4zk9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771954230;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5h6XXnax5hD4rKz2lhow2L2IU1bWYYvQtu/6zIrGaTM=;
	b=+fKGSlOp+QvNEy7yuutR1iaU3FyP+NYau1TLY4garN8soF481EQmVWFuUbag0uabxqW0Sz
	gn94WX7xwg/ojkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BF9A3EA68;
	Tue, 24 Feb 2026 17:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QSLjJTbgnWnJDgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 24 Feb 2026 17:30:30 +0000
Date: Tue, 24 Feb 2026 18:30:29 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] btrfs: fix error message in btrfs_validate_super()
Message-ID: <20260224173029.GC26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260217185335.21013-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217185335.21013-1-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21891-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,harmstone.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D60C118A8B1
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 06:53:19PM +0000, Mark Harmstone wrote:
> Fix the superblock offset mismatch error message in
> btrfs_validate_super(): we changed it so that it considers all the
> superblocks, but the message still assumes we're only looking at the
> first one.
> 
> The change from %u to %llu is because we're changing from a constant to
> a u64.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Fixes: 069ec957c35e ("btrfs: Refactor btrfs_check_super_valid")

FYI I've edited the subjects of the error message fixing patches to be
more specific what is being fixed now that there are a few of them.

