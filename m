Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8238617549
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 04:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiKCDx1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 23:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiKCDwr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 23:52:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADC819C1D
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 20:51:16 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l2so723909pld.13
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Nov 2022 20:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rwtalWE07zgm8uGzPxqdyirAkE6cI8IJy2xBUKAXzIA=;
        b=Tf6vavB/grZ+P4eUZExvy20cwsdU9/o+z0DmswdXvv7evopQBuP2gwj0GTo4YaZSi7
         UJixxHcCPTsQ7P7blgTxy4UuNpH4h5zeEO/xfrlIyzQnVAj1RHBawl9qZDnynO+cdrPY
         leJujQ36nFnxTnV2ADSmh9HhN0YJJWyFjWnqU0+FkQ1Qv4/b14FLOy/ibsJQZ0XuDuDH
         5Hb2qvkPr35bJxyht5/j/C0yvDt0RmtX4d1mjUng0P7I2zizttSbPs5OZFPUNwj0rq2x
         Bt8zQbU0UG56S7bOwkUX6oilGSSVsKAbD+zrDHMfiCriFgB32fZgJ4rFJGRF4GpmEs1+
         wNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwtalWE07zgm8uGzPxqdyirAkE6cI8IJy2xBUKAXzIA=;
        b=0z+pyY5Oq8ijpYGoHCRV3aZ5HJdAvNkDKbBlncn5RxsIMCcWxDn8Cu3HqLZ4zmxpub
         EJMMva/5he0Q0Lbx52V9n5QP9hyavAIkgubRa7FHxHCoW5lYrD6Ndt21wNso2gUn/ZUb
         kqLA/dSeW9qUwTSPyiHF00umq6rZ/vNLjXQrqCVSh2zJ7QSA9euFZAeDunzcjxT1+Nnw
         71KOib1VfBE6dET7BD7JaeewFUU4N7SFVZafP80BsnIqUGk/kLdQlgrWEEBF4E7+EG9q
         WypyunGf2UBSb4WizBsPYnv/g0RuEznTv16GyXpBLayZGyFcM9jV9pwiBx3I+nj37/dg
         p4pA==
X-Gm-Message-State: ACrzQf3zFWDbhL/LrgD9AM8W9+v3/PX594BX+SnWfofHzc+K4QCcRRLK
        HXDJqd0oC/FNtQiZlZy9+JoYmo6SAo8=
X-Google-Smtp-Source: AMsMyM4+bwMVoLQELRH1pFcvtuI7zUiJ8S69PtyLS8m5XQg936sTvXIem6gN2eh7bV7rKO8tOGXAWA==
X-Received: by 2002:a17:90a:488c:b0:213:b4ad:7270 with SMTP id b12-20020a17090a488c00b00213b4ad7270mr26345692pjh.130.1667447474983;
        Wed, 02 Nov 2022 20:51:14 -0700 (PDT)
Received: from ryzen3950 (c-208-82-98-189.rev.sailinternet.net. [208.82.98.189])
        by smtp.gmail.com with ESMTPSA id mt7-20020a17090b230700b002135a57029dsm2221493pjb.29.2022.11.02.20.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:51:13 -0700 (PDT)
From:   Matt Huszagh <huszaghmatt@gmail.com>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How to replace a failing device
In-Reply-To: <20221102003232.097748e7@nvm>
References: <87v8nyh4jg.fsf@gmail.com> <20221102003232.097748e7@nvm>
Date:   Wed, 02 Nov 2022 20:51:11 -0700
Message-ID: <87v8nw3dcg.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Roman Mamedov <rm@romanrm.net> writes:

> Remove this cryptsdc2 from the FS (btrfs dev remove), stop the crypto device,
> wipe sdc2 entirely with wipefs.
>
> Then power-off, boot into a rescue system such as grml.org, and use "ddrescue"
> to copy the entire content of ex-sdd1 to ex-sdc2.
>
> After "ddrescue" manages to copy whatever it could, power-off and remove the
> old failing "sdd" from the system. Do not boot the main OS with both disks
> still plugged in. You can wipe the failing one later (after verifying the
> created copy is good) on some other PC, or booting into the same rescue system
> again.

Thanks so much for the help Roman. I was able to mostly recover the old
device and am now running my computer with ex-sdc2. ddrescue reported
99.99% data rescued with 2 bad sectors. Since I didn't have any trouble
backing up recent data, I'm optimistic I haven't lost anything of value.

I'm investigating RAID configurations (probably RAID10) as a way to make
the process of replacing faulty drives somewhat smoother in the
future. If you have any opinions on this would be curious to hear
them. I'll probably also setup a periodic systemd service to run
smartctl and detect issues (hopefully) earlier.

> The reason for calling them
> "ex", is because it is extremely unfortunate to refer to disks by their sd*
> names like that, as those can vary per kernel, distro, random delays during
> detection, etc -- and of course, the controller ports used. So double-check to
> ensure you get the source and destination right.

Yeah this was a bit of a poor choice I made a while back and failed to
update it. I've now changed my configuration to refer to them by the
device serial number (as reported by smartctl -i) and partition (e.g.,
/dev/mapper/S5H9NC0MC06674P_p2). The disks are found by UUID, so this
should be more correct.

> Of course this eschews the question of why Btrfs is not behaving in a more
> desirable way in these circumstances (maybe someone can weigh in on that), and
> does not use its native tools to recover, but this feels to be just the most
> straightforward idea of "what you can do" right now, to bring the system back
> to working order.

Not sure if it will help, but I'll update my Linux kernel version, which
I haven't done in a while. Still curious why scrub wasn't helping
though.

Thank you!
Matt
