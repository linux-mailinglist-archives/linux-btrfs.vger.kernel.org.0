Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7D455A130
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 20:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiFXShg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiFXSh3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 14:37:29 -0400
Received: from rin.romanrm.net (rin.romanrm.net [51.158.148.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7D281504
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 11:37:25 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id DB1F65C1;
        Fri, 24 Jun 2022 18:37:23 +0000 (UTC)
Date:   Fri, 24 Jun 2022 23:37:22 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Forza <forza@tnonline.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: FSTRIM timeout/errors on WD RED SA500 NAS SSD
Message-ID: <20220624233722.05038e48@nvm>
In-Reply-To: <98c43f5e-2091-b222-edad-632caef9f9e3@tnonline.net>
References: <98c43f5e-2091-b222-edad-632caef9f9e3@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 24 Jun 2022 17:23:27 +0200
Forza <forza@tnonline.net> wrote:

> Can we work around the Btrfs fstrim issue, for example by splitting up 
> fstrim requests in "discard_max_bytes" sized chunks?

If I'm not mistaken, those discard_max_* are honoured automatically by a lower
level than the submitting filesystem (i.e. the block layer).

It seems like the linux-ide list (or is it linux-scsi for SAS?) could be better
suited to hunt down this issue. Especially if aside from Btrfs even just a
simple blkdiscard also shows trouble.

Btw, did you try lowering discard_max_bytes in sysfs, and then retrying
blkdiscard?

-- 
With respect,
Roman
