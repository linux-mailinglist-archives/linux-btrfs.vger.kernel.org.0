Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62D57D8434
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Oct 2023 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjJZOHB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Oct 2023 10:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZOHB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Oct 2023 10:07:01 -0400
X-Greylist: delayed 393 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 07:06:58 PDT
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4614E1AA;
        Thu, 26 Oct 2023 07:06:58 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5b2e826a.dip0.t-ipconnect.de [91.46.130.106])
        by mail.itouring.de (Postfix) with ESMTPSA id 7FA36CF194E;
        Thu, 26 Oct 2023 16:00:23 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 34BDBF01608;
        Thu, 26 Oct 2023 16:00:23 +0200 (CEST)
Subject: Re: [PATCH 6.5 211/285] btrfs: scrub: fix grouping of read IO
To:     Sam James <sam@gentoo.org>, gregkh@linuxfoundation.org,
        Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.com, patches@lists.linux.dev, stable@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <87fs1x1p93.fsf@gentoo.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <02e8fca0-43bd-ad60-6aec-6bcc74d594ee@applied-asynchrony.com>
Date:   Thu, 26 Oct 2023 16:00:23 +0200
MIME-Version: 1.0
In-Reply-To: <87fs1x1p93.fsf@gentoo.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2023-10-26 15:31, Sam James wrote:
> 'btrfs: scrub: fix grouping of read IO' seems to intorduce a
> -Wmaybe-uninitialized warning (which becomes fatal with the kernel's
> passed -Werror=...) with 6.5.9:
> 
> ```
> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c: In function ‘scrub_simple_mirror.isra’:
> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2075:29: error: ‘found_logical’ may be used uninitialized [-Werror=maybe-uninitialized[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized]]
>   2075 |                 cur_logical = found_logical + BTRFS_STRIPE_LEN;
> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2040:21: note: ‘found_logical’ was declared here
>   2040 |                 u64 found_logical;
>        |                     ^~~~~~~~~~~~~
> ```

Good find! found_logical is passed by reference to queue_scrub_stripe(..) (inlined)
where it is used without ever being set:

...
	/* Either >0 as no more extents or <0 for error. */
	if (ret)
		return ret;
	if (found_logical_ret)
		*found_logical_ret = stripe->logical;
	sctx->cur_stripe++;
...

Something is missing here, and somehow I don't think it's just the top-level
initialisation of found_logical.

-h
