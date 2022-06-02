Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8F553BE8F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 21:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbiFBTSj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 15:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238501AbiFBTSb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 15:18:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81906140B5
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 12:18:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a17so2342460lfs.11
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Go3JplgG+8HWPmeBv4Rmi58Y1/7SSHz0KkVlWNpn/3w=;
        b=fHJO7+sRjP8Nnsii1xVkSRi5MQ8jHEIKF8pZN+Y/Bznb3OTm4fDV58WR7L559nx8EM
         ONaNF4/4CPJEUci8czfKWAcBEvTpz4wAIbpkNdGbQSAyWzF8h78WemcZ6PYRZa+dqqDb
         AqeZyL9mlmtyIcFAzI2Pi3HneBFh8JT86TUM/6yg1ADHdp2MUU7aEtNMhLfQpPpgTC+H
         WySH8oJMCQzLhmIiBfxPrXMEZh3TXX/adGTBl4m77kq9ypasW99b8eVvGh/FfDUw3Ia9
         dWzwJIhmsYt1TYRQRp0uZFzviogC6CypANaWyWQrm1/DvOOGTv9haGI7K4KA82NkD/80
         WHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Go3JplgG+8HWPmeBv4Rmi58Y1/7SSHz0KkVlWNpn/3w=;
        b=VXmT2v1X4DH8afyFlIk8fEYIhzdy7MLtF0ZL2qZ4A1W3lKOnJxs7OscTvASu/u/gWR
         tPUpaGkjp37Pliw5Ym1pZ9ZkgEE5wDkLa7hNuA9+Y5y72cM+SIK4X9F9pQZtVkoyHkCB
         3nGQ8jjaT4oKIn2Cz+z/qGtfXtom4YWCPfB8gQ3wKSZMy9tVxuc5e8ARzzya4e20GsYD
         /ttpwdPt3+O9bJ4QX0id7vZfXPtrvjtXC5YtK5AsagTQwhQFY6uEUkW+yMH0M/gnD7lE
         ezr/Cbr2tXb/ARkcKMG914r3pDpxTCVpAA1+7MuxAZ2ZPFlZ7sRt10ZDfPcJScw2ZfMC
         keJg==
X-Gm-Message-State: AOAM532tUszSgFKPo5Xb2p+4fpz+C1og3qEQp5EWHboHw/8oHz2/zgG4
        EfaxSSnVwi2OcqRN/+QTiQts+l9V4+vKFG2h1xjRhj6ykv4MRxXY
X-Google-Smtp-Source: ABdhPJw5cKRT1iC4XBgSNVnUfmJJCmunE7z7YhlqxQ8nazAjbgmJ/wWLb2pcO3Zc+5xXeQX+6dK/Z8YphY1edWbqusM=
X-Received: by 2002:ac2:4294:0:b0:473:e5bc:7a64 with SMTP id
 m20-20020ac24294000000b00473e5bc7a64mr4654978lfh.84.1654197507028; Thu, 02
 Jun 2022 12:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+H1V9xQEDf0G-Nvcv3irtSPF+09dJ6VMs7F8LBLpUGEUSfxmg@mail.gmail.com>
 <CAJCQCtSBoseoCm8vY+UoS_oC5sOBBRp7fV3mU-bJnUTZWJWRgQ@mail.gmail.com>
In-Reply-To: <CAJCQCtSBoseoCm8vY+UoS_oC5sOBBRp7fV3mU-bJnUTZWJWRgQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 2 Jun 2022 15:18:10 -0400
Message-ID: <CAJCQCtS+rL4v3wbo9EgPfsjrB08Ccv+YutBChGAQJBUyEd+LRA@mail.gmail.com>
Subject: Re: Manual intervention options for csum errors
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Matthew Warren <matthewwarren101010@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 2, 2022 at 3:12 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Wed, Jun 1, 2022 at 11:35 PM Matthew Warren
> <matthewwarren101010@gmail.com> wrote:
> >
> > I have FS which is currently not in any sort of raid configuration and
> > occasionally a bit flip will occur somewhere on the disk. It would be
> > nice to be able to tell BTRFS to recalculate the checksum for that
> > specific block and assume the data is correct. For instance, I just
> > had this bit flip in the csum for a non-important file which I have an
> > external backup of.
> >
> > Jun 01 15:58:04 planeptune kernel: BTRFS warning (device nvme0n1p2):
> > csum failed root 258 ino 63674380 off 208896 csum 0xa40b3c39 expected
> > csum 0xa40b2c39 mirror 1
>
> The csums are off by 1 bit. That doesn't mean the data on disk changed
> at all, because had there been a single bit flip in the data block,
> you'd have a completely different csum, it wouldn't be off by one.
> Looks like the data on disk did not change but the csum is computed
> wrong somewhere - either it was originally computed wrong (bit flip)
> and written to the csum tree where it's now persistently wrong. Or
> it's transiently computed wrong on read. Either way, it's most likely
> a memory bit flip. I suppose it could also be a memory bitflip in the
> drive itself.

Also, the reason why it isn't bit rot with the on disk csum resulting
in a one bit flip is because that would be detected by btrfs since the
leaf the csum is stored in is also checksummed. So if you were getting
a new one off bitflip here, the whole leaf would have been rendered
invalid, and all csums in it.

Chances are it is a bitflip after the csum was computed, and insertion
into the leaf, resulting in a leaf checksum that validates the wrong
csum.

But again, a one bit flip in a 4KiB data block would result in a much
bigger difference between have and expected csums because it's a hash
function.


-- 
Chris Murphy
