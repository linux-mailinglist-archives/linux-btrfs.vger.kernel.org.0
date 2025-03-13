Return-Path: <linux-btrfs+bounces-12259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483EEA5F130
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 11:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37DCA7AC5B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 10:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF961FBC87;
	Thu, 13 Mar 2025 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="W5ZpnldR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DCC1EEA59
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862661; cv=none; b=S6dX4ktsYkMyRiC+TLR5I3GMGXKPQ2FRc+A0AybuoEySeuWm4rRFBiijGtbngs1wbOYEt/i/7Dffb7FfmweHU31tA7XTjNNvFUpc4F0tedza1Cddg4WxN+FKQoml/zuh8kEmCtZPFCoDq7lOA+DdSfMvtn5O1ttVdketlPphkAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862661; c=relaxed/simple;
	bh=cdJZRMBGrkonFB3hvNUzys+FuUKN9910SmSB9F1d9xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlPeFJKUx8meD+y5ltE93He9kOcPTftAN1Fl+o5jsTfoDgCMi0ReZZYOHFPSH9jhPRXTSCSdcAkakneKo/vkfqkNYUGPKQ4x8Z7CH9GrFX2ogomTCZmriIrH3Kzy1gboeJAmDb1EJbasE9AFkQvS0rSOKVsWiGy+Ort7610VtUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=W5ZpnldR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fec3176ef3so1388883a91.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741862659; x=1742467459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ek1S1M2Z/3jRrIpDz7olPRb3vs2yw04VJj39Sas7Xhc=;
        b=W5ZpnldRQfxcSJJinZVeOcGGXQfAX49Kypw13lm1k9ifGsLkO2alZ2e/WEcN9RxQA0
         D54te9B60rKU0TItcrivmXHWUgw1+VNTi8TWTL5aKNhu5bG+Kgh+VAFPGdgdWLJmn2Qa
         G/Gbn5Il1b+KVPrdM0fE4ECOns6zvhuEugCN4+FLA+kBK2UIeLIP8ZGTOllycjybHD19
         PsVKL7TGiKDcRtt8dLu8RG4snOzZvJtt0MpH1BIHlDk3GO67DZElgpaNPXtAyKBlG+86
         TXwhrYFzhZNyYQVZjN8e/IyxV/caOpcn8ev4/g2wrzLGAeslKn0TUkfI+lPtF2TIyu+y
         hkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741862659; x=1742467459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek1S1M2Z/3jRrIpDz7olPRb3vs2yw04VJj39Sas7Xhc=;
        b=ZOlmgI8570iBe9vFDotQ3CqpEahZCzfRkI6GqzE8a0XoNfM+C8uPzh9u2Es/LCzRZf
         B1I1sN7J1sIq9EYqJnpIz/J/KN7u90vzqgEHQ84VxlFjc4jFAHyyA0WuTP9TDzgeYY4d
         XNRlZ9w2x3zxnMjcqLDL/0xRZKTMMAYpznekp2lWw5UwXPDvIWgPzG6w7z4yaVU7zxRt
         1UoJ5rG+yccschhld9OGQzh7SSdNxDo2awZfbXBh23dyXwT5jf1vH9j6bqc6ZkBtMGm8
         k2vNnQmYL+7yzXvO+obgoZlW1YWHSjoVMQTr4AapCspgdN2HCMCPzgCddZC5f67B+5WE
         kXlw==
X-Forwarded-Encrypted: i=1; AJvYcCWl5Kv3F7sq64yEPUr6S3uFlcC1ncN1UT8rDPDlYMwuRi9BS5PFjpuiqaWNIYi1/D2QcKXST2h1uu93ng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hPfs1vjCr/N0+yo3XPzpSOAtWqE6IiXdOm1reEI2ru/XTgw+
	hOCRA+cEumX0j78qvU6SL4uMfsk9eoDR1BGM91wRF1Jb1YsEwxNbxL7EXITwAV4=
X-Gm-Gg: ASbGncuAdaDQSbCpvJI0uVfUmi7XxoxisKqWtc9fRS4txceNSH0VdGm5RoCjmby43iX
	bIcU8wp/kOT2Dck2I0L9P+iuCJ2knS7rV4m8HBc07Oyo9RETX3+pm8Gef8qArixoUqtNQJMFXwT
	dl/5/w8A2hfSV6bU2PV0cdCs/jDape3ch/GJe+PmO44LWwD5O4WVIjDz7Tpvwd9GLWQWgAcqmGa
	tPzCM9vLCuoYHSm8f6l+VdtD2+kx0EeTEexhBYkrj07Hhst/CltbkBL30jXr638yT7gGeo+y6t3
	j1ojldcqaIkQtOAez5QMa+rFuQbKG/D40lPHCMU+L8Ql0+Qvt+mjZQQmwMqAmgNhWc//jCvF0o5
	9
X-Google-Smtp-Source: AGHT+IHsVelts5SRr/WJziCKIuWWVYPcap8L5SU4CGAcvx6m6TS5z81715eoW1D7sFPeTWFvFyFeiA==
X-Received: by 2002:a17:90b:17d0:b0:2ee:ee5e:42fb with SMTP id 98e67ed59e1d1-2ff7ce7abc1mr36460554a91.13.1741862658705;
        Thu, 13 Mar 2025 03:44:18 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3011928706bsm3493605a91.46.2025.03.13.03.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 03:44:18 -0700 (PDT)
Date: Thu, 13 Mar 2025 19:44:10 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] introduce io_uring_cmd_import_fixed_vec
Message-ID: <Z9K2-mU3lrlRiV6s@sidongui-MacBookPro.local>
References: <20250312142326.11660-1-sidong.yang@furiosa.ai>
 <7a4217ce-1251-452c-8570-fb36e811b234@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4217ce-1251-452c-8570-fb36e811b234@gmail.com>

On Thu, Mar 13, 2025 at 08:57:45AM +0000, Pavel Begunkov wrote:
> On 3/12/25 14:23, Sidong Yang wrote:
> > This patche series introduce io_uring_cmd_import_vec. With this function,
> > Multiple fixed buffer could be used in uring cmd. It's vectored version
> > for io_uring_cmd_import_fixed(). Also this patch series includes a usage
> > for new api for encoded read in btrfs by using uring cmd.
> 
> Pretty much same thing, we're still left with 2 allocations in the
> hot path. What I think we can do here is to add caching on the
> io_uring side as we do with rw / net, but that would be invisible
> for cmd drivers. And that cache can be reused for normal iovec imports.
> 
> https://github.com/isilence/linux.git regvec-import-cmd
> (link for convenience)
> https://github.com/isilence/linux/tree/regvec-import-cmd
> 
> Not really target tested, no btrfs, not any other user, just an idea.
> There are 4 patches, but the top 3 are of interest.

Thanks, I justed checked the commits now. I think cache is good to resolve
this without allocation if cache hit. Let me reimpl this idea and test it
for btrfs.

> 
> Another way would be to cache in btrfs, but then btrfs would need to
> care about locking for the cache and some other bits, and we wouldn't
> be able to reuse it for other drivers.

Agreed, it could be better to reuse it for other driver.

Thanks,
Sidong
> 
> -- 
> Pavel Begunkov
> 

