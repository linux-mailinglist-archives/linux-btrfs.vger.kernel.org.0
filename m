Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184A31D4B4B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 12:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgEOKo7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 06:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEOKo6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 06:44:58 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABCDC061A0C;
        Fri, 15 May 2020 03:44:56 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 188so1397410lfa.10;
        Fri, 15 May 2020 03:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RP/C+T1G9Ut2iOKolnfVAMBSxN8RIC6J9bPF0F0wsOU=;
        b=VgV4vnHk/xDyNeMazwEiccDn0tx607GkqAOjIVpkNcQlpKA0yk6QiIq2iiw/SvrSMB
         /9T4YYOqWgMKy3laVmhj6LZUdWgwoI8hGn47Dm0lPfoPycjfU6/wMY1nl29Fao6HPGAM
         IUyMLt/wNsvIUCri6O4MQM7X4ETd6JL163HEvI61Wu8j/lpbVYHQK8LOQEYoGqlyiy8v
         dhgExbU/7wjjZ5mWJCq05sx5zobMgfSBZuJkoRRgZoeg530AGaW6dfWL+HC+0xOaCOc5
         7ya49tN5yXHlC12FfLWHVvjka9pwf8SJ/y7szscZMq2whuiUq5QemangKzSbVyXtIL68
         Dd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RP/C+T1G9Ut2iOKolnfVAMBSxN8RIC6J9bPF0F0wsOU=;
        b=qOd1kp5WQhzrb7JYhcDMid2k+Lw0hCrXkN8g5euwtwQaI/BUgI9EHqb9JceckVgD/t
         cvLLzJF3dZRgOwP8y1L4DwQjNAW4Iap9+l/cBiSzWqaljQQOhNjpvfwHWOmrG8i9EWFo
         VWUqh9VtLmyFbn8sNLSATNyBtFJoJmmfDmI0Y0a1koyciUkKvR7pSh8gylsQlOwwalfj
         KvANTVuZsu6PgiBEyjN29EEbsJeg50IsV2q9X4zecsKtLiJg4JStwga2uR1U8t+PWRa8
         NpPllxATe/WRE6YtxVVNWflQouL89PlvObZeL9yA7hmlFXyxOk9KOqyxA36u/HYUwSVR
         U6AQ==
X-Gm-Message-State: AOAM5316VJ2h+ZCR7pFHA4C05Im1jRGfohBuEnqWV3qvdw2FBwf+CFJH
        7lkK5YNieQ8QzZ3Sf0tsMQcOEsSkROfQDFIZBOg=
X-Google-Smtp-Source: ABdhPJwrShfI7gSIURk9dxTDqiEefZ5tzPAA1hhJWtIIiOZzjgjSBp4ntBv8ZrLyRmdnBk7A5M2eKz4h7R+uK1TVd10=
X-Received: by 2002:ac2:5212:: with SMTP id a18mr1971443lfl.83.1589539495366;
 Fri, 15 May 2020 03:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200515021731.cb5y557wsxf66fo3@debian.debian-2>
 <SN4PR0401MB35985CFC199D20362EBFD8E09BBD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAKq8=3KyewqQLdo-GjERuOfKe5ZrmQ+bRPfFRWiyZkjdEVvSeA@mail.gmail.com> <SN4PR0401MB35989B816CB1DA4BCB75B1FC9BBD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB35989B816CB1DA4BCB75B1FC9BBD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Fri, 15 May 2020 18:44:44 +0800
Message-ID: <CAKq8=3L7u05wneTt=DRPNU6dCrg=OMN-Zcp9XgTcd3MWbjPKUg@mail.gmail.com>
Subject: Re: [PATCH -next] fs/btrfs: Fix unlocking in btrfs_ref_tree_mod
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "sterba@suse.com" <sterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 15, 2020 at 5:36 PM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 15/05/2020 11:24, Bo YU wrote:
> > Hi,
> > On Fri, May 15, 2020 at 5:03 PM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 15/05/2020 04:17, Bo YU wrote:
> >>> It adds spin_lock() in add_block_entry() but out path does not unlock
> >>> it.
> >>
> >> Which call path doesn't unlock it? There is an out_unlock label with a
> >> spin_unlock() right above your insert. So either coverity messed something
> >> up or the call path that needs the unlock has to jump to out_unlock instead
> >> of out.
> > This is out label without unlocking it. It will be offered spin_lock
> > in add_block_entry()
> > for be. But here I was worried about that unlock it in if() whether it
> > is right or not.
> >
>
> No add_block_entry() returns with the ref_verify_lock held on success only:
> static struct block_entry *add_block_entry(struct btrfs_fs_info *fs_info,
>                                            u64 bytenr, u64 len,
>                                            u64 root_objectid)
> {
>         struct block_entry *be = NULL, *exist;
>         struct root_entry *re = NULL;
>
>         re = kzalloc(sizeof(struct root_entry), GFP_KERNEL);
>         be = kzalloc(sizeof(struct block_entry), GFP_KERNEL);
>         if (!be || !re) {
>                 kfree(re);
>                 kfree(be);
>                 return ERR_PTR(-ENOMEM);
>         }
>         be->bytenr = bytenr;
>         be->len = len;
>
>         re->root_objectid = root_objectid;
>         re->num_refs = 0;
>
>         spin_lock(&fs_info->ref_verify_lock);
> [...]
>
>
> While the code caller checks for an error:
>
> if (action == BTRFS_ADD_DELAYED_EXTENT) {
>                 /*
>                  * For subvol_create we'll just pass in whatever the parent root
>                  * is and the new root objectid, so let's not treat the passed
>                  * in root as if it really has a ref for this bytenr.
>                  */
>                 be = add_block_entry(fs_info, bytenr, num_bytes, ref_root);
>                 if (IS_ERR(be)) {
>                         kfree(ref);
>                         kfree(ra);
>                         ret = PTR_ERR(be);
>                         goto out;
>                 }
>
> So if add_block_entry returns -ENOMEM it didn't take the lock and thus no unlock
> is needed.
Ok,  I got it. Please drop it.
Thank you!
>
> Or did I miss something?
