Return-Path: <linux-btrfs+bounces-17122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 200A8B95FC2
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 15:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A9B7A9F04
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054F83277A9;
	Tue, 23 Sep 2025 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="yGwEv5jd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65353323F78
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633427; cv=none; b=VZnn7gM2ZMFVyMKaT0imUtN7DXdlFpXrjk7sLuIAQzErLFF25P3uts8H6XP+XtTPmwF+OSBQ5cpNahSMEu+BQ7vCEcoZuXzy77P5cVcIHbjxt7SqXpdKwG7mfNwk13nJd/XcywpwLMRQ4t2d+4YnP+86Q5bM/iwrJQR54bYMTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633427; c=relaxed/simple;
	bh=MjdyuQrqVvsTBegSnd3yU00JR+DMJq7p6mLUJWTlZdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcX86kEUGY8n+DqS9bzY4soDm4zBERuTCWZGcAQ09uy4aBqVqFE+QEAc/EaDbyWz35tJGcQEF0BtCEsx8l9v3gMddXhxsakYUTucwUlAA4n9Ip7/3oDK99m+4sl/RQQtamhuohwI3kVx8DBZ86jZSQ12P5UGD17oVABr6x76P2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=yGwEv5jd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b55115148b4so3573888a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1758633424; x=1759238224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGZ8DWqCix+BtHtElOYwM96MkEfMXUBhKMzH5BSjHrU=;
        b=yGwEv5jdMt4Rgfi0m0bN3rxya9s2FAbia8xtqcTwhc19IK5r4PXmdK+C7UWreg1NfH
         4sk+1SJaFqWoZk8UMTPHgcndklOJpzScvLF5bjkG6gqoUSKB2k3ZVGlgvwgMKVkiX9tQ
         HMMHDCD3TrzFuqxXTV9HAJcgYYX2He2h5yQzLxkZURdzd28u2rXo3M/TKNd/GoKCTF5R
         SSJHzKnVcZ1kR/S8ehZjuwzeAqAlS4edQgRc1y0V8xkXIINs5b4r82gsRo8F8hz5liGg
         WFWMrwFtm4OO2twE/EkvNGL9ESDPBnyP6iVe3AlnhcR6cmuUPbA6c7z1EUU5XrhnwxMP
         WISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758633424; x=1759238224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGZ8DWqCix+BtHtElOYwM96MkEfMXUBhKMzH5BSjHrU=;
        b=MXuuv06nCa2GKxw/bIvM6buXKzA8Uo3o6OXoA9Jva8an1NHVTl5I3W/83vpoDioFDP
         TzrlvfZf3aT53SYyTeaJvFNOetkt4yhjr5JMDcANPyBBgzppTFL3w6OBVDCq9F1suykF
         yuIcYahtnJmRjGpxDKEPtVVE16OqeVDhLCQ8Gq2v0Y7uWzsoyPVG2EPuZVxpDTqc9yTW
         paqKdFTpOznB+vBd26CyU5wYUaBpgxM55Uo0flxzDJ5E6MyP9ZHscgyxVWM+wJWai9QC
         SmDxl+7VsekBzTTYH+jcoawkRvSnOMex/PxFKM+2yzjVQ41yxHNujPoefLYlMhQ4IZw0
         R9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXOyrOYspRUXQOIa8xzzra54AboQ0dN6ID20A5RVw70IkWvQi5CvptUSXRvFykhjUsRiETsDc7r2lRSUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSfsbs/1O6GyxCjBwgIvQGZ4TKv6Pg2A+urIho6y/P2OY2shx
	8TUr258p1cwAuZtVWJv+aAVq3sUqroRf6h0LK9q/+t9p5KQglWZqz6L8ylYHqTtGdhA=
X-Gm-Gg: ASbGnctWsHGuUzEvj4MQkqJN8e0JXaCWAPT5GoElyl2y6ooXL+Q5UlpC4DiOwuBOwp4
	YN3fwQaiwFMRMJ09UhFyWR/7aaG1ZlDbK+RKQoKQ5S6E1QYMJtLGT+VOZmG8iy7Eg4Kv+OONsvz
	9bDJx2I6DmBco3qgkqcWV1wYNdusxazFJj+W5B+aCuHA10jRUtvPq3mgp21/YYjyBZW8xlbZ57x
	2hLK265wNE7UY9o4DicWx530apQnL3k67UZgjVw1uLGSkQKEF9qOgRKn56GUm4IxPzhFwvAYqcB
	pmIlXWvbWM1KMbndEeLSR0VJzJD6bnU3vCHRdFCwu82XISNjCCZQ6GiNwprd9urgvonVRqA4RLw
	1XM0RQGfdW1xjiIKEeuAlJmZUp+KMMBSBpi3aXOj37s/EGv2HZ+CNtpFVF0xyeh59xo4UUI/Acq
	xpKe4GuCj+
X-Google-Smtp-Source: AGHT+IEK7PfWxNFc7fb1bUErPP+++ZIWocUE2B9M31SxyszIkGAjugG30aXgLbzSTbCpFRJZYYXACg==
X-Received: by 2002:a17:90b:17cc:b0:32b:9750:10e4 with SMTP id 98e67ed59e1d1-332a95e0514mr2945365a91.27.1758633423462;
        Tue, 23 Sep 2025 06:17:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551705bd02sm12047994a12.41.2025.09.23.06.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:17:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v12t9-00000005h4t-0IOy;
	Tue, 23 Sep 2025 23:16:59 +1000
Date: Tue, 23 Sep 2025 23:16:59 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v6 0/4] hide ->i_state behind accessors
Message-ID: <aNKdy1vYsWoMvU3c@dread.disaster.area>
References: <20250923104710.2973493-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923104710.2973493-1-mjguzik@gmail.com>

On Tue, Sep 23, 2025 at 12:47:06PM +0200, Mateusz Guzik wrote:
> First commit message quoted verbatim with rationable + API:
> 
> [quote]
> Open-coded accesses prevent asserting they are done correctly. One
> obvious aspect is locking, but significantly more can checked. For
> example it can be detected when the code is clearing flags which are
> already missing, or is setting flags when it is illegal (e.g., I_FREEING
> when ->i_count > 0).
> 
> Given the late stage of the release cycle this patchset only aims to
> hide access, it does not provide any of the checks.
> 
> Consumers can be trivially converted. Suppose flags I_A and I_B are to
> be handled, then:
> 
> state = inode->i_state          => state = inode_state_read(inode)
> inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
> inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
> inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)
> [/quote]
> 
> Right now this is one big NOP, except for READ_ONCE/WRITE_ONCE for every access.
> 
> Given this, I decided to not submit any per-fs patches. Instead, the
> conversion is done in 2 parts: coccinelle and whatever which was missed.
> 
> Generated against:
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries

Much simpler and nicer than the earlier versions. Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

