Return-Path: <linux-btrfs+bounces-1144-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF0681EF35
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 14:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6BF1C22686
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50BD45014;
	Wed, 27 Dec 2023 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iivKLR5A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7tXlNvUb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iivKLR5A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7tXlNvUb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65044C83;
	Wed, 27 Dec 2023 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE2EF1F8B6;
	Wed, 27 Dec 2023 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703683573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xBYm1u5Rw869qRruMxfiUFL7EWn/HQI/eICvgRTHTT8=;
	b=iivKLR5AO3Wq1L1KfGnFCCE4xB/2ywrIbsZ8gAdwiSvpoGF5eeeKc1adysRAVHbBsCC1O7
	sKOiN2TPYUvzWp0bd1JnBrc1CQXpGSRyrZW48t7wEP5YGcs6dV0X+sP90PL7/U0egkKuxA
	tvp4xS1rXyJy8nPgiVkOt2PIcOq8ytk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703683573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xBYm1u5Rw869qRruMxfiUFL7EWn/HQI/eICvgRTHTT8=;
	b=7tXlNvUb5927QDMowfWXjL3gWlNbU44hWg2CxiL7TK7m/fJZ8zlnHUwOIfq/yTBUASkJ8q
	hsNZEdSd1pu2dYCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703683573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xBYm1u5Rw869qRruMxfiUFL7EWn/HQI/eICvgRTHTT8=;
	b=iivKLR5AO3Wq1L1KfGnFCCE4xB/2ywrIbsZ8gAdwiSvpoGF5eeeKc1adysRAVHbBsCC1O7
	sKOiN2TPYUvzWp0bd1JnBrc1CQXpGSRyrZW48t7wEP5YGcs6dV0X+sP90PL7/U0egkKuxA
	tvp4xS1rXyJy8nPgiVkOt2PIcOq8ytk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703683573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xBYm1u5Rw869qRruMxfiUFL7EWn/HQI/eICvgRTHTT8=;
	b=7tXlNvUb5927QDMowfWXjL3gWlNbU44hWg2CxiL7TK7m/fJZ8zlnHUwOIfq/yTBUASkJ8q
	hsNZEdSd1pu2dYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F1CA13281;
	Wed, 27 Dec 2023 13:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DsrXA/IljGXxJQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 27 Dec 2023 13:26:10 +0000
Date: Thu, 28 Dec 2023 00:26:03 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM
Subject: Re: [PATCH 1/3] kstrtox: introduce a safer version of memparse()
Message-ID: <20231228002603.059bfb1c@echidna>
In-Reply-To: <7fd6e5cf2b7258c3c076334f443d5fee7b1086d6.1703324146.git.wqu@suse.com>
References: <cover.1703324146.git.wqu@suse.com>
	<7fd6e5cf2b7258c3c076334f443d5fee7b1086d6.1703324146.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spam-Score: -1.10
X-Spamd-Result: default: False [-1.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.30)[75.02%]
X-Spam-Flag: NO

On Sat, 23 Dec 2023 20:28:05 +1030, Qu Wenruo wrote:

> +	s = _parse_integer_fixup_radix(s, &base);
> +	rv = _parse_integer(s, base, &value);
> +	if (rv & KSTRTOX_OVERFLOW)
> +		return -ERANGE;
> +	if (rv == 0)
> +		return -EINVAL;

I was playing around with your unit tests and noticed that "0xG" didn't
reach the expected rv == 0 -> -EINVAL above. It seems that
_parse_integer_fixup_radix() should handle 0x<non hex> differently, or
at least step past any autodetected '0' octal prefix.

Cheers, David

