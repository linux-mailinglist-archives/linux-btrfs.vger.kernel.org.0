Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD8852DFFE
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 00:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245493AbiESWcD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 18:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiESWcA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 18:32:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF687B41C2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 15:31:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so9941617pjb.2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 15:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kwKOiO93ksLuvRy5JF1IMCijph6M8ZEzmFOS1jGN7CU=;
        b=WwoLmguzevEsPoFF0ggKQIrpr/bzs1pj1VCU/XUM4TTnFam+DKfrEF6ftFrTy3HR18
         BZJgN31Y5f2Xhm7hOiCBbncovml9xg9d6nyX28ZIJHGMgwk5AXOAz/AKtWtv54WDqZ7J
         /JbHGv24w6axpXvKijWQINAUs9uqifECEpZggaa1GZ8maQYAp+Ucev9ThGy5bkAwmu3p
         Ash2ct32sHkK4d05NblDyo5ssRq5tfDXH2uOnDy3iCY+WESVJNg+mlT651zYF9PRcCN+
         gXN1dWwgiZC/o/19FcLim71XhEH3YSKMpyXMDM0d2gXzZKZB3hIE5OSG3VbKLFmxIa5G
         kXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kwKOiO93ksLuvRy5JF1IMCijph6M8ZEzmFOS1jGN7CU=;
        b=BJsUrp/xqvh9MqVWaROBVc4vr+/OkngbS2UTxfpVJhY9SBxtmsne/4urRzZrUCFUVo
         zX6nBEgI+FMwwTJLDCXwGIWAjkM1u0DNrz+1E5wHJxadzL6RLuawFCsVSFz51o0kCiji
         d6nhwabTCBsvKMlVQQqG23acm/UGVkmMQH1QBEqRY6QUgxxXE4djTxqU25gNx4qNoMae
         mxV3CxJHmzBVwKEV9sF4m+tv8XbDMRttpZ9FEpBpQjzRbe7ZhYbfvddnQIlKcYQYaFrQ
         EfaZRm1dE4L6HWmQvZEuvgV+CCfFw7ctnE6XfsEf/HpzSCQjWOSdctgDae7S7/HhjFfK
         2BKw==
X-Gm-Message-State: AOAM533pE4Qs8H/ygZYW3W9ZbQoEOadq9wwSRrTumpCAowdgyC9hsjHA
        NdYWbFMko4f46ga1dgy2L/PiQkje5jYCrw==
X-Google-Smtp-Source: ABdhPJxWaC4X4t2x1tzHiQq6YI0VPA1RLG8t9FervutJCgZEzW92JGbuAY/8dlpGo33GQcxncsq7qA==
X-Received: by 2002:a17:90b:1d0b:b0:1df:b3dc:5140 with SMTP id on11-20020a17090b1d0b00b001dfb3dc5140mr7382662pjb.225.1652999518826;
        Thu, 19 May 2022 15:31:58 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:500::1:1d15])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090abf1600b001d6a79768b6sm293252pjs.49.2022.05.19.15.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 15:31:57 -0700 (PDT)
Date:   Thu, 19 May 2022 15:31:56 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v15 3/7] btrfs: add send stream v2 definitions
Message-ID: <YobFXNs0TVBV8xCc@relinquished.localdomain>
References: <cover.1649092662.git.osandov@fb.com>
 <abea9f460c7341361e58cbba8af355654eb94b5b.1649092662.git.osandov@fb.com>
 <20220518210003.GK18596@twin.jikos.cz>
 <YoVyXsuWEOX6dtXE@relinquished.localdomain>
 <20220519160748.GM18596@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519160748.GM18596@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 19, 2022 at 06:07:49PM +0200, David Sterba wrote:
