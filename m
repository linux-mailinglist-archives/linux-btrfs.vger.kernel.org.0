Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550D15507E2
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 03:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiFSBgf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 18 Jun 2022 21:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSBge (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Jun 2022 21:36:34 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Jun 2022 18:36:28 PDT
Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645F7F58A
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jun 2022 18:36:28 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id 2joXotMdDAcBn2joYoaMyL; Sun, 19 Jun 2022 02:33:25 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JPUoDuGb c=1 sm=1 tr=0 ts=62ae7ce5
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=IkcTkHD0fZMA:10 a=7YfXLusrAAAA:8 a=P1kZ4gAsAAAA:8 a=VwQbUJbxAAAA:8
 a=cca9lVFy6zURa2d6bncA:9 a=QEXdDO2ut3YA:10 a=SLz71HocmBbuEhFRYD3r:22
 a=fn9vMg-Z9CMH7MoVPInU:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     "'Qu Wenruo'" <quwenruo.btrfs@gmx.com>,
        <linux-btrfs@vger.kernel.org>
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk> <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com>
In-Reply-To: <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com>
Subject: RE: Problems with BTRFS formatted disk
Date:   Sun, 19 Jun 2022 02:33:21 +0100
Message-ID: <000001d8837c$91bc74e0$b5355ea0$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE6G7yNOJVUJ6Zum7z6uCsu/gieNwG3iWv+roUAsKA=
Content-Language: en-gb
X-CMAE-Envelope: MS4xfN796lk8AzcIwuff4iG6YfeB0XYEttJC93j42Hz0BXNyjRKur2qBg2EwbDeNgOwnXYNlR4RcnF8WaQN9xL/jL9DUC1W3bMZFbCVf8fzzJjJMNpzjj9yd
 efTph+V6D0O+Z5vGOPQKWvsNMEXP+hW8be3+lDdfiJQON/wSo1NoNmT9EUpNXKd2Ib9M13IrnW+WFuDFnz7QGtEG1sZ32cCh9is=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I at least know when the problem happened - the power fail happened about 13:20:01 on May 26th:

May 26 12:00:01 charon CRON[1959806]: (root) CMD (mount -t btrfs -U c63bcf2b-e4e5-431f-b03d-36f822c68b53 /mnt/root && cd /mnt/root && btrfs-snaps hourly 3 | grep -Ev "$GREPOUT" ; cd / && umount /mnt/root)
May 26 12:00:01 charon CRON[1959808]: (smmsp) CMD (test -x /etc/init.d/sendmail && test -x /usr/share/sendmail/sendmail && test -x /usr/lib/sm.bin/sendmail && /usr/share/sendmail/sendmail cron-msp)
May 26 12:00:01 charon CRON[1959804]: pam_unix(cron:session): session closed for user smmsp
May 26 12:00:01 charon CRON[1959802]: pam_unix(cron:session): session closed for user root
May 26 12:00:01 charon systemd[1372]: mnt-shared.mount: Succeeded.
May 26 12:00:01 charon systemd[1074]: mnt-shared.mount: Succeeded.
May 26 12:00:01 charon systemd[1]: mnt-shared.mount: Succeeded.
May 26 12:00:03 charon CRON[1959803]: pam_unix(cron:session): session closed for user root
May 26 12:00:03 charon systemd[1]: mnt-root.mount: Succeeded.
May 26 12:00:03 charon systemd[1074]: mnt-root.mount: Succeeded.
May 26 12:00:03 charon systemd[1372]: mnt-root.mount: Succeeded.
May 26 12:05:01 charon CRON[1960480]: pam_unix(cron:session): session opened for user root by (uid=0)
May 26 12:05:01 charon CRON[1960481]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
May 26 12:05:01 charon CRON[1960480]: pam_unix(cron:session): session closed for user root
May 26 12:15:01 charon CRON[1961677]: pam_unix(cron:session): session opened for user root by (uid=0)
May 26 12:15:01 charon CRON[1961678]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
May 26 12:15:01 charon CRON[1961677]: pam_unix(cron:session): session closed for user root
May 26 12:17:01 charon CRON[1961923]: pam_unix(cron:session): session opened for user root by (uid=0)
May 26 12:17:01 charon CRON[1961924]: (root) CMD (   cd / && run-parts --report /etc/cron.hourly)
May 26 12:17:01 charon CRON[1961923]: pam_unix(cron:session): session closed for user root
May 26 12:20:01 charon CRON[1962284]: pam_unix(cron:session): session opened for user smmsp by (uid=0)
May 26 12:20:01 charon CRON[1962286]: (smmsp) CMD (test -x /etc/init.d/sendmail && test -x /usr/share/sendmail/sendmail && test -x /usr/lib/sm.bin/sendmail && /usr/share/sendmail/sendmail cron-msp)
May 26 12:20:01 charon CRON[1962284]: pam_unix(cron:session): session closed for user smmsp
May 26 12:25:01 charon CRON[1962904]: pam_unix(cron:session): session opened for user root by (uid=0)
May 26 12:25:01 charon CRON[1962906]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
May 26 12:25:01 charon CRON[1962904]: pam_unix(cron:session): session closed for user root
May 26 12:30:01 charon CRON[1963512]: pam_unix(cron:session): session opened for user root by (uid=0)
May 26 12:30:01 charon CRON[1963514]: (root) CMD ([ -x /etc/init.d/anacron ] && if [ ! -d /run/systemd/system ]; then /usr/sbin/invoke-rc.d anacron start >/dev/null; fi)
May 26 12:30:01 charon CRON[1963512]: pam_unix(cron:session): session closed for user root
May 26 12:33:01 charon systemd[1]: Started Run anacron jobs.
May 26 12:33:01 charon anacron[1963871]: Anacron 2.3 started on 2022-05-26
May 26 12:33:01 charon anacron[1963871]: Normal exit (0 jobs run)
May 26 12:33:01 charon systemd[1]: anacron.service: Succeeded.
May 26 12:35:01 charon CRON[1964126]: pam_unix(cron:session): session opened for user root by (uid=0)
May 26 12:35:01 charon CRON[1964128]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
May 26 12:35:01 charon CRON[1964126]: pam_unix(cron:session): session closed for user root
May 26 12:40:01 charon CRON[1964736]: pam_unix(cron:session): session opened for user smmsp by (uid=0)
May 26 12:40:01 charon CRON[1964738]: (smmsp) CMD (test -x /etc/init.d/sendmail && test -x /usr/share/sendmail/sendmail && test -x /usr/lib/sm.bin/sendmail && /usr/share/sendmail/sendmail cron-msp)
May 26 12:40:01 charon CRON[1964736]: pam_unix(cron:session): session closed for user smmsp
May 26 12:45:01 charon CRON[1965359]: pam_unix(cron:session): session opened for user root by (uid=0)
May 26 12:45:01 charon CRON[1965361]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
May 26 12:45:01 charon CRON[1965359]: pam_unix(cron:session): session closed for user root
May 26 12:51:14 charon Radarr[866]: [Info] RssSyncService: Starting RSS Sync
May 26 12:51:16 charon Radarr[866]: [Info] DownloadDecisionMaker: Processing 100 releases
May 26 12:51:16 charon Radarr[866]: [Info] RssSyncService: RSS Sync Completed. Reports found: 100, Reports grabbed: 0
May 26 12:55:01 charon CRON[1966565]: pam_unix(cron:session): session opened for user root by (uid=0)
May 26 12:55:01 charon CRON[1966566]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
May 26 12:55:01 charon CRON[1966565]: pam_unix(cron:session): session closed for user root
May 26 13:00:01 charon CRON[1967160]: pam_unix(cron:session): session opened for user smmsp by (uid=0)
May 26 13:00:01 charon CRON[1967161]: (smmsp) CMD (test -x /etc/init.d/sendmail && test -x /usr/share/sendmail/sendmail && test -x /usr/lib/sm.bin/sendmail && /usr/share/sendmail/sendmail cron-msp)
May 26 13:00:01 charon CRON[1967160]: pam_unix(cron:session): session closed for user smmsp
May 26 13:05:01 charon CRON[1967787]: pam_unix(cron:session): session opened for user root by (uid=0)
May 26 13:05:01 charon CRON[1967789]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
May 26 13:05:01 charon CRON[1967787]: pam_unix(cron:session): session closed for user root
May 26 13:15:01 charon CRON[1968995]: pam_unix(cron:session): session opened for user root by (uid=0)
May 26 13:15:01 charon CRON[1968996]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
May 26 13:15:01 charon CRON[1968995]: pam_unix(cron:session): session closed for user root
May 26 13:17:01 charon CRON[1969237]: pam_unix(cron:session): session opened for user root by (uid=0)
May 26 13:17:01 charon CRON[1969238]: (root) CMD (   cd / && run-parts --report /etc/cron.hourly)
May 26 13:17:01 charon CRON[1969237]: pam_unix(cron:session): session closed for user root
May 26 13:20:01 charon CRON[1969603]: pam_unix(cron:session): session opened for user smmsp by (uid=0)
May 26 13:20:01 charon CRON[1969605]: (smmsp) CMD (test -x /etc/init.d/sendmail && test -x /usr/share/sendmail/sendmail && test -x /usr/lib/sm.bin/sendmail && /usr/share/sendmail/sendmail cron-msp)
May 26 13:20:01 charon CRON[1969603]: pam_unix(cron:session): session closed for user smmsp
The next btrfs log data follows immediately (well actually a week or so later as I hadn't rebooted since) ☹
-- Reboot --
    Messages deleted
Jun 18 15:20:12 charon kernel: Btrfs loaded, crc32c=crc32c-intel
Jun 18 15:20:12 charon kernel: BTRFS: device fsid 4fc521d7-c18f-4cb3-9eac-d9d367e2b0eb devid 1 transid 130613 /dev/sdb1
Jun 18 15:20:12 charon kernel: BTRFS: device fsid c63bcf2b-e4e5-431f-b03d-36f822c68b53 devid 1 transid 5607929 /dev/sda2
Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): flagging fs with big metadata feature
Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): disk space caching is enabled
Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): has skinny extents
Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): enabling ssd optimizations
Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): enabling auto defrag
Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): turning on discard
Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): use lzo compression, level 0
Jun 18 15:20:12 charon kernel: BTRFS info (device sda2): disk space caching is enabled
Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): flagging fs with big metadata feature
Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): disk space caching is enabled
Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): has skinny extents
Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): parent transid verify failed on 12554306306048 wanted 130605 found 127414
Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corrected: ino 0 off 12554306306048 (dev /dev/sdb1 sector 1007336416)
Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corrected: ino 0 off 12554306310144 (dev /dev/sdb1 sector 1007336424)
Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corrected: ino 0 off 12554306314240 (dev /dev/sdb1 sector 1007336432)
Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corrected: ino 0 off 12554306318336 (dev /dev/sdb1 sector 1007336440)
Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): parent transid verify failed on 12554682138624 wanted 129690 found 127567
Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corrected: ino 0 off 12554682138624 (dev /dev/sdb1 sector 1008070464)
Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corrected: ino 0 off 12554682142720 (dev /dev/sdb1 sector 1008070472)
Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corrected: ino 0 off 12554682146816 (dev /dev/sdb1 sector 1008070480)
Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corrected: ino 0 off 12554682150912 (dev /dev/sdb1 sector 1008070488)
Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): parent transid verify failed on 12554682155008 wanted 129690 found 127567
Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corrected: ino 0 off 12554682155008 (dev /dev/sdb1 sector 1008070496)
Jun 18 15:20:18 charon kernel: BTRFS info (device sdb1): read error corrected: ino 0 off 12554682159104 (dev /dev/sdb1 sector 1008070504)
Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): parent transid verify failed on 12554992156672 wanted 130582 found 127355
Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): parent transid verify failed on 12554992156672 wanted 130582 found 127355
Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): failed to read block groups: -5
Jun 18 15:20:18 charon kernel: BTRFS error (device sdb1): open_ctree failed 

