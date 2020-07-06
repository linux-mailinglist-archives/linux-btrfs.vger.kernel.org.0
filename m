Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E9A215985
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgGFOd7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 10:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbgGFOd6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 10:33:58 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984D6C061755
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 07:33:58 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c30so31065075qka.10
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jul 2020 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PgHneDBsdBphL6y5tT/79k6peho7+vJZ0SATmArvifU=;
        b=LEL/UbH2g9nApiR3LHRPOck21jJyD4hOCpfZDAorBIxj3G6fUESqWAK8tP7JFt1qGT
         nj2MJPc+VvMYPJFQ+IkkP8B84PsS6IW43SZMR4IRRGyf057Q9H2L2+ACsFXBpdcYitYi
         E8X0lYyX6pg/MpMz0895/9fh2ztt5bvWF3K7nrDCTR8o3v+fu3b7SVHpjmhbw9tPGfTA
         6R3oQcnn0vRa29esl4ivwf7DkASVL+b4RtlXNIGvOkdggCm2WqMqUjORC7nPcYcbWT50
         SX478sVBsVt6ft4qSgVo05QEKk2nFDBoWw9pvh1OUea4fxdzPgZzRcRpme1ln1fWjmqb
         fElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PgHneDBsdBphL6y5tT/79k6peho7+vJZ0SATmArvifU=;
        b=nLJKqVQsZfMrIHzXmCkG4mB/5dBU6j8lf/UJUsJHIXSlMR1Sxuo7hr+m19DG2VP5H7
         n3gVTMy3W8aEJy1Bi0YXJDtLlIFT0F8mTSxm4u74E7fFBDvVH+jNrgeDpyh9TEL7PjNz
         vc4OORw62ceVusULaoT/zyqGtPgJEBCNjFA4v8zxzLdvx1yKA7DSGBtLxDR6R9d7El56
         FU/Lx3MAFZ8NSdAuaCzuBx9rDyeex8ExVnc7IqV2u8aWNh6vrQyRTb+tI40xeBwbHRqy
         OQzylG85j+h2pLHLFCNtO5Ym+YwsR45Nw4E9rVGD44WNqoZiChv+JHzsaHMgjWcFhsmO
         AGsw==
X-Gm-Message-State: AOAM533aHZsq4DnXeQl+cNuvr/FSjPJ4E5ed5QifkyM8B1gbxMfjjMqi
        Vxhlx1OUd63wQV2IkK6TtP8F9g==
X-Google-Smtp-Source: ABdhPJzKdFpxtI4S2ywoPrWyOCNCqcZ8Ndub8ES7NrRcD/XDAgS5/VZipcYMoC4f+WNz97vIcytb/w==
X-Received: by 2002:a37:44c4:: with SMTP id r187mr38077867qka.93.1594046037634;
        Mon, 06 Jul 2020 07:33:57 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a140sm20298194qkc.16.2020.07.06.07.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 07:33:57 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] btrfs: space-info: Don't allow signal to
 interrupt ticket waiting
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Hans van Kranenburg <hans@knorrie.org>
References: <20200706074435.52356-1-wqu@suse.com>
 <20200706074435.52356-3-wqu@suse.com>
 <9ca1e526-6149-c5f2-402f-6e7331ac02ea@toxicpanda.com>
 <8f742315-6f47-771e-234e-98d7428c2f5b@suse.com>
 <d01c2c4a-0c3e-c599-fd64-715c000ad31f@toxicpanda.com>
 <13f7d3b6-e555-38cc-b73c-817bab70924c@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9cc6e3ff-ef7f-0948-f55c-b940364cf67f@toxicpanda.com>
