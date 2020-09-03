Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064F625C3CA
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 16:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgICO61 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 10:58:27 -0400
Received: from mailrelay2-3.pub.mailoutpod1-cph3.one.com ([46.30.212.11]:34500
        "EHLO mailrelay2-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728603AbgICO5C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 10:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:to:subject:from;
        bh=VTIVFW2uni5Fp9feGmBdg8cIL01hborbgSD0KblA3WE=;
        b=I3+0pn3N4zfdRiTyJSgIcNle1m5NLc3tAB54J2I2Hn4/693f5AbRdzImtYF01l8TcNgYjFI5/P/Nr
         6+19x20vbWoXmuFUMgeZbpU4BbN+b7NkZNsNhf9yzvWmylrkeEoWPQY9jQA+glwcSNisE6BDGn9kJO
         +20N9Q6+PkUWsekrZURkulUB77I2j+2OPbacvLqzH1lq3YXI5zBhO0JmiYXB/CV+jF4nbc/6AtKiK/
         X7oP7/GBYRCsYoXr3BQieHCZb16uIVt7CiNn9iXMjtLFhKU4WiRHAqgS8W3/LLEGS81FHcQZTzHjUw
         U6dqMYCBO+Sz2FJk0h2wxQJBpxpaoXQ==
X-HalOne-Cookie: 6d1be7d600017d895fa4f08e1f34be878d5636e1
X-HalOne-ID: b21169f7-edf5-11ea-84a0-d0431ea8a290
Received: from [10.0.88.22] (unknown [98.128.186.78])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id b21169f7-edf5-11ea-84a0-d0431ea8a290;
        Thu, 03 Sep 2020 14:56:50 +0000 (UTC)
Subject: Re: Btrfs RAID-10 performance
To:     =?UTF-8?Q?Miloslav_H=c5=afla?= <miloslav.hula@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <b12ff987-e631-8202-246e-1b72142ab8e3@gmail.com>
From:   A L <mail@lechevalier.se>
Message-ID: <7b364356-7041-7d18-bd77-f60e0e2e2112@lechevalier.se>
Date:   Thu, 3 Sep 2020 16:56:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b12ff987-e631-8202-246e-1b72142ab8e3@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 2020-09-03 15:13, Miloslav Hùla wrote:
> Hello,
>
> we are using btrfs RAID-10 (/data, 4.7TB) on a physical Supermicro 
> server with Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz and 125GB of 
> RAM. We run 'btrfs scrub start -B -d /data' every Sunday as a cron 
> task. It takes about 50 minutes to finish.
>
> # uname -a
> Linux imap 4.9.0-12-amd64 #1 SMP Debian 4.9.210-1 (2020-01-20) x86_64 
> GNU/Linux
>
> RAID is a composition of 16 harddrives. Harddrives are connected via 
> AVAGO MegaRAID SAS 9361-8i as a RAID-0 devices. All harddrives are SAS 
> 2.5" 15k drives.
>
> Server serves as a IMAP with Dovecot 2.2.27-3+deb9u6, 4104 accounts, 
> Mailbox format, LMTP delivery.
>
> We run 'rsync' to remote NAS daily. It takes about 6.5 hours to 
> finish, 12'265'387 files last night.
>
>
> Last half year, we encoutered into performace troubles. Server load 
> grows up to 30 in rush hours, due to IO waits. We tried to attach next 
> harddrives (the 838G ones in a list below) and increase a free space 
> by rebalace. I think, it helped a little bit, not not so rapidly.
>
> Is this a reasonable setup and use case for btrfs RAID-10? If so, are 
> there some recommendations to achieve better performance?
>
> Thank you. With kind regards
> Milo
>
Hi,

I think that with your use-case of  lots of concurrent reads and writes, 
It may be better to use using RAID1. This would ensure two copies on 
separate disks for all chunks of data. In turn, this means 8 parallel 
reads/writes instead of only 4 with RAID10. With RAID10 you will engage 
4 drives for every read/write.

