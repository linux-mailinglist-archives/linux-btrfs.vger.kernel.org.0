Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A083A8EA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 04:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFPCDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 22:03:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:50399 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbhFPCDk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 22:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623808891;
        bh=cgqUb/mErSjiscGt3+LUM+itezwpCU/zC1jQVGcqXeA=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=ZTykCMQGr3JA5cdyrbXKR3sxiujR/pqHkf1PXjYCpvf9/2VUL2vnlrBJbb+X7PERv
         F/gE7MSiv682gqPss4TauTG3Q/ZJZjpS2L6W2bF/KVVsI2MAcmk8F5sEufy0OoG995
         HZs1VVjNRHfefcFsFWizweQejCHlMZWxziGOjGIU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QWA-1lxiaA19Wq-004SrV; Wed, 16
 Jun 2021 04:01:30 +0200
To:     "Karaliou, Aliaksei" <akaraliou@panasas.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     "Sinnamohideen, Shafeeq" <shafeeqs@panasas.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <CY4PR08MB3413C14165930B3080FA6D3EAD389@CY4PR08MB3413.namprd08.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Btrfs: Issues with remove-intensive workload
Message-ID: <cf4846f8-db45-a207-2ad7-c5b9613bda43@gmx.com>
Date:   Wed, 16 Jun 2021 10:01:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CY4PR08MB3413C14165930B3080FA6D3EAD389@CY4PR08MB3413.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hNouTlLtFiX2gopgyF2NabJwm7d0E0WWoTfuvVkJTTTjIF8tt+j
 qQAda12F4FG0C/ouK91lk8EEnd31wzvtJZMn3qWOx5aM7MIliIe1CgOHORUElQXjyNx2H/Y
 7XFSq4UcWxXgXBfF5ctiTe3fhfa3muj5d5IsTt5cdEiKyNc2QH7Z/Orc71glvF8UUx46b10
 IZrVFdh2KwfvJXtkHjVmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3rSIqqLQMVA=:4imMPMsWwVac85aIPOVqlH
 9XMOL4X8MF9P80uJ/2Ode78Pz7jX9vlQ8ufCXlfU6vKM3lm/aM2DR7Ua3rFKG2snfvGpH4Puw
 RNiJSWZ1worARDRgCh2WWUFLw6bwsOFIw9mfp6vzAa3lw2wlB9JOU/ZoDwvoi4AZQqf5WA/LY
 Di1G07e8WEZXd9kO3TtxXpXhRcla0otUqjzbVI3ikJ67O+boLlehZql9TgnU823Jsblq9bFZN
 NEKdkTnA8Jn5gUvbZwekEW6hEnkUuDwpWI9fHnrSXkv4Fv+ztBVC6MHU1VDgXsAzhalFufo3P
 m54KWHuNe0ohhONmud1kGWCTCNqsm5M1/8qbG8NZU9r3l7kCSg2Hl769ziHsA5VUU+oSz8wnQ
 +th1dYGFy5EvQyykImR18GIr8u+CXAv8WIJ4/0mwLgf4CDNIoLt+8iKFjxvPdJIxplnBoaSlf
 qiB/tlAq/QfBOg3dWmYttNPx+D1Qknjhh5dUQAODrwU7ogEEmZiX+ZFqdgDbBMoYMpwXPNlL4
 r7JjNlaW8FOVfYgJvdUwv7NSlOtyyY2BbpmMH8czSFdPsKVyOb5YKTTEeY1J7z4yWvAgJYI/6
 94P/M2pvhu3H+FGJJuV4Aqbd1nRHfZvomQTT+auGS9ngbsRCgnTQHVDqRfY0FnfLKhR64pVCJ
 qJJc9MSrl9tX3gmdDuCpj5MTQ8hnWHumhkM/nA/Iskz9JV35aAjDOjtkGaIs9YRE/xZfkLw56
 rnSwzvsnKJ38RBanOb+vmF3ZqUzmjjjId2SqdNJ+T7abQEcM8mx3ItoxY6rq/WoZ3SMpGeCdf
 hJ+AGYV4LIXkTzXNw3bmFpFmTV0ZOTJmJfCyd79G+2fKwwOOgPcYllghGoJ9gtTo/A6Di3KSP
 K1KN/Sp/YxWRjJI6/VNB6sJnRdt3ISRTTkoM7261hUSXckzDP+5KpiXeRQs26RlWgabNVwTq2
 N6ik7LHF2vdBqrqtoiQYJeSPvD0fzOIENWsss523Y3aOZI1OxXBK7/SHo+a3ZGLQNhCGlpT5K
 BTrfGPSbzJYpjgpw3tuezpKFcoMi6nXoNO2WutiuWGbFhztkn2GJOvZl6u4JVqSgQRXOlRLoh
 F5yJFHWsYj7jHw92W4GFzaefCatS5KQuMvmaEaXBkaW8/a4zjRWZQSu8Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/8 =E4=B8=8A=E5=8D=884:23, Karaliou, Aliaksei wrote:
