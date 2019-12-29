Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8E012C28E
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2019 14:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfL2NkU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 08:40:20 -0500
Received: from mout.web.de ([212.227.17.12]:45059 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfL2NkU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 08:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577626818;
        bh=HmsMo5gZgnIWC3sMopkilaKfg8anKUw2PWQwd/zAgLo=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=hJ4vgoPbUGSKO6z7J1irSuMmrlhwZqoycEMbxzxclfHfJqHbc1y+KD0yD/lWUGq/e
         GY1TnJGZ4jfrafV2JStTJC1tII7xw98QFMf3Qo08ylnVfsqGCe5ju+LFVO3Iz9p2Ui
         pfOY/K+JZhIkbXymjLdjxiNluzL+kMdwDpicWzss=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.0.16] ([80.142.201.69]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOAnY-1ir4aM2Pa8-005aCJ for
 <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 14:40:18 +0100
To:     linux-btrfs@vger.kernel.org
From:   Matthias Neuer <mneuer@web.de>
Subject: invalid root item size
Message-ID: <19acbd39-475f-bd72-e280-5f6c6496035c@web.de>
Date:   Sun, 29 Dec 2019 14:40:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-LU
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1+9Ru6ql+Y9rSUvoyNXkHqWs+D2rzwGm3bI6+kJ4QmkashJwm6M
 WksEX5vVbrkCvgXiJYgigTgyYekqo4CPtDdU1QZCIO1ZBPtBI0EifEBq/Gq6ivxoAoINkyy
 v1PtS5DfkH6vk6YVo4gmTWjemvLjHZawPsihzBhikCCqvoPBXk+6UZmzie7eqjQu+rKsNdn
 1IjLyPWyPYf6wwRroAYXw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hp8oq40/IUw=:ma2BD/mOwJjGp/RD3AV3j7
 7KRWnhtXH10OZ6th3Xa9oGa9bSMHFrJxQ9yQsX2p0Z7RIo5J1TyuG9yqbhwvhD5i0+oxOOTCA
 fbFVE6FtyRGQCNuige3q8A6G3tFZr/dTErDuwwrIMKj2/5igRudxX7QLB59Vz58mHD5qF9z+M
 9D4Jx3wVKIXXJFyTAPMuXTnCpzJKCgGCQrdmLT0sk3Zl44Nb9rLh3zwdVCZGELlZE2dcKFJKN
 j1SNmEkWee7dydwV3yGuRUI+LcR+FoklG8tr8xEwtQgc+RsG2IaeP1iLV5ht82uvE5oSXsGwH
 fkV2mVwx2A/ZS6CZyaGvqP2hmnQ9o/LmOpRJQRJ2A71lXIRzbNW0K8U0bDo5PXjyAvQ5c1YdD
 EjFZR22Ol1s4m3bPx7zOB753tK6gq7WwhB1IWtWCrCHcqop2fzL6bi5nTKpdvgjeCSCnbNk4v
 3Csfs2yV2abqeI99/MgkHEg11mJi7THuwXBOtyp6THRvdao+DgfoscRsbPVbqOnx86keNImek
 bL9akUqHAjjNtGH1h3AM2eOLVNbkSS8BAZSw7hq1VNlYCFCdIsPrTPHVilWgTdtKF2yQ5AeNz
 54uzDQnBnJ7B7FjL34WoivKj5sBg927wir/3Xa4hPn0e6TjTeD1VY1dyFO0vHRQxXnk/O9l1A
 KEWS1uuP4PXUsHj4oH0gAW3arx5b1zTnZbJxcNUFRoLjhwTP2XPiF3fdpOHNZLqjd9KawPEnW
 P8DKLCn/zXHnFJBleK7G27BDUyVOY9Zn2zIUzl23NrNVr6EoZ1GNW4VtfYAEeLnrBhEtWxAKe
 EMuuB3r14DIbNuniQVVK7twmwKMDmhC9LSAg4ojWULzZSQ+DBVKgRPn1Z5VjzORTLuOZkDIlX
 re/z58KHobWvRKPU8BX3h6MdNlDXXqkQOdlxeAuLgJekjRL44FzYYk7jb9IcxKVCLLZwuPkkA
 DSYSbrCtgD2wHlU5IdHJlB+IqaaEFdllvrwzqh+GhDNsNphRtZ2nyaCSDxQaez3R5CV7QpYqi
 J2zYWmQsvNIlT9KyaoiVQ9onNZDP12sQa7rYk5gtuqlIXwAPLonst0fgNUyB/cbF1TcUsKsNA
 uF2/Du095mOplcO00C0AlQxMxKwSyk043xbB0WgIfRyzX/s4Psr6QRBh3uec7f1FePOWIIcWH
 upYhimtIJU7lGYS4IRYtb0DDwhOWwHG9NSWvDLpaqTJiOFpDlMbmZ4jdao1uy9qlqalgrPz0C
 68Djg89h8Zg0LkcFyZcqdNJJIN3jxa847qdMPqw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

since I updated my system I noticed a lot of messages like the following
in dmesg (sda8 is /home).

BTRFS critical (device sda8): corrupt leaf: root=3D1 block=3D78397440
slot=3D32, invalid root item size, have 239 expect 439

I did a 'btrfs scrub' but it didn't find any errors. Then I started the
system in single user mode and tried 'btrfs check' but again, no error
could be found.

I read that the issue could come from bad RAM and so I ran memtest86+
for 12h but it seems my RAM is ok.

Is this a real problem and how can I fix it?

Thanks a lot,
Matthias

$ uname -a
Linux matze-debian 5.3.0-3-amd64 #1 SMP Debian 5.3.15-1 (2019-12-07)
x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v5.4

# btrfs fi show
Label: none  uuid: 0957d767-7f29-4235-b812-329fe851b63e
         Total devices 1 FS bytes used 10.29GiB
         devid    1 size 15.64GiB used 15.64GiB path /dev/sda5

Label: none  uuid: 0d3f2898-446d-4967-bd54-a034108d06b9
         Total devices 1 FS bytes used 12.68GiB
         devid    1 size 18.62GiB used 18.61GiB path /dev/sda7

Label: none  uuid: d6954ba3-3d50-4886-ae3f-a92a5ca83923
         Total devices 1 FS bytes used 16.61GiB
         devid    1 size 24.70GiB used 24.70GiB path /dev/sda8

# btrfs fi df /home
Data, single: total=3D22.67GiB, used=3D16.38GiB
System, DUP: total=3D8.00MiB, used=3D4.00KiB
System, single: total=3D4.00MiB, used=3D0.00B
Metadata, DUP: total=3D1.00GiB, used=3D236.50MiB
Metadata, single: total=3D8.00MiB, used=3D0.00B
GlobalReserve, single: total=3D49.54MiB, used=3D0.00B
