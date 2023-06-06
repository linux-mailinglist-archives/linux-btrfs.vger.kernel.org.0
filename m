Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51301724B57
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 20:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjFFS02 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 14:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbjFFS01 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 14:26:27 -0400
Received: from len.romanrm.net (len.romanrm.net [91.121.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1EC171B
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 11:26:03 -0700 (PDT)
Received: from nvm (nvm.home.romanrm.net [IPv6:fd39::101])
        by len.romanrm.net (Postfix) with SMTP id 045E640176;
        Tue,  6 Jun 2023 18:25:58 +0000 (UTC)
Date:   Tue, 6 Jun 2023 23:25:58 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        wqu@suse.com
Subject: Re: How to find/reclaim missing space in volume
Message-ID: <20230606232558.00583826@nvm>
In-Reply-To: <20230606164139.GK105809@merlins.org>
References: <20230605162636.GE105809@merlins.org>
        <9bfa8bb6-b64e-d34f-f9c8-db5f9510fc29@gmail.com>
        <20230606014636.GG105809@merlins.org>
        <295ce1bb-bcd7-ebdf-96b2-230cfeff5871@gmail.com>
        <20230606164139.GK105809@merlins.org>
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

On Tue, 6 Jun 2023 09:41:39 -0700
Marc MERLIN <marc@merlins.org> wrote:

> This sounds like it could be the same, thanks.
> 
> I started with
> sauron:/mnt/btrfs_pool2# btrfs subvolume sync `pwd`
> 
> Unfortunately it's been stuck overnight.

So it does not look the same after all.

Do you see a lot of IO to the device (iostat, iotop)? Is it a fast/slow one?

Anything in dmesg?

-- 
With respect,
Roman
