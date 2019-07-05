Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523EB60517
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 13:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfGELGR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 07:06:17 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:45552 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfGELGR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 07:06:17 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id 58AE78830
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2019 13:06:14 +0200 (MEST)
Date:   Fri, 5 Jul 2019 13:06:14 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: snapshot rollback
Message-ID: <20190705110614.GA14418@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20190705103823.GA13281@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705103823.GA13281@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri 2019-07-05 (12:38), Ulli Horlacher wrote:

> But (how) can I delete the original root subvol to free disk space?

Found:

https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-subvolume

  A freshly created filesystem is also a subvolume, called top-level,
  internally has an id 5. This subvolume cannot be removed or replaced by
  another subvolume.


Ok, it seems my idea (replacing the original root subvolume with a
snapshot) is not possible. 


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20190705103823.GA13281@tik.uni-stuttgart.de>
