Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3D34435EC
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 19:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhKBSrk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 14:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhKBSrj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 14:47:39 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0D1C061203
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Nov 2021 11:45:04 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id a129so572313yba.10
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Nov 2021 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=dpVkovntqs1NXffCxTfwsYEnEoLBHSIkxuy6EGdjGIA=;
        b=c0V1sI53cH1HzyYwPwHTYnAUFUBpp/nvFjgysivKRA53SNSvXIzQIapygpm3nA/IqQ
         oTpWETQkxBkFHFcopjVdnoHZOoHG0TY5eEpw1m4CbFUQCXGKd9jBO78/TFsmj01jn+Ig
         UPD6C01qy7UB+4wIDdZqQfUzspEFgO5KTtgNShMj4KgWWED6puyZkcOR67eOvoxzXFR6
         6Azob38R2rpflU75Jc11zZ8svs3hzsGEaHjqL4irpvQKhAnH9Ej4r0ZofAfoU73++w0J
         6KXJz/pOES93ph8Fh8Ve3KkVtRCY2gy9aKTdwBnUKXmNkLqygak62BgJA9RKBFZ8NpST
         APzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dpVkovntqs1NXffCxTfwsYEnEoLBHSIkxuy6EGdjGIA=;
        b=WolEG3Pta/q9tgjTckKCSRkfhq9ttxXoOKGc6i5kNnxaaBOhMwdA4gVAGsfhajYBdI
         5rxUjr9okd1FEDwgibaCezdSz3XFwns1FaqLuyfPS9bmEggwfXMmLbr5sLKpPoUy5cEx
         lnXRy4LeTfc4W+hnNDZqyPyD7cNRRRIh1wmdAUTw+s24rKU96xpeEXYQ8/OCHeaxuA4J
         k8JXyfMSO+tkvHvHpJcE/3L6d3CZDMFPwRWoCC4z90bdOJw9xIkjC6Sl7qU+xCzCDAfX
         fbAy2TAXdvZ5zJ9kO9nKPnfnhj05cmGVa/tjP9nhNeHPaR4ltQRY1hysKfM/sPFTkcF2
         jLfw==
X-Gm-Message-State: AOAM530S3z9C/8FSK1MkLdiKaV4bhIGRpTLTbblKbPVjlJMTiPQmiJjR
        Q3u1fApOiXbeUJaXx4bOQU9aKtMUSRShdjuW5j3hq2EZ9yO3VNaWooE=
X-Google-Smtp-Source: ABdhPJyFpN0iKk7kRjzvrbZmoIlF2uGFGC/g+mNldD6viU2eyDuAfQcaXHH+XxmgEsIU1PDPhKc7ljPXGBaP0O0IYXo=
X-Received: by 2002:a25:d9c9:: with SMTP id q192mr30288975ybg.470.1635878703632;
 Tue, 02 Nov 2021 11:45:03 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 2 Nov 2021 14:44:48 -0400
Message-ID: <CAJCQCtS7YqzmWGta7uCAv-cOMuhiFG1M-idrO4_VotWi_Tpu7g@mail.gmail.com>
Subject: Moby/Docker gradually exhausts disk space on BTRFS
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Docker gradually exhausts disk space on BTRFS #27653
https://github.com/moby/moby/issues/27653

This bug goes back to 2016 and could really use some attention to
figure out what's going on. I'm not sure even whose bug it is. It
could be docker itself, or the btrfs "graph" driver that docker uses,
or if it's a (btrfs) kernel bug.

It could be there's more than one bug.


-- 
Chris Murphy
