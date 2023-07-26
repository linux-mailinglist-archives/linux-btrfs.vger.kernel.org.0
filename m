Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63369762914
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 05:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGZDJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 23:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjGZDJj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 23:09:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1A130F2;
        Tue, 25 Jul 2023 20:09:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1b9e9765f2cso33175195ad.3;
        Tue, 25 Jul 2023 20:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690340953; x=1690945753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3eGZxYybVzDbWEh1vUjpcnpeshd8LoWv2KA9phPmZQ=;
        b=WgtXbylYxJN2jMMB6H1GpJkjn4UQAfrUgH6M3/TG9fDqRWy36dTZ5DFFLjjuxBu2kI
         JTFqWxJl2eFmRcoyxseN9F4YAa/hLqof14uWfpAJfOttyHYu5aoPGnEGnNkWN5L7SLix
         Wd7COF2vm9i++lAFMSL1FwfsHk8rC6mu40FzlMAjagxVaf3m0N0lG6LqPffPmoX/D/Ro
         WJ3jqBSZoVgCg4VhuYANCBM6IXlRuHmfq44gs6wjV+Nvx+zNckcs9QAKXRPUeeDY+t0D
         6bD15ET0A2VkrgD1Ix+G5Mua/ppRrr5TDArAfpBRn0Ziz0R36zK5pzRXSa7oQl15xHFB
         42RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690340953; x=1690945753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3eGZxYybVzDbWEh1vUjpcnpeshd8LoWv2KA9phPmZQ=;
        b=QMJd568nlL9zYf8ppQo0bL4+kn+9LepRNIdmaCEnmnbIzcZSgYxGTbJUUWsKk39YKt
         qfHQlzyolkrFlk0bwzpRptdAcBPozCNxJCPyoDkNviR9eQq0bX1IHhIOUkscunKb7oFa
         EC6fL5sV8JVakQSaMeqkqezkdGUGjWFdovdMDy7ezIgyXOS3HgTmlhLX/Xq+skG6bPsS
         hUNK5haf0sZt14Xzjk//c1+Agu9NpJ4J+Rg8C0J8laqV7bg6RMx65qZrPr3+2z50S530
         6+SM/5m1ks+wDeDNbQE/jISOxZlj7EF27ovDYjmOuKEueioqt1FTJL4WngcF7jBMIpCO
         CmmA==
X-Gm-Message-State: ABy/qLa7bJpa1rkpKVk+2tpw02stQmuhIxajcZxYO6jVyYe5N1KCFbrA
        nMc2GB2aKBlLCfOE0O3VTUg=
X-Google-Smtp-Source: APBJJlGRF4bJBQL/QQY2P5NRNIn5MwFZZAtNfGnOITBN/oC+SI1Zn4oW1HbSST1/9yrL2va7cPWlog==
X-Received: by 2002:a17:902:b593:b0:1b8:9002:c9ee with SMTP id a19-20020a170902b59300b001b89002c9eemr686987pls.1.1690340953369;
        Tue, 25 Jul 2023 20:09:13 -0700 (PDT)
Received: from localhost.localdomain ([218.66.91.195])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001b9ff5aa2e7sm11864874plz.239.2023.07.25.20.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 20:09:13 -0700 (PDT)
From:   xiaoshoukui <xiaoshoukui@gmail.com>
To:     dsterba@suse.cz
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui@ruijie.com.cn
Subject: Re: [PATCH] btrfs: fix balance_ctl not free properly in btrfs_balance
Date:   Tue, 25 Jul 2023 23:06:17 -0400
Message-Id: <20230726030617.109018-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230714100143.GE20457@suse.cz>
References: <20230714100143.GE20457@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> This is a similar patch to what Josef sent but not exactly the same,
> https://lore.kernel.org/linux-btrfs/9cdf58c2f045863e98a52d7f9d5102ba12b87f07.1687496547.git.josef@toxicpanda.com/
> Both remove balance_need_close but your version does not track the
> paused state. I haven't analyzed it closer, but it looks like you're
> missing some case. Josef's fix simplifies the error handling so we don't
> have te enumerate the errors.

yeah. I think the fix logic is similar.

> As you have a reproducer, can you please try it with this patch instead?
> It's possible that there are still some unhandled states so it would be
> good to check. Thanks.

With Josef patch my fuzz reproducer ran for three hours without tripping panic. 
However, based on the test results, it was found that the fix was not complete.

The above patch only fixes the problem that the balance_ctl is not freed properly, 
but does not solve the problem that the pause ioctl request returns an incorrect
value 0 to the user.

