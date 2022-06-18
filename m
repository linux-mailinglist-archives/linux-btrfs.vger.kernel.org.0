Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29957550764
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 01:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiFRXAS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Jun 2022 19:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFRXAR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Jun 2022 19:00:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C534FD2A
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jun 2022 16:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655593213;
        bh=HqT/UoO9DnPtA63nAe0/12Bqdr1XW45WlnK3gwQF2pY=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=FSx6K1ZaH766UrE8opiLb1suOrWhDzova/VvQaGuU6nIYW76xOzAta79+3ejrMb9q
         Csursjz5ZSRmejUFKyEJLBdM5fipjz8YaixQQMygMU0o+W0bJTIGAXLGK/w5ocCgyL
         d9HzTYZDW2ffk+AMwki6yX0lSviF5bqt2MfzYSN0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1nSGsN3uqd-00bIvb; Sun, 19
 Jun 2022 01:00:13 +0200
Message-ID: <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com>
Date:   Sun, 19 Jun 2022 07:00:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        linux-btrfs@vger.kernel.org
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Problems with BTRFS formatted disk
In-Reply-To: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lUVFRzIHLnSU8bMC9zku6HyGgT7goFFLwMoA3hrMYX61Xmd95Rp
 4YNR4CyGqkuhCGxc/Nm5rMk8iC6n0Dt+QhRLDapCdCwVDg3g2zcOkNh9XUDdzelC5klwjkV
 OrwoeqP2gCQqGgk+JhfaIptvh2IwIjBF7b3zAEe1MxBpc25KLFimZz8BTn0dFC463OoPsbo
 BUWo8CNRBkWqx8OXinlJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TItHncVUhc4=:PRVGPWr5GVT3XY7ikPoDel
 1SVhKXbLS3nWOOJ1wcP61LoCK0HjUIxviyEWAY0v890wxigpg8a/OFXN/dbuGuLCEO6W+YXdt
 5YZ2M2j5+6wIjwdTDMB6l3xM9UggI7e9peNjxGCVLVdgywbexmzomFTVRRcn8/170IzGw+2Rb
 cqiUNM+/PGyCtJvZhTz2mZtUWLNeIXsQfdZloMtZFuudcEyO96VgD3q5V+7G5HmvQwlMUNYMy
 7HsnlYetw/3y2Kp0mJcodE1DpBv9n0aWyhAhV90tMGyCYJNswovshOvWXNbzgBtUjtAyqEi9R
 gBoXS8ZVBJO0e0EpkP/y980ig2ZaJ3dh+ZPQIKo0OtOUgBhn6jFEZm/5oD/HOB+yEgCBkhk2/
 xeFLZwZDsJSCBlENyOYmwv++bk5fn4Hxcg0RqjVyBDFFScqtBDzcwm8sfBKBeB8eZsvqfXYu8
 7nVP7NLLwpD/bFdlvyke3Xa/gZI2SghB5TtRNAxFC3TRATBqv3USeQGVhWgfnWQRnoF8ArPw5
 qGcBD5AVMnUqLG/wOiWgrTEW6YRujnR3nGMnSVP4y72kMQq7+PqPeeBB0UnCK3SuBly3tUdt6
 ajEygmjN5+RqHK36Zbr+5XQKtfY93W9Mji9eUJCDyjAyFdyxx3lWE6mD7Blex3jVwzD+Ktddh
 KVb4fSboyv8VujtICEd0qeThFOk3UBBYxzG8ISqP1gz+VTXqBemSOLQu9p3cm9BVjAcT9WYe8
 +j8k/27ZGirEFOeKFBZjRmR7I56ni1cD7HiX8JR/hFI9/pjWHpxsZhUIJGyHrvsQzxwE0xfb6
 rqwhMLl0CmD0BZXcYIMFNNjwPX/xQkGLv4Sl/3OZbNjVDVVla+YsWHYPTySZaQRs8N1cShJ5o
 P47TCHO/K044QA6BFChTpIDZKtd4rRmUJMN41ZnTbche2gVdDXv/AWLSzWxUbvuC3uvXHZsbI
 X88dz0lXk1YFxsYSoi2Uol+zd82hNFpQvVyhs8D5cHQwE0zmAJKyrnnffJRDRwJTs2/Ugcwnf
 E3RMwi5a5O338QHtYJ6rJNW1raRKQh+G/2UPDsDGB3VaB0aVdFiqW1qbHvwLrKQlMz8T0Itpl
 CzKrKDJY1A/K9+qcWSu+eiIitfNZ6lhRH+jyU7C7cGgLi0QkjzzthNp0A==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/19 02:55, David C. Partridge wrote:
