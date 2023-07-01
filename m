Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5491744ACC
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jul 2023 20:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjGASNc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jul 2023 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGASNb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Jul 2023 14:13:31 -0400
Received: from len.romanrm.net (len.romanrm.net [91.121.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943EA1BC6
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jul 2023 11:13:29 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id E255B401AC;
        Sat,  1 Jul 2023 18:13:26 +0000 (UTC)
Date:   Sat, 1 Jul 2023 23:13:26 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     yeslow <yeslow@proton.me>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Can't mount RAID-0 btrfs volume
Message-ID: <20230701231326.632852b4@nvm>
In-Reply-To: <XbRHcnOusT9SgtIvEblFkrC43giGNCYfguS2_xjdCfx_NpoVzC4tHpV1hm-PF9_oxpVtM2j2imSl_1sEm3eYQRMFZy5ovi--vMQNkrab65o=@proton.me>
References: <XbRHcnOusT9SgtIvEblFkrC43giGNCYfguS2_xjdCfx_NpoVzC4tHpV1hm-PF9_oxpVtM2j2imSl_1sEm3eYQRMFZy5ovi--vMQNkrab65o=@proton.me>
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

On Sat, 01 Jul 2023 14:59:11 +0000
yeslow <yeslow@proton.me> wrote:

> I have a dual boot system with Windows 10 Pro and Linux Kubuntu 22.04.
> 
> I have created a btrfs raid-0 volume in my Linux system with 2 SSD drives to
> store not very important files, where the speed is most important. I then
> use winbtrfs in the Windows 10 system to be able to access the btrfs volume,
> when using Windows 10.
> 
> Everything worked fine for several months until recently. I deleted some
> files on the btrfs volume in Windows 10, which always worked fine, but this
> time I noticed that after the file deletion the volume in Linux was not
> showing the expected free space. When trying to have this fixed, I decided
> to give it a try by using the command: btrfs check --clear-space-cache v2

Could it be that instead of shutting down, you hibernated Windows 10 that time?

As for the recovery options, look into "btrfs restore", that could fetch files
from a damaged filesystem without trying to mount. If it's not damaged too
hard.

-- 
With respect,
Roman
