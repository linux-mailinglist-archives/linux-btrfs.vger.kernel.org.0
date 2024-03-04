Return-Path: <linux-btrfs+bounces-3001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4FE870989
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 19:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E131F271BF
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA10626C9;
	Mon,  4 Mar 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zt7VHvPv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oZvKl65G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zt7VHvPv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oZvKl65G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ACD4C62E
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Mar 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577008; cv=none; b=CruKs5tqoJYKxEwfQc/262fgVEUJW+ByHx3IZp0Rr67OotEmA8U5Ef+k7WFwX7fWlpBOF0lhpcDB/pH8MnVesEB2ovBDpK+rtPGNmf+C08RvPTRSt1GPe2Mkqfg1OtMV6XclQJlhbcjgwWWobeJ/WE0a4i+2h2A0OkhIPhMXN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577008; c=relaxed/simple;
	bh=Yn7T3H5eURtlEtLfXnJyfoe95+VUbaBH/ArhAHW8vUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCUZPMtFrCzzizbmnoH6TBjlv5qD50fUNB0uhyNL9BCglM//tM1rWi2vJM7EQD6nIkA/HXH7QZeZWnq2uDp1l0qHzOK8ZYufFUrWfz9J1qb847higWJHTQzs0NfuEpTEqcPVI8D8MOvdbZ6JWhNgTOJ8IgNFEmO4U6dJhng9PLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zt7VHvPv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oZvKl65G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zt7VHvPv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oZvKl65G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42DC833B9A;
	Mon,  4 Mar 2024 18:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709577002;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ8ci9epBO9BXxqaKnyD9YSToog5nowkd++Ar3XtyUI=;
	b=Zt7VHvPvlUnAYirM0VAMU/In6pR3aSiof/AXqNlvj23eAAAoJVq/ou54B7Qbx7BAt/vMvm
	2O34oCnNmRsfQWqAgFV2nj05HyWoarjs+TXEhnO47hRcrDid1P9i1PNg9pr/F/JZHs8+/6
	sKSmpHq5R/5/tysz1NnxszsBeslSS/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709577002;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ8ci9epBO9BXxqaKnyD9YSToog5nowkd++Ar3XtyUI=;
	b=oZvKl65GFZt5maldXsTPvOhuoPVNo/Wusc+oVcfJKcAanR6UspNNbGvvX4RnoOytbUdZp3
	lyND6rBCCYd5YyCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709577002;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ8ci9epBO9BXxqaKnyD9YSToog5nowkd++Ar3XtyUI=;
	b=Zt7VHvPvlUnAYirM0VAMU/In6pR3aSiof/AXqNlvj23eAAAoJVq/ou54B7Qbx7BAt/vMvm
	2O34oCnNmRsfQWqAgFV2nj05HyWoarjs+TXEhnO47hRcrDid1P9i1PNg9pr/F/JZHs8+/6
	sKSmpHq5R/5/tysz1NnxszsBeslSS/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709577002;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ8ci9epBO9BXxqaKnyD9YSToog5nowkd++Ar3XtyUI=;
	b=oZvKl65GFZt5maldXsTPvOhuoPVNo/Wusc+oVcfJKcAanR6UspNNbGvvX4RnoOytbUdZp3
	lyND6rBCCYd5YyCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 29A39139C6;
	Mon,  4 Mar 2024 18:30:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AwHBCSoT5mWZHQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 04 Mar 2024 18:30:02 +0000
Date: Mon, 4 Mar 2024 19:22:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Helge Kreutzmann <debian@helgefjell.de>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Issues in man pages of btrfs-progs
Message-ID: <20240304182252.GN2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ZeRuEH029j3enMr0@meinfjell.helgefjelltest.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeRuEH029j3enMr0@meinfjell.helgefjelltest.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Zt7VHvPv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oZvKl65G
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 42DC833B9A
X-Spam-Flag: NO

On Sun, Mar 03, 2024 at 12:33:20PM +0000, Helge Kreutzmann wrote:
> Dear brtfs maintainer,
> the manpage-l10n project maintains a large number of translations of
> man pages both from a large variety of sources (including btrfs) as
> well for a large variety of target languages.
> 
> During their work translators notice different possible issues in the
> original (english) man pages. Sometimes this is a straightforward
> typo, sometimes a hard to read sentence, sometimes this is a
> convention not held up and sometimes we simply do not understand the
> original.
> 
> We use several distributions as sources and update regularly (at
> least every 2 month). This means we are fairly recent (some
> distributions like archlinux also update frequently) but might miss
> the latest upstream version once in a while, so the error might be
> already fixed. We apologize and ask you to close the issue immediately
> if this should be the case, but given the huge volume of projects and
> the very limited number of volunteers we are not able to double check
> each and every issue.
> 
> Secondly we translators see the manpages in the neutral po format,
> i.e. converted and harmonized, but not the original source (be it man,
> groff, xml or other). So we cannot provide a true patch (where
> possible), but only an approximation which you need to convert into
> your source format.
> 
> Finally the issues I'm reporting have accumulated over time and are
> not always discovered by me, so sometimes my description of the
> problem my be a bit limited - do not hesitate to ask so we can clarify
> them.
> 
> I'm now reporting the errors for your project. If future reports
> should use another channel, please let me know.
> 
> Man page: btrfs.8
> Issue:    I<\\%btrfs(5)> → B<\\%btrfs>(5)

Thanks for the report, I've opened an issue
https://github.com/kdave/btrfs-progs/issues/756 , looks like it's namely
formatting of the manual page references. There was a recent change that
added a common formatting macro so this can be fixed in one go.

If there's a validation tool that would identify such problems I can add
it to the documentation build pipeline or at least to the CI. Please let
me know.

