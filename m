Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30AD13709B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 16:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgAJPEB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 10:04:01 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:43041 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgAJPEA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 10:04:00 -0500
Received: by mail-qk1-f169.google.com with SMTP id t129so2062735qke.10
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 07:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=R896M3C8CFGzpMpLjV0vDAqN5nksXKlJpUE7xg6h3jA=;
        b=bOO3gcWJ3xWUoSLOW1FknffmOlACiwXCT1l24gd4gz7SEFGIhrolTR8dIqH8FPZCsj
         B9zbtq1bQFS0rMdR5PVhQoV9IB2wzdJs7WxcpqDPe9KSFbiNIhXPQh8nGZRgCq/8FWs1
         heePpGybejJMEiz2t5ZDCqblHL2S3oAnOzuxpZcNO3hP8RyB2/4Cbi1fnKfP5N1cl4mL
         /tvVVFPPDUMgPBTAfIORvXEbmsCm8+IgZA6i11e6nLzTp5md8I5VSOOiyvMXi4PFzor7
         Th3prj8vSfMpGEAspXWsW5jqM2YN7yTFVuBm5xGb84wib10VvHdHfN3cTsu+0C9MZUHA
         Wkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R896M3C8CFGzpMpLjV0vDAqN5nksXKlJpUE7xg6h3jA=;
        b=kbBOhSpmtgbrZ7+NKc0AJL4mJhko69aY66LaK6IXnaYLqh9qj5upZCUQTgfOyp+nmh
         VW5PTn8qxECBJw7/56JqOh4nYzirRNyEXEUOl32ftyL7ypA5ulKvV8CoAjKi9Q6hT83a
         lb8ZZlEMOmnHFzYLYBlGTqG7BsBIXonKgDkJA9MipdIke8Bz7YGaUpomfYxhvLFs/PB9
         SKjLl+wSGXcQAs67kNNCX5HzeBqgHxGIKg5m2kR2LvRnZ2+6Q05Yqy32Dm+PaMble3XZ
         yE9vyDb/DxhHB5WRozfgn3lYOyCk9A675IF3FdiDc41Bhs++9YCOb2U2R46nt4EhdXRU
         94lA==
X-Gm-Message-State: APjAAAXjp1ZjTXsCQRLnDVWf+3Pe0HsaIwzu86fHXkBHTielteeJiDbY
        yWMHC4gbyGRdaKa+Mq3fWzylfhQIIa2y+g==
X-Google-Smtp-Source: APXvYqxzvgMXO+SZxM2INQgjysvHXqrhJcRKDHxSLzPcAlpUsbqTrixbtrti2m3h4AEuNYN9K9XpRg==
X-Received: by 2002:ae9:e901:: with SMTP id x1mr3355576qkf.117.1578668639023;
        Fri, 10 Jan 2020 07:03:59 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4dc2])
        by smtp.gmail.com with ESMTPSA id f23sm949128qke.104.2020.01.10.07.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 07:03:58 -0800 (PST)
Subject: Re: 5.4.8: WARNING: errors detected during scrubbing, corrected
To:     Marc MERLIN <marc@merlins.org>, linux-btrfs@vger.kernel.org
References: <20200109162839.GA29989@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5b11d0a5-b1be-decb-bc74-5b28866637ee@toxicpanda.com>
Date:   Fri, 10 Jan 2020 10:03:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109162839.GA29989@merlins.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/9/20 11:28 AM, Marc MERLIN wrote:
> Howdy,
> 
> I have 6 btrfs pools on my laptop on 3 different SSDs.
> After a few years, one of them is now very slow to scrub
> and hands my laptop while it runs.
> This started under 5.3.8, but upgrading to 5.4.8 didn't fix it.
> 

What the hell kind of laptop are you running that has 3 different SSDs?  That 
thing has got to weight a ton.

> Also, it output 'errors during scrubbing', but I see nothing in the kernel log:
> btrfs scrub start -Bd /mnt/btrfs_pool2
> scrub device /dev/mapper/pool2 (id 1) done
>          scrub started at Thu Jan  9 01:46:45 2020 and finished after 01:29:49
>          total bytes scrubbed: 1.27TiB with 0 errors
> WARNING: errors detected during scrubbing, corrected
> 
> real    89m49.190s
> user    0m0.000s
> sys     13m26.548s
> 
> 
> 89mn is also longer than normal

Can you run the bcc tool offcputime

https://github.com/iovisor/bcc/blob/master/tools/offcputime.py

while scrub is running to get a few stack traces of where we're spending all of 
our time?  It'll help narrow down who is to blame.  Thanks,

Josef
