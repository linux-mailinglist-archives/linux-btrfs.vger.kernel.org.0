Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0D7155157
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 04:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgBGDtw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 22:49:52 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39127 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgBGDtw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 22:49:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so856664oty.6
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 19:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bIqDO4R2l2tokxU43EMDpmVHGK8procE9Q0eSpSoHdA=;
        b=RidBpSCcYroZ//qf37h2oLxaSw52YNHa86aWBs1zIzRmT60cXM3b/RwuUYFA5yVFvl
         z0vAPp8WOlJ7VF3hOFTo/XdTIfRNRzJRcJjRElEDkFVHmzl9dvvrUn+7+IY+LzBExFxs
         Y3xdu0ROCox7o77Kv4DnnwObFf/UvXx53VnAAuh75Xpoc/KcLsyJV8LaJr+G5tzFdiXr
         +vHYASAMVBF555fkdDlsfCy4PA7uUIBI68hfmSczksZ2ELo71tSnN08v/XPZExfO1vqp
         kkI1wYHilwoQjlVySRIIyJAgPXw+rNymZJwMyFrSZNKXgnoabuRkeJpEe4PbLh5qIxBb
         YPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bIqDO4R2l2tokxU43EMDpmVHGK8procE9Q0eSpSoHdA=;
        b=kXSB+tmpbwXpSS6WmjHNVOIh2udsm5hYqAawRLsNT5ObDtAQD28pyMHhtupjQEfwpx
         g1C8qCTxhhpNraNktOqC8l1HvioKrls/YwZx1XCQvTas2+oeQHaRHrWbrWmelz5HG4hH
         kOtl/Hda+BA9kV+9vkSJQKtLO2IoczY6owV/kZD9F4VnG449xt0rBcT9miNyS9wgiYgf
         UbsjUER2+kiriyou5aCJRXNRNyXm+BIcz433yRfKf1vrzQxqkmrTkRoYeN6Gnnrno+n1
         CuTzUpamo8Rt/FnnpC+/eNkocSJhBRCmeyVjwrUPjYbBBL9Bi3hZ/lFkjEvIfNUp7XZw
         Jcfg==
X-Gm-Message-State: APjAAAUzbuYkHEIFjsap2i+cCCvOQmC5yYVsWM5p4a9BSztDfHyKTF+C
        L1dFz0SU8H3jo0/cTSeiZezUCbHqjxLfJs0dP/4=
X-Google-Smtp-Source: APXvYqzxENvfcEHiXkfDV0KCnwYAYEZt4XUPQY4TVoWhrmVOA/BfLVUAzFdnrGv3Edr9Z5BGo7jK5VE3N/cyD+l10Jg=
X-Received: by 2002:a9d:6b84:: with SMTP id b4mr1161519otq.190.1581047389912;
 Thu, 06 Feb 2020 19:49:49 -0800 (PST)
MIME-Version: 1.0
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
 <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com> <CAEOGEKHf9F0VM=au-42MwD63_V8RwtqiskV0LsGpq-c=J_qyPg@mail.gmail.com>
 <f2ad6b4f-b011-8954-77e1-5162c84f7c1f@gmx.com> <CAEOGEKHEeENOdmxgxCZ+76yc2zjaJLdsbQD9ywLTC-OcgMBpBA@mail.gmail.com>
 <b92465bc-bc92-aa86-ad54-900fce10d514@gmx.com>
