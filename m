Return-Path: <linux-btrfs+bounces-2308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF91C850C8C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 02:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9891328233F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 01:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C75715B3;
	Mon, 12 Feb 2024 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oQIdC/ay";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AIQtcroQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oQIdC/ay";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AIQtcroQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F8ECC;
	Mon, 12 Feb 2024 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707700699; cv=none; b=VdhVfVUAyEsk9kJ/NOOjc36uAQqtRFE6+lOnR8s4hb4LJV/Geq1hem36Mx7/FOzki5vF+7/K2NEwj/bk+eLVOQm6vphYgOgkMLw4JrVKg7x7B77onbxC0ocxhrl+tP45Dq9zPd6FOqVGq9Mqj/F9d0PrWsrvzYQsVflib7aUUh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707700699; c=relaxed/simple;
	bh=X8RxdkJ1f3GC/Mfkg3bDudPHmZhEkyhgPou98/1cj/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUY8LDY5eD++EvwPygAa4xCg9AIDqsqiXPncbATp6GsYVqHtyaPa+NL2A4MHhumX+Ov8TYxUEWM5uuteb16CARUzA7YYAyfgV0s+7hJZDAl7TQkSsGzMTaYY8lvPqzaOEpKDA6I3/EatAmRYRNIX7AXX1FyPQbVxT9XqtrL9BDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oQIdC/ay; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AIQtcroQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oQIdC/ay; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AIQtcroQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9705021F14;
	Mon, 12 Feb 2024 01:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707700695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8RxdkJ1f3GC/Mfkg3bDudPHmZhEkyhgPou98/1cj/o=;
	b=oQIdC/aykkr3AKWSWVD7djom4xgBEGB153u7plb+G4+xRdHR+thmfbuAeuYuQhPpWTlr8h
	gv1QRMPdI/MzL14cLLh/gBbk9ZWLEkmlQhmvEX0BNKJylFy7gwjCFKiTzGRWKt4fAvbCyP
	QeVUKkbf4yDFhPpIEtGTRmvj/sJYldU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707700695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8RxdkJ1f3GC/Mfkg3bDudPHmZhEkyhgPou98/1cj/o=;
	b=AIQtcroQN/CWby1kPKOYhqDtBPm6i3wq7v8ILq4j9SgF/zAXX+KTYPEQWuR1nqNrXVVNZO
	SQFoN5dk8GldNnDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707700695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8RxdkJ1f3GC/Mfkg3bDudPHmZhEkyhgPou98/1cj/o=;
	b=oQIdC/aykkr3AKWSWVD7djom4xgBEGB153u7plb+G4+xRdHR+thmfbuAeuYuQhPpWTlr8h
	gv1QRMPdI/MzL14cLLh/gBbk9ZWLEkmlQhmvEX0BNKJylFy7gwjCFKiTzGRWKt4fAvbCyP
	QeVUKkbf4yDFhPpIEtGTRmvj/sJYldU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707700695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8RxdkJ1f3GC/Mfkg3bDudPHmZhEkyhgPou98/1cj/o=;
	b=AIQtcroQN/CWby1kPKOYhqDtBPm6i3wq7v8ILq4j9SgF/zAXX+KTYPEQWuR1nqNrXVVNZO
	SQFoN5dk8GldNnDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A255813985;
	Mon, 12 Feb 2024 01:18:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wTfPFNVxyWXlEgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 12 Feb 2024 01:18:13 +0000
Date: Mon, 12 Feb 2024 12:18:06 +1100
From: David Disseldorp <ddiss@suse.de>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana
 <fdmanana@suse.com>
Subject: Re: [PATCH] generic/736: fix a buffer overflow in
 readdir-while-renames.c
Message-ID: <20240212121806.687b4987@echidna>
In-Reply-To: <eff8549698ca7a61089e17727b3e1d45a4839e6f.1707650891.git.fdmanana@suse.com>
References: <eff8549698ca7a61089e17727b3e1d45a4839e6f.1707650891.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.24
X-Spamd-Result: default: False [-1.24 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.44)[78.67%]
X-Spam-Flag: NO

Reviewed-by: David Disseldorp <ddiss@suse.de>

