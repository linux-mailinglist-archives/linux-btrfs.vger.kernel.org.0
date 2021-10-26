Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8670343B982
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 20:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbhJZS3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 14:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbhJZS3G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 14:29:06 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A69C061745
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 11:26:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id o12so33180340ybk.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XddF2Tusv4LByZKS6nvbLsvLyEXmiWFN1mSvHpfybbw=;
        b=Ehr6cFjCimx2guUsgtpkBfhmGUx73cfD+lgnGrjx5Wrj3ppf9R5BT7LXYgSdr4nT0z
         QcIsZB6o1nEdsnqZiKtUz5P82qC/ay3evfFBaSC1C3pacq1WDIsEg7La0Ui+FryB47mY
         2ik+kk7u2lE6b6XHPk+iRnbdMZoT7+2KXxdmEP+QuIbWQtWhQ1Mwajc3y+gZfAgW6cMI
         WCWpt6KkKsGmXUw/Zyxe1JdfEyYChq4ynVMu0HVMnAVuyQK+jdeSqyQ4HTsSFlk3WrbC
         dh6Ma18vnne5QnC/yugcvHxLPFDI1bqzVcpcin0KIf4LbB8wX9eNhpebNfua1MSszd2Y
         ReXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XddF2Tusv4LByZKS6nvbLsvLyEXmiWFN1mSvHpfybbw=;
        b=SdH6V2MBth9fCm3GUR3n9EyTymvzkhW1CT4vXRiDunjdKBPBsngeiBvUWG19huaOrI
         6JuCmhc0Ony3GZ4AnNbWTGl64JOTZDEk06IrUjkRDrP6DqDmjfARw3fzuDUnln10lUtN
         0GRM6FvEjOgB2JkRB4QonBDAL4za/PrbyYaTaYUi7oWLWB9zcoE9OuSruuNLmyeQp9Kn
         9f6uLvlVMPb5zFta6bSmwwpbNeBphbKQmHV0ko7KOUnhdQSFtIHf6el95dPwhEeZHOKt
         FoC5oZf5nF2PXWmyuk/5/suZXtHMnPaPJ1UWJmey6wLdm4GjpA2rFf7Xd77lkDUOcXHS
         Mw9Q==
X-Gm-Message-State: AOAM531fiieh6sEZckKkgcyV43eI5BnKautjB8Qb6NYBWw/FrUpPhUs/
        Q+/L3xpMJWcZXcFagtVsZ22LKuK+KPZY4WEuep+SiA==
X-Google-Smtp-Source: ABdhPJxSiHP2ymJjJUigKvtsZytwB3H94ehYFD/zKHHXHuqOTdD8xYtbyBGWarK7f3iKFJGRHOfIjlzqS9Go5kFO30M=
X-Received: by 2002:a05:6902:102f:: with SMTP id x15mr24502528ybt.341.1635272802050;
 Tue, 26 Oct 2021 11:26:42 -0700 (PDT)
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
 <fa16bbdf-be5b-6970-8b28-9cb217d4b722@suse.com>
In-Reply-To: <fa16bbdf-be5b-6970-8b28-9cb217d4b722@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 26 Oct 2021 14:26:26 -0400
Message-ID: <CAJCQCtRkGL1hWgpcPntz=vejOyaiawKL4=ofY2=wna=q=EgQtg@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>, Su Yue <l@damenly.su>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 26, 2021 at 2:14 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 26.10.21 =D0=B3. 21:08, Chris Murphy wrote:
> > I don't know whether the hang and crash are related at all. I've been
> > unable to get a sysrq+t that shows anything when "dnf install
> > libreoffice" hangs, which I suspect could be dbus related where a
> > bunch of services get clobbered and restarted during the metric ton of
> > dependencies that libreoffice brings into a cloud base image. But
>
>
> Since this is a qemy virtual machine it's possible to acquire a direct
> memory dump from qemu's management console. There's a dump-guest-memory
> via qemu's management console alternatively via virsh one can do the
> procedure described here:
> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/=
html/virtualization_deployment_and_administration_guide/sect-domain_command=
s-creating_a_dump_file_of_a_domains_core
>
>
> if you can provide a memory dump + kernel vmlinux then I will be happy
> to look into this. In the meantime the barriers fixes should remedy crash=
.

OK thanks. I'll start testing a kernel built with this patch, and then
move on to capturing a memory dump of the VM if we're still seeing
hangs.

--=20
Chris Murphy
