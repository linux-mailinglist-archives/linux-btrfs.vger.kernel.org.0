Return-Path: <linux-btrfs+bounces-6857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B06F9400F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 00:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098D81F2337F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 22:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8602C18EFD5;
	Mon, 29 Jul 2024 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hSzw0XdL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W7BlbYdd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B6wrdkT2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zvHWRnAy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD8D13CA95
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722291181; cv=none; b=Gas6vabBVleKCgErOdi4toFUQADJ/JIIgTai0TIBlXt0jQv23z7apuh9d+ZDe6126PvN9Qt5iCvkCxthfG5BqLxyoIJTzmX/uStAuUmIix+SV0y11zH/nvAhN0YpyjKp7hLiwclMzc2od7KasJMoBGcbkgzL2NkYwOp0wXocrpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722291181; c=relaxed/simple;
	bh=eMcPp7BN1mnFKCoGog0/Ak6XnmG1O5gFkXZUXm8q+HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHNXqK0l/C8vzl17SN3NMFoeD2i91xPWu/w2GctMZMg2ro6MhvRoKQaj78cUieNgLHR/Hmx7qPQToGA4WIlVp8bt9F83QgjIianEg6H5sesFy/PPFl+/aMzCOkWVIWlogs1q0ohNcKegr2FQTBN09oWUkZWev0TTNUQURLwc83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hSzw0XdL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W7BlbYdd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B6wrdkT2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zvHWRnAy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D96EE21AD8;
	Mon, 29 Jul 2024 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722291178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SyEM0pW5MVsTLO3/OuEDl6H/5ttrq9AwnBgArqwHBkY=;
	b=hSzw0XdLrzCyM22hjIjZ6GsUwiYrUcnysklVQo9TZJlcOXLdwSk3hQ5RwF+fxOI87o3acI
	i7qHDXpyQpM1n+oPv7a1UXTpF9zZ0Z9YKI9ZCuz8/D5Lyt7Xj4Fmvux4N9CZMZvRhT4RLL
	NBKyrQJrxgkjGL/oLcHzrKDDxjbexmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722291178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SyEM0pW5MVsTLO3/OuEDl6H/5ttrq9AwnBgArqwHBkY=;
	b=W7BlbYddbSlE+mOyKfUGdsLBMwnvsvcdA5L0xVZQKsMe3Zd5Ax9BpXLKIUkAxKR9AAlY+S
	dSNtFDqtG/5ItUDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B6wrdkT2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zvHWRnAy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722291177;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SyEM0pW5MVsTLO3/OuEDl6H/5ttrq9AwnBgArqwHBkY=;
	b=B6wrdkT2RrimuEAIyc+Mr1/Vw+3wXIHo4jsGAzpdGRETDy+oLKmZPz7MNuClkZZ5Y/9d6Z
	yhmcIaXa6QJLoKvZK8Gk5JAn7LQxiHJ71jkVmlvChXkI6RrG+B2/a/LU7eS+xhDRd1hLm2
	wlaw4Uu7SXZfOq4SvcvqojWSAj/za58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722291177;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SyEM0pW5MVsTLO3/OuEDl6H/5ttrq9AwnBgArqwHBkY=;
	b=zvHWRnAyjXETyX6Yw6tBbCRs6k1KLoapoDVg+6w1B8dh9EFDjAQwGAkgjeZ7JihlZWXJmz
	ZSli5WY6u6vf0PAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A48411368A;
	Mon, 29 Jul 2024 22:12:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tfrqJ+kTqGbpYwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Jul 2024 22:12:57 +0000
Date: Tue, 30 Jul 2024 00:12:52 +0200
From: David Sterba <dsterba@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	Neal Gompa <neal@gompa.dev>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH] libbtrfsutil: python: fix build on Python 3.13
Message-ID: <20240729221252.GV17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fbbb792fa299bfdfa818f6e0790fa545297dc1cf.1721949827.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbbb792fa299bfdfa818f6e0790fa545297dc1cf.1721949827.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: D96EE21AD8

