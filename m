Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726364D5848
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 03:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345706AbiCKCoP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 21:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345700AbiCKCoO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 21:44:14 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78717EF7B5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 18:43:11 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so5412966oti.5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 18:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HtwdhAqMSAdz8Gbiv6Ht1DbDp5TMQ32e6Q0pKFpsLOo=;
        b=cS3Ae/pGNPB5qLFOE1yT2ILr54oLuSXXhgVUAdaQVJBVfU03zJq1RDiPpp6IRy2CEG
         BGNHVU/4z7i/IhNsMIfPY/BROK1O/N0obN0CNoZpT4n+PxClawSO82Hbv0YjmbN4Irt5
         W6HtWdKTVN30H54z6jgthdkqmr3EVwbYXwEJPNUBNn41/yxFVQxZcbrSfpgwMB0QBALx
         tpblXuL2XTjvZ1KMeSInvtHIlKzlGb/0yKPhMmS6XNjcDelUPz1ge3jBtXaNvQoKUwPz
         bptjGEtLOKM7vBxfKy54YhgNmwbWiOCn/tBHzsxRmN12LEi67B6d2LVliV4kOehJfcst
         aqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtwdhAqMSAdz8Gbiv6Ht1DbDp5TMQ32e6Q0pKFpsLOo=;
        b=xKtzuS8YsaCmnQRXzkGPPOHD5MI1O3IuIsqNwsosS/E/Ly0sRYKKxMHWs7gaI7rGMk
         4sivDWk5rFSptGGwLkVhfPW6QdZ9sTPp20BgiNaAPaynCsSK0yoOmf6ifdKQFynCaAjr
         f6wPZ1Bvj8xMhn+ygXfa/GBFFkqoKqimZOJyN6bjaPoucHnji3fNiUywvSJ2L6BBdzsL
         cookGogZtxD5Eg3hztorTqDTVyUXB1yL69EJXheOfLbryvkirh4Xi0GJY9vE8Hi/c0g3
         9m5D/t/BEf30UjF9WT+rmW0yjiXpjQvH/FOoGy3pCn+4D5va3H4KI3Ut2EByO6aAnfjj
         i31Q==
X-Gm-Message-State: AOAM530wKFw1mU+GELyop5x/VkBLKjE321E7awinYqtM5FBv2vwmrUGO
        dYwNuFlm3dRfPpjvViO4wxnuDRQP2m45bdeeK0o=
X-Google-Smtp-Source: ABdhPJxyIB0fJW04eQVN3FJ0FVss5VTjfIStqTPUdgflp0bXcJz8SllARL0AFEDkYHknFYOCRXyI7idERnRajY6st3Q=
X-Received: by 2002:a05:6830:11d6:b0:5b2:5a37:3cc7 with SMTP id
 v22-20020a05683011d600b005b25a373cc7mr3893137otq.381.1646966590570; Thu, 10
 Mar 2022 18:43:10 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com> <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com> <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
 <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
 <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com> <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com> <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
In-Reply-To: <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Fri, 11 Mar 2022 03:42:34 +0100
Message-ID: <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 11, 2022 at 12:27 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> The unexpected behavior is the same reported by another reporter.
> (https://github.com/btrfs/linux/issues/423#issuecomment-1062338536)
>
> Thus this patch should resolve the repeated defrag behavior:
> https://patchwork.kernel.org/project/linux-btrfs/patch/318a1bcdabdd1218d631ddb1a6fe1b9ca3b6b529.1646782687.git.wqu@suse.com/
>
> Mind to give it a try?

New trace (patched kernel):
http://atom-symbol.net/f/2022-03-11/btrfs-autodefrag-trace-patch1.txt.zst

$ cat /proc/297/io
read_bytes: 217_835_884_544
write_bytes: 319_139_635_200

btrfs-cleaner (pid 297) read 217 GB and wrote 319 GB, but this had no
effect on the fragmentation of the file (currently 1810562 extents).

The CPU time of btrfs-cleaner is 20m22s. Machine uptime is 3h27m.

-Jan
