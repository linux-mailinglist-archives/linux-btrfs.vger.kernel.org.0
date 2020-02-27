Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D031711D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 08:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgB0H6i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 02:58:38 -0500
Received: from titan.hyper.fi ([80.83.3.82]:32989 "EHLO titan.hyper.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgB0H6i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 02:58:38 -0500
X-Greylist: delayed 1107 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2020 02:58:38 EST
Received: by titan.hyper.fi (Postfix, from userid 500)
        id 51DC3E7DDD; Thu, 27 Feb 2020 09:40:08 +0200 (EET)
Received: from localhost (localhost [127.0.0.1])
        by titan.hyper.fi (Postfix) with ESMTP id 4F595E7DDB
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2020 09:40:08 +0200 (EET)
Date:   Thu, 27 Feb 2020 09:40:08 +0200 (EET)
From:   linux-btrfs@oh3mqu.pp.hyper.fi
X-X-Sender: oh3mqu@titan.hyper.fi
To:     linux-btrfs@vger.kernel.org
Subject: subvolume layout?
In-Reply-To: <20200226170755.GE22837@infradead.org>
Message-ID: <alpine.LFD.2.00.2002270928290.27975@titan.hyper.fi>
References: <20200225214838.30017-1-willy@infradead.org> <20200225214838.30017-26-willy@infradead.org> <20200226170755.GE22837@infradead.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi,

I am doing backups using btrfs snapshots with this kind of (dir/subvol) 
layout.


   backups(btrfs-root)
   machine1                         machine2
   work(rw) day1(ro) day2(ro)...    work(rw) day1(ro) day2(ro)...


There are tens on machines and hundreds of daily snapshots total and I can 
see slowness.

Now I am wondering which one is better.  Should those machine level 
"directories" be directory or subvolume?


-- 
Ari

