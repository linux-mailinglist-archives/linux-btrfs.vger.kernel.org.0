Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9008D716D40
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 21:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjE3TOL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 15:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjE3TOK (ORCPT
        <rfc822;Linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 15:14:10 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE04116
        for <Linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 12:14:08 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b01d912a76so29433175ad.2
        for <Linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685474048; x=1688066048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BAEkHquIZ/S88Wj/extrjGXyG2DqDmr5RKKSE1H9KE8=;
        b=qXiEclxI3rnrxiHk3JDtE30dzRh+V+2dI5vVddCQhE3DdMT8t10cQJHxGwqK6cZZSG
         QPly4dyFC5Tk3PUrOaUZejuTFsVV0hpJNLuhmLzjhjczzUPWee+9+flfX1F2vrxqrMbW
         ncZ05UbpT3LkyxTgWYeXZLhtLw1ooplKNszYyxypG6EE2PXcE1NNQPI4DayTW8ozSiDR
         KwZbcbOkbEhydBVb6ScQaCprG5ScATvav4VtVOiz0c2wWZloa0g/A52kv4ELpYJjQtdB
         7XYNyqZgMe5MEQN2/ypCT/HJivrXY3RCtYLkCXMLKrZaHKZ7Wq0xEEPHBAalCpueKcHa
         X+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685474048; x=1688066048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAEkHquIZ/S88Wj/extrjGXyG2DqDmr5RKKSE1H9KE8=;
        b=ly4wn6t9v1weE8zCZWlO/lu0zvVY4UUhwOp/3UcAdlVwyP0AinH5f7DLZsYjLkmiEs
         DGPEZmXknwNRqD6I0T32gWmOcQ1SOVzRN2xU0RjY/5XK5WeL3qEDFNrknbjvTxZJzWg4
         W2U+uF25RjBaI7nMFRn+men6GQPelTvKxwGdiQkhT1uiCMK5lwW62UHO7gAHghoqFbZa
         31TaHPMwaf6QKe0LgXMQwf7cn5wcVhx6/j9tJedZtVAn4/JmfXNIpn0K1onNeMVi62BV
         8XMKIw+hYLSe0vyDaE+b+ImGDaXKFCe069t4U8QSDpy5FqL8On9mZ7zEDYPQtpP94Ybg
         1w1Q==
X-Gm-Message-State: AC+VfDyCIgClCA4nuf11aliyVwfHVH+RZ+55ReMrzbxzcMecEc0OeZzy
        sKZnA8D8/ItBm2R8Ce6nKT2ug+sXXSA=
X-Google-Smtp-Source: ACHHUZ6WDTjp0VW0SgYYvPS6WrRG/b3zaiQnp8jB4kEb8kBUyC8pqlgW8Vayx9+IFt7nxK64F6U8Ag==
X-Received: by 2002:a17:902:db05:b0:1ae:89a:9e with SMTP id m5-20020a170902db0500b001ae089a009emr3218284plx.61.1685474047844;
        Tue, 30 May 2023 12:14:07 -0700 (PDT)
Received: from flip-desktop (97-113-131-190.tukw.qwest.net. [97.113.131.190])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d88800b001a183ade911sm10668299plz.56.2023.05.30.12.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 12:14:07 -0700 (PDT)
Date:   Tue, 30 May 2023 12:14:05 -0700
From:   Phillip Duncan <turtlekernelsanders@gmail.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, Linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tests: fix formatting in btrfs-tests
Message-ID: <ZHZK/fXtzwuW8Zrf@flip-desktop>
References: <ZHVLLpTHRvifOIHP@flip-desktop>
 <20230530185411.GD32581@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530185411.GD32581@twin.jikos.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 08:54:11PM +0200, David Sterba wrote:
> On Mon, May 29, 2023 at 06:02:38PM -0700, Phillip Duncan wrote:
> > checkpatch.pl had a couple of formatting suggestions:
> > - #38: Don't use multiple blank lines
> > - #42: Missing a blank line after declarations
> > - #282: Alignment should match open parenthesis
> > 
> > Fixed these format suggestions, checkpatch.pl is a little cleaner now.
> 
> Please don't send such patches, or at least not to btrfs. A more
> elaborate answer:
> 
> https://btrfs.readthedocs.io/en/latest/dev/Developer-s-FAQ.html#how-not-to-start

Thank you for taking the time to respond, I appreciate the direction for
where to start.
