Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD854DB791
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 18:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352472AbiCPRt4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 13:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiCPRtz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 13:49:55 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2F6419A2
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 10:48:41 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id w17-20020a056830111100b005b22c584b93so1892241otq.11
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YuDz+JGU6tqw3rLhnolyvSrc6vY0Ur7/qyobZz5LCWI=;
        b=DOvxVWZUTM16dtU6z4feKvu08fhGIrhQfJoXsmtUoXQ+odAvft5j8PLq4I/uG4eOCS
         jHzfRyYuhE/g3OEOT8b/F7fN2e9zvZyPHG78zCdL97m+qDgfkn5HWQ4QE4weh8uSjsQe
         5dFpf1Et/F1uHXLzOMoZcvIQWR2ZxBNQnWxKkZychj1JCHIzPkIcmaX+6FMIHSHqTCZb
         LoMYPk8eqLRYZQ0MQFXLpxOl51xFDKlyCafYDRF+Me55OAJZEJ5NzPBbticqazvnSDmO
         S1DOQSHj3M0qDfTOGXUsEu4221mQ6Z+amq3FQvrIyecqd55ZScH/1sSMZBnn5NcCOLUR
         iong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuDz+JGU6tqw3rLhnolyvSrc6vY0Ur7/qyobZz5LCWI=;
        b=Ufg5rjDh7WsELg6wAFdkJswx1L2oAwR9HkDkNgXv7LB/F0LYcDzNzmWGNOMOSKTYVz
         lwcaRbMHJfpvXmcIWioLId56kly1H611hA0Ii3eSWriF1lE5tGbJqd4/XjKCnWvPMiw+
         Spm8Vp/vTnJH3RrXBzN4lGpvsVvsxyWiEofcGaELAmGNBVLOVrcxZl4jgJQeNNWKv77L
         6nEaRxWgqt2EadLJ1p8lFu4KPlofidAB1F9DOzYPX/JXNu3Xf751+t7Iu9ckL+PA9uwr
         lD41Uzwy6w/iro1YPQP67rBGRIrdExcoJ5BqxlPXLpffJCwhnTgvnwNAUcmhFO3+DP9j
         JSDg==
X-Gm-Message-State: AOAM530fx82ZrfUnEjfVzH1j5x4FI9ncTypfsl9Ri0HGp/VMLDmEQrZt
        qq6vyL9OmFGbz6FQUJAQCAczkr0gQn/S6iA1jdY=
X-Google-Smtp-Source: ABdhPJyskOWGe9OG7IyY9CDA6ifMCPeBPNUxeF9hA5Myb1iOs8TwMYnnk/I6Tj8MlfCA+/tskZPZ0y4ymxLO3tE2cfI=
X-Received: by 2002:a05:6830:11d6:b0:5b2:5a37:3cc7 with SMTP id
 v22-20020a05683011d600b005b25a373cc7mr378983otq.381.1647452920380; Wed, 16
 Mar 2022 10:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com> <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com> <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com> <87a6dscn20.fsf@vps.thesusis.net>
 <Yi/I54pemZzSrNGg@hungrycats.org> <87fsnjnjxr.fsf@vps.thesusis.net>
 <YjD/7zhERFjcY5ZP@hungrycats.org> <CAODFU0pwch49XB4oGX0GKvuRyrp+JEYBbrHvHcXTnWapPBQ8Aw@mail.gmail.com>
 <YjIYNjq8b7Ar/+Gt@hungrycats.org>
In-Reply-To: <YjIYNjq8b7Ar/+Gt@hungrycats.org>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Wed, 16 Mar 2022 18:48:04 +0100
Message-ID: <CAODFU0obuBSFtwgfxr9PdsGSfpADogw1bEhu7DGsExRXfau1Dg@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Phillip Susi <phill@thesusis.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 16, 2022 at 6:02 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
> On Tue, Mar 15, 2022 at 11:20:09PM +0100, Jan Ziak wrote:
> > - Linear nodatacow search: Does the search happen only with uncached
> > metadata, or also with metadata cached in RAM?
>
> All metadata is cached in RAM prior to searching.  I think I missed
> where you were going with this question.

The idea behind the question was whether the on-disk format of
metadata differs from the in-memory format of metadata; whether
metadata is being transformed when loading/saving it from/to the
storage device.
