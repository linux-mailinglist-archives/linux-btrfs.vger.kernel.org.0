Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0E9E459
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 11:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfH0Jdb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 05:33:31 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:50758 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbfH0Jdb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 05:33:31 -0400
Received: by mail-wm1-f48.google.com with SMTP id v15so2333635wml.0
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 02:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=bJ2QyIWqENyTT2hWJJohBUOKSFcc0b/uY0usNC2JmYE=;
        b=BvrQNA9AiTFzEoZtQQoGkAKnz/f3BOANBGrwUpAvgqMY9DjEnJwSq70U1sglpJyuxE
         VO/4ncfhHsDPV3muI5hULEnvBDM+U7eW8ur2bHIuoJSLQcdiX78Qz52omzS64xAbxskO
         qDLk+zzwaZuheC+PzwtZy7JnyX3aAKts4CY+CC8iu0PQmXjrqKaKJHdiw7CcKMulDF6k
         y/gS8LGkRtjWHUYhee2SMqorQk1z7r6ESJ8vDi/q+rdb7h1mzPPGJcXj8YoMcUlduJ4Z
         q8QJrZlgAyVhyMBcu4nN12dq7YLcvNQHY71/rx0hxdji3ijFS7aCW8hw5Sqdc32Yz8mS
         3QLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=bJ2QyIWqENyTT2hWJJohBUOKSFcc0b/uY0usNC2JmYE=;
        b=tWsFoM6svqejEI6bcVlz3I0rIn1jvuISr7xDHfPU7Aon2vUKPFKb/caC3xvC+JvZgi
         DSMb9aEliETTa5cb5FIgzpq9TLzX5zizIkQbQgvykmRFzQ9lMnYBc2p3Wqt8R5IItjYi
         I+Blhf0ASXGvAUxWWPFX3PIozu5PuZW/f4BvmAncjoUqBVkRWWP0BDOeBGh9U7o1JpcW
         VUkK+pam6nsQz3Kzh7GpsFkFwF8ERUDRHDjOGCzm1fuu2lbebXqMq2L82+Ptgpk1aroo
         Is9qeY4la6Hujx/ROamST3gn7NoonqGUnY6HbgmOiUBWvVKMSkqbg6NHI1DqtFhzuFeY
         1Klg==
X-Gm-Message-State: APjAAAV5fwK/JSBWs1+Hn3bfo/qUMv1EphcZL13j/S3wVsggssC/iSZ8
        0NIdNDTZW3tYrwSy/0LGWqs+5kb9
X-Google-Smtp-Source: APXvYqzvEv3TGQrPFrup5o7hN66+02B4quGSVTgO5ocnK5xcU/bBWCl264WDF2vCCg4lI7GRUJX2sg==
X-Received: by 2002:a1c:7c06:: with SMTP id x6mr27475511wmc.133.1566898408286;
        Tue, 27 Aug 2019 02:33:28 -0700 (PDT)
Received: from [10.19.90.60] ([193.16.224.12])
        by smtp.gmail.com with ESMTPSA id m7sm4202558wmi.18.2019.08.27.02.33.27
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 02:33:27 -0700 (PDT)
From:   Thomas Schneider <74cmonty@gmail.com>
Subject: No files in snapshot
To:     linux-btrfs@vger.kernel.org
Message-ID: <b729e524-3c63-cf90-7115-02dcf2fda003@gmail.com>
Date:   Tue, 27 Aug 2019 11:33:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm running Debian 10 with btrfs-progs=5.2.1.
Creating snapshots with snapper=0.8.2 works w/o errors.
root@ld5507:~# uname -r
5.0.18-1-pve
root@ld5508:~# btrfs fi show
Label: none  uuid: 70997a0b-a36f-46cf-9ddc-b88d47eabc9e
         Total devices 1 FS bytes used 11.17GiB
         devid    1 size 192.53GiB used 22.02GiB path /dev/sdbq3

root@ld5507:~# btrfs fi df /
Data, single: total=18.00GiB, used=10.71GiB
System, DUP: total=8.00MiB, used=16.00KiB
Metadata, DUP: total=2.00GiB, used=465.84MiB
GlobalReserve, single: total=68.03MiB, used=0.00B

However, I run into an issue and need to restore various files.

I thought that I could simply take the files from a snapshot created before.
However, the files required don't exist in any snapshot!

Therefore I have created a new snapshot manually to verify if the files 
will be included, but there's nothing.

These files are required:
root@ld5507:/usr/bin# ls -l /var/lib/ceph/osd/ceph-4/
insgesamt 56
-rw-r--r-- 1 root root 402 Jun  7 12:18 activate.monmap
-rw-r--r-- 1 ceph ceph   3 Jun  7 12:18 active
lrwxrwxrwx 1 ceph ceph  58 Jun  7 12:18 block -> 
/dev/disk/by-partuuid/3bc0c812-2c6b-4544-bbe7-e0444c3448eb
-rw-r--r-- 1 ceph ceph  37 Jun  7 12:18 block_uuid
-rw-r--r-- 1 ceph ceph   2 Jun  7 12:18 bluefs
-rw-r--r-- 1 ceph ceph  37 Jun  7 12:18 ceph_fsid
-rw-r--r-- 1 ceph ceph  37 Jun  7 12:18 fsid
-rw------- 1 ceph ceph  56 Jun  7 12:18 keyring
-rw-r--r-- 1 ceph ceph   8 Jun  7 12:18 kv_backend
-rw-r--r-- 1 ceph ceph  21 Jun  7 12:18 magic
-rw-r--r-- 1 ceph ceph   4 Jun  7 12:18 mkfs_done
-rw-r--r-- 1 ceph ceph   6 Jun  7 12:18 ready
-rw-r--r-- 1 ceph ceph   3 Aug 23 09:56 require_osd_release
-rw-r--r-- 1 ceph ceph   0 Aug 21 12:41 systemd
-rw-r--r-- 1 ceph ceph  10 Jun  7 12:18 type
-rw-r--r-- 1 ceph ceph   2 Jun  7 12:18 whoami

And there are not files in latest snapshot:
root@ld5507:/usr/bin# ls -l 
/btrfs/@snapshots/158/snapshot/var/lib/ceph/osd/ceph-4/
insgesamt 0


Why is this?

THX

