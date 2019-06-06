Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB737793
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 17:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfFFPPP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 11:15:15 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41267 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbfFFPPP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jun 2019 11:15:15 -0400
Received: by mail-vs1-f67.google.com with SMTP id g24so1422800vso.8;
        Thu, 06 Jun 2019 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kQRTTvJECutu2MpATeVBjptWlhCDL4BG2w6Brzcdt/Q=;
        b=jN+/DOZH7TZPyl2XEjjxjBxj6JpdHaUVDgnK27rLaEY3h0qgJ7jipDAhbftXHlhJ04
         nJ1NR5rsFhPm7UyATt+BpoUDleZxJEULs/crJL5ZRwrrHzVmIeuz+fjZQE55ldJ3KZ1P
         l7F/YPc4VQ8FZYzAv1Hnm7qc5wGb5TtZlHxWjqaE4HolOQYU2NeLhywiQwYd2jeqbayt
         OsnBvewg3bIrSPxnq9R80WR2s0VHeq8pdmtfiAwTJabqmL0/Efgo+DPAaU0wc1/kLhle
         QCQAN6JN2FOZHXmjojPE3KSgx8D69J7qQv5IZ+zL816cMYtmpfpNTYbuaofzQQFvsBn3
         viYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kQRTTvJECutu2MpATeVBjptWlhCDL4BG2w6Brzcdt/Q=;
        b=Gv/MPAvgBAos6wV4qOiyzU4FHTGV9sjvEkQjaQ6hXGoowto8t3rkZC9537ioqGLGWz
         w4HSXFP4gznmKU45PJxNOVKK3MJBIBu+syfI+LCUelh9P0lS+wEgrBxZL2+atUgdkRsM
         gE+OoILXGLwxMdXw4oksLadHywN2vYHnjRtqTNw+0wH2iaxpSqKscT/lv/xYtbdjOL7N
         p0gjKEKJcrWdD+cPNM963Z6Rnr0EiFa9B8nDvepyFu/nP/PzXezABt77QSHgh6Ocz164
         GdD7sf24lXRGZP15UblbtryODrp2I0hS6JdXCGwXSLgwqtFF5ROe0qpdpl7Km+mzu4BM
         9nOg==
X-Gm-Message-State: APjAAAU4LYW/oTvoUFwmhbOrX9U6RtLIjyvYlHQ+vukQg76bqn6OJ2Xl
        55zk9j963Ui22b23u8+XZQweduFlKCYFZZFsl6UGljZx
X-Google-Smtp-Source: APXvYqziDYowzJK1iN9yuUzvoAt9Ih1JijajesgqtQa8BGKxKcOFkaxpHCU5yzLcTL8muvv0UOk/XP436QqcTfU5f5Y=
X-Received: by 2002:a67:f684:: with SMTP id n4mr24630231vso.90.1559834114043;
 Thu, 06 Jun 2019 08:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190606135219.1086-1-nborisov@suse.com> <20190606135219.1086-2-nborisov@suse.com>
In-Reply-To: <20190606135219.1086-2-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 6 Jun 2019 16:15:02 +0100
Message-ID: <CAL3q7H6UaxOV1dahcTE6aWJtWsOcWUfs06NgUFMjWx56fbpWKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: Implement DRW lock
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
        peterz@infradead.org, paulmck@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 6, 2019 at 2:55 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
> A (D)ouble (R)eader (W)riter lock is a locking primitive that allows
> to have multiple readers or multiple writers but not multiple readers
> and writers holding it concurrently. The code is factored out from
> the existing open-coded locking scheme used to exclude pending
> snapshots from nocow writers and vice-versa. Current implementation
> actually favors Readers (that is snapshot creaters) to writers (nocow
> writers of the filesystem).
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/Makefile   |  2 +-
>  fs/btrfs/drw_lock.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/drw_lock.h | 23 +++++++++++++++
>  3 files changed, 95 insertions(+), 1 deletion(-)
>  create mode 100644 fs/btrfs/drw_lock.c
>  create mode 100644 fs/btrfs/drw_lock.h
>
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index ca693dd554e9..dc60127791e6 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -10,7 +10,7 @@ btrfs-y +=3D super.o ctree.o extent-tree.o print-tree.o=
 root-tree.o dir-item.o \
