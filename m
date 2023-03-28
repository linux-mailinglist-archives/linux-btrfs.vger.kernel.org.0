Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BEE6CBB5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 11:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjC1Jn7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 05:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjC1Jnm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 05:43:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23016180;
        Tue, 28 Mar 2023 02:43:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso14585124pjb.0;
        Tue, 28 Mar 2023 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679996620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuYJOgB/Dmhv47XSl2ckTIc/uA1Kmsda9qm/B6O6/dc=;
        b=MANHCfbNZfxdzBEvskYzIdXtZhozBv8agcjjwAEmmsP+bzdRCYNFZVo7HVbSKNsdaf
         O5aFnNwPI6OrTT21HwtH56pRV01KVgFn9MiD2xRpoEEOQ4YjQmdT9HGt7i2rPxij4DTH
         32xnWSdJWJQY1lODUIICbAP5bneA/ybGOGJOJTaerEFrJ5tT4o7tjnNGHhUN+XDHSfg6
         liNHFNwjXaJvJBYwhcev0x7iOI2qgbcxOoz2LAJ63JL87dKfb6aYw4WgTQW8nlNXPBGH
         KweFpNmluhYLoY7CzsLUl9TJAxrrLy5DHEGAu4RTbEa4GrT0oVv8n3GF1WpjpqVqeCpR
         xX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679996620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuYJOgB/Dmhv47XSl2ckTIc/uA1Kmsda9qm/B6O6/dc=;
        b=oWPh9VpV18p63wwc73TfCh9TfHIuOjVM9QiDW1fHFNapNNJ3o2zzAPLLIlg74zQPTS
         +HeNr/nrsPjkBvJTm4bbH4Zk0rZWCzNlgwtofVfp2w/LLZdv5xPULnNbRICRu6oVnTfk
         2g4LnerPFgEm5tMaumuRbwkL9dfj/iBqhlkM4akWyDVEJlLbl348jndMNL2Vr8mkvR6q
         F5+1GEZrklzpPLApwxYll/mbogKbBlXqGwV65UFqzdSRJpa177/pB0/M+93QqLiKbPoo
         9IRdF6c1X8+R2qT8l5mOcSE1u4iqxhgPRly2UnOZm62nptIu6QKluAEISSPWOBzYMLdw
         BL9A==
X-Gm-Message-State: AAQBX9fa85Wh9Y1vw5y7By55aawo7vB53l3AQiPhZXeg3xY+13Gx+wAJ
        zL1ehpi3C0lyTeORrzLK3N8JI2seSzgOOQ==
X-Google-Smtp-Source: AKy350ZyFfQVPnSpmXXn9PH/3fmwbC31wr/18pVzQjwDey45zh0Jig+1DTLqbZpLbgKauRDkXQJDEQ==
X-Received: by 2002:a17:902:c406:b0:1a2:333f:e19f with SMTP id k6-20020a170902c40600b001a2333fe19fmr13830438plk.11.1679996619825;
        Tue, 28 Mar 2023 02:43:39 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id b20-20020a170902d89400b001a217a7a11csm7956600plz.131.2023.03.28.02.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:43:39 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     dsterba@suse.cz
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui@ruijie.com.cn
Subject: Re: [PATCH] btrfs: ioctl: fix inaccurate determination of exclusive_operation
Date:   Tue, 28 Mar 2023 05:43:35 -0400
Message-Id: <20230328094335.107562-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230327230553.GJ10580 () twin ! jikos ! cz>
References: <20230327230553.GJ10580 () twin ! jikos ! cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Have you found some bug with the above or is there other combination of
> the exclusive operations that should not work? The changes to the state
> values are the same, besides the wrong locking.

Yes, there is a racy bewteen btrfs_exclop_balance and btrfs_exclop_finish
in btrfs_ioctl_add_dev, when cocurrently adding multiple devices to the
same mnt point. That will cause the assertion in btrfs_exclop_balance to fail.

