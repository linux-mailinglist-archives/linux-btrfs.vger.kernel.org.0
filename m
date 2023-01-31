Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD5682B63
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Jan 2023 12:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjAaLZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Jan 2023 06:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjAaLZo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Jan 2023 06:25:44 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE749573
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Jan 2023 03:25:42 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y11so14072800edd.6
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Jan 2023 03:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y/2dathwgnqy/wfTdJWBpngZ4YWUsUeoUaM7pctZHHo=;
        b=Q4W7hnm6SsI/X+3vYDOCuiEASCd5SZllpDmmbPwAPgqwEIsFfNJaig0XqagDXaSz69
         OfkUnxn1FWmSG4r1ljntYkt1ikVXSmcBtGnzyekO/21lJpi/jvD6ak4kI6d/o+zLRa5O
         kG+L1Q/mknSioM30dS4+XUJ08csXvqB3g01OmAglzxYzTC5rxZ3LYCYP4XZv3p6yq0RE
         l4lZ1QR5Ksj+Rw6oiJR+SXqgSCBjOyItjLt/spFNw9NtEVntZwt3inrvGNNpmd/xlHHS
         dRISQKM/qD4sdjoDIseWFLVMf3g38JCrdkl+nZ0+irQBtrfT0uw53d0s8yiDkoPmi83B
         GJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/2dathwgnqy/wfTdJWBpngZ4YWUsUeoUaM7pctZHHo=;
        b=FAjTnDQRf5SPKQoS+1Acz1E8YxSM/C9EjepDBhP1e9qGggKbDEZe4U0fMqw/b90aUo
         F1XBZO3uJ/yunfRTqr29m//pQPOsymvNRwTIKfM8ImYh7pUWifH5oGqZSo6MvIV/KILg
         3V6Tf6cXr1V3mwRgqGd4oaipzX4MUgQsppgEVORNbyCVe33uvnXJeeeag2oC7qFtgtfi
         61hDUJCX9gizMneRNOEUD3P9hKzNIeQJE2N4WOX1isDZT8KuO1M3uWwo8L+EHPIV1RQq
         Rj0DdW4wLL6ltlB/vpX/a9Hzw03WF+stTawF40NI2EixgaEhYzReThu560wzq9o0o0fM
         Yfsg==
X-Gm-Message-State: AFqh2krWilUZiAQ0TCmxoF7MQlJqRnxNK64CeQ1G9HA8OLsg/K1mEWhl
        9MyLNM0koPOXd6jlYGmBLIkMXJ9I+UeaTgmIDyc=
X-Google-Smtp-Source: AMrXdXuUIec7i40D15pbm/3ctVs9gnPgmde/YV2IwlocSYd3+O0cG5FDmF8uChCJRHGUTYYJXTzsPw5JedTAydYry5k=
X-Received: by 2002:a05:6402:5514:b0:49c:48ad:3d17 with SMTP id
 fi20-20020a056402551400b0049c48ad3d17mr10577462edb.17.1675164341151; Tue, 31
 Jan 2023 03:25:41 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBcsfBPWUc9pwhSrRu5omkP7m8ZUqhFbF-w_DwQJ3Q_aSQ@mail.gmail.com>
 <c08cea1d-1ae3-c0d1-c164-6453ad73f0c0@libero.it> <Y83S6QRxiM/L/2qD@hungrycats.org>
 <CAA7pwKPeVjqkytpvU1X2txatQzuOULTTBXHBAm46YKQmcMn0Ug@mail.gmail.com>
In-Reply-To: <CAA7pwKPeVjqkytpvU1X2txatQzuOULTTBXHBAm46YKQmcMn0Ug@mail.gmail.com>
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Tue, 31 Jan 2023 12:25:29 +0100
Message-ID: <CAA7pwKOXfCY9hhFgmJOkheimoLzJQ+70325j8s2gTz2WmiL8+Q@mail.gmail.com>
Subject: Re: Will Btrfs have an official command to "uncow" existing files?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     kreijack@inwind.it, Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
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

On Mon, 30 Jan 2023 at 17:39, Patrik Lundquist
<patrik.lundquist@gmail.com> wrote:
>
> I threw together https://github.com/pLuster/btrfs-uncow and even tried
> interrupting and continuing a half finished copy once, which worked
> fine. A huge drawback is that files with holes will grow.
>
> It's not well tested and I don't know if it's very useful. Copying
> zeros should be smarter. Open for suggestions.

Goffredo was quick to add support for file holes. Thanks!
