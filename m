Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF51199D1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgCaRmc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 13:42:32 -0400
Received: from len.romanrm.net ([91.121.86.59]:34412 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgCaRmb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 13:42:31 -0400
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id CBB8640044;
        Tue, 31 Mar 2020 17:42:29 +0000 (UTC)
Date:   Tue, 31 Mar 2020 22:42:29 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Eli V <eliventer@gmail.com>
Cc:     Paul Jones <paul@pauljones.id.au>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Victor Hooi <victorhooi@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Using Intel Optane to accelerate a BTRFS array? (equivalent of
 ZLOG/SIL for ZFS?)
Message-ID: <20200331224229.1c216ab2@natsu>
In-Reply-To: <CAJtFHUQbcVSQw1tQzCKEtHegJT81QzTu9OkCo2bonVpMyryRyQ@mail.gmail.com>
References: <CAMnnoULAX9Oc+O3gRbVow54H2p_aAENr8daAtyLR_0wi8Tx7xg@mail.gmail.com>
        <a9b73920-65d5-b973-8578-9659717434b5@gmail.com>
        <SYBPR01MB38978D6654705941C50AF95E9ECB0@SYBPR01MB3897.ausprd01.prod.outlook.com>
        <CAJtFHUSjwBKGyjSQfB-aZwsvV=4AcnG+-h5uF_4zmBOESxd=hA@mail.gmail.com>
        <20200331221749.52b10248@natsu>
        <CAJtFHUQbcVSQw1tQzCKEtHegJT81QzTu9OkCo2bonVpMyryRyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 31 Mar 2020 13:31:19 -0400
Eli V <eliventer@gmail.com> wrote:

> Yes using lvm cache is an option, and will give you actual caching of
> the data files as well. However, in my experience it doesn't do much
> caching of metadata so using it on large filesystems doesn't seem to
> improve interactive usage much at all, i.e. ls -l, or btrfs filesystem
> usage etc.

Forgot to mention that in my case (on a large media server) I had great
results with the described setup, especially noticeable in the mount time.
Walking large directories in a GUI file manager was more responsive too. Not
to mention mass deletion of snapshots. LVM cache seemed to know well to avoid
polluting itself with infrequently accessed sequential-pattern bulk operations
(i.e. copying or reading back the actual file data) and appeared to cache
mostly the metadata as it should. For anyone considering this, give it a try,
and give it at least a few days of normal usage to properly warm up.

-- 
With respect,
Roman
