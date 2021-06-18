Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AE53AD144
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 19:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbhFRRjH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 13:39:07 -0400
Received: from rin.romanrm.net ([51.158.148.128]:51158 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232482AbhFRRjE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 13:39:04 -0400
Received: from natsu (natsu2.home.romanrm.net [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 51C6F69D;
        Fri, 18 Jun 2021 17:36:53 +0000 (UTC)
Date:   Fri, 18 Jun 2021 22:36:52 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Martin Raiber <martin@urbackup.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: IO failure without other (device) error
Message-ID: <20210618223652.4b701f9e@natsu>
In-Reply-To: <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
References: <010201795331ffe5-6933accd-b72f-45f0-be86-c2832b6fe306-000000@eu-west-1.amazonses.com>
        <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 18 Jun 2021 16:18:40 +0000
Martin Raiber <martin@urbackup.org> wrote:

> On 10.05.2021 00:14 Martin Raiber wrote:
> the question is how can I trace where this error comes from... The error message points at btrfs_csum_file_blocks but nothing beyond that

Not entirely nothing, in theory the number afterwards is the line number of
source code (of btrfs/inode.c in this case) where the error occurred. But need
to check your specific patched sources, as if you patch Btrfs code the number
won't match with the mainline.

-- 
With respect,
Roman
