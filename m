Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA734E45E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 19:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiCVSZy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 14:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240326AbiCVSZS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 14:25:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327218E183
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 11:23:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g20so22742576edw.6
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85Ws1qb644UrDxX3GqtVYKt4YI7t6y+/3TtLCRrTTKc=;
        b=Ku1bCHHBy4U/B0ntBvZYaNo6sJY8WQONWU//cYuzD1bsiWewQg70QTeDzl2hXY4XFN
         NwP5Gw/RMT8B+yi8bWlXB4Skrv6zKuyqhznjY3mFaV89GZ3JlOBl5l20RiE80NBafVP2
         AU1HrlWh98Cpn2TbAJ9BGX4m7EnwW3Eei6uQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85Ws1qb644UrDxX3GqtVYKt4YI7t6y+/3TtLCRrTTKc=;
        b=FZisA3/+Gmk96uyzMFT++8OKO0ftx/1kZQ+oJjcjZOH+At+/zLjtVLUq3jQs/T4ZRq
         JmQdNuWmrkcFjOQ9nt8O8Xk0qxAne77MzSrraxPbr2Iw12zeueja/FA5RRHu3GA/0UZP
         tvKcUCoAm30XqYaOmi+68DeHvAay1ScGjY4NjYBjyDdb5KLIaIDVwQAb00MlsJNSAg4e
         7qElqBT+Fo328qYGvhjfQQdWskcFX08gjPmdhWiekEaTshzSsjXLm5Rvri5a6+aCA+Je
         kfv5XDhSI4uKleeywnTYY7/QBCOPApJ9vdVaihY1FAh6tbln/York5CMBANY3HsSupGR
         p9wA==
X-Gm-Message-State: AOAM532iQT4fiZOHO63MFydMiXWSMQXeOYwHcY2szq9I57+E2QPX//gC
        v2KOKWTAePT19a7tWw0au+U9VN17RLIodjSixH80rwu9PtUpEiuSFeE=
X-Google-Smtp-Source: ABdhPJwMtH2ef4MJrXE0r5q0QsAUPWiDH4EPuum8RS4ja9iTxc2/V115+eJwjZT4xBGe3Onik6xG+a123W5HezabEwg=
X-Received: by 2002:aa7:c755:0:b0:419:2f66:e22c with SMTP id
 c21-20020aa7c755000000b004192f66e22cmr14457833eds.381.1647973412741; Tue, 22
 Mar 2022 11:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647894991.git.dsterba@suse.com>
In-Reply-To: <cover.1647894991.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 11:23:21 -0700
Message-ID: <CAADWXX-uX74SETx8QNnGDyBGMJHY-6wr8jC9Sjpv4ARqUca0Xw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.18
To:     David Sterba <dsterba@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 21, 2022 at 2:37 PM David Sterba <dsterba@suse.com> wrote:
>
> - allow reflinks/deduplication from two different mounts of the same
>   filesystem

So I've pulled this, and it looks ok, but I'm not getting the warm and fuzzies.

In particular, I'm not seeing any commentary about different
filesystems for this.

There are several filesystems that use that ->remap_file_range()
operation, so these relaxed rules don't just affect btrfs.

Yes, yes, checking for i_sb matching does seem sensible, but I'd
*really* have liked some sign that people checked with other
filesystem maintainers and this is ok for all of them, and they didn't
make assumptions about "always same mount" rather than "always same
filesystem".

This affects at least cifs, nfs, overlayfs and ocfs2.

Adding fsdevel, and pointing to that

-       if (src_file->f_path.mnt != dst_file->f_path.mnt)
+       if (file_inode(src_file)->i_sb != file_inode(dst_file)->i_sb)

change in commit 9f5710bbfd30 ("fs: allow cross-vfsmount reflink/dedupe")

And yes, there was already a comment about "Practically, they only
need to be on the same file system" from before that matches the new
behavior, but hey, comments have been known to be wrong in the past
too.

And yes, I'm also aware that do_clone_file_range() already had that
exact same i_sb check and it's not new, but since ioctl_file_clone()
cheched for the mount path, I don't think you could actually reach it
without being on the same mount.

And while discussing these sanity checks: wouldn't it make sense to
check that *both* the source file and the destination file support
that remap_file_range() op, and it's the same op?

Yes, yes, it probably always is in practice, but I could imagine some
type confusion thing. So wouldn't it be nice to also have something
like

    if (dst_file->f_op != src_file->f_op)
          goto out_drop_write;

in there? I'm thinking "how about dedupe from a directory to a regular
file" kind of craziness...

                 Linus
