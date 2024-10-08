Return-Path: <linux-btrfs+bounces-8644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFF299541C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 18:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5A0B28B14
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2891E1313;
	Tue,  8 Oct 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0+X2TMDJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yJ4bs5dI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0+X2TMDJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yJ4bs5dI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E41E0E09;
	Tue,  8 Oct 2024 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403841; cv=none; b=CNQmR4ruL5fKiy1UBTuUf06nQ6zgLPrEscOXJlOSgxtPISMr6SWfuCnC+A5aaMSG/YjZMYH3GlbXTkAdwSp8U+9IFcqanYmFxNRi4kHW4B+9n9hRdun2+Z9Xg09/fsV+iXrphFcmJY2UvnhtTI2XgtpiKWtLXTI49hhGvJdRYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403841; c=relaxed/simple;
	bh=gctuw2elVipMW4NLdMwRY4b4B2lcHzupRXgkVDRPJwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjQ381Icuth01syWexUQYAkqZZK3LWrSA5HPUpiQhlF4f8K38MK23mMRK5DSfTpU85jMzwrO8cXq05+POEFYZDpWm8AT06J+kf0YEgE+ScwX3S17/2A/dLVAXkoLOp+iPcSDZAyHNka63fZjdwKUpwMSNRSOicGhLohAOQHZjs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0+X2TMDJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yJ4bs5dI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0+X2TMDJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yJ4bs5dI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF2291FB64;
	Tue,  8 Oct 2024 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728403837;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNr0uQOXBSHoSllotYSzKawgJJkcCx9f7HtFzhtE5PE=;
	b=0+X2TMDJz0L4ZF+3dLYsK8Bw2Cx9t5eCpdmeNSV5mDOcanZw2U+HP475/d4QpmHRwtW0j2
	B+xA1GG27WQhcC1Yh+6KXGmykvvjhRbGdgxVWw6jtMFh9aj/q8kDk7fY02Nl6lACpomE/4
	aALUlbv4spxajR7fJv4rxtFOPe2BiVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728403837;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNr0uQOXBSHoSllotYSzKawgJJkcCx9f7HtFzhtE5PE=;
	b=yJ4bs5dIlDh0Kx92XjV5ODzXW92Ebd8QThgXuoOvDL2cN15CfX8iUKJACbwUV3JRI4T3cV
	XrFTCyAIQYoTIAAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728403837;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNr0uQOXBSHoSllotYSzKawgJJkcCx9f7HtFzhtE5PE=;
	b=0+X2TMDJz0L4ZF+3dLYsK8Bw2Cx9t5eCpdmeNSV5mDOcanZw2U+HP475/d4QpmHRwtW0j2
	B+xA1GG27WQhcC1Yh+6KXGmykvvjhRbGdgxVWw6jtMFh9aj/q8kDk7fY02Nl6lACpomE/4
	aALUlbv4spxajR7fJv4rxtFOPe2BiVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728403837;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNr0uQOXBSHoSllotYSzKawgJJkcCx9f7HtFzhtE5PE=;
	b=yJ4bs5dIlDh0Kx92XjV5ODzXW92Ebd8QThgXuoOvDL2cN15CfX8iUKJACbwUV3JRI4T3cV
	XrFTCyAIQYoTIAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B539A1340C;
	Tue,  8 Oct 2024 16:10:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M48ILH1ZBWf2QgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Oct 2024 16:10:37 +0000
Date: Tue, 8 Oct 2024 18:10:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v4 04/28] range: Add range_overlaps()
Message-ID: <20241008161032.GB1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-4-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-4-c261ee6eeded@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Oct 07, 2024 at 06:16:10PM -0500, Ira Weiny wrote:
> --- a/include/linux/range.h
> +++ b/include/linux/range.h
> +/* True if any part of r1 overlaps r2 */
> +static inline bool range_overlaps(struct range *r1, struct range *r2)

I've noticed only now, you can constify the arguments, but this applise
to other range_* functions so that can be done later in one go.

> +{
> +	return r1->start <= r2->end && r1->end >= r2->start;
> +}

