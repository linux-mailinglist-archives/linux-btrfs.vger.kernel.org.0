Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E3C22249F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jul 2020 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgGPOAT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jul 2020 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbgGPOAJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jul 2020 10:00:09 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16575C061755
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jul 2020 07:00:09 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 80so5554688qko.7
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jul 2020 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1BjilFBBLGsE5wlXU2zjwgQLmb5dO7zdty/211816aY=;
        b=uHp7pckUW8A6VWfattLoe5kmSE5WtXRFDZ4yd++AwKhHTvM8uEQOjBdMM+4S9eBHzv
         r2Gm8xcmMget0NDfYrjVYnt4QejGOktD7++kzOt41gvYOsgtlcPpGE75WxyNsqjV+B0f
         Zpv5Nd3jwbOAc5NrMIZSx4c2M48Ncoq6PcOq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1BjilFBBLGsE5wlXU2zjwgQLmb5dO7zdty/211816aY=;
        b=psBm4GDVGlCp4HcRNPQTYAo6JJQc1FFKLF1Q9Fvej9Zm1f9t9ohRFtRQJwOWuhnhl0
         hvQP3tEew7PtBBorD1UnHjdCvzdz/UjvMWGuzhllj6uHGGePuAGP9+XUnHTzxP7YigFe
         Bq6P5hzD40Eiiyr5RkPvPT0j/xTFrMIS9bgaYmLSanNhrKAzuKqEEmaopdRnldvql0T0
         BUEYiM+FP35NXI466qY73SDkV6pmRZf0QKgXjz7ZvJNcC1p7tnLaJkLa70HSjN+jcVMP
         n+5Kfv2zbDltST/nYeY0fNFkIK2KCyIL927+GaDhTZqF+K6iFMLraPYc0SXGsCcQQgFK
         2WtQ==
X-Gm-Message-State: AOAM533xZ1qih7wnszSL+4HzsELlXGGZ8kYskNWNAR7EHkBeLbro8WDk
        wNKP/sqRUqArPGcHcDNbCZKAj0yPeS6f8A==
X-Google-Smtp-Source: ABdhPJywgil53fIoinvjELd2JumGaQ7INvupOoXOUUQoQjZGez5FNJBiVwm8UjYSUzAWs97YRhKm5g==
X-Received: by 2002:a37:9c81:: with SMTP id f123mr3874005qke.21.1594908007563;
        Thu, 16 Jul 2020 07:00:07 -0700 (PDT)
Received: from [192.168.1.9] (pool-72-83-172-153.washdc.east.verizon.net. [72.83.172.153])
        by smtp.gmail.com with ESMTPSA id u23sm6358168qkk.53.2020.07.16.07.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 07:00:06 -0700 (PDT)
Subject: Re: balance failing with ENOENT
From:   Peter Foley <pefoley2@pefoley.com>
To:     A L <mail@lechevalier.se>, linux-btrfs@vger.kernel.org
References: <5bc91ff8-1764-203d-53e1-a691b1b5abf9@pefoley.com>
 <798d01f.397441d9.1733fb56693@lechevalier.se>
 <6d862426-f260-0617-c529-248e941b4124@pefoley.com>
Message-ID: <94a22bc1-8caf-f4bd-83f7-c922346cc078@pefoley.com>
Date:   Thu, 16 Jul 2020 09:59:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6d862426-f260-0617-c529-248e941b4124@pefoley.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/13/2020 10:16 AM, Peter Foley wrote:
> On 7/11/2020 5:08 PM, A L wrote:
>>
>>
>> ---- From: Peter Foley <pefoley2@pefoley.com> -- Sent: 2020-07-11 - 21:39 ----
>>
>>> Hi,
>>> I've got a btrfs filesystem that started out using the single profile.
>>> I'm trying to convert it to raid1, but got a strange error when doing so.
>>> Note that this only started happening after the initial balance got canceled part-way through.
>>>
>>> btrfs balance start -dconvert=raid1,profiles=single /
>>> ERROR: error during balancing '/': No such file or directory
>>> There may be more info in syslog - try dmesg | tail
>>>
>>
>> You can try "btrfs balance start -dconvert=raid1,soft /" 
>>
>> 'soft' avoids balancing chunks that are already in the target profile. *
>>
>> * https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-balance#FILTERS 
>>
>>
>>
> 
> No dice, exact same failure mode:
> btrfs balance start -dconvert=raid1,soft /                                                                                                                                                                                    ERROR: error during balancing '/': No such file or directory                                                                                                                                                                            There may be more info in syslog - try dmesg | tail
> 
> [146628.913952] BTRFS info (device sda3): balance: start -dconvert=raid1,soft                                                                                                                                                           [146628.914403] BTRFS info (device sda3): relocating block group 968545533952 flags data                                                                                                                                                [146648.475913] BTRFS info (device sda3): found 11 extents, stage: move data extents                                                                                                                                                    [146649.198865] BTRFS info (device sda3): balance: ended with status: -2          
> 

Any other ideas?
I'm completely stumped here...
