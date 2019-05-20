Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A3E23AAB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 16:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391937AbfETOnL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 10:43:11 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41880 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732661AbfETOnL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 10:43:11 -0400
Received: by mail-ua1-f68.google.com with SMTP id l14so593958uah.8
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=tG+scfQ7GE0P48lAYtnE+hQDP4uaZbd8RaolNvoRTaQ=;
        b=OKkLhDDmzUa1JzPUz4V8EE33HM1pbx+FiQPEv/n8XxYaPXwGmq6Nv4duUuTC0DO1X6
         ll150+FTQeeWlWGpAZzy+RL9RhvAJHMy0h3ho8gnD8JHpDdVcP+LRhxi0dNvRJ0Ci/5G
         g21gbMBYalOs80OoXujOTwU6ttRXb9zatYSFvFMYM/a6mRCcH97NIg49TTex85tXXvwG
         k1to0Uj0iU6xmVJPrFl0vK+r147OA7jHHD6USrsvyPj7JKMelfbkFeSouN5v8ETpemSN
         nLmsE0tA98KxNzDfp03gbXmwAxPeOGeXZaoJWXCvnKehkHjaY9MmiTCuXF5yE2VCDJiF
         YIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=tG+scfQ7GE0P48lAYtnE+hQDP4uaZbd8RaolNvoRTaQ=;
        b=A03WlRSO3I9f04OBFxc1a4MIvSN9Smp683sYuUrnTm2k6uEe6F/ydWC6R1xq+ZH+pF
         RqZusRQSdt1ygd27WzasjpWS5TTAmuEfCk3q3RKXlmH6D1ePX5EAM3C0/GUXxStuCsgI
         65UGZ3c0lz6zCLjjNaeKa62O+uZslrQMF9e2R9hcPJZk3T1cIYPj91V7vzTstJl3Ifsp
         rR+7AgmbqamcpOtzifMzAhlBFmowOUr184Bi3lBn9jULVGr/8hVLXvDdNDoHTsRwvWXA
         n+i17Jb/UJu3hpv6YkuM5eL3M8dqSo4y++oP2x8v+XzJ1oRbTrlv2hAP/VXEmS47Fc8F
         OUug==
X-Gm-Message-State: APjAAAVqy6Um5YkGemWe02yyiq462bxkPMzsKi7DgTpPyx9f0A2t+h6o
        vZzQFKFPRg+wUwKwPLevz4/PnOgGUPfQdw7RH6U=
X-Google-Smtp-Source: APXvYqy+EiXpWswwKwFNfcnOwhU+mTBjKOmYX5CU69fLDkH2q7Wy7BbK8+K/48y2BYvL/4POj6Mlt82msC9QCN3crRM=
X-Received: by 2002:ab0:69c6:: with SMTP id u6mr27338186uaq.27.1558363389731;
 Mon, 20 May 2019 07:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190520081142.23706-1-nborisov@suse.com> <560224d9-28ec-033f-c7c0-f324576e5e04@suse.com>
 <CAL3q7H5MHYhrvLnqHagkmLS_cey6Bc-nZh-21ivGjbSPjZ76+Q@mail.gmail.com> <e4c42032-ee2b-1289-3f93-96214c753cc4@suse.com>
In-Reply-To: <e4c42032-ee2b-1289-3f93-96214c753cc4@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 20 May 2019 15:42:58 +0100
Message-ID: <CAL3q7H6ftyYNwKRH3Nx+pXd1fTavZZ3-yo=nwaLEhi7E82jodA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Simplify join_running_log_trans
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe David Borba Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 20, 2019 at 10:13 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 20.05.19 =D0=B3. 12:10 =D1=87., Filipe Manana wrote:
> > On Mon, May 20, 2019 at 9:23 AM Nikolay Borisov <nborisov@suse.com> wro=
te:
> >>
> >>
> >>
> >> On 20.05.19 =D0=B3. 11:11 =D1=87., Nikolay Borisov wrote:
> >>> This patch removes stray smp_mb before root->log_root from join_runni=
ng_log_trans
> >>> as well as the unlocked check for root->log_root. log_root is only se=
t in
> >>> btrfs_add_log_tree, called from start_log_trans under root->log_mutex=
.
> >>> Furthermore, log_root is freed in btrfs_free_log, called from commit_=
fs_root,
> >>> which in turn is called from transaction's critical section (TRANS_CO=
MMIT_DOING).
> >>> Those 2 locking invariants ensure join_running_log_trans don't see in=
valid
> >>> values of ->log_root.
> >>>
> >>> Additionally this results in around 26% improvement when deleting 500=
k files/dir.
> >>> All values are in seconds.
> >>>
> >>>       With Patch (real)       With patch (sys)        Without patch (=
real)    Without patch (sys)
> >>>           80                                  78                     =
                         91                                              90
