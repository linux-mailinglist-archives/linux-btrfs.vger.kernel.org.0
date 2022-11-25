Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9446385BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Nov 2022 09:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiKYI7R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Nov 2022 03:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiKYI7O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Nov 2022 03:59:14 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A6D31EE7
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 00:59:13 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j4so5937351lfk.0
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Nov 2022 00:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKV3GqnxD1IMwqw6YZF2jv4r5w9ouhmjGqcLR9h8414=;
        b=AkNflK2hvGpl9mRYb5mvj54ERX5K+wUh1Ogq0khQA5uSIcs0U//cGKudOl/E/ug8Ss
         FSFH0T4ifyVlS7q8O+kjaLnKeT6L8Vpvs8UAjv9mYS6p41nuZFmd7dh5VdRs/Ym0yy9c
         qmXWlCYDsmrTXhp1puJ1daul05iZsRcjun7f1nG/rfkN6i7vKlO5CCf3UbGBYXDZCQJ+
         RG8KwxqkiiDKRDl+pG6mYMe6Etj/7q0zFFB5HV7/8YU4fEl3YXdU87EdtPqxwkzPHtj3
         swpdVBLF0rFLe6lBLVNPhJQn+irXqP2lz1NwgKCKtsrSR/ayhIo70DhLux9CBFfrUtel
         Fd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKV3GqnxD1IMwqw6YZF2jv4r5w9ouhmjGqcLR9h8414=;
        b=6PpaxAVInMdoAD2hGi3Ttm7FXCGfJFuslXHvsC8cYA7dngWOaCUCOObxaTkrqBjR68
         ihxoCNcJq7qPA5WK+IITlAJnkmhf8GtaKudexxaiUC+THsRVYh/mdvikrRuwIIJFnjjR
         W2+MIPYhon51rpR/Tmenfk4fsaqhejfK/r981fkvvSE8L8O0yHluKudimz8iu2P8zvio
         3D7FYr/Xo9zp/TdXmfNNJUSyB/1dNnOB+B7b+87E/J041p25RyDH11cfljTvsrqm85d/
         +QJDe0sQy6g8oapLmUGYwkW/bu9WewM/ih6MzrPY0bDke0yMSSj1B1KoF66V7bIMbZWO
         Kwog==
X-Gm-Message-State: ANoB5pkt8G/hY00YkkhnyEXmkhTs6hUdbV+4Pjx1bqMlRpSsrPIT23be
        lGEgPq459iqDtuDx1SA1zrVAV/8gavY=
X-Google-Smtp-Source: AA0mqf7R2mUIQb2wvtiUGqfzxQs16JvS7wyiqRUwFZOIMG+17KjPKMBvHn56jKKA89/dQyBQt3QfjQ==
X-Received: by 2002:a05:6512:20c3:b0:4a2:776f:f3c6 with SMTP id u3-20020a05651220c300b004a2776ff3c6mr11546637lfr.302.1669366751199;
        Fri, 25 Nov 2022 00:59:11 -0800 (PST)
Received: from localhost.localdomain (fw.storegate.se. [194.17.41.68])
        by smtp.gmail.com with ESMTPSA id k8-20020a2eb748000000b0026e04cc88cfsm303093ljo.124.2022.11.25.00.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 00:59:10 -0800 (PST)
From:   Joakim <ahoj79@gmail.com>
To:     forza@tnonline.net
Cc:     ahoj79@gmail.com, linux-btrfs@vger.kernel.org
Subject: Re: Speed up mount time?
Date:   Fri, 25 Nov 2022 09:58:57 +0100
Message-Id: <20221125085857.304-1-ahoj79@gmail.com>
X-Mailer: git-send-email 2.38.1.windows.1
In-Reply-To: <aff65aa.d623d93e.184a68f2476@tnonline.net>
References: <aff65aa.d623d93e.184a68f2476@tnonline.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yes, thanks! Metadata defrag finished an hour ago. But time to mount is sti=
ll: 31m6.720s.=0D
I guess I'll just have to wait for the new kernel.=
