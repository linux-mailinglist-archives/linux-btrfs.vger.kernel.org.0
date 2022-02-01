Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DFE4A6172
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 17:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbiBAQeR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 11:34:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37936 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiBAQeR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 11:34:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4DBBD21118;
        Tue,  1 Feb 2022 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643733256;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRvSCxDZc9adTVUPZF+44TtbdSutJK+Qf+HY/F1kh8g=;
        b=HRu0oRGjrJaflEFDVpk0RfvRWPzON8FUfQ5Fj23XDywfU+yYQhLviN6NzVqA5C9mag+SyG
        IrkuCAxtJboNKG7n9h3Dc35cv7aMcSgI14y3tjWoaPAeGZQ6Qz+tgJwQe8nxxmPlymNmBi
        PzBuT3YlGH5ppkobwJTeGvkt/IKdg8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643733256;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRvSCxDZc9adTVUPZF+44TtbdSutJK+Qf+HY/F1kh8g=;
        b=ARE1YDIwXG6LgxNKJApNqnlM4VPy/MVJjunTkJBcssXnZQ7QKL83UO2d1GNqm7lnWQyZgc
        utMFv4Nt5w8BjOBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1F8D1A3B88;
        Tue,  1 Feb 2022 16:34:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1BBD8DA7A9; Tue,  1 Feb 2022 17:33:31 +0100 (CET)
Date:   Tue, 1 Feb 2022 17:33:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: use profile_supported in mkfs as well
Message-ID: <20220201163331.GT14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220126090403.57672-1-johannes.thumshirn@wdc.com>
 <20220126090403.57672-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126090403.57672-2-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 26, 2022 at 01:04:02AM -0800, Johannes Thumshirn wrote:
> Currently we have two places checking if a block-group profile is
> supported on a zoned device, one in mkfs/main.c and one in
> kernel-shared/zoned.c.
> 
> Use the one from kernel-shared/zoned.c in mkfs as well, unifying all
> checks.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  kernel-shared/zoned.c | 2 +-
>  kernel-shared/zoned.h | 1 +
>  mkfs/main.c           | 4 ++--
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
> index 776576bc6c77..e6fd4b31b9d6 100644
> --- a/kernel-shared/zoned.c
> +++ b/kernel-shared/zoned.c
> @@ -808,7 +808,7 @@ out:
>  	return ret;
>  }
>  
> -static bool profile_supported(u64 flags)
> +bool profile_supported(u64 flags)

Making a function part of public APIs should go with a rename adding a
prefix, here it's supported profiles for zoned mode, but it's used
without any other context in mkfs so at last "zoned_profile_supported"
would be good. I'll update it.