Date:   Mon, 6 Jul 2020 10:33:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <13f7d3b6-e555-38cc-b73c-817bab70924c@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/6/20 10:05 AM, Qu Wenruo wrote:
> 
> 
> On 2020/7/6 下午9:53, Josef Bacik wrote:
>> On 7/6/20 9:50 AM, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/7/6 下午9:45, Josef Bacik wrote:
>>>> On 7/6/20 3:44 AM, Qu Wenruo wrote:
>>>>> [BUG]
>>>>> When balance receive a fatal signal, it can make the fs to read-only
>>>>> mode if the timing is unlucky enough:
>>>>>
>>>>>      BTRFS info (device xvdb): balance: start -d -m -s
>>>>>      BTRFS info (device xvdb): relocating block group 73001861120 flags
>>>>> metadata
>>>>>      BTRFS info (device xvdb): found 12236 extents, stage: move data
>>>>> extents
>>>>>      BTRFS info (device xvdb): relocating block group 71928119296 flags
>>>>> data
>>>>>      BTRFS info (device xvdb): found 3 extents, stage: move data extents
>>>>>      BTRFS info (device xvdb): found 3 extents, stage: update data
>>>>> pointers
>>>>>      BTRFS info (device xvdb): relocating block group 60922265600 flags
>>>>> metadata
>>>>>      BTRFS: error (device xvdb) in btrfs_drop_snapshot:5505: errno=-4
>>>>> unknown
>>>>>      BTRFS info (device xvdb): forced readonly
>>>>>      BTRFS info (device xvdb): balance: ended with status: -4
>>>>>
>>>>> [CAUSE]
>>>>> This is caused by the fact that btrfs ticketing space system can be
>>>>> interrupted, and cause all kind of -EINTR returned to various critical
>>>>> section, where we never thought of -EINTR at all.
>>>>>
>>>>> Even for things like btrfs_start_transaction() can be affected by
>>>>> signal:
>>>>>     btrfs_start_transaction()
>>>>>     |- start_transaction(flush = FLUSH_ALL)
>>>>>        |- btrfs_block_rsv_add()
>>>>>           |- btrfs_reserve_metadata_bytes()
>>>>>              |- __reserve_metadata_bytes()
>>>>>                 |- handle_reserve_ticket()
>>>>>                    |- wait_reserve_ticket()
>>>>>                       |- prepare_to_wait_event(TASK_KILLABLE)
>>>>>                       |- ticket->error = -EINTR;
>>>>>
>>>>> And all related callers get -EINTR error.
>>>>>
>>>>> In fact, there are really very limited call sites can really handle
>>>>> that
>>>>> -EINTR properly, above btrfs_drop_snapshot() is one case.
>>>>>
>>>>> [FIX]
>>>>> Things like metadata allocation is really a critical section for btrfs,
>>>>> we don't really want it to be that killable by some impatient users.
>>>>>
>>>>> In fact, for really long duration calls, it should have their own
>>>>> checks
>>>>> on signal, like balance, reflink, generic fiemap calls.
>>>>>
>>>>> So this patch will make ticket waiting uninterruptible, relying on each
>>>>> long duration calls to handle their signals more properly.
>>>>>
>>>>
>>>> Nope, everybody that calls start_transaction() should be able to handle
>>>> -EINTR, so we need to find those callsites and fix them, not make it so
>>>> we hang the box because we don't like fixing error paths.  Thanks,
>>>
>>> Then we also need to handle btrfs_delalloc_reserve_metadata(),
>>> btrfs_block_rsv_refill(), btrfs_use_block_rsv(), btrfs_block_rsv_add().
>>>
>>
>> This only needs to be handled for FLUSH_ALL and FLUSH_STEAL.  Anybody
>> doing btrfs_start_transaction() should be able to fail with -EINTR,
>> because they should be close to the syscall path.  Balance needs to be
>> fixed to deal with it, and I assume there might be a few other places,
>> but by-in-large none of these places should flip read only.  Thanks,
> 
> There are already ones existing, for btrfs_drop_snapshot().
> 
> This is mostly caused by btrfs_delalloc_reserve_metadata(), which always
> use FLUSH_ALL unless there is a running trans or its space cache inode.
> 
> But still, for a lot of relocation code, we don't really want to bother
> the EINTR and just want uninterruptible at least for now.
> 
> Any idea for that?
> Or just rework how we handle errors in a lot of places?
> 
> It doesn't look correct for such a low level mechanism to return -EINTR
> while most of callers doesn't really want to bother.
> 

That's the point, most callers shouldn't have to, because most callers shouldn't 
be far enough into their operations that -EINTR causes problems.

We should probably just change btrfs_drop_snapshot to use join, and then have it 
do any space reservation it needs outside of the trans handle.  The other option 
is a FLUSH_ALL_UNKILLABLE.  Thanks,

Josef
