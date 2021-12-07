Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E26146C3F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 20:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbhLGTwI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 14:52:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39228 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbhLGTwH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 14:52:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B708E21B3F;
        Tue,  7 Dec 2021 19:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638906515;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fX7nt/1x5vbLAmgZX62l/SnhTi54fxc8Qfac2yM2Jlw=;
        b=cea5O8wvB8iy2WUqvfa9wSAqCTR/P0RSaIJ9hh3TxbteYwbBkrjEh0tuyWnTImHoyWD44V
        Tce4teskQcQdK9L19VHlm+CpE6gxPAYUXTQPUFHNp92Gz2WkzN+M7XxvzCtm7gYYTVXQMX
        pTjoppMs0hyqu68fJwPmaULczpC5Xkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638906515;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fX7nt/1x5vbLAmgZX62l/SnhTi54fxc8Qfac2yM2Jlw=;
        b=NIgIqSkZcZnQKhXXtsR0QW767JGesxE6zg0o6Ig3B51kJTjLKPy9jUvE7zqCqng3DCutBn
        qEU+5lFNmvd7qVBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8806EA3B81;
        Tue,  7 Dec 2021 19:48:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B8B1DDA799; Tue,  7 Dec 2021 20:48:20 +0100 (CET)
Date:   Tue, 7 Dec 2021 20:48:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: convert comment to kernel-doc format
Message-ID: <20211207194820.GH28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20211203064820.27033-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203064820.27033-1-rdunlap@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 10:48:20PM -0800, Randy Dunlap wrote:
> Complete kernel-doc notation for btrfs_zone_activate() to prevent
> kernel-doc warnings:
> 
> zoned.c:1784: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Activate block group and underlying device zones
> zoned.c:1784: warning: missing initial short description on line:
>  * Activate block group and underlying device zones

We've been using a slightly different format than the strict kernel-doc,
in this cas the function name is not repeated (because it's right under
the comment), what we want is the argument list checks (order and
completeness).
