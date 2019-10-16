Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E17ACD8AAB
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfJPIR5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 04:17:57 -0400
Received: from rin.romanrm.net ([91.121.75.85]:40102 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfJPIR5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 04:17:57 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Oct 2019 04:17:56 EDT
Received: from natsu (natsu.2.romanrm.net [IPv6:fd39:aa:7359:7f90:e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id F013520276;
        Wed, 16 Oct 2019 08:12:26 +0000 (UTC)
Date:   Wed, 16 Oct 2019 13:12:26 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        =?UTF-8?B?Sm9zw6k=?= Luis <parajoseluis@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: kernel 5.2 read time tree block corruption
Message-ID: <20191016131226.465eb506@natsu>
In-Reply-To: <375ce380-7b7d-03e5-212a-197d8cc2d5fc@gmx.com>
References: <CADTa+SqDLtmmjnJ5gz-3jDxi1NGNAu=cyo0kFXSZfnu6QE_Fdw@mail.gmail.com>
        <66e27fee-7f64-6466-866d-42464fca130f@gmx.com>
        <a6d7a4c6-4295-e081-1bfc-74e9d13fd22d@gmx.com>
        <CADTa+SrurdZf5+T+QGNyLc7gKLuTFYsto+L4Q+30y-uQj+jutg@mail.gmail.com>
        <3e7acddf-6503-7746-db4b-a116b7f89c4d@gmx.com>
        <CADTa+SoDEcHvpJj6-QMHUubFcKACiKLQ6izr=uER-hYtqVg20g@mail.gmail.com>
        <0cae0d30-db18-37cc-562f-100c862099e3@gmx.com>
        <ab485a5a-04b4-a117-9b94-902f7dbcf8d4@suse.com>
        <375ce380-7b7d-03e5-212a-197d8cc2d5fc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 16 Oct 2019 15:45:54 +0800
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> dirty fixes (a special branch for the user
> to do, never intended to upstream).

Still it would be nice to get a btrfs check mode which would include trying
destructive actions, as in accepting the loss of some part of user data
(outright delete corrupt blocks, etc), just to restore the filesystem itself to
a fully correct and mountable state.

Sometimes there are cases when it is inconvenient to recreate the entire FS
(remember seeing 40TB mentioned recently), just to fix a few "parent transid
failed", not even many transactions apart. And the data itself is often backed
up, so restoring only the missing part from the backup would be much easier.

-- 
With respect,
Roman
