Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC51520A7A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 03:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiEJBIo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 21:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiEJBIo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 21:08:44 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3C426FA7F
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 18:04:47 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id c125so17095878iof.9
        for <linux-btrfs@vger.kernel.org>; Mon, 09 May 2022 18:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frU98O7TKmIB02kksMDQNS5ZvCTsWWG3D7HvZwYIZR4=;
        b=o4edvfp+0Yby9U+hgtaQ5vtXzRXxBjB6HtW4o7qZ9EL7SwaPWu18Zf0+USh73/j2lg
         BAG87A/RYES2xog3SxkIDXhxnZub8uCWuONs9890jeutGtUpTO0vakm3tqtKpTB5VSYq
         hX5ZEKFRGRtRTaYAzmSMZZ2ddnEqaxUvjFDXiW+XY4zRmzIYSCwvTDsEv1X8deE9VJb5
         cUc3EESp/GtHTleMpMynQdl0Sus8UTZnY1dSq3+4OpkrXGa0P0hAD7pdDxoGkiTKUHuO
         XS/buQcS+HbCe91g3u2nRSmKTwaIuMjTWqfNAD83vc2X6geC1PRUPGjBvxFNRQ0wM9SI
         EOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frU98O7TKmIB02kksMDQNS5ZvCTsWWG3D7HvZwYIZR4=;
        b=FI34XSUkgOOPjmTSHJTCTXWql8HuTTNa1PjHZEoVc3Cxgx6p/xD7OWYXR6YnWByOZD
         c8AIyBnSe7bSDecDDjseyax9+KLB8mTaSK+K8ojUOUdPwYfYKyN9HGBi0x1YLV6Njh3T
         Fx26Uy47wgDv5uHGoaJViOTiFWhweo11UB9mSw4vBv855cSvRgKag/7GeUiaePv0shTA
         kAqWTHjhiPEsTQfFEufgI/JCiW1S97rdtjQJuYBGnTX9j48nLMEYbPYd5dnw+UIwMPOJ
         lhTRF7ITQmw/6ssKUuqpb17mYxHMZO40++ik5gZoLZNLSVt4Bp4dr/53DUvH1AvcDwNt
         OopA==
X-Gm-Message-State: AOAM532hUiK42KK9bBoFO8RBEgPmGyiZH/JXxVF0bMk/O2ZWJ2kM9Gou
        t8ZGD6r7QnWMEKVydfHrOospCUdPVQm3rhsTPB1PJnryCzQ=
X-Google-Smtp-Source: ABdhPJzIJudr3GsqrK3hgpCwLIp44AD8o14UBxZViykO3jpGmN9ynIsqy0VJQnr3yV7UyZXaR8Oeb5zKKq7Pc/QlZFI=
X-Received: by 2002:a05:6638:3793:b0:32b:6d57:c811 with SMTP id
 w19-20020a056638379300b0032b6d57c811mr8674793jal.102.1652144687224; Mon, 09
 May 2022 18:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqej2giQzLDcxsfze=e=uYOyMEh1v25V3R2xP_AEeHUAsw@mail.gmail.com>
 <20220508205224.GQ12542@merlins.org> <20220508212050.GR12542@merlins.org>
 <CAEzrpqdMFJ2cm0URWqwFehkQQzmrgYO+CdoibSUqqfN1hkGOvQ@mail.gmail.com>
 <20220508221444.GS12542@merlins.org> <CAEzrpqe=qUMdC-8UTeuSy7niO9i8PhFGa6auMmQk_ave30gKUw@mail.gmail.com>
 <20220509004635.GT12542@merlins.org> <CAEzrpqfYRkASd+7ac_2dO+bNtacYwE9ndcYDWsp9B4Esq9Hwug@mail.gmail.com>
 <20220509170054.GW12542@merlins.org> <CAEzrpqccXWAEELYsY0NQ+ZzecQygJFasipt3yE=0L1KA3GgzYg@mail.gmail.com>
 <20220509171929.GY12542@merlins.org>
In-Reply-To: <20220509171929.GY12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 9 May 2022 21:04:36 -0400
Message-ID: <CAEzrpqft5yq1cMFC_zdHDpOyHc0POQTNkKyW2rKhyHuoN+av6Q@mail.gmail.com>
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

On Mon, May 9, 2022 at 1:19 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 09, 2022 at 01:09:37PM -0400, Josef Bacik wrote:
> > Ugh shit, I had an off by one error, that's not great.  I've fixed
> > that up and adjusted the debugging, lets see how that goes.  Thanks,
>

Sorry my laptop battery died while I was at the dealership, and of
course that took allllll day.  Anyway pushed some debugging, am
confused, hopefully won't be confused long.  Thanks,

Josef
