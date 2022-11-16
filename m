Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DEA62CE16
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 23:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiKPWzB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 16 Nov 2022 17:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiKPWzB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 17:55:01 -0500
Received: from mail.cardoe.co.uk (cardoe.plus.com [81.174.243.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C953A663D2
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 14:54:58 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.cardoe.co.uk (Postfix) with ESMTP id 1061156004A
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 22:54:57 +0000 (GMT)
Received: from mail.cardoe.co.uk ([127.0.0.1])
        by localhost (mail.cardoe.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l_7AzETh1iWO for <linux-btrfs@vger.kernel.org>;
        Wed, 16 Nov 2022 22:54:55 +0000 (GMT)
Received: from smtpclient.apple (cardoe.plus.com [81.174.243.101])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.cardoe.co.uk (Postfix) with ESMTPSA id E045C560006
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 22:54:54 +0000 (GMT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Peter Cardoe <peter@cardoe.co.uk>
Mime-Version: 1.0 (1.0)
Subject: Re: root item with a more recent gen
Date:   Wed, 16 Nov 2022 22:54:54 +0000
Message-Id: <16C8B1A2-2500-44C2-ABB4-DE65D37ED838@cardoe.co.uk>
References: <119134c3dcaec15277b5850fc4ccb630.squirrel@mail.cardoe.co.uk>
In-Reply-To: <119134c3dcaec15277b5850fc4ccb630.squirrel@mail.cardoe.co.uk>
To:     linux-btrfs@vger.kernel.org
X-Mailer: iPhone Mail (19H12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Should I be asking these questions on this mailing list or somewhere else, please?

> On 16 Nov 2022, at 10:47, Peter Cardoe <peter@cardoe.co.uk> wrote:
> 
> ﻿Hello,
> Please can someone tell me
> (1) how to display the root item in question
> (2) how to display the found root node in question
> (3) if there a utility for patching the error back to what it should be?
> 
> Thanks very much,
> Peter.
> ---------------------------- Original Message ----------------------------
> Subject: root item with a more recent gen
> From:    "Peter Cardoe" <peter@cardoe.co.uk>
> Date:    Sun, November 13, 2022 3:59 pm
> To:      linux-btrfs@vger.kernel.org
> --------------------------------------------------------------------------
> 
> 
> 
> How can I fix the following error please:
> 
> btrfs check -b --repair /dev/sdb2
> 
> enabling repair mode
> 
> WARNING:
> 
> Do not use --repair unless you are advised to do so by a developer
> 
> or an experienced user, and then only after having accepted that no
> 
> fsck can successfully repair all types of filesystem corruption. Eg.
> 
> some software or hardware bugs can fatally damage a volume.
> 
> The operation will start in 10 seconds.
> 
> Use Ctrl-C to stop it.
> 
> 10 9 8 7 6 5 4 3 2 1
> 
> Starting repair.
> 
> Opening filesystem to check...
> 
> Checking filesystem on /dev/sdb2
> 
> UUID: b5e07514-ad87-47ac-b4f7-3d797cb689bd
> 
> [1/7] checking root items
> 
> root 258 has a root item with a more recent gen (118911) compared to the
> found root node (118707)
> 
> ERROR: failed to repair root items: Invalid argument
> 
> 
