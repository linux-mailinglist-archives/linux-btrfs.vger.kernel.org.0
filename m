Return-Path: <linux-btrfs+bounces-13222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ABBA9681C
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 13:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D083A71CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 11:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA3F27BF7D;
	Tue, 22 Apr 2025 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zdWqEfYl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sIm8ITGf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zdWqEfYl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sIm8ITGf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781EC265619
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322488; cv=none; b=kb/MIVnnEEOZndRP+rgAbiLryar2QeqpJOZeZTRWeQjr9vpo2HmoIHeaLXei9dlU0HC2ENeqNV011mfN3qzXHKZL/KE39sU1B2+uL+dCmQiRFNCehp2f+0aqI/b4gDv11sjmQXJNnxCRlZCXGZCAcJ8NsX94eq61xEmEY2v/aqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322488; c=relaxed/simple;
	bh=mLZAKTqsts6ksQsJg0bZxf24qseksmOq76jaz9P1iSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhB2mEz408USdPPRL8WIsIUXk05JvagiB0Wxt0JTPCqNcB47lyP2mDzuYc1HM0LXHQCtfTNmlaJhwIQZ/vdU5f+d5W5W/bbwhBhv1e7T54x4uq1HQgXbTk19vRCKnWnMU4CPPnqlM73LiccJycw3KiQtb/mF/Qh/EPBwiZ8WSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zdWqEfYl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sIm8ITGf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zdWqEfYl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sIm8ITGf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A35911F444;
	Tue, 22 Apr 2025 11:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745322484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UfksERo9eAsGQoLVLLr8XDEAn6ivMS9N1uZBVtsk3s4=;
	b=zdWqEfYlVoTC3aAZu2dAi+TfzxCki3KwIlKaMyDFb38rCk+G275ZTOhTFpcQcAZymYmfBU
	UwIWEGproE1zY22GPLGg40kewOS4epddjYfIGl/CZbHZlGtHeGj7BoIQM62f7NHWOJOpmu
	RBNM8Fhpi+gtZrtu75g4ghaL7b4UDBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745322484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UfksERo9eAsGQoLVLLr8XDEAn6ivMS9N1uZBVtsk3s4=;
	b=sIm8ITGfyw1GQ5IKjWInxDZvKUoOB46M+WgQ1SniYHWp8/zTxVVE3efe7NNFEj+jqjc72R
	aX03dX10wG7pKIBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745322484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UfksERo9eAsGQoLVLLr8XDEAn6ivMS9N1uZBVtsk3s4=;
	b=zdWqEfYlVoTC3aAZu2dAi+TfzxCki3KwIlKaMyDFb38rCk+G275ZTOhTFpcQcAZymYmfBU
	UwIWEGproE1zY22GPLGg40kewOS4epddjYfIGl/CZbHZlGtHeGj7BoIQM62f7NHWOJOpmu
	RBNM8Fhpi+gtZrtu75g4ghaL7b4UDBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745322484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UfksERo9eAsGQoLVLLr8XDEAn6ivMS9N1uZBVtsk3s4=;
	b=sIm8ITGfyw1GQ5IKjWInxDZvKUoOB46M+WgQ1SniYHWp8/zTxVVE3efe7NNFEj+jqjc72R
	aX03dX10wG7pKIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ECCA139D5;
	Tue, 22 Apr 2025 11:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NBemIvSBB2iIEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 22 Apr 2025 11:48:04 +0000
Date: Tue, 22 Apr 2025 13:48:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: remove BTRFS_REF_LAST from btrfs_ref_type
Message-ID: <20250422114803.GD3659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250417142655.1284388-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417142655.1284388-1-frank.li@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Apr 17, 2025 at 08:26:49AM -0600, Yangtao Li wrote:
> Commit b28b1f0ce44c ("btrfs: delayed-ref: Introduce better documented
> delayed ref structures") introduced BTRFS_REF_LAST, which can be used
> for sanity checking.
> 
> In btrfs_ref_type() there was an assertion
> 
> ASSERT(ref->type == BTRFS_REF_DATA || ref->type == BTRFS_REF_METADATA);
> 
> to validate the value. 
> 
> And there is currently no enum or switch to use the upper limit,
> so let's remove it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Added to for-next, thanks.

