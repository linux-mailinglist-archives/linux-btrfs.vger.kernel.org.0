Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B8655DCF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiF0MxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbiF0MxG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 08:53:06 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638CF65BF
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 05:53:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r9so5572874ljp.9
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=6MCQNYlKz+0Oz1eyuvwy4OkiIxUscdKYbxXdbOj2c1g=;
        b=cHaMrNHIvsBtpa1GlNHagn+iTw122IsKO3dIcc6KAXQ97o9TDHypJ+oLI9aSdDEWC0
         hTTetxM4FK7CmUcSnoPqjoT4aZkl1GwFsunS/B8V4QKlS53OBNmleTBmsp4CWjAMC43W
         LiiopFsc0RExVRTsdHzaZOUNdIn/rX+upsgAeFvE2OaQ4uqHTP1HD0Sknc7anB+YqpmZ
         T+87dxordCWwDQAy8UV4sxSYGM9CJ3PsH8JEQ9sKscGdWpmR4ZXb52OSAwTf10exwlu7
         YugefeCT+ArG0d+noPhp7dQdk66eUZKGZETplmWHzP/m14EbEz7Y+F5xiMfIyGKGzpK/
         jTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6MCQNYlKz+0Oz1eyuvwy4OkiIxUscdKYbxXdbOj2c1g=;
        b=ZjZmJaBnspgRWeVAgvvH4fxhuJaBWeMGAlxHqr19q3IUKtuINHS3WlZVWJOeuHEoBu
         Y/d6WV69PzP4LmadgDUjA0/RKw+0P0NlmW3BSuHaYT0fqVGP8u6gLQCs1rfm4UYV4z//
         GLzgUxVt6s9pyQxsJC8RDfvGgg6AxAorJdGxRW+7Y3l3K2c49+l/nDTqueea7/FB9Hln
         LrGa2cJn43KJQ91ZGmJ7igar6bxtIZoJEndW1manNnPBtQC93LITzyRskrVNzdQZO0PS
         w8Dkm5xGNElsrpX/gLn7lqjZC9V1rXIG4HsQqP68Y8k/5XpC3zzYAWXRkjDW/jOWyCyi
         Qo/Q==
X-Gm-Message-State: AJIora/LS+ftvwsPrNHife/LFLzmL0O478KrJVj8PTkf3aVUPb4ibRbb
        2/0OFp317gwwK0ri2N9eQLotCvCr5gT6ysvPUkFhTtRdM0r71w==
X-Google-Smtp-Source: AGRyM1uA/gHWSaQIz7+IJSyw0zvZGDIt+Hu0/jkHNIwKwB78s+p4D+ZNI6Ns1C+zuQY0iAagS7/vtTCg2SZcFw2MxNs=
X-Received: by 2002:a2e:9ecf:0:b0:25a:6d9e:5d39 with SMTP id
 h15-20020a2e9ecf000000b0025a6d9e5d39mr6909643ljk.41.1656334383749; Mon, 27
 Jun 2022 05:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAL4T1UXZCzOQD_EHF1oMus-b44EzpwEFbKu6pvxQfA3Lu+Y8fw@mail.gmail.com>
In-Reply-To: <CAL4T1UXZCzOQD_EHF1oMus-b44EzpwEFbKu6pvxQfA3Lu+Y8fw@mail.gmail.com>
From:   Sammie Cohen <samanthacohen294@gmail.com>
Date:   Mon, 27 Jun 2022 13:51:33 +0100
Message-ID: <CAL4T1UVCHQ4-GdY7Bh8GVW8N8YvwGzDZB8uVcqt1r4Y12RGj4A@mail.gmail.com>
Subject: Re: FS failing to transact on one of the users on my machine
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

Hi - after getting some help on IRC I was told that this would be
interesting to the ML

This is journalctl output from a week ago when the issue first
presented. More detail available here https://pastebin.com/gXMzRuf0

Jun 21 09:38:54 arch kernel: BTRFS error (device sdb1): parent transid
verify failed on 297560588288 wanted 514104 found 514232
Jun 21 09:38:54 arch kernel: BTRFS: error (device sdb1) in
btrfs_replay_log:2567: errno=-5 IO failure (Failed to recover log
tree)
Jun 21 09:38:54 arch kernel: usb 3-8: 3:1: cannot get freq at ep 0x84

Here is the output from `btrfs check --readonly`
https://pastebin.com/YAnQH9wB

Hope it helps you out some

On Mon, 27 Jun 2022 at 11:33, Sammie Cohen <samanthacohen294@gmail.com> wrote:
>
> The problem is that BTRFS is failing to transact. It'll then find a
> mismatched transaction ID and force the partition into readonly mode.
> I won't be able to restore the system to read/write until I clear the
> log using `btrfs rescue zero-log /dev/sdb1`. My machine has two users.
> "Work" and "Sammie". On the Work account, when I log in through i3,
> it'll encounter this issue within 5-10 minutes. On the Sammie account,
> I can use my computer for hours or days at a time with no issue. But
> it does sometimes still happen on there. I haven't figured out any
> particular action that acts as a trigger for this behaviour. In dmesg,
> the first warning I get that something has gone wrong appears to be
> the error saying that the transaction ID can't be verified.
>
> Below is all the output I was told to include. Any advice on fixing
> would be amazing.
>
> Thank you
>
> -------------------------
> uname -a
> Linux arch 5.18.7-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 25 Jun 2022
> 20:22:01 +0000 x86_64 GNU/Linux
>
> btrfs --version
> btrfs-progs v5.18.1
>
> btrfs fi show
> Label: none  uuid: 383c186c-d4db-472f-8658-67440c74917a
> Total devices 1 FS bytes used 195.62GiB
> devid    1 size 430.26GiB used 204.00GiB path /dev/sda4
>
> Label: none  uuid: c317dd26-5ac2-438c-ad5e-6036b2f69053
> Total devices 1 FS bytes used 419.66GiB
> devid    1 size 447.13GiB used 426.02GiB path /dev/sdb1
>
> Label: none  uuid: 28deecb8-cb49-4be8-87b7-7d039c17c598
> Total devices 1 FS bytes used 2.36GiB
> devid    1 size 447.13GiB used 5.02GiB path /dev/sdc1
>
> Label: none  uuid: 9f36054f-50b6-493d-898a-b78f71c4a86d
> Total devices 1 FS bytes used 1.70TiB
> devid    1 size 3.64TiB used 1.71TiB path /dev/sdd1
>
> btrfs fi df /home
> Data, single: total=420.01GiB, used=415.28GiB
> System, single: total=4.00MiB, used=64.00KiB
> Metadata, single: total=6.01GiB, used=4.38GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
>
> dmesg > please find attached
> At 1220.058269 BTRFS fails to verify the transaction id and forces the
> partition into readonly
