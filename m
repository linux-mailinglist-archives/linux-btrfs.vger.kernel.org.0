Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC892158BC
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 15:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgGFNpE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 09:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbgGFNpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 09:45:04 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F00C061755
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 06:45:04 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e12so28903733qtr.9
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jul 2020 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u1x4ZBiR7rmk6/R+W9B9Xx9bUaFibbx8V13ZY8VIHEo=;
        b=kU2Kcny8AYHRo0HdPiPTq6NVQs/NjuB8xmnqhEVK61x8hAyde2nf+7MHEWzwyDM7k7
         E7vNJD2Hg9hZJJLYI3/bmYGEHfio1XnKc5VRoWMCaTD1/u5nfdUn+dO+MNumSoWb4va8
         s6bKiZEp5N+rOgCNLO/TqyOTjR6tdcLeydlK0/W7XX+TZwOvJOMP87jEhhRyHCiw9efW
         D98JDlFZM8aJ2qRZ3QXHNvi3tzCc2Li8v57TlmnGefz9krJd74mCDknYT6k2w+/vJ0Oq
         GShJuHCnqvCa1PIcpsow9JRIwUPBwv0Yroi3cllmDo+L8BKE3EfuT5zGJ3uaprGKkkhl
         iv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u1x4ZBiR7rmk6/R+W9B9Xx9bUaFibbx8V13ZY8VIHEo=;
        b=BPIKMAqUcDLL9PzoM8i4+tpgGFhSrYFa6pV0xcQczkNRIs/pdmL0dZl1orYp5toi/4
         3c1+onKO1oEk+OViRJidgRwT30EOmFRFyXIDNkLNgoPrIr0opXSxYu7WSFtW9Pru3C8y
         VpiArbByk/SdNqkcOlnkxDEVD4TtZo5sOfnj+QiBuQ041Fm+KQGW5xnUICJg+b1uqkC1
         mhgZ/yqsCAkO5ka5HaQtqDEe9UYoPrXT8bcLa4ugOEZKHBB19PN0SJ8X9VskdQOrqASg
         tnoP5Wk6SyyDZ6SI40X9jPQMTf52g36otAtQ6FCATpqe1j8XYzCTIg9t665Y8HlfYn3A
         KgrQ==
X-Gm-Message-State: AOAM532NrZTLD+7qZrK6Hp+JMwfBpo5XZbHSnWLeuIzmHQAnRllN4GPS
        X0EyJROLbnRGWK9wTbJPI5fwSg==
X-Google-Smtp-Source: ABdhPJyGnemgjz75QRiS55mWTanaCqZyE8Y7kJmJk4ABvI9zS0yHnRfECrTi3WxBJfMCko9kaabZMg==
X-Received: by 2002:ac8:197b:: with SMTP id g56mr28559732qtk.105.1594043103515;
        Mon, 06 Jul 2020 06:45:03 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x3sm20905694qkd.62.2020.07.06.06.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 06:45:02 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] btrfs: space-info: Don't allow signal to
 interrupt ticket waiting
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Hans van Kranenburg <hans@knorrie.org>
References: <20200706074435.52356-1-wqu@suse.com>
 <20200706074435.52356-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9ca1e526-6149-c5f2-402f-6e7331ac02ea@toxicpanda.com>
Date:   Mon, 6 Jul 2020 09:45:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706074435.52356-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/6/20 3:44 AM, Qu Wenruo wrote:
> [BUG]
> When balance receive a fatal signal, it can make the fs to read-only
> mode if the timing is unlucky enough:
> 
>    BTRFS info (device xvdb): balance: start -d -m -s
>    BTRFS info (device xvdb): relocating block group 73001861120 flags metadata
>    BTRFS info (device xvdb): found 12236 extents, stage: move data extents
>    BTRFS info (device xvdb): relocating block group 71928119296 flags data
>    BTRFS info (device xvdb): found 3 extents, stage: move data extents
>    BTRFS info (device xvdb): found 3 extents, stage: update data pointers
>    BTRFS info (device xvdb): relocating block group 60922265600 flags metadata
>    BTRFS: error (device xvdb) in btrfs_drop_snapshot:5505: errno=-4 unknown
>    BTRFS info (device xvdb): forced readonly
>    BTRFS info (device xvdb): balance: ended with status: -4
> 
> [CAUSE]
> This is caused by the fact that btrfs ticketing space system can be
> interrupted, and cause all kind of -EINTR returned to various critical
> section, where we never thought of -EINTR at all.
> 
> Even for things like btrfs_start_transaction() can be affected by
> signal:
>   btrfs_start_transaction()
>   |- start_transaction(flush = FLUSH_ALL)
>      |- btrfs_block_rsv_add()
>         |- btrfs_reserve_metadata_bytes()
>            |- __reserve_metadata_bytes()
>               |- handle_reserve_ticket()
>                  |- wait_reserve_ticket()
>                     |- prepare_to_wait_event(TASK_KILLABLE)
>                     |- ticket->error = -EINTR;
> 
> And all related callers get -EINTR error.
> 
> In fact, there are really very limited call sites can really handle that
> -EINTR properly, above btrfs_drop_snapshot() is one case.
> 
> [FIX]
> Things like metadata allocation is really a critical section for btrfs,
> we don't really want it to be that killable by some impatient users.
> 
> In fact, for really long duration calls, it should have their own checks
> on signal, like balance, reflink, generic fiemap calls.
> 
> So this patch will make ticket waiting uninterruptible, relying on each
> long duration calls to handle their signals more properly.
> 

Nope, everybody that calls start_transaction() should be able to handle -EINTR, 
so we need to find those callsites and fix them, not make it so we hang the box 
because we don't like fixing error paths.  Thanks,

Josef
