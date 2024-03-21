Return-Path: <linux-btrfs+bounces-3496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970208859ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 14:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FC11C21737
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BC284A20;
	Thu, 21 Mar 2024 13:26:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE012134CD
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027568; cv=none; b=W+oqStrW8hIbghaT+qre2+kqeBXE8Oh7NlCydvBJ9WDRolb1ay9gAlxwVf9tFITZB2+IqUE/2xFZJId/Dmf8tDJTuu/G9DBkPTgFEWSXzKF9tJQFCCnlGzV15gaivEXcM6zzr0ou2WBFS9bf4mpe3nyh9W3zuB4lhmRG8MtD95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027568; c=relaxed/simple;
	bh=gfKtmdRtxDxkVgVpm8P+wQLrv8R04K0nVOzISnmEQWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9FmpZ6dWZXbsTkwSathY+mKNgadD+sI7WHwaLGqn1gEzs5+tFSHf6RMVLx++K1rkVjusW0pH1/s550S6+7rgHeEDrmK4cTVW+vg9rs6nWF+SECAewWZs/h9bsYMc3mGN60MCw+EnYRIQxbaa0MM8nRv2S+AxnAMxo81h30kKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18CA8201C3;
	Thu, 21 Mar 2024 13:26:05 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4ADE136AD;
	Thu, 21 Mar 2024 13:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AVulHWs1/GWXWgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 21 Mar 2024 13:26:03 +0000
Date: Fri, 22 Mar 2024 00:25:44 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: reflink: disable cross-subvolume
 clone/dedupe for simple quota
Message-ID: <20240322002544.6904f696@echidna>
In-Reply-To: <74730c411b0fd87484c8d894878c5cd8bac1d434.1710992258.git.wqu@suse.com>
References: <74730c411b0fd87484c8d894878c5cd8bac1d434.1710992258.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 18CA8201C3
X-Spam-Flag: NO

On Thu, 21 Mar 2024 14:09:38 +1030, Qu Wenruo wrote:
...
> [REASON FOR RFC]
> I'm not sure how important the cross-subvolume clone functionality is in
> real-world.
> 
> But considering squota is mostly designed for container usage, in that
> case disabling cross-subvolume clone should be completely fine.

I think copy_file_range() is reasonably common nowadays, and this would
impact such workloads. I don't find the creator-subvol-pays simple quota
behaviour too confusing, so would vote too keep things as is.

Cheers, David

