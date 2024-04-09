Return-Path: <linux-btrfs+bounces-4068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E869A89DE2B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 17:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F901F2B735
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 15:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2103136678;
	Tue,  9 Apr 2024 15:06:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CCF135A4C
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675161; cv=none; b=boCUSG4kTMC2xmkBjNyeeffJmvn53SgtBcim94/PsYFmNlF4W048EzM0KXITZ79SsAXzzIJD1ih0DMjvRPGvbdvfpLPwxM1sFejkmdRpVZxAAjOH9lRRp+vUi+kwUM4u+P/IPCd3eMwolO0w2sOsTq4QGKhATHKq5b6KJYQOjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675161; c=relaxed/simple;
	bh=YhQLFoiSdI7vAt7n1g2IO5uM16pYPDRYbjq7Tymq71Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfKkrIL7kTLSOCxI2mUHe21if5ajsz4P88F/ZWopqRsXAu/xCuJdsSOmGMmqf0cwpW0MipmavL4pRP8e5Bw+OCiZomeYYtDOS9xc3k2ptS8NNV/FO8elQc4JTXGaeG1E383KC8YDTgv1xLKg/XKlMsA90Q7XZJ7UT8DKH+YRlFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 067F320A84;
	Tue,  9 Apr 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EFBD613253;
	Tue,  9 Apr 2024 15:05:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4DJfOlVZFWZAFQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 09 Apr 2024 15:05:57 +0000
Date: Tue, 9 Apr 2024 16:58:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/8] btrfs: rename extent_map::orig_block_len to
 disk_num_bytes
Message-ID: <20240409145832.GH3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1712614770.git.wqu@suse.com>
 <4087de32eabbf9f14988f69e33240db2d5576f5d.1712614770.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4087de32eabbf9f14988f69e33240db2d5576f5d.1712614770.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 067F320A84
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

On Tue, Apr 09, 2024 at 08:03:40AM +0930, Qu Wenruo wrote:
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -2872,7 +2872,7 @@ static inline void btrfs_remove_log_ctx(struct btrfs_root *root,
>  	mutex_unlock(&root->log_mutex);
>  }
>  
> -/* 
> +/*

There is a whitespace change but please check your patches that they
don't contain such fixups unless it's in the modified code. Thanks.

