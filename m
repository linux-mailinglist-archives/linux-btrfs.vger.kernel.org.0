Return-Path: <linux-btrfs+bounces-19976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC9ACD829B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 06:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32E4330439C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 05:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE682F49F0;
	Tue, 23 Dec 2025 05:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRS6qc7F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9A2E228D
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766467989; cv=none; b=p5UjaQLpVcdI82vViv4S+4hQbFvDX7iYYdtuggKSk+JqdeiaCgmO+lwrCRnCTJJgWLZgJORfwtIzihxMzGJg6TadPViFRKcM5UUgzwhZ5X7bSSejV3JauOVWYd4NnepSK6ASg5O+cpHXv7Iacmu2o3eVeYTn9VnTx2FLuMLbbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766467989; c=relaxed/simple;
	bh=NqkuKEROb/OmRVYRZgeOKw/Kls8Un9PKgqEiKcwkGnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHxOqfZAiNtkWyPIGGjp2bHSTBpIyYRcw07K9wzO/1DdWvaXY9I6Q2NxByG3ovDNdg/2ZgMQarX3FTooCDaqIdh4+RoxYpA0QImX5UlQjZYSSaWo7d9RHTE57ZG6MBLnD70O0uBG0toH8MMtMMfF6qZTSz2tmAFbhuZgySZFFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRS6qc7F; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso2659557a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 21:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766467986; x=1767072786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqkuKEROb/OmRVYRZgeOKw/Kls8Un9PKgqEiKcwkGnk=;
        b=YRS6qc7FN4EtduWa68ZXt023TSQiTMXdK7qVlD+eqY53wkWAc89L+baCoLPtatoQNV
         nRV1kqExU4x0Kq/7nLf23qk+jbHPJl1ohW+d6khZJaUUSHKu7UEyHFcuAq3mVyZfVs2E
         mTs3xHvhMuxCjBsNRAzGXzVyQIm1hFrGsZkIVSNA3tnwpvXfk5MxMCrp1htANa4luD++
         f1I0ejIHnRULvDlp6uuawM2q3dtIwL6o3ClXqX/3lAzNiyqtoHm6/1AckOVeDCqzznAA
         cvLnp8ljOlrbS/ahjo6lewbqz/tmL6Gf/oJ28nvKtLYo97aUsLsSQU7wgUM6LnBxyHtH
         UOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766467986; x=1767072786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqkuKEROb/OmRVYRZgeOKw/Kls8Un9PKgqEiKcwkGnk=;
        b=KTPpHwuQ8UO7OWgTuqwq1qKo18zVAejhgnUQjOojXD+FRu4FcDNggAdag1A7xAJZTO
         Po2fECCoHLLTBDwWdFwL0d5x8Th+QdUVPzh3d3XCmwfbLNnErjKFpxdr8RC/yQAI+Szj
         sgd0cAFqG4Uh4AJXfX5dWPdvEnC6MwrN0YECRwGQ4pCXAT0RNNta9EvUTvs19YGm9Wln
         JuGE8F+1+L1zYU4lCKX4qNfgPgp0lFfYYBKLZj1I/NKXa9/6h4vtyifM37yRiS3o/+Js
         hlMo4yCtT+pJ0ihUfyiqUJUFUN9/sBwN5pYj+wUSdLAnrs7mKm124MWX7a7onEs8o9EJ
         Lllg==
X-Forwarded-Encrypted: i=1; AJvYcCV0WQ4NFIkSg9C7rCNM9Rk8kxEiuspvnGkILtb6V+t2BH+88ba/yHLKnjCLw+N2aGNTcPS/ajJJZZEbeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCZehzI8OfHsct9zf/BpdibgFjdirRSOgdxNt4UtU7H3osNnav
	Lqa3a/9RGDxWf8wBDgcldXGd+3Xe1NhlGB4TriIiNv+Fz1rh4wgluu93
X-Gm-Gg: AY/fxX48GPdnMWC9Rh8W1dEk+I/iz+lF70Xlmyu9+B6tyO01v2aCFika8jRrnlGlEsn
	MX3HxTKT9Ugb1Xv8+WzzaAqxyqQfheH2fL2r7FcSFgxapHjK79XwZ2gEhn/0HYjWXQDtYMWeYQn
	fyT0KjOtXWbn+adne0TmSFtEICY+LGk1qBwlctmoUlyU7qBEjITXfg/eca1dBY2xv/cK5aA7uPX
	E4pr4oEHkZSedhRQB9XPzqbk7/KBOpXAfgSfFmZnmG3w9WGDvVuFTyUoLvRH3ychWMatPA1A6vq
	Cb1hYN6pEBs8oV082owycAkFdKqtJfcqps4R5/OS6TJ3br/YEZrzkiVG4usqmroEtTcsnaIOy9T
	Jmc3XbbKQ7Kee+UuWFfoE1p1wRy0DH378HFFiAIuHSUwIzhyQ7acK+n9i19H4u9jsqK9hNROOlS
	utK4e7WHyRdioLscK8vTb/hSFXoUn3w2AHTfqHqOOy7+Tv0tvsTKogUX5Fwkno6DpE
X-Google-Smtp-Source: AGHT+IG5Qf4dCPxqVYyhhZiZ2cPZHWZcc5Jl8Dom3Sf+VbFYEbzUaslYB9RlXBdrrGXOm7O8E9bw2A==
X-Received: by 2002:a05:7301:1a12:b0:2a4:3593:ddd6 with SMTP id 5a478bee46e88-2b05ebb6038mr11158060eec.3.1766467986000;
        Mon, 22 Dec 2025 21:33:06 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm54002618c88.0.2025.12.22.21.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:33:05 -0800 (PST)
Message-ID: <12bb96b6-1e2e-4f53-b4ea-1fae2500aa21@gmail.com>
Date: Mon, 22 Dec 2025 21:33:04 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] fs: exit early in generic_update_time when there is
 no work
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
 <20251223003756.409543-4-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Exit early if no attributes are to be updated, to avoid a spurious call
> to __mark_inode_dirty which can turn into a fairly expensive no-op due to
> the extra checks and locking.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jan Kara<jack@suse.cz>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



