Return-Path: <linux-btrfs+bounces-2947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE57186D3DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 21:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F7C283E97
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 20:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C611428E7;
	Thu, 29 Feb 2024 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LN1JPu5U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QNgPSP5T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LN1JPu5U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QNgPSP5T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D813F437
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236850; cv=none; b=FIusvXy/Ux3pYbrFWCijkjQ380ws6cqH4YE5jDsoHt5XPZnaNj0a7+dOVPkWSifIBze+4VMRZqIN7bYCs3lipUKN7n4TYVHZtoAqRyOBrFVkU2rR57cOEK/YcSOPEHyZ7WdjEOyeFBN2CzIzso5X9k4kWfxi6rHizRtu2xWAWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236850; c=relaxed/simple;
	bh=/S1YsnhyD/A7wWLrvnRTmyjYbdxqsidKYiwpk4QlxXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dvgf5gaHjY+/QhYdrrvz0GjXdR6kvT6g4k6cY2iEP3etqODqB6w7It30or33ZE5YRM4//CNs8OmpKUi5sjPS4OksVafnS5fzJDVAkHivQzzJIQ3eWmVSrq8Q2UuhOhs933F49ggX8Z1kCghlLkycNdUWz3c/EZjbDkynuuT344w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LN1JPu5U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QNgPSP5T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LN1JPu5U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QNgPSP5T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF3EC1F807;
	Thu, 29 Feb 2024 20:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709236846;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sR3D3UnF6Nm9Kq0n0gzy4p50dU9kLesvB9dW4gpSy9g=;
	b=LN1JPu5UejwXv78hT+ExNJ1y4NwAeCs8N60p83bGOGx00zUs22WCHgng291Rb0fO5VdPFa
	ZJUFt1N38Olkru1YN+K+dUzMECZYTyv+M0QI4Nh1ZNa4jTH3l2Pp6TdICuwRMXnFg4MWgN
	BipsEskW5lWYZ+WwMj4UBDTk4a1aIgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709236846;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sR3D3UnF6Nm9Kq0n0gzy4p50dU9kLesvB9dW4gpSy9g=;
	b=QNgPSP5TiNEXfjxQQ2eHlIHOSsYx8mXqkRT5O0q8CC7JLNNNRlDsJVuLNqZuLCheMWTlIR
	Pm4ZheQA3nMO0nAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709236846;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sR3D3UnF6Nm9Kq0n0gzy4p50dU9kLesvB9dW4gpSy9g=;
	b=LN1JPu5UejwXv78hT+ExNJ1y4NwAeCs8N60p83bGOGx00zUs22WCHgng291Rb0fO5VdPFa
	ZJUFt1N38Olkru1YN+K+dUzMECZYTyv+M0QI4Nh1ZNa4jTH3l2Pp6TdICuwRMXnFg4MWgN
	BipsEskW5lWYZ+WwMj4UBDTk4a1aIgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709236846;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sR3D3UnF6Nm9Kq0n0gzy4p50dU9kLesvB9dW4gpSy9g=;
	b=QNgPSP5TiNEXfjxQQ2eHlIHOSsYx8mXqkRT5O0q8CC7JLNNNRlDsJVuLNqZuLCheMWTlIR
	Pm4ZheQA3nMO0nAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ABA913451;
	Thu, 29 Feb 2024 20:00:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id R32vIW7i4GWEfwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 29 Feb 2024 20:00:46 +0000
Date: Thu, 29 Feb 2024 20:53:39 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs-progs: add udev rule to forget removed device
Message-ID: <20240229195339.GF2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1709231441.git.boris@bur.io>
 <80545243dec10a48562bf8a9b5d10b8ba6f16983.1709231441.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80545243dec10a48562bf8a9b5d10b8ba6f16983.1709231441.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu, Feb 29, 2024 at 10:36:55AM -0800, Boris Burkov wrote:
> Now that btrfs supports forgetting devices that don't exist, we can add
> a udev rule to take advantage of that. This avoids bad edge cases
> with cached devices in multi-device filesystems without having to rescan
> all the devices on every change.
> 
> Signed-of-by: Boris Burkov <boris@bur.io>
> ---
>  64-btrfs-rm.rules | 7 +++++++
>  Makefile          | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>  create mode 100644 64-btrfs-rm.rules
> 
> diff --git a/64-btrfs-rm.rules b/64-btrfs-rm.rules
> new file mode 100644
> index 000000000..852155d28
> --- /dev/null
> +++ b/64-btrfs-rm.rules
> @@ -0,0 +1,7 @@

Please add a comment that explains when and why this udev rule should be
used.

> +SUBSYSTEM!="block", GOTO="btrfs_rm_end"
> +ACTION!="remove", GOTO="btrfs_rm_end"
> +ENV{ID_FS_TYPE}!="btrfs", GOTO="btrfs_rm_end"
> +
> +RUN+="/usr/local/bin/btrfs device scan -u $devnode"

Is the full path mandatory or is 'btrfs' sufficient? I think systemd
uses own tool of the same name.

Please use long option name so it's more obvious what it does.

