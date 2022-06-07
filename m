Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E53540BF1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 20:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352024AbiFGSdL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 14:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353110AbiFGSbn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 14:31:43 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5753E17D3A2
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 10:56:51 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h72so9758836iof.11
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glPwWKY/QhIBi45k5arAQIR0dVpSXyJ0rKFzfVSbPOE=;
        b=utf8P7EqalgbgG71pxVgTLyV3oUgAhjOzlC95fBLlFSv3CDsNXO9ygJmbDPA2glUZk
         pJBjKVdg9bOv9TDq0/e6uUpryZ9EGfuQq1knLpNW3p//uFz4uPqkQDIdY/M1hVPIghul
         1/pajpESErrflya2rZbfMEe+tTnVYjxDnYl+wQLg+BJijChbroBUPOStI1i16FNhO+q2
         +5aOe3uey89W3UgXy6ULLJC+H6ocdxG+2/Qmhlg+XhSkNHCEhySu6/fHkod758QStI2/
         qOZ88fxwkIrUN1u6Oq2jrA3yKah2eIr8IcQFOxvE985nGsPtE0grkxTVd/HqzIor1vj+
         MtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glPwWKY/QhIBi45k5arAQIR0dVpSXyJ0rKFzfVSbPOE=;
        b=LZ2Y1I/ThZnEHsw2TbwLn3/JnIMk5RPMBRhPexBtTOobGZT2Fh5nDkAUd3NmRIWNvV
         jjI+WTTciw+O+mbarzJ0lEI41oxv0ECIczVDkteDKlvPJqY5564xIHU9JpTYfdJO51OM
         Xi4X9JMYBFIRLnURmuHu6yWRKc7QFcYa4t+1dT9UtAbH0z5atZuvV+ddPxjdbWpEIM3s
         53sxjJuYV9K4yXHRaQhs52jJ7s8rcQQTFRwtGdOvcE6Pt1K8BOXc4DzveJkc0845jbz/
         yaIwRVwrk0p6jzQ0SwVSN0+WWPzdciSZlqWn2hpV0WFvwhU8MXR3maLxPQ1qSWbi0ef/
         TlVA==
X-Gm-Message-State: AOAM5337/Xx8GjYr08IVHGHw7vu1y5lpYd2G4VcpRveDKy8LlGDp9LRO
        xXdcJtAoAw2huM3IP+iSnFXlLK1wqW1c5gnHNzSBg1v/5WQ=
X-Google-Smtp-Source: ABdhPJxER/dRTt+/BG/nUUPy01Ag+M/vI0uEeL7mLcUsIvwn43UETPDNYoXn8rZnHRGq/jKGImEDa7S+97R76GQOeWc=
X-Received: by 2002:a05:6638:22cf:b0:331:a5b9:22f2 with SMTP id
 j15-20020a05663822cf00b00331a5b922f2mr7162662jat.218.1654624609309; Tue, 07
 Jun 2022 10:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220606215013.GN22722@merlins.org> <CAEzrpqcn_BRL7p3gPmS5OVn5D-m8hMB-5JcAHwEHwKpxGxOMqw@mail.gmail.com>
 <20220606221755.GO22722@merlins.org> <CAEzrpqcr08tHCesiwS9ysxrRQaadAeHyjSTg3Qp+CorvGz6psQ@mail.gmail.com>
 <20220607023740.GQ22722@merlins.org> <CAEzrpqcStzdJt-17404FhAZKww2Y1o7tu6QOgtVGziroGE0pCw@mail.gmail.com>
 <20220607032240.GS22722@merlins.org> <CAEzrpqc8f3HzxUG0Ty1NQoQKAEEAW_3-+3ackv1fDk68qfyf6w@mail.gmail.com>
 <20220607151829.GQ1745079@merlins.org> <CAEzrpqftCCPw1J-jA-MTgoBDG6fNVJ-bJoXCh7NAbCeDptiwag@mail.gmail.com>
 <20220607153257.GR1745079@merlins.org>
In-Reply-To: <20220607153257.GR1745079@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 7 Jun 2022 13:56:38 -0400
Message-ID: <CAEzrpqd9RJ8xoOQFWh_xLBdqeMYA+t=otXT4W5YcPkJqsPvG0A@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 7, 2022 at 11:32 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Jun 07, 2022 at 11:21:57AM -0400, Josef Bacik wrote:
> > Can you capture all of these lines and paste them?  We found a bunch
> > of old block groups but we may not have found everything.  I might
> > want to try manually going and looking for those chunks just so we can
> > avoid mass deleting things.  Thanks,
>
> https://pastebin.com/dPzJgVU9

Ok re-run it, it'll crash right as it tries to delete something, I
need the bytenr it's complaining about.  Thanks,

Josef
