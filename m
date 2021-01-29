Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A93B308CF1
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jan 2021 20:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhA2TAX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jan 2021 14:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232863AbhA2S7z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jan 2021 13:59:55 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B8DC061573;
        Fri, 29 Jan 2021 10:59:12 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id k193so9758763qke.6;
        Fri, 29 Jan 2021 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=g1npVXxs+rY3lFhWpGwf1IZoums5Zjsby4/x0lMTOQ0=;
        b=mZzx4ca946ZfJLOFaFHG/UHqxFIQSA2PeFwsPG8P4IIqOSHQyAYtHn+RCOVgdEpdA2
         5EX45VUcsBpmWp+eYpD28iogjEpHj5lz6Ux5JvqCBWMtS3EC9tknxgUZbP4+tQ3suAEM
         tqdRzVjiHZKKvpsx8CsVUSLa+oHb4HNWj/aFAcE3jMTzMn4C0/iIOn3sgReKFgF2hVDA
         noqPYwTJaZwhKDMrUAp3qHwofeGne9Y37IuLPlFnEq6lAFEy3/M44jTkFdaScJH/0Ali
         0y+eAkfKSY4uNHECnKqeTq2UpYOYB2PbRkgUE53xNR58KA6qhwAEsi56P383I3STcxGp
         OlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=g1npVXxs+rY3lFhWpGwf1IZoums5Zjsby4/x0lMTOQ0=;
        b=jCC1XflSJkN1nYBpZJzoWB3Ddvv3EfxqF4YT4cijjL5WMs0hw4LAm+cw8uZihnzP+f
         iCNMWAlhNcEy+91q1eDg/+wkGuHEkt7KgZDW6tSS3FAiKHXEOF9biVZr/AO0XyUhbLTM
         Ubn/k6ogaMx3drdRpIy5rJguS0veDtGD6YV8vGFOFvirnSJMT/KoRIzhxIk37FomMseq
         1ilQVd427avDFqLVcUOiv5DN8h6h7noEc16JToifaoHnX2RinrIErkqijReIRMfm0330
         3dXUfaF9fMy90+YkyM+o9Bw6yUzVu1voLyzJ8pFW1N+mjzWDtkTue+E4aW25CWd2wnMx
         fL+Q==
X-Gm-Message-State: AOAM533f6u9c7Jx1XQ+D5+f8phJp3v8OecIIAgraNfJrhHAix9/T0uem
        SLJseqCugTL138Wlci3q3Lo+VO+zCNOrkd1++G8=
X-Google-Smtp-Source: ABdhPJxwYPbJA/emisfouc6kqS6rJdA1zxfzqb60up8zittWwUzYK9GwcjmKTTBo+xCVztHB0pK7H0G59uxIVStDlAk=
X-Received: by 2002:a05:620a:69a:: with SMTP id f26mr5766792qkh.0.1611946752153;
 Fri, 29 Jan 2021 10:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20210127135728.30276-1-mrostecki@suse.de> <18dab74b-aea9-0e34-1be5-39d62f44cfd2@toxicpanda.com>
 <20210129171521.GB22949@wotan.suse.de> <20210129174753.GL1993@twin.jikos.cz>
