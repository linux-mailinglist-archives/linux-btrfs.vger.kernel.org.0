Return-Path: <linux-btrfs+bounces-22020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cICvFGGaoGlmlAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22020-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 20:09:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4421AE329
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 20:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4925230A7A6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CA1332605;
	Thu, 26 Feb 2026 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="fiFUT1k+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EF0JTQ+3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB731197B
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132059; cv=none; b=jnbgQRdV79ca5uGvHGfIzoxb7FdwAgWIEC5EOm3W1rfy94qMIjn3svRg/6VrCCnGAkCSo+lAJ9mIaoYrRuDZ6E/rEabgxdky8HvFxNJhp4/QaxEz7TTKPADh1bqVBTITtKOnd0OV7Iqf/D1VbRgaYr4dpGcx1yZMZsu4vw+lHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132059; c=relaxed/simple;
	bh=zMCxPCksIFh+u91bbbqI5B/IlA2PA2tIS1dWEM4VtMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pzt3SHqLeJi9nsN1wnc0zius4bCDXuFE+5WBXC8oI1GmVGHA8qGRvBkkVFpJ8p42jy10or2ULfTiK/AOjWldUk1fM66OyhNkM0UAm+L6ajhOBy7DOhKS0SgqUmEVQ8SoSdYNJq+Kz48uYdsA7RyDZKvwYY7eX+sSFSGRs9iXsy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=fiFUT1k+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EF0JTQ+3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C030B1400187;
	Thu, 26 Feb 2026 13:54:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 26 Feb 2026 13:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772132054; x=1772218454; bh=O/UEaQcxNp
	IpcPz5v/N6jaA6yVrkehq+CzmTiNDue5A=; b=fiFUT1k+MtHMiWEs+3wtoH5WGa
	f323nb4j6cdNx9DIEteg3n/5XVBKuQpUsJpUOOtySYRk8aNlZtn82uhQie3Nt6OG
	Ob77UJdR6R+fcLJt0yDdVP/XV06JVHZEgKiew/1jCLE4VCNj+UFc7ftDAXfgslIO
	Y1tGihAxbCrBE9ZOm4nyJs4ybeIy2abGt6UUDhXdP8oz/XZw0i70UJGAJM3iN3sD
	tUhXS71eIFRw43N9CZzJtH09LUGe8JpzLmKHpfdM29dm3Ju60p0lu0k4Xltm+Cj/
	cBXCLUieddWl4UvsB+M5rzz3YujLkv+qeesvLcJhj0L7YtsEQp+eZZAO1Alw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772132054; x=1772218454; bh=O/UEaQcxNpIpcPz5v/N6jaA6yVrkehq+Czm
	TiNDue5A=; b=EF0JTQ+3yz1hu2HlEDJyTzcYzlZZuEvq8U40Qdf6em8/E/8sg9/
	1eKzJfRkTJKu5x3PLw3TlEUF2Ve/IC0RhIfBqOW+Zx4cwHVmzHWkLAay26mxTZpC
	gAWtvke7xp1IGbJ1lBDqOKPSvEOQe5pZ0dyKsJPLypp6CMSuFfb+H0nEh6/ubtmj
	SI7F2O0kG1unaOvLntEKMTGHYi8Pvq2gUX9IRcU3Rcp/hERp1sEBvSgJrU8n/bHP
	MNvZHbMboNSi22ImNemEigYMkQhkfBymY0rr9QcLP8sadT/OtYGfyMXWzGnZ7X1j
	lAPYu4U/YNIj0+hPI7mWx0WW1H9aiwinWew==
X-ME-Sender: <xms:1pagaRPd6I-I9JAyv53SF9MJf9nTLaFs-6R4Tm7fA3Z-OzrpCPDwWg>
    <xme:1pagaZ_S3Jw9lftFw1oSz71lf3xdpmBp-lsxUTk4upKo715IFQDykn7AN0VFwtqZc
    82OL1pqBjilE4EMULdg4dHAuRNPQOXnRIoAuvJDNOP9X7d86JxqWmk>
