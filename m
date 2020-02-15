Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E54115FE1B
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2020 12:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgBOLQ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Feb 2020 06:16:59 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:43766 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgBOLQ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Feb 2020 06:16:58 -0500
Received: by mail-vs1-f48.google.com with SMTP id 7so7536975vsr.10
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2020 03:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=S1t91dzydfUYO7LWcCDqrd90MDqg/GwrXjKQX+wg2HM=;
        b=irE2rE8SmByrsdfygPult5ss8PzH40+N1NKEiSBXetBcE3CXU88JlFfkxPYo3mKRlY
         kqr3rakh3X7nEAjbzA25LPr+71kaltuU2yCI+D2wnEwrC9r/2H02/PqlTPaQ7XfqE+53
         NkCNpXjlY51a4wdeFfJTLEwh9xsJ0eFHAg44azRbY5B7rFs0hFSrXHnwUim82+VSVUC/
         lc7JuM0LF8YhDxltbk/LXEwOcP8ViwWAnohmrtSt35YMaUv2NnmYRRgh/KasK27hVILi
         QPoVB76JstysdwUSRGuFl3PPMfax39Jz5j0BKFOLwEtw/99pt4HXUfCOR7Pz7sLf4uHI
         StuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=S1t91dzydfUYO7LWcCDqrd90MDqg/GwrXjKQX+wg2HM=;
        b=mPYbSJF636YBe+ZPcmf7QBeOefF3CQE5KBFDxYrVqFFH38ZEScPbZOZ2H5iOEvOmpu
         XwKesh+6yHUNGzJDYmBi1WEnAgLTRsPWDrpwSs0hgXpYixqHPYqHI7BblFADjhRUOJNd
         964FUczL1mCgnW0cxQpbQMXo+E5nQNYE5CKdLNW6bIvfuW0rgPLbauF6fTplAnxj0nfg
         bWmOpy95tcjMprpjOnWod6eMo5TEeZIzEki3UMGooauEPw8JTxnhtxpVCTMBPySPsOqZ
         8w5pw9qBOwPP6Xeb+aEb38wL879+L5BYio4FWaRI1v/aBGezv5kvEtxMuTebthwtsX68
         YbFQ==
X-Gm-Message-State: APjAAAU1u8/DrWCi9nfAV+ur1xIUrLFSgBCvHlR6jG5CkVBGxPayYvaq
        lkjQ5fd58oJ3D8gcjIZRpvIiDwBItzQx7wp4F8yS/1wX
X-Google-Smtp-Source: APXvYqxXyKEZu+LzNlardPvyzl0wg2Vpg9vGa143J3EbYxheSzuY02sCbXMwGxnACtwCKSyCHI9VDqeON3cE4M49UQ4=
X-Received: by 2002:a05:6102:535:: with SMTP id m21mr3494897vsa.95.1581765417897;
 Sat, 15 Feb 2020 03:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20200215051554.GF7778@bombadil.infradead.org>
In-Reply-To: <20200215051554.GF7778@bombadil.infradead.org>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sat, 15 Feb 2020 11:16:46 +0000
Message-ID: <CAL3q7H7Z182t+qKk4UcN0_10FEe9dEsVehUvtFb7YsLpMzibHw@mail.gmail.com>
Subject: Re: Missing unread page handling in readpages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 15, 2020 at 5:22 AM Matthew Wilcox <willy@infradead.org> wrote:
>
>
> As part of my rewrite of the readahead code, I think I spotted a hole
> in btrfs' handling of errors in the current readpages code.
>
> btrfs_readpages() calls extent_readpages() calls (a number of things)
> then finishes up by calling submit_one_bio().  If submit_one_bio()
> returns an error, I believe btrfs never unlocks the pages which were in
> that bio.

So, the pages are unlocked at end_bio_extent_readpage().

The bio created by extent_readpages() (more specifically at
__do_readpage()) has its ->bi_end_io set to end_bio_extent_readpage().
Then submit_one_bio() calls btrfs_submit_bio_hook() or
btree_submit_bio_hook(). When these functions return an error, they
set the bio's ->bi_status to an error and then call bio_endio(), which
results in end_bio_extent_readpage() being called, and that will
unlock the pages, call SetPageError(), and do all necessary error
handling.

thanks

>  Certainly the VFS does not; the filesystem is presumed to
> unlock those pages when IO finishes.  But AFAICT, returning an error
> there means btrfs will never start IO on those pages submit_one_bio()
> is a btrfs function.  It calls tree->ops->submit_bio_hook() so that's
> either btree_submit_bio_hook() or btrfs_submit_bio_hook(), which certainl=
y
> seem like they might be able to return errors.
>
> So do we need to do something to complete the bio with an error in
> order to unlock those pages?  Or have I failed to notice that already
> happening somewhere?
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
