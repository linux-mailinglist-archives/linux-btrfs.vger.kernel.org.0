Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401FD679F7
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2019 13:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfGML2g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Jul 2019 07:28:36 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:35470 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbfGML2g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Jul 2019 07:28:36 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 20BC7ACBF
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2019 13:28:33 +0200 (MEST)
Date:   Sat, 13 Jul 2019 13:28:32 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: find subvolume directories
Message-ID: <20190713112832.GA30696@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20190712231705.GA16856@tik.uni-stuttgart.de>
 <75e5bd20-fafa-07fd-afd9-159e9aacb7db@gmail.com>
 <20190713082759.GB16856@tik.uni-stuttgart.de>
 <62366a29-a8ea-a889-f857-0305eba99051@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62366a29-a8ea-a889-f857-0305eba99051@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat 2019-07-13 (14:10), Andrei Borzenkov wrote:

> >> It is entirely up to the user who creates it how subvolumes are named and
> >> structured. You can well have /foo, /bar, /baz mounted as /, /var and
> >> /home.
> > 
> > And how can I find them in my mounted filesystem?
> > THIS is my problem.
> 
> I am not sure what problem you are trying to solve

I want a list of all subvolumes directories (which I can access with UNIX
tools like cd and ls or btrfs subvolume ...).


> but you can use list of current mounts to build path to each subvolume
> (as long as it is either below one of mounted subvolumes or explicitly
> mounted).

Is there an easy/standard way to do this?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<62366a29-a8ea-a889-f857-0305eba99051@gmail.com>
