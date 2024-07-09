Return-Path: <linux-btrfs+bounces-6330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8146C92C357
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 20:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362771F22833
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 18:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE229180050;
	Tue,  9 Jul 2024 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Xn1mNBBS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C201B86E4
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jul 2024 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550187; cv=none; b=YvM0z17YKqHp8RMZ5iwCyzntvY+tFDKr3vvUnAvpNPU4idAO9sjRSKenC9ELvgpFGdQvzC1g7yjiO5p7QucpJY3SgnNClcpwTAT8ixh6msKy9BpoEt6aDJQEIwNQnjS1QU11rWgiB6qsDOC8SSfXpHLxcKtzeRSH85DOZMLMKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550187; c=relaxed/simple;
	bh=RJoY1hvF1POLzsLr7h6nFw/58ObB7ALUxSwjwB9pCLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN0R3RgB/YsEkxr2cSqKW5ZEwHOPKvjq2/i6AbLXOZ7GFED/WY2PY/eUQCT4VN3KQ1Dx2r7YDbj4OgOYfHjVL4jJp6zgIcBJva8VT4e98/crCo6XjgiVupB18raoaMedPUn048CgZaHy9jF923Ebswy+nZlH9ecOJMGnUnUbG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Xn1mNBBS; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79f323f084eso60666385a.3
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Jul 2024 11:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720550185; x=1721154985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjnRMIv1NdW+QRHrWig66CTt2iigDlyvmBYVZ3W8XTY=;
        b=Xn1mNBBSWPHRW4n19sQLJxfcAsnEH+0KEhpzYG25Wc8DvGq20/RGI7mh2QLiWR0IHK
         yGnetvoHsvsCyTraqhWbdms/8xEtotlrakAmyNoyGuYcWf1KxEpmcpANcFMEP7X5ZXT7
         DB65nkWBoB5Yt9b1WpXozpdpbjM7NrS5PP6OlLHhHdPnKU5ErmIBp2+sOOEOYzKOA0Vj
         gn09RDv7gQ28DKKQ34INjg391cvUawKKvH+MlqiMpNG01VvtmmCUQJHIG/OS2BOU0lph
         W38oKaW4HFMjgc2DkLZJqkcQbFPkNJKAfCs/5tuecOd9HvbaWodLTIB+M0hGHV6ltMom
         /yEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720550185; x=1721154985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjnRMIv1NdW+QRHrWig66CTt2iigDlyvmBYVZ3W8XTY=;
        b=Fltl5SSbh1S2JrNQJQKChM/MaECnJgz7Vym6BXdPCfd3IAjuPRv4jQK82GUg3refFQ
         LHOHMf88s5WR+PiTaR3mdG5ilZg1jXYXhyffmYZ+zrg8lPV94fEUv94kD+x5Muyc4Cxk
         9M+2KABq2J4wxRtf7qhd0Meglk9VeYIMhEjkMwoPg1ykgAHfobmDuBJ+itix5bPZ6sR+
         Y+tzzhVSed5jB9MGnrbbbfbbDpoLrcs97DVjdCkofhrLVvGDMBrkud45AtF+g51jpwsy
         8lMv0wrqawC3yiJpo1Us1sMfil3yPzZ6VVPyDUl88dxyzlOyL0emv5fhnfPpQEZYQig8
         w9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTE9aBY6oaDDr38wyVqaiPbSmnNHDE11cTaM82tZWsskpHNbEz+EkVMxEZIlPGxjwTSXsKC1oYZ2PhKz/bqE9RwQfE49STTKr0zYs=
X-Gm-Message-State: AOJu0Yw1EwRMdW7sowwP5VWatpCyT/pA80lJjjVuBPGJZI5cOwaNgtoW
	mcKyL80Uyt1Tfq4odWqn/eIgkcsLAcJEV8Ek366ARWNMm//oACfhwWNgybka6kxJSQU1x0e2zLw
	F
X-Google-Smtp-Source: AGHT+IGVXZplcORDq/Nfv/sMdJa/qe1kwn8cdY797SNR/+nBbTf/26TfUJa6kFsLuNsO6tIB50GwEg==
X-Received: by 2002:a05:620a:46a5:b0:79f:10e6:2ee with SMTP id af79cd13be357-79f19a78dfcmr407295085a.41.1720550184838;
        Tue, 09 Jul 2024 11:36:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1902bdf5sm121210385a.66.2024.07.09.11.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 11:36:24 -0700 (PDT)
Date: Tue, 9 Jul 2024 14:36:23 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Boris Burkov <boris@bur.io>
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs: add test for subvolid reuse with squota
Message-ID: <20240709183623.GA1045536@perftesting>
References: <53cdc0c4696655a0e7a5eb62612a7b87ff4d48cd.1720547422.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53cdc0c4696655a0e7a5eb62612a7b87ff4d48cd.1720547422.git.boris@bur.io>

On Tue, Jul 09, 2024 at 10:51:04AM -0700, Boris Burkov wrote:
> Squotas are likely to leave qgroups that outlive deleted subvolids.
> Before the kernel patch
> 2b8aa78cf127 ("btrfs: qgroup: fix qgroup id collision across mounts")
> this would lead to a repeated subvolid which would collide on an
> existing qgroup id and error out with EEXIST. In snapshot creation, this
> would lead to a read only fs.
> 
> Add a test which exercises the path that could create duplicate
> subvolids but with squotas enabled, which should avoid the trap.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

