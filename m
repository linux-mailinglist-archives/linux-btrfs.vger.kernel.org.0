Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A0A43B9A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 20:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhJZSeI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 14:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbhJZSeG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 14:34:06 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82958C061348
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 11:31:42 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i9so37196671ybi.8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qwtnYMH9t7iR51/cFuMUbLWf0JU8geO1nucXMt8Szgc=;
        b=GPU+feUnGNNvXp4B5WHjDz8Yaxr2uvetRPc+qUXyd2Yb8fY8YCBfcr8nwegNXOAMvM
         ZzR0GYugp0Qi0qxGxbhmr17LN3xK1s9Sq+inL1AVYgzHPS43OMD4Ro83JrohgVqvfKfb
         yNB1j2X1LwfmlGo8chsPysCVUZvU0qQ88YIr/atVxqpREzemGahdigNEruLx7iA9qf3U
         A9E+TCLao+mGHIOSXlN/YTTj+xC/ZTj0Hi4ZfmDz+sI0zjaj+HZ2BDuifRFAlLHOt+It
         vFQ/HOd2FYoOX1AaTA3cqiPmM/fUVEeJfbxMmENC2IQiEE8zc7skm8vIOeRLJ80AkvUg
         T7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qwtnYMH9t7iR51/cFuMUbLWf0JU8geO1nucXMt8Szgc=;
        b=lo2NvHydTHA48ecKwaOz++qBwZRmeq0HK/RJLJSpmmJ52lmeckXyM34CCOUv8MtQbz
         sTLwBsk8tdI9zvLROeuDfmwfLnU+rwe65InuEtrPjF2rgxrjxlNLzMJd2EQEYOB4XJzP
         GncOs8xBJqdqd7D74M0XqPUWm6B0VqXnxQNeSrYJVaEL2OUST3XpsTxp0UzeM/dl1idW
         JaIx+/N1KkvihyuG26ghTBp3eFg4aeGb6BbBOM+EZKMBv8Cfia5Wg5ymt5mIIMuqkcuR
         sg2jTl9j1qaUs290lNzwxawk1Yyt7XnqvgOXalmqdC9kjILJjtDyb4RnxTGnVsSzN8ck
         gR4g==
X-Gm-Message-State: AOAM5336h1f3KDUbNgriF6cwcT6J00ThXXALWinoWOn2rHzA85Iey9my
        uBP46lfeIeVjZSbmULzGVhVTGaEber13qyM8tU3MKQ==
X-Google-Smtp-Source: ABdhPJyx6u6ZCcFVjiB3Qf3XBqesjT0x08pkrNOE2fAdjXRTweoVD3hkcX3SQTDwlHfI5Psul31xyEQ3dY0fLdjSiA0=
X-Received: by 2002:a25:143:: with SMTP id 64mr25610776ybb.455.1635273101834;
 Tue, 26 Oct 2021 11:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su> <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
 <ff911f0c-9ea5-43b1-4b8d-e8c392f0718e@suse.com> <9e746c1c-85e5-c766-26fa-a4d83f1bfd34@suse.com>
 <CAJCQCtTHPAHMAaBg54Cs9CRKBLD9hRdA2HwOCBjsqZCwWBkyvg@mail.gmail.com>
 <91185758-fdaf-f8da-01eb-a9932734fc09@suse.com> <CAJCQCtTEm5UKR+pr3q-5xw34Tmy2suuU4p9f5H43eQkkw5AiKw@mail.gmail.com>
 <CAJCQCtTBg0BkccvsiRA+KgGL6ObwCqPPx8bb=QZhcaC=tXUsBA@mail.gmail.com>
 <CAJCQCtQ0_iAyC8Tc8OZyf2JGGnboXm8zk9itZaOLAoK=w1qdrg@mail.gmail.com>
 <b03fb30f-3d4b-413c-0227-6655ffeba75d@suse.com> <CAJCQCtSrSHrNKV-HKRS0vy0T0ZrL5GR_BqpbG4iMNZZ66PJN5g@mail.gmail.com>
 <435c0ba3-dab9-3d01-7d43-0d370ffa36aa@suse.com> <CAJCQCtT02w+62mpRCxYNH07YatToQYFyaxuU=+8G_B5+QNgK8w@mail.gmail.com>
 <fa16bbdf-be5b-6970-8b28-9cb217d4b722@suse.com> <CAJCQCtRkGL1hWgpcPntz=vejOyaiawKL4=ofY2=wna=q=EgQtg@mail.gmail.com>
In-Reply-To: <CAJCQCtRkGL1hWgpcPntz=vejOyaiawKL4=ofY2=wna=q=EgQtg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 26 Oct 2021 14:31:25 -0400
Message-ID: <CAJCQCtQaj-SJPpnZyXGUKq7Z-qnMLYbVt2JirXVv7KVhW3LO4g@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Su Yue <l@damenly.su>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 26, 2021 at 2:26 PM Chris Murphy <lists@colorremedies.com> wrot=
e:
>
> On Tue, Oct 26, 2021 at 2:14 PM Nikolay Borisov <nborisov@suse.com> wrote=
:
> >
> >
> >
> > On 26.10.21 =D0=B3. 21:08, Chris Murphy wrote:
> > > I don't know whether the hang and crash are related at all. I've been
> > > unable to get a sysrq+t that shows anything when "dnf install
> > > libreoffice" hangs, which I suspect could be dbus related where a
> > > bunch of services get clobbered and restarted during the metric ton o=
f
> > > dependencies that libreoffice brings into a cloud base image. But
> >
> >
> > Since this is a qemy virtual machine it's possible to acquire a direct
> > memory dump from qemu's management console. There's a dump-guest-memory
> > via qemu's management console alternatively via virsh one can do the
> > procedure described here:
> > https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/=
7/html/virtualization_deployment_and_administration_guide/sect-domain_comma=
nds-creating_a_dump_file_of_a_domains_core
> >
> >
> > if you can provide a memory dump + kernel vmlinux then I will be happy
> > to look into this. In the meantime the barriers fixes should remedy cra=
sh.
>
> OK thanks. I'll start testing a kernel built with this patch, and then
> move on to capturing a memory dump of the VM if we're still seeing
> hangs.

With or without the --memory-only option?


--=20
Chris Murphy
