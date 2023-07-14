Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCF57532D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 09:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjGNHP4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 03:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjGNHPz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 03:15:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520AA11D;
        Fri, 14 Jul 2023 00:15:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-666ecb21f86so1548337b3a.3;
        Fri, 14 Jul 2023 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689318954; x=1691910954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7pZW/C/MXqwt/arilKEJrBtvxTFOdMU8nyVIPqgkkM=;
        b=bHYanExIrxmYVj6EIrKtqfCUwD2EqlIjxXzCA3260mPXhA90dh8bzmxb3vMTEh38/D
         ZAKwAplsqtpBC9DlKtBsXJ8a4DfbAzlguwicdF9uKfc/Nc1zoWm6zl6MLQ9ilRMc1Fxw
         pfBlsYhuD5LSXyh4jkjOVE7R57UQYwi8mwxA+e7CVWl9BETHolOYK48XkPi1WUFy+0Rf
         U8udQ0AE5VtZYbkly89Hioi3jmc+ye2F7CATKaGRLTwxjmbeIyMyBsLwdHHEBsF+eeSd
         tUIqTK2nr1bAuLV54f4Q02LdkBo+EDtcxJmycoZuRc0OcRA9QzmVXcbEtZ+k7TWey2JC
         wqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689318954; x=1691910954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7pZW/C/MXqwt/arilKEJrBtvxTFOdMU8nyVIPqgkkM=;
        b=dvpzu3n9ZtGd77h+Lwezod4CwDSyXBiXyWxun/yFFHqkjkRtyn+mPGS6tZ+/nZSgS1
         jR9PWcMnBxS9IMXED8cLyQ1/sw1wa4sqnA98nvWwal08BnKj13sM23OjEV9XanOQgrsI
         KALHeXoMjHj5745VGCTTkLDqXGbGiFZUf/J5eOaHjR+lpw8EonYmM8XPgf/xXm3KC/W8
         YylhhIe13vMFnLVH9oRQPMj/NNUTVBZa0dZgFbS96Du4MpNWlAHmEs2rTST12MmumsSi
         CjVvGJ7af1sESKMYWFBax1xyopYluNIbVH7Aop8AScHFjZ2/xwLkNsxMXiDbZXlQgent
         oZRw==
X-Gm-Message-State: ABy/qLYmSekGeeCNMics259ehGIIHODU0trg1bA8pGX6bq7i8NcCqJYc
        kYjCfGteI/7+l9fBFRgPC+X8P8pjq0Jq5r4eS7g=
X-Google-Smtp-Source: APBJJlFNOqbw1hpuOhbU1FNqw9Ysa9f/aRgcGSRs3RvDvPoRkWD4mEJCmZ874t3T6WKjOhTC/TPWXA==
X-Received: by 2002:a05:6a00:2307:b0:668:81c5:2f8a with SMTP id h7-20020a056a00230700b0066881c52f8amr5443090pfh.17.1689318953692;
        Fri, 14 Jul 2023 00:15:53 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id x22-20020aa79196000000b00682a839d0aesm6493970pfa.112.2023.07.14.00.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 00:15:53 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Subject: [PATCH] btrfs: fix balance_ctl not free properly in btrfs_balance 
Date:   Fri, 14 Jul 2023 03:15:48 -0400
Message-Id: <20230714071548.45825-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs: fix balance_ctl not free properly in btrfs_balance  

The balance_ctl should be freed after balance finished successfully.
But this is not be true when balance_pause_req > 0 and __btrfs_balance
return with 0. This can lead to unexpected behaviors. Resume balance
with balance_ctl not be free may lead to btrfs_exclop_balance in 
btrfs_ioctl_balance assert fail.

Issue the pause balance request bewteen __btrfs_balance return to ret 
with 0 and mutex_lock(&fs_info->balance_mutex) can lead to such assert
fail.

Rewrite the normal exit condition of balance will fix the problem.

We can easily reproduce the problem with the following code.

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
    struct btrfs_ioctl_balance_args args;
    memset(&args, 0, sizeof(args));
    args.flags |= BTRFS_BALANCE_FORCE;	
    while(!controller);
    //usleep(delta);
    usleep(random_delay1);
    ret = ioctl(fd, BTRFS_IOC_BALANCE_V2, &args);
    if (ret != 0) {
        printf("Failed to balance %s, errno %d\n", path, errno);
    } else {
		printf("%s balance successfully\n", path);
	}
	memset(&args, 0, sizeof(args));
	args.flags |= BTRFS_BALANCE_RESUME;
    ret = ioctl(fd, BTRFS_IOC_BALANCE_V2, &args);
    if (ret != 0) {
        printf("Failed to resume balance %s, errno %d\n", path, errno);
    } else {
		printf("%s resume balance successfully\n", path);
	}
    return NULL;
}

