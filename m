Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE05E4DE760
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Mar 2022 10:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbiCSKBI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Mar 2022 06:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbiCSKBI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Mar 2022 06:01:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3C91A6365
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Mar 2022 02:59:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k21so1042906lfe.4
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Mar 2022 02:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=+u3eDSpVEHfi5Vjnao6D2d6kxlC4QCzMwuebH1x5JOI=;
        b=MSU8S4EfrgQZbpBPVzoMoL3ABBfbTbbWXzauJ30ymNOEy4mo2ALdRAmuZcUAatcjXj
         qe1CYveSzM4YMj+gOYIb1OWE1vslmEvE4Oo63jzmyhyZ8Axv3Q0nBCmR6DCactiHP2pM
         sr/ZVWGqOgfiFZfzGgpILryjdJlg6LsP6X9TYzjSSnUsu5B6fWSCOUSB0MSG3LJkG0kv
         fVhHcWx/8fvoly5wkEA1n/RceXReNL60p8MPMahg7+sm9NoUMjs5T9kTH05DlQicLkSv
         lyRBX+RkqLirmYg1mdOIffMM06uhO4uOt1v/tjDpk5veSDEjJ3Ej/lGgdQOZLvPtxRME
         /58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=+u3eDSpVEHfi5Vjnao6D2d6kxlC4QCzMwuebH1x5JOI=;
        b=vGIOaNtTJ4E6J75MJKI2Ugyv3rnAy6ZrK8PEUKMaF0oVbHR+j0obyqpchNAqZ67Qcf
         YggPD1VmX5H5MxarQ3Grr7mh1oV5ssUjwdFkx5dP35/aKgnpVcVkG9BfAyOqxAl/fop/
         bqshEW/87OKU2zCqpTW6jw5Gbmr0fLrFzJ4gIW+XxcZlUOprhY/bRP4Goa2N6GyjAvq/
         rdxAwMh8S8pu50OtCNuH/ni6PFu4sOTJ042hHM2NtvATILufanMHFoOJlnUd79SMB74Z
         I1bvEWlBQ/xvuhLDFOof8j9ReDqu+SWowSEWhXkY/dhEOu16ipPyVTxoBwocKX/bgpEG
         3MKQ==
X-Gm-Message-State: AOAM530bgvdJNQWryZO5acRJastBGs/Uu3DHACIVSf/wz0ktdODlLio0
        QITIlI7nbVsse79k3oA8VtkxyAg/oz4PaPgm9V8=
X-Google-Smtp-Source: ABdhPJwEDu7LuvgqDMao/keAl2AEwJDzL7ry6Xq13wL2ZjcSDhK0YnuAb6seir8sznKgJZvG8vUcIST1f63290eqqYY=
X-Received: by 2002:ac2:5fc8:0:b0:445:a43e:3526 with SMTP id
 q8-20020ac25fc8000000b00445a43e3526mr8240683lfg.39.1647683982790; Sat, 19 Mar
 2022 02:59:42 -0700 (PDT)
MIME-Version: 1.0
Sender: mrssuzaramalingwan2@gmail.com
Received: by 2002:a05:6500:b83:b0:132:eb07:805f with HTTP; Sat, 19 Mar 2022
 02:59:41 -0700 (PDT)
From:   AZIZAT ABIATU KASIMU <kazizatabiatu@gmail.com>
Date:   Sat, 19 Mar 2022 02:59:41 -0700
X-Google-Sender-Auth: afUP5UHwAN8EtK97RVggqF9qvDo
Message-ID: <CAGa6i3jrP88Pn1_tmUF8usiwY1LdNr0wvLm2dZzTyPL6Z0vfug@mail.gmail.com>
Subject: compensation
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

hello....
this is to inform you that you have be   compensated with the sum of
1.2 million dollars in your pass effort,and  the payment will be issue
into ATM visa  card and send to you from the UBA BANK we need your
address and your Whats App number

Thanks
Mrs AZIZAT ABIATU KASIMU
