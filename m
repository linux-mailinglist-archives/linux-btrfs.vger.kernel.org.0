Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A5B69DEF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 12:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjBULgf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 06:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjBULgX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 06:36:23 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF11C274A8
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 03:35:48 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id eg37so12070777edb.12
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 03:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZQKAYM7sILeD43yYsSSFxDJ4U01oPzfIdRf8xPZsPo=;
        b=gKshF0drBErWwMMdPRF7HgUONwKCed5P4/LTWsqPI7vD0ZpBPBTOBZuiZQg/M4Vlky
         aYbKXEDig2Y0UkwJU3gPiXLXmvkZ1oKLQwWdkohqCFwiHk2Bn6wH62OV16K7gI0GzHml
         FnBt9CWbIZv3UpyKS1mu6x35rd/aSQuL3PZsA84HXSkoXuz4Lt9/3CbHai3bHA+oky2C
         Wi7C9CeI2mMJaep0i8cju67OokKxmvPRY5xxLhRQgsMfW6MK6MtgQaMGfJ8XRYMViMj5
         hU49lFXsWr0Q1q7k6S0mESOnFfSk/xzP1t2KjDkT94FLVTjEYrylX3aMzTRqX6A718r5
         tWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZQKAYM7sILeD43yYsSSFxDJ4U01oPzfIdRf8xPZsPo=;
        b=Q1f9X0n1HjDiaNnvZtGrrtcduN4BuKwF/p0xwVM6B3EwuSyRO5H/vDiQnqKIYBIsQb
         9h2ADFRPKdjTO/nnvxdRYfCLtyKnFGs/aGw5KkNYlsK1fCvoSzfAt6blnw5zTzo4JJew
         HbhHLptlcg8r+oGKhw9mvhbQWbGLL+/VvphvyiEWB8NzkAQrBa5LYeuMvlJplK5l/DDf
         QLUYo5b/MhHeSb1DzVG3Yul3u9FzpVhVnAAZJ9hdbj88u3XknMI7ZTWssMeHy3gtk6C7
         e3isuqmRI/qH3lKj7xV+41pb8p327rPawFr2BdTigvXlkE3nlncSfi5oQlo4ewJwFgxO
         Yc5Q==
X-Gm-Message-State: AO0yUKX8dKYpFzsKW+SKBhBrk8y5dCmESdS94RwdzjNKFLQ37LWdH/YF
        lMzO+ZIubZMIv32nUQd7lpeh0OlldcSy881cGTxBOM+fTUfm78emFj8=
X-Google-Smtp-Source: AK7set+CF9YYyrQZaaZWq+INqyB1MBTVzKuNNtmv1A0YIea86XApo/vyhym1fRSxgfRVZg7ZEUjTMltGIVzm61HirBw=
X-Received: by 2002:a17:906:119b:b0:8d1:57cf:ef3c with SMTP id
 n27-20020a170906119b00b008d157cfef3cmr2977862eja.2.1676979340435; Tue, 21 Feb
 2023 03:35:40 -0800 (PST)
MIME-Version: 1.0
References: <87wn4fiec8.fsf@physik.rwth-aachen.de> <04ddea4e-4823-00dc-c32c-700d9f7e1fef@libero.it>
 <87a61bi4pj.fsf@physik.rwth-aachen.de> <8531c30e-885b-1d8d-314b-5167ed0874ac@libero.it>
 <87k00dmq83.fsf@physik.rwth-aachen.de> <c27655bc-8582-07e2-236d-e3afc6860d13@dirtcellar.net>
 <0282b6d0-b131-3b3a-084d-8c8de2f522a5@tnonline.net> <87r0ujbi6h.fsf@physik.rwth-aachen.de>
In-Reply-To: <87r0ujbi6h.fsf@physik.rwth-aachen.de>
From:   "me@jse.io" <me@jse.io>
Date:   Tue, 21 Feb 2023 07:35:03 -0400
Message-ID: <CAFMvigfxFfMwpBUUBbixzksNX38L2U-Pct0+g-ZZsGm5vJj32A@mail.gmail.com>
Subject: Re: Why is converting from RAID1 to single in Btrfs an I/O-intensive operation?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 3:21 AM Torsten Bronger
<bronger@physik.rwth-aachen.de> wrote:
>
> Hall=C3=B6chen!
>
> Forza writes:
>
> > [...]
> >
> > I believe this would violate the "CoW" nature of Btrfs. In other
> > words, it would introduce a change in-place, which is not possible
> > with current current way of working.
> >
> > There probably are ways to make it safe and atomic, but maybe not
> > a high priority from the current devs?
>
> My naive assumption was: There is the bulk data, and there is
> metadata that also contains the profile of the data.  If the profile
> is changed, only the metadata has to be re-written atomically (in
> particular, the CoW way).
>
> But apparently, the profile is part of the bulk data chunk itself.
> This may well be necessary, but I was surprised by that.
If you want to go back to single on a 2 device RAID1, and avoid the
wear, especially if you plan to return to RAID1 at a later date, why
not just use it degraded? A degraded RAID1 chunk is basically just
single anyway. You can convert the metadata to dup to reduce write amp
without making the fs itself less resilient. New chunks will become
single while degraded anyway. You can convert those back later as
well.

When you do want to return using the old disk, use btrfs replace
instead. It will simply copy the existing data rather than balance it
to replicate it.
>
> Regards,
> Torsten.
>
> --
> Torsten Bronger
>
