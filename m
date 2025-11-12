Return-Path: <linux-btrfs+bounces-18886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E400C50BF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 07:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9283B8A8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 06:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5252DCF46;
	Wed, 12 Nov 2025 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VVr097cp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jULacbEY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VVr097cp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jULacbEY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2C23D7D7
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929641; cv=none; b=Fd5xPyVni0itghUUVkdiKbszLS6CLuOWd0E95bZ9+B2gYY0kCONgaVbCwyZmzP5UFK9alHpWOTpIvlvolncTGr37Gp8ghSNvEiZgV+dTcI2qAOaj1++S8dz0YYvxneZjLKQ5uligBvhfdgQV28GoLlLir1kgO6CjYdX07Z4qX+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929641; c=relaxed/simple;
	bh=0Eu5Z+mkXpXsl4ANGCWF9akp//wz0GSuCKo+K9GVP0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqoKvbmKTyrO5AjGHyxrvi4ZByEyTXbwjeP1Fl62GpEdhPpPuohTeFTxJSpIOVvnqRMdc7pqPFub4T8DRLkOHTuVYcSQlLg1oNrKpcatR/k3+N2YHV/S1s+3W6vrDmfFd7gUfWWdOxE03a2UOy8HrzpDNLJ9VV0hjrFVuf4sWAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VVr097cp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jULacbEY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VVr097cp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jULacbEY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CC2E1F388;
	Wed, 12 Nov 2025 06:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762929637;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jBfWtJB/9+F1D6vi0fBe+HKMmcolHTRwNvl7J1cn5Hg=;
	b=VVr097cpWw5IcVMU+gMp4s3tEhJbLz9rDdQlvHAMJlMYiDB1o/ObPayfXtQQp7shS8jDum
	UOLh1682MDIDIVWpmCnffZtJJdWOA0OGnloHTh/QCGxLygcA+puwAZYhWacZKbZ+J4mH2Y
	a8Ivc3g4wkF/4L7PpqdwpiI0k7e8W64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762929637;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jBfWtJB/9+F1D6vi0fBe+HKMmcolHTRwNvl7J1cn5Hg=;
	b=jULacbEYJK6GEU4fD8svTEoMgoiaFhML5t3yyoqf6sPod+m6c0RYVQX307OINDvbB7RCy7
	4ldh2hzB8m8alOCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762929637;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jBfWtJB/9+F1D6vi0fBe+HKMmcolHTRwNvl7J1cn5Hg=;
	b=VVr097cpWw5IcVMU+gMp4s3tEhJbLz9rDdQlvHAMJlMYiDB1o/ObPayfXtQQp7shS8jDum
	UOLh1682MDIDIVWpmCnffZtJJdWOA0OGnloHTh/QCGxLygcA+puwAZYhWacZKbZ+J4mH2Y
	a8Ivc3g4wkF/4L7PpqdwpiI0k7e8W64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762929637;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jBfWtJB/9+F1D6vi0fBe+HKMmcolHTRwNvl7J1cn5Hg=;
	b=jULacbEYJK6GEU4fD8svTEoMgoiaFhML5t3yyoqf6sPod+m6c0RYVQX307OINDvbB7RCy7
	4ldh2hzB8m8alOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 605A814DA8;
	Wed, 12 Nov 2025 06:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HmdeF+UrFGm6WgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Nov 2025 06:40:37 +0000
Date: Wed, 12 Nov 2025 07:40:28 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: trivial BTRFS_PATH_AUTO_FREE conversions for tests
Message-ID: <20251112064028.GB13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251007033603.13858-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007033603.13858-1-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Tue, Oct 07, 2025 at 11:35:12AM +0800, Sun YangKai wrote:
> Trivial pattern for the auto freeing. No other function cleanup.
> 
> The following cases are considered trivial in this patch:
> 
> 1. Cases where there are no operations between btrfs_free_path() and the
>    function return.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>

Added to for-next, thanks.

