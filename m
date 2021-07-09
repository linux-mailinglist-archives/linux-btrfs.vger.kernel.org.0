Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9783C22DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 13:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhGILb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 07:31:56 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:43927 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230457AbhGILb4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Jul 2021 07:31:56 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 3DEB7CDF2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 13:29:11 +0200 (MEST)
Date:   Fri, 9 Jul 2021 13:29:10 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: where is the parent of a snapshot?
Message-ID: <20210709112910.GD1548@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <0f03c92b-f3c6-bab8-fa37-ef1b489e2d38@gmail.com>
 <20210709071555.GD8249@tik.uni-stuttgart.de>
 <20210709072101.GE11526@savella.carfax.org.uk>
 <20210709073731.GB582@tik.uni-stuttgart.de>
 <20210709074810.GA1548@tik.uni-stuttgart.de>
 <eb210591-3d91-72c3-783f-ccedb9ef3359@georgianit.com>
 <20210709084523.GB1548@tik.uni-stuttgart.de>
 <b3d67963-7bb5-2fbf-f8a0-d7712925855a@suse.com>
 <20210709102653.GC1548@tik.uni-stuttgart.de>
 <b828b671-65db-c6d7-5622-83b8187c692f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b828b671-65db-c6d7-5622-83b8187c692f@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri 2021-07-09 (13:49), Nikolay Borisov wrote:

> > root@fex:~# btrfs version
> > btrfs-progs v4.15.1
> 
> Which kernel version is that with?

root@fex:~# sysinfo 
System:        Linux fex 5.4.0-77-generic x86_64
Distribution:  Ubuntu 18.04.5 LTS


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<b828b671-65db-c6d7-5622-83b8187c692f@suse.com>
