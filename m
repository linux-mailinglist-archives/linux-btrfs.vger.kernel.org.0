Return-Path: <linux-btrfs+bounces-22088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bRAWI2ooomn60QQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22088-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 00:27:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2619C1BEFE1
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 00:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FB11303F7CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 23:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C423A1A26;
	Fri, 27 Feb 2026 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyw0QqIm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9743CECC
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772234841; cv=none; b=Ef7oF0H3WR0EyhF0pZrxGZL3xf9OAK5T+KMxZOF7E8nX9HA2SJ2xgXsBAii3vc1QS8geBBSItwslULV/y5eeZK3+ERxwJOOPZ6gJxLcELRU7LbAGA9ncRltX7sNEYnUZRoLG767CUCbOtG759Ve66Gp0NA4AFtzbR8EyGNv+aiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772234841; c=relaxed/simple;
	bh=k+8qc2RpNJufZKsIYFi5Q32VK9kzIjWLL/e+4/flGsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HXTqbU1ZXUERoeRCvX7aU8p23m7/HGRcPGLm7zSLvgi0CtkD+ICvcMBucBx1YmqPwJf+yz7Z8mxWg95K77Htb5t9ij8A/SDfTI2GCM/B3Il+VQZDKksdvT505wQZn3CV35EUIJWUdBZZRaskYaZ+2KAdosVqSWJQGnHD/1WUOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uyw0QqIm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-824a829f9bbso1263675b3a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 15:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772234838; x=1772839638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YedPaC5extqgXW1dcVUm4KhfzApRs1ym2tdR3f5Ndg0=;
        b=Uyw0QqIm00E3CMnea4ewKmw9tnYU6lKkM+gvfKwtK3wHG3NrEX9C1jMMPGs/bIp/mC
         PaZTSsnQXY/ouKF/+68tBpgTHD6CnWUYcxlzNwI218ZlYWrVGiqVEH87PVL5m73OqJVx
         0Uy+yzREAJmGKPhRab+MuPGpQPeCO7qQkk56Gpt0uJJRoP4/we84Fwt2SODBuEyxNWur
         09R8JZmIzyGuTr1/xQJZ3WIvkz7QokMMbFunmenJmLwpMph3fuS4VUpEM88GxM76bUUF
         EKITcvaXhRJ69RiB0sSXKIKEYrmp5iE1KtfFVb7F1HWzAg9DvuIj6kfrk6Es8KyHOP15
         fgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772234838; x=1772839638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YedPaC5extqgXW1dcVUm4KhfzApRs1ym2tdR3f5Ndg0=;
        b=jSN0eOl2sadLuREGe7Y+M/SxhnysM4TiLQu3fSFArm1ZISWcB1aMa9tzG86duCpKfX
         qV7ssZf9mP7ag1BgRZWv8GC8MR3V7w06tub5KOrl/MG5rMD0xIzR/edQqQqRT7gdJIos
         /T+qxJhH9bZctciyOmi25yn3HTTTXvk4NkzPLbwF7UJL17zl/lxlRu3XIbl8zcGGezau
         pdAAZGSZlFYE0wh8Pj8OSAf1r/I1JxeNZBOEWvE1VZkPgg2Vyfuycaca+Ina2kcP4RB0
         X1EpOgL373Rpu9fp2a7LhY+sZk/zcOj+/M6tLFScRtdCLyi3kuOSzBTOvlhnyd0yniaW
         ZbPA==
X-Forwarded-Encrypted: i=1; AJvYcCUiaNJU6uLCtQL4FyNJB+DPrJ+pw6RDkeGUe5cp41iYydpOSGFlDF4FCaVvv44fZM2UOBgxaSyR/xAnxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOoN7kY82RXYeVrGGCTzDHXBEe78VmSUgYmgQmbLwoPkjhcxo/
	fBiEUReEeeaMnshlu3veAN96wf1mlvQgsLzw/tz4jX3pHejdysHJay93
X-Gm-Gg: ATEYQzz3eN+PBhJATYS4FA8QnCyd0/HatLOUloewQmappHqjFKTzaDQB0ZsIWN6Iwex
	DjauPYuTnDxRFKBaU5BgM7HA2se97lt9ZGA9UgWBuNwm/8lAXB0kkCRi43CURuTixD/BiQBgwlr
	FgsGvb9zX284dGJ19tk846xr34j+O90nuMQScd3fT1Sf7RG+amjhl8vHLy640wPAvhuSPVOUR9+
	5R+Ws3v9E9Cn2KSfexZPsJqd6nP45g+UkbCv0nyrQrWrYOaz2D1nNiqBEcHH6hfWXmeF8mmsXp3
	A8obH3sh1rRil7fuyqluvOpecBc3+V7jU+A5WxgukMEfxRnQyyVCDW0Zuh7yQhq5izlciWfeDMl
	fjhitFAnxqID3v1iImBUO1kxiDnono8OuNOlZl9m8SAlKjNGV9iTO9RCxQSeH3lff/oGnLHbfKO
	yx8r1j4goG/I0f/PBwHFExmZa2Www=
X-Received: by 2002:a05:6a00:1ac7:b0:821:7ee2:b692 with SMTP id d2e1a72fcca58-8274d92de78mr4306551b3a.2.1772234838301;
        Fri, 27 Feb 2026 15:27:18 -0800 (PST)
Received: from [192.168.50.89] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8cd91sm5714983b3a.23.2026.02.27.15.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 15:27:17 -0800 (PST)
Message-ID: <6bcde21c-d297-4063-97dd-836b037c92d8@gmail.com>
Date: Sat, 28 Feb 2026 07:27:15 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: fixes for the received subvol ioctl
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1772150849.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <cover.1772150849.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-22088-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anajainsg@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2619C1BEFE1
X-Rspamd-Action: no action



> Filipe Manana (3):
>   btrfs: fix transaction abort on set received ioctl due to item overflow
>   btrfs: abort transaction on failure to update root in the received subvol ioctl
>   btrfs: remove unnecessary transaction abort in the received subvol ioctl



Can this also be considered for LTS kernels?

Otherwise, this looks good to me.

Reviewed-by: Anand Jain [asj@kernel.org](mailto:asj@kernel.org)

Anand