>            export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
>            compression.o delayed-ref.o relocation.o delayed-inode.o scrub=
.o \
>            reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56=
.o \
> -          uuid-tree.o props.o free-space-tree.o tree-checker.o
> +          uuid-tree.o props.o free-space-tree.o tree-checker.o drw_lock.=
o
>
>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) +=3D acl.o
>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) +=3D check-integrity.o
> diff --git a/fs/btrfs/drw_lock.c b/fs/btrfs/drw_lock.c
> new file mode 100644
> index 000000000000..9681bf7544be
> --- /dev/null
> +++ b/fs/btrfs/drw_lock.c
> @@ -0,0 +1,71 @@
> +#include "drw_lock.h"
> +#include "ctree.h"
> +
> +void btrfs_drw_lock_init(struct btrfs_drw_lock *lock)
> +{
> +       atomic_set(&lock->readers, 0);
> +       percpu_counter_init(&lock->writers, 0, GFP_KERNEL);
> +       init_waitqueue_head(&lock->pending_readers);
> +       init_waitqueue_head(&lock->pending_writers);
> +}
> +
> +void btrfs_drw_lock_destroy(struct btrfs_drw_lock *lock)
> +{
> +       percpu_counter_destroy(&lock->writers);
> +}
> +
> +bool btrfs_drw_try_write_lock(struct btrfs_drw_lock *lock)
> +{
> +       if (atomic_read(&lock->readers))
> +               return false;
> +
> +       percpu_counter_inc(&lock->writers);
> +
> +       /*
> +        * Ensure writers count is updated before we check for
> +        * pending readers
> +        */
> +       smp_mb();
> +       if (atomic_read(&lock->readers)) {
> +               btrfs_drw_read_unlock(lock);

Should be btrfs_drw_write_unlock(lock)

> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +void btrfs_drw_write_lock(struct btrfs_drw_lock *lock)
> +{
> +       while(true) {

Missing space after 'while'.

Thanks.

> +               if (btrfs_drw_try_write_lock(lock))
> +                       return;
> +               wait_event(lock->pending_writers, !atomic_read(&lock->rea=
ders));
> +       }
> +}
> +
> +void btrfs_drw_write_unlock(struct btrfs_drw_lock *lock)
> +{
> +       percpu_counter_dec(&lock->writers);
> +       cond_wake_up(&lock->pending_readers);
> +}
> +
> +void btrfs_drw_read_lock(struct btrfs_drw_lock *lock)
> +{
> +       atomic_inc(&lock->readers);
> +       smp_mb__after_atomic();
> +
> +       wait_event(lock->pending_readers,
> +                  percpu_counter_sum(&lock->writers) =3D=3D 0);
> +}
> +
> +void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock)
> +{
> +       /*
> +        * Atomic RMW operations imply full barrier, so woken up writers
> +        * are guaranteed to see the decrement
> +        */
> +       if (atomic_dec_and_test(&lock->readers))
> +               wake_up(&lock->pending_writers);
> +}
> +
> +
> diff --git a/fs/btrfs/drw_lock.h b/fs/btrfs/drw_lock.h
> new file mode 100644
> index 000000000000..baff59561c06
> --- /dev/null
> +++ b/fs/btrfs/drw_lock.h
> @@ -0,0 +1,23 @@
> +#ifndef BTRFS_DRW_LOCK_H
> +#define BTRFS_DRW_LOCK_H
> +
> +#include <linux/atomic.h>
> +#include <linux/wait.h>
> +#include <linux/percpu_counter.h>
> +
> +struct btrfs_drw_lock {
> +       atomic_t readers;
> +       struct percpu_counter writers;
> +       wait_queue_head_t pending_writers;
> +       wait_queue_head_t pending_readers;
> +};
> +
> +void btrfs_drw_lock_init(struct btrfs_drw_lock *lock);
> +void btrfs_drw_lock_destroy(struct btrfs_drw_lock *lock);
> +void btrfs_drw_write_lock(struct btrfs_drw_lock *lock);
> +bool btrfs_drw_try_write_lock(struct btrfs_drw_lock *lock);
> +void btrfs_drw_write_unlock(struct btrfs_drw_lock *lock);
> +void btrfs_drw_read_lock(struct btrfs_drw_lock *lock);
> +void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock);
> +
> +#endif
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
