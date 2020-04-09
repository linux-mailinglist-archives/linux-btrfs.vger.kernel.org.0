Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90141A3C23
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Apr 2020 23:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgDIVxF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 17:53:05 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42383 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDIVxF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Apr 2020 17:53:05 -0400
Received: by mail-wr1-f45.google.com with SMTP id j2so2064286wrs.9
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Apr 2020 14:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rl4BjyJViknGZSl8PgE9Na3Y2/FlUVSoI5hdVQD0l4Y=;
        b=h8/tC2VeDusIwWCm+U44Pkz3yKYSrbCyL/liEXgxZkJ2w8o7jUQNdimBz9HUR2ZPj1
         pbJTghiVXYa7WK1XTdmBDfz8lcXqGaixiwS+q4rrcZQ2kHETLtJV8UiIWfC7iSAQpW0V
         LT0fk7SQMzN+bINCn41paWhRyKCZ00jw1BDm/xLS8WhEvjeL1SlsIKhSWeWMETSO+H+3
         ltzLigEziSemXBe9XqJGLjxpzMIN7xu6hbO0R2iskHOOL43Cz400DZKP9E1++ttWnveH
         +76pM+6pPW4XxA493mCeMYQC+gx8glMNqYLAVO2Pj/TewEBPWMfP4BAXU+5/xDMv+EVK
         vU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rl4BjyJViknGZSl8PgE9Na3Y2/FlUVSoI5hdVQD0l4Y=;
        b=ADIihwNYAEzrTenjfYwWkJaF7Q7f0Ke4x65P2IIWjc3Vb3/mtwmUBWWQOtkXyEJ8Ll
         mGvraPIfg8eTM+O4Sy8XCU/52tA/GFvA6i1aHSIFeQ/Kdualqm2ONgqSZF0dHwBAgDmx
         MrKYBSjSzj0sOCLGP9xXwYDUemKjXGP/0VXIun9SYjZMzCegkZER6wm2uW/dCBli7pC3
         f05StRbrqAZwE0OzcZQYPbqf+dJPS7BcU22ISpIfuO0u650bcq/2afOy4+UmlNF1+sBE
         2B+2lIzRSWywzMY0eKuI7OoyDLkyV4Zib4whDlYT9Y5P9r5jgup6Sj90DxSHIsWFnqth
         UpFw==
X-Gm-Message-State: AGi0PuZMbrM+3a/DORTzXZnD7WrLptYwgK/RtQAtdZN+qVUIU1MPogn6
        6yVWednLh+duoX3NsNSy2L2vsJZ7
X-Google-Smtp-Source: APiQypKq+GDQdNAzOkosztEHP8k7GsMVthxCVBFMrb78P0c+A1hewRcSUunEf51P72BcLgZa956zxg==
X-Received: by 2002:adf:916f:: with SMTP id j102mr1136740wrj.335.1586469182712;
        Thu, 09 Apr 2020 14:53:02 -0700 (PDT)
Received: from ?IPv6:2001:984:3171:0:126:e139:19f1:9a46? ([2001:984:3171:0:126:e139:19f1:9a46])
        by smtp.gmail.com with ESMTPSA id 132sm13539wmc.47.2020.04.09.14.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 14:53:01 -0700 (PDT)
Subject: Re: btrfs freezing on writes
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <6a1c8ce0-ce2a-698d-dcc6-0657a125dae4@gmail.com>
 <20200409043245.GO13306@hungrycats.org>
From:   kjansen387 <kjansen387@gmail.com>
Message-ID: <e1ed482f-158a-650a-f586-d8ad0310157d@gmail.com>
Date:   Thu, 9 Apr 2020 23:53:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409043245.GO13306@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Zygo,

Thanks for your reply!

 > Try 'btrfs fi usage /export'.
I'm removing /dev/sdd at the moment, my usage now (metadata usage was 
the same a few weeks back):

# btrfs fi usage /export
Overall:
     Device size:                  10.92TiB
     Device allocated:              7.58TiB
     Device unallocated:            3.34TiB
     Device missing:                  0.00B
     Used:                          7.45TiB
     Free (estimated):              1.73TiB      (min: 1.73TiB)
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)

Data,RAID1: Size:3.78TiB, Used:3.72TiB (98.35%)
    /dev/sde        2.53TiB
    /dev/sdf        2.52TiB
    /dev/sdb      869.00GiB
    /dev/sdc      868.00GiB
    /dev/sdd      838.00GiB

Metadata,RAID1: Size:6.00GiB, Used:5.18GiB (86.40%)
    /dev/sde        4.00GiB
    /dev/sdf        5.00GiB
    /dev/sdb        1.00GiB
    /dev/sdc        1.00GiB
    /dev/sdd        1.00GiB

System,RAID1: Size:32.00MiB, Used:592.00KiB (1.81%)
    /dev/sdc       32.00MiB
    /dev/sdd       32.00MiB

Unallocated:
    /dev/sde        1.11TiB
    /dev/sdf        1.11TiB
    /dev/sdb      993.02GiB
    /dev/sdc      993.99GiB
    /dev/sdd     -839.03GiB


What this suggests to me is that I don't have 5GB metadata - I have 12GB ?

 >
 > 	btrfs fi resize 1:-4g /export;
 > 	btrfs fi resize 2:-4g /export;
 > 	btrfs balance start -mdevid=1 /export;
 > 	btrfs fi resize 1:max /export;
 > 	btrfs fi resize 2:max /export;

I'm moving from 5 to 4 disks for the time being, assuming metadata stays 
the same I guess I'd have to aim for 3GB metadata per disk. Do I have to 
change the commands like this ?

btrfs fi resize 1:-1g /export;           # Assuming 4GB metadata
btrfs fi resize 2:-2g /export;           # Assuming 5GB metadata
btrfs balance start -mdevid=1 /export;   # Why only devid 1, and not 2 ?
btrfs fi resize 1:max /export;
btrfs fi resize 2:max /export;

Thanks!

