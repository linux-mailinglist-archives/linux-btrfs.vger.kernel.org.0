Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AA7643B67
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 03:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiLFCmS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Dec 2022 21:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiLFCmR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Dec 2022 21:42:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866ABBF72;
        Mon,  5 Dec 2022 18:42:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id y16so21604007wrm.2;
        Mon, 05 Dec 2022 18:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cSoZALCCgZ9J9X4NU6zzWcqo3fV2QQvKn2ulvrjOZfQ=;
        b=FOpGkLQHKdMr6M8r2mXJRnNpjY6arwsM/xuXB6d/oFzrZeiIN6nwdOXjjPkLT5idgn
         ojTrLaWECpJLlju35z7/zPUmFeHPBSQZxuUzF5rWfMFD496NBgSo3D2tJY93/8fddVID
         wWnniu0DQFML7Wu9LtuZ9kzzDk+Cga+GSrPaHd6DYv9SEJs7qf2h690UJbkVBTSg7+9I
         83wYf50nI56m/+H5HPwwy7y9fPaHCrva956ec6Ax8eEQGFMuPF/HVJg+HeyJD+uEC+YN
         ZbGIVZRBqZthzdXGpPzTCaIxWC3tCEqGIr+eIiG3iEcoSQsFNALrV6BmGy+fXMa6wJO7
         OpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSoZALCCgZ9J9X4NU6zzWcqo3fV2QQvKn2ulvrjOZfQ=;
        b=N91O4gWeuNL9RskBkigiP1w19tjVYUMsrNWmJVQIT5HnZjKAl463Eq5wV/J/RLbvUL
         PTWfnvhH787qPJzzPIMyMlHQDIxy9uuRCZdYnCPgf7VluUyIicP9R/yHfixXYMMGiRRh
         mi0LW+R5ku8G2DJ8YoHPvJRZ60XwMfHY2dpDXQ/PyPAL2shq21AOOGxP75e1YBoZYYvd
         mv2JoSQYZ+N1Y+iLOezuAUuIT3xnvWhbZKZg1fNVFZw5pRo7/cpRxJ8W9bXyVSMDP4oZ
         IBeJxQcQgQIwBi9SfS25S5EunIROzOOEXRWv3fYaxXpHr4tcXPfWTIvaTQXRXhTlg5KS
         Fa2Q==
X-Gm-Message-State: ANoB5pk7LIwXjMD7c1LTUFe5COQBeJTcfAaHXj86WC/2LxeH9ZCBGoar
        nf2T0KPDlGE5aCrG9yzrO1lZO/TIxr4tJgKms2KKIch3sy8IsA==
X-Google-Smtp-Source: AA0mqf5oi1d5gxjahQbv5PfOaEz398qzEI5UCtWJbX3f7A7o7SJ09hQIImwk8g7g8yKwTOe3YlCsg+zP1O6mVZA1aks=
X-Received: by 2002:adf:d0c6:0:b0:242:1873:bb28 with SMTP id
 z6-20020adfd0c6000000b002421873bb28mr22462374wrh.485.1670294534643; Mon, 05
 Dec 2022 18:42:14 -0800 (PST)
MIME-Version: 1.0
References: <20221201160724.2593341-1-cccheng@synology.com> <CAL3q7H5oet2P9XijTtzPo3joZWdoa3OuD9L-wK9nTEFya2PY8w@mail.gmail.com>
In-Reply-To: <CAL3q7H5oet2P9XijTtzPo3joZWdoa3OuD9L-wK9nTEFya2PY8w@mail.gmail.com>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Tue, 6 Dec 2022 10:42:03 +0800
Message-ID: <CAHuHWtnbVsS2pp5EySmZ_72fCrDqKJTAOkssa-D-X5wKoR9uWQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: refuse to remount read-write with unsupported
 compat-ro features
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@cccheng.net, Johnny Chang <johnnyc@synology.com>
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

On Mon, Dec 5, 2022 at 6:45 PM Filipe Manana <fdmanana@kernel.org> wrote:
>
> Wasn't this already done by the following commit?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=81d5d61454c365718655cfc87d8200c84e25d596
>
> Thanks.
>

Wow. I did not notice this commit doing the same job by Qu. But I have
tested the latest linux-6.1 rc-7, and it's still able to mount a unsupported
comat-ro btrfs as read-write via remount.

It's caused by the follow-up commit d7f67ac9a928 ("btrfs: relax
block-group-tree feature dependency checks"). This commit checks read-
only with the current superblock, which will always pass in the situation
remounting from read-only to read-write. It seems `btrfs_check_features()`
cannot cover this scenario.

        if (compat_ro_unsupp && !sb_rdonly(sb)) {
                                ^^^^^^^^^^^^^^

Thanks,
C.C.Cheng
