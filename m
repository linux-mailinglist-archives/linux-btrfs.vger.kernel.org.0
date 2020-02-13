Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A810615B989
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 07:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgBMGVM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 01:21:12 -0500
Received: from len.romanrm.net ([91.121.86.59]:49850 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgBMGVM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 01:21:12 -0500
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 785AB40394;
        Thu, 13 Feb 2020 06:21:10 +0000 (UTC)
Date:   Thu, 13 Feb 2020 11:21:10 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 5.6-rc1, fstrim reports different value 1 minute later
Message-ID: <20200213112110.7100baf2@natsu>
In-Reply-To: <CAJCQCtS9Te9gRAGwin_Wjqv_3cJXVXthNa1g53zF4PbZW+k0Qg@mail.gmail.com>
References: <CAJCQCtS9Te9gRAGwin_Wjqv_3cJXVXthNa1g53zF4PbZW+k0Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 12 Feb 2020 23:08:03 -0700
Chris Murphy <lists@colorremedies.com> wrote:

> Host: kernel 5.5.3, qemu-kvm, Btrfs, backing file is raw with +C  5.6.
> Guest: kernel 5.6.0-rc1, / is Btrfs
> 
> Boot and login, and immediately run these commands:
> 
> [root@localhost ~]# df -h
> /dev/vda4        96G  4.4G   91G   5% /
> # fstrim -v /
> /: 91 GiB (97633062912 bytes) trimmed
> 
> 1 minute later
> 
> [root@localhost ~]# fstrim -v /
> /: 3.5 GiB (3747549184 bytes) trimmed
> [root@localhost ~]#
> 
> There's no activity happening in this one minute period. Reboot, and
> it's reproducible again. 91G trimmed the first time then 3.5G the
> second. Seems like new and unusual behavior. No kernel messages at all
> in either host or guest.

For completeness, what would be returned the 3rd time you trim?

-- 
With respect,
Roman