> Hi,
>
> We have an issue with certain workloads and are looking for a hint regar=
ding what
> to do in our case. Maybe there are ways of improving this in BTRFS modul=
e,
> or there is a way for us to avoid certain behaviors.
>
> Issue:
> Occasionally, we have a pretty intensive delete-only workload with
> tens to hundreds of gigabytes of data being removed during a rather shor=
t period
> of time as the filesystem allows.

First thing first, even I hate to admit, btrfs has a much larger
metadata overhead compared to other fses.

We have csum, larger file extent structure, and mandatory metadata CoW,
so metadata performance is indeed worse compared to other fses.

> It's not 'rm -rf' of a tree but removes
> in different locations of directory hierarchy tree by individual request=
s.
> Also, in order to maintain consistency after possible power off/crash ev=
ents
> we fsync these directories with a few background threads relatively freq=
uently
> (period of sync is about 5 seconds).

Fsync is another point of pain of btrfs.

But in your case, I don't think fsync is really needed.

Btrfs maintains its metadata correctness by mandatory COW.
Meaning you either see old metadata (the file not yet deleted) or the
new metadata (file at least unlinked).

Thus I don't think the extra fsync is needed, and fsync itself is also
pretty heavy in btrfs, even with the log tree optimization.

Or do you mean, even seeing the older files are not acceptable in your
use case?

But anyway, your problem describe indeed seems to be a problem, we
should not block for so long time no matter whatever the operations are.

>
> After a few minutes under such load, those background fsyncs are getting=
 stuck
> for varying amounts of time. It might be 30 seconds, usually 200-600, bu=
t
> we've once seen over 13K seconds. Remove operations continue, but since
> fsyncs are required operations and we don't allow directories to be
> unsynced 'forever', we eventually block foreground operations in applica=
tion.
> After that we don't produce more removes and the transaction has a bette=
r
> chance to finish 'quickly'.
>
> Hardware: 6 HDDs merged into MDRAID 0 with 8M stripe.
> Mount options: relatime,space_cache=3Dv2.
>
> For testing we used files around 100-250M. They had different number of
> extents. Half of them had usually less than 4, but on average around 200=
-250.
> Files might be located in snapshots as well (so they have usually unmodi=
fied
> copies in other BTRFS subvolumes). There are several foreground threads
> which may perform some usual activity (search/modify database, etc.) the=
n
> remove a file from a tree. This seems similar to having an number of
> scripts each picks up a random file from random directory, remove it,
> then sleep fraction of a second, and then repeat.
>
> Before getting stuck or transaction commit begin, we deleted at a rate o=
f
> 300-400 files/s. After an hour, this degraded to an average of just
> 18 file/s.
>
> It seems that creating sparse files with similar average number of exten=
ts
> shows same behavior.
>
> Tests were conducted on OpenSUSE Leap:
>   * 15.0 (kernel-default-4.12.14-lp150.11.4 but btrfs is modified -
>     several patches from 15.1 applied)
>   * 15.2 (kernel-default-5.3.18-lp152.19.2)
>   * 15.0 with kernel updated to kernel-default-5.12.6-1.1.gfe25271
>
> Analysis with trace points added using 'perf' showed a few scenarios:
> A) Several fsync() calls are blocked on 'btrfs_run_delayed_refs(trans, 0=
)' in
>     btrfs_commit_transaction.
>     This issue seems to be fixed by
>       '[PATCH v5 2/8] btrfs: only let one thread pre-flush delayed refs =
in commit'
>     which was already applied to kernel-default-5.12.6-1.1.gfe25271 wher=
e most of tests
>     were conducted.
>
> B) When our background thread calls fsync() on a directory, its inode al=
ready has
>     BTRFS_INODE_NEEDS_FULL_SYNC flag set, unfortunately it was rare case=
 and we