>You can try rescue=all mount option, which has the extra handling on
>corrupted extent tree.

>Although you have to use kernels newer than v5.15 (including v5.15) to
>benefit from the change.

Unfortunately: 
amonra@charon:~$ uname -a
Linux charon 5.4.0-113-generic #127-Ubuntu SMP Wed May 18 14:30:56 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux



-----Original Message-----
From: Qu Wenruo <quwenruo.btrfs@gmx.com> 
Sent: 19 June 2022 00:00
To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger.kernel.org
Subject: Re: Problems with BTRFS formatted disk



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
> option, bad superblock on /dev/sdb1, missing codepage or helper program, or
> othe>
> Jun 18 15:40:27 charon systemd[1]: shared.mount: Mount process exited,
> code=exited, status=32/n/a
> Jun 18 15:40:27 charon systemd[1]: shared.mount: Failed with result
> 'exit-code'.
> Jun 18 15:40:27 charon systemd[1]: Failed to mount /shared.
> Jun 18 15:40:27 charon kernel: BTRFS error (device sdb1): open_ctree failed
>
> I tried:
> root@charon:/home/amonra# btrfs check /dev/sdb1
> Opening filesystem to check...
> parent transid verify failed on 12554992156672 wanted 130582 found 127355
> parent transid verify failed on 12554992156672 wanted 130582 found 127355
> parent transid verify failed on 12554992156672 wanted 130582 found 127355
> Ignoring transid failure
> leaf parent key incorrect 12554992156672
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
> root@charon:/home/amonra# btrfs check -s 1 /dev/sdb1
> using SB copy 1, bytenr 67108864
> Opening filesystem to check...
> parent transid verify failed on 12554992156672 wanted 130582 found 127355
> parent transid verify failed on 12554992156672 wanted 130582 found 127355
> parent transid verify failed on 12554992156672 wanted 130582 found 127355
> Ignoring transid failure
> leaf parent key incorrect 12554992156672
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
> root@charon:/home/amonra# btrfs check -s 2 /dev/sdb1
> using SB copy 2, bytenr 274877906944
> Opening filesystem to check...
> parent transid verify failed on 12554992156672 wanted 130582 found 127355
> parent transid verify failed on 12554992156672 wanted 130582 found 127355
> parent transid verify failed on 12554992156672 wanted 130582 found 127355
> Ignoring transid failure
> leaf parent key incorrect 12554992156672
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
> root@charon:/home/amonra#
>
> but that didn't achieve much.
>
> Following advice I tried: btrfs rescue zero-log which appeared to work, but
> attempt to mount afterwards gave me:
>
> Jun 18 18:58:38 charon kernel: BTRFS info (device sdb1): flagging fs with
> big metadata feature
> Jun 18 18:58:38 charon kernel: BTRFS info (device sdb1): disk space caching
> is enabled
> Jun 18 18:58:38 charon kernel: BTRFS info (device sdb1): has skinny extents
> Jun 18 18:58:39 charon kernel: BTRFS error (device sdb1): parent transid
> verify failed on 12554992156672 wanted 130582 found 127355
> Jun 18 18:58:39 charon kernel: BTRFS error (device sdb1): parent transid
> verify failed on 12554992156672 wanted 130582 found 127355
> Jun 18 18:58:39 charon kernel: BTRFS error (device sdb1): failed to read
> block groups: -5
> Jun 18 18:58:39 charon kernel: BTRFS error (device sdb1): open_ctree failed
>
> In desperation I tried: btrfs check --repair which gave me:
>
> Opening filesystem to check...
> parent transid verify failed on 12554992156672 wanted 130582 found 127355
> parent transid verify failed on 12554992156672 wanted 130582 found 127355
> parent transid verify failed on 12554992156672 wanted 130582 found 127355
> Ignoring transid failure
> leaf parent key incorrect 12554992156672
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
>
> So what do I do now?  I don't have a disk large enough to attempt btrfs
> restore (if that would even work).  I don't have a backup of this volume as
> this is my backup disk.

You can try rescue=all mount option, which has the extra handling on
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

