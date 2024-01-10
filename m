Return-Path: <linux-btrfs+bounces-1379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4877382A38F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 22:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A5E1F2408A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 21:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE694F61E;
	Wed, 10 Jan 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cfV8APNN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rt4KEQRx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b74WyE/b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A/NxhSej"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5624F5F9
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05CDB1F8D4;
	Wed, 10 Jan 2024 21:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704923525;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7U1trt3XgVS2ikeJx/Ms/K9nRYgFn3xUZt6FKtE7UEQ=;
	b=cfV8APNNuBGzHAkhaKIb7cehPNqVF3/UuoIuvAKXHo9MJ9iZlFkhb06x1mb5lFm0p7L8JJ
	XHcfRUq73kS1nbmRxV/6wGf2TIvehwl0KV/HoRmsAibaIxJDZMwF/tmdM0tFJN9ZijTC1P
	FMidfOUHZESgyRO3rxz+IpJ+kODAYcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704923525;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7U1trt3XgVS2ikeJx/Ms/K9nRYgFn3xUZt6FKtE7UEQ=;
	b=Rt4KEQRxPxY6zHnpLbe7MtQ6un2OJ1A6UsYeEVV/+G0x/SsMZhNBWwpRw6wmLl2V6tkG0t
	hUD50JfbcGJkA3BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704923448;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7U1trt3XgVS2ikeJx/Ms/K9nRYgFn3xUZt6FKtE7UEQ=;
	b=b74WyE/bEVgUt3Hb87oTjqOas1gSF6gYWyOd2AZAFES/eLAP8T2w3mYUNzMbZLi7ELYS+l
	1WRSbi6DdKlviZsXgV5vpRGHvV/H4A/ihrlk+nmniFnzTECCak8ISvSyUl9/ndvpxliqMg
	1HENO3uwJNJ1MJBHWNoE8PSbY+wNRV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704923448;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7U1trt3XgVS2ikeJx/Ms/K9nRYgFn3xUZt6FKtE7UEQ=;
	b=A/NxhSejWA8D3x1MMZ6nSZuAG3g6Y9kaYqJcEISN6Iquhy3a4I66iOxa9NBW/Ztpj+4cIM
	82IAviGa5kRyteCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B5E77139C6;
	Wed, 10 Jan 2024 21:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UvTuKzgRn2UaOwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 21:50:48 +0000
Date: Wed, 10 Jan 2024 22:52:04 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v2 2/2] btrfs-progs Documentation: placeholder for
 contents.rst file
Message-ID: <20240110215204.GC31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1704906806.git.anand.jain@oracle.com>
 <5563896f320e169cbd31f13eeba7ca2efb655d6a.1704906806.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5563896f320e169cbd31f13eeba7ca2efb655d6a.1704906806.git.anand.jain@oracle.com>
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
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Wed, Jan 10, 2024 at 10:55:23PM +0530, Anand Jain wrote:
> Sphinx error:
> master file btrfs-progs/Documentation/contents.rst not found
> make[1]: *** [Makefile:37: man] Error 2
> make: *** [Makefile:502: build-Documentation] Error 2
> 
> This build error is seen on version 1.7.6-3 of the sphinx-build.
> 
> For now, to circumvent the build error, create a placeholder file
> named contents.rst using the Makefile also add its cleanup.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to devel, thanks.

> ---
>  .gitignore                | 1 +
>  Documentation/Makefile.in | 8 ++++++++
>  Makefile                  | 7 +++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 26f1940d5546..bb719b41d200 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -79,5 +79,6 @@
>  
>  /Documentation/Makefile
>  /Documentation/_build
> +/Documentation/contents.rst
>  
>  *.patch
> diff --git a/Documentation/Makefile.in b/Documentation/Makefile.in
> index ffc253863ba8..2c036eef00fa 100644
> --- a/Documentation/Makefile.in
> +++ b/Documentation/Makefile.in
> @@ -28,6 +28,12 @@ man5dir = $(mandir)/man5
>  man8dir = $(mandir)/man8
>  
>  .PHONY: all man help
> +.PHONY: contents.rst
> +
> +contents.rst:
> +	@if [ "$$(sphinx-build --version | cut -d' ' -f2)" \< "1.7.7" ]; then \
> +		touch contents.rst; \
> +	fi
>  
>  # Build manual pages by default
>  
> @@ -53,6 +59,8 @@ uninstall:
>  clean:
>  	$(QUIET_RM)$(RM) -rf $(BUILDDIR)/*
>  	$(QUIET_RM)$(RM) -df -- $(BUILDDIR)
> +	$(QUIET_RM)$(RM) -f contents.rst
> +
>  
>  # Catch-all target: route all unknown targets to Sphinx using the new
>  # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
> diff --git a/Makefile b/Makefile
> index 374f59b99150..a031b0726a9c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -417,6 +417,12 @@ endif
>  .PHONY: $(CLEANDIRS)
>  .PHONY: all install clean
>  .PHONY: FORCE
> +.PHONY: contents.rst
> +
> +contents.rst:
> +	@if [ "$$(sphinx-build --version | cut -d' ' -f2)" \< "1.7.7" ]; then \
> +		touch Documentation/contents.rst; \
> +	fi
>  
>  # Create all the static targets
>  static_objects = $(patsubst %.o, %.static.o, $(objects))
> @@ -910,6 +916,7 @@ endif
>  clean-doc:
>  	@echo "Cleaning Documentation"
>  	$(Q)$(MAKE) $(MAKEOPTS) -C Documentation clean
> +	$(Q)$(RM) -f -- Documentation/contents.rst

You don't need to remove the file again, it's in the clean: target in
the documentation directory.

