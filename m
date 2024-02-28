Return-Path: <linux-btrfs+bounces-2863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F1586B486
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F6F1C22AE2
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74653FBAC;
	Wed, 28 Feb 2024 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCWtsqW5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927FE6EF07;
	Wed, 28 Feb 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136987; cv=none; b=UJbay+B4Zvx3AMXRy0nQ9oicRLjhfTYwqaf39bOV88d9jKE1DgensRcp1zB1TK/x1GSAw9ERHodRGRE+1mA2jFtrJz9I5Z5kq1lYMilcEzBYu9oInJTybeW2lcg3d90quVq21gdW0z1zI4npwWJdCqT1gvch8eVi/AN+liRuUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136987; c=relaxed/simple;
	bh=dHGlPHjId7IDqTtZd+lyHXklOZJIi5h31Eb1KiK49Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcpgFOQTbOl1ej8LzqPEn/Y6ucGYf9yAXInwtHedaexHqmkCMBflv33C7x/jOrVZNA6StHUQ5cpFXae9E3dml0vJpIodgZ6QlxCB4CzomhPzEzL0HiTKRc4YnQWI42MYNmXrcEGWV5nnnEpoShSZDbxitk3TqpJk8QuVD6NXF7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCWtsqW5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-608c40666e0so45773907b3.2;
        Wed, 28 Feb 2024 08:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709136984; x=1709741784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bfjds2qROW0bvdzSePF9+wJs94wOzgupIfS1XbRJIJ8=;
        b=jCWtsqW5gXf7ZmXKQsf43+NC+BvvIjYLUe2ZPp9NZuQU32vDd+bBvR4BNgOrFA+Yeq
         1PTcs3UboZky7cpoA4Le+WpwxOhuNdmNr62g3Gtv/Wq2Z/rmlRoUujbgomKJvS534W/2
         kX4+aDevBc8TFP8VcerZ5eWzYL7X33rI/65c9dwTNrzyAsMFzG/PHdFXMp0szXOk4Vp+
         RHWekyNblZS2ZJakMf7DG4FPTVmyODb9A3hqIczpKXVLf97n4PJEYlDdmOApPc+mIcuV
         piqzLeUlv0+QXlrODHZSGQYDXHayyGRfG1KxEho5xi02EV8sEqZ7X2pXLzlXHiPf6l8J
         Umvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136984; x=1709741784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfjds2qROW0bvdzSePF9+wJs94wOzgupIfS1XbRJIJ8=;
        b=D0gjHW3Refa+H26WxfWIy6Vdo3GyXZ8MFBApiEe05Upczgd+q/ZUJq5n5cbAGtP6if
         I3alvHJmf5u5utDnOkvE3ipe50m5intKuzg21KGUa6FglvEVHMJx9cg6mApjsbaUwati
         9eTHgT1oE+p7H5MQgdvikmkY/eg3+/VnuZNVQQnlUcMsyFubIyVBxjTStDh24iCFZ/G1
         O4I1duExY/eLDYtai5ye5m8rxeDNA6aM0nqsyF0OI+8iLriwsZdWeB1V1cxdZ52JoU2v
         SyKdRuNY3r7+fw0ys9GjIMQkgOQ8oV9usWec6VyhPEi1WA3m/0WMj8Tzrri4sUQIPBC/
         IGNw==
X-Forwarded-Encrypted: i=1; AJvYcCXzpl22fppg5tMIxkD0RN8eZkIeSPrt/V6LFAKzLZvAZCoebg64R2xlOUWUAkJ06XOIp+LQX51HcCUyzrUMggv+hUO5g/r144Ct4mKfH2GsmlTWmjwUMzH00n9BK9Cgwj1PFJqaLC5tVrBH3iyact7BnIKyH8cvPmvkub7T0e23xmfEs6+xMlId4LI0ET9X1ZI5yC9TuMgFb6lrCtXS
X-Gm-Message-State: AOJu0YzMshCMXpElSeyRnZGaZ7HER/GAPEQ9XeEthbxpp+4QRSlrKvUI
	DSyKKo1WkW+0E/4hF/9BeE9XsxMv/dE76fTSrUL8vpJkTnKaYy/3
X-Google-Smtp-Source: AGHT+IGRWx7BefJXgsOF8UDKZq6u9sWMOTAUPepP0gk7cEVY5aJQnte0UhFGWBjNGyR1b4oJrRlKng==
X-Received: by 2002:a81:e348:0:b0:5ff:aa34:7c5f with SMTP id w8-20020a81e348000000b005ffaa347c5fmr4887584ywl.46.1709136984377;
        Wed, 28 Feb 2024 08:16:24 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id i196-20020a8191cd000000b006094292e834sm302616ywg.75.2024.02.28.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:16:24 -0800 (PST)
Date: Wed, 28 Feb 2024 08:16:22 -0800
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
Subject: Re: [PATCH net-next v5 03/21] lib/test_bitmap: use pr_info() for
 non-error messages
Message-ID: <Zd9cVnjqfLefeMvh@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-4-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-4-aleksander.lobakin@intel.com>

On Thu, Feb 01, 2024 at 01:21:58PM +0100, Alexander Lobakin wrote:
> From: Alexander Potapenko <glider@google.com>
> 
> pr_err() messages may be treated as errors by some log readers, so let
> us only use them for test failures. For non-error messages, replace them
> with pr_info().
> 
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Acked-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Signed-off-by: Yury Norov <yury.norov@gmail.com>

