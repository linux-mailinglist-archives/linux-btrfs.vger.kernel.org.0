Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A787B16C7C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 22:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEGUmF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 16:42:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44767 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfEGUmF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 16:42:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id e13so962726ljl.11
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 13:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=doId5bT6YfiqO0TtxcmaiAqGJq6tb7R1gJYJXfV4Uxg=;
        b=hFpJjZWDCOo5C+brluYjVyHw9MoXbKil7QZDzuORcsDTKlQbsRPC3SnixsOquzA2jc
         M5K7LyWcBVfx1f0zD7lGcLJTvmYcdVhWOlIGXH7De/rBG0IlAAVyEKhq+yqoXBXARr8s
         VzgUrnNkX4zhpW9VXmA1eJU3xE/O4c5BIiMuADtpTEi1q7zr2sf1lpSFFK3GsbXJ0IiC
         DvbivINU99YCddsHTQyaRsY2LNf7ZQ5GnMmPMYUv5wVBkvIobLn0bG6VCPQMPVt5jHbd
         ZMdyjRCxNpSQcmXPYWRIVpXeJX96uzml5Ildjsd+KoX7offu5uyqCXwGofCH4yjR37l8
         dpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=doId5bT6YfiqO0TtxcmaiAqGJq6tb7R1gJYJXfV4Uxg=;
        b=i5DpGjgVmgZzvUIz2sagC6zeAF3mSDjddABt7QmnLdRE4G+GXPBdHUfC7vFo/eZrEg
         TLgY9nGEAzIBe+ofyt6ZLZVoDU2B2H5WMMtYZi235O1AhLoVUo4cMFx1FlpyfClcPQvX
         aN/YBl57WR+uHIp201p/qHOJfv66nzg/SYBkTC/JyfMDtm6vnQHI3f43XpmyyRMDakq9
         Kc0KQ2zJ3Y9642OlYIOsfBr3RuknSQoRa26k32vgSUR0iGH1ClcWL8xZFAsu06rnPAk6
         qoHFfUjcC63qmZIKL9Bym4lDdCu2YOb9o3eAbqeuk6gbrMyklq3WZg1wNRiaPlkwuJ1J
         QJHQ==
X-Gm-Message-State: APjAAAWjctQuoBUOGcK5jXrn5Wco6k6lZ0CIMBKdFAmaHPgA8rzQYIxe
        Smo6GXJ7IlV/pJFKI2OePzV/kzgYTKtwn43d+/G+lBOWpsg=
X-Google-Smtp-Source: APXvYqy2Po7mUHGFNPtSgY/1ehREz3y60WT0RzBiFZNePI83L0hHBySNAdnxVFBDYvXost2SJofZEeAEvix36iFSwmM=
X-Received: by 2002:a2e:2413:: with SMTP id k19mr4008605ljk.121.1557261723475;
 Tue, 07 May 2019 13:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj_TLB=bqYmt6imjS-QU7OUtvGzatcVDZeCeCj1EfJA-3neKQ@mail.gmail.com>
In-Reply-To: <CAHj_TLB=bqYmt6imjS-QU7OUtvGzatcVDZeCeCj1EfJA-3neKQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 7 May 2019 14:41:52 -0600
Message-ID: <CAJCQCtSED29gxLsLD6FqPx87c63LdZO8TUhZPbVWEw8+a57MSQ@mail.gmail.com>
Subject: Re: Howto read btrfs stack trace?
To:     =?UTF-8?B?T3R0byBLZWvDpGzDpGluZW4=?= <otto@seravo.fi>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 6, 2019 at 10:22 AM Otto Kek=C3=A4l=C3=A4inen <otto@seravo.fi> =
wrote:
>
> Logs have the output below. How shall I read it and debug this situation?
> What are the next steps I could test/debug?
>
>
> kernel: BTRFS info (device dm-9): disk space caching is enabled
> kernel: BTRFS: has skinny extents
> kernel: BTRFS: checking UUID tree
> kernel: BTRFS info (device dm-9): relocating block group 13693423976448 f=
lags 20
> kernel: INFO: task btrfs:2918 blocked for more than 120 seconds.
> kernel:       Not tainted 4.4.0-146-generic #172-Ubuntu

Old kernel, a developer may not reply. This list is for upstream
development so the normal recommendation is to try a newer kernel and
see if the problem still happens. If it still happens, it's still a
bug. If it doesn't happen, probably has been fixed in a newer kernel
but hard to say which one without deep Btrfs knowledge of all the
chances since 4.4 which really is a long time ago, tens of thousands
of commits have happened since then.

If you don't want to try a new kernel you can try the mount option
skip_balance and see if that prevents the balance from resuming. If so
you can 'btrfs balance cancel' it, and then I suggest not doing
another balance. Update your backups at this point in case the problem
with the file system gets worse.

If you are booting from this file system, you can use
'rootflags=3Dskip_balance' as the boot parameter in the bootloader;
mount options are separated by comma and no space.

From the call trace, it's clearly stuck in the balance. I'd say it is
a bug but I don't know why it happens or if there is any work around
other than just using a much newer kernel.

I'm not familiar with the Ubuntu build system and how to get a
rescue/install image with a very new kernel. But I just tested this
image and it works:
https://kojipkgs.fedoraproject.org/compose/rawhide/Fedora-Rawhide-20190506.=
n.1/compose/Everything/x86_64/iso/Fedora-Everything-netinst-x86_64-Rawhide-=
20190506.n.1.iso

You can dd that to a USB stick and boot either BIOS or UEFI firmware
computers. At the bootloader choose Troubleshoot..., and then the
Rescue... option. That will get you to a menu where you can just drop
to a shell, option 3. That kernel is 5.1rc7+ so it's something in
between 5.1rc7 and 5.1.0, and is based on git ea9866793d1e.

From here you can do a mount. If you previously cancelled the balance,
you can use 'btrfs balance resume' to resume, and see if it runs into
the same problem. If it does, then yeah it's still a bug, if not maybe
it's fixed. But again, I'm not sure if there is a backport of the fix
to older kernels or what version the backport is found in.



--=20
Chris Murphy
