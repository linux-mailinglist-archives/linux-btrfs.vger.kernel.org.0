Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502D42E7B70
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Dec 2020 18:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgL3REg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Dec 2020 12:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL3REg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Dec 2020 12:04:36 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DDCC061799
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Dec 2020 09:03:56 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id q25so15849695otn.10
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Dec 2020 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UMCvyRfpYH3+wCV+skWgY3UpWvakFg1nHVeDSJQZYWQ=;
        b=hyHmcJlfE/Y6673oCBdleK7PaV88+SoPa0JFNXfQFCS79nEzfk5ohI76eOPQnJkZN/
         ub7fL51cbbVpmRQ2kGwwXw91NEpJliEzTRgh6815iEoOV1n7vXnD9bVt1wc3htWjp5nM
         6yymSMufEVT54CqKm0xwXIS9kUtnBx4YdREFJW6Gsy453rLsScGJ7HhpFno65tuSUokb
         f37CiKRvKWLD9mqDW5RjnoGgy/eI96TJMRUdCDiCZr9UJz/HH8B0g1yzNHX53zl1jxsa
         IVrpCfEMPCJd5IikAf/lvyOExvq8Xnbbv3/dBUQ/Wm1UUzhH0y9CbsnWKkon7gRCM+AZ
         xpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UMCvyRfpYH3+wCV+skWgY3UpWvakFg1nHVeDSJQZYWQ=;
        b=PQLZhUZF1hqvHSXijoyADbMqalbDfeortwnFIwAFyp5X7DLzWbBMhErDCwVynGUV+B
         UTEUz/wZsx75ayPFHfffkRxbu6D/bhQ0MP/woJ0820UiR8+/pHfB0nb1oV1ct91m60p5
         kK1HGBKTYHvlie6/QHY1zPVPZSXyWQUiORPFa4l2+GeTsraMUryc6e9gUfeQ09GXzOAn
         T+PXh+GIsyCDP5fhOrWHTrx15J35EL4nDW/Qs2my3D+j5QyMjEXnMwnKN+TGYW3MYGNe
         3PWr4fWyr88UQ9EieVpyK9Ohgd172x0LXJQ/pHyMYvu4qqDyEEWq5GUZOVdruYbRY9Oc
         xhew==
X-Gm-Message-State: AOAM530GxKhXL32wpcD9KGFb2vVMdkOwC57L8QawxqYtQPDbR2z7GWRr
        5a41QDvE/p4Qw/RN6qlx7QgOxoTn+2X9yjTSoEC3OxHqFwuLsMgd3SU=
X-Google-Smtp-Source: ABdhPJzclskRMFMo3rGELB+QCXX3j3pN2n3m7un1dz5zNXzQSuF5hMhEOFFLo1MxJz4SlOp8LJtowoBIi9RfdcmNdd4=
X-Received: by 2002:a05:6830:1210:: with SMTP id r16mr39885077otp.343.1609347835355;
 Wed, 30 Dec 2020 09:03:55 -0800 (PST)
MIME-Version: 1.0
References: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
In-Reply-To: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
From:   john terragon <jterragon@gmail.com>
Date:   Wed, 30 Dec 2020 18:03:44 +0100
Message-ID: <CANg_oxxTj_vAT+qoWoBDtM_uN79rei1rwnMxGS9QveUJPsLHWg@mail.gmail.com>
Subject: Re: hierarchical, tree-like structure of snapshots
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry, that ascii tree came out awful and it looks like Z is the child
of Y instead of Y1. I hope this one below looks better.

Y1-Y
 \
  Z-X

On Wed, Dec 30, 2020 at 5:56 PM john terragon <jterragon@gmail.com> wrote:
>
> Hi.
> I would like to maintain a tree-like hierarchical structure of
> snapshots. Let me try to explain what I mean by that.
>
> Let's say I have a btrfs fs with just one subvolume X, and let's say
> that a make a readonly snapshot Y of X. As far as I understand there
> is a parent-child relation between Y (the parent) and X the child.
>
> Now let's say that after some time and modifications of X I do another
> snapshot Z of X. Now the "temporal" stucture would be Y-Z-X. So X is
> now the "child" of Z and Z is now the "child" of Y. The structure is a
> path which is a special case of a tree.
>
> Now let's suppose that I want to start modify Y but I still want to be
> able to have a parent of Z which I might use as a point of reference
> for Z in a
> send to somewhere. That is I want to be able to still do a send -p Y Z
> to another btrfs filesystem where there is previously sent copy of Y
> (which, remember, as of this point has been readonly and I'm just now
> wanting to start to modify it).
> The only thing I think I can do would be to make a readonly snapshot
> Y1 of Y and make Y writeable (so that I can start modify it). At that
> point the structure would be
>
> Y1-Y
>     \
>       Z-X
>
> (yes my ascii art is atrocious...) which is a "proper" tree where Y1
> is the root with two children (Y and Z), Z has one child (X) and Y and
> X are leaves.
> Now, my question is, would Y1 still be usable in send -p Y1 Z, just
> like Y was before becoming writeable and being modified? I would say
> that Y1 would be just as good as the readonly original Y was as a
> parent for Z in a send. But maybe there is some implementation detail
> that escapes me and that prevents Y1 to be used as a perfect
> replacement for the original Y.
> I hope I was clear enough.
> Thanks
> John
