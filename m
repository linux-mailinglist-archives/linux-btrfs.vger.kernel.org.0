Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF340504632
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Apr 2022 05:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiDQDTW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Apr 2022 23:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiDQDTV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Apr 2022 23:19:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D931208;
        Sat, 16 Apr 2022 20:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=138G56qF3OJ0IfNUVRnL54keWgjMUuau5LdUBd3FeOk=; b=wVI2Qjsy4Y+Tsrq0t6/bcoR/vE
        QtqIOvNBg8gf0u3+2MWn2icICHDemS0ne1921LeulaGrdXDlcrzu1gJDYOqKd/woa3GmrdxblKx6P
        7hwywRmW9E+X6Js2tyRSgr/vd4Mnrutr7ZonjepM9n9UjtB1+DNfZ82tI7v/p8EJhjAljlhbCE5oJ
        ARp/VCKy/zeGWlHvzDVhq0FTmnQcArXxP7IgVvzFEd4tE5LSgzzjaWCwcDIKPXkWAt6yFGcY7VemI
        MiVf9COmI4taS0i5b1UBBJvd/YfHUSzYQEZsDMwTgNO7CIrvZmToATwFkiEUFpqMxn49b2gaPN5r0
        zHkTyVfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfvOy-000kqT-Nv; Sun, 17 Apr 2022 03:16:40 +0000
Date:   Sun, 17 Apr 2022 04:16:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, Schspa Shi <schspa@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: zstd: add missing function name in
 zstd_reclaim_timer_fn() comment
Message-ID: <YluGmERvtQY9ju7Y@casper.infradead.org>
References: <20220416081534.28729-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416081534.28729-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 16, 2022 at 03:15:34PM +0700, Bagas Sanjaya wrote:
> kernel test robot reports kernel-doc warning:
> 
> >> fs/btrfs/zstd.c:98: warning: This comment starts with '/**', but
> isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

This is the wrong fix.  Static functions should not have kernel-doc
comments.  Just delete the second '*' at the head of the comment.

Also, btrfs developers should be testing with W=1.  That will catch
these problems before the code is integrated.
