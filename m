Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30B39DBD0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 13:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFGL6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 07:58:21 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:42683 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFGL6U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 07:58:20 -0400
Received: by mail-ed1-f47.google.com with SMTP id i13so20002220edb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Jun 2021 04:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=92d+qusHSqVoGW0uUdNEmpvQk26VZIhWgGNucAMNnbM=;
        b=VdkSMIVHzwDICHYqQuGxV0crrN7l0qZrZHpl/ud1LWdpXUnCvIbU6oJHkZdR8/enzP
         Qx5tMcNoCAbekEhwMutU2bXReYlqZAl3YQTTsGsxm8EzLXf92kO+QT+X3pKHEw/GW0Vb
         0Evu9B0hUU+Jjzr+/YNIH6iuS5RMkSA5mnvKKlx4ub6Wox1dpYC6++wdbQBi/Jxva+h9
         4bahk5RPYnV8psn7c8xFYe5GPk04LLIflHSdiHl1AJ51rhKCaUiAVlvs1VXVcOgPxw2d
         sHVtqHDCV+zunjAVEufSyISOFS4Ek1NYQfmccUtuQhBPwnQd0c3bpjAd68FtL/AkYWlt
         u+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=92d+qusHSqVoGW0uUdNEmpvQk26VZIhWgGNucAMNnbM=;
        b=VyKAMV3eaeUvZ19DYEsTr9rVNtrpt/LDwdmxpa22yxrK5ofAYIfiz88SpcCSMzbEZN
         ZWtEprzAz3khOlCNDx3lagjW7SOdPh4A9GRDW8MrxWgGV1zLbM2gHaMUwsBVXEjurP5d
         1QhCHYW3BWwW+w7Ol4n6Ni0CXTrZMsbGrgRewwXD1+hioK9oIYhPYD/i95wJcPYC3XJ1
         hqjcA5DUnzA9ffCXW9Rj8bwn7I3c+g08CXChx5yEkR5ezA6WHmEAZBf2quky5e+zmQHo
         /Wt+gM9ZwyQaQ9OSvq+BubR6LSYGBgaQ/561uON/KRiFtg7NS8sWFBAT73o8SKppj10t
         q3Ng==
X-Gm-Message-State: AOAM531d+LmEx/NWBUushfKdoL8r+Akgd880rgbuyo9fxJUsP3meIS/j
        LdpOzuCfKBGP7293c4a8GgFt6PfmNj8=
X-Google-Smtp-Source: ABdhPJxKc9oPHznsiQlNYoUu6o6Qh0iezZU1rj0rLv/ZBlkDV8ipf6NgYEywxUJN6DCfiOILAQCB+Q==
X-Received: by 2002:aa7:c547:: with SMTP id s7mr19307198edr.239.1623066912501;
        Mon, 07 Jun 2021 04:55:12 -0700 (PDT)
Received: from localhost.localdomain (ppp046176007146.access.hol.gr. [46.176.7.146])
        by smtp.gmail.com with ESMTPSA id t5sm6444020eje.29.2021.06.07.04.55.10
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:55:12 -0700 (PDT)
From:   auxsvr@gmail.com
To:     linux-btrfs@vger.kernel.org
Subject: Re: Write time tree block corruption detected
Date:   Mon, 07 Jun 2021 14:55:10 +0300
Message-ID: <3113674.aeNJFYEL58@localhost.localdomain>
In-Reply-To: <1861574.PYKUYFuaPT@localhost.localdomain>
References: <1861574.PYKUYFuaPT@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Monday, 31 May 2021 00:30:00 EEST auxsvr@gmail.com wrote:
> Hello,
> 
> On linux 5.3.18-lp152.75-default (openSUSE 15.2), I got the following error message:
> 
> [33573.070335] BTRFS critical (device sda2): corrupt leaf: root=3 block=531135201280 slot=0 devid=1 invalid bytes used: have 64503152640 expect [0, 64424509440]
> [33573.070338] BTRFS error (device sda2): block=531135201280 write time tree block corruption detected 
> [33573.071909] BTRFS: error (device sda2) in btrfs_commit_transaction:2264: errno=-5 IO failure (Error while writing out transaction) 
> [33573.071911] BTRFS info (device sda2): forced readonly 
> [33573.071913] BTRFS warning (device sda2): Skipping commit of aborted transaction. 
> [33573.071915] BTRFS: error (device sda2) in cleanup_transaction:1823: errno=-5 IO failure 
> [33573.071917] BTRFS info (device sda2): delayed_refs has NO entry 
> [33577.283856] BTRFS info (device sda2): delayed_refs has NO entry

After using btrfs check --repair /dev/sda2:

ref mismatch on [184344514560 4096] extent item 1024, found 0
owner ref check failed [184344514560 4096]
repair deleting extent record: key 184344514560 168 4096 
Repaired extent references for 184344514560
Dev extent's total-byte(61236838400) is not equal to byte-used(63451430912) in dev[1, 216, 1]

without resolving the issue, as the filesystem would still become read-only, I deleted all snapshots and there hasn't been an issue for a few hours of heavy use. However, btrfs check still returns the error regarding size mismatch and this worries me a bit. Is there an easy way to resolve this or should I recreate the filesystem?

It seems that every time free space is less than 1 GiB and I use zypper, I get a similar corruption message. Thankfully, there hasn't been any data loss so far. There's also a backup of the filesystem right after the first incident, in case it is useful for further investigation.

Regards,
Petros


