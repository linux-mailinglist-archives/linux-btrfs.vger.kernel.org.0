Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472FA316AE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 17:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhBJQOz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 11:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhBJQOt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 11:14:49 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4EFC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 08:14:09 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id r77so2117607qka.12
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 08:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6SAnEA/881liZzo3QdCP+tgO7Xkx4QaydagVkWyms5I=;
        b=aQJwnB/2cbd/1Zrva5y8K8bdgpigPtHc6g2bMd0XhSzPATayN+zyG8Cp3p0dnyJzET
         a/5i4av8Iu2WoNxXueEc6ZgfOj7UcqsW0G0lItu9VD9yCYNgaofxigSc7TfdY38QzWC2
         QrBPRs5Wlx6B3MVlwa6Y2RHm6PxA6c6bN49wPkcVfPJoCUyyhMRQsjTRzcvLO/RJ6pfu
         57FaSlCOb3N/pgxL5yEqyYBaC53FLVilZ1h4wMWturmpFDeCCm02WVfvPI3ZdlHh8mWK
         yyM5TrYHAo4v9Y4MUfyuC9zO1Hr6TcfIlt49VuFUUvxGhEJDXmnCUO0+C1GaD/aDwQmy
         g+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6SAnEA/881liZzo3QdCP+tgO7Xkx4QaydagVkWyms5I=;
        b=q5wDH8bQrzt35IMVJGmcw1FhS54jgXv1ou+hTX173XdGYt8vOzw9fkNj+VCRgY6hES
         XDd48+aQ2HDa9DAOUghgyD+JfMzUpdiHK/92/I+DYr0MVu67/7gp5F6XwgelrTpMW75a
         gRmQuuHVudoUpkh66iEYp6SJh9tuFeub9qcPL8/I6L8PparSpXvYlMVRTX0DMIWNmOBZ
         uJmt2H2F/HO38W3xZOEZ63FY4EARaWSkdBZTQlj9sQuIVOgcAJXf9HxZzLxlYCmin49d
         gDb6yr3vAxL8Q3JSdUler9EokZoGOIbAEcbMwOJpHdf66JkIlr7dXYXvjsjDlS2G3eiq
         IN2Q==
X-Gm-Message-State: AOAM5338eyCzNCATFU+0xQR0qg05/PsJ3OMLB21Nm4hJ5HIBfF/YY2rH
        FbkMKulG3AGP5ShwBjbNP32IsQ==
X-Google-Smtp-Source: ABdhPJxWdlC4f0+MYR9Nq15RzQ8Yk/mHhzSck/2lmgscsm/0Z842aA1W9jSm9UlLEG8Y+4RbYXWmig==
X-Received: by 2002:a05:620a:227:: with SMTP id u7mr2132667qkm.226.1612973648443;
        Wed, 10 Feb 2021 08:14:08 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v30sm1513654qte.26.2021.02.10.08.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 08:14:07 -0800 (PST)
Subject: Re: [PATCH 4/5] btrfs: add allocation_hint option.
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20210201212820.64381-1-kreijack@libero.it>
 <20210201212820.64381-5-kreijack@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <415a0a47-ce3d-26f0-b770-156b6e53e4a7@toxicpanda.com>
Date:   Wed, 10 Feb 2021 11:14:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201212820.64381-5-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/1/21 4:28 PM, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> Add allocation_hint mount option. This option accepts the following values:
> 
> - 0 (default):  the chunks allocator ignores the disk hints
> - 1:            the chunks allocator considers the disk hints
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@winwind.it>

We don't want an mount option here.  If a user has tagged a block device as 
METADATA/DATA_ONLY or METADATA_PREFERRED we know they want it.  If we want to 
add a way to disable the hinting then I think a sysctl option to disable is a 
reasonable compromise.  Thanks,

Josef
