Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CA34CB58D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 04:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiCCDwm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 22:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiCCDwl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 22:52:41 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE65814A208
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 19:51:56 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id r13so7954723ejd.5
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Mar 2022 19:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRPjsyp+xSE71tfQ7XLfSWOYsienEvZwF6DmyahTP60=;
        b=kWENog7JMhlsWrayynAqh+G91A4O+eGvfFs3Ktl8QT8HVcILabgPTSeCWAy7JxN7nw
         zRsQNHh6V05pImyoOFApT12oTKa0HQd8kgZY4qhphVYEYsV56cGYmiJKnE5VI5m/HTzO
         qjmJKMRVOnV8a7JdeW+j16nLmwQGjs16Zy+tN0TVo8Yp7H8euFYva01p7xhg5LcwEyvr
         /Ii4WYRCH+nPU0Ig5/5ZKO7mKy2658HWJ8q7t7D2kooToFHQqEiRzpyM9QhnhwGOHEkw
         CIg6ep/huLOlnHT6+X1Qmsfko94zICxG9i1vi85+n9KTw5cYDrUSpwTTJg5H45ZFHe3h
         +1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRPjsyp+xSE71tfQ7XLfSWOYsienEvZwF6DmyahTP60=;
        b=kyW3VbJ72NDtQdKwfC6/9zx3GGeFWJwk2RF2UNBwah0ARFBS28pyqouo33Zr/eV1hM
         vuqaRJrB8wARcY7SDeB7Gg5CLF8qoKwKYC1xu7UTnBm1HWT3BzrnS7Qkk32Zq4bBgCi8
         0cqMsBt8lgx/ucAQPP8rWeJyr+fSnyjr5eybkg5X9hlIC16z04lh5luEcpkYY3wRjxCO
         gkmvFNfx66sHe2T/CUdYeNMT6mirw/g/jeZelJKS+xRTRlf0upvCqAw4FC/RqxWAyMlN
         1eC2s/kX3aCIcAecCyQEUFpt87OZiC5K2CY0CZY5Z3FkYVzsMo6C95/T2BaUQn388bbM
         7GYg==
X-Gm-Message-State: AOAM533uuYH/GI4uqw/dBsbWtXMz7pVIwpPqHRpVwJ+Asl/8mw0C7pHm
        cFymMmcad7ih3062qcxOtnfvFuOqX4Apxq2v6FNYRXT/LTxlTA==
X-Google-Smtp-Source: ABdhPJzF/SGsULqHh0F0RuVUJz4gZKLuf4qai0QppfA5qEBWldiU6P2AuceugEX9eg1/5RAeGb7mXLHDvaPU2L42MRM=
X-Received: by 2002:a17:906:c1c6:b0:6d5:cc27:a66c with SMTP id
 bw6-20020a170906c1c600b006d5cc27a66cmr25916413ejb.650.1646279515157; Wed, 02
 Mar 2022 19:51:55 -0800 (PST)
MIME-Version: 1.0
References: <39c96b5608ed99b7d666d4d159f8d135e86b9606.1646219178.git.fdmanana@suse.com>
In-Reply-To: <39c96b5608ed99b7d666d4d159f8d135e86b9606.1646219178.git.fdmanana@suse.com>
From:   Daniel Black <daniel@mariadb.org>
Date:   Thu, 3 Mar 2022 14:51:44 +1100
Message-ID: <CABVffENfbsC6HjGbskRZGR2NvxbnQi17gAuW65eOM+QRzsr8Bg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fallback to blocking mode when doing async dio
 over multiple extents
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you very much Filipe.

I'm still following other discussions that are happening.
