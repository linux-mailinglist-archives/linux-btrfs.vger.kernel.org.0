Return-Path: <linux-btrfs+bounces-7357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC7C95963B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 10:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F922281D7F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED9C19ABAD;
	Wed, 21 Aug 2024 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9F5Cpjn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F61B81B5
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226077; cv=none; b=tD60Ilhtv+P3V+mMc71WXDe4u6X8FjPvs7yOMvNIBkzsW2G0grPSNcx6S580d3MXIlzOCloMP5/Sph4Ac9t9V830Bw1VkH+7N/uIyfqIf+cLiclf3GYGx0EPnpA4r2vTOQLroc/SyBUMHA3SZ+JGQTAEZiKkJf0zGfGpQ00u0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226077; c=relaxed/simple;
	bh=T8gfFZNk5JU5l56K1LuFOsaZqLmtBqkWaA3oe/yExuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMwgnlVIEQrTY+zUE/DJ0zSKAnY+Rr5PFHg0jk3jIyrTI3KMGz7mRIgZL8AfmBuO+ZwCKhQUG68GQpzjqWxAnMHsPB82guBYo87da1E4GFSMmRV6J7lJc66RENFOlyFioQxgnbbDhf7jd7fUDJ5WIpaGyz204/Dom5Jy7nDmtM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9F5Cpjn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3719896b7c8so2774710f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 00:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724226074; x=1724830874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qfv20BTnxwK9GHHiqUOwybUouvxMaLS/j774knK6Dk4=;
        b=e9F5CpjnBsOoY0gqG8S0EY17Yj+J3qSVn96eMouZs+bCZAoaDZKFGm5bv7BJVFSWMV
         PfkvJSAkZbqAH62wRHtDQMbDJFQOnWTWAKqUec6jTuf6SQ+3j/Eih1dnAvLjWNkKaamG
         kD3ZI+QnD8nS+/n4yGfJcqq3fejgWkujPXCJX+oXqaovg/zFDrmIPXhp+VHK45lbw9Ue
         s2ytO/ii7/mM5j2ZSQiXzyW4W3YH8ZreNzBJLa8Oj4SSovi14ejljG851Lx0kYVuaWsJ
         J6cjivdnqHXs3df+IMCheoKztgjDaXBiWNp1esc+kPr2RIZfSkEw7wg/HSgYW5tQsbrb
         gpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724226074; x=1724830874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfv20BTnxwK9GHHiqUOwybUouvxMaLS/j774knK6Dk4=;
        b=vwWoS1WhY1Psfzo318ay8c8I2QSMvdqale0We0kVV8+WFVJbR+KmOaSljSGifbwEyF
         Aa1QjhqqDxCrf/bUYh9e4fh1mKVYjA9G+kM9xDUALS5TmxDFnsEMvWYgWhTNcRp40GX2
         r4aXrJF5VrT6z+DAPi/BH1S6VdDQgPH2t/GVhQ56YAbAU+yxXJbmVGzOx/DpzVNl+2Mv
         6M0OkDRjX3sXw/BPdRK4ehwwiip0Il6HFDisuFnI7MMY34IQosOGvrxt5BOYJDXXGM5f
         1+qOFbRDMuv/oaB7URs5y8eYmRu1KxZ6lxSRGKQz7vNBcR9v0oHQM13FtGZlO7Es5SQS
         QBcQ==
X-Gm-Message-State: AOJu0Yy/Q2tdXGF5vV1gtOV2px9Iplyt5hIWlUMqlKr8NSltkOY3i1TT
	8cpeKB6d5gPYjfxHqq6Zv9mKnHeeeQW8uSH9YneMuWpz0VaKDNVMCsOf9xaoMRjVkFSIhn1R3RG
	BghYavWZ4OlFHhnXVAhX1HbGdl8pdZe9o7vE=
X-Google-Smtp-Source: AGHT+IGHzdGY5nCegJAN11ZgBdh1BcZ7GZTBGFzBjRDY0b7uUbzxkv61Qqt1gYGuiY25CZaMA6Z8/UYKiw9bD6bJYbc=
X-Received: by 2002:adf:efc5:0:b0:368:37e3:dff7 with SMTP id
 ffacd0b85a97d-372fd5a4833mr844712f8f.34.1724226073542; Wed, 21 Aug 2024
 00:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMs-qv9NM6gWTe1oV01XVENhhJ=agFZqb1qJXoLjGoRVS5AXQA@mail.gmail.com>
In-Reply-To: <CAMs-qv9NM6gWTe1oV01XVENhhJ=agFZqb1qJXoLjGoRVS5AXQA@mail.gmail.com>
From: Xuefer <xuefer@gmail.com>
Date: Wed, 21 Aug 2024 15:41:02 +0800
Message-ID: <CAMs-qv96=m2=E1GTvz6yuW5i5Zf6Ng-=0RZQ_RNk6QBrF0aX7A@mail.gmail.com>
Subject: Re: zoned: write pointer offset mismatch of zones in raid1 profile
To: linux-btrfs@vger.kernel.org
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, HAN Yuwei <hrx@bupt.moe>, Naohiro.Aota@wdc.com, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"

I'm hit by the same problem discussed  in
https://lore.kernel.org/all/pidc6y4h62zt44c5m3rdwqbfauik5xtjbijoe6oqmqnkeig2ky@wfxoqxp6rvt7/T/#m0b3cecbe1fd8d9555471eb8239da139f293e2971

Can this issue be brought up to schedule?

