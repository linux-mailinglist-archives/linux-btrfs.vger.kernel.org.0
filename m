Return-Path: <linux-btrfs+bounces-1527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 809B8830D01
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 19:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10277288AF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 18:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A52C24205;
	Wed, 17 Jan 2024 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VYcnGODO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8675A22EE4
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705517586; cv=none; b=FinrU3YVVIKMjh1ccETfvo9bntEplQv+bgS+/ZfPFp683BBbxDagj2uUjuKXKWrPc5e15xJHxhH+JehicWcH0oaLdaPC7eOG0CY801N7Egy3DCHjqgfjnNY4qO+ogTOyzO0xe4ik2H7nhcPJDQxBtgYZfdXMLiP9ykijhqaZuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705517586; c=relaxed/simple;
	bh=11IVJDEQiwuXk4z9roDiMo7LyUC94vtLzdXOm+6INrM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=st8uF9YMuAtTHHGJ4lR4xSY812Tj2ZcN2/zzU+zmjRbg51Nj+Qkcgj9RU1LoGt5a/zfTC7gZP2pOjxumxKdQc63tSDv/DmHOjl75qbjwg6JIwyelH/bxvaUiZc5HSgBWBgbvv79L3Y9r0Ecd8XPEXpoIY9MO1bOQRRXSa0MGbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VYcnGODO; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc2501ed348so265437276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 10:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1705517583; x=1706122383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nrEGUx0OpS5J18ZaHwo9r9nu63k8KEl9OuCZGtInMXM=;
        b=VYcnGODOZFckOkAXLBZkfgTOVEukj9jD2Yd3eeURdgOyenb/JXE/ek+4+ofwMO1Xfn
         OyJTzYX+BcGB724bCu/OvagDsEBQVzpSV5kZJiFPdJf3QrvhYKxC7aOWdGmiJy0oha5X
         W+inJK/2Mkc+BCbVx66RnzWGLL6BxvMt8yfAT+RVTYPkKdDXsSKh/+FsQorLj5E2xZHJ
         aRS56DMsN6hLLRqLpg4C4DP21iMO2bqynGaCMEmxIMs2cB2C/ycXwpsiXzHLcIV8nQDx
         Qh/nk1VDBMNZJTV0H4B1cToMKvbb8ktGb8mElwTeWFdM9lahQWZxiw/3MP3qe21kzYXd
         IWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705517583; x=1706122383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrEGUx0OpS5J18ZaHwo9r9nu63k8KEl9OuCZGtInMXM=;
        b=bb7gmJPxlt6nzedpsMH3ursjXDJwxY+6ihFC0AwwDiWohxkNOaP3FEDBWfmq0wAPRk
         fghxjELxfrfBTMWE7lV7Q5ELuLibaCeFOvcWSLutKzhyg1v120aZI5xDGOLKxrBliHM2
         VQpwUYE4AQKQfaUdc38Ts7IHjZqbmi6pnbcGstxAX2dks6RzixFLAs4mSrqGYvc7+rCG
         lRHXi3CA2sAdMQxJPOoTX9xKQMqTkfpObUKfUufEBBuiDFwB+Nc7e7MYdlsC4cqIxDyc
         o2UGowzttxTB70hcBqYgmy0wJwwruNTUSWj1dSm08mhSWrIwolw1uNv5ol16MUpwMBYw
         VC8A==
X-Gm-Message-State: AOJu0YyCYc3gwH8s4FHNgPP0q1hwhp6vlca4Bc/FiU7LD9Y/61TC715W
	O82mwY8BMcyLCCIn/t3U2Kt/6pPa77dc5IT24T9LamQuOrTP9s0v34MVqBVHaOSgUapFMO2zxNB
	f
X-Google-Smtp-Source: AGHT+IG0z1WAoIN1e35oFAha8XxiU17ABAfUFo7IvckP96qT0iGGG9lcTWCttAjF10lpdFWtRY7c9Q==
X-Received: by 2002:a25:db85:0:b0:dbe:d2ec:e31 with SMTP id g127-20020a25db85000000b00dbed2ec0e31mr843378ybf.27.1705517583500;
        Wed, 17 Jan 2024 10:53:03 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g13-20020a25ef0d000000b00dc22e979d73sm1211287ybd.27.2024.01.17.10.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 10:53:03 -0800 (PST)
Date: Wed, 17 Jan 2024 13:53:02 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] Block size helper cleanups
Message-ID: <20240117185302.GA4022278@perftesting>
References: <cover.1705511340.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1705511340.git.dsterba@suse.com>

On Wed, Jan 17, 2024 at 06:10:13PM +0100, David Sterba wrote:
> Unify using fs_info::sectorsize for inode or superblock.
> 
> David Sterba (2):
>   btrfs: replace sb::s_blocksize by fs_info::sectorsize
>   btrfs: replace i_blocksize by fs_info::sectorsize

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

