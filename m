Return-Path: <linux-btrfs+bounces-5445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A56158FB82C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 17:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BCD1C24A5D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E71147C96;
	Tue,  4 Jun 2024 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="B3IT3QAr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BD71474BD
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516500; cv=none; b=nBxxNAqeSwYhlhmRIpyZQaE0ryn0dwJb6VwtDZm8HhxS3Zdo7Aiiw53VwFYBVIPFq8r879NXIDDHbqVvVrZxuCg/Ny3rQL4ToCAPc1db8nzRX5fRtuWs3vqM6Srx+GgnEaw+7ptkrAocY1mtEJEgGK2zn7a3AbwpxXt+KwjeAhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516500; c=relaxed/simple;
	bh=DUl4pMHnEy2sOoXrmdpK+r3GTg5JBdeyok8vv33bQQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F13QWAnYCf422FAjSAjqAwKUrUc12bOk6Glw5e03t7bDo3EP0tvYcph8kh5Trgnt3mK6M6A3LLZ2YlnVXO/beArux6D2qGeIUH+mrX2roqTeppuA18DcUhh7frtoE/X+xSPVWxkSBhIrx0py1uq72q2dRQBLlchjG11o4WXUkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=B3IT3QAr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70255d5ddb8so2363838b3a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2024 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717516497; x=1718121297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQfzkFVlaGM5BVrS4JGbXx2G1P6hwLG/vFRgpCOI6Iw=;
        b=B3IT3QAr4gwTiixJYFsSRicRP24CqHIrHlMDTZINS+Xq5BjnRIctW/UBdeI3kM8Z/b
         jpw/m5jwnFASyh0tT+uVXDjfSTiShrdOwapFTWb/anGIL4d8HVz7DrGjs5gaSkU7xcCA
         gnVe7UYrMtpV8P9g7nRae3FMaH7gd63BZijh0R7rW52k4lJ0XaSCqrnOmDtoDtt1S0AC
         iBge47PXsM5K1+JZMS0iyX6DZrJbS7coFtaZ8XXYD7tUj0wM/qq41AhxxT01VSucXi1j
         YyyybPdNGXLxL0+1KnJ0sK3VNnZEPO/xaWuwUCS+g97CgsQtL0SGXYPVblh4gcWaqk+v
         SIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516497; x=1718121297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQfzkFVlaGM5BVrS4JGbXx2G1P6hwLG/vFRgpCOI6Iw=;
        b=XXhRxSCY5067U8SXruP1iWjhHKjmfvsapUnkzZcsF+4oRcnW4vERV15o+U8jBJ5e80
         w/xJf2i5xAWn71OKKw3Jxepd/Fi/YmSZA73PLmmR8YQ75/YtqPrIeq5GnaMFvLsv2zxO
         7t9jwFQA3fgRrXASID6EAcX3CQxyprIu8UPX6sWi7PuUdNbS9DIIiozoLYkq8xpqyFZg
         0yEzjAsRT69SgX13qLgy/4lN3LHLZ53qMu9mPDs9GmfrXvJKoBf/gB6X/lRxN990tdxU
         gBoM39svIY7UTrLuuXlRB5+QgqQ3PZJsLVzZ+HbVVXEmBQa5za5QJQoU2jO3o7yoFYJR
         yXJQ==
X-Gm-Message-State: AOJu0YypK4Oqb8qWigb28/VfFY54zoOVxwlm+uvE6aA4qigxtB0SJYQn
	kCkOYDlQ0SigV9OQCob9KSn3E5c/tv7VEWYcXm+Sh+oHTdeKYkKcLX/bqsXetAU=
X-Google-Smtp-Source: AGHT+IEiam119wWevJmhp5DTrGygjQBYZl3XbbvwXlElEDjc9JFg8sX9mBzJvDPSEGSPufUnGFSZdg==
X-Received: by 2002:a05:6a21:2707:b0:1b2:6054:c8ba with SMTP id adf61e73a8af0-1b2b717c49fmr5926637.56.1717516497180;
        Tue, 04 Jun 2024 08:54:57 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:20d6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423cb349sm7457529b3a.14.2024.06.04.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 08:54:56 -0700 (PDT)
Date: Tue, 4 Jun 2024 11:54:54 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix a check condition in misc/038
Message-ID: <20240604155454.GA3413@localhost.localdomain>
References: <a49e6b43e3c140995567fea035017309b4bcd53c.1717480797.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a49e6b43e3c140995567fea035017309b4bcd53c.1717480797.git.wqu@suse.com>

On Tue, Jun 04, 2024 at 03:30:00PM +0930, Qu Wenruo wrote:
> The test case always fail in my VM, with the following error:
> 
>  $ sudo TEST=038\* make test-misc
>     [TEST]   misc-tests.sh
>     [TEST/misc]   038-backup-root-corruption
>  Backup 2 not overwritten
>  test failed for case 038-backup-root-corruption
> 
> After more debugging, the it turns out that there is nothing wrong
> except the final check:
> 
>  [ "$main_root_ptr" -ne "$backup_new_root_ptr" ] || _fail "Backup 2 not overwritten"
> 
> The _fail() is only triggered if the previous check returns false, which
> is completely the opposite.
> 
> In fact the "[ check ] || _fail" pattern is the worst thing in the bash
> world, super easy to cause the opposite check condition.
> 

Except we do this all of the time, we should be used to it by now.

> Fix it by use a proper "if []; then fi" block, and since we're here also
> update the error message to use the newest slot number instead.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/misc-tests/038-backup-root-corruption/test.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/tests/misc-tests/038-backup-root-corruption/test.sh
> index 9be0cee36239..0f97577849cc 100755
> --- a/tests/misc-tests/038-backup-root-corruption/test.sh
> +++ b/tests/misc-tests/038-backup-root-corruption/test.sh
> @@ -61,4 +61,6 @@ main_root_ptr=$(dump_super | awk '/^root\t/{print $2}')
>  slot_num=$(( ($slot_num + 1) % 4 ))
>  backup_new_root_ptr=$(dump_super | grep -A1 "backup $slot_num" | grep backup_tree_root | awk '{print $2}')
>  
> -[ "$main_root_ptr" -ne "$backup_new_root_ptr" ] || _fail "Backup 2 not overwritten"
> +if [ "$main_root_ptr" -ne "$backup_new_root_ptr" ]; then
> +	_fail "Backup ${slot_num} not overwritten"

Don't we prefer just "$slot_num"?  I feel like I've gotten yelld at for this
before.  Just change the existing thing to be correct

[ "$main_root_ptr" -eq "$backup_new_root_ptr" ] || _fail "Backup $slot_num not overwritten"

Thanks,

Josef