> void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
> 			  enum btrfs_exclusive_operation op)
> {
> 	switch (op) {
> 	case BTRFS_EXCLOP_BALANCE_PAUSED:
> 		spin_lock(&fs_info->super_lock);
> 		ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
> 		       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);

when btrfs_exclop_finish function was executed before the ASSERT, the
fs_info->exclusive_operation will change to BTRFS_EXCLOP_NONE. So this
assert will failed.


We can easily reproduce it with the following code.

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/btrfs.h>
#include <pthread.h>
#include <errno.h>
#include <dirent.h>
#include <string.h>

static int fd;
static int i;
static int controller = 0;
static int random_delay1 = 0;
static int random_delay2 = 0;
//const static int delta = 10000;


static pthread_t thread_id[10];
static char *path = "/dev/vda";
static char *btrfsmntpt = "/mnt/my_btrfs";


void prepare_random()
{
    random_delay1 = rand() % 80;
    random_delay2 = rand() % 20;
}

void *thr1(void *arg) {
    int ret;
    while(!controller);
    //usleep(delta);
    usleep(random_delay1);

    ret = ioctl(fd, BTRFS_IOC_ADD_DEV, 0);
    if (ret != 0) {
        printf("Failed to add device %s, errno %d\n", path, errno);
        return NULL;
    }
    printf("Device %s added successfully\n", path);
    return NULL;

}

void *thr2(void *arg) {
    int ret;
    while(!controller);
    usleep(random_delay2);
    ret = ioctl(fd, BTRFS_IOC_ADD_DEV, 0);
    if (ret != 0) {
        printf("Failed to add device %s, errno %d\n", path, errno);
        return NULL;
    }
    printf("Device %s added successfully\n", path);
    return NULL;
}



int main(int argc, char **argv) {

    DIR * dir;
    pthread_t th1, th2;
    srand(time(NULL));

    while(1) {
        controller = 0;
        //prepare random delay
        prepare_random();

        dir = opendir(btrfsmntpt);
        if (!dir) {
            printf("Failed to open btrfs mount point %s, errno %d\n", btrfsmntpt, errno);
            return 1;
        }
        fd = dirfd(dir);
        if (fd < 0) {
            printf("Failed to get directory stream file descriptor, errno %d\n", errno);
            return 1;
        }

        pthread_create(&th2, NULL, thr2, NULL);
        pthread_create(&th1, NULL, thr1, NULL);
        // pthread_create(&th2, NULL, closing_thread, &test);

        controller = 1; // start

        pthread_join(th1, NULL);
        pthread_join(th2, NULL);

        closedir(dir);
        close(fd);
    }
    return 0;
}


The procedure to reproduce the problem:
1、mount a device to /mnt/my_btrfs;
2、excute the above compiled repro;


The log of my test:
root@syzkaller:/home/xsk# mount btrfs.img /mnt/my_btrfs/
root@syzkaller:/home/xsk# mount
/dev/sda on / type ext4 (rw,relatime)
....
/home/xsk/btrfs.img on /mnt/my_btrfs type btrfs (rw,relatime,discard=async,space_cache,subvolid=5,subvol=/)
root@syzkaller:/home/xsk# ./repro 
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add device /dev/vda, errno 14
Failed to add de[   69.838916][ T8108] assertion failed: fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE || fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD, in fs/btrfs/ioctl.c:456
vice /dev/vd[a ,   e69.840759][ T8108] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
9rn[o   1 46
.841461][ T8108] CPU: 0 PID: 8108 Comm: repro Not tainted 6.2.0 #5
[   69.842245][ T8108] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   69.843292][ T8108] RIP: 0010:btrfs_assertfail+0x2c/0x2e
[   69.843899][ T8108] Code: 1f 00 41 55 41 89 d5 41 54 49 89 f4 55 48 89 fd e8 b9 84 e8 f7 44 89 e9 4c 89 e2 48 89 ee 48 c7 c7 20 af 54 8a e8 cb 49 f3 ff <0f> 0b 66 0f 1f 00 55 48 89 fd e8 95 84 e8 f7 48 89 ef 5d 48 c7 c6
[   69.845934][ T8108] RSP: 0018:ffffc90005f1fe28 EFLAGS: 00010282
[   69.846588][ T8108] RAX: 0000000000000097 RBX: 0000000000000000 RCX: 0000000000000000
[   69.847426][ T8108] RDX: ffff88801e8b2440 RSI: ffffffff81637e7c RDI: fffff52000be3fb7
[   69.848267][ T8108] RBP: ffffffff8a533d80 R08: 0000000000000097 R09: 0000000000000000
[   69.849103][ T8108] R10: 0000000080000001 R11: 0000000000000001 R12: ffffffff8a533d40
[   69.849945][ T8108] R13: 00000000000001c8 R14: 000000005000940a R15: 0000000000000000
[   69.850792][ T8108] FS:  00007ff3e2004640(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
[   69.851747][ T8108] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   69.852457][ T8108] CR2: 0000000000000000 CR3: 00000000182c8000 CR4: 0000000000750ef0
[   69.853311][ T8108] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   69.854167][ T8108] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   69.854935][ T8108] PKRU: 55555554
[   69.855263][ T8108] Call Trace:
[   69.855575][ T8108]  <TASK>
[   69.855851][ T8108]  btrfs_exclop_balance+0x13c/0x310
[   69.856337][ T8108]  ? memdup_user+0xab/0xc0
[   69.856749][ T8108]  ? PTR_ERR+0x17/0x20
[   69.857138][ T8108]  btrfs_ioctl_add_dev+0x2ee/0x320
[   69.857716][ T8108]  btrfs_ioctl+0x9d5/0x10d0
[   69.858222][ T8108]  ? btrfs_ioctl_encoded_write+0xb80/0xb80
[   69.858801][ T8108]  __x64_sys_ioctl+0x197/0x210
[   69.859253][ T8108]  do_syscall_64+0x3c/0xb0
[   69.859668][ T8108]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   69.860217][ T8108] RIP: 0033:0x4546af
[   69.860582][ T8108] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
[   69.862533][ T8108] RSP: 002b:00007ff3e2004150 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   69.863299][ T8108] RAX: ffffffffffffffda RBX: 00007ff3e2004640 RCX: 00000000004546af
[   69.864025][ T8108] RDX: 0000000000000000 RSI: 000000005000940a RDI: 0000000000000003
[   69.864739][ T8108] RBP: 00007ff3e20041d0 R08: 0000000000000000 R09: 00007ffd746cf81f
[   69.865528][ T8108] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff3e2004640
[   69.866375][ T8108] R13: 0000000000000009 R14: 000000000041b320 R15: 00007ff3e1804000
[   69.867115][ T8108]  </TASK>
[   69.867411][ T8108] Modules linked in:
[   69.867888][ T8108] ---[ end trace 0000000000000000 ]---
[   69.868392][ T8108] RIP: 0010:btrfs_assertfail+0x2c/0x2e
[   69.868901][ T8108] Code: 1f 00 41 55 41 89 d5 41 54 49 89 f4 55 48 89 fd e8 b9 84 e8 f7 44 89 e9 4c 89 e2 48 89 ee 48 c7 c7 20 af 54 8a e8 cb 49 f3 ff <0f> 0b 66 0f 1f 00 55 48 89 fd e8 95 84 e8 f7 48 89 ef 5d 48 c7 c6
[   69.870857][ T8108] RSP: 0018:ffffc90005f1fe28 EFLAGS: 00010282
[   69.871422][ T8108] RAX: 0000000000000097 RBX: 0000000000000000 RCX: 0000000000000000
[   69.872148][ T8108] RDX: ffff88801e8b2440 RSI: ffffffff81637e7c RDI: fffff52000be3fb7
[   69.872866][ T8108] RBP: ffffffff8a533d80 R08: 0000000000000097 R09: 0000000000000000
[   69.873681][ T8108] R10: 0000000080000001 R11: 0000000000000001 R12: ffffffff8a533d40
[   69.874530][ T8108] R13: 00000000000001c8 R14: 000000005000940a R15: 0000000000000000
[   69.875270][ T8108] FS:  00007ff3e2004640(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
[   69.876084][ T8108] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   69.876681][ T8108] CR2: 0000000000000000 CR3: 00000000182c8000 CR4: 0000000000750ef0
[   69.877464][ T8108] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   69.878317][ T8108] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   69.879062][ T8108] PKRU: 55555554
[   69.879400][ T8108] Kernel panic - not syncing: Fatal exception
[   69.880096][ T8108] Kernel Offset: disabled
[   69.880563][ T8108] Rebooting in 86400 seconds..


Please review whether we should patch the assert to add BTRFS_EXCLOP_NONE condtion.
I'll post a patch if needed. thx.
