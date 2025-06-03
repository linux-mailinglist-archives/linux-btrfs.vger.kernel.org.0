Return-Path: <linux-btrfs+bounces-14431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C956ACCE9E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 23:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DAE16FD54
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 21:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D592236E3;
	Tue,  3 Jun 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pprDgcuA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kIbIJRjE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pprDgcuA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kIbIJRjE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ADC2236FB
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748984738; cv=none; b=YD58yj0byWlCBPEDjDcu4fS9wkWg+EGgIGk2fbkOinepdmqh9R9i/8KluGZwd4jn7yHfYEbX2WWx1smfebyanQhz31vc3zJi/sKTzmp8eo8KFX7pGirEW4agd/AjD3I39/A0+RXl0c4Re+Ry0l1p8OMAf5bAqJNfyaXGwsHceo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748984738; c=relaxed/simple;
	bh=wmbGe7n/+HcuwxTFBR7ch5DnOPpgF9viywur2QYIteE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/eywn7S3CFZK6goK6Emx+OE6A9Xrx+CnlHxjzszD7b0dojX8SRMCXZ3/paglyKHWAzInSiK2MI3psFYB/eYk5N5jbsRTHRGzksl+qMLJ209K9MIh08lrxJKZ4hF3fn3mHYExuqqzcD9qbN+AtmDmaH9Y1rzmFsC5pqlydFPb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pprDgcuA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kIbIJRjE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pprDgcuA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kIbIJRjE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B8DA21AB7;
	Tue,  3 Jun 2025 21:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748984735;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esbVwbrOouUO+HuNOH/Br0BjFU8xzra8NGgPPtDEQZQ=;
	b=pprDgcuAI64PsYXA436aGyhsK0vzfz4fuRIaEx7Byk33MhPVRXLCqKc0pDlkgQE1z5Z7QD
	+cvzEcROpP+PUejUlpd8iiX0CoQkbWBTXu1WULkTD9tTWu73ozrJ9S1G5nS0bkVIlWrV6y
	cSfMNe61FyiAeF9JrWtpx3by9U30Ung=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748984735;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esbVwbrOouUO+HuNOH/Br0BjFU8xzra8NGgPPtDEQZQ=;
	b=kIbIJRjEpTKTiwV8O9LvAAya+WLPgeaEyTkM9Qg32vxoOzVHzV6GhrUCZz4wwWUfn+WzHB
	EN3FuHzpPfFKtMBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748984735;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esbVwbrOouUO+HuNOH/Br0BjFU8xzra8NGgPPtDEQZQ=;
	b=pprDgcuAI64PsYXA436aGyhsK0vzfz4fuRIaEx7Byk33MhPVRXLCqKc0pDlkgQE1z5Z7QD
	+cvzEcROpP+PUejUlpd8iiX0CoQkbWBTXu1WULkTD9tTWu73ozrJ9S1G5nS0bkVIlWrV6y
	cSfMNe61FyiAeF9JrWtpx3by9U30Ung=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748984735;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esbVwbrOouUO+HuNOH/Br0BjFU8xzra8NGgPPtDEQZQ=;
	b=kIbIJRjEpTKTiwV8O9LvAAya+WLPgeaEyTkM9Qg32vxoOzVHzV6GhrUCZz4wwWUfn+WzHB
	EN3FuHzpPfFKtMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B2C113A1D;
	Tue,  3 Jun 2025 21:05:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CadsBp9jP2gZHQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Jun 2025 21:05:35 +0000
Date: Tue, 3 Jun 2025 23:05:25 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: reorganize logic at free_extent_buffer() for
 better readability
Message-ID: <20250603210525.GQ4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1748962110.git.fdmanana@suse.com>
 <efce1f97dd115d01776b1fa08b830168a8a16133.1748962110.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efce1f97dd115d01776b1fa08b830168a8a16133.1748962110.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.cz:replyto,suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,twin.jikos.cz:mid,suse.cz:replyto];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Tue, Jun 03, 2025 at 03:50:25PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's hard to read the logic to break out of the while loop since it's a
> very long expression consisting of a logical or of two composite
> expressions, each one composed by a logical and. Further each one is also
> testing for the EXTENT_BUFFER_UNMAPPED bit, making it more verbose than
> necessary.
> 
> So change from this:
> 
>     if ((!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) && refs <= 3)
>         || (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) &&
>             refs == 1))
>        break;
> 
> To this:
> 
>     if (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags)) {
>         if (refs == 1)
>             break;
>     } else if (refs <= 3) {
>             break;
>     }
> 
> At least on x86_64 using gcc 9.3.0, this doesn't change the object size.

The object size remains the same probably due to function size
alignments, the assembly code changed and I'd say for the better:

  mov    0x10(%rbx),%rdx			# eb->flags
  and    $0x20,%edx
  jne    free_extent_buffer
  cmp    $0x3,%eax
  jle    free_extent_buffer
- mov    0x10(%rbx),%rdx
  lea    -0x1(%rax),%edx
  lock cmpxchg %edx,0x2c(%rbx)
  jne    free_extent_buffer
  pop    %rbx
  ret
- mov    0x10(%rbx),%rdx
- and    $0x20,%edx
- je     free_extent_buffer
  cmp    $0x1,%eax
  jne    free_extent_buffer
  lea    0x28(%rbx),%rdi

IOW it removes instructions that reloaded the eb->flags (offset 0x10/16), the
new version reads it just once per loop. (The diff lacks jump targets and
labels, complete view is in objdump.)

