Return-Path: <linux-btrfs+bounces-12360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFBDA66C39
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 08:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCC43BD803
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 07:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDF41EF385;
	Tue, 18 Mar 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="QlaZblXu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3927E1
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283686; cv=none; b=WWKMBWj5S5j604nKP+M34N68MGWziOKocvWiGSh017mtHCNrZlwt/mNishOOxAhgLkCXv19r6P3cvILWVCniBCC5i4h7ZR2mq8y/L9kb4c6Ixp3cKi/Vw8xuuwOYzrg3sBSutF9I5Hur4w2OqKnJnf3EAOuZX5ZCrqUDDzJXi7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283686; c=relaxed/simple;
	bh=JcP81Ufkh8a4+FR/B0XKynUv7tTtPwZ8DFCJsDVbLC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnnnCM2J0YtpPnkckcD3Ugur7QxVknHMZQWUzpjb+mj92yUTtDLj0OLn+y8Q+D6+yxkJRkqOpnFPSUue9t9Rhw+dpCwNkXE1j/OSQWTzVZNySE6Zrxk1qojEvpGHdTm7ak+/BCsEeFwVHSpMWyJogy86emwju2YHzzwvhyX+6Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=QlaZblXu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2260c915749so27667695ad.3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 00:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742283684; x=1742888484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNvQ6tpEHu4cEr7G/ExgaM8GHz4Ko2OdeuJkFdAQxmM=;
        b=QlaZblXuC9z4dA5S96JSxgC/+QK0lPIgRcjv9ySBw22T6NuTCwkCNFHjvATacT0aMS
         wwmeefYmgxV9M6gDPrNob7gJ1fPIXq/6tmdX3e2iY1CGMtT3HOWjfSy8uph0hN+Eq1f2
         YD1+9XFy0UTLYs3gL+kIb/cuMtrhPKnO5o9O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283684; x=1742888484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNvQ6tpEHu4cEr7G/ExgaM8GHz4Ko2OdeuJkFdAQxmM=;
        b=fpq+T4L5M7pz/9laAkIjRuKvcxjV0uRtGqlEC3It53re9K6peO204sim94TKAKPpVe
         /p4HJ7m0A3D4otBPYVqG8kRF1u2IM37twoXnKMDdYNPY91cB53cNg5ZWllJUl3Ixz6F0
         81ikRrKcMd8zXyuggZ4xAwUgfRL1trK3DbQtKGD5c44f8ZwmxM5oAFi7+sXdlCs5rLvx
         tLDIpxGj3HulSTOIiSWWEOqUPIEqMjdEMqR3mhTKssCDr+jlinGt0DDdYDC+AihPI5hC
         7yC5Ri5oqKC8PtAyTLiM2+XcK+fwvQTfWSH9IhOzkNXhDnfNB6RV9yYbtCz/BewhjuTu
         iwwg==
X-Forwarded-Encrypted: i=1; AJvYcCWjKZeNO89MWL9woSoerv5JZ4YcEruGs0HxWPRv9oURpLhfIIuDwmrVeEdxvuNtD3TzK3XsObvpB5evkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTiSLsn44dWY8TFLNg6bctsrSETZKEl8SpgEDVxoUzoGyg2Zzu
	tcEXdHYpNS7Lj2lutvU6nFVE90dTmmVmO21s/Vg9zuIWaEztO52uQpxnPD9ifrM=
X-Gm-Gg: ASbGncutttYZK/kTrMVZKBjMt24FKOxok990LeENfOddi3ntgPm/SAGkXfNPBBRXXTQ
	V+KYcA4DdOiiPXQYXz4j+Oz/mr36YlvTpSGRx9y0RXphzJ0UCurOucY0oPgYBfecs1A1era7gr/
	WcRwoAV811i2bU5A77WVmE5gJnzwaQ+DPssyb/kJur6lcPw+s9Rq3+aq4scAoRRm2pgSx24YvRu
	MEYPXEX0f2PcCecqMBssoRjj7l/Z0A/AV8ty6JGP59lG1pOXcVW0nxG2C+2CZvsMyNiXrV8PlTX
	4bJVer4gG3NCwHyosIT+78l+JRzBEd/qbkoC4EmEe6mDKzyWChf9/P4BuaVctrCSjlrYIu1YYSO
	wypT09bzT/+M=
X-Google-Smtp-Source: AGHT+IGhFAnuORPDCa7985AEuLYw1DqSB5HkYgp1IM9MykQ1Es3utP38TfZs+Lp4ptOx3gOLYo1VNQ==
X-Received: by 2002:a17:903:2ec3:b0:218:a43c:571e with SMTP id d9443c01a7336-225e0a9c832mr206732775ad.28.1742283684564;
        Tue, 18 Mar 2025 00:41:24 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688da81sm87854535ad.43.2025.03.18.00.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:41:24 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:41:20 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/5] introduce io_uring_cmd_import_fixed_vec
Message-ID: <Z9kjoFcHrdE0FSEb@sidongui-MacBookPro.local>
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
 <fe4fd993-8c9d-4e1d-8b75-1035bdb4dcfa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4fd993-8c9d-4e1d-8b75-1035bdb4dcfa@gmail.com>

On Tue, Mar 18, 2025 at 07:30:51AM +0000, Pavel Begunkov wrote:
> On 3/17/25 13:57, Sidong Yang wrote:
> > This patche series introduce io_uring_cmd_import_vec. With this function,
> > Multiple fixed buffer could be used in uring cmd. It's vectored version
> > for io_uring_cmd_import_fixed(). Also this patch series includes a usage
> > for new api for encoded read/write in btrfs by using uring cmd.
> 
> You're vigorously ignoring the previous comment, you can't stick
> your name to my patches and send them as your own, that's not
> going to work. git format-patch and other tools allow to send
> other's patches in the same patch set without mutilating them.

I'm just not familiar with this. That wasn't my intention. Sorry, Your
patches will be included without modification.

Thanks,
Sidong
> 
> -- 
> Pavel Begunkov
> 

