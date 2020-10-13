Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC2928D076
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 16:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgJMOlf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 10:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388886AbgJMOlb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 10:41:31 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6646EC0613D0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Oct 2020 07:41:31 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w17so1883976ilg.8
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Oct 2020 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eSzTRHUBXrPVv/93C6YGiRAuPPDCdr/yrPGUH8HuEU4=;
        b=JwaXdugwSHYDwFW/k2cF8S42L4WaLQ1puYkOmGpyd/NWj1qzBJwNldCVhgqN1TTHUh
         ZnUysYPOjbDzrHOiTOLKQ1to26Z6r8MaExoC7/ptoybEL4DAY74XGLyeB7iKH2mSeiiy
         Q97OC80PghrpsOQNj3Jw1OP5gLan7GSS85wQgZEg7EboNfOS9JVrGfeCLLsTno7e6g6F
         r8Y58RxmA2b+GMKkFXbbCwQ+I9cQlY7INxAikgBZd/MFxKh28ByeEf2Y0g5GKUr/kXeK
         wjX1UZ7/bXnvUFxrT18SuiZ7W50Ac59jEity8Sp8YUkaUdR6BQkT2P3/T5l/IU7CMfnf
         sWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eSzTRHUBXrPVv/93C6YGiRAuPPDCdr/yrPGUH8HuEU4=;
        b=aDm/iHKGLN+DfKOcwcb+UegG8K/iBnodM4toxl4rpQDV9e/+NpIL7d9JMu0qebpl2H
         J/Ztq2npFJjQu9bNPgXzANLa7uEivzInVx7YsWgQZItqtdA2DMEHvDZIobrfFQv5Rk5e
         WfYbWJMImOrkD0bw5qM8+6SDpcjD39lL1eDScoordrktazdJKJIYgs1AxdDWK1i8NMIm
         kyRARlwrig4vr6gtRahPnxbE32j7h3S5BSwwtoSXpMPOAI8rg6mhYk6RY7yrvs4goxJO
         Qhn/62d04szxpJ/1IPFKJznsDGRb4URhJluLMXKSTN2ILhQHVbQKabzZUXTnwz1zI89g
         N3QQ==
X-Gm-Message-State: AOAM531FlNe1WV9WHQ4aEeG8HTKcZzZukkHlvnTWOPpRiKUrLbbhs4qC
        A9RNwVZID2xnGs7AXPR1vHCcPx0lsCI0xg==
X-Google-Smtp-Source: ABdhPJzwOArLVVUI+m2xA5pLiFK+HLOELa3rukB+JbzM7c+TO/7UXwOms6CCVdZugSISkq0Se8abPw==
X-Received: by 2002:a92:d808:: with SMTP id y8mr194939ilm.249.1602600090322;
        Tue, 13 Oct 2020 07:41:30 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1096? ([2620:10d:c091:480::1:d057])
        by smtp.gmail.com with ESMTPSA id i7sm2231610ilq.64.2020.10.13.07.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 07:41:28 -0700 (PDT)
Subject: Re: [PATCH 4/4] btrfs: do not start readahead for csum tree when
 scrubbing non-data block groups
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1602499587.git.fdmanana@suse.com>
 <fdde80f42dc3e822ab990d28d584175eb0ca222f.1602499588.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0b4b847e-2da7-94e8-7994-38ab33910319@toxicpanda.com>
Date:   Tue, 13 Oct 2020 10:41:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <fdde80f42dc3e822ab990d28d584175eb0ca222f.1602499588.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/12/20 6:55 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When scrubbing a stripe of a block group we always start readahead for the
> checksums btree and wait for it to complete, however when the blockgroup is
> not a data block group (or a mixed block group) it is a waste of time to do
> it, since there are no checksums for metadata extents in that btree.
> 
> So skip that when the block group does not have the data flag set, saving
> some time doing memory allocations, queueing a job in the readahead work
> queue, waiting for it to complete and potentially avoiding some IO as well
> (when csum tree extents are not in memory already).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
