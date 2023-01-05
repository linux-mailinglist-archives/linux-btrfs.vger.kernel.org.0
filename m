Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A0D65E8A9
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 11:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjAEKKy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 05:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjAEKKw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 05:10:52 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0FCBEC
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 02:10:48 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 060CB240489
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 11:10:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1672913447; bh=8GrFqHG19hVRA/7C2w7puW5WgFq722+fz+XilxRuxqc=;
        h=Date:Subject:To:Cc:From:From;
        b=sMpx6VlAA9E0MW79XxNxual9YWjf96/vCAFBrzQb9glINSglLRCkPFMcCwl4oy7iR
         V7DFWRC/l6H+wAZhKB+zgv/fHGww8+BP8RaJBu5fx5nv/4WzqjYaRWC3IrebpJzPxp
         sTVnlJs99hKN6DdR3eDEwnqeDNHh7bJs6+ImdYfi7MxvVbXuG9ON+viNikbn1IP0Rw
         VVNHUFZ2J0RS2+S0Ll1iJJTWJNa15r0TW34rqDD1kFQSC94aNpxH2CFgko5V9j6Obl
         3bj7dhv/hPTk6xJI3SdvMZd64uzfwibGsFykM80Ge2e5BMAr38CENDCZ84cq3dsxiv
         LZbLOOvhJDPtg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Nnj0Q4PgWz6tmG;
        Thu,  5 Jan 2023 11:10:46 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------aE0nPciFnXP4b7Z63cZrBEDP"
Message-ID: <0ee56d23-9a3d-08ea-a303-e995c99d3f43@posteo.de>
Date:   Thu,  5 Jan 2023 10:10:46 +0000
MIME-Version: 1.0
Subject: Re: btrfs send and receive showing errors
Content-Language: de-DE
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <b732e1e7-7b3a-cfa7-1345-d39feaa6a7a8@posteo.de>
 <CAL3q7H72Z7v038psf9rPSjfWn96WDbxpbRx_73HAPvzzV4SB8g@mail.gmail.com>
From:   =?UTF-8?Q?Randy_N=c3=bcrnberger?= <ranuberger@posteo.de>
In-Reply-To: <CAL3q7H72Z7v038psf9rPSjfWn96WDbxpbRx_73HAPvzzV4SB8g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------aE0nPciFnXP4b7Z63cZrBEDP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, Jan 4, 2023 at 14:41, Filipe Manana wrote:
> On Wed, Jan 4, 2023 at 1:05 PM Randy Nürnberger <ranuberger@posteo.de> wrote:
>> Hello,
>>
>> I’m in the process of copying a btrfs filesystem (a couple years old)
>> from one disk to another by using btrfs send and receive on all
>> snapshots. The snapshots were created by a tool every hour on the hour
>> as one backup measure and automatically removed as they became older.
>>
>> I got errors like the following and when I compare the copied snapshots
>> with the originals, some files are missing:
>>
>> ERROR: unlink █████ failed: No such file or directory
>> ERROR: link █████ -> █████ failed: No such file or directory
>> ERROR: utimes █████ failed: No such file or directory
>> ERROR: rmdir █████ failed: No such file or directory
>>
>> Is this a known bug and how can I help diagnosing and fixing this?
> So this is a problem caused by the sender issuing commands with outdated paths.
>
> First, try doing the send operation again with a 6.1 kernel - there
> was at least one fix here that may be relevant.

I tried again with the following kernel version and still got the same 
errors:
Linux arktos 6.1.0-0-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.2-1~exp1 
(2023-01-01) x86_64 GNU/Linux

>
> To actual debug things, in case it's not working with 6.1:
>
> 1) Show how you invoked send and receive. I.e. the full command lines
> for 'btrfs send ...' and 'btrfs receive ...'

Those are my full command lines:

btrfs send -p /mnt/randy/randy-snapshots/2022-01-29--07-00 
/mnt/randy/randy-snapshots/2022-02-27--10-00 | btrfs receive -vvv 
/mnt/intern/randy-snapshots/ 2>receive-1.txt

btrfs send -p /mnt/randy/randy-snapshots/2022-02-27--10-00 
/mnt/randy/randy-snapshots/2022-03-26--07-00 | btrfs receive -vvv 
/mnt/intern/randy-snapshots/ 2>receive-2.txt

>
> 2) Provide the whole output of 'btrfs receive' with the -vvv command
> line option.
>      This will reveal all path names, but it's necessary to debug things.
>      You've hidden path names above, so I suppose that's not acceptable for you.

At least I’m not comfortable sharing the file names on this public 
mailing list. I carefully tried to extract and redact what may be the 
relevant parts.

The second command line above is the first one that fails with the 
following error: “ERROR: unlink Hase/Fuchs/2022-02-23 Reh.odt failed: No 
such file or directory”.

