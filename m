Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BCC3FBCC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 21:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhH3TJP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 15:09:15 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:33694 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhH3TJP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 15:09:15 -0400
Received: by mail-lf1-f54.google.com with SMTP id p38so33453666lfa.0
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 12:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKdXrfUWiKul/R0Ht2C1noK7U5YABoCTXn18esa4TCI=;
        b=WqwZVzDv8nJDZZ2CVzROO5QRSVUwIa4dAVUOpkk8ppiu7RX3SxQ1LOhv/PCirVF2i9
         yvn1An2Y0K4MYTOsaPH6mAz2Dw6erZIh5VGLh3+TQVfkKl/uYkuRuHJm/8GeK5wGLpT/
         nJqvAS6g0RbIWX/71Gklx7cZzg8nRDBGB86ylcUc7VWiAS0tp+l3Z0id985YP7z1s17E
         CSfkuc95a2rMKUWfVYs0lx7Kxf9biwVS++2/CrCGQ62QSKQdq7L9l0LJNhAy3cRRx6DH
         SLMfJIecF3YBdTbiOkv6kg0GfvQ+OPoTHgIta1sPepgZzOvBhJ5m+OtOhtFkDuSlAS3T
         eWSQ==
X-Gm-Message-State: AOAM530VFRGbuP7HzHruSdFSXa4/5t/WS0zi9Z2Q7h7pRvfAlpqdk/j0
        pMuGzd15GUdKquBAS/RJnmBAfkzJpEWOxIrk/lRlmm8g1Aw=
X-Google-Smtp-Source: ABdhPJzNAlhNH4F0YzzCRtvhXa8/avR3tXdCKrq+3Nxher1fW7Js1/VWZuXHstOFPxetvbgfPDO08NocO9cIjBjYOdA=
X-Received: by 2002:a05:6512:21c3:: with SMTP id d3mr17196038lft.226.1630350500058;
 Mon, 30 Aug 2021 12:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
 <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
 <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
 <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com>
 <CAOaVUnUwoq69UZ_ajoxYYOHk8RRgGPNZrcm9YzcmXfDgy24Nfw@mail.gmail.com>
 <CAL3q7H67Nc7vZrCpxAhoWxHObhFn=mgOra+tFt3MjqMSXVFXfQ@mail.gmail.com>
 <CAL3q7H46BpkE+aa00Y71SfTizpOo+4ADhBHU2vme4t-aYO6Zuw@mail.gmail.com>
 <CAOaVUnXXVmGvu-swEkNG-N474BcMAGO1rKvx26RADbQ=OREZUg@mail.gmail.com> <CAL3q7H5UH012m=19sj=4ob-d_LbWqb63t7tYz9bmz1wXyFcctw@mail.gmail.com>
In-Reply-To: <CAL3q7H5UH012m=19sj=4ob-d_LbWqb63t7tYz9bmz1wXyFcctw@mail.gmail.com>
From:   Darrell Enns <darrell@darrellenns.com>
Date:   Mon, 30 Aug 2021 12:08:09 -0700
Message-ID: <CAOaVUnVL508_0xJovhLqxv_zWmROEt-DnmQVkNkTwp0GHPND=Q@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yes, those are the correct IDs:
$btrfs subvolume list /|grep '\(881\)\|\(977\)'
ID 881 gen 35385 top level 453 path .snapshots/327/snapshot
ID 977 gen 39922 top level 453 path .snapshots/374/snapshot

The only thing I get in dmesg when running with the debug patch is this:
[   97.010373] BTRFS info (device dm-3): disk space caching is enabled
[   97.010375] BTRFS info (device dm-3): has skinny extents
[  209.435073] BTRFS info (device dm-3): clone: -EINVAL other, src
400186 (root 2789) dst 400186 (root 2789), off 79134720 destoff
79134720 len 4751360 olen 4751360, src i_size 83886080 dst i_size
83886080 bs 4096 remap_flags 0
