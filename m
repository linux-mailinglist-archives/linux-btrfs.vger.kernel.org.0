Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BCF18B9C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 15:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCSOvT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 10:51:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34336 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgCSOvS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 10:51:18 -0400
Received: by mail-qk1-f196.google.com with SMTP id f3so3342754qkh.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5smCtqwMHItpRqMKmDYmsJsDG8Pa7DGSHoiQrITa0sc=;
        b=GemwRwo9eynAqxzUKXvH4+Oy+KXxBatGpwOFdwHlpsiisWKs5SRykX5hNHfGjQR6IV
         EB+K7a8ZFOX7UjdQWCOviQaapLhqksl3v4CoJy8JBUWVq4m8tcw3Fnp4xG/DHclP3ZE/
         DFH9g5frqLCBpwaLvaN/4V5CIsbImSlimh67b5aDYiNXCM00pgReEKm2oco/CMlDyWvG
         YL1Wh6Jd4jAHSWzx+VL3BBi6i/bMUpZrlljyz67aMxAmwWMGyuBNfOddFESTh6tBXRta
         NtI+1kYPpbTSWDxhAQ3TeYw/ju2Dk9u/WQ4x0EdqWfAaSe4bxpiGDW0IxOaNNNoFZf5E
         VX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5smCtqwMHItpRqMKmDYmsJsDG8Pa7DGSHoiQrITa0sc=;
        b=GOUhCOJOoMFfYeD6nuiWfWPNm1mGm9EY+ji6J799Ka9WULqNvbrtlTYwm9+OJ4ILum
         kMJ/5j4HuRBJUIKQZlNtg7TDh92/4wgjJErUvQoeGqrx10LYUis7EOBTToWhCc/S7zE1
         x52t3baMavXNT4LYISGbkkJsHuDOGI3DjbxcHU2q7CR2Tzo2YcoF9s1BU9W8Lih8+jsr
         ZSuo/KkpDRXLrVP15mqc3gK6cKKaGCM7Od0tkL9Qg+FIsjpNWbnmM+5O3cM6YSyr06rP
         9GUqVmoPnd7rTY0cK+ZDOZ/gTRbe2cbUKfxHgqT2PuPgLMc+mysuLsErqvdvxrIp7tTd
         rrUw==
X-Gm-Message-State: ANhLgQ0abrHMYK7glaRICwjXcVXK+e6JLLWyOKj/1/TG7rFtLWTOdRY4
        +3XM97ed2t7nq58TWjRTbh6mPyZr6js=
X-Google-Smtp-Source: ADFU+vsegGiVkUf1/Y0IYOSjtGaV8LLIK3J/2TV63lo+qUHcgz0d6ZAg/CldAqCNAnD7sF4vYkEv3w==
X-Received: by 2002:a37:a93:: with SMTP id 141mr3395928qkk.244.1584629476830;
        Thu, 19 Mar 2020 07:51:16 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 206sm1698853qkn.36.2020.03.19.07.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:51:16 -0700 (PDT)
Subject: Re: [PATCH] btrfs: use nofs allocations for running delayed items
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200319141132.3127-1-josef@toxicpanda.com>
 <20200319143428.GD12659@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3c965a52-1750-940b-03a9-003a92c9d263@toxicpanda.com>
Date:   Thu, 19 Mar 2020 10:51:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319143428.GD12659@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/19/20 10:34 AM, David Sterba wrote:
> On Thu, Mar 19, 2020 at 10:11:32AM -0400, Josef Bacik wrote:
>> This is because we hold that delayed node's mutex while doing tree
>> operations.  Fix this by just wrapping the searches in nofs.
> 
> For the time being we have to do the explicit NOFS so in the code it's
> a bit awkward. The hint is a function that takes transaction as
> argument.
> 
> I'm working on the scope NOFS (marked by the transaction start/end), it's
> intrusive, all over the code and there are some cases when I want to add
> assertions that turns out to be tricky for some functions.
> 

That could be cleaner, do you want me to drop this and just add a

if (trans)
	memalloc_nofs_save()

memalloc_nofs_restore()

in btrfs_search_slot?  That'll catch all of these usages.  I'm not married to 
any particular approach.  Thanks,

Josef
