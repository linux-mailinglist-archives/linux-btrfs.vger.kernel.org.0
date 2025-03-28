Return-Path: <linux-btrfs+bounces-12659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325B8A75009
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 19:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CF63BAF29
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F091DD0DC;
	Fri, 28 Mar 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gCyGI6uc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZLIi9IUE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gCyGI6uc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZLIi9IUE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5F1D6DA9
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184942; cv=none; b=uBBLMIS84IAGsAgE/OLW1/ayF/UZbEpSIqgjgKg/xScr4Tphh50q5r/JUnocnpDT6inlwYfQxUTvnvZr8p5dnF3ShhOCk7qpW9Sh3Z7TqZ8kpsjtAu0yFMCcW4tLKPjITYsDojBRn57fPSgZAxpEGd7vuWbDJZlEXbWT5N8HOh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184942; c=relaxed/simple;
	bh=6lQd11Y9xF2RgGqOZvXdT+H6PdK2acTcFl7qhzVfLCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSsx9UXIP9MB/wsC3lkjbCLxED0JeLaGvbHgaYbnYvwr3AxB+BPqw+D7Friyoq1mxeQ+NF3vaGC65Cj+GBBBB4DHdb59JEtlPdppYthMxui4LLNyratHfDZCjt3yQlcuVuij4iFUCgHGjUPP9Hhww3pUcCQQ62KHuRgOTp0TEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gCyGI6uc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZLIi9IUE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gCyGI6uc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZLIi9IUE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 577C4211C8;
	Fri, 28 Mar 2025 18:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743184938;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isyx4xQh1w4gf5Yr7sgvQ5gdvNcZb2x3/RnO6lezoJM=;
	b=gCyGI6ucctKw7Jaw4UYde8fvDDq2eDUqokEEJgOSrqJFRO5KuGWS/UeKqhxsgqB8QlXUJ5
	6zMrxoFWhtE/da28as44kFaWK6xmanvf3DhzaRgv9Tg+Gq7B9XvdXSiFkxvU25EXROHxwA
	8C2w+8g+KGlI21PUbFSCG+RMfW8yBQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743184938;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isyx4xQh1w4gf5Yr7sgvQ5gdvNcZb2x3/RnO6lezoJM=;
	b=ZLIi9IUEtut3ni0lHS08FjzM4KkecQYmIQfmuRndUddodVHCiDlQX+GFkGIJZeBBjSZyXt
	IU3CpDpgyb7rIrDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gCyGI6uc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZLIi9IUE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743184938;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isyx4xQh1w4gf5Yr7sgvQ5gdvNcZb2x3/RnO6lezoJM=;
	b=gCyGI6ucctKw7Jaw4UYde8fvDDq2eDUqokEEJgOSrqJFRO5KuGWS/UeKqhxsgqB8QlXUJ5
	6zMrxoFWhtE/da28as44kFaWK6xmanvf3DhzaRgv9Tg+Gq7B9XvdXSiFkxvU25EXROHxwA
	8C2w+8g+KGlI21PUbFSCG+RMfW8yBQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743184938;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isyx4xQh1w4gf5Yr7sgvQ5gdvNcZb2x3/RnO6lezoJM=;
	b=ZLIi9IUEtut3ni0lHS08FjzM4KkecQYmIQfmuRndUddodVHCiDlQX+GFkGIJZeBBjSZyXt
	IU3CpDpgyb7rIrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F1F113998;
	Fri, 28 Mar 2025 18:02:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x2IrDyrk5mezNgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 28 Mar 2025 18:02:18 +0000
Date: Fri, 28 Mar 2025 19:02:13 +0100
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@redhat.com>
Cc: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250328
Message-ID: <20250328180213.GH32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250328012637.23744-1-anand.jain@oracle.com>
 <20250328020312.psokbxpz5untmeey@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328020312.psokbxpz5untmeey@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 577C4211C8
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Fri, Mar 28, 2025 at 10:03:12AM +0800, Zorro Lang wrote:
> On Fri, Mar 28, 2025 at 09:26:24AM +0800, Anand Jain wrote:
> > Zorro,
> > 
> > Please pull this branch, which includes test cases for sysfs syntax
> > verification of btrfs read policy and chunk size. v4 has been on the
> > mailing list for a month now, along with fix from Filipe and Zoned
> > testcase from Johannes.
> > 
> > Please note that the commit:
> >  "fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch"
> > 
> > has the changes discussed with Naohiro, including his review-by tag,
> > (which is missing in your patches-in-queue branch).
> > 
> > Test case number for above commit is changed to btrfs/335 following
> > the integration of the sysfs patches.
> > 
> > Thank you.
> > 
> > The following changes since commit d71157da4ef4cfdbf39e2c4a07f8013633e6bcbe:
> > 
> >   common/rc: explicitly test for engine availability in _require_fio (2025-03-17 00:43:12 +0800)
> > 
> > are available in the Git repository at:
> > 
> >   https://github.com/asj/fstests/tree/staged-20250328 
> > 
> > for you to fetch changes up to 208a7f874df38bf873137d00634783422965a7ab:
> > 
> >   fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch (2025-03-28 08:25:55 +0800)
> > 
> > ----------------------------------------------------------------
> > Anand Jain (5):
> >       fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
> >       fstests: filter: helper for sysfs error filtering
> >       fstests: common/rc: add sysfs argument verification helpers
> >       fstests: btrfs: testcase for sysfs policy syntax verification
> >       fstests: btrfs: testcase for sysfs chunk_size attribute validation
> 
> Hi Anand, these 5 patches don't have any RVBs or ACKs. Do you miss that?
> Although you can ack patches by yourself, but these patches are from you,
> maintainers would better not push their own patches directly without any
> RVBs. So please let someone review and ack them at first.

Maintainers should be allowed to push their patches without RVB, that's
where the role and status adds value. In case of the generic/common
patches there was a discusison and an agreed solution, only the formal
RVB were missing. And in case of fstests it's IMNSHO an overkill, we
rather need the functional improvements, i.e. new test cases for the
specific filesystem without pointless delays and insisiting on reviews
or not trusting a dedicated maintainer with their own patches.

