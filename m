Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B017B9E55
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Oct 2023 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjJEODq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Oct 2023 10:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjJEODU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Oct 2023 10:03:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8082D59E5
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 22:48:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so875786a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Oct 2023 22:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696484938; x=1697089738; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=MYfiLuYwDBOCedc9q8/Xo4M5ib4aKIm9EukXNk9FaNClvdg7W8kDOQwb0Oj8yKkLBh
         bhuL4piG0IYLbgAyKJF+Om2+yiu3D6ZJOtkmI6AzY305gc75Puq61UnAoUaWd4E0d4wi
         Vvh+Jd7CGe1QxzqXmzVmAD0+WPVMs4eP8oi+gC+AxTvznNrGDmnBPFBtxbee4o6xWemz
         97ryxVCJDBi8tTizwSzb6Pro3GEWUciPpiTvJ5zwkLhbRTwmEd8Q+xTZfljR/EWXGyOj
         FHRCtAugM9x45iUECGhtAlr18dnWfRPIaOmX9nyESk+Dxss9XSnlcK7HoVPM9yf5DjSa
         7u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696484938; x=1697089738;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=e8wWoyrSmOVKkKAdkgH6tkGujGQitTDN3NqIsZ5JzZhKwKLX3fikC7ZFFK10gu9wwY
         ZvFZfS3FgRb1GpHkQPlLUi501wHpHvckv3I3y1dGqBFOeJTQILzln6UUc0459AW04W0h
         WJuDpdEn/Pxr0T43AITdktSpJ/aYHYvtMOMQhyrpqolYX8GkWQWGeNGTiBkR/dXhLFHb
         e3TAVw8z8QxWL2iCTFoOloI+S+jdjeEWMlXy33803X88QrApwLY4R8jrWq+21+BcT12C
         uIwL7CmOfqxwmhPlX2ehiOjtnQmlHuO5IO/pbLmsQ+ezAeyGI2/8Z6o6y742RmMbtab3
         xWYA==
X-Gm-Message-State: AOJu0Yx7pps96PPKmwCWdEPlneEiVUtDI9a6ZmcN9LkzMMbgER4UYBnV
        MB4A6ofpcPVXXmKq+02fbtCLQIt+DZo4RdTzf4BQuf5bA9c=
X-Google-Smtp-Source: AGHT+IE1ovbrfw7QXlMKBlSimDskXMUW5hbr025vXML3QV5pFjNLblytgUilJ4lKP5J+hGCZnreodCzyUtYQuS7E7p4=
X-Received: by 2002:aa7:db45:0:b0:533:520:a5a8 with SMTP id
 n5-20020aa7db45000000b005330520a5a8mr3798027edt.29.1696484937599; Wed, 04 Oct
 2023 22:48:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:2e12:0:b0:22f:305d:661b with HTTP; Wed, 4 Oct 2023
 22:48:57 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <coulibalynina09@gmail.com>
Date:   Thu, 5 Oct 2023 05:48:57 +0000
Message-ID: <CABeZed48QdeV72Uq2hyDpFJhxG0psfBzDg=a9ddazGSi1m3tLg@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_50,DEAR_NOBODY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5031]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [coulibalynina09[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [coulibalynina09[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ninacoulibaly03[at]hotmail.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:533 listed in]
        [list.dnswl.org]
        *  2.3 DEAR_NOBODY RAW: Message contains Dear but with no name
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear,

I am interested to invest with you in your country with total trust
and i hope you will give me total support, sincerity and commitment.
Please get back to me as soon as possible so that i can give you my
proposed details of funding and others.

Best Regards.

Mrs Nina Coulibaly
