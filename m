Return-Path: <linux-btrfs+bounces-7370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9335995A3C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 19:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE55283FD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8A1B2533;
	Wed, 21 Aug 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="OwBJoDjj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6521B2526
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260800; cv=none; b=aKMOEm9FKxApLPvXOJn3/fT6pmNA4kVewlPLhvw4JAlce26D8xRU9NIu9h7VRoqe6aeL78KhK+9NigIkDXde77JXPPETZKo0DS9wv5aoeDWsj1dmJf2KxguVHLg5jMq/xqCSaYPs+zWhtDfffH6W6y+tLC92AOeAxcThjKaE5M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260800; c=relaxed/simple;
	bh=eYGzQFwzTEpoODCcSIeHmmz1aTm6nS2RUiT/mlKkBZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmwoGxBuPLY26AXHE9eU4sxDkKX44XW+17MbqQWJ3msJAscC+XCtAloeNz+VusgEFa3R2SsOc9pZ5SMk22yxgm6fcy7icwywIXqWYDH7/Z+mgqUqiOdwMkVuAIGOQRlFg3a2tjZ+RR2btibPohEB7TwYXg2Ze2I/xduQ2T3LqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=OwBJoDjj; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1674508eb9so444667276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724260797; x=1724865597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aVhzZBtW/4YT42mvPOD9obkhbCc+XnXznCHLvT4gpdw=;
        b=OwBJoDjjGLHc7QWnuBqBqg6hb5h8VZaaYuKyRXuOxgY4TSm3R2LveJI3ZpUQuzR9cK
         cNh8aCR7dsuPEprhB5rzbxtGr5ScaZ/vLRtm344FH/EVBD+Dy8VELAu1G0m13vDSmTGY
         oz21YSW+BU74WglQ9heLFA9QSiE0PB3YJ+FmBCRPM8LRKAMuC9lUocCxnPQ2WHr6mbc4
         5nH0fSQogF5FvqKA5rkg3INSLrJFnSu6KvF+FP0eBcQ4vBDTv3lBTqOErbjQS059OeSz
         nhfKpV8j04jcE2Ess7/JXGfOI8+o8V4NurhXxv0s0aHwS2sjhI+5XKGYqXU4nHkSEX1w
         tscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724260797; x=1724865597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVhzZBtW/4YT42mvPOD9obkhbCc+XnXznCHLvT4gpdw=;
        b=aCFS3HWm7Q8lkKoEUvW1Mz+TtGtUoV107AjeNocxMBQv2ChaBX97eo2KsT9EGtPkVw
         rx+UYsfY/fhiqSNV03KgRtT7nBOsjnr/sJlv6J2EdgmrUR2BGhBgFSOQ1CMPrEntuP3w
         apDJncTHFQOAfsUYgGtpZIqNDzxueHX805mcPDzMUhxIYtrbBQRGFHTUhCGM5ctRBWlh
         fdd+m91Qb6DCaD/6X/kdK5Z9t0aEqKdptjp85gr0qLUKssy2y9XbSBosQ9L7H4dGS4MZ
         yYbX5ID4XCTKybRUZIIwBEBDSV04f/q7m9hRctqYovLgdTAX7BdSTOt736+JjfzCoQW7
         9q6Q==
X-Gm-Message-State: AOJu0YzSClzJq1XJxUYsbOfNscuG7JxfM+fqpC2iHpcN/E67zCrhK2u3
	5/a4JY6E0L20RstTYJu1ACnDnGsc+8+lx1JLx+x4hbxOJVoWpZZFZFzje6sw/kY=
X-Google-Smtp-Source: AGHT+IGin4x3UEshGgq3tt5o1Ychw6rnozO2yhcZ3xAXwJaVW0hM0zGAU8EiqROA+S7PC6Be7GDY/Q==
X-Received: by 2002:a05:690c:650c:b0:64a:90fe:911e with SMTP id 00721157ae682-6c0a0239705mr40131517b3.31.1724260797589;
        Wed, 21 Aug 2024 10:19:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9a86d7d2sm22716897b3.63.2024.08.21.10.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:19:57 -0700 (PDT)
Date: Wed, 21 Aug 2024 13:19:56 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] btrfs: remove conditional path allocation from
 read_locked_inode, add path allocation to iget
Message-ID: <20240821171956.GB1998418@perftesting>
References: <cover.1724184314.git.loemra.dev@gmail.com>
 <652ef8f5f0b46c2488a2f72bf34a83d9bc8357db.1724184314.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652ef8f5f0b46c2488a2f72bf34a83d9bc8357db.1724184314.git.loemra.dev@gmail.com>

On Tue, Aug 20, 2024 at 01:13:18PM -0700, Leo Martins wrote:
> Move the path allocation from inside btrfs_read_locked_inode
> to btrfs_iget. This makes the code easier to reason about as it is
> clear where the allocation occurs and who is in charge of freeing the
> path. I have investigated all of the callers of btrfs_iget_path to make
> sure that it is never called with a null path with the expectation
> of a path allocation. All of the null calls seem to come from btrfs_iget
> so it makes sense to do the allocation within btrfs_iget.

You're missing your Signed-off-by.  Also try to be less verbose in your title,
"btrfs: move path allocation into btrfs_iget" or something like that, you want
to avoid wrapping if you can.  Fix those things and you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

