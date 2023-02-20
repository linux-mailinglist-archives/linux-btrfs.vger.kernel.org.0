Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FD469D57D
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 22:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjBTVCe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 16:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjBTVCc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 16:02:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFDEBDF2
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 13:02:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x10so8545887edd.13
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 13:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yq0GbJhWH2XoIlOBzlQE0R2LW2CkRve3Ilke3wYFGeQ=;
        b=Li68PqxzhjhOwhldPjcHROyWLqQAm3hq3lbrw7b0xf+QbCwLi5WsIz6XuXUOTcxKXm
         VfRR66ok62a1DTRs2oMqWLuiT34AxKM4aM9RHcF/QYSWV0eJ33PRPDsmHhe+xKdq3H/F
         beKAxjmDsNmfN5C3J3Eg31CBGQ8Q1bjF1w8nE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yq0GbJhWH2XoIlOBzlQE0R2LW2CkRve3Ilke3wYFGeQ=;
        b=lkOAWfEZxc2UzzRyBVIPjHIHJgOvbSidGYyTtQtgEe9nNTgAVReh2fE4fCs2wbmodV
         7gEuVALTofl2XmM3Do1GYOuOrXZPVjV9P14tXgtzls7mDx368DET4c8l7W1kSzsIF6E6
         6BvaPMxMY5YsHPQ/AvGY4R9Vx7tDn2hXirLTRgGKawa9MorpipUWx3BTQWHxRPKCZzFP
         hKQdzoPANJO3b78mtqEMEwOjwMzZPHDhV6bekMgh9+Mn/uIcumLB4SlbNTujCxaJf0pp
         qEkHS0oG3JxksJDuP7diWFh8ZwAC+QBYkexJMpLzUkPcUT9EVf2ucz8lkCzfvDNFHFnB
         yPYw==
X-Gm-Message-State: AO0yUKWeNs8ySbaMizh6Agyabxp+cUW+xZz9q7Ga2MZxVl5x1NSVTtzF
        uU3g6iwq1ZBeOyl7+MaXPKI9zDZzYOyNSXZK0Ds=
X-Google-Smtp-Source: AK7set/DZ+SaNt1Z1k35a16KZL09NSCadnPgM0KanOlUbwfFAi5wnsXIoE0ne2wXhjj+v6OqdCsvWQ==
X-Received: by 2002:aa7:c551:0:b0:4ac:b69a:2f0b with SMTP id s17-20020aa7c551000000b004acb69a2f0bmr3235059edr.33.1676926949323;
        Mon, 20 Feb 2023 13:02:29 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id b2-20020a50b402000000b004aef4f32edesm687022edh.88.2023.02.20.13.02.28
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 13:02:28 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id g1so9111545edz.7
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 13:02:28 -0800 (PST)
X-Received: by 2002:a17:906:bce7:b0:8b1:28f6:8ab3 with SMTP id
 op7-20020a170906bce700b008b128f68ab3mr4917257ejb.15.1676926946147; Mon, 20
 Feb 2023 13:02:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676908729.git.dsterba@suse.com>
In-Reply-To: <cover.1676908729.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Feb 2023 13:02:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh6-qpZ=yzseD_CQn8Gc+nGDLrufFxSFvVO2qK6+8fGUw@mail.gmail.com>
Message-ID: <CAHk-=wh6-qpZ=yzseD_CQn8Gc+nGDLrufFxSFvVO2qK6+8fGUw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.3
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 20, 2023 at 11:26 AM David Sterba <dsterba@suse.com> wrote:
>
> Other:
>
> - locally enable -Wmaybe-uninitialized after fixing all warnings

I've pulled this, but I strongly suspect this change will get reverted.

I bet neither you nor linux-next is testing even _remotely_ a big
chunk of the different compiler versions that are out there, and the
reason flags like '-Wmaybe-uninitialized' get undone is because some
random compiler version on some random config and target archiecture
gives completely nonsensical warnings for odd reasons.

But hey, maybe the btrfs code is special.

              Linus
