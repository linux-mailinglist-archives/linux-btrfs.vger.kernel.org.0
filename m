Return-Path: <linux-btrfs+bounces-20403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E18D1354E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 15:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B612D31F6793
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDDC2836B1;
	Mon, 12 Jan 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS12BmKv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC2263F5E
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228528; cv=none; b=Mc4pZf9IKaqJxcDa4697pVJxu8s/8WwF7QjDLa/O9Vtlu0Aiae4Jyqhqq79NRMlOXkV8bSmacAON15M01bE6CZQmiHLl4PRrLOGBQg+jIV3Tp4L1rHXHaStXLWPM/lKpgq15PLMswQ1xy5hQia41HLEQHWbQYZHe/DqddMkMuoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228528; c=relaxed/simple;
	bh=ipXclB7XWaQHergzZfDAVG1bQPrDOaJWOyCY/sxR1gY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRSajDcoME69vV458IZoLdOux1Xunu81MaKPpAH8avuDloLkPRxhNoU8hfmRoLoYSywyNfaLiA1T7Ra7yPkmu80zlqd4XvsULLFnd6dMxUks0WsbVechu5aDLCMNnge5UHpXPLJlQP++R49si6+YtXacL7kFovZBZqA0ScBAK9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS12BmKv; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-3e83c40e9dfso4285831fac.1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 06:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768228526; x=1768833326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XPk51WUNGuksCZuOQL2GBwXtgBzEDIRIaH0+momCP8=;
        b=JS12BmKvxIRAX518iGLqBmncMfui6e2Ge5Jl8SV2o/t/iRs0vpn3vHe97H6ul45y/3
         6fXmdOKqa63u4PFv6qKOyCC5QHmv9TeTumfOwVEzOPlA8UUKXkybHV9E58NE+jdF0wbf
         cH6VdBol7YxG2YATMJan7MxIT40a1zHXbopSJMIQ7kb5OA+p+3E0NOVR1/rSa5ANahbd
         KCZukImgbkA3ZQGmc7JopTp3vc1AJGZW+zs1zmEAMXp2uLvThPqFjQWF1rD7wSZU8fnY
         ngT8ehP35Idpbi5yShCVdypmKRYoVdldvqtpfwQREdmtSbCpaZUmJmjeKWqnNaNtYDVQ
         NjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768228526; x=1768833326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0XPk51WUNGuksCZuOQL2GBwXtgBzEDIRIaH0+momCP8=;
        b=rHhsMVtle0mOEYra/g6r6xtWep9gQGeSeh/UE9/zgVRCurhMyXwNOK6BJGLJtaC5pB
         hq0XiTG8vhou3XnUEziBY1NnohdtdxbR5DHLn6NKt7yt/qrutOxtpGOhEu5ZzB8fhpOG
         eY7D3MuZnEsLk62vVG7cuBOgr51F9x6pH4RJtAA462yXoRzTMamCfUXHabcIAVjrTWwm
         bn35DE6Wesv+waxSLpGyNmQJlYFpJI1KNzBQqqiNoFsujBdKkFAU1zljiEh+t8HWNDVs
         ODkNMap3TJkU9I/cCu+EC2mad3ftJlApmJyulBJxgwN4bhHZ7TY61JeANS69XcnCfPT9
         Fhrw==
X-Forwarded-Encrypted: i=1; AJvYcCUoyq2hygHGBcKR/VdJd6p8qZROZqQF4yTeQv8lY5uPo1cCfqmqL/NHZM2yXKi3cwTgN5rUsmy/k8bqLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3VaOrfcR0u+jRYsQntY9JVcoYgUESBMS5OdlS7jMzk0Ld9A60
	TvLa0euNjFkXEpRD0msQl1cOHmuEtPzpccXfLkE7unQZwIsqu0ENeKpV
