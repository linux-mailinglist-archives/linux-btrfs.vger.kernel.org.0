Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43BD134587
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 16:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgAHPBu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 10:01:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34856 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgAHPBu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jan 2020 10:01:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id z76so2904193qka.2
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jan 2020 07:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JHemhC1xpekOf1ILMyU0KvUoIPhZSFnqegm3BytMU/w=;
        b=SuBKz2XS8mtmlijrmhxBe5lCwcQ2BgXkNPwneyCGKoj7Umn4UTg8bsMqmBG5uBCA+J
         46C+m52IoS2JsEMftMIWrnU3LlR6oD3mJ2X2uWLdglVMCFYohu6GwEiPqg5qiOfcchw8
         /bW8QbbXW6qVDqWBNh+PuYpK7zL0eiOBusnD4HbmEwpofnWOaBL9M9GxPXOEObd4cMnw
         1/Fqdtbcm4apoxmMUf9Zg9dpaClYrLtH3UdIAJ69n0qu/z0K3DdeBkWPkWExAQKgrDrT
         aQ5/9N4orGuZ+jZB+cf748M6ArLOzTOi4jFKF9ms78D611VsKuKKORaLu//8nURzaU5v
         fM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JHemhC1xpekOf1ILMyU0KvUoIPhZSFnqegm3BytMU/w=;
        b=M6IlHxqMNlfiCUZ4T6eHpDDJAaOJ3oFpW84n1+IVHvpNFp287VCg79NdD+yEsFIlxr
         jdSryB52DXo/ry1spBm9vtAHf0bOD/zUIisf9svGv1Xnz1I2LaoiFCI8NHmjM7YKzELr
         piPnjB6hPZv9T8Nmn9Ab1Relrxi0Xr3aROKQ9GiXJ8qQG9U28NARZV8ku6FgjbRYT3CB
         xTBUndUhheeVzcKP6g1vJCtC9m+KyD2QwmQ2AMkEKVpSSJJBBI0YtxidFxvZF68HXAVH
         l4yM1ARytbzmS+o8mplMI5RjryNv1F75Akyr04+dvwSQsQV4wcPbiDkfNIkgDQVbKGzQ
         JZoQ==
X-Gm-Message-State: APjAAAWRkwsZaqYtkDVz9FZAaYi/aXFNh7BqxIX91opJTedF/wn/6pUB
        yp9Qzc0e52Y+ff/Uo4wVNWS2HdRyhJR8GA==
X-Google-Smtp-Source: APXvYqy1MEqTiqUnat9wIyPd4Qqzozmty73sLPI79L63+bRNZ34y/6xnA0TPzJojYZF02Vf8GkNMAQ==
X-Received: by 2002:a05:620a:11a3:: with SMTP id c3mr4769889qkk.230.1578495708788;
        Wed, 08 Jan 2020 07:01:48 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::f832])
        by smtp.gmail.com with ESMTPSA id b7sm1695655qtj.15.2020.01.08.07.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 07:01:47 -0800 (PST)
Subject: Re: [PATCH] btrfs: safely advance counter when looking up bio csums
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>
References: <20200108144032.16354-1-dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <212a1c64-a593-9fe7-dbaf-17a32fe4c7f1@toxicpanda.com>
Date:   Wed, 8 Jan 2020 10:01:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108144032.16354-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/8/20 9:40 AM, David Sterba wrote:
> Dan's smatch tool reports
> 
>    fs/btrfs/file-item.c:295 btrfs_lookup_bio_sums()
>    warn: should this be 'count == -1'
> 
> which points to the while (count--) loop. With count == 0 the check
> itself could decrement it to -1. There's a WARN_ON a few lines below
> that has never been seen in practice though.
> 
> It turns out that the value of page_bytes_left matches the count (by
> sectorsize multiples). The loop never reaches the state where count
> would go to -1, because page_bytes_left == 0 is found first and this
> breaks out.
> 
> For clarity, use only plain check on count (and only for positive
> value), decrement safely inside the loop. Any other discrepancy after
> the whole bio list processing should be reported by the exising
> WARN_ON_ONCE as well.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
