Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063182113EB
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 21:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgGATxo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 15:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGATxo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jul 2020 15:53:44 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37FDC08C5C1
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jul 2020 12:53:43 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id l6so23424122qkc.6
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jul 2020 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7vLTAqIcwnnfjogUEvXwy+PbQLku3W1CJZaaSAbNmhY=;
        b=H9sso0RCfIZW0oYZDUsLV1HVhMVW1mZHft2ENg8CCTKflOo4DI+b9nhp47nFFjof4l
         xqQUhJiKMVxDLFLKsE0DG9rAL+Yd3WxfdS0j9J8MT+lsZq9Pa9WDb99nCXlFrF/C51KF
         eWNVWiwwCrDHDZYoeZkl3LOTq86KEr9ENNpQruRJv9X3w42FGNVc0+d/M/TD60WWWuAY
         98rLxY81ciX3P83u8lnpmOHmdrZelfhGs+GlQBhqHV717Xw03e7BLS9ZDRiXip8B5EZW
         Ldz3UVJdodh/8qMdaz+Mfx+8INl8IUpD8FuA1X9UqYlbu+yyeA7x0d3pJ389knKWLZY3
         RWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7vLTAqIcwnnfjogUEvXwy+PbQLku3W1CJZaaSAbNmhY=;
        b=n4+21DVcrlMS0ebahkXH/HXOb8igEnFx6eJMpdXMVmhTxCgQNKBSFiTZdqwZpuDgJt
         nZ9K4tAW0uEym1+1/VO+Wak+8tjaaj+wYWOTPsSi2UDxSAI0XNac3y8XZEVpV0biZZtX
         No3CLP5ZpPxgowHmEhkLR57Naia00iKWzwUNhPSaeFLGRqUiMTyNxSWssal5oPL7FLFG
         2K4sNKV9fk3MqnQ7gYKxpNpRD7ouewHNmWdPcnYQp2ZWn6jmR9ulw++vrWj8eoXFs6sf
         2xhIN+qGSGOFWetMwgosxS96+d2OTqumufk10S1A/kVcLHLtdwBdfk+j96dNAcQ3KN7s
         fqpg==
X-Gm-Message-State: AOAM533Q+vMlWq+cNznJ2htSrHOOZ35scgYpASXB6oxCR++bWnVB1qpf
        +p/f1O3jvdxIy+oFaV/cyPnvRA==
X-Google-Smtp-Source: ABdhPJwTRfQVxLBf1Ho8AEExQsB6GUu3clvkm+XbyCovK4bIm2uHruW70FYalRf/HgLQD4MJ1GQXLg==
X-Received: by 2002:a37:5c7:: with SMTP id 190mr26387551qkf.479.1593633222634;
        Wed, 01 Jul 2020 12:53:42 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h6sm5964255qtu.2.2020.07.01.12.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 12:53:41 -0700 (PDT)
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
To:     waxhead@dirtcellar.net, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <4adbc15c-d8ff-6132-5044-9b6117ef4f5e@dirtcellar.net>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bf383512-71fd-27b1-2e45-b8a0c8e2ba3f@toxicpanda.com>
Date:   Wed, 1 Jul 2020 15:53:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4adbc15c-d8ff-6132-5044-9b6117ef4f5e@dirtcellar.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/1/20 3:43 PM, waxhead wrote:
> 
> 
> Josef Bacik wrote:
>> One of the things that came up consistently in talking with Fedora about
>> switching to btrfs as default is that btrfs is particularly vulnerable
>> to metadata corruption.  If any of the core global roots are corrupted,
>> the fs is unmountable and fsck can't usually do anything for you without
>> some special options.
>>
>> Qu addressed this sort of with rescue=skipbg, but that's poorly named as
>> what it really does is just allow you to operate without an extent root.
>> However there are a lot of other roots, and I'd rather not have to do
>>
>> mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah
>>
>> Instead take his original idea and modify it so it just works for
>> everything.  Turn it into rescue=onlyfs, and then any major root we fail
>> to read just gets left empty and we carry on.
>>
>> Obviously if the fs roots are screwed then the user is in trouble, but
>> otherwise this makes it much easier to pull stuff off the disk without
>> needing our special rescue tools.  I tested this with my TEST_DEV that
>> had a bunch of data on it by corrupting the csum tree and then reading
>> files off the disk.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
> 
> Just an idea inspired from RAID1c3 and RAID1c3, how about introducing DUP2 
> and/or even DUP3 making multiple copies of the metadata to increase the chance 
> to recover metadata on even a single storage device?

Because this only works on HDD.  On SSD's concurrent writes will often be 
shunted to the same erase block, and if the whole erase block goes, so do all of 
your copies.  This is why we default to 'single' for SSD's.

The one thing I _do_ want to do is make better use of the backup roots.  Right 
now we always free the pinned extents once the transaction commits, which makes 
the backup roots useless as we're likely to re-use those blocks.  With Nikolay's 
patches we can now async drop pinned extents, which I've implemented here for an 
unrelated issue.  We could take that work and simply hold pinned extents for 
several transactions so that old backup roots and all of their nodes don't get 
over-written until they cycle out.  This would go a long way towards making us 
more resilient under metadata corruption conditions.  Thanks,

Josef
