Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E81B013B3D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 21:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgANUxI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 15:53:08 -0500
Received: from smtp.mujha-vel.cz ([81.30.225.246]:45127 "EHLO
        smtp.mujha-vel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgANUxI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 15:53:08 -0500
Received: from [81.30.250.3] (helo=[172.16.1.2])
        by smtp.mujha-vel.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jn@forever.cz>)
        id 1irTBP-0007du-R7; Tue, 14 Jan 2020 21:53:05 +0100
Subject: Re: slow single -> raid1 conversion (heavy write to original LVM
 volume)
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <107f8e94-78bc-f891-0e1b-2db7903e8bde@forever.cz>
 <CAJCQCtSeq=nY7HTRjh0Y_0PRJt579HwromzS0NkdF4U6kn_wiA@mail.gmail.com>
 <2e55d20c-323f-e1a2-cdde-8ba0d50270e7@forever.cz>
 <CAJCQCtQhVQrnq7QnTd6ryDSg4SAGv55ceJ+H8LTM6MEYzQX4jQ@mail.gmail.com>
From:   jn <jn@forever.cz>
Message-ID: <ce3fb06f-5a24-df55-f1b5-a0c2b176ec13@forever.cz>
Date:   Tue, 14 Jan 2020 21:53:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQhVQrnq7QnTd6ryDSg4SAGv55ceJ+H8LTM6MEYzQX4jQ@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hello Chris,

here it is:  http://www.uschovna.cz/en/zasilka/TWGCD2G39WBH9G8N-XFE 
(since I have limited journald space, beginning of events was
overwritten already, so it's assembled from syslog files)

jn


current device & fs usage:

root@sopa:~# btrfs dev usa /data
/dev/mapper/sopa-data, ID: 1
   Device size:             1.86TiB
   Device slack:              0.00B
   Data,single:             1.84TiB
   Metadata,single:         8.00MiB
   Metadata,DUP:           13.00GiB
   System,single:           4.00MiB
   System,DUP:             16.00MiB
   Unallocated:               0.00B

/dev/sdb3, ID: 2
   Device size:             1.86TiB
   Device slack:              0.00B
   Unallocated:             1.86TiB

root@sopa:~# btrfs fi usa /data
Overall:
    Device size:           3.71TiB
    Device allocated:           1.86TiB
    Device unallocated:           1.86TiB
    Device missing:             0.00B
    Used:               1.05TiB
    Free (estimated):           2.65TiB    (min: 1.73TiB)
    Data ratio:                  1.00
    Metadata ratio:              2.00
    Global reserve:         512.00MiB    (used: 0.00B)

Data,single: Size:1.84TiB, Used:1.04TiB
   /dev/mapper/sopa-data       1.84TiB

Metadata,single: Size:8.00MiB, Used:0.00B
   /dev/mapper/sopa-data       8.00MiB

Metadata,DUP: Size:6.50GiB, Used:3.00GiB
   /dev/mapper/sopa-data      13.00GiB

System,single: Size:4.00MiB, Used:0.00B
   /dev/mapper/sopa-data       4.00MiB

System,DUP: Size:8.00MiB, Used:224.00KiB
   /dev/mapper/sopa-data      16.00MiB

Unallocated:
   /dev/mapper/sopa-data         0.00B
   /dev/sdb3       1.86TiB


On 14. 01. 20 21:09, Chris Murphy wrote:
> I think it got clipped. And also the MUA is wrapping it and making it
> hard to read. I suggest 'journalctl -k -o short-monotonic' because
> what started the problem might actually be much earlier and there's no
> way to know that without the entire thing. Put that up in a dropbox or
> pastebin or google drive or equivalent. And hopefully a dev will be
> able to figure out why it's hung up. All I can tell from the above is
> that it's hung up on cancelling, which doesn't say much.
>
> _handle_mm_fault is suspicious. On second thought, I suggest doing
> sysrq+t. And then output journalctl -k, and post that. It'll have the
> complete dmesg, the sysrq+w, and +t. That for sure won't post to the
> list, it'll be too long, and the way MUA's wrap it, it's hard to read.
>
> -- Chris Murphy


