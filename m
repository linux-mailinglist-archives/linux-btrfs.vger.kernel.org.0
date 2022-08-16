Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C045960F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 19:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiHPRVw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 13:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbiHPRVv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 13:21:51 -0400
Received: from rin.romanrm.net (rin.romanrm.net [51.158.148.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101FB74E1A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 10:21:49 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id AEA803A0;
        Tue, 16 Aug 2022 17:21:46 +0000 (UTC)
Date:   Tue, 16 Aug 2022 22:21:45 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     J <j@livingrock.ca>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Support Question: ERROR: cannot read chunk root ERROR: cannot
 open file system
Message-ID: <20220816222145.5992dc8d@nvm>
In-Reply-To: <3b28d4fcb0eff4560993841781b1a20f@livingrock.ca>
References: <3b28d4fcb0eff4560993841781b1a20f@livingrock.ca>
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

Hello,

On Tue, 16 Aug 2022 07:42:19 -0400
J <j@livingrock.ca> wrote:

> I'm wondering if there's any suggestions anyone has to at least read the 
> rest of my data [the stuff I didn't copy off before rebooting]?

There is "btrfs restore" for that, to salvage any data from an offline
filesystem without trying to mount.

-- 
With respect,
Roman