In-Reply-To: <20210129174753.GL1993@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 29 Jan 2021 18:59:01 +0000
Message-ID: <CAL3q7H6rGk8emvu2VwqtimTrsdCzFtRY05BgE_yi=gkhaSzg=A@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: Avoid calling btrfs_get_chunk_map() twice
To:     dsterba@suse.cz, Michal Rostecki <mrostecki@suse.de>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 29, 2021 at 5:54 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Jan 29, 2021 at 05:15:21PM +0000, Michal Rostecki wrote:
> > On Fri, Jan 29, 2021 at 11:22:48AM -0500, Josef Bacik wrote:
> > > On 1/27/21 8:57 AM, Michal Rostecki wrote:
> > > > From: Michal Rostecki <mrostecki@suse.com>
> > > >
> > > > Before this change, the btrfs_get_io_geometry() function was callin=
g
> > > > btrfs_get_chunk_map() to get the extent mapping, necessary for
> > > > calculating the I/O geometry. It was using that extent mapping only
> > > > internally and freeing the pointer after its execution.
> > > >
> > > > That resulted in calling btrfs_get_chunk_map() de facto twice by th=
e
> > > > __btrfs_map_block() function. It was calling btrfs_get_io_geometry(=
)
> > > > first and then calling btrfs_get_chunk_map() directly to get the ex=
tent
> > > > mapping, used by the rest of the function.
> > > >
> > > > This change fixes that by passing the extent mapping to the
> > > > btrfs_get_io_geometry() function as an argument.
> > > >
> > > > v2:
> > > > When btrfs_get_chunk_map() returns an error in btrfs_submit_direct(=
):
> > > > - Use errno_to_blk_status(PTR_ERR(em)) as the status
> > > > - Set em to NULL
> > > >
> > > > Signed-off-by: Michal Rostecki <mrostecki@suse.com>
> > >
> > > This panic'ed all of my test vms in their overnight xfstests runs, th=
e panic is this
> > >
> > > [ 2449.936502] BTRFS critical (device dm-7): mapping failed logical
> > > 1113825280 bio len 40960 len 24576
> > > [ 2449.937073] ------------[ cut here ]------------
> > > [ 2449.937329] kernel BUG at fs/btrfs/volumes.c:6450!
> > > [ 2449.937604] invalid opcode: 0000 [#1] SMP NOPTI
> > > [ 2449.937855] CPU: 0 PID: 259045 Comm: kworker/u5:0 Not tainted 5.11=
.0-rc5+ #122
> > > [ 2449.938252] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS
> > > 1.13.0-2.fc32 04/01/2014
> > > [ 2449.938713] Workqueue: btrfs-worker-high btrfs_work_helper
> > > [ 2449.939016] RIP: 0010:btrfs_map_bio.cold+0x5a/0x5c
> > > [ 2449.939392] Code: 37 87 ff ff e8 ed d4 8a ff 48 83 c4 18 e9 b5 52 =
8b ff
> > > 49 89 c8 4c 89 fa 4c 89 f1 48 c7 c6 b0 c0 61 8b 48 89 ef e8 11 87 ff =
ff <0f>
> > > 0b 4c 89 e7 e8 42 09 86 ff e9 fd 59 8b ff 49 8b 7a 50 44 89 f2
> > > [ 2449.940402] RSP: 0000:ffff9f24c1637d90 EFLAGS: 00010282
> > > [ 2449.940689] RAX: 0000000000000057 RBX: ffff90c78ff716b8 RCX: 00000=
00000000000
> > > [ 2449.941080] RDX: ffff90c7fbc27ae0 RSI: ffff90c7fbc19110 RDI: ffff9=
0c7fbc19110
> > > [ 2449.941467] RBP: ffff90c7911d4000 R08: 0000000000000000 R09: 00000=
00000000000
> > > [ 2449.941853] R10: ffff9f24c1637b48 R11: ffffffff8b9723e8 R12: 00000=
00000000000
> > > [ 2449.942243] R13: 0000000000000000 R14: 000000000000a000 R15: 00000=
0004263a000
> > > [ 2449.942632] FS:  0000000000000000(0000) GS:ffff90c7fbc00000(0000)
> > > knlGS:0000000000000000
> > > [ 2449.943072] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 2449.943386] CR2: 00005575163c3080 CR3: 000000010ad6c004 CR4: 00000=
00000370ef0
> > > [ 2449.943772] Call Trace:
> > > [ 2449.943915]  ? lock_release+0x1c3/0x290
> > > [ 2449.944135]  run_one_async_done+0x3a/0x60
> > > [ 2449.944360]  btrfs_work_helper+0x136/0x520
> > > [ 2449.944588]  process_one_work+0x26e/0x570
> > > [ 2449.944812]  worker_thread+0x55/0x3c0
> > > [ 2449.945016]  ? process_one_work+0x570/0x570
> > > [ 2449.945250]  kthread+0x137/0x150
> > > [ 2449.945430]  ? __kthread_bind_mask+0x60/0x60
> > > [ 2449.945666]  ret_from_fork+0x1f/0x30
> > >
> > > it happens when you run btrfs/060.  Please make sure to run xfstests =
against
> > > patches before you submit them upstream.  Thanks,
> > >
> > > Josef
> >
> > Umm... I ran the xftests against v1 patch and didn't get that panic.
>
> It could have been caused by my fixups to v2 and I can reproduce the
> crash now too. I can't see any difference besides the u64/int switch and
> the 'goto out' removal in btrfs_bio_fits_in_stripe.

The problem is caused by what I mentioned earlier today:

The value of "logical" must be set at the start of each iteration of
the loop at btrfs_submit_direct(),
and not before starting the loop, since the start sector is
incremented at the end of each iteration of the loop.




--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
