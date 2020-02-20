Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92807166163
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgBTPtn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:49:43 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34969 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbgBTPtn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:49:43 -0500
Received: by mail-qt1-f195.google.com with SMTP id n17so3189661qtv.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=25wL/sHACnHQdTshtveKrrSvYS6OHkSQECMy2thnsfg=;
        b=Xo3ADaKCleSQpK91KyDzjUkA7DAcD1aeh3zGXcKzo8J9XO/Cm8jjrkskEHl4JeoZmw
         QOo2pdRJ42dxnSPHNyN1xMSUi7gIb3QmfMKt8c4FNKT/3IsXNRDcaLFvuG+UPGILR48N
         5pZmHIs+NcKYlr3KQyQRNSs6qYFPuiHb/CUmGoQDYam2RxKcWWDxx2gv6tA63ap3xy7D
         M3XEE4AIBu79SzVh+3CHpx0mpzh+HGXe3iijlcki3chWxcAAC5faxGeMWSdOc6cNC0gp
         ZRKUogxyk9LzjkR8zQNDd/q2oWWqhoWsiW65JvImDiHkdjXPLJAgZ8e5LBF+Viq3b8lC
         z/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=25wL/sHACnHQdTshtveKrrSvYS6OHkSQECMy2thnsfg=;
        b=msqJfqtCb9ReQhanjkNpPKkOcjJbU5YOZO5/Uu2ms2lmP6skP3Uxk5MOrtlDePpKrH
         74LnDThOEWIj1K2UZ0yoiSRjmJW2irpGp+OByGCFT/nZcpwYpZtEtKfPofjKK49iEllG
         y3gOzrMdoI/Eq3tLod74xkOMmxP2H7bh1+QH/HHiY8lynfLBcXvjF5EnYKMGvv1RG/IW
         fNhpwmSy/7t58Ld/7VVXsYuptFPyRaFytA3tYPwqN8tyutgdWfrxey0JpFOI0hviZUhC
         rKput0kE03LsN0FbyAAvupGu3U0al9L0uo42f9l4hdp1BqVThLLIELmJqq2n/FyrKHDp
         MfwA==
X-Gm-Message-State: APjAAAW5C8sPVp3I0IZoEPyN5R/OIbUHjT8ZAbXXvBnOQjpkLY0W1Xvn
        6PDZPevfCRTvz6BLJ1WOmEVblA==
X-Google-Smtp-Source: APXvYqx3eQuRIxdm4VHjnLeVAirPjpZMq2HlIleTmddHRcI5P5JVvQ9uGw/KRuGKcGCN+oT0OgpwIQ==
X-Received: by 2002:ac8:a8b:: with SMTP id d11mr26425523qti.94.1582213780815;
        Thu, 20 Feb 2020 07:49:40 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v55sm2089119qtc.1.2020.02.20.07.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:49:40 -0800 (PST)
Subject: Re: [PATCH 1/8] btrfs: make the extent buffer leak check per fs info
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200214211147.24610-1-josef@toxicpanda.com>
 <20200214211147.24610-2-josef@toxicpanda.com>
 <78ac92dc-1e57-1d74-0b17-48832a36c649@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f8fff9d1-9323-8f98-6264-fb04531c1efe@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:49:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <78ac92dc-1e57-1d74-0b17-48832a36c649@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/19/20 8:59 AM, Nikolay Borisov wrote:
> 
> 
> On 14.02.20 г. 23:11 ч., Josef Bacik wrote:
>> I'm going to make the entire destruction of btrfs_root's controlled by
>> their refcount, so it will be helpful to notice if we're leaking their
>> eb's on umount.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Overall looks good, one minor nit below though:
> 
>> ---
>>   fs/btrfs/ctree.h     |  3 +++
>>   fs/btrfs/disk-io.c   |  3 +++
>>   fs/btrfs/extent_io.c | 45 ++++++++++++++++++++++----------------------
>>   fs/btrfs/extent_io.h |  7 +++++++
>>   4 files changed, 36 insertions(+), 22 deletions(-)
>>
> 
> <snip>
> 
>> @@ -35,42 +35,45 @@ static inline bool extent_state_in_tree(const struct extent_state *state)
>>   }
>>   
>>   #ifdef CONFIG_BTRFS_DEBUG
>> -static LIST_HEAD(buffers);
>>   static LIST_HEAD(states);
>> -
>>   static DEFINE_SPINLOCK(leak_lock);
> 
> This lock should be renamed to extent_state_leak_lock, otherwise it's
> not clear what it protects. I had to through its usage to figure it out.
> To take this further, why don't you make it a a per-fs_info lock as
> well? Extent states are per fs themselves.
> 

Yeah I can follow up once this set is merged.  Thanks,

Josef
