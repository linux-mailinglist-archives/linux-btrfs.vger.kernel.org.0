Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAD93EBBE8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Aug 2021 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhHMSP0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Aug 2021 14:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhHMSPY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Aug 2021 14:15:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DC9C061756
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Aug 2021 11:14:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q11so14392944wrr.9
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Aug 2021 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G8rbFcqemoLKcJ7qz1HMoTyrxnQSylidDFCufpIcNJc=;
        b=iUNGOfBE5Uy08gt8ipj7aOILzNA53/jAPgE5v613jHVL79q6SM4tSTxaO84Vq4pF/Z
         aijO0UrspoptTU8DpsG/mhLTfBZjHOGe0ZixPIDDUrxgBnu6Zgn+0KHtTxWsExrB8PwI
         AP4Tv9jyIb7z9KRZo//5WXhvwMeH0OWLzbF6nrzyXpQejJv2pnWCwFp56Wp04+/rVaNA
         cHsFghuAIxgzNxr/v6o12M5U3z17GQIH6kH9UQ3n0+Rg5hK7TKaRo7IWhzpTyM0+mjGl
         nTGjr+SgyTSWhFr1GReG03HbBxOhUM+qMbp/o+FYHJXrrgM2X5h2WfJwbyMplA8Ftgqt
         QYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G8rbFcqemoLKcJ7qz1HMoTyrxnQSylidDFCufpIcNJc=;
        b=Vng2hY0TSOu2XizoWLuqJqIjsuBmzf7qz1y09jsyY+Q7bSTz0XQ9DP/La2n5xHTD82
         K5I5hb+KZZwtlS04Zyvbw5DkayjHoAFhryWKcE1ngmWCxkyEDlIyVJrUsQMr5Zc4YELY
         3ljP9QGLKb9jLbz3L6h/OHvI9oB7/YQKRAlD4zFtqEl6QZ1NH1Cq4J64HybQNgWVDKZY
         N7HYv++g0RwE3lU3Lxhy+YKPa5cWGWCXyG65vz6rGFoo3Au5USWmYfFbO/UXCQGm2cbX
         0q/FyJIfPQTcGaR8mlXiFfTPnvmCYSkFQCCnv/WxOhIwsg2nGvd7wzUIZK8bW+wObiOg
         aBZw==
X-Gm-Message-State: AOAM533o20fPgTjwp++gOExM+7cyRYMVCZ8aabWmbkTuhDylbmSDe7cn
        UE0V4GtRV3sHFe+GA/zevXWK5JTSzr7APQ9K4pXp4w==
X-Google-Smtp-Source: ABdhPJyFgRBlkXSkTqzP5RjkL6dtNfRFaAX5r5DnZvIHGN3lECw6N13Id0/csJt0jvbUsiZboyUdfX77yuhZkOEIzRI=
X-Received: by 2002:a5d:6e12:: with SMTP id h18mr4664730wrz.236.1628878496324;
 Fri, 13 Aug 2021 11:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <2729231.WZja5ltl65@ananda> <CADkZQamczB9yqw_Eump8uJJ11ez_kmr2V=HU8S_vnO1Q-Ux9KA@mail.gmail.com>
In-Reply-To: <CADkZQamczB9yqw_Eump8uJJ11ez_kmr2V=HU8S_vnO1Q-Ux9KA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 13 Aug 2021 12:14:40 -0600
Message-ID: <CAJCQCtROaJTj1J7t7fbX0Tjj5C7CvO=2sv02yRYHod_nQZmODQ@mail.gmail.com>
Subject: Re: Corruption errors on Samsung 980 Pro
To:     =?UTF-8?Q?Sebastian_D=C3=B6ring?= <moralapostel@gmail.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 13, 2021 at 3:50 AM Sebastian D=C3=B6ring <moralapostel@gmail.c=
om> wrote:
>
> >It is BTRFS single profile on LVM on LUKS. Mount options are:
>
> ...
>
> >I thought that a Samsung 980 Pro can easily handle "discard=3Dasync" so =
I
> used it.
>
> LUKS doesn't do discard unless you explicitly enable and force it. Have y=
ou?

`cryptsetup open` doesn't allow discards by default, but some distro
installers do enable it by default. The most likely place to find out
is looking at /etc/crypttab




--=20
Chris Murphy
