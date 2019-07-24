Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1FAD724B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 04:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfGXCdw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 22:33:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34341 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfGXCdv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 22:33:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so14154285pgc.1;
        Tue, 23 Jul 2019 19:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PG5Fjwwrk0QuD+sTgYEYYGjOti0OiQdq1uV5NO/0c8Y=;
        b=AAc6uNbrMbXFMcL3MnGZRdvGr23b+I7A8qHl2fitW/UP1nyjy8tBU1FkWAY193tSIY
         zPRChdZEayDulJTZS+1ewNcZY29Oldm0zo2EoQEO8NAZkwGWSpvAloicBvcrVbFaBVjl
         RmW2WwT00t4W+QRVAXHTm5SPKx09wyvkMuV/mmjP0/wlKagHVVjK5pDEmRXe92mu6Zfy
         hr1xJVst4mHX32dPWcAiFRsQNwblgmnnwXP3pg3ycebY3OcxECO3IxFDgRCzFmDccVIB
         nSA+2sS77AFpvay66K18dlgw4RGp5CrN3/Br4bXRPZ2y30/BBMNoPcaqrl4ZKPHiPFgJ
         9R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PG5Fjwwrk0QuD+sTgYEYYGjOti0OiQdq1uV5NO/0c8Y=;
        b=OrJbFxk7CvlqTa1mvISHU4hSZtTJTU1cHpiiNDB/Ej4MvmB83ltP3XFaeCGqv+MDo6
         +ddGPFqDbj4LzbrbRgTF+a8eAhR7q2ZIAKpIbGE2dQ06vc/gj87M0eu0ZSsnQ4aBQJMQ
         zbJXk+Bum0xYPejD4kJrWOdpT7KZK4tfzgC4fZj/ZKlDU9B8fIjFK9I8kiluDYplEqsX
         wiOXLS4dgdWCpk/DjF+jqdLr9TnSSO20BkuzkQJcVYu3FlKzq1NneQn0JChCI23cJn6B
         HUBnXBOpht8wdCyIzd3/jS0MSsX8dEJyodiZPxo4Xy3qE5uC/S/fjSCgF9YONvq0zOoD
         r4jQ==
X-Gm-Message-State: APjAAAW4MzhvEkBGrxocNeCJPWN01fQCMts5+QX5hvm2g6T6O28CK2aX
        40+GSsFYUp0LV9FxsBNMO+WH0p0m
X-Google-Smtp-Source: APXvYqxSqfZOC7vaEUmBkXSL8+tgg9fFUHQDwWkNEhKzUNDpfhkEivfM5Ae4Np1l/uYn+5Ti8d7FVA==
X-Received: by 2002:a65:5144:: with SMTP id g4mr26835599pgq.202.1563935630873;
        Tue, 23 Jul 2019 19:33:50 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id 23sm48509918pfn.176.2019.07.23.19.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 19:33:50 -0700 (PDT)
Subject: Re: [PATCH] fs: btrfs: Fix a possible null-pointer dereference in
 insert_inline_extent()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190724021132.27378-1-baijiaju1990@gmail.com>
 <df4b5d21-0983-3ca2-44de-ea9f1616df7f@gmx.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <800ae777-928f-2969-d4dd-6f358a039e48@gmail.com>
Date:   Wed, 24 Jul 2019 10:33:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <df4b5d21-0983-3ca2-44de-ea9f1616df7f@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/24 10:21, Qu Wenruo wrote:
>
> On 2019/7/24 上午10:11, Jia-Ju Bai wrote:
>> In insert_inline_extent(), there is an if statement on line 181 to check
>> whether compressed_pages is NULL:
>>      if (compressed_size && compressed_pages)
>>
>> When compressed_pages is NULL, compressed_pages is used on line 215:
>>      cpage = compressed_pages[i];
>>
>> Thus, a possible null-pointer dereference may occur.
>>
>> To fix this possible bug, compressed_pages is checked on line 214.
> This can only be hit with compressed_size > 0 and compressed_pages != NULL.
>
> It would be better to have an extra ASSERT() to warn developers about
> the impossible case.

Thanks for the reply :)
So I should add ASSERT(compressed_size > 0 & compressed_pages) at the 
beginning of the function, and remove "if (compressed_size && 
compressed_pages)"?


Best wishes,
Jia-Ju Bai
