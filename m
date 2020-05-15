Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA4C1D4589
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 08:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEOGDg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 02:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726137AbgEOGDg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 02:03:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FED9C061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 14 May 2020 23:03:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j5so2064000wrq.2
        for <linux-btrfs@vger.kernel.org>; Thu, 14 May 2020 23:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=0KhfBx7SOYWGEVnrQ73f2B539NqjMbxsSbjcX6V/o1E=;
        b=knFjahvzySJVuaHvGKsyLHZrU0Sg3p0YtFInARFmYkZBiPY6WHp8KA/l5Lyd1/TZTR
         rTDxhVuiniSKev4ay4V7kKtiVAJCe3XNkVkRspyieTfqpGr5V4VeH0wuOQ5pFeie44Em
         4YkA8m65j1MxK3hXEQgmE/cDHZ5G+fCgRgYretyAVqh9RRM49fvYUMEyI1VfrrWXV0E/
         iEbHA7P9J4oJmPgMt+Bq2Jy5yhZNZbWXWPkQV9TtvMJ81ZFfZqVIN6o9ic58UP4UNaAF
         3m9ZqALuBVKQknMdBpjXxsqYmjp1KUUEzHutPVaowJepsHZ8KYnOGZDn6h9h+VOamuDB
         7a3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=0KhfBx7SOYWGEVnrQ73f2B539NqjMbxsSbjcX6V/o1E=;
        b=Fr+64ENXMefTMUHOPCUnu824ZfKmyM/eZhRpthu2+AqnAeaHztYMUrCH68Tf6je19J
         kyi3Tx3R55K/bHrqF5bnemKnOHC7e2AQetxgUI9jOlM0yVTUG9q3704WSBT23G85csLL
         oQwv3d+u/H3nnLQhiev8uC3F8NfWx78ptegjolzV++q49Ric+fCZsRIfUc23EFoYJMCl
         Hf+ESmFooRKQGh4Yao9pRsHducKLwp3EUslEl688veCx6Hn0d2bzKekAL2HwqwI0zqJW
         NxyMqBQQDZWAEIBguLVd7x6PbXxIhDH/WYL7++U28TfRYkwHp478NnjImARlrBcqcPOF
         E3PA==
X-Gm-Message-State: AOAM531evPRgve6SZyqQrIHrwyKXKjaFEE/l7haUBPCtxK5WnFttDxhP
        4BpL3MIrTZHe/WjltIiac8vTrKu3cIw=
X-Google-Smtp-Source: ABdhPJwBs3EtixZms3Rh4hNa69LZP48k3jrs9PtG6h8g7K1k1YMdQY/K6NNWxS44K+Mudd2NR1vrQg==
X-Received: by 2002:a5d:6a8c:: with SMTP id s12mr2363579wru.345.1589522614233;
        Thu, 14 May 2020 23:03:34 -0700 (PDT)
Received: from [127.0.0.1] (p57967B71.dip0.t-ipconnect.de. [87.150.123.113])
        by smtp.gmail.com with ESMTPSA id q17sm2081493wmk.36.2020.05.14.23.03.33
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 23:03:33 -0700 (PDT)
Date:   Fri, 15 May 2020 06:03:31 +0000 (UTC)
From:   Emil Heimpel <broetchenrackete@gmail.com>
To:     linux-btrfs@vger.kernel.org
Message-ID: <9d2d57e7-29d9-42c2-be55-fb8ee50db40e@localhost>
Subject: Need help recovering broken RAID5 array (parent transid verify
 failed)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <9d2d57e7-29d9-42c2-be55-fb8ee50db40e@localhost>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi,

I hope this is the right place to ask for help. I am unable to mount my BTR=
FS array and wanted to know, if it is possible to recover (some) data from =
it.

I have a RAID1-Metadata/RAID5-Data array consisting of 6 drives, 2x8TB, 5TB=
, 4TB and 2x3TB. It was running fine for the last 3 months. Because I expan=
ded it drive by drive I wanted to do a full balance the other day, when aft=
er around 40% completion (ca 1.5 days) I noticed, that one drive was missin=
g from the array (If I remember correctly, it was the 5TB one). I tried to =
cancel the balance, but even after a few hours it didn't cancel, so I tried=
 to do a reboot. That didn't work either, so I did a hard reset. Probably n=
ot the best idea, I know....

My array looks like this:

[bluemond@BlueQ btrfslogs]$ sudo btrfs fi show=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Label: none=C2=A0 uuid: 19b4f289-a87f-4ed8-8882-b0d03e014104
Total devices 6 FS bytes used 15.47TiB
devid=C2=A0 =C2=A0 1 size 7.28TiB used 5.83TiB path /dev/sdc1
devid=C2=A0 =C2=A0 2 size 4.55TiB used 4.39TiB path /dev/sdg1
devid=C2=A0 =C2=A0 3 size 3.64TiB used 3.63TiB path /dev/sdf1
devid=C2=A0 =C2=A0 4 size 7.28TiB used 3.03TiB path /dev/sda1
devid=C2=A0 =C2=A0 5 size 2.73TiB used 2.22TiB path /dev/sde1
devid=C2=A0 =C2=A0 6 size 2.73TiB used 2.22TiB path /dev/sdd1

After the reboot all drives appeared again but now I can't mount the array =
anymore, it gives me the following error in dmesg:

[=C2=A0 858.554594] BTRFS info (device sdc1): disk space caching is enabled
[=C2=A0 858.554596] BTRFS info (device sdc1): has skinny extents
[=C2=A0 858.556165] BTRFS error (device sdc1): parent transid verify failed=
 on 23219912048640 wanted 116443 found 116484
