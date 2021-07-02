Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0873B9FDA
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 13:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhGBLgS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 07:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhGBLgS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 07:36:18 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E94C061762
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jul 2021 04:33:46 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g19so15811604ybe.11
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Jul 2021 04:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oYhQ2mFVixEz8RMk7J01bJuWvJ/jAlF6zcjMCeBO1Eg=;
        b=kyqO4nPjIk5Z84o5Pg4lfsEkoqRUAgCKl/TDjXs9iUt4PYx8w22jfkX8U0KyhVCjYs
         iaYYfXofD+amJHDzLG17TLzRs9OeS3duYuGXdC7E7s5NBPYoIFL3lRs+iD1BE/bJCuP7
         dWg+eAhdeNanONqfTSwtc1GG/Usry9x3s3hD4q9SonDIcPG128Q/3LNYc0S2zQbhd5nS
         5GUGZJTPNf6Xe7jyfwRKUHcF8oGViSLIMccNfhrPnjNypMFSwJ85+2Bj6ysD0GWjJVp+
         LBz04wNbYnNSDvp2sd1my7hjdLqyZD5ofRohQRDcB+8E9mmsSvCUDi97GVlujKvB31du
         5kvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oYhQ2mFVixEz8RMk7J01bJuWvJ/jAlF6zcjMCeBO1Eg=;
        b=W7EgPZPtLj6YCVEHzb4eING1sitJUBJB/Cb2QeTN31Bn3PjQQh0Dn8SFOAbuvIcI1u
         9CJnOlGpsZvClSyOTQ2OsPMYs45FaRqa59vDbz/uvtfoGM1/5T+a956LUjREKc+YHrkh
         9a4vbe6/Xu220qMThtddtZpbSGY24Qot4tp7M7bBKbXA1RY95ytm0TAD6AbxF1JLDLfA
         ZtT5O63ZOTZUOFgAO4fKQ4A92pFe0a7uh6A8GWDT1WcbLzu1FttN203pOWlrSQzxk9y0
         piBA8Duq0zrgWclWS7QF0m7p7JycG9aWbzXYfsI4WQKV/FNHD1xHK/6R2ZB77mzNLaiu
         qWMQ==
X-Gm-Message-State: AOAM533X5Tpl+5pY+5qB00rW3fOIi4ru+Xaq+0eHTNSSj4NDoQfMF2yR
        1TsjCCK1vKox5e6ltXRFQhTDyLNi58etTnN8Bm4=
X-Google-Smtp-Source: ABdhPJz+8rSs6/UWdmryxO88prVDDEOxgH3kGsryBvCbbu+Gfu7qJZ4JRYEe5N0JVDpAokM4SfInJ3IVuIYXPnIYr7I=
X-Received: by 2002:a25:b203:: with SMTP id i3mr5950977ybj.260.1625225625400;
 Fri, 02 Jul 2021 04:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <a6b7c5c38267fb410a4a4f711e986c863790ddf8.1625221720.git.johannes.thumshirn@wdc.com>
In-Reply-To: <a6b7c5c38267fb410a4a4f711e986c863790ddf8.1625221720.git.johannes.thumshirn@wdc.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Fri, 2 Jul 2021 07:33:09 -0400
Message-ID: <CAEg-Je-Z0pWzEpe+Ym=gwvH+=fJwSOo4nE9hc2EfCXcQVMKXCg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: zoned: revert "btrfs: zoned: fail mount if the
 device does not support zone append"
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 2, 2021 at 6:30 AM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Now that commit f34ee1dce642 ("dm crypt: Fix zoned block device support")
> is merged in master, the device-mapper code can fully emulate zone append
> there's no need for this check anymore.
>
> This reverts commit 1d68128c107a ("btrfs: zoned: fail mount if the device
> does not support zone append").
>
> Cc: Naohiro  Aota <naohiro.aota@wdc.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Singed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

This should be "Signed-off-by", no?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
