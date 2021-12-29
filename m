Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA5B4816E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Dec 2021 22:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhL2VAK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Dec 2021 16:00:10 -0500
Received: from mail2.intellasoft.net ([64.120.46.178]:42787 "EHLO
        mail.bluekaba.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229754AbhL2VAJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Dec 2021 16:00:09 -0500
X-Greylist: delayed 1761 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Dec 2021 16:00:09 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=intellasoft.net; s=20190502; h=Content-Transfer-Encoding:Content-Type:
        Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I9BktkYaXb3zNSSxuvMlmHJ66p+LreA4bRtAJf0dhmc=; b=Nc35xl+rpr79dszIrmtYAG+Z7b
        4Gi8n+5MokmPlXGhpUp4KO3RY3eDDb06VgOCQooT/+6711LoihSKw+OTrZz2R82KDMwepQKy9bX24
        SbuwcNBk2moSwGVPLE1VtsRAQZf9bYxDKpyV0Uuwu0JUr5eEgnxS11c7A7/nHPSfq+hYOF4hWc+Bb
        rDzSttdUugZE4aiE4uxfc/ltiB+IlOrQFfCO+mdY+OBT+tFCMorB7wikpU8Kucpcw7GZlzdtTbve4
        bZ9/7qnX4IHzkPSQt2ii3lSZlHN1PSEahLo9rlVO5kuLF5HZlRSReA9YbQWa0mpnBIH2vlTZyriHv
        EN7ZXREA==;
Message-ID: <41c94bee-eb97-a280-21c3-bcfe216f078d@intellasoft.net>
Date:   Wed, 29 Dec 2021 15:30:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
To:     linux-btrfs@vger.kernel.org
Content-Language: en-US
From:   Mark Murawski <markm-lists@intellasoft.net>
Subject: BTRFS FS corruption
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Kernel: Debian 5.10.70-1~bpo10+1 (2021-10-10)


# ls -al /mnt/var/lib/postgresql/12/main/pg_stat_tmp/
ls: cannot access 
'/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file 
or directory
ls: cannot access 
'/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file 
or directory
ls: cannot access 
'/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file 
or directory
ls: cannot access 
'/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file 
or directory
ls: cannot access 
'/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file 
or directory
ls: cannot access 
'/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file 
or directory
ls: cannot access 
'/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file 
or directory
ls: cannot access 
'/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file 
or directory
ls: cannot access 
'/mnt/var/lib/postgresql/12/main/pg_stat_tmp/global.tmp': No such file 
or directory
total 80
drwx------ 1 1001 1001   94 Dec 29 13:52 .
drwx------ 1 1001 1001  552 Dec 29 13:51 ..
-rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
-rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
-rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
-rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
-rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
-rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
-rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
-rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
-rw------- 1 1001 1001 1526 Dec 29 13:52 db_0.stat
-rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
-rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
-rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
-rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
-rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
-rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
-rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
-rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
-rw------- 1 1001 1001    0 Dec 29 13:52 db_106964.stat
-rw------- 1 1001 1001 1864 Dec 29 13:52 db_16391.stat
-rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
-rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
-rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
-rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
-rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
-rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
-rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
-rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
-rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
-rw------- 1 1001 1001  840 Dec 29 13:52 global.stat
-????????? ? ?    ?       ?            ? global.tmp
-????????? ? ?    ?       ?            ? global.tmp
-????????? ? ?    ?       ?            ? global.tmp
-????????? ? ?    ?       ?            ? global.tmp
-????????? ? ?    ?       ?            ? global.tmp
-????????? ? ?    ?       ?            ? global.tmp
-????????? ? ?    ?       ?            ? global.tmp
-????????? ? ?    ?       ?            ? global.tmp
-????????? ? ?    ?       ?            ? global.tmp

This is a dev/test vm so we can do intrusive operations on it...

Should I run btrfsck?

btrfs scrub did not show any errors/fixes and it did not fix the issue.

