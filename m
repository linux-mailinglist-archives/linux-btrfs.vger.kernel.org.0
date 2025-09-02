Return-Path: <linux-btrfs+bounces-16598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E08B40D4E
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 20:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E4818883A5
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE772E336F;
	Tue,  2 Sep 2025 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZrZvjrHq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ZHO2Bkx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZrZvjrHq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ZHO2Bkx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D2241667
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838858; cv=none; b=ffXEzMqC0lgRuwLgIp64thRVtKmmiKpb5qquV+s84qbldyMozAniboXXORsq6FMxw92lZsSNOKNqJoURZyG2GVG+vaxNeVPEDVXNsbkp+djwQrq4Qn/z3sIE/7MaxTbUcJ8xyNE5G/aRPCDUEg0Reh3EVZRly6quR1Geqwrf5lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838858; c=relaxed/simple;
	bh=6v52S7oCZfKvUIQxANtJISbG/SFbLReJ2hyheD9nw7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYRcznsvM9Lyu/wb088Nllnum8hpaxI2Iz/6+tKVj9j/Jyyyzahg+K9Br+FALSU0+Vr3APPuLyoEHLo1fy+bWczIR1kQCynzrX0MorBosSg4no5tsKj3+MjxUJQUQtB+Q4TQBD2gwR9x2Xbuybp7Ak3eP5tw9lOv+/Rk21PgCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZrZvjrHq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ZHO2Bkx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZrZvjrHq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ZHO2Bkx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B06D211EF;
	Tue,  2 Sep 2025 18:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756838855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6v52S7oCZfKvUIQxANtJISbG/SFbLReJ2hyheD9nw7Q=;
	b=ZrZvjrHqdZ65ZXZcfnrXzVHePzVkgTK+Obb4nsVUBrC8jSKhZdQZ2H6mVBapeXPvolX533
	+DpQ7PbZIEUnKe2x5bIFWSJlQ12q8KtNTdpUhG2Ls4EBc8S1CfbP0cPfaNSeZ3A8NNLvxI
	0CyVT7OEnzSnlgWlpOLnkbR6J+ISuos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756838855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6v52S7oCZfKvUIQxANtJISbG/SFbLReJ2hyheD9nw7Q=;
	b=2ZHO2Bkxbg+Aa4UQeGMExmb2U7hRayR0f8BDJMN0thT45GoLwRC3S79oY2++DESz5JID5/
	ATE7WQE2+P1o9GBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756838855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6v52S7oCZfKvUIQxANtJISbG/SFbLReJ2hyheD9nw7Q=;
	b=ZrZvjrHqdZ65ZXZcfnrXzVHePzVkgTK+Obb4nsVUBrC8jSKhZdQZ2H6mVBapeXPvolX533
	+DpQ7PbZIEUnKe2x5bIFWSJlQ12q8KtNTdpUhG2Ls4EBc8S1CfbP0cPfaNSeZ3A8NNLvxI
	0CyVT7OEnzSnlgWlpOLnkbR6J+ISuos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756838855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6v52S7oCZfKvUIQxANtJISbG/SFbLReJ2hyheD9nw7Q=;
	b=2ZHO2Bkxbg+Aa4UQeGMExmb2U7hRayR0f8BDJMN0thT45GoLwRC3S79oY2++DESz5JID5/
	ATE7WQE2+P1o9GBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BDE613888;
	Tue,  2 Sep 2025 18:47:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uPF0Asc7t2gbawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Sep 2025 18:47:35 +0000
Date: Tue, 2 Sep 2025 20:47:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH v2] btrfs: don't allow adding block device of less than 1
 MB
Message-ID: <20250902184733.GG5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250902103421.19479-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902103421.19479-1-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Tue, Sep 02, 2025 at 11:34:10AM +0100, Mark Harmstone wrote:
> Commit 15ae0410 in btrfs-progs inadvertently changed it so that if the

Please use full reference to commits, like 15ae0410c37a79 ("btrfs-progs:
add error handling for device_get_partition_size_fd_stat()").

