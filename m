Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC5165B858
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 01:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjACAMl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 19:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjACAMk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 19:12:40 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAF221B8
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Jan 2023 16:12:37 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id u19so69789843ejm.8
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jan 2023 16:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t57XbP7Edv3xglGPYZVWWIsegWtCnTEiFLvCTavWSY8=;
        b=Bec7Jr/d3Ziq2j+Cn+8koxt+m2zesHPRFyXW7Z+6lwtaveEx5JK3/pL/eVg2s+2RmJ
         kcbCPMUy8aUNX1+ZLqaQ4LrbSEtq+wSgr/HXQ0gbK9ky7vXFtvV2pNR5Xfjh2eiBZoMe
         41TfFIvL0w0Wvl+73v3iJZ2lpNzCbdzL1hdgdeKnMQZWsv84mJx1FHoNTpzr72vyGS4f
         y34qmzEwhZgpOr9VxXUEk6tDi1qZ0w4AdT/yhGZ5t1ywf9SbnykzfgPzIoxo0+ErhSHQ
         quZhyd3NC135Veyce0bZqmchefa8cV98W47GIgtQ/rhKskHWvwy+92Vhe2BS8hT+ieeF
         QKXA==
X-Gm-Message-State: AFqh2kp/htdzv6zOsVbW7LIt8cAZwo9hMHExaGCHlnvD6fSB4n+gSmMB
        yyAk2YY49zGNH+QmJ3MzA42hAwodVWNBxg==
X-Google-Smtp-Source: AMrXdXuQiKjoxxUGaHo0Czuc+vekt+sw4XPXExK40fVtn34/kFCudai96tZoEC5mvyD2pTZM0q+d/w==
X-Received: by 2002:a17:907:b9d5:b0:81e:8dd4:51c3 with SMTP id xa21-20020a170907b9d500b0081e8dd451c3mr36165120ejc.76.1672704755291;
        Mon, 02 Jan 2023 16:12:35 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b007bd0bb6423csm13392183eje.199.2023.01.02.16.12.34
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 16:12:34 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id b88so34489180edf.6
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jan 2023 16:12:34 -0800 (PST)
X-Received: by 2002:a05:6402:5025:b0:46b:d84f:81d5 with SMTP id
 p37-20020a056402502500b0046bd84f81d5mr5053567eda.427.1672704753955; Mon, 02
 Jan 2023 16:12:33 -0800 (PST)
MIME-Version: 1.0
From:   Neal Gompa <ngompa@fedoraproject.org>
Date:   Mon, 2 Jan 2023 19:11:57 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8L7jieKdoWoZBuBZ6RdXwvwrx04AB0fOZF1fr5Pb-o1g@mail.gmail.com>
Message-ID: <CAEg-Je8L7jieKdoWoZBuBZ6RdXwvwrx04AB0fOZF1fr5Pb-o1g@mail.gmail.com>
Subject: btrfs-progs 6.1 broke the build for multiple applications
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey all,

It looks like btrfs-progs v6.1 broke the build for multiple
applications in Fedora.

Notably, it broke:

* btrfs-assistant
* buildah
* cri-o
* podman
* skopeo
* containerd
* moby/docker
* snapper
* source-to-image

The bug report is here: https://bugzilla.redhat.com/2157606

It looks like this change broke everything:
https://github.com/kdave/btrfs-progs/commit/03451430de7cd2fad18b0f01745545758bc975a5


-- 
Neal Gompa (FAS: ngompa)
