Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF24F3B8FDC
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 11:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhGAJj2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 05:39:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50348 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbhGAJj2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 05:39:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EC53E22635;
        Thu,  1 Jul 2021 09:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625132216;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJWl/b5Hn461RNYn2bvS1zH9/nX6DWV4xfbCDZyqJlE=;
        b=WWMDnE8mR6B++KquiUv+/Az9tJTIT+Eep0osWXaocXtBsQ2eJWM698yPwbDzpgzTvG/GUm
        0a9Fv6a90sH/YWOTm1kP9tJXYNab2D2hSo4ykCFvJxg6UIZzgts1dybZghMjA+aklXeqLv
        EkFbb4teR1qzAMdXyMm4cpukNQloXlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625132216;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJWl/b5Hn461RNYn2bvS1zH9/nX6DWV4xfbCDZyqJlE=;
        b=KBjO1ZdESRbgcSp+3h50gD0SdeEZ7KSbc1ej4L2QN7KIDrkGgpWI1A5TlcGLNroQxgU+JM
        Z6u9I5qfTn9/XUDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BAFA3A3B90;
        Thu,  1 Jul 2021 09:36:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3B667DA6FD; Thu,  1 Jul 2021 11:34:26 +0200 (CEST)
Date:   Thu, 1 Jul 2021 11:34:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] Revert "btrfs: zoned: fail mount if the device does not
 support zone append"
Message-ID: <20210701093426.GU2610@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <00c2351fa6070a149866df5e599e09c908e9cf26.1625127204.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c2351fa6070a149866df5e599e09c908e9cf26.1625127204.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 01, 2021 at 05:13:37PM +0900, Johannes Thumshirn wrote:
> Now that the device-mapper code can fully emulate zone append there's  no
> need for this check anymore.

Which commit implements that? I did a quick search for 'append' in the
recent git history there and found nothing.
> 
> This reverts commit 1d68128c107a0b8c0c9125cb05d4771ddc438369.

Please do commit references as 1d68128c107a ("btrfs: zoned: fail mount if the
device does not support zone append") .
