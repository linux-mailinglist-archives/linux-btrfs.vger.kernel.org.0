Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70904B03D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 20:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfIKSqs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 14:46:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39541 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbfIKSqs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 14:46:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id n7so26568658qtb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 11:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tye9MK7Ia//ShdJ6Q+EBzo0dqq/nVtB9iB/ytR7LYHM=;
        b=zbfKkts3tg9faV0a/+3nnqK1tgeK1nRBLOLKbLDfp9AGgIWuMwJ+YOY9ViapVSlZlv
         4nGQ9D/aZmK16otWjVUtaVcHYcLr6MKnaW3ZYXc0zw77FwVNuz4lCYRgp85z3hXSs1p2
         oWWuAmv4pSxpVka0scDWp6PXTkKn7QqDOmI8JfAhY9UYgzehLaUbkh9+/FRcOK4K3/gv
         ohizDynWagJZLB1rU6nJ8rlrLspC8ZsHp2JosQ6gCQEGShE7U4LTFBeJh/uG095OFYNe
         fcOMWr+RINkCpW38znYzFn4+P+pu2iV6taAjYmMzOhz4yGfdMPekEemD1oXpuCQyvlOa
         ZmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tye9MK7Ia//ShdJ6Q+EBzo0dqq/nVtB9iB/ytR7LYHM=;
        b=SW6BBZJkjARN+hXNqPsGRA2XJJcsQKKHYnQQMlZvIhWXJn5VfQiav5cbRoeBSkgTuE
         fCDD1g4TfMjm6VqDGSlG8vT3N1B9geSY7k4fpXeestIBjtPPQ9l+L5ScPR5pyGnenZt1
         YYOCW8kAW4apXpFiFEh9YEGGwsE41+AvYywUjfUtKgXliW+dVS8X8AH1V8tN/Zw8JsAc
         bDRQVbcCv7Iel58PTQEwh11TTmCjJZ1RADRAE0oHC0gLlYjQe3CVso8vk/Fsp5p60zUB
         JtPFC4IPxf16XYn+FcwOloMm2RCHfdg9kPGuy3y7J+ZyQMBDV95iG7aghdQwk+Na/+Px
         /wSw==
X-Gm-Message-State: APjAAAWZGInyivKVlUgSe01w3DM0pgLGcRz7BDngKD3MEK6gx9Wbxduv
        fvMMZ1pXLlVktwDQV7bL+AJzZFI0ZniCqA==
X-Google-Smtp-Source: APXvYqw+2ZWzvZ2QX+c5UNaDKH9MFzUO+MopgOlr/UEg/rVPbIQ/rCCiJwKdZmKI3UnrYC70Of9wgw==
X-Received: by 2002:ac8:5296:: with SMTP id s22mr36509486qtn.139.1568227607037;
        Wed, 11 Sep 2019 11:46:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::87bd])
        by smtp.gmail.com with ESMTPSA id k17sm161757qtk.7.2019.09.11.11.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 11:46:46 -0700 (PDT)
Date:   Wed, 11 Sep 2019 14:46:44 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: make btrfs_wait_extents() static
Message-ID: <20190911184643.sup5qzevetd7ecd3@macbook-pro-91.dhcp.thefacebook.com>
References: <20190911164238.19524-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911164238.19524-1-fdmanana@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 05:42:38PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's not used ouside of transaction.c
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
