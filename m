Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF0B42DB6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhJNO0d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhJNO0c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 10:26:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF3BC061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 07:24:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c29so5619746pfp.2
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 07:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1agOtAA1NFhkoi7JJNzUe0tpAXSeGCTRJT7lK2xygBg=;
        b=PKDXqeDPVUpwXbtCKdIVAd3GWQISV4ASDQ9YiCuBgOFoodoyaczT4vYO7BwgUGeRs/
         ue1OIVQrp0miJ7YumRM/cyP9IYkXJoeOVrWDLqDe9JYr8QOV4yE1iROW5g9aW+tHXVYc
         RCYyQeIBkS7bJnAJnbPpIUI2EImycsSyavC9jaKPeisnnMW1PP6NUV/fs1oQPvgIGxsg
         OaMuVGjMPz0X2c19BDrz0E4MNikjUUk+8wdNjchaLpuYxhrf4LtPKP9/4opsQmA7hYqX
         3QVkAaIAF51NtNBp94Dj2OrSha1VJHVWYI3HocfLe/NdEkjgCKneA4wFWIiQe63i+lbL
         Qn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1agOtAA1NFhkoi7JJNzUe0tpAXSeGCTRJT7lK2xygBg=;
        b=vm6I7LO/6IjnkBJhajiUCQknjl17hEdetUfO7c4RnL7oe4W+jg/McDn1DF2t9+jmI3
         yJ6N4pBXIPZOPYjqaRl0xdbODFDBGPT0kDhjmanxWCtPA4vtBBRLmmmnxdf0xzXrbdkD
         zLsMyGtZAvD7P02MMjtusq+irP7x9ZPEbskyEPbXfUcH1AX5uxgxyrabJzQ5xQDbIWBa
         GfOu1iti9qOJQz5eeeXAjIwiCW7EWOcLcz0hleNgvssZeMApoVBt+UI9LdImSLNJQY+s
         p6lYDUfYnwNtgk39nwqmx43wFnp7/yEnCt3ClCBxVg6RIsW4NrRfLbkx+BpokbMpEMTy
         MAnw==
X-Gm-Message-State: AOAM530gBVo59546I6bC4HlxhDWOP4IngonU62mI500hSg1E1/+f43Pt
        t0Q9Thx79NbRw1WOZjTiYOThN1OMTaGBiuc8tCJZLwfb+1s=
X-Google-Smtp-Source: ABdhPJwGL5dSaIJEb+szgFdwZ9C9r3NJ3zaVuL3xlkY8jVhRlOQ3rCS6AKU3g3aP3IviXIskhoeM3jpqm9ji+D2AIeM=
X-Received: by 2002:a05:6a00:23c8:b0:44c:d139:f3a4 with SMTP id
 g8-20020a056a0023c800b0044cd139f3a4mr5625916pfc.31.1634221467471; Thu, 14 Oct
 2021 07:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <1920407503.58357312.1634216278641.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <1920407503.58357312.1634216278641.JavaMail.zimbra@helmholtz-muenchen.de>
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Thu, 14 Oct 2021 16:24:16 +0200
Message-ID: <CAA7pwKPWDSeb7kxZq=H+XW19R=x2azDFgM9JCfR1E=etOBZJMg@mail.gmail.com>
Subject: Re: some principal understanding problems (balance and free space)
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
Cc:     Btrfs ML <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 14 Oct 2021 at 15:19, Lentes, Bernd
<bernd.lentes@helmholtz-muenchen.de> wrote:
>
> OS is Ubuntu 16.04, kernel is 4.4.0-66-generic.

At least install the HWE kernel, but you should really upgrade Ubuntu.

sudo apt-get install --install-recommends linux-generic-hwe-16.04

See https://wiki.ubuntu.com/Kernel/LTSEnablementStack
