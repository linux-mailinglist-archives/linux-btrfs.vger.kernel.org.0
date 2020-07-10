Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66CD21B8F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 16:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGJOyE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 10:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJOyE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 10:54:04 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE30C08C5CE
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 07:54:03 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c139so5444323qkg.12
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hkvKWQoycBQe2iin1cb/PNa7ponQ1wEkImnGXBtAtLY=;
        b=gsFrsU6nyuovGEhwWLChOwoozdvMXug94/O1N9fghUaj3ISzILjfZfiqC+SO5IvtDT
         vOtBp3aidvrajo7dB9CFKYkdzCmv0rlJhAjl42JoysepvW4cVBSOUKKZwkDTKAOI5Vxw
         1dXLqv5eeF6LFOT/YOS2gCF1LH0JTx6KdxdsmNirDQ836VTgE8ckUXSQt95AE2DVcVBp
         QdQ87LiOmGKVq5XHuhAiKVleOINTEQLJPVvPTJ7puwV+Tt7z4qSGKvFC51rdvvm6k2Uc
         QyNalDiAQQoFDd4QGjA25ylGYmbKbE/pKudQ61zSz+T5pAsUEr78Y/xvw3vgrAJxe2hJ
         xQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hkvKWQoycBQe2iin1cb/PNa7ponQ1wEkImnGXBtAtLY=;
        b=I8eoUIL6fOTPFsED3DFaMv+aozZ3sQLDA/O4AqaRUI1GxVrcNqNTqUw5M3eT/6XDZm
         SP/beqspp0GTDNhpN+6F1IwZ9I5JzzMiEBtFdfPu7MAta4fiKuKveKsmeSmWCrFMFOJB
         34aqkZHKevgIG82Q99BamQP/ELgo/MWuIyGsoytRSk3GlmmBMeBIYv8hYf6gn47mkHol
         Y6dYp5abVvn27rXO8YNNWRa7Hdq8Sj1Dey3Zl6O7lgwzkyhVROSiVAhifBTLgop9vqZg
         IwLmLoyJw//qKPJZtIcdEQV0Tyz1kbv6UXjgpkdCtKRoonp+39IsAK3+6ti0eauXsNWN
         AOvw==
X-Gm-Message-State: AOAM532Xv9KvhCroDGRxbbYXpj8WS4oOXEOhTgfAy6G0yf/lI3VjYHpA
        TTDoPKtzjXo/e+HskaLFjtuZtYXJV7pa9A==
X-Google-Smtp-Source: ABdhPJw5PxXGuqUU6CcO2WcHQZb9cM6u152O4fJATFy27YjlPPEmPLAMjJewQGI+EWbFKymTjHGBXA==
X-Received: by 2002:a37:6392:: with SMTP id x140mr63689128qkb.269.1594392842998;
        Fri, 10 Jul 2020 07:54:02 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e23sm7510736qkl.55.2020.07.10.07.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:54:01 -0700 (PDT)
Subject: Re: [PATCH] btrfs: return -EIO on error in btree_write_cache_pages
To:     sandeen@redhat.com, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200710140619.2366724-1-josef@toxicpanda.com>
 <2666ea17-def0-7a5b-7af9-646a9edf03cf@redhat.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7c6a3979-9c26-2f20-42f6-633de8f00d2b@toxicpanda.com>
Date:   Fri, 10 Jul 2020 10:54:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2666ea17-def0-7a5b-7af9-646a9edf03cf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/10/20 10:50 AM, Eric Sandeen wrote:
> On 7/10/20 9:06 AM, Josef Bacik wrote:
>> Eric reported seeing this message while running generic/475
>>
>> BTRFS: error (device dm-3) in btrfs_sync_log:3084: errno=-117 Filesystem corrupted
>>
>> This ret came from btrfs_write_marked_extents().  If we get an aborted
>> transaction via an -EIO somewhere, we'll see it in
>> btree_write_cache_pages() and return -EUCLEAN, which we spit out as
>> "Filesystem corrupted".  Except we shouldn't be returning -EUCLEAN here,
>> we need to be returning -EIO.  -EUCLEAN is reserved for actual
>> corruption, not IO errors.
> 
> Is BTRFS_FS_STATE_ERROR only set for IO errors, or could it also be
> set for an actual corruption state?

It's set when we abort the transaction, which can be either or I suppose.  At 
this point we don't have the offending error, but the transaction abort _would_ 
have it.  So if there was a corruption you would see it higher up in the logs. 
Thanks,

Josef
