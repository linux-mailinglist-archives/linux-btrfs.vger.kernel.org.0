Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7561E40A729
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 09:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbhINHOJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 03:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240530AbhINHOI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 03:14:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F2FC061574;
        Tue, 14 Sep 2021 00:12:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o8so4483402pll.1;
        Tue, 14 Sep 2021 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fp3ZKT+uCoGAKQG34YsDErxyHOAuhJOpqsMt6fZ+c1o=;
        b=W0opW9t3R5CRA9EreL0eLAI3ZzcrQX4CJEzO+XUjFR6E+Ztv23H9MnOBgZK9eiOkJb
         XuHKZpE+l6CwaGZiGPHkkKahDXBZxm1E7Alb/TRVMLTYOYG5heKfXFkrvLbIHSyRjTdG
         fmJom3A6Ofb9cKjJ3u6JYPzlFtwx14AHWOs7Gpq3ZsIiLhWf1lTOR10IWt217tJJnSJu
         bWQ8bxC8WNCwEI7vAiW/95wcQjTLcfQxGYMn9NYOJpnuAeuxTMMwCyxXkJYyRZ7FmgDJ
         fL5BqiCZiKJwLzqwbgHz+sSNjfCObhuugU70CmIg5PK43W3Vqv1CuvyTIJRN8OIsx/b9
         ZGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fp3ZKT+uCoGAKQG34YsDErxyHOAuhJOpqsMt6fZ+c1o=;
        b=fT4t0SqYMeOKbaQIHTqIbdx2peiGqYVMl2x8GI49mh8CmX8a8tGa6sp85AiKmSpH0L
         x1Cn2yfbeVW0CtFPH/TNTdv+C8bGwf+09774qyaDkWn9PSvNQ8eF8ZkHuunFUgxEn1P3
         hz2WOELXPhjnmM8xie1h+bOp1/pxUO4LwfQR9CJuYyVtRRm1XJFCdUwcIxqDbzfmEB8C
         cmMQN0r74Pdfty/b/jUYh68S9sCCXmNOlpZs7yV1Hv07btDmZgMgztrdgmG34+92y85t
         AWtGEQDBHyTp+xn/TGIDQDKekFRumVbApp0KhFOCgfjOUQ51Wr5wXep8TJ7WHUX5D6FM
         AEfg==
X-Gm-Message-State: AOAM53341+RkaKRWWS9NnmrY46vy8JZ2MnTVWiNFN7OodsVDFNly4Day
        kywW9UcVgBkJKhGUQZvZeYPdNgTCPUox6mGD9Q==
X-Google-Smtp-Source: ABdhPJx2VPixMHOrR5WAM0J72kMcdRAN66pFEBtKozwfLbBQ76bpkd+40OK9ggZHZANR9K3eEikRuGsy2DHxZkH1GiY=
X-Received: by 2002:a17:90b:4b52:: with SMTP id mi18mr458066pjb.112.1631603565759;
 Tue, 14 Sep 2021 00:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsZuFQykH=vQmy0n_mE1ACpiy1t48dvbUT0wtfBuHC4RFw@mail.gmail.com>
 <1ffc5484-b68e-22db-349c-d1e0c31f9562@gmx.com> <CACkBjsbUnPQ1J5HpXW-be2jb_h2k8d4b2p-epp5pUek_Rf0reQ@mail.gmail.com>
 <52b5e79f-6b56-2d90-6927-86b2faa295b9@gmx.com>
In-Reply-To: <52b5e79f-6b56-2d90-6927-86b2faa295b9@gmx.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 14 Sep 2021 15:12:34 +0800
Message-ID: <CACkBjsYMr1NsWamDFMXm3tuGV60UbE=99G70Mzi9ffU7vs-HXw@mail.gmail.com>
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
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:45=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2021/9/14 =E4=B8=8A=E5=8D=8811:22, Hao Sun wrote:
> > Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8811:13=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >>
> >>
> >> On 2021/9/14 =E4=B8=8A=E5=8D=8810:44, Hao Sun wrote:
> >>> Hello,
> >>>
> >>> When using Healer to fuzz the latest Linux kernel, the following cras=
h
> >>> was triggered.
> >>>
> >>> HEAD commit: 6880fa6c5660 Linux 5.15-rc1
> >>> git tree: upstream
> >>> console output:
> >>> https://drive.google.com/file/d/1U3ei_jCODG9N5UHOspSRmykrEDSey3Qn/vie=
w?usp=3Dsharing
> >>> kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EH=
TLJvsUdWcgB/view?usp=3Dsharing
> >>
> >> Any recorded info for the injected errors during the test?
> >>
> >> It's hanging on a tree lock, without knowing the error injected, it's
> >> really hard to find out what's the cause.
> >>
> >
> > The `task hang` happened without any fault injection.
> > Based on the recorded logs
> > (https://drive.google.com/file/d/1x7u4JfyeL8WhetacBsPDVXm48SvVJUo7/view=
?usp=3Dsharing
> > and https://drive.google.com/file/d/1U3ei_jCODG9N5UHOspSRmykrEDSey3Qn/v=
iew?usp=3Dsharing),
> > no fault-injection log was printed before the task hang.
>
> OK, then it seems like a big problem.
>
> Any workload log from the fuzzer so we can try to reproduce?
>
> Or just using the tool?
>

Execution history:
https://drive.google.com/file/d/1yq_hKNHBbOh8NU_ZRNFYjP9NmnRv0RPL/view?usp=
=3Dsharing

The above is the execution history with the latest 1024 progs saved
before the task hang happened.
However, it is always hard to get useful information from that and
also hard for fuzzer to reproduce the `task hang`.
I'll keep track of this bug and send you the reproducer program once
Healer found it.

Regards
Hao
