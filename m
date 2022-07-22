Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CBB57E266
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jul 2022 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiGVNge (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jul 2022 09:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVNgd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jul 2022 09:36:33 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7E713FA7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jul 2022 06:36:32 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l14so3487793qtv.4
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jul 2022 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FhAqNzMjHItCBXxJNn0CnK8km/tkB3iKgy6yFIjV8PM=;
        b=MscrtghFTqC5Gt5QBloA4g+xw9aGO2WSTRt/JsG/Mm4bDuvmtW3VOZlTgnHLLayNcB
         fCzN8v58ZtV9HMj6QiKHP0ohQKMwHoCuW0SxUnfBlpdFjZiv0yzVe4NcZ+Gq9StvwkjC
         CzCc+8mcwr6mD0rMonFG2MsO+EgOfPf/v9vy8J3whtXlRfQdsfzxfKC3KhzTSeb6Lv5i
         ETahs3Pz2GiFHAYlv/5Ye2V64JQN8TbkG0S9brhtconnUYe8hduVOdWp9LpzHmcU3ml9
         87ZKb6V+el2uwIFOMOz4z0fr/+L8W53shP0occcXT8moFk3ujUAStzlcruCeTb4Toze1
         vFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FhAqNzMjHItCBXxJNn0CnK8km/tkB3iKgy6yFIjV8PM=;
        b=h2F9p1vpsLKu+KT24csqwuM3lHksQcrRnfSam4UyRQu6OsvSEJ1pcf69GZfqf4bVCn
         szuAsM1lhWsk5FklPgRVzjDrzguGETreci+yKi/ypcNAx8fuwF3+4KQYEcatAzw0dCcn
         BHultnuqtzEY4ef+h8IhE+n61+WYwFBUSX/l0k0QbaLCwPx0AZdw8SE5Od+gScw8OJGd
         eREUxWrCoF0aJ9EoEbfBIBRUIPgWH67eFsZJWeHuSBfcgBD/B/NjxmE2nA9xk+5cF+4p
         W+KGewaB8E0I1euTLAd6EXBGtd+2tWtZE6nq/N8gPK8pfeRgE/a5LlXLxjiMroO+HocF
         Jrtg==
X-Gm-Message-State: AJIora+KkrjONydMIzX/qI8Zi3hc1VoKNbk7rUt5/EhhVJifUllGNgA+
        gQKvXB5fkNmBuJvUCvBsb4vTUNUnwh9SmA==
X-Google-Smtp-Source: AGRyM1t3UyS5fWuzxHasz9RrimiSG0KZJzIV6VNVvqY8g1x02NdnqHtQKhtBNuis+cC0aDDGGinmfA==
X-Received: by 2002:ac8:5746:0:b0:31e:d0d6:30bc with SMTP id 6-20020ac85746000000b0031ed0d630bcmr32342qtx.493.1658496991393;
        Fri, 22 Jul 2022 06:36:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id cf5-20020a05622a400500b0031ee01443b4sm2779598qtb.74.2022.07.22.06.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:36:30 -0700 (PDT)
Date:   Fri, 22 Jul 2022 09:36:29 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/6]  btrfs: Annotate wait events with lockdep
Message-ID: <Ytqn3ROQAGJxkTL3@localhost.localdomain>
References: <20220720233818.3107724-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720233818.3107724-1-iangelak@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 20, 2022 at 04:38:13PM -0700, Ioannis Angelakopoulos wrote:
> Hello,
> 
> With this patch series we annotate wait events in btrfs with lockdep to
> catch deadlocks involving these wait events.
> 
> Recently the btrfs developers fixed a non trivial deadlock involving
> wait events
> https://lore.kernel.org/linux-btrfs/20220614131413.GJ20633@twin.jikos.cz/
> 
> Currently lockdep is unable to catch these deadlocks since it does not
> support wait events by default.
> 
> With our lockdep annotations we train lockdep to track these wait events
> and catch more potential deadlocks.
> 
> Specifically, we annotate the below wait events in fs/btrfs/transaction.c
> and in fs/btrfs/ordered-data.c:
> 
>   1) The num_writers wait event
>   2) The num_extwriters wait event
>   3) The transaction states wait events
>   4) The pending_ordered wait event
>   5) The ordered extents wait event
>

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef 
