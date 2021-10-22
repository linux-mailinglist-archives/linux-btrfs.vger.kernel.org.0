Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7FF4377D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhJVNUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 09:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhJVNUi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 09:20:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB07B61163
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Oct 2021 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634908700;
        bh=65b55tZ+m3p57nlVRNzGkg8fjWR915w7J8qf7hCEvIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ANep7Wh9ITrCF4VNi8xSO5TpSM+RQU/0mBFmqcfrWTpRt1SHSrokUH/S0nUCWlgdJ
         PI0QAy1PQdDP46dkEyECto2Ht5rWTDN4ytnb2Os9mUBQufT2iBJCKmCoRFSaG02EzQ
         GXKw/5Ej4MEKCF5bd3mPL4N5aM6NTbenKQjXQ9bcZ5ddIb2b6ee0hQg1KcIjd3vsmA
         KG1lXYwq8UuT5GelDE36LnGctQXpUmiBgPitLZM0KIpw4/ktz+8ED7uVa7lZDMykOE
         1+CNZ379tnYMvIxz5mAitVcyCngqqtkk/+DNLheYod0y4pAd7s6/MdbBrcy300RzY0
         wnh3t1/3yP+0w==
Received: by mail-qt1-f181.google.com with SMTP id o12so3440535qtq.7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Oct 2021 06:18:20 -0700 (PDT)
X-Gm-Message-State: AOAM533w5vmyxT+50BbP6IywdLzLfMSSYQeR6RzVPtfNWk87s9Jri+Dn
        UBDGlfjiHgSozb3gwWVNPlVQwReZogvGKvXjdno=
X-Google-Smtp-Source: ABdhPJwZHCs/AWTL7f6nKMOBx+CTubPaydILDMhEThH4y41nKF6O4E3Xts2CBKhFnqgRnaDigyyq2lFy+MkO6hucQSA=
X-Received: by 2002:ac8:5a07:: with SMTP id n7mr13190060qta.304.1634908699647;
 Fri, 22 Oct 2021 06:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211022135923.E369.409509F4@e16-tech.com> <CAL3q7H4co70ByFqnDVArCQE9B1D7p6jf=jA+PRgJV2ijoS9vWg@mail.gmail.com>
 <20211022201232.7830.409509F4@e16-tech.com>
