Return-Path: <linux-btrfs+bounces-6695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0693C650
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 17:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79125281BD2
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A79B19D88C;
	Thu, 25 Jul 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x5/+uGgB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ir6fkxxE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x5/+uGgB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ir6fkxxE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A019D062
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921070; cv=none; b=sfV9hqjWmOIafblPLe9DXdFA7ijuvpZIvww4JkyrE4KMIogG9VTtrvdI090WxpFrGQZipRqHevrilk3oK6uPxUDh+Y7aBMdcsGnVdtgO4nrJzVxf5P5NGpiF63M4ZL4xrYe5LYE5QTuJqee5RY+f/uCT8owmxoaFIxrPqi+gPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921070; c=relaxed/simple;
	bh=eVv3dl7zWg9NWcXFDTmV8vfjViaQTbq+cA+sL9CgSDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1mii901IICi/QoP2chAuMKQkn3FpI+wgabIziDTow1G6w+tecSw/WBJRebuM4QKKwFmFvrx0Z10ckKzTXukx61BUBEYORoByrV4IzineZv48QiCL8zpqJzjxhNvS7RZF8qGonFf+XS+npKxKHUSkn+dun6f3zhkLQmCrSoGdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x5/+uGgB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ir6fkxxE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x5/+uGgB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ir6fkxxE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC01F21B55;
	Thu, 25 Jul 2024 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721921066;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbhiCrr33tERWHuPB7xy94cu5QM34lwwT9sUtNXbMDw=;
	b=x5/+uGgBzXWZcDlcDOrlImKnx7mDLzg+K6CjpQVprbg6NTr1eAMNse07jTenX65Gi9NkAd
	DjXsVxGqbN1edVSMvRVV05cIDyncSulzpnr8lpeXI4D1Qy8Xjjr+Ts3RNXuM1UQHFJ6Yan
	qkbznTAlaV3g486euJvW1zQGWr8Pah8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721921066;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbhiCrr33tERWHuPB7xy94cu5QM34lwwT9sUtNXbMDw=;
	b=Ir6fkxxEB4DByCufDXZpJO17W3CsBqGiOrn/9bZmxn9cFiH65RoP0fR+ZD2s43HRzwzWGm
	nUOSZAkdjElWskBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721921066;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbhiCrr33tERWHuPB7xy94cu5QM34lwwT9sUtNXbMDw=;
	b=x5/+uGgBzXWZcDlcDOrlImKnx7mDLzg+K6CjpQVprbg6NTr1eAMNse07jTenX65Gi9NkAd
	DjXsVxGqbN1edVSMvRVV05cIDyncSulzpnr8lpeXI4D1Qy8Xjjr+Ts3RNXuM1UQHFJ6Yan
	qkbznTAlaV3g486euJvW1zQGWr8Pah8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721921066;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbhiCrr33tERWHuPB7xy94cu5QM34lwwT9sUtNXbMDw=;
	b=Ir6fkxxEB4DByCufDXZpJO17W3CsBqGiOrn/9bZmxn9cFiH65RoP0fR+ZD2s43HRzwzWGm
	nUOSZAkdjElWskBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FEFC13874;
	Thu, 25 Jul 2024 15:24:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RR2JIipuomafJwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Jul 2024 15:24:26 +0000
Date: Thu, 25 Jul 2024 17:24:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Neal Gompa <neal@gompa.dev>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
	Victor Stinner <vstinner@redhat.com>,
	Miro Hroncok <mhroncok@redhat.com>, David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: libbtrfsutil Python bindings FTBFS with Python 3.13 on Fedora
 Linux 41
Message-ID: <20240725152425.GA17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAEg-Je-tu0DcYvH-mqcv=2xkReYOh9GaeVoJPy0nMD=oqO6stw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je-tu0DcYvH-mqcv=2xkReYOh9GaeVoJPy0nMD=oqO6stw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Score: -0.80

On Sat, Jul 20, 2024 at 12:59:33PM -0400, Neal Gompa wrote:
> Hey all,
> 
> Fedora Linux 41 has upgraded to Python 3.13[1], and as part of it, the
> changes to the interpreter API to remove "private" methods have broken
> the build for python-libbtrfsutil. There's a downstream bug about
> this[2], but the gist of it is that _Py_IDENTIFIER and
> _PyObject_LookupSpecial were removed[3], and so the bindings code
> needs adjustments to fix it.
> 
> Anyone know how to help with this? I'm not really sure how to fix this...
> 
> [1]: https://fedoraproject.org/wiki/Changes/Python3.13
> [2]: https://bugzilla.redhat.com/2245650
> [3]: https://github.com/python/cpython/commit/4fb96a11db5eaca3646bfa697d191469e567d283
> 
> -- 
> 真実はいつも一つ！/ Always, there's only one truth!
> 

Also tracked as https://github.com/kdave/btrfs-progs/issues/838 .

