Return-Path: <linux-btrfs+bounces-6721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F37793D585
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 17:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3911C21130
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 15:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E70144D0A;
	Fri, 26 Jul 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0XJgzX9z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="noIOLb32";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0XJgzX9z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="noIOLb32"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523511F95E
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006139; cv=none; b=UC2oVTa8JtQ3aMHBydK6nwlH/Akez/M/kDTrbqUptow9nEuclNrvljm6q6dZ2sA52z+5pGpiStEi4kuC6BBgtKXzK9r70fdsE16BxlkzIEq6Yc7ViyfAupvVUu4pwLnjo7q7WppRx2fzVPu1knvPCUT1jI99zxjrIYdVamwZFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006139; c=relaxed/simple;
	bh=ct061yvoKNX5yI0uzuapPB9a94Orsd1G/Fs1sCRSTKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow3lbHB7+uX1R30GEpx8B+tF4ylA6oK7I+7nXyWL2rIZe9R6N2D1cvS2Od8B6lNu+4rvzU9+gDppAGQdr1CMhd2iGXAbPtQaEE/+1KKRtjoRKCyxSa0S9SxxAJo1odLKPu+VFLfbAZx0hNNULsXlCO7RHE0/HTRP0yWS9Y54RqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0XJgzX9z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=noIOLb32; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0XJgzX9z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=noIOLb32; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 690741FCFF;
	Fri, 26 Jul 2024 15:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722006135;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0e6rV5aWj+ZO1YgUdekjanA3VL4UmZG3PWRBI5Gd304=;
	b=0XJgzX9zugZ5RqSLxIch8r+2C30FuC8NplhSF56L+XeHlOwlGggSXB8pLjQD9qz4DQ+TMc
	aG8ZnOn3VIYFh6Qaklh5BEtjXYbkpbUeC2G++BmDDCtrkgajea5E87d1GjMO9j/oVGRLtn
	qwNeMOI7AIJ2C7udD2AJ1GRry0Og4AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722006135;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0e6rV5aWj+ZO1YgUdekjanA3VL4UmZG3PWRBI5Gd304=;
	b=noIOLb32r+lohIVYMIxcD9ykcY1ByIc9Df2n/rgpveVFHbptboTC7rflC9njzgEcGzC+7S
	/PuFKX2jcMSg7TAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0XJgzX9z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=noIOLb32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722006135;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0e6rV5aWj+ZO1YgUdekjanA3VL4UmZG3PWRBI5Gd304=;
	b=0XJgzX9zugZ5RqSLxIch8r+2C30FuC8NplhSF56L+XeHlOwlGggSXB8pLjQD9qz4DQ+TMc
	aG8ZnOn3VIYFh6Qaklh5BEtjXYbkpbUeC2G++BmDDCtrkgajea5E87d1GjMO9j/oVGRLtn
	qwNeMOI7AIJ2C7udD2AJ1GRry0Og4AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722006135;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0e6rV5aWj+ZO1YgUdekjanA3VL4UmZG3PWRBI5Gd304=;
	b=noIOLb32r+lohIVYMIxcD9ykcY1ByIc9Df2n/rgpveVFHbptboTC7rflC9njzgEcGzC+7S
	/PuFKX2jcMSg7TAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B41B138A7;
	Fri, 26 Jul 2024 15:02:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ifw6Dne6o2acKQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jul 2024 15:02:15 +0000
Date: Fri, 26 Jul 2024 17:02:14 +0200
From: David Sterba <dsterba@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: Neal Gompa <neal@gompa.dev>, dsterba@suse.cz,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH] libbtrfsutil: python: fix build on Python 3.13
Message-ID: <20240726150214.GF17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fbbb792fa299bfdfa818f6e0790fa545297dc1cf.1721949827.git.osandov@fb.com>
 <20240726011224.GE17473@twin.jikos.cz>
 <CAEg-Je_7OeESAbQ0zBD=fuvY_WHE05vk0iR=Vv4Bq5vAc_qCJw@mail.gmail.com>
 <ZqL9vYnNkQm_bSHs@telecaster>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqL9vYnNkQm_bSHs@telecaster>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 690741FCFF

On Thu, Jul 25, 2024 at 06:37:01PM -0700, Omar Sandoval wrote:
> On Thu, Jul 25, 2024 at 09:29:44PM -0400, Neal Gompa wrote:
> > On Thu, Jul 25, 2024 at 9:12 PM David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Thu, Jul 25, 2024 at 04:28:35PM -0700, Omar Sandoval wrote:
> > > > From: Omar Sandoval <osandov@fb.com>
> > > >
> > > > Python 3.13, currently in beta, removed the internal
> > > > _PyObject_LookupSpecial function. The libbtrfsutil Python bindings use
> > > > it in the path_converter() function because it was based on internal
> > > > path_converter() function in CPython [1]. This is causing build failures
> > > > on Fedora Rawhide [2] and Gentoo [3]. Replace path_converter() with a
> > > > version that only uses public functions based on the one in drgn [4].
> > > >
> > > > 1: https://github.com/python/cpython/blob/d9efa45d7457b0dfea467bb1c2d22c69056ffc73/Modules/posixmodule.c#L1253
> > > > 2: https://bugzilla.redhat.com/show_bug.cgi?id=2245650
> > > > 3: https://github.com/kdave/btrfs-progs/issues/838
> > > > 4: https://github.com/osandov/drgn/blob/9ad29fd86499eb32847473e928b6540872d3d59a/libdrgn/python/util.c#L81
> > > >
> > > > Reported-by: Neal Gompa <neal@gompa.dev>
> > > > Reported-by: Sam James <sam@gentoo.org>
> > > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > >
> > > Thanks, this is more convoluted than I expected. Does this work on other
> > > python versions, like 3.8 and above? I'd have to check what's the lowest
> > > expected python version derived from the base line for distro support so
> > > 3.6 is just a guess.
> > 
> > Well, I can't build it on AlmaLinux 8 with Python 3.6 because
> > libgcrypt is too old, but it builds and works fine on CentOS Stream 9
> > (which has Python 3.9).
> 
> Yup, this works for drgn on Python 3.6-3.13.

Also confirmed by the CI test images, the lowest base is Centos 7 with
3.6.

