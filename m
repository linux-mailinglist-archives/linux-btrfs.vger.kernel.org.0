Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB8F46A579
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 20:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbhLFTT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 14:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348363AbhLFTT4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 14:19:56 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFCEC061746
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 11:16:27 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id a24so10840316qvb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 11:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3eParsN2o2IxMadBOPDU2UFQoGfhQIi1MqLADh1ydBw=;
        b=qh8sTMC6PYDhWpePYo1lt5HyhXJOTBs9U1j5HtfpuF8PR55BVnyVydAUd953tJqp6e
         /3NE9I1qfNHLYoSHcZIFAiJbuv/NelXv6ZfdTemrlqBCSJ8B3qUdAf0q9hCDLlV+kH3m
         Ptx7+ie4NVEqMVeNeHoydpuCB1+i+g9nDwRmKSuI85jCekjYgngKJcGNy2nJZVcj+cil
         ih1dUnLOwurv+DeKchaBTHkQ2TwFx3nf5Ii7r7DdQE9FFpR+4OHm0B+acuHGRyi1hCEq
         85FKKYg+rioKOgHPRCcSXtbEQQYCp6bwrMO27lwTFpV8Z2CnmFOejsKL3BXebDo3t7DP
         P6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3eParsN2o2IxMadBOPDU2UFQoGfhQIi1MqLADh1ydBw=;
        b=wA19qywdtMExuyLZIP02gQkBeRZYqcDsVGu4V2CCnNgRdNDsES9XtVatCk1dCnyxkd
         Un0c+q1j6t8DOCTXz3c3Je4k4TEu+odt/kUp/8PW42YE2cdW1O7HszcuqMCCGoaEW9gZ
         RUMtKMJg+e0JEgDNBX9nUhdqWPidWUxkjheG36DuTvIjyDsildyaGlQ3UGDD4hDLG3gT
         J9R5Al17URdKkyyuLtxX8vRZ4o9YmQZ5h1Jdu52gPl05k+fDQEVUMSq7ChFYQf691pWv
         v245IBl5N9vWmAIm8wlJ2i1qwwAEzdIktfQzy+rANlcwwuA4TXp3N2T2BCRdk8wn8kIb
         9PHw==
X-Gm-Message-State: AOAM533d6eJBn1SMCBLNHHyIJoJxGPJXyL7PkEw2gViPU/yyvC+UVDOY
        JXfw9VRLNGKV1O9r8ZtOl3Prkw==
X-Google-Smtp-Source: ABdhPJxwlzhdEk9z4sinpSMJVq5FWpFlKbGKKQor+OIqfGhT70/Ytu3e6aeYw3Sw+uRbprqsMr/95w==
X-Received: by 2002:a0c:ef4c:: with SMTP id t12mr40259705qvs.110.1638818186792;
        Mon, 06 Dec 2021 11:16:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r16sm7953234qta.46.2021.12.06.11.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:16:26 -0800 (PST)
Date:   Mon, 6 Dec 2021 14:16:24 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: free device if we fail to open it
Message-ID: <Ya5hiA1MIOTtyFwZ@localhost.localdomain>
References: <7cfd63a1232900565abf487e82b7aa4af5fbca29.1638393521.git.josef@toxicpanda.com>
 <fdd4a2c9-00dd-430c-0537-d43734337845@oracle.com>
 <YajuCbMN4H0Ap76V@localhost.localdomain>
 <b25ba451-18f3-073f-0691-c99b10fd8c9a@oracle.com>
 <Yaoy2Ib85CZ/QJXs@localhost.localdomain>
 <3e1ca8f0-e817-6314-90eb-84b10e03ee77@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1ca8f0-e817-6314-90eb-84b10e03ee77@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 06, 2021 at 10:32:07PM +0800, Anand Jain wrote:
