Return-Path: <linux-btrfs+bounces-949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0568E81223A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 23:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01720B212EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 22:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507A281E5D;
	Wed, 13 Dec 2023 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SXz8zIOL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+9qrA6CH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SXz8zIOL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+9qrA6CH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D04115
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 14:59:39 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11C2A21FC3;
	Wed, 13 Dec 2023 22:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702508378;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/G1zoSxec1514q6TB09yptRlAvD+e6c83yZ6Bpuu3iM=;
	b=SXz8zIOLhnhtmW5PtFaG2j/K/9npIn67AS9HLAGw+Hgcp1BZkb55jWrm1t199lvwsqce5f
	J0v7iaaBwx1rHMzs/mT2DrFTm5eGRp78oJ0Ca1H2aeMz396N/jw1gCUBBAiorM+rBpCtuW
	5TLIavSJlbmhbbDBGHLiHhd5OXSBtwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702508378;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/G1zoSxec1514q6TB09yptRlAvD+e6c83yZ6Bpuu3iM=;
	b=+9qrA6CHlbwr1WUyN4kxTrBYBm9QMUfAUVRmbonZSKOJilAq86Kkzl5IA5We+uxF+RMghS
	yP228K5JepNj2pAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702508378;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/G1zoSxec1514q6TB09yptRlAvD+e6c83yZ6Bpuu3iM=;
	b=SXz8zIOLhnhtmW5PtFaG2j/K/9npIn67AS9HLAGw+Hgcp1BZkb55jWrm1t199lvwsqce5f
	J0v7iaaBwx1rHMzs/mT2DrFTm5eGRp78oJ0Ca1H2aeMz396N/jw1gCUBBAiorM+rBpCtuW
	5TLIavSJlbmhbbDBGHLiHhd5OXSBtwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702508378;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/G1zoSxec1514q6TB09yptRlAvD+e6c83yZ6Bpuu3iM=;
	b=+9qrA6CHlbwr1WUyN4kxTrBYBm9QMUfAUVRmbonZSKOJilAq86Kkzl5IA5We+uxF+RMghS
	yP228K5JepNj2pAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 028F81391D;
	Wed, 13 Dec 2023 22:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BqthAFo3emWEOgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 13 Dec 2023 22:59:38 +0000
Date: Wed, 13 Dec 2023 23:52:42 +0100
From: David Sterba <dsterba@suse.cz>
To: David Disseldorp <ddiss@suse.de>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: validate scrub_speed_max sysfs string
Message-ID: <20231213225242.GJ3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231207135522.GX2751@twin.jikos.cz>
 <20231208004156.9612-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208004156.9612-1-ddiss@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Score: -2.48
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.72
X-Spamd-Result: default: False [-1.72 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.72)[83.61%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]

On Fri, Dec 08, 2023 at 11:41:56AM +1100, David Disseldorp wrote:
> Fail the sysfs I/O on any trailing non-space characters.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Added to misc-next a few days ago with updated changelog with reasoning
based on the recent discussions why we want the memparse and suffixes.
Thanks.