On Thu, Jul 25, 2024 at 04:28:35PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Python 3.13, currently in beta, removed the internal
> _PyObject_LookupSpecial function. The libbtrfsutil Python bindings use
> it in the path_converter() function because it was based on internal
> path_converter() function in CPython [1]. This is causing build failures
> on Fedora Rawhide [2] and Gentoo [3]. Replace path_converter() with a
> version that only uses public functions based on the one in drgn [4].
> 
> 1: https://github.com/python/cpython/blob/d9efa45d7457b0dfea467bb1c2d22c69056ffc73/Modules/posixmodule.c#L1253
> 2: https://bugzilla.redhat.com/show_bug.cgi?id=2245650
> 3: https://github.com/kdave/btrfs-progs/issues/838
> 4: https://github.com/osandov/drgn/blob/9ad29fd86499eb32847473e928b6540872d3d59a/libdrgn/python/util.c#L81
> 
> Reported-by: Neal Gompa <neal@gompa.dev>
> Reported-by: Sam James <sam@gentoo.org>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  libbtrfsutil/python/btrfsutilpy.h |  7 +--
>  libbtrfsutil/python/module.c      | 98 ++++++++++---------------------
>  2 files changed, 33 insertions(+), 72 deletions(-)
> 
> diff --git a/libbtrfsutil/python/btrfsutilpy.h b/libbtrfsutil/python/btrfsutilpy.h
> index ee70c23a..49702dcc 100644
> --- a/libbtrfsutil/python/btrfsutilpy.h
> +++ b/libbtrfsutil/python/btrfsutilpy.h
> @@ -40,16 +40,13 @@ extern PyTypeObject SubvolumeInfo_type;
>  extern PyTypeObject SubvolumeIterator_type;
>  extern PyTypeObject QgroupInherit_type;
>  
> -/*
> - * Helpers for path arguments based on posixmodule.c in CPython.
> - */
>  struct path_arg {
>  	bool allow_fd;
> -	char *path;
>  	int fd;
> +	char *path;
>  	Py_ssize_t length;
>  	PyObject *object;
> -	PyObject *cleanup;
> +	PyObject *bytes;
>  };
>  int path_converter(PyObject *o, void *p);
>  void path_cleanup(struct path_arg *path);
> diff --git a/libbtrfsutil/python/module.c b/libbtrfsutil/python/module.c
> index 2657ee28..9b0b86b5 100644
> --- a/libbtrfsutil/python/module.c
> +++ b/libbtrfsutil/python/module.c
> @@ -44,85 +44,49 @@ static int fd_converter(PyObject *o, void *p)
>  int path_converter(PyObject *o, void *p)
>  {
>  	struct path_arg *path = p;
> -	int is_index, is_bytes, is_unicode;
> -	PyObject *bytes = NULL;
> -	Py_ssize_t length = 0;
> -	char *tmp;
>  
>  	if (o == NULL) {
>  		path_cleanup(p);
>  		return 1;
>  	}
>  
> -	path->object = path->cleanup = NULL;
> -	Py_INCREF(o);
> -
>  	path->fd = -1;
> +	path->path = NULL;
> +	path->length = 0;
> +	path->bytes = NULL;
> +	if (path->allow_fd && PyIndex_Check(o)) {
> +		PyObject *fd_obj;
> +		int overflow;
> +		long fd;
>  
> -	is_index = path->allow_fd && PyIndex_Check(o);
> -	is_bytes = PyBytes_Check(o);
> -	is_unicode = PyUnicode_Check(o);
> -
> -	if (!is_index && !is_bytes && !is_unicode) {
> -		_Py_IDENTIFIER(__fspath__);
> -		PyObject *func;
> -
> -		func = _PyObject_LookupSpecial(o, &PyId___fspath__);
> -		if (func == NULL)
> -			goto err_format;
> -		Py_DECREF(o);
> -		o = PyObject_CallFunctionObjArgs(func, NULL);
> -		Py_DECREF(func);
> -		if (o == NULL)
> +		fd_obj = PyNumber_Index(o);
> +		if (!fd_obj)
>  			return 0;
> -		is_bytes = PyBytes_Check(o);
> -		is_unicode = PyUnicode_Check(o);
> -	}
> -
> -	if (is_unicode) {
> -		if (!PyUnicode_FSConverter(o, &bytes))
> -			goto err;
> -	} else if (is_bytes) {
> -		bytes = o;
> -		Py_INCREF(bytes);
> -	} else if (is_index) {
> -		if (!fd_converter(o, &path->fd))

This removes the last use of fd_converter

module.c:22:12: warning: ‘fd_converter’ defined but not used [-Wunused-function]
   22 | static int fd_converter(PyObject *o, void *p)

I'll ifdef it out as it will be probably needed in the future.