[=C2=A0 858.556516] BTRFS error (device sdc1): parent transid verify failed=
 on 23219912048640 wanted 116443=C2=A0 found 116484
[=C2=A0 858.556527] BTRFS error (device sdc1): failed to read chunk root
[=C2=A0 858.588332] BTRFS error (device sdc1): open_ctree failed

Mounting with the backuproot option isn't working either:

[=C2=A0 793.730875] BTRFS info (device sdc1): trying to use backup root at =
mount time
[=C2=A0 793.730879] BTRFS info (device sdc1): disk space caching is enabled
[=C2=A0 793.730880] BTRFS info (device sdc1): has skinny extents
[=C2=A0 793.732479] BTRFS error (device sdc1): parent transid verify failed=
 on 23219912048640 wanted 116443 found 116484
[=C2=A0 793.732775] BTRFS error (device sdc1): parent transid verify failed=
 on 23219912048640 wanted 116443 found 116484
[=C2=A0 793.732785] BTRFS error (device sdc1): failed to read chunk root
[=C2=A0 793.756693] BTRFS error (device sdc1): open_ctree failed

Btrfs restore isn't finding any data either:

[bluemond@BlueQ ~]$ sudo btrfs restore -xmSivD /dev/sda1 /btrfs/
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
Ignoring transid failure
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
Ignoring transid failure
This is a dry-run, no files are going to be restored
Done searching

Btrfs checks of each drive produce the following output:

[bluemond@BlueQ btrfslogs]$ sudo btrfs check /dev/sda1
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
Ignoring transid failure
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
Ignoring transid failure
[1/7] checking root items
parent transid verify failed on 30122546839552 wanted 116438 found 116458
parent transid verify failed on 30122546839552 wanted 116438 found 116458
parent transid verify failed on 30122546839552 wanted 116438 found 116458
Ignoring transid failure
leaf parent key incorrect 30122546839552
ERROR: failed to repair root items: Operation not permitted

[bluemond@BlueQ btrfslogs]$ sudo btrfs check /dev/sdc1
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
Ignoring transid failure
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
Ignoring transid failure
[1/7] checking root items
parent transid verify failed on 30122546839552 wanted 116438 found 116458
parent transid verify failed on 30122546839552 wanted 116438 found 116458
parent transid verify failed on 30122546839552 wanted 116438 found 116458
Ignoring transid failure
leaf parent key incorrect 30122546839552
ERROR: failed to repair root items: Operation not permitted

[bluemond@BlueQ btrfslogs]$ sudo btrfs check /dev/sdd1
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
Ignoring transid failure
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
Ignoring transid failure
[1/7] checking root items
parent transid verify failed on 30122546839552 wanted 116438 found 116458
parent transid verify failed on 30122546839552 wanted 116438 found 116458
parent transid verify failed on 30122546839552 wanted 116438 found 116458
Ignoring transid failure
leaf parent key incorrect 30122546839552
ERROR: failed to repair root items: Operation not permitted

[bluemond@BlueQ btrfslogs]$ sudo btrfs check /dev/sde1
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
Ignoring transid failure
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
Ignoring transid failure
[1/7] checking root items
parent transid verify failed on 30122546839552 wanted 116438 found 116458
parent transid verify failed on 30122546839552 wanted 116438 found 116458
parent transid verify failed on 30122546839552 wanted 116438 found 116458
Ignoring transid failure
leaf parent key incorrect 30122546839552
ERROR: failed to repair root items: Operation not permitted

[bluemond@BlueQ btrfslogs]$ sudo btrfs check /dev/sdf1
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
Ignoring transid failure
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
Ignoring transid failure
[1/7] checking root items
parent transid verify failed on 30122546839552 wanted 116438 found 116458
parent transid verify failed on 30122546839552 wanted 116438 found 116458
parent transid verify failed on 30122546839552 wanted 116438 found 116458
Ignoring transid failure
leaf parent key incorrect 30122546839552
ERROR: failed to repair root items: Operation not permitted

[bluemond@BlueQ btrfslogs]$ sudo btrfs check /dev/sdg1
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
parent transid verify failed on 23219912048640 wanted 116443 found 116484
Ignoring transid failure
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
parent transid verify failed on 30122559078400 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
parent transid verify failed on 30122559127552 wanted 116443 found 116492
Ignoring transid failure
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
parent transid verify failed on 30122471063552 wanted 116437 found 116492
Ignoring transid failure
[1/7] checking root items
parent transid verify failed on 30122546839552 wanted 116438 found 116458
parent transid verify failed on 30122546839552 wanted 116438 found 116458
parent transid verify failed on 30122546839552 wanted 116438 found 116458
Ignoring transid failure
leaf parent key incorrect 30122546839552
ERROR: failed to repair root items: Operation not permitted

I tried to read up on the issue, but I only found it mentioned in the gotch=
as page of the wiki, Marc's blog and in a thread about the stability of RAI=
D56 in this mailing list, where it was stated, that the recoverability is f=
rom 0 to 100%, but nowhere was it mentioned, what to do when you encounter =
that problem. Is there anything I can do to at least recover some of my dat=
a from the array?

And how can I prevent it from happening again? Would using the new multi-pa=
rity raid1 for Metadata help?

Some info on my system:
I'm running arch on an ssd.
[bluemond@BlueQ btrfslogs]$ uname -a
Linux BlueQ 5.6.12-arch1-1 #1 SMP PREEMPT Sun, 10 May 2020 10:43:42 +0000 x=
86_64 GNU/Linux

[bluemond@BlueQ btrfslogs]$ btrfs --version
btrfs-progs v5.6

I'm not very familiar with mailing lists, so pardon me if I have done anyth=
ing wrong!
Hope someone can give me more information about what to do now.

Thanks,
Emil

