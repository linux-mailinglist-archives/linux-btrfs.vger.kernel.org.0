Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB576FF00C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 12:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjEKKm3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 06:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjEKKm1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 06:42:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6196D2D62
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 03:42:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9659e9bbff5so1533023166b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683801745; x=1686393745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vciWS9BXl4ugHnabNKV1aw9Ob8De22wintpz7ruHhw=;
        b=DNLQK+YXTdldLgOCyuoMLr7Ejz+q279Wkv/a6rZOWRpKlVklyeDAScqWkjUevxK3n+
         IIFDup01MujjG0XLoc/eI0E6+3PAl7goXVHggOdnRCTiAO2Lk5M6scXlaumqa+2d9CIC
         nrGOI7Bj2pqPALA7xtemwcefI4ldABzxVaHIy67ALaqO7rjrACs3mHUOq02R/DR8Hbqg
         Pleq/qEDn9YV9nqGi6BD/I2+gTP7fWmgcLIXTTWXNjlDOD7n/As158PJzaea7UDzPZ4+
         EGri8vaofxzK2xpYA2U2gzgUn5W/8aPrf6O8VpQ8q67yQxwdGAS1aBZaEweOumny16Fc
         S/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683801745; x=1686393745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vciWS9BXl4ugHnabNKV1aw9Ob8De22wintpz7ruHhw=;
        b=Bu+8OgqpFtU6HGocRiW1v/65m5yrY4pJiV5ZwKGfVzwdEQiLyLq0GxxSqrPZDAKv9x
         xUy4An6UW8tnTRCI65qWZKMhugiurgyf+jg8HpSDAVtqSxZN4FpHANYjICmcTat6ST5n
         dWbKU7xgfaY9I3bXvPb79RSwNfM7DvZz/HYAir4ORwovO6/+7qvTCr7K0FQ7r8N7ujYq
         tH7g9qC4eN4crIs5iz+NKbPvx3aRSV3x7q4YirdPME3gYO4Lg+DwWzEoO8CAPiHolDwv
         gCbkmVvJGVSEj/mPRYymRxnYl7/SL3OlyO/22YPgwJAqubJcNqVCzl192hO1ghdybSVP
         CArA==
X-Gm-Message-State: AC+VfDxLLWKacpz4DKMy57/FFFUBMJuufzfiW2sSrR2Qi+p1XlTHTnEz
        FlJq9uVAdqiT5YyqBSGs3+NuPdk1d7jS1moiFhk=
X-Google-Smtp-Source: ACHHUZ4M3XnBKYA8kPbPp9l8azwIzDM7KU3FLtj4wYYB1FJ2jBkIytb8GZURDXearc5pnUZDzgAYB8piiIiOqpUVbUw=
X-Received: by 2002:a17:907:1c14:b0:95e:d74d:c4e6 with SMTP id
 nc20-20020a1709071c1400b0095ed74dc4e6mr25018854ejc.25.1683801744614; Thu, 11
 May 2023 03:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <837c4ca9-7694-4633-50b8-57547e120444@nerdbynature.de>
 <8a3f47c0-5b0f-a6c8-d1c4-714e3251b9eb@nerdbynature.de> <61025b77-2057-5a90-032b-f36ffa85deb4@gmx.com>
 <1a1a6ccf-25f9-d362-d890-8a609ff743f2@nerdbynature.de> <7d4287c6-e854-e79a-874a-0f76ea4285a4@nerdbynature.de>
 <ecd355db-e252-4993-97c4-1987963507cd@app.fastmail.com> <dcc34c41-f7c8-e8b2-0a78-c134a257a8db@nerdbynature.de>
 <f73c20ae-f52a-436f-9fa4-6e3839d4b9a6@app.fastmail.com> <c3e3578b-cb09-9643-caca-e52172c18578@nerdbynature.de>
In-Reply-To: <c3e3578b-cb09-9643-caca-e52172c18578@nerdbynature.de>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 11 May 2023 06:41:48 -0400
Message-ID: <CAEg-Je_Cjiy8ajwDrHrLfxxnx0xv91Jq4tca+Lc_gTm4h7q5rw@mail.gmail.com>
Subject: Re: btrfs-transaction stalls
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 10, 2023 at 2:25=E2=80=AFAM Christian Kujau <lists@nerdbynature=
.de> wrote:
>
> On Tue, 9 May 2023, Chris Murphy wrote:
> > That is confusing.
>
> It is! :-)
>
> > If you do not specify any discard mount option, 6.2 kernels default to
> > discard=3Dasync.
>
> So, ever since I installed this system (Lenovo T470, with an NVME disk)
> the "discard" option was added (by me or the install routine) to the moun=
t
> options of the root disk. And btrfs(5) on this Fedoa 38 system (the man
> page says "6.2.2" and "Mar 26, 2023") states:
>
>    discard, discard=3Dsync, discard=3Dasync, nodiscard
>       (default: off, async support since: 5.6)
>
> So, the I'd assume that no discard option means...no discard. But you are
> saying that "discard=3Dasync" is now default, when the option is not
> specified at all?
>
> The man page further states:
>
>   In the synchronous mode (sync or without option value), lack of
>   asynchronous queued TRIM on the backing device TRIM can severely degrad=
e
>   performance
>
> ...but I did not know that until a few days ago. So, I thought: "OK, I ha=
d
> 'discard' specified for ages here, and that defaults to 'discard=3Dsync',=
 so
> better change that to 'discard=3Dasync' now." And ever since I did that
> (i.e. since last week) these weird stalls are now gone.
>
> > If you are manually specifying only discard, you should get async
> > discards, not sync discards. I think sync discards is a bug. Surely wit=
h
> > 6.2 kernels and newer it should be async, but arguably it should be
> > backported to all stable kernels still accepting changes. If not
> > specified, async should be implied.
>
> So, I'm not using vanilla Linux, I'm using 6.2.14-300.fc38.x86_64 from th=
e
> Fedora distribution, but I doubt that they patched the man pages, as they
> sure state something else here: "discard is off by default, and discard
> without options defaults to sync". Or I'm misreading the man page, that's
> entirely possible too :-)
>

So what's probably going on is that "discard" triggers sync discards,
whereas having nothing or specifying "discard=3Dasync" will do async
discards.

We're not patching this in Fedora, so this is certainly an upstream Linux b=
ug.




--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
