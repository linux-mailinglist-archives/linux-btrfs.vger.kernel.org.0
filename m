Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC4A798995
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244337AbjIHPHf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbjIHPHe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:07:34 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8911FC6
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:07:30 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76f066e4fffso117849485a.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185649; x=1694790449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zYapSt6uX0e459PuiGKcCvAvisfSmwT8p1OPUwZGHd4=;
        b=RaoE//50SkGkKBEK+EhjIcYdtb640z48xaSjGZhPBU6T/xnEHUmGl8GcD32qZMkBmo
         hPDBX5Q3nY/3+hiu9FeYIIlH+I2TEHNB3WH9Vu9YYcx+pUBSXNqyjg+sekSDbQKw0Xf+
         1a7Jpn5t234UmlH7wkMv8chtknrM3LRg9LX6enK/0/IvBKh7dkCwCmpqNwvNoq6TBkEl
         /7UoJTD5ejPB2nefQrThfmLc5aq3MRWtPhvcqx9gv28QenK8OG+QN2vhOtQNESvN7qoH
         tJL7VOVm4qHlUKHnCf2eRikbM+fLVIVd8tmX8UlhJIdPlAUuckZH7BNRx7p5wrrDkM9h
         kFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185649; x=1694790449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYapSt6uX0e459PuiGKcCvAvisfSmwT8p1OPUwZGHd4=;
        b=JY8JIyOyBNtE4siibqC3rfmwPtbTnj/gncFhDRcFyAHm88MF7/ddbxS7b7Wm7W650M
         XV07VLTClzQCdxqoHv9RqqBCsaO+6p7GZC994j8OseyWRN/LL3mpqpQn2OFMkm8Z3nsG
         ISvRqxB3EJzXPjZb1vbIXQ6pens73UqUVQHRHSGd+jfJ8dZlLaodZt7C9cRp8xH+4gkI
         OVNdhyrQtyAl4UjodJ/ppZ0XWIAevtZ2YUFGLFL5zEbVgh5/GBwNTO/vOH/P5vgQVbtI
         tuHkj6HKeP5TZV21+TPfwt87QBw8sJ3eF57nw13ZFUj7zgsZHLYzRvPp4RrjE/4myYWT
         cGcg==
X-Gm-Message-State: AOJu0YzdcslOkkyoEmOHtktzonIWotmX7g2SGWm3No/x3K2AnV0YaCrJ
        JaH0tCYs1gBWOIdA4SLdEQFZJLAJC4CCUYGqrTVFyg==
X-Google-Smtp-Source: AGHT+IFxU9lur76kp9aNmbKo4lItTATa2O/DDz5HytGrmrD3HjERLWn1WwJDejHq1dMz+i/PUJkAVA==
X-Received: by 2002:a05:620a:e9e:b0:76f:256c:32d6 with SMTP id w30-20020a05620a0e9e00b0076f256c32d6mr2434670qkm.14.1694185649617;
        Fri, 08 Sep 2023 08:07:29 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u11-20020a05622a17cb00b00405d7c1a4b0sm665879qtk.15.2023.09.08.08.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:07:29 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:07:28 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 11/21] btrfs: remove pointless 'ref_root' variable from
 run_delayed_data_ref()
Message-ID: <20230908150728.GL1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <0f7ec851de1a7913b102ea39723fa3cf636cf6b0.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f7ec851de1a7913b102ea39723fa3cf636cf6b0.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:13PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The 'ref_root' variable, at run_delayed_data_ref(), is not really needed
> as we can always use ref->root directly, plus its initialization to 0 is
> completely pointless as we assign it ref->root before its first use.
> So just drop that variable and use ref->root directly.
> 
> This may help avoid some warnings with clang tools such as the one
> reported/fixed by commit 966de47ff0c9 ("btrfs: remove redundant
> initialization of variables in log_new_ancestors").
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
