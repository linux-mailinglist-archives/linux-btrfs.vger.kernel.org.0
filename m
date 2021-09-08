Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F20403906
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 13:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351547AbhIHLme (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 07:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351532AbhIHLme (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 07:42:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FC0C061575
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 04:41:26 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 17so2288827pgp.4
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Sep 2021 04:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=RbFHtaSkyHveqO+cx93onyXauTyTrj1QPY+7LBwOHmM=;
        b=CZDGGt1EHXpmB0J0xpdy0DdnGJlY5wFmDVm32vTPnxTxFW997i9y87ZOaiosMVXWH5
         +O2zXmhn2xFoAB8P89O3/ZkHKxSh3LoD5WEpdnH+8KqNI2L9LkDwMlrGoAT/hUJ2XyAW
         zpLvazj/B8ReN1MvjvNJ42aCcy9c3fNbr3v/z+rjKXwaBjw3uHo65GmRonHRK9q//utc
         JAsTtHF5+FAZD5aSHghksX/8nm54Rm7BQT0Z7AL9QdxCflHNjw5geXiRlEHi2l4RcVcf
         skpcYJUie5HVcgBZBzBEU2OvMCcvLJ0RfCPo770VVlMTNUGItEjV1auWneiFw9yNB2tI
         LO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=RbFHtaSkyHveqO+cx93onyXauTyTrj1QPY+7LBwOHmM=;
        b=FrBMH0t0C+7vwI5p40gIWVe4XLZyVb4gv7p9cWYy16hiJinwGjpFGfzhNXr6mKCxMf
         aCDPP+cej3zlFs2Brp4Rg1pcHTHbGABKvDct3AlQlPlOyZoOhnvGtSKAJJUkhqXdNdwT
         YPg+LbTx02qwTUhrBmTOS4nJeI1MrU53yiHc1Hkzw2jD6HB5WjAxl6FKm5motupNn2/x
         GqiaZdSdDKpW5MK/7jqPilPr1K5oW9IihZICyVEJMEu4eM4pyi78i6uMTXdzZG9sqx1G
         ygulZ37qDiaeuVwJR9HJlEIcEJ6ruUZqjMwaRpGDdv1oa6/FrdyDx2L+PGQgMO4dDQos
         e57Q==
X-Gm-Message-State: AOAM5316VS0Vw9w32DFljkOIujDjKpOf0AelnxSlIa4ZtFDlgDI+xBDO
        KxYc9Le/ewutBs0oM+g5jLU/X3vZUHEXwn1KlDc=
X-Google-Smtp-Source: ABdhPJwyQAGq8m8mrO9hJtGNJHcFwnQn5c79NKsL15kTt5QFBa9HG62o/CPCwurQKl2EIKu2TO/5LB8hP/+uUK7YrAc=
X-Received: by 2002:a63:150e:: with SMTP id v14mr3290587pgl.126.1631101286054;
 Wed, 08 Sep 2021 04:41:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:8c88:0:0:0:0 with HTTP; Wed, 8 Sep 2021 04:41:25
 -0700 (PDT)
Reply-To: j8108477@gmail.com
In-Reply-To: <CAChQ5PcfgHbWGScZNRwvvxvAFVmJWkMo9hnJ3t5d9YmCMxKD2Q@mail.gmail.com>
References: <CAChQ5PcfgHbWGScZNRwvvxvAFVmJWkMo9hnJ3t5d9YmCMxKD2Q@mail.gmail.com>
From:   MR NORAH JANE <mafomarlene82@gmail.com>
Date:   Wed, 8 Sep 2021 13:41:25 +0200
Message-ID: <CAChQ5PfN2WhSoU4xVaJ5v=CQrsc9S3UK9tBwL7o79UEF_1agvA@mail.gmail.com>
Subject: Fwd:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

---------- Forwarded message ----------
From: MR NORAH JANE <mafomarlene82@gmail.com>
Date: Wed, 8 Sep 2021 13:38:54 +0200
Subject:
To: mafomarlene82@gmail.com

HI, DID YOU RECEIVE MY MAIL?
