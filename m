Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC802116EF
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 01:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGAXzO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 19:55:14 -0400
Received: from mail.nethype.de ([5.9.56.24]:43833 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgGAXzO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 19:55:14 -0400
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jqmZM-002AkU-C3; Wed, 01 Jul 2020 23:55:12 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jqmZM-0002zF-7p; Wed, 01 Jul 2020 23:55:12 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1jqmZM-0000u8-7T; Thu, 02 Jul 2020 01:55:12 +0200
Date:   Thu, 2 Jul 2020 01:55:12 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: first mount(s) after unclean shutdown always fail
Message-ID: <20200701235512.GA3231@schmorp.de>
References: <20200701005116.GA5478@schmorp.de>
 <36fcfc97-ce4c-cce8-ee96-b723a1b68ec7@gmx.com>
 <20200701201419.GB1889@schmorp.de>
 <cc42d4dc-b46f-7868-6a05-187949136eae@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc42d4dc-b46f-7868-6a05-187949136eae@gmx.com>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 07:45:07AM +0800, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2020/7/2 上午4:14, Marc Lehmann wrote:
> > On Wed, Jul 01, 2020 at 09:30:25AM +0800, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >> This looks like an old fs with some bad accounting numbers.
> > 
> > Yeah, but it's not.
> > 
> >> Have you tried btrfs rescue fix-device-size?
> > 
> > Why would I want to try this?
> 
> Read the man page of "btrfs-rescue".

Well, nothing in there explains why I should use it in my situation, or
what it has to do with the problem I reported, so again, why would I want
to do this?

Also, shouldn't btrfs be fixed instead? I was under the impression that
one of the goals of btrfs is to be safe w.r.t. crashes.

The bug I reported has very little or nothing to with strict checking.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
