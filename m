Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B6625C841
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 19:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgICRzN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 13:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICRzM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 13:55:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF14C061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 10:55:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a17so4158272wrn.6
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSptMSKPYzJomhQEUUQqoiEIgQKeYtuwxqPkpzeTpUk=;
        b=DbsshT8H3xzm+zteKTSIXFB5h9ae2B6L7HiXqIx9YBdBLqm9Zkxq/qteZTeSUk7WOe
         7zXNak6PpJGug4i36zI4MRyUCRkd+7ZdsqTRiqtLEy97fn9Ubg5lT0TJahMonyRK8YW9
         8DD5N+MGkplezaZslieNGjwzWcJpxHDlsUHkST8PPYjhB7h9ZGpZPL254A6Jm5+JgT9B
         YWxs2yr8ZEQXPSnxPtAErYpUtuWsNfGUwcjveuR2kc8iZ9pU6GAPdT4tE1X+RQbLBE6m
         kWNETWtfioYTaTRsvvqnVEuEc3XeehmI5AvQm+gChuU0GS2dB9auvPYCeOasx/4Q0jI1
         0KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSptMSKPYzJomhQEUUQqoiEIgQKeYtuwxqPkpzeTpUk=;
        b=FouVLP0R9qIcEKiBhKgNU0lmCuWFvLb5abPXHCYofANexDeVabFVIpYbP1yiCTOx4W
         hUXFTzDPe0Cx5ICZpILeSwNDThceFXpEq/UEoZk5ZnmbsAXndGqPq0gsfQrQtxuz+v4+
         FfGvu0gA8biOiE7moEFzlOAuZtg+tQrGxGB+UQktCY42nrUJdOeq9e6/RUkidjQbHto/
         LbO3jP4dcASLJGT8DgpV/32w9CvJgUhcSWEJ9/w8HGsTiYiSoRRfrh7G0dvgAV4zWzVN
         8vF7m+vPhx3MFl+1XihBxvYcoQhHOCqF5NEvymCEXe1+xPvnZnNWGP5lptDcYQ2aV72U
         og+Q==
X-Gm-Message-State: AOAM530lay5BOWiKlq0txnhFPm3zH+tMut3OsX6jG/9+5Ud9r3hY77JD
        6aTR6unkN04iZxomvqu2egxd8UL6ndhudMdktPBGU2IfccQ8Gw==
X-Google-Smtp-Source: ABdhPJxbHR/sfzAjbeMpGqdX/XpewHZ5tpI1ki+nwj5/H0r7WlXR9I/bbdBsrjndItLN8NGURKlg9/Q5V8VdBPDlDj4=
X-Received: by 2002:adf:912b:: with SMTP id j40mr3600159wrj.42.1599155710796;
 Thu, 03 Sep 2020 10:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <37TAH07_l2Srimzx9YvwQjA7Y1KW9-Xqca9YysAnCJc2c_oOhnmUmvWF7U-JTkntMZQL7qBu82LV-4xA8Sjr3rgtSrM3ses2QPAbaib85Yk=@protonmail.com>
In-Reply-To: <37TAH07_l2Srimzx9YvwQjA7Y1KW9-Xqca9YysAnCJc2c_oOhnmUmvWF7U-JTkntMZQL7qBu82LV-4xA8Sjr3rgtSrM3ses2QPAbaib85Yk=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 3 Sep 2020 11:54:19 -0600
Message-ID: <CAJCQCtSPQCgXa0UrcC6w86UX6DXS2APu0a0RCY+EsdCRVE3=pA@mail.gmail.com>
Subject: Re: [btrfs-progs] btrfs check --clear-space-cache v2 segfaults
To:     Althorion <althorion@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 3, 2020 at 8:58 AM Althorion <althorion@protonmail.com> wrote:
>
> Hi!
>
> My BTRFS partition started throwing errors and remounting read-only, with errors like:
>
> Sep 02 14:49:44 ripper systemd[1]: Started Scrub btrfs filesystem, verify block checksums.
> Sep 02 14:50:56 ripper kernel: BTRFS error (device sdc4): incorrect extent count for 82707480576; counted 1, expected 2
> Sep 02 14:50:56 ripper kernel: BTRFS error (device sdc4): incorrect extent count for 126730895360; counted 5, expected 6
> Sep 02 14:50:56 ripper kernel: BTRFS error (device sdc4): incorrect extent count for 131025862656; counted 0, expected 1
> Sep 02 14:51:55 ripper kernel: BTRFS error (device sdc4): incorrect extent count for 82707480576; counted 2, expected 3
> Sep 02 14:51:55 ripper kernel: BTRFS: error (device sdc4) in convert_free_space_to_bitmaps:316: errno=-5 IO failure
> Sep 02 14:51:55 ripper kernel: BTRFS info (device sdc4): forced readonly
>
> I've tried running btrfs check --clear-space-cache to try and clear the second to last error, but it segfaulted after a few seconds.

Pretty much everything depends on the extent tree being healthy. Free
space bitmaps is a reference to v1, and are composed of data extents.
And v2 is its own btree, and use metadata extents.

While it probably shouldn't segfault in this case, it probably should
refuse making modifications to the extent tree that don't involve
repairing it. And in that sense it's better that it segfaulted than
attempting to modify a damaged extent tree.

> OK, but I run Gentoo, so maybe it's something on my end, so I tried again from an Arch LiveCD, using btrfs-progs 5.7-1, and it segfaulted too.
>
> What else should I try before wiping up the system and recreating from backup?

Well, once you're prepared to wipe it, you could give --repair a try
and see if it fixes anything. If not then the big hammer is
--init-extent-tree. If that completes (it'll take a while) without
error, then you'll want to run --repair afterward. But depending on
the size of the file system, wipe and restore might be faster.


-- 
Chris Murphy
