Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33CD7A520D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 20:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjIRSbl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 18 Sep 2023 14:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjIRSbk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 14:31:40 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250FFF7;
        Mon, 18 Sep 2023 11:31:34 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59bdb3d03b1so48063817b3.3;
        Mon, 18 Sep 2023 11:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695061893; x=1695666693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8MR6DgzFV+KL70KKjvZZcEnHx73mhhuHmUBOw1+I0Y=;
        b=N1ez6LsFOJRwyWEqT9n7SyZAnhir//0DmN8bka9jgGgXIDjlNuRUQ39ABKyTUOWN0G
         +RKFrQJZlsSBip5fxke4AkTz31ZgUYjmukWgzKUFtkWQSK2wzoYrHc7xmKpc0Yv3xE23
         HnrbjT6fyAAcD/14YOrzpuDAKu/sB5Uj4hJfeRQy68i5UwX3vsTgJE8z36nBoVpMdXDS
         /DOMKtQKwAMUHOnBorqAUMnGyuIvDyX+uENBUzJvWq6zAd3clUAcvPV2bVuS4OYLlYdJ
         8jBdQ3SRnj26xBe6wueixet4nF51w9WN34Lh9ull8FSMowXurmcAR3YolWNE9jL25aig
         QM0A==
X-Gm-Message-State: AOJu0YzoLd5c5JBxR+L+vlO/MtvoOyhVbLANxjyfRuI0MNouFCiNJo2O
        Sr2ju4aeEV2r1WT/TxKHJW5heodKN/Febw==
X-Google-Smtp-Source: AGHT+IHWN3/xqIRpmofwM+aVYFkSLI3OpErAwa5T42uNJ8Ifruurw6Pjo24Rcf39tbICTM/piFS3FQ==
X-Received: by 2002:a0d:edc5:0:b0:59b:61c2:e8db with SMTP id w188-20020a0dedc5000000b0059b61c2e8dbmr9743942ywe.49.1695061892885;
        Mon, 18 Sep 2023 11:31:32 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id x8-20020a817c08000000b00589b653b7adsm2743274ywc.136.2023.09.18.11.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 11:31:32 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d7ecdb99b7aso4594635276.3;
        Mon, 18 Sep 2023 11:31:32 -0700 (PDT)
X-Received: by 2002:a25:aaaa:0:b0:d5c:1b9b:6f5a with SMTP id
 t39-20020a25aaaa000000b00d5c1b9b6f5amr8988277ybi.44.1695061892274; Mon, 18
 Sep 2023 11:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
 <20230918-rst-updates-v1-1-17686dc06859@wdc.com> <CAMuHMdWM3_cj4Nb96pZQfErx7n+0Cd7RUQZV+bpvr1Tz5T3sgw@mail.gmail.com>
 <e12a171e-d3b8-401e-b01a-9440f5c75293@wdc.com> <20230918162448.GI2747@suse.cz>
In-Reply-To: <20230918162448.GI2747@suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 20:31:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_rxSsyURvy_57JX2W1ias0_fuMTE6MpNs7qWaCqibkQ@mail.gmail.com>
Message-ID: <CAMuHMdV_rxSsyURvy_57JX2W1ias0_fuMTE6MpNs7qWaCqibkQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: fix 64bit division in btrfs_insert_striped_mirrored_raid_extents
To:     dsterba@suse.cz
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

On Mon, Sep 18, 2023 at 6:31 PM David Sterba <dsterba@suse.cz> wrote:
> On Mon, Sep 18, 2023 at 03:03:10PM +0000, Johannes Thumshirn wrote:
> > On 18.09.23 16:19, Geert Uytterhoeven wrote:
> > > Hi Johannes,
> > >
> > > On Mon, Sep 18, 2023 at 4:14 PM Johannes Thumshirn
> > > <johannes.thumshirn@wdc.com> wrote:
> > >> Fix modpost error due to 64bit division on 32bit systems in
> > >> btrfs_insert_striped_mirrored_raid_extents.
> > >>
> > >> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > >
> > > Thanks for your patch!
> > >
> > >> --- a/fs/btrfs/raid-stripe-tree.c
> > >> +++ b/fs/btrfs/raid-stripe-tree.c
> > >> @@ -148,10 +148,10 @@ static int btrfs_insert_striped_mirrored_raid_extents(
> > >>   {
> > >>          struct btrfs_io_context *bioc;
> > >>          struct btrfs_io_context *rbioc;
> > >> -       const int nstripes = list_count_nodes(&ordered->bioc_list);
> > >> -       const int index = btrfs_bg_flags_to_raid_index(map_type);
> > >> -       const int substripes = btrfs_raid_array[index].sub_stripes;
> > >> -       const int max_stripes = trans->fs_info->fs_devices->rw_devices / substripes;
> > >> +       const size_t nstripes = list_count_nodes(&ordered->bioc_list);
> > >> +       const enum btrfs_raid_types index = btrfs_bg_flags_to_raid_index(map_type);
> > >> +       const u8 substripes = btrfs_raid_array[index].sub_stripes;
> > >> +       const int max_stripes = div_u64(trans->fs_info->fs_devices->rw_devices, substripes);
> > >
> > > What if the quotient does not fit in a signed 32-bit value?
> >
> > Then you've bought a lot of HDDs ;-)
> >
> > Jokes aside, yes this is theoretically correct. Dave can you fix
> > max_stripes up to be u64 when applying?
>
> I think we can keep it int, or unsigned int if needed, we can't hit such
> huge values for rw_devices. The 'theoretically' would fit for a machine
> with infinite resources, otherwise the maximum number of devices I'd
> expect is a few thousand.

rw_devices and various other *_devices are u64.
Is there a good reason they are that big?
With the fs fuzzing threads in mind, is any validation done on their values?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
