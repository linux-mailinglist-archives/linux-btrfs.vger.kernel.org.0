Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFE44E6747
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 17:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbiCXQvB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 12:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCXQvA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 12:51:00 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB87D54F96
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 09:49:27 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 1208480787;
        Thu, 24 Mar 2022 12:49:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648140567; bh=TA072rY/co9+FxE5LTJa8Chhl47wEpyLAPGm9SVW+ao=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LeSjCKKi3LLva9HnVX7e6Zc/NWWhC48I9rObcD+AaubzD4h+q1c5yu7NMrch8Mbiw
         TZeIANffrNyNG9yPQE1z6+TYK2DPuqSNcjFR3dGx3fM303yo0jmNByLh2Zlhk/9759
         patBM1dxSwGMVHNpH/G2yQHXPiXyU/4bXefc3ByvdZalt1xm4ZubC9QHns/PF7X8yC
         oPRnOT3XHddbYLJKTTVyqlZo18yD5TYpNCB5W6QKy7Y6USCLh2efa7nbYg671Hjvzz
         2whYGriS/QW1G9DQ/5qQxwHacxPKhJ328xI9/aSkvFG8pzhAe2FCQ+w7nn9jtaQZ0l
         UvKve/dVQklZw==
Message-ID: <46203a49-0fde-aa5c-e92e-da0f1dd48885@dorminy.me>
Date:   Thu, 24 Mar 2022 12:49:26 -0400
MIME-Version: 1.0
Subject: Re: fixes for handling of split direct I/O bios
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220324160628.1572613-1-hch@lst.de>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220324160628.1572613-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/24/22 12:06, Christoph Hellwig wrote:
> Hi all,
> 
> this series fixes two problems in the direct I/O code where the
> file_offset field in the dio_private structure is used in a context where
> we really need the file_offset for the given low-level bios and not for
> the bio submitted by the iomap direct I/O as recorded in the dio_private
> structure.  To do so we need a new file_offset in the btrfs_dio
> structure.
> 
> Found by code inspection as part of my bio cleanups.
> 
> Diffstat:
>   extent_io.c |    1 +
>   inode.c     |   18 ++++++++----------
>   volumes.h   |    3 +++
>   3 files changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

I'm pretty new and don't know much about the criteria for cc'ing stable, 
but arguably this makes the check_data_csum() error message not lie 
about the start offset in such cases and it seems like a very low risk 
improvement to me... might it be worth adding a Fixes: tag / might this 
be a reasonable fix for stable?
