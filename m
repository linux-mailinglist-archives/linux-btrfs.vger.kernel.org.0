Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ED865BE51
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 11:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbjACKms (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 05:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237358AbjACKmk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 05:42:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3745A8FD0;
        Tue,  3 Jan 2023 02:42:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3E3CB80E63;
        Tue,  3 Jan 2023 10:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB46C433F1;
        Tue,  3 Jan 2023 10:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672742556;
        bh=VxYlM1cxU4DajOBMwZI8h9TsQUA/MyC0fEC3/Ps0X+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fOxkWETISEsWgiLXbAdAhHwhtz7BlS3O4WCXMlsw/sVjMYVT1/NeKWgOlR19z8Sum
         K/4rQax0x2GO+b7w2dDQyRy5QvoZEjLOu8NbdFlEk8fXgA8II5UIJeY2tjSNlOHh8x
         HR+W/ZL5qx1DV7hwqV24uK2MCr+UkxY/CHMErTz1DLmDrms4tdmxyUpV2YYzn0Ijhi
         Um1oYe2zb3ubIiLPD1kc4tjb06HgFjKrh24/fm/SUXTdfzqPl24KmWfCKLHWNqXySE
         E7EDnB29ZiThbRVQM2Gl86lQGWFEhkjnd67KqKd9MtMyGGxsX0Jgo/f3gg8m9bWFmS
         Fr4ZtUWKb3M6Q==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-12c8312131fso36351821fac.4;
        Tue, 03 Jan 2023 02:42:36 -0800 (PST)
X-Gm-Message-State: AFqh2krkpZ2kpwuqaOIFw7BFcM94uagPfiA/NqxodX5HzwyAixsqSaJ4
        ECTdrBVPuukSWpAhfpzeLRpQsY+Eu+Ad6fDJRDM=
X-Google-Smtp-Source: AMrXdXuqk6Prrhr1fa3+Do4IRT0I8JilTYMnfJWkmsU664jwkej1QGLgXwrTC79SEma6OyGpLY8S2L2CZh2SDTsYJQ8=
X-Received: by 2002:a05:6871:1d5:b0:144:6d8b:c318 with SMTP id
 q21-20020a05687101d500b001446d8bc318mr2915763oad.98.1672742555464; Tue, 03
 Jan 2023 02:42:35 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <f68699c3-ec5e-d8e8-f101-6e9a7020ac81@gmx.com> <CABXGCsNrm3ddn3p_ECSRe+yQeoF3KojTFvy-CpXNzi9ADkbnvQ@mail.gmail.com>
 <18b5fa1e-7d1e-4560-c98b-d7ac5fc87c3a@gmx.com> <eaf71061-548d-59d1-b8a9-fa79fd0ed9b3@prnet.org>
In-Reply-To: <eaf71061-548d-59d1-b8a9-fa79fd0ed9b3@prnet.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 3 Jan 2023 10:41:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6RbPsa9Ff9or6+0d4R5vzVcR=RPxHA0=3A_KeSmf7hcQ@mail.gmail.com>
Message-ID: <CAL3q7H6RbPsa9Ff9or6+0d4R5vzVcR=RPxHA0=3A_KeSmf7hcQ@mail.gmail.com>
Subject: Re: [6.2][regression] after commit 947a629988f191807d2d22ba63ae18259bb645c5
 btrfs volume periodical forced switch to readonly after a lot of disk writes
To:     David Arendt <admin@prnet.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, wqu@suse.com,
        dsterba@suse.com, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 26, 2022 at 7:50 AM David Arendt <admin@prnet.org> wrote:
>
> Hi,
>
> I am experiencing I similiar issue using kernel 6.1.1. The problem has
> started in kernel 6.1. It never happend before.
>
> A btrfs scrub and a btrfs check --readonly returned 0 errors.
>
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS critical
> (device sda2): corrupt leaf: root=18446744073709551610
> block=203366612992 slot=73, bad key order, prev (484119 96 1312873)
> current (484119 96 1312849)
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS info
> (device sda2): leaf 203366612992 gen 5068802 total ptrs 105 free space
> 10820 owner 18446744073709551610
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 0 key
> (484119 1 0) itemoff 16123 itemsize 160
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09inode
> generation 45 size 2250 mode 40700
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 1 key
> (484119 12 484118) itemoff 16097 itemsize 26
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 2 key
> (484119 72 15) itemoff 16089 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 3 key
> (484119 72 20) itemoff 16081 itemsize 8
> ...

You've removed the most interesting part of the message.

Can you paste it without any cuts (...)?

Thanks.

> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 82 key
> (484119 96 1312873) itemoff 14665 itemsize 51
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 83 key
> (484119 96 1312877) itemoff 14609 itemsize 56
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 84 key
> (484128 1 0) itemoff 14449 itemsize 160
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09inode
> generation 45 size 98304 mode 100644
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 85 key
> (484128 108 0) itemoff 14396 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data disk bytenr 10674830381056 nr 65536
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data offset 0 nr 65536 ram 65536
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 86 key
> (484129 1 0) itemoff 14236 itemsize 160
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09inode
> generation 45 size 26214400 mode 100644
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 87 key
> (484129 108 589824) itemoff 14183 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data disk bytenr 10665699962880 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 88 key
> (484129 108 2850816) itemoff 14130 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data disk bytenr 10665848733696 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 89 key
> (484129 108 11042816) itemoff 14077 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data disk bytenr 10660869349376 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 90 key
> (484129 108 13402112) itemoff 14024 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data disk bytenr 10660207378432 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 91 key
> (484129 108 19628032) itemoff 13971 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data disk bytenr 10665835618304 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 92 key
> (484129 108 21266432) itemoff 13918 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data disk bytenr 10661222666240 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 93 key
> (484129 108 22740992) itemoff 13865 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data disk bytenr 10665565814784 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 94 key
> (484129 108 23101440) itemoff 13812 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data disk bytenr 10665836371968 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 95 key
> (484129 108 24084480) itemoff 13759 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data disk bytenr 10665836404736 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 96 key
> (484129 108 24150016) itemoff 13706 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data disk bytenr 10665849159680 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 97 key
> (484129 108 24313856) itemoff 13653 itemsize 53
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data disk bytenr 10665849192448 nr 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09extent
> data offset 0 nr 32768 ram 32768
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 98 key
> (484147 1 0) itemoff 13493 itemsize 160
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09\x09inode
> generation 45 size 886 mode 40755
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 99 key
> (484147 72 4) itemoff 13485 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 100 key
> (484147 72 27) itemoff 13477 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 101 key
> (484147 72 35) itemoff 13469 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 102 key
> (484147 72 40) itemoff 13461 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 103 key
> (484147 72 45) itemoff 13453 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - \x09item 104 key
> (484147 72 52) itemoff 13445 itemsize 8
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS error
> (device sda2): block=203366612992 write time tree block corruption detected
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS: error
> (device sda2: state AL) in free_log_tree:3284: errno=-5 IO failure
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS info
> (device sda2: state EAL): forced readonly
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS warning
> (device sda2: state EAL): Skipping commit of aborted transaction.
> 2022-12-26T07:44:45.000000+01:00 server02 kernel - - - BTRFS: error
> (device sda2: state EAL) in cleanup_transaction:1958: errno=-5 IO failure
>
>
> There are no SSD access errors in the kernel logs. Smart data for the
> SSD is normal. I also did a 12 hour memtest to rule out bad RAM.
>
> The filesystem consists of a single 480GB SATA SSD (Corsair Neutron
> XTI). Like for the original poster, the problems occurs only on one
> machine.
>
> The error appears about every few days and seems to be triggered by a
> combination specially under high cpu utilization combined with some disk
> IO. CPU temperature never exceeds 60 degrees.
>
>
> On 26/12/2022 04:29, Qu Wenruo wrote:
> >
> >
> > On 2022/12/26 10:47, Mikhail Gavrilov wrote:
> >> On Mon, Dec 26, 2022 at 5:15 AM Qu Wenruo <quwenruo.btrfs@gmx.com>
> >> wrote:
> >>>
> >>> Thanks a lot for the full kernel log.
> >>>
> >>> It indeed shows something is wrong in the run_one_delayed_ref().
> >>> But surprisingly, if there is something wrong, I'd expect more output
> >>> from btrfs, as normally if one tree block failed to pass whatever the
> >>> checks, it should cause an error message at least.
> >>>
> >>> Since you can reproduce the bug (although I don't think this is easy to
> >>> reproduce), mind to apply the extra debug patch and then try to
> >>> reproduce?
> >>
> >> Of course I am still able to reproduce.
> >> The number of messages foreshadowing readonly has become somewhat more:
> >> [ 2295.155437] BTRFS error (device nvme0n1p3): level check failed on
> >> logical 4957418700800 mirror 1 wanted 0 found 1
> >
> > OK, indeed a level mismatch.
> >
> > From the remaining lines, it shows we're failing at
> > do_free_extent_accounting(), which failed at the btrfs_del_csums().
> >
> > And inside btrfs_del_csums(), what we do are all regular btree
> > operations, thus the tree level check should work without problem.
> >
> > Thus it seems to be a corrupted csum tree.
> >
> >> [ 2295.155831] BTRFS error (device nvme0n1p3: state A): Transaction
> >> aborted (error -5)
> >> [ 2295.155946] BTRFS: error (device nvme0n1p3: state A) in
> >> do_free_extent_accounting:2849: errno=-5 IO failure
> >> [ 2295.155978] BTRFS info (device nvme0n1p3: state EA): forced readonly
> >> [ 2295.155985] BTRFS error (device nvme0n1p3: state EA):
> >> run_one_delayed_ref returned -5
> >> [ 2295.156051] BTRFS: error (device nvme0n1p3: state EA) in
> >> btrfs_run_delayed_refs:2153: errno=-5 IO failure
> >>
> >> Of course full logs are also attached.
> >>
> >>> Another thing is, mind to run "btrfs check --readonly" on the fs?
> >> Result of check attached too.
> >>
> > Could you please run "btrfs check --readonly" from a liveCD?
> > There are tons of possible false alerts if ran on a RW mounted fs.
> >
> > Thanks,
> > Qu
>
>
