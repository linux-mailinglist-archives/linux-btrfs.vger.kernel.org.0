Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87904A3F6A
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jan 2022 10:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbiAaJlT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jan 2022 04:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbiAaJlS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jan 2022 04:41:18 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFA9C061714
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jan 2022 01:41:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c192so9733032wma.4
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jan 2022 01:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=booksterhq.com; s=gm;
        h=from:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=cFpG1RI2O0G/+DQ4LqsIADlzxk6Q5WcOOBi5Rr8kqj4=;
        b=NawqTfOd4AYCmGvGq6AtDkob0Ax3FBewwsTXndASHAEg2rp0+DnIp3HxhUU1cwne9T
         j4Teczp3PVn4packWuDo9sETqUJA075mL5L2wdNatYpguQEIxmDse4No7aX0xKbWIAfj
         mrwlJ62HDMQ+h0j+qjOcGhwx3Wg+aG20aK16kqwgM5/PAKTv2Tduc9NzY53Puup1WEYc
         8y+pYAHLK/C98ceYew3Kt+E8JMMs2GgnZzWc8AQGBPtz5S4PmTqm0zqR1NV+vz5yhJua
         K4IUlH7YiyWYsRbzpviypHbu+p7+iAkY8VVFbfw+8t9CWTvzDREKoRUUmwKy+div4yed
         trbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=cFpG1RI2O0G/+DQ4LqsIADlzxk6Q5WcOOBi5Rr8kqj4=;
        b=5RfH4XbcE86A9b6c4FaLgZCRsmABL1a2wDLZ3yFYM3XOOzJRMbaYNfh8Ky5g55SszS
         +71lsMYGMgHH96vFq+tawzg5xsxFAKgwxz94j/6pfwFg4JKyWQdPICl6yOv0Inbm9bBv
         ZLkTAFbeGtYiSSG41DH7uKKJpUBJ1qi2h/7Zbv9GMKmFxucUwC1MYwHebnkAdlvaTBHw
         5DPn7eTDrtSsrfZX//502DB/hfw9zvtaQnFtuebeJewqung3mVEYDwnnI2GBevNKW7Xk
         EsBfmZ08BJQq/4M0doo4T9poc4mkDj3PB/f6BDNcXQUmowqtywYgpvHkkE2HLWmm6HnJ
         uIxQ==
X-Gm-Message-State: AOAM533cTWLj97wKRh5bxNxzHBSXk6iJ6DL9My4949IobO1c4Nx2hDkZ
        3DDzhX/6u7eIUTEuhtU/JYdrM/pDS26crGG1
X-Google-Smtp-Source: ABdhPJx3+zkHtuudAxZEdHLWIuuXZz2BAebEFm1+JHKZU6HlrC60Jf3HAFVU+kIdLp9cXkwV8tAbyA==
X-Received: by 2002:a05:600c:4ed0:: with SMTP id g16mr17857848wmq.19.1643622072530;
        Mon, 31 Jan 2022 01:41:12 -0800 (PST)
Received: from [192.168.86.250] (cpc105096-sgyl40-2-0-cust48.18-2.cable.virginm.net. [92.239.42.49])
        by smtp.gmail.com with ESMTPSA id 44sm11391543wrm.103.2022.01.31.01.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 01:41:12 -0800 (PST)
From:   Colin Guthrie <colin@booksterhq.com>
X-Google-Original-From: Colin Guthrie <gmane@colin.guthr.ie>
Message-ID: <367f0891-f286-198b-617c-279dc61a2c3b@colin.guthr.ie>
Date:   Mon, 31 Jan 2022 09:41:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: No space left errors on shutdown with systemd-homed /home dir
Content-Language: en-GB
To:     kreijack@inwind.it, Chris Murphy <lists@colorremedies.com>
Cc:     Boris Burkov <boris@bur.io>, "Apostolos B." <barz621@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        systemd Mailing List <systemd-devel@lists.freedesktop.org>
References: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
 <YfHCLhpkS+t8a8CG@zen> <4263e65e-f585-e7f6-b1aa-04885c0ed662@gmail.com>
 <YfHXFfHMeqx4MowJ@zen>
 <CAJCQCtR5ngU8oF6apChzBgFgX1W-9CVcF9kjvgStbkcAq_TsHQ@mail.gmail.com>
 <042e75ab-ded2-009a-d9fc-95887c26d4d2@libero.it>
 <CAJCQCtQv327wHwsT+j+mq3Fvt2fJwyC7SqFcj_+Ph80OuLKTAw@mail.gmail.com>
 <295c62ca-1864-270f-c1b1-3e5cb8fc58dd@inwind.it>
In-Reply-To: <295c62ca-1864-270f-c1b1-3e5cb8fc58dd@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Goffredo Baroncelli wrote on 30/01/2022 09:27:
> On 29/01/2022 19.01, Chris Murphy wrote:
>> On Sat, Jan 29, 2022 at 2:53 AM Goffredo Baroncelli 
>> <kreijack@libero.it> wrote:
>>>
>>> I think that for the systemd uses cases (singled device FS), a simpler
>>> approach would be:
>>>
>>>       fstatfs(fd, &sfs)
>>>       needed = sfs.f_blocks - sfs.f_bavail;
>>>       needed *= sfs.f_bsize
>>>
>>>       needed = roundup_64(needed, 3*(1024*1024*1024))
>>>
>>> Comparing the original systemd-homed code, I made the following changes
>>> - 1) f_bfree is replaced by f_bavail (which seem to be more 
>>> consistent to the disk usage; to me it seems to consider also the 
>>> metadata chunk allocation)
>>> - 2) the needing value is rounded up of 3GB in order to consider a 
>>> further 1 data chunk and 2 metadata chunk (DUP))
>>>
>>> Comments ?
>>
>> I'm still wondering if such a significant shrink is even indicated, in
>> lieu of trim. Isn't it sufficient to just trim on logout, thus
>> returning unused blocks to the underlying filesystem? 
> 
> I agree with you. In Fedora 35, and the default is ext4+luks+trim
> which provides the same results. However I remember that in the past the 
> default
> was btrfs+luks+shrunk. I think that something is changed i.
> 
> However, I want to provide do the systemd folks a suggestion ho change 
> the code.
> Even a warning like: "it doesn't work that because this, please drop it"
> would be sufficient.


Out of curiosity (see other thread on the systemd list about this), what 
it the current recommendation (by systemd/btrfs folks rather then Fedora 
defaults) for homed machine partitioning?

I have a new system to setup and the base filesystem is currently btrfs 
but I'm wondering if I should be putting a large luks file on that (can 
set nocow, but even still) or whether I should redo the base FS as ext4?

Open to some degree of experimentation, especially if the next six 
months promises new features that will be useful etc.

Col

-- 

Colin Guthrie

