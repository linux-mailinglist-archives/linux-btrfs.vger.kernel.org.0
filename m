Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1A5F61C4
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2019 23:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfKIWlL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Nov 2019 17:41:11 -0500
Received: from mail.rptsys.com ([23.155.224.45]:40404 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfKIWlK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 Nov 2019 17:41:10 -0500
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Nov 2019 17:41:10 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id D069CBE3E2BB4
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Nov 2019 16:33:30 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FlTVjvg9m3If for <linux-btrfs@vger.kernel.org>;
        Sat,  9 Nov 2019 16:33:30 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 4E6A9BE3E2AB8
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Nov 2019 16:33:30 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 4E6A9BE3E2AB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1573338810; bh=V5oCJ2TAnxokhB8fNbL6dDkRb40TRCBgZ1ahGTxwWmo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=M1C5tf88Gjy+V7zkDM/Hrq90GE1ZJwOOLnQJNOtAG+ntJxpHvsaVoTv5roesD9Ngi
         YifMAAE3qhgBnBiInD8nzMZU+Yabgx7ptaQ1BEy5G/JRUXzkeIHEp1NLx5T2QzJf6+
         NdUDQgGrKVomEsw5jQLTMd+dBEHOHmrUwFk0T5tA=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PH2SslMnrJLK for <linux-btrfs@vger.kernel.org>;
        Sat,  9 Nov 2019 16:33:30 -0600 (CST)
Received: from vali.starlink.edu (vali.starlink.edu [192.168.3.21])
        by mail.rptsys.com (Postfix) with ESMTP id 277F0BE3E2A63
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Nov 2019 16:33:30 -0600 (CST)
Date:   Sat, 9 Nov 2019 16:33:29 -0600 (CST)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     linux-btrfs@vger.kernel.org
Message-ID: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Unusual crash -- data rolled back ~2 weeks?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC65 (Linux)/8.5.0_GA_3042)
Thread-Index: RXOsokHARtBw/xwBvljfwkDz5Lz3MA==
Thread-Topic: Unusual crash -- data rolled back ~2 weeks?
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We just experienced a very unusual crash on a Linux 5.3 file server using NFS to serve a BTRFS filesystem.  NFS went into deadlock (D wait) with no apparent underlying disk subsystem problems, and when the server was hard rebooted to clear the D wait the BTRFS filesystem remounted itself in the state that it was in approximately two weeks earlier (!).  There was also significant corruption of certain files (e.g. LDAP MDB and MySQL InnoDB) noted -- we restored from backup for those files, but are concerned about the status of the entire filesystem at this point.

We do not use subvolumes, snapshots, or any of the advanced features of BTRFS beyond the data checksumming.  I am at a loss as to how BTRFS could suddenly just "forget" about the past two weeks of written data and (mostly) cleanly roll back on the next mount without even throwing any warnings in dmesg.

Any thoughts on how this is possible, and if there is any chance of getting the lost couple weeks of data back, would be appreciated.

Thank you!
