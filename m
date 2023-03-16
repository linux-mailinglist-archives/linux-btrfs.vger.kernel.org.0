Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10F66BC2FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 01:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCPAst convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 15 Mar 2023 20:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPAsq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 20:48:46 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B90AA70C
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 17:48:44 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id eg48so1302904edb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 17:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678927722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfI+OxTHqv+XOpMIPiBKJ3nta14R4kgaMJ7BqnKa/ko=;
        b=AL8esg4UryihMvAOquqJ9+/K6OlDUJOycR/j6O9WytNsjea3v6CSniaU8aX8+cWRu8
         1fuuFTDddS9ENhawNgjpaaP2Ol7BsQ2OjplnRTf7KA/9YRfuqBWApNFPs1brBDbxaham
         3difxhZ4pNmRSKs4GdUz4lp2UM1OLpVFH1ueikuy1ke0bO3UKJCRXsSz/TX1qAZbguMd
         ZsCVhqIhSjWtLyyfH6MLYM6gITK7GAIEoVCxeY0puRypNAWW7kS/LUjxi4dIXwIE5rDV
         jgwivagGQxYx3MTHvJwFHBXm563B9kFtNeONMNFpGUD7GXV6kSFi/6kbzgqBJluTevHd
         Cr5w==
X-Gm-Message-State: AO0yUKVVpapXFrQQnO0y//B+LtxOXxJ1lLVYKWLgftjvSZXzhoLrTo2m
        dAgsAnfKWVtL48maN3bG6MZtigRSMJWg4Q==
X-Google-Smtp-Source: AK7set8tq5MXoVpzTN9v5Vs9rt1ergYjxVhgK6lRB4FqEYj8EZa3FLODupdexURWVVVZSUf9LsqTdg==
X-Received: by 2002:a17:906:bc46:b0:8b1:3d4:6a9d with SMTP id s6-20020a170906bc4600b008b103d46a9dmr8843243ejv.19.1678927722157;
        Wed, 15 Mar 2023 17:48:42 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id g10-20020a50d0ca000000b004fc1bb4285fsm3091942edf.93.2023.03.15.17.48.41
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 17:48:41 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id cy23so1323555edb.12
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 17:48:41 -0700 (PDT)
X-Received: by 2002:a50:a68f:0:b0:4fb:c8e3:1adb with SMTP id
 e15-20020a50a68f000000b004fbc8e31adbmr2039147edc.3.1678927721503; Wed, 15 Mar
 2023 17:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <ae81e48b0e954bae1c3451c0da1a24ae7146606c.1676684984.git.boris@bur.io>
 <CAL3q7H7wVW_E70+qvb4S7w06RvjW_2dXxzTLLQO45_vC0SLTkA@mail.gmail.com> <Y/UOnKe6Ap8+lGx0@zen>
In-Reply-To: <Y/UOnKe6Ap8+lGx0@zen>
From:   Neal Gompa <ngompa@fedoraproject.org>
Date:   Wed, 15 Mar 2023 20:48:04 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_03VLmcS_XzDytKWbkuDPy9DPesGvoPKa74BqzuRnm0A@mail.gmail.com>
Message-ID: <CAEg-Je_03VLmcS_XzDytKWbkuDPy9DPesGvoPKa74BqzuRnm0A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix dio continue after short write due to source fault
To:     Boris Burkov <boris@bur.io>
Cc:     Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Davide Cavalca <dcavalca@fedoraproject.org>,
        Michel Alexandre Salim <salimma@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 1:52 PM Boris Burkov <boris@bur.io> wrote:
>
> On Mon, Feb 20, 2023 at 02:01:39PM +0000, Filipe Manana wrote:
> > On Sat, Feb 18, 2023 at 2:25 AM Boris Burkov <boris@bur.io> wrote:
> > >
> > > Downstream bug report:
> > > https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> >
> > You place this in a Link: tag at the bottom.
> > Also the previous discussion is useful to be there too:
> >
> > Link: https://lore.kernel.org/linux-btrfs/aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com/
>
> Thank you for the tip, I'll include those in V2.
>

What happened here? I haven't seen a V2 posted (unless I missed something?).



--
Neal Gompa (FAS: ngompa)
