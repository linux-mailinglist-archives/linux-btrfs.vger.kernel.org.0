Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8F925B305
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 19:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIBRhV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 13:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBRhU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 13:37:20 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979D0C061244
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 10:37:19 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id n18so4228332qtw.0
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DdyuErOr1LPX8kpAwGgdR5vrqQLelplF1kJsiblxf6s=;
        b=Iew982ddijyQXoLrKIrCCa8WoXEM7EmzNkgtMUHUttemY3Ce4ZpxZ9gbYULzuvNvQZ
         /xYKhGCRpNXCEpF/Tcawq3Eq5wXg5QUIDLvOPx/8e26+ReEgyrApcQZMgrjZNzae77SB
         BqwjN28TV19mzz18iCQUTjbav2GlurV2MJ9y2rzZDvvrxcPrkbz8/So+sxqZpwY5Af4f
         /leawcecSOL1WTkXeP4OH1AmILE9ZxnzVzR+Pb8AurBSO1halffE3hQyDL1+hui5bCkE
         KmXOlofDl5+hMIzOJK8BShVkP1/M71p+TySbGUK0oxpFy8R+9atYGIPVySO+Jq7T/SHA
         DLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DdyuErOr1LPX8kpAwGgdR5vrqQLelplF1kJsiblxf6s=;
        b=lymya8e2Wdy2T/qvYwj0vLg2yHqmF5jEaJY6/NdejhF6WbCEogmKpF4U8WqLzZ0n/B
         GsO97QA/O5A0xJtyso8iXkorqYv19JxKsUx2phI/FlHe2gyHaVgOSWh7F6I4hNB8KOIX
         S8RqAS4EY8SlPfUlOeZD5QhljZM/cu1jPMnozItMwBq18LEHzJZr83a8cDqHFw9e+L+O
         hYUoUavtYTeyWmHD4Oo380k7bH/RRdls5przvfya3EwM97701mDx2tUunZ8SHih6Ng8M
         9vtFy4dUrkjzSIm5APWwpEgKuX88Pfp0v3HodRk7XJ/c6ifAIkMFFahoNQ4ZQ8p8UlCL
         atVg==
X-Gm-Message-State: AOAM5300PTGw/dEvUlvL3vTbL5WA0HXnDAgxx/KxDrbbauo7J/ub9mBr
        IKw24fJV+lJTqftxNKIrzUUIZA==
X-Google-Smtp-Source: ABdhPJy+H5b+bgU4ifOkRLkDqh7XaQE1g2OCreaX8Z1R/HhYB/LVUnvganQrIhTtHrpF51ZzAGwtnQ==
X-Received: by 2002:ac8:4806:: with SMTP id g6mr7818770qtq.380.1599068238650;
        Wed, 02 Sep 2020 10:37:18 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g18sm34373qtu.69.2020.09.02.10.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 10:37:17 -0700 (PDT)
Subject: Re: About the state of Btrfs RAID 5/6
To:     Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Robbie Ko <robbieko@synology.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <CAEg-Je8OsZjWU_ZyLJHrbOJb=_C56MOmJ5w8UUbzz3JNuAi5Ow@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b9ceb790-e376-69b8-0648-56c9a026b40c@toxicpanda.com>
Date:   Wed, 2 Sep 2020 13:37:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je8OsZjWU_ZyLJHrbOJb=_C56MOmJ5w8UUbzz3JNuAi5Ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/2/20 11:10 AM, Neal Gompa wrote:
> Hey all,
> 
> It keeps coming up over and over: "Btrfs RAID 5/6 is bad, therefore
> Btrfs is bad". I know in practice that most people don't use the
> raid56 modes for various reasons that are unrelated to this, but it's
> frustrating and annoying that it keeps coming up.
> 
> I know that Zygo recently posted about how to use RAID 5/6
> successfully(-ish)[1], and previously David Sterba tried to work on
> this[2]. The result of that was the new raid1cX modes, but we still
> have the raid56 modes.
> 
> What's holding back Btrfs raid56 from having its status[3] updated
> from "Unstable" to "mostly OK" or even "OK"? I know that Synology NAS
> devices use Btrfs and support raid56 using mdraid, why not fix the
> native RAID features so that layer can be dropped?
> 

Honestly there's just a lot of things that need to be looked at right now.  Poor 
Zygo is waiting on the delayed refs flushing work I did months ago because I 
still haven't gotten back to fixing relocation.

At the moment my core priority is getting all the normal parts of the file 
system working properly, and I've got probably 18 months of hell left before I 
feel like I'll be able to look up and address the multi-disk aspect of btrfs. 
RAID0/1/cX modes all work well and are well understood, and that feels "good 
enough" to me for right now.  I know Johannes is working on something magical, 
but IDK what it is or how far out it is.  Thanks,

Josef