This is the directory listing for the snapshot before said file was 
created (this snapshot can be copied without errors):

root@arktos /m/r/randy-snapshots# ls -alh 2022-01-29--07-00/Hase/Fuchs/
insgesamt 2,6M
drwxrws--- 1 randy randy  136 19. Dez 2021   ./
drwxrws--- 1 randy randy  134 24. Nov 2021   ../
-rw-rw---- 1 randy randy  38K  5. Mai 2021  '2021-05-01 Igel.odt'
-rw-rw---- 1 randy randy  16K 30. Sep 2021  '2021-09-30 Wolf.odt'
-rw-rw---- 1 randy randy 2,6M 19. Dez 2021  '2021-12-19 Wildschwein.pdf'

This is the directory listing for the snapshot after the file has been 
created (this snapshot can be copied without errors):

root@arktos /m/r/randy-snapshots# ls -alh 2022-02-27--10-00/Hase/Fuchs/
insgesamt 2,7M
drwxrws---  1 randy randy  178 27. Feb 2022   ./
drwxrws---  1 randy randy  134 24. Nov 2021   ../
-rw-rw----  1 randy randy  38K  5. Mai 2021  '2021-05-01 Igel.odt'
-rw-rw----  1 randy randy  16K 30. Sep 2021  '2021-09-30 Wolf.odt'
-rw-rw----  1 randy randy 2,6M 19. Dez 2021  '2021-12-19 Wildschwein.pdf'
-rw-rwx---+ 1 randy randy  42K 26. Feb 2022  '2022-02-23 Reh.odt'*

This is the directory listing for the snapshot after the file has been 
edited in LibreOffice and *renamed* (trying to copy this one fails):

root@arktos /m/r/randy-snapshots# ls -alh 2022-03-26--07-00/Hase/Fuchs/
insgesamt 2,6M
drwxrws--- 1 randy randy  178  5. Mär 2022   ./
drwxrws--- 1 randy randy  134 24. Nov 2021   ../
-rw-rw---- 1 randy randy  38K  5. Mai 2021  '2021-05-01 Igel.odt'
-rw-rw---- 1 randy randy  16K 30. Sep 2021  '2021-09-30 Wolf.odt'
-rw-rw---- 1 randy randy 2,6M 19. Dez 2021  '2021-12-19 Wildschwein.pdf'
-rw-rw---- 1 randy randy  18K  4. Mär 2022  '2022-03-03 Reh.odt'

I’ve attached the outputs of the commands above. Apparently ‘btrfs send’ 
instructs ‘btrfs receive’ to unlink the file ‘Hase/Fuchs/2022-02-23 
Reh.odt’ which *does* exist in the copied snapshot ‘2022-02-27--10-00’ 
and this fails for whatever reason.

# sha256sum 
/mnt/randy/randy-snapshots/2022-02-27--10-00/Hase/Fuchs/2022-02-23\ Reh.odt
09ab560f8e2d79e61d253550eda5f388aceddb1b51792e01e589e86a53cdd226

# sha256sum 
/mnt/intern/randy-snapshots/2022-02-27--10-00/Hase/Fuchs/2022-02-23\ 
Reh.odt
09ab560f8e2d79e61d253550eda5f388aceddb1b51792e01e589e86a53cdd226

>
> Thanks.
>
>>
>> # uname -a  # this is the kernel on which this originally happend
>> Linux arktos 5.10.0-20-amd64 #1 SMP Debian 5.10.158-2 (2022-12-13)
>> x86_64 GNU/Linux
>>
>>
>> # uname -a  # I already retried everything on the latest Debian
>> backports kernel with the same results
>> Linux arktos 6.0.0-0.deb11.6-amd64 #1 SMP PREEMPT_DYNAMIC Debian
>> 6.0.12-1~bpo11+1 (2022-12-19) x86_64 GNU/Linux
>>
>> # btrfs --version
>> btrfs-progs v5.10.1
>>
>> # btrfs fi sh /mnt/randy  # this is the source
>> Label: none  uuid: 84bba855-578d-48db-80eb-49f1029c7543
>>           Total devices 2 FS bytes used 2.04TiB
>>           devid    1 size 4.00TiB used 2.05TiB path /dev/mapper/randy_1_crypt
>>           devid    2 size 4.00TiB used 2.05TiB path /dev/mapper/randy_2_crypt
>>
>> # btrfs fi df /mnt/randy
>> Data, RAID1: total=2.02TiB, used=2.02TiB
>> System, RAID1: total=8.00MiB, used=320.00KiB
>> Metadata, RAID1: total=25.00GiB, used=22.99GiB
>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>
>>
>> # btrfs fi sh /mnt/intern  # this is the target
>> Label: none  uuid: ebb94498-644c-42cd-892f-37886173523c
>>           Total devices 2 FS bytes used 1.91TiB
>>           devid    1 size 8.00TiB used 1.91TiB path
>> /dev/mapper/vg_arktos_hdd_b-lv_randy_1
>>           devid    2 size 8.00TiB used 1.91TiB path
>> /dev/mapper/vg_arktos_hdd_b-lv_randy_2
>>
>> # btrfs fi df /mnt/intern
>> Data, RAID1: total=1.89TiB, used=1.89TiB
>> System, RAID1: total=8.00MiB, used=288.00KiB
>> Metadata, RAID1: total=21.00GiB, used=20.76GiB
>> GlobalReserve, single: total=512.00MiB, used=0.00B

