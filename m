Return-Path: <linux-btrfs+bounces-5476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F578FD1C7
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 17:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1BB1F270E3
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257991E4BF;
	Wed,  5 Jun 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="OI/nsQmp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2319D891
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2024 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601832; cv=none; b=lbHkfpGx5FpnehLWwtsTiNk/fhn7VwhF/tdBSU6Ebl0hqbOaaZ75iq2n1PwAqxoZ/X3g7FLZp7jV4hDWnC+x1XXFtJBmY8kVuYBmOswW9JQykBb2ma/FFFN6gz1k3hE74mcY2XddUbio/cZMuieARNfpv/YekuL0ZZbBnI2G68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601832; c=relaxed/simple;
	bh=LUldyfKgJc+dZoiXvJ7zmYRT2wmjWGQqRk9HJ+9uzmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLENLJQf0emWmCWaAlM3JmvNOsmheTP6d65O1IsKW+b+uisoLlalZzgWa+Fzwxuiw+cIfxya/gjsMQ+RctbSvWhqV9h0vz6vydqEyxi/rU+7Qg5ZPhtXkFMyC7XgOF0S/EqsuWNJQq059Th0Jo/A2Pn68BHataIExeONXmYXhlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=OI/nsQmp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7025b253f64so87771b3a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Jun 2024 08:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717601830; x=1718206630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4uD9/IA3QDOJYPgtOkQPvhr0j6x1QdKSEc78SL7fcQ=;
        b=OI/nsQmppcmnoXYsxnIt7/QJjKJjnE7Xw+Pyl8ubDtw5SyUQidARO+zbhpmJFJ4sDl
         NZOdYnzNrpwjMDdj5F1NLPVqhyw6A+QAa/U7LUDGXsIHptHLFtmjxcx1nVxn8m8qw/Ul
         88EqGD/fWMoqYDPHitlfLr6AZ4xoxxY6tOkHtrDKwb5jzADkErMWw3rOlpaxxR2TKAHs
         /q2c3B7YDJE7OuNrvcXhzkB9R9pD2mEdVTvWD1iFfLcQ4EN+QsHV0MaW6EOP8qPVO9nN
         iTkv1GQOj7UKWsQnEx1tm7yvzMp+k9LThR24WJN6X1iSBUCDy2wQddGyCWFTlJBjuFdV
         AwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717601830; x=1718206630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4uD9/IA3QDOJYPgtOkQPvhr0j6x1QdKSEc78SL7fcQ=;
        b=ErAsBpTSGspLpz20wMj6u8ncvplTVjsvNp1CRI12DKgiixi7NgV9gFuOh1XcRXC1h5
         7UY7FUHNXZn25ZH1rP0pmFxxaZVVi40gZr7ksfBkJ2dgX3U3yTc1Xu8rWF78lhmSoulb
         E2ruVcd+VQoYbQP/ghJRRjnE85RFjv5G9IP5YDNlqI6EzmIB+ERTnfY1MGFW1cBWnbY+
         +cubRK+rP6+feP69/7p2afn0mmZGZ+n2QMcjObhhr3xQ83GzcsmsXVsSD6lDokxYsHqt
         ZMhtcr6OC7/wHQJX2VyJ7LXAMFSJ9+Aumr/abSvmbSef71vpdhljdb3HvYLQlVqZ/5rx
         4eKw==
X-Forwarded-Encrypted: i=1; AJvYcCXGVZ1HpHGCoCcAJyG2u+Y0ZrJ1kiiXjDyMkaWFTG9MbUPPrgkDBJt81ukJat3ocifPUvAU8LDxsvyyXGXoxRDQcdtzWLWWOmR2WRI=
X-Gm-Message-State: AOJu0YwoBeQ4sdxb3pSARykLU9K30CBTsags+W3WUQBMBsMRNGXxI4AB
	XpnCF4VWrwd688OISEc7pHES2G/yocKHa6awrP11EB5LB/7EEkl9UJ+SaZgM/D4=
X-Google-Smtp-Source: AGHT+IHirW/1aCtuBjvLM7s3QztfhP1AqUWIlezDmHp2d5VmYroZmXKl555jdqI6hJFw3fDf62umrg==
X-Received: by 2002:a05:6a00:1913:b0:6ed:21b2:cb17 with SMTP id d2e1a72fcca58-703e5929a03mr2959585b3a.4.1717601830350;
        Wed, 05 Jun 2024 08:37:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:eaa0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c353f0af87sm8467771a12.15.2024.06.05.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 08:37:10 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:37:08 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 0/4] btrfs: small cleanups for relocation code
Message-ID: <20240605153708.GC21567@localhost.localdomain>
References: <20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org>

On Wed, Jun 05, 2024 at 03:17:48PM +0200, Johannes Thumshirn wrote:
> Here is a small series of cleanups I came across when debugging
> relocation related problems on RAID stripe tree.
> 
> None of them imposes a functional change.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Johannes Thumshirn (4):
>       btrfs: pass reloc_control to relocate_data_extent
>       btrfs: pass a reloc_control to relocate_file_extent_cluster
>       btrfs: pass a reloc_control to relocate_one_folio
>       btrfs: don't pass fs_info to describe_relocation
> 
>  fs/btrfs/relocation.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

