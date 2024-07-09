Return-Path: <linux-btrfs+bounces-6322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D2992BC43
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 15:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566EB1C21874
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 13:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C89318E760;
	Tue,  9 Jul 2024 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RStDiGtj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC215749F
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jul 2024 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533496; cv=none; b=Udh1N7RkJKvFMN22mi69iggyegulATrbmXldC8Zb2YbjRIrqBU9JEv/7J5Z2ydWJs/qWlBSWRGd/5Xzk22MbTH9JZi+nYQfk2c0FyyD3xwdx0GZc89QmedX3ALHRKFhqF8A2/YnO/XybXjsfonrzVB8BNdW9zfeH1lZ5EjUceVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533496; c=relaxed/simple;
	bh=ElKR8Ddth/WCzSzcLPLTMFB0uCKgCAziWpoh2EV5J68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVwp2gHlaJCx9UvRJfdC/R0zTlqmuvFIysXsrWjA10BOiotLIcrFle/hMyzKsxtYmQzdazZ5o0MSUlXV94f5t6E6l8+QnggCtLooBZE1J6kIe4IivU0rk2Ci/J6s5ltPcSJDzXz8aHPqgsEGtdJuTzG6rP0H8ZB+Hdz4quOeqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RStDiGtj; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b5def3916bso26537436d6.3
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Jul 2024 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720533493; x=1721138293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WzV63/qKZ+16Lb+k9eDgUExQZgrgFirRCjTbxdCYDow=;
        b=RStDiGtjYc9M3dD9tG2TJT/m4dWBtE4mh9qW+v6QFlvrtbsLREf69deguLo7fTytPx
         iFs+3A0mzYD6kMb1w1m6zrVLMWQT8GX7QrZTP81g3tIuVl3b+2YvMVEKq3gWtfh0XT32
         zK388+kufG1fbQxgKETasnlKqE6vj/REPYvsyO000agnxSUk9606M5YhiayC6Fbgc6mv
         mXfef7H7JZ5zpeVHjvZSZJs6aa+HmeMkvCiSLB7XqjGkCiJxRYh7kvX8NLKnMozewS1+
         7PdC3t4UGlF9/9yqxWrDCV7P5cbzMfENTbbOR2un/xdqL6X+um0AaiOR9X2R4Cg3IMK5
         9hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720533493; x=1721138293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzV63/qKZ+16Lb+k9eDgUExQZgrgFirRCjTbxdCYDow=;
        b=kv/1R9qCnJuPxiczN0T7+QhrrUTVbz7rN0Xeozs1YGrHTh000oePIm7tCL/NxJGstF
         i9jMkfCf/baK6mBuQTLDTPD/87XdqfcNL3DodTCM8tsk/rblFPWDChk0qNPkPBxEpkOK
         OUzdfmNTgcIqULgN4bI0FzBaf9MxU6G8GeQHcD3nj4Bcv4inVgpon1F9Lk3qnEbkYfVq
         7pbUbevsfBE9/J2RDalFLqbKmDUM8+fG4oDSPYZZ/07g4HYi4GmHQ+HFHSr074j5ZDwl
         4T/6OvWlqwpqN7XPC8BmdoPJ0dIL0+kmbK6OwJb55/xCct4Vt02++PDtmvX5RnM0OlqY
         gNeg==
X-Gm-Message-State: AOJu0YzpPVH8KtRRUsf0ZXZfYWlzIhAgKmJhiOYbtAxpVGAsUDco5L7E
	0SmthtukIf2Rg9/6NaWo8ePWlQJPKfqD8fLGNi+DTG8c2K2+7LzhPW+FGVn4yTs3dQL3vJxSGnJ
	a
X-Google-Smtp-Source: AGHT+IHt9DUEI9miM13GdE0cJ5Y+w5mjWFEIcQtXXO41Y3GwhzzMzph9kVygEXTT1MqR+E8aESo9TA==
X-Received: by 2002:a05:6214:4018:b0:6b5:e2da:8be1 with SMTP id 6a1803df08f44-6b61c1da297mr34337786d6.55.1720533493289;
        Tue, 09 Jul 2024 06:58:13 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b8e3b18sm9112166d6.0.2024.07.09.06.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:58:12 -0700 (PDT)
Date: Tue, 9 Jul 2024 09:58:11 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6.10 0/3] btrfs: some fixes/updates for the extent map
 shrinker
Message-ID: <20240709135811.GA1040492@perftesting>
References: <cover.1720448663.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720448663.git.fdmanana@suse.com>

On Mon, Jul 08, 2024 at 03:42:42PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A few fixes for the extent map shrinker that fix some reports from users
> where their desktops became very unresponsive.
> 
> Several notes here:
> 
> 1) The first patch was already sent before to the list and it's in
>    for-next already. It's unrelated to the reports from those users but
>    it's related to a report from syzbot for a deadlock in case the
>    shrinker does an iput on an inode with 0 links that needs to be
>    deleted, and when the inode still has links but it's dirty, it can
>    make the iput wait for writeback to complete, slowing down the
>    shrinker. I've included it here just to group things in a logical
>    way;
> 
> 2) These patches apply to 6.10-rc;
> 
> 3) At least the first 2 patches should go to 6.10 final IMO;
> 
> 4) In case they land in 6.10-rc, then for-next needs to be rebased since
>    there are minor and trivial conflicts to solve due to the last patch in
>    for-next that reduces the size of struct btrfs_inode down to 1024 bytes.
> 
>    Also the following patch which landed on for-next should be dropped
>    because it's made obsolete by the second patch in this patchset:
> 
>    https://lore.kernel.org/linux-btrfs/cb12212b9c599817507f3978c9102767267625b2.1719825714.git.fdmanana@suse.com/
> 
> 5) There will be further improvements to the shrinker, namely to
>    reduce the latency of finding open inodes in a root, but those
>    will come later and may be too much for 6.10 final. It would also
>    require different patch versions for 6.10 and 6.11 (for-next) since
>    in the former we use a rbtree while in the later we have a xarray
>    now.
> 
> Thanks.
> 
> Filipe Manana (3):
>   btrfs: use delayed iput during extent map shrinking
>   btrfs: stop extent map shrinker if reschedule is needed
>   btrfs: avoid races when tracking progress for extent map shrinking

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

