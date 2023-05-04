Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BA06F6291
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 03:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjEDBNG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 21:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDBNF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 21:13:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32592101
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 18:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683162780; i=quwenruo.btrfs@gmx.com;
        bh=Xjjksxpc5FEe0iH6sjrlrXQCeTqWAR9KODpyoxaj7mo=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=UhCBumtkhAqV8N+BELjdd/Fz28nG/jG/RVnjFwY58vgQAdxo/DW9UIqN1KDM2jbrz
         Wkf7AAPyhz4lMBnVNrgpu31XWAh3hlIYc3xVN0yrqgExDSKo4LVRMz3nBujaYlWdmf
         11AdSeNRcyp3hM9C0y+QmnlJoN0f3Yq3E+o8t/f+N/BAtZibSzAlNhTI6ZxvfX/c72
         brju+hKbluzg6Rs8xGN4H3AoF7JPJ6jfyURNMP6b/T5lSry5K46K6akZKpqL2mWDYE
         b6d9GutittzLGyt7abVefnM57XW8hHj8NlL/k0q/iBFuaHhN9C3uyS0oY/lTmMu68i
         1p0FtJyRYQN4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b6b-1pt1fy3u9d-007zxB; Thu, 04
 May 2023 03:13:00 +0200
Message-ID: <7d106d9e-9889-de54-e3b7-82858ce6be57@gmx.com>
Date:   Thu, 4 May 2023 09:12:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Gowtham <trgowtham123@gmail.com>, linux-btrfs@vger.kernel.org
References: <CA+XNQ=ixcfB1_CXHf5azsB4gX87vvdmei+fxv5dj4K_4=H1=ag@mail.gmail.com>
 <CA+XNQ=i6Oq=nRStZ3P1gCB+NtCrR0u+E_gW1CraLFyz0OoeJrg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Filesystem inconsistency on power cycle
In-Reply-To: <CA+XNQ=i6Oq=nRStZ3P1gCB+NtCrR0u+E_gW1CraLFyz0OoeJrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K+S0HhmEeoFAF02bnr/WFkOoSbbRmV8UX0f4rJ83j9KdVNaryom
 s8eKFguSYKMRmggqRn0Hh+ahoPB0CMsRHWPvZ8/Y0zh7noLcuB0p1+LM/6Zd6zylgVFtnof
 H8FTAhKAmgCtaTDX4GTgHaV8x7jzJiz89Vj9hESkPVPD8QF+XcN9X8iF4EGfLYZkq/PmWWF
 BYGmCi/6hv7axsQic2SeA==
UI-OutboundReport: notjunk:1;M01:P0:2j2uRoGuTbw=;pvEuvaOCBpJHc83//VlkMaKiPju
 AsrHtRu0Ym7NqMi789DYXzFlNBQ8TVjGUkla1qe8K6MroCmw1AsAZ5/14NKWUJCxvqvmd5zY8
 S0pKu2IIRUnOGz2rL9z81+Wsem/5E7O9+4TF2qGrmGZrj81kYacq1bMngH3xCKnJGFb2tYmhu
 KL871XbS8ixSdGCyaKlDAgUtNbiuJL10CwArxbp70oA97Ui69fVYJhEjO54dYlzXtGQEYIE7X
 c872xYMIqvGouAaJ8PVK6ZjjrJure+5YWdVXid3ntnAcBX4AMHvwPhy2FbkL1nTOXlnayO8XR
 0fhuN8AqtjQ8cHIMlPrvdGaydPc2P538Y9rqeif18EzoX8SXcfuTRXhfFlEQeY6hk4vK4UNR4
 iJzgn0SnACCzlSmJuKL3l0d6UYT2XXdY1o02DdJx1KoOakdVQGCRe9m5IJguMeqc0DMWnZE1e
 BB5XITwZ6Kl41+4KnkWooIhkjIAosM3Np9ELAcVfe1ah32stbmpKPlFlLts9ejnch02qAYENx
 qf5r9VohouBtpaMq7RtxQ8Zdrg5Enru6rPThIVVqoxKvKmtFSP9HIZOK3Ac0962pR+Vci059d
 HeMiTWyIV9fQC2htg87DyN3d/X7Hy82u0hHHwcbSoU2eQl5B5wUH0O7EzXJm6u6dQChCKi1T9
 OWpzm0XqpEmd+rNEaeu4flKI/xHtwXM56wXX4BttxTBeIsCyfdHnbSLpreDhARDEjxe+gn3zx
 3TWTdquY0NhTzODH1rjKs09iXjqxBUEY1W4VQVaToef6HkJoT7SYlc7oJ39MhdBe5UuPgNCHO
 FSDj3/v9sqweHnFnCABMnWHAZJL8nd4xTuh0kwjGvL/RIxKiPk4dtgpAuc+cqVQ0j2GAVD5yG
 Z4AcDV5KrQVejcawlPXy6+146xIkuKsqI/SJCEiFW1JbISCUKY5w/A8LvFxqmiYu/GU6upoui
 0TqmwbnqSa2X+EQqB4lkZcKohiE=
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/4 08:24, Gowtham wrote:
> Hi All,
>
> Can anyone suggest a fix or a workaround for the issue in 5.4 kernel?
>
> Regards,
> Gowtham
>
> On Sun, Apr 30, 2023 at 3:50=E2=80=AFPM Gowtham <trgowtham123@gmail.com>=
 wrote:
