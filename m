Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 205271A1835
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 00:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDGWaH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 18:30:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34270 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgDGWaG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Apr 2020 18:30:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id 65so5693058wrl.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Apr 2020 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nx+hSrvSzrfSTkCadja1qhveADTwSvyZ63RDj9Yn6dc=;
        b=kdSBkY+PlgDaAl+XViMtbvesS5lrmzGfr/RTA7MXg1gB0bMzEAx2iEtNkeMGZF2A47
         UG2x3od3qTY+OHl1LKXe5ovD6nONxuMvRYrJFG2XqJN9aYZLJNo8N7Q9+VCJzA6z6/L1
         53zPiNiIafyRNWK/r30tuadge7h6uiiyHCAevdN3XxVMfpJyNCMpt/Ymk6byNOCcz3PV
         q1V/XVO5l7N7w/whKEil0ZyewjcO/vlDZxGWpO0uslcGMQxIYVhjq1SodzEQn8UVNSZE
         KOeoU83Yl/O3YkmH3ShpHb0g520ArGKomPJWyZLtLhI5t7MM1wqLcUKa/ORX16wHcZUT
         anzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nx+hSrvSzrfSTkCadja1qhveADTwSvyZ63RDj9Yn6dc=;
        b=rj1ay51+HKjHXzCqJOJRjykXJ4q2TEVQjoiX77Z7Dxpk2b0i2A78ZZ8VQi6zhBO+ft
         4my2w3flIN3X05Uwl9UEabf+VP3JZY2ruDXqWFA/glgCIq42vUFS6nsJ9SKQ90taxmkJ
         RCbZDgVBD05G5/BLpBTxsZd6GM41L5euttN4qqfcYY7drrJi0ZnGALLwJnzPTjXhGsVg
         BJB2Iea2EPtwlSzDNe453GCpWfeuVml86KqF8qT5ZzTX5vrVePHq2CCy7v8hZIg/9M4z
         uMAMSBYzxbLTBGYr0pyV7keMRFbUjwOrxpF1Pp337OfxuWO3yo0ZmoW1SEVjnt4Dfr1i
         rxqg==
X-Gm-Message-State: AGi0PuaRjrJWs6KIAdPH1NYR+7xWQHw1z749kPgL0YLZ3Cm9UEvtIFwf
        kucfu+VjVG+XXM79WuOyB3g=
X-Google-Smtp-Source: APiQypIXGfTqff7O5Bi0HkqcOEukUus5IRv+1nRXndsNP05fTRmEFN2QrLlEbVCT4I3REIRAGfekaA==
X-Received: by 2002:adf:90ea:: with SMTP id i97mr4853769wri.123.1586298603947;
        Tue, 07 Apr 2020 15:30:03 -0700 (PDT)
Received: from ?IPv6:2001:984:3171:0:126:e139:19f1:9a46? ([2001:984:3171:0:126:e139:19f1:9a46])
        by smtp.gmail.com with ESMTPSA id a67sm4393300wmc.30.2020.04.07.15.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 15:30:03 -0700 (PDT)
Subject: Re: btrfs freezing on writes
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <6a1c8ce0-ce2a-698d-dcc6-0657a125dae4@gmail.com>
 <CAJCQCtRcTzL9LQZppvCj4zg2NpvGUri0QS58wY3E_PG+o0Jchg@mail.gmail.com>
 <CAJCQCtQ6C4kvBQaKMaoPBo8jbj-abNEYh_63-d-EkHVgWq6iPg@mail.gmail.com>
 <4ef177eb-4b06-3b76-bf5c-5cf6df3221f7@gmail.com>
 <CAJCQCtTJQOZ-t6RZuG2ifPMFtEeHRjP6h6SeTc5ysHi-ekMTbQ@mail.gmail.com>
From:   kjansen387 <kjansen387@gmail.com>
Message-ID: <6c75deea-cdf5-ad2f-1244-c6016baa9dfd@gmail.com>
Date:   Wed, 8 Apr 2020 00:30:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTJQOZ-t6RZuG2ifPMFtEeHRjP6h6SeTc5ysHi-ekMTbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ah, true, sync -f does a syncfs.

sync without -f on an existing file is always fast. But when I strace 
vim, fsync is slow (sometimes >10 seconds) because it needs to write 
something.

Hopefully a developer can reply - thanks so far!



On 08-Apr-20 00:11, Chris Murphy wrote:
> On Tue, Apr 7, 2020 at 2:39 PM kjansen387 <kjansen387@gmail.com> wrote:
> 
> 
> 
>> $ grep /export /etc/fstab
>> UUID=8ce9e167-57ea-4cf8-8678-3049ba028c12 /export       btrfs
>> device=/dev/sde,device=/dev/sdf    0 2
> 
> I'd use only noatime for options. There's no advantage of specifying
> devices. And also fs_passno can be 0. fsck.btrfs is a no op anyway, so
> it doesn't hurt anything to leave it at 2.
> 
> 
> 
>> I've attached sysstat info of my disks. What's obvious is that 2 disks
>> have the load (one is written to, the other one is the mirror), and 3
>> are pretty idle. But, it's 2.4MB per second - that's not much!
> 
> Lots of small file writes maybe? What's iostat show for utilization?
> Or vmstat for io? Hard drives of course have limited IO per second.
> 
>> I've just changed the space_cache to v2, but it doesn't seem to help
>> much. 'sync -f /export/tmp' still takes very long at times (just took 22
>> seconds!)
> 
> I just did a strace on this command and it uses syncfs, not fsync. I'm
> pretty sure on Btrfs this is a full filesystem sync, which is
> expensive, all data and metadata. So if it's very dirty, yeah it could
> take some time to flush everything to disk.
> 
> Try it without -f and you'll get fsync.
> 
> 
>> Any way we can find the cause, before I move everything into subvolumes
>> ? I'd like to avoid that if possible. Sounds a bit overkill for 2.4MB/s
>> writes, and I think most of it is going to one influxdb database anyway.
> 
>  From the sysrq...
> [937013.794093] mysqld          D    0 10400      1 0x00004000
> [937013.794240]  do_fsync+0x38/0x70
> 
> [937013.794253] mysqld          D    0 10412      1 0x00004000
> [937013.794297]  do_fsync+0x38/0x70
> 
> [937013.794306] mysqld          D    0 10421      1 0x00004000
> [937013.794353]  do_fsync+0x38/0x70
> 
> [937013.794788] WTJourn.Flusher D    0 1186978 1186954 0x00004320
> [937013.794894]  do_fsync+0x38/0x70
> 
> [937013.794903] ftdc            D    0 1186980 1186954 0x00000320
> [937013.794951]  ? btrfs_create+0x200/0x200 [btrfs]
> 
> [937013.795022] influxd         D    0 2082782      1 0x00004000
> [937013.795086]  do_fsync+0x38/0x70
> 
> [937013.795098] influxd         D    0 2082804      1 0x00004000
> [937013.795143]  do_fsync+0x38/0x70
> 
> [937013.795191] vim             D    0 2228648 2223845 0x00004000
> [937013.795286]  do_fsync+0x38/0x70
> 
> Quite a lot of fsync all at once.
> 
> But I'm not very good at parsing kernel output. Maybe a developer will
> have input.
> 
> 
> 