> It all started with a power outage.
>
> When I brought the system back up I got:
>
> Jun 18 15:40:27 charon kernel: BTRFS error (device sdb1): parent transid
> verify failed on 12554992156672 wanted 130582 found 127355
> Jun 18 15:40:27 charon kernel: BTRFS error (device sdb1): parent transid
> verify failed on 12554992156672 wanted 130582 found 127355

Some data write doesn't reach disk, even btrfs does the proper FLUSH call.

Mind to provide the disk model?

> Jun 18 15:40:27 charon kernel: BTRFS error (device sdb1): failed to read
> block groups: -5
> Jun 18 15:40:27 charon mount[629]: mount: /shared: wrong fs type, bad
> option, bad superblock on /dev/sdb1, missing codepage or helper program,=
 or
> othe>
> Jun 18 15:40:27 charon systemd[1]: shared.mount: Mount process exited,
> code=3Dexited, status=3D32/n/a
> Jun 18 15:40:27 charon systemd[1]: shared.mount: Failed with result
> 'exit-code'.
> Jun 18 15:40:27 charon systemd[1]: Failed to mount /shared.
> Jun 18 15:40:27 charon kernel: BTRFS error (device sdb1): open_ctree fai=
led
>
> I tried:
> root@charon:/home/amonra# btrfs check /dev/sdb1
> Opening filesystem to check...
> parent transid verify failed on 12554992156672 wanted 130582 found 12735=
5
> parent transid verify failed on 12554992156672 wanted 130582 found 12735=
5
> parent transid verify failed on 12554992156672 wanted 130582 found 12735=
5
> Ignoring transid failure
> leaf parent key incorrect 12554992156672
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
> root@charon:/home/amonra# btrfs check -s 1 /dev/sdb1
> using SB copy 1, bytenr 67108864
> Opening filesystem to check...
> parent transid verify failed on 12554992156672 wanted 130582 found 12735=
5
> parent transid verify failed on 12554992156672 wanted 130582 found 12735=
5
> parent transid verify failed on 12554992156672 wanted 130582 found 12735=
5
> Ignoring transid failure
> leaf parent key incorrect 12554992156672
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
> root@charon:/home/amonra# btrfs check -s 2 /dev/sdb1
> using SB copy 2, bytenr 274877906944
> Opening filesystem to check...
> parent transid verify failed on 12554992156672 wanted 130582 found 12735=
5
> parent transid verify failed on 12554992156672 wanted 130582 found 12735=
5
> parent transid verify failed on 12554992156672 wanted 130582 found 12735=
5
> Ignoring transid failure
> leaf parent key incorrect 12554992156672
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
> root@charon:/home/amonra#
>
> but that didn't achieve much.
>
> Following advice I tried: btrfs rescue zero-log which appeared to work, =
but
> attempt to mount afterwards gave me:
>
> Jun 18 18:58:38 charon kernel: BTRFS info (device sdb1): flagging fs wit=
h
> big metadata feature
> Jun 18 18:58:38 charon kernel: BTRFS info (device sdb1): disk space cach=
ing
> is enabled
> Jun 18 18:58:38 charon kernel: BTRFS info (device sdb1): has skinny exte=
nts
> Jun 18 18:58:39 charon kernel: BTRFS error (device sdb1): parent transid
> verify failed on 12554992156672 wanted 130582 found 127355
> Jun 18 18:58:39 charon kernel: BTRFS error (device sdb1): parent transid
> verify failed on 12554992156672 wanted 130582 found 127355
> Jun 18 18:58:39 charon kernel: BTRFS error (device sdb1): failed to read
> block groups: -5
> Jun 18 18:58:39 charon kernel: BTRFS error (device sdb1): open_ctree fai=
led
>
> In desperation I tried: btrfs check --repair which gave me:
>
> Opening filesystem to check...
> parent transid verify failed on 12554992156672 wanted 130582 found 12735=
5
> parent transid verify failed on 12554992156672 wanted 130582 found 12735=
5
> parent transid verify failed on 12554992156672 wanted 130582 found 12735=
5
> Ignoring transid failure
> leaf parent key incorrect 12554992156672
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
>
> So what do I do now?  I don't have a disk large enough to attempt btrfs
> restore (if that would even work).  I don't have a backup of this volume=
 as
> this is my backup disk.

You can try rescue=3Dall mount option, which has the extra handling on
corrupted extent tree.

Although you have to use kernels newer than v5.15 (including v5.15) to
benefit from the change.

Thanks,
Qu

>
> Thanks
> David
>
>
>
>
>
>
>
>
>
>
> Cheers, David
>
>
