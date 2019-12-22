Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC417128F26
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 18:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLVRnc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 12:43:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40927 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVRnc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 12:43:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id c17so11870199qkg.7
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2019 09:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LfTeLXcOImst0FykELhbJB9Dg7wrL474+ESvkqXUobE=;
        b=xdEEjto05B7mIZAi66JfZqBADKxk+EkFKVG5VAqOEER1+EVuY+KqJYjLWiKBbyvHjx
         yk4zFKQPAiyxltAC6FZs1Yg1EhrmJLSB6IUgaqCrwYj1g3NXDCUXtg16ahcSVDKSLixT
         STZCbL59ISzjjLvjKnx36kWWRRCa/sVYz/6aLLnAxwRfTwMWD/XM81KU15VnD/+lPAtU
         HMuFNQVPVwkLMEYaav1qcrKGptfcRxmuCHrY5O+oC/jiFTihuWr7Ep8Ej/SBJRLOE4O/
         kXZ2hW1CjJCiFLLpz+hw+kWy7FX1wHzj1rcR9PZ99eB7wSMTG47IrW7TKYBs6mxExhpL
         QDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LfTeLXcOImst0FykELhbJB9Dg7wrL474+ESvkqXUobE=;
        b=AdEo7HeBNSgfP6izzWxp7BM2e7iMOK/5AsVizhgw93AGAVn08LDFRUPpgeE5Nws3u9
         2OFLmGpnurJWol6gtryUm6BPzftee1YEinjwUwFA9/GXW0c5cLDoSOaNRxDvKIHhq6Zb
         MV6dMVfwkdirCQmJ3Rq+G5muVnLpgReJQ/vJS++HDqAd6moirD8JoDaXUVo7Czy7Dg0I
         LcRBPM8lgxoZuYQ07rtkmFW8DWjQ47kTzRyz0HBv+8MV7e2bsCt/oWqWAD6udav+BPxE
         Ww3kSzsR2+qvrnTPFrepq5zyCGxLYJK+xskrYV+FXJphqy5Kz1QTTtBnXszHR6LQoAjp
         vdIQ==
X-Gm-Message-State: APjAAAXB9TUnPUhqPWcY8CnQf9VU4kNsbg4LMWz/pcpbhxMADAe+/AdL
        6eeW7Z3ZPfPZRIMFxS0vwlFoYUyzocaFbg==
X-Google-Smtp-Source: APXvYqwZ7Sw9mMzvWoHhD45WiEZ2/FzjPf5iUn3h/UDxYnIkpb6d8DrrurdWuaO8y6Xu8fEq/+buOw==
X-Received: by 2002:a05:620a:143a:: with SMTP id k26mr23106901qkj.450.1577036610902;
        Sun, 22 Dec 2019 09:43:30 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4a6d])
        by smtp.gmail.com with ESMTPSA id m21sm4979536qka.117.2019.12.22.09.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 09:43:30 -0800 (PST)
Subject: Re: fstrim is takes a long time on Btrfs and NVMe
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c246f5e9-c9b6-8323-9e2d-26f17051df6a@toxicpanda.com>
Date:   Sun, 22 Dec 2019 12:43:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/19 1:24 AM, Chris Murphy wrote:
> Hi,
> 
> Recent kernels, I think since 5.1 or 5.2, but tested today on 5.3.18,
> 5.4.5, 5.5.0rc2, takes quite a long time for `fstrim /` to complete,
> just over 1 minute.
> 
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/nvme0n1p7  178G   16G  161G   9% /
> 
> fstrim stops on this for pretty much the entire time:
> ioctl(3, FITRIM, {start=0, len=0xffffffffffffffff, minlen=0}) = 0
> 
> top shows the fstrim process itself isn't consuming much CPU, about
> 2-3%. Top five items in per top, not much more revealing.
> 
> Samples: 220K of event 'cycles', 4000 Hz, Event count (approx.):
> 3463316966 lost: 0/0 drop: 0/0
> Overhead  Shared Object                    Symbol
>     1.62%  [kernel]                         [k] find_next_zero_bit
>     1.59%  perf                             [.] 0x00000000002ae063
>     1.52%  [kernel]                         [k] psi_task_change
>     1.41%  [kernel]                         [k] update_blocked_averages
>     1.33%  [unknown]                        [.] 0000000000000000
> 
> On a different system, with older Samsung 840 SATA SSD, and a fresh
> Btrfs, I can't reproduce. It takes less than 1s. Not sure how to get
> more information.
> 
> 

You want to try Dennis's async discard stuff?  That should fix these problems 
for you, the patches are in Dave's tree.  Thanks,

Josef

