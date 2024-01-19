Return-Path: <linux-btrfs+bounces-1570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC18832BFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 15:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CB728713C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DFA54F9F;
	Fri, 19 Jan 2024 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XEFCvbxU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+rOTPb5U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XEFCvbxU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+rOTPb5U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B3E54662
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jan 2024 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676229; cv=none; b=DUbXQJuITRXi4CkEW9YL+J2W0pYdVSRsIlfdWzl3zUcGQvodgBeiU4FJDmPhd9apq65i6qmqqVB9XXsQDKV6ln5IqXnis37bYxlMY7tYmlaKJaxClclf4xTKX/QJbOLNJDl4VGN/0lcUu3Ti8BQjjFjFT6N9bv8eFodJmWHXgCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676229; c=relaxed/simple;
	bh=Y4BPMtpGnkjYUVZX/2ctUhn3W5NMRFndn/C4CH8pNFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtP82QpGY9RWc5EJhMvJglNO4m05wfaWA1TJeooIqVc446Atctikh+1TI6/pReD+mTXr/2pHnQrZ7/9+JyzmvbWteHWwfTD+3+NzSBe2lYdfloURsUuEuUZhF9ZppgNZ2t4fP4fN8Y7QaNGnc3iE1WUHq0qctng6Rc8aTokmitU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XEFCvbxU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+rOTPb5U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XEFCvbxU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+rOTPb5U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40A7221FF5;
	Fri, 19 Jan 2024 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705676226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lutmGpehWyCxk6FHUKB66F4gG8+6u+ayJPk5RRmmdrk=;
	b=XEFCvbxUQp1R7rCTCGtODaWP7jn8mhthL7RytuO6n1C2uuAKNSUvHbx2EniRE82Srs8ad3
	3eko8bKXOfG+ieF0lSgT3HpR9tEqN5HuQ3DflTrA5gvP0DCD5QJuji3Tuvq6Qz19XRqO8y
	YDSc6WhYfz5/mXAzKWLuO4W4/G9the4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705676226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lutmGpehWyCxk6FHUKB66F4gG8+6u+ayJPk5RRmmdrk=;
	b=+rOTPb5ULDwH+x7vnR7VsSCh8tbXA+QBurvTRKqoiwLIn1WjwAG2zTlDySAqvripGmXm1x
	XGtknTR7irA4GrDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705676226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lutmGpehWyCxk6FHUKB66F4gG8+6u+ayJPk5RRmmdrk=;
	b=XEFCvbxUQp1R7rCTCGtODaWP7jn8mhthL7RytuO6n1C2uuAKNSUvHbx2EniRE82Srs8ad3
	3eko8bKXOfG+ieF0lSgT3HpR9tEqN5HuQ3DflTrA5gvP0DCD5QJuji3Tuvq6Qz19XRqO8y
	YDSc6WhYfz5/mXAzKWLuO4W4/G9the4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705676226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lutmGpehWyCxk6FHUKB66F4gG8+6u+ayJPk5RRmmdrk=;
	b=+rOTPb5ULDwH+x7vnR7VsSCh8tbXA+QBurvTRKqoiwLIn1WjwAG2zTlDySAqvripGmXm1x
	XGtknTR7irA4GrDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B632A133DC;
	Fri, 19 Jan 2024 14:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oIgrJMGNqmVoAwAAn2gu4w
	(envelope-from <rgoldwyn@suse.de>); Fri, 19 Jan 2024 14:57:05 +0000
Date: Fri, 19 Jan 2024 08:58:20 -0600
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Re: [PATCH 1/4] btrfs: Use IS_ERR() instead of checking folio
 for NULL
Message-ID: <o64k3ptjlbwese6egw7vt4gso4jwdxvbnytuelkyfopzro7hpk@dhpwg7v2tfdx>
References: <cover.1705605787.git.rgoldwyn@suse.com>
 <e4df9a1068c81f3edeee9bbb4e63d1d453be569b.1705605787.git.rgoldwyn@suse.com>
 <20240119145312.GR31555@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119145312.GR31555@twin.jikos.cz>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XEFCvbxU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+rOTPb5U
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.43)[78.47%]
X-Spam-Score: -1.44
X-Rspamd-Queue-Id: 40A7221FF5
X-Spam-Flag: NO

On 15:53 19/01, David Sterba wrote:
> On Thu, Jan 18, 2024 at 01:46:37PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > __filemap_get_folio() returns an error instead of a NULL pointer. Use
> > IS_ERR() to check if folio is not returned.
> > 
> > As we are fixing this, use set_folio_extent_mapped() instead of
> > set_page_extent_mapped().
> > 
> > Fixes: f8809b1f6a3e btrfs: page to folio conversion in btrfs_truncate_block()
> 
> This is still in for-next so the fixup should be squashed there.

Oh cool. However, this would have to be put after Matthew's patch of
changing set_page_extent_mapped().

-- 
Goldwyn

