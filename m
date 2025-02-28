Return-Path: <linux-btrfs+bounces-11936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A84A499A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 13:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D063AA683
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A6E26B2CB;
	Fri, 28 Feb 2025 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kz7KTaQK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iKv9Kjuf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JYLzVoeG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="suGXf/66"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8159126B2C2
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746528; cv=none; b=jdUGKOte7FmGltlw1qQQ9bpsiL9HTQsNp/yAWSHWIJvOffxXVRyxp627rlLKiBfcdBHotKoO2GpKUt/zyW/ZxXjcr/JH8hBvE6fgXW+1IBIiYfO9C4FCH0jQ3CEVJPmIhLQbJiKdBBOx+j5HiKDCJ//mOnQLU2GUbcIq3tq/C/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746528; c=relaxed/simple;
	bh=FJhJIqYXRzMxrRiyzAoUAJGS3816EeeeutjSBf/Dzrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCPeSmZpyic60fScl2tusXgnNGdIVrQZ8v65ObVfzAADL4I5fpZ2WjmC8/QcW6kYeD02WNhkWRH+JPGxpPwWiw+x6ScsNOg6pEu2MJfkfQgh9qrBcnfr9AZ/E9vow+9QleiviIHXTUWOgcWNPt9ZTahf+niNPzL7kf+J2tLVX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kz7KTaQK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iKv9Kjuf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JYLzVoeG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=suGXf/66; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9377C2118E;
	Fri, 28 Feb 2025 12:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740746524;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21JVWN42FAqhV9ISu/lJ/b2NFrsbqtON0gReqhBkRnE=;
	b=Kz7KTaQK+SBFISNO3KMmFiG12zYNf6kjSb0I02RNYBe9JruoDNSVP/0ti5URF7C1AUX08p
	tpCYs/I9x8AkAlcOWtoH6N1Vdp75K+LKkRQ2Uz/+MZb7TyS6wuUT7iBjW+C7IX7FvgwtHw
	JU+97Tpjm6P3SBVF9pKUfMPy8860mY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740746524;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21JVWN42FAqhV9ISu/lJ/b2NFrsbqtON0gReqhBkRnE=;
	b=iKv9Kjuf2ekIlgszEy6CdTJjRLAbkos5v2lDUZxCA1DhDQtMTxQokEQllbwKNCNEkKx1dC
	eQ4XCMSQZp+zFQBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740746523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21JVWN42FAqhV9ISu/lJ/b2NFrsbqtON0gReqhBkRnE=;
	b=JYLzVoeGK9K5VJz369OqdFC4/VE6XtFCYEbxfdbaOsFA449mI5AnEanzOYYPMR5YvbJMcb
	2CD8JebIGwmIo3XnxPMtpkpDlDRztt1IGCNpGDCEHbrqXHTqMcNeavYOGA1jl/6XFvlWvD
	PZJOvvZ48/G2DH8jpxCnBoVMV0wpKQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740746523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21JVWN42FAqhV9ISu/lJ/b2NFrsbqtON0gReqhBkRnE=;
	b=suGXf/66lcMs+eYTwlC0cRg4BumjiZvrkkN2T7PHEASSaEB8nY6FlhCVU7WRHvq0qlkbHW
	nCwQD1wJ4M4mbKCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79E62137AC;
	Fri, 28 Feb 2025 12:42:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d9yJHRuvwWckEQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 28 Feb 2025 12:42:03 +0000
Date: Fri, 28 Feb 2025 13:42:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/8] btrfs: make subpage handling be feature full
Message-ID: <20250228124202.GF5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740635497.git.wqu@suse.com>
 <20250227111603.GB5777@twin.jikos.cz>
 <ffd5ebe0-541c-4d21-b7dd-f0bbe29c8200@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd5ebe0-541c-4d21-b7dd-f0bbe29c8200@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Feb 28, 2025 at 01:44:04PM +1030, Qu Wenruo wrote:
> For the 2K one, since it's just two small patches I'm also fine pushing 
> them now.
> Just do not forget that we need progs patches, and a dozen of known 
> failures from fstests, and I'm not yet able to address them all any time 
> soon.

Yeah, the mkfs support can go to the next minor progs release. About the
status we can print a warning and document it. No need to focus on
fixing the fstests, I think stress testing will be sufficient for now.

