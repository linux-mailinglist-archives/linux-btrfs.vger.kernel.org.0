Return-Path: <linux-btrfs+bounces-2870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA4886B4EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7912128E099
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B353FB85;
	Wed, 28 Feb 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhtfm+mL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77EA6EEEC;
	Wed, 28 Feb 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137713; cv=none; b=RzwllKGV9lzhhDnkgjrz5K89zvj2A1oprPokbtjCp8zOx1vnKx2EU/C12XKYqYMbidobU2kEU5MgQANrD/zyQCb0rXU0XsoWOEg0FtpbDqWt2C/aNJTJRMG0i6Z7SuxE4OC4Do1ftgMvB5dVBGDPqJWqt3gDhXA/4w4aPnHsIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137713; c=relaxed/simple;
	bh=rzJSJkva3PtBW+oA0aOjMOzhlLevnC0c9zdiruimJy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpDIyQF0UoYfyoUNhCRUbKAQJlmnPmAh2aNXgEO5H5lSvaOfaHEHkokxzEXyNSkyj6cFBLIfQGb+hyCSCmM2/NYwrQu4Vjl6OR8Mp6wJ7b7uEXykCtQnQ96hTIXnoP2X7NLi4/frTvlKZUd7FT990ELsegtBpC6RtRjK/2I8apw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhtfm+mL; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60908e5fb9eso36713037b3.2;
        Wed, 28 Feb 2024 08:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709137711; x=1709742511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J9xXOsuu/zrmE8tx8GTKpJgtMByVr0NI+8cB4bxXCLw=;
        b=nhtfm+mLR7XXUMae7YnmQ/wbUlmleogyBvYN0su8bpt8BUyeM853aycc1bpuoypPZy
         pxS4xUgS8+ZoGmO1XPjRzdTOWcY57oyoiQuAUeUEWmotZJHLYAW4VeGAhkdAujV2gTEV
         862ir61rpgbtVf9whYpJPzig4jP9wicCrETG+Kh/eblGp+j7tbkTlwLltw9SnqOSepX2
         EcuovhYcDG1KLPr3UM6JhjLdvJO5MW3GaYUTXrpunScQpEaMaoGNzwB94RHjr+68pIa7
         nNRKwcNIrDXYfo7DvwKrxcRW9LJZtCuF03KUrXg5zaAZeDNa8758zhMutVLBcMP3+BOH
         JXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137711; x=1709742511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9xXOsuu/zrmE8tx8GTKpJgtMByVr0NI+8cB4bxXCLw=;
        b=A0/MaZHJRzztbtp0cR9dhD8BOrl4K+XdPq9ouBypnJydYOn+vLDt471jNsHTIn/EzC
         na6AfczSUqaoDKrBiezXhnZyllnQiWXFB4AEznKhEPNFi6iEykBAFxDCEBUxsdfAIkEY
         M5/4PdFChr+xTq6zSstGOivRk6O81qmfRFZplSA2EYxK+vgwC9fr7TxNIz3CdbPZglvO
         gAfFWnf+H0uGfWAshqqS16Sl1DuGQf5LQ+19nHTMNO6hbh7KIvI4y3D9IFr8O69Cv0fs
         lLMkXZqDRIRXMlWTmTC/q12tVBp2xjVDuGVgXJePTflJpE10QeJgj7gKazHFhJRBtOKb
         P/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWijixBnxXQ0gtD+w06ZUmYvD4nYWFkonjQgWbliDqe0pu/+lHJaZJPpCafFtnJHqPiPcOD5jF0RXN4fWr5/MlQLNgcARIlb5HSjsxjbk6Q9Mx4dOvJsi6xCcYdPCUm1tefR3K3P+NOfR+9xupoiFdMXjRrhcNEyPVu+huOvLb6QXXww8uBmMM5vGiz1+EVxGjxQIEltzA5bpaunGVm
X-Gm-Message-State: AOJu0YwpLHh/6Ql+UcQ5tfyBsYYmJihh7LbnFVxJl6Il4UgYESq5BcVF
	PFtXW+jAxcr+wu1y7KcMsv0J0zAw4ne7JtNCQ//H4WhPsfoWqx3b
X-Google-Smtp-Source: AGHT+IF7XbBhR5dwgNTUI3cgJlRp6cCPJaEGoJEGT6h5P61G+BSbNJ3st82/ffk1EVnm0MCnhDNYjg==
X-Received: by 2002:a81:e70c:0:b0:609:24ff:bf5b with SMTP id x12-20020a81e70c000000b0060924ffbf5bmr5536903ywl.22.1709137710910;
        Wed, 28 Feb 2024 08:28:30 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id x6-20020a818706000000b0060499d3a893sm2464776ywf.116.2024.02.28.08.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:28:30 -0800 (PST)
Date: Wed, 28 Feb 2024 08:28:29 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>,
	Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>, linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com, ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 11/21] tools: move alignment-related macros
 to new <linux/align.h>
Message-ID: <Zd9fLYP0uzqqwOdO@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-12-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-12-aleksander.lobakin@intel.com>

On Thu, Feb 01, 2024 at 01:22:06PM +0100, Alexander Lobakin wrote:
> Currently, tools have *ALIGN*() macros scattered across the unrelated
> headers, as there are only 3 of them and they were added separately
> each time on an as-needed basis.
> Anyway, let's make it more consistent with the kernel headers and allow
> using those macros outside of the mentioned headers. Create
> <linux/align.h> inside the tools/ folder and include it where needed.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Yury Norov <yury.norov@gmail.com>

