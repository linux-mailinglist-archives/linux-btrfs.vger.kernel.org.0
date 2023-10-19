Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7907CFDB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 17:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346255AbjJSPUp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 11:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346181AbjJSPUo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 11:20:44 -0400
X-Greylist: delayed 514 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 08:20:42 PDT
Received: from jablonecka.jablonka.cz (jablonecka.jablonka.cz [91.219.244.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED212D;
        Thu, 19 Oct 2023 08:20:42 -0700 (PDT)
Received: from twin.jikos.cz (twin.jikos.hovorcovice.czf [10.33.87.18])
        by jablonecka.jablonka.cz (Postfix mail delivery) with ESMTPS id 84EFB6035A44;
        Thu, 19 Oct 2023 17:12:06 +0200 (CEST)
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 39JFC4qc027698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 19 Oct 2023 17:12:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jikos.cz; s=twin;
        t=1697728325; bh=+cpM4igHbnnw0poLVSTLf+CI7GJi/qmDt46l2fHfXos=;
        h=Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:
         Mail-Followup-To:References:MIME-Version:Content-Type:
         Content-Disposition:In-Reply-To:User-Agent; b=btSbo8rM+DrsZy0pVbMD
        yJTIpcDQMA2SZzrlp8TSxiTi9FQOPgwh9hmPo4Ek0+f5TYGNqRQ+RDlKRHtyU0RUARz
        Dwi5vZX1eY/J0dWiTPmLwpUqXoTXbJegIBJYY3FuejTRVrG2uq8ROYdq1NU8NBtJUX0
        v/hqNsq2jTXZAJjC0=
Received: (from dave@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) id 39JFC4kN027697;
        Thu, 19 Oct 2023 17:12:04 +0200
Date:   Thu, 19 Oct 2023 17:12:04 +0200
From:   David Sterba <dave@jikos.cz>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fix for 6.6-rc7
Message-ID: <20231019151204.GA13867@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: torvalds@linux-foundation.org,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1697555249.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697555249.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I don't see this pull request merged after 2 days and I don't see any
reply from you that there would be any problem.

The mail is in lore archives
https://lore.kernel.org/all/cover.1697555249.git.dsterba@suse.com/
https://lore.kernel.org/linux-btrfs/cover.1697555249.git.dsterba@suse.com/

what's a bit suspicious is the "X-Spamd-Bar: +++++++++++++++" header in
the raw message, this could explain it. Please let me know how to
proceed, thanks.


On Tue, Oct 17, 2023 at 05:34:56PM +0200, David Sterba wrote:
> Hi,
> 
> please pull a "one-liner and thousand words", fixing a bug in chunk
> size decision that could lead to suboptimal placement and filling
> patterns. Thanks.
> 
> ----------------------------------------------------------------
> The following changes since commit 75f5f60bf7ee075ed4a29637ce390898b4c36811:
> 
>   btrfs: add __counted_by for struct btrfs_delayed_item and use struct_size() (2023-10-11 11:37:19 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc6-tag
> 
> for you to fetch changes up to 8a540e990d7da36813cb71a4a422712bfba448a4:
> 
>   btrfs: fix stripe length calculation for non-zoned data chunk allocation (2023-10-15 19:00:59 +0200)
> 
> ----------------------------------------------------------------
> Zygo Blaxell (1):
>       btrfs: fix stripe length calculation for non-zoned data chunk allocation
> 
>  fs/btrfs/volumes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
