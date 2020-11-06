Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E652A99E0
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 17:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgKFQz0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 11:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQzZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 11:55:25 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC56C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 08:55:25 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id c27so1644678qko.10
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 08:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0vgzfQKA3GmsK2EHkYTj3FFm2v+OkGyAzmdVge3mu3c=;
        b=bov0KpVIDnpkWzcbHSo6yim2dgl2Jc5o0by25RvMIF7Szvbuy8pSxCgokUS5m5kdxv
         JASiX3IatXarFEPCJxm31MozROgnofWJlOMNZ7vU+HUWO4FJP9I7uyJYeEtUK3l1wwKA
         tcn7ls7E+dzmM0pdjFjTOC6kt3rRskHkmNVUZ/o//VZGG5NrJ7vAec8ClYC9obLNKVb5
         atH39DnRh860JFPpYCbp6NVHi+JJd9M2UbaWoC1Jlk9ZOQKXaJjskgzufgn5/x3x0ff8
         IoMEwiz1y/XKEWYLBke0NgG5U/3WOrBUpfP6objBs0OBNW5400ImEq6ytrMYjUphX+DD
         imng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0vgzfQKA3GmsK2EHkYTj3FFm2v+OkGyAzmdVge3mu3c=;
        b=bObEppFX6omcQAchpxUMhWGLrtNSfJXC5S8/o0Ci+7chi36OPRpgxEZXyv92brixkG
         /c+FUeFVO93n6MeDDxH7+75X7wZoNGSCEsIm6xRIv6FzhQA6sqb9/yGLJuQK6fDfIqgi
         i8hLoAK5NjlVVOgEFE2yAtgtRan2VAkxlqI131z+AkgDYINMA+Y/phK+dwtwZoNrnLVH
         GiT6Tbkdajc4A3fk1AxAlOoS9+SNLI0DH2GHbOyCxjNtCqn5y8sKx4bn3ix0fSx9QfNb
         j5VF3tkBdf/JOG7CYqeLXuw4DTyn43u/ipxgO/Tf6X9NVNI5WrU5x1GRTbxxuzeZ1w5E
         qcDQ==
X-Gm-Message-State: AOAM533uHFuvc3DwX9Z/YBz/U0XE/Ei1l9dUv08aiVgpWV4qjkoqEca7
        Y/F/NkSIBD7n/wqWbHxgszsLNQ==
X-Google-Smtp-Source: ABdhPJz6zoAS+w+Nx/nIgI5cHblOeDPEj3bZm0XroafbwcZ1wMdPBLRuOPB9REntwfM5SiRyow1XLg==
X-Received: by 2002:ae9:f404:: with SMTP id y4mr2489647qkl.372.1604681724794;
        Fri, 06 Nov 2020 08:55:24 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 185sm872761qke.16.2020.11.06.08.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 08:55:23 -0800 (PST)
Subject: Re: [PATCH 1/2] generic: test number of blocks used by a file after
 mwrite into a hole
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1604487838.git.fdmanana@suse.com>
 <289e1444dc95cb86945126b2677ca25879fdb8dd.1604487838.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <eda0fe7a-5bb6-50e1-0664-d4e553a1b2c4@toxicpanda.com>
Date:   Fri, 6 Nov 2020 11:55:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <289e1444dc95cb86945126b2677ca25879fdb8dd.1604487838.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/4/20 6:13 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that after doing a memory mapped write to an empty file, a call to
> stat(2) reports a non-zero number of used blocks.
> 
> This is motivated by a bug in btrfs where the number of blocks used does
> not change. It currenly fails on btrfs and it is fixed by a patch that
> has the following subject:
> 
>    "btrfs: fix missing delalloc new bit for new delalloc ranges"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
