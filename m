Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E4F13B30A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 20:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgANThu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 14:37:50 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43141 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbgANThu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 14:37:50 -0500
Received: by mail-io1-f67.google.com with SMTP id n21so15139412ioo.10
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2020 11:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqXxc47s2eqIDWJXeQSdbHASZfLKW3be0qmfCzYqSiA=;
        b=QvmQ4pi7zohC8dpypbLGbuWfIzHW1NNI4Gix0qhMNBlGFZa1EUWwGDQPJuOZITveYd
         3CL1Y//4O6kZto6iq5F4zVR73MEPbCRUdtlsgzb8nKhHE599imPR190pHbqXTZrnL7aZ
         adZZrkrhPjMNv8GvdNXpRmi/zcgGysycld0ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqXxc47s2eqIDWJXeQSdbHASZfLKW3be0qmfCzYqSiA=;
        b=asfyBzgk5wAeo1if10GP1fCwUcdLwiLgKNDaXWdWfqm6ekFkbzVkq9iVVH+UaUQBST
         xmcf7XdMe7AbJ+jyRVLWD+wHmN0PLL14cTT88J0ifd4YwrVRbQAB8lGknTSeg1E0WAZq
         sspMw6mIcGOUffGI1BdCXA2eiBReX62vUJAOezZJVIm/4W/XeK7xAVjU9iFd/RMjvOGt
         EUKyemAIo6N6pfl18RBglGl5yQxQLYAMDYG2SAzGzzYl/0usQQimJg6UQbCJBmntzJzb
         EbeoxXQXpmGGqriL4+gxGcaPqd0G9YKdJkHLaBhkbE/N0Flyq1GTKec9POFgPnagn7P7
         H1RQ==
X-Gm-Message-State: APjAAAXxMx1WEDaS8d8nWqk9hqBZEEkUAYDdlZ3rmye0sfxotLCOWG4X
        9B2slogpHk9aHPM93aRkoDjf/qSeTeJLxSNehfwylQ==
X-Google-Smtp-Source: APXvYqzPmrKRE/xDnX4YcGTMm6GQ3JwdfynLKAfx+8hSiBBXRyzWP4hxu3Iaox2rKW61vaUcQmkD+tbsIoC7jruNroQ=
X-Received: by 2002:a6b:4909:: with SMTP id u9mr18019643iob.212.1579030669461;
 Tue, 14 Jan 2020 11:37:49 -0800 (PST)
MIME-Version: 1.0
References: <3326.1579019665@warthog.procyon.org.uk> <20200114170250.GA8904@ZenIV.linux.org.uk>
 <9351.1579025170@warthog.procyon.org.uk>
In-Reply-To: <9351.1579025170@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 14 Jan 2020 20:37:38 +0100
Message-ID: <CAJfpegvbGrYb4wGDkuQXaeUGdeAMS0g7n6MezDV0BaLV_Bu1RQ@mail.gmail.com>
Subject: Re: Making linkat() able to overwrite the target
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        dsterba@suse.com, linux-ext4@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 14, 2020 at 7:06 PM David Howells <dhowells@redhat.com> wrote:
>
> Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > > Would it be possible to make linkat() take a flag, say AT_LINK_REPLACE,
> > > that causes the target to be replaced and not give EEXIST?  Or make it so
> > > that rename() can take a tmpfile as the source and replace the target with
> > > that.  I presume that, either way, this would require journal changes on
> > > ext4, xfs and btrfs.
> >
> > Umm...  I don't like the idea of linkat() doing that - you suddenly get new
> > fun cases to think about (what should happen when the target is a mountpoint,
> > for starters?
>
> Don't allow it onto directories, S_AUTOMOUNT-marked inodes or anything that's
> got something mounted on it.
>
> > ) _and_ you would have to add a magical flag to vfs_link() so
> > that it would know which tests to do.
>
> Yes, I suggested AT_LINK_REPLACE as said magical flag.
>
> > As for rename...
>
> Yeah - with further thought, rename() doesn't really work as an interface,
> particularly if a link has already been made.
>
> Do you have an alternative suggestion?  There are two things I want to avoid:
>
>  (1) Doing unlink-link or unlink-create as that leaves a window where the
>      cache file is absent.
>
>  (2) Creating replacement files in a temporary directory and renaming from
>      there over the top of the target file as the temp dir would then be a
>      bottleneck that spends a lot of time locked for creations and renames.

Create multiple sub-temp-dirs and use them alternatively.

I think there was a report for overlayfs with the same bottleneck
(copy up uses a temp dir, but now only for non-regular).  Hasn't
gotten around to implementing this idea yet.

Thanks,
Miklos
