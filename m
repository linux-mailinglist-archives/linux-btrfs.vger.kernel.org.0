Return-Path: <linux-btrfs+bounces-6893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0B941BC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 18:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C95BB276A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C200189919;
	Tue, 30 Jul 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="w0BoWj4T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC14184549
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358574; cv=none; b=sS46cZgHto0/vtCVBoiY3mZ8BRy4Fe1rGkoqEYbCl7EExcU2/zWeSiixqIwWLZn+AGZd2dX6HW9Tuqqv8uGi1YlM7R8qK4I4qEGYDn8XJSIxkKuYtuOy/QbL+PXrALhiUQCXqHuet7lkTgBovmTKm8CMSv0VYC+8jU4+Jrf+rjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358574; c=relaxed/simple;
	bh=hm25pYgs464Ixmhmvvyc8Gq1HWeX5HdgeR2KgGzZUDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiD33T0eyOpCAlyhzK14L76EUUcpRgHiDhCJMl9VpAa2VTX923DkeiM+foUem8uzueha4URbcZUNQJ96CJi5iMEpoVPK/BB6uskwjXjaTjX0RROrjBi+Rxq2QwBr3D0EedhJBPbDeL990I+ezs0kAYwSwegu4Q3YPlaNkf5YfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=w0BoWj4T; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-66c7aeac627so35599327b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722358572; x=1722963372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=242jaByKPfn8Y8xWsCYwJvr/0nFEia3sgGdcNttEbXY=;
        b=w0BoWj4Ts4SNPQ9kq7yA44/ERs10d9RDg3U09wY0jNVfgWGZJaAe9PiCnjOhAQbPSI
         IAbf2t+FcrW3YzDkPyzlfC4ha8w/NMdxF26EPDcV9tEnPApo+eWpCt4TMERtslEH9SSO
         2pH+FipN75DWgYgvt/t3OJCeXJfdCMVabwQsZuGFbrhtNmhpX20vBuH33Q5/wn9fphZB
         rtA//adjwNx9PojMHNwdl7fMV0UrXYxSFRl+38VphbQDrWSjZWpk9ycOGIcIIhp+gpC9
         N7BFeVKE4ZM6p8uJqlWg3FWw8P3iaQqYGRBX7Zsybo+9PY4x/W5hap/yPWYahBmj+W/0
         SQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722358572; x=1722963372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=242jaByKPfn8Y8xWsCYwJvr/0nFEia3sgGdcNttEbXY=;
        b=vpQt9Zq/oE+mYyq9yUL8f0DqE3+nJzrw2F9ygR00LSDlI693k2YbwN04uzX4THi8zv
         X67b7pJiozRgnpvNcYB33ukE3ubleaGgkim4uLj3c2UiE2bfWWKZHAZn8O+QTGu65jmc
         wItWxk5h0uTgzYPJ8Ga3DTej6lkr4rlyJaPb41iX+aDSk33y0cHSzG/uCOC+zV1eMjM1
         uyXDY+VGd1oYJ073uQZ8jYIdc9RWhUSdCQ5AhFzSIP1xrwVncFP6heNEyzOLQ7FPChX9
         kMPfrqkngzg5ZJJ7NhW9VFMBeJqL7bImk9WGxRYWeLuv1TpfEIEHZXOdZnBK+Qjc9kGU
         pcZw==
X-Forwarded-Encrypted: i=1; AJvYcCVz8xvdLBbE7KrfjYsqeHz5X6uD3Gys9+HXGGVuhw7M8Df0yIKhOPHnpD/NnBgsIfuTY9Zr5lyqjH4GfrNXnisia2Fh/G0Q1CDsQqw=
X-Gm-Message-State: AOJu0YwED5bPC6Nne7ZOEmDY7Xwa6F62svJu9fmPyw26ts8TGBKmDNnJ
	t16lYT7d8WgdpDUMFCzxnWj8qSnZE2yg3EimtK0VaRcgq8nE/uk+W2djj2x/4h0=
X-Google-Smtp-Source: AGHT+IEtVH3jrcsnmwnTqzQKJIiPWPoU26jH2qk9/VMRrXXucUEoicVRBFzUGjQwdElc9aL4PVDOsw==
X-Received: by 2002:a05:690c:d92:b0:652:5838:54ef with SMTP id 00721157ae682-67a0a9ea615mr196342597b3.37.1722358571653;
        Tue, 30 Jul 2024 09:56:11 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756c44d4b4sm25749997b3.142.2024.07.30.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:56:11 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:56:10 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Johannes Thumshirn <jthumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 0/5] btrfs: fix relocation on RAID stripe-tree
 filesystems
Message-ID: <20240730165610.GB3828363@perftesting>
References: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730-debug-v2-0-38e6607ecba6@kernel.org>

On Tue, Jul 30, 2024 at 12:33:13PM +0200, Johannes Thumshirn wrote:
> When doing relocation on RST backed filesystems, there is a possibility of
> a scatter-gather list corruption.
> 
> See patch 4 for details.
> 
> CI Link: https://github.com/btrfs/linux/actions/runs/10143804038
> 
> ---
> Changes in v2:
> - Change RST lookup error message to debug
> - Link to v1: https://lore.kernel.org/r/20240729-debug-v1-0-f0b3d78d9438@kernel.org
> 
> ---
> Johannes Thumshirn (5):

You'll have to rebase this because there's some fuzzy application with the folio
stuff merged, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

