Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 487B0118CD6
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 16:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfLJPnI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 10:43:08 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39923 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfLJPnH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 10:43:07 -0500
Received: by mail-vs1-f65.google.com with SMTP id p21so13374694vsq.6
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2019 07:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=lM5OThc/fDiKe9r7ZCis6PysuvmVMCs/dRyqaRr1jOc=;
        b=lZ6oYzdbFHYJV0mEX9Zag8Ok1gRWgDfaCyJGbaLtYp+ery7LwhEbSiON9Z7Os5ACdq
         YtZkR2l5Pw1gvhVcmjmXTvcV2CkB8nTregENj0zBQ7G8q67zI6jbwgp/r7ZjT8eUOa86
         /9RiwYvJGOD0+rqGGqx7ty49j/mUVHgw4c0UazHBhUwLfSBHWnddJrGjmIPLdgccrysa
         lxr52Y8iMa518R8haExEQvVg9ZLSGrsBRZd53yZZxeICrIyaxXQtuUoehxZTxWtEVrRd
         5UEAgDsMfLi0Dm512L/UodwPV52V+5xihZrSakpD4bw2kpZC+qSIMcus4FCQg+JX+iNq
         fOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=lM5OThc/fDiKe9r7ZCis6PysuvmVMCs/dRyqaRr1jOc=;
        b=ULoqWdbkpKhufY2zrNl9289YVmAfZ0CfNHkNjczRI7Z/ORhfF75DNmLPn9aKnkCxCS
         T6nNDjYZy40kqU9LKVAgPtGOR2y8BpqVVXzozPoTFriAg3FSXPbCZ4kfWbvqOPde7GGu
         wj38cFgPmyw0yNmve6tTMCiZKVyz9iot1sxm82/RPi7H/grgLTzX6IZhVU73lH6OKsz0
         hwrpDRLBfFjl6Mt4tcAP/FnaCFXMRfGag97kyGja/3WRri+asaDaoQEho9kjD5pVjlMV
         aGxilx/660jxQZY8hDq7RveM+0quwKpoBgZVNNAxC3K70I4ZVbdW/1FMoNvGjIwrGH6r
         Sy5g==
X-Gm-Message-State: APjAAAWQU7+UbOLzZnyfNfC1fMin/lMXx2VVspAblRstJ4ofNZlVuLz/
        pkD3wKqeuZNlDZf5DJZMjl/Jqms08eGNQF11pTY=
X-Google-Smtp-Source: APXvYqzX0WOIkWvNoIpX1L/lAGffs/Yg52fDduqTNbAkuQBbD3UrauIePaAj7OFBTh0tV6G1TtXOgQGGho2xwfYNx3o=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr24976588vsq.206.1575992586172;
 Tue, 10 Dec 2019 07:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20190628022611.2844-1-anand.jain@oracle.com> <20190703132158.GV20977@twin.jikos.cz>
 <e2ab1be9-8b83-987f-0d88-c1f5547060d4@oracle.com> <51c42306-b4ae-a243-ac96-fb3acb1a317c@oracle.com>
 <20190902162230.GY2752@twin.jikos.cz> <20190903120603.GB2752@twin.jikos.cz> <20190912175402.GM2850@twin.jikos.cz>
In-Reply-To: <20190912175402.GM2850@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 10 Dec 2019 15:42:54 +0000
Message-ID: <CAL3q7H7nbp_kmeEZpRL7KpwhXSA6=QCcwzXT-f0szrwRmW-ohw@mail.gmail.com>
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 10:39 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Sep 03, 2019 at 02:06:03PM +0200, David Sterba wrote:
> > On Mon, Sep 02, 2019 at 06:22:30PM +0200, David Sterba wrote:
> > > On Mon, Sep 02, 2019 at 04:01:56PM +0800, Anand Jain wrote:
> > > >
> > > > David,
> > > >
> > > >   I don't see this patch is integrated. Can you please integrated t=
his
> > > > patch thanks.
> > >
> > > I don't know why but the patch got lost somewhere, adding to devel
> > > again.
> >
> > Not lost, but dropped, misc-tests/021 fails. So dropped again, please
> > fix it and test before posting again. Thanks.
>
> With the test misc/021 updated, this patch has been added to devel.
> Thanks.

So having updated my local btrfs-progs from v5.2.2 to 5.4, I started
getting 4 test cases from fstests failing:

root 15:35:09 /home/fdmanana/git/hub/xfstests (master)> ./check
btrfs/142 btrfs/143 btrfs/157 btrfs/158
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian6 5.4.0-rc8-btrfs-next-51 #1 SMP
PREEMPT Wed Nov 27 10:19:33 WET 2019
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1

