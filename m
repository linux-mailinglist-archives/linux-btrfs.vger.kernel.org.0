Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD10E65DCBD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jan 2023 20:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbjADT3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Jan 2023 14:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbjADT3l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Jan 2023 14:29:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FA13C386;
        Wed,  4 Jan 2023 11:29:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9530B818B8;
        Wed,  4 Jan 2023 19:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7DEC43398;
        Wed,  4 Jan 2023 19:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672860577;
        bh=2JEmACK5j1tQTkq3i5ZXtfBFJwaHwhGQMHSMPE/Jx60=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hlf6wUOiUH90TXZphn762JJGsWjATPRF43eymmHn73M8sAFZ6eGBqNSCaHJj70Nm2
         59so9MIoO37P8yuGL22loKwg/KVDrlVl0Kjhqn/Ug6sncqc7tesgIETBNCvvvAm5HL
         HekMhj0hX6cqNZrffKW94HSr2OnmHVK88AuZy0l55pz+Xc/ftlWA0kFOQ0N+aajUUN
         54wca4sCcyyWGJaJYoCu3CHJTNtrd0PLscU2CXzfgXnWc3uo4wsZF9y0LqlrKl1wU5
         mq1O5nIYKG3ObK0Mz9xm6JDyc1Kx62/wzeqsoFOZd4RyaSj4uJJqcFjYKI+Sz/y7cN
         0fA0OJYaWihHA==
Received: by mail-oi1-f174.google.com with SMTP id e205so30307682oif.11;
        Wed, 04 Jan 2023 11:29:37 -0800 (PST)
X-Gm-Message-State: AFqh2kpLpd0452PYTbaJcaitqnPuCS8IFO6jeYkCEjjKqFej+c/qE64y
        RGTzpsMjFciZqwxT7qBUxBL4zAOwYd7L7bD3JtQ=
X-Google-Smtp-Source: AMrXdXtHx1MQI//kB9ZNK2EtxcgjHn0nM42CKNJwH4yWbuCPp6125UxaHBxYwJZsUlmGFYbJdpCbezZ6fc33ggGJK7U=
X-Received: by 2002:a05:6808:1387:b0:35b:75b:f3b9 with SMTP id
 c7-20020a056808138700b0035b075bf3b9mr2823750oiw.98.1672860576389; Wed, 04 Jan
 2023 11:29:36 -0800 (PST)
MIME-Version: 1.0
References: <ae169fc6-f504-28f0-a098-6fa6a4dfb612@leemhuis.info>
 <20230102154050.GJ11562@twin.jikos.cz> <ac2f141b-b03a-6054-8250-d27a5b568027@gmx.com>
 <03ad09d2-0c0e-ed82-509a-9758fbc81f64@prnet.org>
