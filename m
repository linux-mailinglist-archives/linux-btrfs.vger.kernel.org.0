Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4456994F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 06:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiGGEkc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 00:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGGEka (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 00:40:30 -0400
Received: from out20-63.mail.aliyun.com (out20-63.mail.aliyun.com [115.124.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BC12F00E
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 21:40:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04566672|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.156852-0.00601905-0.837129;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.OM82YmC_1657168818;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OM82YmC_1657168818)
          by smtp.aliyun-inc.com;
          Thu, 07 Jul 2022 12:40:18 +0800
Date:   Thu, 07 Jul 2022 12:40:20 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC 00/11] btrfs: introduce write-intent bitmaps for RAID56
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <ebdc96e3-56f8-37e3-dba1-79622c860e2a@gmx.com>
References: <20220707122446.98D1.409509F4@e16-tech.com> <ebdc96e3-56f8-37e3-dba1-79622c860e2a@gmx.com>
Message-Id: <20220707124019.98D5.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 2022/7/7 12:24, Wang Yugui wrote:
> > Hi,
> >
> >> [BACKGROUND]
> >> Unlike md-raid, btrfs RAID56 has nothing to sync its devices when power
> >> loss happens.
> >>
> >> For pure mirror based profiles it's fine as btrfs can utilize its csums
> >> to find the correct mirror the repair the bad ones.
> >>
> >> But for RAID56, the repair itself needs the data from other devices,
> >> thus any out-of-sync data can degrade the tolerance.
> >>
> >> Even worse, incorrect RMW can use the stale data to generate P/Q,
> >> removing the possibility of recovery the data.
> >>
> >>
> >> For md-raid, it goes with write-intent bitmap, to do faster resilver,
> >> and goes journal (partial parity log for RAID5) to ensure it can even
> >> stand a powerloss + device lose.
> >>
> >> [OBJECTIVE]
> >>
> >> This patchset will introduce a btrfs specific write-intent bitmap.
> >>
> >> The bitmap will locate at physical offset 1MiB of each device, and the
> >> content is the same between all devices.
> >>
> >> When there is a RAID56 write (currently all RAID56 write, including full
> >> stripe write), before submitting all the real bios to disks,
> >> write-intent bitmap will be updated and flushed to all writeable
> >> devices.
> >>
> >> So even if a powerloss happened, at the next mount time we know which
> >> full stripes needs to check, and can start a scrub for those involved
> >> logical bytenr ranges.
> >>
> >> [NO RECOVERY CODE YET]
> >>
> >> Unfortunately, this patchset only implements the write-intent bitmap
> >> code, the recovery part is still a place holder, as we need some scrub
> >> refactor to make it only scrub a logical bytenr range.
> >>
> >> [ADVANTAGE OF BTRFS SPECIFIC WRITE-INTENT BITMAPS]
> >>
> >> Since btrfs can utilize csum for its metadata and CoWed data, unlike
> >> dm-bitmap which can only be used for faster re-silver, we can fully
> >> rebuild the full stripe, as long as:
> >>
> >> 1) There is no missing device
> >>     For missing device case, we still need to go full journal.
> >>
> >> 2) Untouched data stays untouched
> >>     This should be mostly sane for sane hardware.
> >>
> >> And since the btrfs specific write-intent bitmaps are pretty small (4KiB
> >> in size), the overhead much lower than full journal.
> >>
> >> In the future, we may allow users to choose between just bitmaps or full
> >> journal to meet their requirement.
> >>
> >> [BITMAPS DESIGN]
> >>
> >> The bitmaps on-disk format looks like this:
> >>
> >>   [ super ][ entry 1 ][ entry 2 ] ... [entry N]
> >>   |<---------  super::size (4K) ------------->|
> >>
> >> Super block contains how many entires are in use.
> >>
> >> Each entry is 128 bits (16 bytes) in size, containing one u64 for
> >> bytenr, and u64 for one bitmap.
> >>
> >> And all utilized entries will be sorted in their bytenr order, and no
> >> bit can overlap.
> >>
> >> The blocksize is now fixed to BTRFS_STRIPE_LEN (64KiB), so each entry
> >> can contain at most 4MiB, and the whole bitmaps can contain 224 entries.
> >
> > Can we skip the write-intent bitmap log if we already log it in last N records
> > (logrotate aware) to improve the write performance?  because HDD sync
> > IOPS is very small.
> 
> I'm not aware about the logrotate idea you mentioned, mind to explain it
> more?
> 
> But the overall idea of journal/write-intent bitmaps are, always ensure
> there is something recording the full write or the write-intention
> before the real IO is submitted.
> 
> So I'm afraid such behavior can not be changed much.

The basic idea is that we recover the data by scrub, not full log,
so log *1 is same to log *2, but with less IOPS?

log *1
	write(0-64K) log
	wirte(64K-128K) log
	wirte(128K-192K) log
	wirte(192K-256K) log
log *2
	write(0-256K) log
	already write(0-256K), skip
	already write(0-256K), skip
	already write(0-256K), skip

we can search the entry we currently used, but can not search the prev
entry, because it maybe be logrotated?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/07/07

