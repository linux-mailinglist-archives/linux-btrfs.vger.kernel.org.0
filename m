Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965F55507F0
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 04:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiFSCBv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Jun 2022 22:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiFSCBt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Jun 2022 22:01:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394CEDEC6
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jun 2022 19:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655604104;
        bh=3TPICto/K0Bmur5R4BLRPs9FR8STIaJes2F7FvMvMks=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=E2n8KFBjEkjSghx2jddV3FT9nHeCF2JTBOPVMJrZ9G74ZJGK+lJ9NsfodTqs5VAQm
         nszXtVSoeFkJzqWgN766l7XHqpUWU1Sc0irgWNFG/zuDXOZfLeFi4ZlbIGeB62oKnt
         TlS6zs3DaCc0f+eZJiY/ALiKDAoYL0ubAPcIo39A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZktj-1oEgue2u2h-00WpP6; Sun, 19
 Jun 2022 04:01:44 +0200
Message-ID: <838a65c7-214b-adc1-2c9e-3923da6575e2@gmx.com>
Date:   Sun, 19 Jun 2022 10:01:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        linux-btrfs@vger.kernel.org
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk>
 <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com>
 <000001d8837c$91bc74e0$b5355ea0$@perdrix.co.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Problems with BTRFS formatted disk
In-Reply-To: <000001d8837c$91bc74e0$b5355ea0$@perdrix.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V4YM9yKYSMwPnBbofk6EIC+HbAR1UlIwxQXfalu3UK6hIvxv8hH
 pNE3oUCVFYRtI+soWvdOCaCy3UKy9oihi1eFkus6dH+ZNMNjPJPAWSPwK18O8UjtZPPF7vu
 UelthiHHxZl9mOT4YM+0SRlkM20TiAY+pcpRNFd0R4klPe1xvktRq01Jlsn0xyqY3ss+JGS
 k0E08ZyKiEMElejvcD9mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l8KI5r353rQ=:XWDrX7yhfcfNcryr2yWFr9
 4ZBNB5xA5KGaMAq/FJKjU/Q6aOlOZosUlhGUB8l1ESeeGoHf+uJSPOW6uTVwkrHuux0QlKJWF
 g8A4/BNhMBa/oWsmYnqSOKhj+Xcq1xaQ0ttNfm9Qx/TMAzBnKfKCshjSkFJ1Z5C6qUSGiroVP
 dWX5SWMeHEsw8ZCWVNHYQQ/4fOZ7gtGyAuqwHZ0VrbKrMogkLDeRZMEuf4dIERhayESPngGKl
 jSqSJq5ltO0yM7VvXt0tyeBz6TSSHB17b3B+zs0qkxG67pN5vvhCb1YD9gc9oJWZWyo4+aZA2
 p09jkGBJhLArX4ggf0i+AqFW3dcgeZEzrHI/tNdeT5qafcODaLBTOJETVUeexb5Kvhf4fPc2b
 IzSKUpuMDxnsfIUj4hd05GtWueescTG7c+nU+okW1flAttVfmQPFdCIs2c3XWOHRYc0eOcNtN
 w3HcBcp+QmL64NbyLUUjbH0ZjxVFJH6j+P1OmBnoIuKbpTKotnOpD2Lnv79mFwlqHb8HW4Uyh
 UZfB0OGTkcS1y+BLDWokXiGdGONNhAuN/mAloAT/KsTeDE21wFU7dcTRJgt2txQ3rSThYfKhj
 /xJ7a06UNy77voknA+Fhat9veDOTq/Sup9DiTsU/ky8YsUTtbtoto0sjkSwRdlKIraQq7ttBP
 56M8yqalv/luFRc/cZAcRlSiLZ+phZ6wMaQ2t1nrfc6n0R/OrP2TXUKOVmYQ4BYCsahJDzuUk
 oOuwoP/CELPz5JyJ77sCNxfsVQYD4B2D3Ws+XmQ6ovCGzHUFeBIXZXHtkjLNj77tElt+suGRO
 CTrEC99fCeycdhW8NvqUMjNZPcloVdDArfJprt0CmwiTpFH99RA6oxypo8IYzQrCwkthze7AI
 0WZSEvT75W0bzsQXWUU7AhSBpAgTf8+xzwN4Ap304EFaCHcvpp1LXc+yjxoi8enJ0KlvilnYS
 7qGtapMcQjHaeTVaq7Bzvh/vRAoqvt5hik9iQ9pCdpdgrOuj4jFRqlII5G9JYVozoiWN5z3xg
 +QX7uFiHlFyhBZpcIDLyiGtf3zuz30Hfwk+uGgLtsu0Wbgct1DwQnZ2m4Ulbkl2vcx9LkawFk
 GiD4QN4dt4WFnwCe74Pba0l6B8mqLif/LafP7X4NwOK5kvyPCLWraFWxQ==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/19 09:33, David C. Partridge wrote:
