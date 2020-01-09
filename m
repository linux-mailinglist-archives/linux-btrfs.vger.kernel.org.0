Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 700831354EB
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 09:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAII52 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 03:57:28 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35397 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgAII52 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 03:57:28 -0500
Received: by mail-oi1-f196.google.com with SMTP id k4so5256822oik.2
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jan 2020 00:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FravID/oNtBUitzJ+ffGiduxKORbdMS87nJZUHq8fzI=;
        b=eqDvNg5U7emR+gkCeZRBwnJJl8oKOAp3JC6FDdTomwX1DnrntqsaVhRVPdrtHiqoWw
         RAAvoGl5q7UTkxo+HhYBwMaJQa1D4T4PKnBnebKJihF97B104uYOEfx19t54equXG00Y
         R9vCyePjqWJZKiS16A0p6Kx6HwonI4amDcboH3Hy+uvxHGzStM4bCtKEEZrnqHUmCump
         UzYAMGRBU2J+YpeGtayqamrEvGNoaM1yoaR9DkhlZKmSHsCc/ZlmvZN1MpjT1EBwiZhA
         9Enws5T5R3CANiN46x9u9oR5aXMprwS7LcmDDRoxiZSXNzZaCboRTDxM3YbpoU4wIXS4
         uSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FravID/oNtBUitzJ+ffGiduxKORbdMS87nJZUHq8fzI=;
        b=TGPi81T8TKMOVFqwlaJ+MjKANmMeubDBPCfhuDkpgtQu71GnvWGqMSwxfl8r1pyqWR
         BEWAkJW8MqMz+oHlirJMbrFZeOAm+k7TMtHYrQ/5r6zVxdi08gTkfFNxqNvrTKq7711b
         tAVN3ZeDlR8Jt5ajpMBHN4/2bbvY2/Udt7DXJFXiunhGqmUFmbysU/U25EkAZb3qVuhH
         +zKjN4nkoeWdadBUEEdd4zv3g/xlaAs+PT0kF3UzLh3KKgrNoo9ZFrDgM5DwHhpa9iaY
         onBlT4AaTWn5IicPPcJNANxqCQ+HIkajz/fe/wBXELGATz5rbPfdaYBozh3wHeH6ZQuV
         SjQQ==
X-Gm-Message-State: APjAAAXrzg4djyusyNnUshIq3yORmqXmIjYD8O1snCkZgE6gNKk8Mans
        iDJW0KQFmDDvSrqpyGscqbIhLUx3QzRPCmMXwpA2+rB43Po=
X-Google-Smtp-Source: APXvYqyvERVogaajqNmuPg0+FH8Ajkz1wwgOlp9QS2kuPfvtha8Cn5NZCbDA+rjzMRA/TCaYkvXdS3J4OWRYzWlG3p4=
X-Received: by 2002:a05:6808:683:: with SMTP id k3mr2194161oig.50.1578560247640;
 Thu, 09 Jan 2020 00:57:27 -0800 (PST)
MIME-Version: 1.0
References: <b2ccde6952d0fa67c9948a21cd3ac8eddcdb3970.camel@render-wahnsinn.de>
 <CAJCQCtQQWGRQBAeCKt07MG33t9vwi-gahn7Mn9xJpA=HSAuTbw@mail.gmail.com> <0530e18f43a5f31ff8d446be362951f68068b5db.camel@render-wahnsinn.de>
In-Reply-To: <0530e18f43a5f31ff8d446be362951f68068b5db.camel@render-wahnsinn.de>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Thu, 9 Jan 2020 08:57:16 +0000
Message-ID: <CAHzMYBSrZdjwJcMj86u8Dr_imxyiRN5yE=cFgNC9Tofb42umXw@mail.gmail.com>
Subject: Re: How long should a btrfs scrub with RAID5/6 take?
To:     Robert Krig <robert.krig@render-wahnsinn.de>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I reported recently to the list there there's a performance problem
with scrubs on raid5/6 pools, initial report and followups here:

https://lore.kernel.org/linux-btrfs/CAHzMYBTXvY1VgcoFDUvc2NFmVKq2HJRHuS0VXzoneUMh79cySA@mail.gmail.com/

Quick recap:

4 disk raid5 (raid1 metadata)

UUID:             b75ee8b5-ae1c-4395-aa39-bebf10993057
Scrub started:    Wed Nov 27 07:32:46 2019
Status:           running
Duration:         7:34:50
Time left:        1:52:37
ETA:              Wed Nov 27 17:00:18 2019
Total to scrub:   1.20TiB
Bytes scrubbed:   982.05GiB
Rate:             36.85MiB/s
Error summary:    no errors found

11 disk raid5 (raid1 metadata)

UUID:             1236acc8-dbd5-41bd-bf3d-872a8fbbce49
Scrub started:    Sun Dec 15 11:23:45 2019
Status:           running
Duration:         0:51:34
Time left:        90:06:52
ETA:              Thu Dec 19 06:22:13 2019
Total to scrub:   18.10TiB
Bytes scrubbed:   175.12GiB
Rate:             57.96MiB/s
Error summary:    no errors found

Same 11 disk pool during a btrfs send to /dev/null confirming it's
capable of much better read speeds:

btrfs send /mnt/disks/Pics/T12_disk1_Pics_2019-12-15-0829/ | pv -bart
> /dev/null
At subvol /mnt/disks/Pics/T12_disk1_Pics_2019-12-15-0829/
 447GiB 0:13:19 [ 635MiB/s] [ 573MiB/s]

Current speed 635MiB/s, average speed so far 573MiB/s
