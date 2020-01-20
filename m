Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE8981428A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgATK6I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 05:58:08 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36047 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgATK6I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 05:58:08 -0500
Received: by mail-vs1-f65.google.com with SMTP id u14so18669423vsu.3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2020 02:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=+KeGtqWdu6NWtvwVm204aqrjZnB6FYAHKo9Oe3BjJqo=;
        b=ESwt4nHhBk04X0us0k0MY0S2RiVbHB+//+EMceqFqWoj0l1FVhHvvx+5TV++84ZNB+
         ox/wfqF6oi7XXo5Kv2/G+cYIQBTwkACMJ4SDjnw7XdEecbrKWx28Zhl50dVLcpCT/osr
         m3X21+mqyJnSkfJhWlqYA+J9kLZzPNEoG+IjG5lTnOCyhvf6ZvwIoriwipvfqQOMF31O
         1Kjljt8NvQ0aPHpwgPo06fZugmwGQute6HQlyYm8QR3Th1hKqL7cKiZUkt6duV9OSSE5
         01GbBRgv18coaY9CsikEf76bk3JME/bVOObnN9APd5UOWoT5VjWk/U1Z7aciqlqN8ur1
         Jnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=+KeGtqWdu6NWtvwVm204aqrjZnB6FYAHKo9Oe3BjJqo=;
        b=c4+MwT1ULO8AkJddhoQYmyRnRdtosUuYrxbhAnJZht8k0ArYAiSSaBT7Di4xG1fM0w
         u19cxbSBLH3maLk+2h3/MsO686hH5jYLTue9RVj8MLo9BUObFa92U5vOOY405Xgv9Nk0
         S7UqSj3LD4ZObxc0V1RyN17A3CL8dSP3HKte+LFOyB5rnmeMG2bKh32NSmpx1mhzWTTX
         JK/NMKt2JHxA19rJo941Qj4tRb/NsR/Oye5hrqrNranljk3O5DWLHJ0GW73s6WhD1Kg8
         IHYNH01+79zY+RebNdENlKez0rspXCZLqVzMQy29LutV1PsPYF6ufqAMNsB8ABEXqx2v
         ULeQ==
X-Gm-Message-State: APjAAAWF+P3O94wDQrljF143JFV/RkmKQZ5yvD3M2oiVqcPB/MTQVPVI
        VOQNz5zd/cjgdopyN1sWlQIW5AjPzKiUuzhCCkgq/9WA
X-Google-Smtp-Source: APXvYqxWOItL0lHIWdQl0lxI67x/iFxc0F1pAUXSZc+wn6QgL6MgJFVYu6B2fl1TH4sZAz69o+QQsYDxY95UOtlK56M=
X-Received: by 2002:a67:af11:: with SMTP id v17mr10668396vsl.99.1579517887501;
 Mon, 20 Jan 2020 02:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20191030122301.25270-1-fdmanana@kernel.org> <0102016ea8d7cba9-e4f3d553-317c-4a83-9ad6-c161fcdd0e7f-000000@eu-west-1.amazonses.com>
 <0102016fb9f6179a-a6770a1b-f02c-4f6c-8b14-50ad749ccb1f-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016fb9f6179a-a6770a1b-f02c-4f6c-8b14-50ad749ccb1f-000000@eu-west-1.amazonses.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 20 Jan 2020 10:57:56 +0000
Message-ID: <CAL3q7H61cVR7ivb-yhca-AcuQhs6peeKQvv5=S9rRtFP-Re94A@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: send, skip backreference walking for extents with
 many references
To:     Martin Raiber <martin@urbackup.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 18, 2020 at 6:42 PM Martin Raiber <martin@urbackup.org> wrote:
>
> On 26.11.2019 18:52 Martin Raiber wrote:
> > On 30.10.2019 13:23 fdmanana@kernel.org wrote:
> >> From: Filipe Manana <fdmanana@suse.com>
> >>
> >> Backreference walking, which is used by send to figure if it can issue
> >> clone operations instead of write operations, can be very slow and use=
 too
