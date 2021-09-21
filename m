Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27680413512
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 16:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhIUOM7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 10:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhIUOM6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 10:12:58 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29349C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 07:11:30 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bk29so54597597qkb.8
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 07:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8J2G8PTvAIX5/mT2XOH9KsSZ63gF9toqofhEsxCX2WM=;
        b=vR1XJUuAy/laW5k6HaijL3BgCn4aTtIYvf21Q3VaA3j/uyKEk6yK0rsrI0vtcybl4A
         +iuWDpWxPJ0KJHGS26Z4GjOqpRqa6qxSKN6KhV1LwtzeiEa3bsFGJod5woChBOpt3Hrl
         k+6DtG6WBf8euLe4Hkkc1UGcvAH3+Gi6Mpwcg0+DKwK5bdQA6x8zaprfzWfBcUvXBwXa
         NW19xpr2lCxiOazDO4tqevuJOT+nnGL5rYErWICivu88KuGD5CZyqvL7wSm+zeMDO64R
         6uV0ords3NevGW6MDcya1/PrMo1GVMiqqICZPSmueF6sHbbmbiS22T41q2wN8XtRnIG7
         YT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8J2G8PTvAIX5/mT2XOH9KsSZ63gF9toqofhEsxCX2WM=;
        b=nTYzbXCTfwOM2fHIsgFhVMThtrkqM47ilHUWKS2wAyIkxTRuuGzP7eKaqYUskzKbIS
         9FqtaemVApKpwR7mdxxbxKtJFFo0SAhY7awHkWdt+juI/802C6xVLTplou2j4rqeVOMq
         /2YbtyfRTmFGnsdrIdaWqUriSO0+Mg7srX3d6lc2C9r3xZ+wOiO/lYijFubYj0tO7WDH
         ebCtVw7A2P6b10E6UeQzySLNE0cHxgFciTmp66wyxF3/ygqkncoP7lwWCtj7MpTb/cEz
         cwd5R4NAO3tvpw+ImD9QYrVAs6ylVNEXohr3xzEKk6SgNxSVXx/EPYE1am40qPqB56wV
         zNDQ==
X-Gm-Message-State: AOAM5318nPqJ0KdiZRxN8N8VvGjH2/u7wzHG9BXQNr7g//0f5az2M6wQ
        AUsh/xIFN8tKIHcHcg00u89tp/FfXa6DWZtL3ajCuDZRRhYmtRJw
X-Google-Smtp-Source: ABdhPJw240a/stzYg1EqcGVwiFkHKi4dJRJMR5LEo73PfbmZUm+DWd6FGCm/9a4PIdtQUQhMgHBIYW3KHkrThdQZMXo=
X-Received: by 2002:a25:ad1f:: with SMTP id y31mr36158382ybi.437.1632233487785;
 Tue, 21 Sep 2021 07:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtT+OuemovPO7GZk8Y8=qtOObr0XTDp8jh4OHD6y84AFxw@mail.gmail.com>
In-Reply-To: <CAJCQCtT+OuemovPO7GZk8Y8=qtOObr0XTDp8jh4OHD6y84AFxw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 21 Sep 2021 08:11:11 -0600
Message-ID: <CAJCQCtS3qP1UGsf0Sj4=zCH3qSeYL3a8DBuVLSwrPZDOAxJtvw@mail.gmail.com>
Subject: Re: 5.15.0-rc1 armv7hl Workqueue: btrfs-delalloc btrfs_work_helper PC
 is at mmiocpy LR is at ZSTD_compressStream
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Downstream bug is in Fedora Rawhide

https://bugzilla.redhat.com/show_bug.cgi?id=2006295
