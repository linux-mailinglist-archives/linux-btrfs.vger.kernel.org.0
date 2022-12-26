Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8637765662C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Dec 2022 00:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiLZXxL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Dec 2022 18:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiLZXxK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Dec 2022 18:53:10 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00260DDD;
        Mon, 26 Dec 2022 15:53:08 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id k2so5641293qkk.7;
        Mon, 26 Dec 2022 15:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTFeeqkp8E8DV13l6J+Ks626TIBwyIrqrqVeV3UZPaU=;
        b=HXAWrpykVRZ6geWMUlrEDnGh0fm4i3u5r+KXp46P8GKtl3mLhTm53go2AdKTNb/dZ8
         66y58OufmEBItcDHs2ehWCVwu5RaRbiKStBt+wPMQdfpv7VHJKnsHqbLVy9Au1Eexsop
         LrYz05UR8tBLtWxlUKE3VsoLhewEbf1o+3PFF2rkaxXFVNUuYww7DE3WLbfENzlxFjHW
         Px8IRDktM+SpVePPjJxLqfvQCCa+Y5Q4u3z345rQ+IXun+kkaeTW9QGVjkG8vEUae6uD
         YhgZkNd3LHPScOPwFm8FS07UR1Egu9Ahklr5akXwnMzUAq4WVgU6TrDxKU+R6v4D5GB4
         gWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTFeeqkp8E8DV13l6J+Ks626TIBwyIrqrqVeV3UZPaU=;
        b=cacTFNV7Iw7SwmImu26xInXutJm3436by1kkgpBkFdaV2FXOkqwKHhYJbNfb44b3ck
         OwiCji979zcOh0PB36Kr88JHq2I5jSEJytCqeyQPoZJf95CYupg4rScxsyO0C69P9emv
         QFMO2uijyg3PNcjc9W+WbV9T8SWDCSHmd7THJRpKI/QcJcw1sg1LeiqH9FMBFMS+on0K
         mH8B1HnJzMuyWkPUSoDsYDIozaVmFoTPHOc1pvCtCfmAOEVA3ufqOnRrZz7jKK2/3HcP
         RhZGY7zbW8MiIM0QgRic1rVsXUJDEZSxBrHLxKPP6OJeHY17FK5YAm54BcPO/S9BQB8U
         gfng==
X-Gm-Message-State: AFqh2kr94ihKZRAHdDj7jHAWKkBAbG8X+i61KqGCuxu7t87fjBDkbBpF
        XY1NxJhb8BglpECjHgYhbj5nomFJDspVRuPKwuw=
X-Google-Smtp-Source: AMrXdXvRifOITSKhhx5f9GE2WXvSJWXhhgsqa0Akr0nvBlmDjDr7B1dxNk5JJOuEkq2y4tOT0G+k4+kliwB4c6k8xU4=
X-Received: by 2002:a37:592:0:b0:6ff:9cee:cdb7 with SMTP id
 140-20020a370592000000b006ff9ceecdb7mr1024293qkf.327.1672098787872; Mon, 26
 Dec 2022 15:53:07 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <f68699c3-ec5e-d8e8-f101-6e9a7020ac81@gmx.com> <CABXGCsNrm3ddn3p_ECSRe+yQeoF3KojTFvy-CpXNzi9ADkbnvQ@mail.gmail.com>
 <18b5fa1e-7d1e-4560-c98b-d7ac5fc87c3a@gmx.com> <CABXGCsM5y6m=pLX7tyE-RB1yuHEgZh3fxDu5ESfTRxEnW+djZA@mail.gmail.com>
 <0036622d-53f7-eaba-f720-6dd9bdca28ad@gmx.com> <CABXGCsMMYmCT_Hz=wfKWDy4OQJ2KyBO3rNAFC1YCAthziWm+Lg@mail.gmail.com>
 <41734bdb-2df0-6596-01b6-76a7dfd05d64@gmx.com> <CABXGCsM6GOzr+wL9BEk7mD5xLNgsKE5KUBADD8r783V6-FwXdg@mail.gmail.com>
 <e9f4d768-d91b-b5cc-dbe6-041a81833cf3@gmx.com>
In-Reply-To: <e9f4d768-d91b-b5cc-dbe6-041a81833cf3@gmx.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 27 Dec 2022 04:52:57 +0500
Message-ID: <CABXGCsPK6ZZ4=5qathvjqSJNde6MYhA0uvh6zAMznT9Yj3xk2g@mail.gmail.com>
Subject: Re: [6.2][regression] after commit 947a629988f191807d2d22ba63ae18259bb645c5
 btrfs volume periodical forced switch to readonly after a lot of disk writes
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     wqu@suse.com, dsterba@suse.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 27, 2022 at 4:36 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
> Please be aware that, this newer version may cause extra kernel
> warnings, if it found any uninitialized btrfs_tree_parent_check
> structure at submit time.
>
> But there are completely valid cases we can do that, thus it may cause
> much larger dmesg output, and you should not rely on the kernel warning
> to determine if the bug is triggered.
>

The kernel failed to built with v2 patch.