> >>>               63                                      62             =
                                 93                                        =
      91
> >>>               65                                      64             =
                                 92                                        =
      90
> >>>               67                                      65             =
                                 93                                        =
      90
> >>>               75                                      73             =
                                 90                                        =
      88
> >>>               75                                      73             =
                                 91                                        =
      89
> >>>               75                                      73             =
                                 93                                        =
      90
> >>>               74                                      73             =
                                 89                                        =
      87
> >>>               76                                      74             =
                                 91                                        =
      89
> >>> stddev        5.76146200581454        5.45690184791497        1.42400=
062421959        1.22474487139159
> >>> mean  72.2222222222222        70.5555555555556        91.444444444444=
4        89.3333333333333
> >>> median  75                                    73                     =
                         91                                              90
> >>>
> >>     With Patch (real)   With patch (sys)    Without patch (real)    Wi=
thout patch (sys)
> >>         80                   78                     91                =
      90
> >>         63                   62                     93                =
      91
> >>         65                   64                     92                =
      90
> >>         67                   65                     93                =
      90
> >>         75                   73                     90                =
      88
> >>         75                   73                     91                =
      89
> >>         75                   73                     93                =
      90
> >>         74                   73                     89                =
      87
> >>         76                   74                     91                =
      89
> >> stddev  5.76146200581454    5.45690184791497    1.42400062421959    1.=
22474487139159
> >> mean    72.2222222222222    70.5555555555556    91.4444444444444    89=
.3333333333333
> >> median  75                   73                     91                =
      90
> >
> > Great.
> >
> > How was that test done?
> > Simply deleting the files with nothing else running in parallel?
>
> Yes
>
> >
> > How does it behave if while the files are being deleted,  there are
> > concurrent fsyncs on other files of the same subvolume, that is, while
> > the mutex is held?
> >
> > Because that check without holding the mutex, is likely there for
> > performance reasons.
>
> So I will repeat the test when there are concurrent fsyncs running and
> also with no concurrent fsyncs running but just removing the smp_mb, I
> think the performance gain should be from removing the smp_mb and not
> necessarily the check. In the worst case I can leave the check intact
> and just remove the smp_mb because it doesn't add any value
> correctness-wise.

So the barrier is likely there to make sure we see non-null log_root
after it was set, concurrently by someone calling start_log_trans().
It pairs, implicitly, with the mutex_unlock there, at
start_log_trans(), since that implies a memory barrier.

With your patch, we always end up doing a mutex_lock(), which also
implies a memory barrier.

Sorry I missed this before, but your test doesn't make any sense. How
can a memory barrier have such a big impact on a code path (unlink)
that does lot of much heavier stuff? Like btree searches/deletes,
deleting  delayed items, etc.
Your test case is even flawed because join_running_log_trans() can
never be called.

Look at its only two callers, btrfs_del_inode_ref_in_log() and
btrfs_del_dir_entries_in_log(), they both do:

if (dir->logged_trans < trans->transid)
return 0;

ret =3D join_running_log_trans(root);
if (ret)
return 0;

and

if (inode->logged_trans < trans->transid)
return 0;

ret =3D join_running_log_trans(root);
if (ret)
return 0;

Since you never fsync the files nor the directory containing them in
that test, we never end up calling join_running_log_trans().

So I don't know where you got the 26%...

Thanks.

>
> >
> > Thanks.
> >
> >
> >>
> >>
> >> Here's the perf data without being butchered.
> >>
> >>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> >>> ---
> >>>
> >>> This passed full xfstest run and the performance results were obtaine=
d with the
> >>> following testcase:
> >>>
> >>> #!/bin/bash
> >>> for i in {1..10}; do
> >>>     echo "Testun run : %i"
> >>>     ./ltp/fsstress -z -d /media/scratch/ -f creat=3D100 -n 500000
> >>>     sync
> >>>     time rm -rf /media/scratch/*
> >>>     sync
> >>> done
> >>>
> >>>  fs/btrfs/tree-log.c | 4 ----
> >>>  1 file changed, 4 deletions(-)
> >>>
> >>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> >>> index 6adcd8a2c5c7..61744d8af106 100644
> >>> --- a/fs/btrfs/tree-log.c
> >>> +++ b/fs/btrfs/tree-log.c
> >>> @@ -188,10 +188,6 @@ static int join_running_log_trans(struct btrfs_r=
oot *root)
> >>>  {
> >>>       int ret =3D -ENOENT;
> >>>
> >>> -     smp_mb();
> >>> -     if (!root->log_root)
> >>> -             return -ENOENT;
> >>> -
> >>>       mutex_lock(&root->log_mutex);
> >>>       if (root->log_root) {
> >>>               ret =3D 0;
> >>>
> >
> >
> >
> > --
> > Filipe David Manana,
> >
> > =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 yo=
u're right.=E2=80=9D
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
