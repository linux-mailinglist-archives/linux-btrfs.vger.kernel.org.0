Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80963B23E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 18:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfIMQMi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 12:12:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39082 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730578AbfIMQMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 12:12:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id i1so9530229pfa.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2019 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P0eqX5XkxFRyZW4qragBiwA9n55gIZYCPdhHAEdE0Cg=;
        b=URHojBhRU3LUY4auj+Sjj+XApWZeqhNAg1R8atiNWkSpMPfd/6gNqm/tusSZgd/5Bx
         Tyd3uyZhY713CSDYegz15IfYRBhiQrP4PSY8NmoeXQmVIcW9fEfKSh/pOin6lNkHD6Gk
         b+GrJ+tJtH8lS/NEtLCXcHveISDzQkdCTJfqDd41Dw8P/PkK1q+32hh8JpGy00SZOm7H
         WBJaWfe0ztJuV+ofZTvg89ZDoqe0RwBdmdOQIVXyqXcRdb5Iyf5rSUCosijpzT9OK0g8
         5D10LyGtf7MoZA5HwS9e9bJu5XXc+lZGYBFLB7goZZfaLVWMhVoqUHJSsdpcPyPaleHZ
         p+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P0eqX5XkxFRyZW4qragBiwA9n55gIZYCPdhHAEdE0Cg=;
        b=PN5ffDvVu/noHFs3Rvn4cvqI3KvH/M+GBZRj63BreMfPkGcLuTFx5c+ZYiDlHbsxrv
         I2It81zWCs7WbDp2mGIOEMN6uJLTZxXa1sZQpGxcEcWtLIXBDdmQrvFR9XMpbnkim9f8
         PWQEK+n39X4L30eWaJF69RiCPjh/G8pRQjKvnIGMf17bXeY1nxC/GYT9AYI+0+dY83e6
         B0Su5Svy+F1okGVXgGm9OtLS9R74ZsOTlVn4zLWqyES0fkSC/9oitKN9hAnLr43EweIZ
         2BGJcVcKVb4U/geu4H+Mobi6fNXxEGzckyzjsJ2vvaltuJvzci9HF/2fm+P9Ln6Hqyf1
         RTaQ==
X-Gm-Message-State: APjAAAVcKUO5WrDCTcROANx2JI0R5+9S5fNdBweXaAZ2VOGB2O6qRJ6Q
        Ia9zdq/wXRJceew2K+X1Kdzh1A==
X-Google-Smtp-Source: APXvYqzE8N6bQo5dU9iLjuZz6/nxbkouDRI1jHZsX+SKzi71M1QIG56j8Unn9PSLNaZeQrYB37clig==
X-Received: by 2002:a17:90a:9ab:: with SMTP id 40mr6141615pjo.38.1568391157443;
        Fri, 13 Sep 2019 09:12:37 -0700 (PDT)
Received: from localhost ([2620:10d:c090:200::1d1c])
        by smtp.gmail.com with ESMTPSA id r10sm13082734pfh.1.2019.09.13.09.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 09:12:36 -0700 (PDT)
Date:   Fri, 13 Sep 2019 09:12:35 -0700
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs: Verify falloc on multiple holes won't
 cause qgroup reserved data space leak
Message-ID: <20190913161234.jfkyopccbohz5njz@macbook-pro-91.dhcp.thefacebook.com>
References: <20190913015151.15076-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913015151.15076-1-wqu@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 13, 2019 at 09:51:51AM +0800, Qu Wenruo wrote:
> Add a test case where falloc is called on multiple holes with qgroup
> enabled.
> 
> This can cause qgroup reserved data space leak and false EDQUOT error
> even we're not reaching the limit.
> 
> The fix is titled:
> "btrfs: qgroup: Fix the wrong target io_tree when freeing
>  reserved data space"
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
