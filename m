Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A934A8899
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 17:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345034AbiBCQbN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 11:31:13 -0500
Received: from use.bitfolk.com ([85.119.80.223]:35539 "EHLO mail.bitfolk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232725AbiBCQbN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Feb 2022 11:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com
        ; s=alpha; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender
        :Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=W00kaXPnZ+kI1ZLeZElRWAWQr7Xp5zZUTRAx+2MZQMo=; b=Ln6OrEvFsHTG8Ce5eKzKJjqFKP
        A/vdYkTnXogyxHhUFIfWmMdUlx9ScVuOpCr+wZsNvBUmhEq/zUHneXAhjRA1Fl9SzIFVG/vuL8DA0
        vvgW+TDraK/7abPTCJGF5bAKbuUMIsw2eyD/Lv33bfEi/w1Vd7AQt973fQisBgtR9uHfaDosNmCKv
        Fh4GT4QzbNcC5Dn9kkg8Q9hXqrPIvpIOf4LJ1iNeci1VTM/Bj89UukqfIT4aQx/48HdQ0Qs0H0xT7
        AcDvZm5t8KSkTs1iy842tzMJxRcUkgMus2N2TyB/Zqg2WC4siFUVk0pVV1hWrBxF2GGNLcH80WXLI
        iMCNNR8g==;
Received: from andy by mail.bitfolk.com with local (Exim 4.89)
        (envelope-from <andy@strugglers.net>)
        id 1nFf0m-0003CX-SS
        for linux-btrfs@vger.kernel.org; Thu, 03 Feb 2022 16:31:08 +0000
Date:   Thu, 3 Feb 2022 16:31:08 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-btrfs@vger.kernel.org
Subject: "Too many links (31)" issue
Message-ID: <20220203163108.ipdv3yxbe7eb6vc4@bitfolk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL:  http://strugglers.net/wiki/User:Andy
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a host with an xfs filesystem on it, with about 25 million
files. It contains an rsnapshot backup that has been aggressively
deduplicated by means of hardlinks and there's probably only about 7
million unique files on there.

I'm trying to rsync it to a different host into a btrfs filesystem,
but part way through the rsync I get a "Too many links (31)" error:

rsync: [generator] link "/data/backup/rsnapshot/daily.0/chacha/var/lib/dpkg/info/.apt-utils.postrm.0" => daily.0/backup1/var/lib/dpkg/info/libpango1.0-0.postrm failed: Too many links (31)
Hlink node data for 219191 already has path=daily.0/backup1/var/lib/dpkg/info/libpango1.0-0.postrm (daily.0/chacha/var/lib/dpkg/info/apt-utils.postrm)
rsync error: errors with program diagnostics (code 13) at hlink.c(539) [generator=3.2.3]

I searched around on this topic and found hits from 10 years ago
about maximum hardlinks per directory and being dependent upon
length of file path. Is that still relevant today?

This particular file does indeed have a huge number of hardlinks:

$ stat daily.0/chacha/var/lib/dpkg/info/apt-utils.postrm
  File: daily.0/chacha/var/lib/dpkg/info/apt-utils.postrm
  Size: 132             Blocks: 8          IO Block: 4096   regular file
Device: fd05h/64773d    Inode: 1342355538  Links: 7565
Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-02-03 04:51:29.978915067 +0000
Modify: 2011-03-01 21:59:29.000000000 +0000
Change: 2022-01-01 17:35:06.598921506 +0000
 Birth: -
$ sudo find . -mount -samefile daily.0/chacha/var/lib/dpkg/info/apt-utils.postrm | wc -l
7565

I guess it is some sort of template file that is littered all over
Debian systems.

Is there anything I can do to get this working?

The receiving host with the btrfs filesystem is Debian 11
(bullseye), stock Debian kernel 5.10.0-11-amd64. The btrfs
filesystem is mounted with options:

/dev/mapper/backupenc on /data/backup type btrfs (rw,noatime,compress=zstd:15,space_cache,subvolid=5,subvol=/)

As an aside, when the file is as small as 132 bytes is there
actually any advantage in hardlinking copies of it together rather
than just having multiple copies of it? Is there some minimum
file size where it's just not worth it?

(Yes I am aware of offline deuplication which works in XFS as well,
it's just that where the files are known to be entirely identical
I've found that simply hardlinking them together was faster and
easier.)

Cheers,
Andy
