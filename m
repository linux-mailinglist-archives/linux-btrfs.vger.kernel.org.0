Return-Path: <linux-btrfs+bounces-2963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D3E86E0CB
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 13:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024AC284A23
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B096D1C8;
	Fri,  1 Mar 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ems+qwpn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FBQp8Cxu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ems+qwpn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FBQp8Cxu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577ED6BFA4
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709294511; cv=none; b=JXsuSHUbB3/2areoInb0lp3ymykVCnSEFUSHLKD8Lz3M49RbBMjMCUjXHx7ewULI3gkUKvWzYLp7nyoZqqWODG47qyEYBpbZiZs2h367j6cuCv9Z/o/tvx8dWxQqZIN94y/qQT1EdRcDVQwlUDa2oUkBP4LicVMjU/S/Dp6RswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709294511; c=relaxed/simple;
	bh=sJ5mY5QLiO4qSmqG54WKMOCx7doYSgDpz34poACOJXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0zAhSIaXxYs3OBftzEupZpxcWlgqgamiCJyIThARtdEx8J7XqkE8YDo4dnpRqZaOHXxkGA7y536cDpkYuZcvZ8LiQJ1nmbGkArjUEWtI7ceLqV1+QWgbyk1bOO2YNM40lvE3Z5q5YUzxvd6jWQ14hJWj0bbzaOVw7tE0qgFydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ems+qwpn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FBQp8Cxu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ems+qwpn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FBQp8Cxu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E1C1202DE;
	Fri,  1 Mar 2024 12:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709294506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3EEvYjembzBnWO2cvHdGidlkvcG8ousjKQ7d8ck5Jk=;
	b=Ems+qwpnw9rw04QWa3PGWuxR3SKB3iZL8Kiz2KQ0N02thpf39L7GDJJPcKqZEit0mu98L/
	JFRWSLR5852zxsIPGN0kxVhcvoTzI4nqt/DVrQsB3QXGL5+f+zRA6Ba9FcytvwVI7xWnIM
	i/oH41skRXhCw7fGPkR88NIOBIRNxb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709294506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3EEvYjembzBnWO2cvHdGidlkvcG8ousjKQ7d8ck5Jk=;
	b=FBQp8CxuTM0qtmV53j3xQ0RVesTEoQeWaH/ASKF3sSPFKbNaJ4mF4DbdyshOQWiF+Dl4S/
	2K1YVwcmHTbSNNAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709294506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3EEvYjembzBnWO2cvHdGidlkvcG8ousjKQ7d8ck5Jk=;
	b=Ems+qwpnw9rw04QWa3PGWuxR3SKB3iZL8Kiz2KQ0N02thpf39L7GDJJPcKqZEit0mu98L/
	JFRWSLR5852zxsIPGN0kxVhcvoTzI4nqt/DVrQsB3QXGL5+f+zRA6Ba9FcytvwVI7xWnIM
	i/oH41skRXhCw7fGPkR88NIOBIRNxb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709294506;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3EEvYjembzBnWO2cvHdGidlkvcG8ousjKQ7d8ck5Jk=;
	b=FBQp8CxuTM0qtmV53j3xQ0RVesTEoQeWaH/ASKF3sSPFKbNaJ4mF4DbdyshOQWiF+Dl4S/
	2K1YVwcmHTbSNNAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F15F13581;
	Fri,  1 Mar 2024 12:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3vVpB6rD4WVxPQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 01 Mar 2024 12:01:46 +0000
Date: Fri, 1 Mar 2024 12:54:42 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs-progs: forget removed devices
Message-ID: <20240301115442.GI2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1709231441.git.boris@bur.io>
 <751eba3d-c72e-475b-8d21-e15c1d085ce0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751eba3d-c72e-475b-8d21-e15c1d085ce0@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ems+qwpn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FBQp8Cxu
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
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
	 BAYES_HAM(-0.00)[22.05%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2E1C1202DE
X-Spam-Level: 
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Fri, Mar 01, 2024 at 08:01:44AM +0530, Anand Jain wrote:
> On 3/1/24 00:06, Boris Burkov wrote:
> > To fix bugs in multi-dev filesystems not handling a devt changing under
> > them when a device gets destroyed and re-created with a different devt,
> > we need to forget devices as they get removed.
> > 
> > Modify scan -u to take advantage of the kernel taking unvalidated block
> > dev names and modify udev to invoke this scan -u on device remove.
> > 
> 
> Unless we have a specific bug still present after the patch
> "[PATCH] btrfs: validate device maj:min during open," can we
> hold off on using the external udev trigger to clean up stale
> devices in the btrfs kernel?
> 
> IMO, these loopholes have to be fixed in the kernel regardless.

Agreed, spreading the solution to user space and depending on async
events would only make things harder to debug in the end.