X-Gm-Gg: AY/fxX5ayUQ10w4zBl8NECtj9qNzSciEZ8Q+cDzXa8Q6AOSYShHvFTsNeLztylgXlJG
	FgoghNAPrV67yCYkSpazSckwcCC2GZkqYuV67bGmE3CO66Tn3DWTsVYzTRLrAIO9oGRqy7+w09C
	7NRKQpvt5XmYljoRhWbSGipqHGOsJO2GDdNlzkNxszKcP1oA4n9u/8Gm7tDOJHx3TzhvLKlDgLK
	K+jiIB1uZxIEbkmqtLxLf/a2w1VkwN6WVm644cKm0aolA9kfGLnhT2V5Ev3KMkf2LYxgz5lQNjS
	l+3dC9nb2m+H2b7ivxOje6/PWRANj5JaAwuc+NL76mnSefOtGeU2auZNeBVyofuZZ7zhnV8LnUT
	D+ZEY7UaiXHL7Hmao93jPONgvsPaRmkoF2F2zLh9vDIHkuHQXGpoSLiHbOsxvL1J1Tghml6oWCx
	kKgb4Uq46WNyFMHunLDIeHxPqz/Zl9c3uAKW+1nIBbPmY=
X-Google-Smtp-Source: AGHT+IHPabtZCog+BJGfwi4EXiP0Jf8lOROFsQN3GZV8nsWOh5lahZHTowj2Sh7tXlH8ozgNRpn0rw==
X-Received: by 2002:a05:6871:109:b0:3e8:9df6:df79 with SMTP id 586e51a60fabf-3ffc09e470dmr8916653fac.21.1768228525457;
        Mon, 12 Jan 2026 06:35:25 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffb279e939sm11014567fac.16.2026.01.12.06.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:35:24 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: reset block group size class when reservations are freed
Date: Mon, 12 Jan 2026 14:35:23 +0000
Message-Id: <20260112143523.31542-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAL3q7H7c=Pa1D63M50MEn7PoSqi4K749KD5S2+EaVz=n53h2sw@mail.gmail.com>
References: <CAL3q7H7c=Pa1D63M50MEn7PoSqi4K749KD5S2+EaVz=n53h2sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Jan 12, 2026 at 12:39:43 +0000, Filipe Manana fdmanana@kernel.org wrote:
> On Sun, Jan 11, 2026 at 8:25 PM Jiasheng Jiang
> <jiashengjiangcool@gmail.com> wrote:
>>
>> Differential analysis of block-group.c shows an inconsistency between
>> btrfs_add_reserved_bytes() and btrfs_free_reserved_bytes().
>>
>> When space is reserved, btrfs_use_block_group_size_class() is called to
>> set a block group's size class, specializing it for a specific allocation
>> size to reduce fragmentation. However, when these reservations are
>> subsequently freed (e.g., due to an error or transaction abort),
>> btrfs_free_reserved_bytes() fails to perform the corresponding cleanup.
>>
>> This leads to a state leak where a block group remains stuck with a
>> specific size class even if it contains no used or reserved bytes. This
>> stale state causes find_free_extent to unnecessarily skip these block
>> groups for mismatched size requests, leading to suboptimal allocation
>> behavior.
> 
> Not necessarily always. If there are subsequent allocations for the
> same extent size, then there's no problem at all.
> 
>There's more than skipping, it can cause allocation of new block
>groups if there are none with a matching size class and there aren't
>any without a size class.
> 
> I wonder if you observed this in practice and what kind of workload.
> 
> I think that should be rephrased because as it's stated it gives the
> wrong idea that it will always cause bad behaviour, while in reality
> that depends a lot on the workload.

You are right. This inconsistency was identified through differential analysis of the space accounting logic. I haven't observed it in a specific production workload yet. I will rephrase the description in v3 to clarify that the impact is workload-dependent and can lead to unnecessary allocation of new block groups.

>>
>> Fix this by resetting the size class to BTRFS_BG_SZ_NONE in
>> btrfs_free_reserved_bytes() when the block group becomes completely
>> empty.
>>
>> Fixes: 606d1bf10d7e ("btrfs: migrate the block group space accounting helpers")
> 
> What? That's completely wrong.
> 
> First, that commit only moved code around.
> Secondly, that commit happened (2019) before we had support for block
> group size classes (2022).
> 
> The proper commit would be 52bb7a2166af ("btrfs: introduce size class
> to block group allocator").

My apologies for the oversight. I will correct the Fixes tag to 52bb7a2166af in v3.

I will send a v3 with the updated commit message and corrected tags shortly.

Best regards,
Jiasheng

