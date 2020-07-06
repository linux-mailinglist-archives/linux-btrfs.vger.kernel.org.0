Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EFD2158D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 15:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgGFNxW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 09:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbgGFNxV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 09:53:21 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8332C061755
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 06:53:21 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c139so34729070qkg.12
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jul 2020 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rfqYaBGxoCB2bweAlpJNO2CPHIDlyNHnv9GQtPKVRGs=;
        b=Gb+oi4forXoFI5WseLOswTBB+bK4Zq5ySGYqMCbeugHnH3k50cXJ2sj3rgSJMQ31yr
         PwGMtUbU7jC6/4A/39BTXF4GX76O/e2tI+nXwk+Rz7YizvsT6w7aXeiDJajNOL3Z7hU+
         uSItaXwc4+ZwqVJQdDRHh5IG8ypX2lnoZOu+y/PIxvkeu2yUxqKPMeCMGeOuDClbVubZ
         f65i6FYnzzv/AOh/DrX73jRHFMuxPlCGdggk9IPn/rPVN+Yerb4oNOeLC/6i6k46HoND
         kYdGL6U240fR1Qb00NhKPTjc8ZWFchCABnkGK6u2gEQaL1T2dzpVzlX9sIczO+rAi2px
         cqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rfqYaBGxoCB2bweAlpJNO2CPHIDlyNHnv9GQtPKVRGs=;
        b=OYOYHrZOitDfRTZnyGTqWIXSHCV1+/EMEhcSBiac0utUPolN3jY/nm5oF3EcmOaGIc
         a4gC0v9iMUf2g8y3dYTLq6X3H7lmXBKjZe52vXVtjoHGix3SRHbVxFRQYhpHgLMzlYj6
         xgeneJWuBDP1Bv1EPJVBeKOaL1udcjoqedMUxyGhL84G41mFuvswrR9DRjsLFft20ZIf
         sGvuMz1e4IeNM1coDIxJxDYMUoJi4P5FwLVLMosCPcHNA/bL9gl7Ck8hDKBhTRYTRASz
         YEngEWaB2stgoBcAz7jHGnrmusmRiOFXLlNZLQzDmTl9RXIKKVnFPrFOgaSbd2L+BMy2
         TKcQ==
X-Gm-Message-State: AOAM533mIEqkdwzOtlbwP0skItpwpbmz3C3W1nLi9birR6B09GvrIo+0
        kW82/eYK5vpLxj0jmD7Om8Hg3HexbaU3iQ==
X-Google-Smtp-Source: ABdhPJxK4vFBqNdGMqBaSbIl8QbXOebUCwk4KSaBaMk+56e9jPpniND7rA+D9lsQAgwF5UdS/k5w2g==
X-Received: by 2002:a37:6449:: with SMTP id y70mr47818898qkb.435.1594043599747;
        Mon, 06 Jul 2020 06:53:19 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y22sm16288351qky.84.2020.07.06.06.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 06:53:19 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] btrfs: space-info: Don't allow signal to
 interrupt ticket waiting
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Hans van Kranenburg <hans@knorrie.org>
References: <20200706074435.52356-1-wqu@suse.com>
 <20200706074435.52356-3-wqu@suse.com>
 <9ca1e526-6149-c5f2-402f-6e7331ac02ea@toxicpanda.com>
 <8f742315-6f47-771e-234e-98d7428c2f5b@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d01c2c4a-0c3e-c599-fd64-715c000ad31f@toxicpanda.com>
Date:   Mon, 6 Jul 2020 09:53:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8f742315-6f47-771e-234e-98d7428c2f5b@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/6/20 9:50 AM, Qu Wenruo wrote:
> 
> 
> On 2020/7/6 下午9:45, Josef Bacik wrote:
>> On 7/6/20 3:44 AM, Qu Wenruo wrote:
>>> [BUG]
>>> When balance receive a fatal signal, it can make the fs to read-only
>>> mode if the timing is unlucky enough:
>>>
>>>     BTRFS info (device xvdb): balance: start -d -m -s
>>>     BTRFS info (device xvdb): relocating block group 73001861120 flags
>>> metadata
>>>     BTRFS info (device xvdb): found 12236 extents, stage: move data
>>> extents
>>>     BTRFS info (device xvdb): relocating block group 71928119296 flags
>>> data
>>>     BTRFS info (device xvdb): found 3 extents, stage: move data extents
>>>     BTRFS info (device xvdb): found 3 extents, stage: update data pointers
>>>     BTRFS info (device xvdb): relocating block group 60922265600 flags
>>> metadata
>>>     BTRFS: error (device xvdb) in btrfs_drop_snapshot:5505: errno=-4
>>> unknown
>>>     BTRFS info (device xvdb): forced readonly
>>>     BTRFS info (device xvdb): balance: ended with status: -4
>>>
>>> [CAUSE]
>>> This is caused by the fact that btrfs ticketing space system can be
>>> interrupted, and cause all kind of -EINTR returned to various critical
>>> section, where we never thought of -EINTR at all.
>>>
>>> Even for things like btrfs_start_transaction() can be affected by
>>> signal:
>>>    btrfs_start_transaction()
>>>    |- start_transaction(flush = FLUSH_ALL)
>>>       |- btrfs_block_rsv_add()
>>>          |- btrfs_reserve_metadata_bytes()
>>>             |- __reserve_metadata_bytes()
>>>                |- handle_reserve_ticket()
>>>                   |- wait_reserve_ticket()
>>>                      |- prepare_to_wait_event(TASK_KILLABLE)
>>>                      |- ticket->error = -EINTR;
>>>
>>> And all related callers get -EINTR error.
>>>
>>> In fact, there are really very limited call sites can really handle that
>>> -EINTR properly, above btrfs_drop_snapshot() is one case.
>>>
>>> [FIX]
>>> Things like metadata allocation is really a critical section for btrfs,
>>> we don't really want it to be that killable by some impatient users.
>>>
>>> In fact, for really long duration calls, it should have their own checks
>>> on signal, like balance, reflink, generic fiemap calls.
>>>
>>> So this patch will make ticket waiting uninterruptible, relying on each
>>> long duration calls to handle their signals more properly.
>>>
>>
>> Nope, everybody that calls start_transaction() should be able to handle
>> -EINTR, so we need to find those callsites and fix them, not make it so
>> we hang the box because we don't like fixing error paths.  Thanks,
> 
> Then we also need to handle btrfs_delalloc_reserve_metadata(),
> btrfs_block_rsv_refill(), btrfs_use_block_rsv(), btrfs_block_rsv_add().
> 

This only needs to be handled for FLUSH_ALL and FLUSH_STEAL.  Anybody doing 
btrfs_start_transaction() should be able to fail with -EINTR, because they 
should be close to the syscall path.  Balance needs to be fixed to deal with it, 
and I assume there might be a few other places, but by-in-large none of these 
places should flip read only.  Thanks,

Josef
