Return-Path: <linux-btrfs+bounces-21305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDF5GfGVgWl/HAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21305-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 07:30:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBF6D53E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 07:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35C413096BBF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 06:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147037AA97;
	Tue,  3 Feb 2026 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jPngkz7t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wv337tVx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jPngkz7t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wv337tVx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE061E5724
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 06:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100046; cv=none; b=BMkZjQJavKfMXj/Zu7tZIl/9JNzqd3LNXE/5FTxnaS/VsmBgqvDEqZYbIFZCF1KFzmJlqIWx6793qwIQ3NOhDZlW0woIJo+7LZ2dhTCIY7Wmcet9BdvlIFVjGhxQcey0356Ke2jbxfmRiMppELZUXmVUmdH8+spOIcPBw0JRxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100046; c=relaxed/simple;
	bh=M9W7uFZ3pAkWSHknFPCXqED3Z5X8LE+Q7FsVmnRbNW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWGMF8GhCTOK/MdQDdlSVICguWIc9pX5r8nlZ+AuyE48WS1QIr0lOzWjCcaOVXMndbAdrE4d5Z2AefA81q5ov1HdkRz3qKCHiqnwq1Iya0g0yWA0gB74Z8VYp3TJwMq1HtX+sL8DIWU+mwu/VmK3H+Q7cJd5wqaWb7yrFbvIg0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jPngkz7t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wv337tVx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jPngkz7t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wv337tVx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 631835BCC6;
	Tue,  3 Feb 2026 06:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770100043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25h1LnW2DsDCgtqXxViZ7VLVGlV926vxDzEqNo0VCAQ=;
	b=jPngkz7tIbAmOqtwdpn+k95UCQDQpQ9oc0rzkVuXhkMEzyRcgNJGfS/9Ttiw1XN4ceg2Ir
	Si6o/znojNV+i/SreHK3TzR/i3rGu7HtHjlM5JClanhdfcHtG9i1GVSWxBsEmnQW9vUThV
	VLWYhLu0Wz8Zv6s7EcCiL/SIPpdNwBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770100043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25h1LnW2DsDCgtqXxViZ7VLVGlV926vxDzEqNo0VCAQ=;
	b=Wv337tVxsx2OMw40Qpq0G3OIGox9f5loANl0zUe8Ysj+tyU8I0bthflB5pT6wSrb94+9CF
	bq0+Y6IoAzEMijDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jPngkz7t;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Wv337tVx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770100043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25h1LnW2DsDCgtqXxViZ7VLVGlV926vxDzEqNo0VCAQ=;
	b=jPngkz7tIbAmOqtwdpn+k95UCQDQpQ9oc0rzkVuXhkMEzyRcgNJGfS/9Ttiw1XN4ceg2Ir
	Si6o/znojNV+i/SreHK3TzR/i3rGu7HtHjlM5JClanhdfcHtG9i1GVSWxBsEmnQW9vUThV
	VLWYhLu0Wz8Zv6s7EcCiL/SIPpdNwBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770100043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25h1LnW2DsDCgtqXxViZ7VLVGlV926vxDzEqNo0VCAQ=;
	b=Wv337tVxsx2OMw40Qpq0G3OIGox9f5loANl0zUe8Ysj+tyU8I0bthflB5pT6wSrb94+9CF
	bq0+Y6IoAzEMijDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AC6B3EA62;
	Tue,  3 Feb 2026 06:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hc6fDUuVgWncSQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Feb 2026 06:27:23 +0000
Date: Tue, 3 Feb 2026 07:27:18 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] btrfs: tests: zoned: add selftest for zoned code
Message-ID: <20260203062718.GK26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260126054953.2245883-1-naohiro.aota@wdc.com>
 <20260126054953.2245883-5-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126054953.2245883-5-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21305-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Queue-Id: 0DBF6D53E0
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 02:49:53PM +0900, Naohiro Aota wrote:
> Add a test function for the zoned code, for now it tests
> btrfs_load_block_group_by_raid_type() with various test cases. The
> load_zone_info_tests[] array defines the test cases.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Thies patch had some conflicts in for-next and I also accidentally did
not add it to misc-next. Still I'd like to add it to the 6.20/7.0 queue.
It's too late for the first batch, please refresh the patch and resend
on top of for-next, I'll send it in 2nd pull request some time during
the merge window. Thanks.

