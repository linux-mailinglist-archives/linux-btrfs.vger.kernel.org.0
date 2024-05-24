Return-Path: <linux-btrfs+bounces-5277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B228CE5DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 15:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15947282CA1
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 13:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA3286653;
	Fri, 24 May 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qQgmsZB/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zFgnCcia";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qQgmsZB/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zFgnCcia"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB586244;
	Fri, 24 May 2024 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556647; cv=none; b=Nn03cuakvRlq8Nz+jZE117MXwwcz2tw6/kUay5Ne/mKTPb9BAx8lRScaql8+lbqpqESfHYGiwEnvo3UZbHOD0S1PhdL5GTzeEwPXTxxuY2Az1D83EHnmU4z5tt9OGlyF/W1oWWTDdbARdNluZ/QGIVk6LAl+NMI1gmbE7iQB/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556647; c=relaxed/simple;
	bh=w1LplXt5/wwVym29hab3Ep1sdjD4gzGLr0YOFrBl+tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8izrYbPf8Lg0Asy7EpSKpNDkMn/+iqOB1QeJ+yM/UkuESfNvyX7oDXHswSjtV6zef+VbmZcLJmHhO2ntO3pMm8s8fKxekit0OjcZSo6TYt+613iY06aaD+3ot/Hbsga3hcuneDD6xWh/ras4REOIk0dc6O4n0eZIdBJy/W/s8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qQgmsZB/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zFgnCcia; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qQgmsZB/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zFgnCcia; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5796F33B10;
	Fri, 24 May 2024 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716556643;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFNuBkWYv8NttJ9gQsgvZWInMRuqHrxj0Iy7J9akBxY=;
	b=qQgmsZB/sQrnkWEaL76ugHXKmywDEy1N4+I0wONG9Kaov7wmRjF94jSEG6jMD3CY85zveU
	ylhu6i481Z6Rpzneo5HyMBi6Ho978Zw/PY3TkHh7Q5FLK/ZOzT+2dI0UI7vj8hLmoKG7eX
	X5yaHXPV5xgyITPhF5t1dm/eRErSb2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716556643;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFNuBkWYv8NttJ9gQsgvZWInMRuqHrxj0Iy7J9akBxY=;
	b=zFgnCciaglXjV+GSXLP6/9hF1HxHI581itx6pM08nGFvdsD8Gh5eZZE6FGd31eV9vHj5Ba
	M3bq9FiZRmxtkrBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716556643;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFNuBkWYv8NttJ9gQsgvZWInMRuqHrxj0Iy7J9akBxY=;
	b=qQgmsZB/sQrnkWEaL76ugHXKmywDEy1N4+I0wONG9Kaov7wmRjF94jSEG6jMD3CY85zveU
	ylhu6i481Z6Rpzneo5HyMBi6Ho978Zw/PY3TkHh7Q5FLK/ZOzT+2dI0UI7vj8hLmoKG7eX
	X5yaHXPV5xgyITPhF5t1dm/eRErSb2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716556643;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFNuBkWYv8NttJ9gQsgvZWInMRuqHrxj0Iy7J9akBxY=;
	b=zFgnCciaglXjV+GSXLP6/9hF1HxHI581itx6pM08nGFvdsD8Gh5eZZE6FGd31eV9vHj5Ba
	M3bq9FiZRmxtkrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B53713A3D;
	Fri, 24 May 2024 13:17:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mME+EmOTUGbZMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 24 May 2024 13:17:23 +0000
Date: Fri, 24 May 2024 15:17:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/741: add commit ID in _fixed_by_kernel_commit
Message-ID: <20240524131722.GH17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5cc75a8832418894235ad69d0c6e349e899f0c6b.1716524713.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cc75a8832418894235ad69d0c6e349e899f0c6b.1716524713.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]

On Fri, May 24, 2024 at 12:26:59PM +0800, Anand Jain wrote:
> Now that the kernel patch is merged in v6.9, replace the placeholder with
> the actual commit ID.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: David Sterba <dsterba@suse.com>

