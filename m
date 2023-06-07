Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3051E726E4B
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 22:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjFGUt2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 16:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbjFGUtE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 16:49:04 -0400
Received: from len.romanrm.net (len.romanrm.net [91.121.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B418A26AA
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 13:48:40 -0700 (PDT)
Received: from nvm (nvm.home.romanrm.net [IPv6:fd39::101])
        by len.romanrm.net (Postfix) with SMTP id 9521240069;
        Wed,  7 Jun 2023 20:48:02 +0000 (UTC)
Date:   Thu, 8 Jun 2023 01:48:02 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
Cc:     "remi@georgianit.com" <remi@georgianit.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: rollback to a snapshot
Message-ID: <20230608014802.1dce81a0@nvm>
In-Reply-To: <PR3PR04MB7340C53376C738E6DDEA39B2D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
        <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
        <PR3PR04MB734090961ACE766466980F04D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
        <8c9b136c-c992-8c0e-a1e6-0e8aec1e89cd@gmail.com>
        <PR3PR04MB7340CB95E5AB4FC10706604DD653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
        <d708df28-a0fc-411b-97a0-7d2bea2f5f72@app.fastmail.com>
        <PR3PR04MB7340C53376C738E6DDEA39B2D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
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

On Wed, 7 Jun 2023 20:14:27 +0000
Bernd Lentes <bernd.lentes@helmholtz-muenchen.de> wrote:

> I didn't know "--reflink". The help says:
> " When --reflink[=always] is specified, perform a lightweight copy, where the
> data blocks are copied only when modified.  If this is not possible the copy
> fails, or if --reflink=auto is specified, fall back to a standard copy.
> Use --reflink=never to ensure a standard copy is performed.".
> 
> Is that independent from the fs ? That seems to be a kind of a snapshot.
> Am i right ?

Not all filesystems support reflinks.

Btrfs and XFS support it, but for XFS this has to be enabled at FS creation
time (IIRC recent mkfs enables it by default). Ext4, ReiserFS and JFS do not.

For XFS it is a way to have the best of the both worlds: have a filesystem
that is well regarded for performance, but also gain a degree of the CoW
ability that Btrfs is liked for, e.g. allowing instant snapshots of VM images,
including running ones with a point-in-time full image consistency --
unthinkable with traditional copying.

-- 
With respect,
Roman
