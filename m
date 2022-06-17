Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D166D54EEFB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 03:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiFQBsB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 21:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiFQBsA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 21:48:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F673FBCA
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 18:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655430473;
        bh=lcvIkYogUMnlxezh8dWtW0dYyQkZTkdEK1r7nI+Yf+o=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=S1hSGAluDHoK6s2qDDJQPWFSQyNs4i3QpbyiKE4WUGpbzlho+L1PjVi1aS4q1mrg7
         akpXwnZmCn+/sBZZPdXiAjz/LkemppoPg07YblorAoj1g7x9EzE6kChHky/mNFmPzV
         PR+QLa98m4kYc/fKCtYuRWJmTBEAf5OBrHeobA4c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8GMq-1nfpU041bM-014Ehp; Fri, 17
 Jun 2022 03:47:53 +0200
Message-ID: <17bbc7c6-c2e9-dcde-501e-0aad631e53e3@gmx.com>
Date:   Fri, 17 Jun 2022 09:47:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] btrfs: introduce BTRFS_DEFAULT_RESERVED macro
Content-Language: en-US
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1655103954.git.wqu@suse.com>
 <51b17f7480724d528e709a920acd026acff447ea.1655103954.git.wqu@suse.com>
 <24bd65b9-d382-f55b-3640-add00b02f4e3@suse.com>
 <2307850a-4f38-19ab-48fd-47246f11cb4b@gmx.com>
 <20220616152042.GD20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220616152042.GD20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zCjTkZ71EJJIcEepSyEpLQFH9Jz6Cp211Fl7unWSGQdldy6sx6N
 dOjoivJKJ+p384eQobbNMB/BS45eYHnjrbxiqb0RvRtUCu71SzsbZD8gGcg+LvvFa72cOPO
 TijnYnzNkrZ61/TgYuTiSkZZNSCrR6TGlFE6f5v6jF0jX8N+6wn8lhGDAX6Dt3KgC5XJBoJ
 8ACsk3E5suQ9tDH0/VyAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dG+gbmWOqhg=:BOuY6eTaJ/ajbHpjd0r5xR
 8zyByLXpCTm6derT6AKbJbjejCejbTs8TtxSaVdi0Kmu/ZD/sDOxNEcPlcuH4m/haaDtyUVt+
 M88hR+V8AxrySYrvRtABEqLfnn1sCGiEuyjJfHmsV6kf94i+u7nZZMUHIoUs5g6xJXXEr95Ez
 CFy3OZ8SivAQo4DlNAgnpakt6LiqGOP7IcMVtnPCngng/suTkiJNnyLdb9sgf00npWG0SF4P0
 kJ74XHQnEjNHCHwi91Pe9i+3y0yyRdTQfOQuCiDzIrXzqkWR9BK+RJQK1DY6bhULWgD70Ms3E
 lrAu3v48pfyp4ySD9nTip+ThLay3jTjkm1aEQuNt9dBJFk+UxezQge1DqJL19JJfyPVb2KB1n
 tU6IyACrCFWvErhfwqTRh14Aln0UWXZQNwjEqhvrpOJmwenZtfV5dukqQg+css5VmnWF2reX7
 fHPFVnSHjrAw703u9z9+BkKLOIs0Upjr4s/wHwaZNGClP90siQU7OJuf2eVkBNjJ8hCq465+b
 pdXhO38snVO25An9KoLxMn7xSwI8YRCGy40k2QYzmfLzMVYAn6rKjGeSnaSf649bhEylzKnSs
 pVreulQKJg8JmHPcU19fReRXGbAfWAkBtOfmwTn4dNdxdmMVpYY0CLz3OlErgMsjMxqFLvpJe
 DsCEsv6CzEggHj3R406Sjn5/3LoWgYIhCwvFGXSUw+TXupsJvfPGP1QuYNJ0KiNpfEdoBBhUt
 d1DIBHHhpXT7tr30GpDizRMa/PkL21KOS9vCkvDoKsh2RcUSfPecZASus8ErEIKFsJ7Qoerkd
 f+Q7fYqs1NqHj6bGH9nhlAHIOJW3kq4gwOIr+bUWPfumyJQC91mqQE8wxgIztpANS0pVHHjer
 xF/QBwsywD83Jc+yoG+CjgcrX74iE9u3gbG3hUwWRcwKkMqne7sDR3Kw2HMpOR5QqzZFqerMD
 9QeZ2gXJwHgCXkHyhlmtRL/zY9vFWISBsnsF74ggZZwdVmz0ywBcWtQOqIcmZKpXi4Q+gUTgm
 IaN0I0+nLIdzGjHMTE+x59j3GypTsSksMC/Hu9mo+/77iSXqjqV8qkrPr2hfnt1bw3Qb+YMBx
 qjHjoO6XSNs5efHp5U6es+VXmZx36nP1vY4lmhSdvM/YyEa5oovWnqTzg==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/16 23:20, David Sterba wrote:
> On Mon, Jun 13, 2022 at 05:36:19PM +0800, Qu Wenruo wrote:
>>>> index f7afdfd0bae7..62028e7d5799 100644
>>>> --- a/fs/btrfs/ctree.h
>>>> +++ b/fs/btrfs/ctree.h
>>>> @@ -229,6 +229,13 @@ struct btrfs_root_backup {
>>>>  =C2=A0 #define BTRFS_SUPER_INFO_OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SZ_64K
>>>>  =C2=A0 #define BTRFS_SUPER_INFO_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
>>>> +/*
>>>> + * The default reserved space for each device.
>>>> + * This range covers the primary superblock, and some other legacy
>>>> programs like
>>>> + * older bootloader may want to store their data there.
>>>> + */
>>>> +#define BTRFS_DEFAULT_RESERVED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (SZ_1M)
>>>> +
>>>
>>> The name of this macros is too generic and uninformative. How about
>>> BTRFS_BOOT_RESERVED or simply BTRFS_RESERVED_SPACE, because
>>> BTRFS_DEFAULT_RESERVED implies=C2=A0 there is something else, apart fr=
om
>>> "default" and there won't be ...
>
> I've renamed it to BTRFS_DEVICE_RANGE_RESERVED
>
>> BTRFS_RESERVED_SPACE sounds good. The "BOOT_RESERVED" part will
>> definitely lose its meaning in the long run, since now there is no
>> modern bootloader really doing that.
>> (Either go full ESP, like systemd-boot, or extra reserved partition lik=
e
>> GRUB2, or use unpartitioned space after MBR like the legacy GRUB1)
>
> Yeah the bootloader is there as a known example, but what will happen
> with bootloaders in the long run we can't predict, so the reserved space
> will stay.
>
>> But "DEFAULT" is here because later we will enlarge the reserved space
>> (for write-intent map, and will introduce a new super block member to
>> indicate exact how many bytes are reserved), and I don't want to add
>> "DEFAULT" when we introduce that new reserved behavior.
>
> I've dropped the default because right now it's not configurable and if
> it eventually be then it can be renamed, but the write intent bitmap is
> a work in progress so existing patches should not mention it. As said
> before, naming the constant with a single point explaining the meaning
> is a good cleanup on itself.

OK, I would rebase the branch and using thew new naming (and rename it
if needed) after finishing the write-intent bitmaps feature (at least
for the bitmaps update part)

Thanks,
Qu
