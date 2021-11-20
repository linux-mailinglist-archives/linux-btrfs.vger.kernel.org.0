Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6934580C4
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Nov 2021 23:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhKTWOX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Nov 2021 17:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhKTWOW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Nov 2021 17:14:22 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D95BC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Nov 2021 14:11:19 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id g28so13966865qkk.9
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Nov 2021 14:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RyCv7/k8cSIz9Mh5xeBnCG4BeWKtjmIRK1J+L90k8po=;
        b=V8bcQn7Wvp6gwbKSfpvD6QUr8L8jdiA3dp23dd7k7aOVyPba0mQXXsYrTrIInE5uuM
         MfU4BcD9b64YlK5JQ/Ow2qNU8YvLF1xDpL0efEJmP7c7XLD801msTbSPt/VWbUxoTPLv
         H0AuDloCsgA/00vVLVri9MODU6f5QVHDg1yjvCERKiAZbcd0jJFv/+7JwIETzAtJTlXx
         o0p2E7OUcZ2o9+tgrCjM9I/DW8g9+S7d2+jSD3tVBm8q5g4riicBpR5Q/DG2FCJlKJRB
         7EbmqvABr2UL11UhvZDZD/CjEHIrGwkzIqvtcr91WYkVR+0suKkGz73+KGYz4oii6jo5
         t7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RyCv7/k8cSIz9Mh5xeBnCG4BeWKtjmIRK1J+L90k8po=;
        b=jTXod/O9kpuyva+YsGfiQumlxvWxSq8yhYa52CRnMMc2r8WtLTORYwIrQyGe4DGCHu
         sWUCKGf8WzssYALH0/Bc5Okv5FrzGqsfIrUOQ0CIsOdD5K7T/M82AM0karpISKyZ39Di
         F9fI+tbslPrR9hJbYydQPIDglKuwhCU31W7R0hU7fKsSHxGzi2tAZFGrHrpg5RHX6bN2
         tUZyFnHmpMz1yfPfqTJMaRbTTXYtTGt+jPDkC2jOdCQ6Tqb3xZVNtOjaXsBdOkKGj7KX
         5tllo7ck1yJrrwWVZ4y1mlurLXjFXiU8hCzgLF+FK2wuKBP4CDZ6oFTSTrSUS0c5eSPg
         Eysw==
X-Gm-Message-State: AOAM531LKLdpkIBcrrjdykCRm+P/kz9xj/1WG+4HhF9gwQsGF1I3i0co
        TruNX09uyPiZswW7OA+TZzIdPPJQ6t1sVw==
X-Google-Smtp-Source: ABdhPJxrlTMCykF9IYDAVbfFk+BohGWADP1E6JKl4yVIdeYgz66rrzXnl7y9buBmsQiwDDBww65Dtw==
X-Received: by 2002:a05:620a:2447:: with SMTP id h7mr13966157qkn.75.1637446278061;
        Sat, 20 Nov 2021 14:11:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n19sm2030548qta.78.2021.11.20.14.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 14:11:17 -0800 (PST)
Date:   Sat, 20 Nov 2021 17:11:16 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix the memory leak caused in lzo_compress_pages()
Message-ID: <YZlyhNy1/xRYVuCC@localhost.localdomain>
References: <20211120083411.120338-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120083411.120338-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 20, 2021 at 04:34:11PM +0800, Qu Wenruo wrote:
> [BUG]
> Fstests generic/027 is pretty easy to trigger a slow but steady memory
> leak if run with "-o compress=lzo" mount option.
> 
> Normally one single run of generic/027 is enough to eat up at least 4G ram.
> 
> [CAUSE]
> In commit d4088803f511 ("btrfs: subpage: make lzo_compress_pages()
> compatible") we changed how @page_in is released.
> 
> But that refactor makes @page_in only released after all pages being
> compressed.
> 
> This leaves error path not releasing @page_in. And by "error path"
> things like incompressible data will also be treated as an error
> (-E2BIG).
> 
> Thus it can leave btrfs to leak memory even there is nothing wrong
> happened.
> 
> [FIX]
> Add check under @out label to release @page_in when needed, so when we
> hit any error, the input page is properly released.
> 
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: d4088803f511 ("btrfs: subpage: make lzo_compress_pages() compatible")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Woo now we're making it all the way through the xfstests runs on the vm that has
-o compress=lzo.  You can add

Reviewed-and-tested-by: Josef Bacik <josef@toxicpanda.com>

Thanks for digging into this Qu,

Josef
