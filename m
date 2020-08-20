Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24ED24AC19
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 02:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHTAY2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 20:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgHTAY1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 20:24:27 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F98C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 17:24:27 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s2so626269ioo.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 17:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VTHFfJRuh8efurzdpumddOiJw7yWRewOL/JeqiAes0Y=;
        b=MRP/QFh97EIjNPN4QtlbwDqijyeEXvFp9XqiHL7gvQi9gWr+NLZCgcnPNv5NVzVVoz
         wcnxKdQxqhoUFSob31l240+iDeSXO5FhkvNOvkhQOVHO/5R/k+4KUENAuNNAyJj8zrTV
         x9LjhCggQqgPIjmnOQgHjDMujfNlETWIBTU8xMIjdgJhGIy5twsODzOGoWg2l8D+Fk08
         ZbXrgNRVDSBYOg+g5xdbrKLUPD/E/0xHsOUe3RceKHy31ux1Ou3dHhaMHeNlQnHokq3C
         lwJMx/hqfI0uP3MfL/UYnTERYtaGBo3MjDsUt1okdfFHVF+TXDW+FamzjOy8WkXzDbQK
         weNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VTHFfJRuh8efurzdpumddOiJw7yWRewOL/JeqiAes0Y=;
        b=m7iM4NCjkJlyUUQoCEKWL2lgsrdSBrv1N2ec6qxE7E2Ocu2ywRkcGN86wwS66ebiuv
         HZZSrh6hYfeO3qQaydPpj5qH+fcvLXkGeeQaroSopJSQDfMxk+lQQkvf2CdeSq3nxMM2
         cfUrxaTNzNuLhfstX0dnMwjvFnZj/NMqF9P+bycB9w9ZFyO5I0FlPzWRjbaFXNCYFthu
         zkV2xQWMGZ9IpR7q4i5UeWCJFINgbQ2lKPsFmbUDcB5H/7Arr7zvveipbfLWO+YKmkKC
         pkLoxJFN0MGqpUCu8qg7OMlOA+DUvg0WPxuNHkbuY7uCffeI/ASOinTvMsR45/8HTyZj
         rDQg==
X-Gm-Message-State: AOAM533qJrJ1cvGipNbVBwxpv3nnL3JRasMM3eZhbxw7wWumXYL+ozuY
        KYxSS7BBRMtYJzNVd4Dk3mxsrK2lbi9Cgk33h38=
X-Google-Smtp-Source: ABdhPJxYJY3BnjayDTZ4TogLRI+EQEeUfZRb1mgma6IGO3LKTbzJzhmc2KDe9EUEEnFaGgiUCj2bp6d6nz3sVYQub5U=
X-Received: by 2002:a6b:b4c8:: with SMTP id d191mr439108iof.174.1597883066265;
 Wed, 19 Aug 2020 17:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200819214558.531259-1-shngmao@gmail.com>
In-Reply-To: <20200819214558.531259-1-shngmao@gmail.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 19 Aug 2020 20:23:50 -0400
Message-ID: <CAEg-Je8L+KUx93im15DPGvczpvw8TfvhN752itm88w9Qwkg+sg@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: btrfsutil: add pkg-config files for btrfsutil
To:     Sheng Mao <shngmao@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 5:47 PM Sheng Mao <shngmao@gmail.com> wrote:
>
> Add pc files for dynamic and static btrfsutil
> libraries. Users can use pkg-config to set up
> compilation and linking flags.
>
> The paths in pc files depend on prefix variable but
> ignore DESTDIR. DESTDIR is used for packaging and
> it should not affect the paths in pc files.
>

There should be no separate pkgconfig file for static libraries, since
you can tell a compiler to prefer the static library over the dynamic
library when using -lbtrfsutil with -Bstatic flag.

This also reminds me that I need to submit that patch set to fix the
versioning for the btrfs libraries, because they're completely out of
whack and make life difficult...



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
