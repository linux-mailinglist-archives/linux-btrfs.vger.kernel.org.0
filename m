Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CCC504A7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 03:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiDRBgB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Apr 2022 21:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiDRBft (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Apr 2022 21:35:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F408A1835B
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 18:32:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so16053795pjn.3
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 18:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=KJfLbwgngO3OiGtIZhQTnGZUpV/6KTf4a6VxaVn0jHA=;
        b=fUiWEs30cpVdTgnRTDuIunTyD3sFwyNXIMjD2xrDFFhby9PvozDytSBEVj5TLA3enQ
         WJg5PUCFZhavWnDTUSjcqiWdtbmRSnwGPVoJqfidCHXMsRiC/8miYakfaAZVFsJvX3bS
         5rW4pfgKMUPRH4xvCV8Ayqx16fXXcBpmLJ8ouv1MDWzBzzeX6sTvregS6+W7imKu2o9s
         JkpStrFdIm2UGzcq7WrYJf9XXlMNLf1O1L3ohQXq8EaSjdqThCTtF7dsfLFbH0M279GX
         9j/pkX//BLTGvZs/WRmTotqH1MNj+h8ET2s+rsNWcTHLVYqXbzx2Z0wD2+tsX+cqIWVh
         IhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=KJfLbwgngO3OiGtIZhQTnGZUpV/6KTf4a6VxaVn0jHA=;
        b=5OFE0U7c3IcRDzledHiazrRjB8sRDrvK2qedtW68qyZG7NIEGbLaPf6wJZo/TPKVVA
         hiWQizymjYioOAe2p/UtSDyItkCs89SO2punVqh7iC8bDV4xVXZFuSsNy6DwC1zOHQsb
         jSkUmuQOsK/8oQBU48Ky7+AKfc7CGZVoAk1p/GOwrqrdKhK8ZYsBNOSkIoWd9nURstex
         p2CrbrV8ObQOBv/QbZoyRvU13n5cCHakdpX4zjzm7kPDaOuehxhr3GJJzYBXfm2lA2WH
         Sedj0AdM8sshm6S8B06Z+pMdw5lhCXd3IhOpef5tb7ZKwTxcLtlj38Rd0JkCjPQs7Y2D
         SPeg==
X-Gm-Message-State: AOAM53352Du6yBR0CX13NxW6wHTbOskgpwLUUjFAUxyNgCBXHUe3L1XY
        awoONCiWHKCWnLaqRfsF77pwJA==
X-Google-Smtp-Source: ABdhPJxH3Tcv8urG8TWDL99aaKBrMqsxLK1RCMCg75RZRVpxh7Td568gOGSDadX3DzyNp9aRqA2iCg==
X-Received: by 2002:a17:903:2406:b0:158:f6f0:6c44 with SMTP id e6-20020a170903240600b00158f6f06c44mr4676524plo.88.1650245568439;
        Sun, 17 Apr 2022 18:32:48 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g15-20020a63be4f000000b0039934531e95sm10726611pgo.18.2022.04.17.18.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 18:32:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, phillip@squashfs.org.uk,
        target-devel@vger.kernel.org, colyli@suse.de,
        linux-btrfs@vger.kernel.org, martin.petersen@oracle.com,
        linux-raid@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com,
        song@kernel.org, dm-devel@redhat.com, snitzer@redhat.com,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220406061228.410163-1-hch@lst.de>
References: <20220406061228.410163-1-hch@lst.de>
Subject: Re: cleanup bio_kmalloc v3
Message-Id: <165024556441.258485.6980891929042026868.b4-ty@kernel.dk>
Date:   Sun, 17 Apr 2022 19:32:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 6 Apr 2022 08:12:23 +0200, Christoph Hellwig wrote:
> this series finishes off the bio allocation interface cleanups by dealing
> with the weirdest member of the famility.  bio_kmalloc combines a kmalloc
> for the bio and bio_vecs with a hidden bio_init call and magic cleanup
> semantics.
> 
> This series moves a few callers away from bio_kmalloc and then turns
> bio_kmalloc into a simple wrapper for a slab allocation of a bio and the
> inline biovecs.  The callers need to manually call bio_init instead with
> all that entails and the magic that turns bio_put into a kfree goes away
> as well, allowing for a proper debug check in bio_put that catches
> accidental use on a bio_init()ed bio.
> 
> [...]

Applied, thanks!

[1/5] btrfs: simplify ->flush_bio handling
      commit: f9e69aa9ccd7e51c47b147e45e03987ea0ef9aa3
[2/5] squashfs: always use bio_kmalloc in squashfs_bio_read
      commit: 46a2d4ccc49903923506685a8368ca88312bbdc9
[3/5] target/pscsi: remove pscsi_get_bio
      commit: 7655db80932d95f501a0811544d9520ec720e38d
[4/5] block: turn bio_kmalloc into a simple kmalloc wrapper
      commit: 066ff571011d8416e903d3d4f1f41e0b5eb91e1d
[5/5] pktcdvd: stop using bio_reset
      commit: 852ad96cb03621f7995764b4b31cbff9801d8bcd

Best regards,
-- 
Jens Axboe


