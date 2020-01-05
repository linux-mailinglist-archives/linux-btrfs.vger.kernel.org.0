Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDBE1305A7
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 05:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgAEEDo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 23:03:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43747 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgAEEDo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jan 2020 23:03:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so46054869wre.10
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Jan 2020 20:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CHYjwBEteuxfzFIVZuiheDQULE6TEn3Ijqcx+Mfth+E=;
        b=O6FGaM5jmmDpWxWsa16ZMz+/BFuKt6BUKKm1rYMAzBg3M00OuuwHcv2pPpX9Z27Z38
         wsfIqsW3K37kxOepLojmB6SdwKNWkxZ5vLwCXfhPmHiZ4DdsbVNp8hoh6pb8mSd/uu3j
         YD021mxQAA8agcE0APYVWGKkN726IeLCrJsdRuFXv2QWUcMFu3x8wny1FIyT+zBx+hq1
         J/gORik6plUwF6n4GJULllcvA3IqdWJoeOVOyVC7RLycZ4KGJf9ynQT7YY9v6VnbG91u
         lZ6R48Ny+qD+rN5Y9hZuu2exqIDjembKn0GqgGHvkZ1X1BZWbKPWpDFAeNotEQQ5+Opc
         39VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CHYjwBEteuxfzFIVZuiheDQULE6TEn3Ijqcx+Mfth+E=;
        b=V9F1uKI0OfI5jPwdpxu+YzPm0O//aY37i8FlCc1YfUckTTKk3GspVLyDpLPxDFaf3M
         Mj+pvFCyRy5cKyVuNQKoJVQjhl/dMeFeF7/jTm3moCj9A4Eqz04txcEkqAi+aRG1iIDZ
         Aqrf1Zrs4eKwI1R91qRSmlpXl6xpPf5Ra/mjy1InM5+eg/+mriNPzhkaWAlfcNaVIhST
         Cp+jep3gglq+dAKPff7vxgs1l53cO1dRfXFJElcW+LotkJAEPNi/2ToDzw7/xfR+Xbfs
         aaaTuGjkrV3+HhXg6vgV9feX/rYlfvmthEX3xRR8EeMJBQJeTg4hEoGhw9MaTNCc4jBm
         XzUQ==
X-Gm-Message-State: APjAAAWsShk+OQoNKjkeK+YdNhd6FDo8KcWP+AWCXctJFxkdqlbk0w81
        LY0GAv0qM1M3SBZK4kygJzPDJS7E4RiwsrE318MMWA==
X-Google-Smtp-Source: APXvYqwWoXW8GuDHN4u5MPIho1onyvdGsvGNzUJNAvKUvxw518vD7EUXWJ07VV10etlPQYVnjDN+CWW5m0iFaux4vvk=
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr99186719wrm.262.1578197022251;
 Sat, 04 Jan 2020 20:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20191206034406.40167-1-wqu@suse.com> <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com> <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com> <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com> <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
In-Reply-To: <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 4 Jan 2020 21:03:26 -0700
Message-ID: <CAJCQCtQmvHS8+Z7=B_8panSzo=Bfo0ymVU+cr_tR5z1uw+Ejug@mail.gmail.com>
Subject: Re: 12 TB btrfs file system on virtual machine broke again
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 4, 2020 at 10:07 AM Christian Wimmer
<telefonchris@icloud.com> wrote:
>
> Hi guys,
>
> I run again in a problem with my btrfs files system.
> I start wondering if this filesystem type is right for my needs.
> Could you please help me in recovering my 12TB partition?

If you're having recurring problems, there's a decent chance it's
hardware related and not Btrfs, because Btrfs is pretty stable on
stable hardware. Btrfs is actually fussier than other file systems
because everything is checksummed.


> What happened?
> -> This time I was just rebooting normally my virtual machine. I discover=
ed during the past days that the system hangs for some seconds so I thought=
 it would be a good idea to reboot my SUSE Linux after 14 days of working. =
The machine powered off normally but when starting it run into messages lik=
e the pasted ones.

A complete dmesg leading up to the problem would be useful. Kernel
messages at the last moments it was working, and also messages for the
first mount attempt that failed. And kernel versions for both (sounds
like 5.4 series).

And also `btrfs check` output, no repair.

> btrfs-progs-5.4]# ./btrfs restore -l /dev/sdb1
> checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
> checksum verify failed on 3181912915968 found 00000071 wanted 00000066
> checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
> bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968, have=
=3D4908658797358025935
> checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
> checksum verify failed on 2688520683520 found 000000EE wanted FFFFFFEB
> checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
> bad tree block 2688520683520, bytenr mismatch, want=3D2688520683520, have=
=3D10123237912294
> Could not open root, trying backup super
> checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
> checksum verify failed on 3181912915968 found 00000071 wanted 00000066
> checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
> bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968, have=
=3D4908658797358025935
> checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
> checksum verify failed on 2688520683520 found 000000EE wanted FFFFFFEB
> checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
> bad tree block 2688520683520, bytenr mismatch, want=3D2688520683520, have=
=3D10123237912294
> Could not open root, trying backup super
> checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
> checksum verify failed on 3181912915968 found 00000071 wanted 00000066
> checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
> bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968, have=
=3D4908658797358025935
> checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
> checksum verify failed on 2688520683520 found 000000EE wanted FFFFFFEB
> checksum verify failed on 2688520683520 found 000000D5 wanted FFFFFFA9
> bad tree block 2688520683520, bytenr mismatch, want=3D2688520683520, have=
=3D10123237912294
> Could not open root, trying backup super
> btrfs-progs-5.4]#


I'm not sure, the checksums found vs wanted look a little suspicious.

--=20
Chris Murphy