> I at least know when the problem happened - the power fail happened abou=
t 13:20:01 on May 26th:
>
> May 26 12:00:01 charon CRON[1959806]: (root) CMD (mount -t btrfs -U c63b=
cf2b-e4e5-431f-b03d-36f822c68b53 /mnt/root && cd /mnt/root && btrfs-snaps =
hourly 3 | grep -Ev "$GREPOUT" ; cd / && umount /mnt/root)
> May 26 12:00:01 charon CRON[1959808]: (smmsp) CMD (test -x /etc/init.d/s=
endmail && test -x /usr/share/sendmail/sendmail && test -x /usr/lib/sm.bin=
/sendmail && /usr/share/sendmail/sendmail cron-msp)
> May 26 12:00:01 charon CRON[1959804]: pam_unix(cron:session): session cl=
osed for user smmsp
> May 26 12:00:01 charon CRON[1959802]: pam_unix(cron:session): session cl=
osed for user root
> May 26 12:00:01 charon systemd[1372]: mnt-shared.mount: Succeeded.
> May 26 12:00:01 charon systemd[1074]: mnt-shared.mount: Succeeded.
> May 26 12:00:01 charon systemd[1]: mnt-shared.mount: Succeeded.
> May 26 12:00:03 charon CRON[1959803]: pam_unix(cron:session): session cl=
osed for user root
> May 26 12:00:03 charon systemd[1]: mnt-root.mount: Succeeded.
> May 26 12:00:03 charon systemd[1074]: mnt-root.mount: Succeeded.
> May 26 12:00:03 charon systemd[1372]: mnt-root.mount: Succeeded.
> May 26 12:05:01 charon CRON[1960480]: pam_unix(cron:session): session op=
ened for user root by (uid=3D0)
> May 26 12:05:01 charon CRON[1960481]: (root) CMD (command -v debian-sa1 =
> /dev/null && debian-sa1 1 1)
> May 26 12:05:01 charon CRON[1960480]: pam_unix(cron:session): session cl=
osed for user root
> May 26 12:15:01 charon CRON[1961677]: pam_unix(cron:session): session op=
ened for user root by (uid=3D0)
> May 26 12:15:01 charon CRON[1961678]: (root) CMD (command -v debian-sa1 =
> /dev/null && debian-sa1 1 1)
> May 26 12:15:01 charon CRON[1961677]: pam_unix(cron:session): session cl=
osed for user root
> May 26 12:17:01 charon CRON[1961923]: pam_unix(cron:session): session op=
ened for user root by (uid=3D0)
> May 26 12:17:01 charon CRON[1961924]: (root) CMD (   cd / && run-parts -=
-report /etc/cron.hourly)
> May 26 12:17:01 charon CRON[1961923]: pam_unix(cron:session): session cl=
osed for user root
> May 26 12:20:01 charon CRON[1962284]: pam_unix(cron:session): session op=
ened for user smmsp by (uid=3D0)
> May 26 12:20:01 charon CRON[1962286]: (smmsp) CMD (test -x /etc/init.d/s=
endmail && test -x /usr/share/sendmail/sendmail && test -x /usr/lib/sm.bin=
/sendmail && /usr/share/sendmail/sendmail cron-msp)
> May 26 12:20:01 charon CRON[1962284]: pam_unix(cron:session): session cl=
osed for user smmsp
> May 26 12:25:01 charon CRON[1962904]: pam_unix(cron:session): session op=
ened for user root by (uid=3D0)
> May 26 12:25:01 charon CRON[1962906]: (root) CMD (command -v debian-sa1 =
> /dev/null && debian-sa1 1 1)
> May 26 12:25:01 charon CRON[1962904]: pam_unix(cron:session): session cl=
osed for user root
> May 26 12:30:01 charon CRON[1963512]: pam_unix(cron:session): session op=
ened for user root by (uid=3D0)
> May 26 12:30:01 charon CRON[1963514]: (root) CMD ([ -x /etc/init.d/anacr=
on ] && if [ ! -d /run/systemd/system ]; then /usr/sbin/invoke-rc.d anacro=
n start >/dev/null; fi)
> May 26 12:30:01 charon CRON[1963512]: pam_unix(cron:session): session cl=
osed for user root
> May 26 12:33:01 charon systemd[1]: Started Run anacron jobs.
> May 26 12:33:01 charon anacron[1963871]: Anacron 2.3 started on 2022-05-=
26
> May 26 12:33:01 charon anacron[1963871]: Normal exit (0 jobs run)
> May 26 12:33:01 charon systemd[1]: anacron.service: Succeeded.
> May 26 12:35:01 charon CRON[1964126]: pam_unix(cron:session): session op=
ened for user root by (uid=3D0)
> May 26 12:35:01 charon CRON[1964128]: (root) CMD (command -v debian-sa1 =
> /dev/null && debian-sa1 1 1)
> May 26 12:35:01 charon CRON[1964126]: pam_unix(cron:session): session cl=
osed for user root
> May 26 12:40:01 charon CRON[1964736]: pam_unix(cron:session): session op=
ened for user smmsp by (uid=3D0)
> May 26 12:40:01 charon CRON[1964738]: (smmsp) CMD (test -x /etc/init.d/s=
endmail && test -x /usr/share/sendmail/sendmail && test -x /usr/lib/sm.bin=
/sendmail && /usr/share/sendmail/sendmail cron-msp)
> May 26 12:40:01 charon CRON[1964736]: pam_unix(cron:session): session cl=
osed for user smmsp
> May 26 12:45:01 charon CRON[1965359]: pam_unix(cron:session): session op=
ened for user root by (uid=3D0)
> May 26 12:45:01 charon CRON[1965361]: (root) CMD (command -v debian-sa1 =
> /dev/null && debian-sa1 1 1)
> May 26 12:45:01 charon CRON[1965359]: pam_unix(cron:session): session cl=
osed for user root
> May 26 12:51:14 charon Radarr[866]: [Info] RssSyncService: Starting RSS =
Sync
> May 26 12:51:16 charon Radarr[866]: [Info] DownloadDecisionMaker: Proces=
sing 100 releases
> May 26 12:51:16 charon Radarr[866]: [Info] RssSyncService: RSS Sync Comp=
leted. Reports found: 100, Reports grabbed: 0
> May 26 12:55:01 charon CRON[1966565]: pam_unix(cron:session): session op=
ened for user root by (uid=3D0)
> May 26 12:55:01 charon CRON[1966566]: (root) CMD (command -v debian-sa1 =
> /dev/null && debian-sa1 1 1)
> May 26 12:55:01 charon CRON[1966565]: pam_unix(cron:session): session cl=
osed for user root
> May 26 13:00:01 charon CRON[1967160]: pam_unix(cron:session): session op=
ened for user smmsp by (uid=3D0)
> May 26 13:00:01 charon CRON[1967161]: (smmsp) CMD (test -x /etc/init.d/s=
endmail && test -x /usr/share/sendmail/sendmail && test -x /usr/lib/sm.bin=
/sendmail && /usr/share/sendmail/sendmail cron-msp)
> May 26 13:00:01 charon CRON[1967160]: pam_unix(cron:session): session cl=
osed for user smmsp
> May 26 13:05:01 charon CRON[1967787]: pam_unix(cron:session): session op=
ened for user root by (uid=3D0)
> May 26 13:05:01 charon CRON[1967789]: (root) CMD (command -v debian-sa1 =
> /dev/null && debian-sa1 1 1)
> May 26 13:05:01 charon CRON[1967787]: pam_unix(cron:session): session cl=
osed for user root
> May 26 13:15:01 charon CRON[1968995]: pam_unix(cron:session): session op=
ened for user root by (uid=3D0)
> May 26 13:15:01 charon CRON[1968996]: (root) CMD (command -v debian-sa1 =
> /dev/null && debian-sa1 1 1)
> May 26 13:15:01 charon CRON[1968995]: pam_unix(cron:session): session cl=
osed for user root
> May 26 13:17:01 charon CRON[1969237]: pam_unix(cron:session): session op=
ened for user root by (uid=3D0)
> May 26 13:17:01 charon CRON[1969238]: (root) CMD (   cd / && run-parts -=
-report /etc/cron.hourly)
> May 26 13:17:01 charon CRON[1969237]: pam_unix(cron:session): session cl=
osed for user root
> May 26 13:20:01 charon CRON[1969603]: pam_unix(cron:session): session op=
ened for user smmsp by (uid=3D0)
> May 26 13:20:01 charon CRON[1969605]: (smmsp) CMD (test -x /etc/init.d/s=
endmail && test -x /usr/share/sendmail/sendmail && test -x /usr/lib/sm.bin=
/sendmail && /usr/share/sendmail/sendmail cron-msp)
> May 26 13:20:01 charon CRON[1969603]: pam_unix(cron:session): session cl=
osed for user smmsp
> The next btrfs log data follows immediately (well actually a week or so =
later as I hadn't rebooted since) =E2=98=B9
> -- Reboot --
>      Messages deleted
> Jun 18 15:20:12 charon kernel: Btrfs loaded, crc32c=3Dcrc32c-intel
> Jun 18 15:20:12 charon kernel: BTRFS: device fsid 4fc521d7-c18f-4cb3-9ea=
c-d9d367e2b0eb devid 1 transid 130613 /dev/sdb1
> Jun 18 15:20:12 charon kernel: BTRFS: device fsid c63bcf2b-e4e5-431f-b03=
d-36f822c68b53 devid 1 transid 5607929 /dev/sda2
> Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): flagging fs wit=
h big metadata feature
> Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): disk space cach=
ing is enabled
> Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): has skinny exte=
nts
> Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): enabling ssd op=
timizations
> Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): enabling auto d=
efrag
> Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): turning on disc=
ard
> Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): use lzo compres=
sion, level 0
> Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): disk space cach=
ing is enabled
> Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): flagging fs wit=
h big metadata feature
> Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): disk space cach=
ing is enabled
> Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): has skinny exte=
nts
> Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): parent transid=
 verify failed on 12554306306048 wanted 130605 found 127414
> Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corr=
ected: ino 0 off 12554306306048 (dev /dev/sdb1 sector 1007336416)
> Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corr=
ected: ino 0 off 12554306310144 (dev /dev/sdb1 sector 1007336424)
> Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corr=
ected: ino 0 off 12554306314240 (dev /dev/sdb1 sector 1007336432)
> Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corr=
ected: ino 0 off 12554306318336 (dev /dev/sdb1 sector 1007336440)
> Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): parent transid=
 verify failed on 12554682138624 wanted 129690 found 127567
> Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corr=
ected: ino 0 off 12554682138624 (dev /dev/sdb1 sector 1008070464)
> Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corr=
ected: ino 0 off 12554682142720 (dev /dev/sdb1 sector 1008070472)
> Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corr=
ected: ino 0 off 12554682146816 (dev /dev/sdb1 sector 1008070480)
> Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corr=
ected: ino 0 off 12554682150912 (dev /dev/sdb1 sector 1008070488)
> Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): parent transid=
 verify failed on 12554682155008 wanted 129690 found 127567
> Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corr=
ected: ino 0 off 12554682155008 (dev /dev/sdb1 sector 1008070496)
> Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corr=
ected: ino 0 off 12554682159104 (dev /dev/sdb1 sector 1008070504)
> Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): parent transid=
 verify failed on 12554992156672 wanted 130582 found 127355
> Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): parent transid=
 verify failed on 12554992156672 wanted 130582 found 127355

So this means, some copies are correct but some are not, the repaired
ones are from the other copy.
(Btrfs uses DUP by default for its metadata, thus the metadata is
written twice on top of the virtual disk provided by the RAID card).

I'd say, this already shows the raid card is doing something unexpected.

> Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): failed to read=
 block groups: -5
> Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): open_ctree fai=
led
>
>> You can try rescue=3Dall mount option, which has the extra handling on
>> corrupted extent tree.
>
>> Although you have to use kernels newer than v5.15 (including v5.15) to
>> benefit from the change.
>
> Unfortunately:
> amonra@charon:~$ uname -a
> Linux charon 5.4.0-113-generic #127-Ubuntu SMP Wed May 18 14:30:56 UTC 2=
022 x86_64 x86_64 x86_64 GNU/Linux

Any special reason that you can not even use a liveUSB to boot a newer
kernel to do the salvage?

 > It's a RAID 5 array hosted by an Adaptec ASR8885 (which thinks the
disk is "Optimal").

So I doubt if the card is doing something tricky with its cache or recover=
y.

Anyway for now what I can recommend is just find a way to run newer
kernel to utilize rescue=3Dall mount option.
Or btrfs-restore is the only solution.

Thanks,
Qu