X-ME-Received: <xmr:1pagad59HXCSzKMk-eN_AOpbmkKrH4R_mt7prJIShiISSsimn4HgsQFFnCGGVQLbdzwTSORacvACKBidiSE7IttyZCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeikeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepuefgfeetffefgfduvedvvedtfffgudefgfeuffejff
    ehheduueeiudetkeegffehnecuffhomhgrihhnpehqvghmuhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    fhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsth
    hrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1pagaY1UJvBU5OI5wP17zFTmG56yIyiGKkQKO1ug_9g_RcnlLENSUg>
    <xmx:1pagacArC9LEfsl0L4224Zl0-ObR7U4-yM-j93FFkGt-5Z9LU6yInA>
    <xmx:1pagaS0MqOpPokDz5nynZkFp1-2-O7JqNTJNJq_CyaLWxCRZwVRatA>
    <xmx:1pagaetPjv97wjbXvaA1Jv9GdVK7Xe-sLW2ulN1uFIIVTBrtvHfT-w>
    <xmx:1pagaYgOgXEbX62JIHRbDd6qJM755byUWY3qLVpZ80-7kPOnvxr08zmL>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 13:54:14 -0500 (EST)
Date: Thu, 26 Feb 2026 10:55:06 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: fix transaction abort on file creation due to
 name hash collision
