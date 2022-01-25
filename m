Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701B249BCA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 21:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiAYUCS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 15:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiAYUBR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 15:01:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9408DC061753
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 12:00:54 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r59so3183003pjg.4
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 12:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qs5ZpyHdQICFlhZlFhoqnzxayBNHB3cQ6OpDxmrUeyE=;
        b=ilaXob9LJvFT0ifCTvVoFqBTvItOnZgEpX5QBLFE8HKmZ9L1pYdSey6P9PN2AyHSRU
         ijaj4s6j+l6WwXokg3RtCzmCD0qAxIBYL+BkQhADDrq74Be4lE1a66fPQq/+B5uI9Nqy
         4hxx1Nw3NBsdaNhncTImFQzE8n2tQ2md+jMmAx9wOFiE/GY8600zTio38CDrklQBjECL
         7ohJrksfXqddHzdprPZa7gU4CYfNt6lfTL5Z32VCjJz0eFHXXkMs/kgiF8aPFBmb/Flw
         Yjn+t5Uc1AIsccXUkcU71r+DYrxnagG3yZkzAJHBT7ehlPmqwG/vMVF8y3K6SfQ/sJt7
         Ofig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qs5ZpyHdQICFlhZlFhoqnzxayBNHB3cQ6OpDxmrUeyE=;
        b=oPh3HHGwMyKt743hsqoE2YNanln3caWAC51uCBEl0sLxPNxZ2izfwWiv4Q9iONS+vP
         n2Ftf7hJ4PBrcOZy9en3SyCSxkkFqCvT0HpQykwjjUvF5xlz8d3s9X9eFw2PXaOG/grb
         3e5VoQDg2pJOXi7wvhwVlPTdxt6tx9EIcKb/CmaA7iCi2GgIujzxQvZJETAE5JTCWvI2
         Q1fjjrBWo90iPPLASxgAJAEpCNhb6Z/+xp0sYM4RmZd5j7V7EzK62q7mI266juLdrtvX
         frLeg0V92ZtnBXlQvrpFRjCmDdHidfvohRv8n8CfmIGCxQQyEfDL2vocscSCFkfza07/
         JScg==
X-Gm-Message-State: AOAM530qHxSWxrOnVB6EhSxiXJy2L1dHj2ijGEzgtZ+t2OqSpdlTcg6s
        0glz1DLoP+l+WQBJiduubY8DUsxsurHyMLbx81Y=
X-Google-Smtp-Source: ABdhPJxdPPt00LwwlP2vKCNndDY4TtHNZs3i0RzXtJK4o6BzwYZnjQi7gKEBiI0IsG/qVjm9+2NYj4H1ecpBbDgdAfc=
X-Received: by 2002:a17:90a:17a5:: with SMTP id q34mr5139686pja.1.1643140854125;
 Tue, 25 Jan 2022 12:00:54 -0800 (PST)
MIME-Version: 1.0
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
 <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
 <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
 <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
 <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com>
 <CAL3q7H7xfcUk_DXEfdsnGX8dWLDsSAPeAugoeSw3tah476xCBQ@mail.gmail.com>
 <CAEwRaO4Doi4Vk4+SU2GxE7JVV5YuqXXU_cw7DY9wQrMnr9umdA@mail.gmail.com>
 <CAL3q7H4ji1B7zn4=mP4=891XfokkVyOaaqW3dCmUH6uVGjgkjg@mail.gmail.com>
 <CAEwRaO7cA3bbYMSCoYQ2gqaeJBSes5EBok5Oon-YOm7EQ8JOhw@mail.gmail.com>
 <7802ff58-d08b-76d4-fcc7-c5d15d798b3b@gmx.com> <CAEwRaO58oCzY4GjU3gCSru3Gq02GvGSdkg5hPwCKMwYcZ+cM2Q@mail.gmail.com>
 <c88c1438-ebcf-a652-1940-4daa4ee53be9@gmx.com>
In-Reply-To: <c88c1438-ebcf-a652-1940-4daa4ee53be9@gmx.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Tue, 25 Jan 2022 21:00:41 +0100
Message-ID: <CAEwRaO6ogPZKU3pcKac2kMqpvwDRX4eCUnFj0_OxTndPF2Be_w@mail.gmail.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> > Mind to test the latest two patches, which still needs the first 6 patc=
hes:
>
> Gotcha, I'll test the following stack tomorrow, omitting patch 7 from
> Filipe (hopefully the filenames are descriptive enough):
>
> 1-btrfs-fix-too-long-loop-when-defragging-a-1-byte-file.patch
> 2-v2-btrfs-defrag-fix-the-wrong-number-of-defragged-sectors.patch
> 3-btrfs-defrag-properly-update-range--start-for-autodefrag.patch
> 4-btrfs-fix-deadlock-when-reserving-space-during-defrag.patch
> 5-btrfs-add-back-missing-dirty-page-rate-limiting-to-defrag.patch
> 6-btrfs-update-writeback-index-when-starting-defrag.patch
> 7-btrfs-defrag-don-t-try-to-merge-regular-extents-with-preallocated-exten=
ts.patch
> 8-RFC-btrfs-defrag-abort-the-whole-cluster-if-there-is-any-hole-in-the-ra=
nge.patch

After testing this one immediately reduces I/O to the 5.15 baseline of
a few 10s of ops/s,
so your hypothesis does seem correct.

Fran=C3=A7ois-Xavier
