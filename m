Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0365678D6
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 22:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiGEUyw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 16:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGEUyv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 16:54:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35F714005
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 13:54:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lg18so3912703ejb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 13:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqrP7cSeWJSCM47qVnOAZjaOlSUXcSa+wYw62k+r73Q=;
        b=5Jgt4x7C5D/26yxLYIvgsvRfkEbTEhJN9qQ3nKu0/SA37E1p6kjMJd4E7TxZIb1NeM
         iBP6vHkhiNzriu/FJ9jkp1b7C+V43EqCT29fMN8jyQar8XiLBov7JZ63aiY/lMwWX/Rq
         xEQTOcDkqS2g4idr1aWP/pj9ZfRf9hTtKka5Q/9bK2rFP3lZ1DRSxwBdhpnQbMlxtlqF
         8NUGD4AYE/rVycit0NtFZxxZSArfdZ5uUghL6G0DBDOcJXgE2KeeGGgPyI/d8WpRhrlk
         onamTMEHJ/eQeyrCKuKcS/6Tca/8C72akXNfc9Ta/bF5y/v6g9yeLwCvjvwcU4yg30Z1
         D+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqrP7cSeWJSCM47qVnOAZjaOlSUXcSa+wYw62k+r73Q=;
        b=2eMhpLHwqAsjToBlrIsiaWbiN/THRdo+fOLe6QQDTXMS5OfTu75tYW8Ou7PjdI7iTQ
         1c3RV4mpzTtXADv+mVMLJx3S4J/erQRO/e7qnpjhT+ByFslUemGFO3kXv9cKqVTORunB
         Xqk2MkvNXTwmg5GfCBEAHh0BgOs4i9waRuoepD/ANfDQEePX+JmHqCxn5uIJ/iAmbX4m
         S1y8mcFIjk6C7U1CzBsh3uWvlUGyiolzYH8qCeQM7e6sZtzRXVPO4CYCONXNLJGsUeVk
         rtSolW4vs4IYkvW2GzmTUq320e2j0wH7156nYZY9aYusQjFXsRv8GttxQk/wrKZRYHeT
         1Izg==
X-Gm-Message-State: AJIora/dX4AnLlfOfsMSgqd/8SWRkzxZM/XIUlIm3VATbMjcgCWa3ewl
        M6fYewvibAegzmKlHpQPrtSeGb1rUfVK1wo+DdNvFA==
X-Google-Smtp-Source: AGRyM1s7wNlpoS4NUqGX3ZxfWY4q4YZBGwdLxmanmez5FA3FaAYZKkMZS6RppZzu1Jrji5hyialsK3eqAtb6NyZOMSw=
X-Received: by 2002:a17:906:7944:b0:6da:b834:2f3e with SMTP id
 l4-20020a170906794400b006dab8342f3emr35515044ejo.353.1657054488323; Tue, 05
 Jul 2022 13:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <71ee4e58-678d-a8d1-9376-45eaead69ad5@samara.com.es>
In-Reply-To: <71ee4e58-678d-a8d1-9376-45eaead69ad5@samara.com.es>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 5 Jul 2022 16:54:32 -0400
Message-ID: <CAJCQCtTjYJVnOwdyyrjW8Uwzv2NoEzLNn4zXR1a_WXMVEDhmMg@mail.gmail.com>
Subject: Re: Help with btrfs error
To:     Fernando Peral <fernando@samara.com.es>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 5, 2022 at 4:30 AM Fernando Peral <fernando@samara.com.es> wrote:
>
> I have a Opensuse leap 15.3 installed in a ssd disk, on some system
> updates it crashed. I mouted the disk in other computer to test it and
> the fs has some errors. I have tried scrub and check and I don't know
> what to do next, this is the info
>
>
> andromeda:~ # uname -a
> Linux andromeda 5.3.18-150300.59.76-default #1 SMP Thu Jun 16 04:23:47
> UTC 2022 (2cc2ade) x86_64 x86_64 x86_64 GNU/Linux
>
> andromeda:~ # btrfs --version
> btrfs-progs v4.19.1

I'm not really sure what's going on, but there have been improvements
to the write time tree checker since kernel 5.3. It could still be
true that a memory related bit flip escaped detection and caused this
problem. But it could also be an early indication of drive failure.

I suggest updating to a more recent btrfs-progs and running 'btrfs
check --readonly' and post the output to help confirm the problem.



-- 
Chris Murphy
