Return-Path: <linux-btrfs+bounces-968-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEB28140EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 05:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415121C2237E
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 04:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D20663D0;
	Fri, 15 Dec 2023 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vuMD/A0d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nQF6h5E2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W/ETAg7D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S7DEMSIC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2C610D;
	Fri, 15 Dec 2023 04:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6E2E21FEA;
	Fri, 15 Dec 2023 04:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702614206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YLPmSYs18YcsRLgvb0K2o9nyXLwmqnrqPDlTANPjZo=;
	b=vuMD/A0d3d1SbmLx5g4DaLMiIUabw2N6mJYX6dPiO2AY9W7iffwR9uDtP2SrqoDtG1hc6D
	mcEXvZWYBAw9cSwGaibvqSuCCLmbeCvivQpL2n9gM4HNIqw4bha6AuTYVdYnYp0J7Yurxe
	4ZXin6hnEMdVgDnBPGsmNcLaRPskhpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702614206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YLPmSYs18YcsRLgvb0K2o9nyXLwmqnrqPDlTANPjZo=;
	b=nQF6h5E2ny9+I3768UVyITx9OeatKik7Aid1pHHdOI1NkhLdzC+sC17kYQXM/Q04bOWSPC
	mlzUB6DCp9OLVTAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702614205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YLPmSYs18YcsRLgvb0K2o9nyXLwmqnrqPDlTANPjZo=;
	b=W/ETAg7D6D+pLy+IWKBTRjE7Xbr/TK2YOgv6JnOpXl85sd8hUZoYircn9up9nwpgXttjzx
	TI5WaHM5vuln8mmIReNL25/3t+Qn38bMoSfDMR+A49iUsTkNyegkSIYarPnKs07ESTNoE0
	75l2JlAC0QXNSThGiGzOuEaOfJb8cn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702614205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YLPmSYs18YcsRLgvb0K2o9nyXLwmqnrqPDlTANPjZo=;
	b=S7DEMSICcI6fsfJJshYpzPYez2USYkMm9dYGQrNWoYz+4bu3Qjhqfs3B2SKgI4ywnEbFui
	ysvj+rhr4CFzmeCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C15813305;
	Fri, 15 Dec 2023 04:23:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id O9dnLrvUe2USUAAAn2gu4w
	(envelope-from <ddiss@suse.de>); Fri, 15 Dec 2023 04:23:23 +0000
Date: Fri, 15 Dec 2023 15:23:18 +1100
From: David Disseldorp <ddiss@suse.de>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: filter.btrfs: update
 _filter_transaction_commit()
Message-ID: <20231215152318.78149dec@echidna>
In-Reply-To: <20231215030951.449252-1-naohiro.aota@wdc.com>
References: <20231215030951.449252-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Score: -0.93
X-Spam-Flag: NO
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.22 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.18)[70.24%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.22

On Fri, 15 Dec 2023 12:09:51 +0900, Naohiro Aota wrote:
...
> diff --git a/common/filter.btrfs b/common/filter.btrfs
> index 02c6b92dfa94..cea9911448eb 100644
> --- a/common/filter.btrfs
> +++ b/common/filter.btrfs
> @@ -70,6 +70,7 @@ _filter_btrfs_device_stats()
>  
>  _filter_transaction_commit() {
>  	sed -e "/Transaction commit: none (default)/d" | \
> +	sed -e "s/Delete subvolume [0-9]\+/Delete subvolume/g" | \
>  	sed -e "s/Delete subvolume (.*commit):/Delete subvolume/g"
>  }
>  


Looks fine
Reviewed-by: David Disseldorp <ddiss@suse.de>

Nit: the pipe chain can be removed. It might also be a little simpler
if each version had an independent filter, e.g.
  sed -e "/Transaction commit: none (default)/d" \
      -e "s/Delete subvolume [0-9]\+ (.*commit)/Delete subvolume/g" \
      -e "s/Delete subvolume (.*commit):/Delete subvolume/g"

