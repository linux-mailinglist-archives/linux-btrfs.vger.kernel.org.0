Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70847115C4B
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2019 14:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfLGND5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Dec 2019 08:03:57 -0500
Received: from ms11p00im-qufo17281601.me.com ([17.58.38.53]:38615 "EHLO
        ms11p00im-qufo17281601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbfLGND5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Dec 2019 08:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1575723833;
        bh=Xat+yFqYqYiQcqoqK/4H+7JBg6oGHzrKokKTB4M6Ik8=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=eaerJpNelAWaQatYOxcbjxZmoKEhJJNA+7dxPHWpBRwSZtuY2T0YNXVMczaWY5tM6
         ywffivfXWzFyx9TvtJergs4J3pvk5XlcKMcifMw1l9bwJuhF+Fmb746o9foyYIvfaA
         5fsIyNTI555kNUdhnFJmTseFWoBOLCx8KQiOxgg1dobrxGvtc8mTzdjuHRxndDY/FU
         tDiV2V8fLYuGUi5fLrlvRoH/y7UW8QFfVtjlUYOqdsq4HTKPcwhAMk1IpFf2jeyHYY
         fAgoWq9xBNsT93a0rXXkLYmap5OI8qGRvBy40zjFazUwURok0nH471YWSsWrK1n6wB
         UrC9HzsfF9OGg==
Received: from [192.168.15.24] (unknown [177.27.216.49])
        by ms11p00im-qufo17281601.me.com (Postfix) with ESMTPSA id 05F4DBE0640;
        Sat,  7 Dec 2019 13:03:52 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] btrfs-progs: Skip device tree when we failed to read it
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
Date:   Sat, 7 Dec 2019 10:03:50 -0300
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF872461-4D5F-4125-85E6-719A42F5BD0F@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912070112
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry for the repeated post, I am trying to pass the mail server...

Hi Qui,=20

I tried what you said and I got at least some very small files out of =
the device!

Yes, I have sub volumes/snapshots.

There should be a subvolume called =E2=80=9Cprojects=E2=80=9D which I am =
interested in.
Inside this subvolume should be lots of snapshots.

Any chance to recover one of them?

Here the output of the restore command that you suggested:

# ./btrfs restore -l /dev/sdb1=20
checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, =
have=3D14275350892879035392
WARNING: could not setup device tree, skipping it
 tree key (EXTENT_TREE ROOT_ITEM 0) 641515520 level 2
 tree key (DEV_TREE ROOT_ITEM 0) 5349895454720 level 1
 tree key (FS_TREE ROOT_ITEM 0) 653901824 level 1
 tree key (CSUM_TREE ROOT_ITEM 0) 658161664 level 3
 tree key (UUID_TREE ROOT_ITEM 0) 657014784 level 0
 tree key (315 ROOT_ITEM 0) 637386752 level 1
checksum verify failed on 3542131507200 found 0000008C wanted 00000000
checksum verify failed on 3542131507200 found 000000F5 wanted 00000000
checksum verify failed on 3542131507200 found 0000008C wanted 00000000
bad tree block 3542131507200, bytenr mismatch, want=3D3542131507200, =
have=3D14275350892879035392

And I tried:

# ./btrfs restore -r 315 -v -D /dev/sdb1 test/
checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
checksum verify failed on 5349895454720 found 000000A8 wanted 00000000
bad tree block 5349895454720, bytenr mismatch, want=3D5349895454720, =
have=3D14275350892879035392
WARNING: could not setup device tree, skipping it
This is a dry-run, no files are going to be restored
Restoring test/1
Skipping snapshot snapshot
Skipping existing file test/1/info.xml
If you wish to overwrite use -o
Done searching /1
Restoring test/4
Skipping snapshot snapshot
Skipping existing file test/4/info.xml
Done searching /4
Restoring test/28
Skipping snapshot snapshot
Skipping existing file test/28/info.xml
Done searching /28
Restoring test/52
checksum verify failed on 3305202188288 found 0000009E wanted FFFFFFA9
checksum verify failed on 3305202188288 found 000000FA wanted 00000000
checksum verify failed on 3305202188288 found 0000009E wanted FFFFFFA9
bad tree block 3305202188288, bytenr mismatch, want=3D3305202188288, =
have=3D18446556327804403584
Error reading subvolume test/52/snapshot: 18446744073709551611
Error searching test/52/snapshot


Well, I got the very small files info.xml.
How can I get the rest? Any ideas?

Thanks a lot for your help,



Chris



