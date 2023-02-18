Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E14769BD23
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 22:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBRVqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Feb 2023 16:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBRVqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Feb 2023 16:46:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B353EF9E
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Feb 2023 13:46:05 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z10so5141112edc.6
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Feb 2023 13:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdnBY+ozgxsJNH9RV/Ql7s0yx10AJV/JGd/sRLCiRFI=;
        b=h8iO5giGrdSKQlTrYHM3IKQ89sZMqqNHh98l6MrmIoXQo7TokOKp+XB2MLi+LeE+DA
         nmC5dXLN9vJ0jZLEWIsvpQ1OnQt9eKX1jADtATK2blZ7OGDDFi9BEDnddKyPNfXEUJXH
         Y56wiJuBERqTjCRYMPktxfnwL+ZLWUtCgJrUpqeExuiNY1MiT3sHsbKxZxtVFz0ysM96
         O7IAPP45f3hN4QX4bUgo5VGzRjzjeBYDF1NMMvvAyCPAy4Cpb2LR9AY+GFe1NmoWnvup
         aK4FRO3ZmlTtI/EYgslyuOalWZmF2TD/FL78LcOdwocX2zV/uGTWfPY52EFAq23v9jPZ
         p/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdnBY+ozgxsJNH9RV/Ql7s0yx10AJV/JGd/sRLCiRFI=;
        b=QH/A+kEDFegsSi/VuDq8x1sSmjERtUfDwmiKg+xbQ/TStcw39l3U+z/JqaAiV+hC1e
         MTDC/RcEneFG2oGVfcbhs9XgZ2FFpa2/hb0uVKnnzfguLcxfWUd8H50RfEoMmtRc1Oc1
         4yQnWiZOIkVHL4PS7kToP5oT0Dqlwu5sFlXdKt27JDf3eL9l2iRIF5GOUxRzyk7meHt9
         2X/Q4GezfftNZiG2FJs0VroNpLThDWHwokDT9Lpmy2fCtvjEzKXTRNC8On5dYt0JUzFr
         IRXSYlRvU2/icu5WzZoIsH4ul96TjBElMC2BW7MH0G76tKXRQSf/CgNRNojBlc//HFnJ
         7sSA==
X-Gm-Message-State: AO0yUKWZO8fwY2Us221tjUVFWE+qWy3f8mAu5VKzziPosEpkkf1VpOsZ
        bAEjXzRTEM3NDWTprLVvs+beN6wHmcStNkKOPy8+2MWTwndg+a53
X-Google-Smtp-Source: AK7set/up+xVZTEQRLbnsmz2+QQkVUQf1418MwqRYtdSFkSS5FLJoKgvRvi1k3HlaW7upIXvcIJB8nYQ2tVVmEv0VHo=
X-Received: by 2002:a50:baa4:0:b0:4ae:e5b0:cc9c with SMTP id
 x33-20020a50baa4000000b004aee5b0cc9cmr455752ede.2.1676756763659; Sat, 18 Feb
 2023 13:46:03 -0800 (PST)
MIME-Version: 1.0
References: <87wn4fiec8.fsf@physik.rwth-aachen.de> <04ddea4e-4823-00dc-c32c-700d9f7e1fef@libero.it>
 <87a61bi4pj.fsf@physik.rwth-aachen.de> <CAFMvigcmGsqNv11LbZxnJ+TX1_RUm__Vay-S2xNhwKupxTXuQA@mail.gmail.com>
 <87o7pqhh7n.fsf@physik.rwth-aachen.de>
In-Reply-To: <87o7pqhh7n.fsf@physik.rwth-aachen.de>
From:   "me@jse.io" <me@jse.io>
Date:   Sat, 18 Feb 2023 17:46:17 -0400
Message-ID: <CAFMvigdQnQysU6zN4WWcEdTuSg-9Ob3iCBDSkGBH8J9trPeSsg@mail.gmail.com>
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

On Sat, Feb 18, 2023 at 4:11 PM Torsten Bronger
<bronger@physik.rwth-aachen.de> wrote:
>
> Hall=C3=B6chen!
>
> me@jse.io writes:
>
> > On Sat, Feb 18, 2023 at 7:45 AM Torsten Bronger
> > <bronger@physik.rwth-aachen.de> wrote:
> >>
> >> [...]
> >>
> >> I agree that converting to single is not the fastest way to
> >> replace a disk, but the safest AFAICS.  It is the boot partition
> >> in a simple home server without monitor or keyboard, which makes
> >> mounting as degraded difficult.  Besides, you can only mount in
> >> degraded mode once.  If anything goes wrong, I have to rebuild
> >> from scratch.
> >
> > I just want to make clear, this bug was fixed long ago. You would
> > need to update your bootloader conf to use degraded at boot time
> > in this case, but in theory, it should work identical to have a
> > raid1 degraded as converting it all back to single.
>
> What was fixed?  Can you now mount in in degraded mode read-write as
> often as you wish?
Yes, and has been for some time. Since kernel 4.14 iirc.
> Regards,
> Torsten.
> --
> Torsten Bronger
>
