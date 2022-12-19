Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94665113B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 18:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiLSRdB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 12:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiLSRdA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 12:33:00 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2663FBE2E
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Dec 2022 09:32:59 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c7so6735629pfc.12
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Dec 2022 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EZ4TmgZSfakSpCpsQ/IYiaByzhPntgG7ueYoXtfyIcQ=;
        b=kAdngY7KWhih0Vq1SLBFkuNZOC7RSFGFobEGUhy2i/qBHMvI3nnirBqUaZG3OrKCVY
         ZKROOWO/UNQHus4WAUMoLkFG3RH53y/t4LLumLppglvvRB+iSJiIuYPBDZL3hoQOUjzE
         6Ddj6YBHFxFPT7+azt7eOIWGhL2dApUrQml68YPqfxqDm80ZqiIBuY6SBA6FVLSnlVZf
         7egIPjdScHul6eFr67jGWlcqM5JtibMipKA93Qb33OzSkAVCe5ROe17qAlqDILB53Z1W
         FkZoeYArYv6ZGOqZdOFWdjnTIv3u9NZeKC4YZ+Lbkm6HfcggA13Tq3kKkIvq1sgyFRJl
         8yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZ4TmgZSfakSpCpsQ/IYiaByzhPntgG7ueYoXtfyIcQ=;
        b=L4pRJp1vJO1fl5jMBXghw3Oa3hTfV+nqBgV4qkHU1ybxZUppHB5w8MPZ7yZDPqp7tk
         9TEE5Ua0fOVUlgU4X5l/tskG2i6vTkfyI8cTTag2cAKFJunXdixHq6dwMhWrfzrAUi1c
         M5/DX/o54kTZOXfRiqaCRby0m1dvjOVWSezjuBEukBw0HiqOfPklbbbMugYcpCOZ9cSs
         DBFYHzA/RYz50KZe3RxpbQfqT57KZWNC61qNmJZ49HjGzCzB2ZOZ8BpWUHvFtB6VopJw
         NLjvsc01in5HJwCsJzvnbeUifP6XsughcNZi0gKD7k41KT8kZs/ATp3wmv10VNO4OKyh
         VUZg==
X-Gm-Message-State: ANoB5plb6WCbZuM83USZ3ImUtej7R2Y55Xi2MlGk8LV+IOtkE8NomD2H
        SBvnXJpYA/Iv7WPWaBc62gtn30/oYhwdcfSFCgUodqqZHFuly1sf894Znw==
X-Google-Smtp-Source: AA0mqf4S8PLnkwahqF6+CQVsfU4hr39h085Li0IvreP/bXfuF5Gr3KkR2OFxXpmXOQBEcqmqvn2X6DnRhEWLKH6gJg8=
X-Received: by 2002:a63:4f25:0:b0:478:3376:5561 with SMTP id
 d37-20020a634f25000000b0047833765561mr44793909pgb.618.1671471178224; Mon, 19
 Dec 2022 09:32:58 -0800 (PST)
MIME-Version: 1.0
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Mon, 19 Dec 2022 20:32:47 +0300
Message-ID: <CAN4oSBewVqdWU8O4jBqneexYKZGHLSDEhFCwKj+mL5+OjcWeYg@mail.gmail.com>
Subject: Doing anything with the external disk except mounting causes whole
 system lockup
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've been using my scripts for mounting partitions, unmounting, btrfs
send|receive etc. while I'm dealing with my external/backup hard
disks.

Recently I had trouble so I reformatted my external spinning disk and
transferred all snapshots to it (~800GB).

At the end of transfer, there was an error (I might have modified the
bash script that is currently running) so after finishing the `btrbk
...` command, my script gave an error (that's normal), so I restarted
it. From this moment on, I could mount my partitions but I never did a
btrfs send|receive or scrub or unmount again because the system was
simply getting locked up.

I run `dmesg -w` command on another terminal but I didn't save it
(because the system was locked), so I took a photo of it:
https://imgur.com/LJfgjbY

I haven't lost any data and I still have another backup disk, so no
worries. I'm just keeping the disk just in case you may require some
more information this week.

* Linux erik3 6.0.0-0.deb11.2-amd64 #1 SMP PREEMPT_DYNAMIC Debian
6.0.3-1~bpo11+1 (2022-10-29) x86_64 GNU/Linux
* btrfs-progs v5.10.1
* mount options I'm using: rw,noatime
