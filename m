Return-Path: <linux-btrfs+bounces-11298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB16A2982F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 18:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2A53A91D4
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 17:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B11FC0EE;
	Wed,  5 Feb 2025 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wLzNcHXW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y/1g+UDp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aJB6iszQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="98eNYB7Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E590C1519AD
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778299; cv=none; b=Juph1SvxqWsqgFhIgn23XEzkeBrFgDmV+3ZpggCpdKq7fQmCrivzcGpyCPqe0YK+dEX1dNyZ5XxCvnNZsGIWhn1uUJYzffjbkF21v+zkWw7n4n3ktQ/4jgVI6tltvNR0asMIsFcq6HMCQQ1s5gG+sqvnqoqOuPdwHdH7ak+CPWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778299; c=relaxed/simple;
	bh=T2RPe+yyonqhvadMX/kUIZqsoTLgsK3RT19qF1mpss0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMnCkES7D8VbhHx5H2rhAnpjCHY5OOPLxD1tvVExSvy4SZUuc3WAYAc9g+fVsr5xA0kEH0DkrwfEhyrLtnH36jk5Et/6Bep8Y5ePb3lGdHq4qeIO4Kjr4cj2lH7cuXm/095T1N1GnrJPQ44ly9G4xDZYQcZNYkgrl30V98+QeI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wLzNcHXW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y/1g+UDp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aJB6iszQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=98eNYB7Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD8B11F397;
	Wed,  5 Feb 2025 17:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738778296;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5rTqxH0o37vBYWOqaBeWNVBi3NSUOuejNCrbh8iUSck=;
	b=wLzNcHXW0tYYQWHyovjTs4EDSSgx/Tq6/1qmTIXiMI+A+W82+V5p5HSLJA/J5JMK1iuSqw
	Y0uvKh29hIbFFGNc9vIDCS3G6cMbs7ANs2M8ahrFj9O1D1X3EzbbiVqOR3aWJ6aKDprSWM
	gytgtfKVof5nAg3PUH8efwhwNenhCFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738778296;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5rTqxH0o37vBYWOqaBeWNVBi3NSUOuejNCrbh8iUSck=;
	b=Y/1g+UDpZ3LSq2bEikIXgsiq2TH46WPdWYrPae2POoiw+dzdlD1NqG6JuV7Scouy2fNjNU
	0AXmUYbt7b9vaACg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738778295;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5rTqxH0o37vBYWOqaBeWNVBi3NSUOuejNCrbh8iUSck=;
	b=aJB6iszQRA8y/hcah3o0o08NEYOEBdUTefEeAP+wHI0xIXlURa6PwGJjK38bXYwf2l9MTC
	HYC//+O/szsI+uEmDsrj8itIwhSViPj0avrmTqiLfpWt/fe9EqiyUHfHEzbA+okBWc+jAH
	5j5R8qv52WO5qm9OKHDMtLA11nHwdbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738778295;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5rTqxH0o37vBYWOqaBeWNVBi3NSUOuejNCrbh8iUSck=;
	b=98eNYB7QmHfDxT5DnBqGJ1PPaKCATJ2uzwjAtOgEkuJljuxUqY6WJ7IVb01U88TeVW3xjg
	cxbOGELu8U1XBnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7C2613694;
	Wed,  5 Feb 2025 17:58:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id temsL7emo2cfUQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Feb 2025 17:58:15 +0000
Date: Wed, 5 Feb 2025 18:58:10 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v2] btrfs: sysfs: accept size suffixes for read policy
 values
Message-ID: <20250205175810.GK5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8f77c6490a181cb0bb16c6b11131723e46c41108.1737566842.git.anand.jain@oracle.com>
 <3c4582c2ab0ac2537ab70bce3ac3270f81468139.1738163840.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c4582c2ab0ac2537ab70bce3ac3270f81468139.1738163840.git.anand.jain@oracle.com>
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
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Jan 29, 2025 at 11:21:46PM +0800, Anand Jain wrote:
> We now parse human-friendly size values (e.g. '1G', '2M') when setting
> read policies.
> 
> Suggested-by: David Sterba <dsterba@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

v2 is ok, for simple updates like adding a comment you don't need to
resend it. Please add the patch to for-next, thanks.

