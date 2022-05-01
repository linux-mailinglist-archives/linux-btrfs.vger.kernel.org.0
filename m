Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8415161DE
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 07:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiEAFJG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 01:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiEAFJE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 01:09:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB7926562
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 22:05:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so20401653lfg.7
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 22:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o0dtv13GKMv5T0kPnmslsI8L0P7rz3WO3FBZ4f3Pjk0=;
        b=la31/hR36Pv0uIF5mboRxntIrqRKIxlwoKp8/6k7/Dzqakx7ckSIPt1E+a7OxmEHZQ
         UcSEK97tUcX9u7FLYkmZVYE3Ntep/oykSUAI6KzCou+Yz3vGETAL6d4b1RpbTJ767jan
         htJFliVFUFO2HLxCps59w86bxHPx8peqo71WG2rV28gH6OkdsABr8PGDiIprMo/6G1aC
         MHzXPtSCwaARvWCQdeC3XDKlg4Z9OdnWPv6N8qvLwWRNej3rQ54MiAuMHAw1eDzl9W2N
         MZmqiZAbMayWwfAiMWo4ObU0UaQURwv2OQh1D5rN586RcpXGUyHLbRESGjqGZGlMwPN/
         fzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o0dtv13GKMv5T0kPnmslsI8L0P7rz3WO3FBZ4f3Pjk0=;
        b=I6pjUqa6L87kVzlH2MxwDvv+f1WbOjrVUvvSCrPirlrq2rIKWVjti7StAPYnTfoEFv
         dTS1kHF1maUBImWtX+wkYuhMqCvTVr7xElfAjoUw3uudqo1eIW30Gz64xghTtY+lG3sI
         dmF2xts2+MkqkdFFtXqaVQ9DNV+3/Sezms2sMrYxEImHvQaXClTzGSaVSfkj4p+D2vLK
         9dF1PB9zFgCIQX4Y5Gf4o1EieohNyWbZFtzdKgDORlSgChN4/QAZR/bVTaR9CAF2Bz6D
         dakmYAt65KQRXjkx4fnL/mT+p4RIJc3Q3+vIKcezdCfPkKgG5Eq5iNQH2vrDQ2CR0cso
         824g==
X-Gm-Message-State: AOAM533G/cWXShaXXSGEY3MQceOjhUtXRBoLulYD2dcfisI/KKTHHOVT
        L7wCQTyqhRBGWkKpDNliPrb2eLzZlwe2X/+zfhLTbQ==
X-Google-Smtp-Source: ABdhPJwW84BEu2IekdFMVa9WTuCK/4LBvr4ZGFADe5cydMYKK8jIgEYSFc8U0Yp6uceRmCSoKxdMea7XecruV8S8OzE=
X-Received: by 2002:a05:6512:2601:b0:464:f8ca:979a with SMTP id
 bt1-20020a056512260100b00464f8ca979amr5292512lfb.84.1651381538123; Sat, 30
 Apr 2022 22:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <87238001-69C5-4FA8-BE83-C35338BC8C81@gmail.com>
In-Reply-To: <87238001-69C5-4FA8-BE83-C35338BC8C81@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 1 May 2022 01:05:21 -0400
Message-ID: <CAJCQCtS+-+VgLUgvrkVn7k=eGqJXYerY0bDW3xxxqHRF9kMitA@mail.gmail.com>
Subject: Re: How to convert a directory to a subvolume
To:     John Center <jlcenter15@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 30, 2022 at 4:09 PM John Center <jlcenter15@gmail.com> wrote:
>
> Hi,
>
> I just installed Ubuntu 22.04 with a btrfs raid1 root filesystem.  I want=
 to convert a directory, like /opt, into a subvolume. I haven=E2=80=99t bee=
n having much luck.  /opt is empty right now, so it=E2=80=99s a good candid=
ate for conversion.  Could someone please explain how to do it?  I=E2=80=99=
ve been at a dozen different websites, & tried different variations of the =
=E2=80=9Cbtrfs subvolume create=E2=80=9D command, but nothing works when I =
go to mount it.  I think I=E2=80=99m missing something simple, but not sure=
 what it is.

https://btrfs.wiki.kernel.org/index.php/SysadminGuide#Nested

If you're using the nested layout, you won't need to use /etc/fstab.
When using the flat layout, subvolumes are mounted into position using
fstab.

--=20
Chris Murphy