>     didn't trace where it came from.
>     In this case we perform a real-world transaction commit and are doin=
g full
>     amount of delayed-refs job instead of btrfs-transaction kthread.
>
> C) btrfs-transaction kthread wakes up and works on committing current tr=
ansaction.
>     While it is on 'btrfs_run_delayed_refs(trans, 0)' stage everything d=
oesn't
>     seem to be so bad, but we are adding more delayed refs to be process=
ed
>     and this count is usually much more than initial triggering count th=
at this call
>     to btrfs_run_delayed_refs is going to take care of.
>     Then when we change transaction state to TRANS_STATE_COMMIT_START
>     fsync() threads are just stuck at wait_for_commit for a whole time.
>
> I think there might be other scenarios when we move away from pure-delet=
e
> workload, but I think these are enough.
>
> More or less happy scenario here is when btrfs-transaction kthread is in=
 charge
> of commit (it's sleep interval doesn't really makes difference - 30 or 5=
 seconds).
> But when one of our background fsync threads or foreground threads are i=
n charge
> that's a potential disaster because all delayed-refs job is going to blo=
ck
> this thread, especially foreground one.

I believe Josef has more experience on this delayed refs problem.
Adding him to CC.

>
> As I understand, this type of workload is rather extreme and
> current BTRFS design doesn't allow to for a way to split delayed-refs ha=
ndling
> across several transactions to allow more granular commits.
>
> Also, an open question for us is how snapshot delete is different in thi=
s case?

At least I can answer this.

For subvolume/snapshot deletion, we skip the whole tree balancing during
operations, and delete trees without balancing the tree itself (thus no
COW).

This reduce the amount of delayed ref, but can only work when no-one but
btrfs itself can modify the tree, thus it only works when the whole tree
is unlinked, thus can only happen in subvolume/snapshot deletion.

> Will we and when would we get stuck on fsync for snapshot deletion? Woul=
d it be
> as long?

Snapshot deletion can go across several transactions, thus I don't think
it could be a problem.

>
> I assume that snapshot delete is a bit more efficient operation since
> directories don't need to be updated and fsync'ed. Is this correct?

It's more or less correct.

For snapshot deletion, we no longer care about directories at all, all
we care are:
- Tree nodes
- Tree leaves
- Data extents

We just delete them, without CoW the tree blocks, thus only half of the
delayed refs are generated, furthermore subvolume deletion can go across
several transactions, unlike unlink which must happen in one go.

> I once conducted a test of removing several huge files manually vs remov=
ing
> them as a subvolume. It seem faster to delete as a subvolume.
>
> I expected some throttling in BTRFS when deleting files with many extent=
s,
> but I don't see such behavior (and of course there might be delete of so=
me 50G file
> eventually, which is VM image and super-sparse - it will have zillion ex=
tents
> and throttling applied only to this delete will not help).
> Maybe there is something that might be improved within BTRFS internals?
>
> We must delete files, but we potentially may delay this operation by jus=
t
> moving them to a 'trashbin' directory, then deleting slowly.

In fact, btrfs is already delaying the deletion.

When we delete a file, we just unlink it and mark it as orphan.
This part will happen in current transaction, then later deletion of the
file extents and its csum will happen in later transactions.

But even unlinking just one inode, will make us to CoW the tree, and
generate some delayed refs.
When this accumulates, it's quite a lot.

Moving it to trash bin is even worse IMHO.
Moving the inodes means we need to unlink and link, double the workload
than just unlink.
And you still need to unlink anyway, thus I don't think it's really
worthy though.

Thanks,
Qu

> But even in this case we would need to have extra information so we can =
throttle this
> well enough so that the next fsync will not take minutes (less than 30 s=
econds would be ideal).
> To my understanding, there is no such feedback mechanism that we can use=
.
> The only indicator for us is file size and number of extents that we may=
 obtain via FIEMAP.
>
> An additional complication are snapshots that might be taken when we sti=
ll have a bunch
> of files sitting in this 'trashbin' directory waiting for our background=
 deletion - at least
> from metadata side that means increased amount of work with each snapsho=
t created.
>
> As an option we considered usage of reflink ioctl to first move portions
> of file (depending extents count) to some huge file located in different
> volume (on the same device of course), then delete it if that makes
> internal operations faster, but that definitely adds cost of reflink.
>
> Any advice or comments on this issue and my thoughts on mitigations
> would be much appreciated.
>
> Best regards,
>    Aliaksei
>
