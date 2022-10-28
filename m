Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCBE610961
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Oct 2022 06:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiJ1EsQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Oct 2022 00:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJ1EsP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Oct 2022 00:48:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0A41A16C3
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 21:48:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y69so6239736ede.5
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 21:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1+evlEjiivgprd8+/h6nhmvBgyF7NPDenvIzR87hF0=;
        b=B1q0epIx9J2AV6pyLp3ITC58q0rMeO/wp0TBqbAoTLvg8NeSPmSOJyLXNO2eqt+Kkc
         zjfRVQF0KCYfpbjN+Angt6RRcf7IkIZE407P+u3R0Cdct/HG8nl5AcIMCrytevFFmIGd
         Gz93WApqbOG4+aLQeSR9XbBRdoQtxBqwUnB9kWDpkECaQ/tOyb6beqeEcXgZ5AeGkyzU
         W+QnaukG+KS9TO/QmfCHJbwxK8fPqTYvQcAYMAPs+RjHcZdA5Oq4wc7tUdlTJZHOXOj4
         Qn/5Aw/fYoKEhRVFxmaKhOCGN/U5uIOnfZCg7A/8J7e+fbpGyjX5k5W4jatXG5QWGHAw
         J0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1+evlEjiivgprd8+/h6nhmvBgyF7NPDenvIzR87hF0=;
        b=pwPHEe9jWgzQSREEIuOFGepNJKFaJZBQ9sXfzGNhtCeXq43OC5E00DTCXhd1M6dcsR
         0gcjbhVxBH7MPbbyK0DRqWU/CzraGNGVhsF9Nwu4cqUImwngT1HFVHSQRRhEusdoff9m
         eLYTYvWHvRWeO56fnzAT4ifXzYel+LVv9a9duaBI+vwQW1mbkxutkeLjaWPCEvFe+ywY
         ASgsCUMYfmcpmqIjOiZh/kmfEHiyTYMeHhrua9wMxRv13yqoCTRIx6tacDnfKWE1mqsU
         qe1rdTehCjOdmrpFel/R+rhb0cMLuKy+MnjdF5z+OAqdZxfSuEK95dyVkSwi2/TANW0X
         4mQw==
X-Gm-Message-State: ACrzQf120nFRZJjs7Uq0B+tc/b7XrSj2EpkSKzj+zs0kEx8kVNI8zYw3
        qjJMC1PKnO2/7EnLs0sUeifYStf8GfULKcI+P4qqkTpn8rHHqg==
X-Google-Smtp-Source: AMsMyM4vkiF/ahC1ebJyLLHq+IqsAt7tTdW31v1XgMR5uzRJgxE+5aj3VP4fGGx47eCk8KJ2AsdRBa52HTsaJItYcuI=
X-Received: by 2002:a05:6402:5507:b0:452:183f:16d1 with SMTP id
 fi7-20020a056402550700b00452183f16d1mr49923574edb.96.1666932492722; Thu, 27
 Oct 2022 21:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAEmTpZGRKbzc16fWPvxbr6AfFsQoLmz-Lcg-7OgJOZDboJ+SGQ@mail.gmail.com>
 <a6b9bbb8-6f1b-f56b-72db-e366fcd06247@gmail.com>
In-Reply-To: <a6b9bbb8-6f1b-f56b-72db-e366fcd06247@gmail.com>
From:   =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= 
        <socketpair@gmail.com>
Date:   Fri, 28 Oct 2022 07:48:01 +0300
Message-ID: <CAEmTpZHwgENzv0Tn6h73NReqUgKx9D6ykyy_vN6Bs=+yAqAu4w@mail.gmail.com>
Subject: Re: Major bug in BTRFS (syncs are ignored with libaio or io_uring)
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Databases and other software use fsync/sync feature to persist data.
To protect against data loss. Modern DBs may use new fast alternative
such as uring or use libaio to write data. Data loss may happen if
power outage happens after an application reported to upper layer that
data was persisted. Fsyncs/sync must never be faked in storage layers.

=D0=BF=D1=82, 28 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 07:30, Andrei Borz=
enkov <arvidjaar@gmail.com>:
>
> On 28.10.2022 00:21, =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=80=D0=B5=D0=
=BD=D0=B1=D0=B5=D1=80=D0=B3 wrote:
> > How to reproduce (I tested in kernel 6.1):
> >
> > 2.  mkfs.btrfs over a partition.
> > 3.  mount -o lazytime,noatime
> > 4.  touch file.dat
> > 5.  chattr +C file.dat # turns off compression, checksumming and COW
> > 6.  fallocate -l1G file.dat
> > 7.  # prefill the file with random data
> >      fio -ioengine=3Dpsync                      -name=3Dtest -bs=3D1M
> > -rw=3Dwrite                 -filename=3Dfile.dat
> > 8.  fio -ioengine=3Dpsync    -sync=3D1 -direct=3D1 -name=3Dtest -bs=3D4=
k
> > -rw=3Drandwrite -runtime=3D60 -filename=3Dfile.dat  # Will show, say, 2=
K
> > IOPs
> > 9.  fio -ioengine=3Dio_uring -sync=3D1 -direct=3D1 -name=3Dtest -bs=3D4=
k
> > -rw=3Drandwrite -runtime=3D60 -filename=3Dfile.dat  # Will show, say, 3=
2K
> > IOPs
> > 10. fio -ioengine=3Dlibaio   -sync=3D1 -direct=3D1 -name=3Dtest -bs=3D4=
k
> > -rw=3Drandwrite -runtime=3D60 -filename=3Dfile.dat  # Will show, say, 3=
2K
> > IOPs
> >
> > Steps 9 and 10 show implausible IOPs.
> >
> > This does not happen on, say, Ext4 (all the methods give roughly the sa=
me IOPs).
> >
> > Removing -sync=3D1 on all engines on Ext4 gives immediate return (as
> > expected because everything gets merged and finally written very fast)
> >
> > Adding/Removing -sync=3D1 with io_uring or libaio changes nothing on
> > BTRFS (it's definitely a bug)
> >
> >
> > I consider it's a bug in BTRFS. Very important bug because BTRFS
> > becomes default FS in Fedora server/desktop now. This bug may cause
> > data loss. That's why I set this bug as high priority.
> >
> >
>
> Could you explain how this can cause data loss?



--=20
Segmentation fault