btrfs/142 1s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad)
    --- tests/btrfs/142.out 2018-09-16 21:30:48.505104287 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad
2019-12-10 15:35:40.280392626 +0000
    @@ -3,37 +3,37 @@
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
     wrote 65536/65536 bytes
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/142.out
/home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad'  to see
the entire diff)
btrfs/143 2s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad)
    --- tests/btrfs/143.out 2018-09-16 21:30:48.505104287 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad
2019-12-10 15:35:41.740391311 +0000
    @@ -3,37 +3,37 @@
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
     wrote 65536/65536 bytes
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/143.out
/home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad'  to see
the entire diff)
btrfs/157 1s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/157.out.bad)
    --- tests/btrfs/157.out 2018-09-16 21:30:48.505104287 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/157.out.bad
2019-12-10 15:35:43.112390076 +0000
    @@ -1,9 +1,9 @@
     QA output created by 157
     wrote 131072/131072 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 65536/65536 bytes at offset 9437184
    +wrote 65536/65536 bytes at offset 22020096
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 65536/65536 bytes at offset 9437184
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/157.out
/home/fdmanana/git/hub/xfstests/results//btrfs/157.out.bad'  to see
the entire diff)
btrfs/158 2s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/158.out.bad)
    --- tests/btrfs/158.out 2018-09-16 21:30:48.505104287 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/158.out.bad
2019-12-10 15:35:44.844388521 +0000
    @@ -1,9 +1,9 @@
     QA output created by 158
     wrote 131072/131072 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 65536/65536 bytes at offset 9437184
    +wrote 65536/65536 bytes at offset 22020096
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 65536/65536 bytes at offset 9437184
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/158.out
/home/fdmanana/git/hub/xfstests/results//btrfs/158.out.bad'  to see
the entire diff)
Ran: btrfs/142 btrfs/143 btrfs/157 btrfs/158
Failures: btrfs/142 btrfs/143 btrfs/157 btrfs/158
Failed 4 of 4 tests

A git bisect points to this patch:

fdmanana 15:38:37 ~/git/hub/btrfs-progs ((c501c9e3...)|BISECTING)> git
bisect log
git bisect start
# bad: [f82e569b33c3c1cfd4f8f405085ff8d439a0a915] Btrfs progs v5.3.1
git bisect bad f82e569b33c3c1cfd4f8f405085ff8d439a0a915
# good: [55a8c9626fb906c20c3206f8fd39b9a8fb259b79] Btrfs progs v5.2.2
git bisect good 55a8c9626fb906c20c3206f8fd39b9a8fb259b79
# bad: [a38eb3d4265873aa0dc55d1f9f2f1d7667a06b3c] btrfs-progs: add
checksum type to checksumming functions
git bisect bad a38eb3d4265873aa0dc55d1f9f2f1d7667a06b3c
# good: [b74d0dffb11c929c88e8ce7805f7aa6b370522b5] btrfs-progs:
qgroups: use parse_size instead of open coding it
git bisect good b74d0dffb11c929c88e8ce7805f7aa6b370522b5
# good: [3de68a0e8704869e72910b1a06e2e71692015e7b] btrfs-progs: tests:
fix misc/021 when restoring overlapping stale data
git bisect good 3de68a0e8704869e72910b1a06e2e71692015e7b
# bad: [779ada6edd81c520fd0acf61be14fc8669b00f79] btrfs-progs: make
checksum type explicit in mkfs context structure
git bisect bad 779ada6edd81c520fd0acf61be14fc8669b00f79
# bad: [669f56177550375713398aa22dfa817547df5566] btrfs-progs: docs:
use docbook5 backend for asciidoctor
git bisect bad 669f56177550375713398aa22dfa817547df5566
# bad: [c501c9e3b8164657e9210a701e0e0b75061e9d3b] btrfs-progs: mkfs:
match devid order to the stripe index
git bisect bad c501c9e3b8164657e9210a701e0e0b75061e9d3b
# first bad commit: [c501c9e3b8164657e9210a701e0e0b75061e9d3b]
btrfs-progs: mkfs: match devid order to the stripe index
fdmanana 15:38:40 ~/git/hub/btrfs-progs ((c501c9e3...)|BISECTING)>

Am I the only one getting this? It's been a while and I can't have
been the only one running fstests with progs 5.3+.
Is there any fix around for btrfs-progs I missed in mailing list (with
devel branch the tests fail as well), or a plan to update the tests?

thanks


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
