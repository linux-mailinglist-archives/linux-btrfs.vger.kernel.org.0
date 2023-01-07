Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3F2660D9F
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jan 2023 11:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjAGKFG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Jan 2023 05:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbjAGKEl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Jan 2023 05:04:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E1D87905
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Jan 2023 02:01:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bs20so3363248wrb.3
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Jan 2023 02:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zzF72H2e4sQjY5SrTKyRgfPrbJCEHjIfqRWT1W96ZyM=;
        b=KTGYD/7XbVs9oMlXdJRQETRYcJQ0RJ+Tu5gOv3xo4n0PuPbyGEikTX2EWmp2EFYM02
         wjQZ3VUxzqmThoFKYWFaAXL92PvXNxEFo5BGMTtL6strBWO8OPg4C7YDggaULzf5my01
         IgqEg/x5hyfpjntkh+qDq5W7+SPshewnbacrUhMpXoejgN0QumGmM5VAxYyFMKrySNrN
         R+D3aIgrteTIsU4HX8y9F+6qIkWt0p8+XhhfGyum/Xm2gw5PTZci/s3TsD0rWRzlJs6O
         NoxDPYgzXI6Co3Mzynteh6xlWZp9Mfhrdzv9FuFDtwsS9vHJmko5/gRWmqHHzUDYlehI
         X2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzF72H2e4sQjY5SrTKyRgfPrbJCEHjIfqRWT1W96ZyM=;
        b=LO4JHZsTHZ6nVBrUU1JJzYCgxY3yCCiFSLJaXr4ZlOoeYzglg6ACgOHMVYvjyyejcD
         OJO4Q0lpAWEwjSfiwGNFyR3mNLHZwhT/4KuVSygoHK8XpS5PN1xn1JtUaq71V0wVap+r
         FPhNR942yzWvJ0ENAw3vPbqQAwV9u/1mk5vi3dmmLcof3zbRnpBFdIHzL4U9evbGwn7f
         REJNQaZeuT3lj37BDNIUE9iRoLbfQykvREZGn9W8Hw6kA6dxCX318TSM6tYom2AueI3P
         6KZJ6ij/7qLAPLEuyfduOwFk06+mOSXRRB+3oxi9Rs+RVaQ56fQ2qjjrfPQwvJX7E8nc
         HCFg==
X-Gm-Message-State: AFqh2kr76vAuzhodMkqMkWEYuw0wZ3f8gihztmCQwd/3SPJqLlzGvTfp
        LPMtoTi7hEqdJu5tiDH00lOmzBqmbYrcJPs5M2ECfr7gdAo=
X-Google-Smtp-Source: AMrXdXsIcXUqPWf5kjs8qNjNyHpH5A/Ivnis8I2Oo2Eh2bMZQyouBlGwr/luJqsAIG3DK2BRuveothw5z32ebRMBKbs=
X-Received: by 2002:a05:6000:1e02:b0:290:e113:7ec5 with SMTP id
 bj2-20020a0560001e0200b00290e1137ec5mr518338wrb.389.1673085611819; Sat, 07
 Jan 2023 02:00:11 -0800 (PST)
MIME-Version: 1.0
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Sat, 7 Jan 2023 18:00:19 +0800
Message-ID: <CAPm50aLoApkx5SCCmKj8+tFWNn9TbyJssaJFmQW-wkT1HD35yg@mail.gmail.com>
Subject: [PATCH v2] btrfs: adjust error jump position
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Peng Hao <flyingpeng@tencent.com>

Since 'em' has been set to NULL, you can jump directly to out_err.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0e516aefbf51..0ee2e82d6be2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7997,7 +7997,7 @@ static void btrfs_submit_direct(const struct
iomap_iter *iter,
                if (IS_ERR(em)) {
                        status = errno_to_blk_status(PTR_ERR(em));
                        em = NULL;
-                       goto out_err_em;
+                       goto out_err;
                }
                ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
                                            logical, &geom);
--
2.27.0
