Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB044D3061
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiCINrk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiCINrX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:47:23 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E25317E367
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:46:21 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a28so1017782uaf.7
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 05:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jankanis-nl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxpjUVZgJJ24filW052jmnbLhZ6h39AzcOz2V7WhFTI=;
        b=BSxVF5Td/xOaM7SP350B3gIYSXvWtGoSb+Mwxjbk0QPPgzCL4vYSrPGM2n4/Ql4yxu
         dvwnnoTpcfDCbEMH+L+4YDpvISYbAKTFN2ewg7P1F86w2/K0X5/I8WSOjzbJlIWr+FIP
         MjEfHJ8UcqUQ8HkPk/pV+g/6jk57HBRqPa72YgKkTol366KhDRKQenV5dwmHKpsX8on+
         AmVA1qe6pjyyUc13aSVEitSkdDhveKhmfGiv2xXFeSGEWXYAvzn3Y+XNgADg7WlUzCMh
         QNOG8kV7F4qJKgfiRfzdZ/67P6By8VSACUv4i9RNkM5ByaPqpmre0IcclO6Mwh6j+TY5
         0/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxpjUVZgJJ24filW052jmnbLhZ6h39AzcOz2V7WhFTI=;
        b=Opb4T3Xn9qWQQpbGvTrBu4yFuuXuWb5mrzWjFxeUQedUvm9bda36Q5kaLKLGmoeRST
         yBFaHEEW4wkhsqC3U/vGk064PlWx/ZF8AAp3Hvj5coNLQ7U+ZtnPOZuHEtGQzXkOH0TO
         ufldDMPx1RQwy+YwLAPSPDpxar0wFnMuRCqqY0w1Ca6EnpoFEAWvFfVmgHxHk9vxQyBA
         hWqnwUTn660EzvTBRji6oCE5blfo4HQcqnEO7LF7ApJNrWzGVEX0BilluKEk0iuCZimK
         hCCq3BJndh2c125T3pbelJbgHUxZdJvr1rSLQ6Z3oaEOjxD5kGaFrV9ovo70CsixhrlC
         QTGQ==
X-Gm-Message-State: AOAM533FhS4/fedLwsB/He8xRbWvwPRq6klVWdqxThWbx/K8TOWlpnS9
        R3p8aT4o4cEny63FH1hvvRBc9Esw/o+i9Xx4
X-Google-Smtp-Source: ABdhPJw0EmfAwmRfrtEaWcibSTUNEBh/ElHOberv8kljlAXbvO1oRlnQExii5yuD6GjwD+i79ZuB7g==
X-Received: by 2002:ab0:7314:0:b0:346:3f39:802b with SMTP id v20-20020ab07314000000b003463f39802bmr8523115uao.11.1646833580215;
        Wed, 09 Mar 2022 05:46:20 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id u70-20020ab045cc000000b0034a4433fe7fsm242045uau.33.2022.03.09.05.46.17
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 05:46:18 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id b190so2364045vsc.4
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 05:46:17 -0800 (PST)
X-Received: by 2002:a05:6102:c4f:b0:322:8ed8:8fd9 with SMTP id
 y15-20020a0561020c4f00b003228ed88fd9mr992785vss.87.1646833576506; Wed, 09 Mar
 2022 05:46:16 -0800 (PST)
MIME-Version: 1.0
References: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
 <c3b39f81-f5e4-ff06-b1c0-98501d77d79a@opensource.wdc.com>
In-Reply-To: <c3b39f81-f5e4-ff06-b1c0-98501d77d79a@opensource.wdc.com>
From:   Jan Kanis <jan.code@jankanis.nl>
Date:   Wed, 9 Mar 2022 14:46:04 +0100
X-Gmail-Original-Message-ID: <CAAzDdex7fKo8av_KrDx8zNdVUJ_GQgvDpzuekNjXw5kx_Gu9ew@mail.gmail.com>
Message-ID: <CAAzDdex7fKo8av_KrDx8zNdVUJ_GQgvDpzuekNjXw5kx_Gu9ew@mail.gmail.com>
Subject: Re: Is this error fixable or do I need to rebuild the drive?
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 5 Mar 2022 at 11:42, Jan Kanis <jan.code@jankanis.nl> wrote:
>
> Correction on the statistics: 40 GB is 10 million blocks. Chance of no
> spurious checksum matches is then (1-2**-32)**1e67 = 0.99767. The risk
> starts to become significant when writing a few terabyte.

The scrub looks like it worked. I had some 10 million errors, all
correctable, so it looks like my assumptions for the calculation were
correct. Of course I don't know if there were any spurious checksum
matches.


On Mon, 7 Mar 2022 at 01:42, Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
> Hu... SMR disks do not support partitions... And last time I checked,
> cryptsetup did not support LUKS formating of SMR drives (dm-crypt does
> support SMR, that is not the issue). Care to better explain your setup ?

Sure. By SMR drive I meant a regular hard disk (in fact a pair of
Seagate Barracudas) that uses SMR internally but presents a standard
SATA interface.
