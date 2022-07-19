Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA94557915F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 05:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiGSDfl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 23:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiGSDfj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 23:35:39 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F269733A32
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 20:35:37 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10bec750eedso29021715fac.8
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 20:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRb/jT0/MM9+niCGXr6tUFC5S1benAp6957ABloN7M8=;
        b=gCiT/QMLuZKeHdtTo8ZRtcFA1EkD+e9w6qZDEzHA/T71+ixSTvzDqoNTNIC8hSLuCL
         JHT5WG6rG4TCYA0etgOLyJPYeMu53m5T/JHWMg2HdfI7aWEy4VPR9xf1BvUkLkC8PJP1
         eYgA+erW8TgnM1dHAn5Mz++5NR/z5j4B1I21qmw45oBMyitFtp4AjsZBoV78+dFmgvG7
         8/WU11jKbKGSNM71UCekcM3nxRvVs+xF9GVPR0t1EDoP5Nl/VM7YQt6ZHh7hvYezyJeo
         nlINmtrchjSEgLf02luyLN69qMGK78dPTxV0FMOm/He/UbM7MMqgNN1t2ARHxEpfyRtA
         0WHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRb/jT0/MM9+niCGXr6tUFC5S1benAp6957ABloN7M8=;
        b=4u1nRRikVYfXIrIPTvK5A4LchCYkC6qVAvzLQgPE1KStoBMgUp9yp7KqfasnZbb5Hy
         /jfBsyqQFJuNQRaMafJDuyqCkSE/6OGVuewDBO1nme3Bj8HHIJ6SftTOZBXON9Ei58Wa
         r2KETjyGwXs0uTULSlK+i7NHoLhJiJYlSk0HVMG8hZkX0oDeRRVfF0XQDj0JklMmh++u
         xeBQxhcscuySH49ezfm2ayQ16cXavSFN64p0tBMpsbloMnsiT1JBBFZk2svvNrxefuWU
         Db7au7RJASX7N8+gWBxbTTcGIJkxqyx4OOd7BEWN23fQwIlmG7dSdkhhHzVPm4ifU+Aj
         p05g==
X-Gm-Message-State: AJIora+iIsmensr6d9+ukxcdKVZGgNGA0wcvFsAJKFkuWki9o1xdqj8n
        EAypChu21TpkWLF68cyQUA0cURzJ6XdUHqVM+GHdtxqjqREQvg==
X-Google-Smtp-Source: AGRyM1viFZES0nYLXZJNUOum/t3xcPEcQYY8LIs4Ullyb9qZQ9/S+4Ffj5ESsZ/mxqa1wYro6ccAj+h01fcXsQmYm5E=
X-Received: by 2002:a05:6808:16a7:b0:2f9:39c4:c597 with SMTP id
 bb39-20020a05680816a700b002f939c4c597mr15411916oib.101.1658201737239; Mon, 18
 Jul 2022 20:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <000001d899d0$57fb6490$07f22db0$@perdrix.co.uk>
 <CAJCQCtTAx=82boq175vtAu1Z_S9D1tcNSErir1wTK8MbtMfsvw@mail.gmail.com> <009001d89b02$b7f2eb60$27d8c220$@perdrix.co.uk>
In-Reply-To: <009001d89b02$b7f2eb60$27d8c220$@perdrix.co.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 18 Jul 2022 23:35:21 -0400
Message-ID: <CAJCQCtTV4gSBXCmqVG-6dqEC151V=MWRatrTX+hthur_PLT4eQ@mail.gmail.com>
Subject: Re: Odd output from scrub status
To:     "David C. Partridge" <david.partridge@perdrix.co.uk>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 8:01 PM David C. Partridge
<david.partridge@perdrix.co.uk> wrote:
>
> btrfs-progs 5.4.1-2

Well, if you can find a newer version that'd help determine if it's a
current bug or one long since fixed. Current version is 5.18.1.



-- 
Chris Murphy
