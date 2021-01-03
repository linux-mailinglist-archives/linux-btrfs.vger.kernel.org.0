Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEAB2E8A27
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Jan 2021 04:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbhACDvb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Jan 2021 22:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbhACDva (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Jan 2021 22:51:30 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C4C0613CF
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Jan 2021 19:50:50 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x12so12650256plr.10
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Jan 2021 19:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1uOJiTEG7geUhbvAb1WO/zQoPIJ3uAClUIdvJBbyHHQ=;
        b=cgg91xuumpRhq4HiyY7ztZD5lkTXUzKj8ev+kF86nht69Eo1z9CO+1FYA9F+BMW2Lp
         EhdezrYXQHTc9aUlwHtLhU8jfo+aOTrLyHN5oUdWttfoiSUb4AvHZ2NUunRQBxoq3i5b
         GQVicXUd8yHVptX1nzUwHf/bBPm4v++yWOmgwumx8yQ5NtJg5X+83cqfaUB/SVQAqJ24
         p/E7IWNL1/vDYDQpZarfJRAahRxi2XL8khh+0NeTLeMc4ASV0AXMXV+D9E1gb9PogPP1
         etXv4Y3VjirdwOalOpTFhwgOKI5ygKpXkiRxzVb2JwvlSbFZciAY24GRl+2JQCdt7+oF
         mc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1uOJiTEG7geUhbvAb1WO/zQoPIJ3uAClUIdvJBbyHHQ=;
        b=QEXoeibEFEfVMajWSTW/Df4FLmcwmo/z/tppUjBhaMvsyKIfQWrGqGIaPn6DnkPESr
         M2/Ael6nuSB8ViX7PQWE7YUZWTWO2o0JUaXm5fWyIzjQ3zcn+xRiFqCoMcyCsMwQsQ1Z
         tC+wOpEmJq98Dwx5SqgDH+S/I3vfcCKOL1m0LvdT/8y9kaszgrwumg3VIQRV0XCbK099
         sBvYQ5cvjE49PLWuOUmof41TP9M/nnK9GoH1xMKGjR8XeUOhy+7zRd5OUGLJDVkiiOgD
         ERKpXq82kOlcWTQC8I0zk8rskMT5DfgVFv3YTRVYPe0jJ6Joz+BwwGwDTYcghD2Pvb0/
         9XxQ==
X-Gm-Message-State: AOAM531pYFTC7Zb6VnI6s44l5qkEMFSN0zL58z5OCXT7RAzKgdZjhVa2
        jqupHieUBU+gJrtkabTBnB8i8FBJeSaGO/47FtXdYa9o8aM=
X-Google-Smtp-Source: ABdhPJzqpV3/BYtdF1FrivSYUeivYaH9Oz/RDlj+ZXKCmediZVLGxCsvU9nc9hYr3i9YEGA+QD9kTeXVoYD8gwyuUSs=
X-Received: by 2002:a17:902:a504:b029:da:fbca:d49 with SMTP id
 s4-20020a170902a504b02900dafbca0d49mr51530556plq.72.1609645849659; Sat, 02
 Jan 2021 19:50:49 -0800 (PST)
MIME-Version: 1.0
From:   Rosen Penev <rosenp@gmail.com>
Date:   Sat, 2 Jan 2021 19:50:38 -0800
Message-ID: <CAKxU2N_=1uKoVMh20h=_8SyOnHM=WvfZjfQP3t81yN2QTZS4Xg@mail.gmail.com>
Subject: Question about btrfs and XOR offloading
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've noticed that internally, btrfs' XOR code is CPU only. Does anyone
know if there is a performance advantage to using a hardware
accelerated path? I ask as I use BTRFS on a Marvelll ARM platform with
XOR offload capability.