void *thr2(void *arg) {
    int ret;
    struct btrfs_ioctl_balance_args args;
    memset(&args, 0, sizeof(args));
    while(!controller);
    usleep(random_delay2);
    ret = ioctl(fd, BTRFS_IOC_BALANCE_CTL, 0x1);
    if (ret != 0) {
        printf("Failed to pause balance %s, errno %d\n", path, errno);
    } else {
		printf("%s pause balance successfully\n", path);
	}
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
[   54.565209][ T4290] BTRFS info (device loop0): balance: start -f
[   54.566302][ T4290] BTRFS info (device loop0): balance: ended with status: 0
/dev/vda balance successfully
Failed to pause balance /dev/vda, errno 107
Failed to resume balance /dev/vda, errno 107
Failed to pause balance /dev/vda, errno 107
[   54.654827][ T4292] BTRFS info (device loop0): balance: start -f
[   54.655679][ T4292] BTRFS info (device loop0): balance: ended with status: 0
/dev/vda balance successfully
Failed to resume balance /dev/vda, errno 107
Failed to pause balance /dev/vda, errno 107
[   54.727231][ T4294] BTRFS info (device loop0): balance: start -f
[   54.728795][ T4294] BTRFS info (device loop0): balance: ended with status: 0
/dev/vda balance successfully
Failed to resume balance /dev/vda, errno 107
Failed to pause balance /dev/vda, errno 107
[   54.801791][ T4296] BTRFS info (device loop0): balance: start -f
[   54.802566][ T4296] BTRFS info (device loop0): balance: ended with status: 0
/dev/vda balance successfully
Failed to resume balance /dev/vda, errno 107
Failed to pause balance /dev/vda, errno 107
[   54.876345][ T4298] BTRFS info (device loop0): balance: start -f
[   54.877201][ T4298] BTRFS info (device loop0): balance: ended with status: 0
......
......
Failed to resume balance /dev/vda, errno 107
Failed to pause balance /dev/vda, errno 107
[   60.518896][ T4476] BTRFS info (device loop0): balance: start -f
[   60.519831][ T4476] BTRFS info (device loop0): balance: ended with status: 0
/dev/vda balance successfully
Failed to resume balance /dev/vda, errno 107
Failed to pause balance /dev/vda, errno 107
[   60.581485][ T4478] BTRFS info (device loop0): balance: start -f
[   60.582344][ T4478] BTRFS info (device loop0): balance: ended with status: 0
/dev/vda balance successfully
Failed to resume balance /dev/vda, errno 107
Failed to pause balance /dev/vda, errno 107
[   60.639015][ T4480] BTRFS info (device loop0): balance: start -f
[   60.639909][ T4480] BTRFS info (device loop0): balance: ended with status: 0
/dev/vda balance successfully
Failed to resume balance /dev/vda, errno 107
Failed to pause balance /dev/vda, errno 107
[   60.695822][ T4482] BTRFS info (device loop0): balance: start -f
[   60.696686][ T4482] BTRFS info (device loop0): balance: ended with status: 0
/dev/vda balance successfully
Failed to resume balance /dev/vda, errno 107
[   60.753212][ T4484] BTRFS info (device loop0): balance: start -f
[   60.754589][ T4484] BTRFS info (device loop0): balance: ended with status: 0
/dev/vda balance successfully
/dev/vda pause balance successfully
[   60.776677][ T4484] assertion failed: fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED,
 in fs/btrfs/ioctl.c:465
[   60.800426][ T4484] ------------[ cut here ]------------
[   60.801145][ T4484] kernel BUG at fs/btrfs/messages.c:259!
[   60.804667][ T4484] invalid opcode: 0000 [#1] PREEMPT SMP
[   60.806051][ T4484] CPU: 1 PID: 4484 Comm: repro_bp Not tainted 6.2.0 #34
[   60.807169][ T4484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   60.808267][ T4484] RIP: 0010:btrfs_assertfail+0x14/0x16
[   60.808267][ T4484] Code: e8 36 dc 0f 00 48 8d 65 d0 5b 41 5a 41 5c 41 5d 41 5e 41 5f 5d c3 89 d1 48
 89 f2 48 89 fe 48 c7 c7 70 4d 66 83 e8 26 7a f9 ff <0f> 0b 48 c7 c6 98 4d 66 83 e9 f5 fc ff ff 41 56 83 f9 e4 41 89 d6
[   60.808267][ T4484] RSP: 0018:ffffc90004707df0 EFLAGS: 00000246
[   60.808267][ T4484] RAX: 0000000000000066 RBX: ffff88811384f301 RCX: 0000000000000000
[   60.808267][ T4484] RDX: 0000000000000000 RSI: ffffffff8361226e RDI: 00000000ffffffff
[   60.808267][ T4484] RBP: 00000000c4009420 R08: 00000000ffffffff R09: 695f7366203a6465
[   60.808267][ T4484] R10: 0000000074726573 R11: 0000000065737361 R12: 00007f38bfdf0dc0
[   60.808267][ T4484] R13: 0000000000000003 R14: ffff88811384f300 R15: 0000000000000000
[   60.808267][ T4484] FS:  00007f38bfdf1640(0000) GS:ffff88813bc80000(0000) knlGS:0000000000000000
[   60.808267][ T4484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   60.808267][ T4484] CR2: 00007f175952f010 CR3: 0000000114d7b000 CR4: 00000000000006e0
[   60.808267][ T4484] Call Trace:
[   60.808267][ T4484]  <TASK>
[   60.808267][ T4484]  btrfs_exclop_balance+0x160/0x1b0
[   60.828329][ T4484]  ? btrfs_ioctl_balance+0x1a3/0x4a0
[   60.828329][ T4484]  btrfs_ioctl_balance+0x1b0/0x4a0
[   60.828329][ T4484]  btrfs_ioctl+0xa2c/0xd20
[   60.828329][ T4484]  __x64_sys_ioctl+0x7d/0xa0
[   60.828329][ T4484]  do_syscall_64+0x38/0x80
[   60.828329][ T4484]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   60.828329][ T4484] RIP: 0033:0x4547ef
[   60.828329][ T4484] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08
 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
[   60.828329][ T4484] RSP: 002b:00007f38bfdf0d40 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   60.828329][ T4484] RAX: ffffffffffffffda RBX: 00007f38bfdf1640 RCX: 00000000004547ef
[   60.828329][ T4484] RDX: 00007f38bfdf0dc0 RSI: 00000000c4009420 RDI: 0000000000000003
[   60.828329][ T4484] RBP: 00007f38bfdf11d0 R08: 0000000000000000 R09: 0000000000000000
[   60.837353][ T4484] R10: 00000000004b1008 R11: 0000000000000246 R12: 00007f38bfdf1640
[   60.837353][ T4484] R13: 0000000000000009 R14: 000000000041b450 R15: 00007f38bf5f1000
[   60.837353][ T4484]  </TASK>
[   60.837353][ T4484] Modules linked in:
[   60.842505][ T4484] ---[ end trace 0000000000000000 ]---
[   60.843117][ T4484] RIP: 0010:btrfs_assertfail+0x14/0x16
[   60.843596][ T4484] Code: e8 36 dc 0f 00 48 8d 65 d0 5b 41 5a 41 5c 41 5d 41 5e 41 5f 5d c3 89 d1 48
 89 f2 48 89 fe 48 c7 c7 70 4d 66 83 e8 26 7a f9 ff <0f> 0b 48 c7 c6 98 4d 66 83 e9 f5 fc ff ff 41 56 83 f9 e4 41 89 d6