> 
> <snip>
> 
> 
> > >   I got it. It shouldn't be difficult to reproduce and, I could reproduce.
> > > Without this patch.
> > > 
> > > 
> > >   Below is a device with two different paths. dm and its mapper.
> > > 
> > > ----------
> > >   $ ls -bli /dev/mapper/vg-scratch1  /dev/dm-1
> > >   561 brw-rw---- 1 root disk 252, 1 Dec  3 12:13 /dev/dm-1
> > >   565 lrwxrwxrwx 1 root root      7 Dec  3 12:13 /dev/mapper/vg-scratch1 ->
> > > ../dm-1
> > > ----------
> > > 
> > >   Clean the fs_devices.
> > > 
> > > ----------
> > >   $ btrfs dev scan --forget
> > > ----------
> > > 
> > >   Use the mapper to do mkfs.btrfs.
> > > 
> > > ----------
> > >   $ mkfs.btrfs -fq /dev/mapper/vg-scratch0
> > >   $ mount /dev/mapper/vg-scratch0 /btrfs
> > > ----------
> > > 
> > >   Crete raid1 again using mapper path.
> > > 
> > > ----------
> > >   $ mkfs.btrfs -U $uuid -fq -draid1 -mraid1 /dev/mapper/vg-scratch1
> > > /dev/mapper/vg-scratch2
> > > ----------
> > > 
> > >   Use dm path to add the device which belongs to another btrfs filesystem.
> > > 
> > > ----------
> > >   $ btrfs dev add -f /dev/dm-1 /btrfs
> > > ----------
> > > 
> > >   Now mount the above raid1 in degraded mode.
> > > 
> > > ----------
> > >   $ mount -o degraded /dev/mapper/vg-scratch2 /btrfs1
> > > ----------
> > > 
> > 
> > Ahhh nice, I couldn't figure out a way to trigger it manually.  I wonder if we
> > can figure out a way to do this in xfstests without needing to have your
> > SCRATCH_DEV on lvm already?
> 
> Yep. A dm linear on top of a raw device will help. I have a rough draft
> working. I could send it to xfstests if you want?
> 

Yes please, that would be helpful.

> > > > Yeah I was a little fuzzy on this.  I think *any* failure should mean that we
> > > > remove the device from the fs_devices tho right?  So that we show we're missing
> > > > a device, since we can't actually access it?  I'm actually asking, because I
> > > > think we can go either way, but to me I think any failure sure result in the
> > > > removal of the device so we can re-scan the correct one.  Thanks,
> > > > 
> > > 
> > > It is difficult to generalize, I guess. For example, consider the transient
> > > errors during the boot-up and the errors due to slow to-ready devices or the
> > > system-related errors such as ENOMEM/EACCES, all these does not call for
> > > device-free. If we free the device for transient errors, any further attempt
> > > to mount will fail unless it is device-scan again.
> > > 
> > > Here the bug is about btrfs_free_stale_devices() which failed to identify
> > > the same device when tricked by mixing the dm and mapper paths.
> > > Can I check with you if there is another way to fix this by checking the
> > > device major and min number or the serial number from the device inquiry
> > > page?
> > 
> 
> > I suppose I could just change it so that our verification proceses, like the
> > MAGIC or FSID checks, return ENODATA and we only do it in those cases.  Does
> > that seem reasonable?
> 
> The 'btrfs device add' calls btrfs_free_stale_devices(), however
> device_path_matched() fails to match the device by its path. So IMO, fix has
> to be in device_path_matched() but with a different parameter to match
> instead of device path.
> 
> Here is another manifestation of the same problem.
> 
> $ mkfs.btrfs -fq /dev/dm-0
> $ cat /proc/fs/btrfs/devlist | grep device:
>  device: /dev/dm-0
> 
> $ btrfs dev scan --forget /dev/dm-0
> ERROR: cannot unregister device '/dev/mapper/tsdb': No such file or
> directory
> 
> Above, mkfs.btrfs does not sanitizes the input device path however, the
> forget command sanitizes the input device to /dev/mapper/tsdb and the
> device_path_matched() in btrfs_free_stale_devices() fails. So fix has to be
> in device_path_matched() and, why not replace strcmp() with compare major
> and minor device numbers?

I like that better actually, you mind wiring it up since it's your idea?
Thanks,

Josef
