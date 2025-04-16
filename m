Return-Path: <linux-btrfs+bounces-13102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE7DA90C26
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 21:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85ED7460ABA
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 19:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAACD224898;
	Wed, 16 Apr 2025 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZUYYaeOx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="56Y4hh7n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZoHDTDdq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dwhawIfc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2422224225
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831095; cv=none; b=lb8JGevVjPEZUeBSKB3A3y/bi67PrhOJWtys5yupK7J5NcEV4Ow4Y76k6zcDLzLIc1j21no8DY3oEx1CD2DBLToA9Rp4BHgS7Gs2W8q4/tZ8dj2tDiTiPdBMsRshsox9n9SMDFausCxDaOC957gEOJRtXp3If8UApuVckVs9XLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831095; c=relaxed/simple;
	bh=NTaDm5tBbgecLHnt8arUVLcM3RrzoaOtdVjVJnldkbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td4UNtKrJw+gHZrlbsLOaCldjNziYcDE85jHniLPsOTwQsCq6laQWSY5POm4fuN2I2pJreVf8uf9lbVEo1+k1Cg6M3UicAHAApVgXtWRrNPtr7RHuz+z9qNmvCdVBV2azTXcdRAG8gPuzQMPaFL8nE3vrcPqljoG3ro6ighwJiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZUYYaeOx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=56Y4hh7n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZoHDTDdq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dwhawIfc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E84FB1F785;
	Wed, 16 Apr 2025 19:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744831092;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8IPaPyE+OfvnDHSE3qkgcIYyIaQ8wn6xCXY7jAB77I=;
	b=ZUYYaeOxbpKHRCT+8iLby49lXQZoIVmmeh4+c7B8S2ly1bOGnqG4IRQT1zP9UjZtSdp3ER
	rGZagvmBhYKEn3KqCzxWf+HsSx7Z3LVQ/Xma8dC3Uogs6w8RQ2lL9hAt1X25+FUVI22p1Q
	f27pIIB1GYIBzY7ejuXq9heO6xi9/W8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744831092;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8IPaPyE+OfvnDHSE3qkgcIYyIaQ8wn6xCXY7jAB77I=;
	b=56Y4hh7nBI+TmljLL1HKpGBOaFSKBzmGHOUT261w+N50wJ4lwdKTYVrPi8/DQkVCJwkmbp
	zrZneNAcMYuOkQDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744831091;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8IPaPyE+OfvnDHSE3qkgcIYyIaQ8wn6xCXY7jAB77I=;
	b=ZoHDTDdq+2tQVDFQAskU1pOOf3nEyNaRIyuwMOZFSS5RiZ9iuokbXNS6t7EhgLs6LP67Kv
	Srs7/zgdmAP17o4LkY2ImjAF9vGhnJbW0sFkjzomDWoZ0BBR8nAnL4vQE/OSo728JCm0Sk
	t2EcRRUaJ93h5L0dLKbKrckVeQVtiGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744831091;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8IPaPyE+OfvnDHSE3qkgcIYyIaQ8wn6xCXY7jAB77I=;
	b=dwhawIfcIc6BQGIj3mR8fIWhJBjZ4LLD89A5F0t37hIereXLW/a392IbAfGGjlYngizQpo
	rtsjFTW72w0oVLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C15A113976;
	Wed, 16 Apr 2025 19:18:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yeGwLnMCAGj/HQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Apr 2025 19:18:11 +0000
Date: Wed, 16 Apr 2025 21:18:06 +0200
From: David Sterba <dsterba@suse.cz>
To: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] btrfs: remove
 BTRFS_REF_LAST from btrfs_ref_type
Message-ID: <20250416191806.GE13877@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250415083808.893050-1-frank.li@vivo.com>
 <472ae717-5494-44ae-973a-85249a65d289@gmx.com>
 <SEZPR06MB52691756B32BA90DBE82BDFDE8B22@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <2e158208-4914-4bfb-984a-0d35e8b93225@gmx.com>
 <20250415160508.GH16750@suse.cz>
 <SEZPR06MB52696AF210BDA98300C58FCFE8BD2@SEZPR06MB5269.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEZPR06MB52696AF210BDA98300C58FCFE8BD2@SEZPR06MB5269.apcprd06.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,fb.com,toxicpanda.com,suse.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Apr 16, 2025 at 01:25:34PM +0000, 李扬韬 wrote:
> > I think in this case it's ok to remove it, although I agree that we have the _LAST or _NR elsewhere. In btrfs_ref_type() tere's an assertion
> 
> >  ASSERT(ref->type == BTRFS_REF_DATA || ref->type == BTRFS_REF_METADATA);
> 
> > which is validating the values. There's no enumeration or switch that could utilize the upper bound.
> 
> Do I need to modify the submission information and resend this patch?

Yes please, the reasoning was missing from the original patch, we've
come to a conclusion in the discussion so this should be summarized in
v2.