Here list of compilatore error messages:
fs/btrfs/disk-io.c: In function =E2=80=98btrfs_submit_metadata_bio=E2=80=99=
:
fs/btrfs/disk-io.c:5413:2: error: unterminated argument list invoking
macro "WARN_ON"
 5413 | }
      |  ^
  CC      net/ipv4/icmp.o
fs/btrfs/disk-io.c:851:17: error: =E2=80=98WARN_ON=E2=80=99 undeclared (fir=
st use in
this function)
  851 |                 WARN_ON(!memcmp(&check, &bbio->parent_check,
      |                 ^~~~~~~
fs/btrfs/disk-io.c:851:17: note: each undeclared identifier is
reported only once for each function it appears in
fs/btrfs/disk-io.c:851:24: error: expected =E2=80=98;=E2=80=99 at end of in=
put
  851 |                 WARN_ON(!memcmp(&check, &bbio->parent_check,
      |                        ^
      |                        ;
......
fs/btrfs/disk-io.c:851:17: error: expected declaration or statement at
end of input
  851 |                 WARN_ON(!memcmp(&check, &bbio->parent_check,
      |                 ^~~~~~~
fs/btrfs/disk-io.c:851:17: error: expected declaration or statement at
end of input
fs/btrfs/disk-io.c:845:22: warning: unused variable =E2=80=98ret=E2=80=99 [=
-Wunused-variable]
  845 |         blk_status_t ret;
      |                      ^~~
fs/btrfs/disk-io.c:844:40: warning: unused variable =E2=80=98check=E2=80=99=
 [-Wunused-variable]
  844 |         struct btrfs_tree_parent_check check =3D {0};
      |                                        ^~~~~
fs/btrfs/disk-io.c:842:31: warning: unused variable =E2=80=98fs_info=E2=80=
=99
[-Wunused-variable]
  842 |         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
      |                               ^~~~~~~
  HDRTEST usr/include/linux/loadpin.h
fs/btrfs/disk-io.c: At top level:
fs/btrfs/disk-io.c:63:13: warning: =E2=80=98btrfs_destroy_ordered_extents=
=E2=80=99
declared =E2=80=98static=E2=80=99 but never defined [-Wunused-function]
   63 | static void btrfs_destroy_ordered_extents(struct btrfs_root *root);
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/btrfs/disk-io.c:64:12: warning: =E2=80=98btrfs_destroy_delayed_refs=E2=
=80=99
declared =E2=80=98static=E2=80=99 but never defined [-Wunused-function]
   64 | static int btrfs_destroy_delayed_refs(struct btrfs_transaction *tra=
ns,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
fs/btrfs/disk-io.c:66:13: warning: =E2=80=98btrfs_destroy_delalloc_inodes=
=E2=80=99
declared =E2=80=98static=E2=80=99 but never defined [-Wunused-function]
   66 | static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root);
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/btrfs/disk-io.c:67:12: warning: =E2=80=98btrfs_destroy_marked_extents=E2=
=80=99
declared =E2=80=98static=E2=80=99 but never defined [-Wunused-function]
   67 | static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_in=
fo,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/btrfs/disk-io.c:70:12: warning: =E2=80=98btrfs_destroy_pinned_extent=E2=
=80=99
declared =E2=80=98static=E2=80=99 but never defined [-Wunused-function]
   70 | static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_inf=
o,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/btrfs/disk-io.c:72:12: warning: =E2=80=98btrfs_cleanup_transaction=E2=80=
=99
declared =E2=80=98static=E2=80=99 but never defined [-Wunused-function]
   72 | static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)=
;
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~
fs/btrfs/disk-io.c:73:13: warning: =E2=80=98btrfs_error_commit_super=E2=80=
=99 declared
=E2=80=98static=E2=80=99 but never defined [-Wunused-function]
   73 | static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)=
;
      |             ^~~~~~~~~~~~~~~~~~~~~~~~
fs/btrfs/disk-io.c:828:13: warning: =E2=80=98should_async_write=E2=80=99 de=
fined but
not used [-Wunused-function]
  828 | static bool should_async_write(struct btrfs_fs_info *fs_info,
      |             ^~~~~~~~~~~~~~~~~~
fs/btrfs/disk-io.c:161:13: warning: =E2=80=98btrfs_supported_super_csum=E2=
=80=99
defined but not used [-Wunused-function]
  161 | static bool btrfs_supported_super_csum(u16 csum_type)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
fs/btrfs/disk-io.c:130:12: warning: =E2=80=98verify_parent_transid=E2=80=99=
 defined
but not used [-Wunused-function]
  130 | static int verify_parent_transid(struct extent_io_tree *io_tree,
      |            ^~~~~~~~~~~~~~~~~~~~~
fs/btrfs/disk-io.c:75:13: warning: =E2=80=98btrfs_free_csum_hash=E2=80=99 d=
efined but
not used [-Wunused-function]
   75 | static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
      |             ^~~~~~~~~~~~~~~~~~~~
  CC      kernel/notifier.o
make[3]: *** [scripts/Makefile.build:252: fs/btrfs/disk-io.o] Error 1
make[3]: *** Waiting for unfinished jobs....


--=20
Best Regards,
Mike Gavrilov.
