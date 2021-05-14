Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7FE380E95
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 19:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhENRH1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 14 May 2021 13:07:27 -0400
Received: from rin.romanrm.net ([51.158.148.128]:51890 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235049AbhENRH1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 13:07:27 -0400
Received: from natsu (natsu2.home.romanrm.net [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id D537A323;
        Fri, 14 May 2021 17:06:12 +0000 (UTC)
Date:   Fri, 14 May 2021 22:06:12 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Christian =?UTF-8?B?VsO2bGtlcg==?= <cvoelker@knebb.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Removal of Device and Free Space
Message-ID: <20210514220612.6293aa23@natsu>
In-Reply-To: <850c35a8-0322-c60e-b179-b07eb0e1de8c@knebb.de>
References: <850c35a8-0322-c60e-b179-b07eb0e1de8c@knebb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 14 May 2021 10:54:16 +0200
Christian Völker <cvoelker@knebb.de> wrote:

>      What is occupying so much disk space as the data only has 1.7TB 
> which should fit in 1.8TB (two) devices? (no snapshot, nothing special 
> configured on btrfs). Looks like there are ~400GB allocated which are 
> not from data.

Check if there are really no stray snapshots left over, which keep around old
versions of some of your data.

If not, it could be the infamous Btrfs "extent booking" inefficiency, where the
whole extent (up to 128 MB) is kept around as long as some part of it is still
referenced.

Discussed a bit here: https://www.spinics.net/lists/linux-btrfs/msg90352.html

Since then I found that not only VMs, but for example it's really
inefficient space-wise to download torrents onto a Btrfs (without nocow).

Anything where you overwrite small pieces within a large file, will waste
space.

In your case, if it's a backup server and you use rsync or the like in an
incremental mode updating only the changed blocks, switching that to
whole-file updates (-W for rsync) could alleviate the issue. Another way is to
force compression on the filesystem, which clamps the extent size limit down
from 128 MB to 128 KB and mitigates the problem in another way.

-- 
With respect,
Roman
