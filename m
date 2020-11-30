Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A5D2C8632
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 15:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgK3OIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 09:08:47 -0500
Received: from rin.romanrm.net ([51.158.148.128]:46068 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgK3OIr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 09:08:47 -0500
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id BFEF686E;
        Mon, 30 Nov 2020 14:08:05 +0000 (UTC)
Date:   Mon, 30 Nov 2020 19:08:05 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not allow -o compress-force to override
 per-inode settings
Message-ID: <20201130190805.48779810@natsu>
In-Reply-To: <a3cd057e747862eb7027ac6318bd26c6c36e0c49.1606743972.git.josef@toxicpanda.com>
References: <a3cd057e747862eb7027ac6318bd26c6c36e0c49.1606743972.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 30 Nov 2020 08:46:21 -0500
Josef Bacik <josef@toxicpanda.com> wrote:

> However some time later we got chattr -c, which is a user way of
> indicating that the file shouldn't be compressed.  This is at odds with
> -o compress-force.  We should be honoring what the user wants, which is
> to disable compression.

But chattr -c only removes the previously set chattr +c. There's no
"negative-c" to be forced by user in attributes. And +c is already unset on all
files by default. Unless I'm missing something? Thanks

-- 
With respect,
Roman
