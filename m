Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADF546DAD9
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 19:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbhLHSTJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 13:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238740AbhLHSTJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Dec 2021 13:19:09 -0500
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EAFC061746
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Dec 2021 10:15:36 -0800 (PST)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id D4A22616;
        Wed,  8 Dec 2021 18:15:32 +0000 (UTC)
Date:   Wed, 8 Dec 2021 23:15:31 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Rory Campbell-Lange <rory@campbell-lange.net>,
        linux-btrfs@vger.kernel.org
Subject: Re: trouble replacing second disk from pair
Message-ID: <20211208231531.27379888@nvm>
In-Reply-To: <20211208180140.GN17148@hungrycats.org>
References: <YbCnrqxHJxYPATj9@campbell-lange.net>
        <20211208180955.170c6138@nvm>
        <YbDpr5mlHhGhHGwd@campbell-lange.net>
        <20211208180140.GN17148@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 8 Dec 2021 13:01:40 -0500
Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:

> -m implies -s.  In normal use, there is never a reason to have different
> profiles for metadata and system

Then there appears to be no reason to have "system" user-visible as a separate
chunk type.

-- 
With respect,
Roman
