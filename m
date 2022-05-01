Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF7516364
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 11:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiEAJY7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 05:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbiEAJYu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 05:24:50 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8AF2BDC
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 02:21:24 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h3so4724069qtn.4
        for <linux-btrfs@vger.kernel.org>; Sun, 01 May 2022 02:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gMQkZ6XrQterJ/NHW+5/bpkS/N/MR1FqcwQYnPK9WYs=;
        b=k18A0WhlzNjw5T3fOzIjouelCLB7AGV4MNnfiemzJiSss62YCBqdZ1cegysHQ4mKXC
         BJ54JSwwhFOXIfhKZVX8z7t64BKwDJ1i/3r2y1Bi3eUiNVS4JKIndczAqERammpmGIoJ
         DbCPPqoRyyPXI8IP68V99tD46cBDgBXoRFeutOUXtncGTsEgYNXOxZ0B7T0AnV/vof1Y
         9wFZxBwoWFSgrOrJDAzZVOjQ05SjkULDWft4O0SWBwfCSAYTyOdwpKPsvqSYAqWxXGx0
         woUn9V+Md6usNhUkT+72etoFUCdapwZqNEBzTbuWiAcDfzrqR0aJV8IYVg4fE52JOhNG
         +GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gMQkZ6XrQterJ/NHW+5/bpkS/N/MR1FqcwQYnPK9WYs=;
        b=08ExqP+LwKnY6gU4jvFI8cxbZzzO338a2GOnitK/56xFwDq7oC97aK5iLLQRrIj3Me
         zdwsqlRE4neLQdzEHBzqX8hq+UsFuqfpMj0JXmCJWLCql1065wbMVtthoD4oeXYpv7pl
         f1MBb4PifRJszUtH5N1odDfU8JyXcOD0ouiUtJ4ysN+wLbRTId1ZlbktwXXCucnLmfXb
         AovhlhggCVWeA31moHLhIUFggsFHyI8UGvqWTDfe+321TzIKwK2hFCvNjIEsRJQUIvGr
         HTLkI5oYlvmyl7EBp7w0pr+pTrtNMqo1RHzFwVOIc9hqmQu76LWGcgWojEirD6IW8U7U
         UjnQ==
X-Gm-Message-State: AOAM533r+45c3RthdJK9PbrY2RbXvZWGDyiC1LOuvG8EWdttUB4PTvxW
        2vvWqEl8ao2feGhuPDDQkCzcC5SJlmilC7R4c0s=
X-Google-Smtp-Source: ABdhPJzFA7rvIPs2XrO9TNTVkeZOtTDG/cyazw9r+xJFHf3NGml9cu9toS5KHZNGwfXSPSP2SgIrahm0CGl/q+plw5M=
X-Received: by 2002:a05:622a:6082:b0:2f1:1f9c:251e with SMTP id
 hf2-20020a05622a608200b002f11f9c251emr6179796qtb.230.1651396883425; Sun, 01
 May 2022 02:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAGy3qQDeMHQMx6ULiw2uGfiJWzumpyb1jhKgizF5UsRppAoRPQ@mail.gmail.com>
 <20220429112309.nz2x6zdi6qvjqcip@quentin> <20220429113634.orbbcut6anmzzs6w@naota-xeon>
In-Reply-To: <20220429113634.orbbcut6anmzzs6w@naota-xeon>
From:   Inhwi Hwang <dlsgnl1@gmail.com>
Date:   Sun, 1 May 2022 18:20:47 +0900
Message-ID: <CAGy3qQCR-F=CLjjajZt5f6Z1ebmtTar0R2OBrFmD-AWVFw0eSw@mail.gmail.com>
Subject: Re: Question on file system on ZNS SSD
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Pankaj Raghav <pankydev8@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        yeom@snu.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you!
The problem was the mq-deadline scheduler.
I succeeded in running fio write workload.

But, after the write step, the fio verifying step failed .
The error message was
"verify: bad magic header 0, wanted acca at file /mnt/nvme1n2/test.txt
offset 10138288128, length 131072 (requested block:
offset=3D10138288128, length=3D131072)
".