--------------aE0nPciFnXP4b7Z63cZrBEDP
Content-Type: text/plain; charset=UTF-8; name="receive-1-redacted.txt"
Content-Disposition: attachment; filename="receive-1-redacted.txt"
Content-Transfer-Encoding: base64

cmVjZWl2aW5nIHNuYXBzaG90IDIwMjItMDItMjctLTEwLTAwIHV1aWQ9NWI5OGU4MWUtMGU5
Yi04MTRhLWIxOTEtMTlmZTM2NTE3ZDFjLCBjdHJhbnNpZD0xMDYwIHBhcmVudF91dWlkPTVi
OThlODFlLTBlOWItODE0YS1iMTkxLTE5ZmUzNjUxN2QxYywgcGFyZW50X2N0cmFuc2lkPTgx
MApb4oCmXQp1dGltZXMgSGFzZS9GdWNocwpb4oCmXQpta2ZpbGUgbzE1MjU2MDQtMTAxNC0w
CnJlbmFtZSBvMTUyNTYwNC0xMDE0LTAgLT4gSGFzZS9GdWNocy8yMDIyLTAyLTIzIFJlaC5v
ZHQKdXRpbWVzIEhhc2UvRnVjaHMKc2V0X3hhdHRyIEhhc2UvRnVjaHMvMjAyMi0wMi0yMyBS
ZWgub2R0IC0gbmFtZT1zeXN0ZW0ucG9zaXhfYWNsX2FjY2VzcyBkYXRhX2xlbj01MiBkYXRh
PQIKc2V0X3hhdHRyIEhhc2UvRnVjaHMvMjAyMi0wMi0yMyBSZWgub2R0IC0gbmFtZT11c2Vy
LkRPU0FUVFJJQiBkYXRhX2xlbj0zMiBkYXRhPQp3cml0ZSBIYXNlL0Z1Y2hzLzIwMjItMDIt
MjMgUmVoLm9kdCAtIG9mZnNldD0wIGxlbmd0aD00MjE4NApjaG93biBIYXNlL0Z1Y2hzLzIw
MjItMDItMjMgUmVoLm9kdCAtIHVpZD0zMDAwLCBnaWQ9MzAwMApjaG1vZCBIYXNlL0Z1Y2hz
LzIwMjItMDItMjMgUmVoLm9kdCAtIG1vZGU9MDY3MAp1dGltZXMgSGFzZS9GdWNocy8yMDIy
LTAyLTIzIFJlaC5vZHQKQlRSRlNfSU9DX1NFVF9SRUNFSVZFRF9TVUJWT0wgdXVpZD01Yjk4
ZTgxZS0wZTliLTgxNGEtYjE5MS0xOWZlMzY1MTdkMWMsIHN0cmFuc2lkPTEwNjAK
--------------aE0nPciFnXP4b7Z63cZrBEDP
Content-Type: text/plain; charset=UTF-8; name="receive-2-redacted.txt"
Content-Disposition: attachment; filename="receive-2-redacted.txt"
Content-Transfer-Encoding: base64

cmVjZWl2aW5nIHNuYXBzaG90IDIwMjItMDMtMjYtLTA3LTAwIHV1aWQ9NWI5OGU4MWUtMGU5
Yi04MTRhLWIxOTEtMTlmZTM2NTE3ZDFjLCBjdHJhbnNpZD0xNDExIHBhcmVudF91dWlkPTVi
OThlODFlLTBlOWItODE0YS1iMTkxLTE5ZmUzNjUxN2QxYywgcGFyZW50X2N0cmFuc2lkPTEw
NjAKW+KApl0KdXRpbWVzIEhhc2UvRnVjaHMKW+KApl0KdW5saW5rIEhhc2UvRnVjaHMvMjAy
Mi0wMi0yMyBSZWgub2R0CkVSUk9SOiB1bmxpbmsgSGFzZS9GdWNocy8yMDIyLTAyLTIzIFJl
aC5vZHQgZmFpbGVkOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5Cg==

--------------aE0nPciFnXP4b7Z63cZrBEDP--
