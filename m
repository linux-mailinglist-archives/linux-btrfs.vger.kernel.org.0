Return-Path: <linux-btrfs+bounces-1192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07AA822024
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 18:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C5B1C21526
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0856156DF;
	Tue,  2 Jan 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EJ13W6gM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Up454Kk0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EJ13W6gM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Up454Kk0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B6E156CD;
	Tue,  2 Jan 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09D341FD03;
	Tue,  2 Jan 2024 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704215458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14LYxny+6mPtUBpqxYMsy5Ef9aHGTsQH1pgAh5isxYk=;
	b=EJ13W6gMVSHX9UXDl2/WZ/zkhi25Uq3daMmjjwofaQz926R9mOxRT/fb8P6XAOIvrlUeWc
	+uONm9H0kWdHQG3Q1Hg5pv/M9HLNSi+K4TgZEoIdH2FuNciPmv4riMOxsCywXNCzUb35HL
	+W+s1quUYJ/WjWk3KFifXWEOWE8k7PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704215458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14LYxny+6mPtUBpqxYMsy5Ef9aHGTsQH1pgAh5isxYk=;
	b=Up454Kk0yAIUOfIGNVHyCxtoPY8Vs4o5Ej8he98hc69SBqbcAOKN+lQeaq4KAyalRcgxs+
	o0sRfDMHX7igv/AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704215458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14LYxny+6mPtUBpqxYMsy5Ef9aHGTsQH1pgAh5isxYk=;
	b=EJ13W6gMVSHX9UXDl2/WZ/zkhi25Uq3daMmjjwofaQz926R9mOxRT/fb8P6XAOIvrlUeWc
	+uONm9H0kWdHQG3Q1Hg5pv/M9HLNSi+K4TgZEoIdH2FuNciPmv4riMOxsCywXNCzUb35HL
	+W+s1quUYJ/WjWk3KFifXWEOWE8k7PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704215458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14LYxny+6mPtUBpqxYMsy5Ef9aHGTsQH1pgAh5isxYk=;
	b=Up454Kk0yAIUOfIGNVHyCxtoPY8Vs4o5Ej8he98hc69SBqbcAOKN+lQeaq4KAyalRcgxs+
	o0sRfDMHX7igv/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5E1713AC6;
	Tue,  2 Jan 2024 17:10:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DS4qK6FDlGVoCwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Jan 2024 17:10:57 +0000
Date: Tue, 2 Jan 2024 18:10:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
	andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM,
	ddiss@suse.de
Subject: Re: [PATCH v2 0/4] kstrtox: introduce memparse_safe()
Message-ID: <20240102171046.GB15380@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1704168510.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1704168510.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EJ13W6gM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Up454Kk0
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 09D341FD03

On Tue, Jan 02, 2024 at 02:42:10PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Make _parse_integer_fixup_radix() to always treat "0x" as hex
>   This is to make sure invalid strings like "0x" or "0xG" to fail
>   as expected for memparse_safe().
>   Or they would only parse the first 0, then leaving "x" for caller
>   to handle.
> 
> - Update the test case to include above failure cases
>   This including:
>   * "0x", just hex prefix without any suffix/follow up chars
>   * "0xK", just hex prefix and a stray suffix
>   * "0xY", hex prefix with an invalid char
> 
> - Fix a bug in btrfs' conversion to memparse_safe()
>   Where I forgot to delete the old memparse() line.
> 
> - Fix a compiler warning on m68K
>   On that platform, a pointer (32 bits) is smaller than unsigned long long
>   (64 bits), which can cause static checker to warn.
> 
> Function memparse() lacks error handling:
> 
> - If no valid number string at all
>   In that case @retptr would just be updated and return value would be
>   zero.
> 
> - No overflown detection
>   This applies to both the number string part, and the suffixes part.
>   And since we have no way to indicate errors, we can get weird results
>   like:
> 
>   	"25E" -> 10376293541461622784 (9E)
> 
>   This is due to the fact that for "E" suffix, there is only 4 bits
>   left, and 25 with 60 bits left shift would lead to overflow.
>   (And decision to support for that "E" suffix is already cursed)
> 
> So here we introduce a safer version of it: memparse_safe(), and mark
> the original one deprecated.
> Unfortunately I didn't find a good way to mark it deprecated, as with
> recent -Werror changes, '__deprecated' marco does not seem to warn
> anymore.
> 
> The new helper has the following advantages:
> 
> - Better overflow and invalid string detection
>   The overflow detection is for both the numberic part, and with the
>   suffix. Thus above "25E" would be rejected correctly.
>   The invalid string part means if there is no valid number starts at
>   the buffer, we return -EINVAL.
> 
> - Allow caller to select the suffixes, and saner default ones
>   The new default one would be "KMGTP", without the cursed and overflow
>   prone "E".
>   Some older code like setup_elfcorehdr() would benefit from it, if the
>   code really wants to only allow "KMG" suffixes.
> 
> - Keep the old @retptr behavior
>   So the existing callers can easily migrate to the new one, without the
>   need to do extra strsep() work.
> 
> - Finally test cases
>   The test case would cover more things other than the existing kstrtox
>   tests:
>   * The @retptr behavior
>     Either for bad cases, which @retptr should not be touched,
>     or for good cases, the @retptr is properly advanced,
> 
>   * Return value verification
>     Make sure we distinguish -EINVAL and -ERANGE correctly.
> 
> With the new helper, migrate btrfs to the interface, and since the
> @retptr behavior is the same, we won't cause any behavior change.

As long as the suffixed values work in sysfs I don't care how it is
implemented. The safe version is nice of course, but it applies to the
'E' suffix which is so uncommon that there's no practical effect.

