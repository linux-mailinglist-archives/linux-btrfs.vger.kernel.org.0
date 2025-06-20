Return-Path: <linux-btrfs+bounces-14827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54C1AE2057
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA2E6A0686
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C3F2E6128;
	Fri, 20 Jun 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j9CY1BJL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uWgwT7Ag";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j9CY1BJL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uWgwT7Ag"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C88136988
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750437979; cv=none; b=Od65DYyXGxOLMZCsPcCZYo/A4E36idgPEUUq3bJ5ujVRTaR2ApotmjSea/YFrxffXPxwmwPP19tpkagiNBz73l/ef/Ec2xOvgKlMhOSzBIBeU9eZUm1nUvLIBcQCFz6jALdsnmb8bBHWOSYKoYYcBpaQEODXOzXNegW6PDfr28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750437979; c=relaxed/simple;
	bh=TJtoXD+7H9F+5SNwieW+1buWsCXLUKszkBbDrcZWSiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jdxq0bbHaoJH+Xk3102EU0CnmNHU/BPzGKvzuObWYeAP1q7881GBMi+AqJPM5ddX9dOBRVcjBxZT2S9fWzSW4UVAiPvxMPDmh9rPSYJDPX9YJb5oVIGEogrK/kBOQnL8dwHNgR5lPtJxCdJZe99+9aMt4Akfu5ejFEwXuwLIeDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j9CY1BJL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uWgwT7Ag; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j9CY1BJL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uWgwT7Ag; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44D4E1F841;
	Fri, 20 Jun 2025 16:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750437975;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gobm5rwIvQOZ0vOYD+rBYmas8ItCnKaolRz5IrUrUTo=;
	b=j9CY1BJLPKg7IIFVJPM8zHuz2ayookKlGpduAAr6cbeff95XYlamD+vjf5kN6LpQhPIFps
	60YkclgOatkcRu0kh4ds6ljwbDdNllk89lzvXNv6DqXCpkoa62Xl6LGdD9JpbkW1iZ/cdl
	hlBEZ3wfeCY43OdfQTDelWfWEBw0eA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750437975;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gobm5rwIvQOZ0vOYD+rBYmas8ItCnKaolRz5IrUrUTo=;
	b=uWgwT7AgaVIK6NyRqxF+hVuCGT/P1NGiFRDSF+rmp+5b6KTXiMhbJmKlJYUokDtCfvJ8W4
	gkzUg5v/VNZueLCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750437975;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gobm5rwIvQOZ0vOYD+rBYmas8ItCnKaolRz5IrUrUTo=;
	b=j9CY1BJLPKg7IIFVJPM8zHuz2ayookKlGpduAAr6cbeff95XYlamD+vjf5kN6LpQhPIFps
	60YkclgOatkcRu0kh4ds6ljwbDdNllk89lzvXNv6DqXCpkoa62Xl6LGdD9JpbkW1iZ/cdl
	hlBEZ3wfeCY43OdfQTDelWfWEBw0eA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750437975;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gobm5rwIvQOZ0vOYD+rBYmas8ItCnKaolRz5IrUrUTo=;
	b=uWgwT7AgaVIK6NyRqxF+hVuCGT/P1NGiFRDSF+rmp+5b6KTXiMhbJmKlJYUokDtCfvJ8W4
	gkzUg5v/VNZueLCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 370F2136BA;
	Fri, 20 Jun 2025 16:46:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hY0+DVeQVWg7dgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 16:46:15 +0000
Date: Fri, 20 Jun 2025 18:46:10 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 00/14] btrfs-progs: add support for device role-based
 chunk allocation
Message-ID: <20250620164609.GA4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1747070450.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, May 13, 2025 at 02:09:17AM +0800, Anand Jain wrote:
> Adds cleanup, fixes, and device role support to enable more efficient
> kernel chunk allocation based on device perforamnce.
> 
> Anand Jain (14):
>   btrfs-progs: minor spelling correction in the list-chunk help text
>   btrfs-progs: refactor devid comparison function
>   btrfs-progs: rename local dev_list to devices in btrfs_alloc_chunk

I've taken the 3 patches to progs as they seem to be standalone fixes.
Thanks.

