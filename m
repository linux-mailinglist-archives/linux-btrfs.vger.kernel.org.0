Return-Path: <linux-btrfs+bounces-15548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD22B0A8F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 18:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B410164A19
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51BA2E6D2F;
	Fri, 18 Jul 2025 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dSHZiGBu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AD2E612B
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857892; cv=none; b=cF+v0/jtaIwqWk3vgjIGzySwDOdYk1CUMJa6kOhh3RJXebv9Rm1ZQApLBBTi2bktcsZiiz1KRMpVSdLX5uKZxVfTFWnuk4iHooaR7Fn1h6V1CQODFBQh42iOkdwUi9luMafliPceWkMYEoEM5erHYdPN4Ic0HUTlE3zqwiFrVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857892; c=relaxed/simple;
	bh=VLW3UWQLxGRdbGgQdSEaWhEmJKomiEjyniwXZIeWPNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSPoZvXa9YoLvdFJTuH1DXMrnli37dPqJobVpRpDF5vGM23GytWt7u1vwq4EsxmqBAD/Evg5tBunlGrAtZXD5U5xUQuSc7lLn/BMwgJLivuxzdDCADzhX3kSir64wgmX2r3JeIY0CdUjGwHXDwgjlwjbLoMULo6QzOPonSDkzps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dSHZiGBu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748feca4a61so1423530b3a.3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752857890; x=1753462690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIjnpXR7kFzmkgbsnqn30ikPUW7z/FzWNSDSSmsQgxI=;
        b=dSHZiGBuWcQwqvuP04xKJ28O1+13I/OeKSA6nUCS5k0S0krUWhmwGEbOsdhAP4/DeI
         J5QTHCEny63CAkflis7lXL9hnh+McWpKhJPOm+2Rfb2UvWTkOfZddWa8fUxWBsFxg1h2
         llguurF+zpeMeMbG3yJ6DQb0XMCyooSyu120VRjzxmos9thKIQVPIZTjJkYHh/OhsGZz
         SYSj3N5BRkCroSoJ2BYmE3+s33viYuuZoBDq0CA/r9C/sbXvuuvUsB4ubjgDh/Lz8w1G
         brGGFHwo9O5xD0fZBckw7teVx0XwYdx31Hl19s4h1UbIfCDYB905OH0+nxNAsNQNO0gI
         FDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857890; x=1753462690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIjnpXR7kFzmkgbsnqn30ikPUW7z/FzWNSDSSmsQgxI=;
        b=BLpgsMDCqKA3rRcLVKanN4YnRB64iVAE0Td3qYzoTxxTf0P99+ISKSGYs5I9WvmfdQ
         F0pLr5PwqOyg2qxn0W+9C78Z+n0s0elSoyHB11+10PkbFrSKYN//bD3uxaumWxiezW6L
         XOBUu5ZfRj2dEwKR6DCd4EWRV5MAotkajc99uHvBZNiBzn425K1P6qEr4878XqV8KsfY
         SyjH0JTQCwZZZN3O0k3NIgFnRo44Kjg5IaTwrndoLfJnECFsoPFvdbxSul3hIUApe89N
         J/O/b4kjh+jyyghdZqIIdSED74jG/PmJ54JwQXB4e14Jpd9iAuuxhSMOatUBxy6T59rk
         6NBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPNpY5umqys6GFBtnY3ejUjvzx0t8/KShzDBisA9ljbzztKAkycVtkZmc/tulyNfV/wgAHEzAZ4UZYOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx8q4KE4AHDFMzdYvFDv42tl+P4gq378OIJsrmqsGy/D7R1sXQ
	wmvWyOMxYgckbYWmPxOrLvMT3MIEkYibdFuciwkqHTG/5qMLFdtCvdzvYsS/TtgStm4=
X-Gm-Gg: ASbGncsPKoFDkuq8/cPPQjhBFdpGibTIMJFMFt7jFE3d6A48qteNnrKWrObP81++8cq
	Tbk3tDM6XFVy5ox+9WdWtyWZDBw3TPtcmdg5s591I171FX2o+90Qo/I1ZNaYVPNBwha6dW/PAcO
	l7gOoFiJ7UulDdIFWVGAkftRKAXzvO4ocxjpJ274gODDuXU+zH0fzdV+xTbuTZchfD6+BQr3Loh
	fqzOjYSX0VMzR68TR8BdRIFsAgTTAoGlr03gFUZny99bMSF+iWraC9EcJb/X3xpxLM8AsQJ8BwI
	XD++LQRiSPKE/Sw242QKUaBfsIz2qAAgSp9U+8XdqB7W3mMw+ptNtLHF2ZNY+yY0UUheHQ2XTsP
	YGD594uYhb9aKalb2NVRAc7QOgaLDrtw5YfV9OqQLxasrRd5r7xxIyKN9
X-Google-Smtp-Source: AGHT+IGSYEopSk3acBGxusn+C3aQwEH7Y9k5SO3YHjLM61xU8Uro/IWUb/xfLi/OwISpnyV/yTpN+Q==
X-Received: by 2002:a05:6a00:10cb:b0:748:ffaf:9b53 with SMTP id d2e1a72fcca58-757242790admr14294927b3a.16.1752857889825;
        Fri, 18 Jul 2025 09:58:09 -0700 (PDT)
Received: from [172.20.8.9] (syn-071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e20c2sm1551781b3a.18.2025.07.18.09.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:58:08 -0700 (PDT)
Message-ID: <bb01752a-0a36-4e30-bf26-273c9017ffc0@kernel.dk>
Date: Fri, 18 Jul 2025 10:58:07 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] io_uring/btrfs: remove struct io_uring_cmd_data
To: Caleb Sander Mateos <csander@purestorage.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708202212.2851548-1-csander@purestorage.com>
 <CADUfDZr6d_EV6sek0K1ULpg2T862PsnnFT08PhoX9WjHGBA=0w@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZr6d_EV6sek0K1ULpg2T862PsnnFT08PhoX9WjHGBA=0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 2:04 PM, Caleb Sander Mateos wrote:
> Hi Jens,
> Are you satisfied with the updated version of this series? Let me know
> if there's anything else you'd like to see.

I'm fine with it, was hoping some of the CC'ed btrfs folks would ack or
review the btrfs bits. OOO until late sunday, if I hear nothing else by
then, I'll just tentatively stage it in a separate branch for 6.17.

What test cases did you run?

-- 
Jens Axboe

