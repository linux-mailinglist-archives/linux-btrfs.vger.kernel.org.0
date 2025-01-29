Return-Path: <linux-btrfs+bounces-11135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC1A21A3D
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 10:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5431C1888966
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5151ADFE4;
	Wed, 29 Jan 2025 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i5Mwxy/R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pmRhPydC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i5Mwxy/R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pmRhPydC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5161CAB3;
	Wed, 29 Jan 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738144018; cv=none; b=ABiyuxgAMYOQc6JH+syRX6mhQxQt4g+RQazOuoomRpPr0XoiR7V3b392xoAy3D1U7iGvCsJRYeXOFu15cfFHmFa1fmlQb6Xg1LIufScOQ4x06tzSH+TVJVZaZWLCw26EHIkU3GlVCFpWHwuy2VK6SPZjgBMaFWDfUDfU0HRiiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738144018; c=relaxed/simple;
	bh=2tmtqzDlpvJYjOhymjjxXT2d5hZdqgkkSfR6apUc4LU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCd9/zuf1WLHZRGVej8XZNqUaH/FxzQ428NpXrvi3vqEa/OsWydGdM3fZM6LZCzfKdVNHLhf/I6xSOpa6SDu0072ZG0Y9zQCiVi0MMEunae484Qh55IhKhUdTFBSTMkIK6oQnGg6RYDpUxYc1FLbZs7C/45mH17AstHNOTiCpwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i5Mwxy/R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pmRhPydC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i5Mwxy/R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pmRhPydC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8E0D210F5;
	Wed, 29 Jan 2025 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738144014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=i5Mwxy/RNBFOPwFWyefOclI67Mfl4LeClU7BnbzMU2Z49ioZnnFhEdIes2aDRWIG5Qpb0p
	rLBunYuvEC7qM4x5OkOhkaKWeK+V8WjsDgKTMLf0D51Ecutz5uFtjpJqDsgAbMqJDTQ7GK
	s83Yq9bri99hD1Q5u+s3qZtg9o5bDOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738144014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=pmRhPydCZ+RgrhzOPZu1wdQVPJGdMmu2lFLf4y8etatrnARzlhrJMUPMdZgyI5WSug4evo
	LP9tmUY05JKAOgCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738144014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=i5Mwxy/RNBFOPwFWyefOclI67Mfl4LeClU7BnbzMU2Z49ioZnnFhEdIes2aDRWIG5Qpb0p
	rLBunYuvEC7qM4x5OkOhkaKWeK+V8WjsDgKTMLf0D51Ecutz5uFtjpJqDsgAbMqJDTQ7GK
	s83Yq9bri99hD1Q5u+s3qZtg9o5bDOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738144014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=pmRhPydCZ+RgrhzOPZu1wdQVPJGdMmu2lFLf4y8etatrnARzlhrJMUPMdZgyI5WSug4evo
	LP9tmUY05JKAOgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6489C137DB;
	Wed, 29 Jan 2025 09:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C9NOFw35mWf7LAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 29 Jan 2025 09:46:53 +0000
Date: Wed, 29 Jan 2025 10:46:53 +0100
Message-ID: <87o6zq6jg2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,	Yaron Avizrat
 <yaron.avizrat@intel.com>,	Oded Gabbay <ogabbay@kernel.org>,	Julia Lawall
 <Julia.Lawall@inria.fr>,	Nicolas Palix <nicolas.palix@imag.fr>,	James Smart
 <james.smart@broadcom.com>,	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,	Jaroslav Kysela
 <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,	David Sterba <dsterba@suse.com>,	Ilya
 Dryomov <idryomov@gmail.com>,	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Jens Axboe <axboe@kernel.dk>,	Xiubo Li <xiubli@redhat.com>,	Damien Le Moal
 <dlemoal@kernel.org>,	Niklas Cassel <cassel@kernel.org>,	Carlos Maiolino
 <cem@kernel.org>,	"Darrick J. Wong" <djwong@kernel.org>,	Sebastian Reichel
 <sre@kernel.org>,	Keith Busch <kbusch@kernel.org>,	Christoph Hellwig
 <hch@lst.de>,	Sagi Grimberg <sagi@grimberg.me>,	Frank Li
 <Frank.Li@nxp.com>,	Mark Brown <broonie@kernel.org>,	Shawn Guo
 <shawnguo@kernel.org>,	Sascha Hauer <s.hauer@pengutronix.de>,	Pengutronix
 Kernel Team <kernel@pengutronix.de>,	Fabio Estevam <festevam@gmail.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,	Hans de Goede
 <hdegoede@redhat.com>,	Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,	Henrique de Moraes Holschuh
 <hmh@hmh.eng.br>,	Selvin Xavier <selvin.xavier@broadcom.com>,	Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>,	Jason Gunthorpe <jgg@ziepe.ca>,	Leon
 Romanovsky <leon@kernel.org>,	cocci@inria.fr,
	linux-kernel@vger.kernel.org,	linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,	linux-sound@vger.kernel.org,
	linux-btrfs@vger.kernel.org,	ceph-devel@vger.kernel.org,
	linux-block@vger.kernel.org,	linux-ide@vger.kernel.org,
	linux-xfs@vger.kernel.org,	linux-pm@vger.kernel.org,
	linux-nvme@lists.infradead.org,	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,	ibm-acpi-devel@lists.sourceforge.net,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 04/16] ALSA: ac97: convert timeouts to secs_to_jiffies()
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-4-9a6ecf0b2308@linux.microsoft.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
	<20250128-converge-secs-to-jiffies-part-two-v1-4-9a6ecf0b2308@linux.microsoft.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,intel.com,kernel.org,inria.fr,imag.fr,broadcom.com,HansenPartnership.com,oracle.com,perex.cz,suse.com,fb.com,toxicpanda.com,gmail.com,easystack.cn,kernel.dk,redhat.com,lst.de,grimberg.me,nxp.com,pengutronix.de,amd.com,linux.intel.com,hmh.eng.br,ziepe.ca,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,lists.linux.dev,lists.sourceforge.net];
	R_RATELIMIT(0.00)[to_ip_from(RL41ih3fejwepcmbj4wj583m3u)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On Tue, 28 Jan 2025 19:21:49 +0100,
Easwar Hariharan wrote:
> 
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi


> ---
>  sound/pci/ac97/ac97_codec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
> index 6e710dce5c6068ec20c2da751b6f5372ad1df211..88ac37739b7653f69af430dd0163f5ab4ddf0d0c 100644
> --- a/sound/pci/ac97/ac97_codec.c
> +++ b/sound/pci/ac97/ac97_codec.c
> @@ -2461,8 +2461,7 @@ int snd_ac97_update_power(struct snd_ac97 *ac97, int reg, int powerup)
>  		 * (for avoiding loud click noises for many (OSS) apps
>  		 *  that open/close frequently)
>  		 */
> -		schedule_delayed_work(&ac97->power_work,
> -				      msecs_to_jiffies(power_save * 1000));
> +		schedule_delayed_work(&ac97->power_work, secs_to_jiffies(power_save));
>  	else {
>  		cancel_delayed_work(&ac97->power_work);
>  		update_power_regs(ac97);
> 
> -- 
> 2.43.0
> 