[   60.844983][ T4484] RSP: 0018:ffffc90004707df0 EFLAGS: 00000246
[   60.845512][ T4484] RAX: 0000000000000066 RBX: ffff88811384f301 RCX: 0000000000000000
[   60.846172][ T4484] RDX: 0000000000000000 RSI: ffffffff8361226e RDI: 00000000ffffffff
[   60.846777][ T4484] RBP: 00000000c4009420 R08: 00000000ffffffff R09: 695f7366203a6465
[   60.847420][ T4484] R10: 0000000074726573 R11: 0000000065737361 R12: 00007f38bfdf0dc0
[   60.847957][ T4484] R13: 0000000000000003 R14: ffff88811384f300 R15: 0000000000000000
[   60.849118][ T4484] FS:  00007f38bfdf1640(0000) GS:ffff88813bc80000(0000) knlGS:0000000000000000
[   60.849760][ T4484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   60.850214][ T4484] CR2: 00007f175952f010 CR3: 0000000114d7b000 CR4: 00000000000006e0
[   60.851164][ T4484] Kernel panic - not syncing: Fatal exception
[   60.853481][ T4484] Kernel Offset: disabled
[   60.854170][ T4484] Rebooting in 86400 seconds..


Apply the patch, regression tests shows that the problem is fixed.

Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
---
 fs/btrfs/volumes.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7823168c08a6..c1ab94d8694c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4055,14 +4055,6 @@ static int alloc_profile_is_valid(u64 flags, int extended)
        return has_single_bit_set(flags);
 }
 
-static inline int balance_need_close(struct btrfs_fs_info *fs_info)
-{
-       /* cancel requested || normal exit path */
-       return atomic_read(&fs_info->balance_cancel_req) ||
-               (atomic_read(&fs_info->balance_pause_req) == 0 &&
-                atomic_read(&fs_info->balance_cancel_req) == 0);
-}
-
 /*
  * Validate target profile against allowed profiles and return true if it's OK.
  * Otherwise print the error message and return false.
@@ -4411,7 +4403,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
        }
 
        if ((ret && ret != -ECANCELED && ret != -ENOSPC) ||
-           balance_need_close(fs_info)) {
+           ret == -ECANCELED || ret == 0) {
                reset_balance_state(fs_info);
                btrfs_exclop_finish(fs_info);
        }
-- 
2.20.1

