Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFE67257F2
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 10:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjFGIgA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 04:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbjFGIfy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 04:35:54 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11521725
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 01:35:43 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-38e04d1b2b4so6063682b6e.3
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 01:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686126942; x=1688718942;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9jtR386+0dL0q+M9/8EDtTxnOTWSV87feab1aUU9TE=;
        b=GQUVf7cetn5tQ+A4N211C9qcQrNPnrCLqUhcJdJhvIx3+o5Q1RedLUf4A71934wf+z
         FSMeazStZQiN5eOWMP30rjmoEc/roBoXYm0aTnUMOIsCusRpHsCypkUahgoGir0SUrD2
         CYiF00FNz0ZkQ1M3MZKUXqFmmS0qauYXEBzdKY/cbPp6ekvfB2TUXUhBlxwG5N0VONbY
         nR5nFYvYBPGMJKQt2w1ggJshGEi3VWgQGMQGZ3o/0VC+7xQY7v8juUE0aRR1P0Dt3rld
         QSs5HLHqausG97GwcDplG6rNYG+CsxG+ATV29ml6MP7/LH9TG4EWQnVHjXBrDNEyfjgV
         x70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686126942; x=1688718942;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9jtR386+0dL0q+M9/8EDtTxnOTWSV87feab1aUU9TE=;
        b=HSeJS8ww/2+qGpI3840e6TPW6VOJxZp8eQlVuE/GWCKTGSbfDES51QjYpOX9ZVxtay
         aW6KI3Jwdi8soDWqpP8gvdeLmtKsep3BPtytQOSKu9zZwzmfma2k3zcQcuy2wExFWvTe
         sBDNTmzKQHrOVV5hC6X0HKHC2mtM0NdS1D9MgvGGmhcg6Z7jFmG3NxyAzQx4P715QKhF
         77PqNjXc/Cz6OoaDqZuAfZhgNFBOqxGm8wZBcmyp3U1j/VBPVxqF6wiZ8iVN/DHAAO3A
         iZd/AEO0WGR1W5gsskh7j7vsdCwa0eZMJyih+w9X4XWoPkBNVwaxR3Ww+xMzOIHHNj9t
         EV1g==
X-Gm-Message-State: AC+VfDyuAOYPK+7zT/7wJGFmyhNvZLa6Z1Il4VbJRZX8woMpZbmNRsGh
        hmKvFJ78ddlYnRDEYrnwArPe5KeRTu9vATe5pcc19kkz
X-Google-Smtp-Source: ACHHUZ7lPmwZmpbqmBs4IuqVGeTbdxkbAI9EEx6I7NOTDm9JuCuC6XrmTviGDWmHQybJ5YIrk0l3Qbx5SOj2soqI/B8=
X-Received: by 2002:a05:6358:bd03:b0:123:5664:e493 with SMTP id
 dh3-20020a056358bd0300b001235664e493mr3168193rwb.27.1686126942476; Wed, 07
 Jun 2023 01:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <CALgeF5=8Www=aG8=6XXTYsiD-A=dBdGUN8Drj=h4d92yoZNXHw@mail.gmail.com>
 <cf225ad6-69f4-a339-2e7b-42f094a7b5fb@gmx.com> <CALgeF5ksBx0+0v8yGu3XECPkDZJZB0tBAeHt+1MUAXLEa67QPw@mail.gmail.com>
 <01d99c0f-da3f-0d2a-8437-b065bc610eb3@gmx.com> <CALgeF5kFsrBSfUQS9p2sq0xPHJJYcykfnPAe4TP_XM=zXE65tw@mail.gmail.com>
In-Reply-To: <CALgeF5kFsrBSfUQS9p2sq0xPHJJYcykfnPAe4TP_XM=zXE65tw@mail.gmail.com>
From:   Massimiliano Alberti <xanatos78@gmail.com>
Date:   Wed, 7 Jun 2023 10:35:29 +0200
Message-ID: <CALgeF5m5uQuJ-fpfzMG2iDZGb601qZ+TJRJ4Cq2zEFa7OpGsDA@mail.gmail.com>
Subject: Fwd: parent transid verify failed + Couldn't setup device tree
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The dmesg

[  288.076822] BTRFS info (device sdb1): using crc32c (crc32c-intel)
checksum algorithm
[  288.076844] BTRFS error (device sdb1): unrecognized mount option 'rescux=all'
[  288.076975] BTRFS error (device sdb1): open_ctree failed
[  345.636207] BTRFS: device fsid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f
devid 1 transid 9196 /dev/sdb1 scanned by mount (5926)
[  345.639381] BTRFS info (device sdb1): using crc32c (crc32c-intel)
checksum algorithm
[  345.639407] BTRFS info (device sdb1): enabling all of the rescue options
[  345.639409] BTRFS info (device sdb1): ignoring data csums
[  345.639411] BTRFS info (device sdb1): ignoring bad roots
[  345.639413] BTRFS info (device sdb1): disabling log replay at mount time
[  345.639415] BTRFS error (device sdb1): nologreplay must be used
with ro mount option
[  345.640184] BTRFS error (device sdb1): open_ctree failed

Tried btrfs restore (no hypen):

root@ebuntu:~# btrfs restore -D -i /dev/sdb1 /
parent transid verify failed on 4390576160768 wanted 9196 found 3295
parent transid verify failed on 4390576160768 wanted 9196 found 3295
parent transid verify failed on 4390576160768 wanted 9196 found 3295
Ignoring transid failure
Couldn't setup device tree
Could not open root, trying backup super
parent transid verify failed on 4390576160768 wanted 9196 found 3295
parent transid verify failed on 4390576160768 wanted 9196 found 3295
parent transid verify failed on 4390576160768 wanted 9196 found 3295
Ignoring transid failure
Couldn't setup device tree
Could not open root, trying backup super
parent transid verify failed on 4390576160768 wanted 9196 found 3295
parent transid verify failed on 4390576160768 wanted 9196 found 3295
parent transid verify failed on 4390576160768 wanted 9196 found 3295
Ignoring transid failure
Couldn't setup device tree
Could not open root, trying backup super