In-Reply-To: <20211022201232.7830.409509F4@e16-tech.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 22 Oct 2021 14:17:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5t6mL8G8-8QuUBOZDR-oniSosPHZCNo81dFQTcZXigQw@mail.gmail.com>
Message-ID: <CAL3q7H5t6mL8G8-8QuUBOZDR-oniSosPHZCNo81dFQTcZXigQw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix deadlock due to page faults during direct IO
 reads and writes
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000049b1ac05cef0d8c7"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--00000000000049b1ac05cef0d8c7
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 22, 2021 at 1:12 PM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> > On Fri, Oct 22, 2021 at 6:59 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
> > >
> > > Hi,
> > >
> > > I noticed a infinite loop of fstests/generic/475 when I apply this patch
> > > and "[PATCH v9 00/17] gfs2: Fix mmap + page fault deadlocks"
> >
> > You mean v8? I can't find v9 anywhere.
>
> Yes. It is v8.
>
>
> > >
> > > reproduce frequency: about 50%.
> >
> > with v8, on top of current misc-next, I couldn't trigger any issues
> > after running g/475 for 50+ times.
> >
> > >
> > > Call Trace 1:
> > > Oct 22 06:13:06 T7610 kernel: task:fsstress        state:R  running task     stack:    0 pid:2652125 ppid:     1 flags:0x00004006
> > > Oct 22 06:13:06 T7610 kernel: Call Trace:
> > > Oct 22 06:13:06 T7610 kernel: ? iomap_dio_rw+0xa/0x30
> > > Oct 22 06:13:06 T7610 kernel: ? btrfs_file_read_iter+0x157/0x1c0 [btrfs]
> > > Oct 22 06:13:06 T7610 kernel: ? new_sync_read+0x118/0x1a0
> > > Oct 22 06:13:06 T7610 kernel: ? vfs_read+0xf1/0x190
> > > Oct 22 06:13:06 T7610 kernel: ? ksys_read+0x59/0xd0
> > > Oct 22 06:13:06 T7610 kernel: ? do_syscall_64+0x37/0x80
> > > Oct 22 06:13:06 T7610 kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >
> > >
> > > Call Trace 2:
> > > Oct 22 07:45:37 T7610 kernel: task:fsstress        state:R  running task     stack:    0 pid: 9584 ppid:     1 flags:0x00004006
> > > Oct 22 07:45:37 T7610 kernel: Call Trace:
> > > Oct 22 07:45:37 T7610 kernel: ? iomap_dio_complete+0x9e/0x140
> > > Oct 22 07:45:37 T7610 kernel: ? btrfs_file_read_iter+0x124/0x1c0 [btrfs]
> > > Oct 22 07:45:37 T7610 kernel: ? new_sync_read+0x118/0x1a0
> > > Oct 22 07:45:37 T7610 kernel: ? vfs_read+0xf1/0x190
> > > Oct 22 07:45:37 T7610 kernel: ? ksys_read+0x59/0xd0
> > > Oct 22 07:45:37 T7610 kernel: ? do_syscall_64+0x37/0x80
> > > Oct 22 07:45:37 T7610 kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >
> >
> > Are those the complete traces?
> > It looks like too little, and inexact (the prefix ?).
>
> Yes. these are complete traces.  I do not know the reason of 'the prefix ?'
>
> I run fstests/generic/475 2 times again.
> - failed to reproduce on SSD/SAS
> - sucessed to reproduce on SSD/NVMe
>
> Then I gathered 'sysrq -t' for 3 times.
>
> [  909.099550] task:fsstress        state:R  running task     stack:    0 pid: 9269 ppid:     1 flags:0x00004006
> [  909.100594] Call Trace:
> [  909.101633]  ? __clear_user+0x40/0x70
> [  909.102675]  ? lock_release+0x1c6/0x270
> [  909.103717]  ? alloc_extent_state+0xc1/0x190 [btrfs]
> [  909.104822]  ? fixup_exception+0x41/0x60
> [  909.105881]  ? rcu_read_lock_held_common+0xe/0x40
> [  909.106924]  ? rcu_read_lock_sched_held+0x23/0x80
> [  909.107947]  ? rcu_read_lock_sched_held+0x23/0x80
> [  909.108966]  ? slab_post_alloc_hook+0x50/0x340
> [  909.109993]  ? trace_hardirqs_on+0x1a/0xd0
> [  909.111039]  ? lock_extent_bits+0x64/0x90 [btrfs]
> [  909.112202]  ? __clear_extent_bit+0x37a/0x530 [btrfs]
> [  909.113366]  ? filemap_write_and_wait_range+0x87/0xd0
> [  909.114455]  ? clear_extent_bit+0x15/0x20 [btrfs]
> [  909.115628]  ? __iomap_dio_rw+0x284/0x830
> [  909.116741]  ? find_vma+0x32/0xb0
> [  909.117868]  ? __get_user_pages+0xba/0x740
> [  909.118971]  ? iomap_dio_rw+0xa/0x30
> [  909.120069]  ? btrfs_file_read_iter+0x157/0x1c0 [btrfs]
> [  909.121219]  ? new_sync_read+0x11b/0x1b0
> [  909.122301]  ? vfs_read+0xf7/0x190
> [  909.123373]  ? ksys_read+0x5f/0xe0
> [  909.124451]  ? do_syscall_64+0x37/0x80
> [  909.125556]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> [ 1066.293028] task:fsstress        state:R  running task     stack:    0 pid: 9269 ppid:     1 flags:0x00004006
> [ 1066.294069] Call Trace:
> [ 1066.295111]  ? btrfs_file_read_iter+0x157/0x1c0 [btrfs]
> [ 1066.296213]  ? new_sync_read+0x11b/0x1b0
> [ 1066.297268]  ? vfs_read+0xf7/0x190
> [ 1066.298314]  ? ksys_read+0x5f/0xe0
> [ 1066.299359]  ? do_syscall_64+0x37/0x80
> [ 1066.300394]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>
>
> [ 1201.027178] task:fsstress        state:R  running task     stack:    0 pid: 9269 ppid:     1 flags:0x00004006
> [ 1201.028233] Call Trace:
> [ 1201.029298]  ? iomap_dio_rw+0xa/0x30
> [ 1201.030352]  ? btrfs_file_read_iter+0x157/0x1c0 [btrfs]
> [ 1201.031465]  ? new_sync_read+0x11b/0x1b0
> [ 1201.032534]  ? vfs_read+0xf7/0x190
> [ 1201.033592]  ? ksys_read+0x5f/0xe0
> [ 1201.034633]  ? do_syscall_64+0x37/0x80
> [ 1201.035661]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> By the way, I enable ' -O no-holes -R free-space-tree' for mkfs.btrfs by
> default.

Those mkfs options/fs features should be irrelevant.

Can you try with the attached patch applied on top of those patches?

Thanks.

>
>
> > >
> > > We noticed some  error in dmesg before this infinite loop.
> > > [15590.720909] BTRFS: error (device dm-0) in __btrfs_free_extent:3069: errno=-5 IO failure
> > > [15590.723014] BTRFS info (device dm-0): forced readonly
> > > [15590.725115] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2150: errno=-5 IO failure
> >
> > Yes, that's expected, the test intentionally triggers simulated IO
> > failures, which can happen anywhere, not just when running delayed
> > references.
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/10/22
>
>

