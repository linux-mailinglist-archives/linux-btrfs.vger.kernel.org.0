Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2E82AAA89
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Nov 2020 11:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgKHK1O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Nov 2020 05:27:14 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:37813 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgKHK1O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Nov 2020 05:27:14 -0500
Received: by mail-lj1-f181.google.com with SMTP id l10so6434247lji.4
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Nov 2020 02:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zgtkAkXoToBZQ0aQwe01YNm8FJUSqv78NKG1gFtiJJ8=;
        b=dLLC+mhZ31qfujJijmAF3En7ZLj3H9JNszAvpi6C8gai8P/lx3Hom23qFmty3JtGdd
         7jCCQh+a1LawpA1JWoS2ukt8QvpeIyJLunt7k4RQx606DuN53IUyVpypF45Iddnjb0La
         q07On2W1StwKhmCAj+rDcg+J59mT3KKrmZ8M5sb9wMtqra057Ze4h+fzUL4HTKEe8Sbd
         lwvuj2wVmENZ+grSx0eghbHEHkldERDJRvZUcaWdtsqrYv3htLPVTxNd4vdvdJl0Eg3b
         I832flSUQ3pHXRO6OKQn9zJ0jqIQhnGXcAhfNbOOTswsesWQ/7beSiN+CKEqvL5On9Bs
         ZO/A==
X-Gm-Message-State: AOAM532yj2UqTadm5pP1jSA4NRUsYql2k+AIaeVhzkHeroUxDeumUjhl
        w18sUG46UHEdsm/Q8GaW4LA9LoFUONlvPA==
X-Google-Smtp-Source: ABdhPJyucF5nNkmKo7eIbIHmC+TZB4yT0m0BYsMLOSvyDHn93Pck+hH4ZCmdr6X++Dq/7KAU6gU7kw==
X-Received: by 2002:a2e:9f07:: with SMTP id u7mr2399900ljk.251.1604831232578;
        Sun, 08 Nov 2020 02:27:12 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id b76sm1171382lfg.13.2020.11.08.02.27.12
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 02:27:12 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id m16so6424892ljo.6
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Nov 2020 02:27:12 -0800 (PST)
X-Received: by 2002:a2e:b54a:: with SMTP id a10mr3816748ljn.139.1604831232203;
 Sun, 08 Nov 2020 02:27:12 -0800 (PST)
MIME-Version: 1.0
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
Date:   Sun, 8 Nov 2020 10:26:56 +0000
X-Gmail-Original-Message-ID: <CAHhfkvznk6bMSX296zDXqNcDdU=HsUEFLX=_a20isYVRvTT_cQ@mail.gmail.com>
Message-ID: <CAHhfkvznk6bMSX296zDXqNcDdU=HsUEFLX=_a20isYVRvTT_cQ@mail.gmail.com>
Subject: btdu - sampling disk usage profiler for btrfs
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear list,

I would like to announce a new tool for analyzing disk usage on btrfs volumes:

https://github.com/CyberShadow/btdu

btdu works by continuously picking random points in the logical
address space and resolving those to paths. The results are displayed
in an ncdu-like interface, which is updated live as more data is
collected. Consequently, results "accurately" (as far as random
sampling allows) depict usage when deduplication (snapshots / extent
cloning) and compression is in use.

I hope you will find this tool useful in obtaining more insight about
your data storage.

- Vladimir
