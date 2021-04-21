Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CE0366F90
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 17:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbhDUP6H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 11:58:07 -0400
Received: from out20-111.mail.aliyun.com ([115.124.20.111]:57558 "EHLO
        out20-111.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbhDUP6G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 11:58:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1221766|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.013079-7.70474e-05-0.986844;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.K1lWGjP_1619020651;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.K1lWGjP_1619020651)
          by smtp.aliyun-inc.com(10.147.42.22);
          Wed, 21 Apr 2021 23:57:31 +0800
Date:   Wed, 21 Apr 2021 23:57:34 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fdmanana@gmail.com
Subject: Re: 'ls /mnt/scratch/' freeze(deadlock?) when run xfstest(btrfs/232)
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <CAL3q7H6V+x_Pu=bxTFGsuZLHf2mh_DOcthJx7HCSYCL79rjzxw@mail.gmail.com>
References: <20210421201725.577C.409509F4@e16-tech.com> <CAL3q7H6V+x_Pu=bxTFGsuZLHf2mh_DOcthJx7HCSYCL79rjzxw@mail.gmail.com>
Message-Id: <20210421235733.9C11.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------_60804ACE000000009C0D_MULTIPART_MIXED_"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--------_60804ACE000000009C0D_MULTIPART_MIXED_
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

> That's the problem, qgroup flushing triggers writeback for an inode
> for which we have a page dirtied and locked.
> This should fix it:  https://pastebin.com/raw/U9GUZiEf
>=20
> Try it out and I'll write a changelog later.
> Thanks.

we run xfstest on two server with this patch.
one passed the tests.
but one got a btrfs/232 error.

