Return-Path: <linux-btrfs+bounces-13797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8006EAAE759
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 19:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A236E9E17C2
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AB528C5B7;
	Wed,  7 May 2025 17:02:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350A28B50B
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637347; cv=none; b=nVqVkaBkBTrNpVA320zM/gQnezOEpYPmgkYMEahLp0vDB+w/8qwlFwkQ1tZSSwv9J06LUlg0RlAxNFF9ba3r/wGuTe1K6Idv0wrH0iJooOFAmHHqsg1C6H/FvpTD5jNq+fzIXiSC4uD4dJzPYYOWz1qIGLPrDQT0dgRD0W+K7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637347; c=relaxed/simple;
	bh=nbaGA1DNhqBfyJfgBXEjnvt0arktQioD/6JAQjlU1BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnCQ1wpoXT2sP8Bka5Xg2ra7k6NYKap1Wg2Jeabubq2kshX5z5qoAU1q0uPMOeW/CL8A1Uj2kYRmzadC4mIC7tLY2bTHTxg++6Xrl3NkqxZPwyOybxwxGAzG242h2bLT2lY+ZYz0QtC8YMgOY5uPBv263DrR1uPU9wnwZ78Zixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB7211F441;
	Wed,  7 May 2025 17:02:23 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B48FA13882;
	Wed,  7 May 2025 17:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3ZzPKx+SG2h4AwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 May 2025 17:02:23 +0000
Date: Wed, 7 May 2025 19:02:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-btrfs@vger.kernel.org, riteshh@linux.ibm.com,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, disgoel@linux.vnet.ibm.com
Subject: Re: [next-20250506][btrfs] Kernel OOPS while btrfs/001 TC
Message-ID: <20250507170222.GJ9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <75b94ef2-752b-4018-9b2a-148ecda5e8f4@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75b94ef2-752b-4018-9b2a-148ecda5e8f4@linux.ibm.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DB7211F441
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

On Wed, May 07, 2025 at 02:14:34PM +0530, Venkat Rao Bagalkote wrote:
> Hello,
> 
> 
> I am observing kernel OOPS, while running btrfs/001 TC, from xfstests suite.
> 
> 
> This issue is introduced in next-20250506. This issue is not seen on 
> next-20250505 kernel.

Thanks for the report, the patch has been removed from linux-next.

> [  968.074163] NIP [c00800000f7fb5e0] btrfs_get_tree_subvol+0x32c/0x544 > [btrfs]
> [  968.074205] LR [c00800000f7fb3b4] btrfs_get_tree_subvol+0x100/0x544 > [btrfs]
> [  968.074241] Call Trace:
> [  968.074244] [c000000154747bc0] [c00800000f7fb3b4] > btrfs_get_tree_subvol+0x100/0x544 [btrfs] (unreliable)

This was the open coded fc_mount(), v3 is in the mailinglist,
https://lore.kernel.org/linux-btrfs/20250506195826.GU2023217@ZenIV/T/#u

