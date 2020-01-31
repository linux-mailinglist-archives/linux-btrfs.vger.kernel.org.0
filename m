Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A24714EA56
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 11:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgAaKBW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 05:01:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:49889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbgAaKBW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 05:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580464874;
        bh=UtGr2PFC8RYB+SjHz7INW8Mh9eVbr3KjaJYo7xFRD3s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YTQdIxclEpLVuneFbq1MqqyzhBaGnHuAwnnTOoHCnAeuhAnsxrVLyw1bCzff5fkiX
         sdoRMo8HL/zIkWhhTB6QNepkM3jOMJeBOytpN8v5okb7KGGryddD6wwBeT5Ct2B0rJ
         Gv27wuJpiglwr/E6pIZUp6M4OjEFTdmeXSolfarA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.111] ([34.92.246.95]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVNAr-1j6RVW1NTD-00SR8M; Fri, 31
 Jan 2020 11:01:14 +0100
Subject: Re: [PATCH 02/11] btrfs-progs: misc-tests/034: mount the second
 device if first device mount failed
To:     Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191212110204.11128-1-Damenly_Su@gmx.com>
 <20191212110204.11128-3-Damenly_Su@gmx.com>
 <2eba385b-1d75-ce1b-669f-f8722dc016fa@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <000a9744-a72d-88ff-51f1-2705be98bd75@gmx.com>
Date:   Fri, 31 Jan 2020 18:01:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2eba385b-1d75-ce1b-669f-f8722dc016fa@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rdGZWAuYfYM7ltAt9ihiSO9JcvNu6+myLgWwTOCh2Zxfe9O8AvD
 GIpkJXwiduKZ4rO30zrq89j2EJiUYvHSNBLdhCKNHhiAiIfKOhdTmZIdGgj+KG62ek3AM3s
 4r+sB6+49HekShCTOul53Vl2rwNYtslEmUrjsDN8Qq76a+LqlaDHDMpyhowXDPoTJS+aN9S
 IIDCLiWFE7k4ASm/4OZoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WwaoMSmxggM=:HE26UZn6av8Vra4+shdo+P
 ssqEAuCzgrO+26Js61qRSZZ1s4BXwRBotzGBu+Jyhh7XhQtMb2lKxgnLnsVf4pkfy+3SjbRvy
 w48bu970KWAp+XwkUkiWUQ10I6pbcf8HWz69BcDezAejUYb0Qb1BAtYu9xyD7PdSmfxWWlkJH
 4YT3fP/Pe2je6Jh+wpNwtxbIPI/BQIdzNYjvud9KQMR5mRnmgzTMjT0za1o8Q7NRgUCdLkTRb
 bJVT/m1tNT3hPKO85dqoox6caD7/U9dkh38fWUMruMZUQyOwS2EmpR94uPHhFWNEDSbgp27eH
 BuUWH7BmewiP7px2VWi653LW3/IAnoHtnwaJLCI2Mhu+cxPeJ53cwz+IQOoKx5ZMI9J21V09i
 3Vog7zxGQpDm9tklYckBPwI+Ok/uAheHpOla0mLiK5hN9hwMGDuLEvy5NK5EFjzL1eFNClUs5
 znGeRv7PSFUirTU/MVe6NuP/d2uGIjfeS68ayM9fzKxfG0rB4xPWfbPNQ/y6vIil1zg/3MJLD
 JMvha6clCX2b83Qzag8moxZDmZW3xLQPXconMLmmpIuEHXnOTsy2jt4dd1FD8+6TAWTDhC0Do
 tHrNE+Z2BTNV8ek8BDmC3eKVRFINXoPIfZqAtGkGV07amoGIGex46spFfcjIzRtiRb8cFK27f
 86j0u64piZTBvPFI0CqCgta+NPn7wB0ZIs2eYXZlYlTK0M5pKQMsCWroGUJMzBXulUG4c4OUD
 UMt8u3uxWWLkqLRdfo3UnJy/KxGOGR2qkYto7hT/yX9FYmD39E/kBsO97n3mwreaUacYrCcXu
 tRFlaerAM1xkHhfgew9EdXxZkQlKt7I7JEruRraZGXBOSTEn0rvuEV1dUmB0b30rIruUSHR+Z
 OHfsy53vzgsYg5iqas5I5oYHF6TLjCsbegF3MRPOhHkNJxZgmj4tWT4VJzsNdpyRpuqz3ZvCa
 zCZImOGx39m3toVDVJHP7EJmR2Y46zBeTWYGR06d0c20CgWgv01AOUE1xpi1faUmWN8Z+a3Nq
 wr2eDwhgrLp+H0YGFZLWrENzq3cAx8ETG4YYKrnbxKpyv3aXiGgDMcB2fr8chgRzgWzMhw5xw
 QTQK0rSLk25UiFw2xOI8CTrQByQYQMu2qC21ZtK6WFPDGAVYHFZF8K3NlothSuMR97L9YtBHX
 OMsOADmxPWxAaFIZSbHgS3JU3ISBRz8Zsk0kwvnHIfmLs80URvq0qUCTuqDa1/nHcrZvaR0Jz
 8XaUwb5d3CXbnlI2S
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020/1/31 4:03 PM, Nikolay Borisov wrote:
>
>
> On 12.12.19 =D0=B3. 13:01 =D1=87., damenly.su@gmail.com wrote:
>> From: Su Yue <Damenly_Su@gmx.com>
>>
>> The 034 test may fail to mount, and dmesg says open_ctree() failed due
>> to device missing.
>>
>> The partly work flow is
>> step1 loop1 =3D losetup image1
>> step2 loop2 =3D losetup image2
>> setp3 mount loop1
>>
>> The dmesg says the loop2 device is missing.
>> It's possible and known that while step3 is in open_ctree() and
>> fs_devices->opened is nonzero, loop2 device has not been added into the
>
>
> Care to give more details how this can happen? I haven't observed such a
> failure, meaning it's likely due to some race condition. More details
> are needed though. In your change log you say "it's known" but
> apparently only to you in this case.
>

Sure. There's a device missing situation[1] if two
devices(raid 1/0) were caught by udev. Yes, it's
not related to the metadata fsid feature. It just
makes the mount operation due to the missing device then
the test fails.

In this script, $loop1 *may* be failed to be mounted because
$loop2 is "missing". Mounting $loop2 device can verify the
metadata fsid functionality but without the degraded option.


[1]: https://www.spinics.net/lists/linux-btrfs/msg96312.html
