Return-Path: <linux-btrfs+bounces-4316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28288A723D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 19:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593531F21944
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313E91332B6;
	Tue, 16 Apr 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="M86aI3/H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292AB133284
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288403; cv=none; b=Ppo1gJ0ggNIulqk6PSpzF/qH7Zaojhl15wP0TZAi5NG25bNEEGKxZf2xkJCxS99xCf6sKgfh5ZNl/rkzjzehYmNYL2Da3BuKk8jd2SwFYIGef4vt9zB9sHOhkztl3bb+AsHN9u2Mpe4P9TP3Bb9hvKrHj5Y1h6BKtAsR6ZuVAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288403; c=relaxed/simple;
	bh=sdBRpEGJTFO1+Mr19YyKENU3kDnRM+pEJ8oBCRtJGgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQtt4/vLk0jchNKOOAR/i1CreNzMVCoGwXROQDbfADg/hf9F0Eu9EZ41UdBp34vpd3X+0xJ6cjP4vqe1HmuFfPCrgy6OYVUacFS5FpX4w1PAXCYT0vEZE2WU0ebLudbFyk7BpV4LcZjzAsUQ9RSLA5+4SZLsUS26dTF0Ol1DUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=M86aI3/H; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78d7558bf10so409013085a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713288401; x=1713893201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXtLCo9TPypaGlB6IDj7YdRm0RAyHmSGNdt7p9r0NIg=;
        b=M86aI3/HDp0+aNgCniy+E+aLAAylgoRHeKIBU307ifnisdEglUhev8zt4pFk5irNZ+
         4LKCet0rw5YNgaCNX80Mc4hvLR0gq3b0ESRNlJXeGu7K9YCpvrf3KkiDuG3TxRpNxnoQ
         3BcuDuqmIe4Th3yGSHR0g6IMcVy9C3bdCImTewdwLxIovrv5H20JRnjgODVzZuHh47IN
         fAK2SQpbs0QU5c2idjckXF0sF6yOZgtY4QVJOwmsTdbzrpvPO1Ha1V7/3385wghUuDqU
         OGLTIJS4ooYIgW7F6SH8Wk4xNYHBkDEI9hO+qARlGzR8hqgo25UMORjSYIx9An8+MxWU
         r4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713288401; x=1713893201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXtLCo9TPypaGlB6IDj7YdRm0RAyHmSGNdt7p9r0NIg=;
        b=OnLKp889n7fG0WkkTnkIpbzTBAVJQyittetPOBNw0131aObA+QBp2J9z6/35ku9lHO
         kiHfmOCepYDuTfO3VSDgxLyYV5tRLJLsDONpOMmIQmZYrSg+tiBrzpBBe8sX+BhdlSrU
         ulX5On3NK3qtQAadwsrRBVTARX2BLxwJETdmI+f1d7KCHWK3HEuRvPG08CUY+XhB30Z6
         278Gc35cXU1kW6vgy6pzs6nPGd0Caf85JC06Q0meOyMVlFzGH9Mim+Jnkp6txXLZT49C
         kdgiE8DUQ1Oz5x+TQJlSlPQGDtRihpZTOU5og/+vC8UJyiGKUVMbE8nn5cwvMMgT1aFx
         rGrw==
X-Gm-Message-State: AOJu0YwEGBD0lHHvbEGhQ4Ww07NInZcF3uEqqBq5P4FmAYRg8h8mYZw2
	eBdPTUGnFI2ltxUXNbU1gT+oSboNulxyN0O+GX+xjiP89Q27EkiH0wAJm5sf70gOb1FlhcettZA
	g
X-Google-Smtp-Source: AGHT+IH7kdtXYkFiIbBmmt2L9cKmjkcF3wIK2wZahm+R1hdvAdVQ5zgXP4J0/2br6OyA4oGfKeQSEA==
X-Received: by 2002:ae9:e119:0:b0:78d:409a:1d6c with SMTP id g25-20020ae9e119000000b0078d409a1d6cmr13758566qkm.21.1713288401073;
        Tue, 16 Apr 2024 10:26:41 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w14-20020ae9e50e000000b0078ebe12976dsm7684203qkf.19.2024.04.16.10.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:26:40 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:26:40 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 10/10] btrfs: add tracepoints for extent map shrinker
 events
Message-ID: <20240416172640.GB2094489@perftesting>
References: <cover.1713267925.git.fdmanana@suse.com>
 <1f936e6053adef193d57f9ca87c68797c88fae1e.1713267925.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f936e6053adef193d57f9ca87c68797c88fae1e.1713267925.git.fdmanana@suse.com>

On Tue, Apr 16, 2024 at 02:08:12PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Add some tracepoints for the extent map shrinker to help debug and analyse
> main events. These have proved useful during development of the shrinker.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

