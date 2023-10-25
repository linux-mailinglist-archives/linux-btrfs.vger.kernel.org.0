Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6EC7D722B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 19:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjJYRRc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 13:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjJYRRc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 13:17:32 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A05111;
        Wed, 25 Oct 2023 10:17:28 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d190a8f87so20386d6.0;
        Wed, 25 Oct 2023 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698254248; x=1698859048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoiQmnU9g8/25WJ9bZzn6nKCHmQO3r6Imcr+PhsvotM=;
        b=gnG2IZaoDZBUisxDn3e/O2tSag4gmg3KrG4DxGjyXEO2tTwdj07PqXRmE2gyg7rVRQ
         W3ig5kBTg80YuxzyT26W7bxGi+B+Hj3cMnaebRzITJbLy9DnmM6XsIWCW1mScxk8ZsmL
         afYdGxoXNrl3BqnUFdB4FlRZbIbm71mYSy4dqQb0bVGQheTNTxp6qSOShOpJnqtbFV8N
         /14WzWT3Gb6yS/JkQJN/udnSWTZLDvRNoe464+ZAH1KLAKkfTVCq/GO10fO2NfnpwDu1
         9drwMsjB563IlgPo4WZCy6vOrma4FScpTi9PS9te8oaIS7j+CjU1sFceuCGsSxt7DpPw
         CgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698254248; x=1698859048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoiQmnU9g8/25WJ9bZzn6nKCHmQO3r6Imcr+PhsvotM=;
        b=sQVUWxHxmpQW0I7VyCO9XJK0iVKcgoGKao9D6kyIKE7U3PbteKYCTh2N5JHqfXUEPq
         3hl6YMOHygBsYzNmUtzhmH8HVSlSDar1SWS6O27kOc6OPCjOlBMzX6NruxdgiNVTh61x
         F+1g1iQkgsacn6RJNSfaLk407dwZn5z5l7jpFYGm3tUuKNSU9jiGr/az9mBQ+cOFyFIl
         agykN9NCGBUHpEAvSRG74K+6f52gIKzO0ZfcPr8+oXqGbFiDqHajJrKi60QxJnC3p/X5
         eaR3FMpnlgBQzLozUfSva3vfAI3gnQxTVuKiohmTa9ajfkc9vRxd1WMKCtN24MiyxW78
         5AVg==
X-Gm-Message-State: AOJu0YxYyksF6lFlSvGiyZ7ZjzRCK3LTVLJcdjo/rhcFriuq4pGeXqFU
        oTW+FeoFQQsdIRxFwCPTnYUIVSJFto1uwl0EvAo=
X-Google-Smtp-Source: AGHT+IEZ917I8f34QH6+zppbWo5FaQ7CCIM5DqUOMb/XX7hv7QSiC7EWypzUbzRw4FHiVKJjMy2KFuT4sFXWedvw9UI=
X-Received: by 2002:ad4:574b:0:b0:65d:f1d:d383 with SMTP id
 q11-20020ad4574b000000b0065d0f1dd383mr19933998qvx.3.1698254247766; Wed, 25
 Oct 2023 10:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231025135048.36153-1-amir73il@gmail.com>
In-Reply-To: <20231025135048.36153-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Oct 2023 20:17:16 +0300
Message-ID: <CAOQ4uxg2uFz8bR37bwR_OwnDkq5C7NG+hoqu=7gwSC5Zjd4Ccg@mail.gmail.com>
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 25, 2023 at 4:50=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Jan,
>
> This patch set implements your suggestion [1] for handling fanotify
> events for filesystems with non-uniform f_fsid.
>
> With these changes, events report the fsid as it would be reported
> by statfs(2) on the same objet, i.e. the sub-volume's fsid for an inode
> in sub-volume.
>
> This creates a small challenge to watching program, which needs to map
> from fsid in event to a stored mount_fd to use with open_by_handle_at(2).
> Luckily, for btrfs, fsid[0] is uniform and fsid[1] is per sub-volume.
>
> I have adapted fsnotifywatch tool [2] to be able to watch btrfs sb.
> The adapted tool detects the special case of btrfs (a bit hacky) and
> indexes the mount_fd to be used for open_by_handle_at(2) by fsid[0].
>
> Note that this hackacry is not needed when the tool is watching a
> single filesystem (no need for mount_fd lookup table), because btrfs
> correctly decodes file handles from any sub-volume with mount_fd from
> any other sub-volume.

Jan,

Now that I've implemented the userspace part of btrfs sb watch,
I realize that if userspace has to be aware of the fsid oddity of btrfs
anyway, maybe reporting the accurate fsid of the object in event is
not that important at all.

Facts:
1. file_handle is unique across all sub-volumes and can be resolved
    from any fd on any sub-volume
2. fsid[0] can be compared to match an event to a btrfs sb, where any
    fd can be used to resolve file_handle
3. userspace needs to be aware of this fsid[0] fact if it watches more
    than a single sb and userspace needs not care about the value of
    fsid in event at all when watching a single sb
4. even though fanotify never allowed setting sb mark on a path inside
    btrfs sub-volume, it always reported events on inodes in sub-volumes
    to btrfs sb watch - those events always carried the "wrong" fsid (i.e.
    the btrfs root volume fsid)
5. we already agreed that setting up inode marks on inodes inside
    sub-volume should be a no brainer

If we allow reporting either sub-vol fsid or root-vol fsid (exactly as
we do for inodes in sub-vol in current upstream), because we assume
that userspace knows about the fsid[0] trick, then we can we just
remove the -EXDEV error and be done with it.

Thoughts?

Thanks,
Amir.
