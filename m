Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C279F13CB0D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 18:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAORcV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 12:32:21 -0500
Received: from mail-vs1-f54.google.com ([209.85.217.54]:40092 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAORcV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 12:32:21 -0500
Received: by mail-vs1-f54.google.com with SMTP id g23so10938128vsr.7
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 09:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XR7tapcGmLFPVMMJtwzESzHlWG179DMVoRJeSwWuxoo=;
        b=bAvpYfs0u+Aqi+jr5DbAFxfT56HqM1jBj3EJvTHj504ySnxfoentn1SRsp8XzdVTvf
         +/dvy6V9tQdOyTFA4MawLgwhKLmUnJiokukF+hGhgm7Uc5VVU8S+V15y/n8/QViLpfkq
         nWGuoyuRZdc6f9uYjEPGIkL419Sz0k5zhf56begQczy/7+G8f9awMZos+I+fixbXecrG
         spP9E92AAWXjsvJP51Qi/TWDbXVJoQIU6WJ0fSAzxkBwHX0LGfI6YSmz0/RXYvx0iwZL
         rneEWiFfDTRvIyF7ekdXo1Gofv0RVCYv4wnUpO8Re67ces71gvdyGfUlxDxqIgAtakIY
         KMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=XR7tapcGmLFPVMMJtwzESzHlWG179DMVoRJeSwWuxoo=;
        b=gzwqyZV/RlX59WBoJ+yesl2dht0rCTxS2uzTAbYRaKC1/TppApa9JBAtsJIM63gKq9
         hKijvcbOmhut6AJsTMWTEqN655sGPFEoIKBQygfEZc91RHF4VZ8LL+6Vc0qXVXHfCfmV
         fguJaVSbXk2Y3vEdX++iUi4K9wtenfq5wErU5C/9Id4PjOTKuDybKdc8+FKM4P+VkT31
         bb2if+klCx5Hrh80jCfuOzELwO6dxadnaFmCGTVWVvWMNo9Spf30nYi4ln/S4wF+bGiy
         g8bH++AoEYjhz3iGfiyGRiSZeYEUH6AhLe4NyaguUw4uxdnAV1HatFwVbddPtZs3JAAu
         mxSg==
X-Gm-Message-State: APjAAAUXNaQqoDUxmop9vsU6WfM/+grcpn+ijnD3IIscZx82/XYZKFab
        vTGtH2hRnMpvp73Yib+BYvFb6goLltuzmC300ow=
X-Google-Smtp-Source: APXvYqwtSMNLFB/uYKe6HXminSng76gCWDkaXsm2gzJXKWqv1KsKgEfB2c31qJim35j/EE/mcstZ0P2n3POqmkkplZg=
X-Received: by 2002:a67:8010:: with SMTP id b16mr5215910vsd.90.1579109540241;
 Wed, 15 Jan 2020 09:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20200107194237.145694-1-josef@toxicpanda.com>
In-Reply-To: <20200107194237.145694-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 15 Jan 2020 17:32:09 +0000
Message-ID: <CAL3q7H78JUt0WJCXvzdgatU8fFkdWY0r1Yw0qKn0KYLg+KnqRQ@mail.gmail.com>
Subject: Re: [PATCH 0/5][v2] btrfs: fix hole corruption issue with !NO_HOLES
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 7, 2020 at 7:43 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> v1->v2:
> - fixed a bug in 'btrfs: use the file extent tree infrastructure' that wo=
uld
>   result in 0 length files because btrfs_truncate_inode_items() was clear=
ing the
>   file extent map when we fsync'ed multiple times.  Validated this with a
>   modified fsx and generic/521 that reproduced the problem, those modific=
ations
>   were sent up as well.
> - dropped the RFC
>
> ----------------- Original Message -----------------------
> We've historically had this problem where you could flush a targeted sect=
ion of
> an inode and end up with a hole between extents without a hole extent ite=
m.
> This of course makes fsck complain because this is not ok for a file syst=
em that
> doesn't have NO_HOLES set.  Because this is a well understood problem I a=
nd
> others have been ignoring fsck failures during certain xfstests (generic/=
475 for
> example) because they would regularly trigger this edge case.
>
> However this isn't a great behavior to have, we should really be taking a=
ll fsck
> failures seriously, and we could potentially ignore fsck legitimate fsck =
errors
> because we expect it to be this particular failure.
>
> In order to fix this we need to keep track of where we have valid extent =
items,
> and only update i_size to encompass that area.  This unfortunately means =
we need
> a new per-inode extent_io_tree to keep track of the valid ranges.  This i=
s
> relatively straightforward in practice, and helpers have been added to ma=
nage
> this so that in the case of a NO_HOLES file system we just simply skip th=
is work
> altogether.
>
> I've been hammering on this for a week now and I'm pretty sure its ok, bu=
t I'd
> really like Filipe to take a look and I still have some longer running te=
sts
> going on the series.  All of our boxes internally are btrfs and the box I=
 was
> testing on ended up with a weird RPM db corruption that was likely from a=
n
> earlier, broken version of the patch.  However I cannot be 100% sure that=
 was
> the case, so I'm giving it a few more days of testing before I'm satisfie=
d
> there's not some weird thing that RPM does that xfstests doesn't cover.
>
> This has gone through several iterations of xfstests already, including m=
any
> loops of generic/475 for validation to make sure it was no longer failing=
.  So
> far so good, but for something like this wider testing will definitely be
> necessary.  Thanks,

So a comment that applies to the whole patchset.

On power failures we can now end up with non-prealloc extents beyond
the disk_i_size after mounting the filesystem.

Not entirely sure if it will give any potential problems other then
non-reclaimed space for a long time (unless the file is truncated or
written to or beyond the extent's offset), have you tested this
scenario?

I suppose the test cases from fstests that use dm's log writes target
exercise this easily.

Thanks

>
> Josef
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