In-Reply-To: <b92465bc-bc92-aa86-ad54-900fce10d514@gmx.com>
From:   Chiung-Ming Huang <photon3108@gmail.com>
Date:   Fri, 7 Feb 2020 11:49:37 +0800
Message-ID: <CAEOGEKGsMgT5EAdU74GG=0WbzJx81oAXM0p_0rFhZ4vFmbM3Zg@mail.gmail.com>
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=886=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8812:35=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Here is the diff, should be pretty safe:
> diff --git a/check/main.c b/check/main.c
> index 7db65150048b..bcde157c415d 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -10373,7 +10373,8 @@ static int cmd_check(const struct cmd_struct
> *cmd, int argc, char **argv)
>                         ctx.tp =3D TASK_ROOT_ITEMS;
>                         task_start(ctx.info, &ctx.start_time,
> &ctx.item_count);
>                 }
> -               ret =3D repair_root_items(info);
> +               if (repair)
> +                       ret =3D repair_root_items(info);
>                 task_stop(ctx.info);
>                 if (ret < 0) {
>                         err =3D !!ret;
>

I applied this patch and executed `btrfs check /dev/bcache4`. It showed the=
se.
Opening filesystem to check...
Checking filesystem on /dev/bcache4
UUID: 0b79cf54-c424-40ed-adca-bd66b38ad57a
[1/7] checking root items
[2/7] checking extents
parent transid verify failed on 7153357357056 wanted 1382980 found 1452673
parent transid verify failed on 7153357357056 wanted 1382980 found 1452673
parent transid verify failed on 7153357357056 wanted 1382980 found 1452673
Ignoring transid failure
leaf parent key incorrect 7153357357056
bad block 7153357357056
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
root 5 root dir 256 not found
root 257 root dir 256 not found
root 258 root dir 256 not found
root 277 root dir 256 not found
root 278 root dir 256 not found
root 279 root dir 256 not found
root 280 root dir 256 not found
root 283 root dir 256 not found
root 286 root dir 256 not found
root 289 root dir 256 not found
root 292 root dir 256 not found
root 295 root dir 256 not found
root 298 root dir 256 not found
root 304 root dir 256 not found
root 307 root dir 256 not found
root 310 root dir 256 not found
root 313 root dir 256 not found
root 316 root dir 256 not found
root 319 root dir 256 not found
root 322 root dir 256 not found
root 325 root dir 256 not found
root 360 root dir 256 not found
root 367 root dir 256 not found
root 370 root dir 256 not found
root 373 root dir 256 not found
root 376 root dir 256 not found
root 380 root dir 256 not found
root 383 root dir 256 not found
root 386 root dir 256 not found
root 389 root dir 256 not found
root 392 root dir 256 not found
root 399 root dir 256 not found
root 402 root dir 256 not found
root 405 root dir 256 not found
root 408 root dir 256 not found
root 411 root dir 256 not found
root 414 root dir 256 not found
root 417 root dir 256 not found
root 420 root dir 256 not found
root 423 root dir 256 not found
root 426 root dir 256 not found
root 429 root dir 256 not found
root 439 root dir 256 not found
root 442 root dir 256 not found
root 445 root dir 256 not found
root 448 root dir 256 not found
root 451 root dir 256 not found
root 513 root dir 256 not found
root 4613 root dir 256 not found
root 4616 root dir 256 not found
root 4619 root dir 256 not found
root 4622 root dir 256 not found
root 4625 root dir 256 not found
root 4628 root dir 256 not found
root 4631 root dir 256 not found
root 4640 root dir 256 not found
root 4643 root dir 256 not found
root 4646 root dir 256 not found
root 4649 root dir 256 not found
root 4652 root dir 256 not found
root 4673 root dir 256 not found
root 18871 root dir 256 not found
root 19354 root dir 256 not found
root 19355 root dir 256 not found
root 19356 root dir 256 not found
root 19375 root dir 256 not found
root 19416 root dir 256 not found
root 19419 root dir 256 not found
root 19422 root dir 256 not found
root 19425 root dir 256 not found
root 19428 root dir 256 not found
root 19432 root dir 256 not found
root 19435 root dir 256 not found
root 19438 root dir 256 not found
root 19441 root dir 256 not found
root 19450 root dir 256 not found
root 19453 root dir 256 not found
root 19456 root dir 256 not found
root 19459 root dir 256 not found
root 19462 root dir 256 not found
root 19465 root dir 256 not found
root 19468 root dir 256 not found
root 19472 root dir 256 not found
root 19473 root dir 256 not found
root 19613 root dir 256 not found
root 19784 root dir 256 not found
root 19812 root dir 256 not found
root 20572 root dir 256 not found
root 20768 root dir 256 not found
root 20771 root dir 256 not found
root 20834 root dir 256 not found
root 20837 root dir 256 not found
root 21438 root dir 256 not found
root 21447 root dir 256 not found
root 21469 root dir 256 not found
root 21470 root dir 256 not found
root 23144 root dir 256 not found
root 23146 root dir 256 not found
root 23147 root dir 256 not found
root 23440 root dir 256 not found
root 23452 root dir 256 not found
root 23460 root dir 256 not found
root 23471 root dir 256 not found
root 23520 root dir 256 not found
root 23521 root dir 256 not found
root 23833 root dir 256 not found
root 23834 root dir 256 not found
root 23854 root dir 256 not found
root 23855 root dir 256 not found
ERROR: errors found in fs roots
found 1902526464 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 6275072
total fs tree bytes: 1032192
total extent tree bytes: 409600
btree space waste bytes: 974245
file data blocks allocated: 1628962816
 referenced 1628962816

Regards,
Chiung-Ming Huang
