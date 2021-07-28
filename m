Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C43A3D975B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 23:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhG1VOm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 17:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhG1VOm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 17:14:42 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8530BC061757
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 14:14:39 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id a201so6239056ybg.12
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g7/VXf0NvMhPDTNggXYxAZM9MuEiwsER1MM/CeT0MI4=;
        b=g2YShPdqkvwDFfGXgGLoDejBCgG7XpoQ+rAeY4JFycJDST889DywfhsVXi0pH1m2Wh
         1GPYWXLmCNw9aYPA4hjXQVD9goWjK/nbAc/KfJSqQjIeERnEfb2FlZ9IpKa5Hk2Hl/ZO
         Ma1cWL2Jq2Y0nIZl+vRJ84+fSPya2LzJfFTmDBKR8eeK4DLPW+YLHaT9p+AfIYJxKo6s
         Ku+QZjQAsJnRbM6n0Ncgkf/4ovTFoV6YIBYlx2CpVA9ZrpTrhQKLJBrlqkGNF+yZ0qcE
         31tRPmaKTNLtOOG5zhqO425iKXXYICYtqX50Dg2em/v+0JGRIACm/7etR7BObWqcnWZt
         0xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g7/VXf0NvMhPDTNggXYxAZM9MuEiwsER1MM/CeT0MI4=;
        b=VOr9QniyGKEQG8vAW0XrtacBC0031NZ7t1om6BMickoCgDoG/fREhVV3PsTJdoNC7K
         7snqSeCq9F0C5NqyYEwjDuflFPNyvcIYZdtm0a2AlMggXFhsKW2ROOrick9d39t0FyNJ
         m6yXSCrelb2nwn9M/hEEUXLbzhQx6ju462OXp8j1myx1KCU/k3lZS1wolh98O7QWQ0kA
         45Ta64Fkdtdtv/iMfNVOa47v2JrPRQHJdUsLdHJtw+CUQHvD5KeRYzaBw3fJPr6dc5DK
         YmfjzltTPknpEbr5g2osiIjvqZ/ZDH4VkfN+sygySKbQmCPycSfgaWuJtv7cf0BHnFcu
         +57Q==
X-Gm-Message-State: AOAM5326cla74D5UwaWNzxNm5aVaiTjEZzGBteNgg+rx6N6/pvCjZdzh
        RTgd6esBCbzdInVOBabO8F1hWirP/OzpmpNejaY=
X-Google-Smtp-Source: ABdhPJzk1PYUvcky5Fb7AhQJ52poC5qcEQSZiPMQ7xNI8X26mIRCJ0Ui5AHR3pQ8kstPmX1qPJ44SAaNVt3KlJAmtVc=
X-Received: by 2002:a25:9201:: with SMTP id b1mr2230892ybo.354.1627506878597;
 Wed, 28 Jul 2021 14:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <0f344e692b14ffbec90cb9f32e0d177c30326c37.1627498953.git.osandov@fb.com>
