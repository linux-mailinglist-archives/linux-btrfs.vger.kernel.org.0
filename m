Return-Path: <linux-btrfs+bounces-19978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A336FCD82CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 06:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 090C63028F74
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 05:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856492F546D;
	Tue, 23 Dec 2025 05:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ung45Q84"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461CD2E7F1E
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468171; cv=none; b=cNF5XiN1mXiDbEicVJXrQgowaIw3YGVAsDn95nek4YbUTHKt7kffSYrsB+DA/QtVmX0kXcfFdSSUVFsiGpTO4fg/IkcoqXrHzSO/1fAP1grNPO9AE1uVQAJtFRdgRApSwCPdTCP9N4j7QWkeNY45cu7xocKHZ8rTq8l4PmlCAog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468171; c=relaxed/simple;
	bh=lW+UmIWRSVZ7zpivjjDN2RAk8y2uECMzZoBmWD3afKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PToSq94onzkO18ZbuP5nCpTuKTaFjNkz0M7vfpa3Tz/1B0PVzVL13B6ca1S6SLh8IhYlGyDBIAqC5sq1P90RwRKjcyH97x5fN2cF9lz4ECjtU6mF1RGYRrPgngQUEH5yH4sJyYEqJ9G6RcY/w3wMeIPsIgUQ68reVop62hfy/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ung45Q84; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0f3f74587so64984205ad.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 21:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468169; x=1767072969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lW+UmIWRSVZ7zpivjjDN2RAk8y2uECMzZoBmWD3afKc=;
        b=Ung45Q84NKJpgXUpj6V9c/ed39FtjE6rEaUqQWkJJFS7fjSzXwil3mKYAY6k0P8R9Z
         ddtgTfoZNL09/7vdeIMFC9JYApmDKSVclj15wMPBUSYzvYzI2V1K6y3+4OrBFi1YYL2i
         Ygo61aSI7PTM3LrIlLqoQR3YIwD47T+aDfeoHcsd1atowsBYoyrx6dnbVIVfEB/MalJF
         2NuWCA0r1bN8toEVguQoOSvqibnOTY8FjNDSkJ/sdULSEVFDzpcjyqioyPm4wEmXqrj1
         ilE8f7MJVCDOQnn9/KIYfxwD2zQKhMHjA+B/jiX/srEFwN0w8KKug3A4yAIpvlDCg4c+
         GzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468169; x=1767072969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lW+UmIWRSVZ7zpivjjDN2RAk8y2uECMzZoBmWD3afKc=;
        b=SBX3DX2IfCkV0ZzZjYGphSIpkDHSdxjGHcbg2id1A4HJ0cAgZy1O6Wfgq/M8H4cZ4k
         wdaJGMsvkpdE4LOEX3oXpLgT7MncyF6RhTND4UqocUSgfPBpTqVN4wnOUZYhLd452Hiu
         F2dZ4x9yfm8Xl5j/S73qooMJvRONMk3tPgs246QWATqmBn+72J2axR7J4ziBAFDJRGSJ
         d5lGNWY2VYhMRzfTwSRspweNQHyvmgLotRfbpi85CpXVBhkH1OcVAThjP/wNbswfMFmx
         iFcGK0JpZAIu2dFIjF47STORKt4Fbt6Cx2U3uCKD1bUkmqTLyWx2kSy/zeOYNMJ0cjzo
         h7Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVUKIWMSuV9/bO0BFf5bOC1tTooUqEoyIpAQr2EaoJaasEpO8/ge+fS46uhUAiXxT6YyQ9/hfRuAVuCYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKtwlfKL7+JP4QTMw8CG1ZmP0Mw7PaceS/0TpwuUDgXeZr+ZYZ
	D23ruyoNfi9CHXPeqBWZtUkGQ7m+YsmWHUrHYnweydSMY+us/Sp0o1ws
X-Gm-Gg: AY/fxX5oMYwZ8egSuVxUH823f954xyAiGz5Au+RW2lB/n2e2BLggi8AneQat9Pl6q/9
	GF9lgCVXwtiIcaavN9iNegvQXw2BEKcYK4ckGtivCN5DAInKNw4QFqfDUUr26UhOvXpyS03WhEj
	TOV+agcEsdy438rjCmpChJ601FIkplLCW+yhsqYQ7dU2L9x8A8p9PKhGDkAEHADpEaO5Zhnejkf
	f8JVm+qrfjYOIFBb4FfufHquH9LGxkmKs+uOdLIdHdcC1ncR63gfmPi0iHVc5C9hxO8lr+5V2FI
	J+k3g7tvk7FMbWCOIusCxBnEP8G9gUJzVjsYb59PXDTn3Dp0Kq/Oxg2cqcbZsNwJSfa491rTX7Z
	jo6TkhySV+vE/emhcOyjfhm7rMAxuyhl07g+C+Ifq65hwlU0aYG6UW8LeXlgHGTHN9H0Ctf8IKP
	GCTaaQCuoGV41YEj1+yCWSyFQEmrtpkwUiW1fugrdAIVxvKIOuHDOQCAnEZ3/fZRLQ
X-Google-Smtp-Source: AGHT+IH379xsDZ0d7vjKdC6ERRiENfgRNsDKq+A1tK8cXdwsmB2ywvOol5d1N83fquxU7SkCjjJrLg==
X-Received: by 2002:a05:7022:3b8a:b0:11b:79f1:850 with SMTP id a92af1059eb24-121722b7f23mr14589383c88.14.1766468169469;
        Mon, 22 Dec 2025 21:36:09 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254ce49sm52556580c88.15.2025.12.22.21.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:36:09 -0800 (PST)
Message-ID: <e2d34cef-c0f4-4f27-91a0-439f85ed26b5@gmail.com>
Date: Mon, 22 Dec 2025 21:36:08 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] fs: return I_DIRTY_* and allow error returns from
 inode_update_timestamps
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-6-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Change the inode_update_timestamps calling convention, so that instead
> of returning the updated flags that are only needed to calculate the
> I_DIRTY_* flags, return the I_DIRTY_* flags diretly in an argument, and
> reserve the return value to return an error code, which will be needed to
> support non-blocking timestamp updates.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



