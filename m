Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8C324B5E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 12:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbgHTK30 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 06:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbgHTK3X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 06:29:23 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524A3C061757
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 03:29:23 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id y17so416501uaq.6
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 03:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=bKyetrAN9axkRikBOTlOTLyjXz1XWVSBlnibUVcOqks=;
        b=YkxwMabzPc+D8T41N9yWhCR8w+7yUT2az8RlwvQRW4TwOSxHqK3fvN/RI7kYwOYYZt
         Gr9PUS/k+h9c8rtbtw1LcndcYVokODJXwyJpFvAxQQwvgzFKV+sohJMsN/xlMr+5ZUlk
         YDDzSwFeIswIkfnSuWGVzGaHP3hZ/44gXTK2ISzIHBNnWQBG23aHNvrG+J646WGLnXab
         bzCCmRuxSSDd8MzhozuxNOgn8uDxHbnWIHQ0TevfpwjAbJCA4p9iBISN4JH+HBmvWkt/
         8Ia+fPWQkZnTN/skJXXgtzDOSBI1Ga+rf3jSXzk/MmSk9F7PR6a0oKh2OHZ6RJHJvVPZ
         T67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=bKyetrAN9axkRikBOTlOTLyjXz1XWVSBlnibUVcOqks=;
        b=krM4Jnq+GUPpztC6ntH5NpBTApzRp4MlbKfkfy5GK2FfrztlpXZALt7y+zgz3pCnsI
         hUHjLPWt9l13Pr06tpShTGCTASVh5k0sfg+PpXUP5gU2MnZAax0afFTiAaxIXhuSEvhM
         E8+tv9lhBwLPDen+GJ8zic1G6qXrSx8F8WYHPno9DT4rfd/9fQ5nc+uLSV8v/vOET9Yz
         Xz42v5lUEUsanQFS+MzX/E/RFKBGf4maeDH6qQqENwJ6uPZH3Xged8ZVv36C4pEf7C75
         EvHr5fO9K6ybzUk6dL1psvHpx9+moWj+0VkfahqWWcseTyZ2+DhMT2vDDA93zmtKyL72
         rVkw==
X-Gm-Message-State: AOAM530WG6fchVvQ5Boq9nPxECg/q7PT96yEFm3Sun5gRRVDtia5sV+Y
        XqYAqVu3mtnAcfG8Jh6AUjZqiUL5GrPc1wph/wQ=
X-Google-Smtp-Source: ABdhPJy4HmNIzsb9CGL6Xvplsuzxhrv54Rz8CQuj4HK4nMVLpaw1MCxN9GE2cOBvKTfurOlkqVzLCkXu7GddMeFSurw=
X-Received: by 2002:ab0:650a:: with SMTP id w10mr1101453uam.123.1597919362430;
 Thu, 20 Aug 2020 03:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200810213116.795789-1-josef@toxicpanda.com> <20200819162236.GS2026@twin.jikos.cz>
In-Reply-To: <20200819162236.GS2026@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 20 Aug 2020 11:29:11 +0100
Message-ID: <CAL3q7H4Rge7qSVgPokXHPVw6q246wKVn8aWixp8NzXitLPekhw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: check the right variable in btrfs_del_dir_entries_in_log
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 5:25 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Aug 10, 2020 at 05:31:16PM -0400, Josef Bacik wrote:
> > With my new locking code dbench is so much faster that I tripped over a
> > transaction abort from ENOSPC.  This turned out to be because
> > btrfs_del_dir_entries_in_log was checking for ret =3D=3D -ENOSPC, but t=
his
> > function sets err on error, and returns err.  So instead of properly
> > marking the inode as needing a full commit, we were returning -ENOSPC
> > and aborting in __btrfs_unlink_inode.  Fix this by checking the proper
> > variable so that we return the correct thing in the case of ENOSPC.
> >
> > Fixes: 4a500fd178c8 ("Btrfs: Metadata ENOSPC handling for tree log")
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> Added to misc-next, with updated changelog and comment explaining the
> ENOENT.

Looking at the part added to the changelog:

"The ENOENT needs to be checked, because btrfs_lookup_dir_item() can
return -ENOENT if the dir item isn't in the tree log (which would happen
if we hadn't fsync'ed this guy).  We actually handle that case in
__btrfs_unlink_inode, so it's an expected error to get back."

btrfs_lookup_dir_item() returns NULL when the dir item does not exist
in the log.
What can return -ENOENT is btrfs_lookup_dir_index_item(), which we
call right after calling btrfs_lookup_dir_item().
The fact that one returns NULL and the other returns -ENOENT is what
made me question why the special handling for -ENOENT.

Other than the wrong function name, it looks good to me.

Thanks.






--
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