Message-ID: <20260226185506.GA2996252@zen.localdomain>
References: <cover.1772105193.git.fdmanana@suse.com>
 <3f0538466b8a6d7d00c0a8256c76dbdcf01980a0.1772105193.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0538466b8a6d7d00c0a8256c76dbdcf01980a0.1772105193.git.fdmanana@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-22020-lists,linux-btrfs=lfdr.de];
	DMARC_NA(0.00)[bur.io];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC4421AE329
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 02:33:58PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we attempt to create several files with names that result in the same
> hash, we have to pack them in same dir item and that has a limit inherent
> to the leaf size. However if we reach that limit, we trigger a transaction
> abort and turns the filesystem into RO mode. This allows for a malicious
> user to disrupt a system, without the need to have administration
> privileges/capabilities.
> 
> Reproducer:
> 
>    $ cat exploit-hash-collisions.sh
>    #!/bin/bash
> 
>    DEV=/dev/sdi
>    MNT=/mnt/sdi
> 
>    # Use smallest node size to make the test faster and require less file
>    # names that result in hash collision.
>    mkfs.btrfs -f --nodesize 4K $DEV
>    mount $DEV $MNT
> 
>    # List of names that result in the same crc32c hash for btrfs.
>    declare -a names=(
>     'foobar'
>     '%a8tYkxfGMLWRGr55QSeQc4PBNH9PCLIvR6jZnkDtUUru1t@RouaUe_L:@xGkbO3nCwvLNYeK9vhE628gss:T$yZjZ5l-Nbd6CbC$M=hqE-ujhJICXyIxBvYrIU9-TDC'
>     'AQci3EUB%shMsg-N%frgU:02ByLs=IPJU0OpgiWit5nexSyxZDncY6WB:=zKZuk5Zy0DD$Ua78%MelgBuMqaHGyKsJUFf9s=UW80PcJmKctb46KveLSiUtNmqrMiL9-Y0I_l5Fnam04CGIg=8@U:Z'
>     'CvVqJpJzueKcuA$wqwePfyu7VxuWNN3ho$p0zi2H8QFYK$7YlEqOhhb%:hHgjhIjW5vnqWHKNP4'
>     'ET:vk@rFU4tsvMB0$C_p=xQHaYZjvoF%-BTc%wkFW8yaDAPcCYoR%x$FH5O:' >     'HwTon%v7SGSP4FE08jBwwiu5aot2CFKXHTeEAa@38fUcNGOWvE@Mz6WBeDH_VooaZ6AgsXPkVGwy9l@@ZbNXabUU9csiWrrOp0MWUdfi$EZ3w9GkIqtz7I_eOsByOkBOO'
>     'Ij%2VlFGXSuPvxJGf5UWy6O@1svxGha%b@=%wjkq:CIgE6u7eJOjmQY5qTtxE2Rjbis9@us'
>     'KBkjG5%9R8K9sOG8UTnAYjxLNAvBmvV5vz3IiZaPmKuLYO03-6asI9lJ_j4@6Xo$KZicaLWJ3Pv8XEwVeUPMwbHYWwbx0pYvNlGMO9F:ZhHAwyctnGy%_eujl%WPd4U2BI7qooOSr85J-C2V$LfY'
>     'NcRfDfuUQ2=zP8K3CCF5dFcpfiOm6mwenShsAb_F%n6GAGC7fT2JFFn:c35X-3aYwoq7jNX5$ZJ6hI3wnZs$7KgGi7wjulffhHNUxAT0fRRLF39vJ@NvaEMxsMO'
>     'Oj42AQAEzRoTxa5OuSKIr=A_lwGMy132v4g3Pdq1GvUG9874YseIFQ6QU'
>     'Ono7avN5GjC:_6dBJ_'
>     'WHmN2gnmaN-9dVDy4aWo:yNGFzz8qsJyJhWEWcud7$QzN2D9R0efIWWEdu5kwWr73NZm4=@CoCDxrrZnRITr-kGtU_cfW2:%2_am'
>     'WiFnuTEhAG9FEC6zopQmj-A-$LDQ0T3WULz%ox3UZAPybSV6v1Z$b4L_XBi4M4BMBtJZpz93r9xafpB77r:lbwvitWRyo$odnAUYlYMmU4RvgnNd--e=I5hiEjGLETTtaScWlQp8mYsBovZwM2k'
>     'XKyH=OsOAF3p%uziGF_ZVr$ivrvhVgD@1u%5RtrV-gl_vqAwHkK@x7YwlxX3qT6WKKQ%PR56NrUBU2dOAOAdzr2=5nJuKPM-T-$ZpQfCL7phxQbUcb:BZOTPaFExc-qK-gDRCDW2'
>     'd3uUR6OFEwZr%ns1XH_@tbxA@cCPmbBRLdyh7p6V45H$P2$F%w0RqrD3M0g8aGvWpoTFMiBdOTJXjD:JF7=h9a_43xBywYAP%r$SPZi%zDg%ql-KvkdUCtF9OLaQlxmd'
>     'ePTpbnit%hyNm@WELlpKzNZYOzOTf8EQ$sEfkMy1VOfIUu3coyvIr13-Y7Sv5v-Ivax2Go_GQRFMU1b3362nktT9WOJf3SpT%z8sZmM3gvYQBDgmKI%%RM-G7hyrhgYflOw%z::ZRcv5O:lDCFm'
>     'evqk743Y@dvZAiG5J05L_ROFV@$2%rVWJ2%3nxV72-W7$e$-SK3tuSHA2mBt$qloC5jwNx33GmQUjD%akhBPu=VJ5g$xhlZiaFtTrjeeM5x7dt4cHpX0cZkmfImndYzGmvwQG:$euFYmXn$_2rA9mKZ'
>     'gkgUtnihWXsZQTEkrMAWIxir09k3t7jk_IK25t1:cy1XWN0GGqC%FrySdcmU7M8MuPO_ppkLw3=Dfr0UuBAL4%GFk2$Ma10V1jDRGJje%Xx9EV2ERaWKtjpwiZwh0gCSJsj5UL7CR8RtW5opCVFKGGy8Cky'
>     'hNgsG_8lNRik3PvphqPm0yEH3P%%fYG:kQLY=6O-61Wa6nrV_WVGR6TLB09vHOv%g4VQRP8Gzx7VXUY1qvZyS'
>     'isA7JVzN12xCxVPJZ_qoLm-pTBuhjjHMvV7o=F:EaClfYNyFGlsfw-Kf%uxdqW-kwk1sPl2vhbjyHU1A6$hz'
>     'kiJ_fgcdZFDiOptjgH5PN9-PSyLO4fbk_:u5_2tz35lV_iXiJ6cx7pwjTtKy-XGaQ5IefmpJ4N_ZqGsqCsKuqOOBgf9LkUdffHet@Wu'
>     'lvwtxyhE9:%Q3UxeHiViUyNzJsy:fm38pg_b6s25JvdhOAT=1s0$pG25x=LZ2rlHTszj=gN6M4zHZYr_qrB49i=pA--@WqWLIuX7o1S_SfS@2FSiUZN'
>     'rC24cw3UBDZ=5qJBUMs9e$=S4Y94ni%Z8639vnrGp=0Hv4z3dNFL0fBLmQ40=EYIY:Z=SLc@QLMSt2zsss2ZXrP7j4='
>     'uwGl2s-fFrf@GqS=DQqq2I0LJSsOmM%xzTjS:lzXguE3wChdMoHYtLRKPvfaPOZF2fER@j53evbKa7R%A7r4%YEkD=kicJe@SFiGtXHbKe4gCgPAYbnVn'
>     'UG37U6KKua2bgc:IHzRs7BnB6FD:2Mt5Cc5NdlsW%$1tyvnfz7S27FvNkroXwAW:mBZLA1@qa9WnDbHCDmQmfPMC9z-Eq6QT0jhhPpqyymaD:R02ghwYo%yx7SAaaq-:x33LYpei$5g8DMl3C'
>     'y2vjek0FE1PDJC0qpfnN:x8k2wCFZ9xiUF2ege=JnP98R%wxjKkdfEiLWvQzmnW'
>     '8-HCSgH5B%K7P8_jaVtQhBXpBk:pE-$P7ts58U0J@iR9YZntMPl7j$s62yAJO@_9eanFPS54b=UTw$94C-t=HLxT8n6o9P=QnIxq-f1=Ne2dvhe6WbjEQtc'
>     'YPPh:IFt2mtR6XWSmjHptXL_hbSYu8bMw-JP8@PNyaFkdNFsk$M=xfL6LDKCDM-mSyGA_2MBwZ8Dr4=R1D%7-mCaaKGxb990jzaagRktDTyp'
>     '9hD2ApKa_t_7x-a@GCG28kY:7$M@5udI1myQ$x5udtggvagmCQcq9QXWRC5hoB0o-_zHQUqZI5rMcz_kbMgvN5jr63LeYA4Cj-c6F5Ugmx6DgVf@2Jqm%MafecpgooqreJ53P-QTS'
>    )
> 
>    # Now create files with all those names in the same parent directory.
>    # It should not fail since a 4K leaf has enough space for them.
>    for name in "${names[@]}"; do
>         touch $MNT/$name
>    done
> 
>    # Now add one more file name that causes a crc32c hash collision.
>    # This should fail, but it should not turn the filesystem into RO mode
>    # (which could be exploited by malicious users) due to a transaction
>    # abort.
>    touch $MNT/'W6tIm-VK2@BGC@IBfcgg6j_p:pxp_QUqtWpGD5Ok_GmijKOJJt'
> 
>    # Check that we are able to create another file, with a name that does not cause
>    # a crc32c hash collision.
>    echo -n "hello world" > $MNT/baz
> 
>    # Unmount and mount again, verify file baz exists and with the right content.
>    umount $MNT
>    mount $DEV $MNT
>    echo "File baz content: $(cat $MNT/baz)"
> 
>    umount $MNT
> 
> When running the reproducer:
> 
>    $ ./exploit-hash-collisions.sh
>    (...)
>    touch: cannot touch '/mnt/sdi/W6tIm-VK2@BGC@IBfcgg6j_p:pxp_QUqtWpGD5Ok_GmijKOJJt': Value too large for defined data type
>    ./exploit-hash-collisions.sh: line 57: /mnt/sdi/baz: Read-only file system
>    cat: /mnt/sdi/baz: No such file or directory
>    File baz content:
> 
> And the transaction abort stack trace in dmesg/syslog:
> 
>    $ dmesg
>    (...)
>    [758240.509761] ------------[ cut here ]------------
>    [758240.510668] BTRFS: Transaction aborted (error -75)
>    [758240.511577] WARNING: fs/btrfs/inode.c:6854 at btrfs_create_new_inode+0x805/0xb50 [btrfs], CPU#6: touch/888644
>    [758240.513513] Modules linked in: btrfs dm_zero (...)
>    [758240.523221] CPU: 6 UID: 0 PID: 888644 Comm: touch Tainted: G        W           6.19.0-rc8-btrfs-next-225+ #1 PREEMPT(full)
>    [758240.524621] Tainted: [W]=WARN
>    [758240.525037] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>    [758240.526331] RIP: 0010:btrfs_create_new_inode+0x80b/0xb50 [btrfs]
>    [758240.527093] Code: 0f 82 cf (...)
>    [758240.529211] RSP: 0018:ffffce64418fbb48 EFLAGS: 00010292
>    [758240.529935] RAX: 00000000ffffffd3 RBX: 0000000000000000 RCX: 00000000ffffffb5
>    [758240.531040] RDX: 0000000d04f33e06 RSI: 00000000ffffffb5 RDI: ffffffffc0919dd0
>    [758240.531920] RBP: ffffce64418fbc10 R08: 0000000000000000 R09: 00000000ffffffb5
>    [758240.532928] R10: 0000000000000000 R11: ffff8e52c0000000 R12: ffff8e53eee7d0f0
>    [758240.533818] R13: ffff8e57f70932a0 R14: ffff8e5417629568 R15: 0000000000000000
>    [758240.534664] FS:  00007f1959a2a740(0000) GS:ffff8e5b27cae000(0000) knlGS:0000000000000000
>    [758240.535821] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [758240.536644] CR2: 00007f1959b10ce0 CR3: 000000012a2cc005 CR4: 0000000000370ef0
>    [758240.537517] Call Trace:
>    [758240.537828]  <TASK>
>    [758240.538099]  btrfs_create_common+0xbf/0x140 [btrfs]
>    [758240.538760]  path_openat+0x111a/0x15b0
>    [758240.539252]  do_filp_open+0xc2/0x170
>    [758240.539699]  ? preempt_count_add+0x47/0xa0
>    [758240.540200]  ? __virt_addr_valid+0xe4/0x1a0
>    [758240.540800]  ? __check_object_size+0x1b3/0x230
>    [758240.541661]  ? alloc_fd+0x118/0x180
>    [758240.542315]  do_sys_openat2+0x70/0xd0
>    [758240.543012]  __x64_sys_openat+0x50/0xa0
>    [758240.543723]  do_syscall_64+0x50/0xf20
>    [758240.544462]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    [758240.545397] RIP: 0033:0x7f1959abc687
>    [758240.546019] Code: 48 89 fa (...)
>    [758240.548522] RSP: 002b:00007ffe16ff8690 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
>    [758240.566278] RAX: ffffffffffffffda RBX: 00007f1959a2a740 RCX: 00007f1959abc687
>    [758240.567068] RDX: 0000000000000941 RSI: 00007ffe16ffa333 RDI: ffffffffffffff9c
>    [758240.567860] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>    [758240.568707] R10: 00000000000001b6 R11: 0000000000000202 R12: 0000561eec7c4b90
>    [758240.569712] R13: 0000561eec7c311f R14: 00007ffe16ffa333 R15: 0000000000000000
>    [758240.570758]  </TASK>
>    [758240.571040] ---[ end trace 0000000000000000 ]---
>    [758240.571681] BTRFS: error (device sdi state A) in btrfs_create_new_inode:6854: errno=-75 unknown
>    [758240.572899] BTRFS info (device sdi state EA): forced readonly
> 
> Fix this by checking for hash collision, and if the adding a new name is
> possible, early in btrfs_create_new_inode() before we do any tree updates,
> so that we don't need to abort the transaction if we can not add the new
> name due to the leaf size limit.
> 
> A test case for fstests will be sent soon.
> 
> Fixes: caae78e03234 ("btrfs: move common inode creation code into btrfs_create_new_inode()")

