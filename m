Return-Path: <linux-btrfs+bounces-15165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DDCAEFD70
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 805FA7B0D08
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A365C27A469;
	Tue,  1 Jul 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b9RJrq9+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jW90b9qG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b9RJrq9+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jW90b9qG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F127933A
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381760; cv=none; b=Q/PUMlHyeRamB9NtJr6ZUxHQp3SxUCo9EZ9PhaY6s7OH67hi1815657MbAGq/sJ9d3WFhi24y9NQ/qsSStaAHMOuPUWYxaQzOrw06SsoQlU/65vQyl0N7tnGJ3udJSj43aHcvZz0bpTp411N9K6K7HZysnvtcFlvHpjy3rpsKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381760; c=relaxed/simple;
	bh=14969vE7oTvSxbIeUHQwNrXSIWKjWjIDgV2/5sQf9Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKLjxdEWJ7KJGdmVpzP5q9rGnWAjBCipjTRUG5+QtsntmP4mwcK8ytBIjejgpiH1eO934k6wg3P9yYF/oAYLljAdY1PVBEUZdLQdYSXWX4djiqkAXxt98SPBXBEbXUv86IiNyBTU4G87/+FAO52zrkxgbz4+l0oop63SNSYZKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b9RJrq9+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jW90b9qG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b9RJrq9+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jW90b9qG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B0E11F393;
	Tue,  1 Jul 2025 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751381756;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJwexxfuZ+LMIUqSldhmO0aXwQ4xqqJs+O+5myB5TpM=;
	b=b9RJrq9+T34cVkrnvNf/n9dXUx8P6sNRYPsnHMLCwYyhUrzzHBRQV7rk6CYgbWjbk8EUjD
	msn3S6LUKHRMx49jr3FswCTO6+2s9APJZqViHXw/pJ2DTxuhT9G6nI5cZsdiQHHrcNZczh
	eDFEQZBoAoLD0mx/7aptdl2Ov38uLho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751381756;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJwexxfuZ+LMIUqSldhmO0aXwQ4xqqJs+O+5myB5TpM=;
	b=jW90b9qGFbV8y1J1V/y2WoLG5jdU9VN01/vu4IxIZFNwcptQxzD8mnFam2TJFit8hwIC+4
	qyK3jD/HkWnmPdCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751381756;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJwexxfuZ+LMIUqSldhmO0aXwQ4xqqJs+O+5myB5TpM=;
	b=b9RJrq9+T34cVkrnvNf/n9dXUx8P6sNRYPsnHMLCwYyhUrzzHBRQV7rk6CYgbWjbk8EUjD
	msn3S6LUKHRMx49jr3FswCTO6+2s9APJZqViHXw/pJ2DTxuhT9G6nI5cZsdiQHHrcNZczh
	eDFEQZBoAoLD0mx/7aptdl2Ov38uLho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751381756;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJwexxfuZ+LMIUqSldhmO0aXwQ4xqqJs+O+5myB5TpM=;
	b=jW90b9qGFbV8y1J1V/y2WoLG5jdU9VN01/vu4IxIZFNwcptQxzD8mnFam2TJFit8hwIC+4
	qyK3jD/HkWnmPdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A0E313890;
	Tue,  1 Jul 2025 14:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H8eoGfz2Y2hmGQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 01 Jul 2025 14:55:56 +0000
Date: Tue, 1 Jul 2025 16:55:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Brahmajit Das <listout@listout.xyz>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, kees@kernel.org, ailiop@suse.com,
	mark@harmstone.com, David Sterba <dsterba@suse.cz>,
	Brahmajit Das <bdas@suse.de>
Subject: Re: [PATCH v4] btrfs: replace deprecated strcpy with strscpy
Message-ID: <20250701145551.GS31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250620164957.14922-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620164957.14922-1-listout@listout.xyz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Fri, Jun 20, 2025 at 10:19:57PM +0530, Brahmajit Das wrote:
> strcpy is deprecated due to lack of bounds checking. This patch replaces
> strcpy with strscpy, the recommended alternative for null terminated
> strings, to follow best practices.
> 
> There are instances where strscpy cannot be used such as where both the
> source and destination are character pointers. In that instance we can
> use sysfs_emit.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Suggested-by: Anthony Iliopoulos <ailiop@suse.com>
> Suggested-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Brahmajit Das <bdas@suse.de>
> ---
> 
> Changes in v2: using sysfs_emit instead of scnprintf.
> Changes in v3: Removed string.h in xattr, since we are not using any.
> fucntions from string.h and fixed length in memcpy in volumes.c
> Changes in v4: As suggested by David, moving "NONE" as initial value of
> buf in describe_relocation() and removed copying of "NONE" to bp in
> btrfs_describe_block_groups().

Sorry for the delay, added to for-next. Thanks.

