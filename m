Return-Path: <linux-btrfs+bounces-4456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 625D58AB550
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4476B21085
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BBC13A419;
	Fri, 19 Apr 2024 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CCeriSxt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7313C679
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552963; cv=none; b=aDHm/GxMZO6sKCKp4COl7kkbtZyGbQ0hMNhniydLUbDWj1w9isjY/amwTCJERVeRJ0ijhhyV5KjSrFPKRb0Og4oVTziyq5uORqk2JyO6U0QzQ1/Hfee4/CHSmw6ydK++IIextMbx3gbkDDbE1Yq7P+GTzeJZCH2OLld7BgUavYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552963; c=relaxed/simple;
	bh=XYpv/X9i8lqQwfic9+Z4Uvf/TRnl0y8wD+9+vJrbzlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lz89B/YlvtA8J9PRN6P48f1zJ/UZUXLmIA4LlYKLTXCiqmx6w4c2QoaHiLvCT1oAe7GcyYvISswJUX6Eny4/Evvkz6JiW0wDIra9SD2aIyvpPXokHecn7POanaEmzBdse+QIBqfsTfnSfjNvdJypEgOJhJlg2Bh6ln7a1v1nf8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CCeriSxt; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6a0406438b5so11006086d6.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713552960; x=1714157760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KPtKRdIEPLzYrwCUCh9hiXhqpNNzvXiSnAJ3dNueYoQ=;
        b=CCeriSxtQKocXgec7zu2lkaJhzdy4JlV1Rwkka8MhwUTpVcc1ShYZuUTQiIGUjL7Co
         r95NJEnQFNo1YG4hjEMp0r60/2hFhJU8uC+5BR1LMLa7zz4XCKvZ5DV+cEtevtNbh5nY
         /gwkyDAZWgfT3n2rwz0JuQZLhasgzx3BtBxqd/UDMZg9SQC8SUwRN2hwEW1WnjNeWAmI
         77L5TO+YeagiZ5qm8u//3melOw1hZ9dUeUmNdy58cC3XuADJux4+YIIWqlGV0Dxi3/Ur
         bdEYmqcFlHrHo6EsEy+Dkn2fuUzUDBSeLk4ms6VRLx3q1/0kVx5hkD23C0uIMKIUBuhg
         N+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713552960; x=1714157760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPtKRdIEPLzYrwCUCh9hiXhqpNNzvXiSnAJ3dNueYoQ=;
        b=KlkCxoBK6f1dAKKLMs3/Yavl6162SVuovZA60p0byLPKg09bV8z5SJx4OR78hgTK0k
         kpwbo+bKMcwFFaRqVsXmCFKVrHMrOixeWpjLrMoRuMMqEMAeBcKpDB8BFSFvrARsMiL1
         Qfbvwz65Q8T4kznC4CFh/8/d2Gw3exvQtdVutE6YNjQAFc1QAxj1QxhohyZ5vXt/IrwE
         s5H2rV3dhFDTuGTWSsCGI8n8uBIQDndIagJVk6l2Qgx80ZM//OC5FwWZoFKyJySQTZmK
         x7NeBAlEPhzSjctVV6M86t+j8TFP8draFvnM2PupZFy9mayg5ft+OQhyUHos2GAaeYlv
         g5cw==
X-Gm-Message-State: AOJu0YwSgEKdL1TW1g8HvjeV6ZetXTfpKHYj5aZgIvFEwt/GV4J0QeUE
	5Pm2r3X7C1ZtI8/21Im/ikMG8NhT9sBL6jzbl3hYzH4+bUkr1FO0MQpKfPiQxOI=
X-Google-Smtp-Source: AGHT+IHf2TFyT9CtiIaaqLlyG/oYm+gV3Vfwn8kvqGglyGjR9ljhFf9U+ySPW/65YEvbPmP7AVrXtQ==
X-Received: by 2002:a0c:db06:0:b0:699:4a50:c5c0 with SMTP id d6-20020a0cdb06000000b006994a50c5c0mr3335000qvk.18.1713552960500;
        Fri, 19 Apr 2024 11:56:00 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p17-20020a0cf551000000b006a04a14b5e1sm1777426qvm.104.2024.04.19.11.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:56:00 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:55:59 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use btrfs_is_testing() everywhere
Message-ID: <20240419185559.GA2726825@perftesting>
References: <20240417232452.20839-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417232452.20839-1-dsterba@suse.com>

On Thu, Apr 18, 2024 at 01:24:52AM +0200, David Sterba wrote:
> There are open coded tests of BTRFS_FS_STATE_DUMMY_FS_INFO and we have a
> wrapper for that that's a compile-time constant when self-tests are not
> built in. As this is only for development we can save some bytes and
> conditions on release configs by using the helper in the remaining
> cases.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

