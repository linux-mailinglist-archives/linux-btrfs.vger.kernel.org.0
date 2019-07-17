Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC906B8D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 11:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfGQJGm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 05:06:42 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:60345 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfGQJGm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 05:06:42 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id ECDE5872F
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 11:06:38 +0200 (MEST)
Date:   Wed, 17 Jul 2019 11:06:38 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: how do I know a subvolume is a snapshot?
Message-ID: <20190717090638.GB3462@tik.uni-stuttgart.de>
Mail-Followup-To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190716232456.GA26411@tik.uni-stuttgart.de>
 <f47ad813-9b91-a61e-7f4c-378594ee84ea@knorrie.org>
 <TYAPR01MB33604A6035BF09518027AE12E5C90@TYAPR01MB3360.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB33604A6035BF09518027AE12E5C90@TYAPR01MB3360.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed 2019-07-17 (08:57), misono.tomohiro@fujitsu.com wrote:

> FYI, this problem should be fixed in mkfs.btrfs >= v4.16 since the top-level
> subvolume also gets non-empty UUID at mkfs time.

root@fex:~# lsb_release -d
Description:    Ubuntu 18.04.2 LTS

root@fex:~# btrfs version
btrfs-progs v4.15.1

*sigh*

root@fex:~# uname -a
Linux fex 4.15.0-54-generic #58-Ubuntu SMP Mon Jun 24 10:55:24 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

Can I use/install a newer mkfs.btrfs or do I also have to install a newer
kernel version?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<TYAPR01MB33604A6035BF09518027AE12E5C90@TYAPR01MB3360.jpnprd01.prod.outlook.com>
