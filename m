Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F67B281A44
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 19:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbgJBR4V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 13:56:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:33766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgJBR4V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Oct 2020 13:56:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06582ACDB;
        Fri,  2 Oct 2020 17:56:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 04EEFDA781; Fri,  2 Oct 2020 19:54:58 +0200 (CEST)
Date:   Fri, 2 Oct 2020 19:54:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sheng Mao <shngmao@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Neal Gompa <ngompa13@gmail.com>
Subject: Re: [PATCH v2] btrfs-progs: btrfsutil: add pkg-config files for
 btrfsutil
Message-ID: <20201002175458.GZ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sheng Mao <shngmao@gmail.com>,
        linux-btrfs@vger.kernel.org, Neal Gompa <ngompa13@gmail.com>
References: <CAEg-Je8L+KUx93im15DPGvczpvw8TfvhN752itm88w9Qwkg+sg@mail.gmail.com>
 <20200820043618.51575-1-shngmao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820043618.51575-1-shngmao@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 10:36:18PM -0600, Sheng Mao wrote:
> Add pc file for btrfsutil libraries. Users can use
> pkg-config to set up compilation and linking flags.
> 
> The paths in pc file depend on prefix variable but
> ignore DESTDIR. DESTDIR is used for packaging and
> it should not affect the paths in pc file.
> 
> Signed-off-by: Sheng Mao <shngmao@gmail.com>

Thanks, I've added it to devel.

> +test-pkg-config:
> +	@echo "Test pkg-config settings"
> +	export libdir incdir
> +	$(Q)bash tests/pkg-config-tests.sh

I've deleted this section and the script, there's no point testing it
like that.

> --- a/configure.ac
> +++ b/configure.ac
> @@ -12,6 +12,10 @@ LIBBTRFS_MAJOR=0
>  LIBBTRFS_MINOR=1
>  LIBBTRFS_PATCHLEVEL=2
>  
> +BTRFS_UTIL_VERSION_MAJOR=1
> +BTRFS_UTIL_VERSION_MINOR=2
> +BTRFS_UTIL_VERSION_PATCH=0

This would duplicate the version definition, so this needs to parse it
from libbtrfsutil/btrfsutil.h.
