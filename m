Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9548C353061
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Apr 2021 22:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhDBUqc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Apr 2021 16:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBUqc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Apr 2021 16:46:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF270C0613E6
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Apr 2021 13:46:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ap14so8908138ejc.0
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Apr 2021 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PNnIVkrACs0T/v0Fnnbzf7o5Fwuh15mzR8OPUcfEtCA=;
        b=EPBeR7gcX7PfX5OQB0EFc5pXEZd+qSx3HrUyLeAcpN5RHSpx0L9InMm/9QlNCdqZWy
         sF66y5Qblg+boXsgfh/+bxyVvg8xeEq/cZ8NFnyWpChyAR4aEpazdxbIlAhdL+87rpAA
         tw4QZHWWh8zNCZ8I+5duSkLCplgQznB2gKtMQLhjlaVLHrtv/ww4mt6UNRsz9RkFjD++
         WS3N+QVVrunoyP5dU7OV5Kz6bR+sQKrtk/ip5M4iXDYKj2LaUme8rCpLIyAfzojlAdN+
         ilNI8qSFvm9loScnO/rdgIbiJUWzCdpLz3s7ZHbwS5XKuLhOXPgX79RdX9GoaIF0EZik
         IXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PNnIVkrACs0T/v0Fnnbzf7o5Fwuh15mzR8OPUcfEtCA=;
        b=fgLL3yjncQg/m3YXsyfVwZZC4hKRf+c/FEQzdksp+RDcmFodF6zcKK3YZjAJneVjJ6
         6WZzFnBu4uJKkyqPaxTIasWonEOLlPC9NOY8cXEe2OGKLOLa0yJ6UBvVZUu1QqtunbPt
         isCoJxdo2hCRhoXM9rVOypvefr6HLw0ieGPVnlGocERnXdPjBTW3w0DGIjvFG7KXzjVo
         Dn4A1OnasFpm7Bxkta6tLRbHZEdlP+gEssiLkvAJD8YpM5fcUZ5qmsXstUllj4T0udLj
         vvAcxbKrrDKOMtvKLeWeR/kkhSkS8MLjcWBM7aXlDMy4cAw0lRFQftgEg96D4+1z6dmI
         CkyQ==
X-Gm-Message-State: AOAM5324KwInO4UwupQ2C2e4S78Zn8Lpl91lqrVKaq/e7RX4a9uh32YA
        5QorI2ezeeb7UC5bh1vINatbFVUxXFROrg==
X-Google-Smtp-Source: ABdhPJxtT1L/7jPYdejviM+RMSXEhIBCgPybEbqV8GmZcdPnd0DrBBovT+/9dPydWoDWsgYzOoz5jg==
X-Received: by 2002:a17:907:3ea6:: with SMTP id hs38mr16017965ejc.387.1617396387522;
        Fri, 02 Apr 2021 13:46:27 -0700 (PDT)
Received: from [192.168.1.11] (b2b-94-79-184-225.unitymedia.biz. [94.79.184.225])
        by smtp.gmail.com with ESMTPSA id n16sm6028518edr.42.2021.04.02.13.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 13:46:26 -0700 (PDT)
Subject: Re: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd
 2719033, flush 0, corrupt 6, gen 0
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <ef3da480-d00d-877e-2349-6d7b2ebda05e@gmail.com>
 <20210313152146.1D7D.409509F4@e16-tech.com>
 <cefa397a-c39a-78c3-5e85-f6a9951de7d8@gmail.com>
 <CAJCQCtR5zeC=jNRf0iSHpqQXDOBExfFzfGj+PzMTxs_S1JVmVg@mail.gmail.com>
