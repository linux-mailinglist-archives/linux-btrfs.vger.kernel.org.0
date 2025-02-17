Return-Path: <linux-btrfs+bounces-11512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24298A38984
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 17:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D98167006
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB811225773;
	Mon, 17 Feb 2025 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KjQE0xzd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MKOrAcig";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KjQE0xzd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MKOrAcig"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6252A225771
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810289; cv=none; b=qSwfnkIDQDZ1RKzIKuhXR1pSMqV3Nx3nEW4FytwAKhFCmDeKUVW0KdI2KM9orOF1yZ1ORVnWA7tvzjUOcFlGyxP1itcEUA1k6cRmz0sUuClPA2lLQzbXCld4eVmcfWRuZrhnRn7Qv+dDPP/cCIAzoglSbVn5UjmWHv9spjivyvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810289; c=relaxed/simple;
	bh=ON8Mz4JcIZGTaXFj/e5sTzYLhvfpnBjKEoQV5nvQ88g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxmar8XguDSqzA67UNjaY6+kfps6juyuQV9HOoE6Ew9sKfZdWO3bdUKDYnnfuHn9ClKUEW9wbWvU/awO7tCj3CoWgl8HzAM/LS09lFfzeOPhkIPBIQDAScoRhkPE7nPM4NYFlCtXcON4g1NUjbzHsRB09EnvhfvhmgnZdNYKyoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KjQE0xzd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MKOrAcig; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KjQE0xzd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MKOrAcig; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F76D1F451;
	Mon, 17 Feb 2025 16:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739810284;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OD3m8VqjvvAZwXlG+uiAwCrgAIkgOYNa2ONHeK/G/JM=;
	b=KjQE0xzdSFWGU7w4dH502I009EvLEnjJgkoMgXheJxynUqLnC7OcvKLIQTbMXUJr0ecEKi
	Vf87fMlZ3PBzBe+F2U89v36ekcglfoCs2rjCKB/0ekNeJwpMi062NpcTLZzY4YET9/w5xs
	8wD4ZfApblZXRYV4pG1RORDJUWPtoso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739810284;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OD3m8VqjvvAZwXlG+uiAwCrgAIkgOYNa2ONHeK/G/JM=;
	b=MKOrAcig0tfHCCJc54GUnImB6FV5KlNqbyTdc6d+BB3BWNBO0gGCMBdn5jxnafmnLRPtdt
	3BpfUY7ZIM4kR1BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KjQE0xzd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MKOrAcig
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739810284;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OD3m8VqjvvAZwXlG+uiAwCrgAIkgOYNa2ONHeK/G/JM=;
	b=KjQE0xzdSFWGU7w4dH502I009EvLEnjJgkoMgXheJxynUqLnC7OcvKLIQTbMXUJr0ecEKi
	Vf87fMlZ3PBzBe+F2U89v36ekcglfoCs2rjCKB/0ekNeJwpMi062NpcTLZzY4YET9/w5xs
	8wD4ZfApblZXRYV4pG1RORDJUWPtoso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739810284;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OD3m8VqjvvAZwXlG+uiAwCrgAIkgOYNa2ONHeK/G/JM=;
	b=MKOrAcig0tfHCCJc54GUnImB6FV5KlNqbyTdc6d+BB3BWNBO0gGCMBdn5jxnafmnLRPtdt
	3BpfUY7ZIM4kR1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 203D71379D;
	Mon, 17 Feb 2025 16:38:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nGSdB+xls2cEUQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 17 Feb 2025 16:38:04 +0000
Date: Mon, 17 Feb 2025 17:37:58 +0100
From: David Sterba <dsterba@suse.cz>
To: Racz Zoltan <racz.zoli@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: add duration format to fmt_print
Message-ID: <20250217163758.GE5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250211232918.153958-1-racz.zoli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211232918.153958-1-racz.zoli@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 2F76D1F451
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Feb 12, 2025 at 01:29:18AM +0200, Racz Zoltan wrote:
> Added "duration" format in seconds to fmt_print which will convert the
> input to one of the following strings:
> 
> 1. if number of seconds represents more than one day, the output will be 
> for example: "1 days, 01:30:00" (left the plural so parsing back the
> string is easier)
> 2. if less then a day: "23:30:10"

Added to devel, thanks.

