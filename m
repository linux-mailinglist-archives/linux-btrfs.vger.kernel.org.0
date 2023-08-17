Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803F177F6F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 14:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351010AbjHQM6j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 08:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351048AbjHQM6f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 08:58:35 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379AA2D7D
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 05:58:34 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d62ae3fc7f1so6026633276.2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692277113; x=1692881913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZWanNNyl1e4a9HFsYZnsiD4qo/hfmyUMdIQ/f5SCeE=;
        b=ymNu3ZNR7DLLTifK++n+6+TWYgjhAFjOdwvlpKEvS46VCrH1Gp/z2gvvssOg7XjaCu
         SQgP7e7+raH1pPlEKLIWmQ3yxaq9PnzaezYJ9fk4QyeIQcowpQ5QwTjD5tDFE6lFxexx
         vxxLvV6JZcERm6CqEksv+wTo4PAGvGtelnLjfjvXZiZpQjvEebGZeVx6WV8KQsVN5sDd
         /1MQqoPTlh50knkCFYOQIcIvTDerelXSj8NTrI1ye7ROUgwpZH+i/mh9DGmVsWjR7vvT
         dESqXyX4C9az3USSxjfUsUxbOSCiosgqwrLGVrmBF9uHNK3/xT72oK4xBy61DrlcslYV
         +WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692277113; x=1692881913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZWanNNyl1e4a9HFsYZnsiD4qo/hfmyUMdIQ/f5SCeE=;
        b=CeYcwj5ECn+iB+G5EQMyFXDxAdN0857jIgkG/otjQt5lLyUcRzEaomI069wGfO1/AD
         TRZxShD9NAO6TUe1hwaUbKj8K0zcwcL/kOt/Kfr5i2KGLTNEdvuQ7BCegoBAIngWM4Vv
         ixL8Mff6NmFBCM8tvaaqWqkyZ24hlf3icxHt1yS4FgzsFdCCb+krodxjcXOL7iJ4xmM/
         CtIcTdOv83x5I1R95abm3gLWrFun///LJzqGJ8+cE1QiG+cuqNaM5ytuDapshOuU8F4/
         tnR088bnbKNgN8xr+EI1CL/eaEW5txtU8sYzJEFiohD3zq3pYvmQy0n66O8xeOe2PCBM
         T7Dw==
X-Gm-Message-State: AOJu0YzqEdEhvwhN/B0g127heunFsCERH6+qHmrMVAsAzFzqCn5MoPcz
        25Pucx8M6fhpiNGRwP4Lwl/KfQ==
X-Google-Smtp-Source: AGHT+IE8KQ70rQLWfnLEZf3ks2BrtS9eEh50LlFmA8NA7ZVUS1DJy9NQkE8oq2Hj10e/paQ22pIMWQ==
X-Received: by 2002:a25:db03:0:b0:d08:f00d:ccfe with SMTP id g3-20020a25db03000000b00d08f00dccfemr4653298ybf.15.1692277113367;
        Thu, 17 Aug 2023 05:58:33 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p206-20020a25d8d7000000b00d677aec54ffsm3223107ybg.60.2023.08.17.05.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:58:32 -0700 (PDT)
Date:   Thu, 17 Aug 2023 08:58:32 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/179: optimize remove file selection
Message-ID: <20230817125832.GA2932674@perftesting>
References: <20230817051317.3825299-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817051317.3825299-1-naohiro.aota@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 17, 2023 at 02:13:17PM +0900, Naohiro Aota wrote:
> Currently, we use "ls ... | sort -R | head -n1" to choose a removing
> victim. It sorts the files with "ls", sort it randomly and pick the first
> line, which wastes the "ls" sort.
> 
> Also, using "sort -R | head -n1" is inefficient. For example, in a
> directory with 1000000 files, it takes more than 15 seconds to pick a file.
> 
>   $ time bash -c "ls -U | sort -R | head -n 1 >/dev/null"
>   bash -c "ls -U | sort -R | head -n 1 >/dev/null"  15.38s user 0.14s system 99% cpu 15.536 total
> 
>   $ time bash -c "ls -U | shuf -n 1 >/dev/null"
>   bash -c "ls -U | shuf -n 1 >/dev/null"  0.30s user 0.12s system 138% cpu 0.306 total
> 
> So, just use "ls -U" and "shuf -n 1" to choose a victim.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
