Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889D7541366
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 21:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357739AbiFGT7z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 15:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357741AbiFGT7P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 15:59:15 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B301BC14B
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 11:24:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y29so20163802ljd.7
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P2AehPb23QTEH2o3gswHipp+fpQCeKD8+mTHUy+XWo0=;
        b=HQ43BT246NtVUEyiqBOGM/Oeb1VrEOwujPXTdFdebima2WQ/v7KMUcJ2uL3wuAYrhu
         4bZ8qMAYhgZlTDYMvitG2hJyA4ccqmacCB4qcpksXQVWtOS+PhrxZk7tj4nUVaYGC1bn
         cchlBN0e14QObTSZnrWUfxgO9ULz32Grdl6MJ5hLLrZQhdcD1YJIbRLpA4sdrwXz2ZPB
         /h/ctaOBYskFMmg3vvVgNLXlb10CW7AmHMqCO9rBGEql49kDHt8CiLES8WBO6kHvkZkN
         UpxCx6O1tfiRT554o9FVdR01aT+QwTB1AWCBI7XSnI+auVw5P+l9CjAZQvdQSqUtNbPp
         q1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P2AehPb23QTEH2o3gswHipp+fpQCeKD8+mTHUy+XWo0=;
        b=UbuYfVzZmfZ6Sq/fzqZLmdGAfMpbuPTuN3AgOiBWmthjOtEJzUqTrElk6aEcM3/Tas
         5Xeb8bosa6dFPCBQx/GeGgRh0i1GVnuKba+Vv4N86N/UsdvKzyWG6zH9q+QpJV023iXG
         Ay5YRPGaOqvIOHcre3GCmVPLLDGFKjqYhkdX7gfzQYR922nkLFsxpVbwsgiYLp7Atq2y
         iejV430cWdwikGdj3DsoujJUXjvKJ/Q8LNIG9iK7tQdpEfMuxwE9GZw+dnQ2Pmvaz9lZ
         Fmt7kevf0aMVKx63wjTzyT52hq9YvMehoavbXBnRsrityrioJZjkODphA7POCfdL9/O7
         PUDg==
X-Gm-Message-State: AOAM533tLgi4+QpxUbQIl4sCnEIWezfnd0AQaR2V3ZjVdS7mDoK49OLB
        XJVt/cjpuskG/ksnzu1s2IeC25xuHouWb+SoB+THzg==
X-Google-Smtp-Source: ABdhPJxJknPbaevHVUOZ1Fb1sStfAAoF9qlpuBEQa3gCoea8KfQ1TREThJTTXKXXd81IN3jZ6deJkP1dMrna14nvmCc=
X-Received: by 2002:a2e:3112:0:b0:24f:132a:fd71 with SMTP id
 x18-20020a2e3112000000b0024f132afd71mr55669780ljx.522.1654626264079; Tue, 07
 Jun 2022 11:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <023b5ca9-0610-231b-fc4e-a72fe1377a5a@jansson.tech>
 <445c4c65-9b94-4961-c498-5c3d9b140a3d@suse.com> <db44a8ab-bfc1-667d-0c38-b04461768370@jansson.tech>
In-Reply-To: <db44a8ab-bfc1-667d-0c38-b04461768370@jansson.tech>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 7 Jun 2022 14:24:07 -0400
Message-ID: <CAJCQCtQ5W1CqiLedXt0ZzaVOnJ2d_nugFHyt879yOs3W_K=YjA@mail.gmail.com>
Subject: Re: btrfs-convert aborts with an assert
To:     =?UTF-8?Q?Torbj=C3=B6rn_Jansson?= <torbjorn@jansson.tech>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 6, 2022 at 12:51 PM Torbj=C3=B6rn Jansson <torbjorn@jansson.tec=
h> wrote:

> Filesystem features:      has_journal ext_attr dir_index filetype meta_bg
> extent 64bit flex_bg casefold sparse_super large_file huge_file dir_nlink
> extra_isize metadata_csum

^^casefold

I don't think this is related to the reported problem, but it occurs
to me maybe btrfs-progs should check for this feature and warn? The
feature being set means there could be behavioral expectations that
Btrfs can't currently provide since it doesn't support casefolding.


--=20
Chris Murphy
