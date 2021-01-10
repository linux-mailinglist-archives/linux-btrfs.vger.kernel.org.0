Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C70B2F06B0
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 12:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbhAJLhr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 10 Jan 2021 06:37:47 -0500
Received: from rin.romanrm.net ([51.158.148.128]:35484 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbhAJLhr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 06:37:47 -0500
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 48E76860;
        Sun, 10 Jan 2021 11:37:05 +0000 (UTC)
Date:   Sun, 10 Jan 2021 16:37:05 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     " " <Cedric.dewijs@eclipso.eu>
Cc:     <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs send / receive via netcat, fails halfway?
Message-ID: <20210110163705.1852c4a7@natsu>
In-Reply-To: <0440549b7c78763ce787b03341ca5b9f@mail.eclipso.de>
References: <0440549b7c78763ce787b03341ca5b9f@mail.eclipso.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, 10 Jan 2021 11:34:27 +0100
" " <Cedric.dewijs@eclipso.eu> wrote:

> ­I'm trying to transfer a btrfs snapshot via the network.
> 
> First attempt: Both NC programs don't exit after the transfer is complete. When I ctrl-C the sending side, the receiving side exits OK.

It is a common annoyance that NC doesn't exit in such scenario and needs to be
Ctrl-C'ed after verifying that the transfer is over.

Instead, at host2 try:

  ssh host1 "btrfs send ..." | btrfs receive ...

Also much more secure.

-- 
With respect,
Roman