Issue a pause or cancel IOCTL request after judging that there is no pause or 
cancel request on the path of __btrfs_balance to return 0, which will mislead
the user that the pause and cancel requests are successful.In fact, the balance
request has not been paused or canceled.

>	while (1) {
>		if ((!counting && atomic_read(&fs_info->balance_pause_req)) ||
>		    atomic_read(&fs_info->balance_cancel_req)) {
>			ret = -ECANCELED;
>			goto error;
>		}
>	--------------------	
>	.......  issue a pause or cancel req in anthoer thead
>	--------------------	
>	return ret;    --//return ret with 0

> [   60.753212][ T4484] BTRFS info (device loop0): balance: start -f
> [   60.754589][ T4484] BTRFS info (device loop0): balance: ended with status: 0
> /dev/vda balance successfully
> /dev/vda pause balance successfully  --//should fail with invalid.

This should indicate that the pause ioctl fail with invalid request.
With my new patch，the testing result show that both the problems are fixed.

The log of my test:
> [  109.371116][ T4449] BTRFS info (device loop0): balance: start -f
> [  109.382745][ T4449] BTRFS info (device loop0): balance: ended with status: 0
> /dev/vda balance successfully
> Failed to pause balance /dev/vda, errno 22   --//fail with invalid.
> Failed to resume balance /dev/vda, errno 107 --//didn't trip assert panic
> close btrfs

Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
---
 fs/btrfs/fs.h      |  6 ++++++
 fs/btrfs/volumes.c | 14 +++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 203d2a267828..6c85279d0e76 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -92,6 +92,12 @@ enum {
         * main phase. The fs_info::balance_ctl is initialized.
         */
        BTRFS_FS_BALANCE_RUNNING,
+
+       /* Indicate that balance has been paused. */
+       BTRFS_FS_BALANCE_PAUSED,
+
+       /* Indicate that balance has been canceled. */
+       BTRFS_FS_BALANCE_CANCELED,

        /*
         * Indicate that relocation of a chunk has started, it's set per chunk
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 70d69d4b44d2..8e759e7ebdd6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4267,7 +4267,6 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
        u64 num_devices;
        unsigned seq;
        bool reducing_redundancy;
-       bool paused = false;
        int i;

        if (btrfs_fs_closing(fs_info) ||
@@ -4390,6 +4389,8 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
        ASSERT(!test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
        set_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags);
        describe_balance_start_or_resume(fs_info);
+       clear_bit(BTRFS_FS_BALANCE_PAUSED, &fs_info->flags);
+       clear_bit(BTRFS_FS_BALANCE_CANCELED, &fs_info->flags);
        mutex_unlock(&fs_info->balance_mutex);

        ret = __btrfs_balance(fs_info);
@@ -4398,7 +4399,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
        if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req)) {
                btrfs_info(fs_info, "balance: paused");
                btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
-               paused = true;
+               set_bit(BTRFS_FS_BALANCE_PAUSED, &fs_info->flags);
        }
        /*
         * Balance can be canceled by:
@@ -4415,8 +4416,10 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
         *
         * So here we only check the return value to catch canceled balance.
         */
-       else if (ret == -ECANCELED || ret == -EINTR)
+       else if (ret == -ECANCELED || ret == -EINTR) {
                btrfs_info(fs_info, "balance: canceled");
+               set_bit(BTRFS_FS_BALANCE_CANCELED, &fs_info->flags);
+       }
        else
                btrfs_info(fs_info, "balance: ended with status: %d", ret);

@@ -4428,7 +4431,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
        }

        /* We didn't pause, we can clean everything up. */
-       if (!paused) {
+       if (!test_bit(BTRFS_FS_BALANCE_PAUSED, &fs_info->flags)) {
                reset_balance_state(fs_info);
                btrfs_exclop_finish(fs_info);
        }
@@ -4587,6 +4590,7 @@ int btrfs_pause_balance(struct btrfs_fs_info *fs_info)
                /* we are good with balance_ctl ripped off from under us */
                BUG_ON(test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
                atomic_dec(&fs_info->balance_pause_req);
+               ret = test_bit(BTRFS_FS_BALANCE_PAUSED, &fs_info->flags) ? 0 : -EINVAL;
        } else {
                ret = -ENOTCONN;
        }
@@ -4642,7 +4646,7 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info)
                test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
        atomic_dec(&fs_info->balance_cancel_req);
        mutex_unlock(&fs_info->balance_mutex);
-       return 0;
+       return test_bit(BTRFS_FS_BALANCE_CANCELED, &fs_info->flags) ? 0 : -EINVAL;
 }

 int btrfs_uuid_scan_kthread(void *data)
--
2.34.1

