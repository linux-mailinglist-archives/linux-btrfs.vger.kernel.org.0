Return-Path: <linux-btrfs+bounces-3372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E0D87F298
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 22:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA1B282620
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 21:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732365A783;
	Mon, 18 Mar 2024 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fZqvIiE9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JDOoQab2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fZqvIiE9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JDOoQab2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEEC5A780
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798726; cv=none; b=ZwxqznGp5FMbBpNiILW/yLbM6/17xn5MbXe4MFPWsZqS53ovtL04+UQr/OnfX43/Biz7oAm7EbxCWWL9wpCsrfUOY2ByF0H64LnkLZ/o+n9aKrfi/+jLZSXZsPs8pzcsbXwIyY7oTdD6Ltwl6Hh9MaSoT5/DcO11V7Fw1dkAcrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798726; c=relaxed/simple;
	bh=7V4et7tLxQhZP3GjpKdsfXUQouiYxBMIk4sIvkHPHdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDV/CiZWuDIDg0prUiPvOFbQdzjQbaSgaxPLW3he0hPEbk9yhrDPbkCqRt5r8jJO0mR+BMTMFDzEi1IUbBfyr3Y/kB0bl4P8Tv7mKR5hhN0/qE7qpDBdVKH/kVB3UKxQSzawpiz+HvLPwxqHr8/3lSVYRBpdy0IggumDr4nIKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fZqvIiE9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JDOoQab2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fZqvIiE9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JDOoQab2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4DDD5CB65;
	Mon, 18 Mar 2024 21:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710798722;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgsjaGGJLXQu5/yPJbKRkiSxbOJqJ3om9h8VSFEk7Fo=;
	b=fZqvIiE98yE133xbkvWSvviSBJ7dsmla8rByfxQIbVHSpIt3vPUpnbQG34Iq9p3iMifhe1
	9/Ualr0IqwuChG/4Cmr6dDt7/19TJC4nMPAmkgasB/F55fXuyUFAkd0TRN8V4kmJ7HxR8Z
	8tXkvkOxxP4F9JpKvJDFvY3V9lSql2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710798722;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgsjaGGJLXQu5/yPJbKRkiSxbOJqJ3om9h8VSFEk7Fo=;
	b=JDOoQab2/4IhuJqKuniqUF18P25ASgqbtKbKA46NBYxD3s08gCqdLJET0dKTPx8SgxHfpg
	VGR6SkTVAbuObDCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710798722;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgsjaGGJLXQu5/yPJbKRkiSxbOJqJ3om9h8VSFEk7Fo=;
	b=fZqvIiE98yE133xbkvWSvviSBJ7dsmla8rByfxQIbVHSpIt3vPUpnbQG34Iq9p3iMifhe1
	9/Ualr0IqwuChG/4Cmr6dDt7/19TJC4nMPAmkgasB/F55fXuyUFAkd0TRN8V4kmJ7HxR8Z
	8tXkvkOxxP4F9JpKvJDFvY3V9lSql2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710798722;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgsjaGGJLXQu5/yPJbKRkiSxbOJqJ3om9h8VSFEk7Fo=;
	b=JDOoQab2/4IhuJqKuniqUF18P25ASgqbtKbKA46NBYxD3s08gCqdLJET0dKTPx8SgxHfpg
	VGR6SkTVAbuObDCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C624F1349D;
	Mon, 18 Mar 2024 21:52:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gW7eL4K3+GUvSwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Mar 2024 21:52:02 +0000
Date: Mon, 18 Mar 2024 22:44:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: remove a couple pointless callback wrappers
Message-ID: <20240318214449.GH16737@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710763611.git.fdmanana@suse.com>
 <5a8d9a84-8eaa-4c6f-aba5-209a94c7b02b@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a8d9a84-8eaa-4c6f-aba5-209a94c7b02b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.79)[93.72%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Tue, Mar 19, 2024 at 06:42:26AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/3/18 22:44, fdmanana@kernel.org 写道:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Trivial stuff, details in the change logs.
> 
> I guess it's just exposed by some random code reading?
> 
> No automatic tools to expose such single line wrapper?

---
dentifier FUNC, CALL;
type TYPE;
@@

  TYPE
  FUNC(...)
  {
*   return CALL(...);
  }
---

but not all trivial helpers should be removed, some of them have a semantic
value or pair another fuction that is not trivial.

