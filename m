Return-Path: <linux-btrfs+bounces-11973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D2A4BA2B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 10:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0C616B542
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01031EA7E3;
	Mon,  3 Mar 2025 09:01:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FCE757EA
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992475; cv=none; b=RC9UypFlN44QldIXnThgNL1nTYlNKD5FPOS+zS4DQTY6vQyCZMxUKop2GZXCbbhP3MpK7jaobWOaaT3ZZJFrPz09RZ6smMzdiMlQiDGfS27U0haOg8yPhyF8tlHXhu7vTaAYjHr0wn5GzA9ctGk4FPm6gylw1h9K5dBmIKyfHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992475; c=relaxed/simple;
	bh=/u5mfrdz34QMsXvaL5KHwjBrlRrLfjk3Wgllo7RxTjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXXxYMRaptNXuGkPbIZ+NM6oL2jtm0WmhEDG145s+u8h4pT6VjlqSIiQpEA5TutInFiFebnmScCuFzfrcqG7BkBe3ud4yzaF1IQjNdzaDw+rt20EnUbeOxZYGnVrBAgtFc2OZU3TfRsQg7rH3hpL1YTVweamIkGb34KCLm1WHYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F3B421180;
	Mon,  3 Mar 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45EE713939;
	Mon,  3 Mar 2025 09:01:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +7zWENhvxWcueQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 03 Mar 2025 09:01:12 +0000
Date: Mon, 3 Mar 2025 10:01:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/8] btrfs: make subpage handling be feature full
Message-ID: <20250303090102.GU5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740990125.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740990125.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5F3B421180
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Mon, Mar 03, 2025 at 07:05:08PM +1030, Qu Wenruo wrote:
> [CHANGLOG]
> v3:
> - Drop the btrfs uncached write support
>   It turns out that we can not move the folio_end_writeback() call out
>   of the spinlock for now.
> 
>   Two or more async extents can race on the same folio to call
>   folio_end_writeback() if not protected by a spinlock, can be
>   reproduced by generic/127 run loops with experimental 2k block size
>   patchset.
> 
>   Thus disabling uncached write is the smallest fix for now, and drop
>   the previous calling-folio_end_writeback()-out-of-spinlock fix.
> 
>   Not sure if a full revert is better or not, there is still some valid
>   FGP flag related cleanup in that commit.

Let's keep it, the more compelling reason is that we want uncached
writes so we'll have the groundwork for that and ready for testing.

Do you intend to push v3 to for-next for 6.15? I know you removed the
v2, we can postpone it if there are more potential problems.

