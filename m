Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6EF9063F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfHPQ4o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 12:56:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41992 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfHPQ4o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 12:56:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id t12so6771124qtp.9
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LTOc1iUswCLk/TAETsANYzcPGjppu/xue2+TSb+5Ur0=;
        b=xcQYL90TAUySxRBpnAbLB+rIMaJBqwJX6763BygMMfld7MrCvuvolyDToFG6tkxVRi
         SmuKQOZGRZ25uU1pH02Mek1VlKO63tqB9be4bcIiIN8kG+Yu8oGoepv8oAyWQB4mlcDn
         8FuFkFbQTwdm2m8+vUMmOnQZnWfKoGiHP1SqHxUnjW4JeML6zJjSrwmP4Q6Gv6j+HbFs
         k1bsdfmxudtXbaL920Ks+7sKqO8LyIaNIsaJkLwKWEXRW6T4r9Oidd8xwpQl6qm4NZWU
         wuQbsmPXFVuIUIOqbHrHIfS7zY0bUwmIPFfQSK9ClWxT3YT9/BCskVpVVv9KVqkevlR7
         F0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LTOc1iUswCLk/TAETsANYzcPGjppu/xue2+TSb+5Ur0=;
        b=QRyJD50FLcPWB/9Ls+iCCSWryIM1U0OFWwWy3exC6E0nXlv8MewrIory+LdBRLhS8f
         Mx+bF8u10qQ+dOgI42MqsYMqwRdW5dws0SB5tapvB4j9Cb5xu8h/RATXY6dhwEXdOefG
         JMx0GjeTHeG6vQ6hLYAwwrrESAZd1R+1BqKYamrW2de9wEDmwhsMHGM3f78KF7szzRUg
         sJ7DVDB8YlP9kKTunDjcRyI97DeVyX8IgC3YgAILDE4+j+Iq8p1fXNPMEepqDFhZhbns
         YzfIl0YeokCNU7aO9eAd1AtAfJJVOFnDaQu90XaAfTNUAMQFo7DWF0mrMp2UlXVLn61V
         4V8g==
X-Gm-Message-State: APjAAAUGgSCUnjRgddNC55kjyBiCe5lt4Rdw5XhqhoRaxdLr9WW0OxTr
        uscdKZinpLZBcwK1SAr5SqMzuoib6WWhWw==
X-Google-Smtp-Source: APXvYqxu9E/Z2TV2Eric7qrx2aQj3P8qZ09XHOnLXjQQFtXpfGRr+4WyUfKAPZEWSinpyR0hYafZIg==
X-Received: by 2002:ac8:76d4:: with SMTP id q20mr8978267qtr.321.1565974603133;
        Fri, 16 Aug 2019 09:56:43 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i12sm2963234qki.122.2019.08.16.09.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 09:56:42 -0700 (PDT)
Date:   Fri, 16 Aug 2019 12:56:41 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/5] Btrfs: use correct count in btrfs_file_write_iter()
Message-ID: <20190816165640.wvlx2upmthqceue5@MacBook-Pro-91.local>
References: <cover.1565900769.git.osandov@fb.com>
 <06b24b06988a5fac5881a0eef613aa2ef0c63834.1565900769.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06b24b06988a5fac5881a0eef613aa2ef0c63834.1565900769.git.osandov@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 15, 2019 at 02:04:02PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> generic_write_checks() may modify iov_iter_count(), so we must get the
> count after the call, not before. Using the wrong one has a couple of
> consequences:
> 
> 1. We check a longer range in check_can_nocow() for nowait than we're
>    actually writing.
> 2. We create extra hole extent maps in btrfs_cont_expand(). As far as I
>    can tell, this is harmless, but I might be missing something.
> 
> These issues are pretty minor, but let's fix it before something more
> important trips on it.
> 
> Fixes: edf064e7c6fe ("btrfs: nowait aio support")
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