>>
>> Hi
>>
>> We have been running our application on BTRFS rootfs for quite a few
>> Linux kernel versions (from 4.x to 5.x) and occasionally do a power
>> cycle for firmware upgrade. Are there any known issues with BTRFS on
>> Ubuntu 20.04 running kernel 5.4.0-137?

I don't believe there are some known bugs that can lead to the same
problem you described.

>>
>> On power cycles/outages, we have not seen the BTRFS being corrupted
>> earlier on 4.15 kernel. But we are seeing this consistently on a 5.4
>> kernel(with BTRFS RAID1 configuration). Are there any known issues on
>> Ubuntu 20.04? We see some config files like /etc/shadow and other
>> application config becoming zero size after the power-cycle. Also, the
>> btrfs check reports errors like below
>>
>> # btrfs check /dev/sda3
>> Checking filesystem on /dev/sda3
>> UUID: 38c4b032-de12-4dcd-bf66-05e1d03143a8
>> checking extents
>> checking free space cache
>> checking fs roots
>> root 297 inode 28796828 errors 200, dir isize wrong
>> root 297 inode 28796829 errors 200, dir isize wrong
>> root 297 inode 28800233 errors 1, no inode item
>>     unresolved ref dir 28796828 index 506 namelen 14 name
>> ip6tables.conf filetype 1 errors 5, no dir item, no inode ref

Those corruptions are mismatch in inodes backref mismatch, some can even
be bad key ordered.

I want to look deeper into these offending inodes, as in the past we
have seen some memory bitflip causing the same problem.

Mind to dump the following info?

# btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28796828 "
# btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28796829 "

# btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800233 "

# btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800269 "
# btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800270 "
# btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800271 "
# btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800272 "
# btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800273 "
# btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800274 "
# btrfs ins dump-tree -t 297 /dev/sda3 | grep -A5 "(28800275 "

Furthermore, the output of the original mode sometimes is missing needed
info.

Please use a newer btrfs-progs (the easiest way is to grab a rolling
distro liveCD), and paste the output of:

# btrfs check --mode=3Dlowmem /dev/sda3

Thanks,
Qu

>> root 297 inode 28800269 errors 1, no inode item
>>     unresolved ref dir 28796829 index 452 namelen 30 name
>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
>> inode ref
>> root 297 inode 28800270 errors 1, no inode item
>>     unresolved ref dir 28796829 index 454 namelen 30 name
>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
>> inode ref
>> root 297 inode 28800271 errors 1, no inode item
>>     unresolved ref dir 28796829 index 456 namelen 30 name
>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
>> inode ref
>> root 297 inode 28800272 errors 1, no inode item
>>     unresolved ref dir 28796829 index 458 namelen 30 name
>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
>> inode ref
>> root 297 inode 28800273 errors 1, no inode item
>>     unresolved ref dir 28796829 index 460 namelen 30 name
>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
>> inode ref
>> root 297 inode 28800274 errors 1, no inode item
>>     unresolved ref dir 28796829 index 462 namelen 30 name
>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
>> inode ref
>> root 297 inode 28800275 errors 1, no inode item
>>     unresolved ref dir 28796829 index 464 namelen 30 name
>> logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
>> inode ref
>> found 13651775501 bytes used err is 1
>> total csum bytes: 12890096
>> total tree bytes: 267644928
>> total fs tree bytes: 202223616
>> total extent tree bytes: 45633536
>> btree space waste bytes: 59752814
>> file data blocks allocated: 16155500544
>> referenced 16745402368
>>
>>
>> We run the rootfs on BTRFS and mount it using below options
>>
>> # mount -t btrfs
>> /dev/sda3 on / type btrfs
>> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subvo=
lid=3D292,subvol=3D/@/netvisor-5)
>> /dev/sda3 on /.rootbe type btrfs
>> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subvo=
lid=3D256,subvol=3D/@)
>> /dev/sda3 on /home type btrfs
>> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subvo=
lid=3D257,subvol=3D/@home)
>> /dev/sda3 on /var/nvOS/log type btrfs
>> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subvo=
lid=3D258,subvol=3D/@var_nvOS_log)
>> /dev/sda3 on /sftp/nvOS type btrfs
>> (rw,noatime,degraded,compress=3Dlzo,ssd,flushoncommit,space_cache,subvo=
lid=3D292,subvol=3D/@/netvisor-5)
>>
>> # btrfs fi df /.rootbe
>> System, RAID1: total=3D32.00MiB, used=3D12.00KiB
>> Data+Metadata, RAID1: total=3D36.00GiB, used=3D34.19GiB
>> GlobalReserve, single: total=3D132.65MiB, used=3D0.00B
>>
>> # btrfs --version
>> btrfs-progs v5.4.1
>>
>> Regards,
>> Gowtham
