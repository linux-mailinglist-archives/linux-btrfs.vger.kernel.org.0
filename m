Return-Path: <linux-btrfs+bounces-6098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A34191E1CE
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 16:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267FE2851D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 14:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4C15F30F;
	Mon,  1 Jul 2024 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fp9lgaoc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VAfJPYBL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fp9lgaoc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VAfJPYBL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87F15EFB1
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842640; cv=none; b=XTOK3AtylnG8zmU6Cyp7DjUBNW0N/h09uMzdAntyVy3NPO0iL3AUXFJakwcSon0YhcDm7zL0xTg4zvkeCNqoP86ojnoLI5Tw6cjSDIKKSitgto15ETU8MqZyFLx7Yb0S7PTjtvbVE64tup8DTD4w/wQ7xS3VTJwvmRXBlKTM0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842640; c=relaxed/simple;
	bh=LhT/x2x3cWFKW1otv4ubasz0d+43zz9VRTMjgnxR8z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lM6b26fa8qwToWMkIqA1Rcf9jjLdEYXF1v/1rsO/qwN7bgr8DTPqKC0QrNqvp0Ds8r9IPubulRiuuFvX9kFLFWfsofbg1zwUvdMvh0XQ82pZ6910bJq5GKU6C38ekVzZSG51/xQJu9CrucapcFrJIF/O1bJjU5mheZiwzv1HuuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fp9lgaoc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VAfJPYBL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fp9lgaoc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VAfJPYBL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 996D821954;
	Mon,  1 Jul 2024 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719842636;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ajED9s3iCWsvPk61jCn28He1+/n/mMSQPdRkr4ksGA=;
	b=fp9lgaoc6v8gh+p2Q4gvdoIXOuAxr6lA777YktMtXLrq60UZjY9mX8ItebBrsgL4+MOw4Z
	pRmyhH2yJOjiiDtG/xDL5xUMT+p2vIWd7UzDhZm3CB269vgpgMZZLNJvnNmsIgIZdoiXgw
	DzVnxddkzHsF1IHKH/j7d1r5H47RlVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719842636;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ajED9s3iCWsvPk61jCn28He1+/n/mMSQPdRkr4ksGA=;
	b=VAfJPYBLQzDFwQqz3uox6d3eiA92e515aUf98Z6GiufCfJua4U2RxQLQk2yzaie46LpGbT
	RgK7YIddr+ifq1Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fp9lgaoc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VAfJPYBL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719842636;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ajED9s3iCWsvPk61jCn28He1+/n/mMSQPdRkr4ksGA=;
	b=fp9lgaoc6v8gh+p2Q4gvdoIXOuAxr6lA777YktMtXLrq60UZjY9mX8ItebBrsgL4+MOw4Z
	pRmyhH2yJOjiiDtG/xDL5xUMT+p2vIWd7UzDhZm3CB269vgpgMZZLNJvnNmsIgIZdoiXgw
	DzVnxddkzHsF1IHKH/j7d1r5H47RlVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719842636;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ajED9s3iCWsvPk61jCn28He1+/n/mMSQPdRkr4ksGA=;
	b=VAfJPYBLQzDFwQqz3uox6d3eiA92e515aUf98Z6GiufCfJua4U2RxQLQk2yzaie46LpGbT
	RgK7YIddr+ifq1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8826813800;
	Mon,  1 Jul 2024 14:03:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o40JIUy3gmZsZwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 01 Jul 2024 14:03:56 +0000
Date: Mon, 1 Jul 2024 16:03:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: rename the extra_gfp parameter of
 btrfs_alloc_page_array()
Message-ID: <20240701140347.GD21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1719548446.git.wqu@suse.com>
 <9533640304878bb57291dafc76ab0656892cf64a.1719548446.git.wqu@suse.com>
 <CAL3q7H6Nd7f3XEoPGgyovryvF0eMat+25++nwd3W=bSBDSActA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6Nd7f3XEoPGgyovryvF0eMat+25++nwd3W=bSBDSActA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 996D821954
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri, Jun 28, 2024 at 10:33:19AM +0100, Filipe Manana wrote:
> On Fri, Jun 28, 2024 at 5:22 AM Qu Wenruo <wqu@suse.com> wrote:
> >
> > There is only one caller utilizing the @extra_gfp parameter,
> > alloc_eb_folio_array().
> > And in that case the extra_gfp is only assigned to __GFP_NOFAIL.
> >
> > This patch would rename the @extra_gfp parameter to @nofail to indicate
> > that.
> 
> "would rename" -> renames

Ideally also leave out the whole 'This patch ...', I've been fixing that
when I notice it but I've just found more in now immutable patches so
it's obviously not perfect.

