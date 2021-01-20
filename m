Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3322FD4F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 17:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390583AbhATQHV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 11:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391219AbhATQD1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 11:03:27 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350F2C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 08:02:45 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id d11so11099337qvo.11
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 08:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ell2lU24ZI8YAbl5enSwoogFVT4jPB2cMp37P6LOmj4=;
        b=gX0aeJLqUMtCgL4k23FgKjkoUUjHHk+SQDTr4XacHOvCaX2g8I5bi1tf9t9MAO9mCK
         W34lQuhpHD5EoV1ksMB1xcwP8e9EJhZNONp8i3dgA3KkpLOe6P7SgEyoyuEjQkrhLSoM
         xXvbcrdCV8keBveIGRqi/1W4NAuv5dbTG+r27R3tHcOpddjjBHQ1ebWAeglg2PkodUrp
         eMiVv70lLnZawJZJDNWwsRuPp8/S9JxqbeyLUlnqykH7RoLGJ2OYj3XpfjeP18HwcWg1
         9j2YrRqHCONV94OJGzIOFk/dr+XxwlSAN0caGMmZA7pVXZdKS/gfg9HWNFbOmaOB22Um
         EXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ell2lU24ZI8YAbl5enSwoogFVT4jPB2cMp37P6LOmj4=;
        b=MNgM6C6KhA9LyJwSopaNyjsUqABmEigL+Fz1DRHv5HxXCWDTSTkWCWRDpQ/7MoNDU3
         kJe3AdiAmaJ7/uO1OvCmsRsXuwWQtnRCNlioEV8wHV2LMleNzCwS4pUrfZzqQxrx0TDD
         2/TU6aGsbbLlV25JQWuczSZA+Qc4SaLq4gRb/iQgeZlWYODVTmyH0i+U4sZKoSiY/Hyo
         YtfXLRKS9dcaA0ZbAyCkk7gZfBmXHAJD+EqZND6xbm9KMnv8j2BXDV4WzQfrBQtChlAY
         Y2fO9gFyyAr1ThlMuVGgRlw65pWOSt17yjz/wUvEYneQJM8aDgSBQBVJCtsJjrrDL0ug
         ooVA==
X-Gm-Message-State: AOAM5339IBg1maN96rE4niku9sxiY73mJfjuAl+qVSZrLc/jkszqSxXR
        EeXq24ZkBRyVAcEJsXQ+zrl7Kw==
X-Google-Smtp-Source: ABdhPJwDTsREiaTZLXTTbqueuQq18lYHoof/WBMkJrquIvrer5rN0vN89f8P0xaurdT5CVOw57bXyw==
X-Received: by 2002:ad4:5a53:: with SMTP id ej19mr10157146qvb.61.1611158564385;
        Wed, 20 Jan 2021 08:02:44 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x2sm369659qkx.5.2021.01.20.08.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 08:02:42 -0800 (PST)
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20210117185435.36263-1-kreijack@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
Date:   Wed, 20 Jan 2021 11:02:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210117185435.36263-1-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/17/21 1:54 PM, Goffredo Baroncelli wrote:
> 
> Hi all,
> 
> This is an RFC; I wrote this patch because I find the idea interesting
> even though it adds more complication to the chunk allocator.
> 
> The basic idea is to store the metadata chunk in the fasters disks.
> The fasters disk are marked by the "preferred_metadata" flag.
> 
> BTRFS when allocate a new metadata/system chunk, selects the
> "preferred_metadata" disks, otherwise it selectes the non
> "preferred_metadata" disks. The intial patch allowed to use the other
> kind of disk in case a set is full.
> 
> This patches set is based on v5.11-rc2.
> 
> For now, the only user of this patch that I am aware is Zygo.
> However he asked to further constraint the allocation: i.e. avoid to
> allocated metadata on a not "preferred_metadata"
> disk. So I extended the patch adding 4 modes to operate.
> 
> This is enabled passing the option "preferred_metadata=<mode>" at
> mount time.
> 

I'll echo Zygo's hatred for mount options.  The more complicated policy 
decisions belong in properties and sysfs knobs, not mount options.

And then for the properties themselves, presumably we'll want to add other FS 
wide properties in the future.  I'm not against adding new actual keys and items 
to the tree itself, but is there a way we could use our existing property 
infrastructure that we use for compression, and simply store the xattrs in the 
tree root?  It looks like we're just toggling a policy decision, and we don't 
actually need the other properties in the item you've created, so why not just a 
btrfs.preferred_metadata property with the value stored in it, dropped into the 
tree_root so it can be read on mount?  Thanks,

Josef