In-Reply-To: <0f344e692b14ffbec90cb9f32e0d177c30326c37.1627498953.git.osandov@fb.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 28 Jul 2021 17:14:02 -0400
Message-ID: <CAEg-Je-aF7eLRK_9qgM18kOgPjVChRti7PBm2yHgTKrcNQiCgg@mail.gmail.com>
Subject: Re: [PATCH v2] libbtrfsutil: fix race between subvolume iterator and deletion
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 28, 2021 at 3:05 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> Subvolume iteration has a window between when we get a root ref (with
> BTRFS_IOC_TREE_SEARCH or BTRFS_IOC_GET_SUBVOL_ROOTREF) and when we look
> up the path of the parent directory (with BTRFS_IOC_INO_LOOKUP{,_USER}).
> If the subvolume is moved or deleted and its old parent directory is
> deleted during that window, then BTRFS_IOC_INO_LOOKUP{,_USER} will fail
> with ENOENT. The iteration will then fail with ENOENT as well.
>
> We originally encountered this bug with an application that called
> `btrfs subvolume show` (which iterates subvolumes to find snapshots) in
> parallel with other threads creating and deleting subvolumes. It can be
> reproduced almost instantly with the included test cases.
>
> Subvolume iteration should be robust against concurrent modifications to
> subvolumes. So, if a subvolume's parent directory no longer exists, just
> skip the subvolume, as it must have been deleted or moved elsewhere.
>
> Reviewed-by: Neal Gompa <ngompa13@gmail.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> Changes from v1 -> v2:
>
> - Added Neal's reviewed-by.
> - Added test cases.
>
> Let me know if you'd prefer the test cases as a separate patch instead.
>
>  libbtrfsutil/python/tests/__init__.py       | 11 +++-
>  libbtrfsutil/python/tests/test_subvolume.py | 73 +++++++++++++++++++--
>  libbtrfsutil/subvolume.c                    | 18 ++++-
>  3 files changed, 91 insertions(+), 11 deletions(-)
>
> diff --git a/libbtrfsutil/python/tests/__init__.py b/libbtrfsutil/python/=
tests/__init__.py
> index 9fd6f6de..a1ea740e 100644
> --- a/libbtrfsutil/python/tests/__init__.py
> +++ b/libbtrfsutil/python/tests/__init__.py
> @@ -77,7 +77,16 @@ class BtrfsTestCase(unittest.TestCase):
>              mkfs =3D 'mkfs.btrfs'
>          try:
>              subprocess.check_call([mkfs, '-q', image])
> -            subprocess.check_call(['mount', '-o', 'loop', '--', image, m=
ountpoint])
> +            subprocess.check_call(
> +                [
> +                    'mount',
> +                    '-o',
> +                    'loop,user_subvol_rm_allowed',
> +                    '--',
> +                    image,
> +                    mountpoint,
> +                ]
> +            )
>          except Exception as e:
>              os.rmdir(mountpoint)
>              os.remove(image)
> diff --git a/libbtrfsutil/python/tests/test_subvolume.py b/libbtrfsutil/p=
ython/tests/test_subvolume.py
> index 61055f53..2620b5c5 100644
> --- a/libbtrfsutil/python/tests/test_subvolume.py
> +++ b/libbtrfsutil/python/tests/test_subvolume.py
> @@ -17,6 +17,7 @@
>
>  import fcntl
>  import errno
> +import multiprocessing
>  import os
>  import os.path
>  from pathlib import PurePath
> @@ -493,20 +494,78 @@ class TestSubvolume(BtrfsTestCase):
>          finally:
>              os.chdir(pwd)
>
> +    def _skip_unless_have_unprivileged_subvolume_iterator(self, path):
> +        with drop_privs():
> +            try:
> +                for _ in btrfsutil.SubvolumeIterator(path):
> +                    break
> +            except OSError as e:
> +                if e.errno =3D=3D errno.ENOTTY:
> +                    self.skipTest('BTRFS_IOC_GET_SUBVOL_ROOTREF is not a=
vailable')
> +                else:
> +                    raise
> +
>      @skipUnlessHaveNobody
>      def test_subvolume_iterator_unprivileged(self):
>          os.chown(self.mountpoint, NOBODY_UID, -1)
>          pwd =3D os.getcwd()
>          try:
>              os.chdir(self.mountpoint)
> +            self._skip_unless_have_unprivileged_subvolume_iterator('.')
>              with drop_privs():
> -                try:
> -                    list(btrfsutil.SubvolumeIterator('.'))
> -                except OSError as e:
> -                    if e.errno =3D=3D errno.ENOTTY:
> -                        self.skipTest('BTRFS_IOC_GET_SUBVOL_ROOTREF is n=
ot available')
> -                    else:
> -                        raise
>                  self._test_subvolume_iterator()
>          finally:
>              os.chdir(pwd)
> +
> +    @staticmethod
> +    def _create_and_delete_subvolume(i):
> +        dir_name =3D f'dir{i}'
> +        subvol_name =3D dir_name + '/subvol'
> +        while True:
> +            os.mkdir(dir_name)
> +            btrfsutil.create_subvolume(subvol_name)
> +            btrfsutil.delete_subvolume(subvol_name)
> +            os.rmdir(dir_name)
> +
> +    def _test_subvolume_iterator_race(self):
> +        procs =3D []
> +        fd =3D os.open('.', os.O_RDONLY | os.O_DIRECTORY)
> +        try:
> +            for i in range(10):
> +                procs.append(
> +                    multiprocessing.Process(
> +                        target=3Dself._create_and_delete_subvolume,
> +                        args=3D(i,),
> +                        daemon=3DTrue,
> +                    )
> +                )
> +            for proc in procs:
> +                proc.start()
> +            for i in range(1000):
> +                with btrfsutil.SubvolumeIterator(fd) as it:
> +                    for _ in it:
> +                        pass
> +        finally:
> +            for proc in procs:
> +                proc.terminate()
> +                proc.join()
> +            os.close(fd)
> +
> +    def test_subvolume_iterator_race(self):
> +        pwd =3D os.getcwd()
> +        try:
> +            os.chdir(self.mountpoint)
> +            self._test_subvolume_iterator_race()
> +        finally:
> +            os.chdir(pwd)
> +
> +    def test_subvolume_iterator_race_unprivileged(self):
> +        os.chown(self.mountpoint, NOBODY_UID, -1)
> +        pwd =3D os.getcwd()
> +        try:
> +            os.chdir(self.mountpoint)
> +            self._skip_unless_have_unprivileged_subvolume_iterator('.')
> +            with drop_privs():
> +                self._test_subvolume_iterator_race()
> +        finally:
> +            os.chdir(pwd)
> diff --git a/libbtrfsutil/subvolume.c b/libbtrfsutil/subvolume.c
> index e30956b1..32086b7f 100644
> --- a/libbtrfsutil/subvolume.c
> +++ b/libbtrfsutil/subvolume.c
> @@ -1469,8 +1469,16 @@ static enum btrfs_util_error subvolume_iterator_ne=
xt_tree_search(struct btrfs_ut
>                 name =3D (const char *)(ref + 1);
>                 err =3D build_subvol_path_privileged(iter, header, ref, n=
ame,
>                                                    &path_len);
> -               if (err)
> +               if (err) {
> +                       /*
> +                        * If the subvolume's parent directory doesn't ex=
ist,
> +                        * then the subvolume was either moved or deleted=
. Skip
> +                        * it.
> +                        */
> +                       if (errno =3D=3D ENOENT)
> +                               continue;
>                         return err;
> +               }
>
>                 err =3D append_to_search_stack(iter,
>                                 btrfs_search_header_offset(header), path_=
len);
> @@ -1539,8 +1547,12 @@ static enum btrfs_util_error subvolume_iterator_ne=
xt_unprivileged(struct btrfs_u
>                 err =3D build_subvol_path_unprivileged(iter, treeid, diri=
d,
>                                                      &path_len);
>                 if (err) {
> -                       /* Skip the subvolume if we can't access it. */
> -                       if (errno =3D=3D EACCES)
> +                       /*
> +                        * If the subvolume's parent directory doesn't ex=
ist,
> +                        * then the subvolume was either moved or deleted=
. Skip
> +                        * it. Also skip it if we can't access it.
> +                        */
> +                       if (errno =3D=3D ENOENT || errno =3D=3D EACCES)
>                                 continue;
>                         return err;
>                 }
> --
> 2.32.0
>

I like that test cases are part of the commit. It makes sense as part
of a logical change.

I know I've already done the review, but I'll reaffirm this version.

Reviewed-by: Neal Gompa <ngompa13@gmail.com>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