> >> much memory when extents have many references. This change simply skip=
s
> >> backreference walking when an extent has more than 64 references, in w=
hich
> >> case we fallback to a write operation instead of a clone operation. Th=
is
> >> limit is conservative and in practice I observed no signicant slowdown
> >> with up to 100 references and still low memory usage up to that limit.
> >>
> >> This is a temporary workaround until there are speedups in the backref
> >> walking code, and as such it does not attempt to add extra interfaces =
or
> >> knobs to tweak the threshold.
> > Thanks for the patch!
> >
> > Did some further deliberation on  the problem, and for me the best shor=
t
> > term solution (apart from your patch) for the send clone source
> > detection would be to offload it to userspace.
> > I.e. a flag like "--no-data"/BTRFS_SEND_FLAG_NO_FILE_DATA that disables
> > clone source detection.
> > Userspace can then take each BTRFS_SEND_C_UPDATE_EXTENT and look if it
> > is in the clone sources/on the send target. If it is a dedup tool it ca=
n
> > use its dedup database, it can use a cache or it can use
> > BTRFS_IOC_LOGICAL_INO. Another advantage is that user space can do this
> > in multiple threads.
> >
> > Only problem I can think of is that send prevents subvol removal and
> > dedup during send, but user space may not be finished with the actual
> > send stream once send has finished outputting the metadata. So there ma=
y
> > be some issues there, but not if one has control over when removal/dedu=
p
> > happens.
>
> I was still having performance issues even with this patch. Shouldn't be
> too hard to reproduce. E.g., I have a ~10GB sqlite db with 1236459
> extents (as dbs tend to have on btrfs). Sending that (even with only two
> snapshots) causes it to be cpu limited.
>
> So I went ahead and continued to use the patch that disables backref
> walking in send (for the db above the backref walking doesn't do
> anything anyway), but use it in combination with "--no-data" to read
> file data and then dedup in user space (only whole file dedup for now).
> This is all a bit application specific. Is anyone interested in the code?

You should only see performance improvement if you have extents that
have more than 64 references.
You mention two snapshots, but you don't mention if there are extents
that are shared through reflinks (cloning and deduplication).
Also, is compression enabled? That can have a very significant impact,
specially for zstd.

Thanks.


>
> Regards,
> Martin Raiber
>
> >> Reported-by: Atemu <atemu.main@gmail.com>
> >> Link: https://lore.kernel.org/linux-btrfs/CAE4GHgkvqVADtS4AzcQJxo0Q1jK=
QgKaW3JGp3SGdoinVo=3DC9eQ@mail.gmail.com/T/#me55dc0987f9cc2acaa54372ce0492c=
65782be3fa
> >> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >> ---
> >>  fs/btrfs/send.c | 25 ++++++++++++++++++++++++-
> >>  1 file changed, 24 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> >> index 123ac54af071..518ec1265a0c 100644
> >> --- a/fs/btrfs/send.c
> >> +++ b/fs/btrfs/send.c
> >> @@ -25,6 +25,14 @@
> >>  #include "compression.h"
> >>
> >>  /*
> >> + * Maximum number of references an extent can have in order for us to=
 attempt to
> >> + * issue clone operations instead of write operations. This currently=
 exists to
> >> + * avoid hitting limitations of the backreference walking code (takin=
g a lot of
> >> + * time and using too much memory for extents with large number of re=
ferences).
> >> + */
> >> +#define SEND_MAX_EXTENT_REFS        64
> >> +
> >> +/*
> >>   * A fs_path is a helper to dynamically build path names with unknown=
 size.
> >>   * It reallocates the internal buffer on demand.
> >>   * It allows fast adding of path elements on the right side (normal p=
ath) and
> >> @@ -1302,6 +1310,7 @@ static int find_extent_clone(struct send_ctx *sc=
tx,
> >>      struct clone_root *cur_clone_root;
> >>      struct btrfs_key found_key;
> >>      struct btrfs_path *tmp_path;
> >> +    struct btrfs_extent_item *ei;
> >>      int compressed;
> >>      u32 i;
> >>
> >> @@ -1349,7 +1358,6 @@ static int find_extent_clone(struct send_ctx *sc=
tx,
> >>      ret =3D extent_from_logical(fs_info, disk_byte, tmp_path,
> >>                                &found_key, &flags);
> >>      up_read(&fs_info->commit_root_sem);
> >> -    btrfs_release_path(tmp_path);
> >>
> >>      if (ret < 0)
> >>              goto out;
> >> @@ -1358,6 +1366,21 @@ static int find_extent_clone(struct send_ctx *s=
ctx,
> >>              goto out;
> >>      }
> >>
> >> +    ei =3D btrfs_item_ptr(tmp_path->nodes[0], tmp_path->slots[0],
> >> +                        struct btrfs_extent_item);
> >> +    /*
> >> +     * Backreference walking (iterate_extent_inodes() below) is curre=
ntly
> >> +     * too expensive when an extent has a large number of references,=
 both
> >> +     * in time spent and used memory. So for now just fallback to wri=
te
> >> +     * operations instead of clone operations when an extent has more=
 than
> >> +     * a certain amount of references.
> >> +     */
> >> +    if (btrfs_extent_refs(tmp_path->nodes[0], ei) > SEND_MAX_EXTENT_R=
EFS) {
> >> +            ret =3D -ENOENT;
> >> +            goto out;
> >> +    }
> >> +    btrfs_release_path(tmp_path);
> >> +
> >>      /*
> >>       * Setup the clone roots.
> >>       */
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
