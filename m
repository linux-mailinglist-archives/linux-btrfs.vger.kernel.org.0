Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DF4798966
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244168AbjIHPAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjIHPAy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:00:54 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9DE1BF1
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:00:50 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76f14d80ea6so124485585a.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185249; x=1694790049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAK2k78LbGD7mQshaHp4rW3Ab16n/6vmmH8ty/tC42E=;
        b=X1wk4NO7ARTN0LQYjlXko02K338g41Kde+BOMtHPGrIWvmuivC6MelRDXRss7MqhS2
         4PVekvhlALRESvGWmqJ0X1sm6deLyP53u2rzo74scUvShx41ndZ64GEsrm1dkG3FKK/w
         CTQF9C5hmZRS1Uo0zNYcfUrS+rHPcIbgy/Cb6+hyzuD9JpTE8p3dzjIfzz0iTq1HYVOQ
         4TiVpy25uJGqsy+goQWQx8eD/3WF/vw56sWsu/eUfuN9qtsq1GWrghmQo/jcjsS1SJ2j
         m7npvc65LbyfOrjDC0saoIGi3+NJ/ivZ9+4d7jbajKAixcw/DJmZoCN3Kj5fWLJtAets
         4bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185249; x=1694790049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAK2k78LbGD7mQshaHp4rW3Ab16n/6vmmH8ty/tC42E=;
        b=eTz+TL0Vdmf5dReQLeVJYiZ9OkF8i4ugCf+jhIpsMjyl32HxdwxdL+iktlKvTcJ2Fb
         WeZuTwGa4VZ+NLBkAa7VMiokJyqn4IrWhDJQgHFKsbUfMLiIvPTGUUMw/KKFcN02IcoB
         u4KAtyk24pxl7WgQGI0+QkLPaI4PWGsAMzvRi5b1UZlghHa6mbTzLg6zLDQPxs1aRYZf
         5QOHDtHYMmFV8bMta0Tt2E9geibuUSAiLYih79nseq0grL4bMj0S+a8JMjRjwuz7KQBB
         6iqOJ0JIfk0PbNJtS1CkSaT8I0SGRj+JMaplr89uMae+YxiKRlSiDyXFIzkILb9qd21C
         BLHA==
X-Gm-Message-State: AOJu0YxZX/uMbl7OJMywdEXql3Frz0j8rq6xUI6EY2Ykeq10tR6UwqxY
        qKpRaQqaNvGfkBcdllfnkkwb2Q==
X-Google-Smtp-Source: AGHT+IHzU4JC48GIHA6oZdiz3cQngYpKDSbUbHb+A/OEV3XsdTrmPdcEsxKIWdoJJAm9/cCb+S7Enw==
X-Received: by 2002:a05:6214:5a07:b0:64f:8753:71e7 with SMTP id lu7-20020a0562145a0700b0064f875371e7mr2404995qvb.49.1694185249304;
        Fri, 08 Sep 2023 08:00:49 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e17-20020a0cf351000000b0064f50e2c551sm767511qvm.1.2023.09.08.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:00:49 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:00:48 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/21] btrfs: remove the refcount warning/check at
 btrfs_put_delayed_ref()
Message-ID: <20230908150048.GF1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <d67dc2650159fbcbe0cafc5bb9ab390aa985ce11.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d67dc2650159fbcbe0cafc5bb9ab390aa985ce11.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:07PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At btrfs_put_delayed_ref(), it's pointless to have a WARN_ON() to check if
> the refcount of the delayed ref is zero. Such check is already done by the
> refcount_t module and refcount_dec_and_test(), which loudly complains if
> we try to decrement a reference count that is currently 0.
> 
> The WARN_ON() dates back to the time when used a regular atomic_t type
> for the reference counter, before we switched to the refcount_t type.
> The main goal of the refcount_t type/module is precisely to catch such
> types of bugs and loudly complain if they happen.
> 
> This also reduces a bit the module's text size.
> Before this change:
> 
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1612483	 167145	  16864	1796492	 1b698c	fs/btrfs/btrfs.ko
> 
> After this change:
> 
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1612371	 167073	  16864	1796308	 1b68d4	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
