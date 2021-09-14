Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3EE40A451
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 05:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbhINDYQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 23:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbhINDYK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 23:24:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A382C061574;
        Mon, 13 Sep 2021 20:22:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 5so7237657plo.5;
        Mon, 13 Sep 2021 20:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RXWuuP1j+e4RRbqY4fXoGwP299PdzhFGFwmKJhwW5QA=;
        b=U6f+G/eWKnwX/Jndkwn4ew6X24IvRZwJ00DJo4WL92BUmkqSbNS66tutUTIrhPocPj
         QPih6f6r1GL+AfMWXiFOiQlQ3BWKGEhNySQTzl0XWuHSn2AcuwpNLGolYBG+aVvvnS7+
         O0Ybd7FjLlM80tebzGGAbxB3NksKfd3lJKYeyWlIfqh6fkHfqrfb7MzQJG3P+FmkP3p4
         pga71lDQmLJzZ3MqEQUyfYpT08SDLeVIzrF2z00IasUDhtX5MxhLUpqF5OKMTjtFzm+i
         Ygj541198mmRqs7k0yG4FJr/4vbYCkOVneiMLW8ygHlXCa8xHHTaRys5765HMFpUm+Hz
         sL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RXWuuP1j+e4RRbqY4fXoGwP299PdzhFGFwmKJhwW5QA=;
        b=Uyd3dF3/dGXBWu4RznR5WLt/mgxGt25XVHNWc3qA2AHMXrLRxzYFQ9iDeJwszfvmBC
         rRKQO/qYGm+HNpZY3VEaPvbu6dJSbf41MUMql7a+ELFKxRChbciQGzNBIMMDCGCdSreq
         M3T329+dN3CL4bGp/AliBcNDa/A5PUPNLADMXVTZls/pcEJvv/V3hmqbnBuEwRXfLWCq
         QsNgx6ADvE0ugDM8DbS9zX7M+cLCfu13ZJvkpho9fa1I24b7v/lIfq+FNn9RC/XQLjmJ
         6q/9IwShltjKXYYEmzEQBauT0Z07z0ixaLjR3Fk6JkA5n/ScFPJsl9Fr4oSOFx/1U71d
         6MOQ==
X-Gm-Message-State: AOAM531fur0aMpN3+8OW3LPzAnRTLHnAvh1nsEBh+b1m5HNK9ZSKl9y7
        qFUyoDAJMFQt/ZYLSMU0YNRwbT8YQfkzy45BAA==
X-Google-Smtp-Source: ABdhPJwGE2TgEll1c1oZG8dBoSF6ZxmH2NWTdHtNaBPCHvJwulM4uHptz/NukBHzyKq7MdsWrNfIdth+P0m8XVsxyZo=
X-Received: by 2002:a17:90b:4b52:: with SMTP id mi18mr3006576pjb.112.1631589773025;
 Mon, 13 Sep 2021 20:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsZuFQykH=vQmy0n_mE1ACpiy1t48dvbUT0wtfBuHC4RFw@mail.gmail.com>
 <1ffc5484-b68e-22db-349c-d1e0c31f9562@gmx.com>
In-Reply-To: <1ffc5484-b68e-22db-349c-d1e0c31f9562@gmx.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 14 Sep 2021 11:22:42 +0800
Message-ID: <CACkBjsbUnPQ1J5HpXW-be2jb_h2k8d4b2p-epp5pUek_Rf0reQ@mail.gmail.com>
Subject: Re: INFO: task hung in btrfs_alloc_tree_block
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8811:13=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2021/9/14 =E4=B8=8A=E5=8D=8810:44, Hao Sun wrote:
> > Hello,
> >
> > When using Healer to fuzz the latest Linux kernel, the following crash
> > was triggered.
> >
> > HEAD commit: 6880fa6c5660 Linux 5.15-rc1
> > git tree: upstream
> > console output:
> > https://drive.google.com/file/d/1U3ei_jCODG9N5UHOspSRmykrEDSey3Qn/view?=
usp=3Dsharing
> > kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTL=
JvsUdWcgB/view?usp=3Dsharing
>
> Any recorded info for the injected errors during the test?
>
> It's hanging on a tree lock, without knowing the error injected, it's
> really hard to find out what's the cause.
>

The `task hang` happened without any fault injection.
Based on the recorded logs
(https://drive.google.com/file/d/1x7u4JfyeL8WhetacBsPDVXm48SvVJUo7/view?usp=
=3Dsharing
and https://drive.google.com/file/d/1U3ei_jCODG9N5UHOspSRmykrEDSey3Qn/view?=
usp=3Dsharing),
no fault-injection log was printed before the task hang.

Regards
Hao