In-Reply-To: <03ad09d2-0c0e-ed82-509a-9758fbc81f64@prnet.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 4 Jan 2023 19:29:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H75DScFAnUGHFn9x=ZmnCbd_u3+KsLU6qKOGPeVogOQwg@mail.gmail.com>
Message-ID: <CAL3q7H75DScFAnUGHFn9x=ZmnCbd_u3+KsLU6qKOGPeVogOQwg@mail.gmail.com>
Subject: Re: [regression] Bug 216851 - btrfs write time corrupting for log tree
To:     David Arendt <admin@prnet.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 4, 2023 at 7:26 PM David Arendt <admin@prnet.org> wrote:
>
> On 1/3/23 00:38, Qu Wenruo wrote:
> >
> >
> > On 2023/1/2 23:40, David Sterba wrote:
> >> On Tue, Dec 27, 2022 at 03:01:34PM +0100, Thorsten Leemhuis wrote:
> >>> Hi, this is your Linux kernel regression tracker speaking.
> >>>
> >>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> >>> kernel developer don't keep an eye on it, I decided to forward it by
> >>> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216851 :
> >>>
> >>>> I am experiencing btrfs file system errors followed by a switch to
> >>>> readony with kernel 6.1 and 6.1.1. It never happened with kernel
> >>>> versions before.
> >>>>
> >>>> A btrfs scrub and a btrfs check --readonly returned 0 errors.
> >>>>
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS
> >>>> critical (device sda2): corrupt leaf: root=18446744073709551610
> >>>> block=203366612992 slot=73, bad key order, prev (484119 96 1312873)
> >>>> current (484119 96 1312849)
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS info
> >>>> (device sda2): leaf 203366612992 gen 5068802 total ptrs 105 free
> >>>> space 10820 owner 18446744073709551610
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 0
> >>>> key (484119 1 0) itemoff 16123 itemsize 160
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09inode generation 45 size 2250 mode 40700
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 1
> >>>> key (484119 12 484118) itemoff 16097 itemsize 26
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 2
> >>>> key (484119 72 15) itemoff 16089 itemsize 8
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 3
> >>>> key (484119 72 20) itemoff 16081 itemsize 8
> >>>> ...
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 82
> >>>> key (484119 96 1312873) itemoff 14665 itemsize 51
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 83
> >>>> key (484119 96 1312877) itemoff 14609 itemsize 56
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 84
> >>>> key (484128 1 0) itemoff 14449 itemsize 160
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09inode generation 45 size 98304 mode 100644
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 85
> >>>> key (484128 108 0) itemoff 14396 itemsize 53
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data disk bytenr 10674830381056 nr 65536
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data offset 0 nr 65536 ram 65536
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 86
> >>>> key (484129 1 0) itemoff 14236 itemsize 160
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09inode generation 45 size 26214400 mode 100644
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 87
> >>>> key (484129 108 589824) itemoff 14183 itemsize 53
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data disk bytenr 10665699962880 nr 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data offset 0 nr 32768 ram 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 88
> >>>> key (484129 108 2850816) itemoff 14130 itemsize 53
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data disk bytenr 10665848733696 nr 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data offset 0 nr 32768 ram 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 89
> >>>> key (484129 108 11042816) itemoff 14077 itemsize 53
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data disk bytenr 10660869349376 nr 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data offset 0 nr 32768 ram 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 90
> >>>> key (484129 108 13402112) itemoff 14024 itemsize 53
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data disk bytenr 10660207378432 nr 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data offset 0 nr 32768 ram 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 91
> >>>> key (484129 108 19628032) itemoff 13971 itemsize 53
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data disk bytenr 10665835618304 nr 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data offset 0 nr 32768 ram 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 92
> >>>> key (484129 108 21266432) itemoff 13918 itemsize 53
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data disk bytenr 10661222666240 nr 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data offset 0 nr 32768 ram 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 93
> >>>> key (484129 108 22740992) itemoff 13865 itemsize 53
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data disk bytenr 10665565814784 nr 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data offset 0 nr 32768 ram 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 94
> >>>> key (484129 108 23101440) itemoff 13812 itemsize 53
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data disk bytenr 10665836371968 nr 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data offset 0 nr 32768 ram 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 95
> >>>> key (484129 108 24084480) itemoff 13759 itemsize 53
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data disk bytenr 10665836404736 nr 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data offset 0 nr 32768 ram 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 96
> >>>> key (484129 108 24150016) itemoff 13706 itemsize 53
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data disk bytenr 10665849159680 nr 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data offset 0 nr 32768 ram 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 97
> >>>> key (484129 108 24313856) itemoff 13653 itemsize 53
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data disk bytenr 10665849192448 nr 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09extent data offset 0 nr 32768 ram 32768
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 98
> >>>> key (484147 1 0) itemoff 13493 itemsize 160
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - -
> >>>> \x09\x09inode generation 45 size 886 mode 40755
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 99
> >>>> key (484147 72 4) itemoff 13485 itemsize 8
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 100
> >>>> key (484147 72 27) itemoff 13477 itemsize 8
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 101
> >>>> key (484147 72 35) itemoff 13469 itemsize 8
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 102
> >>>> key (484147 72 40) itemoff 13461 itemsize 8
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 103
> >>>> key (484147 72 45) itemoff 13453 itemsize 8
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 104
> >>>> key (484147 72 52) itemoff 13445 itemsize 8
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS error
> >>>> (device sda2): block=203366612992 write time tree block corruption
> >>>> detected
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS: error
> >>>> (device sda2: state AL) in free_log_tree:3284: errno=-5 IO failure
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS info
> >>>> (device sda2: state EAL): forced readonly
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS
> >>>> warning (device sda2: state EAL): Skipping commit of aborted
> >>>> transaction.
> >>>> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS: error
> >>>> (device sda2: state EAL) in cleanup_transaction:1958: errno=-5 IO
> >>>> failure
> >>>>
> >>>>
> >>>> There are no SSD access errors in the kernel logs. Smart data for
> >>>> the SSD is normal. I also did a 12 hour memtest to rule out bad RAM.
> >>>>
> >>>> The filesystem consists of a single 480GB SATA SSD (Corsair Neutron
> >>>> XTI). The problems occurs only on one machine.
> >>>>
> >>>> The error appears about every few days and seems to be triggered by
> >>>> a cspecially under high cpu utilization combined with some disk IO.
> >>>> CPU temperature never exceeds 60 degrees.
> >>>
> >>> See the ticket for more details.
> >>>
> >>> For the record, the issue is apparently different from the 6.2-rc
> >>> regression currently discussed, as stated here:
> >>> https://lore.kernel.org/lkml/462e7bd3-d1f2-3718-fde9-77b418e9fd91@gmx.com/
> >>>
> >>>
> >>> BTW, let me use this mail to also add the report to the list of tracked
> >>> regressions to ensure it's doesn't fall through the cracks:
> >>>
> >>> #regzbot introduced: v6.0..v6.1
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=216851
> >>> #regzbot title: btrfs: write time corrupting for log tree in 6.1
> >>> #regzbot ignore-activity
> >>
> >> #regzbot fix: 'btrfs: fix false alert on bad tree level check'
> >
> > Oh no, this is a different one, this one is not level mismatch.
> >
> > Thanks,
> > Qu
>
> Hi,
>
> Here the logging from another crash, this time on kernel 6.1.3, about 1
> hour after boot. Again during high CPU usage combined with lots of io.
>
> [ 1989.025015] BTRFS critical (device sda2): corrupt leaf:
> root=18446744073709551610 block=574078976 slot=70, bad key order, prev
> (484119 96 1328571) current (484119 96 1328553)
> [ 1989.025022] BTRFS info (device sda2): leaf 574078976 gen 5089233
> total ptrs 108 free space 10370 owner 18446744073709551610
> [ 1989.025024]  item 0 key (484119 1 0) itemoff 16123 itemsize 160
> [ 1989.025025]          inode generation 45 size 2198 mode 40700
> [ 1989.025026]  item 1 key (484119 12 484118) itemoff 16097 itemsize 26
> [ 1989.025027]  item 2 key (484119 72 15) itemoff 16089 itemsize 8
> [ 1989.025027]  item 3 key (484119 72 20) itemoff 16081 itemsize 8
>
> ...

