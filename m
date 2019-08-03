Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083F880796
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2019 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfHCSBZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Aug 2019 14:01:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32894 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfHCSBZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Aug 2019 14:01:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so80517337wru.0
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Aug 2019 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hL/vyNIs/Hnd7Cu8kofOkuFbc6M3PbPeiviMKEi5H+8=;
        b=iJaHaN6DSiAmUitbrEU3eznhvA6RWVKsz/ncqAkQTRTopsJhE9wbSwb4tyS3PAMVKl
         kAVsIDptVoLtSuf2t+QqubKKWYLTVTbRNrSo81PHTwj9Djy/McoEm3yg+23elfg1vGhg
         AcJiICHf8l3IyfUBellUxSGF/g/4tJu1KN6yENW2++DRJA9bYzsKMWI73Hh3Zsv8JTPO
         G8ncvVjkOCxRhHs8bfmpPzfhDax3Qe9HuMiDyBDQ4YEQVBbBKAbiK4fpsP/EH7LMlKji
         E/I6UbFSpWpeaYU7cJfLzVxrfFkGKHG1uZy6UL02sutsSjTFhZ9HOjtJW06YIfDpxrFG
         LOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hL/vyNIs/Hnd7Cu8kofOkuFbc6M3PbPeiviMKEi5H+8=;
        b=cQBfEF4UMP7PnRfsAVnXjZ21l3bC4oiuTrkktozW9RAS7mPvRBbUDCSWdzVhjyxORJ
         0MMbus1A1ajS6phBksKAvz9zKIOLDNVEUqu4DRlTwHkLYCkmDoi89PoSpK4pFNpf9dlU
         oPKYPFu9o9waC8rvFliW8hPNTZoB7hWqCddydbSsfWJwSYr1bsS+9SJF6nRojMceNxcp
         NG6+h+UM48uUq2WxmU528+l0ZRZtGa4CA7qnLcE2oiFAkfWiQjWCOxmwjVH3V0KL9983
         9dtwz7pNRDcv9LfGe/M2dozj5G1+oPJoCeLTRH6IrH33hiK+hA1bbm5Y6i6dkp61PKVa
         9LRw==
X-Gm-Message-State: APjAAAXYcTNf74UobYAkO3ovtHp26tU/TIFYg6JoadjM4hgVA1yRTLHR
        LqGJCM8Sr4ChYyDnNdeLHfxW7pDPEjR2CSl8badaKsy4fkY=
X-Google-Smtp-Source: APXvYqw6+N4o/rIJcs6HONO0Czh0JMzYhtVVRWFc1gdqgXB4XH9yzGOxFKEE5H9p7ISHglvjjiu2lN7ABPS0o3BU7cY=
X-Received: by 2002:adf:dd01:: with SMTP id a1mr62104868wrm.12.1564855283209;
 Sat, 03 Aug 2019 11:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190803100928.GB29941@tik.uni-stuttgart.de>
In-Reply-To: <20190803100928.GB29941@tik.uni-stuttgart.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 3 Aug 2019 12:01:12 -0600
Message-ID: <CAJCQCtSm2a_UNYgue_Ha-JBCXpxrzZh2J5zHfkAXwHdRodJ8Fw@mail.gmail.com>
Subject: Re: btrfs on RHEL7 (kernel 3.10.0) production ready?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Ulli Horlacher <framstag@rus.uni-stuttgart.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 3, 2019 at 4:09 AM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
>
> I have RHEL 7 and CentOS 7.6 servers with kernel 3.10.0 and btrfs-progs v4.9.1
> Is btrfs there ready for production usage(*)?

No, Btrfs is deprecated in RHEL.
https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/7.4_Release_Notes/chap-Red_Hat_Enterprise_Linux-7.4_Release_Notes-Deprecated_Functionality.html

Discussion here:
https://lwn.net/Articles/729488/
https://news.ycombinator.com/item?id=14907771
https://access.redhat.com/discussions/3138231

If you want to use Btrfs in production, and have distribution support,
you'd need to consider SUSE. If you want a similar feature set to
Btrfs, but remain supported on RHEL, you'd need to discuss it with
your Red Hat account manager.

If upstream support for Btrfs is adequate then you'll want to use a
recent stable kernel, and have a test and update strategy for
balancing out the risk of incorporating new kernels as they're
released vs the risk of using a fixed kernel version that grows stale
over time.


-- 
Chris Murphy
