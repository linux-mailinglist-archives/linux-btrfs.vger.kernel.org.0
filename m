Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F1B18C0A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 20:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgCSTpY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 15:45:24 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:35642 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCSTpY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 15:45:24 -0400
Received: by mail-wm1-f45.google.com with SMTP id m3so3795379wmi.0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WL8A32uv39P04mnohuFjgpwkaFen+Ceu1g3CD4m72pI=;
        b=oHnNPCtfS+ShenLzJ36o36hEIk5QvPJqWooRDXWER0lhNz04zXwngHx5p7Go2IQLFX
         0KaTcRSRFBdCfftg3f6Fl6wNYaNarqskE0DrfY9cxpPosxk80UkmsklCx7x54gYXxLQn
         aEED0HHgfb/ZNXhjo+yN2x8tw66gUTBrLs0JAX1wv48ipY2VTppgC+1HWoQ1zkvkQI+3
         r2iO6Ed+XzdG3oK9cHaUFmJZvFVkxxMQyU908POhXjfA14SIY7WyUakJDJ/rAV7Z65Hp
         XLdfgKtxOnIOXrkuiO0MKVR67u76bcKseieoe06EsgTLFeZ8CAvwYZHQuEume4Z/sugI
         mY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WL8A32uv39P04mnohuFjgpwkaFen+Ceu1g3CD4m72pI=;
        b=ta/Rz+wcrGV7cezRRGtefHdqBL06chEA35e0qDjNuheDYrlxxYVMSH4TRU9kHHK04c
         xwtwkbwROF/JMqNXTHqN4tIbTJlVpnxC4pxswnYLHTu4U425DUeQOtTVLi0wvolV7RxV
         lzxevQdxsbvCy2MlwhfjJXuKvG5SQXEB4zUCWc1NelotE2ewn9GTem2PbvGtA+oSFbwV
         gTgsng0mwKGqe6EPeICIM7kBW1NvBWLpIuormIazkbs5qS+2ywtB+pYBnhV2d9/J5hMT
         t5JBYVQWH6F0B8OnnU01G6Nadr8PbNy45qeUb3/LPu6QLZr1GNN/EXwXK9J/tqMKO1vr
         yXig==
X-Gm-Message-State: ANhLgQ2G6gv+tvrq1V4wUfv9kGr6aGeS7cwN41/Ms/kQxpqLh3iv6MCL
        NATzHWkm93pXj4jYNHhUdAOvAZN5fylXu/cbR6TqQA==
X-Google-Smtp-Source: ADFU+vvCBq854YRX+M4Qt5tl792nmg8mGFCU63WrzR8WpIemQqTtXSEKanMF+f52fYmCfUVS6quQHGdm5QNNxnHoFYc=
X-Received: by 2002:a05:600c:2f1a:: with SMTP id r26mr5715031wmn.11.1584647122577;
 Thu, 19 Mar 2020 12:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAPuGWB8Aqvr6po0-nJskh_5W3rUv1+y2P2U-pYMAJ_wwKnLjkA@mail.gmail.com>
In-Reply-To: <CAPuGWB8Aqvr6po0-nJskh_5W3rUv1+y2P2U-pYMAJ_wwKnLjkA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 19 Mar 2020 13:45:06 -0600
Message-ID: <CAJCQCtTGo_phSJ+rw4Y6nqsDrcmQdLDMX4osQ=4kZe5yZc21Ug@mail.gmail.com>
Subject: Re: How do damaged root trees happen and how to protect against power cut?
To:     Carsten Behling <carsten.behling@googlemail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 19, 2020 at 9:14 AM Carsten Behling
<carsten.behling@googlemail.com> wrote:
>
> Hi,
>
> the investigation of damaged root trees are already discussed in the
> thread starting with
>
> https://www.spinics.net/lists/linux-btrfs/msg74019.html
>
> However, one point wasn't discussed at the end:
>
> > I thought so too. Is there a reason why they ended up being colocated?
> > I'm surprised with all the redundancies btrfs is capable of, this can
> > happen. Was it because the volume was starting to become full? (This
> > whole exercise of turning on mirroring was because we're migrating to
> > bigger disks)
>
> Because I have the same issue on an embedded system, after a power
> cut, where none of the root tree copies are usable anymore, I'd also
> like to know :
>
> - How can we end up in that recoverable state?
> - Why can't we protect the fs against the unrecoverable state?
> - Why is that error is so hard to recover?

I'm interested in this too. Also I want to know whether and what Btrfs
debug or consistency check flags are applicable in discovering these
problems as near to the time as they occur; whether they're Btrfs,
block layer, or device problems.


> Furthermore, I'd like to know what would be the best solution for an
> embedded system where power cuts are unavoidable (because of a missing
> circuit). I'm thinking of using a read-only rootfs with a separate
> data partition to ensure at least a booting system. But anyway, the
> data partition could end up in the same state.
>
> I'm not sure if it would be also a good option working with snapshots.
> My space on the embedded device is limited to 8GB. The OS already
> takes about 4GB.

Seed device?

Create a Btrfs file system, use space_cache v2,
compress-force=zstd:16, and write the root image. Resize the file
system to minimum. Set the seed flag. That's the base image. Part of
the provisioning will be to 'btrfs device add' a 2nd partition, and
remount read-write. This means two Btrfs file systems exist, each with
their own UUID. You can reference the read-only seed by its UUID; and
you can reference the read-write volume by its own UUID. On-disk
metadata for this read-write volume points to both the read-only seed
devid1, and the writable 2nd device devid2.

Make sure write cache on the physical media is disabled.

It might be true that 'flushoncommit' and 'notreelog' reduce
complexity for recovery following a crash; at the expense of losing
some data in the latter case. (It's been suggested before in the
archives, but I have no good way to test if results in less instance
of crash/powerfail recoveries because I personally haven't hit any
problems with the default mount options, despite hundreds of
intentional force power offs while writing.)

For embedded systems, consider using industrial flash. They are slower
but more reliable, especially in the case of a power cut. SD Cards are
notorious for corruption and going permanently read-only when power is
cut; but I've had this problem with USB sticks too.


-- 
Chris Murphy
