Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A569217218
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgGGP2r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgGGP2g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:28:36 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840DDC061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:28:36 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o38so32039528qtf.6
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fvt5R9QdWkx05IRlWb/Nz5DOhpQ8TVTbySCd9GskC5s=;
        b=mh4dnS/7VZUwv6DtemvD7R3REROk3/Bnsci/kh5sRAY6hEJk0ufb7obnJXFUkcrgT0
         AZqCeMnaf+3Y1Rq8AQ8ZxvFPoOCi5/jwWGSefiSgnEYrEcOL6z82JLwevHnoRsLw0Gib
         IBjP5MS/S/YHwB/FJ7oydWjMElWRDTOeY8nP+L4W6AcvUOnmiu/Llk+LDVHiT7ISnt8y
         sjZn0Ag4tYlRyf3t/W3Pl318gdUgaCJocm3uJMC3ww/OG0xCWDM02u05BW+oFP7vclVG
         OgYpuChm7INhbUiVUuCHt/sRDRSXBkn9wAkGOz0GjiBNOMoY6UOnb9PIZy7PjO7vRBLi
         D3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fvt5R9QdWkx05IRlWb/Nz5DOhpQ8TVTbySCd9GskC5s=;
        b=TBT6N4f8Imr4n5qLpGeut9Iw/BvX0INnOXtJKyQg7XcCXY4YmtSexrkSYBcNwuyYpU
         L+BBzNIxYh5yeJDObRlQy+bWKetrAG4nZ26Lc/5cpkHAH6qG++jHTW6TUvtpJTIGnTiP
         ShEjoFQedlLHv/OEjOgN4i+6a/XjPqQlgnoI6yps8zcMbgpYa3rNK+5G3Q0bh3Ouybh/
         rSbdUOj55hxyDDwquYvhDohr/melOl7PK4KMVci8iizEeb5m4obTHlRp65ukEF/CL11T
         UN1nnbgToFzbOR5/7/kG0RJuy08iZwwDQgTRNSMUWMYpC59R2f2x1WLb53K2Yr9OBTZx
         kz6A==
X-Gm-Message-State: AOAM532BxcrFXPzZimwZNA354gzYUoDoI0luHRmwL7lOSXTG/M4cxUCb
        oyjGG5JNxbI35tMNIKr03ZpveQ==
X-Google-Smtp-Source: ABdhPJyQPIBwboaY3dFWXcac5eYfLP3ZV41gPgZ8rOzYSvk6lgNTxh/5yU0m5A2tth+xLCQ5tXkrNA==
X-Received: by 2002:ac8:7284:: with SMTP id v4mr56344963qto.267.1594135715494;
        Tue, 07 Jul 2020 08:28:35 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r185sm24888457qkb.39.2020.07.07.08.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 08:28:34 -0700 (PDT)
Subject: Re: [PATCH 00/23] Change data reservations to use the ticketing infra
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200630135921.745612-1-josef@toxicpanda.com>
 <20200703163028.GG27795@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f44431f1-52ea-93ac-0cd0-8db9ae6500e4@toxicpanda.com>
Date:   Tue, 7 Jul 2020 11:28:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200703163028.GG27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/3/20 12:30 PM, David Sterba wrote:
> On Tue, Jun 30, 2020 at 09:58:58AM -0400, Josef Bacik wrote:
>> We've had two different things in place to reserve data and metadata space,
>> because generally speaking data is much simpler.  However the data reservations
>> still suffered from the same issues that plagued metadata reservations, you
>> could get multiple tasks racing in to get reservations.  This causes problems
>> with cases like write/delete loops where we should be able to fill up the fs,
>> delete everything, and go again.  You would sometimes race with a flusher that's
>> trying to unpin the free space, take it's reservations, and then it would fail.
>>
>> Fix this by moving the data reservations under the metadata ticketing
>> infrastructure.  This gets rid of that problem, and simplifies our enospc code
>> more by consolidating it into a single path.  Thanks,
> 
> I created a for-next-20200703 snapshot with this branch included, and it
> went up to generic/102 and got stuck due to softlockups. This could mean
> the machine is overloaded but it usually recovers from that, while not
> in this case as it took more than 7 hours before I killed the VM.
> 
> There is the dio-iomap so the patchsets could interact in some way, I'll
> do more tests next week, this is an early warning that something might
> be going on.

Softlockup in __slab_alloc, I think we were just the victim here.  Thanks,

Josef
