Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C742535272
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 19:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345769AbiEZRMS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 13:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbiEZRMR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 13:12:17 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4526F5FD6
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 10:12:15 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p74so2185944iod.8
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0a3/Fh++CTQiKXpP0BpKkguBXylp52a9xXAs016q/Q=;
        b=F7HqD67TaW/9LBwCfNtlKALIFt5n6yA39U22Z5DANe9Cojn7Gv9rQMR5NFLNhVRQ+g
         S6Dni9FloNSBGXlW9bcrVH5oKm4yWeGGW+TdXrea71Qrd8zQ6b1E/jfvicwg75cPoX2G
         JtkOWdf3VflVx4/G51xrR3nGQIAo+ZBiLQewldKeGdIsJI1wcmU8uEEI4VaJJHKmWdd5
         /knwwYdaJbkpQphljp9x+E/rUsepDlsoUlgvbUsfX72JtXDitRHJNrKaD2JwDt9+DKrN
         jT6vUpy+EQCzGJR7PVFl6hM3Fk6ly5EcvW8mn7j83lZ/NuokLq0mOTJ01BykQWk5rHxh
         IQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0a3/Fh++CTQiKXpP0BpKkguBXylp52a9xXAs016q/Q=;
        b=XytoIgsl2J9+fkElXaPPolHg7KIOZJ7Y0/M04V0ApVKRS59HGilEHSDZbNs5CS4v59
         9xDQ+VIgoNS+vmOi5yC9u3dbHMVjTqBxKMW2d69PZC3EBLimpdkAwDb2iR1uvXIa5l34
         9EFCd6p+k0kIijLyZxuqS4P3s86teKoImcPQHlaoH9lrA6LGG9Wah/h6reDZTSxzDW5A
         GCC6/4Hm+pek80mGbzvrdR4ctt1i+ziqcS14Z0UijheQmYeyKCl5HVgziWNDt/SXHaw/
         LT6Q7V+3Omk8/44gRkDMPsAScIS7Wu4FqVPp0GMDjnv4iEEGyQyczqjTlSikVfpAvDkA
         YhpA==
X-Gm-Message-State: AOAM531zLkfBCgHWmgvaW8rxrKwsm5Ck/ErWgGmsU3K+SP453IM2AKM8
        8zBAz5PIbR+90PTa372Y2COdSP1S1/B0jqRz452QOPS0gU4=
X-Google-Smtp-Source: ABdhPJzZBRKxNIt9RwuxFmMf+Bhu5Lir5zF4QY4VkRglhhaV1JkHKZh2VxLSnmqYBuz8lOMXTZLhxnu9A0kztlhywJs=
X-Received: by 2002:a02:9984:0:b0:32d:aeff:c592 with SMTP id
 a4-20020a029984000000b0032daeffc592mr19766298jal.46.1653585134536; Thu, 26
 May 2022 10:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqdgKtSDJj2QekYuS+M77wYrp6bvXv2Ue3xQ8Vm2bGGYAg@mail.gmail.com>
 <20220517212223.GL8056@merlins.org> <CAEzrpqcX3XEQGjoJCV1wARu=Od7vAypmzO4dCFgQ+_UBBuJdMA@mail.gmail.com>
 <20220518191241.GI13006@merlins.org> <CAEzrpqfPEU9Vt86ykVyxwvDXrihKfGc180oT7SUcQdwtYysquw@mail.gmail.com>
 <20220519222855.GL13006@merlins.org> <20220524011348.GR13006@merlins.org>
 <CAEzrpqd=G50pWKYJRD57ePVpfGNPu947zJXuZFdj0tF4yGzkbQ@mail.gmail.com>
 <20220524191345.GA1751747@merlins.org> <CAEzrpqdTpkvguQq+MGxYBb12-RF97dgW7cccz7o2HoSkrWt8gQ@mail.gmail.com>
 <20220526171046.GB1751747@merlins.org>
In-Reply-To: <20220526171046.GB1751747@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 26 May 2022 13:12:03 -0400
Message-ID: <CAEzrpqd_B13rDPCZLm9h0ji8f1oS7mCw=2d1-iiW=M26FfEcCw@mail.gmail.com>
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

On Thu, May 26, 2022 at 1:10 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, May 25, 2022 at 10:35:22AM -0400, Josef Bacik wrote:
> > At this point let's stop it and try and get the missing chunks back.
> > Looking at the chunk rescue code it looks like it should do the
> > correct thing, can you do
>
> I stopped it here, can't tell how far it was after almost a week of running:
>
> searching 163316 for bad extents
> processed 74514432 of 108576768 possible bytes, 68%
> Found an extent we don't have a block group for in the file
> History/JeanMerlin_Picts/VACANCES/0320-052633.jpg
> Deleting [58726, 108, 0] root 6781246275584 path top 6781246275584 top slot 18 leaf 11160503386112 slot 80
>
> searching 163316 for bad extents
> processed 74514432 of 108576768 possible bytes, 68%
> Found an extent we don't have a block group for in the file
> History/JeanMerlin_Picts/VACANCES/0320-052720.jpg
> Deleting [58727, 108, 0] root 6781246226432 path top 6781246226432 top slot 18 leaf 11160503353344 slot 82
>
> searching 163316 for bad extents
> processed 74514432 of 108576768 possible bytes, 68%
> Found an extent we don't have a block group for in the file
> History/JeanMerlin_Picts/VACANCES/0320-053405.jpg
> Deleting [58728, 108, 0] root 6781246275584 path top 6781246275584 top slot 18 leaf 11160503386112 slot 84
>
> searching 163316 for bad extents
> processed ^Z515008 of 108576768 possible bytes, 67%
>
> > btrfs rescue chunk-recover <device>
>
> Took close to a day to run, and now I have this:
>
> ./btrfs rescue chunk-recover /dev/mapper/dshelf1
> Scanning: DONE in dev0
> JOSEF: root 9
> Couldn't find the last root for 8
> We are going to rebuild the chunk tree on disk, it might destroy the old metadata on the disk, Are you sure? [y/N]:
>
> Do I say 'y' ?
>

Yup it should have found all the best chunks, lets let it do its thing.  Thanks,

Josef
