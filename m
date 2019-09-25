Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B765BE5BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 21:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbfIYTeo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 15:34:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37804 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732875AbfIYTen (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 15:34:43 -0400
Received: by mail-io1-f67.google.com with SMTP id b19so1889692iob.4
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 12:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=goT5laY9vZXAntj/LoRm3JqY5XGC7OTQW3dP6Pik4/4=;
        b=dCq44SUbYmpASysNN8YZJCeRm8VC5caVFo1jLFF3zP6GhGaFlcXeSNeDx8NKADN0m0
         U1OWOU8N5g1AiIXCWNL19Jrhy4EajjHSRrcKK/cCgRFBxsr7ykgrpO5QTq1I+qpZgcxV
         48xTFieJfzPssAa58qMasGAFX+3P9Ia3UwFIgVjGGgZGXp7aUKQSjR/OYpLNCjamENJT
         a+buWdV15GMkpdBG46hHKiRxzA74cr17x6WHZ/pkRETZ9qmqKLenar/TAzuMo0lHP7F0
         gji21stHIW4CqyCR8WgDBUopII1xq+fdzOKjrG1RBLyJc17jwfzeH97v/ZsCl85SEGgL
         IKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=goT5laY9vZXAntj/LoRm3JqY5XGC7OTQW3dP6Pik4/4=;
        b=SQaOw4oam3bahVP12H5BGtf+/gT90g96ikRlYeCc90TnISn7cuhv4NxhW6YRZqa1wg
         br4fU0Ag+bAjatyPS74nZSGIOt5RcxHIg+j/W05r27mYy8lLReK8v2G0Hh22G5Jkzghp
         uz0Edhzou4wuX9ZHj1Oofo3p3d5xJbjLz3iZQOB4jIVCLf4WOBBytMHpiRSzUZ+0Vmid
         8AxrrYvTt5WHCG1kiNP2ptE9yhsgDtuf0V45tZ/GbHn8k3XGWOva9xWKSiHa+mkwAik+
         x1NyBojbh7/Pmev/WdhokDEm/e3IbT22TjE6tKrsQT6sR4nXG/vTjm89ipNpoZ2E8+P3
         +U6g==
X-Gm-Message-State: APjAAAVtBWdXnyaQKl5KgeaE0aiOqcq9bGfD9sMVLotexZorxqFJUYev
        BIuuNL0nEkVWamQeKZia2yrbuPufYnU=
X-Google-Smtp-Source: APXvYqxLPFHY6AQdGFlqUbn355bRx3KNUqpzKwT06AymH6sxSbgv+WnNrtvyCiEbN4GLqORZ+gh1ZQ==
X-Received: by 2002:a02:a617:: with SMTP id c23mr6625480jam.14.1569440082214;
        Wed, 25 Sep 2019 12:34:42 -0700 (PDT)
Received: from mail.matt.pallissard.net (149.174.239.35.bc.googleusercontent.com. [35.239.174.149])
        by smtp.gmail.com with ESMTPSA id z16sm288576iol.64.2019.09.25.12.34.41
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 12:34:41 -0700 (PDT)
Date:   Wed, 25 Sep 2019 12:34:35 -0700
From:   "Pallissard, Matthew" <matt@pallissard.net>
To:     linux-btrfs@vger.kernel.org
Subject: Re: errors found in extent allocation tree or chunk allocation after
 power failure
Message-ID: <20190925193434.ieyj4oo6vkxmjtnw@matt-laptop-p01>
References: <20190925144959.p4xyyhn2d2sajxjj@matt-laptop-p01>
 <CAJCQCtQwHRVs+XwnnUcktGcaRabZGG-UxS4o=g9y_MCiD4yG9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lb6cmn2cg5rlplvs"
Content-Disposition: inline
In-Reply-To: <CAJCQCtQwHRVs+XwnnUcktGcaRabZGG-UxS4o=g9y_MCiD4yG9Q@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--lb6cmn2cg5rlplvs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Chris,

Thank you for your reply.  Responses in-line.

On 2019-09-25T13:08:34, Chris Murphy wrote:
> On Wed, Sep 25, 2019 at 8:50 AM Pallissard, Matthew <matt@pallissard.net> wrote:
> >
> > Version:
> > Kernel: 5.2.2-arch1-1-ARCH #1 SMP PREEMPT Sun Jul 21 19:18:34 UTC 2019 x86_64 GNU/Linux
>
> You need to upgrade to arch kernel 5.2.14 or newer (they backported the fix first appearing in stable 5.2.15). Or you need to downgrade to 5.1 series.
> https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fdmanana@kernel.org/T/#u
>
> That's a nasty bug. I don't offhand see evidence that you've hit this bug. But I'm not certain. So first thing should be to use a different kernel.

Interesting, I'll go ahead with a kernel upgrade as that easy enough.

However, that looks like it's related to a stacktrace regarding a hung process.  Which is not the original problem I had.

Based on the output in my previous email, I've been working under the assumption that there is a problem on-disk.  Is that not correct?


> Next, anytime there is a crash or powerfailur with Btrfs raid56, you need to do a complete scrub of the volume. Obviously will take time but that's what needs to be done first.

I'm using raid 10, not 5 or 6.

> OK actually, before the scrub you need to confirm that each drive's SCT ERC time is *less* than the kernel's SCSI command timer. e.g.

I gather that I should probably do this before any scrub, be it raid 5, 6, or 10.  But, Is a scrub the operation I should attempt on this raid 10 array to repair the specific errors mentioned in my previous email?

Thanks again.

Matt Pallissard

--lb6cmn2cg5rlplvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTvIUMPApUGn6YFkXl1uof+t048SQUCXYvBRwAKCRB1uof+t048
Sb7FAQCF3/SYqNGTdDqiPghaNC3wN/Z75HOi8lfxL/2W32w6TQD/b+Ps/D6DNqqH
FXdDF2JFTII7LlPZvu3gQ+0+x76e/Q0=
=OAFs
-----END PGP SIGNATURE-----

--lb6cmn2cg5rlplvs--
