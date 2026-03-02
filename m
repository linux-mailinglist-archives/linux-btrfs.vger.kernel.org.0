Return-Path: <linux-btrfs+bounces-22149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mXG+HmeSpWnXEAYAu9opvQ
	(envelope-from <linux-btrfs+bounces-22149-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 14:36:39 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68031D9E64
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 14:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5540F30AB650
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CF2334681;
	Mon,  2 Mar 2026 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QliuqGlh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD1736C9D0
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458223; cv=none; b=fTAiFDd/4Dc6YOGnPg13PoKKIlCukI9kjT0OlrBAnW4E0vsn8DcyUZKQ+bkJIOAYaaFIRaH9oKYOGB4psXy/yaQ2FZjjVIPk/TBRakHpEy0LhZRyfL3Z4nePPMQnR8k0ImQTqg8xnMcaIPh7e7RliSzMUEKXHfvivDLIS6+VUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458223; c=relaxed/simple;
	bh=Rq7RfAq1tZwnyavsjnkK9wmAf48OHY+TrmeBnY75gVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxYAYynZIfZnbvYU2l/F0LZXI4++E+h3Spx7//5NFCGdHRKn5sLqurjphUKlRA9N7NEMVRtmN5ZvG6b45bIV2TPtJTNG3IEwWGl2abEGBfWRx3LED6oxli7Lpia3iOazJBGYM1Lp86m1gbiqE56+e5LQ/2064jRYToNByBB9hAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QliuqGlh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab46931cf1so36066075ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2026 05:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772458220; x=1773063020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s24i19n8lKIqVIDIL0pIocUyXuHdTYTMYpJQeikEDx4=;
        b=QliuqGlhM72zAOFK2QwkQ1LbtSPrJdHcPPOCXJYqpUcpGXOCZJcRCbvBWdT8BUuq3v
         bUQx6IaUTLOfZeUkEgGSzREw56LuGVkdDUwOhkjPuEjO87GZNWEXTGzcm3FqJzUTSiEB
         hSUzGmc+N18g9cpKr86DaCf6/gLVfR1syAwTeH7odxYnUIQD0w6zQk9zKAyqNX7VGnS1
         6j+jhjCCLv7Z351U9BAWsWqYhNZoigqcOVIp0LO6probde+f95GaH8BF+NiVK06ulphS
         C2A+A6+ix2/DRDb63ftTR1A7znyW5Dej6xPIVEmaTGIivy8k+zZOTtowp3XM6wYdW+4Q
         kGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458220; x=1773063020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s24i19n8lKIqVIDIL0pIocUyXuHdTYTMYpJQeikEDx4=;
        b=YMKBvS8VGp74zPWJxSa+cZVEFdo6gj+hkhlcXU2LFNy6V5U0+VSNsaZHsbN4HQZ8IV
         8G2mLzjSDbCKTy8e+KVRVrxJONHvNyACgbmlQ4h2Kag1MDfbHz4JICE6CI8NQCPKA0mD
         oxgZokvcFhpfDIGlZxipBIV9nSGfj366eIFbcDV4Ton7T47knkYGULjxDuMoK2OahxMM
         lSJz2Nx54wU/ZREEQlN30ZCk+e2zLYUrItq95F8X5i8wEtBee8AFvHW18Ae8XARwmajJ
         vmIU7+LyqT9Ms0V6LNGu2UhfMgDyZlqtibbL+Rf2hlTNdzs8a2gLNLYpbFhEn8ohkGdb
         Pugg==
X-Forwarded-Encrypted: i=1; AJvYcCWnjSkbO3m8X/iwKg1cmW/P3oRhCDNEuvhBav8wDhPEzs7H3dICAbQ2wIHWW/qmsT+FfB6369jiJiqy5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdGv9saq1i/hQywerRbJjhBE1PRIKJsDz1PTNSOBT1lDcvisHv
	VA71/rBijJFnkBXOLobyPXAV6u3Pvjh9VFIaQ72M1+4h6zooM/ypJcP/
X-Gm-Gg: ATEYQzws+FJZ8eef9bOArqWTl4OhZNVBZMRBp6A5NNqY6aRKEv90gTPrtcYyrzlMpev
	04Qr/tmqKGW9n9Y61BbiePJqjK9WxH7TJB1QpA0CdDfoYvpyI9rkL6X673CYx1dqsUQXcZ268TD
	mAy5xWwnTiGGNyvBCfDQWRcFsl7o6+/ex+P08uS35zZ/1H7lGjOtiJOfXRAwMvx1NTZ36VBnWgX
	6nfbrv8iYYutjfcJci7SuQR33d7BGuA4PA4+qN3ZoChDuH3wAny/sHd8DEQh+VnY596Q9OOw2xD
	0Z37iwGMAR6nmp5FmU0pudObXzOGZ+3mNanfX4EcRCYdRAs5o9t+bkSnW7/iZbt03nQep+uiQuT
	v89i+LDEiPNtWPAjFdM9y2MPoPbrt6LadoQHChDwH/7JynxJ9DXOXHw09Sc/EtIBFFTebvY4E1P
	lH+oEFYjn651y9Qb9d3ds+A/F91FAnt7YGbuF6Vg==
X-Received: by 2002:a17:903:19cf:b0:2ae:4ad5:b76c with SMTP id d9443c01a7336-2ae4ad5ba05mr48823935ad.10.1772458220205;
        Mon, 02 Mar 2026 05:30:20 -0800 (PST)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae45b5201fsm55018345ad.87.2026.03.02.05.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 05:30:19 -0800 (PST)
Message-ID: <cb136241-ca7f-4c64-a6b3-3f86688240f3@gmail.com>
Date: Mon, 2 Mar 2026 21:30:17 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] fstests: verify fanotify isolation on cloned
 filesystems
To: Amir Goldstein <amir73il@gmail.com>, Anand Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 Jan Kara <jack@suse.cz>
References: <cover.1772095513.git.asj@kernel.org>
 <b54dea5e72585db5f5c3d74ce399f9d839965821.1772095513.git.asj@kernel.org>
 <aaQ8CB7C4FjDuedR@amir-ThinkPad-T480>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <aaQ8CB7C4FjDuedR@amir-ThinkPad-T480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22149-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anajainsg@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E68031D9E64
X-Rspamd-Action: no action


>> diff --git a/src/Makefile b/src/Makefile
>> index d0a4106e6be8..ff71cde936a7 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
>>  	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
>> -	rw_hint
>> +	rw_hint fanotify
> 
> Check if you already have fsnotifywait installed on your system
> most likely you do. It was added to inotify-tools quite some time ago.
> Could save you from adding a custom prog.
> Not 100% sure about fsnotifywait, but quite sure that
> fsnotifywatch --verbose prints the FSID of events.
> 

I missed that command. V2 switched to using fsnotifywait.
V2 is not sent yet, I'll wait for any further comments.

Thanks for the review.

Anand

> Thanks,
> Amir.

