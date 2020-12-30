Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FE12E7B34
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Dec 2020 17:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgL3Q5i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Dec 2020 11:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgL3Q5h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Dec 2020 11:57:37 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BA0C061799
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Dec 2020 08:56:57 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id l200so19203100oig.9
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Dec 2020 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HWUPr+EoHHjOig97m2+1Er68K0jHHXK0Z58+YK/2hcU=;
        b=tzC5Hs3wnymqN0EJq8NCZXF+vBOqgGRxCZHzj60UY5xrdY/FunQW0heVC1YtY/ABmr
         yjoBrrGitaeOIL5jpiAkN+YC+GBA+Z7CCItarF+fWFKgDwN/FT8aiTeDIdhKGxMOReHJ
         uprqzY0aILpxgIgsb0dDbvMBEUCMjr6YnTL6owAkznbmghZNraxm1nyBkiSGAwyeo9KN
         DQ8JK6MEyOmPd9yHdIVXpuK4DJQ9XBcfKpE8MZs+2fXPytLaM2ikvxtEAByf5woqtewq
         9jh4uY7B31eY8aYf7fnqEwjSgr3DUmzeIxCLq95y6JXcLzxvFWVcRMkXSZpR5CsEqtH8
         v4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HWUPr+EoHHjOig97m2+1Er68K0jHHXK0Z58+YK/2hcU=;
        b=Mc7DvseWGsaLcFQBfWI2J3ale6kNhT0zXNQGtqvSPNdMCDbjhHR5G7tgP9lN29YnlH
         oYV++MahvYQldxaaJZ7wxWA7e9SzVYj9fNH5VRqEZ7WWR28AoQxKEPOPLsfmuAwbUQuP
         Xn5Kglk1knqM+SPGM8xR2d7Cg1tugKcM7eNkdyo5ZPHAbP3IbP279iElKzE7YQxsWg0B
         Ld27lhJkAnJ1oFy5Wxqe0uR3bP0ys5yjNuhHoFKwT0wnk9YdCNBxC51JsqpcKW3tNf9f
         2KEzqozTkVw5InFG8Pji+nK8UUM8yRc1TsH9nqCuhFVrziFOlIw6pUK1hy8ye+7Q15uJ
         CcEg==
X-Gm-Message-State: AOAM531daG3zhaj/EBT8xQXkczkzsy3manSMX1yvYfsrTbtCmx4rY1uF
        9A+A2njWEWGQgqmFC2lyRn74JJ8kNCyCxDGUVPvC2wH9iYZzYh7+
X-Google-Smtp-Source: ABdhPJzP1BFr2xudIhvjjLVg5xtu3OyZ36J0FlzrZ/oeJqV00k8zS9Up37mdXqZ9762MjyY6qRBalswvUm29OeBD7Yk=
X-Received: by 2002:aca:af8b:: with SMTP id y133mr5755353oie.87.1609347417125;
 Wed, 30 Dec 2020 08:56:57 -0800 (PST)
MIME-Version: 1.0
From:   john terragon <jterragon@gmail.com>
Date:   Wed, 30 Dec 2020 17:56:46 +0100
Message-ID: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
Subject: hierarchical, tree-like structure of snapshots
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi.
I would like to maintain a tree-like hierarchical structure of
snapshots. Let me try to explain what I mean by that.

Let's say I have a btrfs fs with just one subvolume X, and let's say
that a make a readonly snapshot Y of X. As far as I understand there
is a parent-child relation between Y (the parent) and X the child.

Now let's say that after some time and modifications of X I do another
snapshot Z of X. Now the "temporal" stucture would be Y-Z-X. So X is
now the "child" of Z and Z is now the "child" of Y. The structure is a
path which is a special case of a tree.

Now let's suppose that I want to start modify Y but I still want to be
able to have a parent of Z which I might use as a point of reference
for Z in a
send to somewhere. That is I want to be able to still do a send -p Y Z
to another btrfs filesystem where there is previously sent copy of Y
(which, remember, as of this point has been readonly and I'm just now
wanting to start to modify it).
The only thing I think I can do would be to make a readonly snapshot
Y1 of Y and make Y writeable (so that I can start modify it). At that
point the structure would be

Y1-Y
    \
      Z-X

(yes my ascii art is atrocious...) which is a "proper" tree where Y1
is the root with two children (Y and Z), Z has one child (X) and Y and
X are leaves.
Now, my question is, would Y1 still be usable in send -p Y1 Z, just
like Y was before becoming writeable and being modified? I would say
that Y1 would be just as good as the readonly original Y was as a
parent for Z in a send. But maybe there is some implementation detail
that escapes me and that prevents Y1 to be used as a perfect
replacement for the original Y.
I hope I was clear enough.
Thanks
John
