Return-Path: <linux-btrfs+bounces-5322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A798D212F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 18:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E75F1F26B34
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D85B171E68;
	Tue, 28 May 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QnXNe/+T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zk/QKPu2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QnXNe/+T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zk/QKPu2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58EB16D4E6
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912395; cv=none; b=ljW7yxh8NwB5Jok6gbWhD0Z7SLkuCvPNJ6cI8FF8tLVXt5WRfaITVWVrA+J8HL5xledDK8YJF5w46dE5FPv5QeAb9xXWfzuL55HQsgHl8ehCRBGHyt1ZuADnXoghxktstup0eq/uod6d77aOxJ33mAnskL+j7ApZMVtvyQQ0ASU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912395; c=relaxed/simple;
	bh=c4j0/01y/HcCRmR4EjcGiQsMy/XStlBjwlZDGanWXyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIF5sc8Y6Slo/zIHHmw+Z+avbKKXUW4KRZooHs40WSElD0RfyZapV+cFsIeVygGUs6yRKT2x9OJ6BSxDO96Do5D6m8j4cwgW+o9urWQFz8Xk8719a3dvegf2N1HBeAMf5CvfOjvzcAPcbIyAEhbKb7u7dW5vQS3jLItArmKDRds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QnXNe/+T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zk/QKPu2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QnXNe/+T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zk/QKPu2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5DF320352;
	Tue, 28 May 2024 16:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716912391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhTT+630KjCupEnxDt5+7lr/egvGnMBAc+rmC0pi4Co=;
	b=QnXNe/+TE0Rr5z9kE0Qh+rZZM++F+hmEn0sQxcM4kZ2XTUYAa5rEIf481AKbdcMiwGI671
	Kh383PP14vFHqSHp8Y8jvrHpap7KV3FydSmW1BWURSPXOYBvkvzKq3XhK9pej86wanGJ5G
	ScGYoGZ+YkgCNH3syX6/VmaSZA9UEMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716912391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhTT+630KjCupEnxDt5+7lr/egvGnMBAc+rmC0pi4Co=;
	b=zk/QKPu2N9z/m3GOZHrn4rGTNy0W1exImXB5/VuM4CWmYSE3U+V/WXKrZ6c7AcugkyByRS
	iXsSU9UzXwxnwbAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716912391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhTT+630KjCupEnxDt5+7lr/egvGnMBAc+rmC0pi4Co=;
	b=QnXNe/+TE0Rr5z9kE0Qh+rZZM++F+hmEn0sQxcM4kZ2XTUYAa5rEIf481AKbdcMiwGI671
	Kh383PP14vFHqSHp8Y8jvrHpap7KV3FydSmW1BWURSPXOYBvkvzKq3XhK9pej86wanGJ5G
	ScGYoGZ+YkgCNH3syX6/VmaSZA9UEMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716912391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhTT+630KjCupEnxDt5+7lr/egvGnMBAc+rmC0pi4Co=;
	b=zk/QKPu2N9z/m3GOZHrn4rGTNy0W1exImXB5/VuM4CWmYSE3U+V/WXKrZ6c7AcugkyByRS
	iXsSU9UzXwxnwbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE99213A5D;
	Tue, 28 May 2024 16:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cNlEMgcBVmYKBQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 28 May 2024 16:06:31 +0000
Date: Tue, 28 May 2024 18:06:26 +0200
From: David Sterba <dsterba@suse.cz>
To: Sijie Lan <sijielan@gmail.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: Question about btrfs compression
Message-ID: <20240528160626.GF8631@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAGAHmYDquz9v1eABjGkYq=ja1vPkwAz9HmcCQVZk0htb5W830w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGAHmYDquz9v1eABjGkYq=ja1vPkwAz9HmcCQVZk0htb5W830w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3]

On Fri, May 24, 2024 at 02:32:38AM +0800, Sijie Lan wrote:
> As described in
> https://archive.kernel.org/oldwiki/btrfs.wiki.kernel.org/index.php/Compression.html.
> "The compression processes ranges of a file of maximum size 128 KiB
> and compresses each 4 KiB (or page-sized) block separately. Accessing
> a byte in the middle of the given 128 KiB range requires to decompress
> the whole range. This is not optimal and is subject to optimizations
> and further development."
> 
> Since Btrfs compresses each 4KiB block of data separately. My question
> is that when randomly accessing some of the bytes in the entire
> compressed chunk, decompressing some of the bytes in the entire chunk
> seems to be much more efficient than decompressing the entire range
> (128 KiB), but the current method still decompresses the entire 128KiB
> chunk when accessing some of the bytes in the chunk (e.g., 4KiB). So
> why is it not optimized for this, is it a basic implementation
> difficulty or something else?

Technically it's possible. I'm not sure if this would be that noticeable
because page cache readahead reads more memory around what is accessed
so the requested range could be bigger once it ends up in the
decompression.

Assuming we're reading 4k page, we'd need to support seeking into the
compressed stream.  This depends on the used compression algorithm,
we'd need somehow let each decompression to start from there.

For LZO the chunking is done manually, as it needs a contiguous buffer
and referes to previous data directly. We could skip the segments,
though I'm not sure if we store the compressed size (ie. the amount to
skip).

Zstd or zlib keep the state separately and there's no outer container so
we'd need API support for that, returning offset in compressed stream
for a given uncompressed offset in the result. I'm not familiar with the
formats but to make this work the internal segments would have to track
the compressed size and would be able to go over them without
decompression.

The last thing is probably the interface for btrfs compression to fill
just the given range.

