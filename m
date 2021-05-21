Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C8638C86A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 15:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbhEUNkX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 09:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbhEUNkE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 09:40:04 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F3FC06134A
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:38:37 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i67so19691071qkc.4
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s+N32q+c+jROeC3/N7S+xSJq5DAg2NvttBc4/vH2/hY=;
        b=UWNzZG9VgfYMt+NpsMAgdsY+P03Tq/SDNlRnnpp71mA+PvcSvWFlkP2V5GU70KCuPA
         3+UbSp3nkKx3KRW1rLBAk0G8FfcrHtykOjv31NZKyYnM8GGvlteOYubTcS2EnaGuQGNF
         4i4tJts/peAwUrtxw4Ns1zl2laXmcT1Bq6LmOn+ToNXZvg6J8OL+PLwbK9iTDA+5xAcC
         aWAGsA6geHBmSC6LB3b3eEhRVLL+yd/NnVh+5drTKS9Kp34IugJZHKNndA9yES7TTuZy
         5cpI/sZqFfiC6TfYLWJsht2lZC3upRiw4vXibzKbbVnXM6oSDJ5qXYpqRgzw+83nnKNq
         XxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s+N32q+c+jROeC3/N7S+xSJq5DAg2NvttBc4/vH2/hY=;
        b=iKWxfL22jo4VRR2wWBEGNJAKX29xZ61yyhqsYhjlxlwcvci6FDrU1HDZRPnwSU28LK
         BwTIWyf9Id7xwAvHHFjGxNJY4BenDSuGprWetQOC9LsB4Zku0aBRa2OxLPkY/ZUd5ZPC
         WmkwnbFvHceFD8bNZ6MUPBOX0oR7QbXGe2iin50heb6mnuYqY7KkJB9gpLRRZRdhu+Cv
         4wmVcOuJ4SD+59IdcFV+4PSjaAAna66kvlYy8NL0CwAxnenZB1iFHbOb9OfOFGDVFkMa
         jEg2iU2W4mbKA5fc8YB+A+80DriatYjkEYhAF+jJpX/z770B3jCz5wIf5TFAZJY8oDwH
         Y4Bg==
X-Gm-Message-State: AOAM532LQuWDEc0aSUBtOjIB6Gs63ZT8O5EZcE8fVieFu3ZhDYLJRd0Z
        F/MurpVcO02+c/Cxa1nXt1JTTht5WP2QYw==
X-Google-Smtp-Source: ABdhPJzZxhNV71YPUUgj4GwU/yD+aOTzT5p1QoDzUanj8FPruFswhRe5AT5RnSz1Uhsb+7qMl8+z+w==
X-Received: by 2002:a05:620a:22d8:: with SMTP id o24mr13065200qki.361.1621604316814;
        Fri, 21 May 2021 06:38:36 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::114c? ([2620:10d:c091:480::1:e74])
        by smtp.gmail.com with ESMTPSA id a21sm4716245qtm.54.2021.05.21.06.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 06:38:36 -0700 (PDT)
Subject: Re: [PATCH 5/6] btrfs: add cancelation to resize
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621526221.git.dsterba@suse.com>
 <6aabd4e1187d0ce49bad7bf7967148a86b4c56d4.1621526221.git.dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6e1d7267-fa5e-ded8-2160-6a5073736f10@toxicpanda.com>
Date:   Fri, 21 May 2021 09:38:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <6aabd4e1187d0ce49bad7bf7967148a86b4c56d4.1621526221.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/21/21 8:06 AM, David Sterba wrote:
> Accept literal string "cancel" as resize operation and interpret that
> as a request to cancel the running operation. If it's running, wait
> until it finishes current work and return ECANCELED.
> 
> Shrinking resize uses relocation to move the chunks away, use the
> conditional exclusive operation start and cancelation helpers.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
