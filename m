Return-Path: <linux-btrfs+bounces-1187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833F7821D80
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 15:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388AE1F22CAB
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0B512B91;
	Tue,  2 Jan 2024 14:16:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526211722;
	Tue,  2 Jan 2024 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 478D81FD60;
	Tue,  2 Jan 2024 14:16:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24A201340C;
	Tue,  2 Jan 2024 14:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 86yjMMQalGWUXQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 02 Jan 2024 14:16:36 +0000
Date: Wed, 3 Jan 2024 01:16:22 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM
Subject: Re: [PATCH v2 1/4] kstrtox: always skip the leading "0x" even if no
 more valid chars
Message-ID: <20240103011622.144d62d0@echidna>
In-Reply-To: <f905131c211685efa59dfa43ffb3a619a283f914.1704168510.git.wqu@suse.com>
References: <cover.1704168510.git.wqu@suse.com>
	<f905131c211685efa59dfa43ffb3a619a283f914.1704168510.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 478D81FD60

On Tue,  2 Jan 2024 14:42:11 +1030, Qu Wenruo wrote:

> Currently the invalid string "0x" (only hex prefix, no valid chars
> followed) would make _parse_integer_fixup_radix() to treat it as octal.
> 
> This is due to the fact that the function would only auto-detect hex if
> and only if there is any valid hex char after "0x".
> Or it would only go octal instead.
> 
> Thankfully this won't affect our unit test, as "0x" would still be
> treated as failure.
> Since we treat the result as octal, the result value would be 0, leaving
> "x" as the tailing char and still fail kstrtox() functions.
> 
> But for the incoming memparse_safe(), the remaining string would still
> be consumed by the caller, and we need to properly treat "0x" as an
> invalid string.
> 
> So this patch would make _parse_integer_fixup_radix() to forcefully go
> hex no matter if there is any valid char following.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  lib/kstrtox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index d586e6af5e5a..41c9a499bbf3 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -27,7 +27,7 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
>  {
>  	if (*base == 0) {
>  		if (s[0] == '0') {
> -			if (_tolower(s[1]) == 'x' && isxdigit(s[2]))
> +			if (_tolower(s[1]) == 'x')
>  				*base = 16;
>  			else
>  				*base = 8;

There's a copy of this function in arch/x86/boot/string.c which should
probably remain consistent (or be removed). Aside from that, this looks
good to me:
Reviewed-by: David Disseldorp <ddiss@suse.de>