There are no errors in dmesg except this kernel INFO after running fio work=
load:

[  967.717212] INFO: task kworker/u40:10:531 blocked for more than 120 seco=
nds.
[  967.717232]       Not tainted 5.17.4 #1
[  967.717238] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  967.717241] task:kworker/u40:10  state:D stack:    0 pid:  531
ppid:     2 flags:0x00004000
[  967.717256] Workqueue: writeback wb_workfn (flush-btrfs-1)
[  967.717276] Call Trace:
[  967.717280]  <TASK>
[  967.717287]  __schedule+0x302/0x9e0
[  967.717302]  schedule+0x58/0xd0
[  967.717310]  io_schedule+0x4b/0x80
[  967.717319]  folio_wait_bit_common+0x14e/0x390
[  967.717329]  ? file_fdatawait_range+0x30/0x30
[  967.717338]  __folio_lock+0x17/0x20
[  967.717345]  extent_write_cache_pages+0x35f/0x4a0
[  967.717361]  extent_writepages+0x7b/0x140
[  967.717369]  btrfs_writepages+0xe/0x10
[  967.717379]  do_writepages+0xd0/0x1d0
[  967.717389]  ? ttwu_do_wakeup+0x1c/0x170
[  967.717396]  ? ttwu_do_activate+0x6d/0xb0
[  967.717402]  ? _raw_spin_unlock_irqrestore+0x29/0x40
[  967.717415]  ? try_to_wake_up+0x9d/0x5e0
[  967.717422]  __writeback_single_inode+0x44/0x350
[  967.717430]  ? _raw_spin_unlock+0x1a/0x30
[  967.717437]  writeback_sb_inodes+0x226/0x4e0
[  967.717450]  __writeback_inodes_wb+0x56/0xf0
[  967.717459]  wb_writeback+0x1db/0x2c0
[  967.717469]  wb_workfn+0x2d9/0x530
[  967.717477]  ? _raw_spin_unlock+0x1a/0x30
[  967.717485]  process_one_work+0x21a/0x3f0
[  967.717495]  worker_thread+0x50/0x3d0
[  967.717503]  ? rescuer_thread+0x390/0x390
[  967.717511]  kthread+0xfd/0x130
[  967.717517]  ? kthread_complete_and_exit+0x20/0x20
[  967.717524]  ret_from_fork+0x1f/0x30
[  967.717539]  </TASK>

Best regards,
Inhwi Hwang.


2022=EB=85=84 4=EC=9B=94 29=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 8:36, N=
aohiro Aota <Naohiro.Aota@wdc.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Apr 29, 2022 at 01:23:09PM +0200, Pankaj Raghav wrote:
> > On Fri, Apr 29, 2022 at 03:26:45PM +0900, Inhwi Hwang wrote:
> > > Hello,
> > > This is Inhwi Hwang from Seoul National University Distributed
> > > Computing Laboratory.
> > > I've contacted you to ask some questions about the file system on the=
 ZNS SSD.
> > >
> > > I read the documentation of BTRFS on zoned device(Zoned - btrfs Wiki
> > > (kernel.org)).
> > > I want to check the performance of BTRFS on ZNS SSD.
> > > I attached BTRFS on a ZNS SSD(ZN540),
> > > but a basic write test using fio failed and raised errors.
> >
> > Could you also post the errors you are getting?
>
> Please include dmesg as well.
>
> But, I suspect you are not using mq-deadline scheduler.
>
> Could you check which scheduler the device is using with the command belo=
w?
>
> $ cat /sys/block/nvme1n2/queue/scheduler
>
> > > fio command : fio --filename=3D/mnt/nvme1n2/test.txt --direct=3D0 \
> > >                       --size=3D10G --rw=3Dwrite --verify=3Dmd5 --bs=
=3D128K
> > > --output=3D${OUTPUT_NAME}
> > >
> > > Best regards,
> > > Inhwi Hwang
> >
> > --
> > Pankaj Raghav