This fix makes sense but I have two high level questions if you don't
mind:

I couldn't actually find the place EOVERFLOW is coming from.
my best guess is:

insert_with_overflow()
  btrfs_insert_empty_item()
    btrfs_insert_empty_items()
      btrfs_search_slot()
        search_leaf()
          split_leaf()
            	if (extend && data_size + btrfs_item_size(l, slot) +
	            sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(fs_info))
		        return -EOVERFLOW;

Is that right? I am a bit confused how this doesn't get caught by the
check before the call to split leaf
i.e.,
if (leaf_free_space < ins_len) // ctree.c:1951


Also, would it theoretically be possible to extend the collision
handling to allow collisions to span leaves or is there some reason that
is complete no-go?

Regardless of the answers, this is well reasoned, well tested, and a
clear imporovement so please add:

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/inode.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b9f1bd18ea62..9a26fc5a5263 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6635,6 +6635,25 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
>  	int ret;
>  	bool xa_reserved = false;
>  
> +	if (!args->orphan && !args->subvol) {
> +		/*
> +		 * Before anything else, check if we can add the name to the
> +		 * parent directory. We want to avoid a dir item overflow in
> +		 * case we have an existing dir item due to existing name
> +		 * hash collisions. We do this check here before we call
> +		 * btrfs_add_link() down below so that we can avoid a
> +		 * transaction abort (which could be exploited by malicious
> +		 * users).
> +		 *
> +		 * For subvolumes we already do this in btrfs_mksubvol().
> +		 */
> +		ret = btrfs_check_dir_item_collision(BTRFS_I(dir)->root,
> +						     btrfs_ino(BTRFS_I(dir)),
> +						     name);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
> -- 
> 2.47.2
> 