Can you please paste the full message?
If an error/warning, don't just paste a section of the message, paste
the full thing.

I've previously commented on that in the other thread:

https://lore.kernel.org/linux-btrfs/CAL3q7H6RbPsa9Ff9or6+0d4R5vzVcR=RPxHA0=3A_KeSmf7hcQ@mail.gmail.com/

Thanks.


>
> [ 1989.025135]  item 105 key (484147 1 0) itemoff 13086 itemsize 160
> [ 1989.025137]          inode generation 45 size 886 mode 40755
> [ 1989.025138]  item 106 key (484147 72 4) itemoff 13078 itemsize 8
> [ 1989.025139]  item 107 key (484147 72 27) itemoff 13070 itemsize 8
> [ 1989.025140] BTRFS error (device sda2): block=574078976 write time
> tree block corruption detected
> [ 1989.053710] BTRFS: error (device sda2: state AL) in
> free_log_tree:3284: errno=-5 IO failure
> [ 1989.053717] BTRFS info (device sda2: state EAL): forced readonly
> [ 1989.055442] BTRFS warning (device sda2: state EAL): Skipping commit
> of aborted transaction.
> [ 1989.055444] BTRFS: error (device sda2: state EAL) in
> cleanup_transaction:1958: errno=-5 IO failure
>
> Thanks in advance,
>
> David Arendt
>
