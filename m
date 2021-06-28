Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8BA3B6997
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 22:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbhF1UUK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 16:20:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45746 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbhF1UUK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 16:20:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8D07322504;
        Mon, 28 Jun 2021 20:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624911463;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eNE8fNMEHo2o4mdmV6vdenep05ALo6EGBThqb0RSWr4=;
        b=oj/L/rZf+xgKwp2ai04yTGvQ4tmd7CjUoQRo27iYMqHaY3+kH3Eujp5pSvHwSc7hnRS+RF
        6SIpY8m4ltUOtXZVedvlnmCCyZ7n86e1mpCadA1qXNMn3h3Ct8Dl0qi7RlibvmZwHMkE2U
        TfI48QqHhWLRO1jkNDaHNkA3XxrRKX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624911463;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eNE8fNMEHo2o4mdmV6vdenep05ALo6EGBThqb0RSWr4=;
        b=/JcRDUlFRpaJ5bqw/eoLeIh/IrWk2AZJEhValJ2tYryjD7lU/isXvEESnSRrv3rNo1ULWi
        3Nb+UHyR/iyFkGCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5F88DA3B8C;
        Mon, 28 Jun 2021 20:17:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4A0C7DA7F7; Mon, 28 Jun 2021 22:15:14 +0200 (CEST)
Date:   Mon, 28 Jun 2021 22:15:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: improve logging message for auto reclaim
Message-ID: <20210628201514.GF2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
References: <3786140da052ad5067bc6d2990325519c4abd1e0.1624904192.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3786140da052ad5067bc6d2990325519c4abd1e0.1624904192.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 29, 2021 at 03:16:46AM +0900, Johannes Thumshirn wrote:
> -		btrfs_info(fs_info, "reclaiming chunk %llu with %llu%% used",
> -				bg->start, div_u64(bg->used * 100, bg->length));
> +		btrfs_info(fs_info,
> +		   "reclaiming chunk %llu with %llu%% used %llu%% unusable",
> +				bg->start, div_u64(bg->used * 100, bg->length),
> +				div64_u64(zone_unusable * 100, bg->length));

Btw, the bg->used also needs div64_u64, I had a patch somewhere but
can't find it so please fix it as you're touching the code.

Regarding the message, it would not show in non-zoned mode so it should
be ok to print it unconditionally. Once the background reclaim is also
done for regular fs the 'unusable' might be confusing but we can fix
that if neccesary, printing int + string conditionally needs some magic.

I'll add this patch to misc-next, switching the div helpers could happen
in the reverse order but I'll fix that eventually.

>  		trace_btrfs_reclaim_block_group(bg);
>  		ret = btrfs_relocate_chunk(fs_info, bg->start);
>  		if (ret)
> -- 
> 2.31.1
