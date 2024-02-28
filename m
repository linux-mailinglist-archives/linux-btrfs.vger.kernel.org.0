Return-Path: <linux-btrfs+bounces-2857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B24786B1AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 15:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BED46B22BCD
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3951586EF;
	Wed, 28 Feb 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b5bMS5ox";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nHKmRrkM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RwQb/LhB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8m0MA+Qs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41DA152E14
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Feb 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130281; cv=none; b=AupUSEX89B4qOSupWpLnqvDM4IAOEc9XHYufmesauctL7J3cqfJzMe4lOLuJEk/G7Lliq5Zp3Oiv2WhmhoEBth27/Gtw8sKnWMH8EiPYqqNlmpAE4T9QMEi8c07sXQomo8jqgPGRfEfn3qa7A4No96E28aCVLyImwrXU4Upg4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130281; c=relaxed/simple;
	bh=xT4EHbAH8I19VyW7wr6lsMkZ+Pzl3Qk3NjaGaZmTIxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK64vUMZi7SftjOtgPt7UjxBeyp4DHanAdEJpTW6+A592rCKc0iD/we7c+hlu93EdR8qxPE19s6LWBXw9wUjTMQTPmQBPkFmMDi+yxr6m1ULIniBRa3FyoyvfLLGPqKRd75+A8+aNAg7qORfovxUchDSMGUN3fNlgGhjHXccv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b5bMS5ox; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nHKmRrkM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RwQb/LhB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8m0MA+Qs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC0B21F79A;
	Wed, 28 Feb 2024 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709130278;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6BrJNHEAC/riTyu80DuBOpCNyEBCVcOVJp0olKRCMw=;
	b=b5bMS5oxTt7YMECKeevdpH1WtQ1rwRt2+Ut58LT2CIKRYOZp+0Ugc6hrYki569Up6vfLEB
	lH5MxY+ReWAtYV0JM1kgFEHa6XAtBCDOg3on32C1YX+KSr2ln80uwijGtmfFAhhSsgBSTU
	rYp97DoV4jJVqiNmecw+oP306powfrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709130278;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6BrJNHEAC/riTyu80DuBOpCNyEBCVcOVJp0olKRCMw=;
	b=nHKmRrkMbC7Kzhb3SCpkIrqw4uKmmQQq7jbv/ftgkS5liRl1T1KTtjD43khROii3ALcRLL
	kg+vWHZe1fhIDLDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709130277;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6BrJNHEAC/riTyu80DuBOpCNyEBCVcOVJp0olKRCMw=;
	b=RwQb/LhBHhO28W1Zm2qLhFnRQ0eI+FcKjfU5lvv64bLvbyWcEp9BvRx4J2DCIk0XgtgGkH
	pfszR+wqI9wIRiMv4Q4bHa2WKm2xNuIJTJT9sW/i45r0bxVAJP+2MRSiWPzJmlwWC6AoM8
	b08pgm0enlW8h3vCmaeXBerb9ppA9rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709130277;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6BrJNHEAC/riTyu80DuBOpCNyEBCVcOVJp0olKRCMw=;
	b=8m0MA+QsO4AnO7zzR/oaBFUhhMiQe+/bz/iHGYOIoosa9qCWXGBBihoHEEOOyr2tMq004V
	zGosNnxJpsElmvBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D225113A42;
	Wed, 28 Feb 2024 14:24:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YI0bMyVC32WmFgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 28 Feb 2024 14:24:37 +0000
Date: Wed, 28 Feb 2024 15:23:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2] btrfs: include device major and minor numbers in the
 device scan notice
Message-ID: <20240228142356.GM17966@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aaad3aefc570103b68559984307658bd2dd3df1f.1708838672.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaad3aefc570103b68559984307658bd2dd3df1f.1708838672.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="RwQb/LhB";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8m0MA+Qs
X-Spamd-Result: default: False [-2.96 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.95)[99.79%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EC0B21F79A
X-Spam-Level: 
X-Spam-Score: -2.96
X-Spam-Flag: NO

On Sun, Feb 25, 2024 at 12:28:31PM +0530, Anand Jain wrote:
> To better debug issues surrounding device scans, include the device's
> major and minor numbers in the device scan notice for btrfs.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: David Sterba <dsterba@suse.com>

