Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498D2693073
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Feb 2023 12:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBKLnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Feb 2023 06:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjBKLnB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Feb 2023 06:43:01 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4D84DE34
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 03:42:52 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id lu11so21770605ejb.3
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 03:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRkcgAykuIyW+JLUwdv/kp0D+JH9VDDTJMsq4ABr4cc=;
        b=K3Lh88DztiiFoQIHhSmamEHTXzaHF0ejquEDgG0htNCCMY+uy7+tf/yWKBXg+NkUm1
         A8/csLyd93G5t5dLxQIEtoyrc/dDbnaUaIpYuLjiIE2zNgsCR4+6UPq1uqOPj7uFSL5t
         DVBgZmCEGzvyuuhOla6H3tNVdoRR3sKCNrtxG0sqc1F4atbmRl1sPSz3O8MuY/pmxjQS
         Y3E3El0AriCunUsCBHk+ekCfgsSlVh5i7FfUJjNv0CSfXdmaw55+XX/yn0dHImdJg6nq
         cgGU39GpwefRCsGCtPw95JVqt6h9Hmgjx0NfxDybska4JCs/w8Mi/jJn3pLSECMXrE7v
         Foig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRkcgAykuIyW+JLUwdv/kp0D+JH9VDDTJMsq4ABr4cc=;
        b=Kf9xYqaMPc6WpT88CGsGSc61vWKE/ZI/S/Ik2eLfIL6KcBOTiXNWxR454gSD0vrk5f
         fH9PuhqzNGKpdzw5lg8bG86is7FLImqdj0ySNkkDrTh3HJ2LnaN+02cZNdU7BaBJeL+R
         SmSmu+cbhwfDjhPfwCIKxvq+747FBLGkphRClGJ6amlJNgCAqw6mtLJTq+5WAD3DB2Tr
         RQMkQiteupqnTE36R8nGwIPEyrjtrpE/muupLVx5W3IF/KHcfKO9NIboBOZj343kofMR
         yoqNqDzxmaW/IPWYNBLLKYdPPtUmmeX6nONQeFX6WHm/FcyyGqqHn5mPNsVgYaSVeE9H
         d/BA==
X-Gm-Message-State: AO0yUKX6QmAww5fazGxAXKjaXUJBfpKYL1HkXrZEDdKjsVq6EXykpRLs
        KBjNd9DYBMTVj1cIFnDPyQeaFgpSaD0=
X-Google-Smtp-Source: AK7set/mDspRlsOHwu/iiQG/0n6p2wGYJHYyaxsXWxEBviDlnmdg3JqGO18f4/NgbsLTxm7W5cjYBg==
X-Received: by 2002:a17:906:748d:b0:878:6f47:5f72 with SMTP id e13-20020a170906748d00b008786f475f72mr17018700ejl.1.1676115771293;
        Sat, 11 Feb 2023 03:42:51 -0800 (PST)
Received: from ?IPV6:2a00:1370:8182:1876:311d:9354:9fb6:a107? ([2a00:1370:8182:1876:311d:9354:9fb6:a107])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709064e0f00b008af424d4d75sm3355785eju.194.2023.02.11.03.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 03:42:50 -0800 (PST)
Message-ID: <c7c1eda1-d0a9-c924-2900-9158c34fc016@gmail.com>
Date:   Sat, 11 Feb 2023 14:42:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Never balance metadata?
Content-Language: en-US
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     waxhead@dirtcellar.net
References: <ad4de975-3d5f-4dbb-45a5-795626c53c61@dirtcellar.net>
 <1755726.VLH7GnMWUR@lichtvoll.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <1755726.VLH7GnMWUR@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11.02.2023 11:38, Martin Steigerwald wrote:
> waxhead - 11.02.23, 02:36:26 CET:
>> I have read several places, including on this mailing list that
>> metadata is not supposed to be balanced unless converting between
>> profiles.
>>
>> Interestingly enough there is nothing mentioned about this in the
>> docs... https://btrfs.readthedocs.io/en/latest/btrfs-balance.html
>>
>> Should one still NOT balance metadata? If so - please update the docs
>> with a explanation to why one should not do that.
> 
> If that is still the case, it may also be good to by default omit
> metadata on a balance without parameters.
> 
> A long, long time ago I experienced a much longer boot time after a
> balance, I decided to refrain from balancing my BTRFS file systems.
> Especially as long as there is still unallocated space on them. Cause as
> long as BTRFS can still allocate a chunk, I thought that is fine. I
> thought I would be getting a faster system, but it was much much slower.
> That was on a SATA SSD.
> 
> An additional reason for not, or at least not regularly balancing for me
> is avoiding needless writes to flash storage like SATA or NVMe SSDs.
> Usually they can take it, but why age them more than needed?
> 
> Maybe all or some of this is not accurate anymore and one should balance
> BTRFS regularly like default in SUSE distributions, maybe regular
> balancing even reduces writes on other occasions, however I never fully
> understood the performance impact of a regular balance. However in a

Balancing creates larger free space pool which allows large writes which 
is faster and requires less metadata. If every second 4K block in each 
chunk is free, you have exactly 50% free space like if half of chunks 
are free. But in the former case each write will be split into 4K 
pieces, each 4K becomes separate extent and needs additional metadata. 
Whether you will actually observe impact depends heavily on your workload.

Secondary (btrfs specific) consideration is that balancing creates free 
space that can be used both for data and metadata, while each chunk is 
(normally) dedicated to either one. So if your metadata is full you 
/may/ get more space for metadata by compacting data chunks (except 
balancing needs more metadata, at least temporary, an so my fail under 
these conditions).

This is also the reason why balancing metadata is not recommended today. 
Fragmented metadata chunks do not have as much impact on performance, 
but space that is freed by balancing may be allocated to data chunks and 
so unavailable to metadata anymore. As Zygo put it once, if btrfs ever 
needed as much metadata, there are good chances it will need it again.

> virtual environment with lots of virtual machines it may not be best to
> start balance on a lot of them at same or similar times either,
> considering the load it creates for the underlying storage.
> 
> I know balancing not the same as defragmenting files in other filesystems,
> but I still remember the strong warnings of XFS developers not to ever
> just defragment a XFS filesystem just cause you feel like it. The
> reasoning behind these warnings was that defragmenting files tends to
> fragment free space. But balancing actually defragments free space as
> far as I understood and thus is different.
> 
> Anyway, I am keen to read on more insight on this from people who
> understand better what impact a BTRFS balance really has.
> 
> Thanks,

