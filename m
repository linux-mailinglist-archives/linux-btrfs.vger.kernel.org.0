Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368B427B0F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgI1PdH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 11:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgI1PdH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 11:33:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4834C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 08:33:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k18so1603320wmj.5
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oS8i+xN9xU0O7oZ5xF3Cirk3qaaYVKOTZ2NyPhcevDg=;
        b=NVbVj+ldHMRyjU870LqMnF6u22irNxBWlx7NeCTsF4jAe+L4T1Q66XP3E2HXaItOnG
         Bks/f9k1a5F/FmKXS+4mx2sM/bF5BnVC+XWCzsZOjJ5sxfcDcPliOX8SFefdsEbiMqfm
         udZl+JkQGzxzSPP/0GoKDuyDJKV3jMeiCagXJZhcDAonzbpNN+l3jAeVc16Bt+t5RhqC
         kgXvNV/vJPX6SyOPcHo33867YTGtLnnaS0k8lHhaceWyVIyjSRRCBtqR5dt3f113GXN2
         D20zyCJ+wmuBDBbkK56yCFpS2FEWqlJMkbHLWkY+2iCV3NUSfs1X0jFeqGuLY3qv10iE
         570g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oS8i+xN9xU0O7oZ5xF3Cirk3qaaYVKOTZ2NyPhcevDg=;
        b=UfFOAEcpdn8bGqlMG4KIra9tC4T5YivvR7WlryHbyBNUsw54Yp4cZfbomFcYy93rQK
         UeQLEKap7ftk61OVjc4Ezd0oSsYgfXI9rDZTm8vtAwYsfOsHXlhvyHBlxisWg6xBAnqq
         gZTtAyzzjSv9ENkcBA2wxetPmADaONf0xmrYfZ7eVhhdiAITCoL3PvI8G6TeUFwoQq7S
         YYgmfo9W5nj9xx17eLvs2WYUzsPHTppy4IJ+9t0G4cek/h+V1l67Z1ud4RXm0yBEHV0w
         9LTmjctIQ/32saXVzJf5AGYw1/GyHaeu1LYopAnMscA2IBqBEtjxxueywg9J+z/C/r1n
         WuPA==
X-Gm-Message-State: AOAM533iufZNPsn2fKGjNEEmPoYJ7WrY+3V64niinORuHPKtK5bM3o0N
        Eg7B/wgENNK9OCVxM9Y2qF+r36HSi6xvO/VPeZllqLcE30Rf5Rrk
X-Google-Smtp-Source: ABdhPJzRZn3RVBaQXHOsN7WYv7o99NZaVOtGdCLa6CELb5wJK4r8vB1Ary0FNs5pXUI5wGkm/csIOleT/b3Y0WMsF4U=
X-Received: by 2002:a1c:960a:: with SMTP id y10mr2180822wmd.128.1601307184577;
 Mon, 28 Sep 2020 08:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <5df695c82cd7f44da5e57d3a8c8549a01130d759.camel@wittke-web.de>
In-Reply-To: <5df695c82cd7f44da5e57d3a8c8549a01130d759.camel@wittke-web.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 28 Sep 2020 09:32:48 -0600
Message-ID: <CAJCQCtSCRDh65+aAKs4C0t+c3n4aA8sBrE_QLsPy6JkZ0PwGmA@mail.gmail.com>
Subject: Re: Recover from Extent Tree Corruption (maybe due to hardware failure)
To:     Marc Wittke <marc@wittke-web.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 28, 2020 at 7:18 AM Marc Wittke <marc@wittke-web.de> wrote:

> # mount /dev/sdc1 /mnt
> mount: /mnt: can't read superblock on /dev/sdc1.

What about 'mount -o ro,usebackuproot' ?
Also include dmesg if it fails, and include:

'btrfs insp dump-s -f /dev/'

> # sudo btrfs restore -oi /dev/sdc1 /home/marc/rescued/

From the backup roots in the super, and also using 'btrfs-find-root'
it might be possible to find another root tree to use. This was NVMe.
What were the mount options being used?

Another possibility is to recover by isolating a specific snapshot.
Are there any snapshots on this file system?

'btrfs restore --list-roots'

Might be easier to do this on #btrfs, irc.freenode.net because it's
kinda iterative.

-- 
Chris Murphy