> On Wed, May 18, 2022 at 03:25:34PM -0700, Omar Sandoval wrote:
> > On Wed, May 18, 2022 at 11:00:03PM +0200, David Sterba wrote:
> > > On Mon, Apr 04, 2022 at 10:29:05AM -0700, Omar Sandoval wrote:
> > > > @@ -80,16 +84,20 @@ enum btrfs_send_cmd {
> > > >  	BTRFS_SEND_C_MAX_V1 = 22,
> > > >  
> > > >  	/* Version 2 */
> > > > -	BTRFS_SEND_C_MAX_V2 = 22,
> > > > +	BTRFS_SEND_C_FALLOCATE = 23,
> > > > +	BTRFS_SEND_C_SETFLAGS = 24,
> > > 
> > > Do you have patches that implement the fallocate modes and setflags? I
> > > don't see it in this patchset.
> > 
> > Nope, as discussed before, in order to keep the patch series managable,
> > this series adds the definitions and receive support for fallocate and
> > setflags, but leaves the send side to be implemented at a later time.
> > 
> > I implemented fallocate for send back in 2019:
> > https://github.com/osandov/linux/commits/btrfs-send-v2. It passed some
> > basic testing back then, but it'd need a big rebase and more testing.
> 
> The patches in the branch are partially cleanups and preparatory work,
> so at least avoiding sending the holes would be nice to have for v2 as
> it was one of the first bugs reported. The falllocate modes seem to be
> easy. The rest is about the versioning infrastructure that we already
> have merged.

I rebased the patches on this series:
https://github.com/osandov/linux/commits/btrfs-send-v2-redux. It passes
some basic testing, but it'll definitely need a lot of fstests.

> > > The setflags should be switched to
> > > something closer to the recent refactoring that unifies all the
> > > flags/attrs to fileattr. I have a prototype patch for that, comparing
> > > the inode flags in the same way as file mode, the tricky part is on the
> > > receive side how to apply them correctly. On the sending side it's
> > > simple though.
> > 
> > The way this series documents (and implements in receive)
> > BTRFS_SEND_C_SETFLAGS is that it's a simple call to FS_IOC_SETFLAGS with
> > given flags. I don't think this is affected by the change to fileattr,
> > unless I'm misunderstanding.
> 
> The SETFLAGS ioctls are obsolete and I don't want to make them part of
> the protocol defition because the bit namespace contains flags we don't
> have implemented or are not releated to anything in btrfs.
> 
> https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/fs.h#L220
> 
> It's basically just naming and specifying what exactly is the value so
> we should pick the most recent interface name that superseded SETFLAGS
> and the XFLAGS.

This is the situation with FS_IOC_SETFLAGS, FS_IOC_FSSETXATTR, and
fileattr as I understand it. Please correct me if I'm wrong:

- FS_IOC_SETFLAGS originally came from ext4 and was added to Btrfs very
  early on (commit 6cbff00f4632 ("Btrfs: implement
  FS_IOC_GETFLAGS/SETFLAGS/GETVERSION")).
- FS_IOC_FSSETXATTR originally came from XFS and was added to Btrfs a
  few years ago (in commit 025f2121488e ("btrfs: add FS_IOC_FSSETXATTR
  ioctl")).
- The two ioctls allow setting some of the same flags (e.g., IMMUTABLE,
  APPEND), but some are only supported by SETFLAGS (e.g., NOCOW) and
  some are only supported by FSSETXATTR (none of these are supported by
  Btrfs, however).
- fileattr is a recent VFS interface that is used to implement those two
  ioctls. It basically passes through the arguments for whichever ioctl
  was called and translates the equivalent flags between the two ioctls.
  It is not a new UAPI and doesn't have its own set of flags.

Is there another new UAPI that I'm missing that obsoletes SETFLAGS?

I see your point about the irrelevant flags in SETFLAGS, however. Is
your suggestion to have our own send protocol-specific set of flags that
we translate to whatever ioctl we need to make?

> > This is in line with the other commands being straightforward system
> > calls, but it does mean that the sending side has to deal with the
> > complexities of an immutable or append-only file being modified between
> > incremental sends (by temporarily clearing the flag), and of inherited
> > flags (e.g., a COW file inside of a NOCOW directory).
> 
> Yeah the receiving side needs to understand the constraints of the
> flags, it has only the information about the final state and not the
> order in which the flags get applied.

If the sender only tells the receiver what the final flags are, then
yes, the receiver would need to deal with, e.g., temporarily clearing
and resetting flags. The way I envisioned it was that the sender would
instead send commands for those intermediate flag operations. E.g., if
the incremental send requires writing some data to a file that is
immutable in both the source and the parent subvolume, the sender could
send commands to: clear the immutable flag, write the data, set the
immutable flag. This is a lot like the orphan renaming that you
mentioned.

If we want to have receive handle the intermediate states instead, then
I would like to postpone SETFLAGS (or whatever we call it) to send
protocol v3, since it'll be very tricky to get right and we can't add it
to the protocol without having an implementation in the receiver.

On the other hand, if send takes care of the intermediate states and
receive just has to blindly apply the flags, then we can add SETFLAGS to
the protocol and receive now and implement it in send later. That is
exactly what this patch series does.

I'm fine with either of those paths forward, but I don't want to block
the compressed send/receive on SETFLAGS or fallocate.

Thanks,
Omar