--00000000000049b1ac05cef0d8c7
Content-Type: text/x-patch; charset="US-ASCII"; name="foobar.patch"
Content-Disposition: attachment; filename="foobar.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kv2edhq20>
X-Attachment-Id: f_kv2edhq20

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2ZpbGUuYyBiL2ZzL2J0cmZzL2ZpbGUuYwppbmRleCA5MWE1
ZmE4MTRkNzUuLjE5ZmViNGNhYmI1NSAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvZmlsZS5jCisrKyBi
L2ZzL2J0cmZzL2ZpbGUuYwpAQCAtMzcxNiw2ICszNzE2LDcgQEAgc3RhdGljIGludCBjaGVja19k
aXJlY3RfcmVhZChzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywKIHN0YXRpYyBzc2l6ZV90
IGJ0cmZzX2RpcmVjdF9yZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICp0
bykKIHsKIAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmlsZV9pbm9kZShpb2NiLT5raV9maWxwKTsK
KwlzaXplX3QgcHJldl9sZWZ0ID0gMDsKIAlzc2l6ZV90IHJlYWQgPSAwOwogCXNzaXplX3QgcmV0
OwogCkBAIC0zNzUzLDE4ICszNzU0LDIzIEBAIHN0YXRpYyBzc2l6ZV90IGJ0cmZzX2RpcmVjdF9y
ZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICp0bykKIAkJcmVhZCA9IHJl
dDsKIAogCWlmIChpb3ZfaXRlcl9jb3VudCh0bykgPiAwICYmIChyZXQgPT0gLUVGQVVMVCB8fCBy
ZXQgPiAwKSkgeworCQljb25zdCBzaXplX3QgbGVmdCA9IGlvdl9pdGVyX2NvdW50KHRvKTsKKwog
CQkvKgogCQkgKiBXZSBoYXZlIG1vcmUgZGF0YSBsZWZ0IHRvIHJlYWQuIFRyeSB0byBmYXVsdCBp
biBhcyBtYW55IGFzCiAJCSAqIHBvc3NpYmxlIG9mIHRoZSByZW1haW5kZXIgcGFnZXMgYW5kIHJl
dHJ5LgotCQkgKgotCQkgKiBVbmxpa2UgZm9yIGRpcmVjdCBJTyB3cml0ZXMsIGluIGNhc2UgdGhl
IGlvdiByZWZlcnMgdG8gdGhlCi0JCSAqIGZpbGUgYW5kIHJhbmdlIHdlIGFyZSByZWFkaW5nIGZy
b20gKGR1ZSB0byBhIG1tYXApLCB3ZSBkb24ndAotCQkgKiBuZWVkIHRvIHdvcnJ5IGFib3V0IGFu
IGluZmluaXRlIGxvb3AgKHNlZSBidHJmc19kaXJlY3Rfd3JpdGUoKSkKLQkJICogYmVjYXVzZSBp
b21hcCBkb2VzIG5vdCBpbnZhbGlkYXRlIHBhZ2VzIGZvciByZWFkcywgb25seSBkb2VzCi0JCSAq
IGl0IGZvciB3cml0ZXMuCiAJCSAqLwotCQlmYXVsdF9pbl9pb3ZfaXRlcl93cml0ZWFibGUodG8s
IGlvdl9pdGVyX2NvdW50KHRvKSk7Ci0JCWdvdG8gYWdhaW47CisJCWlmIChwcmV2X2xlZnQgPT0g
MCB8fCBsZWZ0IDwgcHJldl9sZWZ0KSB7CisJCQlmYXVsdF9pbl9pb3ZfaXRlcl93cml0ZWFibGUo
dG8sIGxlZnQpOworCQkJcHJldl9sZWZ0ID0gbGVmdDsKKwkJCWdvdG8gYWdhaW47CisJCX0KKwkJ
LyoKKwkJICogSWYgd2UgZGlkbid0IG1ha2UgYW55IHByb2dyZXNzIHNpbmNlIHRoZSBsYXN0IGF0
dGVtcHQsIGZhbGxiYWNrCisJCSAqIHRvIGEgYnVmZmVyZWQgcmVhZCBmb3IgdGhlIHJlbWFpbmRl
ciBvZiB0aGUgcmFuZ2UuCisJCSAqIFRoaXMgaXMganVzdCB0byBhdm9pZCBhbnkgcG9zc2liaWxp
dHkgb2YgbG9vcGluZyBmb3IgdG9vIGxvbmcuCisJCSAqLworCQlyZXQgPSByZWFkOwogCX0KIAli
dHJmc19pbm9kZV91bmxvY2soaW5vZGUsIEJUUkZTX0lMT0NLX1NIQVJFRCk7CiAJcmV0dXJuIHJl
dCA8IDAgPyByZXQgOiByZWFkOwo=
--00000000000049b1ac05cef0d8c7--