btrfs/232 32s ... _check_btrfs_filesystem: filesystem on /dev/nvme0n1p1 is =
inconsistent
(see /usr/hpc-bio/xfstests/results//btrfs/232.full for details)
=2E..
[4/7] checking fs roots
root 5 inode 337 errors 400, nbytes wrong
ERROR: errors found in fs roots
=2E..

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/21


--------_60804ACE000000009C0D_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="232.full"
Content-Disposition: attachment;
 filename="232.full"
Content-Transfer-Encoding: base64

d3JvdGUgOTQzNzE4NDAwLzk0MzcxODQwMCBieXRlcyBhdCBvZmZzZXQgMAo5MDAgTWlCLCAyMzA0
MDAgb3BzOyAwLjU3NTggc2VjICgxLjUyNiBHaUIvc2VjIGFuZCA0MDAwNzYuNDAzNSBvcHMvc2Vj
KQpxdW90YSByZXNjYW4gc3RhcnRlZApfY2hlY2tfYnRyZnNfZmlsZXN5c3RlbTogZmlsZXN5c3Rl
bSBvbiAvZGV2L252bWUwbjFwMSBpcyBpbmNvbnNpc3RlbnQKKioqIGZzY2suYnRyZnMgb3V0cHV0
ICoqKgpbMS83XSBjaGVja2luZyByb290IGl0ZW1zClsyLzddIGNoZWNraW5nIGV4dGVudHMKWzMv
N10gY2hlY2tpbmcgZnJlZSBzcGFjZSB0cmVlCls0LzddIGNoZWNraW5nIGZzIHJvb3RzCnJvb3Qg
NSBpbm9kZSAzMzcgZXJyb3JzIDQwMCwgbmJ5dGVzIHdyb25nCkVSUk9SOiBlcnJvcnMgZm91bmQg
aW4gZnMgcm9vdHMKT3BlbmluZyBmaWxlc3lzdGVtIHRvIGNoZWNrLi4uCkNoZWNraW5nIGZpbGVz
eXN0ZW0gb24gL2Rldi9udm1lMG4xcDEKVVVJRDogN2QwYzEwNWMtYTcwOS00ZDMxLWI1ZTktMmY1
MjBhNWUyZjEzCmZvdW5kIDEzMjUwODA1NzYgYnl0ZXMgdXNlZCwgZXJyb3IocykgZm91bmQKdG90
YWwgY3N1bSBieXRlczogMTA5MTY2MAp0b3RhbCB0cmVlIGJ5dGVzOiA5OTEyMzIwCnRvdGFsIGZz
IHRyZWUgYnl0ZXM6IDc3MzMyNDgKdG90YWwgZXh0ZW50IHRyZWUgYnl0ZXM6IDQ1ODc1MgpidHJl
ZSBzcGFjZSB3YXN0ZSBieXRlczogNTM5NDk4NwpmaWxlIGRhdGEgYmxvY2tzIGFsbG9jYXRlZDog
MjAzMzk5NTc3NgogcmVmZXJlbmNlZCAxMzczNDY2NjI0CioqKiBlbmQgZnNjay5idHJmcyBvdXRw
dXQKKioqIG1vdW50IG91dHB1dCAqKioKc3lzZnMgb24gL3N5cyB0eXBlIHN5c2ZzIChydyxub3N1
aWQsbm9kZXYsbm9leGVjLHJlbGF0aW1lKQpwcm9jIG9uIC9wcm9jIHR5cGUgcHJvYyAocncsbm9z
dWlkLG5vZGV2LG5vZXhlYyxyZWxhdGltZSkKZGV2dG1wZnMgb24gL2RldiB0eXBlIGRldnRtcGZz
IChydyxub3N1aWQsc2l6ZT05ODk2Mzc1NmssbnJfaW5vZGVzPTI0NzQwOTM5LG1vZGU9NzU1LGlu
b2RlNjQpCnNlY3VyaXR5ZnMgb24gL3N5cy9rZXJuZWwvc2VjdXJpdHkgdHlwZSBzZWN1cml0eWZz
IChydyxub3N1aWQsbm9kZXYsbm9leGVjLHJlbGF0aW1lKQp0bXBmcyBvbiAvZGV2L3NobSB0eXBl
IHRtcGZzIChydyxub3N1aWQsbm9kZXYsaW5vZGU2NCkKZGV2cHRzIG9uIC9kZXYvcHRzIHR5cGUg
ZGV2cHRzIChydyxub3N1aWQsbm9leGVjLHJlbGF0aW1lLGdpZD01LG1vZGU9NjIwLHB0bXhtb2Rl
PTAwMCkKdG1wZnMgb24gL3J1biB0eXBlIHRtcGZzIChydyxub3N1aWQsbm9kZXYsbW9kZT03NTUs
aW5vZGU2NCkKdG1wZnMgb24gL3N5cy9mcy9jZ3JvdXAgdHlwZSB0bXBmcyAocm8sbm9zdWlkLG5v
ZGV2LG5vZXhlYyxtb2RlPTc1NSxpbm9kZTY0KQpjZ3JvdXAgb24gL3N5cy9mcy9jZ3JvdXAvc3lz
dGVtZCB0eXBlIGNncm91cCAocncsbm9zdWlkLG5vZGV2LG5vZXhlYyxyZWxhdGltZSx4YXR0cixy
ZWxlYXNlX2FnZW50PS91c3IvbGliL3N5c3RlbWQvc3lzdGVtZC1jZ3JvdXBzLWFnZW50LG5hbWU9
c3lzdGVtZCkKcHN0b3JlIG9uIC9zeXMvZnMvcHN0b3JlIHR5cGUgcHN0b3JlIChydyxub3N1aWQs
bm9kZXYsbm9leGVjLHJlbGF0aW1lKQpub25lIG9uIC9zeXMvZnMvYnBmIHR5cGUgYnBmIChydyxu
b3N1aWQsbm9kZXYsbm9leGVjLHJlbGF0aW1lLG1vZGU9NzAwKQpjZ3JvdXAgb24gL3N5cy9mcy9j
Z3JvdXAvZnJlZXplciB0eXBlIGNncm91cCAocncsbm9zdWlkLG5vZGV2LG5vZXhlYyxyZWxhdGlt
ZSxmcmVlemVyKQpjZ3JvdXAgb24gL3N5cy9mcy9jZ3JvdXAvcGVyZl9ldmVudCB0eXBlIGNncm91
cCAocncsbm9zdWlkLG5vZGV2LG5vZXhlYyxyZWxhdGltZSxwZXJmX2V2ZW50KQpjZ3JvdXAgb24g
L3N5cy9mcy9jZ3JvdXAvbmV0X2NscyxuZXRfcHJpbyB0eXBlIGNncm91cCAocncsbm9zdWlkLG5v
ZGV2LG5vZXhlYyxyZWxhdGltZSxuZXRfY2xzLG5ldF9wcmlvKQpjZ3JvdXAgb24gL3N5cy9mcy9j
Z3JvdXAvY3B1LGNwdWFjY3QgdHlwZSBjZ3JvdXAgKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVs
YXRpbWUsY3B1LGNwdWFjY3QpCmNncm91cCBvbiAvc3lzL2ZzL2Nncm91cC9waWRzIHR5cGUgY2dy
b3VwIChydyxub3N1aWQsbm9kZXYsbm9leGVjLHJlbGF0aW1lLHBpZHMpCmNncm91cCBvbiAvc3lz
L2ZzL2Nncm91cC9jcHVzZXQgdHlwZSBjZ3JvdXAgKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVs
YXRpbWUsY3B1c2V0KQpjZ3JvdXAgb24gL3N5cy9mcy9jZ3JvdXAvZGV2aWNlcyB0eXBlIGNncm91
cCAocncsbm9zdWlkLG5vZGV2LG5vZXhlYyxyZWxhdGltZSxkZXZpY2VzKQpjZ3JvdXAgb24gL3N5
cy9mcy9jZ3JvdXAvYmxraW8gdHlwZSBjZ3JvdXAgKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVs
YXRpbWUsYmxraW8pCmNncm91cCBvbiAvc3lzL2ZzL2Nncm91cC9yZG1hIHR5cGUgY2dyb3VwIChy
dyxub3N1aWQsbm9kZXYsbm9leGVjLHJlbGF0aW1lLHJkbWEpCmNncm91cCBvbiAvc3lzL2ZzL2Nn
cm91cC9tZW1vcnkgdHlwZSBjZ3JvdXAgKHJ3LG5vc3VpZCxub2Rldixub2V4ZWMscmVsYXRpbWUs
bWVtb3J5KQpjZ3JvdXAgb24gL3N5cy9mcy9jZ3JvdXAvaHVnZXRsYiB0eXBlIGNncm91cCAocncs
bm9zdWlkLG5vZGV2LG5vZXhlYyxyZWxhdGltZSxodWdldGxiKQpub25lIG9uIC9zeXMva2VybmVs
L3RyYWNpbmcgdHlwZSB0cmFjZWZzIChydyxyZWxhdGltZSkKY29uZmlnZnMgb24gL3N5cy9rZXJu
ZWwvY29uZmlnIHR5cGUgY29uZmlnZnMgKHJ3LHJlbGF0aW1lKQovZGV2L3NkYTEgb24gLyB0eXBl
IHhmcyAocncscmVsYXRpbWUsYXR0cjIsaW5vZGU2NCxsb2didWZzPTgsbG9nYnNpemU9MzJrLG5v
cXVvdGEpCnJwY19waXBlZnMgb24gL3Zhci9saWIvbmZzL3JwY19waXBlZnMgdHlwZSBycGNfcGlw
ZWZzIChydyxyZWxhdGltZSkKc3lzdGVtZC0xIG9uIC9wcm9jL3N5cy9mcy9iaW5mbXRfbWlzYyB0
eXBlIGF1dG9mcyAocncscmVsYXRpbWUsZmQ9MzcscGdycD0xLHRpbWVvdXQ9MCxtaW5wcm90bz01
LG1heHByb3RvPTUsZGlyZWN0LHBpcGVfaW5vPTUwNjUyKQptcXVldWUgb24gL2Rldi9tcXVldWUg
dHlwZSBtcXVldWUgKHJ3LHJlbGF0aW1lKQpkZWJ1Z2ZzIG9uIC9zeXMva2VybmVsL2RlYnVnIHR5
cGUgZGVidWdmcyAocncscmVsYXRpbWUpCmh1Z2V0bGJmcyBvbiAvZGV2L2h1Z2VwYWdlcyB0eXBl
IGh1Z2V0bGJmcyAocncscmVsYXRpbWUscGFnZXNpemU9Mk0pCm5mc2Qgb24gL3Byb2MvZnMvbmZz
ZCB0eXBlIG5mc2QgKHJ3LHJlbGF0aW1lKQovZGV2L3NkZzEgb24gL2FyY2hpdmUgdHlwZSBidHJm
cyAocncsbm9hdGltZSxzcGFjZV9jYWNoZT12MixzdWJ2b2xpZD01LHN1YnZvbD0vKQovZGV2L3Nk
ZzEgb24gL25vZGV0bXAgdHlwZSBidHJmcyAocncsbm9hdGltZSxzcGFjZV9jYWNoZT12MixzdWJ2
b2xpZD0yNTcsc3Vidm9sPS9ub2RldG1wKQp0bXBmcyBvbiAvcnVuL3VzZXIvMCB0eXBlIHRtcGZz
IChydyxub3N1aWQsbm9kZXYscmVsYXRpbWUsc2l6ZT0xOTgwMTk5NmssbW9kZT03MDAsaW5vZGU2
NCkKKioqIGVuZCBtb3VudCBvdXRwdXQK
--------_60804ACE000000009C0D_MULTIPART_MIXED_--

