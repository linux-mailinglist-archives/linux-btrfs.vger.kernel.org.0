Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232F1539AB9
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 03:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348970AbiFAB0R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 21:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiFAB0Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 21:26:16 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFC88CB21
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 18:26:14 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n145so260338iod.3
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 18:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHY65FXsHwsARljA/4Av19NvRBK251S2ng3jGnWGhZI=;
        b=vul4lfPBYUyNYd1yOIBV7xn/oCxl1xFS/moxVjnuaBXDxgnt6Q90Sp6R8QdzkZNhoU
         JR/EHqHUqVWd160jDRaV6jalpcRfIrkrLvlL09absP7Vziui5hLY44g0AwSR59iRhVxV
         ZrO+SQsGEBbYbVU0MMhNI4pdK6a7RhuoGFmWpBX2A3mE7m3EkiYidBCiUL46F1MPlVd1
         Z0hKdQ1/wSQdeQzQxH7lpaJlC8LQjdJF67gPG6YEVdCGcTjULudg1axFubXDNR0jldSy
         1dOW8rOFOhbNgKDXJgpkcedRxdJS2ewsGJOdgwEnJIAMPWwnLP1w0Qo1bgdCdsp78KkB
         9x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHY65FXsHwsARljA/4Av19NvRBK251S2ng3jGnWGhZI=;
        b=TmtuMxDHufsuF51yw9FqyIJYv7P9jRHUEeakgtW6sWGeRBNaAVPfhyg5P/KirlHr9n
         AFF63v8v2R+ZOPTtNzFz15fg3MfloG74VLAEej2arg+woo5jdVuXF9u2zBkhKZK7A3Mr
         mbzn8mNY4qYTAVEHsckdLGwtECU8LN6AZqyaarq0OV82NQ0qS+v81r8QXs2lww+LB8Fr
         /vkomoe95kcid2Y7ZGkSWB5KlYPmuZvYd6IqSrOMuC8vG6mBcS6/zMEHGIt/q1aTiMCD
         CjiQ23Swa4/5+DSBZC1QbzAJEbbDJ0eauEqMEbc+EWWhBRnCep0l4UNAOArwqH7Tb21J
         GqrA==
X-Gm-Message-State: AOAM533+b4qdBFSK4lmRKDHHUFrCW8WGJW0saB6GDEHacklJFzCtuG9Z
        gSpMDsoXtKJuGYD15l1iCge2hm+jUmUb/OSEvoyASjZrkMc=
X-Google-Smtp-Source: ABdhPJxHonXzzHIDsakn0QCKta2z4vbxPDKvy1kPvarVEuGi8jHiGsEBUO5HYLr56AnhskgFfTc3LCg1ue3i7+c1iwQ=
X-Received: by 2002:a05:6638:379c:b0:32e:d7a6:b715 with SMTP id
 w28-20020a056638379c00b0032ed7a6b715mr22681431jal.102.1654046774247; Tue, 31
 May 2022 18:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220529200415.GI24951@merlins.org> <CAEzrpqdpvnbzaH1gxWnvWLMWEKtOAdYsH25mBWhkF-urf7Zw3g@mail.gmail.com>
 <20220530003701.GJ24951@merlins.org> <CAEzrpqcPirk3AOi1vy+N_V3VY49mvUCiwYL4A_0XoT_jxjgOrg@mail.gmail.com>
 <20220530191834.GK24951@merlins.org> <CAEzrpqdRV8nYFshj85Cahj4VMQ+F0n6WOQ6Y8g7=Kq7X_1xMgw@mail.gmail.com>
 <20220531011224.GA1745079@merlins.org> <CAEzrpqco_RyUBK=dngrv54u8WE2uhSGrJaB9aRY5nUmKNzN32Q@mail.gmail.com>
 <20220531224951.GC22722@merlins.org> <CAEzrpqcui3A42ogkas9pQfMqX0qE+MApPuiUw12uwpqhNq2RHg@mail.gmail.com>
 <20220601002552.GD22722@merlins.org>
In-Reply-To: <20220601002552.GD22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 31 May 2022 21:26:03 -0400
Message-ID: <CAEzrpqfkrD4aYA3vMToi+vfYeoyj=h4JAx+xnGQj836FP+pbjg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 31, 2022 at 8:25 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, May 31, 2022 at 08:14:27PM -0400, Josef Bacik wrote:
> > Wtf, we're clearly writing the chunk root properly because I have to
> > re-open it to recover the tree root, and that's where it fails, but
> > then the chunk restore can't open the root, despite it being correctly
> > read in the tree recover.  I've pushed new code, try tree-recover and
> > then recover-chunks again and capture the output please.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5

Ah ok, I wasn't actually updating the pointer, fixed that, lets try
the same sequence again.  Thanks,

Josef
