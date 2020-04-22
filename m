Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80631B39FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 10:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDVI0z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 04:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725811AbgDVI0z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 04:26:55 -0400
X-Greylist: delayed 794 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Apr 2020 01:26:54 PDT
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9741C03C1A6;
        Wed, 22 Apr 2020 01:26:54 -0700 (PDT)
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 8FEE113F7AB;
        Wed, 22 Apr 2020 10:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587544013; bh=R+5K8GvpfaB5fPFgBojTvqmfDAV0B1cruWUnLhw+XC8=;
        h=Date:From:To;
        b=vviFJBffMyN0U5oWHJ/3UgnliShhXQob5hhCaVPuFp0b6o0j2uaROio9MuW7N1OGk
         BP5NIWSUcacXWsYJFVKNu+Rpw0DeLsgvV3nqrCVmlkMuMesjP3oYNve8K1G7s0yp99
         oHhHk2K438wfNoa2EloE2qtaJI9dHy3RV0VMCpLI=
Date:   Wed, 22 Apr 2020 10:26:53 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
Subject: Re: [PATCH U-BOOT 03/26] fs: btrfs: Cross-port
 btrfs_read_dev_super() from btrfs-progs
Message-ID: <20200422102653.0dee168f@nic.cz>
In-Reply-To: <20200422065009.69392-4-wqu@suse.com>
References: <20200422065009.69392-1-wqu@suse.com>
        <20200422065009.69392-4-wqu@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 22 Apr 2020 14:49:46 +0800
Qu Wenruo <wqu@suse.com> wrote:

> +/* A simple wraper to for error() from btrfs-progs */
> +#define error(...) { printf(__VA_ARGS__); printf("\n"); }

Is this from btrfs-progs?
I don't like these macros much, I prefer to use static inline functions.

static inline void error(const char *fmt, ...)
{
	printf(fmt, __builtin_va_arg_pack());
	printf("\n");
}

Attribute for printf can be added to check printf specifiers:
  __attribute__((format (__printf__, 1, 2)))

It is possible that this won't compile when optimizations are disabled.
In that case more attributes are needed
  __always_inline __attribute__((__gnu_inline__))
These could be defined as a macro in include/linux/compiler-gcc.h
  #define __gnu_inline __always_inline __attribute__((__gnu_inline__))

Marek
