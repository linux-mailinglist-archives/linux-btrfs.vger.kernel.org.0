Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C50E12A15E
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Dec 2019 13:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfLXMkw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Dec 2019 07:40:52 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:32938 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfLXMkw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Dec 2019 07:40:52 -0500
Received: by mail-qt1-f171.google.com with SMTP id d5so18063432qto.0
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Dec 2019 04:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XWJA0kQtC8FCu412p+b6sL5Rpg/KfnNS1eoJmjLJ2u4=;
        b=V6J1JKaxunhJzojRh7BRXXGFINw7wwgU7cfrT782e5Cy8tqqeE0Jme9hpPRQqkooQE
         6BFBujwbDyIH2aLqx9AZqVbVGxialZTMzM2ezMJlCUCm6bcYBl6fFM7JLhhyDST8ghCF
         k2cnOSQ+4JBnd8EKISGGR6awL/1LFAD8h/hb5FmMfFZUQN+Dxk6xHuIjEV5LJoEtEvrx
         CkW1+VAiGs5maD2wTBiD/evg2+n5yIuopqi4zPrahn045Q+f7ghHwGRMN37fN+PRV0wJ
         pPfYdWbXONWfS82OFHupa73I+Yvqq13a6MdXlcYPpKYGyJYRKhJDMb1SBaKUwSN7KeQy
         k3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XWJA0kQtC8FCu412p+b6sL5Rpg/KfnNS1eoJmjLJ2u4=;
        b=TCLK1rYVi0o3x5V+g37lMLSxsYCuddsWrVXwJme8KvTxGXSxex8D6YWD40hpnUDvwY
         o8MTmF+a9ui3R+MrlOWuvFtJ6s8sZXrdpTBJZ8mmFbk02p7CocM3Q+atGI4PGCTjuQRk
         V7cXTQ37FLF2oKpKtbfoFxv6Qn4eM/0XvZeJCTvxwrX95seyklaRrQAq7aw1V5mTQuke
         TW1iPn7oDGqY7El1IwI3rtOCbC0fSC8dsyhF86VllvJiVwoS3sxCdTX152xlzn/8grYg
         y3y8s8HMzSqHjVqyAjSDiBlZJ4onpeV5QYtSh8wD6uGtrm4EoNAavGJ9RdHQHUUWP6tA
         ysQw==
X-Gm-Message-State: APjAAAVV/Jy5ypvm/e5A62HB2MpaLh3ULUnXA/qKjETsxinKppx96ZeA
        YnmS+chqL0yOgGZQaVJXQ5UnDpgKGRKBeg==
X-Google-Smtp-Source: APXvYqz4IbmepNAWx3MdYlMf1zz9oSQReVFO+czVs8WOIlJCFtwdUXwlcYeLkvrli12LlUHTWFraUQ==
X-Received: by 2002:ac8:27ed:: with SMTP id x42mr12323728qtx.299.1577191251330;
        Tue, 24 Dec 2019 04:40:51 -0800 (PST)
Received: from [192.168.1.227] (user-12l2ihc.cable.mindspring.com. [69.81.74.44])
        by smtp.gmail.com with ESMTPSA id o9sm6864748qko.16.2019.12.24.04.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2019 04:40:50 -0800 (PST)
Subject: Re: Metadata chunks on ssd?
To:     Wang Shilong <wangshilong1991@gmail.com>,
        Hans van Kranenburg <hans@knorrie.org>
Cc:     =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs@lesimple.fr>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <16f33002870.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <fbf7c50b-fc02-bf51-b55f-6449121e7eec@knorrie.org>
 <CAP9B-QkL60aELFZzOzZStbAz2UWj11V8YNPtSWWgwzeEnbLpvQ@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <8a45940d-6634-e49d-cfde-e7087060c060@gmail.com>
Date:   Tue, 24 Dec 2019 07:40:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAP9B-QkL60aELFZzOzZStbAz2UWj11V8YNPtSWWgwzeEnbLpvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-12-23 21:04, Wang Shilong wrote:
> On Tue, Dec 24, 2019 at 7:38 AM Hans van Kranenburg <hans@knorrie.org> wrote:
>>
>> Hi Stéphane,
>>
>> On 12/23/19 2:44 PM, Stéphane Lesimple wrote:
>>>
>>> Has this ever been considered to implement a feature so that metadata
>>> chunks would always be allocated on a given set of disks part of the btrfs
>>> filesystem?
>>
>> Yes, many times.
>>
> 
> I implement it locally before for my local testing before.
> 
>>> As metadata use can be intensive and some operations are known to be slow
>>> (such as backref walking), I'm under the (maybe wrong) impression that
>>> having a set of small ssd's just for the metadata would give quite a boost
>>> to a filesystem. Maybe even make qgroups more usable with volumes having 10
>>> snapshots?
>>
>> No, it's not wrong. For bigger filesystems this would certainly help.
>>
>>> This could just be a preference set on the allocator,
>>
>> Yes. Now, the big question is, how do we 'just' set this preference?
>>
>> Be sure to take into account that the filesystem has no way to find out
>> itself which disks are those ssds. There's no easy way to discover this
>> in a running system.
>>
> 
> No, there is API for filesystem to detect whether lower device is SSD or not.
> Something like:
>         if (!blk_queue_nonrot(q))
>                  fs_devices->rotating = 1;
> 
> Currently, btrfs will treat filesystem as rotational disks if any of
> one disk is rotational,
> We might record how many non-rotational disks, and make chunk allocation try SSD
> firstly if it possible.
This doesn't tell you that the device is an SSD though, just that it 
reports to the kernel as non+rotational. For example, NBD devices 
present as non-rotational by default, and in most cases you do _not_ 
want hot data on a network disc.

The important thing here is disk performance, not whether it's an SSD or 
not. An SD card is non-rotational and solid-state, but on most systems 
the performance is going to be sufficiently bad for BTRFS-type workloads 
that it's almost useless for this type of thing.
> 
>>> so that a 6 disks
>>> raid1 FS with 4 spinning disks and 2 ssds prefer to allocate metadata on
>>> the ssd than on the slow drives (and falling back to spinning disks if ssds
>>> are full, with the possibility to rebalance later).
>>>
>>> Would such a feature make sense?
>>
>> Absolutely.
>>
>> Hans
>>

