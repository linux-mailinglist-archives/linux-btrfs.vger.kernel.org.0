Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220A173A4B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 17:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjFVPWY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 11:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjFVPWX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 11:22:23 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3FA19F
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:22:22 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b57b4e95a8so9838641fa.1
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687447341; x=1690039341;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0N5nJumx/VpfPwcm+X3F+lCs1OqaXV0i222KhN0GvVw=;
        b=ZCx44+EuUvLG4YylT1DQu0bfzgugmrPBLvzencJar9mdc1xVAueJCSRWIvjBvW6paw
         Ea0oiYoWXMX+eawNehmsCl2IL5YKIuBw0uTQiA9okux3naKKx21hsAH6DiibSpCDp4Yb
         p4cl5YVF1tMoMD29v0MBBoJF/Ua+tSIcQfnVnUZdeJQhFfYEDRvHKTOWONhmL65o2Imt
         9G4qbiGoBU97Tai7SiedAkgwAxC3amr/ylM8GAoIA7V+nXmEWEWPS6vFv6oHVaFb1O1k
         2ndgFKcyR6IxJw7QDqkMqL+EcIelnvYclgFgI1kyxt+IzUzTtwPRrm9DFn40ZtNjHN69
         E8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687447341; x=1690039341;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0N5nJumx/VpfPwcm+X3F+lCs1OqaXV0i222KhN0GvVw=;
        b=LU0ahx02i76n77xY+pr8VU4bWUh94Rf40s9qWH++HgGtnG/HH4d7aqc3nzbAkhisQ1
         b/xoBA49fbsrSWfVIId0TckngE1Ro8iNtq3IIBCR336evsLHKx6kzLxa/GKKviAZF7g0
         GEc2t50nyMo/C7DdU9kDbFlNiWWrBuGBOo4FSBKk+A3XkVnXj3TMXYerGbql6Q696Tg3
         7Lf8FM0NsORCxAE9ggR2ZXtLrSPk/4VrgsnY7j179Cu3kn0wyp+p+Q6c1mWhaOOCEhxu
         rJsFAfU9j/U6sSNFxnRJLVN3QzKYD36CIa1+wgx4y1xIhV0DHlluAlWzk5dHmjgp6Kg1
         J2mg==
X-Gm-Message-State: AC+VfDx3UNUYKz31AmuUZyXRoMbDAp9Os+F/vvh8xB/x0wBnTCRuuUXW
        QpazIPwnbMu3vBc5Aa34G9bKRapGU8A=
X-Google-Smtp-Source: ACHHUZ7x24iRnQlbSrwtpzzrgJIRCXiC0B+KOGn7WOZy8NjaFPiulIjVGoV4iIfPFHMoksXo83shPA==
X-Received: by 2002:a2e:b80f:0:b0:2b4:67bd:4367 with SMTP id u15-20020a2eb80f000000b002b467bd4367mr8026897ljo.5.1687447340508;
        Thu, 22 Jun 2023 08:22:20 -0700 (PDT)
Received: from [192.168.1.109] ([176.124.146.132])
        by smtp.gmail.com with ESMTPSA id g4-20020a2eb0c4000000b002b483914548sm1357527ljl.42.2023.06.22.08.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 08:22:20 -0700 (PDT)
Message-ID: <9fd09e52-e77e-415b-bd95-9c58dde263d0@gmail.com>
Date:   Thu, 22 Jun 2023 18:22:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: empty directory from previous subvolume in a snapshot is not
 sent|received
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <ea6099a3cff73c20da032afaaeb446c0b12ec1da.camel@scientia.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <ea6099a3cff73c20da032afaaeb446c0b12ec1da.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22.06.2023 16:34, Christoph Anton Mitterer wrote:
> Hey.
> 
> Not sure whether this is a bug or expected.
> 
> On my btrfs I have subvolumes like:
>    data/
>    2023-06-21/
> where e.g. data/ contains the root filesystem and 2023-06-21/ is a ro-
> snapshot thereof.
> 
> 
> When I created 2023-06-21/ from data/, the latter contained another
> (rw-)subvolume data/pictures/, which I've deleted (actually: moved out
> the files back to data/ and rmdir-ed the now empty subvol... or maybe I
> did btrfs subvolume delete - not sure anymore) again after creating the
> snapshot.
> 
> 
> Now 2023-06-21/ contains an empty (non-subvolume) 2023-06-21/pictures/,
> which is expected.
> 
> 
> Today I've send|received 2023-06-21/ to another btrfs (at that point,
> the original data/pictures/ subvolume was already gone), and diff -qr -
> -no-dereference-ed the two afterwards.
> 
> Outcome (apart from "differing" files/sockets/block/char special files)
> is that the target doesn't contain the empty pictures/ dir.
> 
> 
> Not a big problem for me,... but is this expected or some kind of
> strange bug?
> 
> 

I think it is expected. btrfs does not support either recursive 
snapshots or recursive send so "btrfs send" skips directory entry that 
points to subvolume root.
