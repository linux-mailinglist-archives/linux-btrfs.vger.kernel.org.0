Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6192F068E
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 12:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbhAJLIJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jan 2021 06:08:09 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:48888 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbhAJLIJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 06:08:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id B19303F57C;
        Sun, 10 Jan 2021 12:07:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.154
X-Spam-Level: 
X-Spam-Status: No, score=-2.154 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.255, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MY2tYtnOGLMT; Sun, 10 Jan 2021 12:07:10 +0100 (CET)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id BCEC83F567;
        Sun, 10 Jan 2021 12:07:10 +0100 (CET)
Received: from [192.168.0.10] (port=51952)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <forza@tnonline.net>)
        id 1kyYYv-0008rB-TS; Sun, 10 Jan 2021 12:07:09 +0100
Subject: Re: btrfs send / receive via netcat, fails halfway?
To:     Cedric.dewijs@eclipso.eu, linux-btrfs@vger.kernel.org
References: <0440549b7c78763ce787b03341ca5b9f@mail.eclipso.de>
From:   Forza <forza@tnonline.net>
Message-ID: <68cb868e-d282-ad7b-73e4-b285a45606d3@tnonline.net>
Date:   Sun, 10 Jan 2021 12:07:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0440549b7c78763ce787b03341ca5b9f@mail.eclipso.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-01-10 11:34, Cedric.dewijs@eclipso.eu wrote:
> ­I'm trying to transfer a btrfs snapshot via the network.
> 
> First attempt: Both NC programs don't exit after the transfer is complete. When I ctrl-C the sending side, the receiving side exits OK.
> 
> btrfs subvolume delete /mnt/rec/snapshots/*
> receive side:
> # nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
> At subvol 0
> 
> sending side:
> # btrfs send  /mnt/send/snapshots/0 | nc -v 127.0.0.1 6790
> At subvol /mnt/send/snapshots/0
> localhost [127.0.0.1] 6790 (hnmp) open
> 
> 
> 
> Second attempt: both nc programs exit ok at snapshot 0,1,2, but snapshot3 fails halfway, and 4 fails, as 3 is not complete.
> receive side:
> # nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
> At subvol 0
> # nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
> At snapshot 1
> # nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
> At snapshot 2
> # nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
> At snapshot 3
> read(net): Connection reset by peer
> ERROR: short read from stream: expected 49183 read 10450
> # nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
> At snapshot 4
> ERROR: cannot find parent subvolume
> write(stdout): Broken pipe
> 
> sending side:
> # btrfs send  /mnt/send/snapshots/0 | nc -v -c 127.0.0.1 6790
> At subvol /mnt/send/snapshots/0
> localhost [127.0.0.1] 6790 (hnmp) open
> # btrfs send -p /mnt/send/snapshots/0 /mnt/send/snapshots/1 | nc -v -c  127.0.0.1 6790
> At subvol /mnt/send/snapshots/1
> localhost [127.0.0.1] 6790 (hnmp) open
> # btrfs send -p /mnt/send/snapshots/1 /mnt/send/snapshots/2 | nc -v -c  127.0.0.1 6790
> At subvol /mnt/send/snapshots/2
> localhost [127.0.0.1] 6790 (hnmp) open
> # btrfs send -p /mnt/send/snapshots/2 /mnt/send/snapshots/3 | nc -v -c  127.0.0.1 6790
> At subvol /mnt/send/snapshots/3
> localhost [127.0.0.1] 6790 (hnmp) open
> # btrfs send -p /mnt/send/snapshots/3 /mnt/send/snapshots/4 | nc -v -c  127.0.0.1 6790
> At subvol /mnt/send/snapshots/4
> localhost [127.0.0.1] 6790 (hnmp) open
> write(net): Connection reset by peer
> 
> 
> 

Hi,

Haven't used netcat for btrfs send, so I am not sure why you have these 
issues. Have you tried mbuffer instead? This is what I use when I don't 
need to go over ssh.

Mbuffer[1] allows you to specify remote host and port. It also has an 
async buffer so it should be a bit faster too. In fact, it is useful on 
a localhost too, for example when sending snaps to a slower local backup 
media.

Receiving side:
# mbuffer -I port | btrfs receive /mnt/rec/snapshots

Sending side:
# btrfs send /mnt/send/snapshots/0 | mbuffer -O remotehost:port

Good Luck!

//Forza

[1]https://www.maier-komor.de/mbuffer.html





