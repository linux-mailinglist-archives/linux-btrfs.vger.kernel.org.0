Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDA8F56E2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 21:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388576AbfKHTMx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 14:12:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37792 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388183AbfKHTMt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 14:12:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id e187so6262113qkf.4
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Nov 2019 11:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AHbhWsb84wnoua03aMa8aLyb8ItwTMluH+vuZ7nrz1I=;
        b=BNtGnZbJLRJBuxBl05vKV3aRCXPhueD8datIC3ZaBM330LuB8KCttozZPkFVaMYUs6
         0GoowPyE0K/xYYjzuwbDxY0tA9vHNINsYZqM7lSaLNy28Qb5carRjSnBv2LebWwK4EBo
         B2c083dSOIbKS/KTSzxrs825zR5XoZmcLxrosJvkPE/EtnaUWXP0kQ6viWOU3Q/e91Fj
         Ur/rcv0gVMJDLBRdOrIrHPG9BbUQ6+xnF9AKfkj2QtWtl7MaQtDwG5knDpSVWv2Rylpb
         YH8hvHUQXrIX1r8xBigjBsa10rLukeGWsZbQrAWLowMhGF1jcY7eQjmt51z3HO0/iEr3
         gh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AHbhWsb84wnoua03aMa8aLyb8ItwTMluH+vuZ7nrz1I=;
        b=LaXKxdZaCRWNZhr6Xp3AyJlH3Oa8L/19Tvxw2mLz5FjBWw0Lf7BqRHQG+2A2WEUT14
         wcOoMc5lhV5X8bkIyCEjG/uSgoRm5QFzOGb+s0uB+YU1p01LpZcgl9oyqibzdehvxinm
         xCKCJh/C2HQSjQ+91zYVBWASWr7BcW4QNA83MpqtEGqvo5kw3XmiWs2N0MfcqX0aanSf
         yIgtDtPWnxqwaMSfiivTKLIBz0sBz5JMvpDwe6KcUGv9ANApB2qFI8pBsvQ+WDd2YZ4+
         QTX7FpQ4PMI3wl0SsX1wQvVuLJZVxOJ1PTeMs7djf4ss/OsdoMF8DRHympnfnJyut0iJ
         VzVA==
X-Gm-Message-State: APjAAAWZxcLgfYHah+hl8b45Aqc43VZNXV581t4aSmoKeupb781nJoWI
        bhLc/EwMN/g4/JHYQ0iTBrr5Hg==
X-Google-Smtp-Source: APXvYqyR4mqrcooO2Vv5aCq+a1fhw4N4rgf9jpGmdtenyqlv5aomyDMHtO1CjewprdHOMUbI1u2BpA==
X-Received: by 2002:a05:620a:12f8:: with SMTP id f24mr10323110qkl.255.1573240367024;
        Fri, 08 Nov 2019 11:12:47 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1852])
        by smtp.gmail.com with ESMTPSA id a28sm3081360qkn.126.2019.11.08.11.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 11:12:46 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:12:45 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/22] btrfs: keep track of cleanliness of the bitmap
Message-ID: <20191108191244.kcbgfsmzbfpzivri@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1571865774.git.dennis@kernel.org>
 <6563f9fc4cd47bade586d86c658c848f2ffeaa49.1571865774.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6563f9fc4cd47bade586d86c658c848f2ffeaa49.1571865774.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 06:52:58PM -0400, Dennis Zhou wrote:
> There is a cap in btrfs in the amount of free extents that a block group
> can have. When it surpasses that threshold, future extents are placed
> into bitmaps. Instead of keeping track of if a certain bit is trimmed or
> not in a second bitmap, keep track of the relative state of the bitmap.
> 
> With async discard, trimming bitmaps becomes a more frequent operation.
> As a trade off with simplicity, we keep track of if discarding a bitmap
> is in progress. If we fully scan a bitmap and trim as necessary, the
> bitmap is marked clean. This has some caveats as the min block size may
> skip over regions deemed too small. But this should be a reasonable
> trade off rather than keeping a second bitmap and making allocation
> paths more complex. The downside is we may overtrim, but ideally the min
> block size should prevent us from doing that too often and getting stuck
> trimming pathological cases.
> 
> BTRFS_TRIM_STATE_TRIMMING is added to indicate a bitmap is in the
> process of being trimmed. If additional free space is added to that
> bitmap, the bit is cleared. A bitmap will be marked
> BTRFS_TRIM_STATE_TRIMMED if the trimming code was able to reach the end
> of it and the former is still set.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
