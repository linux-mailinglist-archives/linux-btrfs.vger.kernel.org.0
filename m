Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15AD1C232F
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 07:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgEBFZ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 01:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726463AbgEBFZ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 01:25:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ED1C061A0C
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 22:25:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f18so4420657lja.13
        for <linux-btrfs@vger.kernel.org>; Fri, 01 May 2020 22:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G3cuB6/F/gYy3e4UffMeL7R/cVRlNrRIpas2p6OHtQ8=;
        b=BDEZOKgfmOOdYswfr8BqQ1hyEruES5WCMroVrgMiZL8Y6m6uU0ljZY2UwNegREETrM
         14Ro9FiSIZiQWQMUzVGbP4WIyWSCWIOFI8oPgC9Y+F7wvbeBLGTlm447u/womoIg0pAR
         OBMX6Jexo5n4oEzYJmY5LuheMB4e+9piyAaK6f9q2IsSIeFII5MP0Pp73z4yK7wb7g+K
         rsEttythnwsKU2ykJSECBZv20oFwMBBqCIcqbsv/nKrz1mpoQSFtc2GyParjgLMORM8j
         19InL1s9nTDGBgCdCEbtjU3a/JhOeaGM8PmawRU4ez7PxRzr8BTZyRG31aGimBmCCR8E
         Bhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G3cuB6/F/gYy3e4UffMeL7R/cVRlNrRIpas2p6OHtQ8=;
        b=OHJJAco+90zkZh96zaU5oDtH0fo7EjUmcuPvxRwCn4C2NsAo2jFttraZS+hcB9SAsd
         JYLkAhtYsmEOe2ukCbWlmucRYdBvVSWe63QQoAvk/dED1Z7yxHfYVYrXM04TViBIFH9z
         TaYC6AAZK2Fobf7MIghar59DlvyhlDxARbNxXxU1YpNOwUx8+8rQPYTPgkMlVFTUJh0u
         Kpfy9MBf6PuoyB/2Jr7RXbczmuDKkOzOoTl0WR5MIUNqaJBozrPMd19d3I+ruKnItqwB
         ehKSdHK7hcGQy06rNRk95XsBjOlPDFQd1jZjZef6rkzEIeF4eofo6bQxziNzIWjinsCK
         eM1Q==
X-Gm-Message-State: AGi0PuZvX7fbbM9DGrgh2bX7/01UWhff9jM75ZCqqnwEpeEHov+7pKXD
        38Qzk7STlI09d/AP+KBQ+oXZkgHFoWFOE79giK21K0z1Z1Y=
X-Google-Smtp-Source: APiQypJJk/wd/HmeM6Fj/imYUI7PV+qoLJQXZKqEpjsFv8HXqwN2MI9FVYKLEis3763MoQXCebPhYyA2iA3u2GL0EiA=
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr3962046ljp.209.1588397156124;
 Fri, 01 May 2020 22:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net> <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
In-Reply-To: <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
From:   Phil Karn <karn@ka9q.net>
Date:   Fri, 1 May 2020 22:25:44 -0700
Message-ID: <CAMwB8mi62y+9BfXYSmS0-VStGFnqDi8_UkskrdfPg5LsexaRNQ@mail.gmail.com>
Subject: Re: Extremely slow device removals
To:     Paul Jones <paul@pauljones.id.au>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Jean-Denis Girard <jd.girard@sysnux.pf>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm still not sure I understand what "balance" really does. I've run
it quite a few times, with increasing percentage limits as
recommended, but my drives never end up with equal amounts of data.
Maybe that's because I've got an oddball configuration involving
drives of two different sizes and (temporarily at least) an odd number
of drives. It *sounds* like it ought to do what you describe, but what
I read sounds more like an internal defragmentation operation on data
and metadata storage areas. Is it both?

On Fri, May 1, 2020 at 9:48 PM Paul Jones <paul@pauljones.id.au> wrote:

> Delete seems to work like a balance. I've had a totally unbalanced raid 1=
 array and after removing a single almost full drive all the remaining driv=
es are magically 50% full, down from 90% and up from 10%. It's a bit stress=
ful when there is a missing disk as you can only delete a missing disk, not=
 replace it.
> It would be nice if BTRFS had some more smarts so it knows when to "balan=
ce" data, and when to simply "move/copy" a single copy of data.
>
>
> Paul.
