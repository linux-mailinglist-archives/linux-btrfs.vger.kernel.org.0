Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA632B3349
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Nov 2020 11:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgKOKBb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 15 Nov 2020 05:01:31 -0500
Received: from rin.romanrm.net ([51.158.148.128]:47444 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgKOKBa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Nov 2020 05:01:30 -0500
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2020 05:01:30 EST
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id E5AEC28B;
        Sun, 15 Nov 2020 09:53:23 +0000 (UTC)
Date:   Sun, 15 Nov 2020 14:53:23 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Lawrence D'Anna <larry@elder-gods.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Meghan Gwyer <mgwyer@gmail.com>
Subject: Re: bizare bug in "btrfs subvolume show"
Message-ID: <20201115145323.1628d710@natsu>
In-Reply-To: <8EFE06A3-9CC4-4A6A-850F-C7C57DC27942@elder-gods.org>
References: <61E331A6-9DA8-4A7C-905E-4B5A17526020@elder-gods.org>
        <8EFE06A3-9CC4-4A6A-850F-C7C57DC27942@elder-gods.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 14 Nov 2020 13:35:43 -0800
Lawrence D'Anna <larry@elder-gods.org> wrote:

> > On Nov 13, 2020, at 9:47 PM, Lawrence D'Anna <larry@elder-gods.org> wrote:
> > 
> > 
> > But I haven’t been able to track down how redirecting the standard out is possibly influencing this.
> 
> I have narrowed it down a little bit further.
> 
> cmd_subvol_show uses btrfs_util_subvolume_iterator_next_info to find all the snapshots of the 
> subvol it’s showing.
> 
> while it’s performing this iteration, subvolume_iterator_next_tree_search returns a subvolume id 
> of 7168, which does not appear in my filesystem according to "btrfs subvol list”

This still sounds very puzzling, as to how output redirection could affect
things. Perhaps you could run "btrfs sub show" with "strace"? Both with and
without the redirect to see exactly what was the call sequence, parameters and
return values, to compare and find where the difference starts.

-- 
With respect,
Roman
