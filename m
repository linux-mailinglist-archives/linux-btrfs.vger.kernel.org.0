Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F63E99D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 22:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhHKUl3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 16:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhHKUl2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 16:41:28 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0336C061765
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 13:41:04 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y130so3899929qkb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=inYZ30BOLCFmgjt9HfeCp/TY/OhCcf+R7LqwPWc97xU=;
        b=vFVVPt9ttpnqzk26gCVpoJaqXoIbN1/GF7OPtdMUn9hb2kY7DXjDSgo1ifrcl+btbl
         ALUtKUuuUV4exmtwQBFRe6kUIw8GB0y0/zLtuEnNtkRtHVLkvRYClOoY/gENS0gjdlQh
         c4yN3oPsS5u32KL0uyxNmh3NEtSnl1QcZku50vGvQWFcKCBLMSOmOjpno+JyaxLEkJeB
         gFipjt9MecWLcKNelqV+vTcygwZC1y1qNKZlolebEUumtTSwFfL9ZhdbjOiFa4ZRB3+x
         /s5/QoByh/oWx4yObb40fx8Ux5g2JgzHcl/NKkWlN9BkszMhEGALah8HxQa7BkMHnuqY
         eIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=inYZ30BOLCFmgjt9HfeCp/TY/OhCcf+R7LqwPWc97xU=;
        b=Y019hSJGyBD+QlHHxUzGD96QqbY3Bysy3IsYe5yA4sMEhqO19E16vdHL+8BWZWigBV
         Yct0/9z/7Ium2dcvw3ge6TaKcNtKqYE2WsmVjKYJditQHjiTDUR+MHUv4pZ4Im3vmwk5
         QjB5anj7lQne/dYFYD0LcK9I7Uv4vEminBcgnX5i9oi+o3Z7VlomqobcXCBmQw+Wf5P/
         3iwyYSnHqednMnpG/bJMnG8xKpVDO0CB8pr60ayLnAUeW9xFj29cirXnSFyojQuu1L/m
         rRpMJGHUhjPf/gDG1WV9X150zrxx+BKXnnWkaIbKei9QyE2QCby+rbDUaJlQr4PrGo4Y
         9TGQ==
X-Gm-Message-State: AOAM5321DYNMlqOCtzkygM9BgC/Jl7ybcOmJkNsJfQquy0o1XLEjan8h
        +Xc5bVUOS7BfbdbWl4cMGSc6mg==
X-Google-Smtp-Source: ABdhPJwFs6S4osGKAbtUaijXVplaXTYDu0BDkltgjYSF76b2RKCRx/0FNconbCe8HoreOCNlkRtzhA==
X-Received: by 2002:a37:d43:: with SMTP id 64mr959993qkn.430.1628714463671;
        Wed, 11 Aug 2021 13:41:03 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u189sm168648qkh.14.2021.08.11.13.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 13:41:03 -0700 (PDT)
Subject: Re: [PATCH] btrfs: Allow read-only mount with corrupted extent tree
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-kernel@vger.kernel.org
References: <20210811200717.48344-1-davispuh@gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ccd23bbb-1404-0727-383f-2412a5d4df36@toxicpanda.com>
Date:   Wed, 11 Aug 2021 16:41:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210811200717.48344-1-davispuh@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/11/21 4:07 PM, Dāvis Mosāns wrote:
> Currently if there's any corruption at all in extent tree
> (eg. even single bit) then mounting will fail with:
> "failed to read block groups: -5" (-EIO)
> It happens because we immediately abort on first error when
> searching in extent tree for block groups.
> 
> Now with this patch if `ignorebadroots` option is specified
> then we handle such case and continue by removing already
> created block groups and creating dummy block groups.
> 

Already done and queue'ed up for the next release

btrfs: rescue: allow ibadroots to skip bad extent tree when reading block group 
items

thanks,

Josef