From:   Thomas <74cmonty@gmail.com>
Message-ID: <57292e4b-549d-9ce1-7967-32e6820c80e5@gmail.com>
Date:   Fri, 2 Apr 2021 22:46:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtR5zeC=jNRf0iSHpqQXDOBExfFzfGj+PzMTxs_S1JVmVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I finished repartition of devices /dev/sda + /dev/sdb now.
On both devices the first partition is equal in size:
$ sudo fdisk -l /dev/sda
Festplatte /dev/sda: 238,47 GiB, 256060514304 Bytes, 500118192 Sektoren
Festplattenmodell: SanDisk SD8SBAT2
Einheiten: Sektoren von 1 * 512 = 512 Bytes
Sektorgröße (logisch/physikalisch): 512 Bytes / 512 Bytes
E/A-Größe (minimal/optimal): 512 Bytes / 512 Bytes
Festplattenbezeichnungstyp: dos
Festplattenbezeichner: 0x0914a19b

Gerät      Boot    Anfang      Ende  Sektoren Größe Kn Typ
/dev/sda1            2048 497027071 497025024  237G 83 Linux
/dev/sda2       497027072 500118191   3091120  1,5G 82 Linux Swap / Solaris


$ sudo fdisk -l /dev/sdb
Festplatte /dev/sdb: 238,47 GiB, 256060514304 Bytes, 500118192 Sektoren
Festplattenmodell: SanDisk SD9TB8W2
Einheiten: Sektoren von 1 * 512 = 512 Bytes
Sektorgröße (logisch/physikalisch): 512 Bytes / 512 Bytes
E/A-Größe (minimal/optimal): 512 Bytes / 512 Bytes
Festplattenbezeichnungstyp: dos
Festplattenbezeichner: 0xf23fc590

Gerät      Boot Anfang      Ende  Sektoren Größe Kn Typ
/dev/sdb1         2048 497027071 497025024  237G 83 Linux


However, the output of btrfs insp dump-s <device> is still different:
$ sudo btrfs insp dump-s /dev/sda1 | grep dev_item.total_bytes
dev_item.total_bytes    254476812288

$ sudo btrfs insp dump-s /dev/sdb1 | grep dev_item.total_bytes
dev_item.total_bytes    256059465728


Can you please advise how to fix this?
My understanding is that size of btrfs superblock must be equal on both
devices.


THX


Am 13.03.21 um 19:02 schrieb Chris Murphy:
> On Sat, Mar 13, 2021 at 5:22 AM Thomas <74cmonty@gmail.com> wrote:
>
>> Gerät      Boot Anfang      Ende  Sektoren  Größe Kn Typ
>> /dev/sdb1         2048 496093750 496091703 236,6G 83 Linux
>> However the output of btrfs insp dump-s <device> is different:
>> thomas@pc1-desktop:~
>> $ sudo btrfs insp dump-s /dev/sdb1 | grep dev_item.total_bytes
>> dev_item.total_bytes    256059465728
> sdb1 has 253998951936 bytes which is *less* than the btrfs super block
> is saying it should be. 1.919 GiB less. I'm going to guess that the
> sdb1 partition was reduced without first shrinking the file system.
> The most common way this happens is not realizing that each member
> device of a btrfs file system must be separately shrunk. If you do not
> specify a devid, then devid 1 is assumed.
>
> man btrfs filesystem
> "The devid can be found in the output of btrfs filesystem show and
> defaults to 1 if not specified."
>
> I bet that the file system was shunk one time, this shrunk only devid
> 1 which is also /dev/sda1. But then both partitions were shrunk
> thereby truncating sdb1, resulting in these errors.
>
> If that's correct, you need to change the sdb1 partition back to its
> original size (matching the size of the sdb1 btrfs superblock). Scrub
> the file system so sdb1 can be repaired from any prior damage from the
> mistake. Shrink this devid to match the size of the other devid, and
> then change the partition.
>
>
>
>> Gerät      Boot    Anfang      Ende  Sektoren  Größe Kn Typ
>> /dev/sda1  *         2048 496093750 496091703 236,6G 83 Linux
>>
>> thomas@pc1-desktop:~
>> $ sudo btrfs insp dump-s /dev/sda1 | grep dev_item.total_bytes
>> dev_item.total_bytes    253998948352
> This is fine. The file system is 3584 bytes less than the partition.
> I'm not sure why it doesn't end on a 4KiB block boundary or why
> there's a gap before the start of sda2...but at least it's benign.
>
>

