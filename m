Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C254C123
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 07:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiFOFaD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 01:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFOFaA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 01:30:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4931A49937;
        Tue, 14 Jun 2022 22:29:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u12so20965843eja.8;
        Tue, 14 Jun 2022 22:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JIWkiD2gp+DIgZxu8gKOEwEpgQ5/8fbIKpBeO6X4A6Y=;
        b=hwECM+53CVSf51IQ6pQMNyVuwW269uKlYHDfaAtqb/U8PafUKk+ORP/TmMgQsgYmoF
         0PUSzwNQuXGCiSlf27SiPK6C08J6W85qbr6VfOBOc8bZ8inlYzp0faqG8DXQ/WUTfcdi
         1pRq8aglD/nu4d6+kAzx/oYYjHOdBP++YBYv1ua0BdLRvj93XgbZxX5HVECeBSb4MdBv
         ubegmtRNBVhfT3icGdh+OkmQEd/9epG6UQejAsD590cQrpXaNG+zHDXaPcJizstK0cec
         TbFwZP0dEAHXnXS+yv1t60CD3anvCsakpJImS4WCYl9179sN7cC2M4eBAqE6u0l9xqXn
         swYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIWkiD2gp+DIgZxu8gKOEwEpgQ5/8fbIKpBeO6X4A6Y=;
        b=flCeLDfcMDiooZ3pgjgvzEIABgIX9C2vYi65YfYtYmCF7nmywVrSRDWdjo1Qs25Lig
         nZ1Dsh5P1vzC9mPGrj/uW+LoOoobrvPRGUo6K74OcG1tx7W1Z9QMR/8ApTWM+/H0YX1q
         nroL9LOyUIIBJ3XOnpaaTxZ2355LullXZodc8Owqr2NdSdkUb9iSoZu5rjccR36TobV6
         L85eKsS+Gc9vGl4nMw8OpZ/YwprNF/1aq+wZzcYKU34e7cqwRYoRO9nMc3vJxkP8+hvh
         ysaJmlEoNVNf7eBz2PJJOya7CSd8BPlt7xbsPjZd2llCxCkNNg20mvelAiwQtruYudBD
         9rGg==
X-Gm-Message-State: AJIora9RW8Kndak8mL+MEbE2AWByo5WDqo+TmKINGM8tbKqBZIveGZz1
        iFk7MUZf8W6yI//ZXZfEEYo=
X-Google-Smtp-Source: AGRyM1vOxWpwOvHY531EZDcFsmLeInua4DAR00pDq3a/iwIic7gxOq6uSLiFrvNwTyn2QtaDZAL71A==
X-Received: by 2002:a17:907:9605:b0:6f5:c66:7c13 with SMTP id gb5-20020a170907960500b006f50c667c13mr7101498ejc.66.1655270997850;
        Tue, 14 Jun 2022 22:29:57 -0700 (PDT)
Received: from opensuse.localnet (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id i2-20020a170906444200b006fed8dfcf78sm5832838ejp.225.2022.06.14.22.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 22:29:56 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Sterba <dsterba@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, dsterba@suse.cz,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>
Subject: Re: [PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Wed, 15 Jun 2022 07:29:55 +0200
Message-ID: <3619537.MHq7AAxBmi@opensuse>
In-Reply-To: <YqjAVq+1PIpVIr0p@iweiny-desk3>
References: <20220611135203.27992-1-fmdefrancesco@gmail.com> <8952566.CDJkKcVGEf@opensuse> <YqjAVq+1PIpVIr0p@iweiny-desk3>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On marted=C3=AC 14 giugno 2022 19:07:34 CEST Ira Weiny wrote:
> On Tue, Jun 14, 2022 at 06:28:48PM +0200, Fabio M. De Francesco wrote:
> > On marted=C3=AC 14 giugno 2022 16:25:21 CEST David Sterba wrote:
> > > On Tue, Jun 14, 2022 at 01:22:50AM +0200, Fabio M. De Francesco=20
wrote:
> > > > On luned=C3=AC 13 giugno 2022 20:39:13 CEST David Sterba wrote:
> > > > > On Sat, Jun 11, 2022 at 03:52:03PM +0200, Fabio M. De Francesco=20
> > >=20
>=20
> [snip]
>=20
> > > > A better solution is changing the prototype of __kunmap_local(); I
> > > > suppose that Andrew won't object, but who knows?
> > > >=20
> > > > (+Cc Andrew Morton).
> > > >=20
> > > > I was waiting for your comments. At now I've done about 15=20
conversions=20
> > > > across the kernel but it's the first time I had to pass a pointer=20
to=20
> > const=20
> > > > void to kunmap_local(). Therefore, I was not sure if changing the=20
API=20
> > were=20
> > > > better suited (however I have already discussed this with Ira).
> > >=20
> > > IMHO it should be fixed in the API.
> > >=20
> > I agree with you in full.
> >=20
> > At the same time when you sent this email I submitted a patch to change=
=20
> > kunmap_local() and kunmap_atomic().
> >=20
> > After Andrew takes them I'll send v2 of this patch to zstd.c without=20
those=20
> > unnecessary casts.
>=20
> David,
>=20
> Would you be willing to take this through your tree as a pre-patch to the=
=20
kmap
> changes in btrfs?
>=20
> That would be easier for Fabio and probably you and Andrew in the long=20
run.
>=20
> Ira

David,

Please drop the first version of the changes[1] to the API and instead take=
=20
my second version.[2] I've only reworked the commit message (and subject,=20
but this was involuntary) to make explicit that the fundamental reason=20
behind these changes are semantic correctness.

Thanks,

=46abio

[1] https://lore.kernel.org/lkml/20220614142531.16478-1-fmdefrancesco@gmail=
=2Ecom/

[2] https://lore.kernel.org/lkml/20220615051256.31466-1-fmdefrancesco@gmail=
=2Ecom/



