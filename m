Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBC577A322
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Aug 2023 23:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjHLVtz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Aug 2023 17:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHLVty (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Aug 2023 17:49:54 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B56A1706
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Aug 2023 14:49:57 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34978cc9e53so12036635ab.2
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Aug 2023 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1691876996; x=1692481796;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg0ckg/H3P7to9hPYkGHbfdW11xHkTJ8HjcIavn3Aw4=;
        b=iTKI2svr5mDp8wFBy/uJzxOH6Lau5tTyxzHCQIr9wznW6ohyDudbMwLwzctj2HFSgn
         vn38cDpR5YVMmZcqkuLyT9n+qGujHh1EV2I37PZcdeUlLOsHIcSKGrMwr+/AQo1AIvvD
         ZIvIYW5cZyqXXJYmwlV43Z3T+6fjiR/4DmYFK+MEPTxeBqa34MU0xmlh5/GV9SvjyRKs
         c6ElAGAiaXLC92c4B0JjRnQQB9PWfGh37K8rt3tIHZsAdBQnpFjcvu6Q99kN9qd/bElP
         zRpP6tMzRVO0PVuyM153RIHxL9FKwLH7qyydGerHi3wanTD7huHQjacVAaL9ga4BrW7F
         52sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691876996; x=1692481796;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lg0ckg/H3P7to9hPYkGHbfdW11xHkTJ8HjcIavn3Aw4=;
        b=eB1WFit9fb9B/pT2TuyqKD3O60O2ZRbl3Fm3+q9Iyjvj6cnEW6pDFtYLNLwBNav/Eh
         P/v1B/hdx/y5xZy4p2YxYQNLdI9QMWuxuII0LIcUw8wNOEMPuWVKxJhSwwK9Qolc9r30
         rdI9F1/q24rTQ0esr3LjEvhRgagVYPiLhBoMEFVk5p3C6v5j7dc97dq71SbQnTnOqoUX
         rvkmqG/jynMfgvzpnVd6bZv8cijS5Gz0SX4hhW963E7j/Hcc3BrkYqbTL6nmw1EjKLkK
         QQng278cQiqiVtv/QMU6HPbd+HGxIdSeY1LMJgJ5QkBSJkVKbGM9ySfKZb9VAxY+KGHw
         9t3w==
X-Gm-Message-State: AOJu0YwM5Tg2ZWI7F7cKakt4YV6O/BLiyEWw+YNR3SwY0LwRksX2dC+Q
        jVmkWbFiJfKhRg3JqQ6KwUMamoFEonA75NH5b22eyg==
X-Google-Smtp-Source: AGHT+IEMeHFEvQ7JwVMOHhQPjAXKD+WePxiPusRP0ux2+qcwjGs7ttRSh8dZU8D3vUGwfKEiRH92Hg==
X-Received: by 2002:a05:6e02:13f1:b0:349:861a:9c1d with SMTP id w17-20020a056e0213f100b00349861a9c1dmr7472542ilj.8.1691876996634;
        Sat, 12 Aug 2023 14:49:56 -0700 (PDT)
Received: from ?IPV6:2607:fb90:9a16:52e0:3ea9:f4ff:fe4b:aee8? ([2607:fb90:9a16:52e0:3ea9:f4ff:fe4b:aee8])
        by smtp.gmail.com with ESMTPSA id s14-20020a02cc8e000000b004301f422fbdsm1952818jap.178.2023.08.12.14.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 14:49:56 -0700 (PDT)
Message-ID: <2c8c55ec-04c6-e0dc-9c5c-8c7924778c35@landley.net>
Date:   Sat, 12 Aug 2023 16:52:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
Cc:     enh <enh@google.com>
From:   Rob Landley <rob@landley.net>
Subject: Endless readdir() loop on btrfs.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Would anyone like to comment on:

  https://bugzilla.kernel.org/show_bug.cgi?id=217681

which resulted from:

  https://github.com/landley/toybox/issues/306

and just got re-reported as:

  https://github.com/landley/toybox/issues/448

The issue is that modifications to the directory during a getdents()
deterministically append the modified entry to the getdents(), which means
directory traversal is never guaranteed to end, which seems like a denial of
service attack waiting to happen.

This is not a problem on ext4 or tmpfs or vfat or the various flash filesystems,
where readdir() reliably completes. This is a btrfs-specific problem.

I can try to add a CONFIG_BTRFS_BUG optional workaround comparing the dev:inode
pair of returned entries to filter out ones I've already seen, but can I
reliably stop at the first duplicate or do I have to continue to see if there's
more I haven't seen yet? (I dunno what your return order is.) If some OTHER
process is doing a "while true; do mv a b; mv b a; done" loop in a directory,
that could presumably pin any OTHER process doing a naieve readdir() loop over
that directory, hence denial of service...

Rob
