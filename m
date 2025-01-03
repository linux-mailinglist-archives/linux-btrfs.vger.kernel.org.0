Return-Path: <linux-btrfs+bounces-10713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AACD6A00D46
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 18:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890F8163AE4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 17:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152151FAC4B;
	Fri,  3 Jan 2025 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LDxoTqSo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C319342B
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926947; cv=none; b=fjyx9wmTfTYzhLmvwMrP2+8uWi/1Fn2pjv529d5hugfz0B0MkB8gacC/iaBHS/RHOl+dZKhDAsP6wgdaH5XSvQNM6hF+oJU4mSnDYRscZMdsl1wg4IwJ2LAavwM3PV40UCh2W8xxnEE/IsM/yrqKfJIOFMfDM5n7WjMBY8uXFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926947; c=relaxed/simple;
	bh=gPoST/jt5WBqySZv7iVYaQ2xz57myOmE5UZ/PJ6KVNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XDqSWD+lGnu7dj0ffbDDDgZPyh9tpOLmG0DY4Llj4yGXhW+GarxrezPRpOuG8MhdNTcwv0nqs0ptcZQVZN2kGMQN5T2Wsi5WuW8APcJIDkv3Ya/PbDgpgheUEUwH6wLpL7ObMZ2QB0yE6aEB2DRizzcjDy87YIqRPK2eQmepLjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LDxoTqSo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216728b1836so155860945ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2025 09:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735926944; x=1736531744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tPsZYH6BNmlb0EtgXt0Wn++FQ1eCSgqp7vMNq661tIQ=;
        b=LDxoTqSoHe8f4qhIlb0lHmtb11ubKnBOepVVfWfFC9XS3NKUqcq68rTyNPIy6gvCgP
         IN2Es2Ge6ltNLGtrgL6kgISZO5AVxNhrebZV/xG6Rw6Airkv6ooBtZY8lZGGIdoN1gMc
         K0nptYPQisY8BG+ccqBCKhNBZq3E0G2JXBBK0FMe8v9Vron1rpkZGDaLgeBkz4PyEGUK
         46tV2Wmcrxe02qndLu61zqw/VwGx1mleptGQfbJ8wB4kr+USXzxyfLHE7xHXoY4IYgSy
         to9/ckqmqk9tVIreo7j8s2wJk4tix0RFs6WJ/Q+F9flFjENR/HAjN8JtqzXpeIx+4Uwe
         X4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735926944; x=1736531744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPsZYH6BNmlb0EtgXt0Wn++FQ1eCSgqp7vMNq661tIQ=;
        b=c9JzS8akFzaww8M111vi/vuhf+jzQ+I0VWd+WOjtSy7qrp4enr9xtp0AJNzFzPxdId
         ekHaCabV3u2iOqMlXvwGM0vv6aXZaNjdtbzneCSTcliCq2RFyU1wU+HoW5TQGN0wp/yV
         mGg5w8/RLDe7BTCIF2olB+Auvg5lfjNUTpHgAGyjFMce5GTKeh+IDevXUNtGKP7+8NM9
         wk2BfSsj8PPufu0AKHuaoqlrouO8IQl8S0rsTVHknunK5VuZEvRrmzQyIyJhfI1hceZ1
         7c4kybljkJNReQmjuCgWdv3NOa/8psFGpDRtvv/EOEh2JZc2qyuT1AxSlAAQk5mS8McW
         pcGw==
X-Forwarded-Encrypted: i=1; AJvYcCWegy2iQNQsNVKr8148ySwA/KcR03Swzkht8Aix61LJMaFhD9AqzHdwvxZcOjB6Qrtcp0KbfvC88FnLFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+dHdhxJ2e3iQQPqGoPTo8UqyWXDmOgRZOhbXVTLoFLJG45D7P
	wSycpd0nn/brDHXL7yRg4oU0A6j3h3pgOuO0pszBteRQErI+SI99jtvdGQMfXHFWOcnTPO/dxoi
	k
X-Gm-Gg: ASbGncu7cad2Ro/8bUXtV2sXtUlwmgkmSLABhGc9OwXx4ndI4jWReU02smghzC0YJ0i
	r/WRxgKSVRGgU8hAItUUjoG4a/hqSmU1t9azZ9vxD8H8yVtXSZVfTKOUdRcgGig70/TTEsGAOk/
	9Gn1HIRkJz8jKm4PzTiRWt7lLOjbclrSBb0pEN2NyDUeCmjjix4WfLSjpkQuzOP4CcNuq9BdqjV
	ZhFhBmOT8agFfbErLtfWzmDXaRIrUzcXGLhu/GyJRQs1/6Pn6MU7A==
X-Google-Smtp-Source: AGHT+IGpjDAj7wrf2YpqomVMGgMN9e4h2te9bODPZwdcmhZJW8ZzR5Neau+h12vSaifj5qtJCGCreA==
X-Received: by 2002:a17:903:2449:b0:218:a43c:571e with SMTP id d9443c01a7336-219e6ebd140mr764868055ad.28.1735926944525;
        Fri, 03 Jan 2025 09:55:44 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a1773c654sm142231765ad.29.2025.01.03.09.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 09:55:43 -0800 (PST)
Message-ID: <679a18ab-13ab-4a77-9274-7de4fd0d175e@kernel.dk>
Date: Fri, 3 Jan 2025 10:55:42 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] btrfs: fix reading from userspace in
 btrfs_uring_encoded_read()
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20250103150233.2340306-1-maharmstone@fb.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250103150233.2340306-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/25 8:02 AM, Mark Harmstone wrote:
> Version 4 of mine and Jens' patches, to make sure that when our io_uring
> function gets called a second time, it doesn't accidentally read
> something from userspace that's gone out of scope or otherwise gotten
> corrupted.
> 
> I sent a version 3 on December 17, but it looks like that got forgotten
> about over Christmas (unsurprisingly). Version 4 fixes a problem that I
> noticed, namely that we weren't taking a copy of the iovs, which also
> necessitated creating a struct to store these things in. This does
> simplify things by removing the need for the kmemdup, however.
> 
> I also have a patch for io_uring encoded writes ready to go, but it's
> waiting on some of the stuff introduced here.

Looks fine to me, and we really should get this into 6.13. The encoded
reads are somewhat broken without it, violating the usual expectations
on how persistent passed in data should be.

-- 
Jens Axboe


