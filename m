Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373595352D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 19:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbiEZRoO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 13:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiEZRoN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 13:44:13 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3823BB492
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 10:44:12 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id f4so2300673iov.2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6O3TmBHXHe/QqLtCO/vlEQPFDPBY/56J5qpCEaECj2g=;
        b=OMZzryXD7v7/vMPu2NJg/6Y/hWl2KYTlqg6KMD7q6NyfTe05XBg59WsiA7Gheo0kYQ
         LjnJO8RxAVhH+4XF1eyENtycfJ6TyJZbjvH5MUn2X8C4OiZyk+XZ5WJ6aWTc9KFcfr/G
         FVYhYHCDGpaxSy4mfJASsQVMfLaoKowV9IGGk66Rw4yc/NhnIAgZLxLWnJvOdruGcOy5
         +kCnD3il5GtHFswwqp+9nyUIRFCcM3akDjvfQ6nEi1gDOnkAgc1W10294Lww1ouJunkW
         aQ4+hJM+deW2uWcpiODZynJE051AATtzuTtUg1RSbiCQBdMoHCtAhc3I1sqYCnv4+MDi
         AzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6O3TmBHXHe/QqLtCO/vlEQPFDPBY/56J5qpCEaECj2g=;
        b=62A+MorwE7JxbrGwpRaRxbRoZUT9n3c6LvYSJoenqPOdISl+adLx9H4rfcZA/TpCgX
         +2xD4HLy945r43eT+CFvWZnITnJY6+iOJVSqQeKFKcc1a7SGdmuL7uuMp80BUvYS1rYx
         DoilFDS+APPutw/9wzBoGPJm0VYrdgXY2po+CdbSZFT8/o7eI0PjWnh/F4RzYZZgMyPd
         dUcNTMaPBmSx8T/tLVhgnY7vAGFH3PdKCTWPepKLod7wIfLYx5h/tuiR6sEXBGOLLWhF
         WkvLpFFr+GGZEFB6Ah5O3CKM73VqGd3YfQlu5XSjwMP/0TbXSwNNavNTKsfz3SzM+Tmf
         A9uw==
X-Gm-Message-State: AOAM530Fl82swr2dOvV7zjFG8G2pL316VeAb2+fwIniZlht8TB+F9EYJ
        vyHRNFGYIjZU5T5nIBTXR2NHyYbJlTviAodhicDpnq8O17M=
X-Google-Smtp-Source: ABdhPJxOSGxwWBjXHk+95M5m/zjlB8fNIK5+OS3zUS+V2bI7H7bxPU3MuuYQTBlPuOtc+n56DNAaPgROT1xXVYTIdh4=
X-Received: by 2002:a05:6602:29ca:b0:649:558a:f003 with SMTP id
 z10-20020a05660229ca00b00649558af003mr17837200ioq.160.1653587051486; Thu, 26
 May 2022 10:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqcX3XEQGjoJCV1wARu=Od7vAypmzO4dCFgQ+_UBBuJdMA@mail.gmail.com>
 <20220518191241.GI13006@merlins.org> <CAEzrpqfPEU9Vt86ykVyxwvDXrihKfGc180oT7SUcQdwtYysquw@mail.gmail.com>
 <20220519222855.GL13006@merlins.org> <20220524011348.GR13006@merlins.org>
 <CAEzrpqd=G50pWKYJRD57ePVpfGNPu947zJXuZFdj0tF4yGzkbQ@mail.gmail.com>
 <20220524191345.GA1751747@merlins.org> <CAEzrpqdTpkvguQq+MGxYBb12-RF97dgW7cccz7o2HoSkrWt8gQ@mail.gmail.com>
 <20220526171046.GB1751747@merlins.org> <CAEzrpqd_B13rDPCZLm9h0ji8f1oS7mCw=2d1-iiW=M26FfEcCw@mail.gmail.com>
 <20220526173119.GC1751747@merlins.org>
In-Reply-To: <20220526173119.GC1751747@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 26 May 2022 13:44:00 -0400
Message-ID: <CAEzrpqemPU_=VTxGEQS2WtGiaGbHy+ssnj5MKyh=8JC36uyZ6Q@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 26, 2022 at 1:31 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, May 26, 2022 at 01:12:03PM -0400, Josef Bacik wrote:
> > > ./btrfs rescue chunk-recover /dev/mapper/dshelf1
> > > Scanning: DONE in dev0
> > > JOSEF: root 9
> > > Couldn't find the last root for 8
> > > We are going to rebuild the chunk tree on disk, it might destroy the old metadata on the disk, Are you sure? [y/N]:
> > >
> > > Do I say 'y' ?
> >
> > Yup it should have found all the best chunks, lets let it do its thing.  Thanks,
>
> Done.
>
> what next?
>
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# fg
> ./btrfs rescue chunk-recover /dev/mapper/dshelf1
> Scanning: DONE in dev0
> JOSEF: root 9
> Couldn't find the last root for 8
> We are going to rebuild the chunk tree on disk, it might destroy the old metadata on the disk, Are you sure? [y/N]: y
> Chunk tree recovered successfully
> gargamel:/var/local/src/btrfs-progs-josefbacik#
>
> I still have this that ran almost a week:
> gargamel:/var/local/src/btrfs-progs-josefbacik# jobs
> [1]+  Stopped                 ./btrfs rescue init-extent-tree /dev/mapper/dshelf1 2>&1 | tee /mnt/btrfs_space/ri1
>
> I assume it's invalidated and I should kill it?
> If so, do I start the same thing again?
>

Kill it and start it again, hopefully this time we have all the chunks
and the init should be quick like it was before.  Thanks,

Josef
