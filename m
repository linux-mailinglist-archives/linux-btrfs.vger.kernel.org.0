Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A911D363172
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Apr 2021 19:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbhDQR2P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Apr 2021 13:28:15 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:37448 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhDQR2O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Apr 2021 13:28:14 -0400
Received: by mail-qt1-f181.google.com with SMTP id o2so9780557qtr.4
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Apr 2021 10:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6UhICrEqPgvyce0QgtrIkYPOQPRuUITd4w+HSDeIzmQ=;
        b=fcU8O/LnOt0aFKxIQ/W5eAaDDj2Fqft0S5UpyVku2T443Q2PGvaMRC9+4QZZUaObJo
         cqXn5yccc4eSEC+n1YK0DxiYCypMC+VgtYO5c6HBWnlQPSlsHTv90HTjBt6h3HGxvVtH
         3aAa7VETT/GUviQGdln7V6ZgV9iAtEFhC8S9/fU8flgf8A0PcK7dwt0MUoew1Q2es6yz
         UeEKRronD+9QQmmwdnbEWtkGqoyzmOpWRubHz75C3MHJVKWI8rIffLTlS1Kh5GDH77a+
         VX6EcV0f//Ovec9BDBFNaxIQitf2Tdjj5wqxeZPMSnFlXyoYvkYlgBBDdEqhJBWROqqf
         3xPg==
X-Gm-Message-State: AOAM532B9llluYfO/GcZDev71U6y+kt96b3gvVKQ4vhbVCOkYKVGwCn3
        MDhUFL689BAszQISqFZ94ZXwiGn9ptvIpgOUYN7LvsEvX5s=
X-Google-Smtp-Source: ABdhPJxHVq3wMRTBU7RIjksZhCnrDoOIw23iUMTtPdsBIlNpe85VCeVj4TgJKdRkOiB4brWItHCakA/cLipuWXDlBG0=
X-Received: by 2002:ac8:53ce:: with SMTP id c14mr426167qtq.325.1618680467213;
 Sat, 17 Apr 2021 10:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3NTRCPDJSCnOiKSUK+j6wi3yLSH1JG6fcjaSuQwyjA7VESww@mail.gmail.com>
In-Reply-To: <CAK3NTRCPDJSCnOiKSUK+j6wi3yLSH1JG6fcjaSuQwyjA7VESww@mail.gmail.com>
From:   Ross Boylan <rossboylan@stanfordalumni.org>
Date:   Sat, 17 Apr 2021 10:27:36 -0700
Message-ID: <CAK3NTRDhRAC4b9NXTwPARAQirt9z4ZNrwxLNQ+7mL1dehMB24Q@mail.gmail.com>
Subject: Fwd: Interaction of nodatacow and snapshots
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Suppose some files or directories on a subvolume are set nodatacow.
And then one creates a snapshot of that subvolume.
And then does a send based on that snapshot.

What happens?  I've looked through the documentation and can not tell.
It doesn't sound
as if nodatacow is consistent with the whole snapshot mechanism, but I
don't see any
explicit statements that any of the above won't work.

For example, I could imagine any of
1. the snapshot or send command refuses to run.
2. the snapshot completely omits anything that is nodatacow.  That
would probably be tricky since the
   directory with datacow above the object that is not datacow would
need to be altered to
   omit the reference.
3. the snapshot does an explicit copy (i.e., duplicates all the bits)
of all things nodatacow.
4. the snapshot always shows the current (on the original subvolume)
version of the nodatacow files.
5. results are unpredictable and unreliable.
6. the snapshot removes the nodatacow attribute from everything on the
original subvolume.
7. everything works fine (this one requires lots of imagination).

I would appreciate cc's on the reply.

Thanks.
Ross Boylan
