Return-Path: <linux-btrfs+bounces-20062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 946E0CECFCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 01 Jan 2026 12:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FC523008EB4
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jan 2026 11:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E062C1585;
	Thu,  1 Jan 2026 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM36Subz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0921192D8A
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Jan 2026 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767267863; cv=none; b=ZCyfwCLLJnMCunxH7hdS/Vi/g9ocqO2k+J6dS05vUjmpsnULb0smBOS2rayfxoIJkrdRmjWWFhUc6aCQB0rmVrlcpq4yvUAuVwvJ86bJedcBsKUU8/o26JpMsa+Wiy9085G3ICPK7JuoTyfuS7r6+z5SpkhExG6zXiSvvtDSFOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767267863; c=relaxed/simple;
	bh=GLGJNVAu2/fL5axPl7sifOc9Bm0IMlqO84/mgdXDYl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iamuOTzM9npJ4PTlLrR9IzCTcAUv+e/o4tQrdf3k3WBWUq6bCaorWEYiFQ9jL+6WgrElIxqpFFdCIJZVoQ4zD7WcT2t/415q8Wb7iXUXhJPkyYM9GugwQAfiFIS38Zh5ccKAY6XVGOnXQkAWgLmGihIBnZWuaEIbzCeEnb5zXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM36Subz; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-6446c1b327aso1605477d50.3
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Jan 2026 03:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767267860; x=1767872660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A0onbYZV0nDs53qCpEjELVkZIugvzbQpZ0W0wzLcPPU=;
        b=UM36SubzuRN/8jLWeC/HgjjAkBxvKLeaz9wjSEZVblTV7/jStLvHsOVbZyDnn3hwMi
         c8UkDK/r1lCPUk69xBrnvundNB1heljo5aRZlKyh2xtMAVfeEaZvqHYiepW2HIkSBHnW
         N4ZFoo/Nbx7pS3udqIA8p9R2tIKLGJ68pmelexishlnp+0Oh4PqVkehztB0Wwzsn0oSZ
         PaIjUKGUzZqzxqwClWeldnsUKp0bY6W0TJ/BDLR3xqq8/tJQ52y2732BJClEtbh2Ndcm
         voJW+b+4Mzt5vvgklTNW5xmgGZOPLjz0IWR6fpXC1YEpjFWlqA6L+AahJsZlMDxi616k
         4YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767267860; x=1767872660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0onbYZV0nDs53qCpEjELVkZIugvzbQpZ0W0wzLcPPU=;
        b=RHjh9L63CvZRVKCO5hkor6Ax4InDCBhvfvsuZ/xTYYeq5bGv1Alx/eDwuDgMVFJo9F
         kavOcAAv4viE6TgshUuOuoxKPuds1Lz69RvcZyInGJzQYXNDzXWJmemZd7m68g76EMRg
         4cuqjM/WmKTE+56OZdXUWiIDvZu/jW0bgczX8GzmOVaoOBwJpZd4nXP0CPaNUJJEo3Pj
         bP/ry1CUFHOPoq8OJfT+7w2vQA/uVvgq6KGjaO9nshLtvnLuJo1slnzClSy9OsNuEN7f
         zM4xxhj2VnA+tWDq+IqaEfyrMA467898wgSH/SBiBy5r6VBiPLS29Y6YyH1jlxWMQ0p3
         PKlA==
X-Forwarded-Encrypted: i=1; AJvYcCWzW5OaEXI5WVpvuGE/MCar9gS/wFSfWS7Ja+iiFk4jduf8X7LkRkLTjEoUNSfX5JLRT37U/onnquhTYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YywkeEW2SbGtYW0i6VHkTRfNx6p/aM5RyBgj5W0nIzpqZVFvtC4
	akJyD90aAcD5wnha9RXpkFUSI2XfH08UXzL86ODzrt6ynY002bU6ygxZ
X-Gm-Gg: AY/fxX4uzQcukYKE4+5fS7EZrrJYwhurrKVHvb83GcikIGgtrvnKuMvJ9pX4IVCejn6
	juWdIgx5NgSd603FQYS9g5svi1FGmx1gxFslD6K18tgKWhF+Tlx/481Rvr9E+k+TrFH/k5KpVOi
	E0hvpovi8ijT9NiZDYABe8q935xcrIlKrHbRLrrKbpvI9eTxrf8uMUoLdSuV4FpFD28gdQIedFB
	DZ7Akqb/8YtfUp/MY13hoTLJAbAXSboXs03aJwrlVEBYcuCITjjtZRPhH7VA8OPzRXAqHCc+xU1
	E2GvoBkY1oDS+kR3tBZKGlVc6oE9beabVbUWlM6lWVuLWOkjlCcrRimTkHsVzjVyuMSXcPydzJl
	IKcd7miZASERXavopJJBYoaOa7xzXvTntHAN7kXVl3PWKNEqa1XumSB9HAibxDuDBU1aNoKRxvI
	ayD2eO8rc9k+K1ElxhnEcF7/U=
X-Google-Smtp-Source: AGHT+IFZPPSnKrTj9n+VOJYPHcPndTXCEjf3iskIKaxbt0mssBTvyvAjoyS89vznjTyktSdfhKV2HA==
X-Received: by 2002:a05:690e:190d:b0:63f:9530:c2ec with SMTP id 956f58d0204a3-6466a83d503mr27838086d50.1.1767267860654;
        Thu, 01 Jan 2026 03:44:20 -0800 (PST)
Received: from [192.168.1.13] ([193.123.86.108])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a9219ecsm18684389d50.13.2026.01.01.03.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 03:44:20 -0800 (PST)
Message-ID: <c925f2d9-2188-4347-b71c-1ece8abc888c@gmail.com>
Date: Thu, 1 Jan 2026 19:44:15 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] btrfs: fix periodic reclaim condition
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20251231111623.30136-1-sunk67188@gmail.com>
 <20251231111623.30136-8-sunk67188@gmail.com>
 <d15168bf-f8c4-42c6-9a10-73ef44119318@gmx.com>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <d15168bf-f8c4-42c6-9a10-73ef44119318@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/1/1 08:20, Qu Wenruo 写道:
> 
> 
> 在 2025/12/31 21:09, Sun YangKai 写道:
>> Problems with current implementation:
>> 1. reclaimable_bytes is signed while chunk_sz is unsigned, causing
>>     negative reclaimable_bytes to trigger reclaim unexpectedly
>> 2. The "space must be freed between scans" assumption breaks the
>>     two-scan requirement: first scan marks block groups, second scan
>>     reclaims them. Without the second scan, no reclamation occurs.
>>
>> Instead, track actual reclaim progress: pause reclaim when block groups
>> will be reclaimed, and resume only when progress is made. This ensures
>> reclaim continues until no further progress can be made, then resumes when
>> space_info changes or new reclaimable groups appear.
>>
>> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> 
> If this is a bug fix indicated by the title, add a proper "Fixes:" tag please.
> 
> Thanks,
> Qu
> 

Ok. I'll add it in v2.

Thanks,
Sun YangKai


